/******************************************************************************************
 *  eMemory PUFsecurity IP Verilog Behavior Module Main File
 *  IP Name            : EGP512X32UA016CW01
 *  Version            : v0.1
 *  Technology         : TSMC 16nm 0.8V/1.8V FinFET Compact Process
 *  Created At         : 2022/05/25
 *  Worksheet ID       : 23761
 ******************************************************************************************
 *
 *  REVISION HISTORY:
 *  v0.1      2022/05/25    Tony                    Initial
 ******************************************************************************************/
/**************************************************************************************
 *  Simulator          : ncverilog 06.20-s007
 *  Internal Used Code : [VerilogTemplateType.Fuse_DEFAULT] @ 22865
 **************************************************************************************
 *  STATEMENT OF USE
 *  CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF eMemory Technology Inc.
 *  Copyright (c) 2021 eMemory Technology Inc. All Rights Reserved.
 *
 *  This information contains confidential and proprietary information of eMemory.
 *  No part of this information may be reproduced, transmitted, transcribed,
 *  stored in a retrieval system, or translated into any human or computer
 *  language, in any form or by any means, electronic, mechanical, magnetic,
 *  optical, chemical, manual, or otherwise, without the prior written permission
 *  of eMemory.  This information was prepared for informational purpose and is for
 *  use by eMemory's customers only.  eMemory reserves the right to make changes in the
 *  information at any time and without notice.
 **************************************************************************************/
`timescale 1ns/1ps

/**************************************************************/
/*  DEFINE GLOBAL TIMING                                      */
/**************************************************************/
`define EMTC_Timing_Tash_Min                                                10.000
`define EMTC_Timing_Tdhp_Min                                                 2.000
`define EMTC_Timing_Tasp_Min                                                10.000
`define EMTC_Timing_Tpph_Min                                              5000.000
`define EMTC_Timing_Tpph_Max                                             20000.000
`define EMTC_Timing_Tvd2us_Min                                            1000.000
`define EMTC_Timing_Tkl_Min                                                 10.000
`define EMTC_Timing_Tsas_Min                                              2000.000
`define EMTC_Timing_Tch_Min                                                  0.000
`define EMTC_Timing_Tvddh_Min                                                0.000
`define EMTC_Timing_Tpwi_Min                                              1000.000
`define EMTC_Timing_Tpwi_Max                                              5000.000
`define EMTC_Timing_Toh_Min                                                  0.100
`define EMTC_Timing_Tpenh_Min                                                0.000
`define EMTC_Timing_Tah_Min                                                 15.000
`define EMTC_Timing_Tpens_Min                                             1000.000
`define EMTC_Timing_Tcyc_Min                                                40.000
`define EMTC_Timing_Tvd2dh_Min                                               0.000
`define EMTC_Timing_Tp_det_Min                                             100.000
`define EMTC_Timing_Tkh_Min                                                 20.000
`define EMTC_Timing_Tvdus_Min                                             1000.000
`define EMTC_Timing_Tcd_Max                                                 40.000
`define EMTC_Timing_Tpw_Min                                              10000.000
`define EMTC_Timing_Tpw_Max                                              20000.000
`define EMTC_Timing_Tf_Max                                                   1.000
`define EMTC_Timing_Tcel_Min                                                50.000
`define EMTC_Timing_Tms_Min                                                  1.000
`define EMTC_Timing_Tr_Max                                                   1.000
`define EMTC_Timing_Ts_det_Max                                            2000.000
`define EMTC_Timing_Tpps_Min                                              5000.000
`define EMTC_Timing_Tpps_Max                                             20000.000
`define EMTC_Timing_Tcsp_Min                                             10000.000
`define EMTC_Timing_Tcsp_Max                                            100000.000
`define EMTC_Timing_Tas_Min                                                 10.000
`define EMTC_Timing_Tdsp_Min                                                 1.000
`define EMTC_Timing_Trs_det_Max                                             90.000
`define EMTC_Timing_Tvd2ens_Min                                              0.000
`define EMTC_Timing_Tppr_Min                                              5000.000
`define EMTC_Timing_Tppr_Max                                            100000.000
`define EMTC_Timing_Tvdens_Min                                               0.000
`define EMTC_Timing_Th_det_Min                                               1.000
`define EMTC_Timing_Tahp_Min                                                 2.000
`define EMTC_Timing_Tcs_Min                                              10000.000
`define EMTC_Timing_Tmh_Min                                                  1.000
`define EMTC_r_chk_pwr_pins
`ifndef EMTC_PGM_TIMES_SCREEN
`define EMTC_PGM_TIMES_SCREEN 1
`endif
`ifndef EMTC_PGM_TIMES_ALLOW
`define EMTC_PGM_TIMES_ALLOW  1
`endif
`ifndef EMTC_PUF_TIMES_ALLOW
`define EMTC_PUF_TIMES_ALLOW  2
`endif
//`define EMTC_TCS_VPP
/////////////////////////////
//// PTM Mode definition ////
/////////////////////////////

/**************************************************************/
/*  DEFINE GLOBAL IP_MODE PTM                                 */
/**************************************************************/
`define EMTC_IP_UserMode_ProgramEntry                                       4'b0010
`define EMTC_IP_TestMode_ExtinitialMarginReadMode                           4'b0110
`define EMTC_IP_UserMode_ReadAccess                                         4'b0000
`define EMTC_IP_UserMode_ProgramAccess                                      4'b0010
`define EMTC_IP_UserMode_Standby                                            4'b0000
`define EMTC_IP_UserMode_DeepStandby                                        4'b0000
`define EMTC_IP_TestMode_InitialMarginReadMode                              4'b0001
`define EMTC_IP_TestMode_PGMMarginReadMode                                  4'b0100
/////////////////////////////
`define EMTC_Margin_Read ( PTM === `EMTC_MGN_mode )
//////////////////////////////////////
//// DC Specifications definition ////
//////////////////////////////////////

/**************************************************************/
/*  DEFINE GLOBAL DC                                          */
/**************************************************************/
`define EMTC_DC_PUFEnrollmentMode_VDD2_Min                                  "1.62"
`define EMTC_DC_PUFEnrollmentMode_VDD2_Max                                  "1.98"
`define EMTC_DC_PUFEnrollmentMode_VDD2_Typ                                   "1.8"
`define EMTC_DC_PUFEnrollmentMode_VDD_Min                                   "0.72"
`define EMTC_DC_PUFEnrollmentMode_VDD_Max                                   "0.92"
`define EMTC_DC_PUFEnrollmentMode_VDD_Typ                                    "0.8"
`define EMTC_DC_PUFEnrollmentMode_VSS_Min                                      "0"
`define EMTC_DC_PUFEnrollmentMode_VSS_Max                                      "0"
`define EMTC_DC_PUFEnrollmentMode_VSS_Typ                                      "0"
`define EMTC_DC_PGMMode_VDD2_Min                                            "1.62"
`define EMTC_DC_PGMMode_VDD2_Max                                            "1.98"
`define EMTC_DC_PGMMode_VDD2_Typ                                             "1.8"
`define EMTC_DC_PGMMode_VDD_Min                                             "0.72"
`define EMTC_DC_PGMMode_VDD_Max                                             "0.92"
`define EMTC_DC_PGMMode_VDD_Typ                                              "0.8"
`define EMTC_DC_PGMMode_VSS_Min                                                "0"
`define EMTC_DC_PGMMode_VSS_Max                                                "0"
`define EMTC_DC_PGMMode_VSS_Typ                                                "0"
`define EMTC_DC_ReadMode_VDD2_Min                                           "1.62"
`define EMTC_DC_ReadMode_VDD2_Max                                           "1.98"
`define EMTC_DC_ReadMode_VDD2_Typ                                            "1.8"
`define EMTC_DC_ReadMode_VDD_Min                                            "0.72"
`define EMTC_DC_ReadMode_VDD_Max                                            "0.92"
`define EMTC_DC_ReadMode_VDD_Typ                                             "0.8"
`define EMTC_DC_ReadMode_VSS_Min                                               "0"
`define EMTC_DC_ReadMode_VSS_Max                                               "0"
`define EMTC_DC_ReadMode_VSS_Typ                                               "0"
`define EMTC_DC_PUFReadMode_VDD2_Min                                        "1.62"
`define EMTC_DC_PUFReadMode_VDD2_Max                                        "1.98"
`define EMTC_DC_PUFReadMode_VDD2_Typ                                         "1.8"
`define EMTC_DC_PUFReadMode_VDD_Min                                         "0.72"
`define EMTC_DC_PUFReadMode_VDD_Max                                         "0.92"
`define EMTC_DC_PUFReadMode_VDD_Typ                                          "0.8"
`define EMTC_DC_PUFReadMode_VSS_Min                                            "0"
`define EMTC_DC_PUFReadMode_VSS_Max                                            "0"
`define EMTC_DC_PUFReadMode_VSS_Typ                                            "0"

/**************************************************************/
/*  DEFINE GLOBAL DISPLAY_DC                                  */
/**************************************************************/
`define EMTC_DISPLAY_DC_BurstReadMode                            "Burst Read Mode"
`define EMTC_DISPLAY_DC_BurstReadMode_VDD                                    "VDD"
`define EMTC_DISPLAY_DC_BurstReadMode_VDD2                                  "VDD2"
`define EMTC_DISPLAY_DC_BurstReadMode_VPP                                    "VPP"
`define EMTC_DISPLAY_DC_BurstReadMode_VSS_PSUB                          "VSS_PSUB"
`define EMTC_DISPLAY_DC_BurstReadMode_VSS                                    "VSS"
`define EMTC_DISPLAY_DC_BurstReadMode_VPPEXT                              "VPPEXT"
`define EMTC_DISPLAY_DC_BurstReadMode_VREF                                  "VREF"
`define EMTC_DISPLAY_DC_ReadMode                                       "Read Mode"
`define EMTC_DISPLAY_DC_ReadMode_VDD                                         "VDD"
`define EMTC_DISPLAY_DC_ReadMode_VDD2                                       "VDD2"
`define EMTC_DISPLAY_DC_ReadMode_VPP                                         "VPP"
`define EMTC_DISPLAY_DC_ReadMode_VSS_PSUB                               "VSS_PSUB"
`define EMTC_DISPLAY_DC_ReadMode_VSS                                         "VSS"
`define EMTC_DISPLAY_DC_ReadMode_VPPEXT                                   "VPPEXT"
`define EMTC_DISPLAY_DC_ReadMode_VREF                                       "VREF"
`define EMTC_DISPLAY_DC_PUFReadMode                                "PUF Read Mode"
`define EMTC_DISPLAY_DC_PUFReadMode_VDD                                      "VDD"
`define EMTC_DISPLAY_DC_PUFReadMode_VDD2                                    "VDD2"
`define EMTC_DISPLAY_DC_PUFReadMode_VPP                                      "VPP"
`define EMTC_DISPLAY_DC_PUFReadMode_VSS_PSUB                            "VSS_PSUB"
`define EMTC_DISPLAY_DC_PUFReadMode_VSS                                      "VSS"
`define EMTC_DISPLAY_DC_PUFReadMode_VPPEXT                                "VPPEXT"
`define EMTC_DISPLAY_DC_PUFReadMode_VREF                                    "VREF"
`define EMTC_DISPLAY_DC_PGMMode                                         "PGM Mode"
`define EMTC_DISPLAY_DC_PGMMode_VDD                                          "VDD"
`define EMTC_DISPLAY_DC_PGMMode_VDD2                                        "VDD2"
`define EMTC_DISPLAY_DC_PGMMode_VPP                                          "VPP"
`define EMTC_DISPLAY_DC_PGMMode_VSS_PSUB                                "VSS_PSUB"
`define EMTC_DISPLAY_DC_PGMMode_VSS                                          "VSS"
`define EMTC_DISPLAY_DC_PGMMode_VPPEXT                                    "VPPEXT"
`define EMTC_DISPLAY_DC_PGMMode_VREF                                        "VREF"
`define EMTC_DISPLAY_DC_PGMModeVPPExt                        "PGM Mode (VPP Ext.)"
`define EMTC_DISPLAY_DC_PGMModeVPPExt_VDD                                    "VDD"
`define EMTC_DISPLAY_DC_PGMModeVPPExt_VDD2                                  "VDD2"
`define EMTC_DISPLAY_DC_PGMModeVPPExt_VPP                                    "VPP"
`define EMTC_DISPLAY_DC_PGMModeVPPExt_VSS_PSUB                          "VSS_PSUB"
`define EMTC_DISPLAY_DC_PGMModeVPPExt_VSS                                    "VSS"
`define EMTC_DISPLAY_DC_PGMModeVPPExt_VPPEXT                              "VPPEXT"
`define EMTC_DISPLAY_DC_PGMModeVPPExt_VREF                                  "VREF"
`define EMTC_DISPLAY_DC_PGMModeVDD2power                   "PGM Mode (VDD2 power)"
`define EMTC_DISPLAY_DC_PGMModeVDD2power_VDD                                 "VDD"
`define EMTC_DISPLAY_DC_PGMModeVDD2power_VDD2                               "VDD2"
`define EMTC_DISPLAY_DC_PGMModeVDD2power_VPP                                 "VPP"
`define EMTC_DISPLAY_DC_PGMModeVDD2power_VSS_PSUB                        "VSS_PSUB"
`define EMTC_DISPLAY_DC_PGMModeVDD2power_VSS                                 "VSS"
`define EMTC_DISPLAY_DC_PGMModeVDD2power_VPPEXT                           "VPPEXT"
`define EMTC_DISPLAY_DC_PGMModeVDD2power_VREF                               "VREF"
`define EMTC_DISPLAY_DC_AutoEnrollmentMode                  "Auto Enrollment Mode"
`define EMTC_DISPLAY_DC_AutoEnrollmentMode_VDD                               "VDD"
`define EMTC_DISPLAY_DC_AutoEnrollmentMode_VDD2                             "VDD2"
`define EMTC_DISPLAY_DC_AutoEnrollmentMode_VPP                               "VPP"
`define EMTC_DISPLAY_DC_AutoEnrollmentMode_VSS_PSUB                        "VSS_PSUB"
`define EMTC_DISPLAY_DC_AutoEnrollmentMode_VSS                               "VSS"
`define EMTC_DISPLAY_DC_AutoEnrollmentMode_VPPEXT                          "VPPEXT"
`define EMTC_DISPLAY_DC_AutoEnrollmentMode_VREF                             "VREF"
`define EMTC_DISPLAY_DC_PUFEnrollmentMode                    "PUF Enrollment Mode"
`define EMTC_DISPLAY_DC_PUFEnrollmentMode_VDD                                "VDD"
`define EMTC_DISPLAY_DC_PUFEnrollmentMode_VDD2                              "VDD2"
`define EMTC_DISPLAY_DC_PUFEnrollmentMode_VPP                                "VPP"
`define EMTC_DISPLAY_DC_PUFEnrollmentMode_VSS_PSUB                        "VSS_PSUB"
`define EMTC_DISPLAY_DC_PUFEnrollmentMode_VSS                                "VSS"
`define EMTC_DISPLAY_DC_PUFEnrollmentMode_VPPEXT                          "VPPEXT"
`define EMTC_DISPLAY_DC_PUFEnrollmentMode_VREF                              "VREF"

//////////////////////////////////////
//`define EMTC_Specify_timing_check
//`define EMTC_setup_hold
//`define EMTC_no_global_power
//////////////////////////////////
//// Initial value definition ////
//////////////////////////////////

/**************************************************************/
/*  DEFINE GLOBAL PIN_LENGTH                                  */
/**************************************************************/
`define EMTC_Pin_PAS_Length                                                      1
`define EMTC_Pin_PS_Length                                                       1
`define EMTC_Pin_PPROG_Length                                                    1
`define EMTC_Pin_PTM_Length                                                      4
`define EMTC_Pin_PREP_Length                                                     1
`define EMTC_Pin_PDOUT_DUMMY_Length                                             16
`define EMTC_Pin_PDSTB_Length                                                    1
`define EMTC_Pin_PTR_Length                                                      1
`define EMTC_Pin_PBUSY_Length                                                    1
`define EMTC_Pin_PA_Length                                                       9
`define EMTC_Pin_PAIO_Length                                                     5
`define EMTC_Pin_PAMS_Length                                                     4
`define EMTC_Pin_PCE_Length                                                      1
`define EMTC_Pin_VDD2_Length                                                     1
`define EMTC_Pin_PENVDD2_VDD_Length                                             1
`define EMTC_Pin_PCLK_Length                                                     1
`define EMTC_Pin_VDD_Length                                                      1
`define EMTC_Pin_VSS_Length                                                      1
`define EMTC_Pin_PDIN_Length                                                    32
`define EMTC_Pin_PDOUT_Length                                                   32
`define EMTC_Pin_PAM_Length                                                      2
`define EMTC_Pin_PTC_Length                                                      1
`define EMTC_Pin_PWE_Length                                                      1

/**************************************************************/
/*  DEFINE GLOBAL DENSITY_SIZE                                */
/**************************************************************/
`define EMTC_Density_TestRow_Size
`define EMTC_Density_TestCol_Size

/**************************************************************/
/*  DEFINE GLOBAL PDOUT_TEST_ROW                              */
/**************************************************************/
`define EMTC_PDOUT_Test_Row_0_Max                                                8
`define EMTC_PDOUT_Test_Row_0_Min                                                3

`define EMTC_PDOUT_Test_REP_0_Max                                                8
`define EMTC_PDOUT_Test_REP_0_Min                                                4

`define EMTC_PDOUT_Test_Col_0_Max                                                2
`define EMTC_PDOUT_Test_Col_0_Min                                                0

`define EMTC_PDOUT_Test_INF_0_Max                                                8
`define EMTC_PDOUT_Test_INF_0_Min                                                6

`define EMTC_PDOUT_Test_PUF_0_Max                                                8
`define EMTC_PDOUT_Test_PUF_0_Min                                                6

/**************************************************************/
/*  DEFINE GLOBAL PDOUT_TEST_COL                              */
/**************************************************************/


///////////////////////////////////////////////////////////////////////////////

`ifdef EMTC_Pin_PAS_Length
    `define EMTC_Memory_Address      (1 << (`EMTC_Pin_PA_Length + `EMTC_Pin_PAS_Length)) - 1
    `define EMTC_Memory_TotalAddress (1 << (`EMTC_Pin_PA_Length + `EMTC_Pin_PAS_Length)) * `EMTC_Pin_PDOUT_Length - 1
    `define EMTC_Memory_AddressBits         `EMTC_Pin_PA_Length + `EMTC_Pin_PAS_Length
`else
    `define EMTC_Memory_Address      (1 << `EMTC_Pin_PA_Length) - 1
    `define EMTC_Memory_TotalAddress (1 << `EMTC_Pin_PA_Length) * `EMTC_Pin_PDOUT_Length - 1
    `define EMTC_Memory_AddressBits        `EMTC_Pin_PA_Length
`endif
`define EMTC_Memory_Address_PUF      (1 << `EMTC_Pin_PA_Length) - 1
`define EMTC_Memory_TotalAddress_PUF (1 << `EMTC_Pin_PA_Length) * `EMTC_Pin_PDOUT_Length - 1
`define EMTC_Memory_AddressBits_PUF        `EMTC_Pin_PA_Length
`define EMTC_Full_Address            512
`define PERIOD00    5.1
`define PERIOD01    4.1
`define PERIOD02    5.6
`define PERIOD03    4.6

`define PERIOD10    7.1
`define PERIOD11    6.1
`define PERIOD12    7.6
`define PERIOD13    6.6

`define PERIOD20    11.1
`define PERIOD21    10.1
`define PERIOD22    11.6
`define PERIOD23    10.6

`define PERIOD30    13.1
`define PERIOD31    12.1
`define PERIOD32    13.6
`define PERIOD33    12.6

module EGP512X32 (
                              VDD,
                              VDD2,
                              VSS,
                              PA,
                              PAIO,
                              PA_REP,
                              POP_OSC0,
                              POP_OSC1,
                              POP_OSC2,
                              POP_OSC3,
                              PAS,
                              PDIN,
                              PDOUT,
                              PDOUT_DUMMY,
                              PVPRRDY,
                              PTM,
                              PWE,
                              PPROG,
                              PCLK,
                              PUFORG,
                              PCE,
                              PTC,
                              PTR,
                              PDSTB,
                              PIF,
                              PAMS,
                              PAM,
                              PENVDD2_VDD,
                              PUF,
                              PEN_OSC,
                              PENCLK,
                              POSC,
                              PCLKOUT,
                              read_x_flag,
                              read_err_flag,
                              read_0_flag,
                              read_mode_related,
                              pgm_mode_related,
                              is_pgm,
                              not_power_off,
                              notify_min_Tcyc,
                              notify_min_Tkh,
                              notify_min_Tkl,
                              notify_min_Tas,
                              notify_min_Tdhp,
                              notify_min_Tdsp,
                              notify_min_Tahp,
                              notify_min_Tasp,
                              notify_min_Tms,
                              notify_min_Tmh
                          );
/////////////////////
//// Main module ////
/////////////////////
input                                    VDD;
input                                    VDD2;
input                                    VSS;
input   [`EMTC_Pin_PA_Length - 1 : 0]    PA;
input   [`EMTC_Pin_PAIO_Length - 1 : 0]  PAIO;
input   [`EMTC_Pin_PAS_Length - 1 : 0]   PAS;
input   [`EMTC_Pin_PDIN_Length - 1 : 0]  PDIN;
input   [`EMTC_Pin_PTM_Length - 1 : 0]   PTM;
input                           PWE;
input                           PPROG;
input                           PCLK;
input                           PUFORG;
input                           PCE;
input                           PTC;
input                           PTR;
input                           PDSTB;
input                           PIF;
input                           PA_REP;
input [1:0] POP_OSC0;
input [1:0] POP_OSC1;
input [1:0] POP_OSC2;
input [1:0] POP_OSC3;
output                     [3:0] PAMS;
output                     [1:0] PAM;
output  [`EMTC_Pin_PDOUT_Length - 1 : 0] PDOUT;
output  [15:0]                  PDOUT_DUMMY;
output                          PVPRRDY;
input                           PENVDD2_VDD;
input                           PUF;
input [3:0]                     PEN_OSC;
input                           PENCLK;
output [3:0]                    POSC;
output                          PCLKOUT;
output read_x_flag;
output read_err_flag;
output read_0_flag;
output read_mode_related;
output pgm_mode_related;
output is_pgm;
output not_power_off;
input notify_min_Tcyc;
input notify_min_Tkh;
input notify_min_Tkl;
input notify_min_Tas;
input notify_min_Tdhp;
input notify_min_Tdsp;
input notify_min_Tahp;
input notify_min_Tasp;
input notify_min_Tms;
input notify_min_Tmh;

/**************************************************************/
/*  [START] POWER_SEQ                                         */
/*  NMOS_SINGLE_PIN_LIST                                      */
/**************************************************************/
wire PENVDD2_VDDi;
wire      	          	PDSTBi;
wire      	          	VSSi;
wire [31:0] PDOUTo;
wire	[1:0] PAMo;
wire	[3:0] PAMSo;
wire CTRL_PINSi;

nmos U_PENVDD2_VDDi (PENVDD2_VDDi, PENVDD2_VDD, 1'b1);
nmos U_VSSi (VSSi, VSS, 1'b1);
nmos U_PDSTBi (PDSTBi, PDSTB, 1'b1);
nmos U_PDOUT_31o (PDOUT[31], PDOUTo[31], 1'b1);
nmos U_PDOUT_30o (PDOUT[30], PDOUTo[30], 1'b1);
nmos U_PDOUT_29o (PDOUT[29], PDOUTo[29], 1'b1);
nmos U_PDOUT_28o (PDOUT[28], PDOUTo[28], 1'b1);
nmos U_PDOUT_27o (PDOUT[27], PDOUTo[27], 1'b1);
nmos U_PDOUT_26o (PDOUT[26], PDOUTo[26], 1'b1);
nmos U_PDOUT_25o (PDOUT[25], PDOUTo[25], 1'b1);
nmos U_PDOUT_24o (PDOUT[24], PDOUTo[24], 1'b1);
nmos U_PDOUT_23o (PDOUT[23], PDOUTo[23], 1'b1);
nmos U_PDOUT_22o (PDOUT[22], PDOUTo[22], 1'b1);
nmos U_PDOUT_21o (PDOUT[21], PDOUTo[21], 1'b1);
nmos U_PDOUT_20o (PDOUT[20], PDOUTo[20], 1'b1);
nmos U_PDOUT_19o (PDOUT[19], PDOUTo[19], 1'b1);
nmos U_PDOUT_18o (PDOUT[18], PDOUTo[18], 1'b1);
nmos U_PDOUT_17o (PDOUT[17], PDOUTo[17], 1'b1);
nmos U_PDOUT_16o (PDOUT[16], PDOUTo[16], 1'b1);
nmos U_PDOUT_15o (PDOUT[15], PDOUTo[15], 1'b1);
nmos U_PDOUT_14o (PDOUT[14], PDOUTo[14], 1'b1);
nmos U_PDOUT_13o (PDOUT[13], PDOUTo[13], 1'b1);
nmos U_PDOUT_12o (PDOUT[12], PDOUTo[12], 1'b1);
nmos U_PDOUT_11o (PDOUT[11], PDOUTo[11], 1'b1);
nmos U_PDOUT_10o (PDOUT[10], PDOUTo[10], 1'b1);
nmos U_PDOUT_9o (PDOUT[9], PDOUTo[9], 1'b1);
nmos U_PDOUT_8o (PDOUT[8], PDOUTo[8], 1'b1);
nmos U_PDOUT_7o (PDOUT[7], PDOUTo[7], 1'b1);
nmos U_PDOUT_6o (PDOUT[6], PDOUTo[6], 1'b1);
nmos U_PDOUT_5o (PDOUT[5], PDOUTo[5], 1'b1);
nmos U_PDOUT_4o (PDOUT[4], PDOUTo[4], 1'b1);
nmos U_PDOUT_3o (PDOUT[3], PDOUTo[3], 1'b1);
nmos U_PDOUT_2o (PDOUT[2], PDOUTo[2], 1'b1);
nmos U_PDOUT_1o (PDOUT[1], PDOUTo[1], 1'b1);
nmos U_PDOUT_0o (PDOUT[0], PDOUTo[0], 1'b1);
nmos U_PAM_0 (PAM[0], PAMo[0], 1'b1); 
nmos U_PAM_1 (PAM[1], PAMo[1], 1'b1); 
nmos U_PAMS_0 (PAMS[0], PAMSo[0], 1'b1); 
nmos U_PAMS_1 (PAMS[1], PAMSo[1], 1'b1); 
nmos U_PAMS_2 (PAMS[2], PAMSo[2], 1'b1); 
nmos U_PAMS_3 (PAMS[3], PAMSo[3], 1'b1); 

/**************************************************************/
/*  [END] POWER_SEQ                                           */
/*  NMOS_SINGLE_PIN_LIST                                      */
/**************************************************************/

assign CTRL_PINSi = PCE | PPROG | PWE | (|PTM);

/**************************************************************/
/*  [START] POWER_SEQ                                         */
/*  REG_PWR_PINS                                              */
/**************************************************************/
assign PWR_PINSi = VDD & VDD2 & PENVDD2_VDD ;
/**************************************************************/
/*  [END] POWER_SEQ                                           */
/*  REG_PWR_PINS                                              */
/**************************************************************/


/**************************************************************/
/*  [START] POWER_SEQ                                         */
/*  CONNECT_MODULE                                            */
/**************************************************************/
EGP512X32_PWR EGP512X32_PWR (
	.PWR_PINS (PWR_PINSi), .PDSTB (PDSTBi), .CTRL_PINS (CTRL_PINSi), .VSS (VSSi), .power_ready (power_ready)
);
/**************************************************************/
/*  [END] POWER_SEQ                                           */
/*  CONNECT_MODULE                                            */
/**************************************************************/


    parameter EMTC_load_file  = 1'b0; // memory content load from file if set 1
    parameter EMTC_write_file = 1'b1; // memory content write to .dat file if set 1
    parameter power_off          = 4'h0;
    parameter standby            = 4'h1;
    parameter read_mode          = 4'h2;
    parameter ini_mgn_read       = 4'h3;
    parameter ini_mgn_read_ext   = 4'h4;
    parameter pgm_mgn_read       = 4'h5;
    parameter pgm_mode           = 4'h6;
`ifdef EMTC_IP_TestMode_HightempinitialMarginReadMode
    parameter ini_mgn_read_ht    = 4'h7;
`endif
`ifdef EMTC_IP_TestMode_HighTempPGMMarginReadMode
    parameter pgm_mgn_read_ht    = 4'h8;
`endif
`ifdef EMTC_IP_TestMode_VTMode
    parameter vt_mode            = 4'h9;
`endif

    wire read_mode_related;
    wire pgm_mode_related;
    wire is_pgm;
`ifdef EMTC_Timing_Tcd_IMG_Max
    wire is_ini_margin_read;
    wire is_exclude_ini_read;
`else `ifdef EMTC_Timing_Tcyc_IMG_Min
    wire is_ini_margin_read;
    wire is_exclude_ini_read;
    wire is_margin_read;
`endif `endif
    reg [3:0] mode_reg;

`ifdef EMTC_IP_TestMode_HightempinitialMarginReadMode
    `ifdef EMTC_IP_TestMode_HighTempPGMMarginReadMode
        assign read_mode_related = (mode_reg == ini_mgn_read_ext || mode_reg == read_mode || mode_reg == ini_mgn_read || mode_reg == pgm_mgn_read || mode_reg == ini_mgn_read_ht || mode_reg == pgm_mgn_read_ht) ? 1'b1 : 1'b0;
    `else
        assign read_mode_related = (mode_reg == ini_mgn_read_ext || mode_reg == read_mode || mode_reg == ini_mgn_read || mode_reg == pgm_mgn_read || mode_reg == ini_mgn_read_ht) ? 1'b1 : 1'b0;
    `endif
`else `ifdef EMTC_IP_TestMode_HighTempPGMMarginReadMode
        assign read_mode_related = (mode_reg == ini_mgn_read_ext || mode_reg == read_mode || mode_reg == ini_mgn_read || mode_reg == pgm_mgn_read || mode_reg == pgm_mgn_read_ht) ? 1'b1 : 1'b0;
`else
        assign read_mode_related = (mode_reg == ini_mgn_read_ext || mode_reg == read_mode || mode_reg == ini_mgn_read || mode_reg == pgm_mgn_read) ? 1'b1 : 1'b0;
`endif `endif
        assign is_margin_read = read_mode_related & (mode_reg != read_mode);

    assign pgm_mode_related    = (mode_reg == pgm_mode) ? 1'b1: 1'b0;
    assign is_pgm              = (mode_reg == pgm_mode) ? 1'b1: 1'b0;
`ifdef EMTC_Timing_Tcd_IMG_Max
    `ifdef EMTC_IP_TestMode_HightempinitialMarginReadMode
        assign is_ini_margin_read = (mode_reg == ini_mgn_read || mode_reg == ini_mgn_read_ht) ? 1'b1 : 1'b0;
    `else
        assign is_ini_margin_read = (mode_reg == ini_mgn_read) ? 1'b1 : 1'b0;
    `endif
        assign is_exclude_ini_read = read_mode_related & ~ is_ini_margin_read;
`else `ifdef EMTC_Timing_Tcyc_IMG_Min
    `ifdef EMTC_IP_TestMode_HightempinitialMarginReadMode
        assign is_ini_margin_read = (mode_reg == ini_mgn_read || mode_reg == ini_mgn_read_ht) ? 1'b1 : 1'b0;
    `else
        assign is_ini_margin_read = (mode_reg == ini_mgn_read) ? 1'b1 : 1'b0;
    `endif
        assign is_exclude_ini_read = read_mode_related & ~ is_ini_margin_read;
`endif `endif

`ifdef EMTC_IP_TestMode_VTMode
    wire is_vt_mode;
    assign is_vt_mode = (mode_reg == vt_mode) ? 1'b1: 1'b0;
`endif
    wire all_function_mode;
    `ifdef EMTC_IP_TestMode_VTMode
        assign all_function_mode = read_mode_related | pgm_mode_related | is_vt_mode;
    `else
        assign all_function_mode = read_mode_related | pgm_mode_related;
    `endif
    wire not_power_off;
    assign not_power_off = (mode_reg != power_off) ? 1'b1 : 1'b0;

    wire read_valid;
    wire program_valid;
`ifdef EMTC_DC_PGMMode_VPP_Typ
    assign read_valid = PCE & ~ PPROG & ~ PWE & ~ VPP;
`else
    assign read_valid = PCE & ~ PPROG & ~ PWE;
`endif
    assign program_valid = PCE;

    reg exit_mode;
    reg function_mode_trigger;
    initial begin
        function_mode_trigger = 1'b0;
        exit_mode = 1'b0;
    end
`ifdef EMTC_Timing_Tcel_Min
    reg Tms_violation;
    initial Tms_violation = 1'b0;
    reg Tcel_violation;
    initial Tcel_violation = 1'b0;
    // pragma coverage off
    always @ (posedge PCE) begin
        #0.1;
        if (PCE === 1'b1 && !Tms_violation && !Tcel_violation) begin
            function_mode_trigger = 1'b1;
            #0.4;
            function_mode_trigger = 1'b0;
        end
    end
`else
    reg Tms_violation;
    initial Tms_violation = 1'b0;
    // pragma coverage off
    always @ (posedge PCE) begin
        #0.1;
        if (PCE === 1'b1 && !Tms_violation) begin
            function_mode_trigger = 1'b1;
            #0.4;
            function_mode_trigger = 1'b0;
        end
    end
`endif
    // pragma coverage on
    reg [38*8 : 0] mode_string;
    always @ (PTM) begin
        if (PCE === 1'b1 && all_function_mode) begin
            $display ("%t", $realtime, " @@ EMTC_Error : PTM cannot change when PCE is High in %s", mode_string);
            exit_mode = 1'b1;
            #0.2;
            exit_mode = 1'b0;
        end
    end
    always @ (negedge PCE) begin
        if (all_function_mode) begin
            exit_mode = 1'b1;
            #0.2;
            exit_mode = 1'b0;
        end
    end

    reg PVPRRDY;
    initial PVPRRDY = 1'b0;
    always @ (posedge PCE or negedge PCE) begin
        if (PCE === 1'b1)
            PVPRRDY <= #(`EMTC_Timing_Tcs_Min) PCE;
        else
            PVPRRDY <= 1'b0;
    end

    wire power_ready_d;
    wire exit_mode_d;
    wire function_mode_trigger_d;
    wire function_mode_trigger_d2;
    assign #0.1 power_ready_d   = power_ready;
    assign #0.1 exit_mode_d   = exit_mode;
    assign #0.2 function_mode_trigger_d  = function_mode_trigger;
    assign #0.4 function_mode_trigger_d2 = function_mode_trigger;
    reg [3:0] mode;
    initial begin
        mode_reg = power_off;
        mode     = power_off;
    end
    always @ (posedge power_ready_d or negedge power_ready_d or posedge exit_mode_d or posedge function_mode_trigger_d2) begin
        mode_reg = mode;
    end

    always @ (mode_reg or PTM or power_ready or function_mode_trigger_d or exit_mode) begin
        case (mode_reg)
            power_off:
                begin
                    if (power_ready)
                        mode = standby;
                    else
                        mode = power_off;
                end
            standby:
                begin
                    if (!power_ready)
                        mode = power_off;
                    else if (function_mode_trigger_d)
                        case (PTM)
                            `EMTC_IP_UserMode_ReadAccess:
                                mode = read_mode;
                            `EMTC_IP_UserMode_ProgramAccess:
                                begin
                                    mode = pgm_mode;
                                    `ifdef EMTC_Pin_PAS_Length
                                         $display ("%t", $realtime, " @@ EMTC_Note: This is PGM mode, all the PAS cells of one bit should be programmed");
                                    `endif
                                end
                        `ifdef EMTC_IP_TestMode_VTMode
                            `EMTC_IP_TestMode_VTMode:
                                mode = vt_mode;
                        `endif
                        `ifdef EMTC_IP_TestMode_ExtinitialMarginReadMode
                            `EMTC_IP_TestMode_ExtinitialMarginReadMode:
                                mode = ini_mgn_read_ext;
                        `endif
                        `ifdef EMTC_IP_TestMode_InitialMarginReadMode
                            `EMTC_IP_TestMode_InitialMarginReadMode:
                                mode = ini_mgn_read;
                        `else `ifdef EMTC_Off_MGN_mode
                            `EMTC_Off_MGN_mode:
                                mode = ini_mgn_read;
                        `else `ifdef EMTC_IP_TestMode_RoomtempinitialMarginReadMode
                            `EMTC_IP_TestMode_RoomtempinitialMarginReadMode:
                                mode = ini_mgn_read;
                        `endif `endif `endif
                        `ifdef EMTC_IP_TestMode_HightempinitialMarginReadMode
                            `EMTC_IP_TestMode_HightempinitialMarginReadMode:
                                mode = ini_mgn_read_ht;
                        `endif
                        `ifdef EMTC_IP_TestMode_PGMMarginReadMode
                            `EMTC_IP_TestMode_PGMMarginReadMode:
                                mode = pgm_mgn_read;
                        `else `ifdef EMTC_IP_TestMode_RoomTempPGMMarginReadMode
                            `EMTC_IP_TestMode_RoomTempPGMMarginReadMode:
                                mode = pgm_mgn_read;
                        `endif `endif
                        `ifdef EMTC_IP_TestMode_HighTempPGMMarginReadMode
                            `EMTC_IP_TestMode_HighTempPGMMarginReadMode:
                                mode = pgm_mgn_read_ht;
                        `endif
                            default:
                                begin
                                    $display ("%t", $realtime, " @@ EMTC_Error: PTM = %b not defined", PTM);
                                    mode = standby;
                                end
                        endcase
                    else
                        mode = standby;
                end
            default:
                begin
                    if (!power_ready)
                        mode = power_off;
                    else if (exit_mode)
                        mode = standby;
                    else
                        mode = mode_reg;
                end
        endcase
    end

    always @ (mode_reg) begin
        case (mode_reg)
            standby:
                mode_string = "Standby mode";
            read_mode:
                mode_string = "Read mode";
            ini_mgn_read:
                mode_string = "Initial (Off) margin read mode";
            pgm_mgn_read:
                mode_string = "Program margin read mode";
            ini_mgn_read_ext:
                mode_string = "Extend initial (Off) margin read mode";
        `ifdef EMTC_IP_TestMode_HighTempPGMMarginReadMode
            pgm_mgn_read_ht:
                mode_string = "HT program margin read mode";
        `endif
        `ifdef EMTC_IP_TestMode_HightempinitialMarginReadMode
            ini_mgn_read_ht:
                mode_string = "HT initial (Off) margin read mode";
        `endif
            pgm_mode:
                mode_string = "Program mode";
            default:
                mode_string = "Standby mode";
        endcase
    end
    // memory array
    reg [`EMTC_Pin_PDOUT_Length - 1:0] MEM_MAIN      [0 : `EMTC_Memory_Address];
    reg [`EMTC_Pin_PDOUT_Length - 1:0] MEM_TR        [0 : `EMTC_Memory_Address];
    reg [`EMTC_Pin_PDOUT_Length - 1:0] MEM_TC        [0 : `EMTC_Memory_Address];
    reg [`EMTC_Pin_PDOUT_Length - 1:0] MEM_IF        [0 : `EMTC_Memory_Address];
    reg [`EMTC_Pin_PDOUT_Length - 1:0] MEM_REP       [0 : `EMTC_Memory_Address];
    reg [`EMTC_Pin_PDOUT_Length - 1:0] MEM_PUF       [0 : `EMTC_Memory_Address];
    reg [`EMTC_Pin_PDOUT_Length - 1:0] MEM_PUFORG    [0 : `EMTC_Memory_Address_PUF];

    reg [`EMTC_Pin_PDOUT_Length - 1:0] MEM_PUFVIRTUAL[0 : `EMTC_Memory_Address_PUF];

    reg                 [2:0]          MEM_MAIN_T    [0 : `EMTC_Memory_TotalAddress];
    reg                 [2:0]          MEM_TR_T      [0 : `EMTC_Memory_TotalAddress];
    reg                 [2:0]          MEM_TC_T      [0 : `EMTC_Memory_TotalAddress];
    reg                 [2:0]          MEM_IF_T      [0 : `EMTC_Memory_TotalAddress];
    reg                 [2:0]          MEM_REP_T     [0 : `EMTC_Memory_TotalAddress];
    reg                 [2:0]          MEM_PUF_T     [0 : `EMTC_Memory_TotalAddress];
    reg                 [2:0]          MEM_PUFORG_T  [0 : `EMTC_Memory_TotalAddress_PUF];

    parameter mem_file                       = "EGP512X32_IN.dat";
    parameter mem_file_pgm_times             = "EGP512X32_pgm_times_IN.dat";
    parameter mem_file_OUT                   = "EGP512X32.dat";
    parameter mem_file_pgm_times_OUT         = "EGP512X32_pgm_times.dat";
`ifdef EMTC_Density_TestRow_Size
    parameter mem_file_for_TR                = "EGP512X32_TR_IN.dat";
    parameter mem_file_for_TR_pgm_times      = "EGP512X32_TR_pgm_times_IN.dat";
    parameter mem_file_for_TR_OUT            = "EGP512X32_TR.dat";
    parameter mem_file_for_TR_pgm_times_OUT  = "EGP512X32_TR_pgm_times.dat";
`endif
`ifdef EMTC_Density_TestCol_Size
    parameter mem_file_for_TC                = "EGP512X32_TC_IN.dat";
    parameter mem_file_for_TC_pgm_times      = "EGP512X32_TC_pgm_times_IN.dat";
    parameter mem_file_for_TC_OUT            = "EGP512X32_TC.dat";
    parameter mem_file_for_TC_pgm_times_OUT  = "EGP512X32_TC_pgm_times.dat";
`endif
    parameter mem_file_for_IF                = "EGP512X32_IF_IN.dat";
    parameter mem_file_for_IF_pgm_times      = "EGP512X32_IF_pgm_times_IN.dat";
    parameter mem_file_for_IF_OUT            = "EGP512X32_IF.dat";
    parameter mem_file_for_IF_pgm_times_OUT  = "EGP512X32_IF_pgm_times.dat";
    parameter mem_file_for_REP               = "EGP512X32_REP_IN.dat";
    parameter mem_file_for_REP_pgm_times     = "EGP512X32_REP_pgm_times_IN.dat";
    parameter mem_file_for_REP_OUT           = "EGP512X32_REP.dat";
    parameter mem_file_for_REP_pgm_times_OUT = "EGP512X32_REP_pgm_times.dat";
    parameter mem_file_for_PUF               = "EGP512X32_PUF_IN.dat";
    parameter mem_file_for_PUF_pgm_times     = "EGP512X32_PUF_pgm_times_IN.dat";
    parameter mem_file_for_PUF_OUT           = "EGP512X32_PUF.dat";
    parameter mem_file_for_PUF_pgm_times_OUT = "EGP512X32_PUF_pgm_times.dat";
    parameter mem_file_for_PUFORG               = "EGP512X32_PUFORG_IN.dat";
    parameter mem_file_for_PUFORG_pgm_times     = "EGP512X32_PUFORG_pgm_times_IN.dat";
    parameter mem_file_for_PUFORG_OUT           = "EGP512X32_PUFORG.dat";
    parameter mem_file_for_PUFORG_pgm_times_OUT = "EGP512X32_PUFORG_pgm_times.dat";
/**************************************************************/
/*  DECLARE_DC_USAGE                                          */
/**************************************************************/
initial
begin
	$display(" ## For %s, ", `EMTC_DISPLAY_DC_PUFEnrollmentMode);
	$display(" ## 	 %s can be set as %s V ~ %s V ", `EMTC_DISPLAY_DC_PUFEnrollmentMode_VDD2, `EMTC_DC_PUFEnrollmentMode_VDD2_Min, `EMTC_DC_PUFEnrollmentMode_VDD2_Max);
	$display(" ## 	 %s can be set as %s V ~ %s V ", `EMTC_DISPLAY_DC_PUFEnrollmentMode_VDD, `EMTC_DC_PUFEnrollmentMode_VDD_Min, `EMTC_DC_PUFEnrollmentMode_VDD_Max);
	$display(" ## 	 %s can be set as %s V ~ %s V ", `EMTC_DISPLAY_DC_PUFEnrollmentMode_VSS, `EMTC_DC_PUFEnrollmentMode_VSS_Min, `EMTC_DC_PUFEnrollmentMode_VSS_Max);
	$display(" ## For %s, ", `EMTC_DISPLAY_DC_PGMMode);
	$display(" ## 	 %s can be set as %s V ~ %s V ", `EMTC_DISPLAY_DC_PGMMode_VDD2, `EMTC_DC_PGMMode_VDD2_Min, `EMTC_DC_PGMMode_VDD2_Max);
	$display(" ## 	 %s can be set as %s V ~ %s V ", `EMTC_DISPLAY_DC_PGMMode_VDD, `EMTC_DC_PGMMode_VDD_Min, `EMTC_DC_PGMMode_VDD_Max);
	$display(" ## 	 %s can be set as %s V ~ %s V ", `EMTC_DISPLAY_DC_PGMMode_VSS, `EMTC_DC_PGMMode_VSS_Min, `EMTC_DC_PGMMode_VSS_Max);
	$display(" ## For %s, ", `EMTC_DISPLAY_DC_ReadMode);
	$display(" ## 	 %s can be set as %s V ~ %s V ", `EMTC_DISPLAY_DC_ReadMode_VDD2, `EMTC_DC_ReadMode_VDD2_Min, `EMTC_DC_ReadMode_VDD2_Max);
	$display(" ## 	 %s can be set as %s V ~ %s V ", `EMTC_DISPLAY_DC_ReadMode_VDD, `EMTC_DC_ReadMode_VDD_Min, `EMTC_DC_ReadMode_VDD_Max);
	$display(" ## 	 %s can be set as %s V ~ %s V ", `EMTC_DISPLAY_DC_ReadMode_VSS, `EMTC_DC_ReadMode_VSS_Min, `EMTC_DC_ReadMode_VSS_Max);
	$display(" ## For %s, ", `EMTC_DISPLAY_DC_PUFReadMode);
	$display(" ## 	 %s can be set as %s V ~ %s V ", `EMTC_DISPLAY_DC_PUFReadMode_VDD2, `EMTC_DC_PUFReadMode_VDD2_Min, `EMTC_DC_PUFReadMode_VDD2_Max);
	$display(" ## 	 %s can be set as %s V ~ %s V ", `EMTC_DISPLAY_DC_PUFReadMode_VDD, `EMTC_DC_PUFReadMode_VDD_Min, `EMTC_DC_PUFReadMode_VDD_Max);
end

    integer i;
    // Array and Program times initialization
    initial begin
        for (i = 0; i <= `EMTC_Memory_Address_PUF; i = i + 1) begin
            MEM_PUFORG[i] = ~ `EMTC_Pin_PDOUT_Length'h0;
        `ifdef EMTC_URAND
            MEM_PUFVIRTUAL[i] = $urandom;
        `else 
            MEM_PUFVIRTUAL[i] = $random;
        `endif
        end
        if (EMTC_load_file) begin
            $readmemh(mem_file,                  MEM_MAIN);
            $readmemh(mem_file_pgm_times,        MEM_MAIN_T);
        `ifdef EMTC_Density_TestRow_Size
            $readmemh(mem_file_for_TR,           MEM_TR);
            $readmemh(mem_file_for_TR_pgm_times, MEM_TR_T);
        `endif
        `ifdef EMTC_Density_TestCol_Size
            $readmemh(mem_file_for_TC,           MEM_TC);
            $readmemh(mem_file_for_TC_pgm_times, MEM_TC_T);
        `endif
            $readmemh(mem_file_for_IF,           MEM_IF);
            $readmemh(mem_file_for_IF_pgm_times, MEM_IF_T);
            $readmemh(mem_file_for_REP,          MEM_REP);
            $readmemh(mem_file_for_REP_pgm_times,MEM_REP_T);
            $readmemh(mem_file_for_PUF,          MEM_PUF);
            $readmemh(mem_file_for_PUF_pgm_times,MEM_PUF_T);
            $readmemh(mem_file_for_PUFORG,          MEM_PUFORG);
            $readmemh(mem_file_for_PUFORG_pgm_times,MEM_PUFORG_T);
        end else begin
            for (i = 0; i <= `EMTC_Memory_Address; i = i + 1) begin
                MEM_MAIN[i]   = ~ `EMTC_Pin_PDOUT_Length'h0;
                MEM_IF[i]     = ~ `EMTC_Pin_PDOUT_Length'h0;
                MEM_REP[i]    = ~ `EMTC_Pin_PDOUT_Length'h0;
                MEM_PUF[i]    = ~ `EMTC_Pin_PDOUT_Length'h0;
            `ifdef EMTC_Density_TestRow_Size
                MEM_TR[i]     = ~ `EMTC_Pin_PDOUT_Length'h0;
            `endif
            `ifdef EMTC_Density_TestCol_Size
                MEM_TC[i]     = ~ `EMTC_Pin_PDOUT_Length'h0;
            `endif
            end
            for (i = 0; i <= `EMTC_Memory_TotalAddress; i = i + 1) begin
                MEM_MAIN_T[i]   = 3'h0;
                MEM_IF_T[i]     = 3'h0;
                MEM_REP_T[i]    = 3'h0;
                MEM_PUF_T[i]    = 3'h0;
            `ifdef EMTC_Density_TestRow_Size
                MEM_TR_T[i]     = 3'h0;
            `endif
            `ifdef EMTC_Density_TestCol_Size
                MEM_TC_T[i]     = 3'h0;
            `endif
            end
            for (i = 0; i <= `EMTC_Memory_TotalAddress_PUF; i = i + 1)
                MEM_PUFORG_T[i]   = 3'h0;
        end
    end

    // Read
    reg read_x_flag;
    reg read_err_flag;
    initial begin
        read_x_flag = 1'b0;
        read_err_flag = 1'b0;
    end

    realtime pce_rise_time;
    always @ (posedge PCE) begin
        pce_rise_time = $realtime;
    end

    reg pgm_fail_mask_output_flag;
    initial pgm_fail_mask_output_flag = 1'b0;

    reg [`EMTC_Pin_PDOUT_Length - 1:0] dout_buffer_at_posedge_pclk;
    always @ (posedge PCLK) begin
        #`EMTC_Timing_Toh_Min;
        read_x_flag = 1'b1;
        #0.1;
        read_x_flag = 1'b0;
    end

    `ifdef EMTC_Timing_Tsas_Min
    reg read_0_flag;
    initial read_0_flag = 1'b0;
    always @ (posedge PDSTB or negedge PDSTB) begin
        if (PDSTB === 1'b0) begin
            read_0_flag = 1;
            dout_buffer_at_posedge_pclk = `EMTC_Pin_PDOUT_Length'hx;
        end else begin
            read_0_flag = 0;
        end
    end
    `endif

    reg [`EMTC_Pin_PDOUT_Length - 1 : 0] PDOUT_buffer;
`ifdef EMTC_Timing_Tsas_Min
    always @ (read_0_flag or read_x_flag or dout_buffer_at_posedge_pclk) begin
        if (read_0_flag) begin
            PDOUT_buffer   = `EMTC_Pin_PDOUT_Length'h0;
        end else if (read_x_flag) begin
            PDOUT_buffer   = `EMTC_Pin_PDOUT_Length'hx;
        end else begin
            PDOUT_buffer   =   dout_buffer_at_posedge_pclk;
        end
    end
`else
    always @ (read_x_flag or dout_buffer_at_posedge_pclk) begin
        if (read_x_flag) begin
            PDOUT_buffer = `EMTC_Pin_PDOUT_Length'hx;
        end else begin
            PDOUT_buffer = dout_buffer_at_posedge_pclk;
        end
    end
`endif

    reg rst_data;
    initial rst_data = 1'b0;
    always @ (posedge read_err_flag or negedge PCE) begin
        if (!PCE) begin
            #`EMTC_Timing_Tch_Min;
            rst_data = 1'b1;
        end else begin
            rst_data = 1'b1;
        end
        #0.1;
        rst_data = 1'b0;
    end

    always @ (posedge PCLK or posedge rst_data) begin
        if (rst_data)
            dout_buffer_at_posedge_pclk = `EMTC_Pin_PDOUT_Length'hx;
        else if (read_valid === 1'b1 && read_mode_related && !pgm_fail_mask_output_flag && ($realtime - pce_rise_time >= `EMTC_Timing_Tcs_Min))
            read_data;
    end

assign PDOUTo = PDOUT_buffer;
//////////////////////////////////////////////////
    // PGM
    reg program_entry_2;
    initial program_entry_2  = 1'b0;

    always @ (posedge PPROG or negedge PPROG or posedge exit_mode) begin
        #0.1;
        if (exit_mode)
            program_entry_2 = 1'b0;
    `ifdef EMTC_DC_PGMMode_VPP_Typ
        else if (pgm_mode_related && program_valid === 1'b1 && PPROG === 1'b1 && PWE === 1'b0 && VPP === 1'b1)
    `else
        else if (pgm_mode_related && program_valid === 1'b1 && PPROG === 1'b1 && PWE === 1'b0)
    `endif
            program_entry_2 = 1'b1;
        else
            program_entry_2 = 1'b0;
    end

    wire program_entry;
`ifdef EMTC_DC_PGMMode_VPP_Typ
    reg program_entry_1;
    initial program_entry_1 = 1'b0;
    assign program_entry = program_entry_1 & program_entry_2;
    always @ (posedge VPP or negedge VPP or posedge exit_mode) begin
        #1;
        if (exit_mode)
            program_entry_1 = 1'b0;
        else if (pgm_mode_related && program_valid === 1'b1 && VPP === 1'b1 && PPROG === 1'b0 && PWE === 1'b0)
            program_entry_1 = 1'b1;
        else
            program_entry_1 = 1'b0;
    end
`else
    assign program_entry = program_entry_2;
`endif


    integer j;
    integer k;
    reg [`EMTC_Pin_PDOUT_Length - 1 : 0] data_write;
    reg [`EMTC_Pin_PDOUT_Length - 1  : 0] data_write_mask;
    always @ (posedge PWE) begin
        if (program_entry && program_valid === 1'b1 && is_pgm) begin
            data_write                       = ~ `EMTC_Pin_PDOUT_Length'h0;
            data_write[`EMTC_Pin_PDIN_Length - 1 : 0] = PDIN;
            data_write_mask = ~ `EMTC_Pin_PDOUT_Length'h1;
            for (j = 1; j <= PAIO; j = j + 1) begin
                 data_write_mask[`EMTC_Pin_PDOUT_Length - 1 : 1] = data_write_mask[`EMTC_Pin_PDOUT_Length - 2 : 0];
                 data_write_mask[0]    = 1'b1;
            end
            data_write = PDIN | data_write_mask;
            pgm_data;
        end
    end

    always @ (negedge PCE) begin
        if (is_pgm && EMTC_write_file == 1'b1) begin
            StoreToFile;
        `ifdef EMTC_Density_TestCol_Size
            StoreToFile_TC;
        `endif
        `ifdef EMTC_Density_TestRow_Size
            StoreToFile_TR;
        `endif
            StoreToFile_IF;
            StoreToFile_REP;
            StoreToFile_PUF;
            StoreToFile_PUFORG;
        end
    end

    reg address_allowed;
    reg access_main;
    `ifdef EMTC_Density_TestCol_Size
        reg access_TC;
    `endif
    `ifdef EMTC_Density_TestRow_Size
        reg access_TR;
    `endif
        reg access_if;
        reg access_rep;
        reg access_puf;
        reg access_puforg;

    // pragma coverage off
    task check_address_range;
    begin
        if (PA <= `EMTC_Full_Address - 1) begin
            address_allowed = 1'b1;
        end else begin
            $display ("%t", $realtime, " @@ EMTC_Error: address PA = %d out of range in %s, max address = %d", PA, mode_string, `EMTC_Full_Address - 1);
            address_allowed = 1'b0;
        end
        casex ({PUF, PUFORG, PIF, PA_REP, PTC, PTR})
            6'b10_00_00:
                begin
                    {access_puf, access_puforg,  access_if, access_rep, access_main, access_TC, access_TR} = 7'h40;
                    task_check_PUF;
                end
            6'b11_00_00:
                begin
                    {access_puf, access_puforg,  access_if, access_rep, access_main, access_TC, access_TR} = 7'h20;
                    task_check_PUFORG;
                    if (is_margin_read) begin
                        $display ("%t", $realtime, " @@ EMTC_Error: There is no margin read in PUFORG array");
                        address_allowed = 1'b0;
                    end
                end
            6'b00_1x_xx:
                begin
                    {access_puf, access_puforg,  access_if, access_rep, access_main, access_TC, access_TR} = 7'h10;
                    task_check_IF;
                end
            6'b00_01_xx:
                begin
                    {access_puf, access_puforg,  access_if, access_rep, access_main, access_TC, access_TR} = 7'h8;
                    task_check_REP;
                end
            6'b00_00_00:
                begin
                    {access_puf, access_puforg,  access_if, access_rep, access_main, access_TC, access_TR} = 7'h4;
                end
            6'b00_00_10:
                begin
                    {access_puf, access_puforg,  access_if, access_rep, access_main, access_TC, access_TR} = 7'h2;
                    task_check_TC;
                end
            6'b00_00_x1:
                begin
                    {access_puf, access_puforg,  access_if, access_rep, access_main, access_TC, access_TR} = 7'h1;
                    task_check_TR;
                end
            default:
                begin
                    {access_puf, access_puforg,  access_if, access_rep, access_main, access_TC, access_TR} = 7'h0;
                    $display ("%t", $realtime, " @@ EMTC_Error: Invalid PUF, PUFORG, PIF, PA_REP, PTC, PTR selection");
                end
        endcase
    end
    endtask // check_address_range
    // pragma coverage on

`ifdef EMTC_Density_TestRow_Size
    task task_check_TR;
    integer PTR_address;
    begin
        for (PTR_address = `EMTC_PDOUT_Test_Row_0_Min; PTR_address <= `EMTC_PDOUT_Test_Row_0_Max; PTR_address = PTR_address + 1)
            if (PA[PTR_address] != 1'b0) begin
                address_allowed = 1'b0;
                $display ("%t", $realtime, " @@ EMTC_Error: PA[%d] should be 0 in %s at test row", PTR_address, mode_string);
            end
    `ifdef EMTC_PDOUT_Test_Row_0_Min1
        for (PTR_address = `EMTC_PDOUT_Test_Row_0_Min1; PTR_address <= `EMTC_PDOUT_Test_Row_0_Max1; PTR_address = PTR_address + 1)
            if (PA[PTR_address] != 1'b0) begin
                address_allowed = 1'b0;
                $display ("%t", $realtime, " @@ EMTC_Error: PA[%d] should be 0 in %s at test row", PTR_address, mode_string);
            end
    `endif
    end
    endtask // task_check_TR
`endif
    task task_check_IF;
    integer address;
    begin
        for (address = `EMTC_PDOUT_Test_INF_0_Min; address <= `EMTC_PDOUT_Test_INF_0_Max; address = address + 1)
            if (PA[address] != 1'b0) begin
                address_allowed = 1'b0;
                $display ("%t", $realtime, " @@ EMTC_Error: PA[%d] should be 0 in %s at INF array", address, mode_string);
            end
    end
    endtask // task_check_IF

    task task_check_REP;
    integer address;
    begin
        for (address = `EMTC_PDOUT_Test_REP_0_Min; address <= `EMTC_PDOUT_Test_REP_0_Max; address = address + 1)
            if (PA[address] != 1'b0) begin
                address_allowed = 1'b0;
                $display ("%t", $realtime, " @@ EMTC_Error: PA[%d] should be 0 in %s at REP array", address, mode_string);
            end
    end
    endtask // task_check_REP

    task task_check_PUF;
    integer address;
    begin
        for (address = `EMTC_PDOUT_Test_PUF_0_Min; address <= `EMTC_PDOUT_Test_PUF_0_Max; address = address + 1)
            if (PA[address] != 1'b0) begin
                address_allowed = 1'b0;
                $display ("%t", $realtime, " @@ EMTC_Error: PA[%d] should be 0 in %s at PUF array", address, mode_string);
            end
    end
    endtask // task_check_PUF

    task task_check_PUFORG;
    integer address;
    begin
        for (address = `EMTC_PDOUT_Test_PUF_0_Min; address <= `EMTC_PDOUT_Test_PUF_0_Max; address = address + 1)
            if (PA[address] != 1'b0) begin
                address_allowed = 1'b0;
                $display ("%t", $realtime, " @@ EMTC_Error: PA[%d] should be 0 in %s at PUFORG array", address, mode_string);
            end
        if (mode_reg == pgm_mode && PAS !== `EMTC_Pin_PAS_Length'h0) begin
            address_allowed = 1'b0;
            $display ("%t", $realtime, " @@ EMTC_Error: PAS should be 0 in %s at PUFORG array", mode_string);
        end
    end
    endtask // task_check_PUFORG

`ifdef EMTC_Density_TestCol_Size
    task task_check_TC;
    integer PTC_address;
    begin
        for (PTC_address = `EMTC_PDOUT_Test_Col_0_Min; PTC_address <= `EMTC_PDOUT_Test_Col_0_Max; PTC_address = PTC_address + 1)
            if (PA[PTC_address] != 1'b0) begin
                address_allowed = 1'b0;
                $display ("%t", $realtime, " @@ EMTC_Error: PA[%d] should be 0 in %s at test column", PTC_address, mode_string);
            end
    `ifdef EMTC_PDOUT_Test_Col_0_Min1
        for (PTC_address = `EMTC_PDOUT_Test_Col_0_Min1; PTC_address <= `EMTC_PDOUT_Test_Col_0_Max1; PTC_address = PTC_address + 1)
            if (PA[PTC_address] != 1'b0) begin
                address_allowed = 1'b0;
                $display ("%t", $realtime, " @@ EMTC_Error: PA[%d] should be 0 in %s at test column", PTC_address, mode_string);
            end
    `endif
    `ifdef EMTC_Pin_PAIO_Length
        if (is_pgm && PAIO !== `EMTC_Pin_PAIO_Length'd0) begin
            address_allowed = 1'b0;
            $display ("%t", $realtime, " @@ EMTC_Error: PAIO should be 0 in %s at test column", mode_string);
        end
    `endif
    end
    endtask // task_check_TC
`endif

    // pragma coverage off
    task read_data;
    integer io;
    reg [`EMTC_Pin_PDOUT_Length - 1 : 0] the_same_value;
    begin
        check_address_range;
        if (!address_allowed) begin
            dout_buffer_at_posedge_pclk = #(`EMTC_Timing_Toh_Min) `EMTC_Pin_PDOUT_Length'hx;
        end else begin
            case ({access_rep, access_main, access_TC, access_TR, access_puf, access_puforg, access_if})
                7'h1:
                    begin
                        task_read_IF(the_same_value);
                    end
                7'h2:
                    begin
                        task_read_PUFORG(the_same_value);
                    end
                7'h4:
                    begin
                        task_read_PUF(the_same_value);
                    end
                7'h8:
                    begin
                        task_read_TR(the_same_value);
                    end
                7'h10:
                    begin
                        task_read_TC(the_same_value);
                    end
                7'h20:
                    begin
                        task_read_main(the_same_value);
                    end
                7'h40:
                    begin
                        task_read_REP(the_same_value);
                    end
                default:
                    begin
                        task_read_main(the_same_value);
                    end
            endcase
            for (io = 0; io <= `EMTC_Pin_PDOUT_Length - 1; io = io + 1)
                if (the_same_value[io] !== 1'bx)
                    dout_buffer_at_posedge_pclk[io] = the_same_value[io];
                else
                    dout_buffer_at_posedge_pclk[io] <= #(`EMTC_Timing_Toh_Min) the_same_value[io];
        end
    end
    endtask // read_data
    // pragma coverage on

    task task_read_main;
        output [`EMTC_Pin_PDOUT_Length - 1 : 0] the_same_value;
        reg [`EMTC_Pin_PDOUT_Length - 1 : 0] the_same_value;
    `ifdef EMTC_Pin_PAS_Length
        reg [`EMTC_Pin_PDOUT_Length - 1 : 0] read_data_one_word;
        integer io;
        integer read_pas;
        reg [`EMTC_Pin_PAS_Length - 1 : 0] PAS_read;
        reg [`EMTC_Pin_PAS_Length - 1 : 0] PAS_read_full;
        begin
            PAS_read_full = ~`EMTC_Pin_PAS_Length'd0;
            the_same_value = MEM_MAIN[{PA, `EMTC_Pin_PAS_Length'd0}];
            for (read_pas = 1; read_pas <= PAS_read_full; read_pas = read_pas + 1) begin
                PAS_read = read_pas;
                read_data_one_word = MEM_MAIN[{PA, PAS_read}];
                for (io = 0; io <= `EMTC_Pin_PDOUT_Length - 1; io = io + 1)
                    if (the_same_value[io] !== read_data_one_word[io]) begin
                        the_same_value[io] = 1'bx;
                        $display ("%t", $realtime, " @@ EMTC_Error: Not all the PAS cells of PA= %d, IO = %d at main array have been programmed", PA, io);
                    end
            end
        end
    `else
        begin
            the_same_value = MEM_MAIN[PA];
        end
    `endif
    endtask // task_read_main

`ifdef EMTC_Density_TestRow_Size
    task task_read_TR;
        output [`EMTC_Pin_PDOUT_Length - 1 : 0] the_same_value;
        reg [`EMTC_Pin_PDOUT_Length - 1 : 0] the_same_value;
    `ifdef EMTC_Pin_PAS_Length
        reg [`EMTC_Pin_PDOUT_Length - 1 : 0] read_data_one_word;
        integer io;
        integer read_pas;
        reg [`EMTC_Pin_PAS_Length - 1 : 0] PAS_read;
        reg [`EMTC_Pin_PAS_Length - 1 : 0] PAS_read_full;
        begin
            PAS_read_full = ~`EMTC_Pin_PAS_Length'd0;
            the_same_value = MEM_TR[{PA, `EMTC_Pin_PAS_Length'd0}];
            for (read_pas = 1; read_pas <= PAS_read_full; read_pas = read_pas + 1) begin
                PAS_read = read_pas;
                read_data_one_word = MEM_TR[{PA, PAS_read}];
                for (io = 0; io <= `EMTC_Pin_PDOUT_Length - 1; io = io + 1)
                    if (the_same_value[io] !== read_data_one_word[io]) begin
                        the_same_value[io] = 1'bx;
                        $display ("%t", $realtime, " @@ EMTC_Error: Not all the PAS cells of PA= %d, IO = %d at test row have been programmed", PA, io);
                    end
            end
        end
    `else
        begin
            the_same_value = MEM_TR[PA];
        end
    `endif
    endtask // task_read_TR
`endif

    task task_read_IF;
        output [`EMTC_Pin_PDOUT_Length - 1 : 0] the_same_value;
        reg [`EMTC_Pin_PDOUT_Length - 1 : 0] the_same_value;
    `ifdef EMTC_Pin_PAS_Length
        reg [`EMTC_Pin_PDOUT_Length - 1 : 0] read_data_one_word;
        integer io;
        integer read_pas;
        reg [`EMTC_Pin_PAS_Length - 1 : 0] PAS_read;
        reg [`EMTC_Pin_PAS_Length - 1 : 0] PAS_read_full;
        begin
            PAS_read_full = ~`EMTC_Pin_PAS_Length'd0;
            the_same_value = MEM_IF[{PA, `EMTC_Pin_PAS_Length'd0}];
            for (read_pas = 1; read_pas <= PAS_read_full; read_pas = read_pas + 1) begin
                PAS_read = read_pas;
                read_data_one_word = MEM_IF[{PA, PAS_read}];
                for (io = 0; io <= `EMTC_Pin_PDOUT_Length - 1; io = io + 1)
                    if (the_same_value[io] !== read_data_one_word[io]) begin
                        the_same_value[io] = 1'bx;
                        $display ("%t", $realtime, " @@ EMTC_Error: Not all the PAS cells of PA= %d, IO = %d at INF array have been programmed", PA, io);
                    end
            end
        end
    `else
        begin
            the_same_value = MEM_IF[PA];
        end
    `endif
    endtask // task_read_IF

    task task_read_REP;
        output [`EMTC_Pin_PDOUT_Length - 1 : 0] the_same_value;
        reg [`EMTC_Pin_PDOUT_Length - 1 : 0] the_same_value;
    `ifdef EMTC_Pin_PAS_Length
        reg [`EMTC_Pin_PDOUT_Length - 1 : 0] read_data_one_word;
        integer io;
        integer read_pas;
        reg [`EMTC_Pin_PAS_Length - 1 : 0] PAS_read;
        reg [`EMTC_Pin_PAS_Length - 1 : 0] PAS_read_full;
        begin
            PAS_read_full = ~`EMTC_Pin_PAS_Length'd0;
            the_same_value = MEM_REP[{PA, `EMTC_Pin_PAS_Length'd0}];
            for (read_pas = 1; read_pas <= PAS_read_full; read_pas = read_pas + 1) begin
                PAS_read = read_pas;
                read_data_one_word = MEM_REP[{PA, PAS_read}];
                for (io = 0; io <= `EMTC_Pin_PDOUT_Length - 1; io = io + 1)
                    if (the_same_value[io] !== read_data_one_word[io]) begin
                        the_same_value[io] = 1'bx;
                        $display ("%t", $realtime, " @@ EMTC_Error: Not all the PAS cells of PA= %d, IO = %d at REP array have been programmed", PA, io);
                    end
            end
        end
    `else
        begin
            the_same_value = MEM_REP[PA];
        end
    `endif
    endtask // task_read_REP
    
    task task_read_PUF;
        output [`EMTC_Pin_PDOUT_Length - 1 : 0] the_same_value;
        reg [`EMTC_Pin_PDOUT_Length - 1 : 0] the_same_value;
    `ifdef EMTC_Pin_PAS_Length
        reg [`EMTC_Pin_PDOUT_Length - 1 : 0] read_data_one_word;
        integer io;
        integer read_pas;
        reg [`EMTC_Pin_PAS_Length - 1 : 0] PAS_read;
        reg [`EMTC_Pin_PAS_Length - 1 : 0] PAS_read_full;
        begin
            PAS_read_full = ~`EMTC_Pin_PAS_Length'd0;
            the_same_value = MEM_PUF[{PA, `EMTC_Pin_PAS_Length'd0}];
            for (read_pas = 1; read_pas <= PAS_read_full; read_pas = read_pas + 1) begin
                PAS_read = read_pas;
                read_data_one_word = MEM_PUF[{PA, PAS_read}];
                for (io = 0; io <= `EMTC_Pin_PDOUT_Length - 1; io = io + 1)
                    if (the_same_value[io] !== read_data_one_word[io]) begin
                        the_same_value[io] = 1'bx;
                        $display ("%t", $realtime, " @@ EMTC_Error: Not all the PAS cells of PA= %d, IO = %d at PUF array have been programmed", PA, io);
                    end
            end
        end
    `else
        begin
            the_same_value = MEM_PUF[PA];
        end
    `endif
    endtask // task_read_PUF

    task task_read_PUFORG;
        output [`EMTC_Pin_PDOUT_Length - 1 : 0] the_same_value;
        reg [`EMTC_Pin_PDOUT_Length - 1 : 0] the_same_value;
        begin
            the_same_value = MEM_PUFORG[PA];
        end
    endtask // task_read_PUFORG

`ifdef EMTC_Density_TestCol_Size
    task task_read_TC;
        output [`EMTC_Pin_PDOUT_Length - 1 : 0] the_same_value;
        reg [`EMTC_Pin_PDOUT_Length - 1 : 0] the_same_value;
        integer io;
    `ifdef EMTC_Pin_PAS_Length
        reg [`EMTC_Pin_PDOUT_Length - 1 : 0] read_data_one_word;
        integer read_pas;
        reg [`EMTC_Pin_PAS_Length - 1 : 0] PAS_read;
        reg [`EMTC_Pin_PAS_Length - 1 : 0] PAS_read_full;
        begin
            PAS_read_full = ~`EMTC_Pin_PAS_Length'd0;
            the_same_value = MEM_TC[{PA, `EMTC_Pin_PAS_Length'd0}];
            for (read_pas = 1; read_pas <= PAS_read_full; read_pas = read_pas + 1) begin
                PAS_read = read_pas;
                read_data_one_word = MEM_TC[{PA, PAS_read}];
                for (io = 0; io <= `EMTC_Pin_PDOUT_Length - 1; io = io + 1)
                    if (io <= 0) begin
                        if (the_same_value[io] !== read_data_one_word[io]) begin
                            the_same_value[io] = 1'bx;
                            $display ("%t", $realtime, " @@ EMTC_Error: Not all the PAS cells of PA= %d, IO = %d at test column have been programmed", PA, io);
                        end
                    end else
                        the_same_value[io] = 1'bx;
            end
        end
    `else
        begin
            the_same_value = MEM_TC[PA];
            for (io = 0; io <= `EMTC_Pin_PDOUT_Length - 1; io = io + 1)
                if (io > 0)
                    the_same_value[io] = 1'bx;
        end
    `endif
    endtask // task_read_TC
`endif

    wire [`EMTC_Memory_AddressBits - 1 : 0] pgm_addr;
    wire [`EMTC_Memory_AddressBits_PUF - 1 : 0] pgm_addr_puf;
`ifdef EMTC_Pin_PAS_Length
    assign pgm_addr       = {PA, PAS};
`else
    assign pgm_addr       = {PA};
`endif
    assign pgm_addr_puf   = {PA};

    // pragma coverage off
    task pgm_data;
    begin
        check_address_range;
        if (address_allowed) begin
                case ({access_rep, access_main, access_TC, access_TR, access_puf, access_puforg, access_if})
                    7'h1:
                        begin
                            pgm_times_IF;
                            MEM_IF[pgm_addr] = MEM_IF[pgm_addr] & data_write;
                        end
                    7'h2:
                        begin
                            pgm_times_PUFORG;
                            MEM_PUFORG[pgm_addr_puf] = MEM_PUFORG[pgm_addr_puf] & (MEM_PUFVIRTUAL[pgm_addr_puf] | data_write_mask);
                        end
                    7'h4:
                        begin
                            pgm_times_PUF;
                            MEM_PUF[pgm_addr] = MEM_PUF[pgm_addr] & data_write;
                        end
                    7'h8:
                        begin
                            pgm_times_TR;
                            MEM_TR[pgm_addr] = MEM_TR[pgm_addr] & data_write;
                        end
                    7'h10:
                        begin
                            pgm_times_TC;
                            MEM_TC[pgm_addr] = MEM_TC[pgm_addr] & data_write;
                        end
                    7'h20:
                        begin
                            pgm_times_main;
                            MEM_MAIN[pgm_addr] = MEM_MAIN[pgm_addr] & data_write;
                        end
                    7'h40:
                        begin
                            pgm_times_REP;
                            MEM_REP[pgm_addr] = MEM_REP[pgm_addr] & data_write;
                        end
                    default:
                        begin
                            pgm_times_main;
                            MEM_MAIN[pgm_addr] = MEM_MAIN[pgm_addr] & data_write;
                        end
                endcase
        end
    end
    endtask // pgm_data
    // pragma coverage on

`ifdef EMTC_Density_TestCol_Size
    task pgm_times_TC;
    reg [2:0] pgm_times;
    reg [20*8 : 0] array_string;
    integer io;
    begin
        for (io = 0; io <= `EMTC_Pin_PDOUT_Length - 1; io = io + 1) begin
            pgm_times = 3'h0;
            if (data_write[io] === 1'b0) begin
                if (MEM_TC_T[pgm_addr * `EMTC_Pin_PDOUT_Length     + io] != ~ 3'h0)
                    MEM_TC_T[pgm_addr * `EMTC_Pin_PDOUT_Length     + io] = MEM_TC_T[pgm_addr * `EMTC_Pin_PDOUT_Length + io] + 1;
                pgm_times = MEM_TC_T[pgm_addr * `EMTC_Pin_PDOUT_Length     + io];
                array_string = "test column";
                pgm_times_check(pgm_times, array_string, io);
            end
        end
    end
    endtask // pgm_times_TC
`endif
`ifdef EMTC_Density_TestRow_Size
    task pgm_times_TR;
    reg [2:0] pgm_times;
    reg [20*8 : 0] array_string;
    integer io;
    begin
        for (io = 0; io <= `EMTC_Pin_PDOUT_Length - 1; io = io + 1) begin
            pgm_times = 3'h0;
            if (data_write[io] === 1'b0) begin
                if (MEM_TR_T[pgm_addr * `EMTC_Pin_PDOUT_Length     + io] != ~ 3'h0)
                    MEM_TR_T[pgm_addr * `EMTC_Pin_PDOUT_Length     + io] = MEM_TR_T[pgm_addr * `EMTC_Pin_PDOUT_Length + io] + 1;
                pgm_times = MEM_TR_T[pgm_addr * `EMTC_Pin_PDOUT_Length     + io];
                array_string = "test row";
                pgm_times_check(pgm_times, array_string, io);
            end
        end
    end
    endtask // pgm_times_TR
`endif
    task pgm_times_main;
    reg [2:0] pgm_times;
    reg [20*8 : 0] array_string;
    integer io;
    begin
        for (io = 0; io <= `EMTC_Pin_PDOUT_Length - 1; io = io + 1) begin
            pgm_times = 3'h0;
            if (data_write[io] === 1'b0) begin
                if (MEM_MAIN_T[pgm_addr * `EMTC_Pin_PDOUT_Length   + io] != ~ 3'h0)
                    MEM_MAIN_T[pgm_addr * `EMTC_Pin_PDOUT_Length   + io] = MEM_MAIN_T[pgm_addr * `EMTC_Pin_PDOUT_Length + io] + 1;
                pgm_times = MEM_MAIN_T[pgm_addr * `EMTC_Pin_PDOUT_Length   + io];
                array_string = "main array";
                pgm_times_check(pgm_times, array_string, io);
            end
        end
    end
    endtask // pgm_times_main

    task pgm_times_IF;
    reg [2:0] pgm_times;
    reg [20*8 : 0] array_string;
    integer io;
    begin
        for (io = 0; io <= `EMTC_Pin_PDOUT_Length - 1; io = io + 1) begin
            pgm_times = 3'h0;
            if (data_write[io] === 1'b0) begin
                if (MEM_IF_T[pgm_addr * `EMTC_Pin_PDOUT_Length   + io] != ~ 3'h0)
                    MEM_IF_T[pgm_addr * `EMTC_Pin_PDOUT_Length   + io] = MEM_IF_T[pgm_addr * `EMTC_Pin_PDOUT_Length + io] + 1;
                pgm_times = MEM_IF_T[pgm_addr * `EMTC_Pin_PDOUT_Length   + io];
                array_string = "IF array";
                pgm_times_check(pgm_times, array_string, io);
            end
        end
    end
    endtask // pgm_times_IF

    task pgm_times_REP;
    reg [2:0] pgm_times;
    reg [20*8 : 0] array_string;
    integer io;
    begin
        for (io = 0; io <= `EMTC_Pin_PDOUT_Length - 1; io = io + 1) begin
            pgm_times = 3'h0;
            if (data_write[io] === 1'b0) begin
                if (MEM_REP_T[pgm_addr * `EMTC_Pin_PDOUT_Length   + io] != ~ 3'h0)
                    MEM_REP_T[pgm_addr * `EMTC_Pin_PDOUT_Length   + io] = MEM_REP_T[pgm_addr * `EMTC_Pin_PDOUT_Length + io] + 1;
                pgm_times = MEM_REP_T[pgm_addr * `EMTC_Pin_PDOUT_Length   + io];
                array_string = "REP array";
                pgm_times_check(pgm_times, array_string, io);
            end
        end
    end
    endtask // pgm_times_REP

    task pgm_times_PUF;
    reg [2:0] pgm_times;
    reg [20*8 : 0] array_string;
    integer io;
    begin
        for (io = 0; io <= `EMTC_Pin_PDOUT_Length - 1; io = io + 1) begin
            pgm_times = 3'h0;
            if (data_write[io] === 1'b0) begin
                if (MEM_PUF_T[pgm_addr * `EMTC_Pin_PDOUT_Length   + io] != ~ 3'h0)
                    MEM_PUF_T[pgm_addr * `EMTC_Pin_PDOUT_Length   + io] = MEM_PUF_T[pgm_addr * `EMTC_Pin_PDOUT_Length + io] + 1;
                pgm_times = MEM_PUF_T[pgm_addr * `EMTC_Pin_PDOUT_Length   + io];
                array_string = "PUF array";
                pgm_times_check_puf(pgm_times, array_string, io);
            end
        end
    end
    endtask // pgm_times_PUF

    task pgm_times_PUFORG;
    reg [2:0] pgm_times;
    reg [20*8 : 0] array_string;
    integer io;
    begin
        for (io = 0; io <= `EMTC_Pin_PDOUT_Length - 1; io = io + 1) begin
            pgm_times = 3'h0;
            if (data_write_mask[io] === 1'b0) begin
                if (MEM_PUFORG_T[pgm_addr_puf * `EMTC_Pin_PDOUT_Length   + io] != ~ 3'h0)
                    MEM_PUFORG_T[pgm_addr_puf * `EMTC_Pin_PDOUT_Length   + io] = MEM_PUFORG_T[pgm_addr_puf * `EMTC_Pin_PDOUT_Length + io] + 1;
                pgm_times = MEM_PUFORG_T[pgm_addr_puf * `EMTC_Pin_PDOUT_Length   + io];
                array_string = "PUFORG array";
                pgm_times_check_puforg(pgm_times, array_string, io);
            end
        end
    end
    endtask // pgm_times_PUFORG

    event event_timing_vio;
    event event_times_vio;

    task pgm_times_check;
    input [2:0] pgm_times;
    input [20*8 : 0] array_string;
    input integer io;
    begin
        if (pgm_times >= 3'h2)
        `ifdef EMTC_Pin_PAS_Length
            `ifdef EMTC_Pin_PAIO_Length
                $display ("@@ EMTC_Warning,  PA = %d, PAS = %d, PAIO = %d, IO = %d, repeatedly PGM %d times at %s", PA, PAS, PAIO, io, pgm_times, array_string);
            `else
                $display ("@@ EMTC_Warning,  PA = %d, PAS = %d, IO = %d, repeatedly PGM %d times at %s", PA, PAS, io, pgm_times, array_string);
            `endif
        `else `ifdef EMTC_Pin_PAIO_Length
                $display ("@@ EMTC_Warning,  PA = %d, PAIO = %d, IO = %d, repeatedly PGM %d times at %s", PA, PAIO, io, pgm_times, array_string);
        `else
                $display ("@@ EMTC_Warning,  PA = %d, IO = %d, repeatedly PGM %d times at %s", PA, io, pgm_times, array_string);
        `endif `endif
        if (`EMTC_PGM_TIMES_SCREEN == 1 && pgm_times > `EMTC_PGM_TIMES_ALLOW) begin
            $display ("%t", $realtime, " @@ EMTC_Error: Not allow Program more than %d times at the same cell. The following read access will get unknown data.", `EMTC_PGM_TIMES_ALLOW);
            $display ("%t", $realtime, " ## EMTC_Note:  To increase the PGM times allowed. Please modify the definition EMTC_PGM_TIMES_ALLOW");
            $display ("%t", $realtime, " ## EMTC_Note:  To not screen PGM times, Please set the definition EMTC_PGM_TIMES_SCREEN to 0");
            -> event_times_vio;
        end
    end
    endtask // pgm_times_check

    task pgm_times_check_puforg;
    input [2:0] pgm_times;
    input [20*8 : 0] array_string;
    input integer io;
    begin
        if (pgm_times >= 3'h2)
            $display ("@@ EMTC_Warning,  PA = %d, PAIO = %d, IO = %d, repeatedly PGM %d times at %s", PA, PAIO, io, pgm_times, array_string);
        if (`EMTC_PGM_TIMES_SCREEN == 1 && pgm_times > `EMTC_PGM_TIMES_ALLOW) begin
            $display ("%t", $realtime, " @@ EMTC_Error: Not allow Program more than %d times at the same cell. The following read access will get unknown data.", `EMTC_PGM_TIMES_ALLOW);
            $display ("%t", $realtime, " ## EMTC_Note:  To increase the PGM times allowed. Please modify the definition EMTC_PGM_TIMES_ALLOW");
            $display ("%t", $realtime, " ## EMTC_Note:  To not screen PGM times, Please set the definition EMTC_PGM_TIMES_SCREEN to 0");
            -> event_times_vio;
        end
    end
    endtask // pgm_times_check_puforg

    task pgm_times_check_puf;
    input [2:0] pgm_times;
    input [20*8 : 0] array_string;
    input integer io;
    begin
        if (pgm_times >= 3'h2)
        `ifdef EMTC_Pin_PAS_Length
            `ifdef EMTC_Pin_PAIO_Length
                $display ("@@ EMTC_Warning,  PA = %d, PAS = %d, PAIO = %d, IO = %d, repeatedly PGM %d times at %s", PA, PAS, PAIO, io, pgm_times, array_string);
            `else
                $display ("@@ EMTC_Warning,  PA = %d, PAS = %d, IO = %d, repeatedly PGM %d times at %s", PA, PAS, io, pgm_times, array_string);
            `endif
        `else `ifdef EMTC_Pin_PAIO_Length
                $display ("@@ EMTC_Warning,  PA = %d, PAIO = %d, IO = %d, repeatedly PGM %d times at %s", PA, PAIO, io, pgm_times, array_string);
        `else
                $display ("@@ EMTC_Warning,  PA = %d, IO = %d, repeatedly PGM %d times at %s", PA, io, pgm_times, array_string);
        `endif `endif
        if (`EMTC_PGM_TIMES_SCREEN == 1 && pgm_times > `EMTC_PUF_TIMES_ALLOW) begin
            $display ("%t", $realtime, " @@ EMTC_Error: Not allow Program more than %d times at the same cell. The following read access will get unknown data.", `EMTC_PUF_TIMES_ALLOW);
            $display ("%t", $realtime, " ## EMTC_Note:  To increase the PGM times allowed. Please modify the definition EMTC_PUF_TIMES_ALLOW");
            $display ("%t", $realtime, " ## EMTC_Note:  To not screen PGM times, Please set the definition EMTC_PGM_TIMES_SCREEN to 0");
            -> event_times_vio;
        end
    end
    endtask // pgm_times_check_puf

    // pragma coverage off
    task StoreToFile;
    integer outfile;
    integer i;
    begin
        outfile = $fopen(mem_file_OUT);
        if(outfile == 0) begin
            $display("@@ EMTC_Error : cannot open output file %s", mem_file_OUT);
        end else begin
            $display("Saving data to file %s", mem_file_OUT);
            for (i = 0; i <= `EMTC_Memory_Address; i = i + 1) begin
                $fdisplay(outfile, "@%h %h", i, MEM_MAIN[i]);
            end
        end
        $fclose(outfile);

        outfile = $fopen(mem_file_pgm_times_OUT);
        if(outfile == 0) begin
            $display("@@ EMTC_Error : cannot open output file %s", mem_file_pgm_times_OUT);
        end else begin
            $display("Saving data to file %s", mem_file_pgm_times_OUT);
            for (i = 0; i <= `EMTC_Memory_TotalAddress; i = i + 1) begin
                $fdisplay(outfile, "@%h %h", i, MEM_MAIN_T[i]);
            end
        end
        $fclose(outfile);
    end
    endtask // StoreToFile

`ifdef EMTC_Density_TestRow_Size
    task StoreToFile_TR;
    integer outfile;
    integer i;
    begin
        outfile = $fopen(mem_file_for_TR_OUT);
        if(outfile == 0) begin
            $display("@@ EMTC_Error : cannot open output file %s", mem_file_for_TR_OUT);
        end else begin
            $display("Saving data to file %s", mem_file_for_TR_OUT);
            for (i = 0; i <= `EMTC_Memory_Address; i = i + 1) begin
                $fdisplay(outfile, "@%h %h", i, MEM_TR[i]);
            end
        end
        $fclose(outfile);

        outfile = $fopen(mem_file_for_TR_pgm_times_OUT);
        if(outfile == 0) begin
            $display("@@ EMTC_Error : cannot open output file %s", mem_file_for_TR_pgm_times_OUT);
        end else begin
            $display("Saving data to file %s", mem_file_for_TR_pgm_times_OUT);
            for (i = 0; i <= `EMTC_Memory_TotalAddress; i = i + 1) begin
                $fdisplay(outfile, "@%h %h", i, MEM_TR_T[i]);
            end
        end
        $fclose(outfile);
    end
    endtask // StoreToFile_TR
`endif
    task StoreToFile_IF;
    integer outfile;
    integer i;
    begin
        outfile = $fopen(mem_file_for_IF_OUT);
        if(outfile == 0) begin
            $display("@@ EMTC_Error : cannot open output file %s", mem_file_for_IF_OUT);
        end else begin
            $display("Saving data to file %s", mem_file_for_IF_OUT);
            for (i = 0; i <= `EMTC_Memory_Address; i = i + 1) begin
                $fdisplay(outfile, "@%h %h", i, MEM_IF[i]);
            end
        end
        $fclose(outfile);

        outfile = $fopen(mem_file_for_IF_pgm_times_OUT);
        if(outfile == 0) begin
            $display("@@ EMTC_Error : cannot open output file %s", mem_file_for_IF_pgm_times_OUT);
        end else begin
            $display("Saving data to file %s", mem_file_for_IF_pgm_times_OUT);
            for (i = 0; i <= `EMTC_Memory_TotalAddress; i = i + 1) begin
                $fdisplay(outfile, "@%h %h", i, MEM_IF_T[i]);
            end
        end
        $fclose(outfile);
    end
    endtask // StoreToFile_IF

    task StoreToFile_REP;
    integer outfile;
    integer i;
    begin
        outfile = $fopen(mem_file_for_REP_OUT);
        if(outfile == 0) begin
            $display("@@ EMTC_Error : cannot open output file %s", mem_file_for_REP_OUT);
        end else begin
            $display("Saving data to file %s", mem_file_for_REP_OUT);
            for (i = 0; i <= `EMTC_Memory_Address; i = i + 1) begin
                $fdisplay(outfile, "@%h %h", i, MEM_REP[i]);
            end
        end
        $fclose(outfile);

        outfile = $fopen(mem_file_for_REP_pgm_times_OUT);
        if(outfile == 0) begin
            $display("@@ EMTC_Error : cannot open output file %s", mem_file_for_REP_pgm_times_OUT);
        end else begin
            $display("Saving data to file %s", mem_file_for_REP_pgm_times_OUT);
            for (i = 0; i <= `EMTC_Memory_TotalAddress; i = i + 1) begin
                $fdisplay(outfile, "@%h %h", i, MEM_REP_T[i]);
            end
        end
        $fclose(outfile);
    end
    endtask // StoreToFile_REP

    task StoreToFile_PUF;
    integer outfile;
    integer i;
    begin
        outfile = $fopen(mem_file_for_PUF_OUT);
        if(outfile == 0) begin
            $display("@@ EMTC_Error : cannot open output file %s", mem_file_for_PUF_OUT);
        end else begin
            $display("Saving data to file %s", mem_file_for_PUF_OUT);
            for (i = 0; i <= `EMTC_Memory_Address; i = i + 1) begin
                $fdisplay(outfile, "@%h %h", i, MEM_PUF[i]);
            end
        end
        $fclose(outfile);

        outfile = $fopen(mem_file_for_PUF_pgm_times_OUT);
        if(outfile == 0) begin
            $display("@@ EMTC_Error : cannot open output file %s", mem_file_for_PUF_pgm_times_OUT);
        end else begin
            $display("Saving data to file %s", mem_file_for_PUF_pgm_times_OUT);
            for (i = 0; i <= `EMTC_Memory_TotalAddress; i = i + 1) begin
                $fdisplay(outfile, "@%h %h", i, MEM_PUF_T[i]);
            end
        end
        $fclose(outfile);
    end
    endtask // StoreToFile_PUF

    task StoreToFile_PUFORG;
    integer outfile;
    integer i;
    begin
        outfile = $fopen(mem_file_for_PUFORG_OUT);
        if(outfile == 0) begin
            $display("@@ EMTC_Error : cannot open output file %s", mem_file_for_PUFORG_OUT);
        end else begin
            $display("Saving data to file %s", mem_file_for_PUFORG_OUT);
            for (i = 0; i <= `EMTC_Memory_Address_PUF; i = i + 1) begin
                $fdisplay(outfile, "@%h %h", i, MEM_PUFORG[i]);
            end
        end
        $fclose(outfile);

        outfile = $fopen(mem_file_for_PUFORG_pgm_times_OUT);
        if(outfile == 0) begin
            $display("@@ EMTC_Error : cannot open output file %s", mem_file_for_PUFORG_pgm_times_OUT);
        end else begin
            $display("Saving data to file %s", mem_file_for_PUFORG_pgm_times_OUT);
            for (i = 0; i <= `EMTC_Memory_TotalAddress_PUF; i = i + 1) begin
                $fdisplay(outfile, "@%h %h", i, MEM_PUFORG_T[i]);
            end
        end
        $fclose(outfile);
    end
    endtask // StoreToFile_PUFORG

`ifdef EMTC_Density_TestCol_Size
    task StoreToFile_TC;
    integer outfile;
    integer i;
    begin
        outfile = $fopen(mem_file_for_TC_OUT);
        if(outfile == 0) begin
            $display("@@ EMTC_Error : cannot open output file %s", mem_file_for_TC_OUT);
        end else begin
            $display("Saving data to file %s", mem_file_for_TC_OUT);
            for (i = 0; i <= `EMTC_Memory_Address; i = i + 1) begin
                $fdisplay(outfile, "@%h %h", i, MEM_TC[i]);
            end
        end
        $fclose(outfile);

        outfile = $fopen(mem_file_for_TC_pgm_times_OUT);
        if(outfile == 0) begin
            $display("@@ EMTC_Error : cannot open output file %s", mem_file_for_TC_pgm_times_OUT);
        end else begin
            $display("Saving data to file %s", mem_file_for_TC_pgm_times_OUT);
            for (i = 0; i <= `EMTC_Memory_TotalAddress; i = i + 1) begin
                $fdisplay(outfile, "@%h %h", i, MEM_TC_T[i]);
            end
        end
        $fclose(outfile);
    end
    endtask // StoreToFile_TC
`endif
    // pragma coverage on

    // PTM timing violation
    always @ (notify_min_Tmh) begin
        $display ("%t", $realtime, " @@ EMTC_Error : Min mode hold time (Tmh) violation");
    end
    always @ (notify_min_Tms) begin
        $display ("%t", $realtime, " @@ EMTC_Error: Min mode setup time (Tms) violation");
        Tms_violation = 1'b1;
        #1;
        Tms_violation = 1'b0;
    end

    always @ (event_timing_vio or event_times_vio) begin
        pgm_fail_mask_output_flag = 1'b1;
    end

    always @ (notify_min_Tasp) begin
        $display ("%t", $realtime, " @@ EMTC_Error: Address setup time (Tasp) violation in %s", mode_string);
        -> event_timing_vio;
    end
    always @ (notify_min_Tahp) begin
        $display ("%t", $realtime, " @@ EMTC_Error: Address hold time (Tahp) violation in %s", mode_string);
        -> event_timing_vio;
    end
    always @ (notify_min_Tdsp) begin
        $display ("%t", $realtime, " @@ EMTC_Error: Data setup time (Tdsp) violation in %s", mode_string);
        -> event_timing_vio;
    end
    always @ (notify_min_Tdhp) begin
        $display ("%t", $realtime, " @@ EMTC_Error: Data hold time (Tdhp) violation in %s", mode_string);
        -> event_timing_vio;
    end

        always @ (PA or PTR or PTC or PDIN or PIF or PA_REP or PUF or PUFORG) begin
            if (is_pgm && PWE === 1'b1) begin
                $display ("%t", $realtime, " @@ EMTC_Error : Address or data cannot change during PWE program pusle is high.");
                -> event_timing_vio;
            end
        end

    `ifdef EMTC_Pin_PAS_Length
        always @ (PAS) begin
            if (is_pgm && PWE === 1'b1) begin
                $display ("%t", $realtime, " @@ EMTC_Error : PAS cannot change during PWE program pusle is high.");
                -> event_timing_vio;
            end
        end
    `endif

    `ifdef EMTC_Pin_PAIO_Length
        always @ (PAIO) begin
            if (is_pgm && PWE === 1'b1) begin
                $display ("%t", $realtime, " @@ EMTC_Error : PAIO cannot change during PWE program pusle is high.");
                -> event_timing_vio;
            end
        end
    `endif

    // Read timing violation
    always @ (notify_min_Tcyc) begin
        $display ("%t", $realtime, " @@ EMTC_Error: Min cycle time (Tcyc_min) violation in %s", mode_string);
    end
    always @ (notify_min_Tkh) begin
        $display ("%t", $realtime, " @@ EMTC_Error: Min clock pulse high time (Tkh_min) violation in %s", mode_string);
    end
    always @ (notify_min_Tkl) begin
        $display ("%t", $realtime, " @@ EMTC_Error: Min clock pulse low time (Tkl_min) violation in %s", mode_string);
    end
    always @ (notify_min_Tas) begin
        $display ("%t", $realtime, " @@ EMTC_Error: Min address setup/hold time (Tas_min/Tah_min) violation in %s", mode_string);
    end
`ifdef EMTC_Timing_Tcyc_IMG_Max
    reg notify_max_Tcyc;
    realtime pclk_rising_edge_time_ini_mgn;
    reg is_check_tcyc_max;
    initial is_check_tcyc_max = 1'b0;
    always @ (posedge PCLK or negedge PCE) begin
        if (!PCE) begin
            is_check_tcyc_max = 1'b0;
        end else if (is_ini_margin_read) begin
            if (is_check_tcyc_max && ($realtime - pclk_rising_edge_time_ini_mgn > `EMTC_Timing_Tcyc_IMG_Max)) begin
                $display ("%t", $realtime, " @@ EMTC_Error: Max cycle time (Tcyc_IMG_max) violation in %s", mode_string);
                if (notify_max_Tcyc === 1'bx)
                    notify_max_Tcyc = 1'b0;
                else
                    notify_max_Tcyc = ~ notify_max_Tcyc;
            end
            pclk_rising_edge_time_ini_mgn = $realtime;
            is_check_tcyc_max = 1'b1;
        end
    end
    always @ (notify_min_Tcyc or notify_min_Tkh or notify_min_Tas or notify_min_Tkl or notify_max_Tcyc) begin
        read_err_flag = 1'b1;
        #0.1;
        read_err_flag = 1'b0;
    end
`else
    always @ (notify_min_Tcyc or notify_min_Tkh or notify_min_Tas or notify_min_Tkl) begin
        read_err_flag = 1'b1;
        #0.1;
        read_err_flag = 1'b0;
    end
`endif

    realtime pwe_falling_time;
    realtime pwe_rising_time;
    realtime pce_falling_time;
    realtime pce_rising_time;
    realtime pprog_falling_time;
    realtime pprog_rising_time;

    always @ (negedge PWE) begin
        pwe_falling_time = $realtime;
    end
    always @ (posedge PWE) begin
        pwe_rising_time = $realtime;
    end
    always @ (negedge PCE) begin
        pce_falling_time = $realtime;
    end
    always @ (posedge PCE) begin
        pce_rising_time = $realtime;
    end
    always @ (negedge PPROG) begin
        pprog_falling_time = $realtime;
    end
    always @ (posedge PPROG) begin
        pprog_rising_time = $realtime;
    end

    reg tcs_max_check;
    always @ (posedge PCE or posedge PPROG) begin
        if (PPROG === 1'b1 && pgm_mode_related)
            tcs_max_check <= #0.1 1'b0;
        else
            tcs_max_check <= #0.1 1'b1;
    end

    // Tpw
    always @ (pwe_falling_time) begin
        if ($realtime > 0 && is_pgm &&  pwe_falling_time - pwe_rising_time > `EMTC_Timing_Tpw_Max)
        begin
            $display ("%t", $realtime, " @@ EMTC_Error: Max program pulse width time (Tpw_max) violation in %s", mode_string);
            -> event_timing_vio;
        end
        if ($realtime > 0 && is_pgm &&  pwe_falling_time - pwe_rising_time < `EMTC_Timing_Tpw_Min)
        begin
            $display ("%t", $realtime, " @@ EMTC_Error: Min program pulse width time (Tpw_Min) violation in %s", mode_string);
            -> event_timing_vio;
        end
    end

    // Tcsp
    always @ (pprog_rising_time) begin
        if (tcs_max_check && $realtime > 0 && is_pgm &&  pprog_rising_time - pce_rising_time > `EMTC_Timing_Tcsp_Max)
        begin
            $display ("%t", $realtime, " @@ EMTC_Error: Max IP enable time (Tcsp) violation in %s", mode_string);
            -> event_timing_vio;
        end
        if ($realtime > 0 && is_pgm &&  pprog_rising_time - pce_rising_time < `EMTC_Timing_Tcsp_Min)
        begin
            $display ("%t", $realtime, " @@ EMTC_Error: Min IP enable time (Tcsp) violation in %s", mode_string);
            -> event_timing_vio;
        end
    end

    reg tpwi_tpps_max_check;
    initial tpwi_tpps_max_check = 1'b0;
    always @ (posedge PPROG or posedge PWE) begin
        if (PWE === 1'b1 && pgm_mode_related)
            tpwi_tpps_max_check <= #0.1 1'b0;
        else
            tpwi_tpps_max_check <= #0.1 1'b1;
    end

    // Tpwi
    always @ (pwe_rising_time) begin
        if (~tpwi_tpps_max_check && $realtime > 0 && is_pgm &&  pwe_rising_time - pwe_falling_time > `EMTC_Timing_Tpwi_Max)
        begin
            $display ("%t", $realtime, " @@ EMTC_Error: Max program pulse interval time (Tpwi) violation in %s", mode_string);
            -> event_timing_vio;
        end
        if ($realtime > 0 && is_pgm &&  pwe_rising_time - pwe_falling_time < `EMTC_Timing_Tpwi_Min)
        begin
            $display ("%t", $realtime, " @@ EMTC_Error: Min program pulse interval time (Tpwi) violation in %s", mode_string);
            -> event_timing_vio;
        end
    end

`ifdef EMTC_Timing_Tcel_Min
    always @ (pce_rising_time) begin
        if ($realtime > 0 && not_power_off && pce_rising_time - pce_falling_time < `EMTC_Timing_Tcel_Min)
        begin
            $display ("%t", $realtime, " @@ EMTC_Error: Min PCE low period time (Tcel) violation");
            Tcel_violation = 1'b1;
            #1;
            Tcel_violation = 1'b0;
        end
    end
`endif

    reg is_pwe_toggle;
    initial is_pwe_toggle = 1'b0;

    always @ (posedge PWE or posedge PPROG) begin
        if (PPROG === 1'b1 && PWE === 1'b0)
            is_pwe_toggle = 1'b0;
        else if (PPROG === 1'b1 && PWE === 1'b1)
            is_pwe_toggle = 1'b1;
        else
            is_pwe_toggle = 1'b0;
    end

    // Tpph
    always @ (pprog_falling_time) begin
        if ($realtime > 0 && is_pgm && is_pwe_toggle && pprog_falling_time - pwe_falling_time > `EMTC_Timing_Tpph_Max)
        begin
            $display ("%t", $realtime, " @@ EMTC_Error : Max program hold time (Tpph) violation in %s", mode_string);
            -> event_timing_vio;
        end
        if ($realtime > 0 && is_pgm && is_pwe_toggle && pprog_falling_time - pwe_falling_time < `EMTC_Timing_Tpph_Min)
        begin
            $display ("%t", $realtime, " @@ EMTC_Error : Min program hold time (Tpph) violation in %s", mode_string);
            -> event_timing_vio;
        end
    end

    // Tppr
    always @ (pce_falling_time) begin
        if ($realtime > 0 && is_pgm &&  pce_falling_time - pprog_falling_time > `EMTC_Timing_Tppr_Max)
        begin
            $display ("%t", $realtime, " @@ EMTC_Error: Max program recovery time (Tppr) violation in %s", mode_string);
            -> event_timing_vio;
        end
        if ($realtime > 0 && is_pgm &&  pce_falling_time - pprog_falling_time < `EMTC_Timing_Tppr_Min)
        begin
            $display ("%t", $realtime, " @@ EMTC_Error: Min program recovery time (Tppr) violation in %s", mode_string);
            -> event_timing_vio;
        end
    end

    // Tpps
    always @ (pwe_rising_time) begin
        if ($realtime > 0 && tpwi_tpps_max_check &&  pwe_rising_time - pprog_rising_time > `EMTC_Timing_Tpps_Max)
        begin
            $display ("%t", $realtime, " @@ EMTC_Error: Max program setup time (Tpps) violation in %s", mode_string);
            -> event_timing_vio;
        end
        if ($realtime > 0 && is_pgm &&  pwe_rising_time - pprog_rising_time < `EMTC_Timing_Tpps_Min)
        begin
            $display ("%t", $realtime, " @@ EMTC_Error: Min program setup time (Tpps) violation in %s", mode_string);
            -> event_timing_vio;
        end
    end

`ifdef EMTC_Pin_PAIO_Length
    always @ (read_mode_related or PAIO)
    begin
        if (read_mode_related)
            if (PAIO !== `EMTC_Pin_PAIO_Length'h0)
            begin
                pgm_fail_mask_output_flag = 1'b1;
                $display ("%t", $realtime, " @@ EMTC_Error: PAIO should be 0 in %s", mode_string);
            end
    end
`endif

    always @ (posedge PPROG) begin
        if (read_mode_related)
            $display ("%t", $realtime, " @@ EMTC_Error : PPROG cannot set High at Read mode.");
    end
    always @ (posedge PWE) begin
        if (read_mode_related)
            $display ("%t", $realtime, " @@ EMTC_Error : PWE cannot set High at Read mode.");
        else if (pgm_mode_related && !program_entry)
            $display ("%t", $realtime, " @@ EMTC_Error : PWE cannot set High while Program not entry.");
    end
    always @ (negedge PCE) begin
        if (PPROG === 1'b1 && pgm_mode_related)
            $display ("%t", $realtime, " @@ EMTC_Error : PCE cannot set Low when PPROG is High at %s", mode_string);
        if (PWE   === 1'b1 && pgm_mode_related)
            $display ("%t", $realtime, " @@ EMTC_Error : PCE cannot set Low when PWE is High at %s", mode_string);
    end

reg clk_reg;
initial clk_reg = 1'b0;
always @(posedge PENCLK or clk_reg)
    if (!PENCLK)
        clk_reg <= 1'b0;
    else
        clk_reg <= #( 50.0 / 2.0) ~clk_reg;
assign PCLKOUT = clk_reg;
/////////////////////////////////////////////////


wire osc00, osc01, osc02, osc03;
wire osc10, osc11, osc12, osc13;
wire osc20, osc21, osc22, osc23;
wire osc30, osc31, osc32, osc33;

defparam osc_00.period = `PERIOD00;
EGP002K32_OSC osc_00 (.enable (PEN_OSC[0]), .osc(osc00));

defparam osc_01.period = `PERIOD01;
EGP002K32_OSC osc_01 (.enable (PEN_OSC[0]), .osc(osc01));

defparam osc_02.period = `PERIOD02;
EGP002K32_OSC osc_02 (.enable (PEN_OSC[0]), .osc(osc02));

defparam osc_03.period = `PERIOD03;
EGP002K32_OSC osc_03 (.enable (PEN_OSC[0]), .osc(osc03));

defparam osc_10.period = `PERIOD10;
EGP002K32_OSC osc_10 (.enable (PEN_OSC[1]), .osc(osc10));

defparam osc_11.period = `PERIOD11;
EGP002K32_OSC osc_11 (.enable (PEN_OSC[1]), .osc(osc11));

defparam osc_12.period = `PERIOD12;
EGP002K32_OSC osc_12 (.enable (PEN_OSC[1]), .osc(osc12));

defparam osc_13.period = `PERIOD13;
EGP002K32_OSC osc_13 (.enable (PEN_OSC[1]), .osc(osc13));

defparam osc_20.period = `PERIOD20;
EGP002K32_OSC osc_20 (.enable (PEN_OSC[2]), .osc(osc20));

defparam osc_21.period = `PERIOD21;
EGP002K32_OSC osc_21 (.enable (PEN_OSC[2]), .osc(osc21));

defparam osc_22.period = `PERIOD22;
EGP002K32_OSC osc_22 (.enable (PEN_OSC[2]), .osc(osc22));

defparam osc_23.period = `PERIOD23;
EGP002K32_OSC osc_23 (.enable (PEN_OSC[2]), .osc(osc23));

defparam osc_30.period = `PERIOD30;
EGP002K32_OSC osc_30 (.enable (PEN_OSC[3]), .osc(osc30));

defparam osc_31.period = `PERIOD31;
EGP002K32_OSC osc_31 (.enable (PEN_OSC[3]), .osc(osc31));

defparam osc_32.period = `PERIOD32;
EGP002K32_OSC osc_32 (.enable (PEN_OSC[3]), .osc(osc32));

defparam osc_33.period = `PERIOD33;
EGP002K32_OSC osc_33 (.enable (PEN_OSC[3]), .osc(osc33));

reg osc0;
always @ (osc00 or osc01 or osc02 or osc03 or POP_OSC0)
begin
    case (POP_OSC0)
        2'b00:
            osc0 = osc00;
        2'b01:
            osc0 = osc01;
        2'b10:
            osc0 = osc02;
        2'b11:
            osc0 = osc03;
    endcase
end
reg osc1;
always @ (osc10 or osc11 or osc12 or osc13 or POP_OSC1)
begin
    case (POP_OSC1)
        2'b00:
            osc1 = osc10;
        2'b01:
            osc1 = osc11;
        2'b10:
            osc1 = osc12;
        2'b11:
            osc1 = osc13;
    endcase
end
reg osc2;
always @ (osc20 or osc21 or osc22 or osc23 or POP_OSC2)
begin
    case (POP_OSC2)
        2'b00:
            osc2 = osc20;
        2'b01:
            osc2 = osc21;
        2'b10:
            osc2 = osc22;
        2'b11:
            osc2 = osc23;
    endcase
end
reg osc3;
always @ (osc30 or osc31 or osc32 or osc33 or POP_OSC3)
begin
    case (POP_OSC3)
        2'b00:
            osc3 = osc30;
        2'b01:
            osc3 = osc31;
        2'b10:
            osc3 = osc32;
        2'b11:
            osc3 = osc33;
    endcase
end

wire POSC0, POSC1, POSC2, POSC3;

assign POSC0 = PEN_OSC[0] ? osc0 : 0;
assign POSC1 = PEN_OSC[1] ? osc1 : 0;
assign POSC2 = PEN_OSC[2] ? osc2 : 0;
assign POSC3 = PEN_OSC[3] ? osc3 : 0;

wire [3:0] POSC;
assign POSC = {POSC3, POSC2, POSC1, POSC0};

wire [15:0] PDOUT_DUMMY;
reg PALARMB_buffer;
assign PDOUT_DUMMY = 16'h0;
assign PAMo  = {2{PALARMB_buffer}};
assign PAMSo = {4{PALARMB_buffer}};
    initial PALARMB_buffer = 1'b0;

    reg alarm_set;
    initial alarm_set = 1'b1;
    wire VDD_group;
    assign VDD_group = VDD & VDD2;

    always @ (negedge VDD_group or posedge PDSTB) begin
        if (PDSTB === 1'b1 && PCE === 1'b1 && (VDD_group === 1'bx || VDD_group === 1'bz))
            alarm_set <= #90 1'b0;
        else
            alarm_set <=  1'b1;
    end

    always @ (negedge alarm_set or PCE or negedge PDSTB) begin
        if (!PDSTB || !PCE)
            PALARMB_buffer = 1'b0;
        else
            PALARMB_buffer = alarm_set;
    end

//===== $timeformat =====//
initial $timeformat (-9, 3, " ns", 0);
endmodule

module EGP002K32_OSC (enable, osc);
input enable;
output osc;
    parameter period = 100;
    reg osc;
    initial osc = 0;
    always @ ( posedge enable or osc )
        if (!enable)
            osc <= 1'b0;
        else
            osc <= #(period / 2.0) ~osc;
endmodule


/**************************************************************/
/*  [START] POWER_SEQ                                         */
/*  MODULE                                                    */
/**************************************************************/
module EGP512X32_PWR (
	PWR_PINS, PDSTB, CTRL_PINS, VSS, power_ready
	);
	input PWR_PINS;
	input PDSTB;
	input CTRL_PINS;
	input VSS;
	output power_ready;
reg power_on_flag;
event event_vio_power_on_flag;
////////////////////////////////////////////////////////////////////////////////////////////////
reg power_short; initial power_short = 0;
always @ ( posedge power_short )
begin
    if ( power_short === 1 && $realtime != 0 )
        $finish;
end
////////////////////////////////////////////////////////////////////////////////////////////////

/**************************************************************/
/*  [START] POWER_SEQ                                         */
/*  POWER_BLOCK                                               */
/**************************************************************/
// 0 power_ready behavioral - POWER
wire power_ready_pwr_pins;
reg pwr_vio_pwr_pins;
initial pwr_vio_pwr_pins = 0;
event event_vio_pwr_pins;
always @ ( event_vio_pwr_pins )
     TOGGLE_TASK (pwr_vio_pwr_pins);

pwr_up_step pwr_pins (
        .pwr_pin        (1'b1),
        .target         (PWR_PINS),
        .timing_vio     (pwr_vio_pwr_pins),
        .pwr_seq_step   (power_ready_pwr_pins)
);
// 1 target rising - POWER
defparam pwr_pins.t = `EMTC_Timing_Tpens_Min;
`define EMTC_EGP512X32_pwr_on_time
assign #`EMTC_Timing_Tpens_Min PWER_PINS_delay = PWR_PINS;
`define EMTC_EGP256X32_pwr_on_time
always @ ( posedge power_ready_pwr_pins )
begin
        if ( power_ready_pwr_pins === 1 && (PWER_PINS_delay === 1'bz || (PWER_PINS_delay === 1'b0 && PDSTB !== 0)) )
        begin
            $display ( "%t ", $realtime, " @@ EMTC_Error : %s cannot set High when %s isn't Low.", "PWR_PINS", "PDSTB");
            -> event_vio_pwr_pins;
        end
        if ( power_ready_pwr_pins === 1 && (PWER_PINS_delay === 1'bz || (PWER_PINS_delay === 1'b0 && CTRL_PINS !== 0)) )
        begin
            $display ( "%t ", $realtime, " @@ EMTC_Error : %s cannot set High when %s isn't Low.", "PWR_PINS", "CTRL_PINS");
            -> event_vio_pwr_pins;
        end

end
// 4 target falling - SIGNAL
always @ ( negedge PWR_PINS )
begin
        if ( power_ready_pwr_pins === 1 && PDSTB !== 0 )
        begin
            $display ( "%t ", $realtime, " @@ EMTC_Error : %s cannot set Low when %s isn't Low.", "PWR_PINS", "PDSTB");
            -> event_vio_pwr_pins;
        end
        if ( power_ready_pwr_pins === 1 && CTRL_PINS !== 0 )
        begin
            $display ( "%t ", $realtime, " @@ EMTC_Error : %s cannot set Low when %s isn't Low.", "PWR_PINS", "CTRL_PINS");
            -> event_vio_pwr_pins;
        end

end

/**************************************************************/
/*  [END] POWER_SEQ                                           */
/*  POWER_BLOCK                                               */
/**************************************************************/




/**************************************************************/
/*  [START] POWER_SEQ                                         */
/*  SIGNAL_BLOCK                                              */
/**************************************************************/
// 0 power_ready behavioral - SIGNAL (not last signal)
wire power_ready_pdstb;
reg pwr_vio_pdstb;
initial pwr_vio_pdstb = 0;
event event_vio_pdstb;
always @ ( event_vio_pdstb )
    TOGGLE_TASK (pwr_vio_pdstb);

pwr_up_step pdstb (
        .pwr_pin        (power_ready_pwr_pins),
        .target         (PDSTB),
        .timing_vio     (pwr_vio_pdstb),
        .pwr_seq_step   (power_ready_pdstb));
// 1 target rising - SIGNAL
always @ ( posedge power_ready_pdstb )
begin
        if ( power_ready_pdstb === 1 && CTRL_PINS !== 0 )
        begin
            $display ( "%t ", $realtime, " @@ EMTC_Error : %s cannot set High when %s isn't Low.", "PDSTB", "CTRL_PINS");
            -> event_vio_pdstb;
        end

end
// 2. timing check - SIGNAL
/* **** DEBUG **** signal/210_loop.inc */

// 2 timing check
reg notify_tpens_min, notify_tpenh_min;

specify
    $setuphold ( posedge PDSTB, posedge PWR_PINS &&& power_on_flag, `EMTC_Timing_Tpens_Min , 0, notify_tpens_min );
    $setuphold ( negedge PDSTB, negedge PWR_PINS &&& power_on_flag, 0, `EMTC_Timing_Tpenh_Min, notify_tpenh_min );
endspecify
always @ ( notify_tpens_min )
begin
    $display ( "%t ", $realtime, " @@ EMTC_Violation : %s is Illegal.", "Tpens_Min" );
    -> event_vio_pdstb;
end
always @ ( notify_tpenh_min )
begin
    $display ( "%t ", $realtime, " @@ EMTC_Violation : %s is Illegal.", "Tpenh_Min" );
    -> event_vio_pdstb;
end

// 4 target falling - SIGNAL
always @ ( negedge PDSTB )
begin
        if ( power_ready_pdstb === 1 && CTRL_PINS !== 0 )
        begin
            $display ( "%t ", $realtime, " @@ EMTC_Error : %s cannot set Low when %s isn't Low.", "PDSTB", "CTRL_PINS");
            -> event_vio_pdstb;
        end

end
// 0 power_ready behavioral - SIGNAL (last signal)
reg power_ready_ctrl_pins;
reg pwr_vio_ctrl_pins;
event event_vio_ctrl_pins;
always @ ( event_vio_ctrl_pins )
    TOGGLE_TASK (pwr_vio_ctrl_pins);
reg reg_ctrl_pins;
always @ ( CTRL_PINS )
begin
    if ( CTRL_PINS === 1 )
        reg_ctrl_pins = 1;
    else if ( CTRL_PINS === 0 )
        reg_ctrl_pins = 0;
end
always @ ( power_ready_pdstb or negedge reg_ctrl_pins or pwr_vio_ctrl_pins)
begin
    if ( power_ready_pdstb === 1 && CTRL_PINS === 0 )
        power_ready_ctrl_pins = 1;
    else
        power_ready_ctrl_pins = 0;
end
// 2. timing check - SIGNAL
/* **** DEBUG **** signal/210_loop.inc */

// 2 timing check
reg notify_tsas_min, notify_tash_min;

specify
    $setuphold ( posedge CTRL_PINS, posedge PDSTB &&& power_on_flag, `EMTC_Timing_Tsas_Min , 0, notify_tsas_min );
    $setuphold ( negedge CTRL_PINS, negedge PDSTB &&& power_on_flag, 0, `EMTC_Timing_Tash_Min, notify_tash_min );
endspecify
always @ ( notify_tsas_min )
begin
    $display ( "%t ", $realtime, " @@ EMTC_Violation : %s is Illegal.", "Tsas_Min" );
    -> event_vio_ctrl_pins;
end
always @ ( notify_tash_min )
begin
    $display ( "%t ", $realtime, " @@ EMTC_Violation : %s is Illegal.", "Tash_Min" );
    -> event_vio_ctrl_pins;
end

// 3 Below Target Check - SIGNAL
always @ ( posedge CTRL_PINS )
begin
    if ( power_ready_pwr_pins === 1 && PDSTB !== 1 )
    begin
        $display ( "%t ", $realtime, " @@ EMTC_Error : %s cannot set High when %s isn't High.","CTRL_PINS", "PDSTB");
        -> event_vio_pwr_pins;
    end

end

/**************************************************************/
/*  [END] POWER_SEQ                                           */
/*  SIGNAL_BLOCK                                              */
/**************************************************************/


assign power_ready = power_ready_ctrl_pins;

// virtual power
    `ifdef EMTC_EGP512X32_pwr_on_time
        parameter power_on_time = 0;
    `else
        parameter power_on_time = 1000;
    //===== VIRTUAL POWER DEFINE =====//
    // 1 target rising
    always @ ( posedge power_on_flag )
    begin
            if ( power_on_flag === 1 && PDSTB !== 0 )
            begin
                $display ( "%t ", $realtime, " @@ EMTC_Error : %s should be set Low.\n If this is initial reset issue ( input pin from unknwon to Low status ). Please modify \"%m.power_on_time\" after reset time. You can use command \"defparam\" to modify it in top module. ", "PDSTB");
                -> event_vio_pdstb;
            end
            if ( power_on_flag === 1 && CTRL_PINS !== 0 )
            begin
                $display ( "%t ", $realtime, " @@ EMTC_Error : %s should be set Low.\n If this is initial reset issue ( input pin from unknwon to Low status ). Please modify \"%m.power_on_time\" after reset time. You can use command \"defparam\" to modify it in top module. ", "CTRL_PINS");
                -> event_vio_ctrl_pins;
            end

    end
    `endif
    initial
    begin
        power_on_flag <=#0 0;
        power_on_flag <=#power_on_time 1;
    end



/**************************************************************/
/*  [START] POWER_SEQ                                         */
/*  GROUND_BLOCK                                              */
/**************************************************************/
// 0 power_ready behavioral - GROUND
    always @ ( VSS )
    begin
        if ( VSS !== 0 && $realtime != 0 )
        begin
            $display ( "%t ", $realtime, " @@ EMTC_Error : %s should be set ground level", "VSS" );
            power_short = 1;
        end
    end
// 1 target rising - GROUND

    always @ ( posedge PWR_PINS )
    begin
            if ( VSS !== 0 && $realtime != 0 )
            begin
                $display ( "%t ", $realtime, " @@ EMTC_Error : %s should be set ground level when %s rising.", "VSS", "PWR_PINS" );
                power_short = 1;
            end
    end


    always @ ( posedge PDSTB )
    begin
            if ( VSS !== 0 && $realtime != 0 )
            begin
                $display ( "%t ", $realtime, " @@ EMTC_Error : %s should be set ground level when %s rising.", "VSS", "PDSTB" );
                power_short = 1;
            end
    end
    always @ ( posedge CTRL_PINS )
    begin
            if ( VSS !== 0 && $realtime != 0 )
            begin
                $display ( "%t ", $realtime, " @@ EMTC_Error : %s should be set ground level when %s rising.", "VSS", "CTRL_PINS" );
                power_short = 1;
            end
    end

/**************************************************************/
/*  [END] POWER_SEQ                                           */
/*  GROUND_BLOCK                                              */
/**************************************************************/



/**************************************************************/
/*  [START] POWER_SEQ                                         */
/*  TOGGLE_TASK_BLOCK                                         */
/**************************************************************/
    //===== TOGGLE_TASK =====//
    task TOGGLE_TASK;
        inout A;
	    if ( A === 1'bx )
	    	A = 0;
	    else
	    	A = ~A;
    endtask
    //===== $timeformat =====//
    initial $timeformat (-9, 3, " ns", 0);
/**************************************************************/
/*  [END] POWER_SEQ                                           */
/*  TOGGLE_TASK_BLOCK                                         */
/**************************************************************/

endmodule

//===== Power Sequence Sub Module =====//
module pwr_up_step (pwr_pin, target, timing_vio, pwr_seq_step);
    input  pwr_pin;
    input  target;
    input  timing_vio;
    output pwr_seq_step;
    reg pwr_seq_step; initial pwr_seq_step = 0;
    reg pwr_seq_rst;  initial pwr_seq_rst = 0;
    parameter t = 1;

    time time_target_rising;    initial time_target_rising    = 'hx;   
    time time_target_rising_dt; initial time_target_rising_dt = 'hx;
    always @ ( posedge target or posedge pwr_seq_rst )begin
        if ( pwr_seq_rst === 1 ) begin
            time_target_rising = 'hx;
        end
        else begin
            time_target_rising    <= #0 $time;
            if ( t < 1 )
                time_target_rising_dt <= #0 $time;
            else
                time_target_rising_dt <= #(t - 1) $time;
        end
    end
    //always @ (posedge target or posedge pwr_seq_rst) begin
    always @ ( time_target_rising_dt or posedge pwr_seq_rst) begin
        if (pwr_seq_rst)
            pwr_seq_step <= 1'b0;
        else if (pwr_pin === 1'b1 && target === 1'b1 && time_target_rising == time_target_rising_dt )
            pwr_seq_step <= 1'b1;
        else
            pwr_seq_step <= 1'b0;
    end
    always @ (negedge pwr_pin or negedge target or timing_vio) begin
       if ($realtime > 0) begin
          if ( time_target_rising == time_target_rising_dt && target === 1 ) begin
            #1;
          end
            pwr_seq_rst = 1'b1;
            #1;
            pwr_seq_rst = 1'b0;
        end
    end

endmodule
// end of module EGP512X32_PWR
/**************************************************************/
/*  [END] POWER_SEQ                                           */
/*  MODULE                                                    */
/**************************************************************/


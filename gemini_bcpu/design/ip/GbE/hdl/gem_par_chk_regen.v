//------------------------------------------------------------------------------
// Copyright (c) 2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_par_chk_regen.v
//   Module Name:        gem_par_chk_regen
//
//   Release Revision:   r1p12
//   Release SVN Tag:    gem_gxl_det0102_r1p12
//
//   IP Name:            GEM Gigabit Ethernet MAC
//   IP Part Number:     IP7014
//
//   Product Type:       Off-the-shelf
//   IP Type:            Soft
//   IP Family:          Ethernet Controller
//   Technology:         N/A
//   Protocol:           Ethernet
//   Architecture:       N/A
//   Licensable IP:      SIP-Ethernet-MAC+DMA+1588+TSN+PCS-10M/100M/1G-IP7014
//
//------------------------------------------------------------------------------
//   Description    : Check parity of incoming data and generate new parity of
//                    input. Useful for cases where either a bus is being
//                    transformed in some way or if multiple inputs are
//                    combined to form a new output.
//                    If there is a parity error on the check buses then the
//                    new generated parity is 'poisoned'.
//
//------------------------------------------------------------------------------


module gem_par_chk_regen #(
  parameter p_chk_dwid  = 32,
  parameter p_chk_pwid  = (p_chk_dwid+7)/8,
  parameter p_new_dwid  = p_chk_dwid,
  parameter p_new_pwid  = (p_new_dwid+7)/8
)(
  input                     odd_par,    // Select odd or even parity
  input   [p_chk_dwid-1:0]  chk_dat,    // Data to check
  input   [p_chk_pwid-1:0]  chk_par,    // Parity to check
  input   [p_new_dwid-1:0]  new_dat,    // New data to compute parity for
  output  [p_new_dwid-1:0]  dat_out,    // Feed through of new_dat
  output  [p_new_pwid-1:0]  par_out,    // New parity
  output                    chk_err     // There was parity error on check data
);

  wire  [p_new_pwid-1:0]  new_par_int;  // New generated parity

  // Instantiate parity checker
  cdnsdru_asf_parity_check_v1 #(
    .p_data_width (p_chk_dwid),
    .p_num_par    (p_chk_pwid)
  ) i_par_chk (
    .odd_par    (odd_par),
    .data_in    (chk_dat),
    .parity_in  (chk_par),
    .parity_err (chk_err)
  );

  // Generate new parity
  cdnsdru_asf_parity_gen_v1 #(
    .p_data_width (p_new_dwid),
    .p_num_par    (p_new_pwid)
  ) i_par_gen (
    .odd_par    (odd_par),
    .data_in    (new_dat),
    .data_out   (dat_out),
    .parity_out (new_par_int)
  );

  // Poison parity if there was an error on the check buses
  assign par_out  = chk_err ? ~new_par_int  : new_par_int;

endmodule

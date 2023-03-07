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
//   Filename:           edma_arith_par.v
//   Module Name:        edma_arith_par
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
//   Description    : Generic increment/decrement module that takes in two
//                    input values and subtract or decrements as instructed.
//                    If configured to have parity, then the parity is checked
//                    for the incoming data and regenerated for the output.
//                    If the incoming parity detects an error, the outgoing
//                    parity is poisoned.
//
//------------------------------------------------------------------------------


module edma_arith_par #(
  parameter p_dwidth  = 32,
  parameter p_pwidth  = (p_dwidth + 7)/8,
  parameter p_has_par = 1'b0
)(
  input   [p_dwidth-1:0]  in_val,   // Input data to operate on
  input   [p_pwidth-1:0]  in_par,   // Corresponding parity
  input   [p_dwidth-1:0]  op_val,   // Value to apply to in_val
  input                   op_add,   // Add op_val if 1, otherwise decrement
  output  [p_dwidth-1:0]  out_val,  // Output value
  output  [p_pwidth-1:0]  out_par   // Corresponding parity
);

  wire  [p_dwidth:0]    add_val;    // Value if addition
  wire  [p_dwidth:0]    sub_val;    // Value if subtraction
  wire  [p_dwidth-1:0]  int_val;    // Internal value after operation

  assign add_val  = in_val + op_val;
  assign sub_val  = in_val - op_val;

  // Select based on op_add
  assign int_val  = op_add  ? add_val[p_dwidth-1:0]
                            : sub_val[p_dwidth-1:0];

  // Optional parity handling
  generate if (p_has_par == 1) begin : gen_par
    wire                  in_par_err; // Parity check error on input data
    wire  [p_pwidth-1:0]  new_par;    // Re-generated parity

    // First check the input parity
    cdnsdru_asf_parity_check_v1 #(.p_data_width(p_dwidth)) i_par_chk (
      .odd_par    (1'b0),
      .data_in    (in_val),
      .parity_in  (in_par),
      .parity_err (in_par_err)
    );

    // Regenerate parity
    cdnsdru_asf_parity_gen_v1 #(.p_data_width(p_dwidth)) i_gen_par (
      .odd_par    (1'b0),
      .data_in    (int_val),
      .data_out   (),
      .parity_out (new_par)
    );

    // Poison output parity if input had error
    assign out_par  = in_par_err  ? ~new_par  : new_par;
  end else begin : gen_no_par
    assign out_par  = {p_pwidth{1'b0}};
  end
  endgenerate

  assign out_val  = int_val;

endmodule

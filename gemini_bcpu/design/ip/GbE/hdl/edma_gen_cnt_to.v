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
//   Filename:           edma_gen_cnt_to.v
//   Module Name:        edma_gen_cnt_to
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
//   Description    : Generic counter and timeout module.
//                    Keeps count of packets/transactions in flight and generate
//                    a timeout if there is no decrement within a set time.
//
//------------------------------------------------------------------------------


module edma_gen_cnt_to #(
  parameter p_cnt_wid = 8,
  parameter p_to_wid  = 16
)(
  input                      clock,        // Generic input clock
  input                      reset_n,      // Asynchronous reset
  input       [p_to_wid-1:0] timeout_val,  // Number of cycles to count
  input                      enable,       // Synchronous enable
  input                      timer_cnt_en, // Prescaler for timer
  input                      cnt_inc,      // Increment counter
  input                      cnt_dec,      // Decrement counter
  output reg [p_cnt_wid-1:0] count,        // Count value
  output                     to_err        // Timeout error

);

  // Internals
  wire  [p_cnt_wid-1:0] count_m1;     // Counter -1
  wire  [p_cnt_wid-1:0] count_p1;     // Counter +1
  wire                  count_max;    // At max count
  wire                  count_zero;   // Counter zero
  wire                  to_cnt_en;    // Enable timer
  wire                  to_cnt_rst;   // Clear timer
  wire                  trans_to;

  // Count number of outstanding transactions/packets
  always@(posedge clock or negedge reset_n)
  begin
    if (~reset_n)
      count <= {p_cnt_wid{1'b0}};
    else
      if (~enable)
        count <= {p_cnt_wid{1'b0}};
      else
        case ({cnt_inc,cnt_dec})
          2'b01   : count <= count_m1;
          2'b10   : count <= count_p1;
          default : count <= count;
        endcase
  end

  assign count_max  = &count;
  assign count_zero = ~(|count);
  
  // count cannot overflow or underflow because the increment on count_m1 and count_p1
  // is conditioned to count_max and count_zero signals. For this reason we will never 
  // need any extra MSB on the result of the operations.
  assign count_m1 = count_zero  ? count
                                : count - {{(p_cnt_wid-1){1'b0}},1'b1};
  assign count_p1 = count_max   ? count
                                : count + {{(p_cnt_wid-1){1'b0}},1'b1};

  // Start the timer whenever anything is outstanding
  assign to_cnt_en  = |count;

  // Reset the timer if module is disabled or we are reducing the count
  // Note that the reset is assumed to have highest priority.
  assign to_cnt_rst = cnt_dec;

  // Instantiate the re-use module for the timer function
  cdnsdru_asf_trans_timeout_v1 #(.p_count_width(p_to_wid)) i_to_timer (
    .clock          (clock),
    .reset_n        (reset_n),
    .timeout_val    (timeout_val),
    .enable         (enable),
    .timer_cnt_en   (timer_cnt_en),
    .trans_req      (to_cnt_en),
    .trans_resp     (to_cnt_rst),
    .trans_timeout  (trans_to)
  );

  // Error is signalled when trans_to or when a decrement is requested
  // when internal count is 0.
  assign to_err = trans_to | (enable &  cnt_dec & ~cnt_inc & count_zero);

endmodule

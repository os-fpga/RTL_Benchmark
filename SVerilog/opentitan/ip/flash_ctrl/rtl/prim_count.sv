// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Primitive hardened counter module
//
// This module implements two styles of hardened counting
// 1. Duplicate count
//    There are two copies of the relevant counter and they are constantly compared.
// 2. Cross count
//    There is an up count and a down count, and the combined value must always
//    combine to the same value.
//
// This counter supports a generic clr / set / en interface, where
// clr_i and set_i MUST NOT be set at the same time!
//
// In duplicate count mode
//    - clr_i sets all (internal) counters to 0.
//    - set_i sets the up_count's starting value to set_cnt_i.
//      Note: the maximum value is just the max possible value given by the counter's width.
//    - en_i increments the counter by step_i, if neither of the above is set.
//
// In cross count mode
//    - clr_i sets all (internal) counters to 0. This means:
//      -- down_count is halted until set_i is set again
//         Note: The up_count is still running.
//      -- err_o is set to 0 (false),
//      -- cnt_o is either all zero (OutSelDnCnt = 1) or the (running) up_count value
//         (OutSelDnCnt = 0).
//    - set_i sets
//      -- the up_count to 0 and the down_count to set_cnt_i,
//      -- the up_count's maximum value to set_cnt_i.
//    - en_i increments/decrements the up_count/down_count by step_i, if neither of the above is
//      set.

module prim_count import prim_count_pkg::*; #(
  parameter int Width = 2,
  parameter bit OutSelDnCnt = 1, // 0 selects up count
  parameter prim_count_style_e CntStyle = CrossCnt, // DupCnt or CrossCnt
  // This should only be disabled in special circumstances, for example
  // in non-comportable IPs where an error does not trigger an alert.
  parameter bit EnableAlertTriggerSVA = 1
) (
  input clk_i,
  input rst_ni,
  input clr_i,
  input set_i,
  input [Width-1:0] set_cnt_i,
  input en_i,
  input [Width-1:0] step_i, // increment/decrement step when enabled
  output logic [Width-1:0] cnt_o,
  output logic err_o
);

  // if output selects down count, it MUST be the cross count style

  localparam int CntCopies = (CntStyle == DupCnt) ? 2 : 1;

  // clear up count whenever there is an explicit clear, or
  // when the max value is re-set during cross count.
  logic clr_up_cnt;
  assign clr_up_cnt = clr_i |
                      (set_i & (CntStyle == CrossCnt));

  // set up count to desired value only during duplicate counts.
  logic set_up_cnt;
  assign set_up_cnt = set_i & (CntStyle == DupCnt);

  logic [CntCopies-1:0][Width-1:0] up_cnt_d, up_cnt_d_buf;
  logic [CntCopies-1:0][Width-1:0] up_cnt_q;
  logic [Width-1:0] max_val;
  logic err;

  if (CntStyle == CrossCnt) begin : gen_crosscnt_max_val
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        max_val <= '1;
      end else if (clr_i) begin
        max_val <= '1;
      end else if (set_i) begin
        max_val <= set_cnt_i;
      end
    end
  end else begin : gen_dupcnt_max_val
     assign max_val = '1;
  end

  for (genvar i = 0; i < CntCopies; i++) begin : gen_cnts
    // up-count
    assign up_cnt_d[i] = (clr_up_cnt)                     ? '0 :
                         (set_up_cnt)                     ? set_cnt_i :
                         (en_i & (up_cnt_q[i] < max_val)) ? up_cnt_q[i] + step_i :
                                                          up_cnt_q[i];

    prim_buf #(
      .Width(Width)
    ) u_buf (
      .in_i(up_cnt_d[i]),
      .out_o(up_cnt_d_buf[i])
    );

    prim_flop #(
      .Width(Width),
      .ResetValue('0)
    ) u_cnt_flop (
      .clk_i,
      .rst_ni,
      .d_i(up_cnt_d_buf[i]),
      .q_o(up_cnt_q[i])
    );
  end

  if (CntStyle == CrossCnt) begin : gen_cross_cnt_hardening
    logic [Width-1:0] down_cnt;
    logic [Width-1:0] sum;

    // down-count
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        down_cnt <= '{default: '1};
      end else if (clr_i) begin
        down_cnt <= '{default: '1};
      end else if (set_i) begin
        down_cnt <= set_cnt_i;
      end else if (en_i && (down_cnt > '0)) begin
        down_cnt <= down_cnt - step_i;
      end
    end

    logic msb;
    assign {msb, sum} = down_cnt + up_cnt_q[0];
    assign cnt_o = OutSelDnCnt ? down_cnt : up_cnt_q[0];
    assign err   = (max_val != sum) | msb;


    // Up counter assumption to control overflow
      logic [Width:0] unused_cnt;
      assign unused_cnt = up_cnt_q[0] + step_i;
      logic unused_incr_cnt;
      assign unused_incr_cnt = !clr_i & !set_i & en_i;

   
  end else if (CntStyle == DupCnt) begin : gen_dup_cnt_hardening
    // duplicate count compare is always valid
    assign cnt_o = up_cnt_q[0];
    assign err   = (up_cnt_q[0] != up_cnt_q[1]);

   end

  assign err_o = err;

  endmodule // prim_count


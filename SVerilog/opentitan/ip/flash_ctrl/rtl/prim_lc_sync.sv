// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Double-synchronizer flop for life cycle control signals with additional
// output buffers and life-cycle specific assertions.
//
// Should be used exactly as recommended in the life cycle controller spec:
// https://docs.opentitan.org/hw/ip/lc_ctrl/doc/index.html#control-signal-propagation


module prim_lc_sync #(
  // Number of separately buffered output signals.
  // The buffer cells have a don't touch constraint
  // on them such that synthesis tools won't collapse
  // all copies into one signal.
  parameter int NumCopies = 1
) (
  input                                       clk_i,
  input                                       rst_ni,
  input  lc_ctrl_pkg::lc_tx_t                 lc_en_i,
  output lc_ctrl_pkg::lc_tx_t lc_en_o
);


  logic [lc_ctrl_pkg::TxWidth-1:0] lc_en;
  prim_flop_2sync #(
    .Width(lc_ctrl_pkg::TxWidth),
    .ResetValue(lc_ctrl_pkg::TxWidth'(lc_ctrl_pkg::Off))
  ) u_prim_flop_2sync (
    .clk_i,
    .rst_ni,
    .d_i(lc_en_i),
    .q_o(lc_en)
  );

  for (genvar j = 0; j < NumCopies; j++) begin : gen_buffs
    logic [lc_ctrl_pkg::TxWidth-1:0] lc_en_out;
    for (genvar k = 0; k < lc_ctrl_pkg::TxWidth; k++) begin : gen_bits
      prim_buf u_prim_buf (
        .in_i(lc_en[k]),
        .out_o(lc_en_out[k])
      );
    end
    assign lc_en_o[j] = lc_ctrl_pkg::lc_tx_t'(lc_en_out);
  end

 
endmodule : prim_lc_sync

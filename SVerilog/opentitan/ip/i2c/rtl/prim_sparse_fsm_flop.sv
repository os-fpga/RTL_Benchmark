// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0


module prim_sparse_fsm_flop #(
  parameter type              StateEnumT = logic,
  parameter int               Width      = 1,
  parameter logic [Width-1:0] ResetValue = 0,
  // This should only be disabled in special circumstances, for example
  // in non-comportable IPs where an error does not trigger an alert.
  parameter bit               EnableAlertTriggerSVA = 1
) (
  input                    clk_i,
  input                    rst_ni,
  input        [Width-1:0] state_i,
  output logic [Width-1:0] state_o
);

  logic unused_valid_st;

  prim_flop #(
    .Width(Width),
    .ResetValue(ResetValue)
  ) u_state_flop (
    .clk_i,
    .rst_ni,
    .d_i(state_i),
    .q_o(state_o)
  );
endmodule

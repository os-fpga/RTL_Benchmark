// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Common Library: Clock Gating cell

module prim_generic_clock_gating #(
  parameter bit NoFpgaGate = 1'b0 // this parameter has no function in generic
) (
  input        clk_i,
  input        en_i,
  input        test_en_i,
  output logic clk_o
);

  // Assume en_i synchronized, if not put synchronizer prior to en_i
`ifdef ASIC
logic en_latch;
  always_latch begin
    if (!clk_i) begin
      en_latch = en_i | test_en_i;
    end
  end
  assign clk_o = en_latch & clk_i;
`else
  logic en;
  assign en = en_i | test_en_i;
  assign clk_o = en & clk_i;
`endif

endmodule

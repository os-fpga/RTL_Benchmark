// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

module prim_generic_rom #(
  parameter  int Width     = 32,
  parameter  int Depth     = 2048, // 8kB default
  parameter  int Aw        = $clog2(Depth)
) (
  input                        clk_i,
  input                        rst_ni,
  input        [Aw-1:0]        addr_i,
  input                        cs_i,
  output logic [Width-1:0]     dout_o,
  output logic                 dvalid_o
);

  logic [Width-1:0] mem [Depth];

  always_ff @(posedge clk_i) begin
    if (cs_i) begin
      dout_o <= mem[addr_i];
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      dvalid_o <= 1'b0;
    end else begin
      dvalid_o <= cs_i;
    end
  end

  
endmodule

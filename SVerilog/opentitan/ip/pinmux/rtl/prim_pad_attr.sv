// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

// This file is auto-generated.

`ifndef PRIM_DEFAULT_IMPL
  `define PRIM_DEFAULT_IMPL prim_pkg::ImplGeneric
`endif

// This is to prevent AscentLint warnings in the generated
// abstract prim wrapper. These warnings occur due to the .*
// use. TODO: we may want to move these inline waivers
// into a separate, generated waiver file for consistency.
//ri lint_check_off OUTPUT_NOT_DRIVEN INPUT_NOT_READ
module prim_pad_attr
import prim_pad_wrapper_pkg::*;
#(

  parameter pad_type_e PadType = BidirStd // currently ignored in the generic model

) (
  output pad_attr_t attr_warl_o
);
  parameter prim_pkg::impl_e Impl = `PRIM_DEFAULT_IMPL;

if (Impl == prim_pkg::ImplXilinx) begin : gen_xilinx
    prim_xilinx_pad_attr #(
      .PadType(PadType)
    ) u_impl_xilinx (
      .*
    );
end else begin : gen_generic
    prim_generic_pad_attr #(
      .PadType(PadType)
    ) u_impl_generic (
      .*
    );
end

endmodule
//ri lint_check_on OUTPUT_NOT_DRIVEN INPUT_NOT_READ 

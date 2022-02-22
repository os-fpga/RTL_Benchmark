// Copyright (C) 2020-2021  The SymbiFlow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier:ISC

(* blackbox *)
module qlal4s3_mult_32x32_cell (
    input  [31:0] Amult,
    input  [31:0] Bmult,
    input  [ 1:0] Valid_mult,
    output [63:0] Cmult
);

endmodule  /* qlal4s3_32x32_mult_cell */

(* blackbox *)
module qlal4s3_mult_16x16_cell (
    input  [15:0] Amult,
    input  [15:0] Bmult,
    input         Valid_mult,
    output [31:0] Cmult
);

endmodule  /* qlal4s3_16x16_mult_cell */


/* Verilog model of QLAL4S3 Multiplier */
/*qlal4s3_mult_cell*/
module signed_mult (
    A,
    B,
    Valid,
    C
);

  parameter WIDTH = 32;
  parameter CWIDTH = 2 * WIDTH;

  input [WIDTH-1:0] A, B;
  input Valid;
  output [CWIDTH-1:0] C;

  reg signed [WIDTH-1:0] A_q, B_q;
  wire signed [CWIDTH-1:0] C_int;

  assign C_int = A_q * B_q;
  assign valid_int = Valid;
  assign C = C_int;

  always @(*) if (valid_int == 1'b1) A_q <= A;

  always @(*) if (valid_int == 1'b1) B_q <= B;

endmodule


module qlal4s3_mult_cell_macro (
    Amult,
    Bmult,
    Valid_mult,
    sel_mul_32x32,
    Cmult
);

  input [31:0] Amult;
  input [31:0] Bmult;
  input [1:0] Valid_mult;
  input sel_mul_32x32;
  output [63:0] Cmult;

  wire [15:0] A_mult_16_0;
  wire [15:0] B_mult_16_0;
  wire [31:0] C_mult_16_0;
  wire [15:0] A_mult_16_1;
  wire [15:0] B_mult_16_1;
  wire [31:0] C_mult_16_1;
  wire [31:0] A_mult_32;
  wire [31:0] B_mult_32;
  wire [63:0] C_mult_32;
  wire        Valid_mult_16_0;
  wire        Valid_mult_16_1;
  wire        Valid_mult_32;


  assign Cmult           = sel_mul_32x32 ? C_mult_32 : {C_mult_16_1, C_mult_16_0};

  assign A_mult_16_0     = sel_mul_32x32 ? 16'h0 : Amult[15:0];
  assign B_mult_16_0     = sel_mul_32x32 ? 16'h0 : Bmult[15:0];
  assign A_mult_16_1     = sel_mul_32x32 ? 16'h0 : Amult[31:16];
  assign B_mult_16_1     = sel_mul_32x32 ? 16'h0 : Bmult[31:16];

  assign A_mult_32       = sel_mul_32x32 ? Amult : 32'h0;
  assign B_mult_32       = sel_mul_32x32 ? Bmult : 32'h0;

  assign Valid_mult_16_0 = sel_mul_32x32 ? 1'b0 : Valid_mult[0];
  assign Valid_mult_16_1 = sel_mul_32x32 ? 1'b0 : Valid_mult[1];
  assign Valid_mult_32   = sel_mul_32x32 ? Valid_mult[0] : 1'b0;

  signed_mult #(
      .WIDTH(16)
  ) u_signed_mult_16_0 (
      .A    (A_mult_16_0),  //I: 16 bits
      .B    (B_mult_16_0),  //I: 16 bits
      .Valid(Valid_mult_16_0),  //I
      .C    (C_mult_16_0)  //O: 32 bits
  );

  signed_mult #(
      .WIDTH(16)
  ) u_signed_mult_16_1 (
      .A    (A_mult_16_1),  //I: 16 bits
      .B    (B_mult_16_1),  //I: 16 bits
      .Valid(Valid_mult_16_1),  //I
      .C    (C_mult_16_1)  //O: 32 bits
  );

  signed_mult #(
      .WIDTH(32)
  ) u_signed_mult_32 (
      .A    (A_mult_32),  //I: 32 bits
      .B    (B_mult_32),  //I: 32 bits
      .Valid(Valid_mult_32),  //I
      .C    (C_mult_32)  //O: 64 bits
  );

endmodule
/*qlal4s3_mult_cell*/



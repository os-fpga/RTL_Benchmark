module IBUFG(
    output O,
    (* iopad_external_pin *)
    input I);
  parameter CAPACITANCE = "DONT_CARE";
  parameter IBUF_DELAY_VALUE = "0";
  parameter IBUF_LOW_PWR = "TRUE";
  parameter IOSTANDARD = "DEFAULT";
  assign O = I;
endmodule



module IBUF(
    output O,
    (* iopad_external_pin *)
    input I);
  parameter IOSTANDARD = "default";
  parameter IBUF_LOW_PWR = 0;
  assign O = I;
  specify
    (I => O) = 0;
  endspecify
endmodule



module BUFG(
    (* clkbuf_driver *)
    output O,
    input I);
  assign O = I;
  specify
    // https://github.com/SymbiFlow/prjxray-db/blob/4bc6385ab300b1819848371f508185f57b649a0e/artix7/timings/CLK_BUFG_TOP_R.sdf#L11
    (I => O) = 96;
  endspecify
endmodule





module SRL16 (
  output Q,
  input A0, A1, A2, A3,
  (* clkbuf_sink *)
  input CLK,
  input D
);
  parameter [15:0] INIT = 16'h0000;

  reg [15:0] r = INIT;
  assign Q = r[{A3,A2,A1,A0}];
  always @(posedge CLK) r <= { r[14:0], D };

  specify
    // Max delay from: https://github.com/SymbiFlow/prjxray-db/blob/34ea6eb08a63d21ec16264ad37a0a7b142ff6031/artix7/timings/CLBLM_R.sdf#L905
    (posedge CLK => (Q : 1'bx)) = 1472;
    // Max delay from: https://github.com/SymbiFlow/prjxray-db/blob/34ea6eb08a63d21ec16264ad37a0a7b142ff6031/artix7/timings/CLBLM_R.sdf#L912
    $setup(D , posedge CLK, 173);
    (A0 => Q) = 631;
    (A1 => Q) = 472;
    (A2 => Q) = 407;
    (A3 => Q) = 238;
  endspecify
endmodule




module OBUF(
    (* iopad_external_pin *)
    output O,
    input I);
  parameter IOSTANDARD = "default";
  parameter DRIVE = 12;
  parameter SLEW = "SLOW";
  assign O = I;
  specify
    (I => O) = 0;
  endspecify
endmodule
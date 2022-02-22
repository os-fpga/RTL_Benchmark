module bipad (
    input  A,
    input  EN,
    output Q,
    (* iopad_external_pin *)
    inout  P
);
  assign Q = P;
  assign P = EN ? A : 1'bz;
endmodule

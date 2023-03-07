module dti_clkinv
(
  input         CKIN,
  output        CKOUT
);

assign CKOUT = ~CKIN;

endmodule
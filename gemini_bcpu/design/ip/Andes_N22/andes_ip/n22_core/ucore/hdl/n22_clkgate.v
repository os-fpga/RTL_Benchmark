
`include "global.inc"

module n22_clkgate (
  input   clk_in,
  input   clkgate_bypass,
  input   clock_en,
  output  clk_out
);



reg enb;

always@(*)
  if (!clk_in)
    enb <= (clock_en | clkgate_bypass);

assign clk_out = enb & clk_in;


endmodule



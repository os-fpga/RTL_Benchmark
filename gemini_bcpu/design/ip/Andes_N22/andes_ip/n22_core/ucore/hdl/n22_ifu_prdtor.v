
`include "global.inc"

`ifdef N22_HAS_DYNAMIC_BPU
module n22_ifu_prdtor(
  input csr_bpu_enable,

  input updt_ena,
  input updt_take,

  output prdt_take,

  input  clk,
  input  rst_n
  );

  wire [1:0] s0;

  wire s1 = (s0 == 2'b00);
  wire s2 = (s0 == 2'b01);
  wire s3 = (s0 == 2'b10);
  wire s4 = (s0 == 2'b11);


  wire s5 = csr_bpu_enable & updt_ena & (
      ((s1) & (~updt_take))
    | ((s2)               )
    | ((s3)               )
    | ((s4) & ( updt_take))
  );

  wire[1:0] s6 =
       (s1) ? 2'b01
    :  (s2) ? (updt_take ? 2'b00 : 2'b10)
    :  (s3) ? (updt_take ? 2'b01 : 2'b11)
    :  2'b10
    ;

  n22_gnrl_dfflr #(2) taken_dfflr (s5, s6, s0, clk, rst_n);

  assign prdt_take = (~s0[1]);

endmodule
`endif


`include "global.inc"
`ifdef N22_HAS_PMP

module n22_pmp_0dect(
  input           na4,
  input  [30-1:0] pmpaddr,
  output [32-1:0] pmpaddr_mask
  );


  wire [32-1:0] s0 = {pmpaddr, 2'b11};

  wire [32-1:0] s1;
  wire [32-1:0] s2 = {s1[31-1:0],1'b0};

  wire [32-1:0] s3;

  genvar i;
  generate
    for (i=0; i<32; i=i+1) begin: gen_detect_first_0
        if(i==0) begin:gen_i_is_0
            assign s1[0] = 1'b0;
            assign s3[0]   = 1'b0;
        end
        else begin:gen_i_not_0
            assign s1[i] = (~s0[i]) & s0[i-1];
            assign s3[i]   = |s2[i:0];
        end
    end
  endgenerate

  assign pmpaddr_mask = na4 ? {(~(30'b0)),2'b00} : s3;

endmodule
`endif


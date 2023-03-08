
`include "global.inc"

`ifdef N22_HAS_PMONITOR
module n22_pmon_cycle(
  input count_wr_ena,
  input counth_wr_ena,
  input [`N22_XLEN-1:0] wbck_csr_dat,

  input count_stop,
  output [`N22_XLEN-1:0] csr_count ,
  output [`N22_XLEN-1:0] csr_counth,
  output count_ovf,

  input  clk_aon,
  input  rst_n

  );


  wire [`N22_XLEN-1:0] s0;
  wire [`N22_XLEN-1:0] s1;
  wire s2 = ((s0 == (~(`N22_XLEN'b0))));
  wire s3 = ((s1 == (~(`N22_XLEN'b0))));


  wire s4    = count_wr_ena    |
                       ((~counth_wr_ena) & (~count_stop) );
  wire s5   = counth_wr_ena   |
                       ((~count_wr_ena) & (~count_stop) & s2);

  assign count_ovf = s2 & s3 & (~count_wr_ena) & (~counth_wr_ena) & (~count_stop);

  wire [`N22_XLEN-1:0] s6    = count_wr_ena    ? wbck_csr_dat : (s0  + {{`N22_XLEN-1{1'b0}},1'b1});
  wire [`N22_XLEN-1:0] s7   = counth_wr_ena   ? wbck_csr_dat : (s1 + {{`N22_XLEN-1{1'b0}},1'b1});

  n22_gnrl_dfflr #(`N22_XLEN) count_dfflr (s4, s6, s0   , clk_aon, rst_n);
  n22_gnrl_dfflr #(`N22_XLEN) counth_dfflr (s5, s7, s1  , clk_aon, rst_n);

  assign csr_count    = s0;
  assign csr_counth   = s1;


endmodule

`endif


`include "global.inc"

`ifdef N22_HAS_PMONITOR
module n22_pmon_count(
  input count_wr_ena,
  input counth_wr_ena,
  input event_wr_ena,
  input [`N22_XLEN-1:0] wbck_csr_dat,

  input [5-1:0] evt_idx,
  input [`N22_XLEN-1:0] evt_bus,
  input count_stop,
  output [`N22_XLEN-1:0] csr_count ,
  output [`N22_XLEN-1:0] csr_counth,
  output [`N22_XLEN-1:0] csr_event,
  output count_ovf,

  input  clk_aon,
  input  clk,
  input  rst_n

  );


  wire [`N22_XLEN-1:0] s0;
  wire [`N22_XLEN-1:0] s1;
  wire s2 = ((s0 == (~(`N22_XLEN'b0))));
  wire s3 = ((s1 == (~(`N22_XLEN'b0))));

  wire s4 = evt_bus[evt_idx[4:0]];

  wire s5    = count_wr_ena    |
                       ((~counth_wr_ena) & (~count_stop) & s4);
  wire s6   = counth_wr_ena   |
                       ((~count_wr_ena) & (~count_stop) & s4 & s2);

  assign count_ovf = s2 & s3 & (~count_wr_ena) & (~counth_wr_ena) & ((~count_stop) & s4);

  wire [`N22_XLEN-1:0] s7    = count_wr_ena  ? wbck_csr_dat : (s0  + {{`N22_XLEN-1{1'b0}},1'b1});
  wire [`N22_XLEN-1:0] s8   = counth_wr_ena ? wbck_csr_dat : (s1 + {{`N22_XLEN-1{1'b0}},1'b1});

  n22_gnrl_dfflr #(`N22_XLEN) count_dfflr (s5, s7, s0   , clk_aon, rst_n);
  n22_gnrl_dfflr #(`N22_XLEN) counth_dfflr (s6, s8, s1  , clk_aon, rst_n);

  assign csr_count    = s0;
  assign csr_counth   = s1;


  wire s9 = event_wr_ena;
  wire [`N22_XLEN-1:0] s10;
  wire [`N22_XLEN-1:0] s11 = {23'b0,wbck_csr_dat[8:4],4'b0};
  n22_gnrl_dfflr #(`N22_XLEN) event_dfflr (s9, s11, s10, clk, rst_n);
  assign csr_event = s10;



endmodule

`endif

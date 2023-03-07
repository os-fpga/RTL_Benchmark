
`include "global.inc"

`ifdef N22_HAS_TRIGM

module n22_trigm_icount_chck (
  input [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata1,

  input  d_mode,
  input  m_mode,

  output icount_2dm,
  output icount_2excp
  );

  wire [`N22_XLEN-1:0] s0[0:`N22_DEBUG_TRIGM_NUM-1];

  wire [`N22_DEBUG_TRIGM_NUM-1:0] s1;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s2;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s3;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s4;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s5;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s6;

  wire [`N22_DEBUG_TRIGM_NUM-1:0] s7;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s8;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s9;

  genvar i;

  generate
  for(i=0; i<`N22_DEBUG_TRIGM_NUM; i=i+1) begin: gen_match
    assign s0[i] = dbg_tdata1[`N22_XLEN*i +: `N22_XLEN];


    assign s3[i] = (s0[i][`N22_TDATA1_ICOUNT_ACTION] == `N22_TDATA1_ICOUNT_ACTION_W'd1);
    assign s1  [i] = s0[i][`N22_TDATA1_ICOUNT_U];
    assign s2  [i] = s0[i][`N22_TDATA1_ICOUNT_M];
    assign s4  [i] = s0[i][`N22_TDATA1_ICOUNT_COUNT];
    assign s5  [i] = s0[i][`N22_TDATA1_DMODE];
    assign s6[i] = (s0[i][`N22_TDATA1_TYPE] == `N22_TDATA1_TYPE_W'd3);


    assign s7[i] = (m_mode ? s2[i] : s1[i]) &
                      s6[i]
                      ;


    assign s8[i]   =   s3[i]  & s7[i]
                          & s5[i];
    assign s9[i] = (~s3[i]) & s7[i];

  end
  endgenerate

  assign icount_2dm   = (~d_mode) & (|s8);
  assign icount_2excp = (~d_mode) & (|s9);


endmodule

`endif

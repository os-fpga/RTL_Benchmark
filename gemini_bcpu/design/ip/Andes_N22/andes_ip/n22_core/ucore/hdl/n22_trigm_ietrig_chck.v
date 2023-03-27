
`include "global.inc"

`ifdef N22_HAS_TRIGM

module n22_trigm_ietrig_chck (
  input d_mode,
  input m_mode,

  input clic_int_mode,

  input [4:0] excp_cause,
  input [9:0] irq_id,

  input typ_excp,
  input typ_irq,

  input [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata2,
  input [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata1,

  output trigger_2dm,
  output trigger_2excp

  );

  wire [`N22_XLEN-1:0] s0[0:`N22_DEBUG_TRIGM_NUM-1];
  wire [`N22_XLEN-1:0] s1[0:`N22_DEBUG_TRIGM_NUM-1];

  wire [`N22_DEBUG_TRIGM_NUM-1:0] s2;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s3;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s4;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s5;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s6;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s7;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s8;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s9;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s10;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s11;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s12;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s13;

  wire [`N22_DEBUG_TRIGM_NUM-1:0] s14;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s15;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s16;

  genvar i;

  generate
  for(i=0; i<`N22_DEBUG_TRIGM_NUM; i=i+1) begin: gen_match
    assign s0[i] = dbg_tdata2[`N22_XLEN*i +: `N22_XLEN];
    assign s1[i] = dbg_tdata1[`N22_XLEN*i +: `N22_XLEN];


    assign s2[i] = (s1[i][`N22_TDATA1_IETRIGGER_ACTION] == `N22_TDATA1_IETRIGGER_ACTION_W'd1);
    assign s3  [i] = s1[i][`N22_TDATA1_IETRIGGER_U];
    assign s4  [i] = s1[i][`N22_TDATA1_IETRIGGER_M];

    assign s5[i] = (s1[i][`N22_TDATA1_TYPE] == `N22_TDATA1_TYPE_W'd4);
    assign s6[i] = (s1[i][`N22_TDATA1_TYPE] == `N22_TDATA1_TYPE_W'd5);

    assign s13  [i] = s1[i][`N22_TDATA1_DMODE];

    assign s7[i] = s0[i][excp_cause];


    assign s9[i] = s0[i][irq_id[4:0]];

    assign s11[i] = s0[i][0]  & (s0[i][10:1]  == irq_id);
    assign s12[i] = s0[i][16] & (s0[i][26:17] == irq_id);

    assign s10[i] = (s11[i] | s12[i]);

    assign s8[i] = clic_int_mode ? s10[i] : s9[i];


    assign s16[i] = (m_mode ? s4[i] : s3[i]) & (
                         | (s5[i] & typ_irq & s8[i])
                         | (s6[i] & typ_excp & s7[i])
                         );

    assign s14[i]   =   s2[i]  & s16[i]
                          & s13[i];
    assign s15[i] = (~s2[i]) & s16[i];

  end
  endgenerate

  assign trigger_2dm   = (~d_mode) & (|s14);
  assign trigger_2excp = (~d_mode) & (|s15);


endmodule

`endif

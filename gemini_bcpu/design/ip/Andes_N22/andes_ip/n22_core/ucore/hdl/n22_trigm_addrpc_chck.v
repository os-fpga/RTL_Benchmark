
`include "global.inc"

`ifdef N22_HAS_TRIGM

module n22_trigm_addrpc_chck (

  input [`N22_ADDR_SIZE-1:0]  addrpc,

  input d_mode,
  input m_mode,

  input typ_load,
  input typ_store,
  input typ_amo,
  input typ_pc,
  input [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata2,
  input [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata1,

  output trigger_2dm,
  output trigger_2excp
  );

  wire [`N22_XLEN-1:0] s0[0:`N22_DEBUG_TRIGM_NUM-1];
  wire [`N22_XLEN-1:0] s1[0:`N22_DEBUG_TRIGM_NUM-1];
  wire [`N22_XLEN-1:0] s2[0:`N22_DEBUG_TRIGM_NUM-1];
  wire [`N22_XLEN-1:0] s3[0:`N22_DEBUG_TRIGM_NUM-1];

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
  wire [`N22_TDATA1_MCONTROL_MASKMAX_W-1:0] s14 [`N22_DEBUG_TRIGM_NUM-1:0];
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s15;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s16;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s17;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s18;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s19;
                                  `ifdef N22_DEBUG_TRIGM_CHAIN
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s20;
                                  `endif
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s21;
  wire [`N22_XLEN-1:0] s22 [`N22_DEBUG_TRIGM_NUM-1:0];
  wire [`N22_XLEN-1:0] s23 [`N22_DEBUG_TRIGM_NUM-1:0];
  wire [`N22_XLEN-1:0] s24 [`N22_DEBUG_TRIGM_NUM-1:0];
  wire [`N22_XLEN-1:0] s25 [`N22_DEBUG_TRIGM_NUM-1:0];
  `ifdef N22_DEBUG_TRIGM_CHAIN
  wire [`N22_DEBUG_TRIGM_NUM:0] s26;
  `endif

  wire [`N22_DEBUG_TRIGM_NUM-1:0] s27;
  wire [`N22_DEBUG_TRIGM_NUM-1:0] s28;

  genvar i;
  genvar j;

  generate
  for(i=0; i<`N22_DEBUG_TRIGM_NUM; i=i+1) begin: gen_match
    assign s0[i] = dbg_tdata2[`N22_XLEN*i +: `N22_XLEN];
    assign s3[i] = dbg_tdata1[`N22_XLEN*i +: `N22_XLEN];


    assign s4 [i] = s3[i][`N22_TDATA1_MCONTROL_LD];
    assign s5 [i] = s3[i][`N22_TDATA1_MCONTROL_ST];
    assign s6 [i] = s3[i][`N22_TDATA1_MCONTROL_EXE];
    assign s7  [i] = s3[i][`N22_TDATA1_MCONTROL_U];
    assign s8  [i] = s3[i][`N22_TDATA1_MCONTROL_M];
    assign s11 [i] = (s3[i][`N22_TDATA1_MCONTROL_MATCH] == `N22_TDATA1_MCONTROL_MATCH_W'd0);
    assign s12 [i] = (s3[i][`N22_TDATA1_MCONTROL_MATCH] == `N22_TDATA1_MCONTROL_MATCH_W'd1);
    assign s13 [i] = s3[i][`N22_TDATA1_MCONTROL_CHAIN];
    assign s9[i] = (s3[i][`N22_TDATA1_MCONTROL_ACTION] == `N22_TDATA1_MCONTROL_ACTION_W'd1);
    assign s10[i] = (s3[i][`N22_TDATA1_DMODE]);
    assign s14 [i] = s3[i][`N22_TDATA1_MCONTROL_MASKMAX];
    assign s15[i] = (s3[i][`N22_TDATA1_TYPE] == `N22_TDATA1_TYPE_W'd2);

    assign s22[i] = ~(`N22_XLEN'b0);


    assign s1[i] = {s0[i][`N22_XLEN-2:0], 1'b1};
    assign s2[i] = (~s1[i]);
    for(j=0; j<`N22_XLEN; j=j+1) begin: gen_mask
        assign s24[i][j] = |s2[i][j:0];
    end
    assign s23[i] = {20'hFFFF_F, s24[i][11:0]};

    assign s25[i] = s11[i] ?  s22[i] :
                           s12[i] ?  s23[i] :
                                                (~32'h0);

    assign s16[i] = (s11[i] |  s12[i]) &
                           ((addrpc & s25[i]) == (s0[i] & s25[i]));

    assign s18[i] = (
                           (s15[i] & s4[i] & (typ_load | typ_amo))
                         | (s15[i] & s5[i] & (typ_store | typ_amo))
                         | (s15[i] & s6[i] & (typ_pc))
                         );

    assign s17[i] = (m_mode ? s8[i] : s7[i])  & s18[i];

    assign s19[i] = s16[i] & s17[i];

                                  `ifdef N22_DEBUG_TRIGM_CHAIN
    assign s20[i] = s16[i] & s18[i];

    if(i == 0) begin: gen_i_eq_0
      assign s26[0] = 1'b1;
    end
    assign s26[i+1] = s13[i] ? (
                                     (~s20[i]) ? 1'b0 : 1'b1
                                 ): 1'b1;

    assign s21[i] =   s19[i] & s26[i];
                                  `else
    assign s21[i] =   s19[i];
                                  `endif
    assign s27[i]   =   s9[i]  & s21[i]
                          & s10[i];
    assign s28[i] = (~s9[i]) & s21[i];

  end
  endgenerate

  assign trigger_2dm   = (~d_mode) & (|s27);
  assign trigger_2excp = (~d_mode) & (|s28);


endmodule

`endif



`include "global.inc"

module n22_clk_ctrl (
  input  clk_aon,
  input  clk,
  input  rst_n,
  input  clkgate_bypass,

  input  core_cgstop,

  `ifdef N22_TMR_PRIVATE
  input  tmr_active,
  output clk_tmr,
  `endif

  `ifdef N22_HAS_CLIC
  input  clic_active,
  output clk_clic,
  `endif





  input  pft_active,
  output clk_pft,

  `ifdef N22_HAS_ICACHE
  input  icache_active,
  output clk_icache,
  output icache_ls,
  `endif

  input  ifu_active,
  input  exu_active,
  input  lsu_active,
  input  biu_active,
  `ifdef N22_HAS_LBIU
  input  lbiu_active,
  `endif
  `ifdef N22_HAS_ILM
  input  ilm_active,
  output ilm_ls,
  `endif
  `ifdef N22_HAS_DLM
  input  dlm_active,
  output dlm_ls,
  `endif
  output clk_ifu,
  output clk_exu,
  output clk_lsu,

  `ifdef N22_HAS_LBIU
  output clk_lbiu,
  `endif

  `ifdef N22_HAS_ILM
  output clk_ilm,
  `endif
  `ifdef N22_HAS_DLM
  output clk_dlm,
  `endif

  output clk_biu
);



  wire ifu_clk_en = core_cgstop | (ifu_active);
  wire exu_clk_en = core_cgstop | (exu_active);
  wire lsu_clk_en = core_cgstop | (lsu_active);
  wire biu_clk_en = core_cgstop | (biu_active);
  `ifdef N22_HAS_LBIU
  wire lbiu_clk_en = core_cgstop | (lbiu_active);
  `endif




  `ifdef N22_HAS_CLIC
  n22_clkgate u_clic_clkgate(
    .clk_in   (clk_aon    ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (clic_active),
    .clk_out  (clk_clic)
  );
  `endif

  `ifdef N22_TMR_PRIVATE
  n22_clkgate u_tmr_clkgate(
    .clk_in   (clk_aon    ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (tmr_active),
    .clk_out  (clk_tmr)
  );
  `endif




  n22_clkgate u_ifu_clkgate(
    .clk_in   (clk        ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (ifu_clk_en),
    .clk_out  (clk_ifu)
  );

  n22_clkgate u_exu_clkgate(
    .clk_in   (clk        ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (exu_clk_en),
    .clk_out  (clk_exu)
  );

  n22_clkgate u_lsu_clkgate(
    .clk_in   (clk        ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (lsu_clk_en),
    .clk_out  (clk_lsu)
  );

  n22_clkgate u_biu_clkgate(
    .clk_in   (clk        ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (biu_clk_en),
    .clk_out  (clk_biu)
  );

  `ifdef N22_HAS_LBIU
  n22_clkgate u_lbiu_clkgate(
    .clk_in   (clk        ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (lbiu_clk_en),
    .clk_out  (clk_lbiu)
  );
  `endif



  `ifdef N22_HAS_ICACHE
  wire icache_clk_en = core_cgstop | icache_active;
  assign icache_ls = ~icache_clk_en;

  n22_clkgate u_icache_clkgate(
    .clk_in   (clk        ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (icache_clk_en),
    .clk_out  (clk_icache)
  );
  `endif

  wire pft_clk_en = core_cgstop | pft_active;

  n22_clkgate u_pft_clkgate(
    .clk_in   (clk        ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (pft_clk_en),
    .clk_out  (clk_pft)
  );

  `ifdef N22_HAS_ILM
  wire ilm_clk_en = core_cgstop | ilm_active;
  assign ilm_ls = ~ilm_clk_en;

  n22_clkgate u_ilm_clkgate(
    .clk_in   (clk        ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (ilm_clk_en),
    .clk_out  (clk_ilm)
  );
  `endif

  `ifdef N22_HAS_DLM
  wire dlm_clk_en = core_cgstop | dlm_active;
  assign dlm_ls = ~dlm_clk_en;

  n22_clkgate u_dlm_clkgate(
    .clk_in   (clk        ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (dlm_clk_en),
    .clk_out  (clk_dlm)
  );
  `endif

endmodule



`include "global.inc"

`ifdef N22_HAS_STACKSAFE
module n22_spsafe_csr(
  input u_mode,

  input sp_excp_taken_ena,

  input rf_wbck_sp_ena1,
  input rf_wbck_sp_ena2,
  input [`N22_XLEN-1:0] sp_r,

  input csr_ena,
  input csr_wr_en,
  input csr_rd_en,
  input [12-1:0] csr_idx,
  input wbck_csr_wen,
  input  [`N22_XLEN-1:0] wbck_csr_dat,
  output [`N22_XLEN-1:0] read_csr_dat,
  output csr_addr_legal,

  output sp_ovf_excp,
  output sp_udf_excp,
  output spsafe_enable,

  input  clk,
  input  rst_n

  );

  wire [`N22_XLEN-1:0] csr_mhsp_ctl  ;
  wire [`N22_XLEN-1:0] csr_msp_bound ;
  wire [`N22_XLEN-1:0] csr_msp_base  ;

  wire sp_wbck_ena = rf_wbck_sp_ena1 | rf_wbck_sp_ena2;

  wire sp_cmp_r;
  n22_gnrl_dffr #(1) sp_cmp_dffr (sp_wbck_ena, sp_cmp_r, clk, rst_n);

  wire [31:0] msp_bound_r;
  wire [31:0] msp_base_r ;

  wire sp_smaller_bound = (sp_r < msp_bound_r);
  wire sp_bigger_base = (sp_r > msp_base_r);

  wire sel_mhsp_ctl  = (csr_idx == 12'h7c6);
  wire sel_msp_bound = (csr_idx == 12'h7c7);
  wire sel_msp_base  = (csr_idx == 12'h7c8);

  wire rd_mhsp_ctl   = sel_mhsp_ctl  & csr_rd_en;
  wire rd_msp_bound  = sel_msp_bound & csr_rd_en;
  wire rd_msp_base   = sel_msp_base  & csr_rd_en;

  wire wr_mhsp_ctl  = sel_mhsp_ctl  & wbck_csr_wen;
  wire wr_msp_bound = sel_msp_bound & wbck_csr_wen;
  wire wr_msp_base  = sel_msp_base  & wbck_csr_wen;

  wire ovfen_ena = wr_mhsp_ctl | sp_excp_taken_ena;
  wire ovfen_r;
  wire ovfen_nxt = sp_excp_taken_ena ? 1'b0 : wbck_csr_dat[0];
  assign csr_mhsp_ctl[0] = ovfen_r;
  n22_gnrl_dfflr #(1) ovfen_dfflr (ovfen_ena, ovfen_nxt, ovfen_r, clk, rst_n);

  wire udfen_ena = wr_mhsp_ctl | sp_excp_taken_ena;
  wire udfen_r;
  wire udfen_nxt = sp_excp_taken_ena ? 1'b0 : wbck_csr_dat[1];
  assign csr_mhsp_ctl[1] = udfen_r;
  n22_gnrl_dfflr #(1) udfen_dfflr (udfen_ena, udfen_nxt, udfen_r, clk, rst_n);

  wire schm_ena = wr_mhsp_ctl;
  wire schm_r;
  wire schm_nxt = wbck_csr_dat[2];
  assign csr_mhsp_ctl[2] = schm_r;
  n22_gnrl_dfflr #(1) schm_dfflr (schm_ena, schm_nxt, schm_r, clk, rst_n);

`ifdef N22_HAS_UMODE
  wire u_ena = wr_mhsp_ctl;
  wire u_r;
  wire u_nxt = wbck_csr_dat[3];
  assign csr_mhsp_ctl[3] = u_r;
  n22_gnrl_dfflr #(1) u_dfflr (u_ena, u_nxt, u_r, clk, rst_n);
`endif
`ifndef N22_HAS_UMODE
  assign csr_mhsp_ctl[3] = 1'b0;
`endif

  wire m_ena = wr_mhsp_ctl;
  wire m_r;
  wire m_nxt = wbck_csr_dat[5];
  assign csr_mhsp_ctl[5] = m_r;
  n22_gnrl_dfflr #(1) m_dfflr (m_ena, m_nxt, m_r, clk, rst_n);

  assign csr_mhsp_ctl[4] = 1'b0;
  assign csr_mhsp_ctl[31:6] = 26'b0;

`ifdef N22_HAS_UMODE
  wire mode_en = u_mode ? u_r : m_r;
`endif
`ifndef N22_HAS_UMODE
  wire mode_en = m_r;
`endif

  wire mode_ovfen = ovfen_r  & mode_en;
  wire mode_udfen = udfen_r  & mode_en;

  assign spsafe_enable = mode_ovfen | mode_udfen;

  wire detct_msp_bound_ovf = sp_smaller_bound & sp_cmp_r & mode_ovfen;
  wire detct_msp_base_udf  = sp_bigger_base   & sp_cmp_r & mode_udfen;

  wire msp_bound_rec_upt = detct_msp_bound_ovf
                           & schm_r
                           ;
  wire msp_bound_ovf_excp = detct_msp_bound_ovf
                           & (~schm_r)
                           ;
  wire msp_bound_ena = wr_msp_bound | msp_bound_rec_upt;
  wire [`N22_XLEN-1:0] msp_bound_nxt = msp_bound_rec_upt ? sp_r : wbck_csr_dat;
  n22_gnrl_dfflrs #(`N22_XLEN) msp_bound_dfflrs (msp_bound_ena, msp_bound_nxt, msp_bound_r, clk, rst_n);
  assign csr_msp_bound = msp_bound_r;

  wire msp_base_rec_upt = 1'b0;
  wire msp_base_udf_excp = detct_msp_base_udf
                           & (~schm_r)
                           ;
  wire msp_base_ena = wr_msp_base | msp_base_rec_upt;
  wire [`N22_XLEN-1:0] msp_base_nxt = msp_base_rec_upt ? sp_r : wbck_csr_dat;
  n22_gnrl_dfflrs #(`N22_XLEN) msp_base_dfflrs (msp_base_ena, msp_base_nxt, msp_base_r, clk, rst_n);
  assign csr_msp_base = msp_base_r;


  assign {csr_addr_legal, read_csr_dat} = {1'b0,`N22_XLEN'b0}
                 | {sel_mhsp_ctl , ({`N22_XLEN{rd_mhsp_ctl }} & csr_mhsp_ctl )}
                 | {sel_msp_bound, ({`N22_XLEN{rd_msp_bound}} & csr_msp_bound)}
                 | {sel_msp_base , ({`N22_XLEN{rd_msp_base }} & csr_msp_base )}
              ;

  assign sp_ovf_excp = msp_bound_ovf_excp;
  assign sp_udf_excp = msp_base_udf_excp;

endmodule
`endif


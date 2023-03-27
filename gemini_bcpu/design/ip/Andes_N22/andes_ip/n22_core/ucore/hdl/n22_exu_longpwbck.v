

`include "global.inc"

module n22_exu_longpwbck(



`ifdef N22_INDEP_MULDIV
  input  div_wbck_i_valid,
  output div_wbck_i_ready,
  input  [`N22_XLEN-1:0] div_wbck_i_wdat,
  input  div_wbck_i_err,
  input  [`N22_ITAG_WIDTH-1:0] div_wbck_i_itag,
`endif

  input  lsu_wbck_i_valid,
  output lsu_wbck_i_ready,
  input  [`N22_XLEN-1:0] lsu_wbck_i_wdat,
  input  [`N22_ITAG_WIDTH -1:0] lsu_wbck_i_itag,
  input  lsu_wbck_i_err ,
  input  lsu_cmt_i_buserr ,
  input  lsu_cmt_i_pmperr ,
  input  [`N22_ADDR_SIZE -1:0] lsu_cmt_i_badaddr,
  input  [`N22_PC_SIZE -1:0] lsu_cmt_i_pc,
  input  lsu_cmt_i_ld,
  input  lsu_cmt_i_st,

  output longp_wbck_o_valid,
  input  longp_wbck_o_ready,
  output [`N22_FLEN-1:0] longp_wbck_o_wdat,
  output [5-1:0] longp_wbck_o_flags,
  output [`N22_RFIDX_WIDTH -1:0] longp_wbck_o_rdidx,
  output longp_wbck_o_rdfpu,
  output longp_wbck_o_wen,
`ifdef N22_HAS_STACKSAFE
  output longp_wbck_o_rdsp,
`endif
  output  longp_excp_o_valid,
  output  longp_excp_o_insterr,
  output  longp_excp_o_ld,
  output  longp_excp_o_st,
  output  longp_excp_o_buserr ,
  output  longp_excp_o_pmperr ,
  output [`N22_ADDR_SIZE-1:0] longp_excp_o_badaddr,
  output [`N22_PC_SIZE -1:0] longp_excp_o_pc,
  input  oitf_empty,
  input  [`N22_ITAG_WIDTH -1:0] oitf_ret_ptr,
  input  [`N22_RFIDX_WIDTH-1:0] oitf_ret_rdidx,
  input  oitf_ret_rdwen,
  input  oitf_ret_rdfpu,
  output oitf_ret_ena,
`ifdef N22_HAS_STACKSAFE
  input oitf_ret_rdsp,
`endif

  input  clk,
  input  rst_n
  );

  wire longp_excp_o_hsked;



  assign longp_excp_o_valid = longp_excp_o_hsked;




  wire wbck_ready4lsu = (lsu_wbck_i_itag == oitf_ret_ptr) & (~oitf_empty);
  wire wbck_sel_lsu = lsu_wbck_i_valid & wbck_ready4lsu;
`ifdef N22_INDEP_MULDIV
  wire wbck_ready4div = (div_wbck_i_itag == oitf_ret_ptr) & (~oitf_empty);
  wire wbck_sel_div = div_wbck_i_valid & wbck_ready4div;
`endif


  assign {
         longp_excp_o_insterr
        ,longp_excp_o_ld
        ,longp_excp_o_st
        ,longp_excp_o_buserr
        ,longp_excp_o_pmperr
        ,longp_excp_o_badaddr
        ,longp_excp_o_pc
        } =
             ({`N22_ADDR_SIZE*2+5{wbck_sel_lsu}} &
              {
                1'b0,
                lsu_cmt_i_ld,
                lsu_cmt_i_st,
                lsu_cmt_i_buserr,
                lsu_cmt_i_pmperr,
                lsu_cmt_i_badaddr,
                lsu_cmt_i_pc
              })
              ;

  wire wbck_i_ready;
  wire wbck_i_valid;
  wire [`N22_FLEN-1:0] wbck_i_wdat;
  wire [5-1:0] wbck_i_flags;
  wire [`N22_RFIDX_WIDTH-1:0] wbck_i_rdidx;
  wire wbck_i_rdwen;
  wire wbck_i_rdfpu;
  wire wbck_i_err ;
`ifdef N22_HAS_STACKSAFE
  wire wbck_i_rdsp;
`endif

  assign lsu_wbck_i_ready = wbck_ready4lsu & wbck_i_ready;
`ifdef N22_INDEP_MULDIV
  assign div_wbck_i_ready = wbck_ready4div & wbck_i_ready;
`endif

  assign wbck_i_valid = ({1{wbck_sel_lsu}} & lsu_wbck_i_valid)
                   `ifdef N22_INDEP_MULDIV
                      | ({1{wbck_sel_div}} & div_wbck_i_valid)
                   `endif
                         ;
  `ifdef N22_FLEN_IS_32
  wire [`N22_FLEN-1:0] lsu_wbck_i_wdat_exd = lsu_wbck_i_wdat;
                   `ifdef N22_INDEP_MULDIV
  wire [`N22_FLEN-1:0] div_wbck_i_wdat_exd = div_wbck_i_wdat;
                   `endif
  `else
  wire [`N22_FLEN-1:0] lsu_wbck_i_wdat_exd = {{`N22_FLEN-`N22_XLEN{1'b0}},lsu_wbck_i_wdat};
                   `ifdef N22_INDEP_MULDIV
  wire [`N22_FLEN-1:0] div_wbck_i_wdat_exd = {{`N22_FLEN-`N22_XLEN{1'b0}},div_wbck_i_wdat};
                   `endif
  `endif
  assign wbck_i_wdat  = ({`N22_FLEN{wbck_sel_lsu}} & lsu_wbck_i_wdat_exd )
                   `ifdef N22_INDEP_MULDIV
                      | ({`N22_FLEN{wbck_sel_div}} & div_wbck_i_wdat_exd)
                   `endif
                         ;
  assign wbck_i_flags  = 5'b0
                         ;
  assign wbck_i_err   = wbck_sel_lsu & lsu_wbck_i_err
                   `ifdef N22_INDEP_MULDIV
                      | ({1{wbck_sel_div}} & div_wbck_i_err)
                   `endif
                         ;
  assign wbck_i_rdidx = oitf_ret_rdidx;
  assign wbck_i_rdwen = oitf_ret_rdwen;
  assign wbck_i_rdfpu = oitf_ret_rdfpu;
`ifdef N22_HAS_STACKSAFE
  assign wbck_i_rdsp  = oitf_ret_rdsp;
`endif

  wire need_wbck = wbck_i_rdwen;

  wire need_excp = wbck_i_err;

  assign wbck_i_ready =
       (need_wbck ? longp_wbck_o_ready : 1'b1)
       ;


  wire wbck_i_hsked = oitf_ret_ena;
  assign longp_wbck_o_valid = need_wbck & wbck_i_valid;

  assign longp_excp_o_hsked = need_excp & wbck_i_hsked;

  assign longp_wbck_o_wdat  = wbck_i_wdat ;
  assign longp_wbck_o_flags = wbck_i_flags ;
  assign longp_wbck_o_rdfpu = wbck_i_rdfpu ;
  assign longp_wbck_o_wen   = (~wbck_i_err) ;
  assign longp_wbck_o_rdidx = wbck_i_rdidx;
`ifdef N22_HAS_STACKSAFE
  assign longp_wbck_o_rdsp  = wbck_i_rdsp;
`endif


  assign oitf_ret_ena = wbck_i_valid & wbck_i_ready;

endmodule





`include "global.inc"


module n22_exu_branchslv(

  input  excpirq_flush_req,

  input [2-1:0] dbg_prv_r,
  input  cmt_i_bjp_valid,
  output cmt_i_ready,
  input  cmt_i_rv32,
  input  cmt_i_dret,
  input  cmt_i_mret,
  input  cmt_i_fencei,
  input  cmt_i_bjp,
  input  cmt_i_bjp_prdt,
  input  cmt_i_bjp_rslv,
  input  [`N22_PC_SIZE-1:0] cmt_i_pc,
  input  [`N22_XLEN-1:0] cmt_i_bjp_imm,
  input  cmt_i_replaced,

  input  cmt_i_ifu_buserr,
  input  cmt_i_ifu_buserr_btm,
  output [`N22_PC_SIZE-1:0] pc_plus_ofst,
  input  [`N22_PC_SIZE-1:0] csr_mepc_r,
  input  [`N22_PC_SIZE-1:0] csr_dpc_r,

  input  m_mode,
  input  mpp_m_mode,
  input  dbg_mode,

  input  nonalu_excpirq_flush_req,
  input  brchmis_flush_ack,
  output brchmis_flush_req,
  output brchmis_flush_pc_mmode,
  output brchmis_flush_pc_dmode,
  `ifdef N22_TIMING_BOOST
  output [`N22_PC_SIZE-1:0] brchmis_flush_pc,
  output brchmis_flush_fencei,
  `endif

  `ifdef N22_LDST_EXCP_PRECISE
  input lsu_pend_outs,
  input lsu_pend_rv32,
  `endif

  output  cmt_mret_ena,
  output  cmt_dret_ena,

  input  clk,
  input  rst_n
  );


  wire s0;
  wire s1;

  assign brchmis_flush_req = s1 & (~nonalu_excpirq_flush_req);
  assign s0 = brchmis_flush_ack & (~nonalu_excpirq_flush_req);
  wire s2 = (
        (cmt_i_bjp & (cmt_i_bjp_prdt ^ cmt_i_bjp_rslv))
       | cmt_i_fencei
       | cmt_i_mret
       | cmt_i_dret
      );

  wire s3 = (
         cmt_i_bjp
       | cmt_i_fencei
       | cmt_i_mret
       | cmt_i_dret
      );

  assign s1 = cmt_i_bjp_valid & s2;


  assign brchmis_flush_pc_mmode = cmt_i_dret ? (dbg_prv_r == 2'b11) :
                                  cmt_i_mret ? mpp_m_mode :
                                 (cmt_i_fencei | cmt_i_bjp_prdt) ? m_mode :
                                      m_mode;

  assign brchmis_flush_pc_dmode = cmt_i_dret ? 1'b0 :
                                  cmt_i_mret ? dbg_mode :
                                 (cmt_i_fencei | cmt_i_bjp_prdt) ? dbg_mode :
                                      dbg_mode;

  assign pc_plus_ofst =
                        cmt_i_pc + (
                            (
                           `ifdef N22_LDST_EXCP_PRECISE
                              lsu_pend_outs ? ( lsu_pend_rv32 ?
                                                   {{`N22_PC_SIZE-2{1'b1}},2'b0}
                                                 : {{`N22_PC_SIZE-1{1'b1}},1'b0}
                                               ) :
                           `endif
                              cmt_i_ifu_buserr ? ( cmt_i_ifu_buserr_btm ? `N22_PC_SIZE'd0 : `N22_PC_SIZE'd2) :
                             ( (cmt_i_rv32
                               & (~cmt_i_replaced)
                               )
                             ) ? `N22_PC_SIZE'd4 : `N22_PC_SIZE'd2
                            )
                        );

  `ifdef N22_TIMING_BOOST
  assign brchmis_flush_pc =
                          (cmt_i_fencei | (cmt_i_bjp & cmt_i_bjp_prdt)) ? pc_plus_ofst :
    `ifdef N22_HAS_DYNAMIC_BPU
                          (cmt_i_bjp & (~cmt_i_bjp_prdt)) ? (cmt_i_pc + cmt_i_bjp_imm[`N22_PC_SIZE-1:0]) :
    `endif
    `ifndef N22_HAS_DYNAMIC_BPU
      `ifdef N22_HAS_BTFN_BPU
                          (cmt_i_bjp & (~cmt_i_bjp_prdt)) ? (cmt_i_pc + cmt_i_bjp_imm[`N22_PC_SIZE-1:0]) :
      `endif
    `endif
                          cmt_i_dret ? csr_dpc_r :
                                       csr_mepc_r ;
  assign brchmis_flush_fencei = cmt_i_fencei;
  `endif

  wire s4 = brchmis_flush_req & brchmis_flush_ack;
  assign cmt_mret_ena = cmt_i_mret & s4 & (~excpirq_flush_req);
  assign cmt_dret_ena = cmt_i_dret & s4 & (~excpirq_flush_req);

  assign cmt_i_ready = (~s3) |
                             (
                                s0

                                     & (~nonalu_excpirq_flush_req)
                             );

endmodule




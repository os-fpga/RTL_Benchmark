
`include "global.inc"

module n22_exu_disp(
  `ifdef N22_HAS_POWERBRAKE
  input [3:0] csr_mpftctl_tlevel,
  input csr_mxstat_pften,
  `endif

  `ifdef N22_LDST_EXCP_PRECISE
  input lsu_pend_outs,
  `endif

  `ifdef N22_HAS_STACKSAFE
  input  spsafe_enable,
  input  oitf_has_rdsp,
  `endif

  input  wfi_halt_exu_req,
  output wfi_halt_exu_ack,

  input  oitf_empty,
  input  disp_i_valid,
  output disp_i_ready,

  input  disp_i_pc_vld,

  input disp_i_alu_op,
  input disp_i_agu_op,
  input disp_i_bjp_op,
  input disp_i_csr_op,
  input [`N22_DECINFO_WIDTH-1:0]  disp_i_bjp_info,

  input  disp_i_rs1x0,
  input  disp_i_rs2x0,
  input  disp_i_rs1en,
  input  disp_i_rs2en,
  input  [`N22_RFIDX_WIDTH-1:0] disp_i_rs1idx,
  input  [`N22_RFIDX_WIDTH-1:0] disp_i_rs2idx,
  input  [`N22_XLEN-1:0] disp_i_rs1,
  input  [`N22_XLEN-1:0] disp_i_rs2,
  input  disp_i_rdwen,
`ifdef N22_HAS_STACKSAFE
  input  disp_i_rdsp,
`endif
  input  [`N22_RFIDX_WIDTH-1:0] disp_i_rdidx,
  input  [`N22_XLEN-1:0] disp_i_imm,
`ifdef N22_HAS_PMONITOR
  input  [31:0] disp_i_pmon_evts,
`endif
  input  [`N22_PC_SIZE-1:0] disp_i_pc,
  input  [`N22_BPU_IDX_W-1:0] disp_i_prdt_bpu_idx,
  input  disp_i_misalgn,
  input  disp_i_buserr ,
  input  disp_i_pmperr ,
  input  disp_i_mmode  ,
  input  disp_i_dmode  ,
  input  disp_i_replaced,
  input  [`N22_PC_SIZE-1:0] disp_i_replaced_pc,
  input  disp_i_x0base ,


`ifdef N22_HAS_MULDIV
  input [`N22_DECINFO_MULDIV_WIDTH-1:0] disp_i_muldiv_info,
  output [`N22_DECINFO_MULDIV_WIDTH-1:0] disp_o_muldiv_info,
  input  disp_i_muldiv_op,
  output disp_o_muldiv_op,
`endif
  output disp_o_alu_valid,
  input  disp_o_alu_ready,

  input  disp_o_alu_longpipe,

  output [`N22_XLEN-1:0] disp_o_alu_rs1,
  output [`N22_XLEN-1:0] disp_o_alu_rs2,
  output disp_o_alu_rdwen,
`ifdef N22_HAS_STACKSAFE
  output disp_o_alu_rdsp,
`endif
  output [`N22_RFIDX_WIDTH-1:0] disp_o_alu_rdidx,
  output [`N22_XLEN-1:0] disp_o_alu_imm,
`ifdef N22_HAS_PMONITOR
  output [31:0] disp_o_alu_pmon_evts,
`endif
  output [`N22_PC_SIZE-1:0] disp_o_alu_pc,
  output [`N22_BPU_IDX_W-1:0] disp_o_alu_prdt_bpu_idx,
  output [`N22_ITAG_WIDTH-1:0] disp_o_alu_itag,
  output disp_o_alu_misalgn,
  output disp_o_alu_buserr ,
  output disp_o_alu_pmperr ,
  output disp_o_alu_mmode  ,
  output disp_o_alu_dmode  ,
  output disp_o_alu_x0base ,
  output disp_o_alu_replaced,
  output [`N22_PC_SIZE-1:0] disp_o_alu_replaced_pc,

  input  oitfrd_match_disprs1,
  input  oitfrd_match_disprs2,
  input  oitfrd_match_disprs3,
  input  oitfrd_match_disprd,
  input  [`N22_ITAG_WIDTH-1:0] disp_oitf_ptr ,

  output disp_oitf_ena,
  input  disp_oitf_ready,

  output disp_oitf_rs1fpu,
  output disp_oitf_rs2fpu,
  output disp_oitf_rs3fpu,
  output disp_oitf_rdfpu ,

  output disp_oitf_rs1en ,
  output disp_oitf_rs2en ,
  output disp_oitf_rs3en ,
  output disp_oitf_rdwen ,
`ifdef N22_HAS_STACKSAFE
  output disp_oitf_rdsp ,
`endif

  output [`N22_RFIDX_WIDTH-1:0] disp_oitf_rs1idx,
  output [`N22_RFIDX_WIDTH-1:0] disp_oitf_rs2idx,
  output [`N22_RFIDX_WIDTH-1:0] disp_oitf_rs3idx,
  output [`N22_RFIDX_WIDTH-1:0] disp_oitf_rdidx ,


  output spsafe_stall,

  input  clk,
  input  rst_n
  );

  wire s0;


  `ifdef N22_HAS_POWERBRAKE
  wire [4-1:0] s1;
  wire s2 = csr_mxstat_pften;
  wire s3 = (s1 == csr_mpftctl_tlevel);
  wire s4 = s2 | s3;
  wire [4-1:0] s5 = s3 ? 4'b0 : (s1 + 4'b1);
  n22_gnrl_dfflr #(4) pbrake_cnt_dfflr (s4, s5, s1, clk, rst_n);

  assign s0 = (~s3) & csr_mxstat_pften;

  `endif

  `ifdef N22_HAS_STACKSAFE
  assign spsafe_stall = spsafe_enable & oitf_has_rdsp;
  `endif

  `ifndef N22_HAS_POWERBRAKE
  assign s0 = 1'b0;
  `endif

  `ifndef N22_HAS_STACKSAFE
  assign spsafe_stall = 1'b0;
  `endif

  `ifdef N22_LDST_EXCP_PRECISE
  wire s6 = lsu_pend_outs & (~disp_i_agu_op);
  `endif




  wire s7 = disp_i_csr_op;

  wire s8 = disp_i_agu_op
                             ;

  wire s9 = disp_o_alu_longpipe;

  wire s10   = disp_i_bjp_op &
                               ( disp_i_bjp_info [`N22_DECINFO_BJP_FENCE] | disp_i_bjp_info [`N22_DECINFO_BJP_FENCEI]);

  wire s11;
  wire   s12 = disp_o_alu_ready;
  assign disp_o_alu_valid = s11;


  wire s13 =  ((oitfrd_match_disprs1) |
                   (oitfrd_match_disprs2) |
                   (oitfrd_match_disprs3));
  wire s14 = (oitfrd_match_disprd);

  wire s15 = s13 | s14;

  assign wfi_halt_exu_ack = oitf_empty & disp_i_pc_vld;

  wire s16 =
                 (s7 ? oitf_empty : 1'b1)
               & (s10 ? oitf_empty : 1'b1)
               & (~wfi_halt_exu_req)
               & (~s15)
               & (~s0)
               & (~spsafe_stall)
              `ifdef N22_LDST_EXCP_PRECISE
               & (~s6)
              `endif
               `ifdef N22_OITF_DEPTH_IS_1
               & (1'b1)
               `else
               & (s8 ? disp_oitf_ready : 1'b1)
               `endif
               ;

  assign s11 = s16 & disp_i_valid;
  assign disp_i_ready     = s16 & s12;


  wire [`N22_XLEN-1:0] s17 = disp_i_rs1 & {`N22_XLEN{~disp_i_rs1x0}};
  wire [`N22_XLEN-1:0] s18 = disp_i_rs2 & {`N22_XLEN{~disp_i_rs2x0}};
  assign disp_o_alu_rs1   = s17;
  assign disp_o_alu_rs2   = s18;
  assign disp_o_alu_rdwen = disp_i_rdwen;
  assign disp_o_alu_rdidx = disp_i_rdidx;
`ifdef N22_HAS_MULDIV
  assign disp_o_muldiv_info = disp_i_muldiv_info;
  assign disp_o_muldiv_op   = disp_i_muldiv_op;
`endif
`ifdef N22_HAS_STACKSAFE
  assign disp_o_alu_rdsp  = disp_i_rdsp;
`endif

  assign disp_oitf_ena = disp_o_alu_valid & disp_o_alu_ready & s9;


  assign disp_o_alu_imm  = disp_i_imm;
  assign disp_o_alu_pc   = disp_i_pc;
  assign disp_o_alu_prdt_bpu_idx   = disp_i_prdt_bpu_idx;
  assign disp_o_alu_itag = disp_oitf_ptr;
  assign disp_o_alu_misalgn= disp_i_misalgn;
  assign disp_o_alu_buserr = disp_i_buserr;
  assign disp_o_alu_pmperr = disp_i_pmperr;
  assign disp_o_alu_mmode  = disp_i_mmode   ;
  assign disp_o_alu_dmode  = disp_i_dmode   ;
  assign disp_o_alu_replaced    = disp_i_replaced   ;
  assign disp_o_alu_replaced_pc = disp_i_replaced_pc;
  assign disp_o_alu_x0base = disp_i_x0base  ;

  `ifndef N22_HAS_FPU
  wire s19       = 1'b0;
  wire s20 = 1'b0;
  wire s21 = 1'b0;
  wire s22 = 1'b0;
  wire s23 = 1'b0;
  wire [`N22_RFIDX_WIDTH-1:0] s24 = `N22_RFIDX_WIDTH'b0;
  wire [`N22_RFIDX_WIDTH-1:0] s25 = `N22_RFIDX_WIDTH'b0;
  wire [`N22_RFIDX_WIDTH-1:0] s26 = `N22_RFIDX_WIDTH'b0;
  wire [`N22_RFIDX_WIDTH-1:0] s27  = `N22_RFIDX_WIDTH'b0;
  wire s28 = 1'b0;
  wire s29 = 1'b0;
  wire s30 = 1'b0;
  wire s31  = 1'b0;
  `endif
  assign disp_oitf_rs1fpu = s19 ? (s20 & s28) : 1'b0;
  assign disp_oitf_rs2fpu = s19 ? (s21 & s29) : 1'b0;
  assign disp_oitf_rs3fpu = s19 ? (s22 & s30) : 1'b0;
  assign disp_oitf_rdfpu  = s19 ? (s23 & s31 ) : 1'b0;

  assign disp_oitf_rs1en  = s19 ? s20 : disp_i_rs1en;
  assign disp_oitf_rs2en  = s19 ? s21 : disp_i_rs2en;
  assign disp_oitf_rs3en  = s19 ? s22 : 1'b0;
  assign disp_oitf_rdwen  = s19 ? s23 : disp_i_rdwen;
`ifdef N22_HAS_STACKSAFE
  assign disp_oitf_rdsp   = disp_i_rdsp;
`endif

  assign disp_oitf_rs1idx = s19 ? s24 : disp_i_rs1idx;
  assign disp_oitf_rs2idx = s19 ? s25 : disp_i_rs2idx;
  assign disp_oitf_rs3idx = s19 ? s26 : `N22_RFIDX_WIDTH'b0;
  assign disp_oitf_rdidx  = s19 ? s27  : disp_i_rdidx;


`ifdef N22_HAS_PMONITOR
  assign disp_o_alu_pmon_evts = disp_i_pmon_evts;
`endif


endmodule




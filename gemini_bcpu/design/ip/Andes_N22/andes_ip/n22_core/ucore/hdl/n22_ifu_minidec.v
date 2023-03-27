
`include "global.inc"

module n22_ifu_minidec(

  input  [`N22_INSTR_SIZE-1:0] instr,

  input  i_prdt_taken,
  input  i_muldiv_b2b,
  input  i_mmode,
  input  i_dmode,
  input  i_replaced,


  input  csr_rvcompm_enable,


  output dec_execit,
  output [11:0]  dec_execit_imm,

  output dec_rs1en,
  output dec_rs2en,
  output [`N22_RFIDX_WIDTH-1:0] dec_rs1idx,
  output [`N22_RFIDX_WIDTH-1:0] dec_rs2idx,

  output dec_mulhsu,
  output dec_mul   ,
  output dec_div   ,
  output dec_rem   ,
  output dec_divu  ,
  output dec_remu  ,

  output dec_rv32,
  output dec_bjp,
  output dec_jal,
  output dec_jalr,
  output dec_bxx,
  output [`N22_RFIDX_WIDTH-1:0] dec_jalr_rs1idx,
  output [`N22_XLEN-1:0] dec_bjp_imm

  );

  n22_exu_decode u_n22_exu_decode(

  .i_instr(instr),
  .i_prdt_taken(i_prdt_taken),
  .i_muldiv_b2b(i_muldiv_b2b),

  .csr_rvcompm_enable(csr_rvcompm_enable),

  .dec_ilegl(),
  .dec_ilegl_prv(),

  .dec_rs1x0(),
  .dec_rs2x0(),
  .dec_rs1en(dec_rs1en),
  .dec_rs2en(dec_rs2en),
  .dec_rdwen(),
  .dec_rs1idx(dec_rs1idx),
  .dec_rs2idx(dec_rs2idx),
  .dec_rdidx(),
  .dec_imm(),

  .i_mmode(i_mmode),
  .i_dmode(i_dmode),
  .dec_mmode (),
  .dec_dmode (),
  .dec_x0base(),

  .dec_alu_op  (),
  .dec_agu_op  (),
  .dec_bjp_op  (),
  .dec_csr_op  (),
  .dec_alu_info(),
  .dec_agu_info(),
  .dec_bjp_info(),
  .dec_csr_info(),



  .i_replaced     (i_replaced),
  .dec_replaced   (),


  .dec_mulhsu(dec_mulhsu),
  .dec_mul   (dec_mul   ),
  .dec_div   (dec_div   ),
  .dec_rem   (dec_rem   ),
  .dec_divu  (dec_divu  ),
  .dec_remu  (dec_remu  ),

`ifdef N22_HAS_STACKSAFE
  .dec_rdsp(),
`endif

`ifdef N22_HAS_MULDIV
  .dec_muldiv_info(),
  .dec_muldiv_op(),
`endif

  .dec_rv32(dec_rv32),
  .dec_bjp (dec_bjp ),
  .dec_jal (dec_jal ),
  .dec_jalr(dec_jalr),
  .dec_bxx (dec_bxx ),
  .dec_execit (dec_execit),
  .dec_execit_imm(dec_execit_imm),
`ifdef N22_HAS_PMONITOR
  .dec_pmon_evts(),
`endif
  .dec_jalr_rs1idx(dec_jalr_rs1idx),
  .dec_bjp_imm    (dec_bjp_imm    )
  );


endmodule


`include "global.inc"

module n22_ifu_litebpu #(
 parameter N22_DLM_BASE_ADDR        = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_ILM_BASE_ADDR        = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_PPI_BASE_ADDR        = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_FIO_BASE_ADDR        = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION0_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION1_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION2_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION3_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION4_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION5_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION6_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION7_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_TMR_BASE_ADDR        = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_CLIC_BASE_ADDR       = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEBUG_BASE_ADDR      = {(`N22_ADDR_SIZE){1'b0}}
)(

  input  ifu_rsp_hsked,
  `ifdef N22_HAS_DYNAMIC_BPU
  input  bpu_updt_ena ,
  input  bpu_updt_take,
  input  [`N22_BPU_IDX_W-1:0] bpu_updt_idx,
  `endif

  input  replaced,

  input  csr_bpu_enable,

  input  [`N22_PC_SIZE-1:0] pc,
  input  dmode,

  input  dec_jal,
  input  dec_jalr,
  input  dec_bxx,
  input  [`N22_XLEN-1:0] dec_bjp_imm,
  input  [`N22_RFIDX_WIDTH-1:0] dec_jalr_rs1idx,

  input  oitf_empty,
  input  ir_empty,
  input  ir_rs2en,
  input  jalr_rs1idx_cam_irrdidx,

  output bpu_wait,
  output prdt_taken,
  output [`N22_BPU_IDX_W-1:0] prdt_bpu_idx,

  output [`N22_PC_SIZE-1:0] prdt_pc_add_op1,
  output [`N22_PC_SIZE-1:0] prdt_pc_add_op2,

  input  dec_i_valid,
  input  dec_i_err,

  output bpu2rf_rs2_ena,
  input  ir_valid_clr_no_flush,
  input  [`N22_XLEN-1:0] rf2bpu_x1,
  input  [`N22_XLEN-1:0] rf2bpu_rs2,

  input  clk,
  input  rst_n
  );



  wire s0;

  wire s1;
  `ifdef N22_HAS_DYNAMIC_BPU
  wire s2;
  `endif

  assign prdt_taken   = (dec_jal | dec_jalr | (dec_bxx & s0));

    `ifdef N22_HAS_BTFN_BPU
  assign s1 = csr_bpu_enable ? dec_bjp_imm[`N22_XLEN-1] : 1'b1;
    `else
  assign s1 = 1'b1;
    `endif

  `ifdef N22_HAS_DYNAMIC_BPU
  wire [`N22_PC_SIZE-1:0] s3 = pc;
  n22_ifu_bpu u_ifu_bpu(
    .csr_bpu_enable(csr_bpu_enable),

    .updt_bpu_ena (bpu_updt_ena ),
    .updt_bpu_take(bpu_updt_take),
    .updt_bpu_idx (bpu_updt_idx ),

    .prdt_bpu_pc  (s3),
    .prdt_bpu_take(s2),
    .prdt_bpu_idx (prdt_bpu_idx),
    .clk      (clk  ),
    .rst_n    (rst_n)
  );
  assign s0 = csr_bpu_enable ? s2 : s1;
  `endif
  `ifndef N22_HAS_DYNAMIC_BPU
  assign prdt_bpu_idx = `N22_BPU_IDX_W'b0;
  assign s0 = s1;
  `endif



  wire s4 = dec_i_valid & (~dec_i_err);


  wire s5 = (dec_jalr_rs1idx == `N22_RFIDX_WIDTH'd0);
  wire s6 = (dec_jalr_rs1idx == `N22_RFIDX_WIDTH'd1);
  wire s7 = (~s5) & (~s6);

  wire s8 = s4 & dec_jalr & s6 & ((~oitf_empty) | (jalr_rs1idx_cam_irrdidx));
  wire s9 = s4 & dec_jalr & s7 & ((~oitf_empty) | (~ir_empty));


  wire s10;
  wire s11 = (s9 & oitf_empty & (~ir_empty)) & (~jalr_rs1idx_cam_irrdidx) & (ir_valid_clr_no_flush | (~ir_rs2en));

  wire s12 =
        s4 & dec_jalr & s7 &
        (~s10);
  wire s13 = s12 & (
                               (~s9)
                             | s11
                      );
  wire s14 = s12 & (
                               (~s9)
                               );

  wire s15 = ifu_rsp_hsked;
  wire s16 = s13 |   s15;
  wire s17 = s13 & (~s15);

  n22_gnrl_dfflr #(1) rs1xn_rdrf_dfflr (s16, s17, s10, clk, rst_n);

  assign bpu2rf_rs2_ena = s13;

  assign bpu_wait = s8 | s9
                  | s14;

  assign prdt_pc_add_op1 =
                          (replaced & dec_jal) ? {pc[`N22_PC_SIZE-1:21],21'b0} :
                           (dec_bxx | dec_jal) ? pc[`N22_PC_SIZE-1:0]
                         : (dec_jalr & s5) ? (
                                        `ifdef N22_HAS_DEBUG
                                            dmode ? N22_DEBUG_BASE_ADDR :
                                        `endif
                                            `N22_PC_SIZE'b0 )
                         : (dec_jalr & s6) ? rf2bpu_x1[`N22_PC_SIZE-1:0]
                         : rf2bpu_rs2[`N22_PC_SIZE-1:0];

  assign prdt_pc_add_op2 =
                           (replaced & dec_jal) ? {{`N22_ADDR_SIZE-21{1'b0}}, dec_bjp_imm[21-1:0]} :
                          dec_bjp_imm[`N22_PC_SIZE-1:0];

endmodule

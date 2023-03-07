
`include "global.inc"

module n22_exu_alu_bjp(

  input  bjp_i_valid,
  output bjp_i_ready,

  input  [`N22_XLEN-1:0] bjp_i_rs1,
  input  [`N22_XLEN-1:0] bjp_i_rs2,
  input  [`N22_PC_SIZE-1:0] bjp_i_pc,
  input  bjp_i_replaced,
  input  [`N22_DECINFO_BJP_WIDTH-1:0] bjp_i_info,
  input  [`N22_BPU_IDX_W-1:0] bjp_i_prdt_bpu_idx,

  output bjp_o_valid,
  input  bjp_o_ready,
  output [`N22_XLEN-1:0] bjp_o_wbck_wdat,
  output bjp_o_wbck_err,
  output bjp_o_cmt_bjp,
  output bjp_o_cmt_mret,
  output bjp_o_cmt_dret,
  output bjp_o_cmt_fencei,
  output bjp_o_cmt_prdt,
  output bjp_o_cmt_rslv,

  `ifdef N22_HAS_DYNAMIC_BPU
  output  bpu_updt_ena ,
  output  bpu_updt_take,
  output  [`N22_BPU_IDX_W-1:0] bpu_updt_idx,
  `endif


  output [`N22_XLEN-1:0] bjp_req_alu_op1,
  output [`N22_XLEN-1:0] bjp_req_alu_op2,
  output bjp_req_alu_cmp_eq ,
  output bjp_req_alu_cmp_ne ,
  output bjp_req_alu_cmp_lt ,
  output bjp_req_alu_cmp_gt ,
  output bjp_req_alu_cmp_ltu,
  output bjp_req_alu_cmp_gtu,
  output bjp_req_alu_add,

  input  bjp_req_alu_cmp_res,
  input  [`N22_XLEN-1:0] bjp_req_alu_add_res,

  input  clk,
  input  rst_n
  );

  wire s0      = bjp_i_info [`N22_DECINFO_BJP_BBC ];
  wire s1      = bjp_i_info [`N22_DECINFO_BJP_BBS ];
  wire s2     = bjp_i_info [`N22_DECINFO_BJP_BEQC ];
  wire s3     = bjp_i_info [`N22_DECINFO_BJP_BNEC ];
  wire [6:0] s4 = bjp_i_info [`N22_DECINFO_BJP_CIMM ];

  wire s5 = (s2 | s3);
  wire [31:0] s6 = {{25{1'b0}}, s4};
  wire s7 = bjp_i_rs1[s4[4:0]];

  wire s8   = bjp_i_info [`N22_DECINFO_BJP_MRET ];
  wire s9   = bjp_i_info [`N22_DECINFO_BJP_DRET ];
  wire s10 = bjp_i_info [`N22_DECINFO_BJP_FENCEI ];
  wire s11   = bjp_i_info [`N22_DECINFO_BJP_BXX ];
  wire s12  = bjp_i_info [`N22_DECINFO_BJP_JUMP ];
  wire s13  = bjp_i_info [`N22_DECINFO_RV32];
  wire s14  = bjp_i_replaced;

  wire s15 = s12;

  wire s16 = bjp_i_info [`N22_DECINFO_BJP_BPRDT ];

  assign bjp_req_alu_op1 = s15 ?
                            bjp_i_pc
                          : bjp_i_rs1;
  assign bjp_req_alu_op2 = s15 ?
                            (
                              s14 ? `N22_XLEN'd2 :
                              s13 ? `N22_XLEN'd4 : `N22_XLEN'd2
                            )
                          : s5 ? s6
                          : bjp_i_rs2;

  assign bjp_o_cmt_bjp = s11 | s12;
  assign bjp_o_cmt_mret = s8;
  assign bjp_o_cmt_dret = s9;
  assign bjp_o_cmt_fencei = s10;

  assign bjp_req_alu_cmp_eq  = bjp_i_info [`N22_DECINFO_BJP_BEQ  ]
                             | s2
                             ;
  assign bjp_req_alu_cmp_ne  = bjp_i_info [`N22_DECINFO_BJP_BNE  ]
                             | s3
                             ;
  assign bjp_req_alu_cmp_lt  = bjp_i_info [`N22_DECINFO_BJP_BLT  ];
  assign bjp_req_alu_cmp_gt  = bjp_i_info [`N22_DECINFO_BJP_BGT  ];
  assign bjp_req_alu_cmp_ltu = bjp_i_info [`N22_DECINFO_BJP_BLTU ];
  assign bjp_req_alu_cmp_gtu = bjp_i_info [`N22_DECINFO_BJP_BGTU ];




  assign bjp_req_alu_add  = s15;

  assign bjp_o_valid     = bjp_i_valid;
  assign bjp_i_ready     = bjp_o_ready;
  assign bjp_o_cmt_prdt  = s16;
  assign bjp_o_cmt_rslv  =
                           s0 ? (~s7) :
                           s1 ? s7 :
                           s12 ? 1'b1 : bjp_req_alu_cmp_res;

  assign bjp_o_wbck_wdat  = bjp_req_alu_add_res;
  assign bjp_o_wbck_err   = 1'b0;

  `ifdef N22_HAS_DYNAMIC_BPU
  assign bpu_updt_ena   = bjp_o_valid & bjp_o_ready & s11;
  assign bpu_updt_take  = bjp_req_alu_cmp_res & s11;
  assign bpu_updt_idx   = bjp_i_prdt_bpu_idx;
  `endif
endmodule

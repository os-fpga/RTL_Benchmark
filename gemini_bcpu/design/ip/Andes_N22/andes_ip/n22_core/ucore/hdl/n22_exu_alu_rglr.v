
`include "global.inc"

module n22_exu_alu_rglr(

  input  alu_i_valid,
  output alu_i_ready,

  input  [`N22_XLEN-1:0] alu_i_rs1,
  input  [`N22_XLEN-1:0] alu_i_rs2,
  input  [`N22_XLEN-1:0] alu_i_imm,
  input  [`N22_PC_SIZE-1:0] alu_i_pc,
  input  [`N22_DECINFO_ALU_WIDTH-1:0] alu_i_info,

  output alu_o_valid,
  input  alu_o_ready,
  output [`N22_XLEN-1:0] alu_o_wbck_wdat,
  output alu_o_wbck_err,
  output alu_o_cmt_ecall,
  output alu_o_cmt_ebreak,
  output alu_o_cmt_wfi,


  output alu_req_alu_add ,
  output alu_req_alu_sub ,
  output alu_req_alu_xor ,
  output alu_req_alu_sll ,
  output alu_req_alu_srl ,
  output alu_req_alu_sra ,
  output alu_req_alu_or  ,
  output alu_req_alu_and ,
  output alu_req_alu_slt ,
  output alu_req_alu_sltu,
  output alu_req_alu_lui ,
  output [`N22_XLEN-1:0] alu_req_alu_op1,
  output [`N22_XLEN-1:0] alu_req_alu_op2,


  input  [`N22_XLEN-1:0] alu_req_alu_res,

  input  clk,
  input  rst_n
  );

  wire s0 = alu_i_info[`N22_DECINFO_ALU_LEA_H ];
  wire s1 = alu_i_info[`N22_DECINFO_ALU_LEA_W ];
  wire s2 = alu_i_info[`N22_DECINFO_ALU_LEA_D ];

  wire s3          = alu_i_info[`N22_DECINFO_ALU_BFOS];
  wire s4          = alu_i_info[`N22_DECINFO_ALU_BFOZ];
  wire [4:0] s5  = alu_i_info[`N22_DECINFO_ALU_BFLSB ];
  wire [4:0] s6  = alu_i_info[`N22_DECINFO_ALU_BFMSB ];
  wire s7           = alu_i_info[`N22_DECINFO_ALU_FFB     ];
  wire s8       = alu_i_info[`N22_DECINFO_ALU_FFZMISM ];
  wire s9        = alu_i_info[`N22_DECINFO_ALU_FFMISM  ];
  wire s10        = alu_i_info[`N22_DECINFO_ALU_FLMISM  ];

  wire s11 = s7 | s8 | s9 | s10;

  wire s12 = ~(|alu_i_rs1[7:0]);
  wire s13 = ~(|alu_i_rs1[15:8]);
  wire s14 = ~(|alu_i_rs1[23:16]);
  wire s15 = ~(|alu_i_rs1[31:24]);

  wire s16 = ~(|alu_req_alu_res[7:0]);
  wire s17 = ~(|alu_req_alu_res[15:8]);
  wire s18 = ~(|alu_req_alu_res[23:16]);
  wire s19 = ~(|alu_req_alu_res[31:24]);

  wire s20 = ~s16;
  wire s21 = ~s17;
  wire s22 = ~s18;
  wire s23 = ~s19;

  wire s24 = s20 | s12;
  wire s25 = s21 | s13;
  wire s26 = s22 | s14;
  wire s27 = s23 | s15;



  wire s28 = (s7     & s16     )
                           | (s8 & s24)
                           | (s9  & s20     )
                           | (s10  & s20      & (~s21) & (~s22) & (~s23));

  wire s29 = (s7     & s17      & (~s16     ))
                           | (s8 & s25 & (~s24))
                           | (s9  & s21      & (~s20     ))
                           | (s10  & s21      & (~s22) & (~s23));

  wire s30 = (s7     & s18      & (~s16     ) & (~s17     ))
                           | (s8 & s26 & (~s24) & (~s25))
                           | (s9  & s22      & (~s20     ) & (~s21     ))
                           | (s10  & s22      & (~s23) );

  wire s31 = (s7     & s19      & (~s16     ) & (~s17     ) & (~s18     ))
                           | (s8 & s27 & (~s24) & (~s25) & (~s26))
                           | (s9  & s23      & (~s20     ) & (~s21     ) & (~s22     ))
                           | (s10  & s23      );


  wire [31:0] s32= 32'hFFFF_FFFC;
  wire [31:0] s33= 32'hFFFF_FFFD;
  wire [31:0] s34= 32'hFFFF_FFFE;
  wire [31:0] s35= 32'hFFFF_FFFF;
  wire [31:0] s36  = 32'h0;

  wire [31:0] s37  =
                                 ({32{s28}} & s32) |
                                 ({32{s29}} & s33) |
                                 ({32{s30}} & s34) |
                                 ({32{s31}} & s35) ;

  wire signed [ 5:0] s38 = $signed({1'b0,s6}) - $signed({1'b0,s5});
  wire [ 5:0] s39 = $unsigned(s38);

  wire s40 = (s6 == 5'b0);
  wire s41 = s39[5];
  wire s42 = ~s41;

  wire [32:0] s43 = ~(33'b0);
  wire [ 4:0] s44 = s42 ? (s39[4:0]) : s5;
  wire [32:0] s45 = (s43 << s44) << 5'b1;
  wire [32:0] s46 = s45;

  wire [`N22_XLEN-1:0] s47 = alu_req_alu_res;

  wire [`N22_XLEN-1:0] s48 = s42 ? alu_i_rs1 : s47;
  wire [4:0] s49 = s42 ? s6 : s5;
  wire s50 = s48[s49];
  wire [31:0] s51 = {32{s3 ? s50 : 1'b0}};

  wire [31:0] s52 = (s51 & s46[31:0])
                         | (s47 & (~s46[31:0]));

  wire s53 = s40 | s41;
  wire s54 = s42 & (~s40);
  wire [`N22_XLEN-1:0] s55 = (s40 | s42) ? {27'b0,s5} : {27'b0,s6};

  wire s56 = (s3 | s4);

  wire s57  = alu_i_info [`N22_DECINFO_ALU_OP2IMM ];
  wire s58   = alu_i_info [`N22_DECINFO_ALU_OP1PC  ];

  assign alu_req_alu_op1  = s58  ? alu_i_pc  : alu_i_rs1;
  assign alu_req_alu_op2  =
                            s7   ? {4{alu_i_rs2[7:0]}}    :
                            s0 ? {alu_i_rs2[30:0],1'b0} :
                            s1 ? {alu_i_rs2[29:0],2'b0} :
                            s2 ? {alu_i_rs2[28:0],3'b0} :
                            s56 ? s55 :
                            s57 ? alu_i_imm : alu_i_rs2;

  wire s59    = alu_i_info [`N22_DECINFO_ALU_NOP ] ;
  wire s60  = alu_i_info [`N22_DECINFO_ALU_ECAL ];
  wire s61 = alu_i_info [`N22_DECINFO_ALU_EBRK ];
  wire s62    = alu_i_info [`N22_DECINFO_ALU_WFI ];

  assign alu_req_alu_add  = alu_i_info [`N22_DECINFO_ALU_ADD ] & (~s59)
                            | s0
                            | s1
                            | s2
                            ;
  assign alu_req_alu_sub  = alu_i_info [`N22_DECINFO_ALU_SUB ];
  assign alu_req_alu_xor  =
                            s11  |
                            alu_i_info [`N22_DECINFO_ALU_XOR ];
  assign alu_req_alu_sll  =
                            s56 ? s53 :
                            alu_i_info [`N22_DECINFO_ALU_SLL ];
  assign alu_req_alu_srl  =
                            s56 ? s54 :
                            alu_i_info [`N22_DECINFO_ALU_SRL ];
  assign alu_req_alu_sra  = alu_i_info [`N22_DECINFO_ALU_SRA ];
  assign alu_req_alu_or   = alu_i_info [`N22_DECINFO_ALU_OR  ];
  assign alu_req_alu_and  = alu_i_info [`N22_DECINFO_ALU_AND ];
  assign alu_req_alu_slt  = alu_i_info [`N22_DECINFO_ALU_SLT ];
  assign alu_req_alu_sltu = alu_i_info [`N22_DECINFO_ALU_SLTU];
  assign alu_req_alu_lui  = alu_i_info [`N22_DECINFO_ALU_LUI ];


  assign alu_o_valid = alu_i_valid;
  assign alu_i_ready = alu_o_ready;
  assign alu_o_wbck_wdat =
                (s11     ) ? s37 :
                (s56) ? s52 :
                           alu_req_alu_res;

  assign alu_o_cmt_ecall  = s60;
  assign alu_o_cmt_ebreak = s61;
  assign alu_o_cmt_wfi = s62;

  assign alu_o_wbck_err = alu_o_cmt_ecall | alu_o_cmt_ebreak | alu_o_cmt_wfi;

endmodule

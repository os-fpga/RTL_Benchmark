
`include "global.inc"

module n22_ifu_ifetch #(
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
  input [31:0] csr_uitb_addr,


  output reset_flag_r,
  output[`N22_PC_SIZE-1:0] inspect_pc,


  input  [`N22_PC_SIZE-1:0] pc_rtvec,
  output ifu_req_valid,
  input  ifu_req_ready,
  output [`N22_PC_SIZE-1:0] ifu_req_pc,
  output ifu_req_seq,
  output ifu_req_seq_rv32,
  output ifu_req_mmode,
  output ifu_req_dmode,
  output ifu_req_vmode,

  output ifu_flush_req,


  input  ifu_rsp_valid,
  output ifu_rsp_ready,
  input  ifu_rsp_err,
  input  ifu_rsp_err_btm,
  input  ifu_rsp_pmperr,
  input  [`N22_INSTR_SIZE-1:0] ifu_rsp_instr,

  input  csr_icache_enable,
  input  csr_bpu_enable,
  input  csr_rvcompm_enable,

  `ifdef N22_HAS_ICACHE
  output icache_flush_req,
  input  icache_flush_done,
  input  icache_no_outs,
  `endif

  `ifdef N22_HAS_CLIC
  output minhv_clear_r,
  `endif
  output [`N22_INSTR_SIZE-1:0] ifu_o_ir,
  output [`N22_PC_SIZE-1:0] ifu_o_pc,
  output ifu_o_pc_mmode,
  output ifu_o_replaced,
  output [`N22_PC_SIZE-1:0] ifu_o_replaced_pc,
  output ifu_o_pc_dmode,
  output ifu_o_pc_vld,
  output [`N22_RFIDX_WIDTH-1:0] ifu_o_rs1idx,
  output [`N22_RFIDX_WIDTH-1:0] ifu_o_rs2idx,
  output ifu_o_prdt_taken,
  output [`N22_BPU_IDX_W-1:0] ifu_o_prdt_bpu_idx,
  output ifu_o_misalgn,
  output ifu_o_buserr,
  output ifu_o_buserr_btm,
  output ifu_o_pmperr,
  output ifu_o_muldiv_b2b,
  output ifu_o_valid,
  input  ifu_o_ready,

  `ifdef N22_HAS_DYNAMIC_BPU
  input  bpu_updt_ena ,
  input  bpu_updt_take,
  input  [`N22_BPU_IDX_W-1:0] bpu_updt_idx,
  `endif
  output  p1_flush_ack,
  input   p1_flush_req,
  input   [`N22_PC_SIZE-1:0] p1_flush_pc,
  input   p1_flush_fencei,
  input   p1_flush_pc_mmode,
  input   p1_flush_pc_dmode,
  input   p1_flush_pc_vmode,

  output  p2_flush_ack,
  input   p2_flush_req,
  input   [`N22_PC_SIZE-1:0] p2_flush_pc,
  input   p2_flush_pc_mmode,
  input   p2_flush_pc_dmode,
  input   p2_flush_pc_vmode,
  input   p2_flush_fencei,


  input  ifu_halt_req,
  output ifu_halt_ack,

  input  pft_no_outs,


  input  oitf_empty,
  input  [`N22_XLEN-1:0] rf2ifu_x1,
  input  [`N22_XLEN-1:0] rf2ifu_rs2,
  input  dec2ifu_rs2en,
  input  dec2ifu_rden,
  input  [`N22_RFIDX_WIDTH-1:0] dec2ifu_rdidx,
  input  dec2ifu_mulhsu,
  input  dec2ifu_div   ,
  input  dec2ifu_rem   ,
  input  dec2ifu_divu  ,
  input  dec2ifu_remu  ,

  input  clk,
  input  rst_n
  );



  wire s0  = (ifu_req_valid & ifu_req_ready) ;
  wire ifu_rsp_hsked  = (ifu_rsp_valid & ifu_rsp_ready) ;
  wire s1 = (ifu_o_valid & ifu_o_ready) ;
  wire s2 = p1_flush_req & p1_flush_ack;
  wire s3 = p2_flush_req & p2_flush_ack;
  wire s4 = s2 | s3;



  n22_gnrl_dffrs #(1) reset_flag_dffrs (1'b0, reset_flag_r, clk, rst_n);
  wire s5;
  wire s6 = (~s5) & reset_flag_r;
  wire s7 = s5 & s0;
  wire s8 = s6 | s7;
  wire s9 = s6 | (~s7);

  n22_gnrl_dfflr #(1) reset_req_dfflr (s8, s9, s5, clk, rst_n);

  wire s10 = s5;




  wire s11;
  wire s12;
  wire s13;
  wire s14;
  wire s15;

  wire s16;
  wire s17;
  `ifndef N22_HAS_ICACHE
  wire icache_no_outs = 1'b1;
  `endif
  wire s18 = ifu_halt_req & s17 & pft_no_outs & icache_no_outs;
  wire s19;
  n22_gnrl_dffr #(1) halt_ack_set_dffr (s18, s19, clk, rst_n);

  assign s11 = s19 & (~s14);
  assign s12 = s14 & (~ifu_halt_req);

  assign s13 = s11 | s12;
  assign s15 = s11 | (~s12);

  n22_gnrl_dfflr #(1) halt_ack_dfflr (s13, s15, s14, clk, rst_n);

  assign ifu_halt_ack = s14;


   assign p1_flush_ack = 1'b1;
   assign p2_flush_ack = 1'b1;

   wire s20;
   wire s21;
   wire s22;
   wire s23;

   wire s24 =  (s3);
   wire s25 =  (s2 & (~s0));

   assign s20 = s24 | s25;

   wire s26;
   assign s21 = s26 & s0;

   assign s22 = s20 | s21;
   assign s23 = s20 | (~s21);

   n22_gnrl_dfflr #(1) dly_flush_dfflr (s22, s23, s26, clk, rst_n);
   wire s27 = s26;


   wire s28;

  `ifndef N22_HAS_ICACHE
   wire icache_flush_done = 1'b1;
  `endif

   wire s29 = s20;
   wire s30 = (s24 & p2_flush_fencei) | (s25 & p1_flush_fencei);
   wire s31 = s28 & (csr_icache_enable ? icache_flush_done : s16);
   wire s32 = 1'b0;

   wire s33 = s29 | s31;
   wire s34 = s29 ? s30 :
                               s31 ? s32 : s28;
   n22_gnrl_dfflr #(1) dly_flush_fencei_dfflr (s33, s34, s28, clk, rst_n);

   wire s35 = s28;

   wire s36 = s2 | s27;
   wire s37 = s2 | s3 | s27;



  wire s38;
  wire s39;
  wire s40;
  wire s41;
  wire s42;

  wire s43;


  wire  s44;
  wire  s45;
  wire [11:0] s46;

  wire s47;
  wire s48;
  wire s49;
  wire s50;
  wire s51;
  wire s52;
  wire s53 = s50 & (~s49);
  wire s54 = s53 & s0 & (~s52);
  wire s55 = s53 & ifu_rsp_hsked & s52;
  wire s56 = s54 | s55;
  wire s57 = s54 & (~s55);
  n22_gnrl_dfflr #(1) vfetch_1st_rsp_phase_dfflr(s56, s57, s52, clk, rst_n);

  wire s58 = s52 & ~ifu_rsp_err;

  wire s59 = s51 & s49;
  assign s38  = ifu_rsp_hsked & (~s37)
                         & (~s45)
                       `ifdef N22_HAS_CLIC
                         & (~s58)
                       `endif
                         ;
  assign s39  = s1 | (s4 & s41);
  wire s60  = s1 | (s2 & s41);
  wire ir_valid_clr_no_flush  = s1;


  assign s40  = s38  | s39;
  assign s42  = s38  | (~s39);


  n22_gnrl_dfflr #(1) ir_valid_dfflr (s40, s42, s41, clk, rst_n);
  n22_gnrl_dfflr #(1) ir_pc_vld_dfflr (s40, s42, s43, clk, rst_n);

  wire [`N22_INSTR_SIZE-1:0] s61 = ifu_rsp_instr;
  wire                     s62 = ifu_rsp_err;
  wire                     s63 = ifu_rsp_err_btm;
  wire                     s64 = ifu_rsp_pmperr;

  wire s65;
  n22_gnrl_dfflr #(1) ifu_pmperr_dfflr(s38, s64, s65, clk, rst_n);
  wire s66;
  n22_gnrl_dfflr #(1) ifu_err_dfflr(s38, s62, s66, clk, rst_n);
  wire s67;
  n22_gnrl_dfflr #(1) ifu_err_btm_dfflr(s38, s63, s67, clk, rst_n);
  wire prdt_taken;
  wire s68;
  wire [`N22_BPU_IDX_W-1:0] prdt_bpu_idx;
  wire [`N22_BPU_IDX_W-1:0] s69;
  n22_gnrl_dfflr #(1) ifu_prdt_taken_dfflr (s38, prdt_taken, s68, clk, rst_n);
  n22_gnrl_dfflr #(`N22_BPU_IDX_W) prdt_bpu_idx_dfflr (s38, prdt_bpu_idx, s69, clk, rst_n);
  wire s70;
  wire s71;
  n22_gnrl_dfflr #(1) ir_muldiv_b2b_dfflr (s38, 1'b0, s71, clk, rst_n);
  wire [`N22_INSTR_SIZE-1:0] s72;
  wire s73;
  wire s74 = s38 & s73;
  wire s75 = s38;
  n22_gnrl_dfflr #(`N22_INSTR_SIZE/2) ifu_hi_ir_dfflr (s74, s61[31:16], s72[31:16], clk, rst_n);
  n22_gnrl_dfflr #(`N22_INSTR_SIZE/2) ifu_lo_ir_dfflr (s75, s61[15: 0], s72[15: 0], clk, rst_n);

  wire s76;
  wire s77;
  wire [`N22_RFIDX_WIDTH-1:0] s78;
  wire [`N22_RFIDX_WIDTH-1:0] s79;

  `ifndef N22_HAS_FPU
  wire s80        = 1'b0;
  wire s81  = 1'b0;
  wire s82  = 1'b0;
  wire s83  = 1'b0;
  wire s84 = 1'b0;
  wire s85 = 1'b0;
  wire s86 = 1'b0;
  wire [`N22_RFIDX_WIDTH-1:0] s87 = `N22_RFIDX_WIDTH'b0;
  wire [`N22_RFIDX_WIDTH-1:0] s88 = `N22_RFIDX_WIDTH'b0;
  `endif

  wire [`N22_RFIDX_WIDTH-1:0] s89;
  wire [`N22_RFIDX_WIDTH-1:0] s90;
  wire bpu2rf_rs2_ena;
  wire s91 = (s80 & s38 & s81 & (~s84)) |
                       ((~s80) & s38 & s76) ;
  wire s92 = (s80 & s38 & s82 & (~s85)) |
                       ((~s80) & s38 & s77) |
                       (bpu2rf_rs2_ena);
  wire [`N22_RFIDX_WIDTH-1:0] s93 = s80 ? s87 : s78;
  wire [`N22_RFIDX_WIDTH-1:0] s94 = bpu2rf_rs2_ena ? s78 : s80 ? s88 : s79;
  n22_gnrl_dfflr #(`N22_RFIDX_WIDTH) ir_rs1idx_dfflr (s91, s93, s89, clk, rst_n);
  n22_gnrl_dfflr #(`N22_RFIDX_WIDTH) ir_rs2idx_dfflr (s92, s94, s90, clk, rst_n);

  wire s95;
  wire s96 = s95;
  wire s97;
  n22_gnrl_dfflr #(1) ifu_replaced_dfflr (s38, s96,  s97, clk, rst_n);
  assign ifu_o_replaced = s97;

  wire s98;
  wire[`N22_PC_SIZE-1:0] s99;
  wire [`N22_PC_SIZE-1:0] s100 = s99;
  wire [`N22_PC_SIZE-1:0] s101;
  wire s102 = s98;
  n22_gnrl_dfflr #(`N22_PC_SIZE) ifu_replaced_pc_dfflr (s102, s100,  s101, clk, rst_n);
  assign ifu_o_replaced_pc  = s101;

  wire s103;
  wire s104;
  wire s105 = s103;
  wire s106 = s104;
  wire [`N22_PC_SIZE-1:0] s107;
  wire [`N22_PC_SIZE-1:0] s108 = s107;
  wire [`N22_PC_SIZE-1:0] s109;
  wire s110;
  wire s111;
  n22_gnrl_dfflr #(`N22_PC_SIZE) ifu_pc_dfflr (s38, s108,  s109, clk, rst_n);
  n22_gnrl_dfflr #(1) ifu_pc_mmode_dfflr (s38, s105,  s110, clk, rst_n);
  n22_gnrl_dfflr #(1) ifu_pc_dmode_dfflr (s38, s106,  s111, clk, rst_n);

  assign ifu_o_ir  = s72;
  assign ifu_o_pc  = s109;
  assign ifu_o_pc_mmode  = s110;
  assign ifu_o_pc_dmode  = s111;
  assign ifu_o_misalgn = 1'b0;
  assign ifu_o_buserr  = s66;
  assign ifu_o_buserr_btm  = s67;
  assign ifu_o_pmperr  = s65;
  assign ifu_o_rs1idx = s89;
  assign ifu_o_rs2idx = s90;
  assign ifu_o_prdt_taken = s68;
  assign ifu_o_prdt_bpu_idx = s69;
  assign ifu_o_muldiv_b2b = s71;

  assign ifu_o_valid  = s41;
  assign ifu_o_pc_vld = s43;

  assign s47   = (~s41) | s60;

  wire ir_empty = ~s41;
  wire ir_rs2en = dec2ifu_rs2en;
  wire s112 = dec2ifu_rden;
  wire [`N22_RFIDX_WIDTH-1:0] s113 = dec2ifu_rdidx;
  wire [`N22_RFIDX_WIDTH-1:0] s114;
  wire jalr_rs1idx_cam_irrdidx = s112 & (s114 == s113) & s41;

  wire s115 ;
  wire s116 ;
  wire s117 ;
  wire s118;
  wire s119;
  assign s70 =
      (
          ( s115 & dec2ifu_mulhsu)
        | ( s116  & dec2ifu_rem)
        | ( s117  & dec2ifu_div)
        | ( s118 & dec2ifu_remu)
        | ( s119 & dec2ifu_divu)
      )
      & (s89 == s93)
      & (s90 == s94)
      & (~(s89 == s113))
      & (~(s90 == s113))
      ;

  wire s120;
  wire s121;
  wire s122;
  wire s123;
  wire [`N22_XLEN-1:0] s124;

  assign s51 = s50 & (~ifu_rsp_err);
  n22_ifu_minidec u_n22_ifu_minidec (
      .instr       (s61         ),
      .i_prdt_taken(prdt_taken),
      .i_muldiv_b2b(s70),
      .i_mmode     (s105  ),
      .i_dmode     (s106  ),
      .i_replaced  (s96),

      .csr_rvcompm_enable (csr_rvcompm_enable),

      .dec_rs1en   (s76      ),
      .dec_rs2en   (s77      ),
      .dec_rs1idx  (s78     ),
      .dec_rs2idx  (s79     ),

      .dec_rv32    (s73       ),
      .dec_bjp     (s120        ),
      .dec_jal     (s121        ),
      .dec_jalr    (s122       ),
      .dec_bxx     (s123        ),

      .dec_mulhsu  (),
      .dec_mul     (s115 ),
      .dec_div     (s116 ),
      .dec_rem     (s117 ),
      .dec_divu    (s118),
      .dec_remu    (s119),

      .dec_execit     (s44),
      .dec_execit_imm(s46),



      .dec_jalr_rs1idx (s114),
      .dec_bjp_imm (s124    )

  );

  wire bpu_wait;
  wire [`N22_PC_SIZE-1:0] prdt_pc_add_op1;
  wire [`N22_PC_SIZE-1:0] prdt_pc_add_op2;

  n22_ifu_litebpu   #(
    .N22_DLM_BASE_ADDR       (N22_DLM_BASE_ADDR       ),
    .N22_ILM_BASE_ADDR       (N22_ILM_BASE_ADDR       ),
    .N22_PPI_BASE_ADDR       (N22_PPI_BASE_ADDR       ),
    .N22_FIO_BASE_ADDR       (N22_FIO_BASE_ADDR       ),
    .N22_DEVICE_REGION0_BASE (N22_DEVICE_REGION0_BASE ),
    .N22_DEVICE_REGION1_BASE (N22_DEVICE_REGION1_BASE ),
    .N22_DEVICE_REGION2_BASE (N22_DEVICE_REGION2_BASE ),
    .N22_DEVICE_REGION3_BASE (N22_DEVICE_REGION3_BASE ),
    .N22_DEVICE_REGION4_BASE (N22_DEVICE_REGION4_BASE ),
    .N22_DEVICE_REGION5_BASE (N22_DEVICE_REGION5_BASE ),
    .N22_DEVICE_REGION6_BASE (N22_DEVICE_REGION6_BASE ),
    .N22_DEVICE_REGION7_BASE (N22_DEVICE_REGION7_BASE ),
    .N22_TMR_BASE_ADDR       (N22_TMR_BASE_ADDR       ),
    .N22_CLIC_BASE_ADDR      (N22_CLIC_BASE_ADDR      ),
    .N22_DEBUG_BASE_ADDR     (N22_DEBUG_BASE_ADDR     )
  )  u_n22_ifu_litebpu(

    .csr_bpu_enable (csr_bpu_enable),

    .ifu_rsp_hsked  (ifu_rsp_hsked),

  `ifdef N22_HAS_DYNAMIC_BPU
    .bpu_updt_ena             (bpu_updt_ena ),
    .bpu_updt_take            (bpu_updt_take),
    .bpu_updt_idx             (bpu_updt_idx),
  `endif

    .replaced                 (s95),

    .dmode                    (s104),
    .pc                       (s107),

    .dec_jal                  (s121  ),
    .dec_jalr                 (s122 ),
    .dec_bxx                  (s123  ),
    .dec_bjp_imm              (s124  ),
    .dec_jalr_rs1idx          (s114  ),

    .dec_i_valid              (ifu_rsp_valid),
    .dec_i_err                (ifu_rsp_err),
    .ir_valid_clr_no_flush  (ir_valid_clr_no_flush),

    .oitf_empty               (oitf_empty),
    .ir_empty                 (ir_empty  ),
    .ir_rs2en                 (ir_rs2en  ),

    .jalr_rs1idx_cam_irrdidx  (jalr_rs1idx_cam_irrdidx),

    .bpu_wait                 (bpu_wait       ),
    .prdt_taken               (prdt_taken     ),
    .prdt_bpu_idx             (prdt_bpu_idx   ),
    .prdt_pc_add_op1          (prdt_pc_add_op1),
    .prdt_pc_add_op2          (prdt_pc_add_op2),

    .bpu2rf_rs2_ena           (bpu2rf_rs2_ena),
    .rf2bpu_x1                (rf2ifu_x1    ),
    .rf2bpu_rs2               (rf2ifu_rs2   ),

    .clk                      (clk  ) ,
    .rst_n                    (rst_n )
  );
  wire [`N22_PC_SIZE-1:0] s125 =
                   s95 ? `N22_PC_SIZE'd2 :
                   ((~ifu_rsp_err) & s73) ? `N22_PC_SIZE'd4 : `N22_PC_SIZE'd2;

  wire s126;
  wire s127;
  wire s128;
  wire s129;
  wire [`N22_PC_SIZE-1:0] s130;
  wire [`N22_PC_SIZE-1:0] s131;
  wire s132;
  wire s133;
  wire s134;
  wire s135;

  wire s136 = s120 & prdt_taken & (~ifu_rsp_err);





  wire [`N22_PC_SIZE-1:0] s137;
  wire s138;
  wire s139;
  wire s140;
  wire s141;

  wire s142;
  wire s143;
  wire s144;
  wire s145;
  wire [`N22_PC_SIZE-1:0] s146;
  wire [`N22_PC_SIZE-1:0] s147;

  assign{
         s146,
         s147,
         s143,
         s142,
         s144,
         s145
        } =
                s10   ? {pc_rtvec,
                                   `N22_PC_SIZE'b0,
                                   1'b1,
                                   1'b0,
                                   1'b0,
                                   1'b0}:
                s58 ? {ifu_rsp_instr[`N22_PC_SIZE-1:1],1'b0,
                                  `N22_PC_SIZE'b0,
                                  s103,
                                  s104,
                                  s50,
                                  1'b1
                             } :
                s45 ? {csr_uitb_addr[`N22_PC_SIZE-1:0],
                                  {{`N22_PC_SIZE-12{1'b0}},s46},
                                  s103,
                                  s104,
                                  1'b0,
                                  1'b0
                                  } :

                 s136 ? {prdt_pc_add_op1,
                           prdt_pc_add_op2,
                           s103,
                           s104,
                           1'b0,
                           1'b0
                           }    :
                                  {s107,
                                   s125,
                                   s103,
                                   s104,
                                   1'b0,
                                   1'b0
                                   };


  assign ifu_req_seq_rv32 = s73;

  assign s130       = s146 + s147;
  assign s126 = s143;
  assign s127 = s142;
  assign s128 = s144;
  assign s129 = s145;


  assign{
      s137,
      s138,
      s139,
      s140,
      s141
  } =
               s2 ? {
                                 {p1_flush_pc[`N22_PC_SIZE-1:1],1'b0} ,
                                  p1_flush_pc_mmode ,
                                  p1_flush_pc_dmode ,
                                  1'b0 ,
                                  1'b0
                              } :
               s27 ? {
                                {s107[`N22_PC_SIZE-1:1],1'b0} ,
                                 s103 ,
                                 s104 ,
                                 s50,
                                 s49
                              } : {
                                {s130[`N22_PC_SIZE-1:1],1'b0},
                                 s126,
                                 s127,
                                 s128,
                                 s129
                              };

  assign  s45 =  s44 & (~ifu_rsp_err) & (~s95);
  wire s148 = (~s3) & (~s36) & (~s10) & s45
                       `ifdef N22_HAS_CLIC
						 & (~s58)
                       `endif
					   ;
               `ifdef N22_HAS_CLIC

  wire s149 = s58 & ifu_rsp_hsked;
  wire s150 = minhv_clear_r;
  wire s151 = s149 | s150;
  wire s152 = s149 | (~s150);
  n22_gnrl_dfflr #(1) minhv_clear_dfflr (s151, s152, minhv_clear_r, clk, rst_n);

               `endif

  assign {s131,
          s132,
          s133,
          s134,
          s48,
          s135}
         =
               s3 ? { {p2_flush_pc[`N22_PC_SIZE-1:1],1'b0},
                                  p2_flush_pc_mmode,
                                  p2_flush_pc_dmode,
                                  p2_flush_pc_vmode,
                                  1'b0,
                                  1'b0
                                  }:
               s148 ? { s107,
                                         s103 ,
                                         s104 ,
                                         1'b0,
                                         1'b0,
                                         1'b1
                                       }:
                                      {s137,
                                       s138,
                                       s139,
                                       s140,
                                       s141,
                                       1'b0
                                      };

  wire s153;

  assign s98 = s153 & s148;
  assign s99 = s130;






  wire s154 = (~bpu_wait) & (~ifu_halt_req) & (~reset_flag_r);

  wire s155 = s154 | s10 | s36;
  assign ifu_req_seq = (~s36) & (~s10) & (~s136)
                           & (~s45)
                           & (~s95)
                       `ifdef N22_HAS_CLIC
						 & (~s58)
                       `endif
                     ;
  assign ifu_flush_req = s36;
  wire s156;
  wire s157;
  assign s16 = ((~s157) | s156)
                        & ifu_req_ready
                       ;
  assign s17   = (~s157) | ifu_rsp_valid;

  assign ifu_req_valid = s155 &
                             (s16
                             & (
                                 (
                                    (s2 & p1_flush_fencei) |
                                    (s27 & s35)
                                 ) ?
                                 1'b0
                                 : 1'b1)
                             );


  `ifdef N22_HAS_ICACHE
  assign icache_flush_req = (s27 & s35 & csr_icache_enable);
  `endif


  wire s158 = (s36) ? 1'b1 :
                          (s47 & ifu_req_ready & (~bpu_wait));

  assign ifu_rsp_ready = s158;

  assign s153 = s0 | s4;

  n22_gnrl_dfflr #(`N22_PC_SIZE) pc_dfflr (s153, s131, s107, clk, rst_n);

  n22_gnrl_dfflr #(1) pc_mmode_dfflr (s153, s132, s103, clk, rst_n);
  n22_gnrl_dfflr #(1) pc_dmode_dfflr (s153, s133, s104, clk, rst_n);
  n22_gnrl_dfflr #(1) pc_vmode_dfflr (s153, s134, s50, clk, rst_n);
  n22_gnrl_dfflr #(1) pc_vmode_2nd_dfflr (s153,s48,s49, clk, rst_n);
  n22_gnrl_dfflr #(1) replaced_dfflr (s153, s135, s95, clk, rst_n);


  assign inspect_pc = s107;


  assign ifu_req_pc    = s137;
  assign ifu_req_mmode = s138 |
                         s139;
  assign ifu_req_dmode = s139;
  assign ifu_req_vmode = s140 & (~s141);


  wire s159 = s0;
  assign s156 = ifu_rsp_hsked;
  wire s160 = s159 | s156;
  wire s161 = s159 | (~s156);

  n22_gnrl_dfflr #(1) out_flag_dfflr (s160, s161, s157, clk, rst_n);



  `ifndef FPGA_SOURCE
  `ifndef SYNTHESIS
//synopsys translate_off


//synopsys translate_on
`endif
`endif

endmodule


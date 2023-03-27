
`include "global.inc"

module n22_exu_alu #(
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
  input i_alu_op,
  input i_agu_op,
  input i_bjp_op,
  input i_csr_op,
  input [`N22_DECINFO_WIDTH-1:0]  i_alu_info,
  input [`N22_DECINFO_WIDTH-1:0]  i_agu_info,
  input [`N22_DECINFO_WIDTH-1:0]  i_bjp_info,
  input [`N22_DECINFO_WIDTH-1:0]  i_csr_info,

  input i_rv32,
  input [`N22_XLEN-1:0] i_bjp_imm,


  input csr_unalgn_enable,
   `ifdef N22_HAS_ECLIC
  input [31:0] csr_mcause ,
  input [`N22_PC_SIZE-1:0] csr_mepc ,
  input [31:0] csr_mxstatus ,
   `endif
   `ifdef N22_HAS_DEBUG
  input   dbg_mprven,
    `endif
  input   alu_need_excp,
    `ifdef N22_HAS_TRIGM
  input  [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata1,
  input  [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata2,
    `endif


  `ifdef N22_HAS_PMP
  input [`N22_PMP_ENTRY_NUM*`N22_XLEN-1:0] pmpaddr_r,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_r,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_w,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_x,
  input [`N22_PMP_ENTRY_NUM*2-1:0] pmpcfg_bit_a,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_l,
  `endif

  input  mstatus_mprv,
  input  mpp_m_mode,


  input  i_valid,
  output i_ready,

  output i_longpipe,


  `ifdef N22_HAS_CSR_EAI
  `ifndef N22_HAS_EAI
  input  eai_xs_off,
  `endif
  output         eai_csr_valid,
  input          eai_csr_ready,
  output  [31:0] eai_csr_addr,
  output         eai_csr_wr,
  output  [31:0] eai_csr_wdata,
  input   [31:0] eai_csr_rdata,
  `endif



  input  [`N22_ITAG_WIDTH-1:0] i_itag,
  input  [`N22_XLEN-1:0] i_rs1,
  input  [`N22_XLEN-1:0] i_rs2,
  input  [`N22_XLEN-1:0] i_imm,
`ifdef N22_HAS_PMONITOR
  input  [31:0] i_pmon_evts,
`endif
`ifdef N22_HAS_MULDIV
  input  [`N22_DECINFO_MULDIV_WIDTH-1:0] i_muldiv_info,
  input i_muldiv_op,
`endif
  input  [`N22_PC_SIZE-1:0] i_pc,
  input  [`N22_BPU_IDX_W-1:0] i_prdt_bpu_idx,
  input  [`N22_INSTR_SIZE-1:0] i_instr,
  input  i_pc_vld,
  input  [`N22_RFIDX_WIDTH-1:0] i_rdidx,
`ifdef N22_HAS_STACKSAFE
  input  i_rdsp,
`endif
  input  i_rdwen,
  input  i_ilegl,
  input  i_ilegl_prv,
  input  i_buserr,
  input  i_pmperr,
  input  i_misalgn,
  input  i_mmode,
  input  i_dmode,
  input  i_x0base,

  input  flush_pulse,

  `ifdef N22_HAS_DYNAMIC_BPU
  output  bpu_updt_ena ,
  output  bpu_updt_take,
  output  [`N22_BPU_IDX_W-1:0] bpu_updt_idx,
  `endif
  output cmt_o_bjp_valid,

  output cmt_o_valid,
  input  cmt_o_ready,
  output cmt_o_pc_vld,
  output [`N22_PC_SIZE-1:0] cmt_o_pc,
  output [`N22_INSTR_SIZE-1:0] cmt_o_instr,
  output [`N22_XLEN-1:0]    cmt_o_bjp_imm,
  output cmt_o_rv32,
  output cmt_o_bjp,
  output cmt_o_mret,
  output cmt_o_dret,
  output cmt_o_ecall,
  output cmt_o_ebreak,
  output cmt_o_fencei,
  output cmt_o_wfi,
  output cmt_o_ifu_misalgn,
  output cmt_o_ifu_buserr,
  output cmt_o_ifu_pmperr,
  output cmt_o_ifu_ilegl,
  output cmt_o_ifu_ilegl_ilginstr ,
  output cmt_o_ifu_ilegl_prvinstr ,
  output cmt_o_ifu_ilegl_noncsr ,
  output cmt_o_ifu_ilegl_prvcsr ,
  output cmt_o_ifu_ilegl_wrocsr ,
  output cmt_o_bjp_prdt,
  output cmt_o_bjp_rslv,
  output cmt_o_misalgn,
  output cmt_o_ld,
  output cmt_o_stamo,
  output cmt_o_pmperr ,
  output [`N22_ADDR_SIZE-1:0] cmt_o_badaddr,
`ifdef N22_HAS_PMONITOR
  output [31:0] cmt_o_pmon_evts,
`endif
`ifdef N22_HAS_TRIGM
  output cmt_o_trigaddr_2dm  ,
  output cmt_o_trigaddr_2excp,
`endif
  input  i_replaced,
  input  [`N22_PC_SIZE-1:0] i_replaced_pc,
  output cmt_o_replaced,
  output [`N22_PC_SIZE-1:0] cmt_o_replaced_pc,


  output wbck_o_valid,
  input  wbck_o_ready,
  output [`N22_XLEN-1:0] wbck_o_wdat,
  output [`N22_RFIDX_WIDTH-1:0] wbck_o_rdidx,
  output wbck_o_wen,
`ifdef N22_HAS_STACKSAFE
  output wbck_o_rdsp,
`endif

`ifdef N22_INDEP_MULDIV
  output div_longp_o_valid,
  input  div_longp_o_ready,
  output [`N22_XLEN-1:0] div_longp_o_wdat,
  output div_longp_o_err,
  output [`N22_ITAG_WIDTH-1:0] div_longp_o_itag,
`endif

  output csr_ena,
  output csr_wr_en,
  output csr_rd_en,
  output [12-1:0] csr_idx,

  input  nonflush_cmt_ena,
  input  csr_access_ilgl,
  input  csr_ilegl_noncsr,
  input  csr_ilegl_prvcsr,
  input  csr_ilegl_wrocsr,
  input  [`N22_XLEN-1:0] read_csr_dat,
  input  [`N22_XLEN-1:0] read_msts_dat,
  output [`N22_XLEN-1:0] wbck_csr_msts_dat,
  output [`N22_XLEN-1:0] wbck_csr_dat,

  output [`N22_XLEN-1:0] csr_op1,

  output                         agu_icb_cmd_sel,
  output                         agu_icb_cmd_valid,
  input                          agu_icb_cmd_ready,
  output [`N22_ADDR_SIZE-1:0]   agu_icb_cmd_addr,
  output                         agu_icb_cmd_read,
  output [`N22_XLEN-1:0]        agu_icb_cmd_wdata,
  output [`N22_XLEN_MW-1:0]      agu_icb_cmd_wmask,
  output [1:0]                   agu_icb_cmd_size,
  output                         agu_icb_cmd_usign,
  output [`N22_ITAG_WIDTH -1:0] agu_icb_cmd_itag,
  output                         agu_icb_cmd_x0base,
  output                         agu_icb_cmd_mmode,
  output                         agu_icb_cmd_dmode,
  `ifdef N22_LDST_EXCP_PRECISE
  output                         agu_icb_cmd_rv32,
  `endif

  `ifdef N22_MISALIGNED_AMO
  output  agu_unalgn  ,
  output  agu_load    ,
  output  agu_store   ,
  `ifdef N22_HAS_AMO
  output  agu_amo     ,
  output  agu_excl    ,
  output  agu_amoswap ,
  output  agu_amoadd  ,
  output  agu_amoand  ,
  output  agu_amoor   ,
  output  agu_amoxor  ,
  output  agu_amomax  ,
  output  agu_amomin  ,
  output  agu_amomaxu ,
  output  agu_amominu ,
  output  [`N22_XLEN-1:0]      agu_amo_rs2,
  `endif
  `endif



  input  clk,
  input  rst_n
  );




  wire ifu_excp_op = i_ilegl | i_buserr | i_misalgn;

  wire alu_op_raw = i_alu_op;
  wire agu_op_raw = i_agu_op;
  wire bjp_op_raw = i_bjp_op;
  wire csr_op_raw = i_csr_op;

  wire alu_op = (~ifu_excp_op) & alu_op_raw;
  wire agu_op = (~ifu_excp_op) & agu_op_raw;
  wire bjp_op = (~ifu_excp_op) & bjp_op_raw;
  wire csr_op = (~ifu_excp_op) & csr_op_raw;

`ifdef N22_HAS_MULDIV
  wire mdv_op_raw = i_muldiv_op;
  wire mdv_op = (~ifu_excp_op) & i_muldiv_op;
`endif

`ifdef N22_INDEP_MULDIV
  wire i_mul    = i_muldiv_info[`N22_DECINFO_MULDIV_MUL   ];
  wire i_mulh   = i_muldiv_info[`N22_DECINFO_MULDIV_MULH  ];
  wire i_mulhsu = i_muldiv_info[`N22_DECINFO_MULDIV_MULHSU];
  wire i_mulhu  = i_muldiv_info[`N22_DECINFO_MULDIV_MULHU ];
  wire i_div    = i_muldiv_info[`N22_DECINFO_MULDIV_DIV   ];
  wire i_divu   = i_muldiv_info[`N22_DECINFO_MULDIV_DIVU  ];
  wire i_rem    = i_muldiv_info[`N22_DECINFO_MULDIV_REM   ];
  wire i_remu   = i_muldiv_info[`N22_DECINFO_MULDIV_REMU  ];
  wire i_op_mul = i_mul | i_mulh | i_mulhsu | i_mulhu;
  wire i_op_div = i_div | i_divu | i_rem    | i_remu;

  wire mul_op_raw = mdv_op_raw & i_op_mul;
  wire div_op_raw = mdv_op_raw & i_op_div;
  wire mul_op = mdv_op & i_op_mul;
  wire div_op = mdv_op & i_op_div;
`endif



`ifdef N22_SHARE_MULDIV
  wire mdv_i_valid = i_valid & mdv_op;
`endif
`ifdef N22_INDEP_MULDIV
  wire mul_i_valid = i_valid & mul_op;
  wire div_i_valid = i_valid & div_op;
`endif
  wire agu_i_valid = i_valid & agu_op;
  wire alu_i_valid = i_valid & alu_op;
  wire bjp_i_valid = i_valid & bjp_op;
  wire csr_i_valid = i_valid & csr_op;
  wire ifu_excp_i_valid = i_valid & ifu_excp_op;

`ifdef N22_SHARE_MULDIV
  wire mdv_i_ready;
`endif
`ifdef N22_INDEP_MULDIV
  wire mul_i_ready;
  wire div_i_ready;
`endif
  wire agu_i_ready;
  wire alu_i_ready;
  wire bjp_i_ready;
  wire csr_i_ready;
  wire ifu_excp_i_ready;

  assign i_ready =   (agu_i_ready & agu_op)
                   `ifdef N22_SHARE_MULDIV
                   | (mdv_i_ready & mdv_op)
                   `endif
                   `ifdef N22_INDEP_MULDIV
                   | (mul_i_ready & mul_op)
                   | (div_i_ready & div_op)
                   `endif
                   | (alu_i_ready & alu_op)
                   | (ifu_excp_i_ready & ifu_excp_op)
                   | (bjp_i_ready & bjp_op)
                   | (csr_i_ready & csr_op)
                     ;

  wire agu_i_longpipe;
`ifdef N22_SHARE_MULDIV
  wire mdv_i_longpipe;
`endif
`ifdef N22_INDEP_MULDIV
  wire mul_i_longpipe;
  wire div_i_longpipe;
`endif

  assign i_longpipe = (agu_i_longpipe & agu_op)
                   `ifdef N22_SHARE_MULDIV
                    | (mdv_i_longpipe & mdv_op)
                   `endif
                   `ifdef N22_INDEP_MULDIV
                    | (mul_i_longpipe & mul_op)
                    | (div_i_longpipe & div_op)
                   `endif
                   ;

  wire i_longpipe_prdt =
                     (agu_op_raw)
                   `ifdef N22_INDEP_MULDIV
                    | (div_op_raw)
                   `endif
                   ;
  wire csr_o_valid;
  wire csr_o_ready;
  wire [`N22_XLEN-1:0] csr_o_wbck_wdat;
  wire csr_o_wbck_err;


  wire  [`N22_XLEN-1:0]           csr_i_rs1   = i_rs1;
  wire  [`N22_XLEN-1:0]           csr_i_rs2   = i_rs2;
  wire  [`N22_XLEN-1:0]           csr_i_imm   = i_imm;
  wire  [`N22_DECINFO_WIDTH-1:0]  csr_i_info  = i_csr_info;
  wire                             csr_i_rdwen = i_rdwen;



  n22_exu_alu_csrctrl u_n22_exu_alu_csrctrl(
    .alu_need_excp    (alu_need_excp   ),




  `ifdef N22_HAS_CSR_EAI
    .csr_sel_eai      (csr_sel_eai),
    .eai_xs_off       (eai_xs_off),
    .eai_csr_valid    (eai_csr_valid),
    .eai_csr_ready    (eai_csr_ready),
    .eai_csr_addr     (eai_csr_addr ),
    .eai_csr_wr       (eai_csr_wr ),
    .eai_csr_wdata    (eai_csr_wdata),
    .eai_csr_rdata    (eai_csr_rdata),
  `endif

    .csr_i_valid      (csr_i_valid),
    .csr_i_ready      (csr_i_ready),

    .csr_i_rs1        (csr_i_rs1  ),
    .csr_i_info       (csr_i_info[`N22_DECINFO_CSR_WIDTH-1:0]),
    .csr_i_rdwen      (csr_i_rdwen),

    .csr_ena          (csr_ena),
    .csr_idx          (csr_idx),
    .csr_rd_en        (csr_rd_en),
    .csr_wr_en        (csr_wr_en),
    .read_csr_dat     (read_csr_dat),
    .wbck_csr_dat     (wbck_csr_dat),
    .read_msts_dat    (read_msts_dat),
    .wbck_csr_msts_dat     (wbck_csr_msts_dat),
    .csr_access_ilgl  (csr_access_ilgl),

    .csr_op1          (csr_op1),

    .csr_o_valid      (csr_o_valid      ),
    .csr_o_ready      (csr_o_ready      ),
    .csr_o_wbck_wdat  (csr_o_wbck_wdat  ),
    .csr_o_wbck_err   (csr_o_wbck_err   ),

     .clk             (clk),
     .rst_n           (rst_n)
  );

  wire bjp_o_valid;
  wire bjp_o_ready;
  wire [`N22_XLEN-1:0] bjp_o_wbck_wdat;
  wire bjp_o_wbck_err;
  wire bjp_o_cmt_bjp;
  wire bjp_o_cmt_mret;
  wire bjp_o_cmt_dret;
  wire bjp_o_cmt_fencei;
  wire bjp_o_cmt_prdt;
  wire bjp_o_cmt_rslv;

  wire [`N22_XLEN-1:0] bjp_req_alu_op1;
  wire [`N22_XLEN-1:0] bjp_req_alu_op2;
  wire bjp_req_alu_cmp_eq ;
  wire bjp_req_alu_cmp_ne ;
  wire bjp_req_alu_cmp_lt ;
  wire bjp_req_alu_cmp_gt ;
  wire bjp_req_alu_cmp_ltu;
  wire bjp_req_alu_cmp_gtu;
  wire bjp_req_alu_add;
  wire bjp_req_alu_cmp_res;
  wire [`N22_XLEN-1:0] bjp_req_alu_add_res;

  wire  [`N22_XLEN-1:0]           bjp_i_rs1  = i_rs1;
  wire  [`N22_XLEN-1:0]           bjp_i_rs2  = i_rs2;
  wire  [`N22_DECINFO_WIDTH-1:0]  bjp_i_info = i_bjp_info;
  wire  [`N22_PC_SIZE-1:0]        bjp_i_pc   = i_pc;
  wire  [`N22_BPU_IDX_W-1:0]      bjp_i_prdt_bpu_idx= i_prdt_bpu_idx;
  wire                             bjp_i_replaced   = i_replaced;

  n22_exu_alu_bjp u_n22_exu_alu_bjp(
      .bjp_i_valid         (bjp_i_valid         ),
      .bjp_i_ready         (bjp_i_ready         ),
      .bjp_i_rs1           (bjp_i_rs1           ),
      .bjp_i_rs2           (bjp_i_rs2           ),
      .bjp_i_info          (bjp_i_info[`N22_DECINFO_BJP_WIDTH-1:0]),
      .bjp_i_pc            (bjp_i_pc            ),
      .bjp_i_prdt_bpu_idx  (bjp_i_prdt_bpu_idx  ),
      .bjp_i_replaced      (bjp_i_replaced),

      .bjp_o_valid         (bjp_o_valid      ),
      .bjp_o_ready         (bjp_o_ready      ),
      .bjp_o_wbck_wdat     (bjp_o_wbck_wdat  ),
      .bjp_o_wbck_err      (bjp_o_wbck_err   ),

  `ifdef N22_HAS_DYNAMIC_BPU
      .bpu_updt_ena        (bpu_updt_ena ),
      .bpu_updt_take       (bpu_updt_take),
      .bpu_updt_idx        (bpu_updt_idx),
  `endif
      .bjp_o_cmt_bjp       (bjp_o_cmt_bjp    ),
      .bjp_o_cmt_mret      (bjp_o_cmt_mret    ),
      .bjp_o_cmt_dret      (bjp_o_cmt_dret    ),
      .bjp_o_cmt_fencei    (bjp_o_cmt_fencei  ),
      .bjp_o_cmt_prdt      (bjp_o_cmt_prdt   ),
      .bjp_o_cmt_rslv      (bjp_o_cmt_rslv   ),

      .bjp_req_alu_op1     (bjp_req_alu_op1       ),
      .bjp_req_alu_op2     (bjp_req_alu_op2       ),
      .bjp_req_alu_cmp_eq  (bjp_req_alu_cmp_eq    ),
      .bjp_req_alu_cmp_ne  (bjp_req_alu_cmp_ne    ),
      .bjp_req_alu_cmp_lt  (bjp_req_alu_cmp_lt    ),
      .bjp_req_alu_cmp_gt  (bjp_req_alu_cmp_gt    ),
      .bjp_req_alu_cmp_ltu (bjp_req_alu_cmp_ltu   ),
      .bjp_req_alu_cmp_gtu (bjp_req_alu_cmp_gtu   ),
      .bjp_req_alu_add     (bjp_req_alu_add       ),
      .bjp_req_alu_cmp_res (bjp_req_alu_cmp_res   ),
      .bjp_req_alu_add_res (bjp_req_alu_add_res   ),

      .clk                 (clk),
      .rst_n               (rst_n)
  );




  wire agu_o_valid;
  wire agu_o_ready;


  wire agu_o_cmt_misalgn;
  wire agu_o_cmt_ld;
  wire agu_o_cmt_stamo;
  wire agu_o_cmt_pmperr ;
  wire [`N22_ADDR_SIZE-1:0]agu_o_cmt_badaddr ;
`ifdef N22_HAS_TRIGM
  wire agu_o_cmt_trigaddr_2dm;
  wire agu_o_cmt_trigaddr_2excp;
`endif

  wire [`N22_XLEN-1:0] agu_req_alu_op1;
  wire [`N22_XLEN-1:0] agu_req_alu_op2;
  wire agu_req_alu_add ;
  wire [`N22_XLEN-1:0] agu_req_alu_res;



  wire  [`N22_XLEN-1:0]           agu_i_rs1  = {`N22_XLEN         {agu_op_raw}} & i_rs1;
  wire  [`N22_XLEN-1:0]           agu_i_rs2  = {`N22_XLEN         {agu_op_raw}} & i_rs2;
  wire  [`N22_XLEN-1:0]           agu_i_imm  = {`N22_XLEN         {agu_op_raw}} & i_imm;
  wire  [`N22_DECINFO_WIDTH-1:0]  agu_i_info = {`N22_DECINFO_WIDTH{agu_op_raw}} & i_agu_info;
  wire  [`N22_ITAG_WIDTH-1:0]     agu_i_itag = {`N22_ITAG_WIDTH   {agu_op_raw}} & i_itag;

  wire agu_i_mmode  = agu_op_raw & i_mmode;
  wire agu_i_dmode  = agu_op_raw & i_dmode;
  wire agu_i_x0base = agu_op_raw & i_x0base;
  `ifdef N22_LDST_EXCP_PRECISE
  wire agu_i_rv32   = i_rv32;
  `endif


  n22_exu_alu_lsuagu   #(
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
  )u_n22_exu_alu_lsuagu(
      .csr_unalgn_enable (csr_unalgn_enable ),
      .agu_op           (agu_op),
   `ifdef N22_HAS_ECLIC
      .csr_mcause       (csr_mcause),
      .csr_mepc         (csr_mepc  ),
      .csr_mxstatus     (csr_mxstatus  ),
   `endif
   `ifdef N22_HAS_DEBUG
      .dbg_mprven          (dbg_mprven),
   `endif
    `ifdef N22_HAS_TRIGM
      .dbg_tdata1      (dbg_tdata1      ),
      .dbg_tdata2      (dbg_tdata2      ),
    `endif

    `ifdef N22_HAS_PMP
      .pmpaddr_r     (pmpaddr_r   ),
      .pmpcfg_bit_r  (pmpcfg_bit_r),
      .pmpcfg_bit_w  (pmpcfg_bit_w),
      .pmpcfg_bit_x  (pmpcfg_bit_x),
      .pmpcfg_bit_a  (pmpcfg_bit_a),
      .pmpcfg_bit_l  (pmpcfg_bit_l),
    `endif

      .mstatus_mprv  (mstatus_mprv ),
      .mpp_m_mode     (mpp_m_mode    ),

      .agu_i_valid         (agu_i_valid     ),
      .agu_i_ready         (agu_i_ready     ),
      .agu_i_rs1           (agu_i_rs1       ),
      .agu_i_rs2           (agu_i_rs2       ),
      .agu_i_imm           (agu_i_imm       ),
      .agu_i_info          (agu_i_info[`N22_DECINFO_AGU_WIDTH-1:0]),
      .agu_i_longpipe      (agu_i_longpipe  ),
      .agu_i_itag          (agu_i_itag      ),
      .agu_i_mmode         (agu_i_mmode     ),
      .agu_i_dmode         (agu_i_dmode     ),
      .agu_i_x0base        (agu_i_x0base    ),
  `ifdef N22_LDST_EXCP_PRECISE
      .agu_i_rv32            (agu_i_rv32),
  `endif


      .agu_o_valid         (agu_o_valid         ),
      .agu_o_ready         (agu_o_ready         ),
      .agu_o_cmt_misalgn   (agu_o_cmt_misalgn   ),
      .agu_o_cmt_ld        (agu_o_cmt_ld        ),
      .agu_o_cmt_stamo     (agu_o_cmt_stamo     ),
      .agu_o_cmt_pmperr    (agu_o_cmt_pmperr    ),
      .agu_o_cmt_badaddr   (agu_o_cmt_badaddr   ),
`ifdef N22_HAS_TRIGM
      .agu_o_cmt_trigaddr_2dm  (agu_o_cmt_trigaddr_2dm  ),
      .agu_o_cmt_trigaddr_2excp(agu_o_cmt_trigaddr_2excp),
`endif

      .agu_icb_cmd_sel     (agu_icb_cmd_sel     ),

      .agu_icb_cmd_valid   (agu_icb_cmd_valid   ),
      .agu_icb_cmd_ready   (agu_icb_cmd_ready   ),
      .agu_icb_cmd_addr    (agu_icb_cmd_addr    ),
      .agu_icb_cmd_read    (agu_icb_cmd_read    ),
      .agu_icb_cmd_wdata   (agu_icb_cmd_wdata   ),
      .agu_icb_cmd_wmask   (agu_icb_cmd_wmask   ),
      .agu_icb_cmd_size    (agu_icb_cmd_size    ),
      .agu_icb_cmd_usign   (agu_icb_cmd_usign   ),
      .agu_icb_cmd_x0base  (agu_icb_cmd_x0base  ),
      .agu_icb_cmd_mmode   (agu_icb_cmd_mmode   ),
      .agu_icb_cmd_dmode   (agu_icb_cmd_dmode   ),
      .agu_icb_cmd_itag    (agu_icb_cmd_itag    ),
  `ifdef N22_LDST_EXCP_PRECISE
      .agu_icb_cmd_rv32      (agu_icb_cmd_rv32    ),
  `endif

  `ifdef N22_MISALIGNED_AMO
      .agu_unalgn        (agu_unalgn ),
      .agu_load          (agu_load   ),
      .agu_store         (agu_store  ),
  `ifdef N22_HAS_AMO
      .agu_amo           (agu_amo    ),
      .agu_excl          (agu_excl   ),
      .agu_amoswap       (agu_amoswap),
      .agu_amoadd        (agu_amoadd ),
      .agu_amoand        (agu_amoand ),
      .agu_amoor         (agu_amoor  ),
      .agu_amoxor        (agu_amoxor ),
      .agu_amomax        (agu_amomax ),
      .agu_amomin        (agu_amomin ),
      .agu_amomaxu       (agu_amomaxu),
      .agu_amominu       (agu_amominu),
      .agu_amo_rs2       (agu_amo_rs2),
  `endif
  `endif

      .agu_req_alu_op1     (agu_req_alu_op1     ),
      .agu_req_alu_op2     (agu_req_alu_op2     ),
      .agu_req_alu_add     (agu_req_alu_add     ),
      .agu_req_alu_res     (agu_req_alu_res     ),


      .clk                 (clk),
      .rst_n               (rst_n)
  );

  wire alu_o_valid;
  wire alu_o_ready;
  wire [`N22_XLEN-1:0] alu_o_wbck_wdat;
  wire alu_o_wbck_err;
  wire alu_o_cmt_ecall;
  wire alu_o_cmt_ebreak;
  wire alu_o_cmt_wfi;

  wire alu_req_alu_add ;
  wire alu_req_alu_sub ;
  wire alu_req_alu_xor ;
  wire alu_req_alu_sll ;
  wire alu_req_alu_srl ;
  wire alu_req_alu_sra ;
  wire alu_req_alu_or  ;
  wire alu_req_alu_and ;
  wire alu_req_alu_slt ;
  wire alu_req_alu_sltu;
  wire alu_req_alu_lui ;
  wire [`N22_XLEN-1:0] alu_req_alu_op1;
  wire [`N22_XLEN-1:0] alu_req_alu_op2;
  wire [`N22_XLEN-1:0] alu_req_alu_res;

  wire  [`N22_XLEN-1:0]           alu_i_rs1  = i_rs1;
  wire  [`N22_XLEN-1:0]           alu_i_rs2  = i_rs2;
  wire  [`N22_XLEN-1:0]           alu_i_imm  = i_imm;
  wire  [`N22_DECINFO_WIDTH-1:0]  alu_i_info = i_alu_info;
  wire  [`N22_PC_SIZE-1:0]        alu_i_pc   = i_pc;

  n22_exu_alu_rglr u_n22_exu_alu_rglr(

      .alu_i_valid         (alu_i_valid     ),
      .alu_i_ready         (alu_i_ready     ),
      .alu_i_rs1           (alu_i_rs1           ),
      .alu_i_rs2           (alu_i_rs2           ),
      .alu_i_info          (alu_i_info[`N22_DECINFO_ALU_WIDTH-1:0]),
      .alu_i_imm           (alu_i_imm           ),
      .alu_i_pc            (alu_i_pc            ),

      .alu_o_valid         (alu_o_valid         ),
      .alu_o_ready         (alu_o_ready         ),
      .alu_o_wbck_wdat     (alu_o_wbck_wdat     ),
      .alu_o_wbck_err      (alu_o_wbck_err      ),
      .alu_o_cmt_ecall     (alu_o_cmt_ecall ),
      .alu_o_cmt_ebreak    (alu_o_cmt_ebreak),
      .alu_o_cmt_wfi       (alu_o_cmt_wfi   ),

      .alu_req_alu_add     (alu_req_alu_add       ),
      .alu_req_alu_sub     (alu_req_alu_sub       ),
      .alu_req_alu_xor     (alu_req_alu_xor       ),
      .alu_req_alu_sll     (alu_req_alu_sll       ),
      .alu_req_alu_srl     (alu_req_alu_srl       ),
      .alu_req_alu_sra     (alu_req_alu_sra       ),
      .alu_req_alu_or      (alu_req_alu_or        ),
      .alu_req_alu_and     (alu_req_alu_and       ),
      .alu_req_alu_slt     (alu_req_alu_slt       ),
      .alu_req_alu_sltu    (alu_req_alu_sltu      ),
      .alu_req_alu_lui     (alu_req_alu_lui       ),
      .alu_req_alu_op1     (alu_req_alu_op1       ),
      .alu_req_alu_op2     (alu_req_alu_op2       ),
      .alu_req_alu_res     (alu_req_alu_res       ),

      .clk                 (clk           ),
      .rst_n               (rst_n         )
  );

`ifdef N22_SHARE_MULDIV
  wire [`N22_XLEN-1:0]           mdv_i_rs1  = i_rs1;
  wire [`N22_XLEN-1:0]           mdv_i_rs2  = i_rs2;
  wire [`N22_XLEN-1:0]           mdv_i_imm  = i_imm;
  wire [`N22_DECINFO_MULDIV_WIDTH-1:0]  mdv_i_info = i_muldiv_info;
  wire  [`N22_ITAG_WIDTH-1:0]    mdv_i_itag = i_itag;

  wire mdv_o_valid;
  wire mdv_o_ready;
  wire [`N22_XLEN-1:0] mdv_o_wbck_wdat;
  wire mdv_o_wbck_err;

  wire [`N22_ALU_ADDER_WIDTH-1:0] muldiv_req_alu_op1;
  wire [`N22_ALU_ADDER_WIDTH-1:0] muldiv_req_alu_op2;
  wire                             muldiv_req_alu_add ;
  wire                             muldiv_req_alu_sub ;
  wire [`N22_ALU_ADDER_WIDTH-1:0] muldiv_req_alu_res;

  wire          muldiv_sbf_0_ena;
  wire [33-1:0] muldiv_sbf_0_nxt;
  wire [33-1:0] muldiv_sbf_0_r;

  wire          muldiv_sbf_1_ena;
  wire [33-1:0] muldiv_sbf_1_nxt;
  wire [33-1:0] muldiv_sbf_1_r;

  n22_exu_alu_muldiv u_n22_exu_alu_muldiv(

      .muldiv_i_valid      (mdv_i_valid    ),
      .muldiv_i_ready      (mdv_i_ready    ),

      .muldiv_i_rs1        (mdv_i_rs1      ),
      .muldiv_i_rs2        (mdv_i_rs2      ),
      .muldiv_i_imm        (mdv_i_imm      ),
      .muldiv_i_info       (mdv_i_info[`N22_DECINFO_MULDIV_WIDTH-1:0]),
      .muldiv_i_longpipe   (mdv_i_longpipe ),
      .muldiv_i_itag       (mdv_i_itag     ),


      .flush_pulse         (flush_pulse    ),

      .muldiv_o_valid      (mdv_o_valid    ),
      .muldiv_o_ready      (mdv_o_ready    ),
      .muldiv_o_wbck_wdat  (mdv_o_wbck_wdat),
      .muldiv_o_wbck_err   (mdv_o_wbck_err ),

      .muldiv_req_alu_op1  (muldiv_req_alu_op1),
      .muldiv_req_alu_op2  (muldiv_req_alu_op2),
      .muldiv_req_alu_add  (muldiv_req_alu_add),
      .muldiv_req_alu_sub  (muldiv_req_alu_sub),
      .muldiv_req_alu_res  (muldiv_req_alu_res),

      .muldiv_sbf_0_ena    (muldiv_sbf_0_ena  ),
      .muldiv_sbf_0_nxt    (muldiv_sbf_0_nxt  ),
      .muldiv_sbf_0_r      (muldiv_sbf_0_r    ),

      .muldiv_sbf_1_ena    (muldiv_sbf_1_ena  ),
      .muldiv_sbf_1_nxt    (muldiv_sbf_1_nxt  ),
      .muldiv_sbf_1_r      (muldiv_sbf_1_r    ),

      .clk                 (clk               ),
      .rst_n               (rst_n             )
  );
`endif

`ifdef N22_INDEP_MULDIV
  wire [`N22_XLEN-1:0]           mul_i_rs1  = {`N22_XLEN         {mul_op_raw}} & i_rs1;
  wire [`N22_XLEN-1:0]           mul_i_rs2  = {`N22_XLEN         {mul_op_raw}} & i_rs2;
  wire [`N22_XLEN-1:0]           mul_i_imm  = {`N22_XLEN         {mul_op_raw}} & i_imm;
  wire [`N22_DECINFO_MULDIV_WIDTH-1:0]  mul_i_info = {`N22_DECINFO_MULDIV_WIDTH{mul_op_raw}} & i_muldiv_info;
  wire  [`N22_ITAG_WIDTH-1:0]    mul_i_itag = {`N22_ITAG_WIDTH   {mul_op_raw}} & i_itag;

  wire mul_o_valid;
  wire mul_o_ready;
  wire [`N22_XLEN-1:0] mul_o_wbck_wdat;
  wire mul_o_wbck_err;

  `ifdef N22_INDEP_MUL_1CYC
  n22_exu_mul_1cyc u_n22_exu_mul_1cyc(
  `endif

      .mul_i_valid      (mul_i_valid    ),
      .mul_i_ready      (mul_i_ready    ),

      .mul_i_rs1        (mul_i_rs1      ),
      .mul_i_rs2        (mul_i_rs2      ),
      .mul_i_imm        (mul_i_imm      ),
      .mul_i_info       (mul_i_info[`N22_DECINFO_MULDIV_WIDTH-1:0]),
      .mul_i_longpipe   (mul_i_longpipe ),
      .mul_i_itag       (mul_i_itag     ),

      .mul_o_valid      (mul_o_valid    ),
      .mul_o_ready      (mul_o_ready    ),
      .mul_o_wbck_wdat  (mul_o_wbck_wdat),
      .mul_o_wbck_err   (mul_o_wbck_err ),

      .clk              (clk            ),
      .rst_n            (rst_n          )
  );

  wire [`N22_XLEN-1:0]           div_i_rs1  = {`N22_XLEN         {div_op_raw}} & i_rs1;
  wire [`N22_XLEN-1:0]           div_i_rs2  = {`N22_XLEN         {div_op_raw}} & i_rs2;
  wire [`N22_XLEN-1:0]           div_i_imm  = {`N22_XLEN         {div_op_raw}} & i_imm;
  wire [`N22_DECINFO_MULDIV_WIDTH-1:0]  div_i_info = {`N22_DECINFO_MULDIV_WIDTH{div_op_raw}} & i_muldiv_info;
  wire  [`N22_ITAG_WIDTH-1:0]    div_i_itag = {`N22_ITAG_WIDTH   {div_op_raw}} & i_itag;

  wire div_o_valid;
  wire div_o_ready;
  wire [`N22_XLEN-1:0] div_o_wbck_wdat;
  wire div_o_wbck_err;

  n22_exu_div u_n22_exu_div(

      .div_i_valid      (div_i_valid    ),
      .div_i_ready      (div_i_ready    ),

      .div_i_rs1        (div_i_rs1      ),
      .div_i_rs2        (div_i_rs2      ),
      .div_i_imm        (div_i_imm      ),
      .div_i_info       (div_i_info[`N22_DECINFO_MULDIV_WIDTH-1:0]),
      .div_i_longpipe   (div_i_longpipe ),
      .div_i_itag       (div_i_itag     ),

      .div_o_valid      (div_o_valid    ),
      .div_o_ready      (div_o_ready    ),
      .div_o_wbck_wdat  (div_o_wbck_wdat),
      .div_o_wbck_err   (div_o_wbck_err ),

      .div_longp_o_valid(div_longp_o_valid),
      .div_longp_o_ready(div_longp_o_ready),
      .div_longp_o_wdat (div_longp_o_wdat),
      .div_longp_o_err  (div_longp_o_err ),
      .div_longp_o_itag (div_longp_o_itag),

      .clk              (clk            ),
      .rst_n            (rst_n          )
  );
`endif




  wire alu_req_alu = alu_op_raw;
`ifdef N22_SHARE_MULDIV
  wire muldiv_req_alu = mdv_op_raw;
`endif
  wire bjp_req_alu = bjp_op_raw;
  wire agu_req_alu = agu_op_raw;


  n22_exu_alu_dpath u_n22_exu_alu_dpath(
      .alu_req_alu         (alu_req_alu           ),
      .alu_req_alu_add     (alu_req_alu_add       ),
      .alu_req_alu_sub     (alu_req_alu_sub       ),
      .alu_req_alu_xor     (alu_req_alu_xor       ),
      .alu_req_alu_sll     (alu_req_alu_sll       ),
      .alu_req_alu_srl     (alu_req_alu_srl       ),
      .alu_req_alu_sra     (alu_req_alu_sra       ),
      .alu_req_alu_or      (alu_req_alu_or        ),
      .alu_req_alu_and     (alu_req_alu_and       ),
      .alu_req_alu_slt     (alu_req_alu_slt       ),
      .alu_req_alu_sltu    (alu_req_alu_sltu      ),
      .alu_req_alu_lui     (alu_req_alu_lui       ),
      .alu_req_alu_op1     (alu_req_alu_op1       ),
      .alu_req_alu_op2     (alu_req_alu_op2       ),
      .alu_req_alu_res     (alu_req_alu_res       ),

      .bjp_req_alu         (bjp_req_alu           ),
      .bjp_req_alu_op1     (bjp_req_alu_op1       ),
      .bjp_req_alu_op2     (bjp_req_alu_op2       ),
      .bjp_req_alu_cmp_eq  (bjp_req_alu_cmp_eq    ),
      .bjp_req_alu_cmp_ne  (bjp_req_alu_cmp_ne    ),
      .bjp_req_alu_cmp_lt  (bjp_req_alu_cmp_lt    ),
      .bjp_req_alu_cmp_gt  (bjp_req_alu_cmp_gt    ),
      .bjp_req_alu_cmp_ltu (bjp_req_alu_cmp_ltu   ),
      .bjp_req_alu_cmp_gtu (bjp_req_alu_cmp_gtu   ),
      .bjp_req_alu_add     (bjp_req_alu_add       ),
      .bjp_req_alu_cmp_res (bjp_req_alu_cmp_res   ),
      .bjp_req_alu_add_res (bjp_req_alu_add_res   ),

      .agu_req_alu         (agu_req_alu           ),
      .agu_req_alu_op1     (agu_req_alu_op1       ),
      .agu_req_alu_op2     (agu_req_alu_op2       ),
      .agu_req_alu_swap    (1'b0      ),
      .agu_req_alu_add     (agu_req_alu_add       ),
      .agu_req_alu_and     (1'b0      ),
      .agu_req_alu_or      (1'b0      ),
      .agu_req_alu_xor     (1'b0      ),
      .agu_req_alu_max     (1'b0      ),
      .agu_req_alu_min     (1'b0      ),
      .agu_req_alu_maxu    (1'b0      ),
      .agu_req_alu_minu    (1'b0      ),
      .agu_req_alu_res     (agu_req_alu_res       ),

      .agu_sbf_0_ena       (1'b0         ),
      .agu_sbf_0_nxt       (`N22_XLEN'b0         ),
      .agu_sbf_0_r         (),

      .agu_sbf_1_ena       (1'b0         ),
      .agu_sbf_1_nxt       (`N22_XLEN'b0         ),
      .agu_sbf_1_r         (),



`ifdef N22_SHARE_MULDIV
      .muldiv_req_alu      (muldiv_req_alu    ),

      .muldiv_req_alu_op1  (muldiv_req_alu_op1),
      .muldiv_req_alu_op2  (muldiv_req_alu_op2),
      .muldiv_req_alu_add  (muldiv_req_alu_add),
      .muldiv_req_alu_sub  (muldiv_req_alu_sub),
      .muldiv_req_alu_res  (muldiv_req_alu_res),

      .muldiv_sbf_0_ena    (muldiv_sbf_0_ena  ),
      .muldiv_sbf_0_nxt    (muldiv_sbf_0_nxt  ),
      .muldiv_sbf_0_r      (muldiv_sbf_0_r    ),

      .muldiv_sbf_1_ena    (muldiv_sbf_1_ena  ),
      .muldiv_sbf_1_nxt    (muldiv_sbf_1_nxt  ),
      .muldiv_sbf_1_r      (muldiv_sbf_1_r    ),
`endif

      .clk                 (clk           ),
      .rst_n               (rst_n         )
    );

  wire ifu_excp_o_valid;
  wire ifu_excp_o_ready;
  wire [`N22_XLEN-1:0] ifu_excp_o_wbck_wdat;
  wire ifu_excp_o_wbck_err;

  assign ifu_excp_i_ready = ifu_excp_o_ready;
  assign ifu_excp_o_valid = ifu_excp_i_valid;
  assign ifu_excp_o_wbck_wdat = `N22_XLEN'b0;
  assign ifu_excp_o_wbck_err  = 1'b1;

  wire o_valid;
  wire o_ready;


  wire o_bjp_valid =   (bjp_op      & bjp_o_valid     );

  assign o_valid =     (alu_op      & alu_o_valid     )
                     | (bjp_op      & bjp_o_valid     )
                     | (csr_op      & csr_o_valid     )
                     | (agu_op      & agu_o_valid     )
                     | (ifu_excp_op & ifu_excp_o_valid)
                      `ifdef N22_SHARE_MULDIV
                     | (mdv_op      & mdv_o_valid     )
                      `endif
                      `ifdef N22_INDEP_MULDIV
                     | (mul_op      & mul_o_valid     )
                     | (div_op      & div_o_valid     )
                      `endif
                     ;

  assign ifu_excp_o_ready = ifu_excp_op & o_ready;
  assign alu_o_ready      = alu_op & o_ready;
  assign agu_o_ready      = agu_op & o_ready;
`ifdef N22_SHARE_MULDIV
  assign mdv_o_ready      = mdv_op & o_ready;
`endif
`ifdef N22_INDEP_MULDIV
  assign mul_o_ready      = mul_op & o_ready;
  assign div_o_ready      = div_op & o_ready;
`endif
  assign bjp_o_ready      = bjp_op & o_ready;
  assign csr_o_ready      = csr_op & o_ready;

  assign wbck_o_wdat =
                    ({`N22_XLEN{alu_op}} & alu_o_wbck_wdat)
                  | ({`N22_XLEN{bjp_op}} & bjp_o_wbck_wdat)
                  | ({`N22_XLEN{csr_op}} & csr_o_wbck_wdat)
                      `ifdef N22_SHARE_MULDIV
                  | ({`N22_XLEN{mdv_op}} & mdv_o_wbck_wdat)
                      `endif
                      `ifdef N22_INDEP_MULDIV
                  | ({`N22_XLEN{mul_op}} & mul_o_wbck_wdat)
                  | ({`N22_XLEN{div_op}} & div_o_wbck_wdat)
                      `endif
                  | ({`N22_XLEN{ifu_excp_op}} & ifu_excp_o_wbck_wdat)
                  ;

  assign wbck_o_rdidx = i_rdidx;
`ifdef N22_HAS_STACKSAFE
  assign wbck_o_rdsp = i_rdsp;
`endif

  wire wbck_o_rdwen = i_rdwen;

  wire wbck_o_err =
                    ({1{alu_op}} & alu_o_wbck_err)
                  | ({1{bjp_op}} & bjp_o_wbck_err)
                  | ({1{csr_op}} & csr_o_wbck_err)
                      `ifdef N22_SHARE_MULDIV
                  | ({1{mdv_op}} & mdv_o_wbck_err)
                      `endif
                      `ifdef N22_INDEP_MULDIV
                  | ({1{mul_op}} & mul_o_wbck_err)
                  | ({1{div_op}} & div_o_wbck_err)
                      `endif
                  | ({1{ifu_excp_op}} & ifu_excp_o_wbck_err)
                  ;



  wire o_need_wbck = wbck_o_rdwen & (~i_longpipe_prdt);
  assign wbck_o_wen = wbck_o_rdwen & (~i_longpipe) & (~alu_need_excp);
  wire o_need_cmt  = 1'b1;
  assign o_ready =
           (o_need_cmt  ? cmt_o_ready  : 1'b1)
         & (o_need_wbck ? wbck_o_ready : 1'b1);

  assign wbck_o_valid = o_need_wbck & o_valid & (o_need_cmt  ? cmt_o_ready  : 1'b1);
  assign cmt_o_valid  = o_need_cmt  & o_valid & (o_need_wbck ? wbck_o_ready : 1'b1);

  assign cmt_o_bjp_valid  = o_need_cmt & o_bjp_valid & (o_need_wbck ? wbck_o_ready : 1'b1);
  assign cmt_o_instr   = i_instr;
  assign cmt_o_pc   = i_pc;
  assign cmt_o_bjp_imm  = i_bjp_imm;
  assign cmt_o_rv32 = i_rv32;
  assign cmt_o_pc_vld      =
                              i_pc_vld;

  assign cmt_o_replaced    = i_replaced;
  assign cmt_o_replaced_pc = i_replaced_pc;

  assign cmt_o_misalgn     = (agu_op & agu_o_cmt_misalgn)
                           ;
  assign cmt_o_ld          = (agu_op & agu_o_cmt_ld)
                           ;
  assign cmt_o_badaddr     = ({`N22_ADDR_SIZE{agu_op}} & agu_o_cmt_badaddr)
                           ;
`ifdef N22_HAS_PMONITOR
  assign cmt_o_pmon_evts   = i_pmon_evts;
`endif

  assign cmt_o_pmperr      = agu_op & agu_o_cmt_pmperr;
  assign cmt_o_stamo       = agu_op & agu_o_cmt_stamo ;
`ifdef N22_HAS_TRIGM
  assign cmt_o_trigaddr_2dm   = agu_op & agu_o_cmt_trigaddr_2dm;
  assign cmt_o_trigaddr_2excp = agu_op & agu_o_cmt_trigaddr_2excp;
`endif

  assign cmt_o_bjp         = bjp_op & bjp_o_cmt_bjp;
  assign cmt_o_mret        = bjp_op & bjp_o_cmt_mret;
  assign cmt_o_dret        = bjp_op & bjp_o_cmt_dret;
  assign cmt_o_bjp_prdt    = bjp_op & bjp_o_cmt_prdt;
  assign cmt_o_bjp_rslv    = bjp_op & bjp_o_cmt_rslv;
  assign cmt_o_fencei      = bjp_op & bjp_o_cmt_fencei;

  assign cmt_o_ecall       = alu_op & alu_o_cmt_ecall;
  assign cmt_o_ebreak      = alu_op & alu_o_cmt_ebreak;
  assign cmt_o_wfi         = alu_op & alu_o_cmt_wfi;
  assign cmt_o_ifu_misalgn = i_misalgn;
  assign cmt_o_ifu_buserr  = i_buserr;
  assign cmt_o_ifu_pmperr  = i_pmperr;
  assign cmt_o_ifu_ilegl   = i_ilegl
                           | (csr_op & csr_access_ilgl)
                        ;
  assign cmt_o_ifu_ilegl_ilginstr = i_ilegl & (~i_ilegl_prv);
  assign cmt_o_ifu_ilegl_prvinstr = i_ilegl &   i_ilegl_prv;
  assign cmt_o_ifu_ilegl_noncsr   = csr_op & csr_access_ilgl & csr_ilegl_noncsr;
  assign cmt_o_ifu_ilegl_prvcsr   = csr_op & csr_access_ilgl & csr_ilegl_prvcsr;
  assign cmt_o_ifu_ilegl_wrocsr   = csr_op & csr_access_ilgl & csr_ilegl_wrocsr;

endmodule




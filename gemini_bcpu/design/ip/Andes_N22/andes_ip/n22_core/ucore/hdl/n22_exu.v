

`include "global.inc"

module n22_exu #(
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
  input  i_valid,
  output i_ready,
  input  [`N22_INSTR_SIZE-1:0] i_ir,
  input  [`N22_PC_SIZE-1:0] i_pc,
  input  i_mmode ,
  input  i_dmode ,
  input  i_pc_vld,
  input  i_misalgn,
  input  i_buserr,
  input  i_buserr_btm,
  input  i_pmperr,
  input  i_prdt_taken,
  input  [`N22_BPU_IDX_W-1:0] i_prdt_bpu_idx,
  input  i_muldiv_b2b,
  input  [`N22_RFIDX_WIDTH-1:0] i_rs1idx,
  input  [`N22_RFIDX_WIDTH-1:0] i_rs2idx,
  input  i_replaced,
  input  [`N22_PC_SIZE-1:0] i_replaced_pc,

      `ifdef N22_HAS_DEBUG_PRIVATE
  input  tap_dmi_active,
      `endif

  output [31:0] csr_uitb_addr,

  `ifdef N22_LDST_EXCP_PRECISE
  input  lsu_pend_outs,
  input  lsu_pend_rv32,
  `endif

  output csr_rvcompm_enable,

  output trace_ivalid,
  output trace_iexception,
  output trace_interrupt,
  output [`N22_XLEN-1:0] trace_cause,
  output [`N22_XLEN-1:0] trace_tval,
  output [`N22_XLEN-1:0] trace_iaddr,
  output [`N22_XLEN-1:0] trace_instr,
  output [1:0] trace_priv,


  input  [`N22_PC_SIZE-1:0] pc_rtvec,

  output mstatus_mprv,
  output mpp_m_mode,

  `ifdef N22_HAS_DYNAMIC_BPU
  output  bpu_updt_ena ,
  output  bpu_updt_take,
  output  [`N22_BPU_IDX_W-1:0] bpu_updt_idx,
  `endif
  input   p1_flush_ack,
  output  p1_flush_req,
  output  p1_flush_pc_mmode,
  output  p1_flush_pc_dmode,
  output  p1_flush_pc_vmode,
  `ifdef N22_TIMING_BOOST
  output  [`N22_PC_SIZE-1:0] p1_flush_pc,
  output  p1_flush_fencei,
  `endif

  input   p2_flush_ack,
  output  p2_flush_req,
  output  p2_flush_pc_mmode,
  output  p2_flush_pc_dmode,
  output  p2_flush_pc_vmode,
  output  [`N22_PC_SIZE-1:0] p2_flush_pc,
  output  p2_flush_fencei,

  output exu_active,
  output excp_active,

  output core_wfi,


  `ifdef N22_HAS_PMP
  output [`N22_PMP_ENTRY_NUM*`N22_XLEN-1:0] pmpaddr_r,
  output [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_r,
  output [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_w,
  output [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_x,
  output [`N22_PMP_ENTRY_NUM*2-1:0] pmpcfg_bit_a,
  output [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_l,
  `endif


  output csr_ilm_enable   ,
  output csr_dlm_enable   ,
  output csr_icache_enable,
  output csr_bpu_enable,

  output  dbg_sleep,

  input  [`N22_XLEN-1:0] core_mhartid,
  `ifdef N22_HAS_CLIC
  input  clic_irq,
  `endif
  output nmi_irq_taken,
  input  nmi_irq_r,
  input  ext_irq_r,
  input  sft_irq_r,
  input  tmr_irq_r,

  `ifdef N22_HAS_DEBUG
  input  dbg_halt,
  input  dbg_resethaltreq,

  output  [`N22_PC_SIZE-1:0] cmt_dpc,
  output  cmt_dpc_ena,
  output  [3-1:0] cmt_dcause,
  output  cmt_dcause_ena,

  input   [`N22_XLEN-1:0] dbg_dexc2dbg_r,
  output  [`N22_XLEN-1:0] cmt_ddcause,
  output  cmt_ddcause_ena,

  output  cmt_dprv_ena,
  output  [2-1:0] cmt_dprv,
  input   [2-1:0] dbg_prv_r,
  input  [`N22_XLEN-1:0] csr_dpc_r,

    `ifdef N22_HAS_TRIGM
  input  [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata1,
  input  [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata2,
  output icount_taken_ena,
    `endif


  input  dbg_step_r,
  input  dbg_ebreakm_r,
  input  dbg_stopcount,
  input  dbg_ebreaku_r,
  input  dbg_stepie,
  input  dbg_mprven,

  output dbg_csr_ena,
  output dbg_csr_wr_en,
  output dbg_csr_rd_en,
  output dbg_wbck_csr_wen,
  output [12-1:0] dbg_csr_idx,
  output [`N22_XLEN-1:0] dbg_wbck_csr_dat,
  input  [`N22_XLEN-1:0] dbg_read_csr_dat,
  input  dbg_csr_addr_legal,
  input  dbg_csr_prv_ilgl,

  `endif

  input  dbg_mode,
  input  reset_flag_r,



  input  lsu_o_valid,
  output lsu_o_ready,
  input  [`N22_XLEN-1:0] lsu_o_wbck_wdat,
  input  [`N22_ITAG_WIDTH -1:0] lsu_o_wbck_itag,
  input  lsu_o_wbck_err ,
  input  lsu_o_cmt_ld,
  input  lsu_o_cmt_st,
  input  [`N22_ADDR_SIZE -1:0] lsu_o_cmt_badaddr,
  input  [`N22_ADDR_SIZE -1:0] lsu_o_cmt_pc,
  input  lsu_o_cmt_buserr ,
  input  lsu_o_cmt_pmperr ,

  output wfi_halt_ifu_req,
  input  wfi_halt_ifu_ack,

  output oitf_empty,
  output [`N22_XLEN-1:0] rf2ifu_x1,
  output [`N22_XLEN-1:0] rf2ifu_rs2,
  output dec2ifu_rden,
  output dec2ifu_rs2en,
  output [`N22_RFIDX_WIDTH-1:0] dec2ifu_rdidx,
  output dec2ifu_mulhsu,
  output dec2ifu_div   ,
  output dec2ifu_rem   ,
  output dec2ifu_divu  ,
  output dec2ifu_remu  ,

  output                         agu_icb_cmd_sel,

  output                         agu_icb_cmd_valid,
  input                          agu_icb_cmd_ready,
  output [`N22_ADDR_SIZE-1:0]   agu_icb_cmd_addr,
  output                         agu_icb_cmd_read,
  output [`N22_XLEN-1:0]        agu_icb_cmd_wdata,
  output [`N22_XLEN_MW-1:0]      agu_icb_cmd_wmask,
  output                         agu_icb_cmd_x0base,
  output                         agu_icb_cmd_mmode,
  output                         agu_icb_cmd_dmode,
  output [1:0]                   agu_icb_cmd_size,
  output                         agu_icb_cmd_usign,
  output [`N22_ITAG_WIDTH -1:0] agu_icb_cmd_itag,
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


  input   rx_evt_req,
  output  rx_evt_ack,


  output sleep_value,
  output tx_evt,
  output csr_wfe_bit,


  `ifdef N22_HAS_CSR_EAI
  output         eai_csr_valid,
  input          eai_csr_ready,
  output  [31:0] eai_csr_addr,
  output         eai_csr_wr,
  output  [31:0] eai_csr_wdata,
  input   [31:0] eai_csr_rdata,
  `endif

`ifdef N22_HAS_CLIC
  input minhv_clear_r,
  output [7:0] mintstatus_mil_r,
  input [9:0] clic_irq_id,
  input [7:0] clic_irq_lvl,
  input clic_irq_shv,
  input clic_prio_gt_thod,
  output core_in_int,
  output clic_irq_taken,
  output mnxti_valid_taken,
  output mip_bwei    ,
  output mip_pmovi    ,
  output mip_imecci    ,
  output clic_int_mode,
`endif



  input  clkgate_bypass,
  input  clk_aon,
  input  clk,
  input  rst_n
  );


  wire [`N22_XLEN-1:0] s0;
  wire [`N22_XLEN-1:0] s1;

  `ifndef N22_REGFILE_2WP
  wire s2;
  wire [`N22_XLEN-1:0] s3;
  wire [`N22_RFIDX_WIDTH-1:0] s4;
  `endif

  `ifdef N22_REGFILE_2WP
  wire s5;
  wire [`N22_XLEN-1:0] s6;
  wire [`N22_RFIDX_WIDTH-1:0] s7;

  wire s8;
  wire [`N22_XLEN-1:0] s9;
  wire [`N22_RFIDX_WIDTH-1:0] s10;
  `endif

`ifdef N22_HAS_STACKSAFE
  wire sp_excp_taken_ena;
  wire rf_wbck_sp_ena1;
  wire rf_wbck_sp_ena2;
  wire [`N22_XLEN-1:0] sp_r;
  wire sp_ovf_excp;
  wire sp_udf_excp;
  wire oitf_ret_rdsp;
`endif

  n22_exu_regfile u_n22_exu_regfile(
`ifdef N22_HAS_STACKSAFE
    .sp_r          (sp_r     ),
`endif
    .read_src1_idx (i_rs1idx ),
    .read_src2_idx (i_rs2idx ),
    .read_src1_dat (s0),
    .read_src2_dat (s1),

    .x1_r          (rf2ifu_x1),

  `ifdef N22_REGFILE_2WP
    .wbck_dest_wen1 (s5),
    .wbck_dest_idx1 (s7),
    .wbck_dest_dat1 (s6),

    .wbck_dest_wen2 (s8),
    .wbck_dest_idx2 (s10),
    .wbck_dest_dat2 (s9),
  `endif

  `ifndef N22_REGFILE_2WP
    .wbck_dest_wen (s2),
    .wbck_dest_idx (s4),
    .wbck_dest_dat (s3),
  `endif

    .clkgate_bypass     (clkgate_bypass),
    .clk           (clk          ),
    .rst_n         (rst_n        )
  );

  wire dec_rs1en;
  wire dec_rs2en;
  wire dec_ilegl;
  wire dec_ilegl_prv;



`ifdef N22_HAS_MULDIV
  wire [`N22_DECINFO_MULDIV_WIDTH-1:0] dec_muldiv_info;
  wire dec_muldiv_op;
`endif
  wire [`N22_XLEN-1:0] dec_imm;
  `ifdef N22_HAS_PMONITOR
  wire [32-1:0] dec_pmon_evts;
  `endif
  wire dec_rs1x0;
  wire dec_rs2x0;
  wire dec_rdwen;
  wire [`N22_RFIDX_WIDTH-1:0] dec_rdidx;
  `ifdef N22_HAS_STACKSAFE
  wire dec_rdsp;
  `endif


  wire dec_mmode ;
  wire dec_dmode ;
  wire dec_x0base;
  wire dec_replaced;


  wire dec_alu_op;
  wire dec_agu_op;
  wire dec_bjp_op;
  wire dec_csr_op;
  wire [`N22_DECINFO_WIDTH-1:0]  dec_alu_info;
  wire [`N22_DECINFO_WIDTH-1:0]  dec_agu_info;
  wire [`N22_DECINFO_WIDTH-1:0]  dec_bjp_info;
  wire [`N22_DECINFO_WIDTH-1:0]  dec_csr_info;

  wire dec_rv32;
  wire [`N22_XLEN-1:0] dec_bjp_imm;

  n22_exu_decode u_n22_exu_decode (
    .csr_rvcompm_enable(csr_rvcompm_enable),

    .i_instr      (i_ir    ),
    .i_prdt_taken (i_prdt_taken),
    .i_muldiv_b2b (i_muldiv_b2b),
    .i_mmode      (i_mmode ),
    .i_dmode      (i_dmode ),
    .i_replaced    (i_replaced   ),

    .dec_bjp   (),
    .dec_jal   (),
    .dec_jalr  (),
    .dec_bxx   (),
    .dec_jalr_rs1idx(),

    .dec_mulhsu  (dec2ifu_mulhsu),
    .dec_mul     (),
    .dec_div     (dec2ifu_div   ),
    .dec_rem     (dec2ifu_rem   ),
    .dec_divu    (dec2ifu_divu  ),
    .dec_remu    (dec2ifu_remu  ),



    .dec_execit    (),
    .dec_execit_imm(),

`ifdef N22_HAS_MULDIV
    .dec_muldiv_info(dec_muldiv_info),
    .dec_muldiv_op(dec_muldiv_op),
`endif
    .dec_rs1x0 (dec_rs1x0),
    .dec_rs2x0 (dec_rs2x0),
    .dec_rs1en (dec_rs1en),
    .dec_rs2en (dec_rs2en),
    .dec_rdwen (dec_rdwen),
  `ifdef N22_HAS_STACKSAFE
    .dec_rdsp  (dec_rdsp),
  `endif
    .dec_rs1idx(),
    .dec_rs2idx(),
    .dec_ilegl  (dec_ilegl),
    .dec_ilegl_prv  (dec_ilegl_prv),
    .dec_rdidx (dec_rdidx),
    .dec_imm   (dec_imm),
  `ifdef N22_HAS_PMONITOR
    .dec_pmon_evts(dec_pmon_evts),
  `endif
    .dec_mmode (dec_mmode ),
    .dec_dmode (dec_dmode ),
    .dec_replaced    (dec_replaced   ),

    .dec_alu_op  (dec_alu_op),
    .dec_agu_op  (dec_agu_op),
    .dec_bjp_op  (dec_bjp_op),
    .dec_csr_op  (dec_csr_op),
    .dec_alu_info(dec_alu_info),
    .dec_agu_info(dec_agu_info),
    .dec_bjp_info(dec_bjp_info),
    .dec_csr_info(dec_csr_info),

    .dec_rv32    (dec_rv32   ),
    .dec_bjp_imm (dec_bjp_imm),
    .dec_x0base(dec_x0base)
  );

  wire s11;
  wire s12;
  wire s13;
  wire [`N22_ITAG_WIDTH-1:0] s14;
  wire [`N22_XLEN-1:0] s15;
  wire [`N22_XLEN-1:0] s16;
  wire [`N22_XLEN-1:0] s17;
`ifdef N22_HAS_PMONITOR
  wire [31:0] s18;
`endif
  wire s19 ;
  wire s20 ;
  wire s21;
  wire [`N22_BPU_IDX_W-1:0] s22;
`ifdef N22_HAS_MULDIV
  wire [`N22_DECINFO_MULDIV_WIDTH-1:0] s23;
  wire s24;
`endif
  wire [`N22_PC_SIZE-1:0] s25;
  wire [`N22_RFIDX_WIDTH-1:0] s26;
  wire s27;
  wire s28;
  wire s29;
  wire s30;
`ifdef N22_HAS_STACKSAFE
  wire s31;
`endif

  wire s32;
  wire [`N22_PC_SIZE-1:0] s33;

  wire [`N22_ITAG_WIDTH-1:0] disp_oitf_ptr;
  wire disp_oitf_ready;

  wire  disp_oitf_rs1fpu;
  wire  disp_oitf_rs2fpu;
  wire  disp_oitf_rs3fpu;
  wire  disp_oitf_rdfpu;
  wire  [`N22_RFIDX_WIDTH-1:0] disp_oitf_rs1idx;
  wire  [`N22_RFIDX_WIDTH-1:0] disp_oitf_rs2idx;
  wire  [`N22_RFIDX_WIDTH-1:0] disp_oitf_rs3idx;
  wire  [`N22_RFIDX_WIDTH-1:0] disp_oitf_rdidx;
  wire  disp_oitf_rs1en;
  wire  disp_oitf_rs2en;
  wire  disp_oitf_rs3en;
  wire  disp_oitf_rdwen;

  wire oitfrd_match_disprs1;
  wire oitfrd_match_disprs2;
  wire oitfrd_match_disprs3;
  wire oitfrd_match_disprd;

  wire disp_oitf_ena;

  wire wfi_halt_exu_req;
  wire wfi_halt_exu_ack;

  `ifdef N22_HAS_POWERBRAKE
  wire [3:0] csr_mpftctl_tlevel;
  wire csr_mxstat_pften;
  `endif

`ifdef N22_HAS_STACKSAFE
  wire  spsafe_enable;
  wire  oitf_has_rdsp;
  wire disp_oitf_rdsp ;
`endif

  wire spsafe_stall;


  n22_exu_disp u_n22_exu_disp(
    .spsafe_stall     (spsafe_stall),
  `ifdef N22_LDST_EXCP_PRECISE
    .lsu_pend_outs    (lsu_pend_outs),
  `endif

    .wfi_halt_exu_req    (wfi_halt_exu_req),
    .wfi_halt_exu_ack    (wfi_halt_exu_ack),
    .oitf_empty          (oitf_empty),

  `ifdef N22_HAS_POWERBRAKE
    .csr_mpftctl_tlevel  (csr_mpftctl_tlevel),
    .csr_mxstat_pften  (csr_mxstat_pften),
  `endif

    .disp_i_valid        (i_valid         ),
    .disp_i_ready        (i_ready         ),
    .disp_i_pc_vld       (i_pc_vld        ),

    .disp_i_alu_op       (dec_alu_op),
    .disp_i_agu_op       (dec_agu_op),
    .disp_i_bjp_op       (dec_bjp_op),
    .disp_i_csr_op       (dec_csr_op),
    .disp_i_bjp_info     (dec_bjp_info),

    .disp_i_rs1x0        (dec_rs1x0       ),
    .disp_i_rs2x0        (dec_rs2x0       ),
    .disp_i_rs1en        (dec_rs1en       ),
    .disp_i_rs2en        (dec_rs2en       ),
    .disp_i_rs1idx       (i_rs1idx      ),
    .disp_i_rs2idx       (i_rs2idx      ),
    .disp_i_rdwen        (dec_rdwen       ),
    .disp_i_rdidx        (dec_rdidx       ),
`ifdef N22_HAS_MULDIV
    .disp_i_muldiv_info  (dec_muldiv_info ),
    .disp_i_muldiv_op    (dec_muldiv_op ),
`endif
    .disp_i_rs1          (s0          ),
    .disp_i_rs2          (s1          ),
    .disp_i_imm          (dec_imm        ),
`ifdef N22_HAS_PMONITOR
    .disp_i_pmon_evts    (dec_pmon_evts),
`endif
    .disp_i_pc           (i_pc         ),
    .disp_i_prdt_bpu_idx (i_prdt_bpu_idx),
    .disp_i_misalgn      (i_misalgn    ),
    .disp_i_buserr       (i_buserr     ),
    .disp_i_pmperr       (i_pmperr     ),
    .disp_i_mmode        (dec_mmode ),
    .disp_i_dmode        (dec_dmode ),
    .disp_i_x0base       (dec_x0base),
    .disp_i_replaced   (dec_replaced   ),
    .disp_i_replaced_pc(i_replaced_pc),


    .disp_o_alu_valid    (s11   ),
    .disp_o_alu_ready    (s12   ),
    .disp_o_alu_longpipe (s13),
    .disp_o_alu_itag     (s14    ),
    .disp_o_alu_rs1      (s15     ),
    .disp_o_alu_rs2      (s16     ),
    .disp_o_alu_rdwen    (s27    ),
`ifdef N22_HAS_STACKSAFE
    .disp_o_alu_rdsp     (s31),
    .spsafe_enable       (spsafe_enable),
    .oitf_has_rdsp       (oitf_has_rdsp),
    .disp_i_rdsp         (dec_rdsp  ),
    .disp_oitf_rdsp      (disp_oitf_rdsp ),
`endif

    .disp_o_alu_rdidx    (s26   ),
`ifdef N22_HAS_MULDIV
    .disp_o_muldiv_info  (s23),
    .disp_o_muldiv_op    (s24),
`endif
    .disp_o_alu_pc       (s25      ),
    .disp_o_alu_imm      (s17     ),
`ifdef N22_HAS_PMONITOR
    .disp_o_alu_pmon_evts(s18),
`endif
    .disp_o_alu_mmode    (s19 ),
    .disp_o_alu_dmode    (s20 ),
    .disp_o_alu_x0base   (s21),
    .disp_o_alu_prdt_bpu_idx      (s22     ),
    .disp_o_alu_misalgn  (s28    ),
    .disp_o_alu_buserr   (s29     ),
    .disp_o_alu_pmperr   (s30     ),
    .disp_o_alu_replaced    (s32   ),
    .disp_o_alu_replaced_pc (s33),

    .disp_oitf_ena       (disp_oitf_ena    ),
    .disp_oitf_ptr       (disp_oitf_ptr    ),
    .disp_oitf_ready     (disp_oitf_ready  ),

    .disp_oitf_rs1en     (disp_oitf_rs1en),
    .disp_oitf_rs2en     (disp_oitf_rs2en),
    .disp_oitf_rs3en     (disp_oitf_rs3en),
    .disp_oitf_rdwen     (disp_oitf_rdwen ),
    .disp_oitf_rs1idx    (disp_oitf_rs1idx),
    .disp_oitf_rs2idx    (disp_oitf_rs2idx),
    .disp_oitf_rs3idx    (disp_oitf_rs3idx),
    .disp_oitf_rdidx     (disp_oitf_rdidx ),
    .disp_oitf_rs1fpu    (disp_oitf_rs1fpu),
    .disp_oitf_rs2fpu    (disp_oitf_rs2fpu),
    .disp_oitf_rs3fpu    (disp_oitf_rs3fpu),
    .disp_oitf_rdfpu     (disp_oitf_rdfpu),


    .oitfrd_match_disprs1(oitfrd_match_disprs1),
    .oitfrd_match_disprs2(oitfrd_match_disprs2),
    .oitfrd_match_disprs3(oitfrd_match_disprs3),
    .oitfrd_match_disprd (oitfrd_match_disprd ),

    .clk                 (clk  ),
    .rst_n               (rst_n)
  );

  wire oitf_ret_ena;
  wire [`N22_ITAG_WIDTH-1:0] oitf_ret_ptr;
  wire [`N22_RFIDX_WIDTH-1:0] oitf_ret_rdidx;
  wire oitf_ret_rdwen;
  wire oitf_ret_rdfpu;


  n22_exu_oitf u_n22_exu_oitf(

    .dis_ready            (disp_oitf_ready),
    .dis_ena              (disp_oitf_ena  ),
    .ret_ena              (oitf_ret_ena  ),

    .dis_ptr              (disp_oitf_ptr  ),

    .ret_ptr              (oitf_ret_ptr  ),
    .ret_rdidx            (oitf_ret_rdidx),
    .ret_rdwen            (oitf_ret_rdwen),
    .ret_rdfpu            (oitf_ret_rdfpu),

    .disp_i_rs1en         (disp_oitf_rs1en),
    .disp_i_rs2en         (disp_oitf_rs2en),
    .disp_i_rs3en         (disp_oitf_rs3en),
    .disp_i_rdwen         (disp_oitf_rdwen ),
    .disp_i_rs1idx        (disp_oitf_rs1idx),
    .disp_i_rs2idx        (disp_oitf_rs2idx),
    .disp_i_rs3idx        (disp_oitf_rs3idx),
    .disp_i_rdidx         (disp_oitf_rdidx ),
    .disp_i_rs1fpu        (disp_oitf_rs1fpu),
    .disp_i_rs2fpu        (disp_oitf_rs2fpu),
    .disp_i_rs3fpu        (disp_oitf_rs3fpu),
    .disp_i_rdfpu         (disp_oitf_rdfpu ),

    .oitfrd_match_disprs1 (oitfrd_match_disprs1),
    .oitfrd_match_disprs2 (oitfrd_match_disprs2),
    .oitfrd_match_disprs3 (oitfrd_match_disprs3),
    .oitfrd_match_disprd  (oitfrd_match_disprd ),

    .oitf_empty           (oitf_empty    ),
`ifdef N22_HAS_STACKSAFE
    .ret_rdsp            (oitf_ret_rdsp),
    .oitf_has_rdsp       (oitf_has_rdsp),
    .disp_i_rdsp         (disp_oitf_rdsp ),
`endif


    .clk                  (clk           ),
    .rst_n                (rst_n         )
  );

  wire s34;
  wire s35;
  wire s36;
  wire [`N22_XLEN-1:0] s37;
  wire [`N22_RFIDX_WIDTH-1:0] s38;
`ifdef N22_HAS_STACKSAFE
  wire s39;
`endif

  wire s40;
  wire s41;
  wire s42;
  wire s43;
  wire s44;
  wire [`N22_PC_SIZE-1:0] s45;
  wire [`N22_PC_SIZE-1:0] s46;
  wire [`N22_INSTR_SIZE-1:0] s47;
  wire [`N22_XLEN-1:0]    s48;
`ifdef N22_HAS_PMONITOR
  wire [31:0] s49;
`endif
  wire s50;
  wire s51;
  wire s52;
  wire s53;
  wire s54;
  wire s55;
  wire s56;
  wire s57;
  wire s58;
  wire s59;
  wire s60;
  wire s61;
  wire s62 ;
  wire s63 ;
  wire s64 ;
  wire s65 ;
  wire s66 ;
  wire s67;
  wire s68;
  wire s69;
  wire s70;
  wire s71;
  wire s72;
  wire [`N22_ADDR_SIZE-1:0] s73;
`ifdef N22_HAS_TRIGM
  wire s74  ;
  wire s75;
`endif

`ifdef N22_INDEP_MULDIV
  wire div_longp_o_valid;
  wire div_longp_o_ready;
  wire [`N22_XLEN-1:0] div_longp_o_wdat;
  wire div_longp_o_err;
  wire [`N22_ITAG_WIDTH-1:0] div_longp_o_itag;
`endif

  wire csr_ena;
  wire csr_wr_en;
  wire csr_rd_en;
  wire [12-1:0] csr_idx;

  wire [`N22_XLEN-1:0] read_csr_dat;
  wire [`N22_XLEN-1:0] read_msts_dat;
`ifdef N22_HAS_CLIC
  wire [`N22_PC_SIZE-1:0] clic_vec_pc;
`endif
  wire [`N22_XLEN-1:0] wbck_csr_msts_dat;
  wire [`N22_XLEN-1:0] wbck_csr_dat;

  wire [`N22_XLEN-1:0] csr_op1;

  wire flush_pulse;

  wire nonflush_cmt_ena;



  wire csr_access_ilgl;
  wire csr_ilegl_noncsr;
  wire csr_ilegl_prvcsr;
  wire csr_ilegl_wrocsr;


  wire [31:0] csr_mcause;
  wire [31:0] csr_mxstatus;

  wire alu_need_excp   ;

  wire [`N22_PC_SIZE-1:0]  csr_mepc_r;

  wire csr_unalgn_enable;


  n22_exu_alu   #(
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
  ) u_n22_exu_alu(
      .csr_unalgn_enable (csr_unalgn_enable ),
   `ifdef N22_HAS_ECLIC
      .csr_mcause       (csr_mcause),
      .csr_mepc         (csr_mepc_r  ),
      .csr_mxstatus     (csr_mxstatus),
   `endif
   `ifdef N22_HAS_DEBUG
    .dbg_mprven           (dbg_mprven   ),
    `endif
    .alu_need_excp    (alu_need_excp   ),

  `ifdef N22_HAS_PMP
      .pmpaddr_r     (pmpaddr_r   ),
      .pmpcfg_bit_r  (pmpcfg_bit_r),
      .pmpcfg_bit_w  (pmpcfg_bit_w),
      .pmpcfg_bit_x  (pmpcfg_bit_x),
      .pmpcfg_bit_a  (pmpcfg_bit_a),
      .pmpcfg_bit_l  (pmpcfg_bit_l),
  `endif

      .mstatus_mprv  (mstatus_mprv ),
      .mpp_m_mode     (mpp_m_mode  ),


    `ifdef N22_HAS_TRIGM
    .dbg_tdata1      (dbg_tdata1      ),
    .dbg_tdata2      (dbg_tdata2      ),
    `endif

  `ifdef N22_HAS_CSR_EAI
    .eai_csr_valid (eai_csr_valid),
    .eai_csr_ready (eai_csr_ready),
    .eai_csr_addr  (eai_csr_addr ),
    .eai_csr_wr    (eai_csr_wr   ),
    .eai_csr_wdata (eai_csr_wdata),
    .eai_csr_rdata (eai_csr_rdata),
  `endif
    .csr_access_ilgl     (csr_access_ilgl),
    .csr_ilegl_noncsr    (csr_ilegl_noncsr),
    .csr_ilegl_prvcsr    (csr_ilegl_prvcsr),
    .csr_ilegl_wrocsr    (csr_ilegl_wrocsr),
    .nonflush_cmt_ena    (nonflush_cmt_ena),

    .i_valid             (s11   ),
    .i_ready             (s12   ),
    .i_longpipe          (s13),
    .i_itag              (s14    ),
    .i_rs1               (s15     ),
    .i_rs2               (s16     ),

    .i_replaced          (s32       ),
    .i_replaced_pc       (s33    ),
    .cmt_o_replaced      (s44   ),
    .cmt_o_replaced_pc   (s45),

    .i_rdwen             (s27   ),
`ifdef N22_HAS_STACKSAFE
    .i_rdsp              (s31    ),
`endif
    .i_rdidx             (s26   ),

    .i_alu_op  (dec_alu_op),
    .i_agu_op  (dec_agu_op),
    .i_bjp_op  (dec_bjp_op),
    .i_csr_op  (dec_csr_op),
    .i_alu_info(dec_alu_info),
    .i_agu_info(dec_agu_info),
    .i_bjp_info(dec_bjp_info),
    .i_csr_info(dec_csr_info),

    .i_rv32    (dec_rv32   ),
    .i_bjp_imm (dec_bjp_imm),


`ifdef N22_HAS_MULDIV
    .i_muldiv_info       (s23),
    .i_muldiv_op         (s24),
`endif
    .i_pc                (i_pc    ),
    .i_pc_vld            (i_pc_vld),
    .i_instr             (i_ir    ),
    .i_imm               (s17     ),
`ifdef N22_HAS_PMONITOR
    .i_pmon_evts         (s18),
`endif
    .i_misalgn           (s28    ),
    .i_buserr            (s29     ),
    .i_pmperr            (s30     ),
    .i_ilegl             (dec_ilegl      ),
    .i_ilegl_prv         (dec_ilegl_prv  ),
    .i_prdt_bpu_idx      (s22),

    .i_mmode             (s19 ),
    .i_dmode             (s20 ),
    .i_x0base            (s21),

    .flush_pulse         (flush_pulse    ),


  `ifdef N22_HAS_DYNAMIC_BPU
    .bpu_updt_ena        (bpu_updt_ena ),
    .bpu_updt_take       (bpu_updt_take),
    .bpu_updt_idx        (bpu_updt_idx),
  `endif

    .cmt_o_bjp_valid     (s40  ),

    .cmt_o_valid         (s41      ),
    .cmt_o_ready         (s42      ),
    .cmt_o_pc_vld        (s43     ),
    .cmt_o_pc            (s46         ),
    .cmt_o_instr         (s47      ),
    .cmt_o_bjp_imm           (s48        ),
    .cmt_o_rv32          (s50       ),
    .cmt_o_bjp           (s51        ),
    .cmt_o_dret          (s53        ),
    .cmt_o_mret          (s52        ),
    .cmt_o_ecall         (s54      ),
    .cmt_o_ebreak        (s55     ),
    .cmt_o_fencei        (s57     ),
    .cmt_o_wfi           (s56        ),
    .cmt_o_ifu_misalgn   (s58),
    .cmt_o_ifu_buserr    (s59 ),
    .cmt_o_ifu_pmperr    (s60 ),
    .cmt_o_ifu_ilegl     (s61  ),
    .cmt_o_ifu_ilegl_ilginstr(s62),
    .cmt_o_ifu_ilegl_prvinstr(s63),
    .cmt_o_ifu_ilegl_noncsr  (s64  ),
    .cmt_o_ifu_ilegl_prvcsr  (s65  ),
    .cmt_o_ifu_ilegl_wrocsr  (s66  ),
    .cmt_o_bjp_prdt      (s67   ),
    .cmt_o_bjp_rslv      (s68   ),
    .cmt_o_misalgn       (s69),
    .cmt_o_ld            (s70),
    .cmt_o_stamo         (s71),
    .cmt_o_pmperr        (s72),
    .cmt_o_badaddr       (s73),
`ifdef N22_HAS_PMONITOR
    .cmt_o_pmon_evts     (s49),
`endif
    `ifdef N22_HAS_TRIGM
    .cmt_o_trigaddr_2dm  (s74  ),
    .cmt_o_trigaddr_2excp(s75),
    `endif

    .wbck_o_valid        (s34 ),
    .wbck_o_ready        (s36 ),
    .wbck_o_wdat         (s37  ),
    .wbck_o_rdidx        (s38 ),
    .wbck_o_wen          (s35   ),
`ifdef N22_HAS_STACKSAFE
    .wbck_o_rdsp         (s39),
`endif

    .csr_ena             (csr_ena),
    .csr_idx             (csr_idx),
    .csr_rd_en           (csr_rd_en),
    .csr_wr_en           (csr_wr_en),
    .read_csr_dat        (read_csr_dat),
    .wbck_csr_msts_dat   (wbck_csr_msts_dat),
    .read_msts_dat       (read_msts_dat),
    .wbck_csr_dat        (wbck_csr_dat),

    .csr_op1             (csr_op1),

    .agu_icb_cmd_sel     (agu_icb_cmd_sel ),

    .agu_icb_cmd_valid   (agu_icb_cmd_valid ),
    .agu_icb_cmd_ready   (agu_icb_cmd_ready ),
    .agu_icb_cmd_addr    (agu_icb_cmd_addr ),
    .agu_icb_cmd_read    (agu_icb_cmd_read   ),
    .agu_icb_cmd_wdata   (agu_icb_cmd_wdata ),
    .agu_icb_cmd_wmask   (agu_icb_cmd_wmask ),
    .agu_icb_cmd_size    (agu_icb_cmd_size),
    .agu_icb_cmd_x0base  (agu_icb_cmd_x0base),
    .agu_icb_cmd_mmode   (agu_icb_cmd_mmode ),
    .agu_icb_cmd_dmode   (agu_icb_cmd_dmode ),

    .agu_icb_cmd_usign   (agu_icb_cmd_usign),
    .agu_icb_cmd_itag    (agu_icb_cmd_itag),

  `ifdef N22_LDST_EXCP_PRECISE
    .agu_icb_cmd_rv32    (agu_icb_cmd_rv32),
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




`ifdef N22_INDEP_MULDIV
    .div_longp_o_valid   (div_longp_o_valid),
    .div_longp_o_ready   (div_longp_o_ready),
    .div_longp_o_wdat    (div_longp_o_wdat ),
    .div_longp_o_itag    (div_longp_o_itag ),
    .div_longp_o_err     (div_longp_o_err  ),
`endif

    .clk                 (clk          ),
    .rst_n               (rst_n        )
  );

  wire longp_wbck_o_valid;
  wire longp_wbck_o_wen;
  wire longp_wbck_o_ready;
  wire [`N22_FLEN-1:0] longp_wbck_o_wdat;
  wire [`N22_RFIDX_WIDTH-1:0] longp_wbck_o_rdidx;
  wire longp_wbck_o_rdfpu;
  wire [4:0] longp_wbck_o_flags;
`ifdef N22_HAS_STACKSAFE
  wire longp_wbck_o_rdsp;
`endif

  wire longp_excp_o_valid;
  wire longp_excp_o_ld;
  wire longp_excp_o_st;
  wire longp_excp_o_buserr ;
  wire longp_excp_o_pmperr ;
  wire[`N22_ADDR_SIZE-1:0]longp_excp_o_badaddr;
  wire longp_excp_o_insterr;
  wire[`N22_PC_SIZE-1:0]longp_excp_o_pc;

  n22_exu_longpwbck u_n22_exu_longpwbck(

    .lsu_wbck_i_valid   (lsu_o_valid ),
    .lsu_wbck_i_ready   (lsu_o_ready ),
    .lsu_wbck_i_wdat    (lsu_o_wbck_wdat  ),
    .lsu_wbck_i_itag    (lsu_o_wbck_itag  ),
    .lsu_wbck_i_err     (lsu_o_wbck_err   ),
    .lsu_cmt_i_ld       (lsu_o_cmt_ld     ),
    .lsu_cmt_i_st       (lsu_o_cmt_st     ),
    .lsu_cmt_i_badaddr  (lsu_o_cmt_badaddr),
    .lsu_cmt_i_pc       (lsu_o_cmt_pc),
    .lsu_cmt_i_buserr   (lsu_o_cmt_buserr ),
    .lsu_cmt_i_pmperr   (lsu_o_cmt_pmperr ),

    .longp_wbck_o_valid   (longp_wbck_o_valid ),
    .longp_wbck_o_ready   (longp_wbck_o_ready ),
    .longp_wbck_o_wdat    (longp_wbck_o_wdat  ),
    .longp_wbck_o_rdidx   (longp_wbck_o_rdidx ),
    .longp_wbck_o_rdfpu   (longp_wbck_o_rdfpu ),
    .longp_wbck_o_flags   (longp_wbck_o_flags ),
    .longp_wbck_o_wen     (longp_wbck_o_wen   ),
`ifdef N22_HAS_STACKSAFE
    .longp_wbck_o_rdsp    (longp_wbck_o_rdsp),
`endif

    .longp_excp_o_valid   (longp_excp_o_valid  ),
    .longp_excp_o_ld      (longp_excp_o_ld     ),
    .longp_excp_o_st      (longp_excp_o_st     ),
    .longp_excp_o_buserr  (longp_excp_o_buserr ),
    .longp_excp_o_pmperr  (longp_excp_o_pmperr ),
    .longp_excp_o_badaddr (longp_excp_o_badaddr),
    .longp_excp_o_insterr (longp_excp_o_insterr),
    .longp_excp_o_pc      (longp_excp_o_pc),

    .oitf_ret_rdidx      (oitf_ret_rdidx),
    .oitf_ret_rdwen      (oitf_ret_rdwen),
    .oitf_ret_rdfpu      (oitf_ret_rdfpu),
    .oitf_empty          (oitf_empty    ),
    .oitf_ret_ptr        (oitf_ret_ptr  ),
    .oitf_ret_ena        (oitf_ret_ena  ),
`ifdef N22_HAS_STACKSAFE
    .oitf_ret_rdsp       (oitf_ret_rdsp),
`endif



`ifdef N22_INDEP_MULDIV
    .div_wbck_i_valid    (div_longp_o_valid),
    .div_wbck_i_ready    (div_longp_o_ready),
    .div_wbck_i_wdat     (div_longp_o_wdat ),
    .div_wbck_i_itag     (div_longp_o_itag ),
    .div_wbck_i_err      (div_longp_o_err  ),
`endif

    .clk                 (clk          ),
    .rst_n               (rst_n        )
  );


  n22_exu_wbck u_n22_exu_wbck(
`ifdef N22_HAS_STACKSAFE
    .rf_wbck_sp_ena1   (rf_wbck_sp_ena1),
    .rf_wbck_sp_ena2   (rf_wbck_sp_ena2),
`endif
`ifndef N22_HAS_STACKSAFE
    .rf_wbck_sp_ena1   (),
    .rf_wbck_sp_ena2   (),
`endif

    .alu_wbck_i_valid   (s34 ),
    .alu_wbck_i_ready   (s36 ),
    .alu_wbck_i_wdat    (s37  ),
    .alu_wbck_i_rdidx   (s38 ),
    .alu_wbck_i_wen     (s35   ),
`ifdef N22_HAS_STACKSAFE
    .alu_wbck_i_rdsp    (s39   ),
`endif
`ifndef N22_HAS_STACKSAFE
    .alu_wbck_i_rdsp    (1'b0   ),
`endif

    .longp_wbck_i_valid (longp_wbck_o_valid ),
    .longp_wbck_i_ready (longp_wbck_o_ready ),
    .longp_wbck_i_wdat  (longp_wbck_o_wdat  ),
    .longp_wbck_i_rdidx (longp_wbck_o_rdidx ),
    .longp_wbck_i_rdfpu (longp_wbck_o_rdfpu ),
    .longp_wbck_i_flags (longp_wbck_o_flags ),
    .longp_wbck_i_wen   (longp_wbck_o_wen   ),
`ifdef N22_HAS_STACKSAFE
    .longp_wbck_i_rdsp  (longp_wbck_o_rdsp   ),
`endif
`ifndef N22_HAS_STACKSAFE
    .longp_wbck_i_rdsp  (1'b0   ),
`endif


  `ifdef N22_REGFILE_2WP
    .rf_wbck_o_ena1      (s5   ),
    .rf_wbck_o_wdat1     (s6  ),
    .rf_wbck_o_rdidx1    (s7 ),

    .rf_wbck_o_ena2      (s8   ),
    .rf_wbck_o_wdat2     (s9   ),
    .rf_wbck_o_rdidx2    (s10  ),
  `endif

  `ifndef N22_REGFILE_2WP
    .rf_wbck_o_ena      (s2    ),
    .rf_wbck_o_wdat     (s3   ),
    .rf_wbck_o_rdidx    (s4  ),
  `endif



    .clk                 (clk          ),
    .rst_n               (rst_n        )
  );

  wire [`N22_XLEN-1:0] cmt_badaddr;
  wire cmt_badaddr_ena;
  wire [`N22_PC_SIZE-1:0] cmt_epc;
  wire cmt_epc_ena;

  wire [`N22_XLEN-1:0] cmt_cause;
  wire cmt_cause_ena;
  wire cmt_instret_ena;

  wire cmt_excp;
  wire cmt_irq;
  wire cmt_virq;
  wire cmt_nmi;
  wire [`N22_XLEN-1:0] cmt_mdcause;
  wire cmt_mdcause_ena;


  wire                      cmt_mret_ena;
  wire                      cmt_dret_ena;

  wire [`N22_XLEN-1:0]     csr_mtvec_r;
  wire [`N22_XLEN-1:0]     csr_mnvec_r;
  wire mtvt2_enable;
  wire [`N22_XLEN-1:0] csr_mtvt2_r;

  wire m_mode;
  wire nmi_mode;

  wire status_mie_r;

  wire  local_irq_bus_pmperr;
  wire  local_irq_bus_err;
  wire  [`N22_ADDR_SIZE-1:0] local_irq_bus_addr;
  wire  local_irq_bus_ld;

  wire  mip_bwei_ld_r;
  wire  [`N22_ADDR_SIZE-1:0] mip_bwei_addr_r;

  wire  mip_mtie_r;
  wire  mip_msie_r;
  wire  mip_meie_r;
  wire  mip_imecci_r;
  wire  mip_bwei_r;
  wire  mip_bwei_pmp_r;
  wire  mip_pmovi_r;


  wire  mie_mtie_r;
  wire  mie_msie_r;
  wire  mie_meie_r;
  wire  mie_imecci_r;
  wire  mie_bwei_r;
  wire  mie_pmovi_r;



`ifdef N22_HAS_PMONITOR
  wire [31:0] cmt_pmon_evts;
`endif

  wire ebreak4dbg_stopcount;

  wire wr_csr_flush_req;
  wire wr_csr_flush_mmode;
  wire wr_csr_flush_dmode;
  wire wr_csr_flush_vmode;
  wire [`N22_PC_SIZE-1:0] wr_csr_flush_pc;

  wire jlmnxti_flush_req;
  wire jlmnxti_flush_mmode;
  wire jlmnxti_flush_dmode;
  wire jlmnxti_flush_vmode;
  wire [`N22_PC_SIZE-1:0] jlmnxti_flush_pc;

  wire [11:0] irq_cause_id;

  wire nmi_cause_fff;

  wire sleep_value_din;

  wire [`N22_PC_SIZE-1:0] pc_plus_ofst;

  n22_exu_commit   #(
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
  ) u_n22_exu_commit(
  `ifdef N22_LDST_EXCP_PRECISE
      .lsu_pend_outs    (lsu_pend_outs),
      .lsu_pend_rv32    (lsu_pend_rv32),
  `endif
      .pc_plus_ofst     (pc_plus_ofst),

      `ifdef N22_HAS_DEBUG_PRIVATE
    .tap_dmi_active   (tap_dmi_active),
      `endif

    .spsafe_stall     (spsafe_stall),

    .irq_cause_id     (irq_cause_id),

    .trace_ivalid     (trace_ivalid    ),
    .trace_iexception (trace_iexception),
    .trace_interrupt  (trace_interrupt ),
    .trace_cause      (trace_cause     ),
    .trace_tval       (trace_tval      ),
    .trace_iaddr      (trace_iaddr     ),
    .trace_instr      (trace_instr     ),
    .trace_priv       (trace_priv      ),

    .ebreak4dbg_stopcount(ebreak4dbg_stopcount),
`ifdef N22_HAS_STACKSAFE
    .sp_excp_taken_ena(sp_excp_taken_ena),
    .sp_ovf_excp      (sp_ovf_excp      ),
    .sp_udf_excp      (sp_udf_excp      ),
`endif
    .alu_need_excp    (alu_need_excp   ),
`ifdef N22_HAS_PMONITOR
    .cmt_pmon_evts (cmt_pmon_evts),
`endif
  `ifdef N22_HAS_DEBUG
    .dbg_prv_r             (dbg_prv_r),
  `endif
  `ifndef N22_HAS_DEBUG
    .dbg_prv_r             (2'b11),
  `endif
    .core_wfi            (core_wfi        ),
    .nonflush_cmt_ena    (nonflush_cmt_ena),

    .excp_active         (excp_active),

    .nmi_cause_fff      (nmi_cause_fff),

    .csr_wfe_bit         (csr_wfe_bit),

    .rx_evt_req          (rx_evt_req),
    .rx_evt_ack          (rx_evt_ack),

    .sleep_value_din       (sleep_value_din),
    .dbg_sleep             (dbg_sleep      ),


    .wfi_halt_exu_req    (wfi_halt_exu_req),
    .wfi_halt_exu_ack    (wfi_halt_exu_ack),
    .wfi_halt_ifu_req    (wfi_halt_ifu_req),
    .wfi_halt_ifu_ack    (wfi_halt_ifu_ack),

  `ifdef N22_HAS_DEBUG
    .dbg_halt (dbg_halt),
    .dbg_resethaltreq(dbg_resethaltreq),
  `endif
  `ifdef N22_HAS_CLIC
    .clic_irq (clic_irq),
    .clic_irq_id(clic_irq_id),
    .clic_irq_shv(clic_irq_shv),
    .clic_irq_taken(clic_irq_taken),
    .clic_vec_pc(clic_vec_pc),
    .clic_int_mode(clic_int_mode),
  `endif
    .nmi_irq_r              (nmi_irq_r),
    .nmi_irq_taken          (nmi_irq_taken),

    .status_mie_r          (status_mie_r),

    .local_irq_bus_pmperr  (local_irq_bus_pmperr ),
    .local_irq_bus_err     (local_irq_bus_err ),
    .local_irq_bus_addr    (local_irq_bus_addr),
    .local_irq_bus_ld      (local_irq_bus_ld  ),

    .mip_bwei_ld_r         (mip_bwei_ld_r     ),
    .mip_bwei_addr_r       (mip_bwei_addr_r   ),

    .mip_mtie_r            (mip_mtie_r        ),
    .mip_msie_r            (mip_msie_r        ),
    .mip_meie_r            (mip_meie_r        ),
    .mip_imecci_r          (mip_imecci_r      ),
    .mip_bwei_r            (mip_bwei_r        ),
    .mip_bwei_pmp_r        (mip_bwei_pmp_r    ),
    .mip_pmovi_r           (mip_pmovi_r       ),

    .mie_mtie_r            (mie_mtie_r        ),
    .mie_msie_r            (mie_msie_r        ),
    .mie_meie_r            (mie_meie_r        ),
    .mie_imecci_r          (mie_imecci_r      ),
    .mie_bwei_r            (mie_bwei_r        ),
    .mie_pmovi_r           (mie_pmovi_r       ),


    .alu_cmt_i_bjp_valid     (s40  ),

    .alu_cmt_i_valid         (s41      ),
    .alu_cmt_i_ready         (s42      ),
    .alu_cmt_i_pc            (s46         ),
    .alu_cmt_i_instr         (s47      ),
    .alu_cmt_i_pc_vld        (s43     ),
    .alu_cmt_i_bjp_imm           (s48        ),
    .alu_cmt_i_rv32          (s50       ),
    .alu_cmt_i_bjp           (s51        ),
    .alu_cmt_i_mret          (s52        ),
    .alu_cmt_i_dret          (s53        ),
    .alu_cmt_i_ecall         (s54      ),
    .alu_cmt_i_ebreak        (s55     ),
    .alu_cmt_i_fencei        (s57     ),
    .alu_cmt_i_wfi           (s56     ),
    .alu_cmt_i_ifu_misalgn   (s58),
    .alu_cmt_i_ifu_buserr    (s59 ),
    .alu_cmt_i_ifu_buserr_btm(i_buserr_btm ),
    .alu_cmt_i_ifu_pmperr    (s60 ),
    .alu_cmt_i_ifu_ilegl     (s61  ),
    .alu_cmt_i_ifu_ilegl_ilginstr(s62),
    .alu_cmt_i_ifu_ilegl_prvinstr(s63),
    .alu_cmt_i_ifu_ilegl_noncsr  (s64  ),
    .alu_cmt_i_ifu_ilegl_prvcsr  (s65  ),
    .alu_cmt_i_ifu_ilegl_wrocsr  (s66  ),
    .alu_cmt_i_bjp_prdt      (s67   ),
    .alu_cmt_i_bjp_rslv      (s68   ),
    .alu_cmt_i_misalgn       (s69),
    .alu_cmt_i_ld            (s70),
    .alu_cmt_i_stamo         (s71),
    .alu_cmt_i_pmperr        (s72),
    .alu_cmt_i_badaddr       (s73),
`ifdef N22_HAS_PMONITOR
    .alu_cmt_i_pmon_evts     (s49),
`endif
    `ifdef N22_HAS_TRIGM
    .alu_cmt_i_trigaddr_2dm  (s74  ),
    .alu_cmt_i_trigaddr_2excp(s75),
    `endif
    .alu_cmt_i_replaced      (s44   ),
    .alu_cmt_i_replaced_pc   (s45),


    .longp_excp_i_valid    (longp_excp_o_valid  ),
    .longp_excp_i_ld       (longp_excp_o_ld     ),
    .longp_excp_i_st       (longp_excp_o_st     ),
    .longp_excp_i_buserr   (longp_excp_o_buserr ),
    .longp_excp_i_pmperr   (longp_excp_o_pmperr ),
    .longp_excp_i_badaddr  (longp_excp_o_badaddr),
    .longp_excp_i_insterr  (longp_excp_o_insterr),
    .longp_excp_i_pc       (longp_excp_o_pc     ),

    .dbg_mode              (dbg_mode),

    `ifdef N22_HAS_DEBUG
    .cmt_dpc               (cmt_dpc        ),
    .cmt_dpc_ena           (cmt_dpc_ena    ),
    .cmt_dcause            (cmt_dcause     ),
    .cmt_dcause_ena        (cmt_dcause_ena ),

    .dbg_dexc2dbg_r         (dbg_dexc2dbg_r  ),
    .cmt_ddcause           (cmt_ddcause    ),
    .cmt_ddcause_ena       (cmt_ddcause_ena),

    .cmt_dprv_ena          (cmt_dprv_ena),
    .cmt_dprv              (cmt_dprv    ),
    .dbg_step_r            (dbg_step_r),
    .dbg_ebreakm_r         (dbg_ebreakm_r),
    .dbg_ebreaku_r         (dbg_ebreaku_r),
    .dbg_stepie            (dbg_stepie   ),

    `ifdef N22_HAS_TRIGM
    .dbg_tdata1      (dbg_tdata1      ),
    .dbg_tdata2      (dbg_tdata2      ),
    .icount_taken_ena(icount_taken_ena),
    `endif


    `endif

    .reset_flag_r          (reset_flag_r),

    .oitf_empty            (oitf_empty),
    .m_mode                (m_mode),
    .nmi_mode              (nmi_mode),
    .mpp_m_mode            (mpp_m_mode),

    .cmt_badaddr           (cmt_badaddr    ),
    .cmt_badaddr_ena       (cmt_badaddr_ena),
    .cmt_epc               (cmt_epc        ),
    .cmt_epc_ena           (cmt_epc_ena    ),
    .cmt_cause             (cmt_cause      ),
    .cmt_cause_ena         (cmt_cause_ena  ),
    .cmt_instret_ena       (cmt_instret_ena  ),

    .cmt_excp              (cmt_excp       ),
    .cmt_irq               (cmt_irq        ),
    .cmt_virq              (cmt_virq       ),
    .cmt_nmi               (cmt_nmi        ),
    .cmt_mdcause           (cmt_mdcause    ),
    .cmt_mdcause_ena       (cmt_mdcause_ena),

    .cmt_dret_ena            (cmt_dret_ena     ),
    .cmt_mret_ena            (cmt_mret_ena     ),
    .csr_mepc_r              (csr_mepc_r       ),
  `ifdef N22_HAS_DEBUG
    .csr_dpc_r               (csr_dpc_r       ),
  `endif
  `ifndef N22_HAS_DEBUG
    .csr_dpc_r               (`N22_PC_SIZE'b0       ),
  `endif
    .mtvt2_enable            (mtvt2_enable),
    .csr_mtvt2_r             (csr_mtvt2_r ),
    .csr_mtvec_r             (csr_mtvec_r     ),
    .csr_mnvec_r             (csr_mnvec_r),

    .flush_pulse             (flush_pulse    ),

    .p1_flush_ack          (p1_flush_ack    ),
    .p1_flush_req          (p1_flush_req    ),
    .p1_flush_pc_mmode     (p1_flush_pc_mmode),
    .p1_flush_pc_dmode     (p1_flush_pc_dmode),
    .p1_flush_pc_vmode     (p1_flush_pc_vmode),
  `ifdef N22_TIMING_BOOST
    .p1_flush_pc           (p1_flush_pc),
    .p1_flush_fencei       (p1_flush_fencei),
  `endif

    .p2_flush_ack            (p2_flush_ack     ),
    .p2_flush_req            (p2_flush_req     ),
    .p2_flush_pc_mmode       (p2_flush_pc_mmode),
    .p2_flush_pc_dmode       (p2_flush_pc_dmode),
    .p2_flush_pc_vmode       (p2_flush_pc_vmode),
    .p2_flush_pc             (p2_flush_pc      ),
    .p2_flush_fencei       (p2_flush_fencei),

    .wr_csr_flush_req       (wr_csr_flush_req  ),
    .wr_csr_flush_mmode     (wr_csr_flush_mmode),
    .wr_csr_flush_dmode     (wr_csr_flush_dmode),
    .wr_csr_flush_vmode     (wr_csr_flush_vmode),
    .wr_csr_flush_pc        (wr_csr_flush_pc   ),

    .jlmnxti_flush_req       (jlmnxti_flush_req  ),
    .jlmnxti_flush_mmode     (jlmnxti_flush_mmode),
    .jlmnxti_flush_dmode     (jlmnxti_flush_dmode),
    .jlmnxti_flush_vmode     (jlmnxti_flush_vmode),
    .jlmnxti_flush_pc        (jlmnxti_flush_pc   ),

    .clk_aon                 (clk_aon      ),
    .clk                     (clk          ),
    .rst_n                   (rst_n        )
  );


  assign dec2ifu_rden  = disp_oitf_rdwen & (~disp_oitf_rdfpu);
  assign dec2ifu_rs2en = disp_oitf_rs2en & (~disp_oitf_rs2fpu);
  assign dec2ifu_rdidx = dec_rdidx;
  assign rf2ifu_rs2    = s1;





  n22_exu_csr#(
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
  ) u_n22_exu_csr(
      .pc_plus_ofst     (pc_plus_ofst),
      .csr_mxstatus     (csr_mxstatus),
      .csr_mcause       (csr_mcause),
      .csr_pc           (i_pc),
      .csr_ilm_enable    (csr_ilm_enable   ),
      .csr_dlm_enable    (csr_dlm_enable   ),
      .csr_icache_enable (csr_icache_enable),
      .csr_unalgn_enable (csr_unalgn_enable ),
      .csr_bpu_enable    (csr_bpu_enable    ),
      .csr_rvcompm_enable(csr_rvcompm_enable),
      .ebreak4dbg_stopcount(ebreak4dbg_stopcount),
      .ext_irq_r         (ext_irq_r),
      .sft_irq_r         (sft_irq_r),
      .tmr_irq_r         (tmr_irq_r),

      .sleep_value_din   (sleep_value_din),

      .irq_cause_id     (irq_cause_id),
`ifdef N22_HAS_STACKSAFE
      .sp_excp_taken_ena (sp_excp_taken_ena),
      .rf_wbck_sp_ena1   (rf_wbck_sp_ena1),
      .rf_wbck_sp_ena2   (rf_wbck_sp_ena2),
      .sp_r              (sp_r             ),
      .sp_ovf_excp       (sp_ovf_excp      ),
      .sp_udf_excp       (sp_udf_excp      ),
      .spsafe_enable     (spsafe_enable    ),
`endif

      .wr_csr_flush_req   (wr_csr_flush_req  ),
      .wr_csr_flush_mmode (wr_csr_flush_mmode),
      .wr_csr_flush_dmode (wr_csr_flush_dmode),
      .wr_csr_flush_vmode (wr_csr_flush_vmode),
      .wr_csr_flush_pc    (wr_csr_flush_pc   ),

      .jlmnxti_flush_req   (jlmnxti_flush_req  ),
      .jlmnxti_flush_mmode (jlmnxti_flush_mmode),
      .jlmnxti_flush_dmode (jlmnxti_flush_dmode),
      .jlmnxti_flush_vmode (jlmnxti_flush_vmode),
      .jlmnxti_flush_pc    (jlmnxti_flush_pc   ),

      .nmi_cause_fff(nmi_cause_fff),

      .pc_rtvec     (pc_rtvec),

      `ifdef N22_HAS_PMONITOR
      .cmt_pmon_evts (cmt_pmon_evts),
      `endif

      .csr_uitb_addr  (csr_uitb_addr  ),
       `ifdef N22_HAS_POWERBRAKE
      .csr_mpftctl_tlevel  (csr_mpftctl_tlevel),
      .csr_mxstat_pften  (csr_mxstat_pften),
       `endif

      .sleep_value     (sleep_value),
      .tx_evt          (tx_evt     ),
      .csr_wfe_bit     (csr_wfe_bit),

    `ifdef N22_HAS_CLIC
      .mip_bwei             (mip_bwei    ),
      .mip_pmovi            (mip_pmovi    ),
      .mip_imecci           (mip_imecci    ),
      .minhv_clear_r          (minhv_clear_r),
      .mintstatus_mil_r           (mintstatus_mil_r),
      .clic_irq_id          (clic_irq_id),
      .clic_irq_lvl         (clic_irq_lvl),
      .clic_irq_shv         (clic_irq_shv),
      .clic_prio_gt_thod    (clic_prio_gt_thod),
      .core_in_int          (core_in_int),
      .mnxti_valid_taken    (mnxti_valid_taken),
      .clic_int_mode        (clic_int_mode),
      .clic_vec_pc          (clic_vec_pc),
    `endif
      .wbck_csr_msts_dat    (wbck_csr_msts_dat),
      .read_msts_dat        (read_msts_dat),

    `ifdef N22_HAS_PMP
      .pmpaddr_r     (pmpaddr_r   ),
      .pmpcfg_bit_r  (pmpcfg_bit_r),
      .pmpcfg_bit_w  (pmpcfg_bit_w),
      .pmpcfg_bit_x  (pmpcfg_bit_x),
      .pmpcfg_bit_a  (pmpcfg_bit_a),
      .pmpcfg_bit_l  (pmpcfg_bit_l),

    `endif

      .mstatus_mprv  (mstatus_mprv ),

    .csr_access_ilgl     (csr_access_ilgl),
    .csr_ilegl_noncsr    (csr_ilegl_noncsr),
    .csr_ilegl_prvcsr    (csr_ilegl_prvcsr),
    .csr_ilegl_wrocsr    (csr_ilegl_wrocsr),
    .nonflush_cmt_ena    (nonflush_cmt_ena),
    .csr_ena             (csr_ena),
    .csr_idx             (csr_idx),
    .csr_rd_en           (csr_rd_en),
    .csr_wr_en           (csr_wr_en),
    .read_csr_dat        (read_csr_dat),
    .wbck_csr_dat        (wbck_csr_dat),

    .csr_op1             (csr_op1),

    .cmt_badaddr           (cmt_badaddr    ),
    .cmt_badaddr_ena       (cmt_badaddr_ena),
    .cmt_epc               (cmt_epc        ),
    .cmt_epc_ena           (cmt_epc_ena    ),
    .cmt_cause             (cmt_cause      ),
    .cmt_cause_ena         (cmt_cause_ena  ),
    .cmt_instret_ena       (cmt_instret_ena  ),

    .cmt_excp              (cmt_excp       ),
    .cmt_irq               (cmt_irq        ),
    .cmt_virq              (cmt_virq       ),
    .cmt_nmi               (cmt_nmi        ),
    .cmt_mdcause           (cmt_mdcause    ),
    .cmt_mdcause_ena       (cmt_mdcause_ena),

    .cmt_dret_ena  (cmt_dret_ena     ),
    .cmt_mret_ena  (cmt_mret_ena     ),
    .csr_mepc_r    (csr_mepc_r       ),
    .csr_mtvec_r   (csr_mtvec_r     ),
    .csr_mnvec_r   (csr_mnvec_r),
    .mtvt2_enable            (mtvt2_enable),
    .csr_mtvt2_r             (csr_mtvt2_r ),

  `ifdef N22_HAS_DEBUG

    .dbg_csr_ena       (dbg_csr_ena     ),
    .dbg_csr_wr_en     (dbg_csr_wr_en   ),
    .dbg_csr_rd_en     (dbg_csr_rd_en   ),
    .dbg_wbck_csr_wen  (dbg_wbck_csr_wen),
    .dbg_csr_idx       (dbg_csr_idx     ),
    .dbg_wbck_csr_dat  (dbg_wbck_csr_dat),
    .dbg_read_csr_dat  (dbg_read_csr_dat),
    .dbg_csr_addr_legal(dbg_csr_addr_legal),
    .dbg_csr_prv_ilgl  (dbg_csr_prv_ilgl),

    .dbg_prv_r             (dbg_prv_r),

    .dbg_stopcount          (dbg_stopcount),

  `endif


    .dbg_mode       (dbg_mode       ),


    .nmi_mode      (nmi_mode),

    .m_mode        (m_mode),
    .mpp_m_mode    (mpp_m_mode),

    .core_mhartid  (core_mhartid),

    .status_mie_r  (status_mie_r),

    .local_irq_bus_pmperr  (local_irq_bus_pmperr ),
    .local_irq_bus_err     (local_irq_bus_err ),
    .local_irq_bus_addr    (local_irq_bus_addr),
    .local_irq_bus_ld      (local_irq_bus_ld  ),

    .mip_bwei_ld_r         (mip_bwei_ld_r     ),
    .mip_bwei_addr_r       (mip_bwei_addr_r   ),

    .mip_mtie_r            (mip_mtie_r        ),
    .mip_msie_r            (mip_msie_r        ),
    .mip_meie_r            (mip_meie_r        ),
    .mip_imecci_r          (mip_imecci_r      ),
    .mip_bwei_r            (mip_bwei_r        ),
    .mip_bwei_pmp_r        (mip_bwei_pmp_r    ),
    .mip_pmovi_r           (mip_pmovi_r       ),

    .mie_mtie_r            (mie_mtie_r        ),
    .mie_msie_r            (mie_msie_r        ),
    .mie_meie_r            (mie_meie_r        ),
    .mie_imecci_r          (mie_imecci_r      ),
    .mie_bwei_r            (mie_bwei_r        ),
    .mie_pmovi_r           (mie_pmovi_r       ),


    .clk_aon       (clk_aon      ),
    .clk           (clk          ),
    .rst_n         (rst_n        )
  );

  assign exu_active = (~core_wfi) & (
                      (~oitf_empty) | i_valid | excp_active
  `ifdef N22_HAS_CLIC
                    | minhv_clear_r
  `endif
                      )
                    ;


endmodule




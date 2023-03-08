


`include "global.inc"

module n22_exu_commit #(
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
  output ebreak4dbg_stopcount,

  input   spsafe_stall,


      `ifdef N22_HAS_DEBUG_PRIVATE
  input   tap_dmi_active,
      `endif
  `ifdef N22_LDST_EXCP_PRECISE
  input lsu_pend_outs,
  input lsu_pend_rv32,
  `endif

  input   [2-1:0] dbg_prv_r,
`ifdef N22_HAS_STACKSAFE
  input   sp_ovf_excp,
  input   sp_udf_excp,
  output  sp_excp_taken_ena,
`endif

  output  alu_need_excp,
  output  core_wfi,
  output  nonflush_cmt_ena,

  output  excp_active,

  output [11:0] irq_cause_id,

  input   csr_wfe_bit,

  input   rx_evt_req,
  output  rx_evt_ack,

  input   nmi_cause_fff,

  output  wfi_halt_ifu_req,
  output  wfi_halt_exu_req,
  input   wfi_halt_ifu_ack,
  input   wfi_halt_exu_ack,

  input   sleep_value_din,
  output  dbg_sleep,

  output trace_ivalid,
  output trace_iexception,
  output trace_interrupt,
  output [`N22_XLEN-1:0] trace_cause,
  output [`N22_XLEN-1:0] trace_tval,
  output [`N22_XLEN-1:0] trace_iaddr,
  output [`N22_XLEN-1:0] trace_instr,
  output [1:0] trace_priv,


    `ifdef N22_HAS_CLIC
  input  clic_irq,
  input  [9:0] clic_irq_id,
  input  clic_irq_shv,
  input  clic_int_mode,
  output clic_irq_taken,
  input [`N22_PC_SIZE-1:0] clic_vec_pc,
    `endif
  output nmi_irq_taken,
  input  nmi_irq_r,

  output  local_irq_bus_err,
  output  local_irq_bus_pmperr,
  output  [`N22_ADDR_SIZE-1:0] local_irq_bus_addr,
  output  local_irq_bus_ld,

  input   mip_bwei_ld_r,
  input   [`N22_ADDR_SIZE-1:0] mip_bwei_addr_r,

  input   mip_mtie_r,
  input   mip_msie_r,
  input   mip_meie_r,
  input   mip_imecci_r,
  input   mip_bwei_r,
  input   mip_bwei_pmp_r,
  input   mip_pmovi_r,

  input   mie_mtie_r,
  input   mie_msie_r,
  input   mie_meie_r,
  input   mie_imecci_r,
  input   mie_bwei_r,
  input   mie_pmovi_r,


  input   status_mie_r,

`ifdef N22_HAS_PMONITOR
  input  [31:0] alu_cmt_i_pmon_evts,
  output [31:0] cmt_pmon_evts,
`endif
  input                      alu_cmt_i_bjp_valid,

  input                      alu_cmt_i_valid,
  output                     alu_cmt_i_ready,
  input  [`N22_PC_SIZE-1:0] alu_cmt_i_pc,
  input  [`N22_INSTR_SIZE-1:0] alu_cmt_i_instr,
  input                      alu_cmt_i_pc_vld,
  input  [`N22_XLEN-1:0]    alu_cmt_i_bjp_imm,
  input                      alu_cmt_i_rv32,
  input   alu_cmt_i_replaced,
  input   [`N22_PC_SIZE-1:0] alu_cmt_i_replaced_pc,
  input                      alu_cmt_i_bjp,
  input                      alu_cmt_i_wfi,
  input                      alu_cmt_i_fencei,
  input                      alu_cmt_i_mret,
  input                      alu_cmt_i_dret,
  input                      alu_cmt_i_ecall,
  input                      alu_cmt_i_ebreak,
  input                      alu_cmt_i_ifu_misalgn ,
  input                      alu_cmt_i_ifu_buserr ,
  input                      alu_cmt_i_ifu_pmperr ,
  input                      alu_cmt_i_ifu_ilegl ,
  input                      alu_cmt_i_ifu_ilegl_ilginstr ,
  input                      alu_cmt_i_ifu_ilegl_prvinstr ,
  input                      alu_cmt_i_ifu_ilegl_noncsr ,
  input                      alu_cmt_i_ifu_ilegl_prvcsr ,
  input                      alu_cmt_i_ifu_ilegl_wrocsr ,
  input                      alu_cmt_i_bjp_prdt,
  input                      alu_cmt_i_bjp_rslv,
  input                      alu_cmt_i_misalgn,
  input                      alu_cmt_i_ld,
  input                      alu_cmt_i_stamo,
  input                      alu_cmt_i_pmperr ,
  input [`N22_ADDR_SIZE-1:0]alu_cmt_i_badaddr,
    `ifdef N22_HAS_TRIGM
  input                      alu_cmt_i_trigaddr_2dm ,
  input                      alu_cmt_i_trigaddr_2excp,
    `endif
  input  alu_cmt_i_ifu_buserr_btm,

  input   dbg_mode,

  output  [`N22_XLEN-1:0] cmt_badaddr,
  output  cmt_badaddr_ena,
  output  [`N22_PC_SIZE-1:0] cmt_epc,
  output  cmt_epc_ena,
  output  [`N22_XLEN-1:0] cmt_cause,
  output  cmt_cause_ena,
  output  cmt_instret_ena,

  output  cmt_excp,
  output  cmt_irq,
  output  cmt_virq,
  output  cmt_nmi,
  output  [`N22_XLEN-1:0] cmt_mdcause,
  output  cmt_mdcause_ena,

  input   reset_flag_r,

    `ifdef N22_HAS_DEBUG

  output  [`N22_PC_SIZE-1:0] cmt_dpc,
  output  cmt_dpc_ena,
  output  [3-1:0] cmt_dcause,
  output  cmt_dcause_ena,

  input   [`N22_XLEN-1:0] dbg_dexc2dbg_r,
  output  [`N22_XLEN-1:0] cmt_ddcause,
  output  cmt_ddcause_ena,

  output  cmt_dprv_ena,
  output  [2-1:0] cmt_dprv,



  input   dbg_halt,
  input   dbg_resethaltreq,

  input   dbg_step_r,
  input   dbg_ebreakm_r,

  input   dbg_ebreaku_r,
  input   dbg_stepie,

    `ifdef N22_HAS_TRIGM
  input  [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata1,
  input  [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata2,
  output icount_taken_ena,
    `endif
  `endif

  output                     cmt_mret_ena,
  output                     cmt_dret_ena,

  input [`N22_PC_SIZE-1:0]  csr_mepc_r,
  input [`N22_PC_SIZE-1:0]  csr_dpc_r,
  input [`N22_XLEN-1:0]     csr_mtvec_r,
  input [`N22_XLEN-1:0]     csr_mnvec_r,

  input   mtvt2_enable,
  input   [`N22_XLEN-1:0] csr_mtvt2_r,

  output [`N22_PC_SIZE-1:0] pc_plus_ofst,

  input   oitf_empty,

  input   m_mode,
  input   nmi_mode,
  input   mpp_m_mode,

  input                      longp_excp_i_valid,
  input                      longp_excp_i_ld,
  input                      longp_excp_i_st,
  input                      longp_excp_i_buserr ,
  input [`N22_ADDR_SIZE-1:0]longp_excp_i_badaddr,
  input                      longp_excp_i_insterr,
  input                      longp_excp_i_pmperr,
  input [`N22_PC_SIZE-1:0]  longp_excp_i_pc,

  output  flush_pulse,

  input   p1_flush_ack,
  output  p1_flush_req,
  output  p1_flush_pc_mmode,
  output  p1_flush_pc_dmode,
  output  p1_flush_pc_vmode,
  output  [`N22_PC_SIZE-1:0] p1_flush_pc,
  output  p1_flush_fencei,

  input   p2_flush_ack,
  output  p2_flush_req,
  output  p2_flush_pc_mmode,
  output  p2_flush_pc_dmode,
  output  p2_flush_pc_vmode,
  output  [`N22_PC_SIZE-1:0] p2_flush_pc,
  output  p2_flush_fencei,

  input   jlmnxti_flush_req,
  input   jlmnxti_flush_mmode,
  input   jlmnxti_flush_dmode,
  input   jlmnxti_flush_vmode,
  input   [`N22_PC_SIZE-1:0] jlmnxti_flush_pc,

  input   wr_csr_flush_req,
  input   wr_csr_flush_mmode,
  input   wr_csr_flush_dmode,
  input   wr_csr_flush_vmode,
  input   [`N22_PC_SIZE-1:0] wr_csr_flush_pc,

  input  clk_aon,
  input  clk,
  input  rst_n
  );

  wire excpirq_flush_req;

  wire                      alu_brchmis_flush_req;
  wire                      alu_brchmis_flush_pc_mmode;
  wire                      alu_brchmis_flush_pc_dmode;
  wire [`N22_PC_SIZE-1:0] alu_brchmis_flush_pc;
  wire alu_brchmis_flush_fencei;

  wire                      alu_brchmis_cmt_i_ready;


  wire nonalu_excpirq_flush_req;

  n22_exu_branchslv u_n22_exu_branchslv(
    .dbg_prv_r             (dbg_prv_r),
    .excpirq_flush_req       (excpirq_flush_req),
    .cmt_i_ready             (alu_brchmis_cmt_i_ready    ),
    .cmt_i_bjp_valid         (alu_cmt_i_bjp_valid   ),
    .cmt_i_rv32              (alu_cmt_i_rv32    ),
    .cmt_i_bjp               (alu_cmt_i_bjp     ),
    .cmt_i_fencei            (alu_cmt_i_fencei  ),
    .cmt_i_mret              (alu_cmt_i_mret     ),
    .cmt_i_dret              (alu_cmt_i_dret     ),
    .cmt_i_bjp_prdt          (alu_cmt_i_bjp_prdt),
    .cmt_i_bjp_rslv          (alu_cmt_i_bjp_rslv),
    .cmt_i_pc                (alu_cmt_i_pc      ),
    .cmt_i_bjp_imm               (alu_cmt_i_bjp_imm     ),
    .cmt_i_replaced          (alu_cmt_i_replaced   ),

  `ifdef N22_LDST_EXCP_PRECISE
    .lsu_pend_outs           (lsu_pend_outs),
    .lsu_pend_rv32           (lsu_pend_rv32),
  `endif

    .cmt_i_ifu_buserr        (alu_cmt_i_ifu_buserr    ),
    .cmt_i_ifu_buserr_btm    (alu_cmt_i_ifu_buserr_btm),
    .pc_plus_ofst            (pc_plus_ofst            ),

    .cmt_mret_ena            (cmt_mret_ena      ),
    .cmt_dret_ena            (cmt_dret_ena       ),
    .csr_mepc_r              (csr_mepc_r         ),
    .csr_dpc_r               (csr_dpc_r         ),

    .dbg_mode                (dbg_mode),
    .m_mode                  (m_mode),
    .mpp_m_mode              (mpp_m_mode),

    .nonalu_excpirq_flush_req(nonalu_excpirq_flush_req),
    .brchmis_flush_ack       (1'b1    ),
    .brchmis_flush_req       (alu_brchmis_flush_req    ),
    .brchmis_flush_pc_mmode  (alu_brchmis_flush_pc_mmode),
    .brchmis_flush_pc_dmode  (alu_brchmis_flush_pc_dmode),
  `ifdef N22_TIMING_BOOST
    .brchmis_flush_pc        (alu_brchmis_flush_pc),
    .brchmis_flush_fencei    (alu_brchmis_flush_fencei),
  `endif

    .clk   (clk  ),
    .rst_n (rst_n)
  );

  wire excpirq_flush_pc_mmode;
  wire excpirq_flush_pc_dmode;
  wire excpirq_flush_pc_vmode;
  `ifdef N22_TIMING_BOOST
  wire [`N22_PC_SIZE-1:0] excpirq_flush_pc;
  `endif
  wire alu_excp_cmt_i_ready;

  wire cmt_ena;


  n22_exu_excp  #(
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
  ) u_n22_exu_excp(
      `ifdef N22_HAS_DEBUG_PRIVATE
    .tap_dmi_active   (tap_dmi_active),
      `endif

  `ifdef N22_LDST_EXCP_PRECISE
    .lsu_pend_outs           (lsu_pend_outs),
  `endif

    .spsafe_stall     (spsafe_stall),

    .trace_ivalid     (trace_ivalid    ),
    .trace_iexception (trace_iexception),
    .trace_interrupt  (trace_interrupt ),
    .trace_cause      (trace_cause     ),
    .trace_tval       (trace_tval      ),
    .trace_iaddr      (trace_iaddr     ),
    .trace_instr      (trace_instr     ),
    .trace_priv       (trace_priv      ),

    .mpp_m_mode              (mpp_m_mode),

    .irq_cause_id   (irq_cause_id),
    .ebreak4dbg_stopcount (ebreak4dbg_stopcount),
`ifdef N22_HAS_STACKSAFE
    .sp_ovf_excp      (sp_ovf_excp      ),
    .sp_udf_excp      (sp_udf_excp      ),
    .sp_excp_taken_ena(sp_excp_taken_ena),
`endif
    .alu_need_excp (alu_need_excp),

    .csr_wfe_bit         (csr_wfe_bit),

    .rx_evt_req          (rx_evt_req),
    .rx_evt_ack          (rx_evt_ack),


    .nmi_cause_fff      (nmi_cause_fff),

    .core_wfi              (core_wfi        ),
    .wfi_halt_ifu_req      (wfi_halt_ifu_req),
    .wfi_halt_exu_req      (wfi_halt_exu_req),
    .wfi_halt_ifu_ack      (wfi_halt_ifu_ack),
    .wfi_halt_exu_ack      (wfi_halt_exu_ack),
    .sleep_value_din       (sleep_value_din),
    .dbg_sleep             (dbg_sleep      ),

    .cmt_badaddr           (cmt_badaddr    ),
    .cmt_badaddr_ena       (cmt_badaddr_ena),
    .cmt_epc              (cmt_epc        ),
    .cmt_epc_ena          (cmt_epc_ena    ),
    .csr_mepc_r           (csr_mepc_r),
    .cmt_cause             (cmt_cause      ),
    .cmt_cause_ena         (cmt_cause_ena  ),

    .cmt_excp              (cmt_excp       ),
    .cmt_irq               (cmt_irq        ),
    .cmt_virq              (cmt_virq       ),
    .cmt_nmi               (cmt_nmi        ),
    .cmt_mdcause           (cmt_mdcause    ),
    .cmt_mdcause_ena       (cmt_mdcause_ena),


    .cmt_dret_ena          (cmt_dret_ena   ),
    .cmt_ena               (cmt_ena        ),
    .nonflush_cmt_ena      (nonflush_cmt_ena),

    .alu_excp_i_valid      (alu_cmt_i_valid  ),
    .alu_excp_i_ready      (alu_excp_cmt_i_ready    ),
    .alu_excp_i_misalgn    (alu_cmt_i_misalgn),
    .alu_excp_i_ld         (alu_cmt_i_ld     ),
    .alu_excp_i_stamo      (alu_cmt_i_stamo  ),
    .alu_excp_i_pmperr     (alu_cmt_i_pmperr ),
    .alu_excp_i_pc         (alu_cmt_i_pc     ),
    .alu_excp_i_instr      (alu_cmt_i_instr  ),
    .alu_excp_i_rv32       (alu_cmt_i_rv32   ),
    .alu_excp_i_pc_vld     (alu_cmt_i_pc_vld ),
    .alu_excp_i_replaced   (alu_cmt_i_replaced   ),
    .alu_excp_i_replaced_pc(alu_cmt_i_replaced_pc),
    .alu_excp_i_badaddr    (alu_cmt_i_badaddr ),
    .alu_excp_i_ecall      (alu_cmt_i_ecall   ),
    .alu_excp_i_ebreak     (alu_cmt_i_ebreak  ),
    .alu_excp_i_wfi        (alu_cmt_i_wfi  ),
    .alu_excp_i_ifu_misalgn(alu_cmt_i_ifu_misalgn),
    .alu_excp_i_ifu_buserr (alu_cmt_i_ifu_buserr ),
    .alu_excp_i_ifu_pmperr (alu_cmt_i_ifu_pmperr ),
    .alu_excp_i_ifu_ilegl  (alu_cmt_i_ifu_ilegl  ),
    .alu_excp_i_ifu_ilegl_ilginstr(alu_cmt_i_ifu_ilegl_ilginstr),
    .alu_excp_i_ifu_ilegl_prvinstr(alu_cmt_i_ifu_ilegl_prvinstr),
    .alu_excp_i_ifu_ilegl_noncsr  (alu_cmt_i_ifu_ilegl_noncsr  ),
    .alu_excp_i_ifu_ilegl_prvcsr  (alu_cmt_i_ifu_ilegl_prvcsr  ),
    .alu_excp_i_ifu_ilegl_wrocsr  (alu_cmt_i_ifu_ilegl_wrocsr  ),
    `ifdef N22_HAS_TRIGM
    .alu_excp_i_trigaddr_2dm  (alu_cmt_i_trigaddr_2dm  ),
    .alu_excp_i_trigaddr_2excp(alu_cmt_i_trigaddr_2excp),
    `endif

    .pc_plus_ofst            (pc_plus_ofst            ),

    .longp_excp_i_valid    (longp_excp_i_valid  ),
    .longp_excp_i_ld       (longp_excp_i_ld     ),
    .longp_excp_i_st       (longp_excp_i_st     ),
    .longp_excp_i_buserr   (longp_excp_i_buserr ),
    .longp_excp_i_pmperr   (longp_excp_i_pmperr ),
    .longp_excp_i_badaddr  (longp_excp_i_badaddr),
    .longp_excp_i_pc       (longp_excp_i_pc     ),

    .csr_mtvec_r           (csr_mtvec_r       ),
    .csr_mnvec_r           (csr_mnvec_r       ),

    .mtvt2_enable          (mtvt2_enable),
    .csr_mtvt2_r           (csr_mtvt2_r ),

    `ifdef N22_HAS_CLIC
    .clic_irq(clic_irq),
    .clic_irq_id(clic_irq_id),
    .clic_irq_shv(clic_irq_shv),
    .clic_int_mode(clic_int_mode),
    .clic_irq_taken(clic_irq_taken),
    .clic_vec_pc(clic_vec_pc),
    `endif

    .nmi_irq_taken         (nmi_irq_taken),
    .nmi_irq_r             (nmi_irq_r),

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

    .status_mie_r          (status_mie_r),

    .reset_flag_r          (reset_flag_r),

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

    .dbg_halt              (dbg_halt),
    .dbg_resethaltreq      (dbg_resethaltreq),

    `ifdef N22_HAS_TRIGM
    .dbg_tdata1      (dbg_tdata1      ),
    .dbg_tdata2      (dbg_tdata2      ),
    .icount_taken_ena(icount_taken_ena),
    `endif

    .dbg_step_r            (dbg_step_r),
    .dbg_ebreakm_r         (dbg_ebreakm_r),
    .dbg_ebreaku_r         (dbg_ebreaku_r),
    .dbg_stepie            (dbg_stepie),
  `endif

    .dbg_mode              (dbg_mode),

    .oitf_empty            (oitf_empty),

    .m_mode                (m_mode),
    .nmi_mode                (nmi_mode),

    .excpirq_flush_req        (excpirq_flush_req       ),
    .excpirq_flush_pc_mmode   (excpirq_flush_pc_mmode),
    .excpirq_flush_pc_dmode   (excpirq_flush_pc_dmode),
    .excpirq_flush_pc_vmode   (excpirq_flush_pc_vmode),
    .excpirq_flush_pc         (excpirq_flush_pc),

    .nonalu_excpirq_flush_req(nonalu_excpirq_flush_req),

    .excp_active (excp_active),

    .clk_aon (clk_aon),
    .clk   (clk  ),
    .rst_n (rst_n)
  );




  wire pipe_flush_req = p1_flush_req | p2_flush_req;

  assign alu_cmt_i_ready = alu_excp_cmt_i_ready & alu_brchmis_cmt_i_ready;


  assign p1_flush_req      = alu_brchmis_flush_req;
  assign p1_flush_pc_mmode = alu_brchmis_flush_pc_mmode;
  assign p1_flush_pc_dmode = alu_brchmis_flush_pc_dmode;
  assign p1_flush_pc_vmode = 1'b0;
  assign p1_flush_pc       = alu_brchmis_flush_pc;
  assign p1_flush_fencei   = alu_brchmis_flush_fencei;

  assign p2_flush_req      = jlmnxti_flush_req | wr_csr_flush_req | excpirq_flush_req;
  assign p2_flush_pc_mmode = jlmnxti_flush_req ? jlmnxti_flush_mmode : wr_csr_flush_req ? wr_csr_flush_mmode  : excpirq_flush_pc_mmode;
  assign p2_flush_pc_dmode = jlmnxti_flush_req ? jlmnxti_flush_dmode : wr_csr_flush_req ? wr_csr_flush_dmode  : excpirq_flush_pc_dmode;
  assign p2_flush_pc_vmode = jlmnxti_flush_req ? jlmnxti_flush_vmode : wr_csr_flush_req ? wr_csr_flush_vmode  : excpirq_flush_pc_vmode;
  assign p2_flush_pc       = jlmnxti_flush_req ? jlmnxti_flush_pc    : wr_csr_flush_req ? wr_csr_flush_pc     : excpirq_flush_pc;
  assign p2_flush_fencei   = jlmnxti_flush_req ? 1'b0                : wr_csr_flush_req ? 1'b0                : 1'b0;



  assign cmt_ena = alu_cmt_i_valid & alu_cmt_i_ready;
  assign cmt_instret_ena = cmt_ena & (~alu_cmt_i_ifu_ilegl);

  assign nonflush_cmt_ena = cmt_ena & (~pipe_flush_req);


  assign flush_pulse = cmt_ena & pipe_flush_req;



`ifndef FPGA_SOURCE
`ifndef SYNTHESIS
//synopsys translate_off


//synopsys translate_on
`endif
`endif

`ifdef N22_HAS_PMONITOR
  assign cmt_pmon_evts[0] = 1'b0;
  assign cmt_pmon_evts[1] = 1'b1;
  assign cmt_pmon_evts[8:2] =  alu_cmt_i_pmon_evts[8:2] & {7{cmt_instret_ena}};
  assign cmt_pmon_evts[9] = alu_cmt_i_pmon_evts[9] & cmt_instret_ena & alu_cmt_i_bjp_rslv;
  assign cmt_pmon_evts[31:10] = alu_cmt_i_pmon_evts[31:10] & {22{cmt_instret_ena}};
`endif

endmodule




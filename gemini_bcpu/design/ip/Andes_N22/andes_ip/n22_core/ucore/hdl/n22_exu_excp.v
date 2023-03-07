
`include "global.inc"


module n22_exu_excp #(
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
  output  alu_need_excp,
  output  ebreak4dbg_stopcount,

      `ifdef N22_HAS_DEBUG_PRIVATE
  input   tap_dmi_active,
      `endif

  `ifdef N22_LDST_EXCP_PRECISE
  input lsu_pend_outs,
  `endif

  output trace_ivalid,
  output trace_iexception,
  output trace_interrupt,
  output [`N22_XLEN-1:0] trace_cause,
  output [`N22_XLEN-1:0] trace_tval,
  output [`N22_XLEN-1:0] trace_iaddr,
  output [`N22_XLEN-1:0] trace_instr,
  output [1:0] trace_priv,

  input spsafe_stall,


  input mpp_m_mode,

  input   nmi_cause_fff,

  output [11:0] irq_cause_id,

`ifdef N22_HAS_STACKSAFE
  input   sp_ovf_excp,
  input   sp_udf_excp,
  output  sp_excp_taken_ena,
`endif

  output  core_wfi,
  output  wfi_halt_ifu_req,
  output  wfi_halt_exu_req,
  input   wfi_halt_ifu_ack,
  input   wfi_halt_exu_ack,

  input   sleep_value_din,
  output  dbg_sleep,

  input   csr_wfe_bit,

  output  alu_excp_i_ready,
  input   alu_excp_i_valid       ,
  input   alu_excp_i_ld          ,
  input   alu_excp_i_stamo       ,
  input   alu_excp_i_misalgn     ,
    `ifdef N22_HAS_TRIGM
  input   alu_excp_i_trigaddr_2dm ,
  input   alu_excp_i_trigaddr_2excp,
    `endif
  input   alu_excp_i_pmperr ,
  input   alu_excp_i_ecall ,
  input   alu_excp_i_ebreak ,
  input   alu_excp_i_wfi ,
  input   alu_excp_i_ifu_misalgn ,
  input   alu_excp_i_ifu_buserr ,
  input   alu_excp_i_ifu_pmperr ,
  input   alu_excp_i_ifu_ilegl ,
  input   alu_excp_i_ifu_ilegl_ilginstr ,
  input   alu_excp_i_ifu_ilegl_prvinstr ,
  input   alu_excp_i_ifu_ilegl_noncsr ,
  input   alu_excp_i_ifu_ilegl_prvcsr ,
  input   alu_excp_i_ifu_ilegl_wrocsr ,
  input   [`N22_ADDR_SIZE-1:0] alu_excp_i_badaddr,
  input   [`N22_PC_SIZE-1:0] alu_excp_i_pc,
  input   [`N22_INSTR_SIZE-1:0] alu_excp_i_instr,
  input   alu_excp_i_rv32,
  input   alu_excp_i_pc_vld,
  input   alu_excp_i_replaced,
  input   [`N22_PC_SIZE-1:0] alu_excp_i_replaced_pc,

  input   [`N22_PC_SIZE-1:0] pc_plus_ofst,

  input   longp_excp_i_valid,
  input   longp_excp_i_ld,
  input   longp_excp_i_st,
  input   longp_excp_i_buserr ,
  input   longp_excp_i_pmperr ,
  input   [`N22_ADDR_SIZE-1:0] longp_excp_i_badaddr,
  input   [`N22_PC_SIZE-1:0] longp_excp_i_pc,

  output  excpirq_flush_req,

  output  nonalu_excpirq_flush_req,
  output  excpirq_flush_pc_mmode,
  output  excpirq_flush_pc_dmode,
  output  excpirq_flush_pc_vmode,

  output  [`N22_PC_SIZE-1:0] excpirq_flush_pc,

  input   mtvt2_enable,
  input   [`N22_XLEN-1:0] csr_mtvt2_r,

  input   [`N22_XLEN-1:0] csr_mtvec_r,
  input   [`N22_XLEN-1:0] csr_mnvec_r,
  input   cmt_dret_ena,
  input   cmt_ena,
  input   nonflush_cmt_ena,

  output  [`N22_XLEN-1:0] cmt_badaddr,
  output  [`N22_PC_SIZE-1:0] cmt_epc,
  output  [`N22_XLEN-1:0] cmt_cause,
  output  cmt_badaddr_ena,
  output  cmt_cause_ena,
  output  cmt_epc_ena,

  input   [`N22_PC_SIZE-1:0] csr_mepc_r,

  output  cmt_excp,
  output  cmt_irq,
  output  cmt_virq,
  output  cmt_nmi,
  output  [`N22_XLEN-1:0] cmt_mdcause,
  output  cmt_mdcause_ena,



`ifdef N22_HAS_CLIC
  input   clic_irq,
  input   [9:0] clic_irq_id,
  input   clic_irq_shv,
  input   clic_int_mode,
  output  clic_irq_taken,
  input   [`N22_PC_SIZE-1:0]  clic_vec_pc,
`endif

  output  nmi_irq_taken,
  input   nmi_irq_r,

  input   rx_evt_req,
  output  rx_evt_ack,

  input   status_mie_r,

  output  local_irq_bus_pmperr,
  output  local_irq_bus_err,
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

  input   dbg_mode,

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

  input   oitf_empty,

  input   m_mode,
  input   nmi_mode,

  output  excp_active,

  input   clk_aon,
  input   clk,
  input   rst_n
  );
`ifdef N22_HAS_CLIC
  localparam CORE_CLIC_IRQ_NUM = `N22_CORE_CLIC_IRQ_NUM;
  localparam IRQ_NUM_LOG2 = `CLOG2(CORE_CLIC_IRQ_NUM);
  localparam TBASE_ALIGN_SIZE = (CORE_CLIC_IRQ_NUM  < 32) ? 7 : (IRQ_NUM_LOG2 + 2);
`endif

  `ifdef N22_LDST_EXCP_PRECISE
  assign local_irq_bus_pmperr = 1'b0;
  assign local_irq_bus_err = 1'b0;
  assign local_irq_bus_addr = `N22_ADDR_SIZE'b0;
  assign local_irq_bus_ld  = 1'b0;
  `else
  assign local_irq_bus_pmperr = longp_excp_i_valid & longp_excp_i_pmperr;
  assign local_irq_bus_err = longp_excp_i_valid & longp_excp_i_buserr;
  assign local_irq_bus_addr = longp_excp_i_badaddr;
  assign local_irq_bus_ld  = longp_excp_i_ld;
  `endif

`ifdef N22_HAS_STACKSAFE
  wire sp_ovf_excp_pend_set = sp_ovf_excp;
  wire sp_udf_excp_pend_set = sp_udf_excp;
  wire sp_ovf_excp_pend_clr = sp_excp_taken_ena;
  wire sp_udf_excp_pend_clr = sp_excp_taken_ena;
  wire sp_ovf_excp_pend_ena = sp_ovf_excp_pend_set | sp_ovf_excp_pend_clr;
  wire sp_udf_excp_pend_ena = sp_udf_excp_pend_set | sp_udf_excp_pend_clr;
  wire sp_ovf_excp_pend_nxt = sp_ovf_excp_pend_set & (~sp_ovf_excp_pend_clr);
  wire sp_udf_excp_pend_nxt = sp_udf_excp_pend_set & (~sp_udf_excp_pend_clr);
  wire sp_ovf_excp_pend_r;
  wire sp_udf_excp_pend_r;
  n22_gnrl_dfflr #(1) sp_ovf_excp_pend_dfflr (sp_ovf_excp_pend_ena, sp_ovf_excp_pend_nxt, sp_ovf_excp_pend_r, clk, rst_n);
  n22_gnrl_dfflr #(1) sp_udf_excp_pend_dfflr (sp_udf_excp_pend_ena, sp_udf_excp_pend_nxt, sp_udf_excp_pend_r, clk, rst_n);

  wire sp_ovf_excp_pend = (sp_ovf_excp_pend_r | sp_ovf_excp_pend_set);
  wire sp_udf_excp_pend = (sp_udf_excp_pend_r | sp_udf_excp_pend_set);
  wire sp_excp_pend = sp_ovf_excp_pend | sp_udf_excp_pend;
`endif

`ifndef N22_HAS_STACKSAFE
  wire sp_excp_pend = 1'b0;
  wire sp_ovf_excp_pend_r = 1'b0;
  wire sp_udf_excp_pend_r = 1'b0;
  wire sp_ovf_excp_pend = 1'b0;
  wire sp_udf_excp_pend = 1'b0;
`endif
  `ifndef N22_HAS_DEBUG
  wire  [`N22_PC_SIZE-1:0] cmt_dpc;
  wire  cmt_dpc_ena;
  wire  [3-1:0] cmt_dcause;
  wire  cmt_dcause_ena;
  wire  [32-1:0] cmt_ddcause;
  wire  cmt_ddcause_ena;

  wire  cmt_dprv_ena;
  wire  [2-1:0] cmt_dprv;

  wire   dbg_halt      = 1'b0;
  wire   dbg_step_r    = 1'b0;
  wire   dbg_ebreakm_r = 1'b0;
  wire   dbg_ebreaku_r = 1'b0;
  wire   dbg_resethaltreq = 1'b0;
  wire   [`N22_XLEN-1:0] dbg_dexc2dbg_r = 32'b0;

    `ifdef N22_HAS_TRIGM
  wire   [`N22_PC_SIZE-1:0] dbg_mtrig0 = `N22_PC_SIZE'b0;
  wire   [`N22_PC_SIZE-1:0] dbg_mtrig1 = `N22_PC_SIZE'b0;
  wire   dbg_mtrig0_pc  = 1'b0;
  wire   dbg_mtrig1_pc  = 1'b0;
  wire   dbg_mtrig0_2dm = 1'b0;
  wire   dbg_mtrig1_2dm = 1'b0;
    `endif
  `endif

  wire alu_dbg_entry_req;
  wire alu_need_flush;

  assign alu_need_excp = alu_dbg_entry_req | alu_need_flush;


  wire irq_req_active;
  wire nonalu_dbg_entry_req;



  wire wfi_req_hsked = (wfi_halt_ifu_req & wfi_halt_ifu_ack & wfi_halt_exu_req & wfi_halt_exu_ack)
                           `ifdef N22_HAS_DEBUG_PRIVATE
                            & (~tap_dmi_active)
                           `endif
                          ;
  wire dbg_entry_req;
  wire wfi_flag_r;
  wire irq_req;
  wire excpirq_flush_req_pre;
  wire wfi_flag_clr = excpirq_flush_req_pre;
  wire wfi_flag_d_r;
  wire wfi_flag_set = wfi_req_hsked & (~wfi_flag_clr) & (~wfi_flag_d_r);
  wire wfi_flag_ena = wfi_flag_set | wfi_flag_clr;
  wire wfi_flag_nxt = wfi_flag_set & (~wfi_flag_clr);
  n22_gnrl_dfflr #(1) wfi_flag_dfflr (wfi_flag_ena, wfi_flag_nxt, wfi_flag_r, clk_aon, rst_n);
  assign core_wfi = wfi_flag_r;

  wire wfi_flag_din = wfi_flag_ena ? wfi_flag_nxt : wfi_flag_r;
  wire core_wfi_din = wfi_flag_din;

  wire dbg_sleep_din = (wfi_flag_din & sleep_value_din);
  n22_gnrl_dffr #(1) dbg_sleep_dffr (dbg_sleep_din, dbg_sleep, clk_aon, rst_n);

  wire wfi_flag_d_set = wfi_flag_clr & wfi_flag_r;
  wire wfi_flag_d_clr = wfi_flag_d_r;
  wire wfi_flag_d_ena = wfi_flag_d_set | wfi_flag_d_clr;
  wire wfi_flag_d_nxt = wfi_flag_d_set & (~wfi_flag_d_clr);
  n22_gnrl_dfflr #(1) wfi_flag_d_dfflr (wfi_flag_d_ena, wfi_flag_d_nxt, wfi_flag_d_r, clk_aon, rst_n);


`ifndef FPGA_SOURCE
`ifndef SYNTHESIS
//synopsys translate_off



//synopsys translate_on
`endif
`endif





  wire wfi_cmt_ena = alu_excp_i_wfi & cmt_ena;
  wire wfi_halt_req_set = wfi_cmt_ena & (~dbg_mode);
  wire wfi_halt_req_r;
  wire wfi_halt_req_clr = wfi_flag_d_r | (wfi_halt_req_r & wfi_flag_clr);

  wire wfi_halt_req_ena = wfi_halt_req_set | wfi_halt_req_clr;
  wire wfi_halt_req_nxt = wfi_halt_req_set & (~wfi_halt_req_clr);
  n22_gnrl_dfflr #(1) wfi_halt_req_dfflr (wfi_halt_req_ena, wfi_halt_req_nxt, wfi_halt_req_r, clk, rst_n);
  assign wfi_halt_ifu_req = wfi_halt_req_r
                          & alu_excp_i_pc_vld
                            ;
  assign wfi_halt_exu_req = wfi_halt_req_r
                          & alu_excp_i_pc_vld
                            ;





  wire longp_need_flush;


  `ifdef N22_LDST_EXCP_PRECISE
  wire longp_excp_flush_req = longp_need_flush ;
  `else
  wire longp_excp_flush_req = 1'b0;
  `endif


  wire sp_flush_addi_condi = (~longp_need_flush)
                              & alu_excp_i_pc_vld
                           `ifdef N22_LDST_EXCP_PRECISE
                              & (~lsu_pend_outs)
                           `endif
                              ;

  wire sp_flush_req        = sp_excp_pend
                              & sp_flush_addi_condi;


  wire ietrig_2excp_flush_addi_condi = (~longp_need_flush) & (~sp_excp_pend)
                              & alu_excp_i_pc_vld
                           `ifdef N22_LDST_EXCP_PRECISE
                              & (~lsu_pend_outs)
                           `endif
                              & (~spsafe_stall)
                              ;

  wire ietrig_2excp_r;
  wire ietrig_2excp_flush_req = ietrig_2excp_r
                              & ietrig_2excp_flush_addi_condi;

  wire irq_flush_addi_condi = (~longp_need_flush) & (~sp_excp_pend) & (~ietrig_2excp_r)
                              & alu_excp_i_pc_vld
                           `ifdef N22_LDST_EXCP_PRECISE
                              & (~lsu_pend_outs)
                           `endif
                              & (~spsafe_stall)
                              ;

  wire irq_flush_req        = irq_req
                              & irq_flush_addi_condi;

  wire nonalu_dbg_entry_flush_addi_condi =
                              & (~irq_req) & (~longp_need_flush) & (~sp_excp_pend) & (~ietrig_2excp_r)
                              & alu_excp_i_pc_vld
                           `ifdef N22_LDST_EXCP_PRECISE
                              & (~lsu_pend_outs)
                           `endif
                              & (~spsafe_stall)
                              ;

  wire nonalu_dbg_entry_flush_req  = nonalu_dbg_entry_req
                              & nonalu_dbg_entry_flush_addi_condi;




  wire alu_dbg_entry_flush_addi_condi =
                              (~nonalu_dbg_entry_req) & (~irq_req) & (~longp_need_flush) & (~sp_excp_pend) & (~ietrig_2excp_r)
                              ;

  wire alu_dbg_entry_flush_req  = alu_dbg_entry_req
                              & alu_dbg_entry_flush_addi_condi;


  wire alu_excp_req   = alu_excp_i_valid & alu_need_flush;

  wire alu_excp_flush_addi_condi =
                                (~alu_dbg_entry_req) & (~nonalu_dbg_entry_req) & (~irq_req) & (~longp_need_flush) & (~sp_excp_pend) & (~ietrig_2excp_r);

  wire alu_excp_flush_req   = alu_excp_req
                              & alu_excp_flush_addi_condi;

  assign alu_excp_i_ready = alu_dbg_entry_flush_addi_condi;

  wire dbg_entry_flush_req  = nonalu_dbg_entry_flush_req | alu_dbg_entry_flush_req;


  wire   alu_excp_i_brk4excp;


  assign excpirq_flush_req_pre  = (ietrig_2excp_flush_req | sp_flush_req | longp_excp_flush_req | dbg_entry_flush_req | irq_flush_req | alu_excp_flush_req);
  wire all_excp_flush_type = ietrig_2excp_flush_req | sp_flush_req | longp_excp_flush_req | alu_excp_flush_req;

  assign excpirq_flush_req  = (excpirq_flush_req_pre) & (~core_wfi)
                            | wfi_flag_d_r
                              ;
  wire   all_excp_flush_ebreak = alu_excp_i_brk4excp & alu_excp_flush_req
                                 & (~ietrig_2excp_flush_req)
                                 & (~sp_flush_req)
                                 & (~longp_excp_flush_req)
                                 ;

  assign nonalu_excpirq_flush_req =
             longp_need_flush |
             ietrig_2excp_r |
             sp_excp_pend |
             nonalu_dbg_entry_req |
             irq_req          ;

  assign excp_active = irq_req_active | nonalu_dbg_entry_req;

  wire excpirq_taken_ena = excpirq_flush_req;


  wire wfi_mie_disable;
  wire nmi_req_raw;
  wire excp_taken_ena      = all_excp_flush_type & excpirq_taken_ena;
  wire rglr_irq_taken_ena  = irq_flush_req & (~wfi_mie_disable) & (~nmi_req_raw) & excpirq_taken_ena;
  wire nmi_taken_ena       = irq_flush_req & ( nmi_req_raw) & excpirq_taken_ena;
  `ifdef N22_HAS_CLIC
  assign clic_irq_taken    = rglr_irq_taken_ena;
  `endif
  wire dbg_entry_taken_ena = dbg_entry_flush_req & excpirq_taken_ena;

`ifdef N22_HAS_STACKSAFE
  assign sp_excp_taken_ena = excp_taken_ena & sp_excp_pend;
`endif

  wire [`N22_PC_SIZE-1:0] csr_mtvec_algn =  {csr_mtvec_r[`N22_PC_SIZE-1:2],2'b0};
  wire [`N22_PC_SIZE-1:0] csr_mnvec_algn =  {csr_mnvec_r[`N22_PC_SIZE-1:2],2'b0};
  `ifdef N22_HAS_CLIC
  wire [`N22_PC_SIZE-1:0] csr_mtvt2_algn =  {csr_mtvt2_r[`N22_PC_SIZE-1:2],2'b0};
  `endif

  assign nmi_irq_taken = nmi_taken_ena;

  assign {
      excpirq_flush_pc,
      excpirq_flush_pc_mmode,
      excpirq_flush_pc_dmode,
      excpirq_flush_pc_vmode
  } =
  `ifdef N22_HAS_DEBUG
      dbg_entry_flush_req ? {
          N22_DEBUG_BASE_ADDR,
              m_mode,
              1'b1,
              1'b0
          }:
      (all_excp_flush_type & all_excp_flush_ebreak & dbg_mode) ? {
          N22_DEBUG_BASE_ADDR,
              m_mode,
              dbg_mode,
              1'b0
         }:
      (all_excp_flush_type & dbg_mode) ? {
          (N22_DEBUG_BASE_ADDR + `N22_PC_SIZE'd8),
              m_mode,
              dbg_mode,
              1'b0
         }:
  `endif
      (irq_flush_req & nmi_req_raw) ? {
          csr_mnvec_algn,
              1'b1,
              dbg_mode,
              1'b0
          } :
      (all_excp_flush_type & (~dbg_mode)) ? {
           csr_mtvec_algn,
              1'b1,
              dbg_mode,
              1'b0
          } :
    `ifndef N22_HAS_CLIC
      (irq_flush_req & (~nmi_req_raw) & (~wfi_mie_disable)) ? {
            csr_mtvec_algn,
              1'b1,
              dbg_mode,
              1'b0
          }:
    `endif
    `ifdef N22_HAS_CLIC
      (irq_flush_req & (~clic_int_mode) & (~nmi_req_raw) & (~wfi_mie_disable) ) ? {
            csr_mtvec_algn ,
              1'b1,
              dbg_mode,
              1'b0
          }:
      (irq_flush_req & ( clic_int_mode) & (~nmi_req_raw) & (~wfi_mie_disable) ) ?
          (
            clic_irq_shv ? {
              clic_vec_pc,
              1'b1,
              dbg_mode,
              1'b1
              } :
            (mtvt2_enable ? {
                   csr_mtvt2_algn,
                   1'b1,
                   dbg_mode,
                   1'b0
               }: {
                   csr_mtvec_algn,
                   1'b1,
                   dbg_mode,
                   1'b0
                  }
               )
          ) :
    `endif
        (irq_flush_req & (~nmi_req_raw) & wfi_mie_disable ) ? {
                   alu_excp_i_pc,
                   m_mode,
                   dbg_mode,
                   1'b0
        } :
          wfi_flag_d_r ? {
                   alu_excp_i_pc,
                   m_mode,
                   dbg_mode,
                   1'b0
          }:{
                   csr_mtvec_algn,
                   1'b1,
                   dbg_mode,
                   1'b0
                      } ;

  `ifdef N22_LDST_EXCP_PRECISE
  assign longp_need_flush = longp_excp_i_valid;
  `else
  assign longp_need_flush = 1'b0;
  `endif


  wire step_req_r;
  wire alu_dbgebrk_flush_req;
  wire alu_dbgtrig_flush_req;

  wire dbg_icnt_req;

    `ifdef N22_HAS_TRIGM
  wire icount_2dm  ;
  wire icount_2excp;
  n22_trigm_icount_chck u_n22_trigm_icount_chck (
    .d_mode      (dbg_mode),
    .m_mode      (m_mode),
    .dbg_tdata1  (dbg_tdata1   ),
    .icount_2dm  (icount_2dm  ),
    .icount_2excp(icount_2excp)
  );

  wire icount_2dm_r  ;

  wire icount_2excp_r;
  assign icount_taken_ena = (dbg_entry_taken_ena & dbg_icnt_req)
                          | (excp_taken_ena & ietrig_2excp_flush_req & icount_2excp_r);
  wire icount_2dm_set = (~dbg_mode) & icount_2dm & cmt_ena & (~dbg_entry_taken_ena);
  wire icount_2dm_clr = dbg_entry_taken_ena;
  wire icount_2dm_ena = icount_2dm_set | icount_2dm_clr;
  wire icount_2dm_nxt = icount_2dm_set | (~icount_2dm_clr);
  n22_gnrl_dfflr #(1) icount_2dm_dfflr (icount_2dm_ena, icount_2dm_nxt, icount_2dm_r, clk, rst_n);

  wire icount_2excp_set = (~dbg_mode) & icount_2excp & cmt_ena & (~dbg_entry_taken_ena);
  wire icount_2excp_clr = excp_taken_ena;
  wire icount_2excp_ena = icount_2excp_set | icount_2excp_clr;
  wire icount_2excp_nxt = icount_2excp_set | (~icount_2excp_clr);
  n22_gnrl_dfflr #(1) icount_2excp_dfflr (icount_2excp_ena, icount_2excp_nxt, icount_2excp_r, clk, rst_n);
    `endif
    `ifndef N22_HAS_TRIGM
  wire icount_2dm_r  = 1'b0;
    `endif



  wire step_req_set = (~dbg_mode) & dbg_step_r & cmt_ena & (~dbg_entry_taken_ena);
  wire step_req_clr = dbg_entry_taken_ena;
  wire step_req_ena = step_req_set | step_req_clr;
  wire step_req_nxt = step_req_set | (~step_req_clr);
  n22_gnrl_dfflr #(1) step_req_dfflr (step_req_ena, step_req_nxt, step_req_r, clk, rst_n);

  wire resethalt_r;
  wire resethalt_set = (~dbg_mode) & reset_flag_r & dbg_resethaltreq;
  wire resethalt_clr = dbg_entry_taken_ena;
  wire resethalt_ena = resethalt_set | resethalt_clr;
  wire resethalt_nxt = resethalt_set & (~resethalt_clr);
  n22_gnrl_dfflr #(1) resethalt_dfflr (resethalt_ena, resethalt_nxt, resethalt_r, clk_aon, rst_n);

  wire resethalt_req = resethalt_r | resethalt_set;



  wire exc2dbg_type;
  wire [7:0] exc2dbg_ddcause;
  wire [7:0] exc2dbg_ddcause_sub;
  wire [7:0] exc2dbg_ddcause_r;
  wire [7:0] exc2dbg_ddcause_sub_r;

  wire exc2dbg_req_r;
  wire exc2dbg_req_set = (~dbg_mode)
                       & exc2dbg_type
                       ;
  wire exc2dbg_req_clr = dbg_entry_taken_ena;
  wire exc2dbg_req_ena = exc2dbg_req_set | exc2dbg_req_clr;
  wire exc2dbg_req_nxt = exc2dbg_req_set | (~exc2dbg_req_clr);
  n22_gnrl_dfflr #(1) exc2dbg_req_dfflr (exc2dbg_req_ena, exc2dbg_req_nxt, exc2dbg_req_r, clk, rst_n);

  n22_gnrl_dfflr #(8) exc2dbg_ddcause_dfflr     (exc2dbg_req_set, exc2dbg_ddcause,     exc2dbg_ddcause_r,     clk, rst_n);
  n22_gnrl_dfflr #(8) exc2dbg_ddcause_sub_dfflr (exc2dbg_req_set, exc2dbg_ddcause_sub, exc2dbg_ddcause_sub_r, clk, rst_n);

  `ifdef N22_HAS_TRIGM
  wire itrigger_2dm;
  wire itrigger_2excp;
  wire etrigger_2dm;
  wire etrigger_2excp;

  wire itrigger_2dm_req_r;
  wire itrigger_2dm_req_set = (~dbg_mode)
                       & itrigger_2dm
                       & rglr_irq_taken_ena
                       ;
  wire itrigger_2dm_req_clr = dbg_entry_taken_ena;
  wire itrigger_2dm_req_ena = itrigger_2dm_req_set | itrigger_2dm_req_clr;
  wire itrigger_2dm_req_nxt = itrigger_2dm_req_set | (~itrigger_2dm_req_clr);
  n22_gnrl_dfflr #(1) itrigger_2dm_req_dfflr (itrigger_2dm_req_ena, itrigger_2dm_req_nxt, itrigger_2dm_req_r, clk, rst_n);

  wire itrigger_2excp_req_r;
  wire itrigger_2excp_req_set = (~dbg_mode)
                       & itrigger_2excp
                       & rglr_irq_taken_ena
                       ;
  wire itrigger_2excp_req_clr = excp_taken_ena;
  wire itrigger_2excp_req_ena = itrigger_2excp_req_set | itrigger_2excp_req_clr;
  wire itrigger_2excp_req_nxt = itrigger_2excp_req_set | (~itrigger_2excp_req_clr);
  n22_gnrl_dfflr #(1) itrigger_2excp_req_dfflr (itrigger_2excp_req_ena, itrigger_2excp_req_nxt, itrigger_2excp_req_r, clk, rst_n);

  wire etrigger_2dm_req_r;
  wire etrigger_2dm_req_set = (~dbg_mode)
                       & etrigger_2dm
                       & excp_taken_ena
                       ;
  wire etrigger_2dm_req_clr = dbg_entry_taken_ena;
  wire etrigger_2dm_req_ena = etrigger_2dm_req_set | etrigger_2dm_req_clr;
  wire etrigger_2dm_req_nxt = etrigger_2dm_req_set | (~etrigger_2dm_req_clr);
  n22_gnrl_dfflr #(1) etrigger_2dm_req_dfflr (etrigger_2dm_req_ena, etrigger_2dm_req_nxt, etrigger_2dm_req_r, clk, rst_n);

  wire etrigger_2excp_req_r;
  wire etrigger_2excp_req_set = (~dbg_mode)
                       & etrigger_2excp
                       & excp_taken_ena
                       ;
  wire etrigger_2excp_req_clr = excp_taken_ena;
  wire etrigger_2excp_req_ena = etrigger_2excp_req_set | etrigger_2excp_req_clr;
  wire etrigger_2excp_req_nxt = etrigger_2excp_req_set | (~etrigger_2excp_req_clr);
  n22_gnrl_dfflr #(1) etrigger_2excp_req_dfflr (etrigger_2excp_req_ena, etrigger_2excp_req_nxt, etrigger_2excp_req_r, clk, rst_n);



  wire ietrigger_2excp_req_r = itrigger_2excp_req_r | etrigger_2excp_req_r;
  wire ietrigger_2dm_req_r   = itrigger_2dm_req_r   | etrigger_2dm_req_r  ;

  assign ietrig_2excp_r = ietrigger_2excp_req_r | icount_2excp_r;
  `endif
  `ifndef N22_HAS_TRIGM
  wire ietrigger_2dm_req_r   = 1'b0;
  assign ietrig_2excp_r = 1'b0;
  `endif


  `ifdef N22_HAS_DEBUG
  wire dbg_rsthalt_req = resethalt_req;
  wire dbg_exc2dbg_req = exc2dbg_req_r       & (~resethalt_req) ;
  wire dbg_ietrig_req  = ietrigger_2dm_req_r & (~resethalt_req)  & (~exc2dbg_req_r) ;
  wire dbg_halt_req  = dbg_halt              & (~resethalt_req)  & (~exc2dbg_req_r) & (~ietrigger_2dm_req_r) ;
  wire dbg_step_req = step_req_r             & (~resethalt_req)  & (~exc2dbg_req_r) & (~ietrigger_2dm_req_r) & (~dbg_halt);
  assign dbg_icnt_req = icount_2dm_r           & (~resethalt_req)& (~exc2dbg_req_r) & (~ietrigger_2dm_req_r) & (~dbg_halt) & (~step_req_r);
  wire dbg_trig_req = alu_dbgtrig_flush_req  & (~resethalt_req)  & (~exc2dbg_req_r) & (~ietrigger_2dm_req_r) & (~dbg_halt) & (~step_req_r) & (~icount_2dm_r);
  wire dbg_ebrk_req = alu_dbgebrk_flush_req  & (~resethalt_req)  & (~exc2dbg_req_r) & (~ietrigger_2dm_req_r) & (~dbg_halt) & (~step_req_r) & (~icount_2dm_r) & (~alu_dbgtrig_flush_req) ;
  `endif

  `ifndef N22_HAS_DEBUG
  wire dbg_rsthalt_req = 1'b0;
  wire dbg_exc2dbg_req = 1'b0;
  wire dbg_ietrig_req = 1'b0;
  wire dbg_halt_req  = 1'b0;
  wire dbg_step_req = 1'b0;
  assign dbg_icnt_req = 1'b0;
  wire dbg_trig_req = 1'b0;
  wire dbg_ebrk_req = 1'b0;
  `endif

  wire dbg_entry_mask  = dbg_mode;

  assign dbg_entry_req = nonalu_dbg_entry_req | alu_dbg_entry_req;
  assign alu_dbg_entry_req = (~dbg_entry_mask) & (
                                              dbg_trig_req
                                            | dbg_ebrk_req
                                            );
  assign nonalu_dbg_entry_req = (~dbg_entry_mask) & (
                                              dbg_halt_req
                                            | dbg_exc2dbg_req
                                            | dbg_ietrig_req
                                            | dbg_icnt_req
                                            | dbg_rsthalt_req
                                            | dbg_step_req
                                            );


  wire   status_mie_real = status_mie_r | (~m_mode);
  assign wfi_mie_disable = (wfi_halt_req_r & ((~status_mie_real)
                                              | csr_wfe_bit)
                                              );
  `ifdef N22_HAS_DEBUG
  wire dbg_step_mask_irq =  dbg_step_r ? (~dbg_stepie) : 1'b0;
  `endif

  `ifndef N22_HAS_DEBUG
  wire dbg_step_mask_irq =  1'b0;
  `endif

  wire nmi_mask  = dbg_mode | dbg_step_mask_irq | nmi_mode;
  wire evt_mask  = dbg_mode | dbg_step_mask_irq;
  wire irq_mask  = dbg_mode | dbg_step_mask_irq |
                   (
                       (~status_mie_real)
                     & (~wfi_mie_disable)
                   )
                   ;


  wire meie_enabled   = (mip_meie_r   & mie_meie_r);
  wire msie_enabled   = (mip_msie_r   & mie_msie_r);
  wire mtie_enabled   = (mip_mtie_r   & mie_mtie_r);
  wire imecci_enabled = (mip_imecci_r & mie_imecci_r);
  wire bwei_enabled   = (mip_bwei_r   & mie_bwei_r  );
  wire pmovi_enabled  = (mip_pmovi_r  & mie_pmovi_r );

  `ifdef N22_HAS_CLIC
  wire simple_irq_req = clic_int_mode ? clic_irq : (
  `endif
  `ifndef N22_HAS_CLIC
  wire simple_irq_req = (
  `endif
                   meie_enabled
                 | msie_enabled
                 | mtie_enabled
                 | imecci_enabled
                 | bwei_enabled
                 | pmovi_enabled
                 );

  assign nmi_req_raw = (~nmi_mask) & nmi_irq_r;
  wire irq_req_raw   = (~irq_mask) & simple_irq_req;
  wire rx_evt_raw    = (~evt_mask) & rx_evt_req;

  wire wfe_waiting = (wfi_mie_disable & csr_wfe_bit);
  assign irq_req = wfe_waiting ? (rx_evt_raw | nmi_req_raw) :
                                  (irq_req_raw | nmi_req_raw);


  assign irq_req_active = irq_req;


  wire [`N22_XLEN-1:0] irq_cause;

  assign irq_cause_id = irq_cause[11:0];

  assign irq_cause[31] = nmi_req_raw ? 1'b0 : 1'b1;
  assign irq_cause[30:12] = 19'b0;
  assign irq_cause[11:0]  =
                           `ifdef N22_MNVEC_SAME_MTVEC
                           nmi_req_raw    ? {nmi_cause_fff ? 12'hFFF : 12'h001} :
                           `else
                           nmi_req_raw    ? 12'h1 :
                           `endif
                           `ifdef N22_HAS_CLIC
                           clic_int_mode ? {{12-10{1'b0}},clic_irq_id} :
                           `endif
                           (
                           pmovi_enabled  ? 12'd18 :
                           bwei_enabled   ? 12'd17 :
                           imecci_enabled ? 12'd16 :
                           meie_enabled   ? 12'd11 :
                           msie_enabled   ? 12'd3  :
                           mtie_enabled   ? 12'd7  :
                                         12'b0);


  `ifdef N22_HAS_TRIGM
  wire alu_excp_i_trig_2excp;
  `endif
  wire alu_need_flush_pre;
  wire alu_excp_i_ebreak_real = alu_excp_i_ebreak & (~alu_need_flush_pre);
  wire ebreak4excp = (
                      (m_mode ? (~dbg_ebreakm_r) : (~dbg_ebreaku_r))
                     | dbg_mode
                     );
  assign alu_excp_i_brk4excp = (alu_excp_i_ebreak_real & (ebreak4excp));
  wire alu_excp_i_brktrig4excp = alu_excp_i_brk4excp
                             `ifdef N22_HAS_TRIGM
                                | alu_excp_i_trig_2excp
                             `endif
                                ;
  wire alu_excp_i_ebreak4dbg = alu_excp_i_ebreak_real & (~ebreak4excp);

  assign alu_dbgebrk_flush_req = alu_excp_i_valid & alu_excp_i_ebreak4dbg;
  assign ebreak4dbg_stopcount = alu_dbgebrk_flush_req;

    `ifdef N22_HAS_TRIGM

  wire alu_excp_i_trigpc_2dm;
  wire alu_excp_i_trigpc_2excp;

  n22_trigm_addrpc_chck u_n22_trigm_addrpc_chck(
    .d_mode     (dbg_mode ),
    .m_mode     (m_mode ),

    .addrpc     (alu_excp_i_pc    ),
    .typ_load   (1'b0  ),
    .typ_store  (1'b0 ),
    .typ_amo    (1'b0   ),
    .typ_pc     (1'b1   ),
    .dbg_tdata2 (dbg_tdata2),
    .dbg_tdata1 (dbg_tdata1),

    .trigger_2dm  (alu_excp_i_trigpc_2dm),
    .trigger_2excp(alu_excp_i_trigpc_2excp)
  );

  wire alu_excp_i_trig4dbg = (~dbg_mode) &
                    (
                    | alu_excp_i_trigpc_2dm
                    | alu_excp_i_trigaddr_2dm
                    );
  assign alu_excp_i_trig_2excp = (~dbg_mode) &
                    (
                    | alu_excp_i_trigpc_2excp
                    | alu_excp_i_trigaddr_2excp
                    );
  assign alu_dbgtrig_flush_req = alu_excp_i_valid & alu_excp_i_trig4dbg;
    `endif

    `ifndef N22_HAS_TRIGM
  wire alu_excp_i_trig4dbg = 1'b0;
  assign alu_dbgtrig_flush_req = 1'b0;
    `endif



  assign alu_need_flush_pre =
            ( alu_excp_i_misalgn
            | alu_excp_i_pmperr
            | alu_excp_i_ecall
            | alu_excp_i_ifu_misalgn
            | alu_excp_i_ifu_buserr
            | alu_excp_i_ifu_pmperr
            | alu_excp_i_ifu_ilegl
            );

  assign alu_need_flush =
            ( alu_need_flush_pre
            | alu_excp_i_brktrig4excp
            ) & (~alu_excp_i_trig4dbg);




  wire alu_excp_flush_req_ld    = alu_excp_flush_req & alu_excp_i_ld;
  wire alu_excp_flush_req_stamo = alu_excp_flush_req & alu_excp_i_stamo;

  wire alu_excp_flush_req_ebreak      = (alu_excp_flush_req & alu_excp_i_brktrig4excp);
  wire alu_excp_flush_req_ecall       = (alu_excp_flush_req & alu_excp_i_ecall);
  wire alu_excp_flush_req_ifu_misalgn = (alu_excp_flush_req & alu_excp_i_ifu_misalgn);
  wire alu_excp_flush_req_ifu_buserr  = (alu_excp_flush_req & alu_excp_i_ifu_buserr);
  wire alu_excp_flush_req_ifu_pmperr  = (alu_excp_flush_req & alu_excp_i_ifu_pmperr);
  wire alu_excp_flush_req_ifu_ilegl   = (alu_excp_flush_req & alu_excp_i_ifu_ilegl & (~alu_excp_i_ifu_buserr));


  wire alu_excp_flush_req_ld_misalgn    = (alu_excp_flush_req_ld    & alu_excp_i_misalgn);
  wire alu_excp_flush_req_ld_pmperr     = (alu_excp_flush_req_ld    & alu_excp_i_pmperr);
  wire alu_excp_flush_req_stamo_misalgn = (alu_excp_flush_req_stamo & alu_excp_i_misalgn);
  wire alu_excp_flush_req_stamo_pmperr  = (alu_excp_flush_req_stamo & alu_excp_i_pmperr);
  wire longp_excp_flush_req_ld_buserr   = (longp_excp_flush_req & longp_excp_i_ld & longp_excp_i_buserr);
  wire longp_excp_flush_req_st_buserr   = (longp_excp_flush_req & longp_excp_i_st & longp_excp_i_buserr);
  wire sp_ovf_flush_req = sp_flush_req & sp_ovf_excp_pend;
  wire sp_udf_flush_req = sp_flush_req & sp_udf_excp_pend;

  wire excp_flush_by_alu_agu =
                     alu_excp_flush_req_ld_misalgn
                   | alu_excp_flush_req_ld_pmperr
                   | alu_excp_flush_req_stamo_misalgn
                   | alu_excp_flush_req_stamo_pmperr;

  `ifdef N22_LDST_EXCP_PRECISE
  wire excp_flush_by_longp_ldst =
                     longp_excp_flush_req_ld_buserr
                   | longp_excp_flush_req_st_buserr;
  `endif

  wire instr_access_fault = (alu_excp_flush_req_ifu_buserr | alu_excp_flush_req_ifu_pmperr);
  wire load_access_fault = (longp_excp_flush_req_ld_buserr | alu_excp_flush_req_ld_pmperr);
  wire store_access_fault = (longp_excp_flush_req_st_buserr | alu_excp_flush_req_stamo_pmperr);

  wire [`N22_XLEN-1:0] excp_cause;
  assign excp_cause[31:10] = 22'b0;
  assign excp_cause[9:0]  =
      alu_excp_flush_req_ifu_misalgn ? 10'd0
    : instr_access_fault ? 10'd1
    : alu_excp_flush_req_ifu_ilegl  ? 10'd2
    : (alu_excp_flush_req_ebreak | ietrig_2excp_flush_req) ? 10'd3
    : alu_excp_flush_req_ld_misalgn ? 10'd4
    : load_access_fault ? 10'd5
    : alu_excp_flush_req_stamo_misalgn ? 10'd6
    : store_access_fault ? 10'd7
    : (alu_excp_flush_req_ecall & (~m_mode)) ? 10'd8
    : (alu_excp_flush_req_ecall & m_mode) ? 10'd11
    : sp_ovf_flush_req ? 10'd32
    : sp_udf_flush_req ? 10'd33
    : 10'h0;


  localparam DECX2DBG_PMOV   = 19;
  localparam DECX2DBG_BWE    = 15;
  localparam DECX2DBG_HSP    = 12;
  localparam DECX2DBG_MEC    = 11;
  localparam DECX2DBG_UEC    = 8 ;
  localparam DECX2DBG_SAF    = 7 ;
  localparam DECX2DBG_SAM    = 6 ;
  localparam DECX2DBG_LAF    = 5 ;
  localparam DECX2DBG_LAM    = 4 ;
  localparam DECX2DBG_NMI    = 3 ;
  localparam DECX2DBG_IL     = 2 ;
  localparam DECX2DBG_IAF    = 1 ;
  localparam DECX2DBG_IAM    = 0 ;

  wire dexc2dbg_iam = excp_taken_ena & alu_excp_flush_req_ifu_misalgn & dbg_dexc2dbg_r[DECX2DBG_IAM];
  wire dexc2dbg_iaf = excp_taken_ena & instr_access_fault & dbg_dexc2dbg_r[DECX2DBG_IAF];
  wire dexc2dbg_il  = excp_taken_ena & alu_excp_flush_req_ifu_ilegl & dbg_dexc2dbg_r[DECX2DBG_IL];
  wire dexc2dbg_nmi = nmi_taken_ena  & dbg_dexc2dbg_r[DECX2DBG_NMI];
  wire dexc2dbg_lam = excp_taken_ena & alu_excp_flush_req_ld_misalgn & dbg_dexc2dbg_r[DECX2DBG_LAM];
  wire dexc2dbg_laf = excp_taken_ena & load_access_fault & dbg_dexc2dbg_r[DECX2DBG_LAF];
  wire dexc2dbg_sam = excp_taken_ena & alu_excp_flush_req_stamo_misalgn & dbg_dexc2dbg_r[DECX2DBG_SAM];
  wire dexc2dbg_saf = excp_taken_ena & store_access_fault & dbg_dexc2dbg_r[DECX2DBG_SAF];
  wire dexc2dbg_uec = excp_taken_ena & (alu_excp_flush_req_ecall & (~m_mode)) & dbg_dexc2dbg_r[DECX2DBG_UEC];
  wire dexc2dbg_mec = excp_taken_ena & (alu_excp_flush_req_ecall & m_mode) & dbg_dexc2dbg_r[DECX2DBG_MEC];
  wire dexc2dbg_spovf = excp_taken_ena & sp_ovf_flush_req & dbg_dexc2dbg_r[DECX2DBG_HSP];
  wire dexc2dbg_spudf = excp_taken_ena & sp_udf_flush_req & dbg_dexc2dbg_r[DECX2DBG_HSP];
  wire dexc2dbg_bwe = rglr_irq_taken_ena & bwei_enabled & dbg_dexc2dbg_r[DECX2DBG_BWE];
  wire dexc2dbg_povf = rglr_irq_taken_ena & pmovi_enabled & dbg_dexc2dbg_r[DECX2DBG_PMOV];


  assign exc2dbg_ddcause_sub = ( (~dexc2dbg_iam) & (~dexc2dbg_iaf) & dexc2dbg_il ) ? (
                                alu_excp_i_ifu_ilegl_ilginstr ? 8'd0 :
                                alu_excp_i_ifu_ilegl_prvinstr ? 8'd1 :
                                alu_excp_i_ifu_ilegl_noncsr   ? 8'd2 :
                                alu_excp_i_ifu_ilegl_prvcsr   ? 8'd3 :
                                alu_excp_i_ifu_ilegl_wrocsr   ? 8'd4 :
                                                                8'b0

                               ) : 8'b0;

  assign {exc2dbg_ddcause, exc2dbg_type} =
                              dexc2dbg_iam ? {8'd1,1'b1}:
                              dexc2dbg_iaf ? {8'd2,1'b1}:
                              dexc2dbg_il ? {8'd3,1'b1}:
                              dexc2dbg_nmi ? {8'd4,1'b1}:
                              dexc2dbg_lam ? {8'd5,1'b1}:
                              dexc2dbg_laf ? {8'd6,1'b1}:
                              dexc2dbg_sam ? {8'd7,1'b1}:
                              dexc2dbg_saf ? {8'd8,1'b1}:
                              dexc2dbg_uec ? {8'd9,1'b1}:
                              dexc2dbg_mec ? {8'd12,1'b1}:
                              dexc2dbg_bwe ? {8'd17,1'b1}:
                              dexc2dbg_povf ? {8'd18,1'b1}:
                              dexc2dbg_spovf ? {8'd32,1'b1}:
                              dexc2dbg_spudf ? {8'd33,1'b1}:
                                             {8'd0, 1'b0};


    `ifdef N22_HAS_TRIGM
  n22_trigm_ietrig_chck u_n22_trigm_itrig_chck(
    `ifdef N22_HAS_CLIC
    .clic_int_mode(clic_int_mode),
    `else
    .clic_int_mode(1'b0),
    `endif
    .d_mode       (dbg_mode),
    .m_mode       (m_mode),
    .excp_cause   (5'b0),
    .irq_id       (irq_cause[9:0]),

    .typ_excp     (1'b0),
    .typ_irq      (1'b1),

    .dbg_tdata2   (dbg_tdata2),
    .dbg_tdata1   (dbg_tdata1),

    .trigger_2dm  (itrigger_2dm),
    .trigger_2excp(itrigger_2excp)
  );

  n22_trigm_ietrig_chck u_n22_trigm_etrig_chck(
    .clic_int_mode(1'b0),
    .d_mode       (dbg_mode),
    .m_mode       (m_mode),
    .excp_cause   (excp_cause[4:0]),
    .irq_id       (10'b0),

    .typ_excp     (1'b1),
    .typ_irq      (1'b0),

    .dbg_tdata2   (dbg_tdata2),
    .dbg_tdata1   (dbg_tdata1),

    .trigger_2dm  (etrigger_2dm),
    .trigger_2excp(etrigger_2excp)
  );
   `endif




 wire cmt_irq_bwei = (cmt_irq & (
                    `ifdef N22_HAS_CLIC
                             clic_int_mode ? (clic_irq_id == 10'd17) :
                    `endif
                             bwei_enabled));
  wire cmt_badaddr_update = excpirq_taken_ena;

  wire dummy1;
  assign {dummy1,cmt_badaddr} = cmt_irq_bwei ? {{`N22_XLEN+1-`N22_PC_SIZE{1'b0}},mip_bwei_addr_r} :
                 `ifdef N22_LDST_EXCP_PRECISE
                       (excp_flush_by_longp_ldst) ? longp_excp_i_badaddr :
                 `else
                 `endif
                       excp_flush_by_alu_agu    ? {{`N22_XLEN+1-`N22_PC_SIZE{1'b0}},alu_excp_i_badaddr} :
                             `ifdef N22_HAS_TRIGM
                       (alu_excp_flush_req_ebreak & alu_excp_i_trig_2excp & alu_excp_i_trigaddr_2excp) ? {{`N22_XLEN+1-`N22_PC_SIZE{1'b0}},alu_excp_i_badaddr} :
                       ((alu_excp_flush_req_ebreak & alu_excp_i_trig_2excp & alu_excp_i_trigpc_2excp) | ietrig_2excp_flush_req) ? {{`N22_XLEN+1-`N22_PC_SIZE{1'b0}},alu_excp_i_pc} :
                             `endif
                       alu_excp_flush_req_ifu_misalgn ? {{`N22_XLEN+1-`N22_PC_SIZE{1'b0}},alu_excp_i_pc} :
                       (instr_access_fault & alu_excp_flush_req_ifu_pmperr) ? {{`N22_XLEN+1-`N22_PC_SIZE{1'b0}},alu_excp_i_pc} :
                       (instr_access_fault & alu_excp_flush_req_ifu_buserr) ? (
                                                       alu_excp_i_replaced ? {{`N22_XLEN+1-`N22_PC_SIZE{1'b0}},alu_excp_i_replaced_pc} :
                                                    {{`N22_XLEN+1-`N22_PC_SIZE{1'b0}},pc_plus_ofst}) :
                       alu_excp_flush_req_ifu_ilegl ? (alu_excp_i_rv32 ? {1'b0,alu_excp_i_instr} : {17'b0,alu_excp_i_instr[15:0]}) :
                            {`N22_XLEN+1{1'b0}};

                 `ifdef N22_LDST_EXCP_PRECISE
  assign cmt_epc = (longp_excp_i_valid & alu_excp_i_pc_vld) ? pc_plus_ofst : alu_excp_i_pc;
                 `else
  assign cmt_epc = alu_excp_i_pc;
                 `endif


  assign cmt_cause = excp_taken_ena ? excp_cause : irq_cause;

  assign cmt_mdcause_ena = cmt_cause_ena & (
                    (cmt_excp &
                           (instr_access_fault |
                            alu_excp_flush_req_ifu_ilegl |
                            load_access_fault |
                            store_access_fault)
                        ) |
                    (
                     cmt_irq_bwei
                     )
                 );

  assign cmt_mdcause[31:`N22_DCAUSE_CODE_W] = {32-`N22_DCAUSE_CODE_W{1'b0}};

  wire cmt_mdcause_sel0 = cmt_excp ? (
                          (instr_access_fault & 1'b0) |
                          (alu_excp_flush_req_ifu_ilegl & 1'b1) |
                          (load_access_fault & 1'b0) |
                          (store_access_fault & 1'b0)
                         ) : 1'b0
                         ;

  wire cmt_mdcause_sel1 = cmt_excp ? (
                          (instr_access_fault & 1'b0) |
                          (alu_excp_flush_req_ifu_ilegl & 1'b0) |
                          (load_access_fault & 1'b0) |
                          (store_access_fault & 1'b0)
                         ) : (mip_bwei_ld_r & (~mip_bwei_pmp_r))
                         ;

  wire cmt_mdcause_sel2 = cmt_excp ? (
                          (instr_access_fault & alu_excp_flush_req_ifu_pmperr) |
                          (alu_excp_flush_req_ifu_ilegl & 1'b0) |
                          (load_access_fault & alu_excp_flush_req_ld_pmperr) |
                          (store_access_fault & alu_excp_flush_req_stamo_pmperr)
                      ) : ((~mip_bwei_ld_r) & (~mip_bwei_pmp_r))
                      ;

  wire cmt_mdcause_sel3 = cmt_excp ? (
                          (instr_access_fault & alu_excp_flush_req_ifu_buserr & (~alu_excp_flush_req_ifu_pmperr)) |
                          (alu_excp_flush_req_ifu_ilegl & 1'b0) |
                          (load_access_fault & longp_excp_flush_req_ld_buserr) |
                          (store_access_fault & longp_excp_flush_req_st_buserr)
                      ) : (mip_bwei_ld_r & mip_bwei_pmp_r)
                      ;

  wire cmt_mdcause_sel4 = cmt_excp ? 1'b0 :
                        ((~mip_bwei_ld_r) & mip_bwei_pmp_r)
                      ;

  assign cmt_mdcause[`N22_DCAUSE_CODE_W-1:0] =
                     cmt_mdcause_sel0 ? `N22_DCAUSE_CODE_W'd0 :
                     cmt_mdcause_sel1 ? `N22_DCAUSE_CODE_W'd1 :
                     cmt_mdcause_sel2 ? `N22_DCAUSE_CODE_W'd2 :
                     cmt_mdcause_sel3 ? `N22_DCAUSE_CODE_W'd3 :
                     cmt_mdcause_sel4 ? `N22_DCAUSE_CODE_W'd4 : `N22_DCAUSE_CODE_W'd0 ;

  assign cmt_epc_ena     = (~dbg_mode) & (excp_taken_ena | rglr_irq_taken_ena | nmi_taken_ena);
  assign cmt_excp   = excp_taken_ena;
  assign cmt_irq    = rglr_irq_taken_ena;
  assign cmt_nmi    = nmi_taken_ena;
  assign cmt_virq   = excpirq_flush_pc_vmode;

  assign cmt_cause_ena   = cmt_epc_ena
                             ;
  assign cmt_badaddr_ena = cmt_epc_ena & cmt_badaddr_update;

  assign cmt_dpc =
               dbg_exc2dbg_req ? csr_mepc_r
               : alu_excp_i_pc;
  assign cmt_dpc_ena = dbg_entry_taken_ena;

  wire cmt_dcause_set;

`ifdef N22_HAS_UMODE
  assign cmt_dprv_ena = cmt_dcause_set;
  wire   cmt_dprv_mmode =  dbg_exc2dbg_req ? mpp_m_mode : m_mode;
  assign cmt_dprv = cmt_dprv_mmode ? 2'b11 : 2'b00;
`endif

`ifndef N22_HAS_UMODE
  assign cmt_dprv_ena = 1'b0;
  assign cmt_dprv = 2'b11;
`endif

  assign cmt_dcause_set = dbg_entry_taken_ena;
  wire cmt_dcause_clr = cmt_dret_ena;
  wire [2:0] set_dcause_nxt =
                              dbg_rsthalt_req ? 3'd5 :
                              dbg_halt_req  ? 3'd3 :
                              dbg_step_req ? 3'd4 :
                              dbg_ietrig_req ? 3'd2 :
                              dbg_icnt_req ? 3'd2 :
                              dbg_trig_req ? 3'd2 :
                              (dbg_ebrk_req | dbg_exc2dbg_req) ? 3'd1 :
                                             3'd0;

  assign cmt_dcause_ena = cmt_dcause_set | cmt_dcause_clr;
  assign cmt_dcause = cmt_dcause_set ? set_dcause_nxt : 3'd0;

  wire cmt_ddcause_set = cmt_dcause_set & (set_dcause_nxt == 3'd1);
  wire cmt_ddcause_clr = cmt_dret_ena;
  wire [15:0] set_ddcause_nxt =
                              dbg_ebrk_req ? 16'd0 : {exc2dbg_ddcause_sub_r,exc2dbg_ddcause_r};

  assign cmt_ddcause_ena = cmt_ddcause_set | cmt_ddcause_clr;
  assign cmt_ddcause = cmt_ddcause_set ? {16'b0,set_ddcause_nxt} : 32'd0;





  assign rx_evt_ack = wfe_waiting ? excpirq_taken_ena : 1'b1;

  assign trace_ivalid = nonflush_cmt_ena | excpirq_taken_ena;

  assign trace_iexception = excp_taken_ena | nmi_taken_ena;

  assign trace_interrupt = rglr_irq_taken_ena;

  assign trace_cause = cmt_cause;

  assign trace_tval = cmt_badaddr;

  assign trace_iaddr = cmt_epc;

  assign trace_instr = alu_excp_i_instr;

  assign trace_priv = m_mode ? 2'b11 : 2'b00;

endmodule




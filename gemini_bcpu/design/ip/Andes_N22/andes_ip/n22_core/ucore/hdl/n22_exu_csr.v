
`include "global.inc"

module n22_exu_csr #(
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
  input  [`N22_PC_SIZE-1:0] pc_plus_ofst,

  output csr_unalgn_enable,
  output csr_bpu_enable,
  output csr_rvcompm_enable,
  output csr_ilm_enable   ,
  output csr_dlm_enable   ,
  output csr_icache_enable,
  output jlmnxti_flush_req,
  output jlmnxti_flush_mmode,
  output jlmnxti_flush_dmode,
  output jlmnxti_flush_vmode,
  output [`N22_PC_SIZE-1:0] jlmnxti_flush_pc,

  output wr_csr_flush_req,
  output wr_csr_flush_mmode,
  output wr_csr_flush_dmode,
  output wr_csr_flush_vmode,
  output [`N22_PC_SIZE-1:0] wr_csr_flush_pc,

  output nmi_cause_fff,

  input [12-1:0] irq_cause_id,

  input [`N22_PC_SIZE-1:0] csr_pc,

  input  [`N22_PC_SIZE-1:0] pc_rtvec,

  input tmr_irq_r,
  input sft_irq_r,
  input ext_irq_r,

  output sleep_value,
  output sleep_value_din,
  output tx_evt,
  output csr_wfe_bit,

  output mtvt2_enable,
  output [`N22_XLEN-1:0] csr_mtvt2_r,

`ifdef N22_HAS_STACKSAFE
  input sp_excp_taken_ena,
  input rf_wbck_sp_ena1,
  input rf_wbck_sp_ena2,
  input [`N22_XLEN-1:0] sp_r,
  output sp_ovf_excp,
  output sp_udf_excp,
  output spsafe_enable,
`endif

`ifdef N22_HAS_PMP
  output [`N22_PMP_ENTRY_NUM*`N22_XLEN-1:0] pmpaddr_r,
  output [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_r,
  output [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_w,
  output [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_x,
  output [`N22_PMP_ENTRY_NUM*2-1:0] pmpcfg_bit_a,
  output [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_l,
`endif

`ifdef N22_HAS_PMONITOR
  input [31:0] cmt_pmon_evts,
`endif

  output       mstatus_mprv,

  output [31:0] csr_uitb_addr,

  `ifdef N22_HAS_POWERBRAKE
  output [3:0] csr_mpftctl_tlevel,
  output csr_mxstat_pften,
  `endif


  input nonflush_cmt_ena,

  input [`N22_XLEN-1:0] wbck_csr_msts_dat,
  `ifdef N22_HAS_CLIC
  output mip_bwei,
  output mip_pmovi,
  output mip_imecci,
  input minhv_clear_r,
  output[`N22_PC_SIZE-1:0]     clic_vec_pc,
  output [7:0] mintstatus_mil_r,
  input [9:0] clic_irq_id,
  input [7:0] clic_irq_lvl,
  input clic_irq_shv,
  input clic_prio_gt_thod,
  output core_in_int,
  output mnxti_valid_taken,
  output clic_int_mode,
  `endif
  input csr_ena,
  input csr_wr_en,
  input csr_rd_en,
  input [12-1:0] csr_idx,


  output csr_access_ilgl,
  output csr_ilegl_noncsr,
  output csr_ilegl_prvcsr,
  output csr_ilegl_wrocsr,

  output [`N22_XLEN-1:0] read_csr_dat,
  output [`N22_XLEN-1:0] read_msts_dat,
  input  [`N22_XLEN-1:0] wbck_csr_dat,

  input  [`N22_XLEN-1:0] csr_op1,

  input  [`N22_XLEN-1:0] core_mhartid,

  output status_mie_r,

  output mie_imecci_r,
  output mie_bwei_r,
  output mie_pmovi_r,
  output mie_mtie_r,
  output mie_msie_r,
  output mie_meie_r,

  output mip_imecci_r,
  output mip_bwei_r,
  output mip_bwei_pmp_r,
  output mip_pmovi_r,
  output mip_mtie_r,
  output mip_msie_r,
  output mip_meie_r,

  output [`N22_ADDR_SIZE-1:0] mip_bwei_addr_r,
  output mip_bwei_ld_r,

  input  local_irq_bus_pmperr,
  input  local_irq_bus_err,
  input  [`N22_ADDR_SIZE-1:0] local_irq_bus_addr,
  input  local_irq_bus_ld,

  input ebreak4dbg_stopcount,

  `ifdef N22_HAS_DEBUG
  input [2-1:0] dbg_prv_r,
  input dbg_stopcount,


  output dbg_csr_ena,
  output dbg_csr_wr_en,
  output dbg_csr_rd_en,
  output [12-1:0] dbg_csr_idx,
  output dbg_wbck_csr_wen,
  output  [`N22_XLEN-1:0] dbg_wbck_csr_dat,
  input  [`N22_XLEN-1:0] dbg_read_csr_dat,
  input  dbg_csr_addr_legal,
  input  dbg_csr_prv_ilgl,

  `endif

  input  dbg_mode,

  output m_mode,
  output nmi_mode,
  output mpp_m_mode,

  input [`N22_XLEN-1:0] cmt_badaddr,
  input cmt_badaddr_ena,
  input [`N22_XLEN-1:0] cmt_cause,
  input cmt_cause_ena,

  input [`N22_PC_SIZE-1:0] cmt_epc,

  input cmt_instret_ena,

  input cmt_epc_ena,
  input cmt_excp,
  input cmt_nmi,
  input cmt_irq,
  input cmt_virq,

  input [`N22_XLEN-1:0] cmt_mdcause,
  input cmt_mdcause_ena,

  input cmt_mret_ena,

  input cmt_dret_ena,

  output[`N22_PC_SIZE-1:0]  csr_mepc_r,
  output[`N22_XLEN-1:0]  csr_mcause,
  output[`N22_XLEN-1:0]  csr_mxstatus,

  output[`N22_XLEN-1:0]     csr_mtvec_r,
  output[`N22_XLEN-1:0]     csr_mnvec_r,


  input  clk_aon,
  input  clk,
  input  rst_n

  );
`ifdef N22_MNVEC_SAME_MTVEC
  localparam CAUSE_CODE_W = 12;
`else
  localparam CAUSE_CODE_W = 10;
`endif

`ifdef N22_HAS_CLIC
  localparam CORE_CLIC_IRQ_NUM = `N22_CORE_CLIC_IRQ_NUM;
  localparam IRQ_NUM_LOG2 = `CLOG2(CORE_CLIC_IRQ_NUM);
  localparam TBASE_ALIGN_SIZE = (CORE_CLIC_IRQ_NUM  < 32) ? 7 : (IRQ_NUM_LOG2 + 2);
  localparam CLIC_EXCCODE_W   = (IRQ_NUM_LOG2 < CAUSE_CODE_W) ? CAUSE_CODE_W : IRQ_NUM_LOG2;
`endif





wire csr_addr_legal;
wire umode_prv_ilgl;
wire umode_wro_ilgl;
wire csr_wro_ilgl;

assign csr_ilegl_noncsr  = (~csr_addr_legal)
                           ;
assign csr_ilegl_wrocsr = csr_wro_ilgl | umode_wro_ilgl;
assign csr_ilegl_prvcsr =
              `ifdef N22_HAS_DEBUG
                      dbg_csr_prv_ilgl
              `endif
                      | umode_prv_ilgl;

assign csr_access_ilgl = (csr_wr_en | csr_rd_en) & (
                  csr_ilegl_noncsr
                | csr_ilegl_prvcsr
                | csr_ilegl_wrocsr
                );

wire wbck_csr_wen = csr_wr_en & csr_ena & (~csr_access_ilgl);


wire [`N22_XLEN-1:0] cause_r;

wire [1:0] status_priv_r;

assign m_mode = (status_priv_r == 2'b11);

wire [1:0] xstatus_typ_r;
wire xstatus_typ_irq  = (xstatus_typ_r == `N22_TYP_IRQ);
wire xstatus_typ_excp = (xstatus_typ_r == `N22_TYP_EXCP);
wire xstatus_typ_nmi  = (xstatus_typ_r == `N22_TYP_NMI);
assign nmi_mode = xstatus_typ_nmi;
wire mcause_irq_mode = cause_r[31];
wire cmt_irq_mret_ena = mcause_irq_mode & cmt_mret_ena;
wire cmt_nonirq_mret_ena = (~mcause_irq_mode) & cmt_mret_ena;

wire [1:0] status_mpp_r;

wire mpp_mmode = (status_mpp_r == 2'b11);

assign mpp_m_mode = mpp_mmode;

wire sel_mstatus = (csr_idx == 12'h300);

wire rd_mstatus = sel_mstatus & csr_rd_en;

wire wr_mstatus = sel_mstatus & csr_wr_en;

wire wr_mstatus_en = (wr_mstatus & wbck_csr_wen) ;

wire status_mprv_r;


wire status_mprv_ena =
        wr_mstatus_en;

wire status_mprv_nxt = wbck_csr_dat[17];

  `ifdef N22_HAS_UMODE
n22_gnrl_dfflr #(1) status_mprv_dfflr (status_mprv_ena, status_mprv_nxt, status_mprv_r, clk, rst_n);
  `endif
  `ifndef N22_HAS_UMODE
assign status_mprv_r = 1'b0;
  `endif

wire status_priv_ena =
        cmt_epc_ena |
        cmt_dret_ena |
        cmt_mret_ena
        ;


wire [1:0] status_priv_nxt;

assign status_priv_nxt =
               cmt_epc_ena ? 2'b11 :
  `ifdef N22_HAS_DEBUG
               cmt_dret_ena ? dbg_prv_r :
  `endif
               cmt_mret_ena ? status_mpp_r :
                              status_priv_r;

  `ifdef N22_HAS_UMODE
n22_gnrl_dfflrs #(2) status_priv_dfflr (status_priv_ena, status_priv_nxt, status_priv_r, clk, rst_n);
  `endif
  `ifndef N22_HAS_UMODE
assign status_priv_r = 2'b11;
  `endif


assign mstatus_mprv = status_mprv_r;


wire [1:0]     ptyp1_r;
wire           pdme1_r;
wire           ppften1_r;
wire [2:1]     mpp1_r;
wire           mpie1_r;

`ifndef N22_EXCPSAVE_LEVEL_2
assign ptyp1_r   = 2'b0;
assign pdme1_r = 1'b0;
assign ppften1_r = 1'b0;
assign mpie1_r = 1'b1;
assign mpp1_r   = 2'b0;
`endif

wire cmt_irq_epc_ena= cmt_irq & cmt_epc_ena;
wire cmt_virq_epc_ena= cmt_irq_epc_ena & cmt_virq;
wire sel_mnxti = (csr_idx == 12'h345);
wire sel_jlmnxti = (csr_idx == `N22_JLMNXTI_CSRIDX);
wire msts_wr_ena_mnxti;
wire jlmnxti_flush_inhv_set;
`ifdef N22_HAS_CLIC
wire minhv_set = cmt_virq_epc_ena
              `ifdef N22_HAS_ECLIC
               | jlmnxti_flush_inhv_set
              `endif
              ;
`endif
`ifndef N22_HAS_CLIC
wire clic_int_mode;
`endif
wire wr_mcause;

wire status_mpie_r;
wire status_mie_ena  =
    msts_wr_ena_mnxti |
       cmt_epc_ena
     | cmt_mret_ena
     | wr_mstatus_en
        ;

wire status_mie_nxt  =
    msts_wr_ena_mnxti ? (
                `ifdef N22_HAS_CLIC
                    `ifdef N22_HAS_ECLIC
                        sel_jlmnxti ? 1'b1 :
                    `endif
                `endif
        wbck_csr_msts_dat[3]) :
     cmt_epc_ena ? 1'b0 :
    cmt_mret_ena ? status_mpie_r :
    wr_mstatus_en ? wbck_csr_dat[3] :
                  status_mie_r;

n22_gnrl_dfflr #(1) status_mie_dfflr (status_mie_ena, status_mie_nxt, status_mie_r, clk, rst_n);




wire wr_mcause_real_en;
wire wr_mcause_in_clic_mode = wr_mcause_real_en & clic_int_mode;
wire status_mpie_ena  =
       cmt_epc_ena
     | cmt_mret_ena
     `ifdef N22_HAS_CLIC
     | wr_mcause_in_clic_mode
     `endif
     | wr_mstatus_en;

wire status_mpp_ena = status_mpie_ena;


wire [1:0] status_mpp_nxt;


wire [1:0] mpp_mret_value =
                                  `ifdef N22_HAS_UMODE
                                      2'b00
                                  `else
                                      2'b11
                                  `endif
                                  ;

wire  [`N22_XLEN-1:0] wbck_csr_dat_cause;

assign status_mpp_nxt =
                cmt_epc_ena ? status_priv_r :
                cmt_mret_ena ?
                              `ifdef N22_EXCPSAVE_LEVEL_2
                                  (mcause_irq_mode ? mpp_mret_value : mpp1_r) :
                              `else
                                  mpp_mret_value :
                              `endif
                wr_mstatus_en ? {2{wbck_csr_dat[11]}} :
    `ifdef N22_HAS_CLIC
                 wr_mcause_in_clic_mode ?  {2{wbck_csr_dat_cause[28]}} :
    `endif
                                status_mpp_r;


wire status_mpie_nxt    =
    cmt_epc_ena ? status_mie_r :
    cmt_mret_ena  ?
                              `ifdef N22_EXCPSAVE_LEVEL_2
                                  (mcause_irq_mode ? 1'b1 : mpie1_r) :
                              `else
                                  1'b1 :
                              `endif
    wr_mstatus_en ? wbck_csr_dat[7] :
    `ifdef N22_HAS_CLIC
      wr_mcause_in_clic_mode  ?  wbck_csr_dat_cause[27]:
    `endif
                  status_mpie_r;

`ifdef N22_HAS_UMODE
n22_gnrl_dfflrs #(2) status_mpp_dfflrs (status_mpp_ena, status_mpp_nxt, status_mpp_r, clk, rst_n);
`endif
`ifndef N22_HAS_UMODE
assign status_mpp_r = 2'b11;
`endif
n22_gnrl_dfflr #(1) status_mpie_dfflr (status_mpie_ena, status_mpie_nxt, status_mpie_r, clk, rst_n);










wire [1:0] status_fs_r;
wire [1:0] status_xs_r;
wire status_sd_r = (status_fs_r == 2'b11) | (status_xs_r == 2'b11);

`ifndef N22_HAS_EAI
assign status_xs_r = 2'b0;
`endif

wire [`N22_XLEN-1:0] cause_nxt;
wire [`N22_XLEN-1:0] csr_mscratch;



wire cause_ena = wr_mcause_real_en | cmt_cause_ena;

wire [`N22_XLEN-1:0] csr_mtvt2;

`ifndef N22_HAS_ECLIC
assign mtvt2_enable = 1'b0;
assign csr_mtvt2 = 32'b0;
`endif

assign csr_mtvt2_r = csr_mtvt2;

`ifdef N22_HAS_CLIC
wire [7:0] mpil_r;

wire [`N22_XLEN-1:0] mintstatus_r;
assign core_in_int = ~(mintstatus_r == `N22_XLEN'b0);
wire sel_mtvt = (csr_idx == 12'h307);
wire rd_mtvt = csr_rd_en & sel_mtvt;
wire wr_mtvt = csr_wr_en & sel_mtvt;
wire mtvt_ena = (wr_mtvt & wbck_csr_wen);
wire [`N22_PC_SIZE-1:0] mtvt_nxt =  {wbck_csr_dat[`N22_PC_SIZE-1:TBASE_ALIGN_SIZE],{TBASE_ALIGN_SIZE{1'b0}}};
wire [`N22_PC_SIZE-1:0] mtvt_r;
n22_gnrl_dfflr #(`N22_PC_SIZE) mtvt_dfflr (mtvt_ena, mtvt_nxt, mtvt_r, clk, rst_n);
wire [`N22_PC_SIZE-1 :0] mtvt_tbase = mtvt_r;
wire [`N22_PC_SIZE-1:0] csr_mtvt = mtvt_r;
assign clic_vec_pc = {csr_mtvt[(`N22_PC_SIZE-1):(IRQ_NUM_LOG2+2)],clic_irq_id[IRQ_NUM_LOG2-1:0],2'b0};

`ifdef N22_HAS_ECLIC
wire sel_mtvt2 = (csr_idx == `N22_MTVT2_CSRIDX);
wire rd_mtvt2 = csr_rd_en & sel_mtvt2;
wire wr_mtvt2 = csr_wr_en & sel_mtvt2;
wire mtvt2_ena = (wr_mtvt2 & wbck_csr_wen);
wire [`N22_PC_SIZE-1:0] mtvt2_nxt =  {wbck_csr_dat[`N22_PC_SIZE-1:2],1'b0,wbck_csr_dat[0]};
wire [`N22_PC_SIZE-1:0] mtvt2_r;
n22_gnrl_dfflr #(`N22_PC_SIZE) mtvt2_dfflr (mtvt2_ena, mtvt2_nxt, mtvt2_r, clk, rst_n);
wire [`N22_PC_SIZE-1 :0] mtvt2_tbase = mtvt2_r;
assign csr_mtvt2 = mtvt2_r;
assign mtvt2_enable = csr_mtvt2[0];
`endif



wire mists_mil_wr_ena_mnxti;
wire sel_mintstatus = (csr_idx == 12'h346);
wire rd_mintstatus = csr_rd_en & sel_mintstatus;
wire mintstatus_ena =clic_int_mode & ( mists_mil_wr_ena_mnxti
                                     | cmt_irq_epc_ena
                                     | cmt_irq_mret_ena);

wire [`N22_XLEN-1:0] mintstatus_nxt = (mists_mil_wr_ena_mnxti | cmt_irq_epc_ena) ? {clic_irq_lvl, 24'b0} :
                                                                 cmt_irq_mret_ena ? {mpil_r, 24'b0}       :
                                                                                    mintstatus_r;
n22_gnrl_dfflr #(32) mintstatus_dfflr (mintstatus_ena, mintstatus_nxt, mintstatus_r, clk, rst_n);
wire [`N22_XLEN-1:0] csr_mintstatus = mintstatus_r;
assign mintstatus_mil_r = mintstatus_r[31:24];


wire sel_mscratchcsw = (csr_idx == 12'h348);
wire rd_mscratchcsw = csr_rd_en & sel_mscratchcsw;
wire mscratchcsw_valid = sel_mscratchcsw & (status_mpp_r != status_priv_r);
wire mscratch_wr_en_mscratchcsw = wbck_csr_wen & mscratchcsw_valid;
wire [`N22_XLEN-1:0] csr_mscratchcsw = mscratchcsw_valid ? csr_mscratch : csr_op1;


wire sel_mscratchcswl = (csr_idx == 12'h349);
wire rd_mscratchcswl = csr_rd_en & sel_mscratchcswl;
wire mpil_r_eq0 = (mpil_r == 8'b0);
wire mintstatus_mil_r_eq0 = (mintstatus_mil_r[7:0] == 8'b0);
wire mscratchcswl_valid = (mpil_r_eq0 != mintstatus_mil_r_eq0) & sel_mscratchcswl & clic_int_mode;
wire mscratch_wr_en_mscratchcswl = wbck_csr_wen & mscratchcswl_valid;
wire [`N22_XLEN-1:0] mscratchcswl = mscratchcswl_valid ? csr_mscratch : csr_op1;
wire [`N22_XLEN-1:0] csr_mscratchcswl = clic_int_mode ? mscratchcswl : `N22_XLEN'b0;
`endif

`ifdef N22_HAS_ECLIC
wire rd_jlmnxti = csr_rd_en & sel_jlmnxti;
`endif

wire rd_mnxti = csr_rd_en & sel_mnxti;

wire sel_mnxti_jlmnxti = sel_mnxti
                   `ifdef N22_HAS_CLIC
                       | sel_jlmnxti
                   `endif
                       ;

`ifdef N22_HAS_CLIC
wire mnxti_valid = sel_mnxti_jlmnxti
                        & clic_prio_gt_thod
                        & core_in_int
                        & (clic_irq_lvl > mpil_r)
                        & (~clic_irq_shv)
                        & clic_int_mode;

assign mists_mil_wr_ena_mnxti = mnxti_valid & wbck_csr_wen;
wire mcas_exco_wr_ena_mnxti = mists_mil_wr_ena_mnxti;

wire [`N22_PC_SIZE-1:0] mnxti_nxt;
assign  mnxti_nxt = {mtvt_tbase[(`N22_PC_SIZE-1):(IRQ_NUM_LOG2+2)],clic_irq_id[IRQ_NUM_LOG2-1:0],2'b0};


wire [`N22_XLEN-1:0] csr_mnxti = mnxti_valid ?
                              `ifdef N22_ADDR_SIZE_IS_32
                                          mnxti_nxt
                              `endif
                              `ifdef N22_ADDR_SIZE_IS_24
                                          {{`N22_XLEN-`N22_PC_SIZE{1'b0}},mnxti_nxt}
                              `endif
                                          : `N22_XLEN'b0;


assign mnxti_valid_taken = mists_mil_wr_ena_mnxti;
`endif
assign msts_wr_ena_mnxti = sel_mnxti_jlmnxti & wbck_csr_wen;

`ifdef N22_HAS_ECLIC
wire [`N22_XLEN-1:0] jlmnxti = mnxti_valid ?
                              `ifdef N22_ADDR_SIZE_IS_32
                                   csr_pc
                              `endif
                              `ifdef N22_ADDR_SIZE_IS_24
                                   {{`N22_XLEN-`N22_PC_SIZE{1'b0}},csr_pc}
                              `endif
                                   : csr_op1;

wire [`N22_XLEN-1:0] csr_jlmnxti = clic_int_mode ?  jlmnxti : `N22_XLEN'b0;

assign jlmnxti_flush_req = mnxti_valid_taken & sel_jlmnxti;
assign jlmnxti_flush_pc  = mnxti_nxt[`N22_PC_SIZE-1:0];
assign jlmnxti_flush_vmode  = 1'b1;
assign jlmnxti_flush_dmode  = dbg_mode;
assign jlmnxti_flush_mmode  = m_mode;
assign jlmnxti_flush_inhv_set  = jlmnxti_flush_req & jlmnxti_flush_vmode;
`else
assign jlmnxti_flush_req = 1'b0;
assign jlmnxti_flush_pc  = `N22_PC_SIZE'b0;
assign jlmnxti_flush_vmode  = 1'b0;
assign jlmnxti_flush_dmode  = 1'b0;
assign jlmnxti_flush_mmode  = 1'b0;
assign jlmnxti_flush_inhv_set  = 1'b0;
`endif

wire pmp_csr_addr_legal;

wire sel_mcache_ctl;

wire sel_uitb;

assign wr_csr_flush_req = wbck_csr_wen &
                          (   1'b0
                 `ifdef N22_HAS_CACHE
                              | sel_mcache_ctl
                 `endif
                              | pmp_csr_addr_legal
                              | sel_uitb
                          )
                          ;
assign wr_csr_flush_pc  = pc_plus_ofst;
assign wr_csr_flush_vmode  = 1'b0;
assign wr_csr_flush_dmode  = dbg_mode;
assign wr_csr_flush_mmode  = m_mode;

`ifndef N22_HAS_CLIC
wire [`N22_XLEN-1:0] csr_mnxti = `N22_XLEN'b0;
`endif

`ifndef N22_HAS_FPU
assign status_fs_r = 2'b0;
`endif

wire [`N22_XLEN-1:0] csr_mstatus;

assign csr_mstatus[31]    = status_sd_r;
assign csr_mstatus[30:23] = 8'b0;
assign csr_mstatus[22:18] = 5'b0;
assign csr_mstatus[17]    = status_mprv_r;
assign csr_mstatus[16:15] = status_xs_r;
assign csr_mstatus[14:13] = status_fs_r;
assign csr_mstatus[12:11] = status_mpp_r;
assign csr_mstatus[10:9]  = 2'b0;
assign csr_mstatus[8]     = 1'b0;
assign csr_mstatus[7]     = status_mpie_r;
assign csr_mstatus[6]     = 1'b0;
assign csr_mstatus[5]     = 1'b0;
assign csr_mstatus[4]     = 1'b0;
assign csr_mstatus[3]     = status_mie_r;
assign csr_mstatus[2]     = 1'b0;
assign csr_mstatus[1]     = 1'b0;
assign csr_mstatus[0]     = 1'b0;


wire sel_medeleg = (csr_idx == 12'h302);
wire sel_mideleg = (csr_idx == 12'h303);

wire rd_medeleg = sel_medeleg & csr_rd_en;
wire rd_mideleg = sel_mideleg & csr_rd_en;

wire [`N22_XLEN-1:0] csr_medeleg = 32'b0;
wire [`N22_XLEN-1:0] csr_mideleg = 32'b0;


wire sel_mie = (csr_idx == 12'h304);
wire rd_mie = sel_mie & csr_rd_en;
wire wr_mie = sel_mie & csr_wr_en;
wire mie_ena = (~clic_int_mode) & wr_mie & wbck_csr_wen;
wire [`N22_XLEN-1:0] mie_r;
wire [`N22_XLEN-1:0] mie_nxt;
assign mie_nxt[31:22] = 10'b0;
assign mie_nxt[21] = 1'b0;
assign mie_nxt[20] = 1'b0;
assign mie_nxt[19] = 1'b0;
`ifdef N22_HAS_PMONITOR
assign mie_nxt[18] = wbck_csr_dat[18];
`else
assign mie_nxt[18] = 1'b0;
`endif
assign mie_nxt[17] = wbck_csr_dat[17];
`ifndef N22_HAS_ECC
assign mie_nxt[16] = 1'b0;
`endif
assign mie_nxt[15:12] = 4'b0;
assign mie_nxt[11] = wbck_csr_dat[11];
assign mie_nxt[10:8] = 3'b0;
assign mie_nxt[ 7] = wbck_csr_dat[ 7];
assign mie_nxt[6:4] = 3'b0;
assign mie_nxt[ 3] = wbck_csr_dat[ 3];
assign mie_nxt[2:0] = 3'b0;
n22_gnrl_dfflr #(`N22_XLEN) mie_dfflr (mie_ena, mie_nxt, mie_r, clk, rst_n);
wire [`N22_XLEN-1:0] csr_mie = clic_int_mode ? 32'b0 : mie_r;
assign mie_pmovi_r  = csr_mie[18];
assign mie_bwei_r   = csr_mie[17];
assign mie_imecci_r = csr_mie[16];
assign mie_meie_r = csr_mie[11];
assign mie_mtie_r = csr_mie[ 7];
assign mie_msie_r = csr_mie[ 3];



wire sel_mip = (csr_idx == 12'h344);
wire rd_mip = sel_mip & csr_rd_en;
wire wr_mip = (~clic_int_mode) & sel_mip & csr_wr_en;
wire mip_wr_en = wr_mip & wbck_csr_wen;

`ifndef N22_HAS_CLIC
wire mip_bwei;
wire mip_pmovi;
wire mip_imecci;
`endif


assign mip_bwei = local_irq_bus_err;
wire mip_bwei_set = (~clic_int_mode) & mip_bwei;
wire mip_bwei_clr = cmt_irq_epc_ena & (irq_cause_id == 12'd17);
wire mip_bwei_nxt_raw = mip_bwei_set | (~mip_bwei_clr);
wire mip_bwei_ena = mip_wr_en | mip_bwei_set | mip_bwei_clr;
wire mip_bwei_nxt = mip_wr_en ? wbck_csr_dat[17] : mip_bwei_nxt_raw;
n22_gnrl_dfflr #(1) mip_bwei_dfflr (mip_bwei_ena, mip_bwei_nxt, mip_bwei_r, clk, rst_n);
`ifdef N22_HAS_PMP
wire mip_bwei_pmp_nxt = mip_bwei_nxt_raw;
n22_gnrl_dfflr #(1) mip_bwei_pmp_dfflr (mip_bwei, local_irq_bus_pmperr, mip_bwei_pmp_r, clk, rst_n);
`endif
`ifndef N22_HAS_PMP
assign mip_bwei_pmp_r = 1'b0;
`endif

wire pmon_pmovf_irq;
`ifdef N22_HAS_PMONITOR
assign mip_pmovi = pmon_pmovf_irq;
wire mip_pmovi_set = (~clic_int_mode) & mip_pmovi;
wire mip_pmovi_clr = cmt_irq_epc_ena & (irq_cause_id == 12'd18);
wire mip_pmovi_nxt_raw = mip_pmovi_set | (~mip_pmovi_clr);
wire mip_pmovi_ena = mip_wr_en | mip_pmovi_set | mip_pmovi_clr;
wire mip_pmovi_nxt = mip_wr_en ? wbck_csr_dat[18] : mip_pmovi_nxt_raw;
n22_gnrl_dfflr #(1) mip_pmovi_dfflr (mip_pmovi_ena, mip_pmovi_nxt, mip_pmovi_r, clk, rst_n);
`else
assign mip_pmovi = 1'b0;
assign mip_pmovi_r = 1'b0;
`endif



`ifndef N22_HAS_ECC
assign mip_imecci = 1'b0;
assign mip_imecci_r = 1'b0;
`endif

assign mip_mtie_r = tmr_irq_r;
assign mip_msie_r = sft_irq_r;
assign mip_meie_r = ext_irq_r;

wire [`N22_XLEN-1:0] mip_r;
wire [`N22_XLEN-1:0] csr_mip;
assign mip_r[31:22] = 10'b0;
assign mip_r[21] = 1'b0;
assign mip_r[20] = 1'b0;
assign mip_r[19] = 1'b0;
assign mip_r[18] = mip_pmovi_r;
assign mip_r[17] = mip_bwei_r;
assign mip_r[16] = mip_imecci_r;
assign mip_r[15:12] = 4'b0;
assign mip_r[11] = mip_meie_r;
assign mip_r[10:8] = 3'b0;
assign mip_r[ 7] = mip_mtie_r;
assign mip_r[6:4] = 3'b0;
assign mip_r[ 3] = mip_msie_r;
assign mip_r[2:0] = 3'b0;

assign csr_mip = clic_int_mode ? 32'b0 : mip_r;

wire mip_bwei_ld_ena = mip_bwei;
wire mip_bwei_ld_nxt = local_irq_bus_ld;
n22_gnrl_dfflr #(1) mip_bwei_ld_dffr (mip_bwei_ld_ena,  mip_bwei_ld_nxt, mip_bwei_ld_r, clk, rst_n);

wire mip_bwei_addr_ena = mip_bwei;
wire [`N22_ADDR_SIZE-1:0] mip_bwei_addr_nxt = local_irq_bus_addr;
n22_gnrl_dfflr #(`N22_ADDR_SIZE) mip_bwei_addr_dffr (mip_bwei_addr_ena,  mip_bwei_addr_nxt, mip_bwei_addr_r, clk, rst_n);

wire sel_mtvec = (csr_idx == 12'h305);
wire rd_mtvec = csr_rd_en & sel_mtvec;
wire wr_mtvec = sel_mtvec & csr_wr_en;
wire mtvec_ena = (wr_mtvec & wbck_csr_wen);
wire [`N22_PC_SIZE-1:0] mtvec_r;
`ifdef N22_HAS_CLIC
wire [`N22_PC_SIZE-1:0] mtvec_nxt = wbck_csr_dat[`N22_PC_SIZE-1:0];
`else
wire [`N22_PC_SIZE-1:0] mtvec_nxt = {wbck_csr_dat[`N22_PC_SIZE-1:2],2'b0};
`endif
n22_gnrl_dfflr #(`N22_PC_SIZE) mtvec_dfflr (mtvec_ena, mtvec_nxt, mtvec_r, clk, rst_n);
wire [`N22_XLEN-1:0] csr_mtvec = clic_int_mode ? mtvec_r : {mtvec_r[`N22_PC_SIZE-1:2],2'b0};
assign csr_mtvec_r = csr_mtvec;

wire sel_mnvec = (csr_idx == 12'h7c3);
wire rd_mnvec = csr_rd_en & sel_mnvec;

`ifdef N22_MNVEC_SAME_RESET
wire [`N22_PC_SIZE-1:0] csr_mnvec = pc_rtvec;
`endif

`ifdef N22_MNVEC_SAME_MTVEC
wire [`N22_XLEN-1:0] csr_mnvec = nmi_cause_fff ? csr_mtvec : pc_rtvec;
`endif

`ifdef N22_MNVEC_RW
wire wr_mnvec = sel_mnvec & csr_wr_en;
wire mnvec_ena = (wr_mnvec & wbck_csr_wen);
wire [`N22_PC_SIZE-1:0] mnvec_r;
wire [`N22_PC_SIZE-1:0] mnvec_nxt = {wbck_csr_dat[`N22_PC_SIZE-1:2],2'b0};
n22_gnrl_dfflr #(`N22_PC_SIZE) mnvec_dfflr (mnvec_ena, mnvec_nxt, mnvec_r, clk, rst_n);
wire [`N22_XLEN-1:0] csr_mnvec = mnvec_r;
`endif

assign csr_mnvec_r = csr_mnvec;


wire sel_mscratch = (csr_idx == 12'h340);
wire rd_mscratch = sel_mscratch & csr_rd_en;
wire wr_mscratch = sel_mscratch & csr_wr_en;
`ifndef N22_HAS_CLIC
wire mscratch_ena = (wr_mscratch & wbck_csr_wen);
`endif
`ifdef N22_HAS_CLIC
wire mscratch_ena = (wr_mscratch & wbck_csr_wen) | mscratch_wr_en_mscratchcsw | mscratch_wr_en_mscratchcswl;
`endif
wire [`N22_XLEN-1:0] mscratch_r;
wire [`N22_XLEN-1:0] mscratch_nxt = wbck_csr_dat;
n22_gnrl_dfflr #(`N22_XLEN) mscratch_dfflr (mscratch_ena, mscratch_nxt, mscratch_r, clk, rst_n);
assign csr_mscratch = mscratch_r;








wire sel_mepc = (csr_idx == 12'h341);
wire rd_mepc = sel_mepc & csr_rd_en;
wire wr_mepc = sel_mepc & csr_wr_en;
wire epc_ena = (wr_mepc & wbck_csr_wen) | cmt_epc_ena
      `ifdef N22_EXCPSAVE_LEVEL_2
               | cmt_nonirq_mret_ena
      `endif
               ;
      `ifdef N22_EXCPSAVE_LEVEL_2
wire [`N22_XLEN-1:0] saveepc1_r;
      `endif

wire [`N22_PC_SIZE-1:0] epc_r;
wire [`N22_PC_SIZE-1:0] epc_nxt;
assign epc_nxt[`N22_PC_SIZE-1:1] =
        cmt_epc_ena ? cmt_epc[`N22_PC_SIZE-1:1] :
      `ifdef N22_EXCPSAVE_LEVEL_2
        cmt_nonirq_mret_ena ? saveepc1_r[`N22_PC_SIZE-1:1] :
      `endif
        wbck_csr_dat[`N22_PC_SIZE-1:1];
assign epc_nxt[0] = 1'b0;
n22_gnrl_dfflr #(`N22_PC_SIZE) epc_dfflr (epc_ena, epc_nxt, epc_r, clk, rst_n);
`ifdef N22_ADDR_SIZE_IS_32
wire [`N22_XLEN-1:0] csr_mepc = epc_r;
`endif
`ifdef N22_ADDR_SIZE_IS_24
wire [`N22_XLEN-1:0] csr_mepc = {{`N22_XLEN-`N22_PC_SIZE{1'b0}},epc_r};
`endif
assign csr_mepc_r = epc_r;


wire [1:0] xstatus_ptyp_r;


wire sel_mcause = (csr_idx == 12'h342);
wire rd_mcause = sel_mcause & csr_rd_en;
assign wr_mcause = sel_mcause & csr_wr_en;

assign wr_mcause_real_en =
      `ifdef N22_EXCPSAVE_LEVEL_2
               cmt_nonirq_mret_ena |
      `endif
               (wr_mcause & wbck_csr_wen);

      `ifdef N22_EXCPSAVE_LEVEL_2
wire [`N22_XLEN-1:0] savecause1_r;
wire [`N22_XLEN-1:0] savedcause1_r;
      `endif

assign wbck_csr_dat_cause =
      `ifdef N22_EXCPSAVE_LEVEL_2
               cmt_nonirq_mret_ena ? savecause1_r :
      `endif
               wbck_csr_dat;


assign cause_nxt[31]  = cmt_cause_ena ? cmt_cause[31] : wbck_csr_dat_cause[31];

`ifndef N22_HAS_CLIC
assign clic_int_mode = 1'b0;
assign cause_nxt[30:CAUSE_CODE_W] = {31-CAUSE_CODE_W{1'b0}};
assign cause_nxt[CAUSE_CODE_W-1:0] = cmt_cause_ena ? cmt_cause[CAUSE_CODE_W-1:0] : wbck_csr_dat_cause[CAUSE_CODE_W-1:0];
n22_gnrl_dfflr  #(32) cause_dfflr (cause_ena, cause_nxt, cause_r, clk, rst_n);
`endif

`ifdef N22_HAS_CLIC
assign cause_nxt[30:0] = 31'b0;
wire minhv_r;
assign clic_int_mode = (mtvec_r[5:0] == 6'b11);
n22_gnrl_dfflr  #(1) cause_msb_dfflr (cause_ena, cause_nxt[31], cause_r[31], clk, rst_n);
wire cause_minhv_ena = clic_int_mode & (wr_mcause_real_en | minhv_set | minhv_clear_r);
wire minhv_nxt = minhv_set   ? 1'b1 :
                 minhv_clear_r ? 1'b0 :
                 wr_mcause_real_en   ? wbck_csr_dat_cause[30]:
                 minhv_r;
n22_gnrl_dfflr  #(1) cause_minhv_dfflr (cause_minhv_ena, minhv_nxt, minhv_r, clk, rst_n);

wire mpil_ena =  clic_int_mode & (cmt_irq_epc_ena | wr_mcause_real_en);

wire [7:0] mpil_nxt =   cmt_irq_epc_ena  ?  mintstatus_mil_r :
                        wr_mcause_real_en   ?  wbck_csr_dat_cause[23:16] :
                        mpil_r;
n22_gnrl_dfflr  #(8) cause_mpil_dfflr (mpil_ena, mpil_nxt, mpil_r, clk, rst_n);


wire clic_exccode_ena = cause_ena | mcas_exco_wr_ena_mnxti;
wire [CLIC_EXCCODE_W-1:0] clic_exccode_r;
wire [CLIC_EXCCODE_W-1:0] clic_exccode_nxt = cmt_cause_ena          ? cmt_cause[CLIC_EXCCODE_W-1:0] :
                                               mcas_exco_wr_ena_mnxti ? {{CLIC_EXCCODE_W-IRQ_NUM_LOG2{1'b0}},clic_irq_id[IRQ_NUM_LOG2-1:0]}
                                             : wbck_csr_dat_cause[CLIC_EXCCODE_W-1:0];

n22_gnrl_dfflr  #(CLIC_EXCCODE_W) cause_exccode_dfflr (clic_exccode_ena,clic_exccode_nxt,clic_exccode_r,clk,rst_n);

assign cause_r[30] = clic_int_mode ? minhv_r : 1'b0;
assign cause_r[29:28] =  clic_int_mode ? status_mpp_r : 2'b0;
assign cause_r[27] =  clic_int_mode ? status_mpie_r : 1'b0;
assign cause_r[26:25] =  2'b0;
assign cause_r[24] = 1'b0;
assign cause_r[23:16] = clic_int_mode ? mpil_r : 8'b0;
assign cause_r[15:CLIC_EXCCODE_W] = {(16-CLIC_EXCCODE_W){1'b0}};
assign cause_r[CLIC_EXCCODE_W-1:0] = clic_exccode_r;
`endif

assign csr_mcause = cause_r;


wire sel_mbadaddr = (csr_idx == 12'h343);
wire rd_mbadaddr = sel_mbadaddr & csr_rd_en;
wire wr_mbadaddr = sel_mbadaddr & csr_wr_en;
wire cmt_trap_badaddr_ena = cmt_badaddr_ena;
wire badaddr_ena = (wr_mbadaddr & wbck_csr_wen) | cmt_trap_badaddr_ena;
wire [`N22_XLEN-1:0] badaddr_r;
wire [`N22_XLEN-1:0] badaddr_nxt;
assign badaddr_nxt = cmt_trap_badaddr_ena ? cmt_badaddr : wbck_csr_dat[`N22_XLEN-1:0];
n22_gnrl_dfflr #(`N22_XLEN) badaddr_dfflr (badaddr_ena, badaddr_nxt, badaddr_r, clk, rst_n);
wire [`N22_XLEN-1:0] csr_mbadaddr;
assign csr_mbadaddr = badaddr_r;



wire sel_misa = (csr_idx == 12'h301);
wire rd_misa = sel_misa & csr_rd_en;
wire [`N22_XLEN-1:0] csr_misa = {
    2'b1
   ,4'b0
   ,1'b0
   ,1'b0
   ,1'b1
   ,1'b0
   ,1'b0
  `ifdef N22_HAS_UMODE
   ,1'b1
  `endif
  `ifndef N22_HAS_UMODE
   ,1'b0
  `endif
   ,1'b0
   ,1'b0
   ,1'b0
   ,1'b0
   ,1'b0
   ,1'b0
   ,1'b0
   `ifdef N22_HAS_MULDIV
   ,1'b1
   `else
   ,1'b0
   `endif
   ,1'b0
   ,1'b0
   ,1'b0
   `ifdef N22_RFREG_NUM_IS_32
   ,1'b1
   `else
   ,1'b0
   `endif
   ,1'b0
   ,1'b0
  `ifndef N22_HAS_FPU
   ,1'b0
  `endif
   `ifdef N22_RFREG_NUM_IS_32
   ,1'b0
   `else
   ,1'b1
   `endif
  `ifndef N22_HAS_FPU
   ,1'b0
  `endif
   ,1'b1
   ,1'b0
  `ifdef N22_HAS_AMO
   ,1'b1
  `endif
  `ifndef N22_HAS_AMO
   ,1'b0
  `endif
                           };


wire [`N22_XLEN-1:0] csr_marchid   = `N22_CFG_CPU_ID;
wire [`N22_XLEN-1:0] csr_mhartid   = core_mhartid;

wire [`N22_XLEN-1:0] csr_mimpid;
assign csr_mimpid[31:8] = `N22_IMPID_MAJOR;
assign csr_mimpid[ 7:4] = `N22_IMPID_MINOR;
assign csr_mimpid[ 3:0] = `N22_IMPID_EXTENSION;

wire sel_mvendorid = (csr_idx == 12'hF11);
wire sel_marchid   = (csr_idx == 12'hF12);
wire sel_mimpid    = (csr_idx == 12'hF13);
wire sel_mhartid   = (csr_idx == 12'hF14);

wire rd_mvendorid = csr_rd_en & sel_mvendorid;
wire rd_marchid   = csr_rd_en & sel_marchid  ;
wire rd_mimpid    = csr_rd_en & sel_mimpid   ;
wire rd_mhartid   = csr_rd_en & sel_mhartid  ;


wire [`N22_XLEN-1:0] pmp_read_csr_dat;


n22_pmp_csr u_n22_pmp_csr(
    .csr_ena       (csr_ena      ),
    .csr_wr_en     (csr_wr_en    ),
    .csr_rd_en     (csr_rd_en    ),
    .csr_idx       (csr_idx      ),
    .wbck_csr_dat  (wbck_csr_dat ),
    .read_csr_dat  (pmp_read_csr_dat ),
    .wbck_csr_wen  (wbck_csr_wen),
    .csr_addr_legal(pmp_csr_addr_legal),

`ifdef N22_HAS_PMP
    .pmpaddr_r     (pmpaddr_r   ),
    .pmpcfg_bit_r  (pmpcfg_bit_r),
    .pmpcfg_bit_w  (pmpcfg_bit_w),
    .pmpcfg_bit_x  (pmpcfg_bit_x),
    .pmpcfg_bit_a  (pmpcfg_bit_a),
    .pmpcfg_bit_l  (pmpcfg_bit_l),
`endif

    .clk  (clk  ),
    .rst_n(rst_n)

  );




wire wr_xstatus_en;

wire xstatus_typ_ena =
       cmt_epc_ena
     | cmt_mret_ena
     | wr_xstatus_en;

wire [1:0] xstatus_typ_nxt  =
               cmt_epc_ena ? (
                   ( {2{cmt_excp}} & `N22_TYP_EXCP) |
                   ( {2{cmt_irq }} & `N22_TYP_IRQ ) |
                   ( {2{cmt_nmi }} & `N22_TYP_NMI )
               ) :
               cmt_mret_ena ? xstatus_ptyp_r :
               wr_xstatus_en ? wbck_csr_dat[7:6] :
                  xstatus_typ_r;

n22_gnrl_dfflr #(2) xstatus_typ_dfflr (xstatus_typ_ena, xstatus_typ_nxt, xstatus_typ_r, clk, rst_n);


wire xstatus_ptyp_ena  = xstatus_typ_ena
    ;

wire [1:0] xstatus_ptyp_nxt  =
    cmt_epc_ena ? (xstatus_typ_r) :
    cmt_mret_ena ?
      `ifdef N22_EXCPSAVE_LEVEL_2
                 (mcause_irq_mode ? xstatus_ptyp_r  : ptyp1_r) :
      `else
                 xstatus_ptyp_r :
      `endif
    wr_xstatus_en ? wbck_csr_dat[9:8] :
                  xstatus_ptyp_r;

n22_gnrl_dfflr #(2) xstatus_ptyp_dfflr (xstatus_ptyp_ena, xstatus_ptyp_nxt, xstatus_ptyp_r, clk, rst_n);


assign sel_uitb = (csr_idx == 12'h800);
wire rd_uitb = sel_uitb & csr_rd_en;
wire wr_uitb = sel_uitb & csr_wr_en;
wire uitb_ena = (wr_uitb & wbck_csr_wen);
wire [`N22_XLEN-1:0] uitb_r;
wire [`N22_XLEN-1:0] uitb_nxt = {wbck_csr_dat[31:2],2'b0};
n22_gnrl_dfflr #(`N22_XLEN) uitb_dfflr (uitb_ena, uitb_nxt, uitb_r, clk, rst_n);
wire [`N22_XLEN-1:0] csr_uitb = uitb_r;
assign csr_uitb_addr = {csr_uitb[31:2],2'b0};

wire sel_xstatus = (csr_idx == 12'h7c4);
wire rd_xstatus = sel_xstatus & csr_rd_en;
wire wr_xstatus = sel_xstatus & csr_wr_en;
assign wr_xstatus_en = (wr_xstatus & wbck_csr_wen) ;

wire sel_mdcause = (csr_idx == 12'h7c9);
wire rd_mdcause = sel_mdcause & csr_rd_en;
wire wr_mdcause = sel_mdcause & csr_wr_en;

wire mdcause_ena = (wr_mdcause & wbck_csr_wen) | cmt_mdcause_ena
      `ifdef N22_EXCPSAVE_LEVEL_2
               | cmt_nonirq_mret_ena
      `endif
      ;
wire [`N22_XLEN-1:0] mdcause_r;
wire [`N22_XLEN-1:0] mdcause_nxt;
assign mdcause_nxt[31:`N22_DCAUSE_CODE_W] = {32-`N22_DCAUSE_CODE_W{1'b0}};
assign mdcause_nxt[`N22_DCAUSE_CODE_W-1:0] =
                   cmt_mdcause_ena ? cmt_mdcause[`N22_DCAUSE_CODE_W-1:0] :
      `ifdef N22_EXCPSAVE_LEVEL_2
               cmt_nonirq_mret_ena ? savedcause1_r[`N22_DCAUSE_CODE_W-1:0] :
      `endif
                   wbck_csr_dat[`N22_DCAUSE_CODE_W-1:0];

n22_gnrl_dfflr  #(32) mdcause_dfflr (mdcause_ena, mdcause_nxt, mdcause_r, clk, rst_n);
wire [`N22_XLEN-1:0] csr_mdcause = mdcause_r;


  `ifdef N22_HAS_POWERBRAKE
wire sel_mpftctl = (csr_idx == 12'h7c5);
wire rd_mpftctl = sel_mpftctl & csr_rd_en;
wire wr_mpftctl = sel_mpftctl & csr_wr_en;
wire mpftctl_ena = (wr_mpftctl & wbck_csr_wen);
wire [`N22_XLEN-1:0] mpftctl_r;
wire [`N22_XLEN-1:0] mpftctl_nxt = {23'b0,wbck_csr_dat[8:4],4'b0};
n22_gnrl_dfflr #(`N22_XLEN) mpftctl_dfflr (mpftctl_ena, mpftctl_nxt, mpftctl_r, clk, rst_n);
wire [`N22_XLEN-1:0] csr_mpftctl = mpftctl_r;
assign csr_mpftctl_tlevel = csr_mpftctl[7:4];
wire csr_mpftctl_fstint = csr_mpftctl[8];



wire xstatus_pften_r ;
wire xstatus_ppften_r;
wire xstatus_pften_ena  =
       cmt_epc_ena
     | cmt_mret_ena
     | wr_xstatus_en
     ;

wire xstatus_pften_nxt  =
    cmt_epc_ena ? (csr_mpftctl_fstint ? 1'b0 : xstatus_pften_r) :
    cmt_mret_ena ? xstatus_ppften_r :
    wr_xstatus_en ? wbck_csr_dat[0] :
                  xstatus_pften_r;

n22_gnrl_dfflr #(1) xstatus_pften_dfflr (xstatus_pften_ena, xstatus_pften_nxt, xstatus_pften_r, clk, rst_n);


wire xstatus_ppften_ena  = xstatus_pften_ena;

wire xstatus_ppften_nxt  =
    cmt_epc_ena ? (xstatus_pften_r) :
    cmt_mret_ena ?
      `ifdef N22_EXCPSAVE_LEVEL_2
                 (mcause_irq_mode ? xstatus_ppften_r : ppften1_r) :
      `else
                 xstatus_ppften_r :
      `endif
    wr_xstatus_en ? wbck_csr_dat[1] :
                  xstatus_ppften_r;

n22_gnrl_dfflr #(1) xstatus_ppften_dfflr (xstatus_ppften_ena, xstatus_ppften_nxt, xstatus_ppften_r, clk, rst_n);
  `endif

  `ifndef N22_HAS_POWERBRAKE
  wire xstatus_pften_r  = 1'b0;
  wire xstatus_ppften_r = 1'b0;
  `endif








  wire xstatus_dme_r  = 1'b0;
  wire xstatus_pdme_r = 1'b0;




wire [`N22_XLEN-1:0] csr_xstatus;

assign csr_xstatus[31:10] = 22'b0;
assign csr_xstatus[ 9: 8] = xstatus_ptyp_r;
assign csr_xstatus[ 7: 6] = xstatus_typ_r;
assign csr_xstatus[    5] = xstatus_pdme_r ;
assign csr_xstatus[    4] = xstatus_dme_r;
assign csr_xstatus[    3] = 1'b0;
assign csr_xstatus[    2] = 1'b0;
assign csr_xstatus[    1] = xstatus_ppften_r;
assign csr_xstatus[    0] = xstatus_pften_r;

assign csr_mxstatus = csr_xstatus;

  `ifdef N22_HAS_POWERBRAKE
assign csr_mxstat_pften = xstatus_pften_r;
  `endif


wire pmon_csr_addr_legal;
wire pmon_csr_umode_prv_ilgl;
wire pmon_csr_umode_wro_ilgl;
wire pmon_csr_umode_sel_legal;
wire [`N22_XLEN-1:0] pmon_read_csr_dat;

n22_pmon_csr u_n22_pmon_csr(

  .m_mode(m_mode),

  .dbg_mode     (dbg_mode     ),
  `ifdef N22_HAS_DEBUG
  .dbg_stopcount(dbg_stopcount),
  `endif
  `ifndef N22_HAS_DEBUG
  .dbg_stopcount(1'b0),
  `endif

  .ebreak4dbg_stopcount(ebreak4dbg_stopcount),

  .csr_ena       (csr_ena      ),
  .csr_wr_en     (csr_wr_en    ),
  .csr_rd_en     (csr_rd_en    ),
  .csr_idx       (csr_idx      ),
  .wbck_csr_wen  (wbck_csr_wen ),
  .wbck_csr_dat  (wbck_csr_dat ),
  .read_csr_dat  (pmon_read_csr_dat ),

  .csr_addr_legal     (pmon_csr_addr_legal     ),
  .csr_umode_sel_legal(pmon_csr_umode_sel_legal),
  .csr_umode_prv_ilgl  (pmon_csr_umode_prv_ilgl  ),
  .csr_umode_wro_ilgl  (pmon_csr_umode_wro_ilgl  ),

  .cmt_instret_ena(cmt_instret_ena),
`ifdef N22_HAS_PMONITOR
  .pmon_evts(cmt_pmon_evts),
`endif

  .pmon_pmovf_irq(pmon_pmovf_irq),

  .clk_aon  (clk_aon  ),
  .clk  (clk  ),
  .rst_n(rst_n)
  );

  wire u_mode;

`ifdef N22_HAS_STACKSAFE

  wire [`N22_XLEN-1:0] spsafe_read_csr_dat;
  wire spsafe_csr_addr_legal;

  n22_spsafe_csr u_n22_spsafe_csr(
    .u_mode           (u_mode           ),
    .sp_excp_taken_ena(sp_excp_taken_ena),
    .rf_wbck_sp_ena1   (rf_wbck_sp_ena1),
    .rf_wbck_sp_ena2   (rf_wbck_sp_ena2),
    .sp_r             (sp_r             ),
    .spsafe_enable (spsafe_enable),

    .csr_ena       (csr_ena      ),
    .csr_wr_en     (csr_wr_en    ),
    .csr_rd_en     (csr_rd_en    ),
    .csr_idx       (csr_idx      ),
    .wbck_csr_wen  (wbck_csr_wen ),
    .wbck_csr_dat  (wbck_csr_dat ),
    .read_csr_dat  (spsafe_read_csr_dat ),
    .csr_addr_legal(spsafe_csr_addr_legal),

    .sp_ovf_excp(sp_ovf_excp),
    .sp_udf_excp(sp_udf_excp),

    .clk  (clk  ),
    .rst_n(rst_n)
    );
`endif


wire sel_sleep_value = (csr_idx == `N22_SLEEPVALUE_CSRIDX);
wire sel_tx_evt = (csr_idx == `N22_TXEVT_CSRIDX);
wire sel_wfe = (csr_idx == `N22_WFE_CSRIDX);
wire rd_sleep_value  = csr_rd_en & sel_sleep_value    ;
wire rd_tx_evt       = csr_rd_en & sel_tx_evt      ;
wire rd_wfe          = csr_rd_en & sel_wfe      ;

wire wr_sleep_value  = csr_wr_en & sel_sleep_value    ;
wire wr_tx_evt       = csr_wr_en & sel_tx_evt      ;
wire wr_wfe          = csr_wr_en & sel_wfe      ;

wire sleep_value_wr_ena = (wr_sleep_value & wbck_csr_wen);
wire tx_evt_wr_ena      = (wr_tx_evt & wbck_csr_wen);
wire wfe_wr_ena         = (wr_wfe & wbck_csr_wen);

wire [`N22_XLEN-1:0] sleep_value_r;
wire sleep_value_set = sleep_value_wr_ena;
wire sleep_value_ena = sleep_value_set;
wire [`N22_XLEN-1:0] sleep_value_nxt = {31'b0,wbck_csr_dat[0]};
n22_gnrl_dfflr #(`N22_XLEN) sleep_value_dfflr (sleep_value_ena, sleep_value_nxt, sleep_value_r, clk, rst_n);

wire [`N22_XLEN-1:0] csr_sleep_value = sleep_value_r;
assign sleep_value_din = sleep_value_ena ? sleep_value_nxt[0] : sleep_value_r[0];


wire [`N22_XLEN-1:0] tx_evt_r;
wire tx_evt_set = tx_evt_wr_ena;
wire tx_evt_clr = tx_evt_r[0];
wire tx_evt_ena = tx_evt_set | tx_evt_clr;
wire [`N22_XLEN-1:0] tx_evt_nxt = tx_evt_set ? {31'b0,wbck_csr_dat[0]} : 32'b0;
n22_gnrl_dfflr #(`N22_XLEN) tx_evt_dfflr (tx_evt_ena, tx_evt_nxt, tx_evt_r, clk_aon, rst_n);

wire [`N22_XLEN-1:0] csr_tx_evt = tx_evt_r;


wire [`N22_XLEN-1:0] wfe_r;
wire wfe_set = wfe_wr_ena;
wire wfe_ena = wfe_set;
wire [`N22_XLEN-1:0] wfe_nxt = {31'b0,wbck_csr_dat[0]};
n22_gnrl_dfflr #(`N22_XLEN) wfe_dfflr (wfe_ena, wfe_nxt, wfe_r, clk, rst_n);

wire [`N22_XLEN-1:0] csr_wfe = wfe_r;


assign sleep_value = sleep_value_r[0];
assign tx_evt = tx_evt_r[0];
assign csr_wfe_bit = wfe_r[0];

`ifdef N22_EXCPSAVE_LEVEL_2

wire sel_msavestatus = (csr_idx == 12'h7d6);
wire sel_msaveepc1   = (csr_idx == 12'h7d7);
wire sel_msaveepc2   = (csr_idx == 12'h7d9);
wire sel_msavecause1 = (csr_idx == 12'h7d8);
wire sel_msavecause2 = (csr_idx == 12'h7da);
wire sel_msavedcause1 = (csr_idx == 12'h7db);
wire sel_msavedcause2 = (csr_idx == 12'h7dc);
wire rd_msavestatus  = csr_rd_en & sel_msavestatus    ;
wire rd_msaveepc1    = csr_rd_en & sel_msaveepc1      ;
wire rd_msaveepc2    = csr_rd_en & sel_msaveepc2      ;
wire rd_msavecause1  = csr_rd_en & sel_msavecause1    ;
wire rd_msavecause2  = csr_rd_en & sel_msavecause2    ;
wire rd_msavedcause1  = csr_rd_en & sel_msavedcause1    ;
wire rd_msavedcause2  = csr_rd_en & sel_msavedcause2    ;

wire msavestatus_wr_ena  = wbck_csr_wen & sel_msavestatus    ;
wire msaveepc1_wr_ena    = wbck_csr_wen & sel_msaveepc1      ;
wire msaveepc2_wr_ena    = wbck_csr_wen & sel_msaveepc2      ;
wire msavecause1_wr_ena  = wbck_csr_wen & sel_msavecause1    ;
wire msavecause2_wr_ena  = wbck_csr_wen & sel_msavecause2    ;
wire msavedcause1_wr_ena  = wbck_csr_wen & sel_msavedcause1    ;
wire msavedcause2_wr_ena  = wbck_csr_wen & sel_msavedcause2    ;

wire [`N22_XLEN-1:0] saveepc2_r;
wire [`N22_XLEN-1:0] savecause2_r;
wire [`N22_XLEN-1:0] savedcause2_r;

wire [1:0]     ptyp2_nxt;
wire           pdme2_nxt;
wire           ppften2_nxt;
wire [2:1]     mpp2_nxt;
wire           mpie2_nxt;

wire [1:0]     ptyp1_nxt;
wire           pdme1_nxt;
wire           ppften1_nxt;
wire [2:1]     mpp1_nxt;
wire           mpie1_nxt;

wire [1:0]     ptyp2_r;
wire           pdme2_r;
wire           ppften2_r;
wire [2:1]     mpp2_r;
wire           mpie2_r;

wire  cmt_nonirq_epc_ena = (~cmt_irq) & cmt_epc_ena;

wire msavestatus_ena  =
       cmt_nonirq_epc_ena
     | cmt_nonirq_mret_ena
     | msavestatus_wr_ena
     ;

assign {
     ptyp2_nxt,
     pdme2_nxt,
     ppften2_nxt,
     mpp2_nxt,
     mpie2_nxt,

     ptyp1_nxt,
     pdme1_nxt,
     ppften1_nxt,
     mpp1_nxt,
     mpie1_nxt}  =
    cmt_nonirq_epc_ena ? {
                    ptyp1_r,
                    pdme1_r,
                    ppften1_r,
                    mpp1_r,
                    mpie1_r,

                    xstatus_ptyp_r,
                    xstatus_pdme_r,
                    xstatus_ppften_r,
                    status_mpp_r,
                    status_mpie_r
                    } :
    cmt_nonirq_mret_ena ?  {
                    ptyp2_r,
                    pdme2_r,
                    ppften2_r,
                    mpp_mret_value,
                    1'b1,

                    ptyp2_r,
                    pdme2_r,
                    ppften2_r,
                    mpp2_r,
                    mpie2_r
                    }:

     msavestatus_wr_ena ? {
                    wbck_csr_dat[15:14] ,
                    wbck_csr_dat[13] ,
                    wbck_csr_dat[11] ,
                    wbck_csr_dat[10:9] ,
                    wbck_csr_dat[8] ,

                    wbck_csr_dat[7:6],
                    wbck_csr_dat[5],
                    wbck_csr_dat[3] ,
                    wbck_csr_dat[2:1] ,
                    wbck_csr_dat[0]
                    }:
                    {
                    ptyp2_r,
                    pdme2_r,
                    ppften2_r,
                    mpp2_r,
                    mpie2_r,

                    ptyp1_r,
                    pdme1_r,
                    ppften1_r,
                    mpp1_r,
                    mpie1_r
                    };

n22_gnrl_dfflr #(2) ptyp2_dfflr(msavestatus_ena, ptyp2_nxt, ptyp2_r, clk, rst_n);
n22_gnrl_dfflr #(1) ppften2_dfflr(msavestatus_ena, ppften2_nxt, ppften2_r, clk, rst_n);
n22_gnrl_dfflr #(1) pdme2_dfflr (msavestatus_ena, pdme2_nxt, pdme2_r, clk, rst_n);

n22_gnrl_dfflr #(2) ptyp1_dfflr(msavestatus_ena, ptyp1_nxt, ptyp1_r, clk, rst_n);
n22_gnrl_dfflr #(1) ppften1_dfflr(msavestatus_ena, ppften1_nxt, ppften1_r, clk, rst_n);
n22_gnrl_dfflr #(1) pdme1_dfflr (msavestatus_ena, pdme1_nxt, pdme1_r, clk, rst_n);

n22_gnrl_dfflrs #(1) mpie2_dfflrs (msavestatus_ena, mpie2_nxt, mpie2_r, clk, rst_n);
n22_gnrl_dfflrs #(1) mpie1_dfflrs (msavestatus_ena, mpie1_nxt, mpie1_r, clk, rst_n);

`ifdef N22_HAS_UMODE
n22_gnrl_dfflr #(2) mpp2_dfflr(msavestatus_ena, mpp2_nxt, mpp2_r, clk, rst_n);
n22_gnrl_dfflr #(2) mpp1_dfflr(msavestatus_ena, mpp1_nxt, mpp1_r, clk, rst_n);
`endif
`ifndef N22_HAS_UMODE
assign mpp2_r = 2'b11;
assign mpp1_r = 2'b11;
`endif

wire [`N22_XLEN-1:0] csr_msavestatus;

assign csr_msavestatus[31:16] = 16'b0;

assign csr_msavestatus[15:14] = ptyp2_r  ;
assign csr_msavestatus[13]    = pdme2_r  ;
assign csr_msavestatus[12]    = 1'b0;
assign csr_msavestatus[11]    = ppften2_r;
assign csr_msavestatus[10:9]  = mpp2_r   ;
assign csr_msavestatus[8]     = mpie2_r  ;
assign csr_msavestatus[7:6]   = ptyp1_r  ;
assign csr_msavestatus[5]     = pdme1_r  ;
assign csr_msavestatus[4]     = 1'b0;
assign csr_msavestatus[3]     = ppften1_r;
assign csr_msavestatus[2:1]   = mpp1_r   ;
assign csr_msavestatus[0]     = mpie1_r  ;

wire [`N22_XLEN-1:0] saveepc1_nxt;
wire [`N22_XLEN-1:0] saveepc2_nxt;
wire [`N22_XLEN-1:0] saveepc1_nxt_pre;
wire [`N22_XLEN-1:0] saveepc2_nxt_pre;

wire saveepc1_ena  =
       cmt_nonirq_epc_ena
     | cmt_nonirq_mret_ena
     | msaveepc1_wr_ena
     ;

assign saveepc1_nxt_pre =
    cmt_nonirq_epc_ena ?  epc_r :
    cmt_nonirq_mret_ena ?  saveepc2_r:
    msaveepc1_wr_ena ?  wbck_csr_dat :
                    saveepc1_r;

assign saveepc1_nxt[`N22_XLEN-1:1] = saveepc1_nxt_pre[`N22_XLEN-1:1];
assign saveepc1_nxt[0] = 1'b0;

n22_gnrl_dfflr #(`N22_XLEN) saveepc1_dfflr (saveepc1_ena, saveepc1_nxt, saveepc1_r, clk, rst_n);

wire saveepc2_ena  =
       cmt_nonirq_epc_ena
     | cmt_nonirq_mret_ena
     | msaveepc2_wr_ena
     ;

assign saveepc2_nxt_pre =
    cmt_nonirq_epc_ena ?  saveepc1_r :
    cmt_nonirq_mret_ena ?  saveepc2_r:
    msaveepc2_wr_ena ?  wbck_csr_dat :
                    saveepc2_r;

assign saveepc2_nxt[`N22_XLEN-1:1] = saveepc2_nxt_pre[`N22_XLEN-1:1];
assign saveepc2_nxt[0] = 1'b0;
n22_gnrl_dfflr #(`N22_XLEN) saveepc2_dfflr (saveepc2_ena, saveepc2_nxt, saveepc2_r, clk, rst_n);

wire [`N22_XLEN-1:0] savecause1_nxt;
wire [`N22_XLEN-1:0] savecause2_nxt;
wire [`N22_XLEN-1:0] savedcause1_nxt;
wire [`N22_XLEN-1:0] savedcause2_nxt;

wire savecause1_ena  =
       cmt_nonirq_epc_ena
     | cmt_nonirq_mret_ena
     | msavecause1_wr_ena
     ;

wire [`N22_XLEN-1:0] savecause1_nxt_pre =
    cmt_nonirq_epc_ena ?  cause_r :
    cmt_nonirq_mret_ena ?  savecause2_r:
    msavecause1_wr_ena ?  wbck_csr_dat :
                    savecause1_r;


wire savecause2_ena  =
       cmt_nonirq_epc_ena
     | cmt_nonirq_mret_ena
     | msavecause2_wr_ena
     ;

wire [`N22_XLEN-1:0] savecause2_nxt_pre =
    cmt_nonirq_epc_ena ?  savecause1_r :
    cmt_nonirq_mret_ena ?  savecause2_r:
    msavecause2_wr_ena ?  wbck_csr_dat :
                    savecause2_r;

    `ifndef N22_HAS_CLIC
assign savecause1_nxt[31]   = savecause1_nxt_pre[31];
assign savecause1_nxt[30:CAUSE_CODE_W] = {31-CAUSE_CODE_W{1'b0}};
assign savecause1_nxt[CAUSE_CODE_W-1:0]  = savecause1_nxt_pre[CAUSE_CODE_W-1:0];

assign savecause2_nxt[31]   = savecause2_nxt_pre[31];
assign savecause2_nxt[30:CAUSE_CODE_W] = {31-CAUSE_CODE_W{1'b0}};
assign savecause2_nxt[CAUSE_CODE_W-1:0]  = savecause2_nxt_pre[CAUSE_CODE_W-1:0];

    `endif

    `ifdef N22_HAS_CLIC
assign savecause1_nxt[31:27]   = savecause1_nxt_pre[31:27];
assign savecause1_nxt[26:24]   = 3'b0;
assign savecause1_nxt[23:16]   = savecause1_nxt_pre[23:16];
assign savecause1_nxt[15:CLIC_EXCCODE_W] = {(16-CLIC_EXCCODE_W){1'b0}};
assign savecause1_nxt[CLIC_EXCCODE_W-1:0]   = savecause1_nxt_pre[CLIC_EXCCODE_W-1:0];

assign savecause2_nxt[31:27]   = savecause2_nxt_pre[31:27];
assign savecause2_nxt[26:24]   = 3'b0;
assign savecause2_nxt[23:16]   = savecause2_nxt_pre[23:16];
assign savecause2_nxt[15:CLIC_EXCCODE_W] = {(16-CLIC_EXCCODE_W){1'b0}};
assign savecause2_nxt[CLIC_EXCCODE_W-1:0]   = savecause2_nxt_pre[CLIC_EXCCODE_W-1:0];

    `endif

n22_gnrl_dfflr #(`N22_XLEN) savecause1_dfflr (savecause1_ena, savecause1_nxt, savecause1_r, clk, rst_n);
n22_gnrl_dfflr #(`N22_XLEN) savecause2_dfflr (savecause2_ena, savecause2_nxt, savecause2_r, clk, rst_n);

wire savedcause1_ena  =
       cmt_nonirq_epc_ena
     | cmt_nonirq_mret_ena
     | msavedcause1_wr_ena
     ;

wire [`N22_XLEN-1:0] savedcause1_nxt_pre =
    cmt_nonirq_epc_ena ?  mdcause_r :
    cmt_nonirq_mret_ena ?  savedcause2_r:
    msavedcause1_wr_ena ?  wbck_csr_dat :
                    savedcause1_r;


wire savedcause2_ena  =
       cmt_nonirq_epc_ena
     | cmt_nonirq_mret_ena
     | msavedcause2_wr_ena
     ;

wire [`N22_XLEN-1:0] savedcause2_nxt_pre =
    cmt_nonirq_epc_ena ?  savedcause1_r :
    cmt_nonirq_mret_ena ?  savedcause2_r:
    msavedcause2_wr_ena ?  wbck_csr_dat :
                    savedcause2_r;

assign savedcause1_nxt[31:`N22_DCAUSE_CODE_W] = {32-`N22_DCAUSE_CODE_W{1'b0}};
assign savedcause1_nxt[`N22_DCAUSE_CODE_W-1:0]  = savedcause1_nxt_pre[`N22_DCAUSE_CODE_W-1:0];

assign savedcause2_nxt[31:`N22_DCAUSE_CODE_W] = {32-`N22_DCAUSE_CODE_W{1'b0}};
assign savedcause2_nxt[`N22_DCAUSE_CODE_W-1:0]  = savedcause2_nxt_pre[`N22_DCAUSE_CODE_W-1:0];

n22_gnrl_dfflr #(`N22_XLEN) savedcause1_dfflr (savedcause1_ena, savedcause1_nxt, savedcause1_r, clk, rst_n);
n22_gnrl_dfflr #(`N22_XLEN) savedcause2_dfflr (savedcause2_ena, savedcause2_nxt, savedcause2_r, clk, rst_n);

wire [`N22_XLEN-1:0] csr_msaveepc1 = saveepc1_r;
wire [`N22_XLEN-1:0] csr_msaveepc2 = saveepc2_r;
wire [`N22_XLEN-1:0] csr_msavecause1 = savecause1_r;
wire [`N22_XLEN-1:0] csr_msavecause2 = savecause2_r;
wire [`N22_XLEN-1:0] csr_msavedcause1 = savedcause1_r;
wire [`N22_XLEN-1:0] csr_msavedcause2 = savedcause2_r;

`endif

wire sel_micm_cfg   = (csr_idx == 12'hfc0);
wire sel_mdcm_cfg   = (csr_idx == 12'hfc1);
wire sel_mmsc_cfg   = (csr_idx == 12'hfc2);
wire sel_milmb      = (csr_idx == 12'h7c0);
wire sel_mdlmb      = (csr_idx == 12'h7c1);
wire sel_mppib      = (csr_idx == 12'h7f0);
wire sel_mfiob      = (csr_idx == 12'h7f1);
assign sel_mcache_ctl = (csr_idx == 12'h7ca);
wire sel_mmisc_ctl  = (csr_idx == 12'h7d0);
wire rd_micm_cfg    = csr_rd_en & sel_micm_cfg     ;
wire rd_mdcm_cfg    = csr_rd_en & sel_mdcm_cfg     ;
wire rd_mmsc_cfg    = csr_rd_en & sel_mmsc_cfg     ;
wire rd_milmb       = csr_rd_en & sel_milmb        ;
wire rd_mdlmb       = csr_rd_en & sel_mdlmb        ;
wire rd_mppib       = csr_rd_en & sel_mppib        ;
wire rd_mfiob       = csr_rd_en & sel_mfiob        ;
wire rd_mcache_ctl  = csr_rd_en & sel_mcache_ctl   ;
wire rd_mmisc_ctl   = csr_rd_en & sel_mmisc_ctl    ;

wire milmb_wr_ena      = wbck_csr_wen & sel_milmb        ;
wire mdlmb_wr_ena      = wbck_csr_wen & sel_mdlmb        ;
wire mppib_wr_ena      = wbck_csr_wen & sel_mppib        ;
wire mfiob_wr_ena      = wbck_csr_wen & sel_mfiob        ;
wire mcache_ctl_wr_ena = wbck_csr_wen & sel_mcache_ctl   ;
wire mmisc_ctl_wr_ena  = wbck_csr_wen & sel_mmisc_ctl    ;

wire [`N22_XLEN-1:0] micm_cfg_r;
wire [`N22_XLEN-1:0] mdcm_cfg_r;
wire [`N22_XLEN-1:0] mmsc_cfg_r;

wire [`N22_XLEN-1:0] milmb_r;
wire [`N22_XLEN-1:0] mdlmb_r;
wire [`N22_XLEN-1:0] mppib_r;
wire [`N22_XLEN-1:0] mfiob_r;
wire [`N22_XLEN-1:0] mmisc_ctl_r;


`ifdef N22_HAS_ICACHE
  localparam ICACHE_INDEX_W_MINUS_SIX = (`N22_ICACHE_INDEX_W - 6);
  localparam FIVE_MINUS_ICACHE_INDEX_W = (5-`N22_ICACHE_INDEX_W);
generate
  if(`N22_ICACHE_INDEX_W >= 6) begin: gen_idx_ge_6
    assign micm_cfg_r[2:0] = ICACHE_INDEX_W_MINUS_SIX[2:0];
    assign micm_cfg_r[24] = 1'b0;
  end
  else begin:gen_idx_lt_6
    assign micm_cfg_r[2:0] = FIVE_MINUS_ICACHE_INDEX_W[2:0];
    assign micm_cfg_r[24] = 1'b1;
  end
endgenerate

assign micm_cfg_r[5:3] =
                 `ifndef N22_ICACHE_2WAYS
                       3'd0;
                 `endif
                 `ifdef N22_ICACHE_2WAYS
                       3'd1;
                 `endif

assign micm_cfg_r[8:6] = 3'd3;

assign micm_cfg_r[9] = 1'b0;
assign micm_cfg_r[11:10] = 2'b0;
`endif

`ifndef N22_HAS_ICACHE
assign micm_cfg_r[11:0] = 12'd0;
assign micm_cfg_r[24] = 1'b0;
`endif


`ifdef N22_HAS_ILM
assign micm_cfg_r[14:12] = 3'd1;

  localparam ILM_SIZE_ENCODE = (`N22_ILM_ADDR_WIDTH - 9);
assign micm_cfg_r[19:15] = ILM_SIZE_ENCODE[4:0];

assign micm_cfg_r[20] = 1'b0;
assign micm_cfg_r[22:21] = 2'b0;
`endif

`ifndef N22_HAS_ILM
assign micm_cfg_r[22:12] = 11'd0;
`endif

`ifdef N22_HAS_ILM
`ifndef N22_D_SHARE_ILM
assign micm_cfg_r[23] = 1'b1;
`endif
`ifdef N22_D_SHARE_ILM
assign micm_cfg_r[23] = 1'b0;
`endif
`endif

`ifndef N22_HAS_ILM
assign micm_cfg_r[23] = 1'b0;
`endif

assign micm_cfg_r[31:25] = 7'b0;




assign mdcm_cfg_r[11:0] = 12'd0;



`ifdef N22_HAS_DLM
assign mdcm_cfg_r[14:12] = 3'd1;

  localparam DLM_SIZE_ENCODE = (`N22_DLM_ADDR_WIDTH - 9);
assign mdcm_cfg_r[19:15] = DLM_SIZE_ENCODE[4:0];

assign mdcm_cfg_r[20] = 1'b0;
assign mdcm_cfg_r[22:21] = 2'b0;
assign mdcm_cfg_r[31:23] = 9'b0;
`endif

`ifndef N22_HAS_DLM
assign mdcm_cfg_r[31:12] = 20'd0;
`endif

assign mmsc_cfg_r[0] = 1'd0;
assign mmsc_cfg_r[2:1] = 2'd0;
assign mmsc_cfg_r[3] = 1'd1;
assign mmsc_cfg_r[4] =
                      `ifdef N22_HAS_POWERBRAKE
                          1'b1;
                      `endif
                      `ifndef N22_HAS_POWERBRAKE
                          1'b0;
                      `endif
assign mmsc_cfg_r[5] =
                      `ifdef N22_HAS_STACKSAFE
                          1'b1;
                      `endif
                      `ifndef N22_HAS_STACKSAFE
                          1'b0;
                      `endif
assign mmsc_cfg_r[6] =
                      `ifdef N22_HAS_ACE
                          1'b1;
                      `endif
                      `ifndef N22_HAS_ACE
                          1'b0;
                      `endif
`ifdef N22_HAS_PMONITOR
  `ifdef N22_PMON_NUM_IS_4
assign mmsc_cfg_r[11:7] = 5'd0;
  `else
assign mmsc_cfg_r[11:7] = 5'd4;
  `endif
`else
assign mmsc_cfg_r[11:7] = 5'd0;
`endif

assign mmsc_cfg_r[12] = 1'b0;
assign mmsc_cfg_r[13] = 1'b1;
assign mmsc_cfg_r[14] = 1'b0;
assign mmsc_cfg_r[15] =
                      `ifdef N22_HAS_PMONITOR
                          1'b1;
                      `endif
                      `ifndef N22_HAS_PMONITOR
                          1'b0;
                      `endif
assign mmsc_cfg_r[19:16] = 4'b0;

assign mmsc_cfg_r[21:20] =
                      `ifdef N22_EXCPSAVE_LEVEL_2
                           2'd2;
                      `endif
                      `ifndef N22_EXCPSAVE_LEVEL_2
                           2'd0;
                      `endif

assign mmsc_cfg_r[22] =
                      `ifdef N22_HAS_PMONITOR
                          1'b0;
                      `endif
                      `ifndef N22_HAS_PMONITOR
                          1'b1;
                      `endif

assign mmsc_cfg_r[23] =
                          1'b1;

assign mmsc_cfg_r[24] = 1'b1;

assign mmsc_cfg_r[25] =
                      `ifdef N22_HAS_PPI
                          1'b1;
                      `endif
                      `ifndef N22_HAS_PPI
                          1'b0;
                      `endif

assign mmsc_cfg_r[26] =
                      `ifdef N22_HAS_FIO
                          1'b1;
                      `endif
                      `ifndef N22_HAS_FIO
                          1'b0;
                      `endif

assign mmsc_cfg_r[27] =
                      `ifdef N22_HAS_CLIC
                          1'b1;
                      `endif
                      `ifndef N22_HAS_CLIC
                          1'b0;
                      `endif

assign mmsc_cfg_r[28] =
                      `ifdef N22_HAS_ECLIC
                          1'b1;
                      `endif
                      `ifndef N22_HAS_ECLIC
                          1'b0;
                      `endif

assign mmsc_cfg_r[29] =
                      `ifdef N22_HAS_DSP
                          1'b1;
                      `endif
                      `ifndef N22_HAS_DSP
                          1'b0;
                      `endif

assign mmsc_cfg_r[31:30] = 2'b0;

`ifdef N22_HAS_ILM
  `ifdef N22_IDEN_RW
n22_gnrl_dfflr #1 reg_milmb_ien (milmb_wr_ena, wbck_csr_dat[0], milmb_r[0], clk, rst_n);
  `else
assign milmb_r[0] = 1'b1;
  `endif
assign milmb_r[2:1] = 2'b0;
assign milmb_r[3] = 1'b0;
assign milmb_r[9:4] = 6'b0;
`ifdef N22_ADDR_SIZE_IS_32
assign milmb_r[31:10] = N22_ILM_BASE_ADDR[31:10];
`endif
`ifdef N22_ADDR_SIZE_IS_24
assign milmb_r[`N22_ADDR_SIZE-1:10] = N22_ILM_BASE_ADDR[`N22_ADDR_SIZE-1:10];
assign milmb_r[31:`N22_ADDR_SIZE] = {32-`N22_ADDR_SIZE{1'b0}};
`endif
`endif
`ifndef N22_HAS_ILM
assign milmb_r[31:0] = 32'b0;
`endif

`ifdef N22_HAS_DLM
  `ifdef N22_IDEN_RW
n22_gnrl_dfflr #1 reg_mdlmb_den (mdlmb_wr_ena, wbck_csr_dat[0], mdlmb_r[0], clk, rst_n);
  `else
assign mdlmb_r[0] = 1'b1;
  `endif
assign mdlmb_r[2:1] = 2'b0;
assign mdlmb_r[3] = 1'b0;
assign mdlmb_r[9:4] = 6'b0;
`ifdef N22_ADDR_SIZE_IS_32
assign mdlmb_r[31:10] = N22_DLM_BASE_ADDR[31:10];
`endif
`ifdef N22_ADDR_SIZE_IS_24
assign mdlmb_r[`N22_ADDR_SIZE-1:10] = N22_DLM_BASE_ADDR[`N22_ADDR_SIZE-1:10];
assign mdlmb_r[31:`N22_ADDR_SIZE] = {32-`N22_ADDR_SIZE{1'b0}};
`endif
`endif
`ifndef N22_HAS_DLM
assign mdlmb_r[31:0] = 32'b0;
`endif

assign csr_ilm_enable = milmb_r[0];
assign csr_dlm_enable = mdlmb_r[0];

`ifdef N22_HAS_PPI
assign mppib_r[0] = 1'b1;
  localparam PPI_SIZE_ENCODE = (`N22_PPI_ADDR_WIDTH - 9);
assign mppib_r[5:1] = PPI_SIZE_ENCODE[4:0];
assign mppib_r[9:6] = 4'b0;
`ifdef N22_ADDR_SIZE_IS_32
assign mppib_r[31:10] = N22_PPI_BASE_ADDR[31:10];
`endif
`ifdef N22_ADDR_SIZE_IS_24
assign mppib_r[`N22_ADDR_SIZE-1:10] = N22_PPI_BASE_ADDR[`N22_ADDR_SIZE-1:10];
assign mppib_r[31:`N22_ADDR_SIZE] = {32-`N22_ADDR_SIZE{1'b0}};
`endif
`endif
`ifndef N22_HAS_PPI
assign mppib_r[31:0] = 32'b0;
`endif

`ifdef N22_HAS_FIO
assign mfiob_r[0] = 1'b1;
  localparam FIO_SIZE_ENCODE = (`N22_FIO_ADDR_WIDTH - 9);
assign mfiob_r[5:1] = FIO_SIZE_ENCODE[4:0];
assign mfiob_r[9:6] = 4'b0;
assign mfiob_r[31:10] = N22_FIO_BASE_ADDR[31:10];
`endif
`ifndef N22_HAS_FIO
assign mfiob_r[31:0] = 32'b0;
`endif

`ifdef N22_HAS_CACHE
wire [`N22_XLEN-1:0] mcache_ctl_r;
wire mcache_ctl_ena = mcache_ctl_wr_ena;
wire [`N22_XLEN-1:0] mcache_ctl_nxt = {31'b0,wbck_csr_dat[0]};
n22_gnrl_dfflr #(`N22_XLEN) mcache_ctl_dfflr (mcache_ctl_ena, mcache_ctl_nxt, mcache_ctl_r, clk, rst_n);
`endif

`ifdef N22_HAS_ICACHE
assign csr_icache_enable = mcache_ctl_r[0];
`endif

`ifndef N22_HAS_ICACHE
assign csr_icache_enable = 1'b0;
`endif

wire mmisc_ctl_ena = mmisc_ctl_wr_ena;
wire [`N22_XLEN-1:0] mmisc_ctl_nxt;

assign mmisc_ctl_nxt[31:10] = 22'b0;
assign mmisc_ctl_r[31:10] = 22'b0;

assign mmisc_ctl_nxt[9] = wbck_csr_dat[9];
n22_gnrl_dfflr #(1) mmisc_ctl_9_dfflr (mmisc_ctl_ena, mmisc_ctl_nxt[9], mmisc_ctl_r[9], clk, rst_n);

assign nmi_cause_fff = mmisc_ctl_r[9];

assign mmisc_ctl_nxt[8:7] = 2'b0;
assign mmisc_ctl_r[8:7] = 2'b0;

assign mmisc_ctl_nxt[5:4] = 2'b0;
assign mmisc_ctl_r[5:4] = 2'b0;


assign mmisc_ctl_nxt[2] = wbck_csr_dat[2];

assign mmisc_ctl_nxt[1:0] = 2'b0;
assign mmisc_ctl_r[1:0] = 2'b0;

`ifdef N22_MISALIGNED_ACCESS
assign mmisc_ctl_nxt[6] = wbck_csr_dat[6];
n22_gnrl_dfflrs #(1) mmisc_ctl_6_dfflrs (mmisc_ctl_ena, mmisc_ctl_nxt[6], mmisc_ctl_r[6], clk, rst_n);
assign csr_unalgn_enable = mmisc_ctl_r[6];
`endif

`ifndef N22_MISALIGNED_ACCESS
assign mmisc_ctl_nxt[6] = 1'b0;
assign mmisc_ctl_r[6] = 1'b0;
assign csr_unalgn_enable = 1'b0;
`endif

`ifdef N22_HAS_BPU
assign mmisc_ctl_nxt[3] = wbck_csr_dat[3];
n22_gnrl_dfflrs #(1) mmisc_ctl_3_dfflrs (mmisc_ctl_ena, mmisc_ctl_nxt[3], mmisc_ctl_r[3], clk, rst_n);
assign csr_bpu_enable = mmisc_ctl_r[3];
`endif

`ifndef N22_HAS_BPU
assign mmisc_ctl_nxt[3] = 1'b0;
assign mmisc_ctl_r[3] = 1'b0;
assign csr_bpu_enable = 1'b0;
`endif

n22_gnrl_dfflr  #(1) mmisc_ctl_2_dfflr  (mmisc_ctl_ena, mmisc_ctl_nxt[2], mmisc_ctl_r[2], clk, rst_n);



assign csr_rvcompm_enable = mmisc_ctl_r[2];




wire [`N22_XLEN-1:0] csr_micm_cfg   = micm_cfg_r  ;
wire [`N22_XLEN-1:0] csr_mdcm_cfg   = mdcm_cfg_r  ;
wire [`N22_XLEN-1:0] csr_mmsc_cfg   = mmsc_cfg_r  ;
wire [`N22_XLEN-1:0] csr_milmb      = milmb_r     ;
wire [`N22_XLEN-1:0] csr_mdlmb      = mdlmb_r     ;
wire [`N22_XLEN-1:0] csr_mppib      = mppib_r     ;
wire [`N22_XLEN-1:0] csr_mfiob      = mfiob_r     ;
                 `ifdef N22_HAS_CACHE
wire [`N22_XLEN-1:0] csr_mcache_ctl = mcache_ctl_r;
                 `endif
wire [`N22_XLEN-1:0] csr_mmisc_ctl  = mmisc_ctl_r ;

            `ifndef N22_HAS_DEBUG
wire sel_tselect  = (csr_idx == 12'h7a0);
wire sel_tdata1   = (csr_idx == 12'h7a1);
wire sel_tdata2   = (csr_idx == 12'h7a2);
wire sel_tdata3   = (csr_idx == 12'h7a3);
wire sel_tinfo    = (csr_idx == 12'h7a4);
wire sel_mcontext = (csr_idx == 12'h7a8);
wire sel_textra32 = (csr_idx == 12'h7a3);

wire rd_tselect  =  csr_rd_en & sel_tselect ;
wire rd_tdata1   =  csr_rd_en & sel_tdata1  ;
wire rd_tdata2   =  csr_rd_en & sel_tdata2  ;
wire rd_tdata3   =  csr_rd_en & sel_tdata3  ;
wire rd_tinfo    =  csr_rd_en & sel_tinfo   ;
wire rd_mcontext =  csr_rd_en & sel_mcontext;
wire rd_textra32 =  csr_rd_en & sel_textra32;

wire [`N22_XLEN-1:0] csr_tinfo    = 32'b1;
wire [`N22_XLEN-1:0] csr_tselect  = 32'b0;
wire [`N22_XLEN-1:0] csr_tdata1   = 32'b0;
wire [`N22_XLEN-1:0] csr_tdata2   = 32'b0;
wire [`N22_XLEN-1:0] csr_tdata3   = 32'b0;
            `endif


wire [`N22_XLEN-1:0] csr_mvendorid_tmp1 = 32'h11d;
wire [`N22_XLEN-1:0] csr_mvendorid_tmp2 = 32'h201;
wire [`N22_XLEN-1:0] csr_mvendorid = (csr_mvendorid_tmp1 + csr_mvendorid_tmp2);

assign read_msts_dat = csr_mstatus;
assign {csr_addr_legal, read_csr_dat} = {1'b0,`N22_XLEN'b0}
               | {sel_sleep_value      , ({`N22_XLEN{rd_sleep_value      }} & csr_sleep_value)}
               | {sel_tx_evt           , ({`N22_XLEN{rd_tx_evt           }} & csr_tx_evt)}
               | {sel_wfe              , ({`N22_XLEN{rd_wfe              }} & csr_wfe)}
               | {sel_mstatus    , ({`N22_XLEN{rd_mstatus    }} & csr_mstatus  )     }
                 `ifdef N22_EXCPSAVE_LEVEL_2
               | {sel_msavestatus  , ({`N22_XLEN{rd_msavestatus  }} & csr_msavestatus)     }
               | {sel_msaveepc1    , ({`N22_XLEN{rd_msaveepc1    }} & csr_msaveepc1  )     }
               | {sel_msaveepc2    , ({`N22_XLEN{rd_msaveepc2    }} & csr_msaveepc2  )     }
               | {sel_msavecause1  , ({`N22_XLEN{rd_msavecause1  }} & csr_msavecause1)     }
               | {sel_msavecause2  , ({`N22_XLEN{rd_msavecause2  }} & csr_msavecause2)     }
               | {sel_msavedcause1  , ({`N22_XLEN{rd_msavedcause1  }} & csr_msavedcause1)     }
               | {sel_msavedcause2  , ({`N22_XLEN{rd_msavedcause2  }} & csr_msavedcause2)     }
                 `endif
               | {sel_micm_cfg  , ({`N22_XLEN{rd_micm_cfg  }} & csr_micm_cfg)     }
               | {sel_mdcm_cfg  , ({`N22_XLEN{rd_mdcm_cfg  }} & csr_mdcm_cfg)     }
               | {sel_mmsc_cfg  , ({`N22_XLEN{rd_mmsc_cfg  }} & csr_mmsc_cfg)     }
                 `ifdef N22_HAS_ILM
               | {sel_milmb       , ({`N22_XLEN{rd_milmb       }} & csr_milmb     )     }
                 `endif
                 `ifdef N22_HAS_DLM
               | {sel_mdlmb       , ({`N22_XLEN{rd_mdlmb       }} & csr_mdlmb     )     }
                 `endif
                 `ifdef N22_HAS_PPI
               | {sel_mppib       , ({`N22_XLEN{rd_mppib       }} & csr_mppib     )     }
                 `endif
                 `ifdef N22_HAS_FIO
               | {sel_mfiob       , ({`N22_XLEN{rd_mfiob       }} & csr_mfiob     )     }
                 `endif
                 `ifdef N22_HAS_CACHE
               | {sel_mcache_ctl  , ({`N22_XLEN{rd_mcache_ctl  }} & csr_mcache_ctl)     }
                 `endif
               | {sel_mmisc_ctl   , ({`N22_XLEN{rd_mmisc_ctl   }} & csr_mmisc_ctl )     }
               | {sel_mie        , ({`N22_XLEN{rd_mie        }} & csr_mie      )     }
               | {sel_mtvec      , ({`N22_XLEN{rd_mtvec      }} & csr_mtvec    )     }
               | {sel_mnvec      , ({`N22_XLEN{rd_mnvec      }} & csr_mnvec    )     }
               | {sel_mepc       , ({`N22_XLEN{rd_mepc       }} & csr_mepc     )     }
               | {sel_mscratch   , ({`N22_XLEN{rd_mscratch   }} & csr_mscratch )     }
               | {sel_mcause     , ({`N22_XLEN{rd_mcause     }} & csr_mcause   )     }
               | {sel_mbadaddr   , ({`N22_XLEN{rd_mbadaddr   }} & csr_mbadaddr )     }
               | {sel_mip        , ({`N22_XLEN{rd_mip        }} & csr_mip      )     }
               | {sel_misa       , ({`N22_XLEN{rd_misa       }} & csr_misa      )    }
               | {sel_mvendorid  , ({`N22_XLEN{rd_mvendorid  }} & csr_mvendorid)     }
               | {sel_marchid    , ({`N22_XLEN{rd_marchid    }} & csr_marchid  )     }
               | {sel_mimpid     , ({`N22_XLEN{rd_mimpid     }} & csr_mimpid   )     }
               | {sel_mhartid    , ({`N22_XLEN{rd_mhartid    }} & csr_mhartid  )     }
               | {pmon_csr_addr_legal, pmon_read_csr_dat                            }
            `ifdef N22_HAS_POWERBRAKE
               | {sel_mpftctl    , ({`N22_XLEN{rd_mpftctl    }} & csr_mpftctl   )     }
            `endif
            `ifdef N22_HAS_CLIC
               | {sel_mnxti      , ({`N22_XLEN{rd_mnxti      }} & csr_mnxti   )     }
               | {sel_mtvt       , ({`N22_XLEN{rd_mtvt       }} & csr_mtvt     )     }
              `ifdef N22_HAS_ECLIC
               | {sel_jlmnxti    , ({`N22_XLEN{rd_jlmnxti    }} & csr_jlmnxti )     }
               | {sel_mtvt2      , ({`N22_XLEN{rd_mtvt2      }} & csr_mtvt2   )     }
              `endif
               | {sel_mintstatus , ({`N22_XLEN{rd_mintstatus  }} & csr_mintstatus)   }
               | {sel_mscratchcsw , ({`N22_XLEN{rd_mscratchcsw}} & csr_mscratchcsw)  }
               | {sel_mscratchcswl, ({`N22_XLEN{rd_mscratchcswl}} & csr_mscratchcswl)}
            `endif
            `ifdef N22_HAS_DEBUG
               | {dbg_csr_addr_legal, dbg_read_csr_dat                            }
            `endif
            `ifndef N22_HAS_DEBUG
               | {sel_tselect, ({`N22_XLEN{rd_tselect    }} & csr_tselect)       }
               | {sel_tdata1 , ({`N22_XLEN{rd_tdata1     }} & csr_tdata1)        }
               | {sel_tdata2 , ({`N22_XLEN{rd_tdata2     }} & csr_tdata2)        }
               | {sel_tdata3 , ({`N22_XLEN{rd_tdata3     }} & csr_tdata3)        }
               | {sel_tinfo  , ({`N22_XLEN{rd_tinfo      }} & csr_tinfo )        }
               | {sel_mcontext  , ({`N22_XLEN{rd_mcontext      }} & 32'b0 )        }
               | {sel_textra32  , ({`N22_XLEN{rd_textra32      }} & 32'b0 )        }
            `endif
            `ifdef N22_HAS_STACKSAFE
               | {spsafe_csr_addr_legal, spsafe_read_csr_dat                            }
            `endif
               | {sel_xstatus    , ({`N22_XLEN{rd_xstatus    }} & csr_xstatus  )     }
               | {sel_mdcause    , ({`N22_XLEN{rd_mdcause    }} & csr_mdcause  )     }
               | {sel_uitb       , ({`N22_XLEN{rd_uitb       }} & csr_uitb)     }
               | {pmp_csr_addr_legal, (pmp_read_csr_dat)                                 }
               ;

  assign csr_wro_ilgl =  csr_wr_en & (
                 sel_mvendorid
               | sel_marchid
               | sel_mimpid
               | sel_mhartid
               | sel_micm_cfg
               | sel_mdcm_cfg
               | sel_mmsc_cfg
               ) ;


`ifdef N22_HAS_UMODE

  assign u_mode = (~m_mode) & (~dbg_mode);

  wire umode_sel_legal = ( 1'b0
                  | sel_uitb
                  | sel_wfe
                  | sel_tx_evt
                  | sel_sleep_value
                 );

  wire umode_csr_prv_ilgl = u_mode &
               (~( 1'b0
                  | pmon_csr_umode_sel_legal
                  | umode_sel_legal
                  ))
               ;


  assign umode_prv_ilgl = umode_csr_prv_ilgl | pmon_csr_umode_prv_ilgl;
  assign umode_wro_ilgl = pmon_csr_umode_wro_ilgl;

`endif

`ifndef N22_HAS_UMODE
  assign u_mode = 1'b0;
  assign umode_prv_ilgl = 1'b0;
  assign umode_wro_ilgl = 1'b0;
`endif



  `ifdef N22_HAS_DEBUG
  assign dbg_csr_ena      = csr_ena     ;
  assign dbg_csr_wr_en    = csr_wr_en   ;
  assign dbg_csr_rd_en    = csr_rd_en   ;
  assign dbg_csr_idx      = csr_idx     ;
  assign dbg_wbck_csr_wen = wbck_csr_wen;
  assign dbg_wbck_csr_dat = wbck_csr_dat;
  `endif

`ifndef FPGA_SOURCE
`ifndef SYNTHESIS
//synopsys translate_off


//synopsys translate_on
`endif
`endif

endmodule


// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_csr (
    core_clk,
    core_reset_n,
    reset_vector,
    hart_id,
    csr_marchid,
    csr_mimpid,
    core_coherent_enable,
    core_coherent_state,
    mmu_csr_mitlb_access,
    mmu_csr_mitlb_miss,
    mmu_csr_mdtlb_access,
    mmu_csr_mdtlb_miss,
    ace_acr_dirty_set,
    ace_error,
    ilm_csr_access,
    dlm_csr_access0,
    dlm_csr_access1,
    dlm_csr_access2,
    dlm_csr_access3,
    ipipe_csr_nmi_pending,
    wb_i0_instr_event,
    wb_i1_instr_event,
    ipipe_csr_req_wr_valid,
    ipipe_csr_req_rd_valid,
    ipipe_csr_req_read_only,
    ipipe_csr_req_mrandstate,
    ipipe_csr_req_func,
    ipipe_csr_req_waddr,
    ipipe_csr_req_wdata,
    ipipe_csr_req_raddr,
    csr_ipipe_resp_rdata,
    csr_ipipe_rmw_rdata,
    csr_trap_delegated,
    ipipe_csr_halt_taken,
    ipipe_csr_halt_return,
    ipipe_csr_halt_cause,
    ipipe_csr_halt_ddcause,
    csr_medeleg,
    csr_sedeleg,
    ipipe_csr_nmi_taken,
    ipipe_csr_trap_taken,
    trap_handled_by_s_mode,
    trap_handled_by_u_mode,
    ipipe_csr_m_trap_return,
    ipipe_csr_s_trap_return,
    ipipe_csr_u_trap_return,
    ipipe_csr_inst_retire,
    ipipe_csr_pfm_inst_retire,
    ipipe_csr_cause_we,
    ipipe_csr_cause_detail_we,
    ipipe_csr_cause_interrupt,
    ipipe_csr_cause_code,
    ipipe_csr_cause_detail,
    ipipe_csr_cause_detail_pm,
    ipipe_csr_epc_we,
    ipipe_csr_epc_wdata,
    ipipe_csr_tval_wdata,
    ipipe_csr_tval_we,
    ipipe_csr_ecc_trap,
    ipipe_csr_ecc_code_en,
    ipipe_csr_ecc_code,
    ipipe_csr_ecc_corr,
    ipipe_csr_ecc_precise,
    ipipe_csr_ecc_ramid,
    ipipe_csr_ecc_insn,
    ipipe_csr_ecc_fetch,
    ipipe_csr_vtype_we,
    ipipe_csr_vtype_wdata,
    ipipe_csr_vl_we,
    ipipe_csr_vl_wdata,
    csr_mstatus_mie,
    csr_mstatus_sie,
    csr_mstatus_uie,
    csr_mepc,
    csr_sepc,
    csr_uepc,
    csr_mtvec,
    csr_stvec,
    csr_utvec,
    csr_mip,
    csr_mie,
    csr_ipipe_slip,
    csr_ipipe_slie,
    ipipe_csr_int_delegate_u,
    ipipe_csr_int_delegate_s,
    ipipe_csr_m_sbe_set,
    ipipe_csr_s_sbe_set,
    ipipe_csr_m_slpecc_clr,
    ipipe_csr_m_hpmint_clr,
    ipipe_csr_m_sbe_clr,
    ipipe_csr_s_slpecc_clr,
    ipipe_csr_s_hpmint_clr,
    ipipe_csr_s_sbe_clr,
    csr_milmb_ien,
    csr_milmb_eccen,
    csr_milmb_rwecc,
    csr_mdlmb_den,
    csr_mdlmb_eccen,
    csr_mdlmb_rwecc,
    csr_mecc_code,
    csr_mcache_ctl_iprefetch_en,
    csr_mcache_ctl_ic_en,
    csr_mcache_ctl_ic_eccen,
    csr_mcache_ctl_ic_rwecc,
    csr_mcache_ctl_dc_en,
    csr_mcache_ctl_dc_eccen,
    csr_mcache_ctl_dc_rwecc,
    csr_mcache_ctl_cctl_suen,
    csr_mcache_ctl_dprefetch_en,
    csr_mcache_ctl_dc_waround,
    csr_mcache_ctl_tlb_eccen,
    csr_mcache_ctl_tlb_rwecc,
    csr_mxstatus_dme,
    csr_mxstatus_ime,
    lsu_reserve_clr,
    lsu_prefetch_clr,
    csr_cur_privilege,
    cur_privilege_m,
    cur_privilege_s,
    cur_privilege_u,
    ls_privilege_m,
    ls_privilege_s,
    ls_privilege_u,
    csr_mstatus_mpp,
    csr_mstatus_mprv,
    csr_mstatus_mxr,
    csr_mstatus_sum,
    csr_dcsr_debugint,
    csr_resethaltreq,
    csr_halt_mode,
    csr_dcsr_step,
    csr_dcsr_mprven,
    csr_dcsr_ebreakm,
    csr_dcsr_ebreaks,
    csr_dcsr_ebreaku,
    csr_dcsr_stepie,
    csr_dpc,
    csr_mstatus_fs,
    csr_mmisc_ctl_aces,
    csr_mmisc_ctl_vec_plic,
    csr_mmisc_ctl_rvcompm,
    csr_mmisc_ctl_brpe,
    csr_mmisc_ctl_una,
    csr_mmisc_ctl_nbcache_en,
    csr_tcontrol_mte,
    csr_dexc2dbg_iam,
    csr_dexc2dbg_iaf,
    csr_dexc2dbg_ii,
    csr_dexc2dbg_nmi,
    csr_dexc2dbg_lam,
    csr_dexc2dbg_laf,
    csr_dexc2dbg_sam,
    csr_dexc2dbg_saf,
    csr_dexc2dbg_uec,
    csr_dexc2dbg_sec,
    csr_dexc2dbg_hec,
    csr_dexc2dbg_mec,
    csr_dexc2dbg_hsp,
    csr_dexc2dbg_slpecc,
    csr_dexc2dbg_sbe,
    csr_dexc2dbg_ace,
    csr_dexc2dbg_pmov,
    csr_dexc2dbg_spf,
    csr_dexc2dbg_lpf,
    csr_dexc2dbg_ipf,
    debugint,
    resethaltreq,
    csr_satp_ppn,
    csr_satp_mode,
    csr_satp_asid,
    meip,
    mtip,
    msip,
    seip,
    ueip,
    meiid,
    seiid,
    ueiid,
    csr_meiid,
    csr_seiid,
    csr_ueiid,
    csr_tselect_we,
    csr_tdata1_we,
    csr_tdata2_we,
    csr_tdata3_we,
    csr_mcontext_we,
    csr_scontext_we,
    csr_wdata,
    csr_tselect,
    csr_tdata1,
    csr_tdata2,
    csr_tdata3,
    csr_tinfo,
    csr_mcontext,
    csr_scontext,
    lsu_cctl_rdata,
    lsu_cctl_raddr,
    csr_t_level,
    csr_pft_en,
    ipipe_csr_mhsp_bound_wdata,
    ipipe_csr_mhsp_bound_wen,
    ipipe_csr_hsp_xcpt,
    csr_mhsp_bound,
    csr_mhsp_base,
    csr_mhsp_ctl_ovf_en,
    csr_mhsp_ctl_udf_en,
    csr_mhsp_ctl_schm,
    csr_mhsp_ctl_u,
    csr_mhsp_ctl_s,
    csr_mhsp_ctl_m,
    csr_uitb,
    stoptime,
    csr_mcounteren,
    csr_mcounterwen,
    csr_scounteren,
    csr_mstatus_tw,
    csr_mstatus_tvm,
    csr_mstatus_tsr,
    ipipe_csr_ucode_ov_set,
    csr_frm,
    ipipe_csr_fs_wen,
    ipipe_csr_fflags_set,
    csr_mmu_satp_we,
    csr_pmp_we,
    csr_pmp_waddr,
    csr_pmp_raddr0,
    csr_pmp_raddr1,
    csr_pmp_wdata,
    pmp_csr_hit0,
    pmp_csr_rdata0,
    pmp_csr_hit1,
    pmp_csr_rdata1,
    csr_pma_we,
    csr_pma_waddr,
    csr_pma_raddr0,
    csr_pma_raddr1,
    csr_pma_wdata,
    pma_csr_hit0,
    pma_csr_rdata0,
    pma_csr_hit1,
    pma_csr_rdata1,
    csr_mideleg,
    csr_sideleg,
    csr_mslideleg,
    csr_mcctlbeginaddr,
    itlb_translate_en,
    csr_ls_translate_en,
    csr_vtype,
    csr_vl,
    csr_vstart,
    ipipe_event,
    dcu_event,
    mshr_event,
    ifu_event,
    lsu_event,
    csr_prob_raddr,
    csr_prob_rdata,
    slvp_ipipe_local_int,
    slvp_ipipe_ecc_corr,
    slvp_ipipe_ecc_ramid,
    dcu_async_ecc_error,
    dcu_async_ecc_corr,
    dcu_async_ecc_ramid,
    int_ecc_corr,
    int_ecc_ramid,
    int_ecc_insn,
    int_ecc_cause_detail
);
parameter CPUID = 16'h0000;
parameter MIMPID = 32'h00000000;
parameter MMU_SCHEME_INT = 2;
parameter PALEN = 39;
parameter VALEN = 39;
parameter EXTVALEN = 40;
parameter FLEN = 1;
parameter CAUSE_LEN = 6;
parameter RVA_SUPPORT_INT = 0;
parameter RVN_SUPPORT_INT = 0;
parameter DSP_SUPPORT_INT = 0;
parameter ACE_SUPPORT_INT = 0;
parameter FP16_SUPPORT_INT = 0;
parameter BFLOAT16_SUPPORT_INT = 0;
parameter VINT4_SUPPORT_INT = 0;
parameter HAS_VPU_INT = 0;
parameter NUM_PRIVILEGE_LEVELS = 1;
parameter DEBUG_SUPPORT_INT = 0;
parameter NUM_TRIGGER = 0;
parameter PERFORMANCE_MONITOR_INT = 0;
parameter POWERBRAKE_SUPPORT_INT = 1;
parameter VECTOR_PLIC_SUPPORT_INT = 1;
parameter SLAVE_PORT_SUPPORT_INT = 1;
parameter STACKSAFE_SUPPORT_INT = 0;
parameter ISA_ANDES_INT = 1;
parameter BRANCH_PREDICTION_INT = 0;
parameter UNALIGNED_ACCESS_INT = 0;
parameter PMA_ENTRIES = 0;
parameter DCACHE_PREFETCH_SUPPORT_INT = 0;
parameter WRITE_AROUND_SUPPORT_INT = 0;
parameter LM_ENABLE_CTRL_INT = 0;
parameter ILM_SIZE_KB = 0;
parameter ILM_ECC_TYPE_INT = 0;
parameter DLM_SIZE_KB = 0;
parameter DLM_ECC_TYPE_INT = 0;
parameter ILM_BASE = 64'h1000_0000;
parameter DLM_BASE = 64'h2000_0000;
parameter CACHE_LINE_SIZE = 16;
parameter ICACHE_SIZE_KB = 0;
parameter ICACHE_ECC_TYPE_INT = 0;
parameter ICACHE_TAG_RAM_AW = 9;
parameter ICACHE_WAY = 2;
parameter ICACHE_LRU_INT = 0;
parameter ICACHE_FIRST_WORD_FIRST_INT = 1;
parameter DCACHE_SIZE_KB = 0;
parameter DCACHE_ECC_TYPE_INT = 0;
parameter DCACHE_TAG_AW = 9;
parameter DCACHE_WAY = 2;
parameter DCACHE_LRU_INT = 0;
parameter DCACHE_FIRST_WORD_FIRST_INT = 1;
parameter STLB_ECC_TYPE = 0;
parameter CM_SUPPORT_INT = 0;
parameter CLUSTER_SUPPORT_INT = 0;
parameter L2C_CACHE_SIZE_KB = 0;
parameter IOCP_NUM = 0;
parameter NCORE_CLUSTER = 1;
parameter L2C_REG_BASE = 64'h0000_0000;
parameter LOCALINT_SLPECC = 16;
parameter LOCALINT_SBE = 17;
parameter LOCALINT_HPMINT = 18;
parameter LOCALINT_ACEERR = 24;
parameter TRACE_INTERFACE_INT = 0;
localparam VENDOR_ANDES = 11'h31e;
localparam ECC_SUPPORT_INT = ((STLB_ECC_TYPE != 0) | (ILM_ECC_TYPE_INT != 0) | (DLM_ECC_TYPE_INT != 0) | ((ICACHE_ECC_TYPE_INT != 0)) | (DCACHE_ECC_TYPE_INT != 0)) ? 1 : 0;
localparam LM_ECC_SUPPORT_INT = ((ILM_ECC_TYPE_INT != 0) | (DLM_ECC_TYPE_INT != 0)) ? 1 : 0;
localparam ECC_CODE_LEN = 7;
localparam PRIVILEGE_USER = 2'b00;
localparam PRIVILEGE_SUPERVISOR = 2'b01;
localparam PRIVILEGE_HYPERVISOR = 2'b10;
localparam PRIVILEGE_MACHINE = 2'b11;
localparam MMISC_CTL_EXIST_INT = (((ACE_SUPPORT_INT == 1)) | ((ISA_ANDES_INT == 1)) | ((VECTOR_PLIC_SUPPORT_INT == 1)) | ((BRANCH_PREDICTION_INT != 0))) ? 1 : 0;
localparam MMSC_CFG2_EXIST_INT = 1;
localparam CACHE_SUPPORT_INT = ((ICACHE_SIZE_KB != 0) | (DCACHE_SIZE_KB != 0) | (STLB_ECC_TYPE != 0)) ? 1 : 0;
localparam DCACHE_SUPPORT_INT = (DCACHE_SIZE_KB != 0) ? 1 : 0;
localparam RVF_SUPPORT_INT = 0;
localparam SLPECC_SUPPORT_INT = ((((LM_ECC_SUPPORT_INT == 1)) & ((SLAVE_PORT_SUPPORT_INT == 1))) | ((DCACHE_SIZE_KB != 0) & (DCACHE_ECC_TYPE_INT != 0))) ? 1 : 0;
localparam CSR12_MVENDORID = 12'hf11;
localparam CSR12_MARCHID = 12'hf12;
localparam CSR12_MIMPID = 12'hf13;
localparam CSR12_MHARTID = 12'hf14;
localparam CSR12_MSTATUS = 12'h300;
localparam CSR12_MISA = 12'h301;
localparam CSR12_MEDELEG = 12'h302;
localparam CSR12_MIDELEG = 12'h303;
localparam CSR12_MIE = 12'h304;
localparam CSR12_MTVEC = 12'h305;
localparam CSR12_MSCRATCH = 12'h340;
localparam CSR12_MEPC = 12'h341;
localparam CSR12_MCAUSE = 12'h342;
localparam CSR12_MTVAL = 12'h343;
localparam CSR12_MIP = 12'h344;
localparam CSR12_TSELECT = 12'h7a0;
localparam CSR12_TDATA1 = 12'h7a1;
localparam CSR12_TDATA2 = 12'h7a2;
localparam CSR12_TDATA3 = 12'h7a3;
localparam CSR12_TINFO = 12'h7a4;
localparam CSR12_TCONTROL = 12'h7a5;
localparam CSR12_MCONTEXT = 12'h7a8;
localparam CSR12_SCONTEXT = 12'h7aa;
localparam CSR12_DCSR = 12'h7b0;
localparam CSR12_DPC = 12'h7b1;
localparam CSR12_DSCRATCH0 = 12'h7b2;
localparam CSR12_DSCRATCH1 = 12'h7b3;
localparam CSR12_MICM_CFG = 12'hfc0;
localparam CSR12_MDCM_CFG = 12'hfc1;
localparam CSR12_MMSC_CFG = 12'hfc2;
localparam CSR12_MMSC_CFG2 = 12'hfc3;
localparam CSR12_ML2C_CTL_BASE = 12'hfcf;
localparam CSR12_MMISC_CTL = 12'h7d0;
localparam CSR12_MCLK_CTL = 12'h7df;
localparam CSR12_MSLIDELEG = 12'h7d5;
localparam CSR12_MILMB = 12'h7c0;
localparam CSR12_MDLMB = 12'h7c1;
localparam CSR12_MECC_CODE = 12'h7c2;
localparam CSR12_MNVEC = 12'h7c3;
localparam CSR12_MXSTATUS = 12'h7c4;
localparam CSR12_MPFT_CTL = 12'h7c5;
localparam CSR12_MHSP_CTL = 12'h7c6;
localparam CSR12_MHSP_BOUND = 12'h7c7;
localparam CSR12_MHSP_BASE = 12'h7c8;
localparam CSR12_MDCAUSE = 12'h7c9;
localparam CSR12_MCACHE_CTL = 12'h7ca;
localparam CSR12_MCCTLBEGINADDR = 12'h7cb;
localparam CSR12_MCCTLCOMMAND = 12'h7cc;
localparam CSR12_MCCTLDATA = 12'h7cd;
localparam CSR12_DEXC2DBG = 12'h7e0;
localparam CSR12_DDCAUSE = 12'h7e1;
localparam CSR12_MRANDSEQ = 12'h7fc;
localparam CSR12_MRANDSEQH = 12'h7fd;
localparam CSR12_MRANDSTATE = 12'h7fe;
localparam CSR12_MRANDSTATEH = 12'h7ff;
localparam CSR12_UITB = 12'h800;
localparam CSR12_UCODE = 12'h801;
localparam CSR12_UDCAUSE = 12'h809;
localparam CSR12_UCCTLBEGINADDR = 12'h80b;
localparam CSR12_UCCTLCOMMAND = 12'h80c;
localparam CSR12_SSTATUS = 12'h100;
localparam CSR12_SIE = 12'h104;
localparam CSR12_SIDELEG = 12'h103;
localparam CSR12_SEDELEG = 12'h102;
localparam CSR12_STVEC = 12'h105;
localparam CSR12_SSCRATCH = 12'h140;
localparam CSR12_SEPC = 12'h141;
localparam CSR12_SCAUSE = 12'h142;
localparam CSR12_STVAL = 12'h143;
localparam CSR12_SIP = 12'h144;
localparam CSR12_SATP = 12'h180;
localparam CSR12_SLIE = 12'h9c4;
localparam CSR12_SLIP = 12'h9c5;
localparam CSR12_SDCAUSE = 12'h9c9;
localparam CSR12_SCCTLDATA = 12'h9cd;
localparam CSR12_SMISC_CTL = 12'h9d0;
localparam CSR12_USTATUS = 12'h000;
localparam CSR12_UIE = 12'h004;
localparam CSR12_UTVEC = 12'h005;
localparam CSR12_USCRATCH = 12'h040;
localparam CSR12_UEPC = 12'h041;
localparam CSR12_UCAUSE = 12'h042;
localparam CSR12_UTVAL = 12'h043;
localparam CSR12_UIP = 12'h044;
localparam CSR12_FFLAGS = 12'h001;
localparam CSR12_FRM = 12'h002;
localparam CSR12_FCSR = 12'h003;
localparam CSR12_VSTART = 12'h008;
localparam CSR12_VXSAT = 12'h009;
localparam CSR12_VXRM = 12'h00a;
localparam CSR12_VCSR = 12'h00f;
localparam CSR12_VL = 12'hc20;
localparam CSR12_VTYPE = 12'hc21;
localparam CSR12_VLENB = 12'hc22;
localparam STATE_OFF = 2'd0;
localparam STATE_INIT = 2'd1;
localparam STATE_CLEAN = 2'd2;
localparam STATE_DIRTY = 2'd3;
localparam CAUSE_MISALIGNED_FETCH = 10'h0;
localparam CAUSE_FAULT_FETCH = 10'h1;
localparam CAUSE_ILLEGAL_INST = 10'h2;
localparam CAUSE_BREAKPOINT = 10'h3;
localparam CAUSE_MISALIGNED_LOAD = 10'h4;
localparam CAUSE_FAULT_LOAD = 10'h5;
localparam CAUSE_MISALIGNED_STORE = 10'h6;
localparam CAUSE_FAULT_STORE = 10'h7;
localparam CAUSE_USER_ECALL = 10'h8;
localparam CAUSE_SUPERVISOR_ECALL = 10'h9;
localparam CAUSE_PAGE_FAULT_FETCH = 10'hc;
localparam CAUSE_PAGE_FAULT_LOAD = 10'hd;
localparam CAUSE_PAGE_FAULT_STORE = 10'hf;
localparam INT_ECC_DCAUSE_SLVP = 3'd1;
localparam DCAUSE_SWBREAK = 3'd1;
localparam DCAUSE_TRIGGER = 3'd2;
localparam DCAUSE_DBGINT = 3'd3;
localparam DCAUSE_STEP = 3'd4;
localparam DCAUSE_HALT = 3'd5;
localparam SATP_MODE_BARE = 4'h0;
localparam SATP_MODE_SV39 = 4'h8;
localparam SATP_MODE_SV48 = 4'h9;
input core_clk;
input core_reset_n;
input [VALEN - 1:0] reset_vector;
input [63:0] hart_id;
input [31:0] csr_marchid;
input [31:0] csr_mimpid;
output core_coherent_enable;
input core_coherent_state;
input mmu_csr_mitlb_access;
input mmu_csr_mitlb_miss;
input mmu_csr_mdtlb_access;
input mmu_csr_mdtlb_miss;
input ace_acr_dirty_set;
input ace_error;
input ilm_csr_access;
input dlm_csr_access0;
input dlm_csr_access1;
input dlm_csr_access2;
input dlm_csr_access3;
input ipipe_csr_nmi_pending;
input [40:0] wb_i0_instr_event;
input [40:0] wb_i1_instr_event;
input ipipe_csr_req_wr_valid;
input ipipe_csr_req_rd_valid;
input ipipe_csr_req_read_only;
input ipipe_csr_req_mrandstate;
input [1:0] ipipe_csr_req_func;
input [11:0] ipipe_csr_req_waddr;
input [31:0] ipipe_csr_req_wdata;
input [11:0] ipipe_csr_req_raddr;
output [31:0] csr_ipipe_resp_rdata;
output [31:0] csr_ipipe_rmw_rdata;
output csr_trap_delegated;
input ipipe_csr_halt_taken;
input ipipe_csr_halt_return;
input [2:0] ipipe_csr_halt_cause;
input [15:0] ipipe_csr_halt_ddcause;
output [31:0] csr_medeleg;
output [31:0] csr_sedeleg;
input ipipe_csr_nmi_taken;
input ipipe_csr_trap_taken;
input trap_handled_by_s_mode;
input trap_handled_by_u_mode;
input ipipe_csr_m_trap_return;
input ipipe_csr_s_trap_return;
input ipipe_csr_u_trap_return;
input [1:0] ipipe_csr_inst_retire;
input [1:0] ipipe_csr_pfm_inst_retire;
input ipipe_csr_cause_we;
input ipipe_csr_cause_detail_we;
input ipipe_csr_cause_interrupt;
input [9:0] ipipe_csr_cause_code;
input [2:0] ipipe_csr_cause_detail;
input [1:0] ipipe_csr_cause_detail_pm;
input ipipe_csr_epc_we;
input [31:0] ipipe_csr_epc_wdata;
input [31:0] ipipe_csr_tval_wdata;
input ipipe_csr_tval_we;
input ipipe_csr_ecc_trap;
input ipipe_csr_ecc_code_en;
input [7:0] ipipe_csr_ecc_code;
input ipipe_csr_ecc_corr;
input ipipe_csr_ecc_precise;
input [3:0] ipipe_csr_ecc_ramid;
input ipipe_csr_ecc_insn;
input ipipe_csr_ecc_fetch;
input ipipe_csr_vtype_we;
input [31:0] ipipe_csr_vtype_wdata;
input ipipe_csr_vl_we;
input [31:0] ipipe_csr_vl_wdata;
output csr_mstatus_mie;
output csr_mstatus_sie;
output csr_mstatus_uie;
output [31:0] csr_mepc;
output [31:0] csr_sepc;
output [31:0] csr_uepc;
output [31:0] csr_mtvec;
output [31:0] csr_stvec;
output [31:0] csr_utvec;
output [31:0] csr_mip;
output [31:0] csr_mie;
output [31:0] csr_ipipe_slip;
output [31:0] csr_ipipe_slie;
input ipipe_csr_int_delegate_u;
input ipipe_csr_int_delegate_s;
input ipipe_csr_m_sbe_set;
input ipipe_csr_s_sbe_set;
input ipipe_csr_m_slpecc_clr;
input ipipe_csr_m_hpmint_clr;
input ipipe_csr_m_sbe_clr;
input ipipe_csr_s_slpecc_clr;
input ipipe_csr_s_hpmint_clr;
input ipipe_csr_s_sbe_clr;
output csr_milmb_ien;
output [1:0] csr_milmb_eccen;
output csr_milmb_rwecc;
output csr_mdlmb_den;
output [1:0] csr_mdlmb_eccen;
output csr_mdlmb_rwecc;
output [31:0] csr_mecc_code;
output csr_mcache_ctl_iprefetch_en;
output csr_mcache_ctl_ic_en;
output [1:0] csr_mcache_ctl_ic_eccen;
output csr_mcache_ctl_ic_rwecc;
output csr_mcache_ctl_dc_en;
output [1:0] csr_mcache_ctl_dc_eccen;
output csr_mcache_ctl_dc_rwecc;
output csr_mcache_ctl_cctl_suen;
output csr_mcache_ctl_dprefetch_en;
output [1:0] csr_mcache_ctl_dc_waround;
output [1:0] csr_mcache_ctl_tlb_eccen;
output csr_mcache_ctl_tlb_rwecc;
output csr_mxstatus_dme;
output csr_mxstatus_ime;
output lsu_reserve_clr;
output lsu_prefetch_clr;
output [1:0] csr_cur_privilege;
output cur_privilege_m;
output cur_privilege_s;
output cur_privilege_u;
output ls_privilege_m;
output ls_privilege_s;
output ls_privilege_u;
output [1:0] csr_mstatus_mpp;
output csr_mstatus_mprv;
output csr_mstatus_mxr;
output csr_mstatus_sum;
output csr_dcsr_debugint;
output csr_resethaltreq;
output csr_halt_mode;
output csr_dcsr_step;
output csr_dcsr_mprven;
output csr_dcsr_ebreakm;
output csr_dcsr_ebreaks;
output csr_dcsr_ebreaku;
output csr_dcsr_stepie;
output [31:0] csr_dpc;
output [1:0] csr_mstatus_fs;
output [1:0] csr_mmisc_ctl_aces;
output csr_mmisc_ctl_vec_plic;
output csr_mmisc_ctl_rvcompm;
output csr_mmisc_ctl_brpe;
output csr_mmisc_ctl_una;
output csr_mmisc_ctl_nbcache_en;
output csr_tcontrol_mte;
output csr_dexc2dbg_iam;
output csr_dexc2dbg_iaf;
output csr_dexc2dbg_ii;
output csr_dexc2dbg_nmi;
output csr_dexc2dbg_lam;
output csr_dexc2dbg_laf;
output csr_dexc2dbg_sam;
output csr_dexc2dbg_saf;
output csr_dexc2dbg_uec;
output csr_dexc2dbg_sec;
output csr_dexc2dbg_hec;
output csr_dexc2dbg_mec;
output csr_dexc2dbg_hsp;
output csr_dexc2dbg_slpecc;
output csr_dexc2dbg_sbe;
output csr_dexc2dbg_ace;
output csr_dexc2dbg_pmov;
output csr_dexc2dbg_spf;
output csr_dexc2dbg_lpf;
output csr_dexc2dbg_ipf;
input debugint;
input resethaltreq;
output [PALEN - 1:12] csr_satp_ppn;
output [3:0] csr_satp_mode;
output [8:0] csr_satp_asid;
input meip;
input mtip;
input msip;
input seip;
input ueip;
input [9:0] meiid;
input [9:0] seiid;
input [9:0] ueiid;
output [9:0] csr_meiid;
output [9:0] csr_seiid;
output [9:0] csr_ueiid;
output csr_tselect_we;
output csr_tdata1_we;
output csr_tdata2_we;
output csr_tdata3_we;
output csr_mcontext_we;
output csr_scontext_we;
output [31:0] csr_wdata;
input [31:0] csr_tselect;
input [31:0] csr_tdata1;
input [31:0] csr_tdata2;
input [31:0] csr_tdata3;
input [31:0] csr_tinfo;
input [31:0] csr_mcontext;
input [31:0] csr_scontext;
input [31:0] lsu_cctl_rdata;
input [31:0] lsu_cctl_raddr;
output [3:0] csr_t_level;
output csr_pft_en;
input [31:0] ipipe_csr_mhsp_bound_wdata;
input ipipe_csr_mhsp_bound_wen;
input ipipe_csr_hsp_xcpt;
output [31:0] csr_mhsp_bound;
output [31:0] csr_mhsp_base;
output csr_mhsp_ctl_ovf_en;
output csr_mhsp_ctl_udf_en;
output csr_mhsp_ctl_schm;
output csr_mhsp_ctl_u;
output csr_mhsp_ctl_s;
output csr_mhsp_ctl_m;
output [31:0] csr_uitb;
output stoptime;
output [31:0] csr_mcounteren;
output [31:0] csr_mcounterwen;
output [31:0] csr_scounteren;
output csr_mstatus_tw;
output csr_mstatus_tvm;
output csr_mstatus_tsr;
input ipipe_csr_ucode_ov_set;
output [31:0] csr_frm;
input ipipe_csr_fs_wen;
input [4:0] ipipe_csr_fflags_set;
output csr_mmu_satp_we;
output csr_pmp_we;
output [11:0] csr_pmp_waddr;
output [11:0] csr_pmp_raddr0;
output [11:0] csr_pmp_raddr1;
output [31:0] csr_pmp_wdata;
input pmp_csr_hit0;
input [31:0] pmp_csr_rdata0;
input pmp_csr_hit1;
input [31:0] pmp_csr_rdata1;
output csr_pma_we;
output [11:0] csr_pma_waddr;
output [11:0] csr_pma_raddr0;
output [11:0] csr_pma_raddr1;
output [31:0] csr_pma_wdata;
input pma_csr_hit0;
input [31:0] pma_csr_rdata0;
input pma_csr_hit1;
input [31:0] pma_csr_rdata1;
output [31:0] csr_mideleg;
output [31:0] csr_sideleg;
output [31:0] csr_mslideleg;
output [31:0] csr_mcctlbeginaddr;
output itlb_translate_en;
output csr_ls_translate_en;
output [31:0] csr_vtype;
output [31:0] csr_vl;
output [31:0] csr_vstart;
input [0:0] ipipe_event;
input [6:0] dcu_event;
input [15:0] mshr_event;
input [5:0] ifu_event;
input [4:0] lsu_event;
input [11:0] csr_prob_raddr;
output [31:0] csr_prob_rdata;
input slvp_ipipe_local_int;
input slvp_ipipe_ecc_corr;
input [3:0] slvp_ipipe_ecc_ramid;
input dcu_async_ecc_error;
input dcu_async_ecc_corr;
input [3:0] dcu_async_ecc_ramid;
output int_ecc_corr;
output [3:0] int_ecc_ramid;
output int_ecc_insn;
output [2:0] int_ecc_cause_detail;


reg csr_mmu_satp_we;
wire nmi_taken = ipipe_csr_nmi_taken;
wire trap_taken = ipipe_csr_trap_taken;
wire halt_taken = ipipe_csr_halt_taken;
wire ecc_trap_taken = ipipe_csr_trap_taken & ipipe_csr_ecc_trap;
wire m_trap_return = ipipe_csr_m_trap_return;
wire s_trap_return = ipipe_csr_s_trap_return;
wire u_trap_return = ipipe_csr_u_trap_return;
wire halt_return = ipipe_csr_halt_return;
wire three_level_mode = (NUM_PRIVILEGE_LEVELS > 2);
wire [31:0] csr_misa;
wire [31:0] csr_mvendorid = {{21{1'b0}},VENDOR_ANDES};
wire [31:0] csr_mhartid = hart_id[31:0];
wire [31:0] csr_mstatus;
wire csr_medeleg_iam;
wire csr_medeleg_iaf;
wire csr_medeleg_ii;
wire csr_medeleg_b;
wire csr_medeleg_lam;
wire csr_medeleg_laf;
wire csr_medeleg_sam;
wire csr_medeleg_saf;
wire csr_medeleg_uec;
wire csr_medeleg_sec;
wire csr_medeleg_ipf;
wire csr_medeleg_lpf;
wire csr_medeleg_spf;
wire [31:0] csr_medeleg = {{16{1'b0}},csr_medeleg_spf,1'b0,csr_medeleg_lpf,csr_medeleg_ipf,2'b0,csr_medeleg_sec,csr_medeleg_uec,csr_medeleg_saf,csr_medeleg_sam,csr_medeleg_laf,csr_medeleg_lam,csr_medeleg_b,csr_medeleg_ii,csr_medeleg_iaf,csr_medeleg_iam};
wire csr_mideleg_ssi;
wire csr_mideleg_sti;
wire csr_mideleg_sei;
wire csr_mideleg_usi;
wire csr_mideleg_uti;
wire csr_mideleg_uei;
wire [31:0] csr_mideleg = {{22{1'b0}},csr_mideleg_sei,csr_mideleg_uei,2'b0,csr_mideleg_sti,csr_mideleg_uti,2'b0,csr_mideleg_ssi,csr_mideleg_usi};
wire [31:0] csr_mslideleg;
wire csr_mslideleg_slpecc;
wire csr_mslideleg_sbe;
wire csr_mslideleg_hpmint;
wire csr_mslideleg_aceerr;
wire [31:0] csr_mie;
wire [31:0] csr_mtvec;
wire [31:0] csr_mxstatus;
wire [31:0] csr_mdcause;
wire [31:0] csr_mcache_ctl;
wire [31:0] csr_mcctlcommand;
wire [31:0] csr_mcctldata;
wire [31:0] csr_resp_rdata;
reg [31:0] csr_mscratch;
wire [31:0] csr_mepc;
wire [31:0] csr_mcause;
wire [31:0] csr_mtval;
wire [31:0] csr_mip;
wire [31:0] csr_rmw_mip;
wire [31:0] csr_dcsr;
wire [31:0] csr_dpc;
wire [31:0] csr_dscratch0;
wire [31:0] csr_dscratch1;
wire [31:0] csr_micm_cfg;
wire [31:0] csr_mdcm_cfg;
wire [31:0] csr_mmsc_cfg;
wire [31:0] csr_mmsc_cfg2;
wire [31:0] csr_ml2c_ctl_base;
wire [31:0] csr_mmisc_ctl;
wire [31:0] csr_milmb;
wire [31:0] csr_mdlmb;
wire [31:0] csr_mecc_code;
wire [7:0] csr_mecc_code_code;
wire csr_mecc_code_c;
wire csr_mecc_code_p;
wire [3:0] csr_mecc_code_ramid;
wire csr_mecc_code_fetch;
wire [31:0] csr_mnvec;
wire [31:0] csr_dexc2dbg;
wire [31:0] csr_ddcause;
wire [31:0] csr_mpft_ctl;
wire [31:0] csr_mhsp_ctl;
wire [31:0] csr_mhsp_bound;
wire [31:0] csr_mhsp_base;
wire [31:0] csr_uitb;
wire [31:0] csr_udcause;
wire [31:0] csr_mrandseq;
wire [31:0] csr_mrandseqh;
wire [31:0] csr_mrandstate;
wire [31:0] csr_mrandstateh;
wire csr_milmb_ien;
wire [1:0] csr_milmb_eccen;
wire csr_milmb_rwecc;
wire csr_mdlmb_den;
wire [1:0] csr_mdlmb_eccen;
wire csr_mdlmb_rwecc;
wire [1:0] csr_mmisc_ctl_aces;
wire csr_mmisc_ctl_vec_plic;
wire csr_mmisc_ctl_rvcompm;
wire csr_mmisc_ctl_brpe;
wire csr_mmisc_ctl_una;
wire csr_mmisc_ctl_nbcache_en;
wire [1:0] fpu_status;
wire [31:0] csr_sstatus;
wire [31:0] csr_sie;
wire [31:0] csr_slie;
wire [31:0] csr_ipipe_slie;
wire [31:0] csr_sip;
wire [31:0] csr_slip;
wire [31:0] csr_ipipe_slip;
wire [31:0] csr_stvec;
wire [31:0] csr_sepc;
wire [31:0] csr_scause;
wire [31:0] csr_sdcause;
wire [31:0] csr_stval;
wire [31:0] csr_sscratch;
wire [31:0] csr_satp;
wire [31:0] csr_sedeleg;
wire csr_sedeleg_iam;
wire csr_sedeleg_iaf;
wire csr_sedeleg_ii;
wire csr_sedeleg_b;
wire csr_sedeleg_lam;
wire csr_sedeleg_laf;
wire csr_sedeleg_sam;
wire csr_sedeleg_saf;
wire csr_sedeleg_uec;
wire csr_sedeleg_ipf;
wire csr_sedeleg_lpf;
wire csr_sedeleg_spf;
wire [31:0] csr_sideleg;
wire [31:0] csr_rmw_sip;
wire [31:0] csr_smisc_ctl = {{26{1'b0}},csr_mmisc_ctl_aces,4'b0};
wire [PALEN - 1:12] csr_satp_ppn;
wire [3:0] csr_satp_mode;
wire [8:0] csr_satp_asid;
wire valid_satp_mode;
wire [31:0] csr_ustatus;
wire [31:0] csr_uie;
wire [31:0] csr_utvec;
wire [31:0] csr_uscratch;
wire [31:0] csr_uepc;
wire [31:0] csr_ucause;
wire [31:0] csr_utval;
wire [31:0] csr_uip;
reg csr_mip_meip;
reg csr_mip_mtip;
reg csr_mip_msip;
wire csr_mip_heip = 1'b0;
wire csr_mip_htip = 1'b0;
wire csr_mip_hsip = 1'b0;
wire csr_mip_seip;
wire csr_mip_stip;
wire csr_mip_ssip;
wire csr_mip_ueip;
wire csr_mip_utip;
wire csr_mip_usip;
reg csr_mip_sbe;
wire csr_mip_sbe_we;
wire csr_mip_sbe_nx;
wire csr_mip_hpmint;
wire csr_mip_slpecc;
wire csr_mip_aceerr;
wire csr_slip_sbe;
wire csr_slip_hpmint;
wire csr_slip_slpecc;
wire csr_slip_aceerr;
reg csr_mie_meie;
reg csr_mie_mtie;
reg csr_mie_msie;
wire csr_mie_slpecc;
wire csr_mie_aceerr;
wire csr_mie_hpmint;
reg csr_mie_sbe;
wire csr_slie_slpecc;
wire csr_slie_aceerr;
wire csr_slie_hpmint;
wire csr_slie_sbe;
wire csr_mie_heie = 1'b0;
wire csr_mie_htie = 1'b0;
wire csr_mie_hsie = 1'b0;
wire csr_mie_seie;
wire csr_mie_stie;
wire csr_mie_ssie;
wire csr_mie_ueie;
wire csr_mie_utie;
wire csr_mie_usie;
reg [VALEN - 1:2] csr_mtvec_addr;
reg [EXTVALEN - 1:1] reg_csr_mepc_addr;
wire [EXTVALEN - 1:1] reg_csr_mepc_addr_nx;
wire csr_mepc_addr_we;
wire csr_mtval_en;
reg [EXTVALEN - 1:0] reg_mtval_addr;
wire [EXTVALEN - 1:0] reg_mtval_addr_nx;
reg csr_mcause_interrupt;
reg [9:0] csr_mcause_code;
wire csr_mcause_interrupt_nx;
wire [9:0] csr_mcause_code_nx;
wire csr_mcause_en;
wire csr_mcache_ctl_ic_en;
wire csr_mcache_ctl_dc_en;
wire [1:0] csr_mcache_ctl_ic_eccen;
wire [1:0] csr_mcache_ctl_dc_eccen;
wire csr_mcache_ctl_ic_rwecc;
wire csr_mcache_ctl_dc_rwecc;
wire csr_mcache_ctl_cctl_suen;
wire csr_mcache_ctl_dc_first_word;
wire csr_mcache_ctl_iprefetch_en;
wire csr_mcache_ctl_ic_first_word;
wire [1:0] csr_mcache_ctl_l2c_waround;
wire csr_mcache_ctl_dc_cohen;
wire csr_mcache_ctl_dc_cohsta;
wire [1:0] csr_mstatus_sxl = (NUM_PRIVILEGE_LEVELS > 2) ? 2'd2 : 2'd0;
wire [1:0] csr_mstatus_uxl = (NUM_PRIVILEGE_LEVELS > 1) ? 2'd2 : 2'd0;
wire csr_mstatus_sum;
wire csr_mstatus_mxr;
wire csr_mstatus_tvm;
wire csr_mstatus_tw;
wire csr_mstatus_tsr;
wire csr_mstatus_mprv;
wire [1:0] csr_mstatus_xs = csr_mmisc_ctl_aces;
wire [1:0] csr_mstatus_fs = fpu_status;
wire csr_mstatus_sd = (csr_mstatus_xs == 2'b11 | csr_mstatus_fs == 2'b11);
wire [1:0] csr_mstatus_mpp;
wire [1:0] csr_mstatus_hpp = 2'd0;
wire csr_mstatus_spp;
reg csr_mstatus_mpie;
wire csr_mstatus_hpie = 1'd0;
wire csr_mstatus_spie;
wire csr_mstatus_upie;
reg csr_mstatus_mie;
wire csr_mstatus_hie = 1'd0;
wire csr_mstatus_sie;
wire csr_mstatus_uie;
wire csr_mstatus_mie_nx;
wire csr_mstatus_mie_en;
wire csr_mstatus_mpie_nx;
wire csr_mstatus_mpie_en;
wire [1:0] csr_dcsr_prv;
wire csr_dcsr_step;
wire csr_dcsr_mprven;
wire csr_dcsr_nmip = ipipe_csr_nmi_pending;
wire csr_dcsr_debugint;
wire [2:0] csr_dcsr_cause;
wire csr_dcsr_stoptime;
wire csr_dcsr_stopcount;
wire csr_dcsr_ebreakm;
wire csr_dcsr_ebreakh = 1'b0;
wire csr_dcsr_ebreaks;
wire csr_dcsr_ebreaku;
wire csr_dcsr_stepie;
wire [3:0] csr_dcsr_xdebugver = ((DEBUG_SUPPORT_INT == 1)) ? 4'd4 : 4'd0;
wire csr_tcontrol_mte;
wire csr_tcontrol_mpte;
wire [31:0] csr_tcontrol = {{24{1'b0}},csr_tcontrol_mpte,3'b000,csr_tcontrol_mte,3'b000};
wire csr_dexc2dbg_iam;
wire csr_dexc2dbg_iaf;
wire csr_dexc2dbg_ii;
wire csr_dexc2dbg_nmi;
wire csr_dexc2dbg_lam;
wire csr_dexc2dbg_laf;
wire csr_dexc2dbg_sam;
wire csr_dexc2dbg_saf;
wire csr_dexc2dbg_uec;
wire csr_dexc2dbg_sec;
wire csr_dexc2dbg_hec = 1'b0;
wire csr_dexc2dbg_mec;
wire csr_dexc2dbg_hsp;
wire csr_dexc2dbg_slpecc;
wire csr_dexc2dbg_sbe;
wire csr_dexc2dbg_ace;
wire csr_dexc2dbg_pmov;
wire csr_dexc2dbg_spf;
wire csr_dexc2dbg_lpf;
wire csr_dexc2dbg_ipf;
wire [3:0] csr_mpft_ctl_t_level;
wire csr_mpft_ctl_fast_int;
wire csr_mxstatus_pft_en;
wire csr_mxstatus_ppft_en;
wire csr_mxstatus_dme;
wire csr_mxstatus_pdme;
wire csr_mxstatus_ime;
wire csr_mxstatus_pime;
wire csr_mhsp_ctl_ovf_en;
wire csr_mhsp_ctl_udf_en;
wire csr_mhsp_ctl_schm;
wire csr_mhsp_ctl_u;
wire csr_mhsp_ctl_s;
wire csr_mhsp_ctl_m;
reg [2:0] reg_mdcause;
reg [1:0] reg_mdcause_pm;
wire reg_mdcause_en;
wire [2:0] reg_mdcause_nx;
wire [1:0] reg_mdcause_pm_nx;
wire [7:0] csr_ddcause_maintype;
wire [7:0] csr_ddcause_subtype;
wire [31:0] csr_wdata = ipipe_csr_req_wdata;
wire csr_ucode_ov;
wire [31:0] csr_ucode = {{31{1'b0}},csr_ucode_ov};
wire [31:0] csr_fflags;
wire [31:0] csr_frm;
wire [31:0] csr_fcsr;
wire [31:0] csr_mclk_ctl;
wire [31:0] csr_vstart;
wire [31:0] csr_vxsat;
wire [31:0] csr_vxrm;
wire [31:0] csr_vcsr = {32{1'b0}};
wire [31:0] csr_vl;
wire [31:0] csr_vtype;
wire [32:0] csr_vlenb = {33{1'b0}};
wire sel_wr_mscratch = (ipipe_csr_req_waddr == CSR12_MSCRATCH);
wire sel_wr_mie = (ipipe_csr_req_waddr == CSR12_MIE);
wire sel_wr_mip = (ipipe_csr_req_waddr == CSR12_MIP);
wire sel_wr_mstatus = (ipipe_csr_req_waddr == CSR12_MSTATUS);
wire sel_wr_mtvec = (ipipe_csr_req_waddr == CSR12_MTVEC);
wire sel_wr_mepc = (ipipe_csr_req_waddr == CSR12_MEPC);
wire sel_wr_mtval = (ipipe_csr_req_waddr == CSR12_MTVAL);
wire sel_wr_mcause = (ipipe_csr_req_waddr == CSR12_MCAUSE);
wire sel_wr_medeleg = (ipipe_csr_req_waddr == CSR12_MEDELEG) & ((NUM_PRIVILEGE_LEVELS > 2) | ((NUM_PRIVILEGE_LEVELS == 2) & ((RVN_SUPPORT_INT == 1))));
wire sel_wr_mideleg = (ipipe_csr_req_waddr == CSR12_MIDELEG) & ((NUM_PRIVILEGE_LEVELS > 2) | ((NUM_PRIVILEGE_LEVELS == 2) & ((RVN_SUPPORT_INT == 1))));
wire sel_wr_mslideleg = (ipipe_csr_req_waddr == CSR12_MSLIDELEG) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_wr_tselect = (ipipe_csr_req_waddr == CSR12_TSELECT);
wire sel_wr_tdata1 = (ipipe_csr_req_waddr == CSR12_TDATA1);
wire sel_wr_tdata2 = (ipipe_csr_req_waddr == CSR12_TDATA2);
wire sel_wr_tdata3 = (ipipe_csr_req_waddr == CSR12_TDATA3);
wire sel_wr_tcontrol = (ipipe_csr_req_waddr == CSR12_TCONTROL);
wire sel_wr_mcontext = (ipipe_csr_req_waddr == CSR12_MCONTEXT);
wire sel_wr_scontext = (ipipe_csr_req_waddr == CSR12_SCONTEXT);
wire sel_wr_dcsr = (ipipe_csr_req_waddr == CSR12_DCSR);
wire sel_wr_dpc = (ipipe_csr_req_waddr == CSR12_DPC);
wire sel_wr_dscratch0 = (ipipe_csr_req_waddr == CSR12_DSCRATCH0);
wire sel_wr_dscratch1 = (ipipe_csr_req_waddr == CSR12_DSCRATCH1);
wire sel_wr_mmisc_ctl = (ipipe_csr_req_waddr == CSR12_MMISC_CTL) & ((MMISC_CTL_EXIST_INT == 1));
wire sel_wr_mclk_ctl = (ipipe_csr_req_waddr == CSR12_MCLK_CTL) & ((FLEN != 1));
wire sel_wr_milmb = (ipipe_csr_req_waddr == CSR12_MILMB) & (ILM_SIZE_KB != 0);
wire sel_wr_mdlmb = (ipipe_csr_req_waddr == CSR12_MDLMB) & (DLM_SIZE_KB != 0);
wire sel_wr_dexc2dbg = (ipipe_csr_req_waddr == CSR12_DEXC2DBG);
wire sel_wr_mrandseq = 1'b0;
wire sel_wr_mrandseqh = 1'b0;
wire sel_wr_mrandstate = 1'b0;
wire sel_wr_mrandstateh = 1'b0;
wire sel_wr_mxstatus = (ipipe_csr_req_waddr == CSR12_MXSTATUS);
wire sel_wr_mpft_ctl = (ipipe_csr_req_waddr == CSR12_MPFT_CTL);
wire sel_wr_mdcause = (ipipe_csr_req_waddr == CSR12_MDCAUSE);
wire sel_wr_mhsp_ctl = (ipipe_csr_req_waddr == CSR12_MHSP_CTL) & (STACKSAFE_SUPPORT_INT == 1);
wire sel_wr_mhsp_bound = (ipipe_csr_req_waddr == CSR12_MHSP_BOUND) & (STACKSAFE_SUPPORT_INT == 1);
wire sel_wr_mhsp_base = (ipipe_csr_req_waddr == CSR12_MHSP_BASE) & (STACKSAFE_SUPPORT_INT == 1);
wire sel_wr_uitb = (ipipe_csr_req_waddr == CSR12_UITB);
wire sel_wr_ucode = (ipipe_csr_req_waddr == CSR12_UCODE) & ((DSP_SUPPORT_INT == 1));
wire sel_wr_udcause = (ipipe_csr_req_waddr == CSR12_UDCAUSE) & ((RVN_SUPPORT_INT == 1));
wire sel_wr_mcache_ctl = (ipipe_csr_req_waddr == CSR12_MCACHE_CTL) & (CACHE_SUPPORT_INT == 1);
wire sel_wr_mcctlcommand = (ipipe_csr_req_waddr == CSR12_MCCTLCOMMAND) & (CACHE_SUPPORT_INT == 1);
wire sel_wr_mcctldata = (ipipe_csr_req_waddr == CSR12_MCCTLDATA) & (CACHE_SUPPORT_INT == 1);
wire sel_wr_mcctlbeginaddr = (ipipe_csr_req_waddr == CSR12_MCCTLBEGINADDR) & (CACHE_SUPPORT_INT == 1);
wire sel_wr_ucctlcommand = (ipipe_csr_req_waddr == CSR12_UCCTLCOMMAND) & (CACHE_SUPPORT_INT == 1);
wire sel_wr_ucctlbeginaddr = (ipipe_csr_req_waddr == CSR12_UCCTLBEGINADDR) & (CACHE_SUPPORT_INT == 1);
wire sel_wr_scctldata = (ipipe_csr_req_waddr == CSR12_SCCTLDATA) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_wr_sstatus = (ipipe_csr_req_waddr == CSR12_SSTATUS) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_wr_sie = (ipipe_csr_req_waddr == CSR12_SIE) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_wr_slie = (ipipe_csr_req_waddr == CSR12_SLIE) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_wr_sip = (ipipe_csr_req_waddr == CSR12_SIP) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_wr_slip = (ipipe_csr_req_waddr == CSR12_SLIP) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_wr_sideleg = (ipipe_csr_req_waddr == CSR12_SIDELEG) & (NUM_PRIVILEGE_LEVELS > 2) & ((RVN_SUPPORT_INT == 1));
wire sel_wr_sedeleg = (ipipe_csr_req_waddr == CSR12_SEDELEG) & (NUM_PRIVILEGE_LEVELS > 2) & ((RVN_SUPPORT_INT == 1));
wire sel_wr_stvec = (ipipe_csr_req_waddr == CSR12_STVEC) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_wr_sepc = (ipipe_csr_req_waddr == CSR12_SEPC) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_wr_scause = (ipipe_csr_req_waddr == CSR12_SCAUSE) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_wr_sdcause = (ipipe_csr_req_waddr == CSR12_SDCAUSE) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_wr_stval = (ipipe_csr_req_waddr == CSR12_STVAL) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_wr_sscratch = (ipipe_csr_req_waddr == CSR12_SSCRATCH) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_wr_satp = (ipipe_csr_req_waddr == CSR12_SATP) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_wr_smisc_ctl = (ipipe_csr_req_waddr == CSR12_SMISC_CTL) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_wr_ustatus = (ipipe_csr_req_waddr == CSR12_USTATUS) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_wr_uie = (ipipe_csr_req_waddr == CSR12_UIE) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_wr_utvec = (ipipe_csr_req_waddr == CSR12_UTVEC) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_wr_uscratch = (ipipe_csr_req_waddr == CSR12_USCRATCH) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_wr_uepc = (ipipe_csr_req_waddr == CSR12_UEPC) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_wr_ucause = (ipipe_csr_req_waddr == CSR12_UCAUSE) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_wr_utval = (ipipe_csr_req_waddr == CSR12_UTVAL) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_wr_uip = (ipipe_csr_req_waddr == CSR12_UIP) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_wr_mecc_code = (ipipe_csr_req_waddr == CSR12_MECC_CODE) & (ECC_SUPPORT_INT == 1);
wire sel_wr_fflags = (ipipe_csr_req_waddr == CSR12_FFLAGS) & (FLEN != 1);
wire sel_wr_frm = (ipipe_csr_req_waddr == CSR12_FRM) & (FLEN != 1);
wire sel_wr_fcsr = (ipipe_csr_req_waddr == CSR12_FCSR) & (FLEN != 1);
wire csr_we = ipipe_csr_req_wr_valid & ~ipipe_csr_req_read_only;
wire csr_mscratch_we = csr_we & sel_wr_mscratch;
wire csr_mie_we = csr_we & sel_wr_mie;
wire csr_mip_we = csr_we & sel_wr_mip;
wire csr_mstatus_we = csr_we & sel_wr_mstatus;
wire csr_mtvec_we = csr_we & sel_wr_mtvec;
wire csr_mepc_we = csr_we & sel_wr_mepc;
wire csr_mtval_we = csr_we & sel_wr_mtval;
wire csr_mcause_we = csr_we & sel_wr_mcause;
wire csr_medeleg_we = csr_we & sel_wr_medeleg;
wire csr_mideleg_we = csr_we & sel_wr_mideleg;
wire csr_mslideleg_we = csr_we & sel_wr_mslideleg;
wire csr_tselect_we = csr_we & sel_wr_tselect;
wire csr_tdata1_we = csr_we & sel_wr_tdata1;
wire csr_tdata2_we = csr_we & sel_wr_tdata2;
wire csr_tdata3_we = csr_we & sel_wr_tdata3;
wire csr_tcontrol_we = csr_we & sel_wr_tcontrol;
wire csr_mcontext_we = csr_we & sel_wr_mcontext;
wire csr_scontext_we = csr_we & sel_wr_scontext;
wire csr_dcsr_we = csr_we & sel_wr_dcsr;
wire csr_dpc_we = csr_we & sel_wr_dpc;
wire csr_dscratch0_we = csr_we & sel_wr_dscratch0;
wire csr_dscratch1_we = csr_we & sel_wr_dscratch1;
wire csr_mmisc_ctl_we = csr_we & sel_wr_mmisc_ctl;
wire csr_milmb_we = csr_we & sel_wr_milmb;
wire csr_mdlmb_we = csr_we & sel_wr_mdlmb;
wire csr_mecc_code_we = csr_we & sel_wr_mecc_code;
wire csr_dexc2dbg_we = csr_we & sel_wr_dexc2dbg;
wire csr_mrandseq_we = csr_we & sel_wr_mrandseq;
wire csr_mrandseqh_we = csr_we & sel_wr_mrandseqh;
wire csr_mrandstate_we = csr_we & sel_wr_mrandstate;
wire csr_mrandstateh_we = csr_we & sel_wr_mrandstateh;
wire csr_mxstatus_we = csr_we & sel_wr_mxstatus;
wire csr_mpft_ctl_we = csr_we & sel_wr_mpft_ctl;
wire csr_mdcause_we = csr_we & sel_wr_mdcause;
wire csr_mhsp_ctl_we = csr_we & sel_wr_mhsp_ctl;
wire csr_mhsp_bound_we = csr_we & sel_wr_mhsp_bound;
wire csr_mhsp_base_we = csr_we & sel_wr_mhsp_base;
wire csr_uitb_we = csr_we & sel_wr_uitb;
wire csr_ucode_we = csr_we & sel_wr_ucode;
wire csr_udcause_we = csr_we & sel_wr_udcause;
wire csr_mcache_ctl_we = csr_we & sel_wr_mcache_ctl;
wire csr_mcctlcommand_we = csr_we & sel_wr_mcctlcommand;
wire csr_mcctldata_we = csr_we & sel_wr_mcctldata;
wire csr_mcctlbeginaddr_we = csr_we & sel_wr_mcctlbeginaddr;
wire csr_ucctlcommand_we = csr_we & sel_wr_ucctlcommand;
wire csr_ucctlbeginaddr_we = csr_we & sel_wr_ucctlbeginaddr;
wire csr_scctldata_we = csr_we & sel_wr_scctldata;
wire csr_sstatus_we = csr_we & sel_wr_sstatus;
wire csr_sie_we = csr_we & sel_wr_sie;
wire csr_slie_we = csr_we & sel_wr_slie;
wire csr_sip_we = csr_we & sel_wr_sip;
wire csr_slip_we = csr_we & sel_wr_slip;
wire csr_sideleg_we = csr_we & sel_wr_sideleg;
wire csr_sedeleg_we = csr_we & sel_wr_sedeleg;
wire csr_stvec_we = csr_we & sel_wr_stvec;
wire csr_sepc_we = csr_we & sel_wr_sepc;
wire csr_scause_we = csr_we & sel_wr_scause;
wire csr_sdcause_we = csr_we & sel_wr_sdcause;
wire csr_stval_we = csr_we & sel_wr_stval;
wire csr_sscratch_we = csr_we & sel_wr_sscratch;
wire csr_satp_we = csr_we & sel_wr_satp & valid_satp_mode;
wire csr_smisc_ctl_we = csr_we & sel_wr_smisc_ctl;
wire csr_ustatus_we = csr_we & sel_wr_ustatus;
wire csr_uie_we = csr_we & sel_wr_uie;
wire csr_utvec_we = csr_we & sel_wr_utvec;
wire csr_uscratch_we = csr_we & sel_wr_uscratch;
wire csr_uepc_we = csr_we & sel_wr_uepc;
wire csr_ucause_we = csr_we & sel_wr_ucause;
wire csr_utval_we = csr_we & sel_wr_utval;
wire csr_uip_we = csr_we & sel_wr_uip;
wire csr_fflags_we = csr_we & sel_wr_fflags;
wire csr_frm_we = csr_we & sel_wr_frm;
wire csr_fcsr_we = csr_we & sel_wr_fcsr;
wire sel_rd_mvendorid = (ipipe_csr_req_raddr == CSR12_MVENDORID);
wire sel_rd_marchid = (ipipe_csr_req_raddr == CSR12_MARCHID);
wire sel_rd_mimpid = (ipipe_csr_req_raddr == CSR12_MIMPID);
wire sel_rd_mhartid = (ipipe_csr_req_raddr == CSR12_MHARTID);
wire sel_rd_mstatus = (ipipe_csr_req_raddr == CSR12_MSTATUS);
wire sel_rd_misa = (ipipe_csr_req_raddr == CSR12_MISA);
wire sel_rd_medeleg = (ipipe_csr_req_raddr == CSR12_MEDELEG) & ((NUM_PRIVILEGE_LEVELS > 2) | ((NUM_PRIVILEGE_LEVELS == 2) & ((RVN_SUPPORT_INT == 1))));
wire sel_rd_mideleg = (ipipe_csr_req_raddr == CSR12_MIDELEG) & ((NUM_PRIVILEGE_LEVELS > 2) | ((NUM_PRIVILEGE_LEVELS == 2) & ((RVN_SUPPORT_INT == 1))));
wire sel_rd_mslideleg = (ipipe_csr_req_raddr == CSR12_MSLIDELEG) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_rd_mie = (ipipe_csr_req_raddr == CSR12_MIE);
wire sel_rd_mtvec = (ipipe_csr_req_raddr == CSR12_MTVEC);
wire sel_rd_scctldata = (ipipe_csr_req_raddr == CSR12_SCCTLDATA) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_rd_mscratch = (ipipe_csr_req_raddr == CSR12_MSCRATCH);
wire sel_rd_mepc = (ipipe_csr_req_raddr == CSR12_MEPC);
wire sel_rd_mcause = (ipipe_csr_req_raddr == CSR12_MCAUSE);
wire sel_rd_mtval = (ipipe_csr_req_raddr == CSR12_MTVAL);
wire sel_rd_mip = (ipipe_csr_req_raddr == CSR12_MIP);
wire sel_rd_tselect = (ipipe_csr_req_raddr == CSR12_TSELECT);
wire sel_rd_tdata1 = (ipipe_csr_req_raddr == CSR12_TDATA1);
wire sel_rd_tdata2 = (ipipe_csr_req_raddr == CSR12_TDATA2);
wire sel_rd_tdata3 = (ipipe_csr_req_raddr == CSR12_TDATA3);
wire sel_rd_tinfo = (ipipe_csr_req_raddr == CSR12_TINFO);
wire sel_rd_tcontrol = (ipipe_csr_req_raddr == CSR12_TCONTROL);
wire sel_rd_mcontext = (ipipe_csr_req_raddr == CSR12_MCONTEXT);
wire sel_rd_scontext = (ipipe_csr_req_raddr == CSR12_SCONTEXT);
wire sel_rd_dcsr = (ipipe_csr_req_raddr == CSR12_DCSR);
wire sel_rd_dpc = (ipipe_csr_req_raddr == CSR12_DPC);
wire sel_rd_dscratch0 = (ipipe_csr_req_raddr == CSR12_DSCRATCH0);
wire sel_rd_dscratch1 = (ipipe_csr_req_raddr == CSR12_DSCRATCH1);
wire sel_rd_micm_cfg = (ipipe_csr_req_raddr == CSR12_MICM_CFG);
wire sel_rd_mdcm_cfg = (ipipe_csr_req_raddr == CSR12_MDCM_CFG);
wire sel_rd_mmsc_cfg = (ipipe_csr_req_raddr == CSR12_MMSC_CFG);
wire sel_rd_mmsc_cfg2 = (ipipe_csr_req_raddr == CSR12_MMSC_CFG2) & ((MMSC_CFG2_EXIST_INT == 1));
wire sel_rd_ml2c_ctl_base = (ipipe_csr_req_raddr == CSR12_ML2C_CTL_BASE) & (L2C_CACHE_SIZE_KB != 0);
wire sel_rd_mmisc_ctl = (ipipe_csr_req_raddr == CSR12_MMISC_CTL) & ((MMISC_CTL_EXIST_INT == 1));
wire sel_rd_mclk_ctl = (ipipe_csr_req_raddr == CSR12_MCLK_CTL) & ((FLEN != 1));
wire sel_rd_milmb = (ipipe_csr_req_raddr == CSR12_MILMB) & (ILM_SIZE_KB != 0);
wire sel_rd_mdlmb = (ipipe_csr_req_raddr == CSR12_MDLMB) & (DLM_SIZE_KB != 0);
wire sel_rd_mecc_code = (ipipe_csr_req_raddr == CSR12_MECC_CODE) & (ECC_SUPPORT_INT == 1);
wire sel_rd_mnvec = (ipipe_csr_req_raddr == CSR12_MNVEC);
wire sel_rd_mxstatus = (ipipe_csr_req_raddr == CSR12_MXSTATUS);
wire sel_rd_mpft_ctl = (ipipe_csr_req_raddr == CSR12_MPFT_CTL);
wire sel_rd_mdcause = (ipipe_csr_req_raddr == CSR12_MDCAUSE);
wire sel_rd_mcache_ctl = (ipipe_csr_req_raddr == CSR12_MCACHE_CTL) & (CACHE_SUPPORT_INT == 1);
wire sel_rd_mcctlbeginaddr = (ipipe_csr_req_raddr == CSR12_MCCTLBEGINADDR) & (CACHE_SUPPORT_INT == 1);
wire sel_rd_mcctlcommand = (ipipe_csr_req_raddr == CSR12_MCCTLCOMMAND) & (CACHE_SUPPORT_INT == 1);
wire sel_rd_mcctldata = (ipipe_csr_req_raddr == CSR12_MCCTLDATA) & (CACHE_SUPPORT_INT == 1);
wire sel_rd_mhsp_ctl = (ipipe_csr_req_raddr == CSR12_MHSP_CTL) & (STACKSAFE_SUPPORT_INT == 1);
wire sel_rd_mhsp_bound = (ipipe_csr_req_raddr == CSR12_MHSP_BOUND) & (STACKSAFE_SUPPORT_INT == 1);
wire sel_rd_mhsp_base = (ipipe_csr_req_raddr == CSR12_MHSP_BASE) & (STACKSAFE_SUPPORT_INT == 1);
wire sel_rd_uitb = (ipipe_csr_req_raddr == CSR12_UITB);
wire sel_rd_udcause = (ipipe_csr_req_raddr == CSR12_UDCAUSE) & ((RVN_SUPPORT_INT == 1));
wire sel_rd_ucode = (ipipe_csr_req_raddr == CSR12_UCODE) & ((DSP_SUPPORT_INT == 1));
wire sel_rd_ucctlbeginaddr = (ipipe_csr_req_raddr == CSR12_UCCTLBEGINADDR) & (CACHE_SUPPORT_INT == 1);
wire sel_rd_ucctlcommand = (ipipe_csr_req_raddr == CSR12_UCCTLCOMMAND) & (CACHE_SUPPORT_INT == 1);
wire sel_rd_dexc2dbg = (ipipe_csr_req_raddr == CSR12_DEXC2DBG);
wire sel_rd_ddcause = (ipipe_csr_req_raddr == CSR12_DDCAUSE);
wire sel_prob_rd_mvendorid = (csr_prob_raddr == CSR12_MVENDORID);
wire sel_prob_rd_marchid = (csr_prob_raddr == CSR12_MARCHID);
wire sel_prob_rd_mimpid = (csr_prob_raddr == CSR12_MIMPID);
wire sel_prob_rd_mhartid = (csr_prob_raddr == CSR12_MHARTID);
wire sel_prob_rd_mstatus = (csr_prob_raddr == CSR12_MSTATUS);
wire sel_prob_rd_misa = (csr_prob_raddr == CSR12_MISA);
wire sel_prob_rd_medeleg = (csr_prob_raddr == CSR12_MEDELEG) & ((NUM_PRIVILEGE_LEVELS > 2) | ((NUM_PRIVILEGE_LEVELS == 2) & ((RVN_SUPPORT_INT == 1))));
wire sel_prob_rd_mideleg = (csr_prob_raddr == CSR12_MIDELEG) & ((NUM_PRIVILEGE_LEVELS > 2) | ((NUM_PRIVILEGE_LEVELS == 2) & ((RVN_SUPPORT_INT == 1))));
wire sel_prob_rd_mslideleg = (csr_prob_raddr == CSR12_MSLIDELEG) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_prob_rd_mie = (csr_prob_raddr == CSR12_MIE);
wire sel_prob_rd_mtvec = (csr_prob_raddr == CSR12_MTVEC);
wire sel_prob_rd_scctldata = (csr_prob_raddr == CSR12_SCCTLDATA) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_prob_rd_mscratch = (csr_prob_raddr == CSR12_MSCRATCH);
wire sel_prob_rd_mepc = (csr_prob_raddr == CSR12_MEPC);
wire sel_prob_rd_mcause = (csr_prob_raddr == CSR12_MCAUSE);
wire sel_prob_rd_mtval = (csr_prob_raddr == CSR12_MTVAL);
wire sel_prob_rd_mip = (csr_prob_raddr == CSR12_MIP);
wire sel_prob_rd_tselect = (csr_prob_raddr == CSR12_TSELECT);
wire sel_prob_rd_tdata1 = (csr_prob_raddr == CSR12_TDATA1);
wire sel_prob_rd_tdata2 = (csr_prob_raddr == CSR12_TDATA2);
wire sel_prob_rd_tdata3 = (csr_prob_raddr == CSR12_TDATA3);
wire sel_prob_rd_tinfo = (csr_prob_raddr == CSR12_TINFO);
wire sel_prob_rd_tcontrol = (csr_prob_raddr == CSR12_TCONTROL);
wire sel_prob_rd_mcontext = (csr_prob_raddr == CSR12_MCONTEXT);
wire sel_prob_rd_scontext = (csr_prob_raddr == CSR12_SCONTEXT);
wire sel_prob_rd_dcsr = (csr_prob_raddr == CSR12_DCSR);
wire sel_prob_rd_dpc = (csr_prob_raddr == CSR12_DPC);
wire sel_prob_rd_dscratch0 = (csr_prob_raddr == CSR12_DSCRATCH0);
wire sel_prob_rd_dscratch1 = (csr_prob_raddr == CSR12_DSCRATCH1);
wire sel_prob_rd_micm_cfg = (csr_prob_raddr == CSR12_MICM_CFG);
wire sel_prob_rd_mdcm_cfg = (csr_prob_raddr == CSR12_MDCM_CFG);
wire sel_prob_rd_mmsc_cfg = (csr_prob_raddr == CSR12_MMSC_CFG);
wire sel_prob_rd_mmsc_cfg2 = (csr_prob_raddr == CSR12_MMSC_CFG2) & ((MMSC_CFG2_EXIST_INT == 1));
wire sel_prob_rd_mmisc_ctl = (csr_prob_raddr == CSR12_MMISC_CTL) & ((MMISC_CTL_EXIST_INT == 1));
wire sel_prob_rd_mclk_ctl = (csr_prob_raddr == CSR12_MCLK_CTL) & ((FLEN != 1));
wire sel_prob_rd_milmb = (csr_prob_raddr == CSR12_MILMB) & (ILM_SIZE_KB != 0);
wire sel_prob_rd_mdlmb = (csr_prob_raddr == CSR12_MDLMB) & (DLM_SIZE_KB != 0);
wire sel_prob_rd_mecc_code = (csr_prob_raddr == CSR12_MECC_CODE) & (ECC_SUPPORT_INT == 1);
wire sel_prob_rd_mnvec = (csr_prob_raddr == CSR12_MNVEC);
wire sel_prob_rd_mxstatus = (csr_prob_raddr == CSR12_MXSTATUS);
wire sel_prob_rd_mpft_ctl = (csr_prob_raddr == CSR12_MPFT_CTL);
wire sel_prob_rd_mdcause = (csr_prob_raddr == CSR12_MDCAUSE);
wire sel_prob_rd_mcache_ctl = (csr_prob_raddr == CSR12_MCACHE_CTL) & (CACHE_SUPPORT_INT == 1);
wire sel_prob_rd_mcctlbeginaddr = (csr_prob_raddr == CSR12_MCCTLBEGINADDR) & (CACHE_SUPPORT_INT == 1);
wire sel_prob_rd_mcctlcommand = (csr_prob_raddr == CSR12_MCCTLCOMMAND) & (CACHE_SUPPORT_INT == 1);
wire sel_prob_rd_mcctldata = (csr_prob_raddr == CSR12_MCCTLDATA) & (CACHE_SUPPORT_INT == 1);
wire sel_prob_rd_mhsp_ctl = (csr_prob_raddr == CSR12_MHSP_CTL) & (STACKSAFE_SUPPORT_INT == 1);
wire sel_prob_rd_mhsp_bound = (csr_prob_raddr == CSR12_MHSP_BOUND) & (STACKSAFE_SUPPORT_INT == 1);
wire sel_prob_rd_mhsp_base = (csr_prob_raddr == CSR12_MHSP_BASE) & (STACKSAFE_SUPPORT_INT == 1);
wire sel_prob_rd_uitb = (csr_prob_raddr == CSR12_UITB);
wire sel_prob_rd_udcause = (csr_prob_raddr == CSR12_UDCAUSE) & ((RVN_SUPPORT_INT == 1));
wire sel_prob_rd_ucode = (csr_prob_raddr == CSR12_UCODE) & ((DSP_SUPPORT_INT == 1));
wire sel_prob_rd_ucctlbeginaddr = (csr_prob_raddr == CSR12_UCCTLBEGINADDR) & (CACHE_SUPPORT_INT == 1);
wire sel_prob_rd_ucctlcommand = (csr_prob_raddr == CSR12_UCCTLCOMMAND) & (CACHE_SUPPORT_INT == 1);
wire sel_prob_rd_dexc2dbg = (csr_prob_raddr == CSR12_DEXC2DBG);
wire sel_prob_rd_ddcause = (csr_prob_raddr == CSR12_DDCAUSE);
wire sel_rd_mrandseq = 1'b0;
wire sel_rd_mrandseqh = 1'b0;
wire sel_rd_mrandstate = 1'b0;
wire sel_rd_mrandstateh = 1'b0;
wire sel_prob_rd_mrandseq = 1'b0;
wire sel_prob_rd_mrandseqh = 1'b0;
wire sel_prob_rd_mrandstate = 1'b0;
wire sel_prob_rd_mrandstateh = 1'b0;
wire csr_rmw_mip_seip;
wire csr_rmw_mip_ueip;
wire sel_rd_sstatus = (ipipe_csr_req_raddr == CSR12_SSTATUS) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_rd_sie = (ipipe_csr_req_raddr == CSR12_SIE) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_rd_slie = (ipipe_csr_req_raddr == CSR12_SLIE) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_rd_sip = (ipipe_csr_req_raddr == CSR12_SIP) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_rd_slip = (ipipe_csr_req_raddr == CSR12_SLIP) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_rd_sideleg = (ipipe_csr_req_raddr == CSR12_SIDELEG) & (NUM_PRIVILEGE_LEVELS > 2) & ((RVN_SUPPORT_INT == 1));
wire sel_rd_sedeleg = (ipipe_csr_req_raddr == CSR12_SEDELEG) & (NUM_PRIVILEGE_LEVELS > 2) & ((RVN_SUPPORT_INT == 1));
wire sel_rd_stvec = (ipipe_csr_req_raddr == CSR12_STVEC) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_rd_sepc = (ipipe_csr_req_raddr == CSR12_SEPC) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_rd_scause = (ipipe_csr_req_raddr == CSR12_SCAUSE) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_rd_sdcause = (ipipe_csr_req_raddr == CSR12_SDCAUSE) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_rd_stval = (ipipe_csr_req_raddr == CSR12_STVAL) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_rd_sscratch = (ipipe_csr_req_raddr == CSR12_SSCRATCH) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_rd_satp = (ipipe_csr_req_raddr == CSR12_SATP) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_rd_smisc_ctl = (ipipe_csr_req_raddr == CSR12_SMISC_CTL) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_rd_ustatus = (ipipe_csr_req_raddr == CSR12_USTATUS) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_rd_uie = (ipipe_csr_req_raddr == CSR12_UIE) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_rd_utvec = (ipipe_csr_req_raddr == CSR12_UTVEC) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_rd_uscratch = (ipipe_csr_req_raddr == CSR12_USCRATCH) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_rd_uepc = (ipipe_csr_req_raddr == CSR12_UEPC) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_rd_ucause = (ipipe_csr_req_raddr == CSR12_UCAUSE) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_rd_utval = (ipipe_csr_req_raddr == CSR12_UTVAL) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_rd_uip = (ipipe_csr_req_raddr == CSR12_UIP) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_rd_fflags = (ipipe_csr_req_raddr == CSR12_FFLAGS) & (FLEN != 1);
wire sel_rd_frm = (ipipe_csr_req_raddr == CSR12_FRM) & (FLEN != 1);
wire sel_rd_fcsr = (ipipe_csr_req_raddr == CSR12_FCSR) & (FLEN != 1);
wire sel_rd_vstart = 1'b0;
wire sel_rd_vxsat = 1'b0;
wire sel_rd_vxrm = 1'b0;
wire sel_rd_vcsr = 1'b0;
wire sel_rd_vl = 1'b0;
wire sel_rd_vtype = 1'b0;
wire sel_rd_vlenb = 1'b0;
wire sel_prob_rd_sstatus = (csr_prob_raddr == CSR12_SSTATUS) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_prob_rd_sie = (csr_prob_raddr == CSR12_SIE) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_prob_rd_slie = (csr_prob_raddr == CSR12_SLIE) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_prob_rd_sip = (csr_prob_raddr == CSR12_SIP) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_prob_rd_slip = (csr_prob_raddr == CSR12_SLIP) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_prob_rd_sideleg = (csr_prob_raddr == CSR12_SIDELEG) & (NUM_PRIVILEGE_LEVELS > 2) & ((RVN_SUPPORT_INT == 1));
wire sel_prob_rd_sedeleg = (csr_prob_raddr == CSR12_SEDELEG) & (NUM_PRIVILEGE_LEVELS > 2) & ((RVN_SUPPORT_INT == 1));
wire sel_prob_rd_stvec = (csr_prob_raddr == CSR12_STVEC) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_prob_rd_sepc = (csr_prob_raddr == CSR12_SEPC) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_prob_rd_scause = (csr_prob_raddr == CSR12_SCAUSE) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_prob_rd_sdcause = (csr_prob_raddr == CSR12_SDCAUSE) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_prob_rd_stval = (csr_prob_raddr == CSR12_STVAL) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_prob_rd_sscratch = (csr_prob_raddr == CSR12_SSCRATCH) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_prob_rd_satp = (csr_prob_raddr == CSR12_SATP) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_prob_rd_smisc_ctl = (csr_prob_raddr == CSR12_SMISC_CTL) & (NUM_PRIVILEGE_LEVELS > 2);
wire sel_prob_rd_ustatus = (csr_prob_raddr == CSR12_USTATUS) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_prob_rd_uie = (csr_prob_raddr == CSR12_UIE) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_prob_rd_utvec = (csr_prob_raddr == CSR12_UTVEC) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_prob_rd_uscratch = (csr_prob_raddr == CSR12_USCRATCH) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_prob_rd_uepc = (csr_prob_raddr == CSR12_UEPC) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_prob_rd_ucause = (csr_prob_raddr == CSR12_UCAUSE) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_prob_rd_utval = (csr_prob_raddr == CSR12_UTVAL) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_prob_rd_uip = (csr_prob_raddr == CSR12_UIP) & (NUM_PRIVILEGE_LEVELS > 1);
wire sel_prob_rd_fflags = (csr_prob_raddr == CSR12_FFLAGS) & (FLEN != 1);
wire sel_prob_rd_frm = (csr_prob_raddr == CSR12_FRM) & (FLEN != 1);
wire sel_prob_rd_fcsr = (csr_prob_raddr == CSR12_FCSR) & (FLEN != 1);
wire ipipe_csr_m_slpecc_set;
wire ipipe_csr_s_slpecc_set;
assign csr_trap_delegated = trap_handled_by_s_mode | trap_handled_by_u_mode;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        csr_mmu_satp_we <= 1'b0;
    end
    else begin
        csr_mmu_satp_we <= csr_satp_we;
    end
end

wire sel_rd_pfm_csr;
wire sel_prob_rd_pfm_csr;
wire [31:0] csr_pfm_rdata;
wire [31:0] csr_prob_pfm_rdata;
wire hpm_m_counter_ovf;
wire hpm_s_counter_ovf;
assign csr_misa[31:30] = 2'd1;
assign csr_misa[29:26] = {4{1'b0}};
assign csr_misa[25:24] = 2'd0;
assign csr_misa[23] = 1'b1;
assign csr_misa[22] = 1'd0;
assign csr_misa[21] = 1'b0;
assign csr_misa[20] = (NUM_PRIVILEGE_LEVELS > 1);
assign csr_misa[19] = 1'd0;
assign csr_misa[18] = (NUM_PRIVILEGE_LEVELS > 2);
assign csr_misa[17:14] = 4'b0;
assign csr_misa[13] = ((RVN_SUPPORT_INT == 1));
assign csr_misa[12] = 1'b1;
assign csr_misa[11:9] = 3'd0;
assign csr_misa[8] = 1'b1;
assign csr_misa[7:6] = 2'd0;
assign csr_misa[5] = (FLEN != 1);
assign csr_misa[4] = 1'b0;
assign csr_misa[3] = (FLEN >= 64);
assign csr_misa[2] = 1'b1;
assign csr_misa[1] = 1'b0;
assign csr_misa[0] = (RVA_SUPPORT_INT == 1);
assign csr_mslideleg = {{(32 - LOCALINT_SLPECC - 1){1'b0}},csr_mslideleg_slpecc,{LOCALINT_SLPECC{1'b0}}} | {{(32 - LOCALINT_SBE - 1){1'b0}},csr_mslideleg_sbe,{LOCALINT_SBE{1'b0}}} | {{(32 - LOCALINT_HPMINT - 1){1'b0}},csr_mslideleg_hpmint,{LOCALINT_HPMINT{1'b0}}} | {{(32 - LOCALINT_ACEERR - 1){1'b0}},csr_mslideleg_aceerr,{LOCALINT_ACEERR{1'b0}}};
assign csr_mip = {{20{1'b0}},csr_mip_meip,csr_mip_heip,csr_mip_seip,csr_mip_ueip,csr_mip_mtip,csr_mip_htip,csr_mip_stip,csr_mip_utip,csr_mip_msip,csr_mip_hsip,csr_mip_ssip,csr_mip_usip} | {{(32 - LOCALINT_ACEERR - 1){1'b0}},csr_mip_aceerr,{LOCALINT_ACEERR{1'b0}}} | {{(32 - LOCALINT_SLPECC - 1){1'b0}},csr_mip_slpecc,{LOCALINT_SLPECC{1'b0}}} | {{(32 - LOCALINT_HPMINT - 1){1'b0}},csr_mip_hpmint,{LOCALINT_HPMINT{1'b0}}} | {{(32 - LOCALINT_SBE - 1){1'b0}},csr_mip_sbe,{LOCALINT_SBE{1'b0}}};
assign csr_sip = {{20{1'b0}},1'b0,1'b0,(csr_mip_seip & csr_mideleg[9]),(csr_mip_ueip & csr_mideleg[8]),1'b0,1'b0,(csr_mip_stip & csr_mideleg[5]),(csr_mip_utip & csr_mideleg[4]),1'b0,1'b0,(csr_mip_ssip & csr_mideleg[1]),(csr_mip_usip & csr_mideleg[0])};
assign csr_uip = {{20{1'b0}},1'b0,1'b0,1'b0,(csr_mip_ueip & csr_mideleg[8] & csr_sideleg[8]),1'b0,1'b0,1'b0,(csr_mip_utip & csr_mideleg[4] & csr_sideleg[4]),1'b0,1'b0,1'b0,(csr_mip_usip & csr_mideleg[0] & csr_sideleg[0])};
assign csr_rmw_mip = {{20{1'b0}},csr_mip_meip,csr_mip_heip,csr_rmw_mip_seip,csr_rmw_mip_ueip,csr_mip_mtip,csr_mip_htip,csr_mip_stip,csr_mip_utip,csr_mip_msip,csr_mip_hsip,csr_mip_ssip,csr_mip_usip} | {{(32 - LOCALINT_ACEERR - 1){1'b0}},csr_mip_aceerr,{LOCALINT_ACEERR{1'b0}}} | {{(32 - LOCALINT_SLPECC - 1){1'b0}},csr_mip_slpecc,{LOCALINT_SLPECC{1'b0}}} | {{(32 - LOCALINT_HPMINT - 1){1'b0}},csr_mip_hpmint,{LOCALINT_HPMINT{1'b0}}} | {{(32 - LOCALINT_SBE - 1){1'b0}},csr_mip_sbe,{LOCALINT_SBE{1'b0}}};
assign csr_rmw_sip = {{20{1'b0}},1'b0,1'b0,(csr_rmw_mip_seip & csr_mideleg[9]),(csr_rmw_mip_ueip & csr_mideleg[8]),1'b0,1'b0,(csr_mip_stip & csr_mideleg[5]),(csr_mip_utip & csr_mideleg[4]),1'b0,1'b0,(csr_mip_ssip & csr_mideleg[1]),(csr_mip_usip & csr_mideleg[0])};
wire csr_slip_slpecc_read_en;
wire csr_slip_aceerr_read_en;
wire csr_slip_hpmint_read_en;
wire csr_slip_sbe_read_en;
wire csr_slie_slpecc_read_en;
wire csr_slie_aceerr_read_en;
wire csr_slie_hpmint_read_en;
wire csr_slie_sbe_read_en;
assign csr_slip_aceerr_read_en = (csr_mslideleg[LOCALINT_ACEERR] & cur_privilege_s) | cur_privilege_m;
assign csr_slip_slpecc_read_en = (csr_mslideleg[LOCALINT_SLPECC] & cur_privilege_s) | cur_privilege_m;
assign csr_slip_hpmint_read_en = (csr_mslideleg[LOCALINT_HPMINT] & cur_privilege_s) | cur_privilege_m;
assign csr_slip_sbe_read_en = (csr_mslideleg[LOCALINT_SBE] & cur_privilege_s) | cur_privilege_m;
assign csr_slie_aceerr_read_en = csr_slip_aceerr_read_en;
assign csr_slie_slpecc_read_en = csr_slip_slpecc_read_en;
assign csr_slie_hpmint_read_en = csr_slip_hpmint_read_en;
assign csr_slie_sbe_read_en = csr_slip_sbe_read_en;
assign csr_slip = {{(32 - LOCALINT_SLPECC - 1){1'b0}},(csr_slip_slpecc & csr_slip_slpecc_read_en),{LOCALINT_SLPECC{1'b0}}} | {{(32 - LOCALINT_ACEERR - 1){1'b0}},(csr_slip_aceerr & csr_slip_aceerr_read_en),{LOCALINT_ACEERR{1'b0}}} | {{(32 - LOCALINT_HPMINT - 1){1'b0}},(csr_slip_hpmint & csr_slip_hpmint_read_en),{LOCALINT_HPMINT{1'b0}}} | {{(32 - LOCALINT_SBE - 1){1'b0}},(csr_slip_sbe & csr_slip_sbe_read_en),{LOCALINT_SBE{1'b0}}};
assign csr_ipipe_slip = {{(32 - LOCALINT_SLPECC - 1){1'b0}},csr_slip_slpecc,{LOCALINT_SLPECC{1'b0}}} | {{(32 - LOCALINT_ACEERR - 1){1'b0}},csr_slip_aceerr,{LOCALINT_ACEERR{1'b0}}} | {{(32 - LOCALINT_HPMINT - 1){1'b0}},csr_slip_hpmint,{LOCALINT_HPMINT{1'b0}}} | {{(32 - LOCALINT_SBE - 1){1'b0}},csr_slip_sbe,{LOCALINT_SBE{1'b0}}};
assign csr_mie = {{20{1'b0}},csr_mie_meie,csr_mie_heie,csr_mie_seie,csr_mie_ueie,csr_mie_mtie,csr_mie_htie,csr_mie_stie,csr_mie_utie,csr_mie_msie,csr_mie_hsie,csr_mie_ssie,csr_mie_usie} | {{(32 - LOCALINT_SLPECC - 1){1'b0}},csr_mie_slpecc,{LOCALINT_SLPECC{1'b0}}} | {{(32 - LOCALINT_ACEERR - 1){1'b0}},csr_mie_aceerr,{LOCALINT_ACEERR{1'b0}}} | {{(32 - LOCALINT_HPMINT - 1){1'b0}},csr_mie_hpmint,{LOCALINT_HPMINT{1'b0}}} | {{(32 - LOCALINT_SBE - 1){1'b0}},csr_mie_sbe,{LOCALINT_SBE{1'b0}}};
assign csr_sie = {{20{1'b0}},1'b0,1'b0,(csr_mie_seie & csr_mideleg[9]),(csr_mie_ueie & csr_mideleg[8]),1'b0,1'b0,(csr_mie_stie & csr_mideleg[5]),(csr_mie_utie & csr_mideleg[4]),1'b0,1'b0,(csr_mie_ssie & csr_mideleg[1]),(csr_mie_usie & csr_mideleg[0])};
assign csr_uie = {{20{1'b0}},1'b0,1'b0,1'b0,(csr_mie_ueie & csr_mideleg[8] & csr_sideleg[8]),1'b0,1'b0,1'b0,(csr_mie_utie & csr_mideleg[4] & csr_sideleg[4]),1'b0,1'b0,1'b0,(csr_mie_usie & csr_mideleg[0] & csr_sideleg[0])};
assign csr_slie = {{(32 - LOCALINT_SLPECC - 1){1'b0}},(csr_slie_slpecc & csr_slie_slpecc_read_en),{LOCALINT_SLPECC{1'b0}}} | {{(32 - LOCALINT_ACEERR - 1){1'b0}},(csr_slie_aceerr & csr_slie_aceerr_read_en),{LOCALINT_ACEERR{1'b0}}} | {{(32 - LOCALINT_HPMINT - 1){1'b0}},(csr_slie_hpmint & csr_slie_hpmint_read_en),{LOCALINT_HPMINT{1'b0}}} | {{(32 - LOCALINT_SBE - 1){1'b0}},(csr_slie_sbe & csr_slie_sbe_read_en),{LOCALINT_SBE{1'b0}}};
assign csr_ipipe_slie = {{(32 - LOCALINT_SLPECC - 1){1'b0}},csr_slie_slpecc,{LOCALINT_SLPECC{1'b0}}} | {{(32 - LOCALINT_ACEERR - 1){1'b0}},csr_slie_aceerr,{LOCALINT_ACEERR{1'b0}}} | {{(32 - LOCALINT_HPMINT - 1){1'b0}},csr_slie_hpmint,{LOCALINT_HPMINT{1'b0}}} | {{(32 - LOCALINT_SBE - 1){1'b0}},csr_slie_sbe,{LOCALINT_SBE{1'b0}}};
assign csr_mstatus[0] = csr_mstatus_uie;
assign csr_mstatus[1] = csr_mstatus_sie;
assign csr_mstatus[2] = csr_mstatus_hie;
assign csr_mstatus[3] = csr_mstatus_mie;
assign csr_mstatus[4] = csr_mstatus_upie;
assign csr_mstatus[5] = csr_mstatus_spie;
assign csr_mstatus[6] = csr_mstatus_hpie;
assign csr_mstatus[7] = csr_mstatus_mpie;
assign csr_mstatus[8] = csr_mstatus_spp;
assign csr_mstatus[10:9] = csr_mstatus_hpp[1:0];
assign csr_mstatus[12:11] = csr_mstatus_mpp[1:0];
assign csr_mstatus[14:13] = csr_mstatus_fs[1:0];
assign csr_mstatus[16:15] = csr_mstatus_xs[1:0];
assign csr_mstatus[17] = csr_mstatus_mprv;
assign csr_mstatus[18] = csr_mstatus_sum;
assign csr_mstatus[19] = csr_mstatus_mxr;
assign csr_mstatus[20] = csr_mstatus_tvm;
assign csr_mstatus[21] = csr_mstatus_tw;
assign csr_mstatus[22] = csr_mstatus_tsr;
assign csr_mstatus[30:23] = 8'd0;
assign csr_mstatus[31] = csr_mstatus_sd;
assign csr_sstatus[0] = csr_mstatus_uie;
assign csr_sstatus[1] = csr_mstatus_sie;
assign csr_sstatus[2] = 1'b0;
assign csr_sstatus[3] = 1'b0;
assign csr_sstatus[4] = csr_mstatus_upie;
assign csr_sstatus[5] = csr_mstatus_spie;
assign csr_sstatus[6] = 1'b0;
assign csr_sstatus[7] = 1'b0;
assign csr_sstatus[8] = csr_mstatus_spp;
assign csr_sstatus[10:9] = 2'b0;
assign csr_sstatus[12:11] = 2'b0;
assign csr_sstatus[14:13] = csr_mstatus_fs[1:0];
assign csr_sstatus[16:15] = csr_mstatus_xs[1:0];
assign csr_sstatus[17] = 1'b0;
assign csr_sstatus[18] = csr_mstatus_sum;
assign csr_sstatus[19] = csr_mstatus_mxr;
assign csr_sstatus[20] = 1'b0;
assign csr_sstatus[21] = 1'b0;
assign csr_sstatus[22] = 1'b0;
assign csr_sstatus[30:23] = 8'd0;
assign csr_sstatus[31] = csr_mstatus_sd;
assign csr_ustatus[0] = csr_mstatus_uie;
assign csr_ustatus[3:1] = 3'b0;
assign csr_ustatus[4] = csr_mstatus_upie;
assign csr_ustatus[31:5] = {27{1'b0}};
assign reg_csr_mepc_addr_nx[EXTVALEN - 1:2] = (ipipe_csr_epc_we & ~csr_trap_delegated) ? ipipe_csr_epc_wdata[EXTVALEN - 1:2] : csr_wdata[EXTVALEN - 1:2];
assign reg_csr_mepc_addr_nx[1] = (ipipe_csr_epc_we & ~csr_trap_delegated) ? ipipe_csr_epc_wdata[1] : csr_wdata[1];
assign csr_mepc_addr_we = (ipipe_csr_epc_we & ~csr_trap_delegated) | csr_mepc_we;
assign csr_mtvec[VALEN - 1:0] = {csr_mtvec_addr,2'd0};
assign csr_mnvec[VALEN - 1:0] = reset_vector[VALEN - 1:0];
generate
    if (32 > EXTVALEN) begin:gen_zero_extend_pacsr
        assign csr_mtvec[31:VALEN] = {(32 - VALEN){1'b0}};
        assign csr_milmb[31:VALEN] = {(32 - VALEN){1'b0}};
        assign csr_mdlmb[31:VALEN] = {(32 - VALEN){1'b0}};
        assign csr_mnvec[31:VALEN] = {(32 - VALEN){1'b0}};
    end
    if ((32 > EXTVALEN) && (VALEN == EXTVALEN)) begin:gen_zero_extend_vacsr
        assign csr_stvec[31:VALEN] = {(32 - VALEN){1'b0}};
        assign csr_utvec[31:VALEN] = {(32 - VALEN){1'b0}};
        assign csr_mtval[31:VALEN] = {(32 - VALEN){1'b0}};
        assign csr_stval[31:VALEN] = {(32 - VALEN){1'b0}};
        assign csr_utval[31:VALEN] = {(32 - VALEN){1'b0}};
        assign csr_mepc[31:VALEN] = {(32 - VALEN){1'b0}};
        assign csr_sepc[31:VALEN] = {(32 - VALEN){1'b0}};
        assign csr_uepc[31:VALEN] = {(32 - VALEN){1'b0}};
        assign csr_dpc[31:VALEN] = {(32 - VALEN){1'b0}};
        assign csr_uitb[31:VALEN] = {(32 - VALEN){1'b0}};
    end
    if ((32 > EXTVALEN) && (VALEN != EXTVALEN)) begin:gen_sign_extend_vacsr
        assign csr_stvec[31:EXTVALEN] = {(32 - EXTVALEN){csr_stvec[EXTVALEN - 1]}};
        assign csr_utvec[31:EXTVALEN] = {(32 - EXTVALEN){csr_utvec[EXTVALEN - 1]}};
        assign csr_mtval[31:EXTVALEN] = {(32 - EXTVALEN){csr_mtval[EXTVALEN - 1]}};
        assign csr_stval[31:EXTVALEN] = {(32 - EXTVALEN){csr_stval[EXTVALEN - 1]}};
        assign csr_utval[31:EXTVALEN] = {(32 - EXTVALEN){csr_utval[EXTVALEN - 1]}};
        assign csr_mepc[31:EXTVALEN] = {(32 - EXTVALEN){csr_mepc[EXTVALEN - 1]}};
        assign csr_sepc[31:EXTVALEN] = {(32 - EXTVALEN){csr_sepc[EXTVALEN - 1]}};
        assign csr_uepc[31:EXTVALEN] = {(32 - EXTVALEN){csr_uepc[EXTVALEN - 1]}};
        assign csr_dpc[31:EXTVALEN] = {(32 - EXTVALEN){csr_dpc[EXTVALEN - 1]}};
        assign csr_uitb[31:EXTVALEN] = {(32 - EXTVALEN){csr_uitb[EXTVALEN - 1]}};
    end
endgenerate
assign csr_mcause = {csr_mcause_interrupt,{21{1'b0}},csr_mcause_code};
assign csr_micm_cfg[2:0] = (ICACHE_SIZE_KB == 0) ? 3'd0 : (ICACHE_TAG_RAM_AW == 12) ? 3'd6 : (ICACHE_TAG_RAM_AW == 11) ? 3'd5 : (ICACHE_TAG_RAM_AW == 10) ? 3'd4 : (ICACHE_TAG_RAM_AW == 9) ? 3'd3 : (ICACHE_TAG_RAM_AW == 8) ? 3'd2 : (ICACHE_TAG_RAM_AW == 7) ? 3'd1 : 3'd0;
assign csr_micm_cfg[5:3] = (ICACHE_SIZE_KB == 0) ? 3'd0 : (ICACHE_WAY == 4) ? 3'd3 : (ICACHE_WAY == 2) ? 3'd1 : 3'd0;
assign csr_micm_cfg[8:6] = (ICACHE_SIZE_KB == 0) ? 3'd0 : (CACHE_LINE_SIZE == 64) ? 3'd4 : (CACHE_LINE_SIZE == 32) ? 3'd3 : 3'd2;
assign csr_micm_cfg[9] = (ICACHE_SIZE_KB != 0);
assign csr_micm_cfg[11:10] = ((ICACHE_ECC_TYPE_INT == 0)) ? 2'd0 : ((ICACHE_ECC_TYPE_INT == 1)) ? 2'd1 : 2'd2;
assign csr_micm_cfg[14:12] = (ILM_SIZE_KB != 0) ? 3'd1 : 3'd0;
assign csr_micm_cfg[19:15] = (ILM_SIZE_KB == 0) ? 5'd0 : (ILM_SIZE_KB == 4) ? 5'd3 : (ILM_SIZE_KB == 8) ? 5'd4 : (ILM_SIZE_KB == 16) ? 5'd5 : (ILM_SIZE_KB == 32) ? 5'd6 : (ILM_SIZE_KB == 64) ? 5'd7 : (ILM_SIZE_KB == 128) ? 5'd8 : (ILM_SIZE_KB == 256) ? 5'd9 : (ILM_SIZE_KB == 512) ? 5'd10 : (ILM_SIZE_KB == 1024) ? 5'd11 : (ILM_SIZE_KB == 2048) ? 5'd12 : (ILM_SIZE_KB == 4096) ? 5'd13 : (ILM_SIZE_KB == 8192) ? 5'd14 : 5'd15;
assign csr_micm_cfg[20] = 1'b0;
assign csr_micm_cfg[22:21] = (ILM_ECC_TYPE_INT == 0) ? 2'd0 : (ILM_ECC_TYPE_INT == 1) ? 2'd1 : 2'd2;
assign csr_micm_cfg[23] = 1'b0;
assign csr_micm_cfg[24] = (ICACHE_TAG_RAM_AW == 5);
assign csr_micm_cfg[26:25] = (ICACHE_SIZE_KB == 0) ? 2'd0 : (ICACHE_LRU_INT == 0) ? 2'd1 : 2'd2;
assign csr_micm_cfg[31:27] = {5{1'b0}};
assign csr_mdcm_cfg[2:0] = (DCACHE_SIZE_KB == 0) ? 3'd0 : (DCACHE_TAG_AW == 12) ? 3'd6 : (DCACHE_TAG_AW == 11) ? 3'd5 : (DCACHE_TAG_AW == 10) ? 3'd4 : (DCACHE_TAG_AW == 9) ? 3'd3 : (DCACHE_TAG_AW == 8) ? 3'd2 : (DCACHE_TAG_AW == 7) ? 3'd1 : 3'd0;
assign csr_mdcm_cfg[5:3] = (DCACHE_SIZE_KB == 0) ? 3'd0 : (DCACHE_WAY == 4) ? 3'd3 : (DCACHE_WAY == 2) ? 3'd1 : 3'd0;
assign csr_mdcm_cfg[8:6] = (DCACHE_SIZE_KB == 0) ? 3'd0 : (CACHE_LINE_SIZE == 64) ? 3'd4 : (CACHE_LINE_SIZE == 32) ? 3'd3 : 3'd2;
assign csr_mdcm_cfg[9] = (DCACHE_SIZE_KB != 0);
assign csr_mdcm_cfg[11:10] = (DCACHE_ECC_TYPE_INT == 0) ? 2'd0 : (DCACHE_ECC_TYPE_INT == 1) ? 2'd1 : 2'd2;
assign csr_mdcm_cfg[14:12] = (DLM_SIZE_KB != 0) ? 3'd1 : 3'd0;
assign csr_mdcm_cfg[19:15] = (DLM_SIZE_KB == 0) ? 5'd0 : (DLM_SIZE_KB == 4) ? 5'd3 : (DLM_SIZE_KB == 8) ? 5'd4 : (DLM_SIZE_KB == 16) ? 5'd5 : (DLM_SIZE_KB == 32) ? 5'd6 : (DLM_SIZE_KB == 64) ? 5'd7 : (DLM_SIZE_KB == 128) ? 5'd8 : (DLM_SIZE_KB == 256) ? 5'd9 : (DLM_SIZE_KB == 512) ? 5'd10 : (DLM_SIZE_KB == 1024) ? 5'd11 : (DLM_SIZE_KB == 2048) ? 5'd12 : (DLM_SIZE_KB == 4096) ? 5'd13 : (DLM_SIZE_KB == 8192) ? 5'd14 : 5'd15;
assign csr_mdcm_cfg[20] = 1'b0;
assign csr_mdcm_cfg[22:21] = (DLM_ECC_TYPE_INT == 0) ? 2'd0 : (DLM_ECC_TYPE_INT == 1) ? 2'd1 : 2'd2;
assign csr_mdcm_cfg[23] = 1'b0;
assign csr_mdcm_cfg[24] = (DCACHE_TAG_AW == 5);
assign csr_mdcm_cfg[26:25] = (DCACHE_SIZE_KB == 0) ? 2'd0 : (DCACHE_LRU_INT == 0) ? 2'd1 : 2'd2;
assign csr_mdcm_cfg[31:27] = {5{1'b0}};
assign csr_mmsc_cfg[0] = (ECC_SUPPORT_INT == 1);
assign csr_mmsc_cfg[1] = 1'b0;
assign csr_mmsc_cfg[2] = (STLB_ECC_TYPE == 1);
assign csr_mmsc_cfg[3] = 1'b1;
assign csr_mmsc_cfg[4] = ((POWERBRAKE_SUPPORT_INT == 1));
assign csr_mmsc_cfg[5] = (STACKSAFE_SUPPORT_INT == 1);
assign csr_mmsc_cfg[6] = ((ACE_SUPPORT_INT == 1));
assign csr_mmsc_cfg[11:7] = 5'b0;
assign csr_mmsc_cfg[12] = ((VECTOR_PLIC_SUPPORT_INT == 1));
assign csr_mmsc_cfg[13] = 1'b1;
assign csr_mmsc_cfg[14] = ((SLAVE_PORT_SUPPORT_INT == 1));
assign csr_mmsc_cfg[15] = (PERFORMANCE_MONITOR_INT == 1);
assign csr_mmsc_cfg[16] = (CACHE_SUPPORT_INT == 1);
assign csr_mmsc_cfg[17] = (FLEN != 1) & ((FP16_SUPPORT_INT == 0));
assign csr_mmsc_cfg[18] = (CACHE_SUPPORT_INT == 1);
assign csr_mmsc_cfg[19] = 1'b0;
assign csr_mmsc_cfg[21:20] = 2'b0;
assign csr_mmsc_cfg[22] = (PERFORMANCE_MONITOR_INT == 0);
assign csr_mmsc_cfg[28:23] = 6'b0;
assign csr_mmsc_cfg[29] = ((DSP_SUPPORT_INT == 1));
assign csr_mmsc_cfg[30] = (PMA_ENTRIES != 0);
assign csr_mmsc_cfg[31] = ((MMSC_CFG2_EXIST_INT == 1));
assign csr_mmsc_cfg2[0] = ((BFLOAT16_SUPPORT_INT == 1));
assign csr_mmsc_cfg2[1] = ((FP16_SUPPORT_INT == 1));
assign csr_mmsc_cfg2[2] = ((VINT4_SUPPORT_INT == 1));
assign csr_mmsc_cfg2[3] = 1'b0;
assign csr_mmsc_cfg2[4] = 1'b0;
assign csr_mmsc_cfg2[5] = (FLEN != 1);
assign csr_mmsc_cfg2[6] = 1'b0;
assign csr_mmsc_cfg2[12:7] = 6'd0;
assign csr_mmsc_cfg2[13] = (CLUSTER_SUPPORT_INT != 0);
assign csr_mmsc_cfg2[14] = (L2C_CACHE_SIZE_KB != 0);
assign csr_mmsc_cfg2[15] = (IOCP_NUM != 0);
assign csr_mmsc_cfg2[19:16] = (NCORE_CLUSTER == 4) ? 4'd3 : (NCORE_CLUSTER == 2) ? 4'd1 : (NCORE_CLUSTER == 8) ? 4'd7 : 4'd0;
assign csr_mmsc_cfg2[20] = 1'b0;
assign csr_mmsc_cfg2[21] = (STLB_ECC_TYPE == 1);
assign csr_mmsc_cfg2[31:22] = {10{1'b0}};
assign csr_ml2c_ctl_base[31:0] = L2C_REG_BASE[31:0];
assign csr_mmisc_ctl[0] = 1'b0;
assign csr_mmisc_ctl[1] = csr_mmisc_ctl_vec_plic;
assign csr_mmisc_ctl[2] = csr_mmisc_ctl_rvcompm;
assign csr_mmisc_ctl[3] = csr_mmisc_ctl_brpe;
assign csr_mmisc_ctl[5:4] = csr_mmisc_ctl_aces;
assign csr_mmisc_ctl[6] = csr_mmisc_ctl_una;
assign csr_mmisc_ctl[7] = 1'b0;
assign csr_mmisc_ctl[8] = csr_mmisc_ctl_nbcache_en;
assign csr_mmisc_ctl[31:9] = {23{1'b0}};
assign csr_milmb[0] = csr_milmb_ien;
assign csr_milmb[2:1] = csr_milmb_eccen;
assign csr_milmb[3] = csr_milmb_rwecc;
assign csr_milmb[11:4] = 8'd0;
assign csr_milmb[VALEN - 1:12] = ILM_BASE[VALEN - 1:12];
assign csr_mdlmb[0] = csr_mdlmb_den;
assign csr_mdlmb[2:1] = csr_mdlmb_eccen;
assign csr_mdlmb[3] = csr_mdlmb_rwecc;
assign csr_mdlmb[11:4] = 8'd0;
assign csr_mdlmb[VALEN - 1:12] = DLM_BASE[VALEN - 1:12];
assign csr_mecc_code[7:0] = csr_mecc_code_code;
assign csr_mecc_code[15:8] = 8'd0;
assign csr_mecc_code[16] = csr_mecc_code_c;
assign csr_mecc_code[17] = csr_mecc_code_p;
assign csr_mecc_code[21:18] = csr_mecc_code_ramid;
assign csr_mecc_code[22] = csr_mecc_code_fetch;
assign csr_mecc_code[31:23] = {9{1'b0}};
assign csr_dcsr[31:28] = csr_dcsr_xdebugver;
assign csr_dcsr[27:16] = 12'd0;
assign csr_dcsr[15] = csr_dcsr_ebreakm;
assign csr_dcsr[14] = csr_dcsr_ebreakh;
assign csr_dcsr[13] = csr_dcsr_ebreaks;
assign csr_dcsr[12] = csr_dcsr_ebreaku;
assign csr_dcsr[11] = csr_dcsr_stepie;
assign csr_dcsr[10] = csr_dcsr_stopcount;
assign csr_dcsr[9] = csr_dcsr_stoptime;
assign csr_dcsr[8:6] = csr_dcsr_cause;
assign csr_dcsr[5] = 1'b0;
assign csr_dcsr[4] = csr_dcsr_mprven;
assign csr_dcsr[3] = csr_dcsr_nmip;
assign csr_dcsr[2] = csr_dcsr_step;
assign csr_dcsr[1:0] = csr_dcsr_prv;
assign csr_dexc2dbg[0] = csr_dexc2dbg_iam;
assign csr_dexc2dbg[1] = csr_dexc2dbg_iaf;
assign csr_dexc2dbg[2] = csr_dexc2dbg_ii;
assign csr_dexc2dbg[3] = csr_dexc2dbg_nmi;
assign csr_dexc2dbg[4] = csr_dexc2dbg_lam;
assign csr_dexc2dbg[5] = csr_dexc2dbg_laf;
assign csr_dexc2dbg[6] = csr_dexc2dbg_sam;
assign csr_dexc2dbg[7] = csr_dexc2dbg_saf;
assign csr_dexc2dbg[8] = csr_dexc2dbg_uec;
assign csr_dexc2dbg[9] = csr_dexc2dbg_sec;
assign csr_dexc2dbg[10] = csr_dexc2dbg_hec;
assign csr_dexc2dbg[11] = csr_dexc2dbg_mec;
assign csr_dexc2dbg[12] = csr_dexc2dbg_hsp;
assign csr_dexc2dbg[13] = csr_dexc2dbg_ace;
assign csr_dexc2dbg[14] = csr_dexc2dbg_slpecc;
assign csr_dexc2dbg[15] = csr_dexc2dbg_sbe;
assign csr_dexc2dbg[16] = csr_dexc2dbg_ipf;
assign csr_dexc2dbg[17] = csr_dexc2dbg_lpf;
assign csr_dexc2dbg[18] = csr_dexc2dbg_spf;
assign csr_dexc2dbg[19] = csr_dexc2dbg_pmov;
assign csr_dexc2dbg[31:20] = {12{1'b0}};
assign csr_ddcause[7:0] = csr_ddcause_maintype;
assign csr_ddcause[15:8] = csr_ddcause_subtype;
assign csr_ddcause[31:16] = {16{1'b0}};
generate
    if (((MMU_SCHEME_INT == 1)) && (PALEN == 34)) begin:gen_csr_satp_sv32_pa34
        assign csr_satp = {csr_satp_mode[0],csr_satp_asid,csr_satp_ppn};
    end
    else if (((MMU_SCHEME_INT == 1)) && (PALEN != 34)) begin:gen_csr_satp_sv32_non_pa34
        assign csr_satp = {csr_satp_mode[0],csr_satp_asid,{(34 - PALEN){1'b0}},csr_satp_ppn};
    end
    else if ((((MMU_SCHEME_INT == 2)) || ((MMU_SCHEME_INT == 3))) && (PALEN == 56)) begin:gen_csr_satp_sv39_sv48_pa56
        assign csr_satp = {csr_satp_mode,7'b0,csr_satp_asid,csr_satp_ppn};
    end
    else if ((((MMU_SCHEME_INT == 2)) || ((MMU_SCHEME_INT == 3))) && (PALEN != 56)) begin:gen_csr_satp_sv39_sv48_non_pa56
        assign csr_satp = {csr_satp_mode,7'b0,csr_satp_asid,{(56 - PALEN){1'b0}},csr_satp_ppn};
    end
    else begin:gen_csr_satp_bare
        assign csr_satp = {32{1'b0}};
    end
endgenerate
wire [43:0] hint_event;
assign hint_event[19] = dcu_event[0];
assign hint_event[22] = dcu_event[1];
assign hint_event[20] = dcu_event[2];
assign hint_event[21] = dcu_event[3];
assign hint_event[24] = dcu_event[4];
assign hint_event[25] = dcu_event[5];
assign hint_event[26] = dcu_event[6];
assign hint_event[0] = mshr_event[0];
assign hint_event[2] = mshr_event[1];
assign hint_event[4] = mshr_event[2];
assign hint_event[6] = mshr_event[3];
assign hint_event[8] = mshr_event[4];
assign hint_event[10] = mshr_event[5];
assign hint_event[12] = mshr_event[6];
assign hint_event[14] = mshr_event[7];
assign hint_event[1] = mshr_event[8];
assign hint_event[3] = mshr_event[9];
assign hint_event[5] = mshr_event[10];
assign hint_event[7] = mshr_event[11];
assign hint_event[9] = mshr_event[12];
assign hint_event[11] = mshr_event[13];
assign hint_event[13] = mshr_event[14];
assign hint_event[15] = mshr_event[15];
assign hint_event[32] = ifu_event[0];
assign hint_event[34] = ifu_event[1];
assign hint_event[33] = ifu_event[2];
assign hint_event[35] = ifu_event[4];
assign hint_event[36] = ifu_event[3];
assign hint_event[43] = ifu_event[5];
assign hint_event[17] = lsu_event[0];
assign hint_event[18] = lsu_event[1];
assign hint_event[40] = lsu_event[3];
assign hint_event[23] = lsu_event[2];
assign hint_event[31] = lsu_event[4];
assign hint_event[16] = ipipe_event[0];
assign hint_event[37] = ilm_csr_access;
assign hint_event[27] = dlm_csr_access0;
assign hint_event[28] = dlm_csr_access1;
assign hint_event[29] = dlm_csr_access2;
assign hint_event[30] = dlm_csr_access3;
assign hint_event[41] = mmu_csr_mitlb_access;
assign hint_event[42] = mmu_csr_mitlb_miss;
assign hint_event[38] = mmu_csr_mdtlb_access;
assign hint_event[39] = mmu_csr_mdtlb_miss;
kv_pfm_csr #(
    .PERFORMANCE_MONITOR_INT(PERFORMANCE_MONITOR_INT),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS)
) kv_pfm_csr (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_we(csr_we),
    .csr_waddr(ipipe_csr_req_waddr),
    .csr_wdata(csr_wdata),
    .csr_rd_hit0(sel_rd_pfm_csr),
    .csr_rd_hit1(sel_prob_rd_pfm_csr),
    .csr_raddr0(ipipe_csr_req_raddr),
    .csr_rdata0(csr_pfm_rdata),
    .csr_raddr1(csr_prob_raddr),
    .csr_rdata1(csr_prob_pfm_rdata),
    .ipipe_csr_pfm_inst_retire(ipipe_csr_pfm_inst_retire),
    .wb_i0_instr_event(wb_i0_instr_event),
    .wb_i1_instr_event(wb_i1_instr_event),
    .hint_event(hint_event),
    .csr_dcsr_stopcount(csr_dcsr_stopcount),
    .csr_halt_mode(csr_halt_mode),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .csr_mcounteren(csr_mcounteren),
    .csr_mcounterwen(csr_mcounterwen),
    .csr_scounteren(csr_scounteren),
    .hpm_m_counter_ovf(hpm_m_counter_ovf),
    .hpm_s_counter_ovf(hpm_s_counter_ovf)
);
assign csr_resp_rdata = ({32{sel_rd_misa}} & csr_misa) | ({32{sel_rd_mvendorid}} & csr_mvendorid) | ({32{sel_rd_marchid}} & csr_marchid) | ({32{sel_rd_mimpid}} & csr_mimpid) | ({32{sel_rd_mhartid}} & csr_mhartid) | ({32{sel_rd_mstatus}} & csr_mstatus) | ({32{sel_rd_medeleg}} & csr_medeleg) | ({32{sel_rd_mideleg}} & csr_mideleg) | ({32{sel_rd_mslideleg}} & csr_mslideleg) | ({32{sel_rd_mie}} & csr_mie) | ({32{sel_rd_mtvec}} & csr_mtvec) | ({32{sel_rd_pfm_csr}} & csr_pfm_rdata) | ({32{sel_rd_mscratch}} & csr_mscratch) | ({32{sel_rd_mepc}} & csr_mepc) | ({32{sel_rd_mcause}} & csr_mcause) | ({32{sel_rd_mtval}} & csr_mtval) | ({32{sel_rd_tselect}} & csr_tselect) | ({32{sel_rd_tdata1}} & csr_tdata1) | ({32{sel_rd_tdata2}} & csr_tdata2) | ({32{sel_rd_tdata3}} & csr_tdata3) | ({32{sel_rd_tinfo}} & csr_tinfo) | ({32{sel_rd_tcontrol}} & csr_tcontrol) | ({32{sel_rd_mcontext}} & csr_mcontext) | ({32{sel_rd_scontext}} & csr_scontext) | ({32{sel_rd_dcsr}} & csr_dcsr) | ({32{sel_rd_dpc}} & csr_dpc) | ({32{sel_rd_dscratch0}} & csr_dscratch0) | ({32{sel_rd_dscratch1}} & csr_dscratch1) | ({32{sel_rd_micm_cfg}} & csr_micm_cfg) | ({32{sel_rd_mdcm_cfg}} & csr_mdcm_cfg) | ({32{sel_rd_mmsc_cfg}} & csr_mmsc_cfg) | ({32{sel_rd_mmsc_cfg2}} & csr_mmsc_cfg2) | ({32{sel_rd_ml2c_ctl_base}} & csr_ml2c_ctl_base) | ({32{sel_rd_mmisc_ctl}} & csr_mmisc_ctl) | ({32{sel_rd_milmb}} & csr_milmb) | ({32{sel_rd_mdlmb}} & csr_mdlmb) | ({32{sel_rd_mecc_code}} & csr_mecc_code) | ({32{sel_rd_mnvec}} & csr_mnvec) | ({32{sel_rd_mxstatus}} & csr_mxstatus) | ({32{sel_rd_mpft_ctl}} & csr_mpft_ctl) | ({32{sel_rd_mdcause}} & csr_mdcause) | ({32{sel_rd_mcache_ctl}} & csr_mcache_ctl) | ({32{sel_rd_mcctlbeginaddr}} & csr_mcctlbeginaddr) | ({32{sel_rd_mcctlcommand}} & csr_mcctlcommand) | ({32{sel_rd_mcctldata}} & csr_mcctldata) | ({32{sel_rd_scctldata}} & csr_mcctldata) | ({32{sel_rd_ucctlbeginaddr}} & csr_mcctlbeginaddr) | ({32{sel_rd_ucctlcommand}} & csr_mcctlcommand) | ({32{sel_rd_mhsp_ctl}} & csr_mhsp_ctl) | ({32{sel_rd_mhsp_bound}} & csr_mhsp_bound) | ({32{sel_rd_mhsp_base}} & csr_mhsp_base) | ({32{sel_rd_uitb}} & csr_uitb) | ({32{sel_rd_ucode}} & csr_ucode) | ({32{sel_rd_udcause}} & csr_udcause) | ({32{sel_rd_dexc2dbg}} & csr_dexc2dbg) | ({32{sel_rd_ddcause}} & csr_ddcause) | ({32{sel_rd_mrandseq}} & csr_mrandseq) | ({32{sel_rd_mrandseqh}} & csr_mrandseqh) | ({32{sel_rd_mrandstate}} & csr_mrandstate) | ({32{sel_rd_mrandstateh}} & csr_mrandstateh) | ({32{sel_rd_sstatus}} & csr_sstatus) | ({32{sel_rd_sie}} & csr_sie) | ({32{sel_rd_slie}} & csr_slie) | ({32{sel_rd_slip}} & csr_slip) | ({32{sel_rd_sideleg}} & csr_sideleg) | ({32{sel_rd_sedeleg}} & csr_sedeleg) | ({32{sel_rd_stvec}} & csr_stvec) | ({32{sel_rd_sepc}} & csr_sepc) | ({32{sel_rd_scause}} & csr_scause) | ({32{sel_rd_sdcause}} & csr_sdcause) | ({32{sel_rd_stval}} & csr_stval) | ({32{sel_rd_sscratch}} & csr_sscratch) | ({32{sel_rd_satp}} & csr_satp) | ({32{sel_rd_smisc_ctl}} & csr_smisc_ctl) | ({32{sel_rd_ustatus}} & csr_ustatus) | ({32{sel_rd_uie}} & csr_uie) | ({32{sel_rd_utvec}} & csr_utvec) | ({32{sel_rd_uscratch}} & csr_uscratch) | ({32{sel_rd_uepc}} & csr_uepc) | ({32{sel_rd_ucause}} & csr_ucause) | ({32{sel_rd_utval}} & csr_utval) | ({32{sel_rd_uip}} & csr_uip) | ({32{sel_rd_fflags}} & csr_fflags) | ({32{sel_rd_frm}} & csr_frm) | ({32{sel_rd_fcsr}} & csr_fcsr) | ({32{sel_rd_vstart}} & csr_vstart) | ({32{sel_rd_vxsat}} & csr_vxsat) | ({32{sel_rd_vxrm}} & csr_vxrm) | ({32{sel_rd_vcsr}} & csr_vcsr) | ({32{sel_rd_vl}} & csr_vl) | ({32{sel_rd_vtype}} & csr_vtype) | ({32{sel_rd_vlenb}} & csr_vlenb[31:0]) | ({32{pmp_csr_hit0}} & pmp_csr_rdata0) | ({32{pma_csr_hit0}} & pma_csr_rdata0);
assign csr_ipipe_resp_rdata = csr_resp_rdata | ({32{sel_rd_mip}} & csr_mip) | ({32{sel_rd_sip}} & csr_sip);
assign csr_ipipe_rmw_rdata = csr_resp_rdata | ({32{sel_rd_mip}} & csr_rmw_mip) | ({32{sel_rd_sip}} & csr_rmw_sip);
assign csr_prob_rdata = ({32{sel_prob_rd_misa}} & csr_misa) | ({32{sel_prob_rd_mvendorid}} & csr_mvendorid) | ({32{sel_prob_rd_marchid}} & csr_marchid) | ({32{sel_prob_rd_mimpid}} & csr_mimpid) | ({32{sel_prob_rd_mhartid}} & csr_mhartid) | ({32{sel_prob_rd_mstatus}} & csr_mstatus) | ({32{sel_prob_rd_medeleg}} & csr_medeleg) | ({32{sel_prob_rd_mideleg}} & csr_mideleg) | ({32{sel_prob_rd_mslideleg}} & csr_mslideleg) | ({32{sel_prob_rd_mie}} & csr_mie) | ({32{sel_prob_rd_mtvec}} & csr_mtvec) | ({32{sel_prob_rd_pfm_csr}} & csr_prob_pfm_rdata) | ({32{sel_prob_rd_mscratch}} & csr_mscratch) | ({32{sel_prob_rd_mepc}} & csr_mepc) | ({32{sel_prob_rd_mcause}} & csr_mcause) | ({32{sel_prob_rd_mtval}} & csr_mtval) | ({32{sel_prob_rd_mip}} & csr_mip) | ({32{sel_prob_rd_tselect}} & csr_tselect) | ({32{sel_prob_rd_tdata1}} & csr_tdata1) | ({32{sel_prob_rd_tdata2}} & csr_tdata2) | ({32{sel_prob_rd_tdata3}} & csr_tdata3) | ({32{sel_prob_rd_tinfo}} & csr_tinfo) | ({32{sel_prob_rd_tcontrol}} & csr_tcontrol) | ({32{sel_prob_rd_mcontext}} & csr_mcontext) | ({32{sel_prob_rd_scontext}} & csr_scontext) | ({32{sel_prob_rd_dcsr}} & csr_dcsr) | ({32{sel_prob_rd_dpc}} & csr_dpc) | ({32{sel_prob_rd_dscratch0}} & csr_dscratch0) | ({32{sel_prob_rd_dscratch1}} & csr_dscratch1) | ({32{sel_prob_rd_micm_cfg}} & csr_micm_cfg) | ({32{sel_prob_rd_mdcm_cfg}} & csr_mdcm_cfg) | ({32{sel_prob_rd_mmsc_cfg}} & csr_mmsc_cfg) | ({32{sel_prob_rd_mmsc_cfg2}} & csr_mmsc_cfg2) | ({32{sel_prob_rd_mmisc_ctl}} & csr_mmisc_ctl) | ({32{sel_prob_rd_milmb}} & csr_milmb) | ({32{sel_prob_rd_mdlmb}} & csr_mdlmb) | ({32{sel_prob_rd_mecc_code}} & csr_mecc_code) | ({32{sel_prob_rd_mnvec}} & csr_mnvec) | ({32{sel_prob_rd_mxstatus}} & csr_mxstatus) | ({32{sel_prob_rd_mpft_ctl}} & csr_mpft_ctl) | ({32{sel_prob_rd_mdcause}} & csr_mdcause) | ({32{sel_prob_rd_mcache_ctl}} & csr_mcache_ctl) | ({32{sel_prob_rd_mcctlbeginaddr}} & csr_mcctlbeginaddr) | ({32{sel_prob_rd_mcctlcommand}} & csr_mcctlcommand) | ({32{sel_prob_rd_mcctldata}} & csr_mcctldata) | ({32{sel_prob_rd_scctldata}} & csr_mcctldata) | ({32{sel_prob_rd_ucctlbeginaddr}} & csr_mcctlbeginaddr) | ({32{sel_prob_rd_ucctlcommand}} & csr_mcctlcommand) | ({32{sel_prob_rd_mhsp_ctl}} & csr_mhsp_ctl) | ({32{sel_prob_rd_mhsp_bound}} & csr_mhsp_bound) | ({32{sel_prob_rd_mhsp_base}} & csr_mhsp_base) | ({32{sel_prob_rd_uitb}} & csr_uitb) | ({32{sel_prob_rd_ucode}} & csr_ucode) | ({32{sel_prob_rd_udcause}} & csr_udcause) | ({32{sel_prob_rd_dexc2dbg}} & csr_dexc2dbg) | ({32{sel_prob_rd_ddcause}} & csr_ddcause) | ({32{sel_prob_rd_mrandseq}} & csr_mrandseq) | ({32{sel_prob_rd_mrandseqh}} & csr_mrandseqh) | ({32{sel_prob_rd_mrandstate}} & csr_mrandstate) | ({32{sel_prob_rd_mrandstateh}} & csr_mrandstateh) | ({32{sel_prob_rd_sstatus}} & csr_sstatus) | ({32{sel_prob_rd_sie}} & csr_sie) | ({32{sel_prob_rd_slie}} & csr_slie) | ({32{sel_prob_rd_sip}} & csr_sip) | ({32{sel_prob_rd_slip}} & csr_slip) | ({32{sel_prob_rd_sideleg}} & csr_sideleg) | ({32{sel_prob_rd_sedeleg}} & csr_sedeleg) | ({32{sel_prob_rd_stvec}} & csr_stvec) | ({32{sel_prob_rd_sepc}} & csr_sepc) | ({32{sel_prob_rd_scause}} & csr_scause) | ({32{sel_prob_rd_sdcause}} & csr_sdcause) | ({32{sel_prob_rd_stval}} & csr_stval) | ({32{sel_prob_rd_sscratch}} & csr_sscratch) | ({32{sel_prob_rd_satp}} & csr_satp) | ({32{sel_prob_rd_smisc_ctl}} & csr_smisc_ctl) | ({32{sel_prob_rd_ustatus}} & csr_ustatus) | ({32{sel_prob_rd_uie}} & csr_uie) | ({32{sel_prob_rd_utvec}} & csr_utvec) | ({32{sel_prob_rd_uscratch}} & csr_uscratch) | ({32{sel_prob_rd_uepc}} & csr_uepc) | ({32{sel_prob_rd_ucause}} & csr_ucause) | ({32{sel_prob_rd_utval}} & csr_utval) | ({32{sel_prob_rd_uip}} & csr_uip) | ({32{sel_prob_rd_fflags}} & csr_fflags) | ({32{sel_prob_rd_frm}} & csr_frm) | ({32{sel_prob_rd_fcsr}} & csr_fcsr) | ({32{pmp_csr_hit1}} & pmp_csr_rdata1) | ({32{pma_csr_hit1}} & pma_csr_rdata1);
generate
    if (NUM_PRIVILEGE_LEVELS == 1) begin:gen_cur_privilege_m
        assign csr_cur_privilege = PRIVILEGE_MACHINE;
        assign cur_privilege_m = (csr_cur_privilege == PRIVILEGE_MACHINE);
        assign cur_privilege_s = 1'b0;
        assign cur_privilege_u = 1'b0;
        assign ls_privilege_m = 1'b1;
        assign ls_privilege_s = 1'b0;
        assign ls_privilege_u = 1'b0;
    end
    else begin:gen_cur_privilege_msu_mu
        wire [1:0] csr_cur_privilege_nx;
        reg [1:0] reg_cur_privilege;
        wire reg_cur_privilege_en;
        wire return_from_s_mode;
        wire return_from_u_mode;
        wire mpp_privilege_m;
        wire mpp_privilege_s;
        wire mpp_privilege_u;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_cur_privilege <= PRIVILEGE_MACHINE;
            end
            else if (reg_cur_privilege_en) begin
                reg_cur_privilege <= csr_cur_privilege_nx;
            end
        end

        assign return_from_s_mode = s_trap_return & (NUM_PRIVILEGE_LEVELS > 2);
        assign return_from_u_mode = u_trap_return & (NUM_PRIVILEGE_LEVELS > 1);
        assign reg_cur_privilege_en = nmi_taken | trap_taken | u_trap_return | s_trap_return | m_trap_return | halt_taken | halt_return;
        assign csr_cur_privilege_nx = halt_taken ? PRIVILEGE_MACHINE : halt_return ? csr_dcsr_prv : (trap_taken & trap_handled_by_s_mode) ? PRIVILEGE_SUPERVISOR : ((trap_taken & trap_handled_by_u_mode) | return_from_u_mode) ? PRIVILEGE_USER : return_from_s_mode ? {1'b0,csr_mstatus_spp} : m_trap_return ? csr_mstatus_mpp : PRIVILEGE_MACHINE;
        assign csr_cur_privilege = reg_cur_privilege;
        assign cur_privilege_m = (csr_cur_privilege == PRIVILEGE_MACHINE);
        assign cur_privilege_s = (csr_cur_privilege == PRIVILEGE_SUPERVISOR);
        assign cur_privilege_u = (csr_cur_privilege == PRIVILEGE_USER);
        assign mpp_privilege_m = (csr_mstatus_mpp == PRIVILEGE_MACHINE);
        assign mpp_privilege_s = (csr_mstatus_mpp == PRIVILEGE_SUPERVISOR);
        assign mpp_privilege_u = (csr_mstatus_mpp == PRIVILEGE_USER);
        assign ls_privilege_m = (csr_mstatus_mprv & (~csr_halt_mode | csr_dcsr_mprven)) ? mpp_privilege_m : cur_privilege_m;
        assign ls_privilege_s = (csr_mstatus_mprv & (~csr_halt_mode | csr_dcsr_mprven)) ? mpp_privilege_s : cur_privilege_s;
        assign ls_privilege_u = (csr_mstatus_mprv & (~csr_halt_mode | csr_dcsr_mprven)) ? mpp_privilege_u : cur_privilege_u;
    end
endgenerate
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        csr_mscratch <= {32{1'b0}};
    end
    else if (csr_mscratch_we) begin
        csr_mscratch <= csr_wdata;
    end
end

generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_sscratch_yes
        reg [31:0] reg_csr_sscratch;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_sscratch <= {32{1'b0}};
            end
            else if (csr_sscratch_we) begin
                reg_csr_sscratch <= csr_wdata;
            end
        end

        assign csr_sscratch = reg_csr_sscratch;
    end
    else begin:gen_csr_sscratch_no
        assign csr_sscratch = {32{1'b0}};
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 1) && ((RVN_SUPPORT_INT == 1))) begin:gen_csr_uscratch_yes
        reg [31:0] reg_csr_uscratch;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_uscratch <= {32{1'b0}};
            end
            else if (csr_uscratch_we) begin
                reg_csr_uscratch <= csr_wdata;
            end
        end

        assign csr_uscratch = reg_csr_uscratch;
    end
    else begin:gen_csr_uscratch_no
        assign csr_uscratch = {32{1'b0}};
    end
endgenerate
generate
    if ((MMU_SCHEME_INT == 1)) begin:gen_csr_satp_sv32
        reg [PALEN - 1:12] reg_csr_satp_ppn_sv32;
        reg reg_csr_satp_mode_sv32;
        reg [8:0] reg_csr_satp_asid_sv32;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_satp_ppn_sv32 <= {(PALEN - 12){1'b0}};
                reg_csr_satp_asid_sv32 <= 9'b0;
                reg_csr_satp_mode_sv32 <= 1'b0;
            end
            else if (csr_satp_we) begin
                reg_csr_satp_ppn_sv32 <= csr_wdata[PALEN - 13:0];
                reg_csr_satp_asid_sv32 <= csr_wdata[30:22];
                reg_csr_satp_mode_sv32 <= csr_wdata[31];
            end
        end

        assign csr_satp_ppn = reg_csr_satp_ppn_sv32;
        assign csr_satp_asid = reg_csr_satp_asid_sv32;
        assign csr_satp_mode = {3'b0,reg_csr_satp_mode_sv32};
        assign valid_satp_mode = 1'b1;
    end
    else if ((MMU_SCHEME_INT == 2)) begin:gen_csr_satp_sv39
        reg [PALEN - 1:12] reg_csr_satp_ppn_sv39;
        reg reg_csr_satp_mode_sv39;
        reg [8:0] reg_csr_satp_asid_sv39;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_satp_ppn_sv39 <= {(PALEN - 12){1'b0}};
                reg_csr_satp_asid_sv39 <= 9'b0;
                reg_csr_satp_mode_sv39 <= 1'b0;
            end
            else if (csr_satp_we) begin
                reg_csr_satp_ppn_sv39 <= csr_wdata[PALEN - 13:0];
                reg_csr_satp_asid_sv39 <= csr_wdata[52:44];
                reg_csr_satp_mode_sv39 <= (csr_wdata[63:60] == 4'h8) ? csr_wdata[63] : 1'b0;
            end
        end

        assign csr_satp_ppn = reg_csr_satp_ppn_sv39;
        assign csr_satp_asid = reg_csr_satp_asid_sv39;
        assign csr_satp_mode = {reg_csr_satp_mode_sv39,3'b0};
        assign valid_satp_mode = (csr_wdata[63:60] == SATP_MODE_BARE) | (csr_wdata[63:60] == SATP_MODE_SV39);
    end
    else if ((MMU_SCHEME_INT == 3)) begin:gen_csr_satp_sv48
        reg [PALEN - 1:12] reg_csr_satp_ppn_sv48;
        reg reg_csr_satp_mode_b0_sv48;
        reg reg_csr_satp_mode_b3_sv48;
        reg [8:0] reg_csr_satp_asid_sv48;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_satp_ppn_sv48 <= {(PALEN - 12){1'b0}};
                reg_csr_satp_asid_sv48 <= 9'b0;
                reg_csr_satp_mode_b0_sv48 <= 1'b0;
                reg_csr_satp_mode_b3_sv48 <= 1'b0;
            end
            else if (csr_satp_we) begin
                reg_csr_satp_ppn_sv48 <= csr_wdata[PALEN - 13:0];
                reg_csr_satp_asid_sv48 <= csr_wdata[52:44];
                reg_csr_satp_mode_b0_sv48 <= (csr_wdata[63:60] == 4'h8) | (csr_wdata[63:60] == 4'h9) ? csr_wdata[60] : 1'b0;
                reg_csr_satp_mode_b3_sv48 <= (csr_wdata[63:60] == 4'h8) | (csr_wdata[63:60] == 4'h9) ? csr_wdata[63] : 1'b0;
            end
        end

        assign csr_satp_ppn = reg_csr_satp_ppn_sv48;
        assign csr_satp_asid = reg_csr_satp_asid_sv48;
        assign csr_satp_mode = {reg_csr_satp_mode_b3_sv48,2'b0,reg_csr_satp_mode_b0_sv48};
        assign valid_satp_mode = (csr_wdata[63:60] == SATP_MODE_BARE) | (csr_wdata[63:60] == SATP_MODE_SV39) | (csr_wdata[63:60] == SATP_MODE_SV48);
    end
    else begin:gen_csr_satp_no
        assign csr_satp_ppn = {(PALEN - 12){1'b0}};
        assign csr_satp_asid = 9'b0;
        assign csr_satp_mode = 4'b0;
        assign valid_satp_mode = 1'b0;
    end
endgenerate
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        csr_mip_meip <= 1'b0;
        csr_mip_mtip <= 1'b0;
        csr_mip_msip <= 1'b0;
    end
    else begin
        csr_mip_meip <= meip;
        csr_mip_mtip <= mtip;
        csr_mip_msip <= msip;
    end
end

generate
    if ((ACE_SUPPORT_INT == 1)) begin:gen_csr_mip_mie_aceerr_yes
        reg reg_csr_mip_aceerr;
        reg reg_csr_mie_aceerr;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mip_aceerr <= 1'b0;
            end
            else begin
                reg_csr_mip_aceerr <= ace_error;
            end
        end

        assign csr_mip_aceerr = reg_csr_mip_aceerr;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mie_aceerr <= 1'b0;
            end
            else if (csr_mie_we) begin
                reg_csr_mie_aceerr <= csr_wdata[LOCALINT_ACEERR];
            end
        end

        assign csr_mie_aceerr = reg_csr_mie_aceerr;
    end
    else begin:gen_csr_mip_mie_aceerr_no
        assign csr_mip_aceerr = 1'b0;
        assign csr_mie_aceerr = 1'b0;
        wire nds_unused_ace_error = ace_error;
    end
endgenerate
generate
    if (ECC_SUPPORT_INT == 1) begin:gen_async_ecc_error
        wire async_ecc_error;
        reg reg_int_ecc_corr;
        wire reg_int_ecc_corr_nx;
        reg [3:0] reg_int_ecc_ramid;
        wire [3:0] reg_int_ecc_ramid_nx;
        reg reg_int_ecc_insn;
        wire reg_int_ecc_insn_nx;
        reg [2:0] reg_int_ecc_cause_detail;
        wire [2:0] reg_int_ecc_cause_detail_nx;
        assign async_ecc_error = slvp_ipipe_local_int | dcu_async_ecc_error | (csr_mip_we & csr_wdata[LOCALINT_SLPECC]) | (csr_slip_we & (csr_mslideleg[LOCALINT_SLPECC] | cur_privilege_m) & csr_wdata[LOCALINT_SLPECC]);
        always @(posedge core_clk) begin
            if (async_ecc_error) begin
                reg_int_ecc_corr <= reg_int_ecc_corr_nx;
                reg_int_ecc_ramid <= reg_int_ecc_ramid_nx;
                reg_int_ecc_insn <= reg_int_ecc_insn_nx;
                reg_int_ecc_cause_detail <= reg_int_ecc_cause_detail_nx;
            end
        end

        assign reg_int_ecc_corr_nx = slvp_ipipe_local_int ? slvp_ipipe_ecc_corr : dcu_async_ecc_error ? dcu_async_ecc_corr : 1'd0;
        assign reg_int_ecc_ramid_nx = slvp_ipipe_local_int ? slvp_ipipe_ecc_ramid : dcu_async_ecc_error ? dcu_async_ecc_ramid : 4'd0;
        assign reg_int_ecc_insn_nx = 1'b0;
        assign reg_int_ecc_cause_detail_nx = slvp_ipipe_local_int ? INT_ECC_DCAUSE_SLVP : 3'd0;
        assign ipipe_csr_m_slpecc_set = async_ecc_error & (cur_privilege_m | ~three_level_mode);
        assign ipipe_csr_s_slpecc_set = async_ecc_error & ~cur_privilege_m & three_level_mode;
        assign int_ecc_corr = reg_int_ecc_corr;
        assign int_ecc_ramid = reg_int_ecc_ramid;
        assign int_ecc_insn = reg_int_ecc_insn;
        assign int_ecc_cause_detail = reg_int_ecc_cause_detail;
    end
    else begin:gen_async_ecc_error_stub
        assign ipipe_csr_m_slpecc_set = 1'b0;
        assign ipipe_csr_s_slpecc_set = 1'b0;
        assign int_ecc_corr = 1'b0;
        assign int_ecc_ramid = 4'd0;
        assign int_ecc_insn = 1'b0;
        assign int_ecc_cause_detail = 3'd0;
        wire nds_unused_dcu_async_ecc_error = dcu_async_ecc_error;
        wire nds_unused_dcu_async_ecc_corr = dcu_async_ecc_corr;
        wire [3:0] nds_unused_dcu_async_ecc_ramid = dcu_async_ecc_ramid;
        wire nds_unused_slvp_ipipe_local_int = slvp_ipipe_local_int;
        wire nds_unused_slvp_ipipe_ecc_corr = slvp_ipipe_ecc_corr;
        wire [3:0] nds_unused_slvp_ipipe_ecc_ramid = slvp_ipipe_ecc_ramid;
    end
endgenerate
generate
    if ((SLPECC_SUPPORT_INT == 1)) begin:gen_csr_mip_mie_slpecc_yes
        reg reg_csr_mip_slpecc;
        wire csr_mip_slpecc_we;
        wire csr_mip_slpecc_nx;
        reg reg_csr_mie_slpecc;
        assign csr_mip_slpecc_we = csr_mip_we | ipipe_csr_m_slpecc_set | ipipe_csr_m_slpecc_clr;
        assign csr_mip_slpecc_nx = ipipe_csr_m_slpecc_set ? 1'b1 : ipipe_csr_m_slpecc_clr ? 1'b0 : csr_wdata[LOCALINT_SLPECC];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mip_slpecc <= 1'b0;
            end
            else if (csr_mip_slpecc_we) begin
                reg_csr_mip_slpecc <= csr_mip_slpecc_nx;
            end
        end

        assign csr_mip_slpecc = reg_csr_mip_slpecc;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mie_slpecc <= 1'b0;
            end
            else if (csr_mie_we) begin
                reg_csr_mie_slpecc <= csr_wdata[LOCALINT_SLPECC];
            end
        end

        assign csr_mie_slpecc = reg_csr_mie_slpecc;
    end
    else begin:gen_csr_mip_mie_slpecc_no
        assign csr_mip_slpecc = 1'b0;
        assign csr_mie_slpecc = 1'b0;
        wire nds_unused_ipipe_csr_m_slpecc_set = ipipe_csr_m_slpecc_set;
        wire nds_unused_ipipe_csr_m_slpecc_clr = ipipe_csr_m_slpecc_clr;
    end
endgenerate
generate
    if (PERFORMANCE_MONITOR_INT == 1) begin:gen_csr_mip_mie_hpmint_yes
        reg reg_csr_mip_hpmint;
        wire csr_mip_hpmint_we;
        wire csr_mip_hpmint_nx;
        assign csr_mip_hpmint_we = csr_mip_we | hpm_m_counter_ovf | ipipe_csr_m_hpmint_clr;
        assign csr_mip_hpmint_nx = hpm_m_counter_ovf ? 1'b1 : ipipe_csr_m_hpmint_clr ? 1'b0 : csr_wdata[LOCALINT_HPMINT];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mip_hpmint <= 1'b0;
            end
            else if (csr_mip_hpmint_we) begin
                reg_csr_mip_hpmint <= csr_mip_hpmint_nx;
            end
        end

        assign csr_mip_hpmint = reg_csr_mip_hpmint;
        reg reg_csr_mie_hpmint;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mie_hpmint <= 1'b0;
            end
            else if (csr_mie_we) begin
                reg_csr_mie_hpmint <= csr_wdata[LOCALINT_HPMINT];
            end
        end

        assign csr_mie_hpmint = reg_csr_mie_hpmint;
    end
    else begin:gen_csr_mip_mie_hpmint_no
        assign csr_mip_hpmint = 1'b0;
        assign csr_mie_hpmint = 1'b0;
        wire nds_unused_ipipe_csr_m_hpmint_clr = ipipe_csr_m_hpmint_clr;
        wire nds_unused_hpm_m_counter_ovf = hpm_m_counter_ovf;
    end
endgenerate
assign csr_mip_sbe_we = csr_mip_we | ipipe_csr_m_sbe_set | ipipe_csr_m_sbe_clr;
assign csr_mip_sbe_nx = ipipe_csr_m_sbe_set ? 1'b1 : ipipe_csr_m_sbe_clr ? 1'b0 : csr_wdata[LOCALINT_SBE];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        csr_mip_sbe <= 1'b0;
    end
    else if (csr_mip_sbe_we) begin
        csr_mip_sbe <= csr_mip_sbe_nx;
    end
end

generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_mip_seip_yes
        reg reg_csr_mip_seip;
        reg seip_from_io;
        wire reg_csr_mip_seip_nx;
        wire reg_csr_mip_seip_set;
        wire reg_csr_mip_seip_clr;
        wire mip_seip_wdata;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mip_seip <= 1'b0;
                seip_from_io <= 1'b0;
            end
            else begin
                reg_csr_mip_seip <= reg_csr_mip_seip_nx;
                seip_from_io <= seip;
            end
        end

        assign reg_csr_mip_seip_set = csr_mip_we & mip_seip_wdata;
        assign reg_csr_mip_seip_clr = csr_mip_we & ~mip_seip_wdata;
        assign reg_csr_mip_seip_nx = reg_csr_mip_seip_set | reg_csr_mip_seip & ~reg_csr_mip_seip_clr;
        assign csr_mip_seip = reg_csr_mip_seip | seip_from_io;
        assign csr_rmw_mip_seip = reg_csr_mip_seip;
        assign mip_seip_wdata = ipipe_csr_req_wdata[9];
    end
    else begin:gen_csr_mip_seip_no
        assign csr_mip_seip = 1'b0;
        assign csr_rmw_mip_seip = 1'b0;
        wire nds_unused_seip = seip;
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 2) && (VECTOR_PLIC_SUPPORT_INT == 1)) begin:gen_csr_seiid
        reg [9:0] reg_seiid;
        wire reg_seiid_en;
        always @(posedge core_clk) begin
            if (reg_seiid_en) begin
                reg_seiid <= seiid;
            end
        end

        assign reg_seiid_en = csr_mmisc_ctl_vec_plic & seip;
        assign csr_seiid = reg_seiid;
    end
    else begin:gen_csr_seiid_stub
        assign csr_seiid = 10'd0;
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 1) && ((RVN_SUPPORT_INT == 1))) begin:gen_csr_mip_ueip_yes
        reg reg_csr_mip_ueip;
        reg ueip_from_io;
        wire reg_csr_mip_ueip_nx;
        wire reg_csr_mip_ueip_en;
        assign reg_csr_mip_ueip_en = csr_mip_we | (csr_sip_we & csr_mideleg_uei);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mip_ueip <= 1'b0;
            end
            else if (reg_csr_mip_ueip_en) begin
                reg_csr_mip_ueip <= reg_csr_mip_ueip_nx;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                ueip_from_io <= 1'b0;
            end
            else begin
                ueip_from_io <= ueip;
            end
        end

        assign csr_mip_ueip = reg_csr_mip_ueip | ueip_from_io;
        assign csr_rmw_mip_ueip = reg_csr_mip_ueip;
        assign reg_csr_mip_ueip_nx = ipipe_csr_req_wdata[8];
    end
    else begin:gen_csr_mip_ueip_no
        assign csr_mip_ueip = 1'b0;
        assign csr_rmw_mip_ueip = 1'b0;
        wire nds_unused_ueip = ueip;
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 1) && ((RVN_SUPPORT_INT == 1)) && (VECTOR_PLIC_SUPPORT_INT == 1)) begin:gen_csr_ueiid
        reg [9:0] reg_ueiid;
        wire reg_ueiid_en;
        always @(posedge core_clk) begin
            if (reg_ueiid_en) begin
                reg_ueiid <= ueiid;
            end
        end

        assign reg_ueiid_en = csr_mmisc_ctl_vec_plic & ueip;
        assign csr_ueiid = reg_ueiid;
    end
    else begin:gen_csr_ueiid_stub
        assign csr_ueiid = 10'd0;
    end
endgenerate
generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_mip_stip_yes
        reg reg_csr_mip_stip;
        wire csr_mip_stip_set;
        wire csr_mip_stip_clr;
        wire csr_mip_stip_nx;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mip_stip <= 1'b0;
            end
            else begin
                reg_csr_mip_stip <= csr_mip_stip_nx;
            end
        end

        assign csr_mip_stip_set = csr_mip_we & csr_wdata[5];
        assign csr_mip_stip_clr = csr_mip_we & ~csr_wdata[5];
        assign csr_mip_stip_nx = csr_mip_stip_set | csr_mip_stip & ~csr_mip_stip_clr;
        assign csr_mip_stip = reg_csr_mip_stip;
    end
    else begin:gen_csr_mip_stip_no
        assign csr_mip_stip = 1'b0;
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 1) && ((RVN_SUPPORT_INT == 1))) begin:gen_csr_mip_utip_yes
        reg reg_csr_mip_utip;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mip_utip <= 1'b0;
            end
            else if (csr_mip_we) begin
                reg_csr_mip_utip <= csr_wdata[4];
            end
        end

        assign csr_mip_utip = reg_csr_mip_utip;
    end
    else begin:gen_csr_mip_utip_no
        assign csr_mip_utip = 1'b0;
    end
endgenerate
generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_mip_ssip_yes
        reg reg_csr_mip_ssip;
        wire csr_mip_ssip_set;
        wire csr_mip_ssip_clr;
        wire csr_mip_ssip_nx;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mip_ssip <= 1'b0;
            end
            else begin
                reg_csr_mip_ssip <= csr_mip_ssip_nx;
            end
        end

        assign csr_mip_ssip_set = (csr_mip_we | csr_sip_we & csr_mideleg_ssi) & csr_wdata[1];
        assign csr_mip_ssip_clr = (csr_mip_we | csr_sip_we & csr_mideleg_ssi) & ~csr_wdata[1];
        assign csr_mip_ssip_nx = csr_mip_ssip_set | csr_mip_ssip & ~csr_mip_ssip_clr;
        assign csr_mip_ssip = reg_csr_mip_ssip;
    end
    else begin:gen_csr_mip_ssip_no
        assign csr_mip_ssip = 1'b0;
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 1) && ((RVN_SUPPORT_INT == 1))) begin:gen_csr_mip_usip_yes
        reg reg_csr_mip_usip;
        wire reg_csr_mip_usip_en;
        wire ssi_user_mode_delegate = csr_mideleg_usi & ((NUM_PRIVILEGE_LEVELS < 3) | csr_sideleg[0]);
        wire ssi_supervisor_mode_delegate = csr_mideleg_usi & (NUM_PRIVILEGE_LEVELS > 2) & ~csr_sideleg[0];
        assign reg_csr_mip_usip_en = (csr_mip_we | (csr_sip_we & ssi_supervisor_mode_delegate) | (csr_uip_we & ssi_user_mode_delegate));
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mip_usip <= 1'b0;
            end
            else if (reg_csr_mip_usip_en) begin
                reg_csr_mip_usip <= csr_wdata[0];
            end
        end

        assign csr_mip_usip = reg_csr_mip_usip;
    end
    else begin:gen_csr_mip_usip_no
        assign csr_mip_usip = 1'b0;
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 2) && (PERFORMANCE_MONITOR_INT == 1)) begin:gen_csr_slip_slie_hpmint_yes
        wire csr_slip_hpmint_we;
        wire csr_slip_hpmint_nx;
        reg reg_csr_slip_hpmint;
        reg reg_csr_slie_hpmint;
        wire csr_slie_hpmint_nx;
        assign csr_slip_hpmint_we = csr_slip_we & (csr_mslideleg[LOCALINT_HPMINT] | cur_privilege_m) | hpm_s_counter_ovf | ipipe_csr_s_hpmint_clr;
        assign csr_slip_hpmint_nx = hpm_s_counter_ovf ? 1'b1 : ipipe_csr_s_hpmint_clr ? 1'b0 : csr_wdata[LOCALINT_HPMINT];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_slip_hpmint <= 1'b0;
            end
            else if (csr_slip_hpmint_we) begin
                reg_csr_slip_hpmint <= csr_slip_hpmint_nx;
            end
        end

        assign csr_slip_hpmint = reg_csr_slip_hpmint;
        assign csr_slie_hpmint_nx = csr_wdata[LOCALINT_HPMINT] & (csr_mslideleg[LOCALINT_HPMINT] | cur_privilege_m);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_slie_hpmint <= 1'b0;
            end
            else if (csr_slie_we) begin
                reg_csr_slie_hpmint <= csr_slie_hpmint_nx;
            end
        end

        assign csr_slie_hpmint = reg_csr_slie_hpmint;
    end
    else begin:gen_csr_slip_slie_hpmint_no
        assign csr_slip_hpmint = 1'b0;
        assign csr_slie_hpmint = 1'b0;
        wire nds_unused_ipipe_csr_s_hpmint_clr = ipipe_csr_s_hpmint_clr;
        wire nds_unused_hpm_s_counter_ovf = hpm_s_counter_ovf;
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 2) && ((ACE_SUPPORT_INT == 1))) begin:gen_csr_slip_slie_aceerr_yes
        reg reg_csr_slip_aceerr;
        wire csr_slip_aceerr_nx;
        reg reg_csr_slie_aceerr;
        wire csr_slie_aceerr_nx;
        assign csr_slip_aceerr_nx = ~cur_privilege_m & ace_error;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_slip_aceerr <= 1'b0;
            end
            else begin
                reg_csr_slip_aceerr <= csr_slip_aceerr_nx;
            end
        end

        assign csr_slip_aceerr = reg_csr_slip_aceerr;
        assign csr_slie_aceerr_nx = csr_wdata[LOCALINT_ACEERR] & (csr_mslideleg[LOCALINT_ACEERR] | cur_privilege_m);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_slie_aceerr <= 1'b0;
            end
            else if (csr_slie_we) begin
                reg_csr_slie_aceerr <= csr_slie_aceerr_nx;
            end
        end

        assign csr_slie_aceerr = reg_csr_slie_aceerr;
    end
    else begin:gen_csr_slip_slie_aceerr_no
        assign csr_slip_aceerr = 1'b0;
        assign csr_slie_aceerr = 1'b0;
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 2) && ((SLPECC_SUPPORT_INT == 1))) begin:gen_csr_slip_slie_slpecc_yes
        reg reg_csr_slip_slpecc;
        wire csr_slip_slpecc_we;
        wire csr_slip_slpecc_nx;
        reg reg_csr_slie_slpecc;
        wire csr_slie_slpecc_nx;
        assign csr_slip_slpecc_we = csr_slip_we & (csr_mslideleg[LOCALINT_SLPECC] | cur_privilege_m) | ipipe_csr_s_slpecc_set | ipipe_csr_s_slpecc_clr;
        assign csr_slip_slpecc_nx = ipipe_csr_s_slpecc_set ? 1'b1 : ipipe_csr_s_slpecc_clr ? 1'b0 : csr_wdata[LOCALINT_SLPECC];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_slip_slpecc <= 1'b0;
            end
            else if (csr_slip_slpecc_we) begin
                reg_csr_slip_slpecc <= csr_slip_slpecc_nx;
            end
        end

        assign csr_slip_slpecc = reg_csr_slip_slpecc;
        assign csr_slie_slpecc_nx = csr_wdata[LOCALINT_SLPECC] & (csr_mslideleg[LOCALINT_SLPECC] | cur_privilege_m);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_slie_slpecc <= 1'b0;
            end
            else if (csr_slie_we) begin
                reg_csr_slie_slpecc <= csr_slie_slpecc_nx;
            end
        end

        assign csr_slie_slpecc = reg_csr_slie_slpecc;
    end
    else begin:gen_csr_slip_slie_slpecc_no
        assign csr_slip_slpecc = 1'b0;
        assign csr_slie_slpecc = 1'b0;
        wire nds_unused_ipipe_csr_s_slpecc_set = ipipe_csr_s_slpecc_set;
        wire nds_unused_ipipe_csr_s_slpecc_clr = ipipe_csr_s_slpecc_clr;
    end
endgenerate
generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_slip_sbe_yes
        reg reg_csr_slip_sbe;
        wire csr_slip_sbe_we;
        wire csr_slip_sbe_nx;
        assign csr_slip_sbe_we = csr_slip_we & (csr_mslideleg[LOCALINT_SBE] | cur_privilege_m) | ipipe_csr_s_sbe_set | ipipe_csr_s_sbe_clr;
        assign csr_slip_sbe_nx = ipipe_csr_s_sbe_set ? 1'b1 : ipipe_csr_s_sbe_clr ? 1'b0 : csr_wdata[LOCALINT_SBE];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_slip_sbe <= 1'b0;
            end
            else if (csr_slip_sbe_we) begin
                reg_csr_slip_sbe <= csr_slip_sbe_nx;
            end
        end

        assign csr_slip_sbe = reg_csr_slip_sbe;
    end
    else begin:gen_csr_slip_sbe_no
        assign csr_slip_sbe = 1'b0;
        wire nds_unused_ipipe_csr_s_sbe_clr = ipipe_csr_s_sbe_clr;
        wire nds_unused_ipipe_csr_s_sbe_set = ipipe_csr_s_sbe_set;
    end
endgenerate
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        csr_mie_meie <= 1'b0;
        csr_mie_mtie <= 1'b0;
        csr_mie_msie <= 1'b0;
        csr_mie_sbe <= 1'b0;
    end
    else if (csr_mie_we) begin
        csr_mie_meie <= csr_wdata[11];
        csr_mie_mtie <= csr_wdata[7];
        csr_mie_msie <= csr_wdata[3];
        csr_mie_sbe <= csr_wdata[LOCALINT_SBE];
    end
end

generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_slie_sbe_yes
        reg reg_csr_slie_sbe;
        wire csr_slie_sbe_nx;
        assign csr_slie_sbe_nx = csr_wdata[LOCALINT_SBE] & (csr_mslideleg[LOCALINT_SBE] | cur_privilege_m);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_slie_sbe <= 1'b0;
            end
            else if (csr_slie_we) begin
                reg_csr_slie_sbe <= csr_slie_sbe_nx;
            end
        end

        assign csr_slie_sbe = reg_csr_slie_sbe;
    end
    else begin:gen_csr_slie_sbe_no
        assign csr_slie_sbe = 1'b0;
    end
endgenerate
generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_mie_sxie_yes
        reg reg_csr_mie_seie;
        reg reg_csr_mie_stie;
        reg reg_csr_mie_ssie;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mie_seie <= 1'b0;
                reg_csr_mie_stie <= 1'b0;
                reg_csr_mie_ssie <= 1'b0;
            end
            else if (csr_mie_we | csr_sie_we) begin
                reg_csr_mie_seie <= csr_wdata[9];
                reg_csr_mie_stie <= csr_wdata[5];
                reg_csr_mie_ssie <= csr_wdata[1];
            end
        end

        assign csr_mie_seie = reg_csr_mie_seie;
        assign csr_mie_stie = reg_csr_mie_stie;
        assign csr_mie_ssie = reg_csr_mie_ssie;
    end
    else begin:gen_csr_mie_sxie_no
        assign csr_mie_seie = 1'b0;
        assign csr_mie_stie = 1'b0;
        assign csr_mie_ssie = 1'b0;
    end
endgenerate
generate
    if (((RVN_SUPPORT_INT == 1)) && (NUM_PRIVILEGE_LEVELS > 1)) begin:gen_csr_mie_uxie_yes
        reg reg_csr_mie_ueie;
        reg reg_csr_mie_utie;
        reg reg_csr_mie_usie;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mie_ueie <= 1'b0;
                reg_csr_mie_utie <= 1'b0;
                reg_csr_mie_usie <= 1'b0;
            end
            else if (csr_mie_we | csr_sie_we | csr_uie_we) begin
                reg_csr_mie_ueie <= csr_wdata[8];
                reg_csr_mie_utie <= csr_wdata[4];
                reg_csr_mie_usie <= csr_wdata[0];
            end
        end

        assign csr_mie_ueie = reg_csr_mie_ueie;
        assign csr_mie_utie = reg_csr_mie_utie;
        assign csr_mie_usie = reg_csr_mie_usie;
    end
    else begin:gen_csr_mie_uxie_no
        assign csr_mie_ueie = 1'b0;
        assign csr_mie_utie = 1'b0;
        assign csr_mie_usie = 1'b0;
    end
endgenerate
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        csr_mstatus_mie <= 1'b0;
    end
    else if (csr_mstatus_mie_en) begin
        csr_mstatus_mie <= csr_mstatus_mie_nx;
    end
end

assign csr_mstatus_mie_en = nmi_taken | (trap_taken & ~csr_trap_delegated) | m_trap_return | csr_mstatus_we;
assign csr_mstatus_mie_nx = nmi_taken ? 1'b0 : trap_taken ? 1'b0 : m_trap_return ? csr_mstatus_mpie : csr_wdata[3];
generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_mstatus_sie_yes
        reg reg_csr_mstatus_sie;
        wire csr_mstatus_sie_nx;
        wire csr_mstatus_sie_en;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mstatus_sie <= 1'b0;
            end
            else if (csr_mstatus_sie_en) begin
                reg_csr_mstatus_sie <= csr_mstatus_sie_nx;
            end
        end

        assign csr_mstatus_sie_en = (trap_taken & trap_handled_by_s_mode) | s_trap_return | csr_mstatus_we | csr_sstatus_we;
        assign csr_mstatus_sie_nx = trap_taken ? 1'b0 : s_trap_return ? csr_mstatus_spie : csr_wdata[1];
        assign csr_mstatus_sie = reg_csr_mstatus_sie;
    end
    else begin:gen_csr_mstatus_sie_no
        assign csr_mstatus_sie = 1'b0;
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 1) && ((RVN_SUPPORT_INT == 1))) begin:gen_csr_mstatus_uie_yes
        reg reg_csr_mstatus_uie;
        wire csr_mstatus_uie_nx;
        wire csr_mstatus_uie_en;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mstatus_uie <= 1'b0;
            end
            else if (csr_mstatus_uie_en) begin
                reg_csr_mstatus_uie <= csr_mstatus_uie_nx;
            end
        end

        assign csr_mstatus_uie_en = (trap_taken & trap_handled_by_u_mode) | u_trap_return | csr_mstatus_we | csr_sstatus_we | csr_ustatus_we;
        assign csr_mstatus_uie_nx = trap_taken ? 1'b0 : u_trap_return ? csr_mstatus_upie : csr_wdata[0];
        assign csr_mstatus_uie = reg_csr_mstatus_uie;
    end
    else begin:gen_csr_mstatus_uie_no
        assign csr_mstatus_uie = 1'b0;
    end
endgenerate
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        csr_mstatus_mpie <= 1'b0;
    end
    else if (csr_mstatus_mpie_en) begin
        csr_mstatus_mpie <= csr_mstatus_mpie_nx;
    end
end

assign csr_mstatus_mpie_en = nmi_taken | (trap_taken & ~csr_trap_delegated) | m_trap_return | csr_mstatus_we;
assign csr_mstatus_mpie_nx = nmi_taken ? csr_mstatus_mie : trap_taken ? csr_mstatus_mie : m_trap_return ? 1'b1 : csr_wdata[7];
generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_mstatus_spie_yes
        reg reg_csr_mstatus_spie;
        wire csr_mstatus_spie_nx;
        wire csr_mstatus_spie_en;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mstatus_spie <= 1'b0;
            end
            else if (csr_mstatus_spie_en) begin
                reg_csr_mstatus_spie <= csr_mstatus_spie_nx;
            end
        end

        assign csr_mstatus_spie_en = (trap_taken & trap_handled_by_s_mode) | s_trap_return | csr_mstatus_we | csr_sstatus_we;
        assign csr_mstatus_spie_nx = trap_taken ? csr_mstatus_sie : s_trap_return ? 1'b1 : csr_wdata[5];
        assign csr_mstatus_spie = reg_csr_mstatus_spie;
    end
    else begin:gen_csr_mstatus_spie_no
        assign csr_mstatus_spie = 1'b0;
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 1) && ((RVN_SUPPORT_INT == 1))) begin:gen_csr_mstatus_upie_yes
        reg reg_csr_mstatus_upie;
        wire csr_mstatus_upie_nx;
        wire csr_mstatus_upie_en;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mstatus_upie <= 1'b0;
            end
            else if (csr_mstatus_upie_en) begin
                reg_csr_mstatus_upie <= csr_mstatus_upie_nx;
            end
        end

        assign csr_mstatus_upie_en = (trap_taken & trap_handled_by_u_mode) | u_trap_return | csr_mstatus_we | csr_sstatus_we | csr_ustatus_we;
        assign csr_mstatus_upie_nx = trap_taken ? csr_mstatus_uie : u_trap_return ? 1'b1 : csr_wdata[4];
        assign csr_mstatus_upie = reg_csr_mstatus_upie;
    end
    else begin:gen_csr_mstatus_upie_no
        assign csr_mstatus_upie = 1'b0;
    end
endgenerate
generate
    if (NUM_PRIVILEGE_LEVELS > 1) begin:gen_csr_mstatus_mpp_yes
        reg [1:0] reg_csr_mstatus_mpp;
        wire [1:0] reg_csr_mstatus_mpp_nx;
        wire reg_csr_mstatus_mpp_en;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mstatus_mpp <= PRIVILEGE_MACHINE;
            end
            else if (reg_csr_mstatus_mpp_en) begin
                reg_csr_mstatus_mpp <= reg_csr_mstatus_mpp_nx;
            end
        end

        assign reg_csr_mstatus_mpp_en = nmi_taken | (trap_taken & ~csr_trap_delegated) | m_trap_return | csr_mstatus_we;
        assign reg_csr_mstatus_mpp_nx = nmi_taken ? csr_cur_privilege : trap_taken ? csr_cur_privilege : m_trap_return ? PRIVILEGE_USER : ((NUM_PRIVILEGE_LEVELS > 2) & (csr_wdata[12:11] == PRIVILEGE_HYPERVISOR)) ? PRIVILEGE_SUPERVISOR : (NUM_PRIVILEGE_LEVELS > 2) ? csr_wdata[12:11] : {2{csr_wdata[11]}};
        assign csr_mstatus_mpp = reg_csr_mstatus_mpp;
    end
    else begin:gen_csr_mstatus_mpp_no
        assign csr_mstatus_mpp = PRIVILEGE_MACHINE;
    end
endgenerate
generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_mstatus_spp_yes
        reg reg_csr_mstatus_spp;
        wire reg_csr_mstatus_spp_nx;
        wire reg_csr_mstatus_spp_en;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mstatus_spp <= PRIVILEGE_USER[0];
            end
            else if (reg_csr_mstatus_spp_en) begin
                reg_csr_mstatus_spp <= reg_csr_mstatus_spp_nx;
            end
        end

        assign reg_csr_mstatus_spp_en = (trap_taken & trap_handled_by_s_mode) | s_trap_return | csr_mstatus_we | csr_sstatus_we;
        assign reg_csr_mstatus_spp_nx = trap_taken ? csr_cur_privilege[0] : s_trap_return ? PRIVILEGE_USER[0] : csr_wdata[8];
        assign csr_mstatus_spp = reg_csr_mstatus_spp;
    end
    else begin:gen_csr_mstatus_spp_no
        assign csr_mstatus_spp = PRIVILEGE_USER[0];
    end
endgenerate
generate
    if (NUM_PRIVILEGE_LEVELS > 1) begin:gen_csr_mstatus_mprv_yes
        reg reg_csr_mstatus_mprv;
        wire reg_csr_mstatus_mprv_nx;
        wire reg_csr_mstatus_mprv_en;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mstatus_mprv <= 1'b0;
            end
            else if (reg_csr_mstatus_mprv_en) begin
                reg_csr_mstatus_mprv <= reg_csr_mstatus_mprv_nx;
            end
        end

        assign reg_csr_mstatus_mprv_en = csr_mstatus_we | (halt_return & (csr_dcsr_prv != PRIVILEGE_MACHINE));
        assign reg_csr_mstatus_mprv_nx = halt_return ? 1'b0 : csr_wdata[17];
        assign csr_mstatus_mprv = reg_csr_mstatus_mprv;
    end
    else begin:gen_csr_mstatus_mprv_no
        assign csr_mstatus_mprv = 1'b0;
    end
endgenerate
generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_mstatus_sum_mxr_yes
        reg reg_csr_mstatus_sum;
        reg reg_csr_mstatus_mxr;
        wire csr_mstatus_sum_nx;
        wire csr_mstatus_mxr_nx;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mstatus_sum <= 1'b0;
                reg_csr_mstatus_mxr <= 1'b0;
            end
            else if (csr_mstatus_we | csr_sstatus_we) begin
                reg_csr_mstatus_sum <= csr_mstatus_sum_nx;
                reg_csr_mstatus_mxr <= csr_mstatus_mxr_nx;
            end
        end

        assign csr_mstatus_sum_nx = csr_wdata[18];
        assign csr_mstatus_mxr_nx = csr_wdata[19];
        assign csr_mstatus_sum = reg_csr_mstatus_sum;
        assign csr_mstatus_mxr = reg_csr_mstatus_mxr;
    end
    else begin:gen_csr_mstatus_sum_mxr_no
        assign csr_mstatus_sum = 1'b0;
        assign csr_mstatus_mxr = 1'b0;
    end
endgenerate
generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_mstatus_tvm_tw_tsr_yes
        reg reg_csr_mstatus_tvm;
        reg reg_csr_mstatus_tw;
        reg reg_csr_mstatus_tsr;
        wire csr_mstatus_tvm_nx;
        wire csr_mstatus_tw_nx;
        wire csr_mstatus_tsr_nx;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mstatus_tvm <= 1'b0;
                reg_csr_mstatus_tw <= 1'b0;
                reg_csr_mstatus_tsr <= 1'b0;
            end
            else if (csr_mstatus_we) begin
                reg_csr_mstatus_tvm <= csr_mstatus_tvm_nx;
                reg_csr_mstatus_tw <= csr_mstatus_tw_nx;
                reg_csr_mstatus_tsr <= csr_mstatus_tsr_nx;
            end
        end

        assign csr_mstatus_tvm_nx = csr_wdata[20];
        assign csr_mstatus_tw_nx = csr_wdata[21];
        assign csr_mstatus_tsr_nx = csr_wdata[22];
        assign csr_mstatus_tvm = reg_csr_mstatus_tvm;
        assign csr_mstatus_tw = reg_csr_mstatus_tw;
        assign csr_mstatus_tsr = reg_csr_mstatus_tsr;
    end
    else begin:gen_csr_mstatus_tvm_tw_tsr_no
        assign csr_mstatus_tvm = 1'b0;
        assign csr_mstatus_tw = 1'b0;
        assign csr_mstatus_tsr = 1'b0;
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 2) || ((NUM_PRIVILEGE_LEVELS == 2) && ((RVN_SUPPORT_INT == 1)))) begin:gen_csr_mstatus_medeleg_yes
        reg reg_csr_medeleg_iam;
        reg reg_csr_medeleg_iaf;
        reg reg_csr_medeleg_ii;
        reg reg_csr_medeleg_b;
        reg reg_csr_medeleg_lam;
        reg reg_csr_medeleg_laf;
        reg reg_csr_medeleg_sam;
        reg reg_csr_medeleg_saf;
        reg reg_csr_medeleg_uec;
        reg reg_csr_medeleg_ipf;
        reg reg_csr_medeleg_lpf;
        reg reg_csr_medeleg_spf;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_medeleg_iam <= 1'b0;
                reg_csr_medeleg_iaf <= 1'b0;
                reg_csr_medeleg_ii <= 1'b0;
                reg_csr_medeleg_b <= 1'b0;
                reg_csr_medeleg_lam <= 1'b0;
                reg_csr_medeleg_laf <= 1'b0;
                reg_csr_medeleg_sam <= 1'b0;
                reg_csr_medeleg_saf <= 1'b0;
                reg_csr_medeleg_uec <= 1'b0;
                reg_csr_medeleg_ipf <= 1'b0;
                reg_csr_medeleg_lpf <= 1'b0;
                reg_csr_medeleg_spf <= 1'b0;
            end
            else if (csr_medeleg_we) begin
                reg_csr_medeleg_iam <= csr_wdata[0];
                reg_csr_medeleg_iaf <= csr_wdata[1];
                reg_csr_medeleg_ii <= csr_wdata[2];
                reg_csr_medeleg_b <= csr_wdata[3];
                reg_csr_medeleg_lam <= csr_wdata[4];
                reg_csr_medeleg_laf <= csr_wdata[5];
                reg_csr_medeleg_sam <= csr_wdata[6];
                reg_csr_medeleg_saf <= csr_wdata[7];
                reg_csr_medeleg_uec <= csr_wdata[8];
                reg_csr_medeleg_ipf <= csr_wdata[12];
                reg_csr_medeleg_lpf <= csr_wdata[13];
                reg_csr_medeleg_spf <= csr_wdata[15];
            end
        end

        assign csr_medeleg_iam = reg_csr_medeleg_iam;
        assign csr_medeleg_iaf = reg_csr_medeleg_iaf;
        assign csr_medeleg_ii = reg_csr_medeleg_ii;
        assign csr_medeleg_b = reg_csr_medeleg_b;
        assign csr_medeleg_lam = reg_csr_medeleg_lam;
        assign csr_medeleg_laf = reg_csr_medeleg_laf;
        assign csr_medeleg_sam = reg_csr_medeleg_sam;
        assign csr_medeleg_saf = reg_csr_medeleg_saf;
        assign csr_medeleg_uec = reg_csr_medeleg_uec;
        assign csr_medeleg_ipf = reg_csr_medeleg_ipf;
        assign csr_medeleg_lpf = reg_csr_medeleg_lpf;
        assign csr_medeleg_spf = reg_csr_medeleg_spf;
    end
    else begin:gen_csr_mstatus_medeleg_no
        assign csr_medeleg_iam = 1'b0;
        assign csr_medeleg_iaf = 1'b0;
        assign csr_medeleg_ii = 1'b0;
        assign csr_medeleg_b = 1'b0;
        assign csr_medeleg_lam = 1'b0;
        assign csr_medeleg_laf = 1'b0;
        assign csr_medeleg_sam = 1'b0;
        assign csr_medeleg_saf = 1'b0;
        assign csr_medeleg_uec = 1'b0;
        assign csr_medeleg_ipf = 1'b0;
        assign csr_medeleg_lpf = 1'b0;
        assign csr_medeleg_spf = 1'b0;
    end
endgenerate
generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_medeleg_sec_yes
        reg reg_csr_medeleg_sec;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_medeleg_sec <= 1'b0;
            end
            else if (csr_medeleg_we) begin
                reg_csr_medeleg_sec <= csr_wdata[9];
            end
        end

        assign csr_medeleg_sec = reg_csr_medeleg_sec;
    end
    else begin:gen_csr_medeleg_sec_no
        assign csr_medeleg_sec = 1'b0;
    end
endgenerate
generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_mideleg_s_mode_yes
        reg reg_csr_mideleg_ssi;
        reg reg_csr_mideleg_sti;
        reg reg_csr_mideleg_sei;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mideleg_ssi <= 1'b0;
                reg_csr_mideleg_sti <= 1'b0;
                reg_csr_mideleg_sei <= 1'b0;
            end
            else if (csr_mideleg_we) begin
                reg_csr_mideleg_ssi <= csr_wdata[1];
                reg_csr_mideleg_sti <= csr_wdata[5];
                reg_csr_mideleg_sei <= csr_wdata[9];
            end
        end

        assign csr_mideleg_ssi = reg_csr_mideleg_ssi;
        assign csr_mideleg_sti = reg_csr_mideleg_sti;
        assign csr_mideleg_sei = reg_csr_mideleg_sei;
    end
    else begin:gen_csr_mideleg_s_mode_no
        assign csr_mideleg_ssi = 1'b0;
        assign csr_mideleg_sti = 1'b0;
        assign csr_mideleg_sei = 1'b0;
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 1) && ((RVN_SUPPORT_INT == 1))) begin:gen_csr_mideleg_u_mode_yes
        reg reg_csr_mideleg_usi;
        reg reg_csr_mideleg_uti;
        reg reg_csr_mideleg_uei;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mideleg_usi <= 1'b0;
                reg_csr_mideleg_uti <= 1'b0;
                reg_csr_mideleg_uei <= 1'b0;
            end
            else if (csr_mideleg_we) begin
                reg_csr_mideleg_usi <= csr_wdata[0];
                reg_csr_mideleg_uti <= csr_wdata[4];
                reg_csr_mideleg_uei <= csr_wdata[8];
            end
        end

        assign csr_mideleg_usi = reg_csr_mideleg_usi;
        assign csr_mideleg_uti = reg_csr_mideleg_uti;
        assign csr_mideleg_uei = reg_csr_mideleg_uei;
    end
    else begin:gen_csr_mideleg_u_mode_no
        assign csr_mideleg_usi = 1'b0;
        assign csr_mideleg_uti = 1'b0;
        assign csr_mideleg_uei = 1'b0;
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 2) && (PERFORMANCE_MONITOR_INT == 1)) begin:gen_csr_mslideleg_hpmint_yes
        reg reg_csr_mslideleg_hpmint;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mslideleg_hpmint <= 1'b0;
            end
            else if (csr_mslideleg_we) begin
                reg_csr_mslideleg_hpmint <= csr_wdata[LOCALINT_HPMINT];
            end
        end

        assign csr_mslideleg_hpmint = reg_csr_mslideleg_hpmint;
    end
    else begin:gen_csr_mslideleg_hpmint_no
        assign csr_mslideleg_hpmint = 1'b0;
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 2) && ((ACE_SUPPORT_INT == 1))) begin:gen_csr_mslideleg_aceerr_yes
        reg reg_csr_mslideleg_aceerr;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mslideleg_aceerr <= 1'b0;
            end
            else if (csr_mslideleg_we) begin
                reg_csr_mslideleg_aceerr <= csr_wdata[LOCALINT_ACEERR];
            end
        end

        assign csr_mslideleg_aceerr = reg_csr_mslideleg_aceerr;
    end
    else begin:gen_csr_mslideleg_aceerr_no
        assign csr_mslideleg_aceerr = 1'b0;
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 2) && ((SLPECC_SUPPORT_INT == 1))) begin:gen_csr_mslideleg_slpecc_yes
        reg reg_csr_mslideleg_slpecc;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mslideleg_slpecc <= 1'b0;
            end
            else if (csr_mslideleg_we) begin
                reg_csr_mslideleg_slpecc <= csr_wdata[LOCALINT_SLPECC];
            end
        end

        assign csr_mslideleg_slpecc = reg_csr_mslideleg_slpecc;
    end
    else begin:gen_csr_mslideleg_slpecc_no
        assign csr_mslideleg_slpecc = 1'b0;
    end
endgenerate
generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_mslideleg_sbe_yes
        reg reg_csr_mslideleg_sbe;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_mslideleg_sbe <= 1'b0;
            end
            else if (csr_mslideleg_we) begin
                reg_csr_mslideleg_sbe <= csr_wdata[LOCALINT_SBE];
            end
        end

        assign csr_mslideleg_sbe = reg_csr_mslideleg_sbe;
    end
    else begin:gen_csr_mslideleg_sbe_no
        assign csr_mslideleg_sbe = 1'b0;
    end
endgenerate
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        csr_mtvec_addr <= {(VALEN - 2){1'b0}};
    end
    else if (csr_mtvec_we) begin
        csr_mtvec_addr <= csr_wdata[VALEN - 1:2];
    end
end

generate
    if ((NUM_PRIVILEGE_LEVELS > 2) && ((RVN_SUPPORT_INT == 1))) begin:gen_csr_sedeleg_yes
        reg reg_csr_sedeleg_iam;
        reg reg_csr_sedeleg_iaf;
        reg reg_csr_sedeleg_ii;
        reg reg_csr_sedeleg_b;
        reg reg_csr_sedeleg_lam;
        reg reg_csr_sedeleg_laf;
        reg reg_csr_sedeleg_sam;
        reg reg_csr_sedeleg_saf;
        reg reg_csr_sedeleg_uec;
        reg reg_csr_sedeleg_ipf;
        reg reg_csr_sedeleg_lpf;
        reg reg_csr_sedeleg_spf;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_sedeleg_iam <= 1'b0;
                reg_csr_sedeleg_iaf <= 1'b0;
                reg_csr_sedeleg_ii <= 1'b0;
                reg_csr_sedeleg_b <= 1'b0;
                reg_csr_sedeleg_lam <= 1'b0;
                reg_csr_sedeleg_laf <= 1'b0;
                reg_csr_sedeleg_sam <= 1'b0;
                reg_csr_sedeleg_saf <= 1'b0;
                reg_csr_sedeleg_uec <= 1'b0;
                reg_csr_sedeleg_ipf <= 1'b0;
                reg_csr_sedeleg_lpf <= 1'b0;
                reg_csr_sedeleg_spf <= 1'b0;
            end
            else if (csr_sedeleg_we) begin
                reg_csr_sedeleg_iam <= csr_wdata[0];
                reg_csr_sedeleg_iaf <= csr_wdata[1];
                reg_csr_sedeleg_ii <= csr_wdata[2];
                reg_csr_sedeleg_b <= csr_wdata[3];
                reg_csr_sedeleg_lam <= csr_wdata[4];
                reg_csr_sedeleg_laf <= csr_wdata[5];
                reg_csr_sedeleg_sam <= csr_wdata[6];
                reg_csr_sedeleg_saf <= csr_wdata[7];
                reg_csr_sedeleg_uec <= csr_wdata[8];
                reg_csr_sedeleg_ipf <= csr_wdata[12];
                reg_csr_sedeleg_lpf <= csr_wdata[13];
                reg_csr_sedeleg_spf <= csr_wdata[15];
            end
        end

        assign csr_sedeleg_iam = reg_csr_sedeleg_iam;
        assign csr_sedeleg_iaf = reg_csr_sedeleg_iaf;
        assign csr_sedeleg_ii = reg_csr_sedeleg_ii;
        assign csr_sedeleg_b = reg_csr_sedeleg_b;
        assign csr_sedeleg_lam = reg_csr_sedeleg_lam;
        assign csr_sedeleg_laf = reg_csr_sedeleg_laf;
        assign csr_sedeleg_sam = reg_csr_sedeleg_sam;
        assign csr_sedeleg_saf = reg_csr_sedeleg_saf;
        assign csr_sedeleg_uec = reg_csr_sedeleg_uec;
        assign csr_sedeleg_ipf = reg_csr_sedeleg_ipf;
        assign csr_sedeleg_lpf = reg_csr_sedeleg_lpf;
        assign csr_sedeleg_spf = reg_csr_sedeleg_spf;
        assign csr_sedeleg = {{16{1'b0}},csr_sedeleg_spf,1'b0,csr_sedeleg_lpf,csr_sedeleg_ipf,2'b0,1'b0,csr_sedeleg_uec,csr_sedeleg_saf,csr_sedeleg_sam,csr_sedeleg_laf,csr_sedeleg_lam,csr_sedeleg_b,csr_sedeleg_ii,csr_sedeleg_iaf,csr_sedeleg_iam};
    end
    else if ((NUM_PRIVILEGE_LEVELS > 2) && ((RVN_SUPPORT_INT == 0))) begin:gen_csr_sedeleg_0
        assign csr_sedeleg_iam = 1'b0;
        assign csr_sedeleg_iaf = 1'b0;
        assign csr_sedeleg_ii = 1'b0;
        assign csr_sedeleg_b = 1'b0;
        assign csr_sedeleg_lam = 1'b0;
        assign csr_sedeleg_laf = 1'b0;
        assign csr_sedeleg_sam = 1'b0;
        assign csr_sedeleg_saf = 1'b0;
        assign csr_sedeleg_uec = 1'b0;
        assign csr_sedeleg_ipf = 1'b0;
        assign csr_sedeleg_lpf = 1'b0;
        assign csr_sedeleg_spf = 1'b0;
        assign csr_sedeleg = {32{1'b0}};
        wire nds_unused_sedeleg_signals = |{csr_sedeleg_iam,csr_sedeleg_iaf,csr_sedeleg_ii,csr_sedeleg_b,csr_sedeleg_lam,csr_sedeleg_laf,csr_sedeleg_sam,csr_sedeleg_saf,csr_sedeleg_uec,csr_sedeleg_ipf,csr_sedeleg_lpf,csr_sedeleg_spf};
    end
    else begin:gen_csr_sedeleg_imply_1
        assign csr_sedeleg_iam = 1'b1;
        assign csr_sedeleg_iaf = 1'b1;
        assign csr_sedeleg_ii = 1'b1;
        assign csr_sedeleg_b = 1'b1;
        assign csr_sedeleg_lam = 1'b1;
        assign csr_sedeleg_laf = 1'b1;
        assign csr_sedeleg_sam = 1'b1;
        assign csr_sedeleg_saf = 1'b1;
        assign csr_sedeleg_uec = 1'b1;
        assign csr_sedeleg_ipf = 1'b1;
        assign csr_sedeleg_lpf = 1'b1;
        assign csr_sedeleg_spf = 1'b1;
        assign csr_sedeleg = {32{1'b1}};
        wire nds_unused_sedeleg_signals = |{csr_sedeleg_iam,csr_sedeleg_iaf,csr_sedeleg_ii,csr_sedeleg_b,csr_sedeleg_lam,csr_sedeleg_laf,csr_sedeleg_sam,csr_sedeleg_saf,csr_sedeleg_uec,csr_sedeleg_ipf,csr_sedeleg_lpf,csr_sedeleg_spf};
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 2) && ((RVN_SUPPORT_INT == 1))) begin:gen_csr_sideleg_yes
        reg reg_csr_sideleg_usi;
        reg reg_csr_sideleg_uti;
        reg reg_csr_sideleg_uei;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_sideleg_usi <= 1'b0;
                reg_csr_sideleg_uti <= 1'b0;
                reg_csr_sideleg_uei <= 1'b0;
            end
            else if (csr_sideleg_we) begin
                reg_csr_sideleg_usi <= csr_wdata[0];
                reg_csr_sideleg_uti <= csr_wdata[4];
                reg_csr_sideleg_uei <= csr_wdata[8];
            end
        end

        assign csr_sideleg = {{23{1'b0}},reg_csr_sideleg_uei,3'b0,reg_csr_sideleg_uti,3'b0,reg_csr_sideleg_usi};
    end
    else if ((NUM_PRIVILEGE_LEVELS > 2) && ((RVN_SUPPORT_INT == 0))) begin:gen_csr_sideleg_0
        assign csr_sideleg = {32{1'b0}};
    end
    else begin:gen_csr_sideleg_imply_1
        assign csr_sideleg = {32{1'b1}};
    end
endgenerate
generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_stvec_addr_yes
        reg [EXTVALEN - 1:2] reg_csr_stvec_addr;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_stvec_addr <= {(EXTVALEN - 2){1'b0}};
            end
            else if (csr_stvec_we) begin
                reg_csr_stvec_addr <= csr_wdata[EXTVALEN - 1:2];
            end
        end

        assign csr_stvec[EXTVALEN - 1:0] = {reg_csr_stvec_addr,2'b0};
    end
    else begin:gen_csr_stvec_addr_no
        assign csr_stvec[EXTVALEN - 1:0] = {EXTVALEN{1'b0}};
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 1) && ((RVN_SUPPORT_INT == 1))) begin:gen_csr_utvec_addr_yes
        reg [EXTVALEN - 1:2] reg_csr_utvec_addr;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_utvec_addr <= {(EXTVALEN - 2){1'b0}};
            end
            else if (csr_utvec_we) begin
                reg_csr_utvec_addr <= csr_wdata[EXTVALEN - 1:2];
            end
        end

        assign csr_utvec[EXTVALEN - 1:0] = {reg_csr_utvec_addr,2'b0};
    end
    else begin:gen_csr_utvec_addr_no
        assign csr_utvec[EXTVALEN - 1:0] = {EXTVALEN{1'b0}};
    end
endgenerate
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        reg_csr_mepc_addr <= {(EXTVALEN - 1){1'b0}};
    end
    else if (csr_mepc_addr_we) begin
        reg_csr_mepc_addr <= reg_csr_mepc_addr_nx;
    end
end

assign csr_mepc[EXTVALEN - 1:0] = {reg_csr_mepc_addr,1'b0};
generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_sepc_addr_yes
        wire [EXTVALEN - 1:1] csr_sepc_addr_nx;
        wire csr_sepc_addr_we;
        reg [EXTVALEN - 1:1] reg_csr_sepc;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_sepc <= {(EXTVALEN - 1){1'b0}};
            end
            else if (csr_sepc_addr_we) begin
                reg_csr_sepc <= csr_sepc_addr_nx;
            end
        end

        assign csr_sepc_addr_nx[EXTVALEN - 1:2] = (ipipe_csr_epc_we & trap_handled_by_s_mode) ? ipipe_csr_epc_wdata[EXTVALEN - 1:2] : csr_wdata[EXTVALEN - 1:2];
        assign csr_sepc_addr_nx[1] = (ipipe_csr_epc_we & trap_handled_by_s_mode) ? ipipe_csr_epc_wdata[1] : csr_wdata[1];
        assign csr_sepc_addr_we = (ipipe_csr_epc_we & trap_handled_by_s_mode) | csr_sepc_we;
        assign csr_sepc[EXTVALEN - 1:0] = {reg_csr_sepc,1'b0};
    end
    else begin:gen_csr_sepc_addr_no
        assign csr_sepc[EXTVALEN - 1:0] = {EXTVALEN{1'b0}};
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 1) && ((RVN_SUPPORT_INT == 1))) begin:gen_csr_uepc_addr_yes
        wire [EXTVALEN - 1:1] csr_uepc_addr_nx;
        wire csr_uepc_addr_we;
        reg [EXTVALEN - 1:1] reg_csr_uepc;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_csr_uepc <= {(EXTVALEN - 1){1'b0}};
            end
            else if (csr_uepc_addr_we) begin
                reg_csr_uepc <= csr_uepc_addr_nx;
            end
        end

        assign csr_uepc_addr_nx[EXTVALEN - 1:2] = (ipipe_csr_epc_we & trap_handled_by_u_mode) ? ipipe_csr_epc_wdata[EXTVALEN - 1:2] : csr_wdata[EXTVALEN - 1:2];
        assign csr_uepc_addr_nx[1] = (ipipe_csr_epc_we & trap_handled_by_u_mode) ? ipipe_csr_epc_wdata[1] : csr_wdata[1];
        assign csr_uepc_addr_we = (ipipe_csr_epc_we & trap_handled_by_u_mode) | csr_uepc_we;
        assign csr_uepc[EXTVALEN - 1:0] = {reg_csr_uepc,1'b0};
    end
    else begin:gen_csr_uepc_addr_no
        assign csr_uepc[EXTVALEN - 1:0] = {EXTVALEN{1'b0}};
    end
endgenerate
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        reg_mtval_addr <= {EXTVALEN{1'b0}};
    end
    else if (csr_mtval_en) begin
        reg_mtval_addr <= reg_mtval_addr_nx;
    end
end

wire [EXTVALEN - 1:0] ipipe_csr_tval_satp_wdata;
generate
    if (EXTVALEN > 39) begin:gen_extvalen_gt39
        wire bad_va = ipipe_csr_tval_wdata[38] ? (&ipipe_csr_tval_wdata[EXTVALEN - 1:39]) : (|ipipe_csr_tval_wdata[EXTVALEN - 1:39]);
        assign ipipe_csr_tval_satp_wdata[EXTVALEN - 1:39] = (csr_satp_mode == SATP_MODE_SV39) ? {(EXTVALEN - 39){bad_va}} : ipipe_csr_tval_wdata[EXTVALEN - 1:39];
        assign ipipe_csr_tval_satp_wdata[38:0] = ipipe_csr_tval_wdata[38:0];
    end
    else begin:gen_extvalen_le39
        assign ipipe_csr_tval_satp_wdata = ipipe_csr_tval_wdata[EXTVALEN - 1:0];
    end
endgenerate
assign reg_mtval_addr_nx = ipipe_csr_tval_we ? ipipe_csr_tval_satp_wdata[EXTVALEN - 1:0] : csr_wdata[EXTVALEN - 1:0];
assign csr_mtval_en = csr_mtval_we | (ipipe_csr_tval_we & ~csr_trap_delegated);
assign csr_mtval[EXTVALEN - 1:0] = reg_mtval_addr;
generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_stval_yes
        wire csr_stval_en;
        wire [EXTVALEN - 1:0] reg_stval_addr_nx;
        reg [EXTVALEN - 1:0] reg_stval_addr;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_stval_addr <= {EXTVALEN{1'b0}};
            end
            else if (csr_stval_en) begin
                reg_stval_addr <= reg_stval_addr_nx;
            end
        end

        assign reg_stval_addr_nx = ipipe_csr_tval_we ? ipipe_csr_tval_satp_wdata[EXTVALEN - 1:0] : csr_wdata[EXTVALEN - 1:0];
        assign csr_stval_en = csr_stval_we | (ipipe_csr_tval_we & trap_handled_by_s_mode);
        assign csr_stval[EXTVALEN - 1:0] = reg_stval_addr;
    end
    else begin:gen_csr_stval_no
        assign csr_stval[EXTVALEN - 1:0] = {EXTVALEN{1'b0}};
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 1) && ((RVN_SUPPORT_INT == 1))) begin:gen_csr_utval_yes
        wire csr_utval_en;
        wire [EXTVALEN - 1:0] reg_utval_addr_nx;
        reg [EXTVALEN - 1:0] reg_utval_addr;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_utval_addr <= {EXTVALEN{1'b0}};
            end
            else if (csr_utval_en) begin
                reg_utval_addr <= reg_utval_addr_nx;
            end
        end

        assign reg_utval_addr_nx = ipipe_csr_tval_we ? ipipe_csr_tval_satp_wdata[EXTVALEN - 1:0] : csr_wdata[EXTVALEN - 1:0];
        assign csr_utval_en = csr_utval_we | (ipipe_csr_tval_we & trap_handled_by_u_mode);
        assign csr_utval[EXTVALEN - 1:0] = reg_utval_addr;
    end
    else begin:gen_csr_utval_no
        assign csr_utval[EXTVALEN - 1:0] = {EXTVALEN{1'b0}};
    end
endgenerate
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        csr_mcause_interrupt <= 1'b0;
        csr_mcause_code <= 10'b0;
    end
    else if (csr_mcause_en) begin
        csr_mcause_interrupt <= csr_mcause_interrupt_nx;
        csr_mcause_code <= csr_mcause_code_nx;
    end
end

assign csr_mcause_en = (ipipe_csr_cause_we & ~csr_trap_delegated) | csr_mcause_we;
assign csr_mcause_interrupt_nx = ipipe_csr_cause_we ? ipipe_csr_cause_interrupt : csr_wdata[31];
assign csr_mcause_code_nx = ipipe_csr_cause_we ? ipipe_csr_cause_code : csr_wdata[9:0];
generate
    if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_csr_scause_yes
        wire csr_scause_en;
        wire csr_scause_interrupt_nx;
        reg csr_scause_interrupt;
        reg [9:0] csr_scause_code;
        wire [9:0] csr_scause_code_nx;
        reg [2:0] reg_sdcause;
        reg [1:0] reg_sdcause_pm;
        wire csr_sdcause_en;
        wire [2:0] csr_sdcause_nx;
        wire [1:0] csr_sdcause_pm_nx;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                csr_scause_interrupt <= 1'b0;
                csr_scause_code <= 10'b0;
            end
            else if (csr_scause_en) begin
                csr_scause_interrupt <= csr_scause_interrupt_nx;
                csr_scause_code <= csr_scause_code_nx;
            end
        end

        assign csr_scause_en = (ipipe_csr_cause_we & trap_handled_by_s_mode) | csr_scause_we;
        assign csr_scause_interrupt_nx = ipipe_csr_cause_we ? ipipe_csr_cause_interrupt : csr_wdata[31];
        assign csr_scause_code_nx = ipipe_csr_cause_we ? ipipe_csr_cause_code : csr_wdata[9:0];
        assign csr_scause = {csr_scause_interrupt,{21{1'b0}},csr_scause_code};
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_sdcause <= 3'b0;
                reg_sdcause_pm <= 2'b0;
            end
            else if (csr_sdcause_en) begin
                reg_sdcause <= csr_sdcause_nx;
                reg_sdcause_pm <= csr_sdcause_pm_nx;
            end
        end

        assign csr_sdcause_en = (ipipe_csr_cause_detail_we & trap_handled_by_s_mode) | csr_sdcause_we;
        assign {csr_sdcause_pm_nx,csr_sdcause_nx} = ipipe_csr_cause_detail_we ? {ipipe_csr_cause_detail_pm[1:0],ipipe_csr_cause_detail[2:0]} : {csr_wdata[6:5],csr_wdata[2:0]};
        assign csr_sdcause = {{25{1'b0}},reg_sdcause_pm,2'b00,reg_sdcause};
    end
    else begin:gen_csr_scause_no
        assign csr_scause = {32{1'b0}};
        assign csr_sdcause = {32{1'b0}};
    end
endgenerate
generate
    if ((NUM_PRIVILEGE_LEVELS > 1) && ((RVN_SUPPORT_INT == 1))) begin:gen_csr_ucause_udcause_yes
        wire csr_ucause_en;
        wire csr_ucause_interrupt_nx;
        reg csr_ucause_interrupt;
        reg [9:0] csr_ucause_code;
        wire [9:0] csr_ucause_code_nx;
        reg [2:0] reg_udcause;
        wire csr_udcause_en;
        wire [2:0] csr_udcause_nx;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                csr_ucause_interrupt <= 1'b0;
                csr_ucause_code <= 10'b0;
            end
            else if (csr_ucause_en) begin
                csr_ucause_interrupt <= csr_ucause_interrupt_nx;
                csr_ucause_code <= csr_ucause_code_nx;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_udcause <= 3'b0;
            end
            else if (csr_udcause_en) begin
                reg_udcause <= csr_udcause_nx;
            end
        end

        assign csr_ucause_en = (ipipe_csr_cause_we & trap_handled_by_u_mode) | csr_ucause_we;
        assign csr_ucause_interrupt_nx = ipipe_csr_cause_we ? ipipe_csr_cause_interrupt : csr_wdata[31];
        assign csr_ucause_code_nx = ipipe_csr_cause_we ? ipipe_csr_cause_code : csr_wdata[9:0];
        assign csr_ucause = {csr_ucause_interrupt,{21{1'b0}},csr_ucause_code};
        assign csr_udcause_en = (ipipe_csr_cause_detail_we & trap_handled_by_u_mode) | csr_udcause_we;
        assign csr_udcause_nx = ipipe_csr_cause_detail_we ? ipipe_csr_cause_detail[2:0] : csr_wdata[2:0];
        assign csr_udcause = {{29{1'b0}},reg_udcause};
    end
    else begin:gen_csr_ucause_no
        assign csr_ucause = {32{1'b0}};
        assign csr_udcause = {32{1'b0}};
    end
endgenerate
generate
    if ((VECTOR_PLIC_SUPPORT_INT == 1)) begin:gen_vec_plic_support
        reg reg_mmisc_ctl_vec_plic;
        reg [9:0] reg_meiid;
        wire reg_meiid_en;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mmisc_ctl_vec_plic <= 1'b0;
            end
            else if (csr_mmisc_ctl_we) begin
                reg_mmisc_ctl_vec_plic <= csr_wdata[1];
            end
        end

        always @(posedge core_clk) begin
            if (reg_meiid_en) begin
                reg_meiid <= meiid;
            end
        end

        assign reg_meiid_en = csr_mmisc_ctl_vec_plic & meip;
        assign csr_meiid = reg_meiid;
        assign csr_mmisc_ctl_vec_plic = reg_mmisc_ctl_vec_plic;
    end
    else begin:gen_vec_plic_no_support
        assign csr_mmisc_ctl_vec_plic = 1'b0;
        assign csr_meiid = 10'd0;
    end
endgenerate
generate
    if ((ISA_ANDES_INT == 1)) begin:gen_csr_mmisc_ctl_rvcompm_reg
        reg reg_mmisc_ctl_rvcompm;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mmisc_ctl_rvcompm <= 1'b0;
            end
            else if (csr_mmisc_ctl_we) begin
                reg_mmisc_ctl_rvcompm <= csr_wdata[2];
            end
        end

        assign csr_mmisc_ctl_rvcompm = reg_mmisc_ctl_rvcompm;
    end
    else begin:gen_csr_mmisc_ctl_rvcompm
        assign csr_mmisc_ctl_rvcompm = 1'b0;
    end
endgenerate
generate
    if ((BRANCH_PREDICTION_INT != 0)) begin:gen_reg_mmisc_ctl_brpe
        reg reg_mmisc_ctl_brpe;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mmisc_ctl_brpe <= 1'b1;
            end
            else if (csr_mmisc_ctl_we) begin
                reg_mmisc_ctl_brpe <= csr_wdata[3];
            end
        end

        assign csr_mmisc_ctl_brpe = reg_mmisc_ctl_brpe;
    end
    else begin:gen_csr_mmisc_ctl_brpe
        assign csr_mmisc_ctl_brpe = 1'b0;
    end
endgenerate
generate
    if ((UNALIGNED_ACCESS_INT == 1)) begin:gen_reg_mmisc_ctl_una
        reg reg_mmisc_ctl_una;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mmisc_ctl_una <= 1'b1;
            end
            else if (csr_mmisc_ctl_we) begin
                reg_mmisc_ctl_una <= csr_wdata[6];
            end
        end

        assign csr_mmisc_ctl_una = reg_mmisc_ctl_una;
    end
    else begin:gen_csr_mmisc_ctl_una
        assign csr_mmisc_ctl_una = 1'b0;
    end
endgenerate
reg reg_mmisc_ctl_nbcache_en;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        reg_mmisc_ctl_nbcache_en <= 1'b0;
    end
    else if (csr_mmisc_ctl_we) begin
        reg_mmisc_ctl_nbcache_en <= csr_wdata[8];
    end
end

assign csr_mmisc_ctl_nbcache_en = reg_mmisc_ctl_nbcache_en;
generate
    if ((ACE_SUPPORT_INT == 1)) begin:gen_aces_reg
        reg [1:0] reg_mmisc_ctl_aces;
        wire mmisc_ctl_aces_we = csr_mmisc_ctl_we | csr_smisc_ctl_we | ace_acr_dirty_set;
        wire [1:0] mmisc_ctl_aces_nx;
        assign mmisc_ctl_aces_nx = ace_acr_dirty_set ? 2'd3 : csr_wdata[5:4];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mmisc_ctl_aces <= 2'b0;
            end
            else if (mmisc_ctl_aces_we) begin
                reg_mmisc_ctl_aces <= mmisc_ctl_aces_nx;
            end
        end

        assign csr_mmisc_ctl_aces = reg_mmisc_ctl_aces;
    end
    else begin:gen_no_aces_reg
        assign csr_mmisc_ctl_aces = 2'b0;
        wire nds_unused_ace_acr_dirty_set = ace_acr_dirty_set;
    end
endgenerate
generate
    if (FLEN != 1) begin:gen_fpu_status_reg
        reg [1:0] reg_fpu_status;
        wire [1:0] reg_fpu_status_nx;
        wire reg_fpu_status_we;
        wire csr_mstatus_update_en = csr_mstatus_we | csr_sstatus_we;
        wire csr_fcsr_update_en = csr_fcsr_we | csr_fflags_we | csr_frm_we;
        assign reg_fpu_status_we = csr_mstatus_update_en | csr_fcsr_update_en | ipipe_csr_fs_wen;
        assign reg_fpu_status_nx = csr_mstatus_update_en ? csr_wdata[14:13] : csr_fcsr_update_en ? STATE_DIRTY : STATE_DIRTY;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_fpu_status <= STATE_OFF;
            end
            else if (reg_fpu_status_we) begin
                reg_fpu_status <= reg_fpu_status_nx;
            end
        end

        assign fpu_status = reg_fpu_status;
    end
    else begin:gen_no_fpu_status_reg
        assign fpu_status = 2'b0;
    end
endgenerate
generate
    if ((ILM_SIZE_KB != 0) && ((LM_ENABLE_CTRL_INT == 1))) begin:gen_ilm_ctrl_enable
        reg reg_milmb_ien;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_milmb_ien <= 1'b0;
            end
            else if (csr_milmb_we) begin
                reg_milmb_ien <= csr_wdata[0];
            end
        end

        assign csr_milmb_ien = reg_milmb_ien;
    end
    else begin:gen_ilm_ctrl_disable
        assign csr_milmb_ien = (ILM_SIZE_KB != 0);
    end
endgenerate
generate
    if (ILM_ECC_TYPE_INT != 0) begin:gen_ilm_ecc_regs
        reg [1:0] reg_milmb_eccen;
        reg reg_milmb_rwecc;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_milmb_eccen <= 2'd0;
                reg_milmb_rwecc <= 1'b0;
            end
            else if (csr_milmb_we) begin
                reg_milmb_eccen <= csr_wdata[2:1];
                reg_milmb_rwecc <= csr_wdata[3];
            end
        end

        assign csr_milmb_eccen = reg_milmb_eccen;
        assign csr_milmb_rwecc = reg_milmb_rwecc;
    end
    else begin:gen_no_ilm_ecc_regs
        assign csr_milmb_eccen = 2'd0;
        assign csr_milmb_rwecc = 1'b0;
    end
endgenerate
generate
    if ((DLM_SIZE_KB != 0) && ((LM_ENABLE_CTRL_INT == 1))) begin:gen_dlm_ctrl_enable
        reg reg_mdlmb_den;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mdlmb_den <= 1'b0;
            end
            else if (csr_mdlmb_we) begin
                reg_mdlmb_den <= csr_wdata[0];
            end
        end

        assign csr_mdlmb_den = reg_mdlmb_den;
    end
    else begin:gen_dlm_ctrl_disable
        assign csr_mdlmb_den = (DLM_SIZE_KB != 0);
    end
endgenerate
generate
    if (DLM_ECC_TYPE_INT != 0) begin:gen_dlm_ecc_regs
        reg [1:0] reg_mdlmb_eccen;
        reg reg_mdlmb_rwecc;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mdlmb_eccen <= 2'd0;
                reg_mdlmb_rwecc <= 1'b0;
            end
            else if (csr_mdlmb_we) begin
                reg_mdlmb_eccen <= csr_wdata[2:1];
                reg_mdlmb_rwecc <= csr_wdata[3];
            end
        end

        assign csr_mdlmb_eccen = reg_mdlmb_eccen;
        assign csr_mdlmb_rwecc = reg_mdlmb_rwecc;
    end
    else begin:gen_no_dlm_ecc_regs
        assign csr_mdlmb_eccen = 2'd0;
        assign csr_mdlmb_rwecc = 1'b0;
    end
endgenerate
generate
    if (ECC_SUPPORT_INT == 1) begin:gen_reg_mecc_code
        wire reg_mecc_code_en;
        reg [ECC_CODE_LEN - 1:0] reg_mecc_code;
        reg reg_mecc_code_c;
        reg [3:0] reg_mecc_code_ramid;
        reg reg_mecc_code_fetch;
        wire reg_mecc_code_status_en;
        reg reg_mecc_code_p;
        wire [ECC_CODE_LEN - 1:0] mecc_code_nx;
        assign reg_mecc_code_en = ipipe_csr_ecc_code_en | csr_mecc_code_we;
        assign mecc_code_nx = ipipe_csr_ecc_code_en ? ipipe_csr_ecc_code[ECC_CODE_LEN - 1:0] : csr_wdata[ECC_CODE_LEN - 1:0];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mecc_code <= {ECC_CODE_LEN{1'd0}};
            end
            else if (reg_mecc_code_en) begin
                reg_mecc_code <= mecc_code_nx[ECC_CODE_LEN - 1:0];
            end
        end

        assign reg_mecc_code_status_en = ecc_trap_taken;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mecc_code_c <= 1'b0;
                reg_mecc_code_ramid <= 4'b0;
                reg_mecc_code_fetch <= 1'b0;
                reg_mecc_code_p <= 1'b1;
            end
            else if (reg_mecc_code_status_en) begin
                reg_mecc_code_c <= ipipe_csr_ecc_corr;
                reg_mecc_code_ramid <= ipipe_csr_ecc_ramid;
                reg_mecc_code_fetch <= ipipe_csr_ecc_fetch;
                reg_mecc_code_p <= ipipe_csr_ecc_precise;
            end
        end

        kv_zero_ext #(
            .OW(8),
            .IW(ECC_CODE_LEN)
        ) u_csr_mecc_code_code (
            .out(csr_mecc_code_code),
            .in(reg_mecc_code)
        );
        assign csr_mecc_code_c = reg_mecc_code_c;
        assign csr_mecc_code_p = reg_mecc_code_p;
        assign csr_mecc_code_ramid = reg_mecc_code_ramid;
        assign csr_mecc_code_fetch = reg_mecc_code_fetch;
    end
    else begin:gen_no_reg_mecc_code
        assign csr_mecc_code_code = 8'd0;
        assign csr_mecc_code_c = 1'b0;
        assign csr_mecc_code_p = 1'b0;
        assign csr_mecc_code_ramid = 4'd0;
        assign csr_mecc_code_fetch = 1'd0;
        wire nds_unused_ipipe_csr_ecc_corr = ipipe_csr_ecc_corr;
        wire nds_unused_ipipe_csr_ecc_code_en = ipipe_csr_ecc_code_en;
        wire [7:0] nds_unused_ipipe_csr_ecc_code = ipipe_csr_ecc_code;
        wire nds_unused_ipipe_csr_ecc_precise = ipipe_csr_ecc_precise;
        wire nds_unused_ipipe_csr_ecc_fetch = ipipe_csr_ecc_fetch;
        wire [3:0] nds_unused_ipipe_csr_ecc_ramid = ipipe_csr_ecc_ramid;
        wire nds_unused_ecc_trap_taken = ecc_trap_taken;
    end
endgenerate
generate
    if ((DEBUG_SUPPORT_INT == 1)) begin:gen_debug_regs
        reg reg_halt_mode;
        wire reg_halt_mode_nx;
        reg reg_dcsr_step;
        reg reg_dcsr_mprven;
        reg reg_dcsr_stoptime;
        reg reg_dcsr_stopcount;
        reg reg_dcsr_ebreakm;
        reg reg_dcsr_stepie;
        reg [31:0] reg_dscratch0;
        reg [31:0] reg_dscratch1;
        reg reg_dcsr_debugint;
        reg reg_resethaltreq;
        reg [EXTVALEN - 1:1] reg_dpc_addr;
        wire [EXTVALEN - 1:1] reg_dpc_addr_nx;
        wire [EXTVALEN - 1:0] nds_unused_dpc_reset_vector;
        wire reg_dpc_addr_we;
        reg [2:0] reg_dcsr_cause;
        wire [2:0] reg_dcsr_cause_nx;
        wire reg_dcsr_cause_we;
        reg reg_dexc2dbg_iam;
        reg reg_dexc2dbg_iaf;
        reg reg_dexc2dbg_ii;
        reg reg_dexc2dbg_nmi;
        reg reg_dexc2dbg_lam;
        reg reg_dexc2dbg_laf;
        reg reg_dexc2dbg_sam;
        reg reg_dexc2dbg_saf;
        reg reg_dexc2dbg_mec;
        reg reg_dexc2dbg_hsp;
        reg reg_dexc2dbg_sbe;
        reg [CAUSE_LEN - 1:0] reg_ddcause_maintype;
        wire reg_ddcause_maintype_we;
        reg [2:0] reg_ddcause_subtype;
        wire reg_ddcause_subtype_we;
        reg reg_stoptime;
        wire reg_stoptime_nx;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_dcsr_step <= 1'b0;
                reg_dcsr_mprven <= 1'b0;
                reg_dcsr_stoptime <= 1'b1;
                reg_dcsr_stopcount <= 1'b1;
                reg_dcsr_stepie <= 1'b0;
                reg_dcsr_ebreakm <= 1'b0;
            end
            else if (csr_dcsr_we) begin
                reg_dcsr_step <= csr_wdata[2];
                reg_dcsr_mprven <= csr_wdata[4];
                reg_dcsr_stoptime <= csr_wdata[9];
                reg_dcsr_stopcount <= csr_wdata[10];
                reg_dcsr_stepie <= csr_wdata[11];
                reg_dcsr_ebreakm <= csr_wdata[15];
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_dcsr_debugint <= 1'b0;
            end
            else begin
                reg_dcsr_debugint <= debugint;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_resethaltreq <= 1'b0;
            end
            else begin
                reg_resethaltreq <= resethaltreq;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_dscratch0 <= {32{1'b0}};
            end
            else if (csr_dscratch0_we) begin
                reg_dscratch0 <= csr_wdata;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_dscratch1 <= {32{1'b0}};
            end
            else if (csr_dscratch1_we) begin
                reg_dscratch1 <= csr_wdata;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_dexc2dbg_iam <= 1'b0;
                reg_dexc2dbg_iaf <= 1'b0;
                reg_dexc2dbg_ii <= 1'b0;
                reg_dexc2dbg_nmi <= 1'b0;
                reg_dexc2dbg_lam <= 1'b0;
                reg_dexc2dbg_laf <= 1'b0;
                reg_dexc2dbg_sam <= 1'b0;
                reg_dexc2dbg_saf <= 1'b0;
                reg_dexc2dbg_mec <= 1'b0;
                reg_dexc2dbg_hsp <= 1'b0;
                reg_dexc2dbg_sbe <= 1'b0;
            end
            else if (csr_dexc2dbg_we) begin
                reg_dexc2dbg_iam <= csr_wdata[0];
                reg_dexc2dbg_iaf <= csr_wdata[1];
                reg_dexc2dbg_ii <= csr_wdata[2];
                reg_dexc2dbg_nmi <= csr_wdata[3];
                reg_dexc2dbg_lam <= csr_wdata[4];
                reg_dexc2dbg_laf <= csr_wdata[5];
                reg_dexc2dbg_sam <= csr_wdata[6];
                reg_dexc2dbg_saf <= csr_wdata[7];
                reg_dexc2dbg_mec <= csr_wdata[11];
                reg_dexc2dbg_hsp <= csr_wdata[12] & csr_mmsc_cfg[5];
                reg_dexc2dbg_sbe <= csr_wdata[15];
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_halt_mode <= 1'b0;
            end
            else begin
                reg_halt_mode <= reg_halt_mode_nx;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_dpc_addr <= {(EXTVALEN - 1){1'b0}};
            end
            else if (reg_dpc_addr_we) begin
                reg_dpc_addr <= reg_dpc_addr_nx;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_dcsr_cause <= 3'd0;
            end
            else if (reg_dcsr_cause_we) begin
                reg_dcsr_cause <= reg_dcsr_cause_nx;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_ddcause_maintype <= {CAUSE_LEN{1'd0}};
            end
            else if (reg_ddcause_maintype_we) begin
                reg_ddcause_maintype <= ipipe_csr_halt_ddcause[CAUSE_LEN - 1:0];
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_ddcause_subtype <= 3'd0;
            end
            else if (reg_ddcause_subtype_we) begin
                reg_ddcause_subtype <= ipipe_csr_halt_ddcause[10:8];
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_stoptime <= 1'd0;
            end
            else begin
                reg_stoptime <= reg_stoptime_nx;
            end
        end

        assign reg_halt_mode_nx = halt_taken | (reg_halt_mode & ~halt_return);
        assign reg_stoptime_nx = reg_halt_mode_nx & csr_dcsr_stoptime;
        kv_zero_ext #(
            .OW(EXTVALEN),
            .IW(VALEN)
        ) u_dpc_reset_vector_zext (
            .out(nds_unused_dpc_reset_vector),
            .in(reset_vector)
        );
        assign reg_dpc_addr_we = (halt_taken & ~reg_halt_mode) | csr_dpc_we;
        assign reg_dpc_addr_nx[EXTVALEN - 1:2] = halt_taken ? ipipe_csr_epc_wdata[EXTVALEN - 1:2] : csr_wdata[EXTVALEN - 1:2];
        assign reg_dpc_addr_nx[1] = halt_taken ? ipipe_csr_epc_wdata[1] : csr_wdata[1];
        assign reg_dcsr_cause_we = (halt_taken & ~reg_halt_mode);
        assign reg_dcsr_cause_nx = halt_taken ? ipipe_csr_halt_cause : DCAUSE_DBGINT;
        assign reg_ddcause_maintype_we = (halt_taken & ~reg_halt_mode);
        assign reg_ddcause_subtype_we = (halt_taken & ~reg_halt_mode);
        assign csr_halt_mode = reg_halt_mode;
        assign csr_dcsr_debugint = reg_dcsr_debugint;
        assign csr_resethaltreq = reg_resethaltreq;
        assign csr_dcsr_step = reg_dcsr_step;
        assign csr_dcsr_mprven = reg_dcsr_mprven;
        assign csr_dcsr_stoptime = reg_dcsr_stoptime;
        assign csr_dcsr_stopcount = reg_dcsr_stopcount;
        assign csr_dcsr_stepie = reg_dcsr_stepie;
        assign csr_dcsr_ebreakm = reg_dcsr_ebreakm;
        assign csr_dscratch0 = reg_dscratch0;
        assign csr_dscratch1 = reg_dscratch1;
        assign csr_dpc[EXTVALEN - 1:0] = {reg_dpc_addr,1'b0};
        assign csr_dcsr_cause = reg_dcsr_cause;
        assign csr_dexc2dbg_iam = reg_dexc2dbg_iam;
        assign csr_dexc2dbg_iaf = reg_dexc2dbg_iaf;
        assign csr_dexc2dbg_ii = reg_dexc2dbg_ii;
        assign csr_dexc2dbg_nmi = reg_dexc2dbg_nmi;
        assign csr_dexc2dbg_lam = reg_dexc2dbg_lam;
        assign csr_dexc2dbg_laf = reg_dexc2dbg_laf;
        assign csr_dexc2dbg_sam = reg_dexc2dbg_sam;
        assign csr_dexc2dbg_saf = reg_dexc2dbg_saf;
        assign csr_dexc2dbg_mec = reg_dexc2dbg_mec;
        assign csr_dexc2dbg_hsp = reg_dexc2dbg_hsp;
        assign csr_dexc2dbg_sbe = reg_dexc2dbg_sbe;
        assign csr_ddcause_maintype = {{(8 - CAUSE_LEN){1'b0}},reg_ddcause_maintype};
        assign csr_ddcause_subtype = {5'd0,reg_ddcause_subtype[2:0]};
        assign stoptime = reg_stoptime;
    end
    else begin:gen_no_regs_dcsr
        assign csr_halt_mode = 1'b0;
        assign csr_dcsr_debugint = 1'b0;
        assign csr_resethaltreq = 1'b0;
        assign csr_dcsr_step = 1'b0;
        assign csr_dcsr_mprven = 1'b0;
        assign csr_dcsr_stoptime = 1'b0;
        assign csr_dcsr_stopcount = 1'b1;
        assign csr_dcsr_stepie = 1'b0;
        assign csr_dcsr_ebreakm = 1'b0;
        assign csr_dscratch0 = {32{1'b0}};
        assign csr_dscratch1 = {32{1'b0}};
        assign csr_dpc[EXTVALEN - 1:0] = {EXTVALEN{1'b0}};
        assign csr_dcsr_cause = 3'd0;
        assign csr_dexc2dbg_iam = 1'b0;
        assign csr_dexc2dbg_iaf = 1'b0;
        assign csr_dexc2dbg_ii = 1'b0;
        assign csr_dexc2dbg_nmi = 1'b0;
        assign csr_dexc2dbg_lam = 1'b0;
        assign csr_dexc2dbg_laf = 1'b0;
        assign csr_dexc2dbg_sam = 1'b0;
        assign csr_dexc2dbg_saf = 1'b0;
        assign csr_dexc2dbg_mec = 1'b0;
        assign csr_dexc2dbg_hsp = 1'b0;
        assign csr_dexc2dbg_sbe = 1'b0;
        assign csr_ddcause_maintype = 8'd0;
        assign csr_ddcause_subtype = 8'd0;
        assign stoptime = 1'b0;
        wire [15:0] nds_unused_ipipe_csr_halt_ddcause = ipipe_csr_halt_ddcause;
        wire nds_unused_resethaltreq = resethaltreq;
        wire nds_unused_debugint = debugint;
        wire [2:0] nds_unused_ipipe_csr_halt_cause = ipipe_csr_halt_cause;
    end
endgenerate
generate
    if (NUM_TRIGGER > 0) begin:gen_tcontrol_yes
        reg reg_tcontrol_mte;
        wire reg_tcontrol_mte_en;
        wire reg_tcontrol_mte_nx;
        reg reg_tcontrol_mpte;
        wire reg_tcontrol_mpte_en;
        wire reg_tcontrol_mpte_nx;
        assign reg_tcontrol_mte_en = csr_tcontrol_we | (trap_taken & ~csr_trap_delegated) | m_trap_return | nmi_taken;
        assign reg_tcontrol_mte_nx = csr_tcontrol_we ? csr_wdata[3] : |m_trap_return ? reg_tcontrol_mpte : 1'b0;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_tcontrol_mte <= 1'b0;
            end
            else if (reg_tcontrol_mte_en) begin
                reg_tcontrol_mte <= reg_tcontrol_mte_nx;
            end
        end

        assign csr_tcontrol_mte = reg_tcontrol_mte;
        assign reg_tcontrol_mpte_en = csr_tcontrol_we | (trap_taken & ~csr_trap_delegated) | nmi_taken;
        assign reg_tcontrol_mpte_nx = csr_tcontrol_we ? csr_wdata[7] : reg_tcontrol_mte;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_tcontrol_mpte <= 1'b0;
            end
            else if (reg_tcontrol_mpte_en) begin
                reg_tcontrol_mpte <= reg_tcontrol_mpte_nx;
            end
        end

        assign csr_tcontrol_mpte = reg_tcontrol_mpte;
    end
    else begin:gen_tcontrol_no
        assign csr_tcontrol_mte = 1'b0;
        assign csr_tcontrol_mpte = 1'b0;
        wire nds_unused_csr_tcontrol_we = csr_tcontrol_we;
    end
endgenerate
generate
    if (((DEBUG_SUPPORT_INT == 1)) && ((SLPECC_SUPPORT_INT == 1))) begin:gen_reg_dexc2dbg_slpecc
        reg reg_dexc2dbg_slpecc;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_dexc2dbg_slpecc <= 1'b0;
            end
            else if (csr_dexc2dbg_we) begin
                reg_dexc2dbg_slpecc <= csr_wdata[14];
            end
        end

        assign csr_dexc2dbg_slpecc = reg_dexc2dbg_slpecc;
    end
    else begin:gen_csr_dexc2dbg_slpecc_zero
        assign csr_dexc2dbg_slpecc = 1'b0;
    end
endgenerate
generate
    if (((DEBUG_SUPPORT_INT == 1)) && ((ACE_SUPPORT_INT == 1))) begin:gen_ace_debug_reg
        reg reg_dexc2dbg_ace;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_dexc2dbg_ace <= 1'b0;
            end
            else if (csr_dexc2dbg_we) begin
                reg_dexc2dbg_ace <= csr_wdata[13];
            end
        end

        assign csr_dexc2dbg_ace = reg_dexc2dbg_ace;
    end
    else begin:gen_no_ace_debug_reg
        assign csr_dexc2dbg_ace = 1'b0;
    end
endgenerate
generate
    if (((DEBUG_SUPPORT_INT == 1)) && (NUM_PRIVILEGE_LEVELS > 1)) begin:gen_reg_dcsr_prv
        reg [1:0] reg_dcsr_prv;
        wire reg_dcsr_prv_en;
        wire [1:0] reg_dcsr_prv_nx;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_dcsr_prv <= PRIVILEGE_MACHINE;
            end
            else if (reg_dcsr_prv_en) begin
                reg_dcsr_prv <= reg_dcsr_prv_nx;
            end
        end

        assign reg_dcsr_prv_en = (halt_taken & ~csr_halt_mode) | csr_dcsr_we;
        assign reg_dcsr_prv_nx = halt_taken ? csr_cur_privilege : ((NUM_PRIVILEGE_LEVELS > 2) & (csr_wdata[1:0] == PRIVILEGE_HYPERVISOR)) ? PRIVILEGE_SUPERVISOR : (NUM_PRIVILEGE_LEVELS > 2) ? {csr_wdata[1:0]} : {2{csr_wdata[0]}};
        assign csr_dcsr_prv = reg_dcsr_prv;
    end
    else begin:gen_dcsr_prv_hardwire
        assign csr_dcsr_prv = PRIVILEGE_MACHINE;
    end
endgenerate
generate
    if (((DEBUG_SUPPORT_INT == 1)) && (NUM_PRIVILEGE_LEVELS > 1)) begin:gen_reg_dcsr_ebreaku
        reg reg_dcsr_ebreaku;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_dcsr_ebreaku <= 1'b0;
            end
            else if (csr_dcsr_we) begin
                reg_dcsr_ebreaku <= csr_wdata[12];
            end
        end

        assign csr_dcsr_ebreaku = reg_dcsr_ebreaku;
    end
    else begin:gen_dcsr_ebreaku_hardwire
        assign csr_dcsr_ebreaku = 1'b0;
    end
endgenerate
generate
    if (((DEBUG_SUPPORT_INT == 1)) && (NUM_PRIVILEGE_LEVELS > 1)) begin:gen_reg_dexc2dbg_uec
        reg reg_dexc2dbg_uec;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_dexc2dbg_uec <= 1'b0;
            end
            else if (csr_dexc2dbg_we) begin
                reg_dexc2dbg_uec <= csr_wdata[8];
            end
        end

        assign csr_dexc2dbg_uec = reg_dexc2dbg_uec;
    end
    else begin:gen_dexc2dbg_uec_hardwire
        assign csr_dexc2dbg_uec = 1'b0;
    end
endgenerate
generate
    if (((DEBUG_SUPPORT_INT == 1)) && (NUM_PRIVILEGE_LEVELS > 2)) begin:gen_reg_dcsr_ebreaks
        reg reg_dcsr_ebreaks;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_dcsr_ebreaks <= 1'b0;
            end
            else if (csr_dcsr_we) begin
                reg_dcsr_ebreaks <= csr_wdata[13];
            end
        end

        assign csr_dcsr_ebreaks = reg_dcsr_ebreaks;
    end
    else begin:gen_dcsr_ebreaks_hardwire
        assign csr_dcsr_ebreaks = 1'b0;
    end
endgenerate
generate
    if (((DEBUG_SUPPORT_INT == 1)) && (NUM_PRIVILEGE_LEVELS > 2)) begin:gen_reg_dexc2dbg_supervisor
        reg reg_dexc2dbg_sec;
        reg reg_dexc2dbg_ipf;
        reg reg_dexc2dbg_lpf;
        reg reg_dexc2dbg_spf;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_dexc2dbg_sec <= 1'b0;
                reg_dexc2dbg_ipf <= 1'b0;
                reg_dexc2dbg_lpf <= 1'b0;
                reg_dexc2dbg_spf <= 1'b0;
            end
            else if (csr_dexc2dbg_we) begin
                reg_dexc2dbg_sec <= csr_wdata[9];
                reg_dexc2dbg_ipf <= csr_wdata[16];
                reg_dexc2dbg_lpf <= csr_wdata[17];
                reg_dexc2dbg_spf <= csr_wdata[18];
            end
        end

        assign csr_dexc2dbg_sec = reg_dexc2dbg_sec;
        assign csr_dexc2dbg_ipf = reg_dexc2dbg_ipf;
        assign csr_dexc2dbg_lpf = reg_dexc2dbg_lpf;
        assign csr_dexc2dbg_spf = reg_dexc2dbg_spf;
    end
    else begin:gen_dexc2dbg_sec_hardwire
        assign csr_dexc2dbg_sec = 1'b0;
        assign csr_dexc2dbg_ipf = 1'b0;
        assign csr_dexc2dbg_lpf = 1'b0;
        assign csr_dexc2dbg_spf = 1'b0;
    end
endgenerate
generate
    if (((DEBUG_SUPPORT_INT == 1)) && (PERFORMANCE_MONITOR_INT == 1)) begin:gen_reg_dexc2dbg_pmov
        reg reg_dexc2dbg_pmov;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_dexc2dbg_pmov <= 1'b0;
            end
            else if (csr_dexc2dbg_we) begin
                reg_dexc2dbg_pmov <= csr_wdata[19];
            end
        end

        assign csr_dexc2dbg_pmov = reg_dexc2dbg_pmov;
    end
    else begin:gen_dexc2dbg_pmov_hardwire
        assign csr_dexc2dbg_pmov = 1'b0;
    end
endgenerate
generate
    if ((POWERBRAKE_SUPPORT_INT == 1)) begin:gen_reg_mpft_ctl
        reg [3:0] reg_mpft_ctl_t_level;
        reg reg_mpft_ctl_fast_int;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mpft_ctl_t_level <= 4'b0;
                reg_mpft_ctl_fast_int <= 1'b0;
            end
            else if (csr_mpft_ctl_we) begin
                reg_mpft_ctl_t_level <= csr_wdata[7:4];
                reg_mpft_ctl_fast_int <= csr_wdata[8];
            end
        end

        assign csr_mpft_ctl_t_level = reg_mpft_ctl_t_level;
        assign csr_mpft_ctl_fast_int = reg_mpft_ctl_fast_int;
    end
    else begin:gen_reg_mpft_ctl_else
        assign csr_mpft_ctl_t_level = 4'b0;
        assign csr_mpft_ctl_fast_int = 1'b0;
    end
endgenerate
assign csr_mpft_ctl[3:0] = 4'b0;
assign csr_mpft_ctl[7:4] = csr_mpft_ctl_t_level;
assign csr_mpft_ctl[8] = csr_mpft_ctl_fast_int;
assign csr_mpft_ctl[31:9] = {23{1'b0}};
assign csr_t_level = csr_mpft_ctl_t_level;
generate
    if ((POWERBRAKE_SUPPORT_INT == 1)) begin:gen_reg_mxstatus_pft_en
        reg reg_mxstatus_pft_en;
        reg reg_mxstatus_ppft_en;
        wire reg_mxstatus_pft_en_nx;
        wire reg_mxstatus_ppft_en_nx;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mxstatus_pft_en <= 1'b0;
            end
            else begin
                reg_mxstatus_pft_en <= reg_mxstatus_pft_en_nx;
            end
        end

        assign reg_mxstatus_pft_en_nx = csr_mxstatus_we ? csr_wdata[0] : trap_taken ? ~csr_mpft_ctl_fast_int & csr_mxstatus_pft_en : m_trap_return ? csr_mxstatus_ppft_en : csr_mxstatus_pft_en;
        assign csr_mxstatus_pft_en = reg_mxstatus_pft_en;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mxstatus_ppft_en <= 1'b0;
            end
            else begin
                reg_mxstatus_ppft_en <= reg_mxstatus_ppft_en_nx;
            end
        end

        assign reg_mxstatus_ppft_en_nx = csr_mxstatus_we ? csr_wdata[1] : trap_taken ? csr_mxstatus_pft_en : csr_mxstatus_ppft_en;
        assign csr_mxstatus_ppft_en = reg_mxstatus_ppft_en;
    end
    else begin:gen_reg_mxstatus_pft_en_else
        assign csr_mxstatus_pft_en = 1'b0;
        assign csr_mxstatus_ppft_en = 1'b0;
        wire nds_unused_csr_mxstatus_we = csr_mxstatus_we;
    end
endgenerate
generate
    if ((ILM_SIZE_KB != 0) || (ICACHE_SIZE_KB != 0)) begin:gen_reg_mxstatus_ime
        reg reg_mxstatus_ime;
        wire reg_mxstatus_ime_en;
        wire reg_mxstatus_ime_nx;
        wire reg_mxstatus_pime_en;
        reg reg_mxstatus_pime;
        wire reg_mxstatus_pime_nx;
        wire csr_ecc_xcpt_update = ecc_trap_taken & ((ipipe_csr_ecc_ramid == 4'd2) | (ipipe_csr_ecc_ramid == 4'd3) | ((ipipe_csr_ecc_ramid == 4'd8) & ipipe_csr_ecc_insn & ~ipipe_csr_cause_interrupt));
        assign reg_mxstatus_ime_en = csr_mxstatus_we | csr_ecc_xcpt_update | m_trap_return;
        assign reg_mxstatus_pime_en = csr_mxstatus_we | trap_taken | nmi_taken;
        assign reg_mxstatus_ime_nx = csr_mxstatus_we ? csr_wdata[2] : m_trap_return ? reg_mxstatus_pime : csr_ecc_xcpt_update;
        assign reg_mxstatus_pime_nx = csr_mxstatus_we ? csr_wdata[3] : reg_mxstatus_ime;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mxstatus_ime <= 1'b0;
            end
            else if (reg_mxstatus_ime_en) begin
                reg_mxstatus_ime <= reg_mxstatus_ime_nx;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mxstatus_pime <= 1'b0;
            end
            else if (reg_mxstatus_pime_en) begin
                reg_mxstatus_pime <= reg_mxstatus_pime_nx;
            end
        end

        assign csr_mxstatus_ime = reg_mxstatus_ime;
        assign csr_mxstatus_pime = reg_mxstatus_pime;
    end
    else begin:gen_reg_mxstatus_ime_else
        assign csr_mxstatus_ime = 1'b0;
        assign csr_mxstatus_pime = 1'b0;
        wire nds_unused_ipipe_csr_ecc_insn = ipipe_csr_ecc_insn;
        wire [3:0] nds_unused_ipipe_csr_ecc_ramid = ipipe_csr_ecc_ramid;
        wire nds_unused_ecc_trap_taken = ecc_trap_taken;
        wire nds_unused_csr_mxstatus_we = csr_mxstatus_we;
    end
endgenerate
generate
    if ((ILM_SIZE_KB != 0) || (DLM_SIZE_KB != 0) || (DCACHE_SIZE_KB != 0)) begin:gen_reg_mxstatus_dme
        reg reg_mxstatus_dme;
        wire reg_mxstatus_dme_en;
        wire reg_mxstatus_dme_nx;
        wire reg_mxstatus_pdme_en;
        reg reg_mxstatus_pdme;
        wire reg_mxstatus_pdme_nx;
        wire csr_ecc_xcpt_update = ecc_trap_taken & ((ipipe_csr_ecc_ramid == 4'd4) | (ipipe_csr_ecc_ramid == 4'd5) | ((ipipe_csr_ecc_ramid == 4'd8) & ~ipipe_csr_ecc_insn & ~ipipe_csr_cause_interrupt) | ((ipipe_csr_ecc_ramid == 4'd9) & ~ipipe_csr_cause_interrupt));
        assign reg_mxstatus_dme_en = csr_mxstatus_we | csr_ecc_xcpt_update | m_trap_return;
        assign reg_mxstatus_pdme_en = csr_mxstatus_we | trap_taken | nmi_taken;
        assign reg_mxstatus_dme_nx = csr_mxstatus_we ? csr_wdata[4] : m_trap_return ? reg_mxstatus_pdme : csr_ecc_xcpt_update;
        assign reg_mxstatus_pdme_nx = csr_mxstatus_we ? csr_wdata[5] : reg_mxstatus_dme;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mxstatus_dme <= 1'b0;
            end
            else if (reg_mxstatus_dme_en) begin
                reg_mxstatus_dme <= reg_mxstatus_dme_nx;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mxstatus_pdme <= 1'b0;
            end
            else if (reg_mxstatus_pdme_en) begin
                reg_mxstatus_pdme <= reg_mxstatus_pdme_nx;
            end
        end

        assign csr_mxstatus_dme = reg_mxstatus_dme;
        assign csr_mxstatus_pdme = reg_mxstatus_pdme;
    end
    else begin:gen_reg_mxstatus_dme_else
        assign csr_mxstatus_dme = 1'b0;
        assign csr_mxstatus_pdme = 1'b0;
        wire nds_unused_ipipe_csr_ecc_insn = ipipe_csr_ecc_insn;
        wire [3:0] nds_unused_ipipe_csr_ecc_ramid = ipipe_csr_ecc_ramid;
        wire nds_unused_ecc_trap_taken = ecc_trap_taken;
        wire nds_unused_csr_mxstatus_we = csr_mxstatus_we;
    end
endgenerate
assign csr_mxstatus[0] = csr_mxstatus_pft_en;
assign csr_mxstatus[1] = csr_mxstatus_ppft_en;
assign csr_mxstatus[2] = csr_mxstatus_ime;
assign csr_mxstatus[3] = csr_mxstatus_pime;
assign csr_mxstatus[4] = csr_mxstatus_dme;
assign csr_mxstatus[5] = csr_mxstatus_pdme;
assign csr_mxstatus[31:6] = {26{1'b0}};
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        reg_mdcause <= 3'b0;
        reg_mdcause_pm <= 2'b0;
    end
    else if (reg_mdcause_en) begin
        reg_mdcause <= reg_mdcause_nx;
        reg_mdcause_pm <= reg_mdcause_pm_nx;
    end
end

assign reg_mdcause_en = (ipipe_csr_cause_detail_we & ~csr_trap_delegated) | csr_mdcause_we;
assign {reg_mdcause_pm_nx,reg_mdcause_nx} = ipipe_csr_cause_detail_we ? {ipipe_csr_cause_detail_pm[1:0],ipipe_csr_cause_detail[2:0]} : {csr_wdata[6:5],csr_wdata[2:0]};
assign csr_mdcause = {{25{1'b0}},reg_mdcause_pm,2'b00,reg_mdcause};
assign csr_pft_en = csr_mxstatus_pft_en;
generate
    wire uitb_hw;
    reg [EXTVALEN - 1:2] reg_uitb_addr;
    always @(posedge core_clk or negedge core_reset_n) begin
        if (!core_reset_n) begin
            reg_uitb_addr <= {(EXTVALEN - 2){1'b0}};
        end
        else if (csr_uitb_we) begin
            reg_uitb_addr <= csr_wdata[EXTVALEN - 1:2];
        end
    end

    assign uitb_hw = 1'b0;
    assign csr_uitb[EXTVALEN - 1:0] = {reg_uitb_addr,1'b0,uitb_hw};
endgenerate
generate
    if ((STACKSAFE_SUPPORT_INT == 1)) begin:gen_reg_mhsp_ctl_bound_base
        wire reg_mhsp_ctl_ovf_en_nx;
        wire reg_mhsp_ctl_udf_en_nx;
        wire mhsp_ctl_ovud_en_we;
        wire mhsp_bound_we;
        wire [31:0] reg_mhsp_bound_nx;
        reg [31:0] reg_mhsp_bound;
        reg [31:0] reg_mhsp_base;
        reg reg_mhsp_ctl_ovf_en;
        reg reg_mhsp_ctl_udf_en;
        reg reg_mhsp_ctl_schm;
        reg reg_mhsp_ctl_u;
        reg reg_mhsp_ctl_s;
        reg reg_mhsp_ctl_m;
        assign reg_mhsp_ctl_ovf_en_nx = ipipe_csr_hsp_xcpt ? 1'b0 : csr_wdata[0];
        assign reg_mhsp_ctl_udf_en_nx = ipipe_csr_hsp_xcpt ? 1'b0 : csr_wdata[1];
        assign mhsp_ctl_ovud_en_we = ipipe_csr_hsp_xcpt | csr_mhsp_ctl_we;
        assign reg_mhsp_bound_nx = csr_mhsp_bound_we ? csr_wdata[31:0] : ipipe_csr_mhsp_bound_wdata[31:0];
        assign mhsp_bound_we = csr_mhsp_bound_we | ipipe_csr_mhsp_bound_wen;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mhsp_bound <= {32{1'b1}};
            end
            else if (mhsp_bound_we) begin
                reg_mhsp_bound <= reg_mhsp_bound_nx;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mhsp_base <= {32{1'b1}};
            end
            else if (csr_mhsp_base_we) begin
                reg_mhsp_base <= csr_wdata[31:0];
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mhsp_ctl_ovf_en <= 1'b0;
                reg_mhsp_ctl_udf_en <= 1'b0;
            end
            else if (mhsp_ctl_ovud_en_we) begin
                reg_mhsp_ctl_ovf_en <= reg_mhsp_ctl_ovf_en_nx;
                reg_mhsp_ctl_udf_en <= reg_mhsp_ctl_udf_en_nx;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mhsp_ctl_schm <= 1'b0;
                reg_mhsp_ctl_u <= 1'b0;
                reg_mhsp_ctl_s <= 1'b0;
                reg_mhsp_ctl_m <= 1'b0;
            end
            else if (csr_mhsp_ctl_we) begin
                reg_mhsp_ctl_schm <= csr_wdata[2];
                reg_mhsp_ctl_u <= csr_wdata[3] & csr_misa[20];
                reg_mhsp_ctl_s <= csr_wdata[4] & csr_misa[18];
                reg_mhsp_ctl_m <= csr_wdata[5];
            end
        end

        assign csr_mhsp_bound = reg_mhsp_bound;
        assign csr_mhsp_base = reg_mhsp_base;
        assign csr_mhsp_ctl_ovf_en = reg_mhsp_ctl_ovf_en;
        assign csr_mhsp_ctl_udf_en = reg_mhsp_ctl_udf_en;
        assign csr_mhsp_ctl_schm = reg_mhsp_ctl_schm;
        assign csr_mhsp_ctl_u = reg_mhsp_ctl_u;
        assign csr_mhsp_ctl_s = reg_mhsp_ctl_s;
        assign csr_mhsp_ctl_m = reg_mhsp_ctl_m;
    end
    else begin:gen_reg_mhsp_ctl_bound_base_else
        assign csr_mhsp_bound = {32{1'b0}};
        assign csr_mhsp_base = {32{1'b0}};
        assign csr_mhsp_ctl_ovf_en = 1'b0;
        assign csr_mhsp_ctl_udf_en = 1'b0;
        assign csr_mhsp_ctl_schm = 1'b0;
        assign csr_mhsp_ctl_u = 1'b0;
        assign csr_mhsp_ctl_s = 1'b0;
        assign csr_mhsp_ctl_m = 1'b0;
        wire [31:0] nds_unused_ipipe_csr_mhsp_bound_wdata = ipipe_csr_mhsp_bound_wdata;
        wire nds_unused_ipipe_csr_hsp_xcpt = ipipe_csr_hsp_xcpt;
        wire nds_unused_ipipe_csr_mhsp_bound_wen = ipipe_csr_mhsp_bound_wen;
    end
endgenerate
assign csr_mhsp_ctl[0] = csr_mhsp_ctl_ovf_en;
assign csr_mhsp_ctl[1] = csr_mhsp_ctl_udf_en;
assign csr_mhsp_ctl[2] = csr_mhsp_ctl_schm;
assign csr_mhsp_ctl[3] = csr_mhsp_ctl_u;
assign csr_mhsp_ctl[4] = csr_mhsp_ctl_s;
assign csr_mhsp_ctl[5] = csr_mhsp_ctl_m;
assign csr_mhsp_ctl[31:6] = {26{1'b0}};
assign csr_mrandseq = {32{1'b0}};
assign csr_mrandseqh = {32{1'b0}};
assign csr_mrandstate = {32{1'b0}};
assign csr_mrandstateh = {32{1'b0}};
wire nds_unused_ipipe_csr_req_mrandstate = ipipe_csr_req_mrandstate;
wire nds_unused_ipipe_csr_req_rd_valid = ipipe_csr_req_rd_valid;
assign csr_mcache_ctl[0] = csr_mcache_ctl_ic_en;
assign csr_mcache_ctl[1] = csr_mcache_ctl_dc_en;
assign csr_mcache_ctl[3:2] = csr_mcache_ctl_ic_eccen;
assign csr_mcache_ctl[5:4] = csr_mcache_ctl_dc_eccen;
assign csr_mcache_ctl[6] = csr_mcache_ctl_ic_rwecc;
assign csr_mcache_ctl[7] = csr_mcache_ctl_dc_rwecc;
assign csr_mcache_ctl[8] = csr_mcache_ctl_cctl_suen;
assign csr_mcache_ctl[9] = csr_mcache_ctl_iprefetch_en;
assign csr_mcache_ctl[10] = csr_mcache_ctl_dprefetch_en;
assign csr_mcache_ctl[11] = csr_mcache_ctl_ic_first_word;
assign csr_mcache_ctl[12] = csr_mcache_ctl_dc_first_word;
assign csr_mcache_ctl[14:13] = csr_mcache_ctl_dc_waround;
assign csr_mcache_ctl[16:15] = csr_mcache_ctl_l2c_waround;
assign csr_mcache_ctl[18:17] = csr_mcache_ctl_tlb_eccen;
assign csr_mcache_ctl[19] = csr_mcache_ctl_dc_cohen;
assign csr_mcache_ctl[20] = csr_mcache_ctl_dc_cohsta;
assign csr_mcache_ctl[22:21] = 2'b0;
assign csr_mcache_ctl[23] = csr_mcache_ctl_tlb_rwecc;
assign csr_mcache_ctl[31:24] = {8{1'b0}};
generate
    if (ICACHE_SIZE_KB != 0) begin:gen_mcache_ctl_ic_en
        reg reg_mcache_ctl_ic_en;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mcache_ctl_ic_en <= 1'b0;
            end
            else if (csr_mcache_ctl_we) begin
                reg_mcache_ctl_ic_en <= csr_wdata[0];
            end
        end

        assign csr_mcache_ctl_ic_en = reg_mcache_ctl_ic_en;
    end
    else begin:gen_mcache_ctl_ic_hardwired
        assign csr_mcache_ctl_ic_en = 1'b0;
        wire nds_unused_csr_mcache_ctl_ic_we = csr_mcache_ctl_we;
    end
endgenerate
generate
    if (DCACHE_SIZE_KB != 0) begin:gen_mcache_ctl_dc_en
        reg reg_mcache_ctl_dc_en;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mcache_ctl_dc_en <= 1'b0;
            end
            else if (csr_mcache_ctl_we) begin
                reg_mcache_ctl_dc_en <= csr_wdata[1];
            end
        end

        assign csr_mcache_ctl_dc_en = reg_mcache_ctl_dc_en;
    end
    else begin:gen_mcache_ctl_dc_hardwired
        assign csr_mcache_ctl_dc_en = 1'b0;
        wire nds_unused_csr_mcache_ctl_dc_we = csr_mcache_ctl_we;
    end
endgenerate
generate
    if ((DCACHE_SIZE_KB != 0) && (CM_SUPPORT_INT == 1)) begin:gen_mcache_ctl_dc_coh
        reg reg_mcache_ctl_dc_cohen;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mcache_ctl_dc_cohen <= 1'b0;
            end
            else if (csr_mcache_ctl_we) begin
                reg_mcache_ctl_dc_cohen <= csr_wdata[19];
            end
        end

        assign csr_mcache_ctl_dc_cohen = reg_mcache_ctl_dc_cohen;
        assign csr_mcache_ctl_dc_cohsta = core_coherent_state;
        assign core_coherent_enable = reg_mcache_ctl_dc_cohen;
    end
    else begin:gen_mcache_ctl_dc_coh_stub
        assign csr_mcache_ctl_dc_cohen = 1'b0;
        assign csr_mcache_ctl_dc_cohsta = 1'b0;
        assign core_coherent_enable = 1'b0;
        wire nds_unused_core_coherent_state = core_coherent_state;
        wire nds_unused_csr_mcache_ctl_dc_coh_we = csr_mcache_ctl_we;
    end
endgenerate
generate
    if ((ICACHE_SIZE_KB != 0) && ((ICACHE_ECC_TYPE_INT != 0))) begin:gen_mcache_ctl_ic_ecc
        reg [1:0] reg_mcache_ctl_ic_eccen;
        reg reg_mcache_ctl_ic_rwecc;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mcache_ctl_ic_eccen <= 2'b0;
                reg_mcache_ctl_ic_rwecc <= 1'b0;
            end
            else if (csr_mcache_ctl_we) begin
                reg_mcache_ctl_ic_eccen <= csr_wdata[3:2];
                reg_mcache_ctl_ic_rwecc <= csr_wdata[6];
            end
        end

        assign csr_mcache_ctl_ic_eccen = reg_mcache_ctl_ic_eccen;
        assign csr_mcache_ctl_ic_rwecc = reg_mcache_ctl_ic_rwecc;
    end
    else begin:gen_mcache_ctl_ic_ecc_hardwired
        assign csr_mcache_ctl_ic_eccen = 2'b0;
        assign csr_mcache_ctl_ic_rwecc = 1'b0;
        wire nds_unused_csr_mcache_ctl_ic_ecc_we = csr_mcache_ctl_we;
    end
endgenerate
generate
    if ((DCACHE_SIZE_KB != 0) && (DCACHE_ECC_TYPE_INT != 0)) begin:gen_mcache_ctl_dc_ecc
        reg [1:0] reg_mcache_ctl_dc_eccen;
        reg reg_mcache_ctl_dc_rwecc;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mcache_ctl_dc_eccen <= 2'b0;
                reg_mcache_ctl_dc_rwecc <= 1'b0;
            end
            else if (csr_mcache_ctl_we) begin
                reg_mcache_ctl_dc_eccen <= csr_wdata[5:4];
                reg_mcache_ctl_dc_rwecc <= csr_wdata[7];
            end
        end

        assign csr_mcache_ctl_dc_eccen = reg_mcache_ctl_dc_eccen;
        assign csr_mcache_ctl_dc_rwecc = reg_mcache_ctl_dc_rwecc;
    end
    else begin:gen_mcache_ctl_dc_ecc_hardwired
        assign csr_mcache_ctl_dc_eccen = 2'b0;
        assign csr_mcache_ctl_dc_rwecc = 1'b0;
        wire nds_unused_csr_mcache_ctl_dc_ecc_we = csr_mcache_ctl_we;
    end
endgenerate
generate
    if (CACHE_SUPPORT_INT == 1) begin:gen_mcctl_enable
        reg mcache_ctl_cctl_suen;
        reg [31:0] mcctldata;
        wire [31:0] mcctlbeginaddr_nx;
        wire csr_mcctlcommand_en;
        reg [31:0] mcctlcommand;
        wire csr_mcctldata_en;
        wire [31:0] mcctldata_nx;
        reg [31:0] mcctlbeginaddr;
        wire mcctlbeginaddr_en;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                mcache_ctl_cctl_suen <= 1'b0;
            end
            else if (csr_mcache_ctl_we) begin
                mcache_ctl_cctl_suen <= csr_wdata[8];
            end
        end

        assign csr_mcache_ctl_cctl_suen = mcache_ctl_cctl_suen;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                mcctlcommand <= {32{1'b0}};
            end
            else if (csr_mcctlcommand_en) begin
                mcctlcommand <= csr_wdata[31:0];
            end
        end

        assign csr_mcctlcommand_en = csr_mcctlcommand_we | csr_ucctlcommand_we;
        assign csr_mcctlcommand = mcctlcommand;
        wire [7:0] cctl_command = csr_wdata[7:0];
        wire cctl_l1d_all = (cctl_command == 8'b00000111) | (cctl_command == 8'b00000110) | (cctl_command == 8'b00010111);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                mcctlbeginaddr <= {32{1'b0}};
            end
            else if (mcctlbeginaddr_en) begin
                mcctlbeginaddr <= mcctlbeginaddr_nx;
            end
        end

        assign mcctlbeginaddr_en = csr_mcctlbeginaddr_we | csr_ucctlbeginaddr_we | csr_mcctlcommand_en & ~cctl_l1d_all;
        assign mcctlbeginaddr_nx = (csr_mcctlbeginaddr_we | csr_ucctlbeginaddr_we) ? csr_wdata[31:0] : lsu_cctl_raddr;
        assign csr_mcctlbeginaddr = mcctlbeginaddr;
        wire cctl_data_we = (cctl_command == 8'b00010011) | (cctl_command == 8'b00010100) | (cctl_command == 8'b00000011) | (cctl_command == 8'b00011011) | (cctl_command == 8'b00011100) | (cctl_command == 8'b00001011) | (cctl_command == 8'b10010011) | (cctl_command == 8'b10010100);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                mcctldata <= {32{1'b0}};
            end
            else if (csr_mcctldata_en) begin
                mcctldata <= mcctldata_nx[31:0];
            end
        end

        assign csr_mcctldata = mcctldata;
        assign csr_mcctldata_en = csr_scctldata_we | csr_mcctldata_we | (csr_mcctlcommand_en & cctl_data_we);
        assign mcctldata_nx = (csr_scctldata_we | csr_mcctldata_we) ? csr_wdata[31:0] : lsu_cctl_rdata[31:0];
    end
    else begin:gen_mcctl_disabled
        assign csr_mcache_ctl_cctl_suen = 1'b0;
        assign csr_mcctlbeginaddr = {32{1'b0}};
        assign csr_mcctlcommand = {32{1'b0}};
        assign csr_mcctldata = {32{1'b0}};
        wire [31:0] nds_unused_lsu_cctl_rdata = lsu_cctl_rdata;
        wire [31:0] nds_unused_lsu_cctl_raddr = lsu_cctl_raddr;
        wire nds_unused_csr_mcctldata_we = csr_mcctldata_we;
        wire nds_unused_csr_mcache_ctl_we = csr_mcache_ctl_we;
        wire nds_unused_csr_ucctlbeginaddr_we = csr_ucctlbeginaddr_we;
        wire nds_unused_csr_mcctlbeginaddr_we = csr_mcctlbeginaddr_we;
        wire nds_unused_csr_scctldata_we = csr_scctldata_we;
    end
endgenerate
assign lsu_reserve_clr = trap_taken | nmi_taken | halt_taken | csr_mcctlcommand_we | csr_ucctlcommand_we;
assign lsu_prefetch_clr = csr_halt_mode | trap_taken | nmi_taken | csr_mmu_satp_we | m_trap_return | s_trap_return | u_trap_return;
generate
    if (ICACHE_SIZE_KB != 0) begin:gen_mcache_ctl_iprefetch_en
        reg reg_mcache_ctl_iprefetch_en;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mcache_ctl_iprefetch_en <= 1'b0;
            end
            else if (csr_mcache_ctl_we) begin
                reg_mcache_ctl_iprefetch_en <= csr_wdata[9];
            end
        end

        assign csr_mcache_ctl_iprefetch_en = reg_mcache_ctl_iprefetch_en;
    end
    else begin:gen_mcache_ctl_iprefetch_en_hardwired
        assign csr_mcache_ctl_iprefetch_en = 1'b0;
        wire nds_unused_csr_mcache_ctl_iprefetch_we = csr_mcache_ctl_we;
    end
endgenerate
generate
    if ((DCACHE_SIZE_KB != 0) && ((DCACHE_PREFETCH_SUPPORT_INT == 1))) begin:gen_mcache_ctl_dprefetch_en
        reg reg_mcache_ctl_dprefetch_en;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mcache_ctl_dprefetch_en <= 1'b0;
            end
            else if (csr_mcache_ctl_we) begin
                reg_mcache_ctl_dprefetch_en <= csr_wdata[10];
            end
        end

        assign csr_mcache_ctl_dprefetch_en = reg_mcache_ctl_dprefetch_en;
    end
    else begin:gen_mcache_ctl_dprefetch_en_hardwired
        assign csr_mcache_ctl_dprefetch_en = 1'b0;
        wire nds_unused_csr_mcache_ctl_dprefetch_we = csr_mcache_ctl_we;
    end
endgenerate
generate
    if ((ICACHE_FIRST_WORD_FIRST_INT == 1)) begin:gen_mcache_ctl_ic_first_word
        assign csr_mcache_ctl_ic_first_word = 1'b1;
    end
    else begin:gen_mcache_ctl_ic_first_word_hardwired
        assign csr_mcache_ctl_ic_first_word = 1'b0;
    end
endgenerate
generate
    if ((DCACHE_FIRST_WORD_FIRST_INT == 1)) begin:gen_mcache_ctl_dc_first_word
        assign csr_mcache_ctl_dc_first_word = 1'b1;
    end
    else begin:gen_mcache_ctl_dc_first_word_hardwired
        assign csr_mcache_ctl_dc_first_word = 1'b0;
    end
endgenerate
generate
    if ((DCACHE_SIZE_KB != 0) && (WRITE_AROUND_SUPPORT_INT == 1)) begin:gen_mcache_ctl_dc_wa
        reg [1:0] reg_mcache_ctl_dc_waround;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mcache_ctl_dc_waround <= 2'b0;
            end
            else if (csr_mcache_ctl_we) begin
                reg_mcache_ctl_dc_waround <= csr_wdata[14:13];
            end
        end

        assign csr_mcache_ctl_dc_waround = reg_mcache_ctl_dc_waround;
    end
    else begin:gen_mcache_ctl_dc_wa_hardwired
        assign csr_mcache_ctl_dc_waround = 2'b0;
        wire nds_unused_csr_mcache_ctl_dc_wa_we = csr_mcache_ctl_we;
    end
endgenerate
assign csr_mcache_ctl_l2c_waround = 2'b0;
generate
    if (((MMU_SCHEME_INT != 0)) && (STLB_ECC_TYPE == 1)) begin:gen_mcache_ctl_tlb_eccen
        reg [1:0] reg_mcache_ctl_tlb_eccen;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mcache_ctl_tlb_eccen <= 2'b0;
            end
            else if (csr_mcache_ctl_we) begin
                reg_mcache_ctl_tlb_eccen <= csr_wdata[18:17];
            end
        end

        assign csr_mcache_ctl_tlb_eccen = reg_mcache_ctl_tlb_eccen;
    end
    else begin:gen_mcache_ctl_tlb_eccen_hardwired
        assign csr_mcache_ctl_tlb_eccen = 2'b0;
        wire nds_unused_csr_mcache_ctl_tlb_eccen_we = csr_mcache_ctl_we;
    end
endgenerate
generate
    if (((MMU_SCHEME_INT != 0)) && (STLB_ECC_TYPE == 1)) begin:gen_mcache_ctl_tlb_rwecc
        reg reg_mcache_ctl_tlb_rwecc;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_mcache_ctl_tlb_rwecc <= 1'b0;
            end
            else if (csr_mcache_ctl_we) begin
                reg_mcache_ctl_tlb_rwecc <= csr_wdata[23];
            end
        end

        assign csr_mcache_ctl_tlb_rwecc = reg_mcache_ctl_tlb_rwecc;
    end
    else begin:gen_mcache_ctl_tlb_rwecc_hardwired
        assign csr_mcache_ctl_tlb_rwecc = 1'b0;
        wire nds_unused_csr_mcache_ctl_tlb_rwecc_we = csr_mcache_ctl_we;
    end
endgenerate
assign csr_pmp_we = csr_we;
assign csr_pmp_waddr = ipipe_csr_req_waddr;
assign csr_pmp_raddr0 = ipipe_csr_req_raddr;
assign csr_pmp_raddr1 = csr_prob_raddr;
assign csr_pmp_wdata = csr_wdata;
assign csr_pma_we = csr_we;
assign csr_pma_waddr = ipipe_csr_req_waddr;
assign csr_pma_raddr0 = ipipe_csr_req_raddr;
assign csr_pma_raddr1 = csr_prob_raddr;
assign csr_pma_wdata = csr_wdata;
generate
    if ((DSP_SUPPORT_INT == 1)) begin:gen_dsp_ucode_reg_yes
        wire ucode_ov_we;
        wire reg_ucode_ov_nx;
        reg reg_ucode_ov;
        assign ucode_ov_we = ipipe_csr_ucode_ov_set | csr_ucode_we;
        assign reg_ucode_ov_nx = ipipe_csr_ucode_ov_set | csr_wdata[0];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_ucode_ov <= 1'b0;
            end
            else if (ucode_ov_we) begin
                reg_ucode_ov <= reg_ucode_ov_nx;
            end
        end

        assign csr_ucode_ov = reg_ucode_ov;
    end
    else begin:gen_dsp_ucode_reg_no
        assign csr_ucode_ov = 1'b0;
        wire nds_unused_ipipe_csr_ucode_ov_set = ipipe_csr_ucode_ov_set;
    end
endgenerate
generate
    if (FLEN != 1) begin:gen_fflags_reg_yes
        wire fflags_hw_we;
        wire fflags_sw_we;
        wire fflags_we;
        wire [4:0] reg_fflags_nx;
        reg [4:0] reg_fflags;
        assign fflags_hw_we = (|ipipe_csr_fflags_set);
        assign fflags_sw_we = csr_fcsr_we | csr_fflags_we;
        assign fflags_we = fflags_hw_we | fflags_sw_we;
        assign reg_fflags_nx = fflags_hw_we ? (ipipe_csr_fflags_set | reg_fflags) : csr_wdata[4:0];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_fflags <= 5'd0;
            end
            else if (fflags_we) begin
                reg_fflags <= reg_fflags_nx;
            end
        end

        assign csr_fflags = {{27{1'b0}},reg_fflags};
    end
    else begin:gen_fflags_reg_no
        assign csr_fflags = {32{1'b0}};
    end
endgenerate
generate
    if (FLEN != 1) begin:gen_frm_reg_yes
        wire frm_we;
        wire [2:0] reg_frm_nx;
        reg [2:0] reg_frm;
        assign frm_we = csr_fcsr_we | csr_frm_we;
        assign reg_frm_nx = csr_fcsr_we ? csr_wdata[7:5] : csr_wdata[2:0];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                reg_frm <= 3'd0;
            end
            else if (frm_we) begin
                reg_frm <= reg_frm_nx;
            end
        end

        assign csr_frm = {{29{1'b0}},reg_frm};
    end
    else begin:gen_frm_reg_no
        assign csr_frm = {32{1'b0}};
    end
endgenerate
assign csr_fcsr = {{24{1'b0}},csr_frm[2:0],csr_fflags[4:0]};
assign csr_mclk_ctl[31:0] = 32'd0;
generate
    if (NUM_PRIVILEGE_LEVELS < 3) begin:gen_non_smode_unused_wire
        wire nds_unused_wire0 = (|csr_sedeleg_iam) | (|csr_sedeleg_iaf) | (|csr_sedeleg_ii) | (|csr_sedeleg_b) | (|csr_sedeleg_lam) | (|csr_sedeleg_laf) | (|csr_sedeleg_sam) | (|csr_sedeleg_saf) | (|csr_sedeleg_uec) | (|csr_sedeleg_ipf) | (|csr_sedeleg_lpf) | (|csr_sedeleg_spf);
    end
endgenerate
assign csr_vtype = {32{1'b0}};
assign csr_vl = {32{1'b0}};
assign csr_vstart = {32{1'b0}};
assign csr_vxrm = {32{1'b0}};
assign csr_vxsat = {32{1'b0}};
assign itlb_translate_en = (csr_cur_privilege != PRIVILEGE_MACHINE) & (csr_halt_mode != 1'b1) & (csr_satp_mode != SATP_MODE_BARE);
assign csr_ls_translate_en = ~ls_privilege_m & (csr_satp_mode != SATP_MODE_BARE);
wire nds_unused_wire = (|halt_taken) | (|u_trap_return) | (|halt_return) | (|cur_privilege_u) | (|csr_medeleg_we) | (|csr_mideleg_we) | (|csr_mslideleg_we) | (|csr_dcsr_we) | (|csr_dpc_we) | (|csr_dscratch0_we) | (|csr_dscratch1_we) | (|csr_milmb_we) | (|csr_mdlmb_we) | (|csr_mecc_code_we) | (|csr_dexc2dbg_we) | (|csr_mrandseq_we) | (|csr_mrandseqh_we) | (|csr_mrandstate_we) | (|csr_mrandstateh_we) | (|csr_mpft_ctl_we) | (|csr_mhsp_ctl_we) | (|csr_mhsp_bound_we) | (|csr_mhsp_base_we) | (|csr_uitb_we) | (|csr_ucode_we) | (|csr_udcause_we) | (|csr_sstatus_we) | (|csr_sie_we) | (|csr_slie_we) | (|csr_sip_we) | (|csr_slip_we) | (|csr_sideleg_we) | (|csr_sedeleg_we) | (|csr_stvec_we) | (|csr_sepc_we) | (|csr_scause_we) | (|csr_sdcause_we) | (|csr_stval_we) | (|csr_sscratch_we) | (|csr_smisc_ctl_we) | (|csr_ustatus_we) | (|csr_uie_we) | (|csr_utvec_we) | (|csr_uscratch_we) | (|csr_uepc_we) | (|csr_ucause_we) | (|csr_utval_we) | (|csr_uip_we);
wire nds_unused_rv32 = (|csr_mstatus_uxl) | (|csr_mstatus_sxl);
wire nds_unused_ipipe_csr_int_delegate_u = ipipe_csr_int_delegate_u;
wire nds_unused_ipipe_csr_int_delegate_s = ipipe_csr_int_delegate_s;
wire [1:0] nds_unused_ipipe_csr_req_func = ipipe_csr_req_func;
wire [1:0] nds_unused_ipipe_csr_inst_retire = ipipe_csr_inst_retire;
endmodule


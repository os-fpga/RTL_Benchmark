// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lsu (
    dptw_mmu_req_ready,
    dptw_mmu_resp_data,
    dptw_mmu_resp_status,
    dptw_mmu_resp_valid,
    mmu_dptw_req_pa,
    mmu_dptw_req_valid,
    core_clk,
    core_reset_n,
    iptw_mmu_req_ready,
    iptw_mmu_resp_data,
    iptw_mmu_resp_status,
    iptw_mmu_resp_valid,
    mmu_iptw_req_pa,
    mmu_iptw_req_valid,
    csr_ls_translate_en,
    csr_mdlmb_eccen,
    csr_mdlmb_rwecc,
    csr_milmb_eccen,
    csr_milmb_rwecc,
    csr_mmisc_ctl_una,
    csr_mxstatus_dme,
    csr_satp_mode,
    dcu_ack_id,
    dcu_ack_rdata,
    dcu_ack_status,
    dcu_ack_valid,
    dcu_cmt_addr,
    dcu_cmt_func,
    dcu_cmt_valid,
    dcu_cmt_wdata,
    dcu_cmt_wmask,
    dcu_cri_id,
    dcu_cri_nbload_result,
    dcu_cri_rdata,
    dcu_cri_status,
    dcu_cri_valid,
    dcu_req_addr,
    dcu_req_func,
    dcu_req_id,
    dcu_req_ready,
    dcu_req_stall,
    dcu_req_valid,
    dcu_wna_pending,
    dtlb_lsu_status,
    lsu_async_read_error,
    lsu_async_write_error,
    lsu_dlm0_a_addr,
    lsu_dlm0_a_func,
    lsu_dlm0_a_ready,
    lsu_dlm0_a_stall,
    lsu_dlm0_a_user,
    lsu_dlm0_a_valid,
    lsu_dlm0_d_data,
    lsu_dlm0_d_status,
    lsu_dlm0_d_user,
    lsu_dlm0_d_valid,
    lsu_dlm0_w_data,
    lsu_dlm0_w_mask,
    lsu_dlm0_w_ready,
    lsu_dlm0_w_status,
    lsu_dlm0_w_valid,
    lsu_dlm1_a_addr,
    lsu_dlm1_a_func,
    lsu_dlm1_a_ready,
    lsu_dlm1_a_stall,
    lsu_dlm1_a_user,
    lsu_dlm1_a_valid,
    lsu_dlm1_d_data,
    lsu_dlm1_d_status,
    lsu_dlm1_d_user,
    lsu_dlm1_d_valid,
    lsu_dlm1_w_data,
    lsu_dlm1_w_mask,
    lsu_dlm1_w_ready,
    lsu_dlm1_w_status,
    lsu_dlm1_w_valid,
    lsu_dlm2_a_addr,
    lsu_dlm2_a_func,
    lsu_dlm2_a_ready,
    lsu_dlm2_a_stall,
    lsu_dlm2_a_user,
    lsu_dlm2_a_valid,
    lsu_dlm2_d_data,
    lsu_dlm2_d_status,
    lsu_dlm2_d_user,
    lsu_dlm2_d_valid,
    lsu_dlm2_w_data,
    lsu_dlm2_w_mask,
    lsu_dlm2_w_ready,
    lsu_dlm2_w_status,
    lsu_dlm2_w_valid,
    lsu_dlm3_a_addr,
    lsu_dlm3_a_func,
    lsu_dlm3_a_ready,
    lsu_dlm3_a_stall,
    lsu_dlm3_a_user,
    lsu_dlm3_a_valid,
    lsu_dlm3_d_data,
    lsu_dlm3_d_status,
    lsu_dlm3_d_user,
    lsu_dlm3_d_valid,
    lsu_dlm3_w_data,
    lsu_dlm3_w_mask,
    lsu_dlm3_w_ready,
    lsu_dlm3_w_status,
    lsu_dlm3_w_valid,
    lsu_dtlb_lru_valid,
    lsu_dtlb_lru_wdata,
    lsu_ilm_a_addr,
    lsu_ilm_a_func,
    lsu_ilm_a_ready,
    lsu_ilm_a_stall,
    lsu_ilm_a_user,
    lsu_ilm_a_valid,
    lsu_ilm_d_data,
    lsu_ilm_d_status,
    lsu_ilm_d_user,
    lsu_ilm_d_valid,
    lsu_ilm_w_data,
    lsu_ilm_w_mask,
    lsu_ilm_w_ready,
    lsu_ilm_w_status,
    lsu_ilm_w_valid,
    lsu_pma_req_pa,
    lsu_pmp_req_pa,
    lsu_pmp_req_store,
    nbload_resp_rd,
    nbload_resp_result,
    nbload_resp_status,
    nbload_resp_valid,
    pma_lsu_resp_fault,
    pma_lsu_resp_mtype,
    pma_lsu_resp_namo,
    pmp_lsu_resp_fault,
    trigm_ls_addr,
    trigm_ls_load,
    trigm_ls_result,
    trigm_ls_store,
    csr_halt_mode,
    csr_mcache_ctl_dc_en,
    ls_una_wait,
    csr_mdlmb_den,
    csr_milmb_ien,
    dtlb_lsu_ppn,
    lsu_dtlb_privilege_u,
    lsu_dtlb_store,
    lsu_dtlb_va_op0,
    lsu_dtlb_va_op1,
    lsu_event,
    lsu_mmu_req_valid,
    lsu_mmu_va,
    mmu_lsu_resp_valid,
    ls_privilege_u,
    lsu_a_address,
    lsu_a_corrupt,
    lsu_a_data,
    lsu_a_mask,
    lsu_a_opcode,
    lsu_a_param,
    lsu_a_ready,
    lsu_a_size,
    lsu_a_source,
    lsu_a_user,
    lsu_a_valid,
    lsu_d_corrupt,
    lsu_d_data,
    lsu_d_denied,
    lsu_d_opcode,
    lsu_d_param,
    lsu_d_ready,
    lsu_d_sink,
    lsu_d_size,
    lsu_d_source,
    lsu_d_user,
    lsu_d_valid,
    csr_mcache_ctl_dprefetch_en,
    lsu_prefetch_clr,
    csr_mcache_ctl_ic_rwecc,
    csr_mcache_ctl_tlb_rwecc,
    csr_mcctlbeginaddr,
    dcu_acctl_ecc_corr,
    dcu_acctl_ecc_error,
    dcu_ix_ack,
    dcu_ix_addr,
    dcu_ix_command,
    dcu_ix_raddr,
    dcu_ix_rdata,
    dcu_ix_req,
    dcu_ix_status,
    dcu_ix_wdata,
    dcu_standby_ready,
    dcu_wbf_flush,
    ifu_cctl_ack,
    ifu_cctl_command,
    ifu_cctl_ecc_status,
    ifu_cctl_raddr,
    ifu_cctl_rdata,
    ifu_cctl_req,
    ifu_cctl_status,
    ifu_cctl_waddr,
    ifu_cctl_wdata,
    ifu_fence_done,
    ifu_fence_req,
    ifu_ipipe_standby_ready,
    ls_cmt_kill,
    ls_cmt_valid,
    ls_cmt_wdata_base,
    ls_cmt_wdata_sel_vpu,
    ls_cmt_wdata_vpu,
    ls_issue_ready,
    ls_privilege_m,
    ls_privilege_s,
    ls_req_asid,
    ls_req_base0,
    ls_req_base1,
    ls_req_base_bypass,
    ls_req_func,
    ls_req_offset,
    ls_req_pc,
    ls_req_stall,
    ls_req_valid,
    ls_resp_bresult,
    ls_resp_fault_addr,
    ls_resp_result,
    ls_resp_result_64b,
    ls_resp_status,
    ls_resp_valid,
    ls_standby_ready,
    lsu_cctl_raddr,
    lsu_cctl_rdata,
    lsu_reserve_clr,
    mmu_fence_asid,
    mmu_fence_done,
    mmu_fence_mode,
    mmu_fence_req,
    mmu_fence_vaddr,
    tlb_cctl_ack,
    tlb_cctl_command,
    tlb_cctl_ecc_status,
    tlb_cctl_raddr,
    tlb_cctl_rdata,
    tlb_cctl_req,
    tlb_cctl_waddr,
    tlb_cctl_wdata,
    wfi_enabled
);
parameter FLEN = 64;
parameter VALEN = 32;
parameter PALEN = 32;
parameter EXTVALEN = 32;
parameter RVA_SUPPORT_INT = 0;
parameter UNALIGNED_ACCESS_INT = 0;
parameter MMU_SCHEME_INT = 0;
parameter ILM_ECC_TYPE_INT = 0;
parameter ILM_SIZE_KB = 8;
parameter ILM_AMSB = 15;
parameter ILM_RAM_DW = 64;
parameter ILM_BASE = 64'h1000_0000;
parameter DLM_ECC_TYPE_INT = 0;
parameter DLM_SIZE_KB = 0;
parameter DLM_AMSB = 15;
parameter DLM_RAM_DW = 64;
parameter DLM_BASE = 64'h2000_0000;
parameter NUM_DLM_BANKS = 1;
parameter L2_ADDR_WIDTH = 32;
parameter L2_DATA_WIDTH = 64;
parameter DCACHE_PREFETCH_SUPPORT_INT = 0;
parameter PERFORMANCE_MONITOR_INT = 0;
parameter TL_SINK_WIDTH = 2;
parameter CLUSTER_SUPPORT_INT = 0;
localparam LSQ_DEPTH = 4;
localparam LSP_SRCS = LSQ_DEPTH + 3;
output dptw_mmu_req_ready;
output [31:0] dptw_mmu_resp_data;
output [16:0] dptw_mmu_resp_status;
output dptw_mmu_resp_valid;
input [(PALEN - 1):0] mmu_dptw_req_pa;
input mmu_dptw_req_valid;
input core_clk;
input core_reset_n;
output iptw_mmu_req_ready;
output [31:0] iptw_mmu_resp_data;
output [16:0] iptw_mmu_resp_status;
output iptw_mmu_resp_valid;
input [(PALEN - 1):0] mmu_iptw_req_pa;
input mmu_iptw_req_valid;
input csr_ls_translate_en;
input [1:0] csr_mdlmb_eccen;
input csr_mdlmb_rwecc;
input [1:0] csr_milmb_eccen;
input csr_milmb_rwecc;
input csr_mmisc_ctl_una;
input csr_mxstatus_dme;
input [3:0] csr_satp_mode;
input dcu_ack_id;
input [31:0] dcu_ack_rdata;
input [18:0] dcu_ack_status;
input dcu_ack_valid;
output [(PALEN - 1):0] dcu_cmt_addr;
output [10:0] dcu_cmt_func;
output dcu_cmt_valid;
output [31:0] dcu_cmt_wdata;
output [3:0] dcu_cmt_wmask;
input [0:0] dcu_cri_id;
input [31:0] dcu_cri_nbload_result;
input [31:0] dcu_cri_rdata;
input [8:0] dcu_cri_status;
input dcu_cri_valid;
output [(PALEN - 1):0] dcu_req_addr;
output [21:0] dcu_req_func;
output dcu_req_id;
input dcu_req_ready;
output dcu_req_stall;
output dcu_req_valid;
input dcu_wna_pending;
input [30:0] dtlb_lsu_status;
output lsu_async_read_error;
output lsu_async_write_error;
output [DLM_AMSB:0] lsu_dlm0_a_addr;
output [2:0] lsu_dlm0_a_func;
input lsu_dlm0_a_ready;
output lsu_dlm0_a_stall;
output [0:0] lsu_dlm0_a_user;
output lsu_dlm0_a_valid;
input [31:0] lsu_dlm0_d_data;
input [13:0] lsu_dlm0_d_status;
input [0:0] lsu_dlm0_d_user;
input lsu_dlm0_d_valid;
output [31:0] lsu_dlm0_w_data;
output [3:0] lsu_dlm0_w_mask;
input lsu_dlm0_w_ready;
input lsu_dlm0_w_status;
output lsu_dlm0_w_valid;
output [DLM_AMSB:0] lsu_dlm1_a_addr;
output [2:0] lsu_dlm1_a_func;
input lsu_dlm1_a_ready;
output lsu_dlm1_a_stall;
output [0:0] lsu_dlm1_a_user;
output lsu_dlm1_a_valid;
input [31:0] lsu_dlm1_d_data;
input [13:0] lsu_dlm1_d_status;
input [0:0] lsu_dlm1_d_user;
input lsu_dlm1_d_valid;
output [31:0] lsu_dlm1_w_data;
output [3:0] lsu_dlm1_w_mask;
input lsu_dlm1_w_ready;
input lsu_dlm1_w_status;
output lsu_dlm1_w_valid;
output [DLM_AMSB:0] lsu_dlm2_a_addr;
output [2:0] lsu_dlm2_a_func;
input lsu_dlm2_a_ready;
output lsu_dlm2_a_stall;
output [0:0] lsu_dlm2_a_user;
output lsu_dlm2_a_valid;
input [31:0] lsu_dlm2_d_data;
input [13:0] lsu_dlm2_d_status;
input [0:0] lsu_dlm2_d_user;
input lsu_dlm2_d_valid;
output [31:0] lsu_dlm2_w_data;
output [3:0] lsu_dlm2_w_mask;
input lsu_dlm2_w_ready;
input lsu_dlm2_w_status;
output lsu_dlm2_w_valid;
output [DLM_AMSB:0] lsu_dlm3_a_addr;
output [2:0] lsu_dlm3_a_func;
input lsu_dlm3_a_ready;
output lsu_dlm3_a_stall;
output [0:0] lsu_dlm3_a_user;
output lsu_dlm3_a_valid;
input [31:0] lsu_dlm3_d_data;
input [13:0] lsu_dlm3_d_status;
input [0:0] lsu_dlm3_d_user;
input lsu_dlm3_d_valid;
output [31:0] lsu_dlm3_w_data;
output [3:0] lsu_dlm3_w_mask;
input lsu_dlm3_w_ready;
input lsu_dlm3_w_status;
output lsu_dlm3_w_valid;
output lsu_dtlb_lru_valid;
output [7:0] lsu_dtlb_lru_wdata;
output [ILM_AMSB:0] lsu_ilm_a_addr;
output [2:0] lsu_ilm_a_func;
input lsu_ilm_a_ready;
output lsu_ilm_a_stall;
output [2:0] lsu_ilm_a_user;
output lsu_ilm_a_valid;
input [63:0] lsu_ilm_d_data;
input [13:0] lsu_ilm_d_status;
input [2:0] lsu_ilm_d_user;
input lsu_ilm_d_valid;
output [63:0] lsu_ilm_w_data;
output [7:0] lsu_ilm_w_mask;
input lsu_ilm_w_ready;
input lsu_ilm_w_status;
output lsu_ilm_w_valid;
output [(PALEN - 1):0] lsu_pma_req_pa;
output [(PALEN - 1):0] lsu_pmp_req_pa;
output lsu_pmp_req_store;
output [4:0] nbload_resp_rd;
output [31:0] nbload_resp_result;
output nbload_resp_status;
output nbload_resp_valid;
input pma_lsu_resp_fault;
input [3:0] pma_lsu_resp_mtype;
input pma_lsu_resp_namo;
input pmp_lsu_resp_fault;
output [(VALEN - 1):0] trigm_ls_addr;
output trigm_ls_load;
input [4:0] trigm_ls_result;
output trigm_ls_store;
input csr_halt_mode;
input csr_mcache_ctl_dc_en;
input ls_una_wait;
input csr_mdlmb_den;
input csr_milmb_ien;
input [(PALEN - 1):12] dtlb_lsu_ppn;
output lsu_dtlb_privilege_u;
output lsu_dtlb_store;
output [(VALEN - 1):0] lsu_dtlb_va_op0;
output [20:0] lsu_dtlb_va_op1;
output [4:0] lsu_event;
output lsu_mmu_req_valid;
output [(EXTVALEN - 1):0] lsu_mmu_va;
input mmu_lsu_resp_valid;
input ls_privilege_u;
output [(L2_ADDR_WIDTH - 1):0] lsu_a_address;
output lsu_a_corrupt;
output [(L2_DATA_WIDTH - 1):0] lsu_a_data;
output [(L2_DATA_WIDTH / 8) - 1:0] lsu_a_mask;
output [2:0] lsu_a_opcode;
output [2:0] lsu_a_param;
input lsu_a_ready;
output [2:0] lsu_a_size;
output lsu_a_source;
output [7:0] lsu_a_user;
output lsu_a_valid;
input lsu_d_corrupt;
input [(L2_DATA_WIDTH - 1):0] lsu_d_data;
input lsu_d_denied;
input [2:0] lsu_d_opcode;
input [1:0] lsu_d_param;
output lsu_d_ready;
input [(TL_SINK_WIDTH - 1):0] lsu_d_sink;
input [2:0] lsu_d_size;
input lsu_d_source;
input [1:0] lsu_d_user;
input lsu_d_valid;
input csr_mcache_ctl_dprefetch_en;
input lsu_prefetch_clr;
input csr_mcache_ctl_ic_rwecc;
input csr_mcache_ctl_tlb_rwecc;
input [31:0] csr_mcctlbeginaddr;
input dcu_acctl_ecc_corr;
input dcu_acctl_ecc_error;
input dcu_ix_ack;
output [31:0] dcu_ix_addr;
output [7:0] dcu_ix_command;
input [31:0] dcu_ix_raddr;
input [31:0] dcu_ix_rdata;
output dcu_ix_req;
input [11:0] dcu_ix_status;
output [31:0] dcu_ix_wdata;
input dcu_standby_ready;
output dcu_wbf_flush;
input ifu_cctl_ack;
output [4:0] ifu_cctl_command;
input [11:0] ifu_cctl_ecc_status;
input [31:0] ifu_cctl_raddr;
input [31:0] ifu_cctl_rdata;
output ifu_cctl_req;
input [4:0] ifu_cctl_status;
output [31:0] ifu_cctl_waddr;
output [31:0] ifu_cctl_wdata;
input ifu_fence_done;
output ifu_fence_req;
input ifu_ipipe_standby_ready;
input ls_cmt_kill;
input ls_cmt_valid;
input [31:0] ls_cmt_wdata_base;
input ls_cmt_wdata_sel_vpu;
input [63:0] ls_cmt_wdata_vpu;
output ls_issue_ready;
input ls_privilege_m;
input ls_privilege_s;
input [8:0] ls_req_asid;
input [31:0] ls_req_base0;
input [31:0] ls_req_base1;
input [2:0] ls_req_base_bypass;
input [34:0] ls_req_func;
input [20:0] ls_req_offset;
input [11:0] ls_req_pc;
input [1:0] ls_req_stall;
input ls_req_valid;
output [31:0] ls_resp_bresult;
output [(EXTVALEN - 1):0] ls_resp_fault_addr;
output [31:0] ls_resp_result;
output [63:0] ls_resp_result_64b;
output [31:0] ls_resp_status;
output ls_resp_valid;
output ls_standby_ready;
output [31:0] lsu_cctl_raddr;
output [31:0] lsu_cctl_rdata;
input lsu_reserve_clr;
output [8:0] mmu_fence_asid;
input mmu_fence_done;
output [1:0] mmu_fence_mode;
output mmu_fence_req;
output [(VALEN - 13):0] mmu_fence_vaddr;
input tlb_cctl_ack;
output [1:0] tlb_cctl_command;
input [7:0] tlb_cctl_ecc_status;
input [31:0] tlb_cctl_raddr;
input [31:0] tlb_cctl_rdata;
output tlb_cctl_req;
output [31:0] tlb_cctl_waddr;
output [31:0] tlb_cctl_wdata;
input wfi_enabled;


wire [36:0] dptw_req_func;
wire [(PALEN - 1):0] dptw_req_pa;
wire dptw_req_valid;
wire [36:0] iptw_req_func;
wire [(PALEN - 1):0] iptw_req_pa;
wire iptw_req_valid;
wire [31:0] lsp_ack_bresult;
wire [(EXTVALEN - 1):0] lsp_ack_fault_va;
wire lsp_ack_kill;
wire [(PALEN - 1):0] lsp_ack_pa;
wire [31:0] lsp_ack_result;
wire [63:0] lsp_ack_result2;
wire [6:0] lsp_ack_src;
wire [44:0] lsp_ack_status;
wire [(EXTVALEN - 1):0] lsp_ack_va;
wire lsp_ack_valid;
wire [3:0] lsp_event;
wire lsp_req_ready;
wire lsp_standby_ready;
wire [(PALEN - 1):0] lspipe_a_address;
wire lspipe_a_corrupt;
wire [31:0] lspipe_a_data;
wire [3:0] lspipe_a_mask;
wire [2:0] lspipe_a_opcode;
wire [2:0] lspipe_a_param;
wire [2:0] lspipe_a_size;
wire lspipe_a_source;
wire [7:0] lspipe_a_user;
wire lspipe_a_valid;
wire lspipe_d_ready;
wire [4:0] prf_resp_id;
wire prf_resp_status;
wire prf_resp_valid;
wire rpt_cmt_kill;
wire [11:0] rpt_cmt_pc;
wire [16:0] rpt_cmt_status;
wire [(EXTVALEN - 1):0] rpt_cmt_va;
wire rpt_cmt_valid;
wire [63:0] lsq_cmt_wdata;
wire [(LSQ_DEPTH - 1):0] lsq_commit;
wire lsq_empty;
wire [(LSQ_DEPTH - 1):0] lsq_kill;
wire lsq_req_dlm;
wire [36:0] lsq_req_func;
wire lsq_req_ilm;
wire [2:0] lsq_req_offset;
wire [11:0] lsq_req_pc;
wire [(LSQ_DEPTH - 1):0] lsq_req_src;
wire lsq_req_stall;
wire [(EXTVALEN - 1):0] lsq_req_va;
wire [(VALEN - 1):0] lsq_req_va_op0;
wire [20:0] lsq_req_va_op1;
wire lsq_req_valid;
wire uop_issue_ready;
wire [31:0] uop_resp_bresult;
wire [(EXTVALEN - 1):0] uop_resp_fault_va;
wire [(PALEN - 1):0] uop_resp_pa;
wire [31:0] uop_resp_result;
wire [63:0] uop_resp_result64;
wire [36:0] uop_resp_status;
wire uop_resp_valid;
wire arb_standby_ready;
wire [31:0] dptw_ack_result;
wire [44:0] dptw_ack_status;
wire dptw_ack_valid;
wire dptw_req_ready;
wire [31:0] iptw_ack_result;
wire [44:0] iptw_ack_status;
wire iptw_ack_valid;
wire iptw_req_ready;
wire [63:0] lsp_cmt_wdata;
wire [6:0] lsp_commit;
wire [6:0] lsp_kill;
wire [2:0] lsp_req_base_va20;
wire lsp_req_dlm;
wire [36:0] lsp_req_func;
wire lsp_req_ilm;
wire [2:0] lsp_req_offset;
wire [(PALEN - 1):0] lsp_req_pa;
wire [11:0] lsp_req_pc;
wire lsp_req_ptw;
wire [6:0] lsp_req_src;
wire lsp_req_stall;
wire [(EXTVALEN - 1):0] lsp_req_va;
wire [(EXTVALEN - 1):0] lsp_req_va_lm;
wire lsp_req_valid;
wire [31:0] lsq_ack_bresult;
wire [(EXTVALEN - 1):0] lsq_ack_fault_va;
wire [(PALEN - 1):0] lsq_ack_pa;
wire [31:0] lsq_ack_result;
wire [63:0] lsq_ack_result2;
wire [(LSQ_DEPTH - 1):0] lsq_ack_src;
wire [44:0] lsq_ack_status;
wire lsq_ack_valid;
wire lsq_req_ready;
wire [44:0] prf_ack_status;
wire prf_ack_valid;
wire prf_req_ready;
wire lsbuf_a_ready;
wire lsbuf_d_corrupt;
wire [31:0] lsbuf_d_data;
wire lsbuf_d_denied;
wire [2:0] lsbuf_d_opcode;
wire [1:0] lsbuf_d_param;
wire [(TL_SINK_WIDTH - 1):0] lsbuf_d_sink;
wire [2:0] lsbuf_d_size;
wire lsbuf_d_source;
wire [1:0] lsbuf_d_user;
wire lsbuf_d_valid;
wire [(PALEN - 1):0] lsbuf_a_address;
wire lsbuf_a_corrupt;
wire [31:0] lsbuf_a_data;
wire [3:0] lsbuf_a_mask;
wire [2:0] lsbuf_a_opcode;
wire [2:0] lsbuf_a_param;
wire [2:0] lsbuf_a_size;
wire lsbuf_a_source;
wire [7:0] lsbuf_a_user;
wire lsbuf_a_valid;
wire lsbuf_d_ready;
wire lspipe_a_ready;
wire lspipe_d_corrupt;
wire [31:0] lspipe_d_data;
wire lspipe_d_denied;
wire [2:0] lspipe_d_opcode;
wire [1:0] lspipe_d_param;
wire [(TL_SINK_WIDTH - 1):0] lspipe_d_sink;
wire [2:0] lspipe_d_size;
wire lspipe_d_source;
wire [1:0] lspipe_d_user;
wire lspipe_d_valid;
wire [36:0] prf_req_func;
wire [11:0] prf_req_pc;
wire [(EXTVALEN - 1):0] prf_req_va;
wire prf_req_valid;
wire prf_standby_ready;
wire lsp_reserve_clr;
wire lsuop_prefetch_clr;
wire uop_cmt_kill;
wire uop_cmt_valid;
wire [63:0] uop_cmt_wdata_f;
wire [31:0] uop_cmt_wdata_i;
wire uop_cmt_wdata_sel_f;
wire [(EXTVALEN - 1):0] uop_req_addr;
wire uop_req_dlm;
wire [26:0] uop_req_func;
wire uop_req_ilm;
wire [(VALEN - 1):0] uop_req_op0;
wire [20:0] uop_req_op1;
wire [11:0] uop_req_pc;
wire [1:0] uop_req_stall;
wire uop_req_valid;
kv_lspipe #(
    .CLUSTER_SUPPORT_INT(CLUSTER_SUPPORT_INT),
    .DCACHE_PREFETCH_SUPPORT_INT(DCACHE_PREFETCH_SUPPORT_INT),
    .DLM_AMSB(DLM_AMSB),
    .DLM_BASE(DLM_BASE),
    .DLM_ECC_TYPE_INT(DLM_ECC_TYPE_INT),
    .DLM_RAM_DW(DLM_RAM_DW),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .EXTVALEN(EXTVALEN),
    .FLEN(FLEN),
    .ILM_AMSB(ILM_AMSB),
    .ILM_BASE(ILM_BASE),
    .ILM_ECC_TYPE_INT(ILM_ECC_TYPE_INT),
    .ILM_RAM_DW(ILM_RAM_DW),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .LSP_SRCS(LSP_SRCS),
    .MMU_SCHEME_INT(MMU_SCHEME_INT),
    .NUM_DLM_BANKS(NUM_DLM_BANKS),
    .PALEN(PALEN),
    .PERFORMANCE_MONITOR_INT(PERFORMANCE_MONITOR_INT),
    .RVA_SUPPORT_INT(RVA_SUPPORT_INT),
    .TL_SINK_WIDTH(TL_SINK_WIDTH),
    .VALEN(VALEN)
) u_lspipe (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_ls_translate_en(csr_ls_translate_en),
    .csr_milmb_eccen(csr_milmb_eccen),
    .csr_milmb_rwecc(csr_milmb_rwecc),
    .csr_mdlmb_eccen(csr_mdlmb_eccen),
    .csr_mdlmb_rwecc(csr_mdlmb_rwecc),
    .csr_mxstatus_dme(csr_mxstatus_dme),
    .csr_mcache_ctl_dc_en(csr_mcache_ctl_dc_en),
    .csr_halt_mode(csr_halt_mode),
    .csr_satp_mode(csr_satp_mode),
    .csr_mmisc_ctl_una(csr_mmisc_ctl_una),
    .lsp_event(lsp_event),
    .dcu_wna_pending(dcu_wna_pending),
    .lsp_standby_ready(lsp_standby_ready),
    .rpt_cmt_valid(rpt_cmt_valid),
    .rpt_cmt_kill(rpt_cmt_kill),
    .rpt_cmt_pc(rpt_cmt_pc),
    .rpt_cmt_va(rpt_cmt_va),
    .rpt_cmt_status(rpt_cmt_status),
    .lsp_req_valid(lsp_req_valid),
    .lsp_req_stall(lsp_req_stall),
    .lsp_req_ptw(lsp_req_ptw),
    .lsp_req_src(lsp_req_src),
    .lsp_req_func(lsp_req_func),
    .lsp_req_pc(lsp_req_pc),
    .lsp_req_va(lsp_req_va),
    .lsp_req_va_lm(lsp_req_va_lm),
    .lsp_req_pa(lsp_req_pa),
    .lsp_req_base_va20(lsp_req_base_va20),
    .lsp_req_offset(lsp_req_offset),
    .lsp_req_ilm(lsp_req_ilm),
    .lsp_req_dlm(lsp_req_dlm),
    .lsp_req_ready(lsp_req_ready),
    .lsp_ack_valid(lsp_ack_valid),
    .lsp_ack_kill(lsp_ack_kill),
    .lsp_ack_src(lsp_ack_src),
    .lsp_ack_result(lsp_ack_result),
    .lsp_ack_result2(lsp_ack_result2),
    .lsp_ack_bresult(lsp_ack_bresult),
    .lsp_ack_va(lsp_ack_va),
    .lsp_ack_fault_va(lsp_ack_fault_va),
    .lsp_ack_pa(lsp_ack_pa),
    .lsp_ack_status(lsp_ack_status),
    .nbload_resp_valid(nbload_resp_valid),
    .nbload_resp_rd(nbload_resp_rd),
    .nbload_resp_result(nbload_resp_result),
    .nbload_resp_status(nbload_resp_status),
    .lsu_async_read_error(lsu_async_read_error),
    .prf_resp_valid(prf_resp_valid),
    .prf_resp_id(prf_resp_id),
    .prf_resp_status(prf_resp_status),
    .lsp_commit(lsp_commit),
    .lsp_kill(lsp_kill),
    .lsp_cmt_wdata(lsp_cmt_wdata),
    .lsp_reserve_clr(lsp_reserve_clr),
    .dtlb_lsu_status(dtlb_lsu_status),
    .lsu_dtlb_lru_valid(lsu_dtlb_lru_valid),
    .lsu_dtlb_lru_wdata(lsu_dtlb_lru_wdata),
    .lsu_pmp_req_pa(lsu_pmp_req_pa),
    .lsu_pmp_req_store(lsu_pmp_req_store),
    .pmp_lsu_resp_fault(pmp_lsu_resp_fault),
    .lsu_pma_req_pa(lsu_pma_req_pa),
    .pma_lsu_resp_fault(pma_lsu_resp_fault),
    .pma_lsu_resp_mtype(pma_lsu_resp_mtype),
    .pma_lsu_resp_namo(pma_lsu_resp_namo),
    .dcu_req_addr(dcu_req_addr),
    .dcu_req_func(dcu_req_func),
    .dcu_req_valid(dcu_req_valid),
    .dcu_req_stall(dcu_req_stall),
    .dcu_req_id(dcu_req_id),
    .dcu_req_ready(dcu_req_ready),
    .dcu_ack_valid(dcu_ack_valid),
    .dcu_ack_id(dcu_ack_id),
    .dcu_ack_rdata(dcu_ack_rdata),
    .dcu_ack_status(dcu_ack_status),
    .dcu_cmt_valid(dcu_cmt_valid),
    .dcu_cmt_addr(dcu_cmt_addr),
    .dcu_cmt_func(dcu_cmt_func),
    .dcu_cmt_wdata(dcu_cmt_wdata),
    .dcu_cmt_wmask(dcu_cmt_wmask),
    .dcu_cri_valid(dcu_cri_valid),
    .dcu_cri_id(dcu_cri_id),
    .dcu_cri_rdata(dcu_cri_rdata),
    .dcu_cri_nbload_result(dcu_cri_nbload_result),
    .dcu_cri_status(dcu_cri_status),
    .lspipe_a_opcode(lspipe_a_opcode),
    .lspipe_a_param(lspipe_a_param),
    .lspipe_a_user(lspipe_a_user),
    .lspipe_a_size(lspipe_a_size),
    .lspipe_a_source(lspipe_a_source),
    .lspipe_a_address(lspipe_a_address),
    .lspipe_a_data(lspipe_a_data),
    .lspipe_a_mask(lspipe_a_mask),
    .lspipe_a_corrupt(lspipe_a_corrupt),
    .lspipe_a_valid(lspipe_a_valid),
    .lspipe_a_ready(lspipe_a_ready),
    .lspipe_d_opcode(lspipe_d_opcode),
    .lspipe_d_param(lspipe_d_param),
    .lspipe_d_user(lspipe_d_user),
    .lspipe_d_size(lspipe_d_size),
    .lspipe_d_source(lspipe_d_source),
    .lspipe_d_sink(lspipe_d_sink),
    .lspipe_d_data(lspipe_d_data),
    .lspipe_d_denied(lspipe_d_denied),
    .lspipe_d_corrupt(lspipe_d_corrupt),
    .lspipe_d_valid(lspipe_d_valid),
    .lspipe_d_ready(lspipe_d_ready),
    .lsu_dlm0_a_addr(lsu_dlm0_a_addr),
    .lsu_dlm0_a_func(lsu_dlm0_a_func),
    .lsu_dlm0_a_ready(lsu_dlm0_a_ready),
    .lsu_dlm0_a_stall(lsu_dlm0_a_stall),
    .lsu_dlm0_a_user(lsu_dlm0_a_user),
    .lsu_dlm0_a_valid(lsu_dlm0_a_valid),
    .lsu_dlm1_a_addr(lsu_dlm1_a_addr),
    .lsu_dlm1_a_func(lsu_dlm1_a_func),
    .lsu_dlm1_a_ready(lsu_dlm1_a_ready),
    .lsu_dlm1_a_stall(lsu_dlm1_a_stall),
    .lsu_dlm1_a_user(lsu_dlm1_a_user),
    .lsu_dlm1_a_valid(lsu_dlm1_a_valid),
    .lsu_dlm2_a_addr(lsu_dlm2_a_addr),
    .lsu_dlm2_a_func(lsu_dlm2_a_func),
    .lsu_dlm2_a_ready(lsu_dlm2_a_ready),
    .lsu_dlm2_a_stall(lsu_dlm2_a_stall),
    .lsu_dlm2_a_user(lsu_dlm2_a_user),
    .lsu_dlm2_a_valid(lsu_dlm2_a_valid),
    .lsu_dlm3_a_addr(lsu_dlm3_a_addr),
    .lsu_dlm3_a_func(lsu_dlm3_a_func),
    .lsu_dlm3_a_ready(lsu_dlm3_a_ready),
    .lsu_dlm3_a_stall(lsu_dlm3_a_stall),
    .lsu_dlm3_a_user(lsu_dlm3_a_user),
    .lsu_dlm3_a_valid(lsu_dlm3_a_valid),
    .lsu_dlm0_d_data(lsu_dlm0_d_data),
    .lsu_dlm0_d_status(lsu_dlm0_d_status),
    .lsu_dlm0_d_user(lsu_dlm0_d_user),
    .lsu_dlm0_d_valid(lsu_dlm0_d_valid),
    .lsu_dlm1_d_data(lsu_dlm1_d_data),
    .lsu_dlm1_d_status(lsu_dlm1_d_status),
    .lsu_dlm1_d_user(lsu_dlm1_d_user),
    .lsu_dlm1_d_valid(lsu_dlm1_d_valid),
    .lsu_dlm2_d_data(lsu_dlm2_d_data),
    .lsu_dlm2_d_status(lsu_dlm2_d_status),
    .lsu_dlm2_d_user(lsu_dlm2_d_user),
    .lsu_dlm2_d_valid(lsu_dlm2_d_valid),
    .lsu_dlm3_d_data(lsu_dlm3_d_data),
    .lsu_dlm3_d_status(lsu_dlm3_d_status),
    .lsu_dlm3_d_user(lsu_dlm3_d_user),
    .lsu_dlm3_d_valid(lsu_dlm3_d_valid),
    .lsu_dlm0_w_data(lsu_dlm0_w_data),
    .lsu_dlm0_w_mask(lsu_dlm0_w_mask),
    .lsu_dlm0_w_ready(lsu_dlm0_w_ready),
    .lsu_dlm0_w_status(lsu_dlm0_w_status),
    .lsu_dlm0_w_valid(lsu_dlm0_w_valid),
    .lsu_dlm1_w_data(lsu_dlm1_w_data),
    .lsu_dlm1_w_mask(lsu_dlm1_w_mask),
    .lsu_dlm1_w_ready(lsu_dlm1_w_ready),
    .lsu_dlm1_w_status(lsu_dlm1_w_status),
    .lsu_dlm1_w_valid(lsu_dlm1_w_valid),
    .lsu_dlm2_w_data(lsu_dlm2_w_data),
    .lsu_dlm2_w_mask(lsu_dlm2_w_mask),
    .lsu_dlm2_w_ready(lsu_dlm2_w_ready),
    .lsu_dlm2_w_status(lsu_dlm2_w_status),
    .lsu_dlm2_w_valid(lsu_dlm2_w_valid),
    .lsu_dlm3_w_data(lsu_dlm3_w_data),
    .lsu_dlm3_w_mask(lsu_dlm3_w_mask),
    .lsu_dlm3_w_ready(lsu_dlm3_w_ready),
    .lsu_dlm3_w_status(lsu_dlm3_w_status),
    .lsu_dlm3_w_valid(lsu_dlm3_w_valid),
    .lsu_ilm_a_addr(lsu_ilm_a_addr),
    .lsu_ilm_a_func(lsu_ilm_a_func),
    .lsu_ilm_a_ready(lsu_ilm_a_ready),
    .lsu_ilm_a_stall(lsu_ilm_a_stall),
    .lsu_ilm_a_user(lsu_ilm_a_user),
    .lsu_ilm_a_valid(lsu_ilm_a_valid),
    .lsu_ilm_d_data(lsu_ilm_d_data),
    .lsu_ilm_d_status(lsu_ilm_d_status),
    .lsu_ilm_d_user(lsu_ilm_d_user),
    .lsu_ilm_d_valid(lsu_ilm_d_valid),
    .lsu_ilm_w_data(lsu_ilm_w_data),
    .lsu_ilm_w_mask(lsu_ilm_w_mask),
    .lsu_ilm_w_ready(lsu_ilm_w_ready),
    .lsu_ilm_w_status(lsu_ilm_w_status),
    .lsu_ilm_w_valid(lsu_ilm_w_valid),
    .trigm_ls_load(trigm_ls_load),
    .trigm_ls_store(trigm_ls_store),
    .trigm_ls_addr(trigm_ls_addr),
    .trigm_ls_result(trigm_ls_result),
    .lsu_async_write_error(lsu_async_write_error)
);
kv_lsu_buf #(
    .ADDR_WIDTH(PALEN),
    .DATA_WIDTH(32),
    .NUM_BUF(0),
    .TL_SINK_WIDTH(TL_SINK_WIDTH)
) u_lsu_buf (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .lspipe_a_address(lspipe_a_address),
    .lspipe_a_corrupt(lspipe_a_corrupt),
    .lspipe_a_data(lspipe_a_data),
    .lspipe_a_mask(lspipe_a_mask),
    .lspipe_a_opcode(lspipe_a_opcode),
    .lspipe_a_param(lspipe_a_param),
    .lspipe_a_ready(lspipe_a_ready),
    .lspipe_a_size(lspipe_a_size),
    .lspipe_a_source(lspipe_a_source),
    .lspipe_a_user(lspipe_a_user),
    .lspipe_a_valid(lspipe_a_valid),
    .lspipe_d_corrupt(lspipe_d_corrupt),
    .lspipe_d_data(lspipe_d_data),
    .lspipe_d_denied(lspipe_d_denied),
    .lspipe_d_opcode(lspipe_d_opcode),
    .lspipe_d_param(lspipe_d_param),
    .lspipe_d_ready(lspipe_d_ready),
    .lspipe_d_sink(lspipe_d_sink),
    .lspipe_d_size(lspipe_d_size),
    .lspipe_d_source(lspipe_d_source),
    .lspipe_d_user(lspipe_d_user),
    .lspipe_d_valid(lspipe_d_valid),
    .lsbuf_a_address(lsbuf_a_address),
    .lsbuf_a_corrupt(lsbuf_a_corrupt),
    .lsbuf_a_data(lsbuf_a_data),
    .lsbuf_a_mask(lsbuf_a_mask),
    .lsbuf_a_opcode(lsbuf_a_opcode),
    .lsbuf_a_param(lsbuf_a_param),
    .lsbuf_a_ready(lsbuf_a_ready),
    .lsbuf_a_size(lsbuf_a_size),
    .lsbuf_a_source(lsbuf_a_source),
    .lsbuf_a_user(lsbuf_a_user),
    .lsbuf_a_valid(lsbuf_a_valid),
    .lsbuf_d_corrupt(lsbuf_d_corrupt),
    .lsbuf_d_data(lsbuf_d_data),
    .lsbuf_d_denied(lsbuf_d_denied),
    .lsbuf_d_opcode(lsbuf_d_opcode),
    .lsbuf_d_param(lsbuf_d_param),
    .lsbuf_d_ready(lsbuf_d_ready),
    .lsbuf_d_sink(lsbuf_d_sink),
    .lsbuf_d_size(lsbuf_d_size),
    .lsbuf_d_source(lsbuf_d_source),
    .lsbuf_d_user(lsbuf_d_user),
    .lsbuf_d_valid(lsbuf_d_valid)
);
kv_lsu_arb #(
    .EXTVALEN(EXTVALEN),
    .LSQ_DEPTH(LSQ_DEPTH),
    .PALEN(PALEN),
    .PERFORMANCE_MONITOR_INT(PERFORMANCE_MONITOR_INT),
    .VALEN(VALEN)
) u_lsu_arb (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .arb_standby_ready(arb_standby_ready),
    .ls_privilege_u(ls_privilege_u),
    .lsu_dtlb_privilege_u(lsu_dtlb_privilege_u),
    .lsu_dtlb_va_op0(lsu_dtlb_va_op0),
    .lsu_dtlb_va_op1(lsu_dtlb_va_op1),
    .lsu_dtlb_store(lsu_dtlb_store),
    .dtlb_lsu_ppn(dtlb_lsu_ppn),
    .lsq_req_valid(lsq_req_valid),
    .lsq_req_stall(lsq_req_stall),
    .lsq_req_src(lsq_req_src),
    .lsq_req_func(lsq_req_func),
    .lsq_req_pc(lsq_req_pc),
    .lsq_req_va(lsq_req_va),
    .lsq_req_va_op0(lsq_req_va_op0),
    .lsq_req_va_op1(lsq_req_va_op1),
    .lsq_req_offset(lsq_req_offset),
    .lsq_req_ilm(lsq_req_ilm),
    .lsq_req_dlm(lsq_req_dlm),
    .lsq_req_ready(lsq_req_ready),
    .lsq_ack_valid(lsq_ack_valid),
    .lsq_ack_src(lsq_ack_src),
    .lsq_ack_result(lsq_ack_result),
    .lsq_ack_result2(lsq_ack_result2),
    .lsq_ack_bresult(lsq_ack_bresult),
    .lsq_ack_fault_va(lsq_ack_fault_va),
    .lsq_ack_pa(lsq_ack_pa),
    .lsq_ack_status(lsq_ack_status),
    .lsq_cmt_wdata(lsq_cmt_wdata),
    .lsq_commit(lsq_commit),
    .lsq_kill(lsq_kill),
    .iptw_req_valid(iptw_req_valid),
    .iptw_req_pa(iptw_req_pa),
    .iptw_req_func(iptw_req_func),
    .iptw_req_ready(iptw_req_ready),
    .iptw_ack_valid(iptw_ack_valid),
    .iptw_ack_result(iptw_ack_result),
    .iptw_ack_status(iptw_ack_status),
    .dptw_req_valid(dptw_req_valid),
    .dptw_req_pa(dptw_req_pa),
    .dptw_req_func(dptw_req_func),
    .dptw_req_ready(dptw_req_ready),
    .dptw_ack_valid(dptw_ack_valid),
    .dptw_ack_result(dptw_ack_result),
    .dptw_ack_status(dptw_ack_status),
    .prf_req_valid(prf_req_valid),
    .prf_req_va(prf_req_va),
    .prf_req_func(prf_req_func),
    .prf_req_pc(prf_req_pc),
    .prf_req_ready(prf_req_ready),
    .prf_ack_valid(prf_ack_valid),
    .prf_ack_status(prf_ack_status),
    .lsp_req_valid(lsp_req_valid),
    .lsp_req_stall(lsp_req_stall),
    .lsp_req_ptw(lsp_req_ptw),
    .lsp_req_src(lsp_req_src),
    .lsp_req_func(lsp_req_func),
    .lsp_req_pc(lsp_req_pc),
    .lsp_req_va(lsp_req_va),
    .lsp_req_va_lm(lsp_req_va_lm),
    .lsp_req_base_va20(lsp_req_base_va20),
    .lsp_req_pa(lsp_req_pa),
    .lsp_req_offset(lsp_req_offset),
    .lsp_req_ilm(lsp_req_ilm),
    .lsp_req_dlm(lsp_req_dlm),
    .lsp_req_ready(lsp_req_ready),
    .lsp_ack_valid(lsp_ack_valid),
    .lsp_ack_kill(lsp_ack_kill),
    .lsp_ack_src(lsp_ack_src),
    .lsp_ack_result(lsp_ack_result),
    .lsp_ack_result2(lsp_ack_result2),
    .lsp_ack_bresult(lsp_ack_bresult),
    .lsp_ack_va(lsp_ack_va),
    .lsp_ack_fault_va(lsp_ack_fault_va),
    .lsp_ack_pa(lsp_ack_pa),
    .lsp_ack_status(lsp_ack_status),
    .lsp_commit(lsp_commit),
    .lsp_kill(lsp_kill),
    .lsp_cmt_wdata(lsp_cmt_wdata),
    .lsp_event(lsp_event),
    .lsu_event(lsu_event),
    .lsu_mmu_req_valid(lsu_mmu_req_valid),
    .lsu_mmu_va(lsu_mmu_va),
    .mmu_lsu_resp_valid(mmu_lsu_resp_valid)
);
kv_lsuop #(
    .DCACHE_PREFETCH_SUPPORT_INT(DCACHE_PREFETCH_SUPPORT_INT),
    .DLM_AMSB(DLM_AMSB),
    .DLM_BASE(DLM_BASE),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .EXTVALEN(EXTVALEN),
    .ILM_AMSB(ILM_AMSB),
    .ILM_BASE(ILM_BASE),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .PALEN(PALEN),
    .RVA_SUPPORT_INT(RVA_SUPPORT_INT),
    .UNALIGNED_ACCESS_INT(UNALIGNED_ACCESS_INT),
    .VALEN(VALEN)
) u_lsuop (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_halt_mode(csr_halt_mode),
    .csr_mcache_ctl_dc_en(csr_mcache_ctl_dc_en),
    .csr_mcache_ctl_ic_rwecc(csr_mcache_ctl_ic_rwecc),
    .csr_mcache_ctl_tlb_rwecc(csr_mcache_ctl_tlb_rwecc),
    .csr_mcctlbeginaddr(csr_mcctlbeginaddr),
    .csr_milmb_ien(csr_milmb_ien),
    .csr_mdlmb_den(csr_mdlmb_den),
    .ls_issue_ready(ls_issue_ready),
    .ls_standby_ready(ls_standby_ready),
    .wfi_enabled(wfi_enabled),
    .ls_privilege_m(ls_privilege_m),
    .ls_privilege_s(ls_privilege_s),
    .ls_privilege_u(ls_privilege_u),
    .ls_req_valid(ls_req_valid),
    .ls_req_pc(ls_req_pc),
    .ls_req_stall(ls_req_stall),
    .ls_req_base0(ls_req_base0),
    .ls_req_base1(ls_req_base1),
    .ls_req_base_bypass(ls_req_base_bypass),
    .ls_req_offset(ls_req_offset),
    .ls_req_asid(ls_req_asid),
    .ls_req_func(ls_req_func),
    .ls_resp_valid(ls_resp_valid),
    .ls_resp_result(ls_resp_result),
    .ls_resp_bresult(ls_resp_bresult),
    .ls_resp_fault_addr(ls_resp_fault_addr),
    .ls_resp_status(ls_resp_status),
    .ls_resp_result_64b(ls_resp_result_64b),
    .ls_cmt_valid(ls_cmt_valid),
    .ls_cmt_kill(ls_cmt_kill),
    .ls_cmt_wdata_sel_vpu(ls_cmt_wdata_sel_vpu),
    .ls_cmt_wdata_base(ls_cmt_wdata_base),
    .ls_cmt_wdata_vpu(ls_cmt_wdata_vpu),
    .lsu_reserve_clr(lsu_reserve_clr),
    .lsp_reserve_clr(lsp_reserve_clr),
    .ifu_fence_req(ifu_fence_req),
    .ifu_fence_done(ifu_fence_done),
    .lsu_cctl_raddr(lsu_cctl_raddr),
    .lsu_cctl_rdata(lsu_cctl_rdata),
    .ifu_cctl_req(ifu_cctl_req),
    .ifu_cctl_command(ifu_cctl_command),
    .ifu_cctl_waddr(ifu_cctl_waddr),
    .ifu_cctl_wdata(ifu_cctl_wdata),
    .ifu_cctl_ack(ifu_cctl_ack),
    .ifu_cctl_status(ifu_cctl_status),
    .ifu_cctl_raddr(ifu_cctl_raddr),
    .ifu_cctl_rdata(ifu_cctl_rdata),
    .ifu_cctl_ecc_status(ifu_cctl_ecc_status),
    .dcu_ix_req(dcu_ix_req),
    .dcu_ix_addr(dcu_ix_addr),
    .dcu_ix_command(dcu_ix_command),
    .dcu_ix_wdata(dcu_ix_wdata),
    .dcu_ix_ack(dcu_ix_ack),
    .dcu_ix_rdata(dcu_ix_rdata),
    .dcu_ix_raddr(dcu_ix_raddr),
    .dcu_ix_status(dcu_ix_status),
    .dcu_wbf_flush(dcu_wbf_flush),
    .dcu_acctl_ecc_error(dcu_acctl_ecc_error),
    .dcu_acctl_ecc_corr(dcu_acctl_ecc_corr),
    .tlb_cctl_req(tlb_cctl_req),
    .tlb_cctl_command(tlb_cctl_command),
    .tlb_cctl_waddr(tlb_cctl_waddr),
    .tlb_cctl_wdata(tlb_cctl_wdata),
    .tlb_cctl_ack(tlb_cctl_ack),
    .tlb_cctl_raddr(tlb_cctl_raddr),
    .tlb_cctl_rdata(tlb_cctl_rdata),
    .tlb_cctl_ecc_status(tlb_cctl_ecc_status),
    .ifu_ipipe_standby_ready(ifu_ipipe_standby_ready),
    .lsp_standby_ready(lsp_standby_ready),
    .arb_standby_ready(arb_standby_ready),
    .dcu_standby_ready(dcu_standby_ready),
    .prf_standby_ready(prf_standby_ready),
    .lsq_empty(lsq_empty),
    .lsuop_prefetch_clr(lsuop_prefetch_clr),
    .mmu_fence_req(mmu_fence_req),
    .mmu_fence_done(mmu_fence_done),
    .mmu_fence_mode(mmu_fence_mode),
    .mmu_fence_vaddr(mmu_fence_vaddr),
    .mmu_fence_asid(mmu_fence_asid),
    .uop_issue_ready(uop_issue_ready),
    .uop_req_valid(uop_req_valid),
    .uop_req_stall(uop_req_stall),
    .uop_req_pc(uop_req_pc),
    .uop_req_addr(uop_req_addr),
    .uop_req_func(uop_req_func),
    .uop_req_op0(uop_req_op0),
    .uop_req_op1(uop_req_op1),
    .uop_req_ilm(uop_req_ilm),
    .uop_req_dlm(uop_req_dlm),
    .uop_resp_valid(uop_resp_valid),
    .uop_resp_result(uop_resp_result),
    .uop_resp_result64(uop_resp_result64),
    .uop_resp_bresult(uop_resp_bresult),
    .uop_resp_fault_va(uop_resp_fault_va),
    .uop_resp_pa(uop_resp_pa),
    .uop_resp_status(uop_resp_status),
    .uop_cmt_valid(uop_cmt_valid),
    .uop_cmt_kill(uop_cmt_kill),
    .uop_cmt_wdata_sel_f(uop_cmt_wdata_sel_f),
    .uop_cmt_wdata_i(uop_cmt_wdata_i),
    .uop_cmt_wdata_f(uop_cmt_wdata_f)
);
kv_lsq #(
    .DEPTH(LSQ_DEPTH),
    .DLM_AMSB(DLM_AMSB),
    .DLM_BASE(DLM_BASE),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .EXTVALEN(EXTVALEN),
    .FLEN(FLEN),
    .ILM_AMSB(ILM_AMSB),
    .ILM_BASE(ILM_BASE),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .PALEN(PALEN),
    .VALEN(VALEN)
) u_lsq (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_milmb_ien(csr_milmb_ien),
    .csr_mdlmb_den(csr_mdlmb_den),
    .lsq_empty(lsq_empty),
    .uop_issue_ready(uop_issue_ready),
    .ls_una_wait(ls_una_wait),
    .uop_req_valid(uop_req_valid),
    .uop_req_stall(uop_req_stall),
    .uop_req_func(uop_req_func),
    .uop_req_pc(uop_req_pc),
    .uop_req_addr(uop_req_addr),
    .uop_req_ilm(uop_req_ilm),
    .uop_req_dlm(uop_req_dlm),
    .uop_req_op0(uop_req_op0),
    .uop_req_op1(uop_req_op1),
    .uop_resp_valid(uop_resp_valid),
    .uop_resp_result(uop_resp_result),
    .uop_resp_result64(uop_resp_result64),
    .uop_resp_bresult(uop_resp_bresult),
    .uop_resp_fault_va(uop_resp_fault_va),
    .uop_resp_pa(uop_resp_pa),
    .uop_resp_status(uop_resp_status),
    .uop_cmt_valid(uop_cmt_valid),
    .uop_cmt_kill(uop_cmt_kill),
    .uop_cmt_wdata_i(uop_cmt_wdata_i),
    .uop_cmt_wdata_f(uop_cmt_wdata_f),
    .uop_cmt_wdata_sel_f(uop_cmt_wdata_sel_f),
    .lsq_req_valid(lsq_req_valid),
    .lsq_req_stall(lsq_req_stall),
    .lsq_req_src(lsq_req_src),
    .lsq_req_func(lsq_req_func),
    .lsq_req_pc(lsq_req_pc),
    .lsq_req_va(lsq_req_va),
    .lsq_req_va_op0(lsq_req_va_op0),
    .lsq_req_va_op1(lsq_req_va_op1),
    .lsq_req_offset(lsq_req_offset),
    .lsq_req_ilm(lsq_req_ilm),
    .lsq_req_dlm(lsq_req_dlm),
    .lsq_req_ready(lsq_req_ready),
    .lsq_commit(lsq_commit),
    .lsq_kill(lsq_kill),
    .lsq_cmt_wdata(lsq_cmt_wdata),
    .lsq_ack_valid(lsq_ack_valid),
    .lsq_ack_src(lsq_ack_src),
    .lsq_ack_result(lsq_ack_result),
    .lsq_ack_result2(lsq_ack_result2),
    .lsq_ack_bresult(lsq_ack_bresult),
    .lsq_ack_fault_va(lsq_ack_fault_va),
    .lsq_ack_pa(lsq_ack_pa),
    .lsq_ack_status(lsq_ack_status)
);
generate
    if ((DCACHE_PREFETCH_SUPPORT_INT == 1)) begin:gen_rpt
        kv_lsu_rpt #(
            .DLM_AMSB(DLM_AMSB),
            .DLM_BASE(DLM_BASE),
            .EXTVALEN(EXTVALEN),
            .ILM_AMSB(ILM_AMSB),
            .ILM_BASE(ILM_BASE),
            .VALEN(VALEN)
        ) u_lsu_rpt (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .csr_milmb_ien(csr_milmb_ien),
            .csr_mdlmb_den(csr_mdlmb_den),
            .csr_mcache_ctl_dprefetch_en(csr_mcache_ctl_dprefetch_en),
            .lsu_prefetch_clr(lsu_prefetch_clr),
            .lsuop_prefetch_clr(lsuop_prefetch_clr),
            .rpt_cmt_valid(rpt_cmt_valid),
            .rpt_cmt_kill(rpt_cmt_kill),
            .rpt_cmt_pc(rpt_cmt_pc),
            .rpt_cmt_va(rpt_cmt_va),
            .rpt_cmt_status(rpt_cmt_status),
            .prf_req_valid(prf_req_valid),
            .prf_req_func(prf_req_func),
            .prf_req_pc(prf_req_pc),
            .prf_req_va(prf_req_va),
            .prf_req_ready(prf_req_ready),
            .prf_ack_valid(prf_ack_valid),
            .prf_ack_status(prf_ack_status),
            .prf_resp_valid(prf_resp_valid),
            .prf_resp_id(prf_resp_id),
            .prf_resp_status(prf_resp_status),
            .nbload_resp_valid(nbload_resp_valid),
            .nbload_resp_rd(nbload_resp_rd),
            .nbload_resp_status(nbload_resp_status),
            .prf_standby_ready(prf_standby_ready)
        );
    end
endgenerate
generate
    if ((DCACHE_PREFETCH_SUPPORT_INT != 1)) begin:gen_rpt_stub
        kv_lsu_rpt_stub #(
            .DLM_AMSB(DLM_AMSB),
            .DLM_BASE(DLM_BASE),
            .EXTVALEN(EXTVALEN),
            .ILM_AMSB(ILM_AMSB),
            .ILM_BASE(ILM_BASE),
            .VALEN(VALEN)
        ) u_lsu_rpt_stub (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .csr_milmb_ien(csr_milmb_ien),
            .csr_mdlmb_den(csr_mdlmb_den),
            .csr_mcache_ctl_dprefetch_en(csr_mcache_ctl_dprefetch_en),
            .lsu_prefetch_clr(lsu_prefetch_clr),
            .lsuop_prefetch_clr(lsuop_prefetch_clr),
            .rpt_cmt_valid(rpt_cmt_valid),
            .rpt_cmt_kill(rpt_cmt_kill),
            .rpt_cmt_pc(rpt_cmt_pc),
            .rpt_cmt_va(rpt_cmt_va),
            .rpt_cmt_status(rpt_cmt_status),
            .prf_req_valid(prf_req_valid),
            .prf_req_func(prf_req_func),
            .prf_req_pc(prf_req_pc),
            .prf_req_va(prf_req_va),
            .prf_req_ready(prf_req_ready),
            .prf_ack_valid(prf_ack_valid),
            .prf_ack_status(prf_ack_status),
            .prf_resp_valid(prf_resp_valid),
            .prf_resp_id(prf_resp_id),
            .prf_resp_status(prf_resp_status),
            .nbload_resp_valid(nbload_resp_valid),
            .nbload_resp_rd(nbload_resp_rd),
            .nbload_resp_status(nbload_resp_status),
            .prf_standby_ready(prf_standby_ready)
        );
    end
endgenerate
kv_lsu_ptw #(
    .PALEN(PALEN)
) u_dptw (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .mmu_ptw_req_valid(mmu_dptw_req_valid),
    .mmu_ptw_req_pa(mmu_dptw_req_pa),
    .ptw_mmu_req_ready(dptw_mmu_req_ready),
    .ptw_mmu_resp_valid(dptw_mmu_resp_valid),
    .ptw_mmu_resp_status(dptw_mmu_resp_status),
    .ptw_mmu_resp_data(dptw_mmu_resp_data),
    .ptw_req_valid(dptw_req_valid),
    .ptw_req_pa(dptw_req_pa),
    .ptw_req_func(dptw_req_func),
    .ptw_req_ready(dptw_req_ready),
    .ptw_ack_valid(dptw_ack_valid),
    .ptw_ack_result(dptw_ack_result),
    .ptw_ack_status(dptw_ack_status)
);
kv_lsu_ptw #(
    .PALEN(PALEN)
) u_iptw (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .mmu_ptw_req_valid(mmu_iptw_req_valid),
    .mmu_ptw_req_pa(mmu_iptw_req_pa),
    .ptw_mmu_req_ready(iptw_mmu_req_ready),
    .ptw_mmu_resp_valid(iptw_mmu_resp_valid),
    .ptw_mmu_resp_status(iptw_mmu_resp_status),
    .ptw_mmu_resp_data(iptw_mmu_resp_data),
    .ptw_req_valid(iptw_req_valid),
    .ptw_req_pa(iptw_req_pa),
    .ptw_req_func(iptw_req_func),
    .ptw_req_ready(iptw_req_ready),
    .ptw_ack_valid(iptw_ack_valid),
    .ptw_ack_result(iptw_ack_result),
    .ptw_ack_status(iptw_ack_status)
);
kv_lsu_brg #(
    .L2_ADDR_WIDTH(L2_ADDR_WIDTH),
    .L2_DATA_WIDTH(L2_DATA_WIDTH),
    .PALEN(PALEN),
    .TL_SINK_WIDTH(TL_SINK_WIDTH)
) u_lsu_brg (
    .lsbuf_a_opcode(lsbuf_a_opcode),
    .lsbuf_a_param(lsbuf_a_param),
    .lsbuf_a_user(lsbuf_a_user),
    .lsbuf_a_size(lsbuf_a_size),
    .lsbuf_a_address(lsbuf_a_address),
    .lsbuf_a_source(lsbuf_a_source),
    .lsbuf_a_data(lsbuf_a_data),
    .lsbuf_a_mask(lsbuf_a_mask),
    .lsbuf_a_corrupt(lsbuf_a_corrupt),
    .lsbuf_a_valid(lsbuf_a_valid),
    .lsbuf_a_ready(lsbuf_a_ready),
    .lsbuf_d_opcode(lsbuf_d_opcode),
    .lsbuf_d_param(lsbuf_d_param),
    .lsbuf_d_user(lsbuf_d_user),
    .lsbuf_d_size(lsbuf_d_size),
    .lsbuf_d_source(lsbuf_d_source),
    .lsbuf_d_sink(lsbuf_d_sink),
    .lsbuf_d_data(lsbuf_d_data),
    .lsbuf_d_denied(lsbuf_d_denied),
    .lsbuf_d_corrupt(lsbuf_d_corrupt),
    .lsbuf_d_valid(lsbuf_d_valid),
    .lsbuf_d_ready(lsbuf_d_ready),
    .lsu_a_opcode(lsu_a_opcode),
    .lsu_a_param(lsu_a_param),
    .lsu_a_user(lsu_a_user),
    .lsu_a_size(lsu_a_size),
    .lsu_a_source(lsu_a_source),
    .lsu_a_address(lsu_a_address),
    .lsu_a_data(lsu_a_data),
    .lsu_a_mask(lsu_a_mask),
    .lsu_a_corrupt(lsu_a_corrupt),
    .lsu_a_valid(lsu_a_valid),
    .lsu_a_ready(lsu_a_ready),
    .lsu_d_opcode(lsu_d_opcode),
    .lsu_d_param(lsu_d_param),
    .lsu_d_user(lsu_d_user),
    .lsu_d_size(lsu_d_size),
    .lsu_d_source(lsu_d_source),
    .lsu_d_sink(lsu_d_sink),
    .lsu_d_data(lsu_d_data),
    .lsu_d_denied(lsu_d_denied),
    .lsu_d_corrupt(lsu_d_corrupt),
    .lsu_d_valid(lsu_d_valid),
    .lsu_d_ready(lsu_d_ready),
    .core_clk(core_clk),
    .core_reset_n(core_reset_n)
);
endmodule


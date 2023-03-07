// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_ifu (
    core_clk,
    core_reset_n,
    lm_reset_done,
    icache_disable_init,
    btb_init_done,
    ifu_fence_req,
    ifu_fence_done,
    ifu_event,
    resume,
    resume_for_replay,
    resume_pc,
    resume_vectored,
    retry,
    retry_pc,
    redirect,
    redirect_for_cti,
    redirect_pc,
    redirect_pc_hit_ilm,
    redirect_ras_ptr,
    ipipe_ifu_stall,
    ifu_ipipe_standby_ready,
    ifu_ipipe_init_done,
    ex9_lookup_valid,
    ex9_lookup_pc,
    ex9_lookup_ready,
    ex9_lookup_resp_valid,
    ex9_lookup_resp_ready,
    ex9_lookup_resp_instr,
    ex9_lookup_resp_fault,
    ex9_lookup_resp_fault_dcause,
    ex9_lookup_resp_page_fault,
    ex9_lookup_resp_ecc_corr,
    ex9_lookup_resp_ecc_code,
    ex9_lookup_resp_ecc_ramid,
    ifu_ilm_kill,
    ifu_ilm_req_valid,
    ifu_ilm_req_stall,
    ifu_ilm_req_addr,
    ifu_ilm_req_tag,
    ilm_ifu_req_ready,
    ilm_ifu_resp_valid,
    ilm_ifu_resp_rdata,
    ilm_ifu_resp_tag,
    ilm_ifu_resp_status,
    ifu_icu_kill,
    icu_ifu_bus_req_full,
    icu_ifu_bus_req_event,
    ifu_icu_req_valid,
    ifu_icu_req_type,
    ifu_icu_req_addr,
    ifu_icu_req_nonseq,
    ifu_icu_req_rd_word,
    ifu_icu_req_tag,
    ifu_icu_f1_pa,
    ifu_icu_f2_cacheable,
    ifu_icu_f2_cctl_pref,
    ifu_icu_req_wdata,
    ifu_icu_req_wecc,
    icu_ifu_req_ready,
    icu_ifu_resp_valid,
    icu_ifu_resp_tag,
    icu_ifu_resp_status,
    icu_ifu_resp_rdata,
    ifu_icu_line_aq,
    ifu_icu_line_aq_addr,
    ifu_icu_line_aq_index,
    ifu_icu_line_aq_attri,
    icu_ifu_line_aq_error,
    icu_ifu_line_aq_done,
    ifu_icu_line_op_req,
    ifu_icu_line_op,
    icu_ifu_line_op_req_done,
    icu_standby_ready,
    ifu_itlb_req_valid,
    ifu_itlb_va,
    itlb_ifu_pa,
    itlb_ifu_status,
    ifu_mmu_req_valid,
    ifu_mmu_va,
    mmu_ifu_resp_valid,
    ifu_pmp_req_pa,
    pmp_ifu_resp_fault,
    ifu_pma_req_pa,
    pma_ifu_resp_fault,
    pma_ifu_resp_mtype,
    csr_milmb_ien,
    csr_milmb_eccen,
    csr_mmisc_ctl_brpe,
    csr_trap_delegated,
    csr_halt_mode,
    csr_mcache_ctl_iprefetch_en,
    csr_mcache_ctl_ic_en,
    csr_mxstatus_ime,
    csr_mcache_ctl_ic_eccen,
    csr_mcache_ctl_ic_rwecc,
    csr_mecc_code,
    csr_cur_privilege,
    ifu_i0_valid,
    ifu_i0_pc,
    ifu_i0_instr,
    ifu_i0_vector_resume,
    ifu_i0_instr_16b,
    ifu_i0_keep_bhr,
    ifu_i0_pred_valid,
    ifu_i0_pred_hit,
    ifu_i0_pred_way,
    ifu_i0_pred_taken,
    ifu_i0_pred_ret,
    ifu_i0_pred_cnt,
    ifu_i0_pred_npc,
    ifu_i0_pred_start,
    ifu_i0_pred_brk,
    ifu_i0_pred_bogus,
    ifu_i0_fault,
    ifu_i0_fault_dcause,
    ifu_i0_page_fault,
    ifu_i0_fault_upper,
    ifu_i0_ecc_corr,
    ifu_i0_ecc_code,
    ifu_i0_ecc_ramid,
    ifu_i0_ready,
    ifu_i1_valid,
    ifu_i1_pc,
    ifu_i1_instr,
    ifu_i1_vector_resume,
    ifu_i1_instr_16b,
    ifu_i1_keep_bhr,
    ifu_i1_pred_valid,
    ifu_i1_pred_hit,
    ifu_i1_pred_way,
    ifu_i1_pred_taken,
    ifu_i1_pred_ret,
    ifu_i1_pred_cnt,
    ifu_i1_pred_npc,
    ifu_i1_pred_start,
    ifu_i1_pred_brk,
    ifu_i1_pred_bogus,
    ifu_i1_fault,
    ifu_i1_fault_dcause,
    ifu_i1_page_fault,
    ifu_i1_fault_upper,
    ifu_i1_ecc_corr,
    ifu_i1_ecc_code,
    ifu_i1_ecc_ramid,
    ifu_i1_ready,
    ifu_cctl_req,
    ifu_cctl_command,
    ifu_cctl_waddr,
    ifu_cctl_wdata,
    ifu_cctl_ack,
    ifu_cctl_status,
    ifu_cctl_rdata,
    ifu_cctl_raddr,
    ifu_cctl_ecc_status,
    bpu_rd_valid,
    bpu_rd_ack,
    bpu_info_hit,
    bpu_info_fall_thru_pc,
    bpu_info_target,
    bpu_info_start_pc,
    bpu_info_offset,
    bpu_info_way,
    bpu_info_ucond,
    bpu_info_ret,
    bpu_info_pred_taken,
    bpu_info_pred_cnt,
    bpu_rd_ready
);
parameter VALEN = 32;
parameter EXTVALEN = 32;
parameter PALEN = 32;
parameter ILM_SIZE_KB = 8;
parameter ILM_AMSB = 13;
parameter ILM_BASE = 32'h1000_0000;
parameter LM_ENABLE_CTRL_INT = 0;
parameter ICACHE_WAY = 2;
parameter BTB_SIZE = 0;
parameter MMU_SCHEME_INT = 0;
parameter ICACHE_SIZE_KB = 0;
parameter ICACHE_TAG_RAM_AW = 9;
parameter ICACHE_TAG_RAM_DW = 26;
parameter ICACHE_INDEX_MSB = 10;
parameter ICACHE_TAG_ECC_DW = 16;
parameter DEVICE_REGION0_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION0_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION1_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION1_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION2_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION2_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION3_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION3_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION4_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION4_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION5_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION5_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION6_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION6_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION7_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION7_MASK = 64'h00000000_00000000;
localparam NO_ECC_TAG_DW = ICACHE_TAG_RAM_DW - ICACHE_TAG_ECC_DW;
localparam TAG_MSB = (ICACHE_SIZE_KB == 0) ? 0 : (PALEN - 1);
localparam TAG_LSB = (ICACHE_SIZE_KB == 0) ? TAG_MSB : (TAG_MSB - NO_ECC_TAG_DW + 4);
localparam TAG_WIDTH = TAG_MSB - TAG_LSB + 1;
localparam INDEX_MSB = ICACHE_INDEX_MSB;
localparam INDEX_LSB = 6;
localparam INDEX_WIDTH = INDEX_MSB - INDEX_LSB + 1;
localparam OFFSET_MSB = 5;
localparam OFFSET_LSB = 3;
localparam OFFSET_WIDTH = OFFSET_MSB - OFFSET_LSB + 1;
localparam CACHE_VALID = NO_ECC_TAG_DW - 1;
localparam CACHE_LOCK = NO_ECC_TAG_DW - 2;
localparam CACHE_LOCK_DUP = NO_ECC_TAG_DW - 3;
localparam INIT_RESET = 3'b000;
localparam INIT_BTB = 3'b001;
localparam INIT_LM = 3'b010;
localparam INIT_CACHE = 3'b011;
localparam INIT_DONE = 3'b100;
localparam UNUSED_PC_BIT_NUM = 1;
localparam PRIVILEGE_USER = 2'b00;
localparam PRIVILEGE_MACHINE = 2'b11;
localparam FQ_DEPTH_LOGIC = 3'd4;
localparam FQ_DEPTH = 4;
localparam FQ_NCNT_MSB = 2;
localparam ST_FETCH = 3'd0;
localparam ST_FILL_TLB = 3'd1;
localparam ST_XCPT_STALL = 3'd2;
localparam ST_RECOVER = 3'd3;
localparam ST_ECC_INV = 3'd4;
localparam ST_MH = 3'd5;
localparam ST_EX9_FETCH = 3'd6;
localparam ST_MH_IDLE = 2'd0;
localparam ST_MH_WOST = 2'd1;
localparam ST_MH_PREF = 2'd2;
input core_clk;
input core_reset_n;
input lm_reset_done;
input icache_disable_init;
input btb_init_done;
input ifu_fence_req;
output ifu_fence_done;
output [5:0] ifu_event;
input resume;
input resume_for_replay;
input [EXTVALEN - 1:0] resume_pc;
input resume_vectored;
input retry;
input [EXTVALEN - 1:0] retry_pc;
input redirect;
input redirect_for_cti;
input [EXTVALEN - 1:0] redirect_pc;
input redirect_pc_hit_ilm;
input [1:0] redirect_ras_ptr;
input ipipe_ifu_stall;
output ifu_ipipe_standby_ready;
output ifu_ipipe_init_done;
input ex9_lookup_valid;
input [EXTVALEN - 1:0] ex9_lookup_pc;
output ex9_lookup_ready;
output ex9_lookup_resp_valid;
input ex9_lookup_resp_ready;
output [31:0] ex9_lookup_resp_instr;
output ex9_lookup_resp_fault;
output [2:0] ex9_lookup_resp_fault_dcause;
output ex9_lookup_resp_page_fault;
output ex9_lookup_resp_ecc_corr;
output [7:0] ex9_lookup_resp_ecc_code;
output [2:0] ex9_lookup_resp_ecc_ramid;
output ifu_ilm_kill;
output ifu_ilm_req_valid;
output ifu_ilm_req_stall;
output [VALEN - 1:0] ifu_ilm_req_addr;
output ifu_ilm_req_tag;
input ilm_ifu_req_ready;
input [3:0] ilm_ifu_resp_valid;
input [63:0] ilm_ifu_resp_rdata;
input ilm_ifu_resp_tag;
input [35:0] ilm_ifu_resp_status;
output ifu_icu_kill;
input icu_ifu_bus_req_full;
input icu_ifu_bus_req_event;
output ifu_icu_req_valid;
output [2:0] ifu_icu_req_type;
output [VALEN - 1:0] ifu_icu_req_addr;
output ifu_icu_req_nonseq;
output [1:0] ifu_icu_req_rd_word;
output ifu_icu_req_tag;
output [PALEN - 1:0] ifu_icu_f1_pa;
output ifu_icu_f2_cacheable;
output ifu_icu_f2_cctl_pref;
output [71:0] ifu_icu_req_wdata;
output ifu_icu_req_wecc;
input icu_ifu_req_ready;
input [3:0] icu_ifu_resp_valid;
input icu_ifu_resp_tag;
input [35:0] icu_ifu_resp_status;
input [63:0] icu_ifu_resp_rdata;
output ifu_icu_line_aq;
output [PALEN - 1:0] ifu_icu_line_aq_addr;
output [ICACHE_INDEX_MSB:6] ifu_icu_line_aq_index;
output [16:0] ifu_icu_line_aq_attri;
input icu_ifu_line_aq_error;
input icu_ifu_line_aq_done;
output ifu_icu_line_op_req;
output [1:0] ifu_icu_line_op;
input icu_ifu_line_op_req_done;
input icu_standby_ready;
output ifu_itlb_req_valid;
output [EXTVALEN - 1:0] ifu_itlb_va;
input [PALEN - 1:0] itlb_ifu_pa;
input [18:0] itlb_ifu_status;
output ifu_mmu_req_valid;
output [EXTVALEN - 1:0] ifu_mmu_va;
input mmu_ifu_resp_valid;
output [PALEN - 1:0] ifu_pmp_req_pa;
input pmp_ifu_resp_fault;
output [PALEN - 1:0] ifu_pma_req_pa;
input pma_ifu_resp_fault;
input [3:0] pma_ifu_resp_mtype;
input csr_milmb_ien;
input [1:0] csr_milmb_eccen;
input csr_mmisc_ctl_brpe;
input csr_trap_delegated;
input csr_halt_mode;
input csr_mcache_ctl_iprefetch_en;
input csr_mcache_ctl_ic_en;
input csr_mxstatus_ime;
input [1:0] csr_mcache_ctl_ic_eccen;
input csr_mcache_ctl_ic_rwecc;
input [31:0] csr_mecc_code;
input [1:0] csr_cur_privilege;
output ifu_i0_valid;
output [EXTVALEN - 1:0] ifu_i0_pc;
output [31:0] ifu_i0_instr;
output ifu_i0_vector_resume;
output ifu_i0_instr_16b;
output ifu_i0_keep_bhr;
output ifu_i0_pred_valid;
output ifu_i0_pred_hit;
output [1:0] ifu_i0_pred_way;
output ifu_i0_pred_taken;
output ifu_i0_pred_ret;
output [3:0] ifu_i0_pred_cnt;
output [VALEN - 1:0] ifu_i0_pred_npc;
output ifu_i0_pred_start;
output ifu_i0_pred_brk;
output ifu_i0_pred_bogus;
output ifu_i0_fault;
output [2:0] ifu_i0_fault_dcause;
output ifu_i0_page_fault;
output ifu_i0_fault_upper;
output ifu_i0_ecc_corr;
output [7:0] ifu_i0_ecc_code;
output [2:0] ifu_i0_ecc_ramid;
input ifu_i0_ready;
output ifu_i1_valid;
output [EXTVALEN - 1:0] ifu_i1_pc;
output [31:0] ifu_i1_instr;
output ifu_i1_vector_resume;
output ifu_i1_instr_16b;
output ifu_i1_keep_bhr;
output ifu_i1_pred_valid;
output ifu_i1_pred_hit;
output [1:0] ifu_i1_pred_way;
output ifu_i1_pred_taken;
output ifu_i1_pred_ret;
output [3:0] ifu_i1_pred_cnt;
output [VALEN - 1:0] ifu_i1_pred_npc;
output ifu_i1_pred_start;
output ifu_i1_pred_brk;
output ifu_i1_pred_bogus;
output ifu_i1_fault;
output [2:0] ifu_i1_fault_dcause;
output ifu_i1_page_fault;
output ifu_i1_fault_upper;
output ifu_i1_ecc_corr;
output [7:0] ifu_i1_ecc_code;
output [2:0] ifu_i1_ecc_ramid;
input ifu_i1_ready;
input ifu_cctl_req;
input [4:0] ifu_cctl_command;
input [31:0] ifu_cctl_waddr;
input [31:0] ifu_cctl_wdata;
output ifu_cctl_ack;
output [4:0] ifu_cctl_status;
output [31:0] ifu_cctl_rdata;
output [31:0] ifu_cctl_raddr;
output [11:0] ifu_cctl_ecc_status;
output bpu_rd_valid;
input bpu_rd_ack;
input bpu_info_hit;
input [VALEN - 1:0] bpu_info_fall_thru_pc;
input [VALEN - 1:0] bpu_info_target;
input [VALEN - 1:0] bpu_info_start_pc;
input [9:0] bpu_info_offset;
input [1:0] bpu_info_way;
input bpu_info_ucond;
input bpu_info_ret;
input bpu_info_pred_taken;
input [3:0] bpu_info_pred_cnt;
input bpu_rd_ready;


wire ifu_cctl_ack;
wire [4:0] ifu_cctl_status;
wire [11:0] ifu_cctl_ecc_status;
wire [31:0] ifu_cctl_rdata;
wire [31:0] ifu_cctl_raddr;
wire rvc_en = 1'b1;
wire btb_support = (BTB_SIZE != 0);
reg [2:0] init_ctr_cs;
reg [2:0] init_ctr_ns;
wire init_ctr_done = init_ctr_cs == INIT_DONE;
reg f0_valid;
reg [EXTVALEN - 1:0] f0_pc;
reg f0_vectored;
wire f0_vectored_nx;
reg vector_fetching;
wire vector_fetching_set;
wire vector_fetching_clr;
wire vector_fetching_nx;
wire [EXTVALEN - 1:0] f0_pc_nx;
wire f0_pc_update;
wire [EXTVALEN - 1:0] f0_pc_flush_init_value;
wire f0_valid_set;
wire f0_valid_clr;
reg f0_bblk_start;
wire f0_bblk_start_nx;
wire req_ready;
wire [EXTVALEN - 1:0] req_addr;
wire req_bblk_start;
wire req_hit_ilm;
wire ilm_enable;
wire target_bblk_start;
wire target_pred_taken;
wire target_rd_low_word_only;
reg resp_sel_ilm;
wire req_valid;
wire fetch_issue;
reg [1:0] num_outstanding_req;
wire [1:0] num_outstanding_req_nx;
wire num_outstanding_req_en;
wire no_outstanding_req = num_outstanding_req == 2'd0;
wire f0_valid_ilm_hit;
wire vector_resume;
wire fetch_kill = redirect | resume | retry;
wire [VALEN - 1:0] target_pc;
wire [OFFSET_WIDTH - 1:0] target_pc_offset;
wire target_pc_hit_ilm;
reg [EXTVALEN - 1:0] seq_pc;
wire seq_pc_update;
wire [EXTVALEN - 1:0] seq_pc_nx;
wire [3:0] fetch_resp_valid;
wire [3:0] fetch_resp_valid_raw;
wire [3:0] fetch_resp_valid_no_xcpt;
wire [3:0] fetch_ex9_resp_valid;
wire fq_full_stall;
wire [FQ_NCNT_MSB:0] ost_max_num;
wire fetch_stall;
wire [3:0] fetch_valid;
wire [63:0] fetch_resp_inst;
wire fetch_bblk_start;
wire fetch_bblk_end;
wire fetch_fault;
wire fetch_page_fault;
wire fetch_pmp_fault;
wire fetch_pma_fault;
wire fetch_ecc_corr;
wire fetch_ecc_xcpt;
wire [7:0] fetch_ecc_code;
wire [2:0] fetch_ecc_ramid;
reg fq_fault;
reg fq_page_fault;
reg fq_pmp_fault;
reg fq_pma_fault;
reg fq_ecc_corr;
reg fq_ecc_xcpt;
reg [7:0] fq_ecc_code;
reg [2:0] fq_ecc_ramid;
wire fq_fault_nx;
wire fq_page_fault_nx;
wire fq_pmp_fault_nx;
wire fq_pma_fault_nx;
wire fq_ecc_corr_nx;
wire fq_ecc_xcpt_nx;
wire [7:0] fq_ecc_code_nx;
wire [2:0] fq_ecc_ramid_nx;
wire resp_valid;
wire no_addr_valid_stall;
wire fetch_nxt_seq_kill_needed_f2;
wire [3:0] fetch_end_offset;
wire resp_raw_is_bblk_end_f2;
wire ic_self_reset_done;
wire ic_self_reset;
wire ic_self_reset_on;
wire [ICACHE_TAG_RAM_AW - 1:0] ic_flush_addr;
wire [EXTVALEN - 1:0] ic_flush_addr_nx_ext;
wire [ICACHE_TAG_RAM_AW - 1:0] ic_flush_addr_nx;
reg [2:0] fetch_req_cs;
reg [2:0] fetch_req_ns;
wire f2_ic_ecc_error;
wire f2_ilm_ecc_error;
wire f2_fetch_data_ecc_error;
wire f2_ic_ecc_corr;
wire f2_ilm_ecc_corr;
wire f2_ecc_replay;
wire f2_ic_ecc_replay;
wire f2_ilm_ecc_replay;
wire f2_no_ack;
wire f2_stall;
wire f2_ilm_stall;
wire f2_fetch_data_ecc_xcpt;
wire f2_ic_ecc_corr_xcpt;
wire f2_ic_ecc_uncorr_xcpt;
wire f2_ic_ecc_xcpt;
wire f2_ilm_ecc_corr_xcpt;
wire f2_ilm_ecc_uncorr_xcpt;
wire f2_ilm_ecc_xcpt;
wire f2_error;
wire f2_xcpt;
wire f2_bblk_start;
wire f2_cache_miss;
wire [2:0] pf_req_type;
reg f1_valid;
reg [2:0] f1_req_type;
reg f1_req_start;
reg [EXTVALEN - 1:0] f1_va;
wire [PALEN - 1:0] f1_pa;
wire f1_cacheability;
wire f1_itlb_miss;
wire f1_itlb_page_fault;
wire f1_itlb_pmp_fault;
wire f1_itlb_pma_fault;
wire f1_itlb_bus_error;
wire f1_itlb_ecc_xcpt;
wire f1_itlb_ecc_corr;
wire [3:0] f1_itlb_ecc_ramid;
wire [7:0] f1_itlb_ecc_code;
wire f1_pa_invalid;
reg f2_valid;
reg [2:0] f2_req_type;
reg f2_req_start;
reg [EXTVALEN - 1:0] f2_va;
reg [PALEN - 1:0] f2_pa;
reg f2_pa_invalid;
reg f2_cacheability;
wire f2_pa_cacheability;
wire f2_cctl_cacheability;
wire f2_cctl_hit_ilm;
reg f2_itlb_page_fault;
reg f2_itlb_pmp_fault;
reg f2_itlb_pma_fault;
reg f2_itlb_bus_error;
reg f2_itlb_miss;
wire f2_pmp_fault;
reg [2:0] f2_itlb_ecc_ramid;
reg [7:0] f2_itlb_ecc_code;
reg f2_itlb_ecc_corr;
reg f2_itlb_ecc_xcpt;
wire f2_pma_fault;
wire [3:0] f2_pma_mtype;
wire all_mmu_req_done;
reg [PALEN - 1:0] line_aq_pa;
reg [INDEX_MSB:INDEX_LSB] line_aq_index;
reg [3:0] line_aq_lock_way;
reg [3:0] line_aq_valid_way;
reg [2:0] line_aq_lru;
reg [3:0] line_aq_pma_mtype;
wire recover_entry_update;
wire recover_cacheability_update;
reg recover_cacheability;
wire recover_cacheability_nx;
reg recover_vector;
reg [EXTVALEN - 1:0] recover_pc;
wire [EXTVALEN - 1:0] recover_pc_nx;
reg recover_bblk_start;
wire recover_bblk_start_nx;
reg cache_miss_recover;
wire this_mmu_req_is_done;
reg itlb_fill_valid;
wire itlb_fill_valid_set;
wire itlb_fill_valid_clr;
wire itlb_fill_valid_nx;
reg [VALEN - 1:0] itlb_fill_va;
wire [EXTVALEN - 1:0] itlb_fill_va_ext;
wire [VALEN - 1:0] itlb_fill_va_nx;
reg itlb_fill_wait_valid;
wire itlb_fill_wait_valid_set;
wire itlb_fill_wait_valid_clr;
wire itlb_fill_wait_valid_nx;
reg [VALEN - 1:0] itlb_fill_wait_va;
reg line_aq;
wire line_aq_en;
wire line_aq_set;
wire line_aq_clr;
wire line_aq_nx;
wire line_aq_attri_update;
wire [EXTVALEN - 1:0] prefetch_addr;
wire [EXTVALEN - 1:0] prefetch_dw_offset;
wire [EXTVALEN - 1:0] prefetch_line_offset;
wire [EXTVALEN - 1:0] prefetch_offset;
wire [EXTVALEN - 1:0] prefetch_addr_base;
wire [EXTVALEN - 1:0] f2_align_addr_base;
wire ic_en = csr_mcache_ctl_ic_en;
wire ime = csr_mxstatus_ime;
wire halt_mode = csr_halt_mode;
reg prefetch_valid;
wire prefetch_valid_set;
wire prefetch_valid_clr;
wire prefetch_valid_nx;
wire prefetch_valid_en;
wire prefetch_issueable;
wire fetch_recover = (fetch_req_cs == ST_RECOVER);
wire fetch_normal = (fetch_req_cs == ST_FETCH);
wire fetch_ex9 = (fetch_req_cs == ST_EX9_FETCH);
wire [EXTVALEN - 1:0] target_pc_va_extend;
wire cache_support = (ICACHE_SIZE_KB != 0);
wire [1:0] mmu_ifu_status = 2'b0;
wire f1_valid_nx;
wire f2_valid_nx;
wire fencei_req = ifu_fence_req & ic_en & ~ime;
wire fencei_done;
wire ic_op_req_pulse;
wire [8:0] ic_op_valid;
reg [8:0] ic_op_valid_pf;
wire ic_op_valid_pf_en;
wire [8:0] ic_op_valid_pf_nx;
wire [VALEN - 1:0] ic_op_addr;
wire [EXTVALEN - 1:0] ic_op_addr_ext;
wire [71:0] ic_op_wdata;
wire cache_flush_valid = ic_op_valid[0];
wire cache_flush_addr_clr;
wire [ICACHE_TAG_RAM_AW - 1:0] cache_flush_index = ic_flush_addr;
reg [FQ_NCNT_MSB:0] fq_ncnt;
wire fq_ncnt_update;
wire [FQ_NCNT_MSB:0] fq_ncnt_nx;
wire fq_wr;
wire fq_rd;
wire [3:0] fq_wr_xcpt;
wire inst0_issue;
wire inst1_issue;
wire i0_bblk_start;
wire i1_bblk_start;
wire i0_32b;
wire i1_32b;
wire fq_i0_valid;
wire [31:0] fq_i0_inst;
wire fq_i0_bblk_start;
wire fq_i0_bblk_end;
wire fq_i0_xcpt;
wire fq_i0_xcpt_upper;
wire fq_i0_bogus;
wire fq_i1_valid;
wire [31:0] fq_i1_inst;
wire fq_i1_bblk_start;
wire fq_i1_bblk_end;
wire fq_i1_xcpt;
wire fq_i1_xcpt_upper;
wire fq_i1_bogus;
wire [EXTVALEN - 1:0] f2_ecc_inv_addr;
reg ecc_inv_for_xcpt;
wire ecc_inv_for_xcpt_nx;
wire fetch_ilm_valid;
wire fetch_icu_valid;
wire [3:0] ilm_ifu_resp_valid_with_mask;
wire tb_ilm_mask;
wire f2_pma_device;
wire f2_pma_uncache;
wire f2_pma_alloc;
wire [3:0] f2_way_lock;
wire f2_all_way_lock;
wire fetch_ex9_last_is_xcpt;
wire ex9_lookup_resp_done;
reg f1_abort;
wire f1_abort_set;
wire f1_abort_clr;
wire f1_abort_nx;
wire f1_abort_en;
reg f2_abort;
wire f2_abort_nx;
wire f2_alive = f2_valid & ~f2_abort;
wire nds_unused_top = csr_mmisc_ctl_brpe | (|redirect_ras_ptr) | icu_ifu_resp_tag | csr_trap_delegated | ilm_ifu_resp_tag;
wire ifu_i0_pred_hit_no_tb;
wire ifu_i1_pred_hit_no_tb;
wire [VALEN - 1:0] ifu_i0_pred_npc_no_tb;
wire [VALEN - 1:0] ifu_i1_pred_npc_no_tb;
assign tb_ilm_mask = 1'b0;
assign ilm_ifu_resp_valid_with_mask = ilm_ifu_resp_valid & ~{4{ilm_ifu_resp_status[34] | tb_ilm_mask}};
assign fetch_ilm_valid = |ilm_ifu_resp_valid_with_mask;
assign fetch_icu_valid = |icu_ifu_resp_valid;
assign ex9_lookup_ready = 1'b1;
generate
    wire ex9_lookup_resp_valid_set;
    wire ex9_lookup_resp_valid_clr;
    wire ex9_lookup_resp_valid_nx;
    wire ex9_lookup_resp_valid_en;
    reg ex9_lookup_resp_valid_reg;
    wire [31:0] ex9_lookup_resp_instr_nx;
    wire ex9_lookup_resp_fault_nx;
    wire [2:0] ex9_lookup_resp_fault_dcause_nx;
    wire ex9_lookup_resp_page_fault_nx;
    wire ex9_lookup_resp_ecc_corr_nx;
    wire [7:0] ex9_lookup_resp_ecc_code_nx;
    wire [2:0] ex9_lookup_resp_ecc_ramid_nx;
    reg [31:0] ex9_lookup_resp_instr_reg;
    reg ex9_lookup_resp_fault_reg;
    reg [2:0] ex9_lookup_resp_fault_dcause_reg;
    reg ex9_lookup_resp_page_fault_reg;
    reg ex9_lookup_resp_ecc_corr_reg;
    reg [7:0] ex9_lookup_resp_ecc_code_reg;
    reg [2:0] ex9_lookup_resp_ecc_ramid_reg;
    wire fetch_ex9_last_is_xcpt_nx;
    reg fetch_ex9_last_is_xcpt_reg;
    assign fetch_ex9_last_is_xcpt_nx = (fetch_req_cs == ST_XCPT_STALL) & ~ifu_icu_line_aq;
    always @(posedge core_clk or negedge core_reset_n) begin
        if (!core_reset_n) begin
            fetch_ex9_last_is_xcpt_reg <= 1'b0;
        end
        else if (ex9_lookup_valid) begin
            fetch_ex9_last_is_xcpt_reg <= fetch_ex9_last_is_xcpt_nx;
        end
    end

    assign fetch_ex9_last_is_xcpt = fetch_ex9_last_is_xcpt_reg;
    assign ex9_lookup_resp_done = (|fetch_ex9_resp_valid) | (f2_no_ack & f2_pmp_fault & fetch_ex9);
    assign ex9_lookup_resp_valid_set = ex9_lookup_resp_done & ~fetch_kill & ~ic_op_req_pulse;
    assign ex9_lookup_resp_valid_clr = ex9_lookup_resp_ready | fetch_kill | ic_op_req_pulse;
    assign ex9_lookup_resp_valid_nx = (ex9_lookup_resp_valid & ~ex9_lookup_resp_valid_clr) | ex9_lookup_resp_valid_set;
    assign ex9_lookup_resp_valid_en = ex9_lookup_resp_valid_set | ex9_lookup_resp_valid_clr;
    always @(posedge core_clk or negedge core_reset_n) begin
        if (!core_reset_n) begin
            ex9_lookup_resp_valid_reg <= 1'b0;
        end
        else if (ex9_lookup_resp_valid_en) begin
            ex9_lookup_resp_valid_reg <= ex9_lookup_resp_valid_nx;
        end
    end

    assign ex9_lookup_resp_valid = ex9_lookup_resp_valid_reg;
    assign ex9_lookup_resp_instr_nx = fetch_resp_inst[31:0];
    assign ex9_lookup_resp_fault_nx = fetch_fault;
    assign ex9_lookup_resp_fault_dcause_nx = f2_itlb_ecc_xcpt ? 3'b1 : f2_fetch_data_ecc_xcpt ? 3'd1 : f2_pmp_fault ? 3'd2 : f2_pma_fault ? 3'd4 : 3'd3;
    assign ex9_lookup_resp_page_fault_nx = fetch_page_fault;
    assign ex9_lookup_resp_ecc_corr_nx = fetch_ecc_corr;
    assign ex9_lookup_resp_ecc_code_nx = fetch_ecc_code;
    assign ex9_lookup_resp_ecc_ramid_nx = fetch_ecc_ramid;
    always @(posedge core_clk or negedge core_reset_n) begin
        if (!core_reset_n) begin
            ex9_lookup_resp_instr_reg <= 32'b0;
            ex9_lookup_resp_fault_reg <= 1'b0;
            ex9_lookup_resp_fault_dcause_reg <= 3'b0;
            ex9_lookup_resp_page_fault_reg <= 1'b0;
            ex9_lookup_resp_ecc_corr_reg <= 1'b0;
            ex9_lookup_resp_ecc_code_reg <= 8'b0;
            ex9_lookup_resp_ecc_ramid_reg <= 3'b0;
        end
        else if (ex9_lookup_resp_valid_set) begin
            ex9_lookup_resp_instr_reg <= ex9_lookup_resp_instr_nx;
            ex9_lookup_resp_fault_reg <= ex9_lookup_resp_fault_nx;
            ex9_lookup_resp_fault_dcause_reg <= ex9_lookup_resp_fault_dcause_nx;
            ex9_lookup_resp_page_fault_reg <= ex9_lookup_resp_page_fault_nx;
            ex9_lookup_resp_ecc_corr_reg <= ex9_lookup_resp_ecc_corr_nx;
            ex9_lookup_resp_ecc_code_reg <= ex9_lookup_resp_ecc_code_nx;
            ex9_lookup_resp_ecc_ramid_reg <= ex9_lookup_resp_ecc_ramid_nx;
        end
    end

    assign ex9_lookup_resp_instr = ex9_lookup_resp_instr_reg;
    assign ex9_lookup_resp_fault = ex9_lookup_resp_fault_reg;
    assign ex9_lookup_resp_fault_dcause = ex9_lookup_resp_fault_dcause_reg;
    assign ex9_lookup_resp_page_fault = ex9_lookup_resp_page_fault_reg;
    assign ex9_lookup_resp_ecc_corr = ex9_lookup_resp_ecc_corr_reg;
    assign ex9_lookup_resp_ecc_code = ex9_lookup_resp_ecc_code_reg;
    assign ex9_lookup_resp_ecc_ramid = ex9_lookup_resp_ecc_ramid_reg;
endgenerate
assign vector_fetching_set = f0_valid & f0_vectored & fetch_issue & (pf_req_type == 3'b0);
assign vector_fetching_clr = fetch_kill;
assign vector_fetching_nx = (vector_fetching & ~vector_fetching_clr) | vector_fetching_set;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        vector_fetching <= 1'b0;
    end
    else begin
        vector_fetching <= vector_fetching_nx;
    end
end

assign vector_resume = vector_fetching;
wire tb_stall;
assign tb_stall = 1'b0;
assign fetch_stall = ipipe_ifu_stall | fq_full_stall | no_addr_valid_stall | (fetch_req_cs == ST_XCPT_STALL) | f2_stall | tb_stall;
assign req_valid = (init_ctr_done & ~fetch_stall & fetch_normal) | (redirect & ~ipipe_ifu_stall & ~redirect_for_cti) | (redirect & ~ipipe_ifu_stall & redirect_for_cti & bpu_rd_ready) | (f0_valid & ~init_ctr_done) | (f0_valid & ~fetch_normal & ~redirect & ~(prefetch_valid & fetch_stall) & ~(fetch_ex9 & (ipipe_ifu_stall | f2_stall)));
kv_sign_ext #(
    .OW(EXTVALEN),
    .IW(VALEN)
) u_target_pc_va_extend (
    .out(target_pc_va_extend),
    .in(target_pc)
);
assign target_pc_offset = target_pc[OFFSET_MSB:OFFSET_LSB];
assign req_addr = redirect ? redirect_pc : f0_valid ? f0_pc : target_pc_va_extend;
assign req_bblk_start = redirect ? redirect_for_cti & btb_support : f0_valid ? f0_bblk_start & btb_support : target_bblk_start & btb_support;
assign f0_valid_ilm_hit = (f0_pc[EXTVALEN - 1:ILM_AMSB + 1] == ILM_BASE[EXTVALEN - 1:ILM_AMSB + 1]) & ~pf_req_type[2];
assign target_pc_hit_ilm = target_pc_va_extend[EXTVALEN - 1:ILM_AMSB + 1] == ILM_BASE[EXTVALEN - 1:ILM_AMSB + 1];
generate
    if ((LM_ENABLE_CTRL_INT == 1)) begin:gen_lm_enable_ctrl
        assign ilm_enable = csr_milmb_ien;
    end
    else begin:gen_lm_alway_on
        wire nds_unused_lm_alway_on = csr_milmb_ien;
        assign ilm_enable = 1'b1;
    end
endgenerate
assign req_hit_ilm = ilm_enable & (ILM_SIZE_KB != 0) & (pf_req_type == 3'b0) & (redirect ? redirect_pc_hit_ilm : f0_valid ? f0_valid_ilm_hit : target_pc_hit_ilm);
assign ifu_icu_req_wdata = {csr_mecc_code[7:0],ic_op_wdata[63:0]} & {72{(fetch_req_cs != ST_ECC_INV) & ~ecc_inv_for_xcpt & ~ic_op_valid_pf[8]}};
assign ifu_icu_req_addr = req_addr[VALEN - 1:0];
assign ifu_icu_req_valid = (req_valid & ~req_hit_ilm & (~resp_sel_ilm | no_outstanding_req)) | (req_valid & redirect & ~redirect_pc_hit_ilm) | (req_valid & redirect & ~ilm_enable) | (req_valid & ~req_hit_ilm & pf_req_type[2]);
assign ifu_icu_req_type = pf_req_type;
assign ifu_icu_req_wecc = csr_mcache_ctl_ic_rwecc;
assign ifu_icu_req_nonseq = redirect | f0_valid | (target_bblk_start & target_pred_taken) | ~(|target_pc_offset);
assign ifu_icu_req_tag = 1'b0;
assign ifu_icu_kill = fetch_kill;
assign ifu_icu_req_rd_word[0] = ~ifu_icu_req_addr[2] | (~redirect & ~fetch_normal);
assign ifu_icu_req_rd_word[1] = ~target_rd_low_word_only | ~fetch_normal | redirect;
assign ifu_ilm_req_addr = req_addr[VALEN - 1:0];
assign ifu_ilm_req_valid = (req_valid & (resp_sel_ilm | no_outstanding_req)) | (req_valid & ilm_enable & redirect);
assign ifu_ilm_req_stall = ~req_hit_ilm | resume | retry & ~redirect;
assign ifu_ilm_req_tag = 1'b0;
assign ifu_ilm_kill = fetch_kill | (fetch_recover & resp_sel_ilm) | (fetch_ex9 & f0_valid) | ic_op_req_pulse;
kv_ic_op #(
    .VALEN(VALEN),
    .ICACHE_WAY(ICACHE_WAY),
    .ICACHE_SIZE_KB(ICACHE_SIZE_KB),
    .ICACHE_TAG_RAM_AW(ICACHE_TAG_RAM_AW),
    .TAG_DW(NO_ECC_TAG_DW)
) u_kv_ic_op (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .icache_disable_init(icache_disable_init),
    .ic_self_reset_on(ic_self_reset_on),
    .ifu_cctl_req(ifu_cctl_req),
    .ifu_cctl_command(ifu_cctl_command),
    .ifu_cctl_waddr(ifu_cctl_waddr),
    .ifu_cctl_wdata(ifu_cctl_wdata),
    .ifu_cctl_ack(ifu_cctl_ack),
    .ifu_cctl_status(ifu_cctl_status),
    .ifu_cctl_ecc_status(ifu_cctl_ecc_status),
    .ifu_cctl_rdata(ifu_cctl_rdata),
    .ifu_cctl_raddr(ifu_cctl_raddr),
    .resume(resume),
    .redirect(redirect),
    .fencei_req(fencei_req),
    .fencei_done(fencei_done),
    .line_op_done(icu_ifu_line_op_req_done),
    .ic_op_req_pulse(ic_op_req_pulse),
    .ic_op_valid(ic_op_valid),
    .ic_op_addr(ic_op_addr),
    .ic_op_wdata(ic_op_wdata),
    .icu_ifu_resp_status(icu_ifu_resp_status),
    .icu_ifu_resp_rdata(icu_ifu_resp_rdata),
    .f2_itlb_miss(f2_itlb_miss),
    .f2_itlb_page_fault(f2_itlb_page_fault),
    .f2_itlb_bus_error(f2_itlb_bus_error),
    .f2_itlb_ecc_xcpt(f2_itlb_ecc_xcpt),
    .f2_itlb_ecc_corr(f2_itlb_ecc_corr),
    .f2_itlb_ecc_ramid(f2_itlb_ecc_ramid),
    .f2_itlb_ecc_code(f2_itlb_ecc_code),
    .f2_pmp_fault(f2_pmp_fault),
    .f2_pma_fault(f2_pma_fault),
    .f2_ecc_replay(f2_ecc_replay),
    .f2_fetch_data_ecc_xcpt(f2_fetch_data_ecc_xcpt),
    .f2_cctl_cacheability(f2_cctl_cacheability),
    .all_mmu_req_done(all_mmu_req_done),
    .icu_ifu_line_aq_done(icu_ifu_line_aq_done),
    .icu_ifu_line_aq_error(icu_ifu_line_aq_error),
    .cache_flush_index(cache_flush_index)
);
assign ifu_fence_done = fencei_done | ~ic_en | ime;
assign ic_op_valid_pf_nx = {9{~resume}} & ic_op_valid;
assign ic_op_valid_pf_en = resume | (ic_op_valid != ic_op_valid_pf);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        ic_op_valid_pf <= {9{1'b0}};
    end
    else if (ic_op_valid_pf_en) begin
        ic_op_valid_pf <= ic_op_valid_pf_nx;
    end
end

assign ic_self_reset_done = (ICACHE_SIZE_KB == 0) | (ic_self_reset & (&ic_flush_addr)) | icache_disable_init;
assign ic_self_reset = (ICACHE_SIZE_KB != 0) & ic_self_reset_on & ~icache_disable_init;
generate
    if (ICACHE_SIZE_KB != 0) begin:gen_icache_flush_yes
        reg ic_self_reset_reg;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                ic_self_reset_reg <= 1'b1;
            end
            else if (ic_self_reset_done) begin
                ic_self_reset_reg <= 1'b0;
            end
        end

        assign ic_self_reset_on = ic_self_reset_reg;
        assign ic_flush_addr = f0_pc[INDEX_MSB:INDEX_LSB];
        assign ic_flush_addr_nx = ic_flush_addr + {{INDEX_WIDTH - 1{1'b0}},1'b1};
        assign ic_flush_addr_nx_ext = {{EXTVALEN - 4 - INDEX_WIDTH{1'b0}},4'b1111,ic_flush_addr_nx} << (OFFSET_WIDTH + 3);
    end
    else begin:gen_icache_flush_no
        wire nds_unused_icache_flush_no = (|ic_flush_addr_nx);
        assign ic_flush_addr = {ICACHE_TAG_RAM_AW{1'b0}};
        assign ic_flush_addr_nx = {ICACHE_TAG_RAM_AW{1'b0}};
        assign ic_flush_addr_nx_ext = {EXTVALEN{1'b0}};
        assign ic_self_reset_on = 1'b0;
    end
endgenerate
assign pf_req_type = ({3{(fetch_req_cs == ST_ECC_INV) & ~redirect}} & 3'd7) | ({3{ecc_inv_for_xcpt & ~redirect}} & 3'd7) | ({3{fetch_normal | redirect | (fetch_ex9 & ~ecc_inv_for_xcpt)}} & 3'd0) | ({3{prefetch_valid & ~redirect & ~ecc_inv_for_xcpt}} & 3'd1) | ({3{ic_op_valid_pf[0]}} & 3'd7) | ({3{ic_op_valid_pf[1]}} & 3'd1) | ({3{ic_op_valid_pf[2]}} & 3'd6) | ({3{ic_op_valid_pf[3]}} & 3'd7) | ({3{ic_op_valid_pf[4]}} & 3'd4) | ({3{ic_op_valid_pf[5]}} & 3'd5);
wire f1_translate_en;
assign f1_translate_en = ((MMU_SCHEME_INT != 0)) & ~resp_sel_ilm;
assign ifu_itlb_req_valid = ~f1_req_type[2] & f1_valid & ~f2_stall & f1_translate_en;
assign ifu_itlb_va = f1_va;
generate
    if (VALEN < PALEN) begin:gen_f1_pa_on_pa
        wire [PALEN - 1:0] f1_va_sext;
        kv_sign_ext #(
            .OW(PALEN),
            .IW(VALEN)
        ) u_flush_data_ext (
            .out(f1_va_sext),
            .in(f1_va)
        );
        assign f1_pa = f1_translate_en ? itlb_ifu_pa : f1_va_sext;
    end
    else begin:gen_f1_pa_on_va
        assign f1_pa = f1_translate_en ? itlb_ifu_pa : f1_va[PALEN - 1:0];
    end
endgenerate
assign f1_itlb_miss = ~(|itlb_ifu_status[2:1]) & itlb_ifu_status[0] & ifu_itlb_req_valid;
assign f1_itlb_page_fault = itlb_ifu_status[1] & ifu_itlb_req_valid;
assign f1_itlb_ecc_xcpt = itlb_ifu_status[2] & (itlb_ifu_status[3 +:3] == 3'd1) & ifu_itlb_req_valid;
assign f1_itlb_pmp_fault = itlb_ifu_status[2] & (itlb_ifu_status[3 +:3] == 3'd2) & ifu_itlb_req_valid;
assign f1_itlb_bus_error = itlb_ifu_status[2] & (itlb_ifu_status[3 +:3] == 3'd3) & ifu_itlb_req_valid;
assign f1_itlb_pma_fault = itlb_ifu_status[2] & (itlb_ifu_status[3 +:3] == 3'd4) & ifu_itlb_req_valid;
assign ifu_icu_f1_pa = f1_pa;
assign f1_pa_invalid = f1_itlb_miss | f1_itlb_bus_error | f1_itlb_page_fault | f1_itlb_pmp_fault | f1_itlb_pma_fault;
assign f1_itlb_ecc_corr = itlb_ifu_status[14];
assign f1_itlb_ecc_ramid = itlb_ifu_status[15 +:4];
assign f1_itlb_ecc_code = itlb_ifu_status[6 +:8];
assign ifu_icu_f2_cacheable = f2_cacheability & ~f2_pma_device & ~f2_pma_uncache;
assign ifu_icu_f2_cctl_pref = ifu_cctl_req;
assign f1_cacheability = ~halt_mode & ic_en & ~ime;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f1_req_type <= 3'b0;
        f1_req_start <= 1'b0;
    end
    else if (f1_valid_nx & ~f2_stall) begin
        f1_req_type <= pf_req_type;
        f1_req_start <= req_bblk_start;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f1_va <= {EXTVALEN{1'b0}};
    end
    else if (fetch_issue) begin
        f1_va <= req_addr;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f2_req_type <= 3'b0;
        f2_req_start <= 1'b0;
        f2_va <= {EXTVALEN{1'b0}};
        f2_pa <= {PALEN{1'b0}};
        f2_pa_invalid <= 1'b0;
        f2_cacheability <= 1'b0;
        f2_itlb_page_fault <= 1'b0;
        f2_itlb_pmp_fault <= 1'b0;
        f2_itlb_pma_fault <= 1'b0;
        f2_itlb_bus_error <= 1'b0;
        f2_itlb_ecc_xcpt <= 1'b0;
        f2_itlb_ecc_corr <= 1'b0;
        f2_itlb_ecc_ramid <= 3'b0;
        f2_itlb_ecc_code <= 8'b0;
        f2_abort <= 1'b0;
    end
    else if (f2_valid_nx & ~f2_stall) begin
        f2_req_type <= f1_req_type;
        f2_req_start <= f1_req_start;
        f2_va <= f1_va;
        f2_pa <= f1_pa;
        f2_pa_invalid <= f1_pa_invalid;
        f2_cacheability <= f1_cacheability;
        f2_itlb_page_fault <= f1_itlb_page_fault;
        f2_itlb_pmp_fault <= f1_itlb_pmp_fault;
        f2_itlb_pma_fault <= f1_itlb_pma_fault;
        f2_itlb_bus_error <= f1_itlb_bus_error;
        f2_itlb_ecc_xcpt <= f1_itlb_ecc_xcpt;
        f2_itlb_ecc_corr <= f1_itlb_ecc_corr;
        f2_itlb_ecc_ramid <= f1_itlb_ecc_ramid[2:0];
        f2_itlb_ecc_code <= f1_itlb_ecc_code;
        f2_abort <= f2_abort_nx;
    end
end

assign f2_abort_nx = fetch_nxt_seq_kill_needed_f2 | f1_abort;
assign f2_pma_device = ~f2_pma_mtype[3] & ~f2_pma_mtype[2] & ~f2_pma_mtype[1];
assign f2_pma_uncache = ~f2_pma_mtype[3] & ~f2_pma_mtype[2] & f2_pma_mtype[1];
assign f2_pma_alloc = f2_pma_mtype[0];
assign f2_way_lock = icu_ifu_resp_status[27 +:4] & icu_ifu_resp_status[23 +:4];
assign f2_all_way_lock = ((ICACHE_WAY == 4) & (&f2_way_lock)) | ((ICACHE_WAY == 2) & (&f2_way_lock[1:0])) | ((ICACHE_WAY == 1) & f2_way_lock[0]);
assign f2_pa_cacheability = f2_cacheability & ~f2_pma_device & ~f2_pma_uncache & f2_pma_alloc & ~f2_all_way_lock;
assign f2_cctl_cacheability = ~f2_cctl_hit_ilm & ~f2_pma_device & ~f2_pma_uncache & ~f2_all_way_lock;
assign f2_cctl_hit_ilm = ifu_cctl_waddr[VALEN - 1:ILM_AMSB + 1] == ILM_BASE[VALEN - 1:ILM_AMSB + 1];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f2_itlb_miss <= 1'b0;
    end
    else begin
        f2_itlb_miss <= f2_valid_nx & ~f1_abort & ~fetch_nxt_seq_kill_needed_f2 & f1_itlb_miss & ~f1_req_type[2];
    end
end

wire f1_valid_for_fetch_normal_nx;
wire f1_valid_for_redirect_nx;
wire f1_valid_for_ex9_fetch_nx;
wire f1_kill;
wire f2_kill;
assign f1_kill = resume | retry | f2_cache_miss | f2_xcpt | f2_fetch_data_ecc_error | f2_itlb_miss | fetch_recover | ic_op_req_pulse | cache_flush_valid | f2_no_ack;
assign f2_kill = fetch_kill | ic_op_req_pulse | f2_cache_miss | f2_xcpt | f2_fetch_data_ecc_error | f2_itlb_miss | fetch_recover | f2_no_ack;
assign f1_valid_for_fetch_normal_nx = fetch_issue & ~f1_kill & ~ex9_lookup_valid;
assign f1_valid_for_redirect_nx = (redirect & ~resume & ~ipipe_ifu_stall & ~redirect_for_cti & req_ready) | (redirect & ~resume & ~ipipe_ifu_stall & redirect_for_cti & bpu_rd_ready & req_ready);
assign f1_valid_for_ex9_fetch_nx = fetch_issue & fetch_ex9 & ~fetch_kill;
assign f1_valid_nx = f1_valid_for_fetch_normal_nx | f1_valid_for_redirect_nx | f1_valid_for_ex9_fetch_nx;
assign f2_valid_nx = f1_valid & ~f2_kill & ~ex9_lookup_valid;
assign f1_abort_set = f1_valid & fetch_nxt_seq_kill_needed_f2;
assign f1_abort_clr = ~f2_stall;
assign f1_abort_nx = (f1_valid | f1_abort_set) & ~f1_abort_clr;
assign f1_abort_en = f1_abort_set | f1_abort_clr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f1_abort <= 1'b0;
    end
    else if (f1_abort_en) begin
        f1_abort <= f1_abort_nx;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f1_valid <= 1'b0;
    end
    else if (~f2_stall | f1_kill | ex9_lookup_valid) begin
        f1_valid <= f1_valid_nx;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f2_valid <= 1'b0;
    end
    else if (~f2_stall | f2_kill | ex9_lookup_valid) begin
        f2_valid <= f2_valid_nx;
    end
end

assign ifu_pmp_req_pa = f2_pa;
assign f2_pmp_fault = (pmp_ifu_resp_fault & ~f2_req_type[2] & ~f2_pa_invalid) | f2_itlb_pmp_fault;
assign ifu_pma_req_pa = f2_pa;
assign f2_pma_fault = (pma_ifu_resp_fault & ~resp_sel_ilm & ~halt_mode & ~f2_req_type[2] & ~f2_pa_invalid) | f2_itlb_pma_fault;
assign f2_pma_mtype = halt_mode ? 4'b0000 : (ic_en | (pma_ifu_resp_mtype[3:2] == 2'b0) | ime & ic_en) ? pma_ifu_resp_mtype : 4'b0011;
assign recover_entry_update = (f2_alive & ~f2_stall & (f2_fetch_data_ecc_error | f2_cache_miss | f2_itlb_miss | f2_no_ack)) & fetch_normal | (ex9_lookup_valid & fetch_normal & ~fetch_kill);
assign recover_pc_nx = f2_alive ? f2_va : f1_valid ? f1_va : f0_valid ? f0_pc : target_pc_va_extend;
assign recover_bblk_start_nx = f2_alive ? f2_req_start : f1_valid ? f1_req_start : f0_valid ? f0_bblk_start : target_bblk_start;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        recover_pc <= {EXTVALEN{1'b0}};
        recover_bblk_start <= 1'b0;
        cache_miss_recover <= 1'b0;
        recover_vector <= 1'b0;
    end
    else if (recover_entry_update) begin
        recover_pc <= recover_pc_nx;
        recover_bblk_start <= recover_bblk_start_nx;
        cache_miss_recover <= f2_cache_miss;
        recover_vector <= vector_fetching;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        recover_cacheability <= 1'b0;
    end
    else if (recover_cacheability_update) begin
        recover_cacheability <= recover_cacheability_nx;
    end
end

assign recover_cacheability_update = (f2_alive & f2_cache_miss & fetch_normal) | (f2_alive & f2_cache_miss & fetch_ex9);
assign recover_cacheability_nx = f2_pa_cacheability;
wire tb_f2_ecc_error;
wire ecc_check_en;
assign ecc_check_en = csr_mcache_ctl_ic_eccen[1] & (ic_en | halt_mode) & ~ime;
assign tb_f2_ecc_error = 1'b0;
assign f2_cache_miss = f2_alive & fetch_icu_valid & icu_ifu_resp_status[22] & ~f2_ic_ecc_error & ~f2_itlb_miss & ~f2_req_type[2];
assign f2_ic_ecc_error = (f2_alive & fetch_icu_valid & ((|icu_ifu_resp_status[1 +:4]) | tb_f2_ecc_error) & ecc_check_en);
assign f2_ilm_ecc_error = f2_alive & ~f2_ilm_stall & fetch_ilm_valid & (|ilm_ifu_resp_status[1 +:4]) & csr_milmb_eccen[1];
assign f2_fetch_data_ecc_error = (f2_ic_ecc_error | f2_ilm_ecc_error) & f2_alive & ~f2_stall;
assign f2_ic_ecc_corr = icu_ifu_resp_status[15] | tb_f2_ecc_error;
assign f2_ilm_ecc_corr = ilm_ifu_resp_status[15];
assign f2_bblk_start = ((fetch_req_cs == ST_FILL_TLB) & recover_bblk_start) | (f2_alive & ~f2_ilm_stall & resp_sel_ilm & f2_req_start & fetch_normal) | (f2_alive & ~resp_sel_ilm & f2_req_start & fetch_normal);
assign f2_no_ack = (f2_alive & ~f2_ilm_stall & resp_sel_ilm & ~fetch_ilm_valid);
assign f2_ilm_stall = (f2_valid & resp_sel_ilm & ilm_ifu_resp_status[35]) & ~redirect;
assign f2_stall = f2_ilm_stall;
assign f2_ic_ecc_replay = ((csr_mcache_ctl_ic_eccen == 2'b10) & f2_ic_ecc_error & f2_ic_ecc_corr);
assign f2_ilm_ecc_replay = ((csr_milmb_eccen == 2'b10) & f2_ilm_ecc_error & f2_ilm_ecc_corr);
assign f2_ecc_replay = f2_ic_ecc_replay | f2_ilm_ecc_replay;
assign f2_ic_ecc_corr_xcpt = f2_ic_ecc_error & f2_ic_ecc_corr & (csr_mcache_ctl_ic_eccen == 2'b11);
assign f2_ic_ecc_uncorr_xcpt = f2_ic_ecc_error & ~f2_ic_ecc_corr;
assign f2_ic_ecc_xcpt = f2_ic_ecc_corr_xcpt | f2_ic_ecc_uncorr_xcpt;
assign f2_ilm_ecc_corr_xcpt = f2_ilm_ecc_error & f2_ilm_ecc_corr & (csr_milmb_eccen == 2'b11);
assign f2_ilm_ecc_uncorr_xcpt = f2_ilm_ecc_error & ~f2_ilm_ecc_corr;
assign f2_ilm_ecc_xcpt = f2_ilm_ecc_corr_xcpt | f2_ilm_ecc_uncorr_xcpt;
assign f2_fetch_data_ecc_xcpt = f2_ic_ecc_xcpt | f2_ilm_ecc_xcpt;
assign f2_error = f2_ic_ecc_error | f2_ilm_ecc_error | (fetch_icu_valid & (|icu_ifu_resp_status[0])) | (fetch_ilm_valid & (|ilm_ifu_resp_status[0])) | f2_itlb_bus_error | f2_itlb_page_fault | f2_itlb_ecc_xcpt | f2_pmp_fault | f2_pma_fault;
assign f2_xcpt = f2_fetch_data_ecc_xcpt | (f2_alive & fetch_icu_valid & (|icu_ifu_resp_status[0])) | (f2_alive & ~f2_ilm_stall & fetch_ilm_valid & (|ilm_ifu_resp_status[0])) | (f2_alive & f2_pmp_fault) | (f2_alive & f2_pma_fault) | (f2_alive & f2_itlb_page_fault) | (f2_alive & f2_itlb_ecc_xcpt) | (f2_alive & f2_itlb_bus_error);
assign this_mmu_req_is_done = mmu_ifu_resp_valid & ~itlb_fill_wait_valid;
always @* begin
    case (fetch_req_cs)
        ST_FETCH: fetch_req_ns = resume ? ST_FETCH : redirect ? ST_FETCH : ic_op_req_pulse ? ST_XCPT_STALL : retry ? ST_FETCH : ex9_lookup_valid ? ST_EX9_FETCH : ((f2_alive) & f2_itlb_miss) ? ST_FILL_TLB : ((f2_alive) & f2_xcpt) ? ST_XCPT_STALL : ((f2_valid) & f2_ilm_stall) ? ST_FETCH : ((f2_alive) & f2_ilm_ecc_replay) ? ST_RECOVER : ((f2_alive) & f2_no_ack) ? ST_RECOVER : ((f2_alive) & f2_ic_ecc_replay) ? ST_ECC_INV : ((f2_alive) & f2_cache_miss) ? ST_MH : ST_FETCH;
        ST_XCPT_STALL: fetch_req_ns = resume ? ST_FETCH : redirect ? ST_FETCH : ic_op_req_pulse ? ST_XCPT_STALL : retry & ~fencei_req & ~ifu_cctl_req ? ST_FETCH : ex9_lookup_valid ? ST_EX9_FETCH : (cache_miss_recover & icu_ifu_line_aq_done) ? ST_RECOVER : ST_XCPT_STALL;
        ST_FILL_TLB: fetch_req_ns = resume ? ST_FETCH : redirect ? ST_FETCH : ic_op_req_pulse ? ST_XCPT_STALL : retry ? ST_FETCH : ex9_lookup_valid ? ST_EX9_FETCH : (this_mmu_req_is_done & ~(|mmu_ifu_status)) ? ST_RECOVER : ST_FILL_TLB;
        ST_ECC_INV: fetch_req_ns = resume ? ST_FETCH : redirect ? ST_FETCH : ic_op_req_pulse ? ST_XCPT_STALL : retry ? ST_FETCH : ex9_lookup_valid ? ST_EX9_FETCH : ST_RECOVER;
        ST_MH: fetch_req_ns = resume ? ST_FETCH : redirect ? ST_FETCH : ic_op_req_pulse ? ST_XCPT_STALL : retry ? ST_FETCH : ex9_lookup_valid ? ST_EX9_FETCH : (icu_ifu_line_aq_done) ? ST_RECOVER : (icu_ifu_bus_req_full & ifu_icu_line_aq) ? ST_XCPT_STALL : ST_MH;
        ST_EX9_FETCH: fetch_req_ns = resume ? ST_FETCH : redirect ? ST_FETCH : ic_op_req_pulse ? ST_XCPT_STALL : retry ? ST_FETCH : ex9_lookup_resp_done & fetch_ex9_last_is_xcpt ? ST_XCPT_STALL : ex9_lookup_resp_done ? ST_RECOVER : ST_EX9_FETCH;
        ST_RECOVER: fetch_req_ns = resume ? ST_FETCH : redirect ? ST_FETCH : ic_op_req_pulse ? ST_XCPT_STALL : retry ? ST_FETCH : ex9_lookup_valid ? ST_EX9_FETCH : ST_FETCH;
        default: fetch_req_ns = 3'b0;
    endcase
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        fetch_req_cs <= 3'b0;
    end
    else begin
        fetch_req_cs <= fetch_req_ns;
    end
end

assign itlb_fill_valid_set = (f2_alive & f2_itlb_miss & (~itlb_fill_valid | mmu_ifu_resp_valid) & ~fetch_kill & ~ic_op_req_pulse & ~ifu_cctl_req) | ((~itlb_fill_valid | mmu_ifu_resp_valid) & ~fetch_kill & ic_op_valid[7]) | (itlb_fill_wait_valid & mmu_ifu_resp_valid & ~fetch_kill & ~ic_op_req_pulse);
assign itlb_fill_valid_clr = mmu_ifu_resp_valid;
assign itlb_fill_valid_nx = (itlb_fill_valid & ~itlb_fill_valid_clr) | itlb_fill_valid_set;
assign itlb_fill_wait_valid_set = (f2_alive & f2_itlb_miss & (itlb_fill_valid & ~mmu_ifu_resp_valid) & ~fetch_kill & ~ic_op_req_pulse & ~ifu_cctl_req) | ((itlb_fill_valid & ~mmu_ifu_resp_valid) & ~fetch_kill & ic_op_valid[7]);
assign itlb_fill_wait_valid_clr = itlb_fill_valid & mmu_ifu_resp_valid & itlb_fill_wait_valid | fetch_kill | ic_op_req_pulse;
assign itlb_fill_wait_valid_nx = (itlb_fill_wait_valid & ~itlb_fill_wait_valid_clr) | itlb_fill_wait_valid_set;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        itlb_fill_valid <= 1'b0;
        itlb_fill_wait_valid <= 1'b0;
    end
    else begin
        itlb_fill_valid <= itlb_fill_valid_nx;
        itlb_fill_wait_valid <= itlb_fill_wait_valid_nx;
    end
end

assign all_mmu_req_done = ~itlb_fill_valid & ~itlb_fill_wait_valid;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        itlb_fill_va <= {VALEN{1'b0}};
    end
    else if (itlb_fill_valid_set) begin
        itlb_fill_va <= itlb_fill_va_nx;
    end
end

assign itlb_fill_va_nx = itlb_fill_wait_valid & mmu_ifu_resp_valid ? itlb_fill_wait_va : f2_va[VALEN - 1:0];
kv_sign_ext #(
    .OW(EXTVALEN),
    .IW(VALEN)
) u_itlb_fill_va_sext (
    .out(itlb_fill_va_ext),
    .in(itlb_fill_va)
);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        itlb_fill_wait_va <= {VALEN{1'b0}};
    end
    else if (itlb_fill_wait_valid_set) begin
        itlb_fill_wait_va <= f2_va[VALEN - 1:0];
    end
end

assign ifu_mmu_req_valid = itlb_fill_valid;
assign ifu_mmu_va = itlb_fill_va_ext;
assign ecc_inv_for_xcpt_nx = (fetch_normal & f2_ic_ecc_corr_xcpt & ~fetch_kill & ~ic_op_req_pulse) | (fetch_ex9 & f2_ic_ecc_corr_xcpt & ~fetch_kill & ~ic_op_req_pulse) | (fetch_ex9 & f2_ic_ecc_replay & ~fetch_kill & ~ic_op_req_pulse & ~f2_xcpt);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        ecc_inv_for_xcpt <= 1'b0;
    end
    else begin
        ecc_inv_for_xcpt <= ecc_inv_for_xcpt_nx;
    end
end

reg miss_handle_wait;
wire miss_handle_wait_set;
wire miss_handle_wait_clr;
wire miss_handle_wait_nx;
wire miss_handle_wait_en;
assign miss_handle_wait_set = (f2_cache_miss & ~f2_xcpt & fetch_normal & icu_ifu_bus_req_full) | (f2_cache_miss & ~f2_xcpt & fetch_ex9 & icu_ifu_bus_req_full);
assign miss_handle_wait_clr = fetch_kill | ic_op_req_pulse | ~icu_ifu_bus_req_full | ex9_lookup_valid;
assign miss_handle_wait_nx = (miss_handle_wait | miss_handle_wait_set) & ~miss_handle_wait_clr;
assign miss_handle_wait_en = miss_handle_wait_set | miss_handle_wait_clr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        miss_handle_wait <= 1'b0;
    end
    else if (miss_handle_wait_en) begin
        miss_handle_wait <= miss_handle_wait_nx;
    end
end

assign prefetch_issueable = (f2_cache_miss & ~icu_ifu_bus_req_full & fetch_normal & ~f0_vectored) | (miss_handle_wait & ~icu_ifu_bus_req_full & ~fetch_ex9 & ~f0_vectored);
assign prefetch_valid_set = prefetch_issueable & ~fetch_kill & ~ic_op_req_pulse & ~ex9_lookup_valid & csr_mcache_ctl_iprefetch_en;
assign prefetch_valid_clr = fetch_kill | ic_op_req_pulse | icu_ifu_bus_req_full | (f2_itlb_miss & f2_valid) | (f2_error & f2_valid) | (f2_xcpt & f2_valid) | ((recover_cacheability != f2_pa_cacheability) & f2_valid) | (f2_valid & ~f2_cache_miss) | icu_ifu_line_aq_done | (prefetch_valid & f0_valid & ~fetch_normal & ~(fetch_req_cs == ST_MH)) | ex9_lookup_valid;
assign prefetch_valid_nx = (prefetch_valid & ~prefetch_valid_clr) | prefetch_valid_set;
assign prefetch_valid_en = prefetch_valid_set | prefetch_valid_clr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        prefetch_valid <= 1'b0;
    end
    else if (prefetch_valid_en) begin
        prefetch_valid <= prefetch_valid_nx;
    end
end

wire line_op_req_set;
wire line_op_req_clr;
wire line_op_req_nx;
wire line_op_req_en;
reg line_op_req;
reg [1:0] ifu_icu_line_op;
wire [1:0] ifu_icu_line_op_nx;
assign line_op_req_set = ic_op_req_pulse | (ifu_cctl_req & icu_ifu_line_aq_done) | resume & ~resume_for_replay;
assign line_op_req_clr = icu_ifu_line_op_req_done;
assign line_op_req_nx = (line_op_req & ~line_op_req_clr) | line_op_req_set;
assign line_op_req_en = line_op_req_set | line_op_req_clr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        line_op_req <= 1'b0;
    end
    else if (line_op_req_en) begin
        line_op_req <= line_op_req_nx;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        ifu_icu_line_op <= 2'b0;
    end
    else if (line_op_req_set) begin
        ifu_icu_line_op <= ifu_icu_line_op_nx;
    end
end

assign ifu_icu_line_op_req = line_op_req;
assign ifu_icu_line_op_nx = (fencei_req | resume & ~resume_for_replay) ? 2'd1 : 2'd0;
assign line_aq_set = (f2_cache_miss & ~f2_xcpt & ~icu_ifu_bus_req_full & ~fetch_kill & fetch_normal & ~ic_op_req_pulse & ~ex9_lookup_valid) | (f2_cache_miss & ~f2_xcpt & ~icu_ifu_bus_req_full & ~fetch_kill & fetch_ex9 & ~ic_op_req_pulse) | (miss_handle_wait & ~icu_ifu_bus_req_full & ~fetch_kill & ~icu_ifu_line_aq_done & ~ic_op_req_pulse & ~ex9_lookup_valid) | (ic_op_valid[6] & ~fetch_kill);
assign line_aq_clr = fetch_kill | icu_ifu_line_aq_done | ic_op_req_pulse | ex9_lookup_valid | (line_aq & icu_ifu_line_aq_error & ifu_cctl_req);
assign line_aq_nx = (line_aq & ~line_aq_clr) | line_aq_set;
assign line_aq_en = line_aq_set | line_aq_clr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        line_aq <= 1'b0;
    end
    else if (line_aq_en) begin
        line_aq <= line_aq_nx;
    end
end

assign line_aq_attri_update = (f2_cache_miss & ~f2_xcpt & fetch_normal) | (f2_cache_miss & ~f2_xcpt & fetch_ex9) | (prefetch_valid & f2_valid & ~prefetch_valid_clr & f2_cache_miss & ~f2_xcpt) | (ifu_cctl_req & f2_cache_miss & ~f2_xcpt);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        line_aq_pa <= {PALEN{1'b0}};
        line_aq_index <= {INDEX_WIDTH{1'b0}};
        line_aq_valid_way <= 4'b0;
        line_aq_lock_way <= 4'b0;
        line_aq_lru <= 3'b0;
        line_aq_pma_mtype <= 4'b0;
    end
    else if (line_aq_attri_update) begin
        line_aq_pa <= f2_pa;
        line_aq_index <= f2_va[INDEX_MSB:INDEX_LSB];
        line_aq_valid_way <= icu_ifu_resp_status[23 +:4];
        line_aq_lock_way <= icu_ifu_resp_status[27 +:4];
        line_aq_lru <= icu_ifu_resp_status[31 +:3];
        line_aq_pma_mtype <= f2_pma_mtype;
    end
end

assign ifu_icu_line_aq = line_aq & ~ifu_icu_line_op_req;
assign ifu_icu_line_aq_addr = line_aq_pa;
assign ifu_icu_line_aq_index = line_aq_index;
assign ifu_icu_line_aq_attri[0] = ifu_cctl_req ? 1'b1 : recover_cacheability;
assign ifu_icu_line_aq_attri[5] = (csr_cur_privilege != PRIVILEGE_USER);
assign ifu_icu_line_aq_attri[6 +:4] = line_aq_valid_way;
assign ifu_icu_line_aq_attri[10 +:4] = line_aq_lock_way & line_aq_valid_way;
assign ifu_icu_line_aq_attri[14 +:3] = line_aq_lru;
assign ifu_icu_line_aq_attri[1 +:4] = line_aq_pma_mtype;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f0_valid <= 1'b0;
    end
    else if (f0_valid_set) begin
        f0_valid <= 1'b1;
    end
    else if (f0_valid_clr) begin
        f0_valid <= 1'b0;
    end
end

wire cctl_ram_rw;
wire f2_ic_ecc_revise;
wire ex9_fetch_recover;
assign ex9_fetch_recover = (icu_ifu_line_aq_done & ~redirect & ~ifu_cctl_req & ~fencei_req) | (f2_valid & ~f2_ilm_stall & f2_no_ack & ~redirect) | (this_mmu_req_is_done & ifu_mmu_req_valid & ~redirect) | (ecc_inv_for_xcpt & ~redirect) | (f2_ilm_ecc_replay & ~ic_op_req_pulse & ~f2_xcpt & ~redirect);
assign cctl_ram_rw = ic_op_valid[0] | ic_op_valid[1] | ic_op_valid[2] | ic_op_valid[3] | ic_op_valid[4] | ic_op_valid[5];
assign f2_ic_ecc_revise = (f2_ic_ecc_replay & ~ic_op_req_pulse & ~f2_xcpt) | (f2_ic_ecc_corr_xcpt & ~ic_op_req_pulse);
assign f0_valid_set = (redirect & (ipipe_ifu_stall | ~req_ready | (~bpu_rd_ready & redirect_for_cti))) | resume | (retry & ~redirect & ~ifu_cctl_req & ~fencei_req) | (ex9_lookup_valid & ~redirect & ~ifu_cctl_req & ~fencei_req) | (fetch_ex9 & ex9_fetch_recover) | (fetch_normal & f2_ic_ecc_revise & ~redirect) | (fetch_ex9 & f2_ic_ecc_revise & ~redirect) | (fetch_recover & ~redirect & ~ic_op_req_pulse) | (prefetch_valid_set & ~redirect & ~ic_op_req_pulse) | (prefetch_valid & fetch_issue & ~prefetch_valid_clr & ~redirect & ~ic_op_req_pulse) | (cctl_ram_rw & ~redirect);
assign f0_valid_clr = fetch_issue | ic_op_req_pulse | (prefetch_valid & f0_valid & ~fetch_normal);
assign f0_pc_flush_init_value = {{EXTVALEN - 4{1'b0}},4'b1111} << (INDEX_WIDTH + OFFSET_WIDTH + 3);
assign f2_ecc_inv_addr = {{(EXTVALEN - 10 - INDEX_WIDTH){1'b0}},icu_ifu_resp_status[1 +:4],f2_va[INDEX_MSB:INDEX_LSB],6'b0};
kv_sign_ext #(
    .OW(EXTVALEN),
    .IW(VALEN)
) u_ic_op_sext (
    .out(ic_op_addr_ext),
    .in(ic_op_addr)
);
kv_zero_ext #(
    .OW(EXTVALEN),
    .IW(4)
) u_prefetch_dw_offset_zext (
    .out(prefetch_dw_offset),
    .in(4'b1000)
);
kv_zero_ext #(
    .OW(EXTVALEN),
    .IW(7)
) u_prefetch_line_offset_zext (
    .out(prefetch_line_offset),
    .in(7'b1000000)
);
assign f2_align_addr_base = f2_pa_cacheability ? {f2_va[EXTVALEN - 1:6],6'b0} : {f2_va[EXTVALEN - 1:3],3'b0};
assign prefetch_addr_base = prefetch_valid_set ? f2_align_addr_base : f0_pc;
assign prefetch_offset = prefetch_valid_set ? f2_pa_cacheability ? prefetch_line_offset : prefetch_dw_offset : recover_cacheability ? prefetch_line_offset : prefetch_dw_offset;
assign prefetch_addr = prefetch_addr_base + prefetch_offset;
assign cache_flush_addr_clr = cache_flush_valid & ~ic_op_valid_pf[0];
wire f2_ecc_inv = (fetch_ex9 & f2_ic_ecc_error & f2_ic_ecc_corr) | (fetch_normal & f2_ic_ecc_error & f2_ic_ecc_corr);
assign f0_pc_update = (redirect & (ipipe_ifu_stall | ~req_ready | (~bpu_rd_ready & redirect_for_cti))) | resume | (retry & ~redirect & ~ifu_cctl_req & ~fencei_req) | (ex9_lookup_valid & ~redirect & ~ifu_cctl_req & ~fencei_req) | (fetch_ex9 & ex9_fetch_recover) | (fetch_ex9 & f2_ic_ecc_revise & ~redirect) | (fetch_normal & f2_ic_ecc_revise & ~redirect) | (fetch_recover & ~redirect & ~ic_op_req_pulse) | (prefetch_issueable & ~redirect & ~ic_op_req_pulse) | (prefetch_valid & fetch_issue & ~redirect & ~ic_op_req_pulse) | (cctl_ram_rw & ~redirect);
assign f0_pc_nx = resume ? resume_pc : redirect ? redirect_pc : cache_flush_addr_clr ? f0_pc_flush_init_value : ic_op_valid_pf[0] ? ic_flush_addr_nx_ext : |ic_op_valid ? ic_op_addr_ext : retry ? retry_pc : ex9_lookup_valid ? ex9_lookup_pc : f2_ecc_inv ? f2_ecc_inv_addr : fetch_ex9 ? seq_pc : fetch_recover ? recover_pc : prefetch_addr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f0_pc <= {EXTVALEN{1'b0}};
    end
    else if (f0_pc_update) begin
        f0_pc <= f0_pc_nx;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f0_vectored <= 1'b0;
    end
    else if (fetch_kill | fetch_recover) begin
        f0_vectored <= f0_vectored_nx;
    end
end

assign f0_vectored_nx = resume ? resume_vectored : redirect ? 1'b0 : retry ? 1'b0 : recover_vector;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f0_bblk_start <= 1'b0;
    end
    else if (f0_valid_set) begin
        f0_bblk_start <= f0_bblk_start_nx;
    end
end

assign f0_bblk_start_nx = (redirect_for_cti & ~resume) | (~fetch_kill & fetch_recover & recover_bblk_start);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        resp_sel_ilm <= 1'b0;
    end
    else if (fetch_issue) begin
        resp_sel_ilm <= req_hit_ilm;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        init_ctr_cs <= INIT_RESET;
    end
    else if (!init_ctr_done) begin
        init_ctr_cs <= init_ctr_ns;
    end
end

always @* begin
    case (init_ctr_cs)
        INIT_RESET: init_ctr_ns = INIT_LM;
        INIT_LM: init_ctr_ns = lm_reset_done ? INIT_BTB : INIT_LM;
        INIT_BTB: init_ctr_ns = btb_init_done ? INIT_CACHE : INIT_BTB;
        INIT_CACHE: init_ctr_ns = (icache_disable_init | ic_self_reset_done | ~cache_support | ~ic_self_reset) ? INIT_DONE : INIT_CACHE;
        INIT_DONE: init_ctr_ns = INIT_DONE;
        default: init_ctr_ns = 3'b0;
    endcase
end

assign ifu_ipipe_init_done = init_ctr_done;
assign req_ready = (req_hit_ilm ? ilm_ifu_req_ready : icu_ifu_req_ready) & ((resp_sel_ilm == req_hit_ilm) | no_outstanding_req | redirect);
assign fetch_issue = req_valid & req_ready;
kv_pq #(
    .VALEN(VALEN),
    .EXTVALEN(EXTVALEN),
    .BTB_SIZE(BTB_SIZE)
) u_kv_pq (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .resume(resume),
    .resume_pc(resume_pc),
    .retry(retry),
    .retry_pc(retry_pc),
    .redirect(redirect),
    .redirect_pc(redirect_pc),
    .redirect_for_cti(redirect_for_cti),
    .f0_valid(f0_valid),
    .f0_pc(f0_pc),
    .f0_vectored(f0_vectored),
    .f0_bblk_start(f0_bblk_start),
    .fetch_req_valid(req_valid),
    .fetch_req_ready(req_ready),
    .fetch_resp_valid(fetch_resp_valid_no_xcpt),
    .fetch_resp_valid_raw(fetch_resp_valid_raw),
    .fetch_normal(fetch_normal),
    .fetch_recover(fetch_recover),
    .recover_entry_update(recover_entry_update),
    .bpu_rd_ack(bpu_rd_ack),
    .bpu_info_hit(bpu_info_hit),
    .bpu_info_fall_thru_pc(bpu_info_fall_thru_pc),
    .bpu_info_target(bpu_info_target),
    .bpu_info_start_pc(bpu_info_start_pc),
    .bpu_info_offset(bpu_info_offset),
    .bpu_info_way(bpu_info_way),
    .bpu_info_ucond(bpu_info_ucond),
    .bpu_info_ret(bpu_info_ret),
    .bpu_info_pred_taken(bpu_info_pred_taken),
    .bpu_info_pred_cnt(bpu_info_pred_cnt),
    .bpu_rd_ready(bpu_rd_ready),
    .bpu_rd_valid(bpu_rd_valid),
    .target_pc(target_pc),
    .target_bblk_start(target_bblk_start),
    .target_pred_taken(target_pred_taken),
    .target_rd_low_word_only(target_rd_low_word_only),
    .seq_pc(seq_pc[VALEN - 1:0]),
    .ifu_i0_pc(ifu_i0_pc),
    .ifu_i0_pred_valid(ifu_i0_pred_valid),
    .ifu_i0_pred_way(ifu_i0_pred_way),
    .ifu_i0_pred_taken(ifu_i0_pred_taken),
    .ifu_i0_pred_ret(ifu_i0_pred_ret),
    .ifu_i0_pred_cnt(ifu_i0_pred_cnt),
    .ifu_i0_pred_brk(ifu_i0_pred_brk),
    .ifu_i0_pred_npc(ifu_i0_pred_npc_no_tb),
    .ifu_i0_keep_bhr(ifu_i0_keep_bhr),
    .ifu_i0_pred_hit(ifu_i0_pred_hit_no_tb),
    .ifu_i0_bblk_start(i0_bblk_start),
    .ifu_i0_32b(i0_32b),
    .ifu_i0_issue(inst0_issue),
    .ifu_i1_pc(ifu_i1_pc),
    .ifu_i1_pred_valid(ifu_i1_pred_valid),
    .ifu_i1_pred_way(ifu_i1_pred_way),
    .ifu_i1_pred_taken(ifu_i1_pred_taken),
    .ifu_i1_pred_ret(ifu_i1_pred_ret),
    .ifu_i1_pred_cnt(ifu_i1_pred_cnt),
    .ifu_i1_pred_brk(ifu_i1_pred_brk),
    .ifu_i1_pred_npc(ifu_i1_pred_npc_no_tb),
    .ifu_i1_keep_bhr(ifu_i1_keep_bhr),
    .ifu_i1_pred_hit(ifu_i1_pred_hit_no_tb),
    .ifu_i1_bblk_start(i1_bblk_start),
    .ifu_i1_32b(i1_32b),
    .ifu_i1_issue(inst1_issue),
    .no_addr_valid_stall(no_addr_valid_stall),
    .fetch_nxt_seq_kill_needed_f2(fetch_nxt_seq_kill_needed_f2),
    .fetch_end_offset(fetch_end_offset),
    .resp_raw_is_bblk_end_f2(resp_raw_is_bblk_end_f2)
);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        seq_pc <= {EXTVALEN{1'b0}};
    end
    else if (seq_pc_update) begin
        seq_pc <= seq_pc_nx;
    end
end

assign seq_pc_update = (fetch_issue & (fetch_req_cs == ST_FETCH)) | (fetch_issue & redirect) | (ex9_lookup_valid & ex9_lookup_ready);
assign seq_pc_nx = (ex9_lookup_valid & ex9_lookup_ready & ~redirect) ? ex9_lookup_pc[EXTVALEN - 1:0] : {req_addr[EXTVALEN - 1:3],3'b0} + {{(EXTVALEN - 4){1'b0}},4'b1000};
assign fq_wr = (f2_no_ack & f2_pmp_fault & fetch_normal & ~ex9_lookup_valid) | (f2_stall & f2_pmp_fault & fetch_normal & ~ex9_lookup_valid) | (|(fetch_resp_valid));
assign fq_ncnt_nx = fetch_kill ? {FQ_NCNT_MSB + 1{1'b0}} : fq_ncnt + {{FQ_NCNT_MSB{1'b0}},fq_wr} - {{FQ_NCNT_MSB{1'b0}},fq_rd};
assign fq_ncnt_update = fetch_kill | fq_wr | fq_rd;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        fq_ncnt <= {FQ_NCNT_MSB + 1{1'b0}};
    end
    else if (fq_ncnt_update) begin
        fq_ncnt <= fq_ncnt_nx;
    end
end

assign fetch_fault = f2_error;
assign fetch_page_fault = f2_itlb_page_fault;
assign fetch_pmp_fault = f2_pmp_fault;
assign fetch_pma_fault = f2_pma_fault;
assign fetch_ecc_corr = (fetch_ilm_valid & f2_ilm_ecc_corr & ~f2_itlb_ecc_xcpt) | (fetch_icu_valid & f2_ic_ecc_corr & ~f2_itlb_ecc_xcpt) | (f2_itlb_ecc_xcpt & f2_itlb_ecc_corr);
assign fetch_ecc_xcpt = f2_fetch_data_ecc_xcpt | f2_itlb_ecc_xcpt;
assign fetch_ecc_code = ({8{fetch_ilm_valid & ~f2_itlb_ecc_xcpt}} & ilm_ifu_resp_status[7 +:8]) | ({8{fetch_icu_valid & ~f2_itlb_ecc_xcpt}} & icu_ifu_resp_status[7 +:8]) | ({8{fetch_icu_valid & f2_itlb_ecc_xcpt}} & f2_itlb_ecc_code);
assign fetch_ecc_ramid = ({3{fetch_ilm_valid & ~f2_itlb_ecc_xcpt}} & {1'b0,ilm_ifu_resp_status[5 +:2]}) | ({3{fetch_icu_valid & ~f2_itlb_ecc_xcpt}} & {1'b0,icu_ifu_resp_status[5 +:2]}) | ({3{fetch_icu_valid & f2_itlb_ecc_xcpt}} & f2_itlb_ecc_ramid);
assign fq_fault_nx = fetch_fault & ~fetch_kill;
assign fq_page_fault_nx = fetch_page_fault & ~fetch_kill;
assign fq_pmp_fault_nx = fetch_pmp_fault & ~fetch_kill;
assign fq_pma_fault_nx = fetch_pma_fault & ~fetch_kill;
assign fq_ecc_corr_nx = fetch_ecc_corr & ~fetch_kill;
assign fq_ecc_xcpt_nx = fetch_ecc_xcpt & ~fetch_kill;
assign fq_ecc_code_nx = fetch_ecc_code & {8{~fetch_kill}};
assign fq_ecc_ramid_nx = fetch_ecc_ramid & {3{~fetch_kill}};
wire fq_xcpt_info_update;
assign fq_xcpt_info_update = fetch_kill | (resp_valid & fetch_normal) | (f2_no_ack & f2_pmp_fault & fetch_normal) | (f2_stall & f2_pmp_fault & fetch_normal);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        fq_fault <= 1'b0;
        fq_page_fault <= 1'b0;
        fq_pmp_fault <= 1'b0;
        fq_pma_fault <= 1'b0;
        fq_ecc_corr <= 1'b0;
        fq_ecc_xcpt <= 1'b0;
        fq_ecc_code <= 8'b0;
        fq_ecc_ramid <= 3'b0;
    end
    else if (fq_xcpt_info_update) begin
        fq_fault <= fq_fault_nx;
        fq_page_fault <= fq_page_fault_nx;
        fq_pmp_fault <= fq_pmp_fault_nx;
        fq_pma_fault <= fq_pma_fault_nx;
        fq_ecc_corr <= fq_ecc_corr_nx;
        fq_ecc_xcpt <= fq_ecc_xcpt_nx;
        fq_ecc_code <= fq_ecc_code_nx;
        fq_ecc_ramid <= fq_ecc_ramid_nx;
    end
end

wire [63:0] ilm_resp_rdata_mask_xcpt;
wire [63:0] icu_resp_rdata_mask_xcpt;
assign ilm_resp_rdata_mask_xcpt = ilm_ifu_resp_rdata & {{16{~fq_wr_xcpt[3]}},{16{~fq_wr_xcpt[2]}},{16{~fq_wr_xcpt[1]}},{16{~fq_wr_xcpt[0]}}};
assign icu_resp_rdata_mask_xcpt = icu_ifu_resp_rdata & {64{~f2_xcpt}};
assign fetch_resp_inst[63:0] = ({64{(|ilm_ifu_resp_valid)}} & ilm_resp_rdata_mask_xcpt) | ({64{(|icu_ifu_resp_valid)}} & icu_resp_rdata_mask_xcpt);
assign fetch_bblk_start = f2_bblk_start;
assign fetch_bblk_end = resp_raw_is_bblk_end_f2;
assign fetch_valid = ({4{fetch_end_offset[0]}} & {3'b0,fetch_resp_valid[0]}) | ({4{fetch_end_offset[1]}} & {2'b0,fetch_resp_valid[1:0]}) | ({4{fetch_end_offset[2]}} & {1'b0,fetch_resp_valid[2:0]}) | ({4{fetch_end_offset[3]}} & {fetch_resp_valid[3:0]});
assign fetch_resp_valid = ((ilm_ifu_resp_valid_with_mask & {4{~f2_ilm_stall}}) | icu_ifu_resp_valid) & {4{f2_alive & fetch_normal & ~ex9_lookup_valid & ((~(fetch_icu_valid & icu_ifu_resp_status[22]) & ~f2_itlb_miss & ~f2_ecc_replay) | (f2_xcpt & ~f2_itlb_miss))}};
assign fetch_resp_valid_no_xcpt = ((ilm_ifu_resp_valid_with_mask & {4{~f2_ilm_stall}}) | icu_ifu_resp_valid) & {4{f2_alive & fetch_normal & ~ex9_lookup_valid & (~(fetch_icu_valid & icu_ifu_resp_status[22]) & ~f2_itlb_miss & ~f2_ecc_replay)}};
assign fetch_resp_valid_raw = ((ilm_ifu_resp_valid_with_mask & {4{~f2_ilm_stall}}) | icu_ifu_resp_valid) & {4{f2_alive & fetch_normal & ~ex9_lookup_valid}};
assign fetch_ex9_resp_valid = ((ilm_ifu_resp_valid_with_mask & {4{~f2_ilm_stall}}) | icu_ifu_resp_valid) & {4{f2_alive & fetch_ex9 & ((~(fetch_icu_valid & icu_ifu_resp_status[22]) & ~f2_itlb_miss & ~f2_ecc_replay) | (f2_xcpt & ~f2_itlb_miss))}};
assign ost_max_num = {{(FQ_NCNT_MSB - 1){1'b0}},num_outstanding_req} + fq_ncnt;
assign fq_full_stall = (ost_max_num == FQ_DEPTH_LOGIC) & ~redirect;
wire [1:0] f2_ilm_ecc_pos_ori;
wire [3:0] f2_ilm_ecc_pos;
wire [3:0] f2_ilm_ecc_pos_align;
assign f2_ilm_ecc_pos_ori = ilm_ifu_resp_status[16 +:2];
assign f2_ilm_ecc_pos = {{2{f2_ilm_ecc_pos_ori[1]}},{2{f2_ilm_ecc_pos_ori[0]}}};
assign f2_ilm_ecc_pos_align = (f2_va[2:1] == 2'b00) ? f2_ilm_ecc_pos : (f2_va[2:1] == 2'b01) ? {1'b0,f2_ilm_ecc_pos[3:1]} : (f2_va[2:1] == 2'b10) ? {2'b0,f2_ilm_ecc_pos[3:2]} : {3'b0,f2_ilm_ecc_pos[3]};
assign inst0_issue = ifu_i0_valid & ifu_i0_ready;
assign inst1_issue = ifu_i1_valid & ifu_i1_ready;
assign fq_wr_xcpt = f2_fetch_data_ecc_xcpt & resp_sel_ilm ? f2_ilm_ecc_pos_align : {4{(f2_alive & f2_xcpt & (f2_req_type == 3'b0))}};
kv_fq #(
    .FQ_DEPTH(FQ_DEPTH)
) u_kv_fq (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .fetch_kill(fetch_kill),
    .fq_wr(fq_wr),
    .fq_rd(fq_rd),
    .fq_wr_valid(fetch_valid),
    .fq_wr_xcpt(fq_wr_xcpt),
    .fq_wr_inst(fetch_resp_inst),
    .fq_wr_bblk_start(fetch_bblk_start),
    .fq_wr_bblk_end(fetch_bblk_end),
    .fq_i0_valid(fq_i0_valid),
    .fq_i0_inst(fq_i0_inst),
    .fq_i0_bblk_start(fq_i0_bblk_start),
    .fq_i0_bblk_end(fq_i0_bblk_end),
    .fq_i0_xcpt(fq_i0_xcpt),
    .fq_i0_xcpt_upper(fq_i0_xcpt_upper),
    .fq_i0_bogus(fq_i0_bogus),
    .fq_i0_ready(ifu_i0_ready),
    .fq_i1_valid(fq_i1_valid),
    .fq_i1_inst(fq_i1_inst),
    .fq_i1_bblk_start(fq_i1_bblk_start),
    .fq_i1_bblk_end(fq_i1_bblk_end),
    .fq_i1_xcpt(fq_i1_xcpt),
    .fq_i1_xcpt_upper(fq_i1_xcpt_upper),
    .fq_i1_bogus(fq_i1_bogus),
    .fq_i1_ready(ifu_i1_ready)
);
assign i0_bblk_start = ifu_i0_pred_start;
assign i1_bblk_start = ifu_i1_pred_start;
assign i0_32b = (ifu_i0_instr[1:0] == 2'b11) | ~rvc_en;
assign i1_32b = (ifu_i1_instr[1:0] == 2'b11) | ~rvc_en;
wire tb_i0_vector_resume;
assign tb_i0_vector_resume = 1'b0;
assign ifu_i0_valid = fq_i0_valid;
assign ifu_i0_instr = (tb_i0_vector_resume) ? ifu_i0_pc[31:0] : fq_i0_inst;
assign ifu_i0_vector_resume = vector_resume | tb_i0_vector_resume;
assign ifu_i0_fault = fq_i0_xcpt & fq_fault;
assign ifu_i0_fault_dcause = fq_ecc_xcpt ? 3'd1 : fq_pmp_fault ? 3'd2 : fq_pma_fault ? 3'd4 : 3'd3;
assign ifu_i0_page_fault = fq_i0_xcpt & fq_page_fault;
assign ifu_i0_fault_upper = fq_i0_xcpt_upper;
assign ifu_i0_ecc_corr = fq_ecc_corr;
assign ifu_i0_ecc_code = fq_ecc_code;
assign ifu_i0_ecc_ramid = fq_ecc_ramid;
assign ifu_i0_instr_16b = ~i0_32b;
wire tb_i0_pred_npc_drive;
assign tb_i0_pred_npc_drive = 1'b0;
assign ifu_i0_pred_npc = (tb_i0_pred_npc_drive) ? {VALEN{1'b0}} : ifu_i0_pred_npc_no_tb;
wire tb_ifu_i0_pred_hit;
assign tb_ifu_i0_pred_hit = 1'b0;
assign ifu_i0_pred_hit_no_tb = fq_i0_bblk_end;
assign ifu_i0_pred_bogus = fq_i0_bogus;
assign ifu_i0_pred_hit = ifu_i0_pred_hit_no_tb | tb_ifu_i0_pred_hit;
assign ifu_i0_pred_start = fq_i0_bblk_start;
assign ifu_i1_valid = fq_i1_valid;
assign ifu_i1_instr = fq_i1_inst;
assign ifu_i1_vector_resume = 1'b0;
assign ifu_i1_fault = fq_i1_xcpt & fq_fault;
assign ifu_i1_fault_dcause = fq_ecc_xcpt ? 3'd1 : fq_pmp_fault ? 3'd2 : fq_pma_fault ? 3'd4 : 3'd3;
assign ifu_i1_page_fault = fq_i1_xcpt & fq_page_fault;
assign ifu_i1_fault_upper = fq_i1_xcpt_upper;
assign ifu_i1_ecc_corr = fq_ecc_corr;
assign ifu_i1_ecc_code = fq_ecc_code;
assign ifu_i1_ecc_ramid = fq_ecc_ramid;
assign ifu_i1_instr_16b = ~i1_32b;
wire tb_i1_pred_npc_drive;
assign tb_i1_pred_npc_drive = 1'b0;
assign ifu_i1_pred_npc = (tb_i1_pred_npc_drive) ? {VALEN{1'b0}} : ifu_i1_pred_npc_no_tb;
wire tb_ifu_i1_pred_hit;
assign tb_ifu_i1_pred_hit = 1'b0;
assign ifu_i1_pred_hit_no_tb = fq_i1_bblk_end;
assign ifu_i1_pred_bogus = fq_i1_bogus;
assign ifu_i1_pred_hit = ifu_i1_pred_hit_no_tb | tb_ifu_i1_pred_hit;
assign ifu_i1_pred_start = fq_i1_bblk_start;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        num_outstanding_req <= 2'd0;
    end
    else if (num_outstanding_req_en) begin
        num_outstanding_req <= num_outstanding_req_nx;
    end
end

assign num_outstanding_req_en = fetch_kill | ic_op_req_pulse | ex9_lookup_valid | (fetch_issue & fetch_normal) | (resp_valid & fetch_normal) | fetch_nxt_seq_kill_needed_f2 | fetch_recover;
assign num_outstanding_req_nx = resume ? 2'd0 : redirect ? {1'b0,fetch_issue} : ic_op_req_pulse ? 2'b0 : retry ? 2'b0 : ex9_lookup_valid ? 2'b0 : fetch_recover ? 2'd0 : num_outstanding_req + {1'b0,fetch_issue & fetch_normal} - {1'b0,resp_valid & fetch_normal} - {1'b0,fetch_nxt_seq_kill_needed_f2 & f1_valid & fetch_normal};
assign resp_valid = resp_sel_ilm ? (|ilm_ifu_resp_valid_with_mask) & f2_alive & ~f2_ilm_stall : (|icu_ifu_resp_valid) & f2_alive;
wire no_valid_in_pipe;
assign no_valid_in_pipe = ~f1_valid & ~f2_valid;
assign ifu_ipipe_standby_ready = (fq_full_stall & icu_standby_ready & fetch_normal & ~itlb_fill_valid & ~itlb_fill_wait_valid & no_valid_in_pipe) | ((fetch_req_cs == ST_XCPT_STALL) & icu_standby_ready & ~itlb_fill_valid & ~itlb_fill_wait_valid & ~f0_valid);
wire event_fetch_cache_access_nx;
wire event_fetch_cache_miss_nx;
wire event_uncacheable_access_nx;
wire event_cacheable_miss_wait_cycle_set;
wire event_cacheable_miss_wait_cycle_clr;
wire event_cacheable_miss_wait_cycle_nx;
wire event_cacheable_miss_wait_cycle_en;
wire event_uncacheable_miss_wait_cycle_set;
wire event_uncacheable_miss_wait_cycle_clr;
wire event_uncacheable_miss_wait_cycle_nx;
wire event_uncacheable_miss_wait_cycle_en;
wire event_itlb_fill_wait_cycle_set;
wire event_itlb_fill_wait_cycle_clr;
wire event_itlb_fill_wait_cycle_nx;
wire event_itlb_fill_wait_cycle_en;
reg event_fetch_cache_access;
reg event_fetch_cache_miss;
reg event_cacheable_miss_wait_cycle;
reg event_uncacheable_miss_wait_cycle;
reg event_uncacheable_access;
reg event_itlb_fill_wait_cycle;
wire [5:0] ifu_event;
assign event_cacheable_miss_wait_cycle_set = (f2_cache_miss & ~f2_xcpt & fetch_normal) & f2_pa_cacheability & ~fetch_kill & ~ic_op_req_pulse & ~ex9_lookup_valid;
assign event_cacheable_miss_wait_cycle_clr = (f2_valid & fetch_normal) | fetch_kill | ic_op_req_pulse | ex9_lookup_valid;
assign event_cacheable_miss_wait_cycle_nx = (event_cacheable_miss_wait_cycle & ~event_cacheable_miss_wait_cycle_clr) | event_cacheable_miss_wait_cycle_set;
assign event_cacheable_miss_wait_cycle_en = event_cacheable_miss_wait_cycle_set | event_cacheable_miss_wait_cycle_clr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        event_cacheable_miss_wait_cycle <= 1'b0;
    end
    else if (event_cacheable_miss_wait_cycle_en) begin
        event_cacheable_miss_wait_cycle <= event_cacheable_miss_wait_cycle_nx;
    end
end

assign event_uncacheable_miss_wait_cycle_set = (f2_cache_miss & ~f2_xcpt & fetch_normal) & ~f2_pa_cacheability & ~fetch_kill & ~ic_op_req_pulse & ~ex9_lookup_valid;
assign event_uncacheable_miss_wait_cycle_clr = (f2_valid & fetch_normal) | fetch_kill | ic_op_req_pulse | ex9_lookup_valid;
assign event_uncacheable_miss_wait_cycle_nx = (event_uncacheable_miss_wait_cycle & ~event_uncacheable_miss_wait_cycle_clr) | event_uncacheable_miss_wait_cycle_set;
assign event_uncacheable_miss_wait_cycle_en = event_uncacheable_miss_wait_cycle_set | event_uncacheable_miss_wait_cycle_clr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        event_uncacheable_miss_wait_cycle <= 1'b0;
    end
    else if (event_uncacheable_miss_wait_cycle_en) begin
        event_uncacheable_miss_wait_cycle <= event_uncacheable_miss_wait_cycle_nx;
    end
end

assign event_itlb_fill_wait_cycle_set = f2_alive & f2_itlb_miss & ~fetch_kill & ~ic_op_req_pulse & ~ex9_lookup_valid;
assign event_itlb_fill_wait_cycle_clr = (f2_valid & fetch_normal) | fetch_kill | ic_op_req_pulse | ex9_lookup_valid;
assign event_itlb_fill_wait_cycle_nx = (event_itlb_fill_wait_cycle & ~event_itlb_fill_wait_cycle_clr) | event_itlb_fill_wait_cycle_set;
assign event_itlb_fill_wait_cycle_en = event_itlb_fill_wait_cycle_set | event_itlb_fill_wait_cycle_clr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        event_itlb_fill_wait_cycle <= 1'b0;
    end
    else if (event_itlb_fill_wait_cycle_en) begin
        event_itlb_fill_wait_cycle <= event_itlb_fill_wait_cycle_nx;
    end
end

assign event_fetch_cache_access_nx = fetch_normal & (|icu_ifu_resp_valid) & f2_alive & f2_pa_cacheability & ~event_cacheable_miss_wait_cycle;
assign event_fetch_cache_miss_nx = icu_ifu_bus_req_event;
assign event_uncacheable_access_nx = fetch_normal & (|icu_ifu_resp_valid) & f2_alive & ~f2_pa_cacheability & ~event_uncacheable_miss_wait_cycle;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        event_fetch_cache_access <= 1'b0;
        event_fetch_cache_miss <= 1'b0;
        event_uncacheable_access <= 1'b0;
    end
    else begin
        event_fetch_cache_access <= event_fetch_cache_access_nx;
        event_fetch_cache_miss <= event_fetch_cache_miss_nx;
        event_uncacheable_access <= event_uncacheable_access_nx;
    end
end

assign ifu_event[0] = event_fetch_cache_access;
assign ifu_event[1] = event_fetch_cache_miss;
assign ifu_event[4] = event_uncacheable_access;
assign ifu_event[2] = event_cacheable_miss_wait_cycle;
assign ifu_event[3] = event_uncacheable_miss_wait_cycle;
assign ifu_event[5] = event_itlb_fill_wait_cycle;
endmodule


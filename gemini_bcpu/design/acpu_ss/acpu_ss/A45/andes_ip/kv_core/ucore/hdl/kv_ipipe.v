// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_ipipe (
    core_clk,
    core_reset_n,
    hart_halted,
    biu_ipipe_standby_ready,
    ifu_ipipe_standby_ready,
    mmu_ipipe_standby_ready,
    fpu_ipipe_standby_ready,
    fpu_ipipe_fdiv_standby_ready,
    core_wfi_mode,
    wfi_enabled,
    csr_vstart,
    csr_vtype,
    csr_vl,
    ls_privilege_m,
    ls_privilege_s,
    ls_privilege_u,
    ipipe_ifu_stall,
    ifu_ipipe_init_done,
    ifu_i0_valid,
    ifu_i0_pc,
    ifu_i0_instr,
    ifu_i0_vector_resume,
    ifu_i0_instr_16b,
    ifu_i0_pred_valid,
    ifu_i0_pred_hit,
    ifu_i0_pred_way,
    ifu_i0_pred_taken,
    ifu_i0_pred_ret,
    ifu_i0_pred_bogus,
    ifu_i0_pred_cnt,
    ifu_i0_pred_start,
    ifu_i0_pred_brk,
    ifu_i0_keep_bhr,
    ifu_i0_pred_npc,
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
    ifu_i1_pred_valid,
    ifu_i1_pred_hit,
    ifu_i1_pred_way,
    ifu_i1_pred_taken,
    ifu_i1_pred_ret,
    ifu_i1_pred_bogus,
    ifu_i1_pred_cnt,
    ifu_i1_keep_bhr,
    ifu_i1_pred_npc,
    ifu_i1_pred_start,
    ifu_i1_pred_brk,
    ifu_i1_fault,
    ifu_i1_fault_dcause,
    ifu_i1_page_fault,
    ifu_i1_fault_upper,
    ifu_i1_ecc_corr,
    ifu_i1_ecc_code,
    ifu_i1_ecc_ramid,
    ifu_i1_ready,
    fpu_i0_ctrl,
    fpu_i0_valid,
    fpu_i0_frs1,
    fpu_i0_frs2,
    fpu_i0_frs3,
    fpu_i1_ctrl,
    fpu_i1_valid,
    fpu_i1_frs1,
    fpu_i1_frs2,
    fpu_i1_frs3,
    fpu_lx_stall,
    fpu_fmis_result,
    fmis_flag_set,
    fpu_fmv_result,
    fpu_fmac32_result,
    fpu_fmac64_result,
    fmac_flag_set,
    redirect,
    redirect_for_cti,
    redirect_pc,
    redirect_pc_hit_ilm,
    redirect_ras_ptr,
    retry,
    retry_pc,
    btb_flush_ready,
    btb_flush_valid,
    btb_update_p0,
    btb_update_p0_way,
    btb_update_p0_blk_offset,
    btb_update_p0_alloc,
    btb_update_p0_start_pc,
    btb_update_p0_target_pc,
    btb_update_p0_ucond,
    btb_update_p0_call,
    btb_update_p0_ret,
    btb_update_p0_hold,
    btb_update_p1,
    btb_update_p1_way,
    btb_update_p1_blk_offset,
    btb_update_p1_alloc,
    btb_update_p1_start_pc,
    btb_update_p1_target_pc,
    btb_update_p1_ucond,
    btb_update_p1_call,
    btb_update_p1_ret,
    btb_update_p1_hold,
    bhr_recover,
    bhr_recover_data,
    bht_update_p0,
    bht_update_p0_dir_addr,
    bht_update_p0_sel_addr,
    bht_update_p0_sel_data,
    bht_update_p0_dir_data,
    bht_update_p1,
    bht_update_p1_dir_addr,
    bht_update_p1_sel_addr,
    bht_update_p1_sel_data,
    bht_update_p1_dir_data,
    rf_sdw_recover,
    rf_raddr1,
    rf_raddr2,
    rf_raddr3,
    rf_raddr4,
    rf_rdata1,
    rf_rdata2,
    rf_rdata3,
    rf_rdata4,
    rf_we1,
    rf_waddr1,
    rf_wdata1,
    rf_wstatus1,
    rf_we2,
    rf_waddr2,
    rf_wdata2,
    rf_wstatus2,
    rf_we3,
    rf_waddr3,
    rf_wdata3,
    rf_wstatus3,
    frf_raddr1,
    frf_raddr2,
    frf_raddr3,
    frf_raddr4,
    frf_rdata1,
    frf_rdata2,
    frf_rdata3,
    frf_rdata4,
    frf_we1,
    frf_waddr1,
    frf_wdata1,
    frf_wstatus1,
    frf_we2,
    frf_waddr2,
    frf_wdata2,
    frf_wstatus2,
    frf_we3,
    frf_waddr3,
    frf_wdata3,
    frf_wstatus3,
    alu0_func,
    alu0_op0,
    alu0_op1,
    alu0_result,
    alu0_aresult,
    alu0_bresult,
    alu1_func,
    alu1_op0,
    alu1_op1,
    alu1_bop0,
    alu1_bop1,
    alu1_result,
    alu2_func,
    alu2_op0,
    alu2_op1,
    alu2_result,
    alu3_func,
    alu3_op0,
    alu3_op1,
    alu3_bop0,
    alu3_bop1,
    alu3_result,
    bru0_pc,
    bru0_op0,
    bru0_op1,
    bru0_fn,
    bru0_offset,
    bru0_type,
    bru0_pred_info,
    bru0_pred_npc,
    bru0_target,
    bru0_seq_npc,
    bru0_reso_info,
    bru1_pc,
    bru1_op0,
    bru1_op1,
    bru1_bop0,
    bru1_bop1,
    bru1_fn,
    bru1_offset,
    bru1_type,
    bru1_pred_info,
    bru1_pred_npc,
    bru1_target,
    bru1_seq_npc,
    bru1_reso_info,
    bru2_pc,
    bru2_op0,
    bru2_op1,
    bru2_fn,
    bru2_offset,
    bru2_type,
    bru2_pred_info,
    bru2_pred_npc,
    bru2_target,
    bru2_seq_npc,
    bru2_reso_info,
    bru3_pc,
    bru3_op0,
    bru3_op1,
    bru3_bop0,
    bru3_bop1,
    bru3_fn,
    bru3_offset,
    bru3_type,
    bru3_pred_info,
    bru3_pred_npc,
    bru3_target,
    bru3_seq_npc,
    bru3_reso_info,
    mdu_kill,
    mdu_req_valid,
    mdu_req_tag,
    mdu_req_func,
    mdu_req_op0,
    mdu_req_op1,
    mdu_req_ready,
    mdu_resp_valid,
    mdu_resp_tag,
    mdu_resp_result,
    mdu_resp_ready,
    ex9_lookup_valid,
    ex9_lookup_ready,
    ex9_lookup_pc,
    ex9_lookup_resp_valid,
    ex9_lookup_resp_ready,
    ex9_lookup_resp_instr,
    ex9_lookup_resp_fault,
    ex9_lookup_resp_fault_dcause,
    ex9_lookup_resp_page_fault,
    ex9_lookup_resp_ecc_corr,
    ex9_lookup_resp_ecc_code,
    ex9_lookup_resp_ecc_ramid,
    async_valid,
    async_ready,
    wfi_done,
    itrigger_fire,
    etrigger_fire,
    ii_i0_trace_stall,
    wb_i0_alive,
    wb_i1_alive,
    wb_i0_seg_end,
    wb_i1_seg_end,
    wb_i0_retire,
    wb_i1_retire,
    wb_i0_pc,
    wb_i1_pc,
    wb_i0_npc,
    wb_i1_npc,
    wb_i0_tval,
    wb_i1_tval,
    wb_i0_ctrl,
    wb_i1_ctrl,
    wb_i0_instr,
    wb_i1_instr,
    wb_i0_reso_info,
    wb_i1_reso_info,
    wb_i0_16b,
    wb_i1_16b,
    wb_i0_trace_trigger,
    wb_i1_trace_trigger,
    wb_ls_ecc_code,
    wb_ls_ecc_corr,
    wb_ls_ecc_ramid,
    resume,
    resume_for_replay,
    resume_pc,
    resume_vectored,
    wb_i0_resume,
    wb_i1_resume,
    wb_postsync_resume,
    ls_standby_ready,
    ls_issue_ready,
    ls_req_valid,
    ls_req_pc,
    ls_req_stall,
    ls_req_base0,
    ls_req_base1,
    ls_req_base_bypass,
    ls_req_offset,
    ls_req_asid,
    ls_req_func,
    ls_resp_valid,
    ls_resp_result,
    ls_resp_bresult,
    ls_resp_status,
    ls_resp_fault_addr,
    ls_resp_result_64b,
    ls_cmt_valid,
    ls_cmt_kill,
    ls_cmt_wdata_sel_vpu,
    ls_cmt_wdata_base,
    ls_cmt_wdata_vpu,
    ls_una_wait,
    nbload_resp_valid,
    nbload_resp_rd,
    nbload_resp_result,
    nbload_resp_status,
    vpu_srf_wvalid,
    vpu_srf_wready,
    vpu_srf_wfrf,
    vpu_srf_waddr,
    vpu_srf_wdata,
    csr_mmisc_ctl_aces,
    ipipe_csr_req_wr_valid,
    ipipe_csr_req_rd_valid,
    ipipe_csr_req_read_only,
    ipipe_csr_req_mrandstate,
    ipipe_csr_req_func,
    ipipe_csr_req_waddr,
    ipipe_csr_req_raddr,
    ipipe_csr_req_wdata,
    csr_mhsp_bound,
    csr_mhsp_base,
    csr_mhsp_ctl_ovf_en,
    csr_mhsp_ctl_udf_en,
    csr_mhsp_ctl_schm,
    csr_mhsp_ctl_u,
    csr_mhsp_ctl_s,
    csr_mhsp_ctl_m,
    ipipe_csr_mhsp_bound_wdata,
    ipipe_csr_mhsp_bound_wen,
    ipipe_csr_hsp_xcpt,
    ipipe_csr_vtype_we,
    ipipe_csr_vtype_wdata,
    ipipe_csr_vl_we,
    ipipe_csr_vl_wdata,
    csr_uitb,
    csr_t_level,
    csr_pft_en,
    csr_ipipe_resp_rdata,
    csr_ipipe_rmw_rdata,
    csr_mcache_ctl_cctl_suen,
    csr_mstatus_tw,
    csr_mstatus_tvm,
    csr_mstatus_tsr,
    csr_cur_privilege,
    cur_privilege_m,
    cur_privilege_s,
    cur_privilege_u,
    csr_halt_mode,
    csr_dcsr_step,
    csr_dcsr_ebreakm,
    csr_dcsr_ebreaks,
    csr_dcsr_ebreaku,
    csr_ls_translate_en,
    csr_mcounteren,
    csr_mcounterwen,
    csr_scounteren,
    csr_frm,
    csr_mtvec,
    csr_stvec,
    csr_utvec,
    csr_mstatus_fs,
    csr_mmisc_ctl_rvcompm,
    csr_mmisc_ctl_brpe,
    csr_mmisc_ctl_nbcache_en,
    fmul_req,
    fmul_func,
    fmul_op0,
    fmul_op1,
    fmul_stall,
    fmul_result,
    trigm_i0_pc,
    trigm_i1_pc,
    trigm_i0_result,
    trigm_i1_result,
    trigm_icount_result,
    trigm_icount_enabled,
    ipipe_csr_fflags_set,
    ipipe_csr_ucode_ov_set,
    ipipe_csr_fs_wen,
    dsp_instr_valid,
    dsp_operand_ctrl,
    dsp_function_ctrl,
    dsp_result_ctrl,
    dsp_overflow_ctrl,
    dsp_data_src1,
    dsp_data_src2,
    dsp_data_src3,
    dsp_data_src4,
    dsp_stage2_pipe_en,
    dsp_stage3_pipe_en,
    dsp_stage1_result,
    dsp_stage1_ovf_set,
    dsp_stage2_result,
    dsp_stage2_ovf_set,
    dsp_stage3_result,
    dsp_stage3_ovf_set,
    vsetvl_op0,
    vsetvl_op1,
    vsetvl_result,
    vsetvl_vtype,
    ace_cmd_valid,
    ace_cmd_inst,
    ace_cmd_pc,
    ace_cmd_rs1,
    ace_cmd_rs2,
    ace_cmd_rs3,
    ace_cmd_rs4,
    ace_cmd_ready,
    ace_cmd_priv,
    ace_cmd_beat,
    ace_cmd_vl,
    ace_cmd_vtype,
    ace_cmd_hartid,
    ace_sync_req,
    ace_sync_type,
    ace_interrupt,
    ace_sync_ack,
    ace_sync_ack_status,
    ace_error,
    ace_standby_ready,
    ace_xrf_rd1_ready,
    ace_xrf_rd1_valid,
    ace_xrf_rd1_index,
    ace_xrf_rd1_data,
    ace_xrf_rd1_status,
    ace_xrf_rd2_ready,
    ace_xrf_rd2_valid,
    ace_xrf_rd2_index,
    ace_xrf_rd2_data,
    ace_xrf_rd2_status,
    fdiv_req_ready,
    fdiv_resp_tag,
    fdiv_resp_flag_set,
    fdiv_resp_result,
    fdiv_resp_valid,
    fdiv_resp_ready,
    fdiv_kill,
    vpu_viq_size,
    vpu_req_valid,
    vpu_req_vtype,
    vpu_req_vstart,
    vpu_req_vl,
    vpu_req_ls_privilege,
    vpu_req_i0_ctrl,
    vpu_req_i0_instr,
    vpu_req_i0_op1,
    vpu_req_i0_op2,
    vpu_req_i1_ctrl,
    vpu_req_i1_instr,
    vpu_req_i1_op1,
    vpu_req_i1_op2,
    vpu_vtlb_flush,
    vpu_cmt_valid,
    vpu_cmt_kill,
    vpu_cmt_i0_op1,
    vpu_cmt_i1_op1,
    vpu_ack_valid,
    vpu_ack_status,
    ipipe_event
);
parameter VALEN = 32;
parameter PALEN = 32;
parameter EXTVALEN = 32;
parameter FLEN = 0;
parameter ILM_SIZE_KB = 8;
parameter ILM_BASE = 64'h1000_0000;
parameter ILM_AMSB = 15;
parameter DLM_SIZE_KB = 8;
parameter DLM_BASE = 64'h2000_0000;
parameter DLM_AMSB = 15;
parameter CAUSE_LEN = 6;
parameter RVA_SUPPORT_INT = 0;
parameter RVN_SUPPORT_INT = 0;
parameter DSP_SUPPORT_INT = 0;
parameter ACE_SUPPORT_INT = 0;
parameter ACE_LS_SUPPORT_INT = 0;
parameter DEBUG_SUPPORT_INT = 0;
parameter TRACE_INTERFACE_INT = 0;
parameter VECTOR_PLIC_SUPPORT_INT = 0;
parameter STACKSAFE_SUPPORT_INT = 0;
parameter UNALIGNED_ACCESS_INT = 0;
parameter ISA_ANDES_INT = 1;
parameter BRANCH_PREDICTION_INT = 0;
parameter PERFORMANCE_MONITOR_INT = 0;
parameter FP16_SUPPORT_INT = 0;
parameter BFLOAT16_SUPPORT_INT = 0;
parameter VINT4_SUPPORT_INT = 0;
parameter NUM_PRIVILEGE_LEVELS = 1;
parameter PMA_ENTRIES = 0;
parameter BTB_SIZE = 0;
parameter DEBUG_VEC = 64'h0000_0000;
parameter ILM_ECC_TYPE_INT = 0;
parameter DLM_ECC_TYPE_INT = 0;
parameter DCACHE_ECC_TYPE_INT = 0;
parameter ICACHE_ECC_TYPE_INT = 0;
parameter STLB_ECC_TYPE = 0;
parameter MULTIPLIER_INT = 1;
parameter STATIC_BRANCH_PREDICTION_INT = 0;
parameter ISA_GP_INT = 0;
parameter ISA_LEA_INT = 0;
parameter ISA_BEQC_INT = 0;
parameter ISA_BBZ_INT = 0;
parameter ISA_BFO_INT = 0;
parameter ISA_STR_INT = 0;
parameter POWERBRAKE_SUPPORT_INT = 0;
parameter CACHE_LINE_SIZE = 32;
parameter ICACHE_SIZE_KB = 0;
parameter DCACHE_SIZE_KB = 0;
parameter MMU_SCHEME_INT = 0;
parameter LOCALINT_SLPECC = 16;
parameter LOCALINT_SBE = 17;
parameter LOCALINT_HPMINT = 18;
parameter HAS_VPU_INT = 0;
parameter VLEN = 512;
localparam DSP_OCTRL_WIDTH = 44;
localparam DSP_FCTRL_WIDTH = 151;
localparam DSP_RCTRL_WIDTH = 70;
localparam DSP_HCTRL_WIDTH = 3;
localparam OP_MISC_MEM = 7'b0001111;
localparam OP_DSP = 7'b1111111;
localparam PRIVILEGE_USER = 2'b00;
localparam PRIVILEGE_SUPERVISOR = 2'b01;
localparam PRIVILEGE_HYPERVISOR = 2'b10;
localparam PRIVILEGE_MACHINE = 2'b11;
localparam INT_MEI = 11;
localparam INT_MSI = 3;
localparam INT_MTI = 7;
localparam INT_SEI = 9;
localparam INT_SSI = 1;
localparam INT_STI = 5;
localparam INT_UEI = 8;
localparam INT_USI = 0;
localparam INT_UTI = 4;
localparam SATP_MODE_BARE = 4'h0;
localparam SLVP = 3;
localparam MEI = 0;
localparam MTI = 1;
localparam MSI = 2;
localparam SEI = 3;
localparam STI = 4;
localparam SSI = 5;
localparam UEI = 6;
localparam UTI = 7;
localparam USI = 8;
localparam MICRO_MISALIGNED_LS_IDLE = 2'b00;
localparam MICRO_MISALIGNED_1ST_LS = 2'b01;
localparam MICRO_MISALIGNED_2ND_LS = 2'b10;
localparam MICRO_MISALIGNED_3RD_LS = 2'b11;
localparam TARGET_ADDRESS_BIT_NUMBER = 19;
localparam FULL_WRITE_FUNC3 = 3'b010;
localparam ECC_SUPPORT_INT = ((STLB_ECC_TYPE != 0) | (ILM_ECC_TYPE_INT != 0) | (DLM_ECC_TYPE_INT != 0) | (DCACHE_ECC_TYPE_INT != 0)) ? 1 : 0;
localparam MMISC_CTL_EXIST_INT = (((ACE_SUPPORT_INT == 1)) | ((ISA_ANDES_INT == 1)) | ((VECTOR_PLIC_SUPPORT_INT == 1)) | ((BRANCH_PREDICTION_INT != 0))) ? 1 : 0;
localparam MMSC_CFG2_EXIST_INT = 1;
localparam CACHE_SUPPORT_INT = ((ICACHE_SIZE_KB != 0) | (DCACHE_SIZE_KB != 0) | (STLB_ECC_TYPE != 0)) ? 1 : 0;
localparam HSP_LOAD_IDLE = 2'h0;
localparam HSP_LOAD_WAIT_DATA = 2'h1;
localparam HSP_LOAD_CHECK = 2'h2;
localparam HSP_LOAD_EXCEPTION = 2'h3;
localparam HSP_MDU_IDLE = 2'h0;
localparam HSP_MDU_WAIT_DATA = 2'h1;
localparam HSP_MDU_CHECK = 2'h2;
localparam HSP_MDU_EXCEPTION = 2'h3;
localparam RAMID_ICACHE_TAG = 4'b0010;
localparam RAMID_ICACHE_DATA = 4'b0011;
localparam RAMID_DCACHE_TAG = 4'b0100;
localparam RAMID_DCACHE_DATA = 4'b0101;
localparam RAMID_ILM = 4'b1000;
localparam RAMID_DLM = 4'b1001;
localparam L1D_VA_INVAL = 5'b00000;
localparam L1D_VA_WB = 5'b00001;
localparam L1D_VA_WBINVAL = 5'b00010;
localparam L1D_VA_LOCK = 5'b00011;
localparam L1D_VA_UNLOCK = 5'b00100;
localparam L1D_LEAF_WB = 5'b00101;
localparam L1D_WBINVAL_ALL = 5'b00110;
localparam L1D_LX_ALL = 5'b00111;
localparam L1I_VA_INVAL = 5'b01000;
localparam L1I_VA_LOCK = 5'b01011;
localparam L1I_VA_UNLOCK = 5'b01100;
localparam L1D_IX_INVAL = 5'b10000;
localparam L1D_IX_WB = 5'b10001;
localparam L1D_IX_WBINVAL = 5'b10010;
localparam L1D_IX_RTAG = 5'b10011;
localparam L1D_IX_RDATA = 5'b10100;
localparam L1D_IX_WTAG = 5'b10101;
localparam L1D_IX_WDATA = 5'b10110;
localparam L1D_INVAL_ALL = 5'b10111;
localparam L1I_IX_INVAL = 5'b11000;
localparam L1I_IX_RTAG = 5'b11011;
localparam L1I_IX_RDATA = 5'b11100;
localparam L1I_IX_WTAG = 5'b11101;
localparam L1I_IX_WDATA = 5'b11110;
localparam DSP_RDY_EX = 2'b00;
localparam DSP_RDY_MM = 2'b01;
localparam DSP_RDY_WB = 2'b10;
localparam VPU_STATUS_BITS = 2;
localparam VPU_CTRL_BITS = 17;
localparam UINS_PCLEN = 16;
input core_clk;
input core_reset_n;
output hart_halted;
input biu_ipipe_standby_ready;
input ifu_ipipe_standby_ready;
input mmu_ipipe_standby_ready;
input fpu_ipipe_standby_ready;
input fpu_ipipe_fdiv_standby_ready;
output core_wfi_mode;
output wfi_enabled;
input [31:0] csr_vstart;
input [31:0] csr_vtype;
input [31:0] csr_vl;
input ls_privilege_m;
input ls_privilege_s;
input ls_privilege_u;
output ipipe_ifu_stall;
input ifu_ipipe_init_done;
input ifu_i0_valid;
input [EXTVALEN - 1:0] ifu_i0_pc;
input [31:0] ifu_i0_instr;
input ifu_i0_vector_resume;
input ifu_i0_instr_16b;
input ifu_i0_pred_valid;
input ifu_i0_pred_hit;
input [1:0] ifu_i0_pred_way;
input ifu_i0_pred_taken;
input ifu_i0_pred_ret;
input ifu_i0_pred_bogus;
input [3:0] ifu_i0_pred_cnt;
input ifu_i0_pred_start;
input ifu_i0_pred_brk;
input ifu_i0_keep_bhr;
input [VALEN - 1:0] ifu_i0_pred_npc;
input ifu_i0_fault;
input [2:0] ifu_i0_fault_dcause;
input ifu_i0_page_fault;
input ifu_i0_fault_upper;
input ifu_i0_ecc_corr;
input [7:0] ifu_i0_ecc_code;
input [2:0] ifu_i0_ecc_ramid;
output ifu_i0_ready;
input ifu_i1_valid;
input [EXTVALEN - 1:0] ifu_i1_pc;
input [31:0] ifu_i1_instr;
input ifu_i1_vector_resume;
input ifu_i1_instr_16b;
input ifu_i1_pred_valid;
input ifu_i1_pred_hit;
input [1:0] ifu_i1_pred_way;
input ifu_i1_pred_taken;
input ifu_i1_pred_ret;
input ifu_i1_pred_bogus;
input [3:0] ifu_i1_pred_cnt;
input ifu_i1_keep_bhr;
input [VALEN - 1:0] ifu_i1_pred_npc;
input ifu_i1_pred_start;
input ifu_i1_pred_brk;
input ifu_i1_fault;
input [2:0] ifu_i1_fault_dcause;
input ifu_i1_page_fault;
input ifu_i1_fault_upper;
input ifu_i1_ecc_corr;
input [7:0] ifu_i1_ecc_code;
input [2:0] ifu_i1_ecc_ramid;
output ifu_i1_ready;
output [21:0] fpu_i0_ctrl;
output fpu_i0_valid;
output [63:0] fpu_i0_frs1;
output [FLEN - 1:0] fpu_i0_frs2;
output [FLEN - 1:0] fpu_i0_frs3;
output [21:0] fpu_i1_ctrl;
output fpu_i1_valid;
output [63:0] fpu_i1_frs1;
output [FLEN - 1:0] fpu_i1_frs2;
output [FLEN - 1:0] fpu_i1_frs3;
output fpu_lx_stall;
input [63:0] fpu_fmis_result;
input [4:0] fmis_flag_set;
input [63:0] fpu_fmv_result;
input [FLEN - 1:0] fpu_fmac32_result;
input [FLEN - 1:0] fpu_fmac64_result;
input [4:0] fmac_flag_set;
output redirect;
output redirect_for_cti;
output [EXTVALEN - 1:0] redirect_pc;
output redirect_pc_hit_ilm;
output [1:0] redirect_ras_ptr;
output retry;
output [EXTVALEN - 1:0] retry_pc;
input btb_flush_ready;
output btb_flush_valid;
output btb_update_p0;
output [1:0] btb_update_p0_way;
output [9:0] btb_update_p0_blk_offset;
output btb_update_p0_alloc;
output [VALEN - 1:0] btb_update_p0_start_pc;
output [VALEN - 1:0] btb_update_p0_target_pc;
output btb_update_p0_ucond;
output btb_update_p0_call;
output btb_update_p0_ret;
output btb_update_p0_hold;
output btb_update_p1;
output [1:0] btb_update_p1_way;
output [9:0] btb_update_p1_blk_offset;
output btb_update_p1_alloc;
output [VALEN - 1:0] btb_update_p1_start_pc;
output [VALEN - 1:0] btb_update_p1_target_pc;
output btb_update_p1_ucond;
output btb_update_p1_call;
output btb_update_p1_ret;
output btb_update_p1_hold;
output bhr_recover;
output [7:0] bhr_recover_data;
output bht_update_p0;
output [7:0] bht_update_p0_dir_addr;
output [7:0] bht_update_p0_sel_addr;
output [1:0] bht_update_p0_sel_data;
output [1:0] bht_update_p0_dir_data;
output bht_update_p1;
output [7:0] bht_update_p1_dir_addr;
output [7:0] bht_update_p1_sel_addr;
output [1:0] bht_update_p1_sel_data;
output [1:0] bht_update_p1_dir_data;
output rf_sdw_recover;
output [4:0] rf_raddr1;
output [4:0] rf_raddr2;
output [4:0] rf_raddr3;
output [4:0] rf_raddr4;
input [31:0] rf_rdata1;
input [31:0] rf_rdata2;
input [31:0] rf_rdata3;
input [31:0] rf_rdata4;
output rf_we1;
output [4:0] rf_waddr1;
output [31:0] rf_wdata1;
output [1:0] rf_wstatus1;
output rf_we2;
output [4:0] rf_waddr2;
output [31:0] rf_wdata2;
output [1:0] rf_wstatus2;
output rf_we3;
output [4:0] rf_waddr3;
output [31:0] rf_wdata3;
output rf_wstatus3;
output [4:0] frf_raddr1;
output [4:0] frf_raddr2;
output [4:0] frf_raddr3;
output [4:0] frf_raddr4;
input [FLEN - 1:0] frf_rdata1;
input [FLEN - 1:0] frf_rdata2;
input [FLEN - 1:0] frf_rdata3;
input [FLEN - 1:0] frf_rdata4;
output frf_we1;
output [4:0] frf_waddr1;
output [FLEN - 1:0] frf_wdata1;
output [1:0] frf_wstatus1;
output frf_we2;
output [4:0] frf_waddr2;
output [FLEN - 1:0] frf_wdata2;
output [1:0] frf_wstatus2;
output frf_we3;
output [4:0] frf_waddr3;
output [FLEN - 1:0] frf_wdata3;
output frf_wstatus3;
output [35:0] alu0_func;
output [31:0] alu0_op0;
output [31:0] alu0_op1;
input [31:0] alu0_result;
input [31:0] alu0_aresult;
input [31:0] alu0_bresult;
output [35:0] alu1_func;
output [31:0] alu1_op0;
output [31:0] alu1_op1;
output [31:0] alu1_bop0;
output [31:0] alu1_bop1;
input [31:0] alu1_result;
output [35:0] alu2_func;
output [31:0] alu2_op0;
output [31:0] alu2_op1;
input [31:0] alu2_result;
output [35:0] alu3_func;
output [31:0] alu3_op0;
output [31:0] alu3_op1;
output [31:0] alu3_bop0;
output [31:0] alu3_bop1;
input [31:0] alu3_result;
output [EXTVALEN - 1:0] bru0_pc;
output [31:0] bru0_op0;
output [31:0] bru0_op1;
output [4:0] bru0_fn;
output [20:0] bru0_offset;
output [8:0] bru0_type;
output [11:0] bru0_pred_info;
output [EXTVALEN - 1:0] bru0_pred_npc;
input [EXTVALEN - 1:0] bru0_target;
input [EXTVALEN - 1:0] bru0_seq_npc;
input [12:0] bru0_reso_info;
output [EXTVALEN - 1:0] bru1_pc;
output [31:0] bru1_op0;
output [31:0] bru1_op1;
output [31:0] bru1_bop0;
output [31:0] bru1_bop1;
output [4:0] bru1_fn;
output [20:0] bru1_offset;
output [8:0] bru1_type;
output [11:0] bru1_pred_info;
output [EXTVALEN - 1:0] bru1_pred_npc;
input [EXTVALEN - 1:0] bru1_target;
input [EXTVALEN - 1:0] bru1_seq_npc;
input [12:0] bru1_reso_info;
output [EXTVALEN - 1:0] bru2_pc;
output [31:0] bru2_op0;
output [31:0] bru2_op1;
output [4:0] bru2_fn;
output [20:0] bru2_offset;
output [8:0] bru2_type;
output [11:0] bru2_pred_info;
output [EXTVALEN - 1:0] bru2_pred_npc;
input [EXTVALEN - 1:0] bru2_target;
input [EXTVALEN - 1:0] bru2_seq_npc;
input [12:0] bru2_reso_info;
output [EXTVALEN - 1:0] bru3_pc;
output [31:0] bru3_op0;
output [31:0] bru3_op1;
output [31:0] bru3_bop0;
output [31:0] bru3_bop1;
output [4:0] bru3_fn;
output [20:0] bru3_offset;
output [8:0] bru3_type;
output [11:0] bru3_pred_info;
output [EXTVALEN - 1:0] bru3_pred_npc;
input [EXTVALEN - 1:0] bru3_target;
input [EXTVALEN - 1:0] bru3_seq_npc;
input [12:0] bru3_reso_info;
output mdu_kill;
output mdu_req_valid;
output [4:0] mdu_req_tag;
output [3:0] mdu_req_func;
output [31:0] mdu_req_op0;
output [31:0] mdu_req_op1;
input mdu_req_ready;
input mdu_resp_valid;
input [4:0] mdu_resp_tag;
input [31:0] mdu_resp_result;
output mdu_resp_ready;
output ex9_lookup_valid;
input ex9_lookup_ready;
output [EXTVALEN - 1:0] ex9_lookup_pc;
input ex9_lookup_resp_valid;
output ex9_lookup_resp_ready;
input [31:0] ex9_lookup_resp_instr;
input ex9_lookup_resp_fault;
input [2:0] ex9_lookup_resp_fault_dcause;
input ex9_lookup_resp_page_fault;
input ex9_lookup_resp_ecc_corr;
input [7:0] ex9_lookup_resp_ecc_code;
input [2:0] ex9_lookup_resp_ecc_ramid;
input async_valid;
output async_ready;
input wfi_done;
input [4:0] itrigger_fire;
input [4:0] etrigger_fire;
input ii_i0_trace_stall;
output wb_i0_alive;
output wb_i1_alive;
output wb_i0_seg_end;
output wb_i1_seg_end;
output wb_i0_retire;
output wb_i1_retire;
output [EXTVALEN - 1:0] wb_i0_pc;
output [EXTVALEN - 1:0] wb_i1_pc;
output [EXTVALEN - 1:0] wb_i0_npc;
output [EXTVALEN - 1:0] wb_i1_npc;
output [31:0] wb_i0_tval;
output [31:0] wb_i1_tval;
output [149:0] wb_i0_ctrl;
output [149:0] wb_i1_ctrl;
output [31:0] wb_i0_instr;
output [31:0] wb_i1_instr;
output [12:0] wb_i0_reso_info;
output [12:0] wb_i1_reso_info;
output wb_i0_16b;
output wb_i1_16b;
output [2:0] wb_i0_trace_trigger;
output [2:0] wb_i1_trace_trigger;
output [7:0] wb_ls_ecc_code;
output wb_ls_ecc_corr;
output [3:0] wb_ls_ecc_ramid;
output resume;
output resume_for_replay;
input [EXTVALEN - 1:0] resume_pc;
input resume_vectored;
output wb_i0_resume;
output wb_i1_resume;
output wb_postsync_resume;
input ls_standby_ready;
input ls_issue_ready;
output ls_req_valid;
output [11:0] ls_req_pc;
output [1:0] ls_req_stall;
output [31:0] ls_req_base0;
output [31:0] ls_req_base1;
output [2:0] ls_req_base_bypass;
output [20:0] ls_req_offset;
output [8:0] ls_req_asid;
output [34:0] ls_req_func;
input ls_resp_valid;
input [31:0] ls_resp_result;
input [31:0] ls_resp_bresult;
input [31:0] ls_resp_status;
input [EXTVALEN - 1:0] ls_resp_fault_addr;
input [63:0] ls_resp_result_64b;
output ls_cmt_valid;
output ls_cmt_kill;
output ls_cmt_wdata_sel_vpu;
output [31:0] ls_cmt_wdata_base;
output [63:0] ls_cmt_wdata_vpu;
output ls_una_wait;
input nbload_resp_valid;
input [4:0] nbload_resp_rd;
input [31:0] nbload_resp_result;
input nbload_resp_status;
input vpu_srf_wvalid;
output vpu_srf_wready;
input vpu_srf_wfrf;
input [4:0] vpu_srf_waddr;
input [63:0] vpu_srf_wdata;
input [1:0] csr_mmisc_ctl_aces;
output ipipe_csr_req_wr_valid;
output ipipe_csr_req_rd_valid;
output ipipe_csr_req_read_only;
output ipipe_csr_req_mrandstate;
output [1:0] ipipe_csr_req_func;
output [11:0] ipipe_csr_req_waddr;
output [11:0] ipipe_csr_req_raddr;
output [31:0] ipipe_csr_req_wdata;
input [31:0] csr_mhsp_bound;
input [31:0] csr_mhsp_base;
input csr_mhsp_ctl_ovf_en;
input csr_mhsp_ctl_udf_en;
input csr_mhsp_ctl_schm;
input csr_mhsp_ctl_u;
input csr_mhsp_ctl_s;
input csr_mhsp_ctl_m;
output [31:0] ipipe_csr_mhsp_bound_wdata;
output ipipe_csr_mhsp_bound_wen;
output ipipe_csr_hsp_xcpt;
output ipipe_csr_vtype_we;
output [31:0] ipipe_csr_vtype_wdata;
output ipipe_csr_vl_we;
output [31:0] ipipe_csr_vl_wdata;
input [31:0] csr_uitb;
input [3:0] csr_t_level;
input csr_pft_en;
input [31:0] csr_ipipe_resp_rdata;
input [31:0] csr_ipipe_rmw_rdata;
input csr_mcache_ctl_cctl_suen;
input csr_mstatus_tw;
input csr_mstatus_tvm;
input csr_mstatus_tsr;
input [1:0] csr_cur_privilege;
input cur_privilege_m;
input cur_privilege_s;
input cur_privilege_u;
input csr_halt_mode;
input csr_dcsr_step;
input csr_dcsr_ebreakm;
input csr_dcsr_ebreaks;
input csr_dcsr_ebreaku;
input csr_ls_translate_en;
input [31:0] csr_mcounteren;
input [31:0] csr_mcounterwen;
input [31:0] csr_scounteren;
input [31:0] csr_frm;
input [31:0] csr_mtvec;
input [31:0] csr_stvec;
input [31:0] csr_utvec;
input [1:0] csr_mstatus_fs;
input csr_mmisc_ctl_rvcompm;
input csr_mmisc_ctl_brpe;
input csr_mmisc_ctl_nbcache_en;
output fmul_req;
output [3:0] fmul_func;
output [31:0] fmul_op0;
output [31:0] fmul_op1;
output fmul_stall;
input [31:0] fmul_result;
output [VALEN - 1:0] trigm_i0_pc;
output [VALEN - 1:0] trigm_i1_pc;
input [4:0] trigm_i0_result;
input [4:0] trigm_i1_result;
input [4:0] trigm_icount_result;
input trigm_icount_enabled;
output [4:0] ipipe_csr_fflags_set;
output ipipe_csr_ucode_ov_set;
output ipipe_csr_fs_wen;
output dsp_instr_valid;
output [DSP_OCTRL_WIDTH - 1:0] dsp_operand_ctrl;
output [DSP_FCTRL_WIDTH - 1:0] dsp_function_ctrl;
output [DSP_RCTRL_WIDTH - 1:0] dsp_result_ctrl;
output dsp_overflow_ctrl;
output [31:0] dsp_data_src1;
output [31:0] dsp_data_src2;
output [31:0] dsp_data_src3;
output [31:0] dsp_data_src4;
output dsp_stage2_pipe_en;
output dsp_stage3_pipe_en;
input [63:0] dsp_stage1_result;
input dsp_stage1_ovf_set;
input [63:0] dsp_stage2_result;
input dsp_stage2_ovf_set;
input [63:0] dsp_stage3_result;
input dsp_stage3_ovf_set;
output [31:0] vsetvl_op0;
output [31:0] vsetvl_op1;
input [31:0] vsetvl_result;
input [8:0] vsetvl_vtype;
output ace_cmd_valid;
output [31:7] ace_cmd_inst;
output [VALEN - 1:0] ace_cmd_pc;
output [31:0] ace_cmd_rs1;
output [31:0] ace_cmd_rs2;
output [31:0] ace_cmd_rs3;
output [31:0] ace_cmd_rs4;
input ace_cmd_ready;
output [1:0] ace_cmd_priv;
output [31:0] ace_cmd_beat;
output [31:0] ace_cmd_vl;
output [31:0] ace_cmd_vtype;
output [31:0] ace_cmd_hartid;
output ace_sync_req;
output [31:0] ace_sync_type;
output ace_interrupt;
input ace_sync_ack;
input ace_sync_ack_status;
input ace_error;
input ace_standby_ready;
output ace_xrf_rd1_ready;
input ace_xrf_rd1_valid;
input [4:0] ace_xrf_rd1_index;
input [31:0] ace_xrf_rd1_data;
input ace_xrf_rd1_status;
output ace_xrf_rd2_ready;
input ace_xrf_rd2_valid;
input [4:0] ace_xrf_rd2_index;
input [31:0] ace_xrf_rd2_data;
input ace_xrf_rd2_status;
input fdiv_req_ready;
input [4:0] fdiv_resp_tag;
input [4:0] fdiv_resp_flag_set;
input [FLEN - 1:0] fdiv_resp_result;
input fdiv_resp_valid;
output fdiv_resp_ready;
output fdiv_kill;
input [3:0] vpu_viq_size;
output [1:0] vpu_req_valid;
output [8:0] vpu_req_vtype;
output [9:0] vpu_req_vstart;
output [10:0] vpu_req_vl;
output [1:0] vpu_req_ls_privilege;
output [(VPU_CTRL_BITS - 1):0] vpu_req_i0_ctrl;
output [31:0] vpu_req_i0_instr;
output [63:0] vpu_req_i0_op1;
output [63:0] vpu_req_i0_op2;
output [(VPU_CTRL_BITS - 1):0] vpu_req_i1_ctrl;
output [31:0] vpu_req_i1_instr;
output [63:0] vpu_req_i1_op1;
output [63:0] vpu_req_i1_op2;
output vpu_vtlb_flush;
output vpu_cmt_valid;
output vpu_cmt_kill;
output [63:0] vpu_cmt_i0_op1;
output [63:0] vpu_cmt_i1_op1;
input vpu_ack_valid;
input [VPU_STATUS_BITS - 1:0] vpu_ack_status;
output [0:0] ipipe_event;


wire fdiv_resp_return;
wire lx_stall;
wire csr_brpe_clr;
wire csr_brpe_wrz;
wire csr_btb_flush;
wire ii_is_calu_pair;
wire ii_is_calu_cmv_pair;
wire [20:0] ii_i0_size;
wire [20:0] ii_i1_size;
wire [20:0] ii_instrs_size;
reg [31:0] ex_i1_calu_imm;
reg [31:0] mm_i1_calu_imm;
reg [31:0] lx_i1_calu_imm;
wire [31:0] bru0_link_result;
wire [31:0] bru1_link_result;
wire [31:0] bru2_link_result;
wire [31:0] bru3_link_result;
wire throttling_stall;
wire [1:0] ifu_valid;
wire [1:0] ifd_kill;
wire [1:0] iiq_alive;
wire [1:0] id_ready;
wire id_ex9_lookup_ins;
wire id_ex9_not_ready;
wire id_retry;
wire id_uinstr_sel;
wire id_uinstr_ready;
wire [322:0] id_uinstr_ctrl;
wire [11:0] id_uinstr_pred_info;
wire [EXTVALEN - 1:0] id_uinstr_pred_npc;
wire [31:0] ifu_i0_dec_instr;
wire ifu_i0_dec_fault;
wire [2:0] ifu_i0_dec_fault_dcause;
wire ifu_i0_dec_page_fault;
wire ifu_i0_dec_ecc_corr;
wire [7:0] ifu_i0_dec_ecc_code;
wire [2:0] ifu_i0_dec_ecc_ramid;
wire ifu_i0_dec_instr_16b;
wire [EXTVALEN - 1:0] ifd_i0_pred_npc;
wire [322:0] ifd_i0_ctrl;
wire [11:0] ifd_i0_pred_info;
wire [EXTVALEN - 1:0] id_i0_npc;
wire [EXTVALEN - 1:0] id_i0_pred_npc;
wire [322:0] id_i0_ctrl;
wire [322:0] iiq_i0_ctrl;
wire [11:0] id_i0_pred_info;
wire [31:0] id_i0_instr;
wire id_i0_ex9_ins;
wire [31:0] id_i0_imm;
wire [EXTVALEN - 1:0] id_i0_pc;
wire [EXTVALEN - 1:0] iiq_i0_pc;
wire [UINS_PCLEN - 3:0] iiq_i0_uinstr_pc;
wire [EXTVALEN - 1:0] iiq_i0_npc;
wire [11:0] iiq_i0_pred_info;
wire [31:0] iiq_i0_instr;
wire [31:0] iiq_i0_imm;
wire id_i0_alive;
wire [31:0] ifu_i1_dec_instr;
wire ifu_i1_dec_fault;
wire [2:0] ifu_i1_dec_fault_dcause;
wire ifu_i1_dec_page_fault;
wire ifu_i1_dec_ecc_corr;
wire [7:0] ifu_i1_dec_ecc_code;
wire [2:0] ifu_i1_dec_ecc_ramid;
wire ifu_i1_dec_instr_16b;
wire [EXTVALEN - 1:0] ifd_i1_pred_npc;
wire [322:0] ifd_i1_ctrl;
wire [11:0] ifd_i1_pred_info;
wire [EXTVALEN - 1:0] id_i1_npc;
wire [EXTVALEN - 1:0] id_i1_pred_npc;
wire [322:0] id_i1_ctrl;
wire [322:0] iiq_i1_ctrl;
wire [11:0] id_i1_pred_info;
wire [31:0] id_i1_instr;
wire id_i1_ex9_ins;
wire [31:0] id_i1_imm;
wire [EXTVALEN - 1:0] id_i1_pc;
wire [EXTVALEN - 1:0] iiq_i1_pc;
wire [UINS_PCLEN - 3:0] iiq_i1_uinstr_pc;
wire [EXTVALEN - 1:0] iiq_i1_npc;
wire [11:0] iiq_i1_pred_info;
wire [31:0] iiq_i1_instr;
wire [31:0] iiq_i1_imm;
wire id_i1_alive;
wire [4:0] rf_waddr3;
wire [EXTVALEN - 1:0] ii_exec_i0_it_jal_base;
wire [EXTVALEN - 1:0] ii_exec_i1_it_jal_base;
wire tb_redirect;
wire tb_redirect_for_cti;
wire [EXTVALEN - 1:0] tb_redirect_pc;
wire tb_redirect_hit_ilm;
wire [1:0] tb_ras_ptr;
wire tb_fdiv_resp_ready;
wire [1:0] ii_valid;
wire [1:0] ii_ready;
wire [322:0] ii_i0_ctrl;
wire [11:0] ii_i0_pred_info;
wire [EXTVALEN - 1:0] ii_i0_pc;
wire [UINS_PCLEN - 3:0] ii_i0_uinstr_pc;
wire [EXTVALEN - 1:0] ii_i0_npc;
wire [31:0] ii_i0_instr;
wire [EXTVALEN - 1:0] ii_i0_instr_zext;
wire [31:0] ii_i0_imm;
wire [EXTVALEN - 1:0] ii_i0_val;
wire [EXTVALEN - 1:0] ii_i0_tval;
wire [322:0] ii_i1_ctrl;
wire [11:0] ii_i1_pred_info;
wire [EXTVALEN - 1:0] ii_i1_pc;
wire [UINS_PCLEN - 3:0] ii_i1_uinstr_pc;
wire [EXTVALEN - 1:0] ii_i1_npc;
wire [31:0] ii_i1_instr;
wire [EXTVALEN - 1:0] ii_i1_instr_zext;
wire [31:0] ii_i1_imm;
wire [EXTVALEN - 1:0] ii_i1_val;
wire [EXTVALEN - 1:0] ii_i1_tval;
wire [1:0] ii_alive;
wire [1:0] ii_abort;
wire [1:0] ii_doable;
wire ii_i0_stall;
wire [213:0] ii_ex_i0_ctrl;
wire [31:0] ii_i0_pc_ext;
wire ii_i0_late;
wire [11:0] ii_i0_mm_bypass;
wire ii_i0_ex_nbload_hazard;
wire ii_i0_mm_nbload_hazard;
wire ii_i1_stall;
wire [213:0] ii_ex_i1_ctrl;
wire [31:0] ii_i1_pc_ext;
wire ii_i1_late;
wire [11:0] ii_i1_mm_bypass;
wire ii_i1_ex_nbload_hazard;
wire ii_i1_mm_nbload_hazard;
wire [3:0] ii_i1_ex_bypass;
wire [3:0] ii_i1_lx_bypass;
wire [5:0] ii_i0_src1_sel = ii_i0_ctrl[295 +:6];
wire [5:0] ii_i1_src1_sel = (ii_i0_ctrl[292] | ii_is_calu_cmv_pair) ? 6'b1 : ii_i1_ctrl[295 +:6];
wire [1:0] ii_i0_tval_sel = ii_i0_ctrl[302 +:2];
wire [1:0] ii_i1_tval_sel = ii_i1_ctrl[302 +:2];
wire [4:0] ii_vpu_vtype_sel;
wire ii_i0_fu_vpu = ii_i0_ctrl[193];
wire ii_i1_fu_vpu = ii_i1_ctrl[193];
wire ii_i0_existent_csr;
wire ii_i0_privileged_csr;
wire ii_i0_privileged_csr_ddcause;
wire ii_i0_readonly_csr;
wire [1:0] ii_uinstr_seg;
wire ii_uinstr_star_mid;
wire [31:0] rs1_rf_rdata;
wire [31:0] rs2_rf_rdata;
wire [31:0] rs3_rf_rdata;
wire [31:0] rs4_rf_rdata;
wire [31:0] ii_src1;
wire [31:0] ii_src2;
wire [31:0] ii_src3;
wire [31:0] ii_src4;
wire [4:0] ii_rs1;
wire [4:0] ii_rs2;
wire [4:0] ii_rs3;
wire [4:0] ii_rs4;
wire [2:0] ii_i0_ras_ptr;
wire [2:0] ii_i1_ras_ptr;
wire [16:0] ii_vpu_i0_ctrl;
wire [16:0] ii_vpu_i1_ctrl;
wire ii_vpu_i0_op1_sel;
wire ii_vpu_i1_op1_sel;
wire ii_vpu_i0_op1_hazard;
wire ii_vpu_i1_op1_hazard;
wire wfi_enabled;
wire i0_ll_presync_not_ready;
wire i1_ll_presync_not_ready;
wire [2:0] presync_ready;
wire ii_i0_illegal_csr;
wire [2:0] ii_i0_illegal_csr_ddcause_sub;
wire [1:0] ii_ex_valid;
wire ii_uinstr_star;
reg [0:0] ipipe_event;
wire [0:0] ipipe_event_nx;
wire event_xrf_busy;
reg insert_hss;
wire insert_hss_nx;
wire inster_hss_clr;
reg [4:0] insert_trigger;
wire [4:0] insert_trigger_nx;
wire [4:0] insert_trigger_set;
wire [4:0] insert_trigger_clr;
wire [4:0] insert_trigger_final = insert_trigger | trigm_icount_result;
wire rs1_ren;
wire rs2_ren;
wire rs3_ren;
wire rs4_ren;
wire [17:0] ii_i0_bypass;
wire [17:0] ii_i1_bypass;
wire [17:0] ii_i0_frs_bypass;
wire [17:0] ii_i0_xrs_bypass;
wire [17:0] ii_i1_frs_bypass;
wire [8:0] ii_i1_frs3_bypass;
wire [17:0] ii_i1_xrs_bypass;
wire [15:0] ii_mdu_bypass;
wire [3:0] ii_mdu_func;
wire [2:0] ii_ls_base_bypass;
wire [34:0] ii_ls_func;
wire [20:0] ii_ls_offset;
wire ii_postsync_replay;
wire ls_issue_ready;
wire [31:0] ls_req_base;
wire [3:0] ii_viq_size;
wire vpu_srf_wgrant = vpu_srf_wvalid & vpu_srf_wready;
wire ex_ctrl_en;
reg [1:0] ex_valid;
wire [1:0] ex_alive;
wire [1:0] ex_doable;
wire [1:0] ex_abort;
wire ex_i0_valid;
wire [204:0] ex_mm_i0_ctrl;
reg [213:0] ex_i0_ctrl;
reg [EXTVALEN - 1:0] ex_i0_pc;
reg [UINS_PCLEN - 3:0] ex_i0_uinstr_pc;
reg [31:0] ex_i0_instr;
reg [EXTVALEN - 1:0] ex_i0_val;
reg [11:0] ex_i0_pred_info;
wire [12:0] ex_i0_reso_info;
wire [EXTVALEN - 1:0] ex_mm_i0_val;
wire ex_i0_poisoned;
wire ex_i0_ls;
wire ex_i1_valid;
wire [204:0] ex_mm_i1_ctrl;
reg [213:0] ex_i1_ctrl;
reg [EXTVALEN - 1:0] ex_i1_pc;
reg [UINS_PCLEN - 3:0] ex_i1_uinstr_pc;
reg [31:0] ex_i1_instr;
reg [EXTVALEN - 1:0] ex_i1_val;
reg [11:0] ex_i1_pred_info;
wire [12:0] ex_i1_reso_info;
wire [EXTVALEN - 1:0] ex_mm_i1_val;
wire ex_i1_poisoned;
wire ex_i1_ls;
reg [31:0] ex_src1_reg;
reg [31:0] ex_src2_reg;
reg [31:0] ex_src3_reg;
reg [31:0] ex_src4_reg;
wire [31:0] ex_src1;
wire [31:0] ex_src2;
wire [31:0] ex_src3;
wire [31:0] ex_src4;
wire [4:0] ex_vpu_vtype_sel;
wire [8:0] ex_vtype;
wire [31:0] ex_vl;
wire ex_i0_fu_vpu = ex_i0_ctrl[152];
wire ex_i1_fu_vpu = ex_i1_ctrl[152];
wire ex_i0_vsetvl = ex_i0_ctrl[153];
wire ex_i1_vsetvl = ex_i1_ctrl[153];
reg [15:0] ex_mdu_bypass;
reg [3:0] ex_mdu_func;
wire [31:0] ex_rd1_wdata;
wire [31:0] ex_rd2_wdata;
wire [31:0] mdu_req_op0_reg;
wire [31:0] mdu_req_op1_reg;
reg [20:0] ex_ls_offset;
reg [34:0] ex_ls_func;
reg [2:0] ex_ls_base_bypass;
wire ex_ls_loadb;
wire ex_ls_poisoned;
wire [2:0] ex_ls_addr_lsbs;
wire [2:0] ls_req_func3 = ls_req_func[0 +:3];
wire ls_req_load = ls_req_func[3];
wire int_taken_mask_set;
wire int_taken_mask_clr;
wire int_taken_mask_en;
wire int_taken_mask_nx;
reg int_taken_mask;
wire ex_mm_i0_random_replay;
wire ex_mm_i1_random_replay;
assign ex_mm_i0_random_replay = 1'b0;
assign ex_mm_i1_random_replay = 1'b0;
wire id_i0_pp_instr;
wire mm_non_pp_uinstr;
wire lx_pp_int_taken_mask_set;
wire wb_pp_int_taken_mask_clr;
wire wb_pp_insert_hss_clr;
wire wb_i0_pp_retire;
wire wb_i0_non_pp_micro_last;
wire wb_i0_non_pp_micro;
wire wb_i1_non_pp_micro;
wire wb_i0_xreg_backup;
wire wb_i1_xreg_backup;
wire ii_i0_1st_pp_micro;
wire ii_i1_1st_pp_micro;
wire ex_i0_illegal_pp;
wire ex_i1_illegal_pp;
wire mm_ctrl_en;
reg [1:0] mm_valid;
wire [1:0] mm_alive;
wire [1:0] mm_doable;
wire [1:0] mm_abort;
wire [1:0] mm_lx_abort;
wire mm_i0_valid;
wire mm_i0_kill;
wire mm_i0_xcpt;
wire mm_i0_replay;
wire mm_i0_nbload_hazard;
reg [204:0] mm_i0_ctrl;
wire [192:0] mm_lx_i0_ctrl;
reg [EXTVALEN - 1:0] mm_i0_pc;
reg [UINS_PCLEN - 3:0] mm_i0_uinstr_pc;
reg [31:0] mm_i0_instr;
wire mm_i0_mispred;
reg [EXTVALEN - 1:0] mm_i0_val;
wire [EXTVALEN - 1:0] mm_i0_npc;
wire [EXTVALEN - 1:0] mm_i0_seq_npc;
reg [12:0] mm_i0_reso_info;
wire [12:0] mm_lx_i0_reso_info;
reg [11:0] mm_i0_pred_info;
wire [2:0] mm_i0_ras_ptr;
wire mm_i0_redirect;
wire mm_i0_val_misaligned;
wire mm_i0_redirect_pc_hit_ilm;
wire mm_i1_valid;
wire mm_i1_kill;
wire mm_i1_xcpt;
wire mm_i1_replay;
wire mm_i1_nbload_hazard;
reg [204:0] mm_i1_ctrl;
wire [192:0] mm_lx_i1_ctrl;
reg [EXTVALEN - 1:0] mm_i1_pc;
reg [UINS_PCLEN - 3:0] mm_i1_uinstr_pc;
reg [31:0] mm_i1_instr;
wire mm_i1_mispred;
reg [EXTVALEN - 1:0] mm_i1_val;
wire [EXTVALEN - 1:0] mm_i1_npc;
wire [EXTVALEN - 1:0] mm_i1_seq_npc;
reg [12:0] mm_i1_reso_info;
wire [12:0] mm_lx_i1_reso_info;
reg [11:0] mm_i1_pred_info;
wire [2:0] mm_i1_ras_ptr;
wire mm_i1_redirect;
wire mm_i1_val_misaligned;
wire mm_i1_redirect_pc_hit_ilm;
wire mm_i0_tb_mispred;
wire mm_i1_tb_mispred;
wire mm_i0_btb_mispred;
wire mm_i1_btb_mispred;
reg [31:0] mm_src1_reg;
reg [31:0] mm_src2_reg;
reg [31:0] mm_src3_reg;
reg [31:0] mm_src4_reg;
wire [31:0] mm_src1;
wire [31:0] mm_src2;
wire [31:0] mm_src3;
wire [31:0] mm_src4;
wire [31:0] mm_rd1_wdata;
wire [31:0] mm_rd2_wdata;
wire mm_redirect_final;
wire mm_i0_redirect_final;
wire mm_i1_redirect_final;
reg mm_ls_loadb;
wire [1:0] mm_uinstr_seg;
wire mm_uinstr;
wire mm_i0_vsetvl = mm_i0_ctrl[167];
wire mm_i1_vsetvl = mm_i1_ctrl[167];
wire mm_i0_sp_xcpt;
wire mm_i1_sp_xcpt;
wire [2:0] mm_i0_sp_status;
wire [2:0] mm_i1_sp_status;
wire lx_ctrl_en;
reg [1:0] lx_valid;
wire [1:0] lx_alive;
wire [1:0] lx_abort;
wire [1:0] lx_doable;
wire lx_i0_valid;
reg [192:0] lx_i0_ctrl;
wire [149:0] lx_wb_i0_ctrl;
reg [31:0] lx_i0_instr;
reg [EXTVALEN - 1:0] lx_i0_pc;
reg [12:0] lx_i0_reso_info;
reg [11:0] lx_i0_pred_info;
wire [12:0] lx_wb_i0_reso_info;
reg [EXTVALEN - 1:0] lx_i0_val;
wire [EXTVALEN - 1:0] lx_wb_i0_val;
wire [CAUSE_LEN - 1:0] lx_i0_ls_cause;
wire lx_i0_ls_halt;
wire lx_i0_ls_replay;
wire lx_i0_nbload;
wire [3:0] lx_i0_ramid;
wire lx_i1_valid;
reg [192:0] lx_i1_ctrl;
wire [149:0] lx_wb_i1_ctrl;
reg [31:0] lx_i1_instr;
reg [EXTVALEN - 1:0] lx_i1_pc;
reg [12:0] lx_i1_reso_info;
reg [11:0] lx_i1_pred_info;
wire [12:0] lx_wb_i1_reso_info;
reg [EXTVALEN - 1:0] lx_i1_val;
wire [EXTVALEN - 1:0] lx_wb_i1_val;
wire [CAUSE_LEN - 1:0] lx_i1_ls_cause;
wire lx_i1_ls_halt;
wire lx_i1_ls_replay;
wire lx_i1_nbload;
wire [3:0] lx_i1_ramid;
wire lx_i1_poisoned;
wire [3:0] lx_i1_bypass = lx_i1_ctrl[75 +:4];
reg [31:0] lx_src1_reg;
reg [31:0] lx_src2_reg;
reg [31:0] lx_src3_reg;
reg [31:0] lx_src4_reg;
wire [31:0] lx_src1;
wire [31:0] lx_src2;
wire [31:0] lx_src3;
wire [31:0] lx_src4;
wire [31:0] lx_rd1_wdata;
wire [31:0] lx_rd2_wdata;
wire [31:0] lau2_result;
wire [31:0] lau3_result;
wire lx_i0_vsetvl = lx_i0_ctrl[149];
wire lx_i1_vsetvl = lx_i1_ctrl[149];
wire [31:0] csr_wdata;
wire lx_i0_ls_xcpt;
wire lx_i1_ls_xcpt;
wire lx_i0_ls_trace_on;
wire lx_i1_ls_trace_on;
wire lx_i0_ls_trace_off;
wire lx_i1_ls_trace_off;
wire lx_i0_ls_trace_notify;
wire lx_i1_ls_trace_notify;
wire lx_ls_stall;
wire lx_wait_ls_resp;
wire lx_sp_i0_sel_rd1;
wire lx_sp_i1_sel_rd1;
wire [1:0] lx_wb_valid;
wire lx_wb_async_stall;
wire wb_ctrl_en;
wire wb_valid_en;
wire wb_kill;
wire [2:0] wb_ras_ptr;
reg [1:0] wb_valid;
wire wb_i0_valid;
wire wb_i0_alive;
wire wb_i0_doable;
wire wb_i0_abort;
reg [149:0] wb_i0_ctrl;
reg [EXTVALEN - 1:0] wb_i0_pc;
reg [31:0] wb_i0_instr;
wire wb_i0_kill;
wire wb_i0_nbload;
wire wb_i0_mispred;
wire [EXTVALEN - 1:0] wb_i0_npc;
wire [EXTVALEN - 1:0] wb_i0_seq_npc;
wire [31:0] wb_i0_seq_npc_sext;
reg [EXTVALEN - 1:0] wb_i0_val;
wire [31:0] wb_i0_val_sext;
wire [31:0] wb_i0_fetch_fault_pc_sext;
reg [12:0] wb_i0_reso_info_reg;
wire [12:0] wb_i0_reso_info;
reg [11:0] wb_i0_pred_info;
wire [2:0] wb_i0_ras_ptr;
wire wb_i0_redirect;
wire wb_i0_redirect_pc_hit_ilm;
wire wb_i0_target_misaligned;
wire wb_i1_valid;
wire wb_i1_alive;
wire wb_i1_doable;
wire wb_i1_abort;
reg [149:0] wb_i1_ctrl;
reg [EXTVALEN - 1:0] wb_i1_pc;
reg [31:0] wb_i1_instr;
wire wb_i1_kill;
wire wb_i1_nbload;
wire wb_i1_mispred;
wire [EXTVALEN - 1:0] wb_i1_npc;
wire [EXTVALEN - 1:0] wb_i1_seq_npc;
wire [31:0] wb_i1_seq_npc_sext;
reg [EXTVALEN - 1:0] wb_i1_val;
wire [31:0] wb_i1_val_sext;
wire [31:0] wb_i1_fetch_fault_pc_sext;
reg [12:0] wb_i1_reso_info_reg;
wire [12:0] wb_i1_reso_info;
reg [11:0] wb_i1_pred_info;
wire [2:0] wb_i1_ras_ptr;
wire wb_i1_redirect;
wire wb_i1_redirect_pc_hit_ilm;
wire wb_i1_target_misaligned;
wire wb_i0_btb_mispred;
wire wb_i1_btb_mispred;
wire wb_i0_tb_mispred;
wire wb_i1_tb_mispred;
wire wb_i0_pc_en;
wire [EXTVALEN - 1:0] wb_i0_pc_nx;
reg wb_i0_pc_vec;
wire wb_i0_pc_vec_nx;
wire [1:0] wb_i0_micro_seg;
wire wb_i0_seg_end;
wire [1:0] wb_i1_micro_seg;
wire wb_i1_seg_end;
wire wb_i0_micro;
wire wb_i0_micro_last;
wire wb_i1_micro;
wire [8:0] wb_vtype;
wire wb_i0_vsetvl = wb_i0_ctrl[105];
wire wb_i1_vsetvl = wb_i1_ctrl[105];
wire wb_redirect;
wire wb_i0_calu_taken;
wire wb_post_stall_rel;
reg [7:0] wb_ls_ecc_code;
reg wb_ls_ecc_corr;
reg [3:0] wb_ls_ecc_ramid;
reg [31:0] wb_rd1_wdata_reg;
reg [31:0] wb_rd2_wdata_reg;
wire [31:0] wb_rd1_wdata;
wire [31:0] wb_rd2_wdata;
reg wb_async_stall;
wire wb_async_taken;
wire ex_mm_ls_valid;
reg mm_ls_valid;
reg lx_ls_valid;
reg mm_ls_killed;
reg lx_ls_killed;
wire mm_ls_killed_nx;
wire lx_ls_killed_nx;
reg lx_ls_commited;
wire lx_ls_commited_nx;
wire ls_resp_nbload = lx_ls_valid & ~lx_ls_killed & ls_resp_status[12];
wire uinstr_redirect;
wire uinstr_flush;
wire uinstr_done;
wire [31:0] id_uinstr_imm12;
wire [UINS_PCLEN - 3:0] id_uinstr_pc;
reg core_wfi_mode;
wire core_wfi_mode_en;
wire core_wfi_mode_set;
wire core_wfi_mode_clr;
wire core_wfi_mode_nx;
wire mdu_resp_ready;
wire mdu_inst_retire;
reg mdu_retired;
wire mdu_retired_nx;
wire mdu_resp_return;
wire mdu_uins_retire;
wire mdu_uins_wr_rf_en;
wire mdu_uins_wr_rf_set;
wire mdu_uins_wr_rf_clr;
wire mdu_uins_wr_rf_nx;
reg mdu_uins_wr_rf;
wire mdu_uins_rf_we_en;
wire mdu_uins_rf_we_set;
wire mdu_uins_rf_we_clr;
wire mdu_uins_rf_we_nx;
reg mdu_uins_rf_we;
wire wfi_done;
wire mhsp_match_priv_lv;
wire [1:0] ex_i0_postsync = ex_i0_ctrl[71 +:2];
wire [1:0] mm_i0_postsync = mm_i0_ctrl[71 +:2];
wire [1:0] lx_i0_postsync = lx_i0_ctrl[71 +:2];
wire [1:0] wb_i0_postsync = wb_i0_ctrl[34 +:2];
wire [1:0] ex_i1_postsync = ex_i1_ctrl[71 +:2];
wire [1:0] lx_i1_postsync = lx_i1_ctrl[71 +:2];
wire rvc_en = 1'b1;
wire dsp_instr_valid;
wire [31:0] dsp_data_src1;
wire [31:0] dsp_data_src2;
wire [31:0] dsp_data_src3;
wire [31:0] dsp_data_src4;
wire [DSP_OCTRL_WIDTH - 1:0] dsp_operand_ctrl;
wire [DSP_FCTRL_WIDTH - 1:0] dsp_function_ctrl;
wire [DSP_RCTRL_WIDTH - 1:0] dsp_result_ctrl;
wire dsp_overflow_ctrl;
wire dsp_stage2_pipe_en;
wire dsp_stage3_pipe_en;
wire [31:0] ex_dsp_rd1;
wire [31:0] ex_dsp_rd2;
wire [31:0] mm_dsp_rd1;
wire [31:0] mm_dsp_rd2;
wire [31:0] lx_dsp_rd1;
wire [31:0] lx_dsp_rd2;
reg [VALEN - 1:0] mm_bblk_start_pc;
wire mm_bblk_start_pc_update;
wire [VALEN - 1:0] mm_bblk_start_pc_nx;
wire [VALEN - 1:0] mm_i0_bblk_start_pc;
wire [VALEN - 1:0] mm_i1_bblk_start_pc;
reg mm_btb_update_issued;
wire mm_btb_update_issued_set;
wire mm_btb_update_issued_clr;
wire mm_btb_update_issued_nx;
wire mm_btb_update_p0;
wire mm_btb_update_p0_invalid;
wire mm_btb_update_p0_valid;
wire [1:0] mm_btb_update_p0_way;
wire [9:0] mm_btb_update_p0_blk_offset;
wire mm_btb_update_p0_alloc;
wire [VALEN - 1:0] mm_btb_update_p0_start_pc;
wire [VALEN - 1:0] mm_btb_update_p0_target_pc;
wire mm_btb_update_p0_ucond;
wire mm_btb_update_p0_call;
wire mm_btb_update_p0_ret;
wire mm_btb_update_p1;
wire mm_btb_update_p1_invalid;
wire mm_btb_update_p1_valid;
wire [1:0] mm_btb_update_p1_way;
wire [9:0] mm_btb_update_p1_blk_offset;
wire mm_btb_update_p1_alloc;
wire [VALEN - 1:0] mm_btb_update_p1_start_pc;
wire [VALEN - 1:0] mm_btb_update_p1_target_pc;
wire mm_btb_update_p1_ucond;
wire mm_btb_update_p1_call;
wire mm_btb_update_p1_ret;
reg [VALEN - 1:0] wb_bblk_start_pc;
wire wb_bblk_start_pc_update;
wire [VALEN - 1:0] wb_bblk_start_pc_nx;
wire [VALEN - 1:0] wb_i0_bblk_start_pc;
wire [VALEN - 1:0] wb_i1_bblk_start_pc;
wire [VALEN - 1:0] wb_i0_update_dir_addr;
wire [VALEN - 1:0] wb_i1_update_dir_addr;
wire wb_bht_update_p0;
wire [1:0] wb_bht_update_p0_sel_data;
wire [1:0] wb_bht_update_p0_dir_data;
wire [7:0] wb_bht_update_p0_sel_addr;
wire [7:0] wb_bht_update_p0_dir_addr;
wire wb_bht_update_p1;
wire [1:0] wb_bht_update_p1_sel_data;
wire [1:0] wb_bht_update_p1_dir_data;
wire [7:0] wb_bht_update_p1_sel_addr;
wire [7:0] wb_bht_update_p1_dir_addr;
wire wb_btb_update_p0;
wire wb_btb_update_p0_valid;
wire wb_btb_update_p0_invalid;
wire [1:0] wb_btb_update_p0_way;
wire [9:0] wb_btb_update_p0_blk_offset;
wire wb_btb_update_p0_alloc;
wire [VALEN - 1:0] wb_btb_update_p0_start_pc;
wire [VALEN - 1:0] wb_btb_update_p0_target_pc;
wire wb_btb_update_p0_ucond;
wire wb_btb_update_p0_call;
wire wb_btb_update_p0_ret;
wire wb_btb_update_p1;
wire wb_btb_update_p1_valid;
wire wb_btb_update_p1_invalid;
wire [1:0] wb_btb_update_p1_way;
wire [9:0] wb_btb_update_p1_blk_offset;
wire wb_btb_update_p1_alloc;
wire [VALEN - 1:0] wb_btb_update_p1_start_pc;
wire [VALEN - 1:0] wb_btb_update_p1_target_pc;
wire wb_btb_update_p1_ucond;
wire wb_btb_update_p1_call;
wire wb_btb_update_p1_ret;
reg wb_bht_btb_update_issued;
wire wb_bht_btb_update_issued_set;
wire wb_bht_btb_update_issued_clr;
wire wb_bht_btb_update_issued_nx;
wire wb_i0_16b = wb_i0_ctrl[7] | wb_i0_ctrl[92];
wire [VALEN - 1:0] wb_i0_fall_thru_offset;
wire wb_i0_fall_thru_offset_overflow;
wire wb_i0_start_pc_valid;
wire wb_i0_is_start;
wire wb_i1_16b = wb_i1_ctrl[7];
wire [VALEN - 1:0] wb_i1_fall_thru_offset;
wire wb_i1_fall_thru_offset_overflow;
wire wb_i1_start_pc_valid;
wire wb_i1_is_start;
reg wb_start_pc_valid_keep;
wire wb_start_pc_valid_keep_set;
wire wb_start_pc_valid_keep_clr;
wire wb_start_pc_valid_keep_nx;
reg mm_redirect_issued;
wire mm_redirect_issued_nx;
wire mm_redirect;
wire [4:0] ace_resp_rd1;
wire ace_resp_rd1_valid;
wire [4:0] ace_resp_rd2;
wire ace_resp_rd2_valid;
wire ace_no_credit_stall;
wire ace_q_rvalid;
wire ace_q_rready;
wire wb_rf_we2;
wire ace_sync_req;
wire ace_presync_ready;
wire [31:0] ace_sync_type;
wire ace_interrupt;
wire [21:0] fpu_i0_ctrl;
wire fpu_i0_valid;
wire [63:0] fpu_i0_frs1;
wire [FLEN - 1:0] fpu_i0_frs2;
wire [FLEN - 1:0] fpu_i0_frs3;
wire [21:0] fpu_i1_ctrl;
wire fpu_i1_valid;
wire [63:0] fpu_i1_frs1;
wire [FLEN - 1:0] fpu_i1_frs2;
wire [FLEN - 1:0] fpu_i1_frs3;
wire [FLEN - 1:0] rs1_frf_rdata;
wire [FLEN - 1:0] rs2_frf_rdata;
wire [FLEN - 1:0] rs3_frf_rdata;
wire [FLEN - 1:0] rs4_frf_rdata;
wire [FLEN - 1:0] ii_i1_frs3_frf_rdata;
wire [6:0] ii_i0_frs1_src_sel;
wire [6:0] ii_i0_frs2_src_sel;
wire [6:0] ii_i0_frs3_src_sel;
wire [6:0] ii_i1_frs1_src_sel;
wire [6:0] ii_i1_frs2_src_sel;
wire [6:0] ii_i1_frs3_src_sel;
wire [8:0] ii_fstore_wdata_sel;
wire fdiv_kill;
wire [4:0] frf_raddr1;
wire [4:0] frf_raddr2;
wire [4:0] frf_raddr3;
wire [4:0] frf_raddr4;
wire [4:0] frf_waddr1;
wire frf_we1;
wire [FLEN - 1:0] frf_wdata1;
wire [4:0] frf_waddr2;
wire frf_we2;
wire [4:0] frf_waddr3;
wire frf_we3;
wire [31:0] lx_dp_frd1_high_part;
wire [31:0] lx_dp_frd2_high_part;
wire [31:0] wb_dp_frd1_high_part;
wire [31:0] wb_dp_frd2_high_part;
wire [FLEN - 1:0] mm_fstore_wdata;
reg [FLEN - 1:0] lx_fstore_wdata;
wire [63:0] lx_fstore_wdata_zext;
wire [8:0] mm_fstore_wdata_sel;
wire [1:0] ex_ls_size = ls_req_func3[1:0];
reg [1:0] mm_ls_size;
reg [1:0] lx_ls_size;
wire [63:0] nan_boxing_value;
wire [63:0] fpu_nan_load_data_64b;
reg fdiv_resp_wait_frf_update;
wire fdiv_resp_wait_frf_update_set;
wire fdiv_resp_wait_frf_update_clr;
wire fdiv_resp_wait_frf_update_nx;
wire fdiv_resp_wait_frf_update_en;
wire [31:0] ls_resp_result_with_nan_boxing;
assign fdiv_resp_wait_frf_update_set = (wb_i0_doable & wb_i0_ctrl[95]) | (wb_i1_doable & wb_i1_ctrl[95]);
assign fdiv_resp_wait_frf_update_clr = fdiv_resp_return;
assign fdiv_resp_wait_frf_update_nx = (fdiv_resp_wait_frf_update | fdiv_resp_wait_frf_update_set) & ~fdiv_resp_wait_frf_update_clr;
assign fdiv_resp_wait_frf_update_en = fdiv_resp_wait_frf_update_set | fdiv_resp_wait_frf_update_clr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        fdiv_resp_wait_frf_update <= 1'b0;
    end
    else if (fdiv_resp_wait_frf_update_en) begin
        fdiv_resp_wait_frf_update <= fdiv_resp_wait_frf_update_nx;
    end
end

reg [4:0] lx_i0_fpu_csr_flag_set;
reg [4:0] lx_i1_fpu_csr_flag_set;
wire [4:0] lx_i0_fpu_csr_flag_set_nx;
wire [4:0] lx_i1_fpu_csr_flag_set_nx;
reg [4:0] wb_i0_fpu_csr_flag_set;
reg [4:0] wb_i1_fpu_csr_flag_set;
wire [4:0] wb_i0_fpu_csr_flag_set_nx;
wire [4:0] wb_i1_fpu_csr_flag_set_nx;
assign lx_i0_fpu_csr_flag_set_nx = fmis_flag_set & {5{mm_doable[0] & mm_i0_ctrl[158]}};
assign lx_i1_fpu_csr_flag_set_nx = fmis_flag_set & {5{mm_doable[1] & mm_i1_ctrl[158]}};
assign wb_i0_fpu_csr_flag_set_nx = ({5{lx_doable[0] & ~lx_stall & lx_i0_ctrl[138]}} & fmac_flag_set) | ({5{lx_doable[0] & ~lx_stall}} & lx_i0_fpu_csr_flag_set);
assign wb_i1_fpu_csr_flag_set_nx = ({5{lx_doable[1] & ~lx_stall & lx_i1_ctrl[138]}} & fmac_flag_set) | ({5{lx_doable[1] & ~lx_stall}} & lx_i1_fpu_csr_flag_set);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        lx_i0_fpu_csr_flag_set <= 5'b0;
        lx_i1_fpu_csr_flag_set <= 5'b0;
    end
    else if (lx_ctrl_en) begin
        lx_i0_fpu_csr_flag_set <= lx_i0_fpu_csr_flag_set_nx;
        lx_i1_fpu_csr_flag_set <= lx_i1_fpu_csr_flag_set_nx;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        wb_i0_fpu_csr_flag_set <= 5'b0;
        wb_i1_fpu_csr_flag_set <= 5'b0;
    end
    else begin
        wb_i0_fpu_csr_flag_set <= wb_i0_fpu_csr_flag_set_nx;
        wb_i1_fpu_csr_flag_set <= wb_i1_fpu_csr_flag_set_nx;
    end
end

assign ipipe_csr_fflags_set = ({5{((wb_i0_doable & wb_i0_ctrl[98]) | (wb_i1_doable & wb_i1_ctrl[98]))}} & fmac_flag_set) | ({5{wb_i0_doable}} & wb_i0_fpu_csr_flag_set) | ({5{wb_i1_doable}} & wb_i1_fpu_csr_flag_set) | ({5{fdiv_resp_valid & (fdiv_resp_wait_frf_update | fdiv_resp_wait_frf_update_set)}} & fdiv_resp_flag_set);
assign ipipe_csr_fs_wen = (wb_i0_doable & wb_i0_ctrl[91]) | (wb_i1_doable & wb_i1_ctrl[91]) | (wb_i0_doable & wb_i0_ctrl[99] & (|wb_i0_fpu_csr_flag_set)) | (wb_i1_doable & wb_i1_ctrl[99] & (|wb_i1_fpu_csr_flag_set));
wire wb_i1_frf_wr;
wire wb_i1_fmac64_wr;
assign wb_i1_frf_wr = wb_i1_doable & wb_i1_ctrl[91] & ~wb_i1_ctrl[95];
assign wb_i1_fmac64_wr = wb_i1_doable & wb_i1_ctrl[91] & wb_i1_ctrl[98];
assign frf_raddr1 = ii_i0_ctrl[141 +:5] & {5{ii_i0_ctrl[146] & ii_valid[0]}};
assign frf_raddr2 = ii_i0_ctrl[152] ? ii_i0_ctrl[147 +:5] & {5{ii_i0_ctrl[152] & ii_valid[0]}} : ii_i1_ctrl[153 +:5] & {5{ii_i1_ctrl[158] & ii_valid[1]}};
assign frf_raddr3 = ii_i0_ctrl[158] ? ii_i0_ctrl[153 +:5] & {5{ii_i0_ctrl[158] & ii_valid[0]}} : ii_i1_ctrl[141 +:5] & {5{ii_i1_ctrl[146] & ii_valid[1]}};
assign frf_raddr4 = ii_i1_ctrl[147 +:5] & {5{ii_i1_ctrl[152] & ii_valid[1]}};
assign frf_waddr1 = wb_i0_ctrl[86 +:5];
assign frf_we1 = wb_i0_doable & wb_i0_ctrl[91];
assign frf_wstatus1 = {1'b0,wb_i0_ctrl[95]};
assign frf_waddr2 = wb_i1_frf_wr ? wb_i1_ctrl[86 +:5] : fdiv_resp_tag;
assign frf_we2 = (wb_i1_doable & wb_i1_ctrl[91]) | (fdiv_resp_valid & (fdiv_resp_wait_frf_update | fdiv_resp_wait_frf_update_set));
assign frf_wstatus2 = {1'b0,wb_i1_ctrl[95] & ~fdiv_resp_valid};
assign frf_waddr3 = 5'b0;
assign frf_we3 = 1'b0;
assign frf_wdata3 = {FLEN{1'b0}};
assign frf_wstatus3 = 1'b0;
generate
    if (FLEN == 32) begin:gen_len_eq_frf_wdata
        assign frf_wdata1 = wb_i0_ctrl[98] ? fpu_fmac64_result : wb_rd1_wdata;
        assign frf_wdata2 = wb_i1_fmac64_wr ? fpu_fmac64_result : wb_i1_frf_wr ? wb_rd2_wdata : fdiv_resp_result;
    end
    else if (FLEN == 64) begin:gen_len_neq_dp_frf_wdata
        assign frf_wdata1 = wb_i0_ctrl[98] ? fpu_fmac64_result : {wb_dp_frd1_high_part,wb_rd1_wdata};
        assign frf_wdata2 = wb_i1_fmac64_wr ? fpu_fmac64_result : wb_i1_frf_wr ? {wb_dp_frd2_high_part,wb_rd2_wdata} : fdiv_resp_result;
    end
    else begin:gen_len_neq_sp_frf_wdata
        assign frf_wdata1 = wb_rd1_wdata[FLEN - 1:0];
        assign frf_wdata2 = wb_i1_frf_wr ? wb_rd2_wdata[FLEN - 1:0] : fdiv_resp_result;
    end
endgenerate
wire [31:0] rs1_rf_rdata_for_fpu;
wire [31:0] rs2_rf_rdata_for_fpu;
wire [31:0] rs3_rf_rdata_for_fpu;
wire [31:0] rs4_rf_rdata_for_fpu;
wire [31:0] ii_i1_frs3_rdata_for_fpu;
wire ii_i0_fpu_inst;
wire ii_i1_fpu_inst;
assign rs1_rf_rdata_for_fpu = ({32{ii_i0_fpu_inst & ii_i0_bypass[0]}} & rf_rdata1) | ({32{ii_i0_fpu_inst & ii_i0_bypass[3]}} & mm_rd1_wdata) | ({32{ii_i0_fpu_inst & ii_i0_bypass[4]}} & mm_rd2_wdata) | ({32{ii_i0_fpu_inst & ii_i0_bypass[5]}} & lx_rd1_wdata) | ({32{ii_i0_fpu_inst & lx_i1_ctrl[180] & ii_i0_bypass[6]}} & lx_src4_reg) | ({32{ii_i0_fpu_inst & lx_i1_ctrl[177] & ii_i0_bypass[6]}} & ls_resp_result_with_nan_boxing) | ({32{ii_i0_fpu_inst & ii_i0_bypass[7]}} & wb_rd1_wdata) | ({32{ii_i0_fpu_inst & ii_i0_bypass[8]}} & wb_rd2_wdata);
assign rs2_rf_rdata_for_fpu = ({32{ii_i0_frs_bypass[12]}} & mm_rd1_wdata) | ({32{ii_i0_frs_bypass[13]}} & mm_rd2_wdata) | ({32{lx_i0_ctrl[180] & ii_i0_frs_bypass[14]}} & lx_src2_reg) | ({32{lx_i0_ctrl[177] & ii_i0_frs_bypass[14]}} & ls_resp_result_with_nan_boxing) | ({32{lx_i1_ctrl[180] & ii_i0_frs_bypass[15]}} & lx_src4_reg) | ({32{lx_i1_ctrl[177] & ii_i0_frs_bypass[15]}} & ls_resp_result_with_nan_boxing) | ({32{ii_i0_frs_bypass[16]}} & wb_rd1_wdata) | ({32{ii_i0_frs_bypass[17]}} & wb_rd2_wdata);
assign rs3_rf_rdata_for_fpu = ({32{(ii_i0_fpu_inst | ii_i1_fpu_inst) & ii_i1_bypass[0]}} & rf_rdata3) | ({32{(ii_i0_fpu_inst | ii_i1_fpu_inst) & ii_i1_bypass[3]}} & mm_rd1_wdata) | ({32{(ii_i0_fpu_inst | ii_i1_fpu_inst) & ii_i1_bypass[4]}} & mm_rd2_wdata) | ({32{(ii_i0_fpu_inst | ii_i1_fpu_inst) & ii_i1_bypass[5]}} & lx_rd1_wdata) | ({32{(ii_i0_fpu_inst | ii_i1_fpu_inst) & lx_i1_ctrl[180] & ii_i1_bypass[6]}} & lx_src4_reg) | ({32{(ii_i0_fpu_inst | ii_i1_fpu_inst) & lx_i1_ctrl[177] & ii_i1_bypass[6]}} & ls_resp_result_with_nan_boxing) | ({32{(ii_i0_fpu_inst | ii_i1_fpu_inst) & ii_i1_bypass[7]}} & wb_rd1_wdata) | ({32{(ii_i0_fpu_inst | ii_i1_fpu_inst) & ii_i1_bypass[8]}} & wb_rd2_wdata);
assign rs4_rf_rdata_for_fpu = ({32{ii_i1_frs_bypass[12]}} & mm_rd1_wdata) | ({32{ii_i1_frs_bypass[13]}} & mm_rd2_wdata) | ({32{lx_i0_ctrl[180] & ii_i1_frs_bypass[14]}} & lx_src2_reg) | ({32{lx_i0_ctrl[177] & ii_i1_frs_bypass[14]}} & ls_resp_result_with_nan_boxing) | ({32{lx_i1_ctrl[180] & ii_i1_frs_bypass[15]}} & lx_src4_reg) | ({32{lx_i1_ctrl[177] & ii_i1_frs_bypass[15]}} & ls_resp_result_with_nan_boxing) | ({32{ii_i1_frs_bypass[16]}} & wb_rd1_wdata) | ({32{ii_i1_frs_bypass[17]}} & wb_rd2_wdata);
assign ii_i1_frs3_rdata_for_fpu = ({32{ii_i1_frs3_bypass[3]}} & mm_rd1_wdata) | ({32{ii_i1_frs3_bypass[4]}} & mm_rd2_wdata) | ({32{lx_i0_ctrl[180] & ii_i1_frs3_bypass[5]}} & lx_src2_reg) | ({32{lx_i0_ctrl[177] & ii_i1_frs3_bypass[5]}} & ls_resp_result_with_nan_boxing) | ({32{lx_i1_ctrl[180] & ii_i1_frs3_bypass[6]}} & lx_src4_reg) | ({32{lx_i1_ctrl[177] & ii_i1_frs3_bypass[6]}} & ls_resp_result_with_nan_boxing) | ({32{ii_i1_frs3_bypass[7]}} & wb_rd1_wdata) | ({32{ii_i1_frs3_bypass[8]}} & wb_rd2_wdata);
wire lx_fstore_wdata_en;
assign lx_fstore_wdata_en = lx_ctrl_en & (mm_i0_ctrl[160] & mm_doable[0] | mm_i1_ctrl[160] & mm_doable[1]);
generate
    if ((FLEN == 64) & 1'b1) begin:gen_dp_high_part
        wire [31:0] mm_dp_frd1_high_part;
        wire [31:0] mm_dp_frd2_high_part;
        reg [31:0] mm_dp_frd1_high_part_reg;
        wire [31:0] mm_dp_frd1_high_part_nx;
        reg [31:0] mm_dp_frd2_high_part_reg;
        wire [31:0] mm_dp_frd2_high_part_nx;
        reg [31:0] lx_dp_frd1_high_part_reg;
        wire [31:0] lx_dp_frd1_high_part_nx;
        reg [31:0] lx_dp_frd2_high_part_reg;
        wire [31:0] lx_dp_frd2_high_part_nx;
        reg [31:0] wb_dp_frd1_high_part_reg;
        wire [31:0] wb_dp_frd1_high_part_nx;
        reg [31:0] wb_dp_frd2_high_part_reg;
        wire [31:0] wb_dp_frd2_high_part_nx;
        wire [31:0] mm_rd1_byapss_ii_high_part;
        wire [31:0] mm_rd2_byapss_ii_high_part;
        wire [31:0] lx_rd1_byapss_ii_high_part;
        wire [31:0] lx_rd2_byapss_ii_high_part;
        wire [31:0] wb_rd1_byapss_ii_high_part;
        wire [31:0] wb_rd2_byapss_ii_high_part;
        wire [31:0] ii_rs1_bypass_high_part;
        wire [31:0] ii_rs2_bypass_high_part;
        wire [31:0] ii_rs3_bypass_high_part;
        wire [31:0] ii_rs4_bypass_high_part;
        wire [31:0] ii_i1_frs3_bypass_high_part;
        assign mm_dp_frd1_high_part_nx = fpu_fmv_result[FLEN - 1:32] & {32{ex_i0_ctrl[143]}};
        assign mm_dp_frd2_high_part_nx = fpu_fmv_result[FLEN - 1:32] & {32{ex_i1_ctrl[143]}};
        assign lx_dp_frd1_high_part_nx = mm_i0_ctrl[158] ? fpu_fmis_result[FLEN - 1:32] : mm_dp_frd1_high_part;
        assign lx_dp_frd2_high_part_nx = mm_i1_ctrl[158] ? fpu_fmis_result[FLEN - 1:32] : mm_dp_frd2_high_part;
        assign wb_dp_frd1_high_part_nx = lx_i0_ctrl[138] ? fpu_fmac32_result[FLEN - 1:32] : lx_i0_ctrl[137] ? fpu_nan_load_data_64b[FLEN - 1:32] : lx_dp_frd1_high_part;
        assign wb_dp_frd2_high_part_nx = lx_i1_ctrl[138] ? fpu_fmac32_result[FLEN - 1:32] : lx_i1_ctrl[137] ? fpu_nan_load_data_64b[FLEN - 1:32] : lx_dp_frd2_high_part;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                mm_dp_frd1_high_part_reg <= 32'b0;
                mm_dp_frd2_high_part_reg <= 32'b0;
            end
            else if (mm_ctrl_en) begin
                mm_dp_frd1_high_part_reg <= mm_dp_frd1_high_part_nx;
                mm_dp_frd2_high_part_reg <= mm_dp_frd2_high_part_nx;
            end
        end

        assign mm_dp_frd1_high_part = mm_dp_frd1_high_part_reg;
        assign mm_dp_frd2_high_part = mm_dp_frd2_high_part_reg;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                lx_dp_frd1_high_part_reg <= 32'b0;
                lx_dp_frd2_high_part_reg <= 32'b0;
            end
            else if (lx_ctrl_en) begin
                lx_dp_frd1_high_part_reg <= lx_dp_frd1_high_part_nx;
                lx_dp_frd2_high_part_reg <= lx_dp_frd2_high_part_nx;
            end
        end

        assign lx_dp_frd1_high_part = lx_dp_frd1_high_part_reg;
        assign lx_dp_frd2_high_part = lx_dp_frd2_high_part_reg;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                wb_dp_frd1_high_part_reg <= 32'b0;
                wb_dp_frd2_high_part_reg <= 32'b0;
            end
            else if (wb_ctrl_en) begin
                wb_dp_frd1_high_part_reg <= wb_dp_frd1_high_part_nx;
                wb_dp_frd2_high_part_reg <= wb_dp_frd2_high_part_nx;
            end
        end

        assign wb_dp_frd1_high_part = wb_dp_frd1_high_part_reg;
        assign wb_dp_frd2_high_part = wb_dp_frd2_high_part_reg;
        assign mm_rd1_byapss_ii_high_part = mm_dp_frd1_high_part;
        assign mm_rd2_byapss_ii_high_part = mm_dp_frd2_high_part;
        assign lx_rd1_byapss_ii_high_part = lx_i0_ctrl[137] ? fpu_nan_load_data_64b[FLEN - 1:32] : lx_dp_frd1_high_part;
        assign lx_rd2_byapss_ii_high_part = lx_i1_ctrl[137] ? fpu_nan_load_data_64b[FLEN - 1:32] : lx_dp_frd2_high_part;
        assign wb_rd1_byapss_ii_high_part = wb_dp_frd1_high_part;
        assign wb_rd2_byapss_ii_high_part = wb_dp_frd2_high_part;
        assign ii_rs1_bypass_high_part = ({32{ii_i0_frs_bypass[3]}} & mm_rd1_byapss_ii_high_part) | ({32{ii_i0_frs_bypass[4]}} & mm_rd2_byapss_ii_high_part) | ({32{ii_i0_frs_bypass[5]}} & lx_rd1_byapss_ii_high_part) | ({32{ii_i0_frs_bypass[6]}} & lx_rd2_byapss_ii_high_part) | ({32{ii_i0_frs_bypass[7]}} & wb_rd1_byapss_ii_high_part) | ({32{ii_i0_frs_bypass[8]}} & wb_rd2_byapss_ii_high_part);
        assign ii_rs2_bypass_high_part = ({32{ii_i0_frs_bypass[12]}} & mm_rd1_byapss_ii_high_part) | ({32{ii_i0_frs_bypass[13]}} & mm_rd2_byapss_ii_high_part) | ({32{ii_i0_frs_bypass[14]}} & lx_rd1_byapss_ii_high_part) | ({32{ii_i0_frs_bypass[15]}} & lx_rd2_byapss_ii_high_part) | ({32{ii_i0_frs_bypass[16]}} & wb_rd1_byapss_ii_high_part) | ({32{ii_i0_frs_bypass[17]}} & wb_rd2_byapss_ii_high_part);
        assign ii_rs3_bypass_high_part = ({32{ii_i1_frs_bypass[3]}} & mm_rd1_byapss_ii_high_part) | ({32{ii_i1_frs_bypass[4]}} & mm_rd2_byapss_ii_high_part) | ({32{ii_i1_frs_bypass[5]}} & lx_rd1_byapss_ii_high_part) | ({32{ii_i1_frs_bypass[6]}} & lx_rd2_byapss_ii_high_part) | ({32{ii_i1_frs_bypass[7]}} & wb_rd1_byapss_ii_high_part) | ({32{ii_i1_frs_bypass[8]}} & wb_rd2_byapss_ii_high_part);
        assign ii_rs4_bypass_high_part = ({32{ii_i1_frs_bypass[12]}} & mm_rd1_byapss_ii_high_part) | ({32{ii_i1_frs_bypass[13]}} & mm_rd2_byapss_ii_high_part) | ({32{ii_i1_frs_bypass[14]}} & lx_rd1_byapss_ii_high_part) | ({32{ii_i1_frs_bypass[15]}} & lx_rd2_byapss_ii_high_part) | ({32{ii_i1_frs_bypass[16]}} & wb_rd1_byapss_ii_high_part) | ({32{ii_i1_frs_bypass[17]}} & wb_rd2_byapss_ii_high_part);
        assign ii_i1_frs3_bypass_high_part = ({32{ii_i1_frs3_bypass[3]}} & mm_rd1_byapss_ii_high_part) | ({32{ii_i1_frs3_bypass[4]}} & mm_rd2_byapss_ii_high_part) | ({32{ii_i1_frs3_bypass[5]}} & lx_rd1_byapss_ii_high_part) | ({32{ii_i1_frs3_bypass[6]}} & lx_rd2_byapss_ii_high_part) | ({32{ii_i1_frs3_bypass[7]}} & wb_rd1_byapss_ii_high_part) | ({32{ii_i1_frs3_bypass[8]}} & wb_rd2_byapss_ii_high_part);
        assign rs1_frf_rdata = {ii_rs1_bypass_high_part,rs1_rf_rdata_for_fpu};
        assign rs2_frf_rdata = {ii_rs2_bypass_high_part,rs2_rf_rdata_for_fpu};
        assign rs3_frf_rdata = {ii_rs3_bypass_high_part,rs3_rf_rdata_for_fpu};
        assign rs4_frf_rdata = {ii_rs4_bypass_high_part,rs4_rf_rdata_for_fpu};
        assign ii_i1_frs3_frf_rdata = {ii_i1_frs3_bypass_high_part,ii_i1_frs3_rdata_for_fpu};
        assign mm_fstore_wdata = ({FLEN{mm_fstore_wdata_sel[0]}} & {mm_src4_reg,mm_src2_reg}) | ({FLEN{mm_fstore_wdata_sel[1] & mm_i0_ctrl[158]}} & fpu_fmis_result) | ({FLEN{mm_fstore_wdata_sel[1] & mm_i0_ctrl[159]}} & {mm_dp_frd1_high_part,mm_src2_reg}) | ({FLEN{mm_fstore_wdata_sel[2]}} & {lx_dp_frd1_high_part,lx_src2_reg}) | ({FLEN{mm_fstore_wdata_sel[3]}} & {lx_dp_frd2_high_part,lx_src4_reg}) | ({FLEN{mm_fstore_wdata_sel[4]}} & fpu_nan_load_data_64b) | ({FLEN{mm_fstore_wdata_sel[5]}} & fpu_fmac32_result) | ({FLEN{mm_fstore_wdata_sel[6]}} & {wb_dp_frd1_high_part,wb_rd1_wdata_reg[31:0]}) | ({FLEN{mm_fstore_wdata_sel[7]}} & {wb_dp_frd2_high_part,wb_rd2_wdata_reg[31:0]}) | ({FLEN{mm_fstore_wdata_sel[8]}} & fpu_fmac64_result);
    end
    else if (FLEN != 1) begin:gen_dp_higher_part_no
        assign lx_dp_frd1_high_part = 32'b0;
        assign lx_dp_frd2_high_part = 32'b0;
        assign wb_dp_frd1_high_part = 32'b0;
        assign wb_dp_frd2_high_part = 32'b0;
        assign rs1_frf_rdata = rs1_rf_rdata_for_fpu[FLEN - 1:0];
        assign rs2_frf_rdata = rs2_rf_rdata_for_fpu[FLEN - 1:0];
        assign rs3_frf_rdata = rs3_rf_rdata_for_fpu[FLEN - 1:0];
        assign rs4_frf_rdata = rs4_rf_rdata_for_fpu[FLEN - 1:0];
        assign ii_i1_frs3_frf_rdata = ii_i1_frs3_rdata_for_fpu[FLEN - 1:0];
        assign mm_fstore_wdata = ({FLEN{mm_fstore_wdata_sel[0] & mm_i0_ctrl[160]}} & mm_src2_reg[FLEN - 1:0]) | ({FLEN{mm_fstore_wdata_sel[0] & mm_i1_ctrl[160] & mm_i1_valid}} & mm_src4_reg[FLEN - 1:0]) | ({FLEN{mm_fstore_wdata_sel[1] & mm_i0_ctrl[158]}} & fpu_fmis_result[FLEN - 1:0]) | ({FLEN{mm_fstore_wdata_sel[1] & mm_i0_ctrl[159]}} & mm_src2_reg[FLEN - 1:0]) | ({FLEN{mm_fstore_wdata_sel[2]}} & lx_src2_reg[FLEN - 1:0]) | ({FLEN{mm_fstore_wdata_sel[3]}} & lx_src4_reg[FLEN - 1:0]) | ({FLEN{mm_fstore_wdata_sel[4]}} & fpu_nan_load_data_64b[FLEN - 1:0]) | ({FLEN{mm_fstore_wdata_sel[5]}} & fpu_fmac32_result[FLEN - 1:0]) | ({FLEN{mm_fstore_wdata_sel[6]}} & wb_rd1_wdata_reg[FLEN - 1:0]) | ({FLEN{mm_fstore_wdata_sel[7]}} & wb_rd2_wdata_reg[FLEN - 1:0]) | ({FLEN{mm_fstore_wdata_sel[8]}} & fpu_fmac64_result[FLEN - 1:0]);
    end
    else begin:gen_no_fpu
        assign lx_dp_frd1_high_part = 32'b0;
        assign lx_dp_frd2_high_part = 32'b0;
        assign wb_dp_frd1_high_part = 32'b0;
        assign wb_dp_frd2_high_part = 32'b0;
        assign rs1_frf_rdata = 1'b0;
        assign rs2_frf_rdata = 1'b0;
        assign rs3_frf_rdata = 1'b0;
        assign rs4_frf_rdata = 1'b0;
        assign mm_fstore_wdata = 1'b0;
        assign ii_i1_frs3_frf_rdata = 1'b0;
    end
endgenerate
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        lx_fstore_wdata <= {FLEN{1'b0}};
    end
    else if (lx_fstore_wdata_en) begin
        lx_fstore_wdata <= mm_fstore_wdata;
    end
end

kv_zero_ext #(
    .OW(64),
    .IW(FLEN)
) u_lx_fstore_wdata_zext (
    .out(lx_fstore_wdata_zext),
    .in(lx_fstore_wdata)
);
assign mm_fstore_wdata_sel = mm_i0_ctrl[138 +:9];
assign ls_cmt_wdata_sel_vpu = (lx_doable[0] & lx_i0_ctrl[142]) | (lx_doable[1] & lx_i1_ctrl[142]);
assign ls_cmt_wdata_vpu = lx_fstore_wdata_zext;
assign fpu_i0_ctrl[0 +:6] = ii_i0_ctrl[123 +:6];
assign fpu_i0_ctrl[6] = ii_i0_ctrl[172];
assign fpu_i0_ctrl[12] = ii_i0_ctrl[174] | ii_i0_ctrl[175];
assign fpu_i0_ctrl[13] = ii_i0_ctrl[176];
assign fpu_i0_ctrl[14] = ii_i0_ctrl[177];
assign fpu_i0_ctrl[15 +:3] = ii_i0_ctrl[137 +:3];
assign fpu_i0_ctrl[18 +:3] = ii_i0_ctrl[159 +:3];
assign fpu_i0_ctrl[21] = ii_i0_ctrl[162];
assign fpu_i0_ctrl[7 +:5] = ii_i0_ctrl[131 +:5];
assign fpu_i0_valid = ii_doable[0] & ~ii_i0_stall & ~ii_i0_pred_info[6] & (ii_i0_ctrl[176] | ii_i0_ctrl[174] | ii_i0_ctrl[175] | ii_i0_ctrl[172] | ii_i0_ctrl[177]);
assign ii_i0_fpu_inst = ii_valid[0] & (ii_i0_ctrl[176] | ii_i0_ctrl[174] | ii_i0_ctrl[175] | ii_i0_ctrl[172] | ii_i0_ctrl[177] | ii_i0_ctrl[173] | ii_i0_ctrl[178]);
assign ii_i1_fpu_inst = ii_valid[1] & (ii_i1_ctrl[176] | ii_i1_ctrl[174] | ii_i1_ctrl[175] | ii_i1_ctrl[172] | ii_i1_ctrl[177] | ii_i1_ctrl[173] | ii_i1_ctrl[178]);
generate
    if (1'b1 && (FLEN == 64)) begin:gen_i0_frs1_rv32_dp
        assign fpu_i0_frs1 = ({64{ii_i0_frs1_src_sel[0]}} & frf_rdata1) | ({64{ii_i0_frs1_src_sel[1]}} & fpu_fmac32_result) | ({64{ii_i0_frs1_src_sel[2]}} & fpu_fmac64_result) | ({64{ii_i0_frs1_src_sel[3]}} & fpu_fmis_result) | ({64{ii_i0_frs1_src_sel[4]}} & rs1_frf_rdata) | ({64{ii_i0_frs1_src_sel[5]}} & fdiv_resp_result) | ({64{ii_i0_frs1_src_sel[6]}} & fpu_fmv_result);
    end
    else if ((FLEN == 32) && 1'b1) begin:gen_i0_frs1_rv32_sp
        assign fpu_i0_frs1 = ({64{ii_i0_frs1_src_sel[0]}} & {32'hffffffff,frf_rdata1[FLEN - 1:0]}) | ({64{ii_i0_frs1_src_sel[1]}} & {32'hffffffff,fpu_fmac32_result[FLEN - 1:0]}) | ({64{ii_i0_frs1_src_sel[2]}} & {32'hffffffff,fpu_fmac64_result[FLEN - 1:0]}) | ({64{ii_i0_frs1_src_sel[3]}} & fpu_fmis_result) | ({64{ii_i0_frs1_src_sel[4]}} & {32'hffffffff,rs1_frf_rdata}) | ({64{ii_i0_frs1_src_sel[5]}} & {32'hffffffff,fdiv_resp_result[FLEN - 1:0]}) | ({64{ii_i0_frs1_src_sel[6]}} & fpu_fmv_result);
    end
    else if (FLEN == 32) begin:gen_i0_frs1_rv64_sp
        assign fpu_i0_frs1 = ({64{ii_i0_frs1_src_sel[0]}} & {32'hffffffff,frf_rdata1[FLEN - 1:0]}) | ({64{ii_i0_frs1_src_sel[1]}} & {32'hffffffff,fpu_fmac32_result[FLEN - 1:0]}) | ({64{ii_i0_frs1_src_sel[2]}} & {32'hffffffff,fpu_fmac64_result[FLEN - 1:0]}) | ({64{ii_i0_frs1_src_sel[3]}} & fpu_fmis_result) | ({64{ii_i0_frs1_src_sel[4]}} & rs1_rf_rdata_for_fpu) | ({64{ii_i0_frs1_src_sel[5]}} & {32'hffffffff,fdiv_resp_result[FLEN - 1:0]}) | ({64{ii_i0_frs1_src_sel[6]}} & fpu_fmv_result);
    end
    else begin:gen_i0_frs1_no_fpu
        assign fpu_i0_frs1 = 64'b0;
    end
endgenerate
wire [6:0] fpu_i0_frs1_sel = {{ii_i0_frs1_src_sel[0]},{ii_i0_frs1_src_sel[1]},{ii_i0_frs1_src_sel[2]},{ii_i0_frs1_src_sel[3]},{{ii_i0_frs1_src_sel[4]} & (ii_i0_bypass[0] | (|ii_i0_bypass[8:3]))},{ii_i0_frs1_src_sel[5]},{ii_i0_frs1_src_sel[6]}};
wire ii_i0_fmac = ii_i0_ctrl[174] | ii_i0_ctrl[175];
wire ii_i0_fmac_3_read = ii_i0_fmac & ii_i0_ctrl[158];
wire ii_i1_fmac = ii_i1_ctrl[174] | ii_i1_ctrl[175];
wire ii_i1_fmac_3_read = ii_i1_fmac & ii_i1_ctrl[158];
wire [63:0] ii_i0_const_1s;
wire [63:0] ii_i1_const_1s;
wire ii_i0_fmul = ii_i0_fmac & (fpu_i0_ctrl[2:0] == 3'b110);
wire ii_i1_fmul = ii_i1_fmac & (fpu_i1_ctrl[2:0] == 3'b110);
wire fpu_i0_rs3_sel_fmac32;
wire fpu_i0_rs3_sel_fmac64;
wire fpu_i0_rs3_sel_fmis;
wire fpu_i0_rs3_sel_fdiv;
wire fpu_i0_rs3_sel_fmv;
wire fpu_i1_rs3_sel_fmac32;
wire fpu_i1_rs3_sel_fmac64;
wire fpu_i1_rs3_sel_fmis;
wire fpu_i1_rs3_sel_fdiv;
wire fpu_i1_rs3_sel_fmv;
wire [2:0] ii_i0_sew;
wire [2:0] ii_i1_sew;
assign ii_i0_sew = ii_i0_ctrl[159 +:3];
assign ii_i1_sew = ii_i1_ctrl[159 +:3];
assign ii_i0_const_1s = ii_i0_sew[2] ? 64'h3ff0000000000000 : ii_i0_sew[1] ? 64'hffffffff3f800000 : 64'hffffffffffff3c00;
assign ii_i1_const_1s = ii_i1_sew[2] ? 64'h3ff0000000000000 : ii_i1_sew[1] ? 64'hffffffff3f800000 : 64'hffffffffffff3c00;
assign fpu_i0_frs2 = ({FLEN{ii_i0_frs2_src_sel[0] & (ii_i0_fmac_3_read | ii_i0_fmul | ~ii_i0_fmac)}} & frf_rdata2[FLEN - 1:0]) | ({FLEN{ii_i0_frs2_src_sel[1] & (ii_i0_fmac_3_read | ii_i0_fmul | ~ii_i0_fmac)}} & fpu_fmac32_result[FLEN - 1:0]) | ({FLEN{ii_i0_frs2_src_sel[2] & (ii_i0_fmac_3_read | ii_i0_fmul | ~ii_i0_fmac)}} & fpu_fmac64_result[FLEN - 1:0]) | ({FLEN{ii_i0_frs2_src_sel[3] & (ii_i0_fmac_3_read | ii_i0_fmul | ~ii_i0_fmac)}} & fpu_fmis_result[FLEN - 1:0]) | ({FLEN{ii_i0_frs2_src_sel[4] & (ii_i0_fmac_3_read | ii_i0_fmul | ~ii_i0_fmac)}} & rs2_frf_rdata[FLEN - 1:0]) | ({FLEN{ii_i0_frs2_src_sel[5] & (ii_i0_fmac_3_read | ii_i0_fmul | ~ii_i0_fmac)}} & fdiv_resp_result[FLEN - 1:0]) | ({FLEN{ii_i0_frs2_src_sel[6] & (ii_i0_fmac_3_read | ii_i0_fmul | ~ii_i0_fmac)}} & fpu_fmv_result[FLEN - 1:0]) | ({FLEN{~ii_i0_fmac_3_read & ii_i0_fmac & ~ii_i0_fmul}} & ii_i0_const_1s[FLEN - 1:0]);
assign fpu_i0_rs3_sel_fmac32 = (ii_i0_frs3_src_sel[1] & ii_i0_fmac_3_read & ~ii_i0_fmul) | (ii_i0_frs2_src_sel[1] & ~ii_i0_fmac_3_read & ~ii_i0_fmul);
assign fpu_i0_rs3_sel_fmac64 = (ii_i0_frs3_src_sel[2] & ii_i0_fmac_3_read & ~ii_i0_fmul) | (ii_i0_frs2_src_sel[2] & ~ii_i0_fmac_3_read & ~ii_i0_fmul);
assign fpu_i0_rs3_sel_fmis = (ii_i0_frs3_src_sel[3] & ii_i0_fmac_3_read & ~ii_i0_fmul) | (ii_i0_frs2_src_sel[3] & ~ii_i0_fmac_3_read & ~ii_i0_fmul);
assign fpu_i0_rs3_sel_fdiv = (ii_i0_frs3_src_sel[5] & ii_i0_fmac_3_read & ~ii_i0_fmul) | (ii_i0_frs2_src_sel[5] & ~ii_i0_fmac_3_read & ~ii_i0_fmul);
assign fpu_i0_rs3_sel_fmv = (ii_i0_frs3_src_sel[6] & ii_i0_fmac_3_read & ~ii_i0_fmul) | (ii_i0_frs2_src_sel[6] & ~ii_i0_fmac_3_read & ~ii_i0_fmul);
assign fpu_i0_frs3 = ({FLEN{ii_i0_frs3_src_sel[0] & ii_i0_fmac_3_read & ~ii_i0_fmul}} & frf_rdata3[FLEN - 1:0]) | ({FLEN{ii_i0_frs2_src_sel[0] & ~ii_i0_fmac_3_read & ~ii_i0_fmul}} & frf_rdata2[FLEN - 1:0]) | ({FLEN{ii_i0_frs3_src_sel[4] & ii_i0_fmac_3_read & ~ii_i0_fmul}} & rs3_frf_rdata[FLEN - 1:0]) | ({FLEN{ii_i0_frs2_src_sel[4] & ~ii_i0_fmac_3_read & ~ii_i0_fmul}} & rs2_frf_rdata[FLEN - 1:0]) | ({FLEN{fpu_i0_rs3_sel_fmac32}} & fpu_fmac32_result[FLEN - 1:0]) | ({FLEN{fpu_i0_rs3_sel_fmac64}} & fpu_fmac64_result[FLEN - 1:0]) | ({FLEN{fpu_i0_rs3_sel_fmis}} & fpu_fmis_result[FLEN - 1:0]) | ({FLEN{fpu_i0_rs3_sel_fdiv}} & fdiv_resp_result[FLEN - 1:0]) | ({FLEN{fpu_i0_rs3_sel_fmv}} & fpu_fmv_result[FLEN - 1:0]);
assign fpu_i1_ctrl[0 +:6] = ii_i1_ctrl[123 +:6];
assign fpu_i1_ctrl[6] = ii_i1_ctrl[172];
assign fpu_i1_ctrl[12] = ii_i1_ctrl[174] | ii_i1_ctrl[175];
assign fpu_i1_ctrl[13] = ii_i1_ctrl[176];
assign fpu_i1_ctrl[14] = ii_i1_ctrl[177];
assign fpu_i1_ctrl[15 +:3] = ii_i1_ctrl[137 +:3];
assign fpu_i1_ctrl[18 +:3] = ii_i1_ctrl[159 +:3];
assign fpu_i1_ctrl[21] = ii_i1_ctrl[162];
assign fpu_i1_ctrl[7 +:5] = ii_i1_ctrl[131 +:5];
assign fpu_i1_valid = ii_doable[1] & ~ii_i1_stall & ~ii_i0_pred_info[6] & ~ii_i1_pred_info[6] & (ii_i1_ctrl[176] | ii_i1_ctrl[174] | ii_i1_ctrl[175] | ii_i1_ctrl[172] | ii_i1_ctrl[177]);
generate
    if (1'b1 && (FLEN == 64)) begin:gen_i1_frs1_rv32_dp
        assign fpu_i1_frs1 = ({64{ii_i1_frs1_src_sel[0]}} & frf_rdata3) | ({64{ii_i1_frs1_src_sel[1]}} & fpu_fmac32_result) | ({64{ii_i1_frs1_src_sel[2]}} & fpu_fmac64_result) | ({64{ii_i1_frs1_src_sel[3]}} & fpu_fmis_result) | ({64{ii_i1_frs1_src_sel[4]}} & rs3_frf_rdata) | ({64{ii_i1_frs1_src_sel[5]}} & fdiv_resp_result) | ({64{ii_i1_frs1_src_sel[6]}} & fpu_fmv_result);
    end
    else if ((FLEN == 32) && 1'b1) begin:gen_i1_frs1_rv32_sp
        assign fpu_i1_frs1 = ({64{ii_i1_frs1_src_sel[0]}} & {32'hffffffff,frf_rdata3[FLEN - 1:0]}) | ({64{ii_i1_frs1_src_sel[1]}} & {32'hffffffff,fpu_fmac32_result[FLEN - 1:0]}) | ({64{ii_i1_frs1_src_sel[2]}} & {32'hffffffff,fpu_fmac64_result[FLEN - 1:0]}) | ({64{ii_i1_frs1_src_sel[3]}} & fpu_fmis_result) | ({64{ii_i1_frs1_src_sel[4]}} & {32'hffffffff,rs3_frf_rdata[FLEN - 1:0]}) | ({64{ii_i1_frs1_src_sel[5]}} & {32'hffffffff,fdiv_resp_result[FLEN - 1:0]}) | ({64{ii_i1_frs1_src_sel[6]}} & fpu_fmv_result);
    end
    else if (FLEN == 32) begin:gen_i1_frs1_rv64_sp
        assign fpu_i1_frs1 = ({64{ii_i1_frs1_src_sel[0]}} & {32'hffffffff,frf_rdata3[FLEN - 1:0]}) | ({64{ii_i1_frs1_src_sel[1]}} & {32'hffffffff,fpu_fmac32_result[FLEN - 1:0]}) | ({64{ii_i1_frs1_src_sel[2]}} & {32'hffffffff,fpu_fmac64_result[FLEN - 1:0]}) | ({64{ii_i1_frs1_src_sel[3]}} & fpu_fmis_result) | ({64{ii_i1_frs1_src_sel[4]}} & rs3_rf_rdata_for_fpu) | ({64{ii_i1_frs1_src_sel[5]}} & {32'hffffffff,fdiv_resp_result[FLEN - 1:0]}) | ({64{ii_i1_frs1_src_sel[6]}} & fpu_fmv_result);
    end
    else begin:gen_i1_frs1_no_fpu
        assign fpu_i1_frs1 = 64'b0;
    end
endgenerate
assign fpu_i1_frs2 = ({FLEN{ii_i1_frs2_src_sel[0] & (ii_i1_fmac_3_read | ~ii_i1_fmac | ii_i1_fmul)}} & frf_rdata4[FLEN - 1:0]) | ({FLEN{ii_i1_frs2_src_sel[1] & (ii_i1_fmac_3_read | ~ii_i1_fmac | ii_i1_fmul)}} & fpu_fmac32_result[FLEN - 1:0]) | ({FLEN{ii_i1_frs2_src_sel[2] & (ii_i1_fmac_3_read | ~ii_i1_fmac | ii_i1_fmul)}} & fpu_fmac64_result[FLEN - 1:0]) | ({FLEN{ii_i1_frs2_src_sel[3] & (ii_i1_fmac_3_read | ~ii_i1_fmac | ii_i1_fmul)}} & fpu_fmis_result[FLEN - 1:0]) | ({FLEN{ii_i1_frs2_src_sel[4] & (ii_i1_fmac_3_read | ~ii_i1_fmac | ii_i1_fmul)}} & rs4_frf_rdata[FLEN - 1:0]) | ({FLEN{ii_i1_frs2_src_sel[5] & (ii_i1_fmac_3_read | ~ii_i1_fmac | ii_i1_fmul)}} & fdiv_resp_result[FLEN - 1:0]) | ({FLEN{ii_i1_frs2_src_sel[6] & (ii_i1_fmac_3_read | ~ii_i1_fmac | ii_i1_fmul)}} & fpu_fmv_result[FLEN - 1:0]) | ({FLEN{ii_i1_fmac & ~ii_i1_fmul & ~ii_i1_fmac_3_read}} & ii_i1_const_1s[FLEN - 1:0]);
assign fpu_i1_rs3_sel_fmac32 = (ii_i1_frs3_src_sel[1] & ii_i1_fmac_3_read & ~ii_i1_fmul) | (ii_i1_frs2_src_sel[1] & ~ii_i1_fmac_3_read & ~ii_i1_fmul);
assign fpu_i1_rs3_sel_fmac64 = (ii_i1_frs3_src_sel[2] & ii_i1_fmac_3_read & ~ii_i1_fmul) | (ii_i1_frs2_src_sel[2] & ~ii_i1_fmac_3_read & ~ii_i1_fmul);
assign fpu_i1_rs3_sel_fmis = (ii_i1_frs3_src_sel[3] & ii_i1_fmac_3_read & ~ii_i1_fmul) | (ii_i1_frs2_src_sel[3] & ~ii_i1_fmac_3_read & ~ii_i1_fmul);
assign fpu_i1_rs3_sel_fdiv = (ii_i1_frs3_src_sel[5] & ii_i1_fmac_3_read & ~ii_i1_fmul) | (ii_i1_frs2_src_sel[5] & ~ii_i1_fmac_3_read & ~ii_i1_fmul);
assign fpu_i1_rs3_sel_fmv = (ii_i1_frs3_src_sel[6] & ii_i1_fmac_3_read & ~ii_i1_fmul) | (ii_i1_frs2_src_sel[6] & ~ii_i1_fmac_3_read & ~ii_i1_fmul);
assign fpu_i1_frs3 = ({FLEN{ii_i1_frs3_src_sel[0] & ii_i1_fmac_3_read & ~ii_i1_fmul}} & frf_rdata2[FLEN - 1:0]) | ({FLEN{ii_i1_frs2_src_sel[0] & ~ii_i1_fmac_3_read & ~ii_i1_fmul}} & frf_rdata4[FLEN - 1:0]) | ({FLEN{ii_i1_frs3_src_sel[4] & ii_i1_fmac_3_read & ~ii_i1_fmul}} & ii_i1_frs3_frf_rdata[FLEN - 1:0]) | ({FLEN{ii_i1_frs2_src_sel[4] & ~ii_i1_fmac_3_read & ~ii_i1_fmul}} & rs4_frf_rdata[FLEN - 1:0]) | ({FLEN{fpu_i1_rs3_sel_fmac32}} & fpu_fmac32_result[FLEN - 1:0]) | ({FLEN{fpu_i1_rs3_sel_fmac64}} & fpu_fmac64_result[FLEN - 1:0]) | ({FLEN{fpu_i1_rs3_sel_fmis}} & fpu_fmis_result[FLEN - 1:0]) | ({FLEN{fpu_i1_rs3_sel_fdiv}} & fdiv_resp_result[FLEN - 1:0]) | ({FLEN{fpu_i1_rs3_sel_fmv}} & fpu_fmv_result[FLEN - 1:0]);
assign ii_ex_i0_ctrl[174 +:9] = ii_fstore_wdata_sel;
assign ii_ex_i1_ctrl[174 +:9] = 9'b0;
assign ex_mm_i0_ctrl[138 +:9] = ex_i0_ctrl[174 +:9];
assign ex_mm_i1_ctrl[138 +:9] = 9'b0;
assign fdiv_resp_return = fdiv_resp_valid & fdiv_resp_ready;
assign fdiv_resp_ready = ~wb_i1_frf_wr & tb_fdiv_resp_ready;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mm_ls_size <= 2'b0;
    end
    else if (mm_ctrl_en) begin
        mm_ls_size <= ex_ls_size;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        lx_ls_size <= 2'b0;
    end
    else if (lx_ctrl_en) begin
        lx_ls_size <= mm_ls_size;
    end
end

assign nan_boxing_value = {64{1'b1}} << {(4'd1 << lx_ls_size[1:0]),3'd0};
assign fpu_nan_load_data_64b = ls_resp_result_64b | nan_boxing_value;
assign fpu_lx_stall = lx_stall;
assign hart_halted = csr_halt_mode;
generate
    if (VALEN == EXTVALEN) begin:gen_link_result_ze
        kv_zero_ext #(
            .OW(32),
            .IW(EXTVALEN)
        ) u_bru0_link_result (
            .out(bru0_link_result),
            .in(bru0_seq_npc)
        );
        kv_zero_ext #(
            .OW(32),
            .IW(EXTVALEN)
        ) u_bru1_link_result (
            .out(bru1_link_result),
            .in(bru1_seq_npc)
        );
        kv_zero_ext #(
            .OW(32),
            .IW(EXTVALEN)
        ) u_bru2_link_result (
            .out(bru2_link_result),
            .in(bru2_seq_npc)
        );
        kv_zero_ext #(
            .OW(32),
            .IW(EXTVALEN)
        ) u_bru3_link_result (
            .out(bru3_link_result),
            .in(bru3_seq_npc)
        );
    end
    else begin:gen_link_result_se
        kv_sign_ext #(
            .OW(32),
            .IW(EXTVALEN)
        ) u_bru0_link_result (
            .out(bru0_link_result),
            .in(bru0_seq_npc)
        );
        kv_sign_ext #(
            .OW(32),
            .IW(EXTVALEN)
        ) u_bru1_link_result (
            .out(bru1_link_result),
            .in(bru1_seq_npc)
        );
        kv_sign_ext #(
            .OW(32),
            .IW(EXTVALEN)
        ) u_bru2_link_result (
            .out(bru2_link_result),
            .in(bru2_seq_npc)
        );
        kv_sign_ext #(
            .OW(32),
            .IW(EXTVALEN)
        ) u_bru3_link_result (
            .out(bru3_link_result),
            .in(bru3_seq_npc)
        );
    end
endgenerate
wire id_ex9_lookup_fault;
assign ifu_i0_ready = id_ready[0] & ~id_ex9_not_ready & ~id_i0_ex9_ins & id_uinstr_ready;
assign ifu_i1_ready = id_ready[1] & ~id_ex9_not_ready & ~(id_i0_ex9_ins | id_i1_ex9_ins) & ~id_i0_pp_instr & id_uinstr_ready;
kv_sign_ext #(
    .OW(EXTVALEN),
    .IW(VALEN)
) u_ifu_i0_pred_npc_sext (
    .out(id_i0_pred_npc),
    .in(ifu_i0_pred_npc)
);
kv_sign_ext #(
    .OW(EXTVALEN),
    .IW(VALEN)
) u_ifu_i1_pred_npc_sext (
    .out(id_i1_pred_npc),
    .in(ifu_i1_pred_npc)
);
assign id_ex9_lookup_fault = ex9_lookup_resp_valid & ex9_lookup_resp_fault;
assign id_i0_npc = id_ex9_lookup_fault ? ex9_lookup_pc : id_i0_ctrl[317] ? ifu_i0_pc[EXTVALEN - 1:0] : id_i0_pred_npc;
assign id_i1_npc = id_i1_ctrl[317] ? ifu_i1_pc[EXTVALEN - 1:0] : id_i1_pred_npc;
kv_dec #(
    .FLEN(FLEN),
    .VLEN(VLEN),
    .RVA_SUPPORT_INT(RVA_SUPPORT_INT),
    .RVN_SUPPORT_INT(RVN_SUPPORT_INT),
    .DSP_SUPPORT_INT(DSP_SUPPORT_INT),
    .ACE_SUPPORT_INT(ACE_SUPPORT_INT),
    .ISA_GP_INT(ISA_GP_INT),
    .ISA_LEA_INT(ISA_LEA_INT),
    .ISA_BEQC_INT(ISA_BEQC_INT),
    .ISA_BBZ_INT(ISA_BBZ_INT),
    .ISA_BFO_INT(ISA_BFO_INT),
    .ISA_STR_INT(ISA_STR_INT),
    .STACKSAFE_SUPPORT_INT(STACKSAFE_SUPPORT_INT),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .MULTIPLIER_INT(MULTIPLIER_INT)
) u_kv_dec_i0 (
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .csr_mstatus_tw(csr_mstatus_tw),
    .csr_mstatus_tvm(csr_mstatus_tvm),
    .csr_mstatus_tsr(csr_mstatus_tsr),
    .csr_mmisc_ctl_aces(csr_mmisc_ctl_aces),
    .csr_mhsp_ctl_m(csr_mhsp_ctl_m),
    .csr_mhsp_ctl_s(csr_mhsp_ctl_s),
    .csr_mhsp_ctl_u(csr_mhsp_ctl_u),
    .src2_imm(id_i0_imm),
    .id_ctrl(id_i0_ctrl),
    .instr_from_exec_it(id_ex9_lookup_ins),
    .csr_frm(csr_frm),
    .csr_mstatus_fs(csr_mstatus_fs),
    .csr_mmisc_ctl_rvcompm(csr_mmisc_ctl_rvcompm),
    .csr_halt_mode(csr_halt_mode),
    .csr_dcsr_step(csr_dcsr_step),
    .csr_dcsr_ebreakm(csr_dcsr_ebreakm),
    .csr_dcsr_ebreaks(csr_dcsr_ebreaks),
    .csr_dcsr_ebreaku(csr_dcsr_ebreaku),
    .trigm_icount_enabled(trigm_icount_enabled),
    .ifu_vector_resume(ifu_i0_vector_resume),
    .ifu_pred_bogus(ifu_i0_pred_bogus),
    .ifu_pred_hit(ifu_i0_pred_hit),
    .ifu_pred_taken(ifu_i0_pred_taken),
    .ifu_pred_start(ifu_i0_pred_start),
    .ifu_pred_brk(ifu_i0_pred_brk),
    .ifu_fault(ifu_i0_dec_fault),
    .ifu_fault_dcause(ifu_i0_dec_fault_dcause),
    .ifu_ecc_code(ifu_i0_dec_ecc_code),
    .ifu_ecc_corr(ifu_i0_dec_ecc_corr),
    .ifu_ecc_ramid(ifu_i0_dec_ecc_ramid),
    .ifu_page_fault(ifu_i0_dec_page_fault),
    .ifu_fault_upper(ifu_i0_fault_upper),
    .ifu_instr(ifu_i0_dec_instr),
    .ifu_instr_16b(ifu_i0_dec_instr_16b)
);
kv_dec #(
    .FLEN(FLEN),
    .VLEN(VLEN),
    .RVA_SUPPORT_INT(RVA_SUPPORT_INT),
    .RVN_SUPPORT_INT(RVN_SUPPORT_INT),
    .DSP_SUPPORT_INT(DSP_SUPPORT_INT),
    .ACE_SUPPORT_INT(ACE_SUPPORT_INT),
    .ISA_GP_INT(ISA_GP_INT),
    .ISA_LEA_INT(ISA_LEA_INT),
    .ISA_BEQC_INT(ISA_BEQC_INT),
    .ISA_BBZ_INT(ISA_BBZ_INT),
    .ISA_BFO_INT(ISA_BFO_INT),
    .ISA_STR_INT(ISA_STR_INT),
    .STACKSAFE_SUPPORT_INT(STACKSAFE_SUPPORT_INT),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .MULTIPLIER_INT(MULTIPLIER_INT)
) u_kv_dec_i1 (
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .csr_mstatus_tw(csr_mstatus_tw),
    .csr_mstatus_tvm(csr_mstatus_tvm),
    .csr_mstatus_tsr(csr_mstatus_tsr),
    .csr_mmisc_ctl_aces(csr_mmisc_ctl_aces),
    .csr_mhsp_ctl_m(csr_mhsp_ctl_m),
    .csr_mhsp_ctl_s(csr_mhsp_ctl_s),
    .csr_mhsp_ctl_u(csr_mhsp_ctl_u),
    .src2_imm(id_i1_imm),
    .id_ctrl(id_i1_ctrl),
    .instr_from_exec_it(1'b0),
    .csr_frm(csr_frm),
    .csr_mstatus_fs(csr_mstatus_fs),
    .csr_mmisc_ctl_rvcompm(csr_mmisc_ctl_rvcompm),
    .csr_halt_mode(csr_halt_mode),
    .csr_dcsr_step(csr_dcsr_step),
    .csr_dcsr_ebreakm(csr_dcsr_ebreakm),
    .csr_dcsr_ebreaks(csr_dcsr_ebreaks),
    .csr_dcsr_ebreaku(csr_dcsr_ebreaku),
    .trigm_icount_enabled(trigm_icount_enabled),
    .ifu_vector_resume(ifu_i1_vector_resume),
    .ifu_pred_bogus(ifu_i1_pred_bogus),
    .ifu_pred_hit(ifu_i1_pred_hit),
    .ifu_pred_taken(ifu_i1_pred_taken),
    .ifu_pred_start(ifu_i1_pred_start),
    .ifu_pred_brk(ifu_i1_pred_brk),
    .ifu_fault(ifu_i1_dec_fault),
    .ifu_fault_dcause(ifu_i1_dec_fault_dcause),
    .ifu_ecc_code(ifu_i1_dec_ecc_code),
    .ifu_ecc_corr(ifu_i1_dec_ecc_corr),
    .ifu_ecc_ramid(ifu_i1_dec_ecc_ramid),
    .ifu_page_fault(ifu_i1_dec_page_fault),
    .ifu_fault_upper(ifu_i1_fault_upper),
    .ifu_instr(ifu_i1_dec_instr),
    .ifu_instr_16b(ifu_i1_dec_instr_16b)
);
wire [UINS_PCLEN - 1:0] uinstr_redirect_pc;
assign uinstr_redirect_pc = redirect_pc[UINS_PCLEN - 1:0];
kv_uins_ctl #(
    .UINS_PCLEN(UINS_PCLEN),
    .STLB_ECC_TYPE(STLB_ECC_TYPE),
    .STACKSAFE_SUPPORT_INT(STACKSAFE_SUPPORT_INT),
    .ICACHE_SIZE_KB(ICACHE_SIZE_KB),
    .DCACHE_SIZE_KB(DCACHE_SIZE_KB),
    .EXTVALEN(EXTVALEN)
) kv_uins_ctl (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .csr_halt_mode(csr_halt_mode),
    .csr_mcache_ctl_cctl_suen(csr_mcache_ctl_cctl_suen),
    .ifu_valid(ifu_valid),
    .ifu_i0_instr(ifu_i0_dec_instr),
    .ifu_i1_instr(ifu_i1_dec_instr),
    .ifu_i0_pc(ifu_i0_pc),
    .ifu_i1_pc(ifu_i1_pc),
    .id_i0_instr(id_i0_instr),
    .id_i1_instr(id_i1_instr),
    .id_i0_ready(id_ready[0]),
    .id_i1_ready(id_ready[1]),
    .id_i0_alive(id_i0_alive),
    .id_i1_alive(id_i1_alive),
    .id_i0_pc(id_i0_pc),
    .id_i1_pc(id_i1_pc),
    .id_uinstr_pred_info(id_uinstr_pred_info),
    .id_uinstr_pred_npc(id_uinstr_pred_npc),
    .id_uinstr_ctrl(id_uinstr_ctrl),
    .id_uinstr_sel(id_uinstr_sel),
    .id_uinstr_ready(id_uinstr_ready),
    .id_uinstr_imm12(id_uinstr_imm12),
    .id_uinstr_pc(id_uinstr_pc),
    .ifd_kill(ifd_kill),
    .ifd_i0_dec_ctrl(ifd_i0_ctrl),
    .ifd_i1_dec_ctrl(ifd_i1_ctrl),
    .ifd_i0_pred_info(ifd_i0_pred_info),
    .ifd_i1_pred_info(ifd_i1_pred_info),
    .ifd_i0_pred_npc(ifd_i0_pred_npc),
    .ifd_i1_pred_npc(ifd_i1_pred_npc),
    .uinstr_redirect(uinstr_redirect),
    .uinstr_redirect_pc(uinstr_redirect_pc),
    .uinstr_flush(uinstr_flush),
    .uinstr_done(uinstr_done)
);
assign ifd_i0_ctrl = id_i0_ctrl;
assign ifd_i1_ctrl = id_i1_ctrl;
assign ifd_i0_pred_info = id_i0_pred_info;
assign ifd_i1_pred_info = id_i1_pred_info;
assign ifd_i0_pred_npc = id_i0_pred_npc;
assign ifd_i1_pred_npc = id_i1_pred_npc;
assign ifd_kill[0] = (ifu_i0_vector_resume & ~id_i0_ctrl[317]) | (id_ex9_not_ready & ~ex9_lookup_resp_valid) | id_i0_ex9_ins;
assign ifd_kill[1] = ifd_kill[0] | id_i1_ex9_ins | id_ex9_not_ready;
assign ifu_valid[0] = ifu_i0_valid;
assign ifu_valid[1] = ifu_i1_valid;
assign id_retry = ifu_i0_valid & ifu_i0_vector_resume & ~ifu_i0_fault & ~ifu_i0_page_fault & ~((ii_i0_ctrl[130] | ii_i0_ctrl[129] | ii_i0_ctrl[291]) & ii_valid[0]);
generate
    if (EXTVALEN == 32) begin:gen_retry_pc_32
        assign retry_pc = ifu_i0_instr;
    end
    else begin:gen_retry_pc_else
        wire [31:0] retry_pc_vector_base;
        wire [31:0] retry_pc_xlen;
        wire [VALEN - 1:0] retry_pc_next;
        assign retry_pc_vector_base = ({32{cur_privilege_m}} & csr_mtvec) | ({32{cur_privilege_s}} & csr_stvec) | ({32{cur_privilege_u}} & csr_utvec);
        assign retry_pc_xlen = {retry_pc_vector_base[31:32],ifu_i0_instr};
        assign retry_pc_next = retry_pc_xlen[VALEN - 1:0];
        kv_sign_ext #(
            .OW(EXTVALEN),
            .IW(VALEN)
        ) u_retry_pc_sext (
            .out(retry_pc),
            .in(retry_pc_next)
        );
    end
endgenerate
assign retry = id_retry;
wire [31:0] ex9_result_pc;
generate
    if (32 > EXTVALEN) begin:gen_ex9_look_pc
        assign ex9_lookup_pc = ex9_result_pc[EXTVALEN - 1:0];
    end
    else begin:gen_ex9_look_pc_ze
        kv_zero_ext #(
            .OW(EXTVALEN),
            .IW(32)
        ) u_ex9_lookup_pc_ext (
            .out(ex9_lookup_pc),
            .in(ex9_result_pc)
        );
    end
endgenerate
generate
    wire tb_id_i0_ex9_ins;
    wire tb_id_i1_ex9_ins;
    wire [31:0] tb_ex9_result_pc;
    wire tb_ipipe_select_ex9;
    wire id_ex9_abort;
    wire id_ex9_lookup_valid;
    wire id_ex9_lookup_clr;
    wire id_ex9_lookup_en;
    wire id_ex9_lookup_nx;
    wire ex9_lookup_abort;
    wire [11:0] ex9_offset_imm12;
    wire [31:0] ex9_offset;
    reg id_ex9_lookup_ins_reg;
    assign tb_id_i0_ex9_ins = 1'b0;
    assign tb_id_i1_ex9_ins = 1'b0;
    assign tb_ipipe_select_ex9 = 1'b0;
    assign tb_ex9_result_pc = {32{1'b0}};
    assign id_i0_ex9_ins = (id_i0_ctrl[121] | tb_id_i0_ex9_ins) & ~id_ex9_lookup_ins & ~id_ex9_abort;
    assign id_i1_ex9_ins = id_i1_ctrl[121] | tb_id_i1_ex9_ins;
    assign id_ex9_not_ready = id_ex9_lookup_ins & ~(ex9_lookup_resp_valid & ex9_lookup_resp_ready);
    assign id_ex9_abort = ifu_i0_fault | ifu_i0_page_fault | ifu_i0_vector_resume;
    assign ex9_lookup_abort = id_ex9_abort | ((ii_i0_ctrl[130] | ii_i0_ctrl[129] | ii_i0_ctrl[291]) & ii_valid[0]);
    assign id_ex9_lookup_valid = id_i0_ex9_ins & ifu_i0_valid & id_uinstr_ready;
    assign ex9_lookup_valid = id_ex9_lookup_valid & ~ex9_lookup_abort & ~id_ex9_lookup_ins;
    assign ex9_lookup_resp_ready = id_ex9_lookup_ins & id_uinstr_ready;
    assign ex9_offset_imm12 = {ifu_i0_instr[8],(1'b0 ? ifu_i0_instr[7] : ifu_i0_instr[12]),ifu_i0_instr[3],ifu_i0_instr[9],ifu_i0_instr[6:5],ifu_i0_instr[2],ifu_i0_instr[11:10],ifu_i0_instr[4],2'b0};
    assign ex9_offset = {{20{1'b0}},ex9_offset_imm12};
    assign ex9_result_pc = (({csr_uitb[31:2],2'b0}) + ex9_offset) & {32{~tb_id_i0_ex9_ins}} | tb_ex9_result_pc & {32{tb_id_i0_ex9_ins}};
    assign ii_exec_i0_it_jal_base = ii_i0_pc & ({{(EXTVALEN - 21){1'b1}},{21{~ii_i0_ctrl[47]}}});
    assign ii_exec_i1_it_jal_base = ii_i1_pc & ({{(EXTVALEN - 21){1'b1}},{21{~ii_i1_ctrl[47]}}});
    assign ifu_i0_dec_instr = id_ex9_lookup_ins ? ex9_lookup_resp_instr : ifu_i0_instr;
    assign ifu_i0_dec_fault = id_ex9_lookup_ins ? ex9_lookup_resp_fault : ifu_i0_fault;
    assign ifu_i0_dec_page_fault = id_ex9_lookup_ins ? ex9_lookup_resp_page_fault : ifu_i0_page_fault;
    assign ifu_i0_dec_fault_dcause = id_ex9_lookup_ins ? ex9_lookup_resp_fault_dcause : ifu_i0_fault_dcause;
    assign ifu_i0_dec_ecc_code = id_ex9_lookup_ins ? ex9_lookup_resp_ecc_code : ifu_i0_ecc_code;
    assign ifu_i0_dec_ecc_corr = id_ex9_lookup_ins ? ex9_lookup_resp_ecc_corr : ifu_i0_ecc_corr;
    assign ifu_i0_dec_ecc_ramid = id_ex9_lookup_ins ? ex9_lookup_resp_ecc_ramid : ifu_i0_ecc_ramid;
    assign ifu_i0_dec_instr_16b = id_ex9_lookup_ins ? (~tb_ipipe_select_ex9 & (ex9_lookup_resp_instr[1:0] != 2'b11)) : ifu_i0_instr_16b;
    assign ifu_i1_dec_instr = ifu_i1_instr;
    assign ifu_i1_dec_fault = ifu_i1_fault;
    assign ifu_i1_dec_page_fault = ifu_i1_page_fault;
    assign ifu_i1_dec_fault_dcause = ifu_i1_fault_dcause;
    assign ifu_i1_dec_ecc_code = ifu_i1_ecc_code;
    assign ifu_i1_dec_ecc_corr = ifu_i1_ecc_corr;
    assign ifu_i1_dec_ecc_ramid = ifu_i1_ecc_ramid;
    assign ifu_i1_dec_instr_16b = ifu_i1_instr_16b;
    assign id_ex9_lookup_clr = redirect | resume | (ex9_lookup_resp_ready & ex9_lookup_resp_valid);
    assign id_ex9_lookup_en = ex9_lookup_ready & ~id_ex9_lookup_ins | id_ex9_lookup_clr;
    assign id_ex9_lookup_nx = id_ex9_lookup_valid & ~id_ex9_lookup_clr;
    assign id_ex9_lookup_ins = id_ex9_lookup_ins_reg;
    always @(posedge core_clk or negedge core_reset_n) begin
        if (!core_reset_n) begin
            id_ex9_lookup_ins_reg <= 1'b0;
        end
        else if (id_ex9_lookup_en) begin
            id_ex9_lookup_ins_reg <= id_ex9_lookup_nx;
        end
    end

endgenerate
assign id_i0_pred_info = {ifu_i0_pred_valid,ifu_i0_keep_bhr,ifu_i0_pred_way,ifu_i0_pred_ret,ifu_i0_pred_bogus,ifu_i0_pred_cnt,ifu_i0_pred_taken,ifu_i0_pred_hit};
assign id_i1_pred_info = {ifu_i1_pred_valid,ifu_i1_keep_bhr,ifu_i1_pred_way,ifu_i1_pred_ret,ifu_i1_pred_bogus,ifu_i1_pred_cnt,ifu_i1_pred_taken,ifu_i1_pred_hit};
assign trigm_i0_pc = ii_i0_pc[VALEN - 1:0];
assign trigm_i1_pc = ii_i1_pc[VALEN - 1:0];
wire iiq_flush;
assign ii_alive[0] = ii_valid[0] & ~mm_i0_kill & ~mm_i1_kill & ~wb_kill & ~ii_postsync_replay;
assign ii_alive[1] = ii_valid[1] & ~mm_i0_kill & ~mm_i1_kill & ~wb_kill & ~ii_postsync_replay;
assign ii_doable[0] = ii_alive[0] & ~ii_abort[0];
assign ii_doable[1] = ii_alive[1] & ~ii_abort[1];
assign ii_abort[0] = ii_i0_ctrl[317] | insert_hss | insert_trigger_final[0] | insert_trigger_final[1];
assign ii_abort[1] = ii_i1_ctrl[317];
assign ii_ready[0] = ~(lx_stall | ii_i0_stall);
assign ii_ready[1] = ~(lx_stall | ii_i1_stall);
assign iiq_alive = {id_i1_alive,id_i0_alive};
assign iiq_i0_pc = id_i0_pc;
assign iiq_i1_pc = id_i1_pc;
wire nds_unused_uinstr_pc = |id_uinstr_pc;
assign iiq_i0_uinstr_pc = {(UINS_PCLEN - 2){1'b0}};
assign iiq_i1_uinstr_pc = {(UINS_PCLEN - 2){1'b0}};
assign iiq_i0_npc = id_uinstr_sel ? id_uinstr_pred_npc : id_i0_npc;
assign iiq_i0_imm = id_uinstr_sel ? id_uinstr_imm12 : id_i0_imm;
assign iiq_i0_pred_info = id_uinstr_sel ? id_uinstr_pred_info : id_i0_pred_info;
assign iiq_i0_ctrl = id_uinstr_sel ? id_uinstr_ctrl : id_i0_ctrl;
assign iiq_i0_instr[15:0] = id_i0_instr[15:0];
assign iiq_i0_instr[31:16] = id_i0_instr[31:16] & {16{~(id_uinstr_sel ? id_uinstr_ctrl[249] : ifu_i0_dec_instr_16b)}};
assign iiq_i1_npc = id_i1_npc;
assign iiq_i1_imm = id_i1_imm;
assign iiq_i1_pred_info = id_i1_pred_info;
assign iiq_i1_ctrl = id_i1_ctrl;
assign iiq_i1_instr[15:0] = id_i1_instr[15:0];
assign iiq_i1_instr[31:16] = id_i1_instr[31:16] & {16{~(ifu_i1_dec_instr_16b & ~id_uinstr_sel)}};
kv_iiq_wrap #(
    .IIQ_WIDTH(EXTVALEN + (UINS_PCLEN - 2) + EXTVALEN + 323 + 32 + 32 + 12),
    .FLEN(FLEN),
    .VLEN(VLEN),
    .EXTVALEN(EXTVALEN),
    .UINS_PCLEN(UINS_PCLEN),
    .CTRL_WIDTH(323),
    .PRED_WIDTH(12),
    .RVA_SUPPORT_INT(RVA_SUPPORT_INT),
    .RVN_SUPPORT_INT(RVN_SUPPORT_INT),
    .DSP_SUPPORT_INT(DSP_SUPPORT_INT),
    .ACE_SUPPORT_INT(ACE_SUPPORT_INT),
    .ISA_GP_INT(ISA_GP_INT),
    .ISA_LEA_INT(ISA_LEA_INT),
    .ISA_BEQC_INT(ISA_BEQC_INT),
    .ISA_BBZ_INT(ISA_BBZ_INT),
    .ISA_BFO_INT(ISA_BFO_INT),
    .ISA_STR_INT(ISA_STR_INT),
    .STACKSAFE_SUPPORT_INT(STACKSAFE_SUPPORT_INT),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .MULTIPLIER_INT(MULTIPLIER_INT)
) u_iiq_wrap (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .iiq_flush(iiq_flush),
    .iiq_w_valid(iiq_alive),
    .iiq_w_ready(id_ready),
    .iiq_w_data0({iiq_i0_pc,iiq_i0_uinstr_pc,iiq_i0_npc,iiq_i0_ctrl,iiq_i0_instr,iiq_i0_imm,iiq_i0_pred_info}),
    .iiq_w_data1({iiq_i1_pc,iiq_i1_uinstr_pc,iiq_i1_npc,iiq_i1_ctrl,iiq_i1_instr,iiq_i1_imm,iiq_i1_pred_info}),
    .iiq_r_valid(ii_valid),
    .iiq_r_ready(ii_ready),
    .iiq_r_data0({ii_i0_pc,ii_i0_uinstr_pc,ii_i0_npc,ii_i0_ctrl,ii_i0_instr,ii_i0_imm,ii_i0_pred_info}),
    .iiq_r_data1({ii_i1_pc,ii_i1_uinstr_pc,ii_i1_npc,ii_i1_ctrl,ii_i1_instr,ii_i1_imm,ii_i1_pred_info})
);
assign iiq_flush = mm_redirect_final | wb_redirect | resume;
generate
    if ((32 > EXTVALEN) && (EXTVALEN == VALEN)) begin:gen_extvalen_xlen_zero_extend
        wire [31:0] ii_i0_pc_zext;
        wire [31:0] ii_i1_pc_zext;
        kv_zero_ext #(
            .OW(32),
            .IW(EXTVALEN)
        ) u_ii_i0_pc_zext (
            .out(ii_i0_pc_zext),
            .in(ii_i0_pc)
        );
        kv_zero_ext #(
            .OW(32),
            .IW(EXTVALEN)
        ) u_ii_i1_pc_zext (
            .out(ii_i1_pc_zext),
            .in(ii_i1_pc)
        );
        assign ii_i0_pc_ext = ii_i0_pc_zext;
        assign ii_i1_pc_ext = ii_i1_pc_zext;
    end
    else if ((32 > EXTVALEN) && (EXTVALEN != VALEN)) begin:gen_extvalen_xlen_sign_extend
        wire [31:0] ii_i0_pc_sext;
        wire [31:0] ii_i1_pc_sext;
        kv_sign_ext #(
            .OW(32),
            .IW(EXTVALEN)
        ) u_ii_i0_pc_sext (
            .out(ii_i0_pc_sext),
            .in(ii_i0_pc)
        );
        kv_sign_ext #(
            .OW(32),
            .IW(EXTVALEN)
        ) u_ii_i1_pc_sext (
            .out(ii_i1_pc_sext),
            .in(ii_i1_pc)
        );
        assign ii_i0_pc_ext = ii_i0_pc_sext;
        assign ii_i1_pc_ext = ii_i1_pc_sext;
    end
    else begin:gen_ex_pc_extend_no
        assign ii_i0_pc_ext = ii_i0_pc;
        assign ii_i1_pc_ext = ii_i1_pc;
    end
endgenerate
kv_zero_ext #(
    .OW(EXTVALEN),
    .IW(32)
) u_ii_i0_instr_zext (
    .out(ii_i0_instr_zext),
    .in(ii_i0_instr)
);
kv_zero_ext #(
    .OW(EXTVALEN),
    .IW(32)
) u_ii_11_instr_zext (
    .out(ii_i1_instr_zext),
    .in(ii_i1_instr)
);
kv_csr_dec #(
    .FLEN(FLEN),
    .RVN_SUPPORT_INT(RVN_SUPPORT_INT),
    .DSP_SUPPORT_INT(DSP_SUPPORT_INT),
    .ACE_SUPPORT_INT(ACE_SUPPORT_INT),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .PERFORMANCE_MONITOR_INT(PERFORMANCE_MONITOR_INT),
    .POWERBRAKE_SUPPORT_INT(POWERBRAKE_SUPPORT_INT),
    .STACKSAFE_SUPPORT_INT(STACKSAFE_SUPPORT_INT),
    .CACHE_SUPPORT_INT(CACHE_SUPPORT_INT),
    .ICACHE_ECC_TYPE_INT(ICACHE_ECC_TYPE_INT),
    .ECC_SUPPORT_INT(ECC_SUPPORT_INT),
    .MMISC_CTL_EXIST_INT(MMISC_CTL_EXIST_INT),
    .MMSC_CFG2_EXIST_INT(MMSC_CFG2_EXIST_INT),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .PMA_ENTRIES(PMA_ENTRIES),
    .HAS_VPU_INT(HAS_VPU_INT)
) u_kv_csr_dec (
    .existent_csr(ii_i0_existent_csr),
    .privileged_csr(ii_i0_privileged_csr),
    .privileged_csr_ddcause(ii_i0_privileged_csr_ddcause),
    .readonly_csr(ii_i0_readonly_csr),
    .writeonly_csr(ii_i0_ctrl[87]),
    .func_csr(ii_i0_ctrl[100 +:2]),
    .csr_cur_privilege(csr_cur_privilege),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .csr_halt_mode(csr_halt_mode),
    .csr_mcache_ctl_cctl_suen(csr_mcache_ctl_cctl_suen),
    .csr_mstatus_tvm(csr_mstatus_tvm),
    .csr_mcounteren(csr_mcounteren),
    .csr_mcounterwen(csr_mcounterwen),
    .csr_scounteren(csr_scounteren),
    .csr_ucctlcommand_privileged(1'b0),
    .rd_index(ii_i0_ctrl[255 +:5]),
    .csr_addr(ii_i0_instr[31:20])
);
assign ii_uinstr_star = ii_i0_ctrl[225 +:2] == 2'b10;
assign ii_i0_illegal_csr = (ii_i0_ctrl[168] & ii_i0_privileged_csr) | (ii_i0_ctrl[168] & ~ii_i0_existent_csr) | (ii_i0_ctrl[168] & ii_i0_readonly_csr & ~ii_i0_ctrl[86]) | (ii_i0_ctrl[168] & ii_i0_privileged_csr & ii_uinstr_star) | (ii_i0_ctrl[168] & ~ii_i0_existent_csr & ii_uinstr_star);
assign ii_i0_illegal_csr_ddcause_sub = ~ii_i0_existent_csr ? 3'd2 : ii_i0_privileged_csr_ddcause ? 3'd3 : 3'd4;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        insert_hss <= 1'b0;
    end
    else if (~lx_stall) begin
        insert_hss <= insert_hss_nx;
    end
end

assign ii_uinstr_seg = ii_i0_ctrl[225 +:2];
assign ii_uinstr_star_mid = ~ii_uinstr_seg[0];
assign inster_hss_clr = (wb_i0_ctrl[138] & wb_i0_alive & wb_i0_seg_end) | (wb_i1_ctrl[138] & wb_i1_alive & wb_i1_seg_end) | wb_pp_insert_hss_clr;
assign insert_hss_nx = ~csr_halt_mode & ~inster_hss_clr & (insert_hss | (csr_dcsr_step & ii_alive[0] & ~ii_i0_stall & ~ii_uinstr_star_mid));
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        insert_trigger <= {5{1'b0}};
    end
    else begin
        insert_trigger <= insert_trigger_nx;
    end
end

assign insert_trigger_set = itrigger_fire | etrigger_fire;
assign insert_trigger_clr[0] = resume;
assign insert_trigger_clr[1] = csr_halt_mode;
assign insert_trigger_clr[2] = 1'b1;
assign insert_trigger_clr[3] = 1'b1;
assign insert_trigger_clr[4] = 1'b1;
assign insert_trigger_nx = insert_trigger_set | (insert_trigger & ~insert_trigger_clr);
assign wb_post_stall_rel = mm_i0_kill | mm_i1_kill | wb_kill | (wb_i0_postsync[1] & wb_i0_alive);
kv_iiu #(
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .FLEN(FLEN)
) u_kv_iiu (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .core_wfi_mode(core_wfi_mode),
    .csr_halt_mode(csr_halt_mode),
    .csr_dcsr_step(csr_dcsr_step),
    .csr_mmisc_ctl_nbcache_en(csr_mmisc_ctl_nbcache_en),
    .csr_ls_translate_en(csr_ls_translate_en),
    .throttling_stall(throttling_stall),
    .ii_vpu_vtype_sel(ii_vpu_vtype_sel),
    .ii_viq_size(ii_viq_size),
    .ii_vpu_i0_op1_hazard(ii_vpu_i0_op1_hazard),
    .ii_vpu_i1_op1_hazard(ii_vpu_i1_op1_hazard),
    .ace_resp_rd1(ace_resp_rd1),
    .ace_resp_rd1_valid(ace_resp_rd1_valid),
    .ace_resp_rd2(ace_resp_rd2),
    .ace_resp_rd2_valid(ace_resp_rd2_valid),
    .ace_no_credit_stall(ace_no_credit_stall),
    .ace_sync_req(ace_sync_req),
    .ace_presync_ready(ace_presync_ready),
    .ace_sync_ack(ace_sync_ack),
    .wb_i0_rd1_wen(wb_i0_ctrl[131]),
    .wb_i0_rd2_wen(wb_i0_ctrl[137]),
    .lx_stall(lx_stall),
    .wb_kill(wb_kill),
    .wb_ras_ptr(wb_ras_ptr),
    .wb_i0_doable(wb_i0_doable),
    .wb_i0_abort(wb_i0_abort),
    .wb_i1_doable(wb_i1_doable),
    .wb_i1_abort(wb_i1_abort),
    .wb_i0_nbload(wb_i0_nbload),
    .wb_i1_nbload(wb_i1_nbload),
    .lx_i0_nbload(lx_i0_nbload),
    .lx_i1_nbload(lx_i1_nbload),
    .wb_post_stall_rel(wb_post_stall_rel),
    .mm_i0_kill(mm_i0_kill),
    .mm_i0_ras_ptr(mm_i0_ras_ptr),
    .mm_i1_kill(mm_i1_kill),
    .mm_i1_ras_ptr(mm_i1_ras_ptr),
    .ii_i0_doable(ii_doable[0]),
    .ii_i1_doable(ii_doable[1]),
    .ii_i0_abort(ii_abort[0]),
    .ii_i0_trace_stall(ii_i0_trace_stall),
    .ii_i0_instr(ii_i0_instr),
    .ii_i1_instr(ii_i1_instr),
    .mdu_kill(mdu_kill),
    .mdu_req_ready(mdu_req_ready),
    .mdu_resp_return(mdu_resp_return),
    .mdu_resp_tag(mdu_resp_tag),
    .fdiv_kill(fdiv_kill),
    .fdiv_req_ready(fdiv_req_ready),
    .fdiv_resp_return(fdiv_resp_return),
    .fdiv_resp_tag(fdiv_resp_tag),
    .ls_issue_ready(ls_issue_ready),
    .nbload_resp_valid(nbload_resp_valid),
    .nbload_resp_rd(nbload_resp_rd),
    .vpu_srf_wgrant(vpu_srf_wgrant),
    .vpu_srf_wfrf(vpu_srf_wfrf),
    .vpu_srf_waddr(vpu_srf_waddr),
    .lsu_cctl_req(1'b0),
    .presync_ready(presync_ready),
    .wfi_enabled(wfi_enabled),
    .wfi_done(wfi_done),
    .ii_i0_ctrl(ii_i0_ctrl),
    .ii_i1_ctrl(ii_i1_ctrl),
    .ii_is_calu_pair(ii_is_calu_pair),
    .rs1_ren(rs1_ren),
    .rs2_ren(rs2_ren),
    .rs3_ren(rs3_ren),
    .rs4_ren(rs4_ren),
    .ii_rs1(ii_rs1),
    .ii_rs2(ii_rs2),
    .ii_rs3(ii_rs3),
    .ii_rs4(ii_rs4),
    .ii_ls_base_bypass(ii_ls_base_bypass),
    .ii_ls_func(ii_ls_func),
    .ii_ls_offset(ii_ls_offset),
    .mm_ls_loadb(mm_ls_loadb),
    .ii_mdu_bypass(ii_mdu_bypass),
    .ii_i0_late(ii_i0_late),
    .ii_i1_late(ii_i1_late),
    .ii_i0_bypass(ii_i0_bypass),
    .ii_i1_bypass(ii_i1_bypass),
    .ii_i0_frs_bypass(ii_i0_frs_bypass),
    .ii_i1_frs_bypass(ii_i1_frs_bypass),
    .ii_i1_frs3_bypass(ii_i1_frs3_bypass),
    .ii_i0_xrs_bypass(ii_i0_xrs_bypass),
    .ii_i1_xrs_bypass(ii_i1_xrs_bypass),
    .ii_i1_ex_bypass(ii_i1_ex_bypass),
    .ii_i0_mm_bypass(ii_i0_mm_bypass),
    .ii_i1_mm_bypass(ii_i1_mm_bypass),
    .ii_fstore_wdata_sel(ii_fstore_wdata_sel),
    .ii_i1_lx_bypass(ii_i1_lx_bypass),
    .ii_i0_frs1_src_sel(ii_i0_frs1_src_sel),
    .ii_i0_frs2_src_sel(ii_i0_frs2_src_sel),
    .ii_i0_frs3_src_sel(ii_i0_frs3_src_sel),
    .ii_i1_frs1_src_sel(ii_i1_frs1_src_sel),
    .ii_i1_frs2_src_sel(ii_i1_frs2_src_sel),
    .ii_i1_frs3_src_sel(ii_i1_frs3_src_sel),
    .ii_i0_ex_nbload_hazard(ii_i0_ex_nbload_hazard),
    .ii_i1_ex_nbload_hazard(ii_i1_ex_nbload_hazard),
    .ii_i0_mm_nbload_hazard(ii_i0_mm_nbload_hazard),
    .ii_i1_mm_nbload_hazard(ii_i1_mm_nbload_hazard),
    .ii_i0_ras_ptr(ii_i0_ras_ptr),
    .ii_i1_ras_ptr(ii_i1_ras_ptr),
    .ii_i0_stall(ii_i0_stall),
    .ii_i1_stall(ii_i1_stall),
    .btb_flush_valid(btb_flush_valid),
    .btb_flush_ready(btb_flush_ready),
    .csr_btb_flush(csr_btb_flush),
    .event_xrf_busy(event_xrf_busy)
);
wire [4:0] csr_ziim = ii_i0_ctrl[318 +:5];
wire csr_instr = (ii_i0_instr[6:0] == 7'b1110011) & (ii_i0_instr[13:12] != 2'd0);
assign csr_brpe_clr = ((ii_i0_instr[31:20] == 12'h7d0) & csr_instr & (ii_i0_instr[14:12] == 3'b011) & rf_rdata1[3]) | ((ii_i0_instr[31:20] == 12'h7d0) & csr_instr & (ii_i0_instr[14:12] == 3'b111) & csr_ziim[3]);
assign csr_brpe_wrz = ((ii_i0_instr[31:20] == 12'h7d0) & csr_instr & (ii_i0_instr[14:12] == 3'b001) & ~rf_rdata1[3]) | ((ii_i0_instr[31:20] == 12'h7d0) & csr_instr & (ii_i0_instr[14:12] == 3'b101) & ~csr_ziim[3]);
assign csr_btb_flush = (csr_brpe_clr | csr_brpe_wrz) & ~ii_abort[0];
assign ii_rs1 = ii_i0_ctrl[267 +:5];
assign ii_rs2 = ii_i0_ctrl[273 +:5];
assign ii_rs3 = ii_is_calu_cmv_pair ? ii_i1_ctrl[273 +:5] : ii_i0_ctrl[292] ? ii_i0_ctrl[279 +:5] : ii_i1_ctrl[267 +:5];
assign ii_rs4 = ii_is_calu_pair ? ii_i1_ctrl[255 +:5] : ii_i0_ctrl[292] ? ii_i0_ctrl[285 +:5] : ii_i1_ctrl[273 +:5];
assign rs1_ren = ii_i0_ctrl[272];
assign rs2_ren = ii_i0_ctrl[278];
assign rs3_ren = (ii_i0_ctrl[292] ? ii_i0_ctrl[284] : ii_i1_ctrl[272]) | ii_is_calu_cmv_pair;
assign rs4_ren = (ii_i0_ctrl[292] ? ii_i0_ctrl[290] : ii_i1_ctrl[278]) | ii_is_calu_pair;
assign rf_raddr1 = ii_i0_ctrl[267 +:5];
assign rf_raddr2 = ii_i0_ctrl[273 +:5];
assign rf_raddr3 = ii_rs3;
assign rf_raddr4 = ii_rs4;
assign i0_ll_presync_not_ready = ex_valid[0] & ((ex_i0_ctrl[134] & ~ex_i0_ctrl[90]) | ex_i0_ctrl[131] | ex_i0_ctrl[138] | ex_i0_ctrl[140] | ex_i0_ctrl[141] | ex_i0_ctrl[142] | ex_i0_ctrl[143] | ex_i0_ctrl[139] | ex_i0_ctrl[205] | ex_i0_ctrl[206]);
assign i1_ll_presync_not_ready = ex_valid[1] & ((ex_i1_ctrl[134] & ~ex_i1_ctrl[90]) | ex_i1_ctrl[131] | ex_i1_ctrl[138] | ex_i1_ctrl[140] | ex_i1_ctrl[141] | ex_i1_ctrl[142] | ex_i1_ctrl[143] | ex_i1_ctrl[139] | ex_i1_ctrl[205] | ex_i1_ctrl[206]);
assign ace_presync_ready = ~(|{ex_valid[1:0],mm_valid[1:0],lx_valid[1:0],wb_valid[1:0]}) & ~ace_cmd_valid;
assign presync_ready[0] = fpu_ipipe_standby_ready & (ace_standby_ready & ~ace_cmd_valid) & ~(|{ex_valid[1:0],mm_valid[1:0],lx_valid[1:0],wb_valid[1:0]});
assign presync_ready[1] = (~ii_i0_ctrl[102] & ~(|{ex_valid[1:0]}) & fpu_ipipe_fdiv_standby_ready) | (ii_i0_ctrl[102] & ~(|{i0_ll_presync_not_ready,i1_ll_presync_not_ready}));
assign presync_ready[2] = fpu_ipipe_fdiv_standby_ready;
wire [31:0] ii_i0_dsp_instr;
wire [31:0] ii_i1_dsp_instr;
wire ii_i0_dsp;
wire [31:0] ii_dsp_instr;
wire ii_dsp_src2_sel_imm;
wire ii_dsp_src3_sel_imm;
wire ii_dsp_src4_sel_imm;
wire [31:0] ii_dsp_src2_imm;
wire [31:0] ii_dsp_src3_imm;
wire [31:0] ii_dsp_src4_imm;
wire [DSP_OCTRL_WIDTH - 1:0] ii_dsp_operand_ctrl;
wire [DSP_FCTRL_WIDTH - 1:0] ii_dsp_function_ctrl;
wire [DSP_RCTRL_WIDTH - 1:0] ii_dsp_result_ctrl;
wire ii_dsp_overflow_ctrl;
assign ex_dsp_rd1 = dsp_stage1_result[31:0];
assign mm_dsp_rd1 = dsp_stage2_result[31:0];
assign lx_dsp_rd1 = dsp_stage3_result[31:0];
kv_zero_ext #(
    .OW(32),
    .IW(32)
) u_ex_dsp_rd2 (
    .out(ex_dsp_rd2),
    .in(dsp_stage1_result[63:32])
);
kv_zero_ext #(
    .OW(32),
    .IW(32)
) u_mm_dsp_rd2 (
    .out(mm_dsp_rd2),
    .in(dsp_stage2_result[63:32])
);
kv_zero_ext #(
    .OW(32),
    .IW(32)
) u_lx_dsp_rd2 (
    .out(lx_dsp_rd2),
    .in(dsp_stage3_result[63:32])
);
assign ii_i0_dsp_instr = ii_i0_instr;
assign ii_i1_dsp_instr = ii_i1_instr;
assign ii_i0_dsp = ii_i0_ctrl[169] | ii_i0_ctrl[171] | ii_i0_ctrl[170];
assign ii_dsp_instr = ii_i0_dsp ? ii_i0_dsp_instr : ii_i1_dsp_instr;
generate
    if ((DSP_SUPPORT_INT == 1)) begin:gen_dsp_dec
        kv_dsp_dec u_kv_dsp_dec(
            .instr(ii_dsp_instr),
            .src2_sel_imm(ii_dsp_src2_sel_imm),
            .src3_sel_imm(ii_dsp_src3_sel_imm),
            .src4_sel_imm(ii_dsp_src4_sel_imm),
            .src2_imm(ii_dsp_src2_imm),
            .src3_imm(ii_dsp_src3_imm),
            .src4_imm(ii_dsp_src4_imm),
            .operand_ctrl(ii_dsp_operand_ctrl),
            .function_ctrl(ii_dsp_function_ctrl),
            .result_ctrl(ii_dsp_result_ctrl),
            .overflow_ctrl(ii_dsp_overflow_ctrl)
        );
    end
endgenerate
generate
    if ((DSP_SUPPORT_INT == 0)) begin:gen_dsp_dec_stub
        kv_dsp_dec_stub u_kv_dsp_dec_stub(
            .instr(ii_dsp_instr),
            .src2_sel_imm(ii_dsp_src2_sel_imm),
            .src3_sel_imm(ii_dsp_src3_sel_imm),
            .src4_sel_imm(ii_dsp_src4_sel_imm),
            .src2_imm(ii_dsp_src2_imm),
            .src3_imm(ii_dsp_src3_imm),
            .src4_imm(ii_dsp_src4_imm),
            .operand_ctrl(ii_dsp_operand_ctrl),
            .function_ctrl(ii_dsp_function_ctrl),
            .result_ctrl(ii_dsp_result_ctrl),
            .overflow_ctrl(ii_dsp_overflow_ctrl)
        );
    end
endgenerate
wire ii_rs1_zero = (ii_rs1 == 5'd0);
wire ii_rs2_zero = (ii_rs2 == 5'd0);
wire ii_rs3_zero = (ii_rs3 == 5'd0);
wire ii_rs4_zero = (ii_rs4 == 5'd0);
generate
    if ((DSP_SUPPORT_INT == 1)) begin:gen_dsp_pipe_ctrl
        kv_dsp_pipe_ctrl u_kv_dsp_pipe_ctrl(
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .ii_i0_ctrl(ii_i0_ctrl),
            .ii_i1_ctrl(ii_i1_ctrl),
            .ex_i0_ctrl(ex_i0_ctrl),
            .ex_i1_ctrl(ex_i1_ctrl),
            .mm_i0_ctrl(mm_i0_ctrl),
            .mm_i1_ctrl(mm_i1_ctrl),
            .lx_i0_ctrl(lx_i0_ctrl),
            .lx_i1_ctrl(lx_i1_ctrl),
            .ii_valid(ii_valid),
            .ex_valid(ex_valid),
            .mm_alive(mm_alive),
            .lx_i0_valid(lx_i0_valid),
            .lx_i1_valid(lx_i1_valid),
            .lx_stall(lx_stall),
            .wb_i0_doable(wb_i0_doable),
            .wb_i1_doable(wb_i1_doable),
            .ii_rs1_zero(ii_rs1_zero),
            .ii_rs2_zero(ii_rs2_zero),
            .ii_rs3_zero(ii_rs3_zero),
            .ii_rs4_zero(ii_rs4_zero),
            .ii_dsp_src2_sel_imm(ii_dsp_src2_sel_imm),
            .ii_dsp_src3_sel_imm(ii_dsp_src3_sel_imm),
            .ii_dsp_src4_sel_imm(ii_dsp_src4_sel_imm),
            .ii_dsp_src2_imm(ii_dsp_src2_imm),
            .ii_dsp_src3_imm(ii_dsp_src3_imm),
            .ii_dsp_src4_imm(ii_dsp_src4_imm),
            .ii_dsp_operand_ctrl(ii_dsp_operand_ctrl),
            .ii_dsp_function_ctrl(ii_dsp_function_ctrl),
            .ii_dsp_result_ctrl(ii_dsp_result_ctrl),
            .ii_dsp_overflow_ctrl(ii_dsp_overflow_ctrl),
            .rs1_rf_rdata(rs1_rf_rdata),
            .rs2_rf_rdata(rs2_rf_rdata),
            .rs3_rf_rdata(rs3_rf_rdata),
            .rs4_rf_rdata(rs4_rf_rdata),
            .dsp_instr_valid(dsp_instr_valid),
            .dsp_operand_ctrl(dsp_operand_ctrl),
            .dsp_function_ctrl(dsp_function_ctrl),
            .dsp_result_ctrl(dsp_result_ctrl),
            .dsp_overflow_ctrl(dsp_overflow_ctrl),
            .dsp_data_src1(dsp_data_src1),
            .dsp_data_src2(dsp_data_src2),
            .dsp_data_src3(dsp_data_src3),
            .dsp_data_src4(dsp_data_src4),
            .dsp_stage2_pipe_en(dsp_stage2_pipe_en),
            .dsp_stage3_pipe_en(dsp_stage3_pipe_en),
            .dsp_stage1_ovf_set(dsp_stage1_ovf_set),
            .dsp_stage2_ovf_set(dsp_stage2_ovf_set),
            .dsp_stage3_ovf_set(dsp_stage3_ovf_set),
            .ipipe_csr_ucode_ov_set(ipipe_csr_ucode_ov_set)
        );
    end
endgenerate
generate
    if ((DSP_SUPPORT_INT == 0)) begin:gen_dsp_pipe_ctrl_stub
        kv_dsp_pipe_ctrl_stub u_kv_dsp_pipe_ctrl_stub(
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .ii_i0_ctrl(ii_i0_ctrl),
            .ii_i1_ctrl(ii_i1_ctrl),
            .ex_i0_ctrl(ex_i0_ctrl),
            .ex_i1_ctrl(ex_i1_ctrl),
            .mm_i0_ctrl(mm_i0_ctrl),
            .mm_i1_ctrl(mm_i1_ctrl),
            .lx_i0_ctrl(lx_i0_ctrl),
            .lx_i1_ctrl(lx_i1_ctrl),
            .ii_valid(ii_valid),
            .ex_valid(ex_valid),
            .mm_alive(mm_alive),
            .lx_i0_valid(lx_i0_valid),
            .lx_i1_valid(lx_i1_valid),
            .lx_stall(lx_stall),
            .wb_i0_doable(wb_i0_doable),
            .wb_i1_doable(wb_i1_doable),
            .ii_rs1_zero(ii_rs1_zero),
            .ii_rs2_zero(ii_rs2_zero),
            .ii_rs3_zero(ii_rs3_zero),
            .ii_rs4_zero(ii_rs4_zero),
            .ii_dsp_src2_sel_imm(ii_dsp_src2_sel_imm),
            .ii_dsp_src3_sel_imm(ii_dsp_src3_sel_imm),
            .ii_dsp_src4_sel_imm(ii_dsp_src4_sel_imm),
            .ii_dsp_src2_imm(ii_dsp_src2_imm),
            .ii_dsp_src3_imm(ii_dsp_src3_imm),
            .ii_dsp_src4_imm(ii_dsp_src4_imm),
            .ii_dsp_operand_ctrl(ii_dsp_operand_ctrl),
            .ii_dsp_function_ctrl(ii_dsp_function_ctrl),
            .ii_dsp_result_ctrl(ii_dsp_result_ctrl),
            .ii_dsp_overflow_ctrl(ii_dsp_overflow_ctrl),
            .dsp_instr_valid(dsp_instr_valid),
            .dsp_operand_ctrl(dsp_operand_ctrl),
            .dsp_function_ctrl(dsp_function_ctrl),
            .dsp_result_ctrl(dsp_result_ctrl),
            .dsp_overflow_ctrl(dsp_overflow_ctrl),
            .rs1_rf_rdata(rs1_rf_rdata),
            .rs2_rf_rdata(rs2_rf_rdata),
            .rs3_rf_rdata(rs3_rf_rdata),
            .rs4_rf_rdata(rs4_rf_rdata),
            .dsp_data_src1(dsp_data_src1),
            .dsp_data_src2(dsp_data_src2),
            .dsp_data_src3(dsp_data_src3),
            .dsp_data_src4(dsp_data_src4),
            .dsp_stage2_pipe_en(dsp_stage2_pipe_en),
            .dsp_stage3_pipe_en(dsp_stage3_pipe_en),
            .dsp_stage1_ovf_set(dsp_stage1_ovf_set),
            .dsp_stage2_ovf_set(dsp_stage2_ovf_set),
            .dsp_stage3_ovf_set(dsp_stage3_ovf_set),
            .ipipe_csr_ucode_ov_set(ipipe_csr_ucode_ov_set)
        );
    end
endgenerate
wire [20:0] calu_cond0_offset;
assign calu_cond0_offset = ii_i0_ctrl[49 +:21];
assign ii_i0_size = {18'd0,~ii_i0_ctrl[42],ii_i0_ctrl[42],1'b0};
assign ii_i1_size = {18'd0,~ii_i1_ctrl[42],ii_i1_ctrl[42],1'b0};
assign ii_instrs_size = ii_i0_size + ii_i1_size;
assign ii_is_calu_pair = (ii_i1_ctrl[75] & ii_valid[1] & ~ii_abort[1] & ~ii_i1_pred_info[6] & ~ii_i1_ctrl[292]) & (ii_i0_ctrl[74] & (calu_cond0_offset[3:0] == ii_instrs_size[3:0]) & ~ii_i0_pred_info[0] & ~ii_i0_pred_info[6] & ~ii_i0_ctrl[292]);
assign ii_is_calu_cmv_pair = ii_is_calu_pair & ii_i1_ctrl[167];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        ex_i1_calu_imm <= {32{1'b0}};
    end
    else if (ex_ctrl_en) begin
        ex_i1_calu_imm <= ii_i1_imm;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mm_i1_calu_imm <= {32{1'b0}};
    end
    else if (mm_ctrl_en) begin
        mm_i1_calu_imm <= ex_i1_calu_imm;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        lx_i1_calu_imm <= {32{1'b0}};
    end
    else if (~lx_stall) begin
        lx_i1_calu_imm <= mm_i1_calu_imm;
    end
end

wire rv32d = (FLEN == 64);
wire src2_sel_rf = rs2_ren | ii_i0_ctrl[178];
wire src4_sel_rf = rs4_ren | (rv32d & ii_i0_ctrl[292] & ii_i0_ctrl[178]) | ii_i1_ctrl[178];
wire rs2_from_frf = ii_i0_ctrl[152];
wire rs4_from_frf = (ii_i0_ctrl[178] & rv32d) | (ii_i1_ctrl[178] & ii_valid[1]) & ~ii_i0_ctrl[290];
wire [31:0] frf_rdata_to_rf2_pipe_xlen;
wire [31:0] frf_rdata_to_rf4_pipe_xlen;
wire [31:0] frf_lx_rd1_to_rf4_pipe_xlen;
wire [31:0] frf_wb_rd1_to_rf4_pipe_xlen;
wire [31:0] frf_lx_rd2_to_rf4_pipe_xlen;
wire [31:0] frf_wb_rd2_to_rf4_pipe_xlen;
generate
    if ((FLEN != 1) & (FLEN >= 32)) begin:gen_to_rf2_pipe_flen_beq_xlen
        assign frf_rdata_to_rf2_pipe_xlen = frf_rdata2[31:0];
    end
    else if ((FLEN != 1) & (FLEN < 32)) begin:gen_to_rf2_pipe_flen_lt_xlen
        assign frf_rdata_to_rf2_pipe_xlen = {{(32 - FLEN){1'b0}},frf_rdata2[FLEN - 1:0]};
    end
    else begin:gen_to_rf2_pipe_no_fpu
        assign frf_rdata_to_rf2_pipe_xlen = {32{1'b0}};
    end
endgenerate
generate
    if ((FLEN == 64) & 1'b1) begin:gen_rv32d_to_rf4_pipe
        assign frf_rdata_to_rf4_pipe_xlen = frf_rdata2[63:32];
        assign frf_lx_rd1_to_rf4_pipe_xlen = lx_i0_ctrl[137] ? fpu_nan_load_data_64b[FLEN - 1:32] : lx_dp_frd1_high_part;
        assign frf_lx_rd2_to_rf4_pipe_xlen = lx_i1_ctrl[137] ? fpu_nan_load_data_64b[FLEN - 1:32] : lx_dp_frd2_high_part;
        assign frf_wb_rd1_to_rf4_pipe_xlen = wb_dp_frd1_high_part;
        assign frf_wb_rd2_to_rf4_pipe_xlen = wb_dp_frd2_high_part;
    end
    else if ((FLEN < 32) & (FLEN != 1)) begin:gen_rv64f_to_rf4_pipe
        assign frf_rdata_to_rf4_pipe_xlen = {32'hffffffff,frf_rdata4};
        assign frf_lx_rd1_to_rf4_pipe_xlen = {32{1'b0}};
        assign frf_lx_rd2_to_rf4_pipe_xlen = {32{1'b0}};
        assign frf_wb_rd1_to_rf4_pipe_xlen = {32{1'b0}};
        assign frf_wb_rd2_to_rf4_pipe_xlen = {32{1'b0}};
    end
    else if (FLEN != 1) begin:gen_rv32f_rv64d_to_rf4_pipe
        assign frf_rdata_to_rf4_pipe_xlen = frf_rdata4[31:0];
        assign frf_lx_rd1_to_rf4_pipe_xlen = {32{1'b0}};
        assign frf_lx_rd2_to_rf4_pipe_xlen = {32{1'b0}};
        assign frf_wb_rd1_to_rf4_pipe_xlen = {32{1'b0}};
        assign frf_wb_rd2_to_rf4_pipe_xlen = {32{1'b0}};
    end
    else begin:gen_to_rf4_pipe_no_fpu
        assign frf_rdata_to_rf4_pipe_xlen = {32{1'b0}};
        assign frf_lx_rd1_to_rf4_pipe_xlen = {32{1'b0}};
        assign frf_lx_rd2_to_rf4_pipe_xlen = {32{1'b0}};
        assign frf_wb_rd1_to_rf4_pipe_xlen = {32{1'b0}};
        assign frf_wb_rd2_to_rf4_pipe_xlen = {32{1'b0}};
    end
endgenerate
assign rs1_rf_rdata = ({32{ii_i0_xrs_bypass[0]}} & rf_rdata1) | ({32{ii_i0_xrs_bypass[1]}} & ex_rd1_wdata) | ({32{ii_i0_xrs_bypass[2]}} & ex_rd2_wdata) | ({32{ii_i0_xrs_bypass[3]}} & mm_rd1_wdata) | ({32{ii_i0_xrs_bypass[4]}} & mm_rd2_wdata) | ({32{ii_i0_xrs_bypass[5]}} & lx_rd1_wdata) | ({32{ii_i0_xrs_bypass[6]}} & lx_rd2_wdata) | ({32{ii_i0_xrs_bypass[7]}} & wb_rd1_wdata) | ({32{ii_i0_xrs_bypass[8]}} & wb_rd2_wdata);
assign rs2_rf_rdata = ({32{ii_i0_bypass[9] & ~rs2_from_frf}} & rf_rdata2) | ({32{ii_i0_bypass[9] & rs2_from_frf}} & frf_rdata_to_rf2_pipe_xlen) | ({32{ii_i0_bypass[10]}} & ex_rd1_wdata) | ({32{ii_i0_bypass[11]}} & ex_rd2_wdata) | ({32{ii_i0_bypass[12]}} & mm_rd1_wdata) | ({32{ii_i0_bypass[13]}} & mm_rd2_wdata) | ({32{ii_i0_bypass[14]}} & lx_rd1_wdata) | ({32{ii_i0_bypass[15]}} & lx_rd2_wdata) | ({32{ii_i0_bypass[16]}} & wb_rd1_wdata) | ({32{ii_i0_bypass[17]}} & wb_rd2_wdata);
assign rs3_rf_rdata = ({32{ii_i1_xrs_bypass[0]}} & rf_rdata3) | ({32{ii_i1_xrs_bypass[1]}} & ex_rd1_wdata) | ({32{ii_i1_xrs_bypass[2]}} & ex_rd2_wdata) | ({32{ii_i1_xrs_bypass[3]}} & mm_rd1_wdata) | ({32{ii_i1_xrs_bypass[4]}} & mm_rd2_wdata) | ({32{ii_i1_xrs_bypass[5]}} & lx_rd1_wdata) | ({32{ii_i1_xrs_bypass[6]}} & lx_rd2_wdata) | ({32{ii_i1_xrs_bypass[7]}} & wb_rd1_wdata) | ({32{ii_i1_xrs_bypass[8]}} & wb_rd2_wdata);
assign rs4_rf_rdata = ({32{ii_i1_bypass[9] & ~rs4_from_frf}} & rf_rdata4) | ({32{ii_i0_bypass[9] & rs4_from_frf & rv32d}} & frf_rdata_to_rf4_pipe_xlen) | ({32{ii_i1_bypass[9] & rs4_from_frf & ~rv32d}} & frf_rdata_to_rf4_pipe_xlen) | ({32{ii_i1_bypass[10]}} & ex_rd1_wdata) | ({32{ii_i1_bypass[11]}} & ex_rd2_wdata) | ({32{ii_i1_bypass[12]}} & mm_rd1_wdata) | ({32{ii_i1_bypass[13]}} & mm_rd2_wdata) | ({32{ii_i1_bypass[14] & ~(ii_i0_ctrl[178] & rv32d)}} & lx_rd1_wdata) | ({32{ii_i0_bypass[14] & (ii_i0_ctrl[178] & rv32d)}} & frf_lx_rd1_to_rf4_pipe_xlen) | ({32{ii_i1_bypass[15] & ~(ii_i0_ctrl[178] & rv32d)}} & lx_rd2_wdata) | ({32{ii_i0_bypass[15] & (ii_i0_ctrl[178] & rv32d)}} & frf_lx_rd2_to_rf4_pipe_xlen) | ({32{ii_i1_bypass[16] & ~(ii_i0_ctrl[178] & rv32d)}} & wb_rd1_wdata) | ({32{ii_i0_bypass[16] & (ii_i0_ctrl[178] & rv32d)}} & frf_wb_rd1_to_rf4_pipe_xlen) | ({32{ii_i1_bypass[17] & ~(ii_i0_ctrl[178] & rv32d)}} & wb_rd2_wdata) | ({32{ii_i0_bypass[17] & (ii_i0_ctrl[178] & rv32d)}} & frf_wb_rd2_to_rf4_pipe_xlen);
wire [31:0] ii_exec_i0_it_jal_base_sext;
wire [31:0] ii_exec_i1_it_jal_base_sext;
kv_sign_ext #(
    .OW(32),
    .IW(EXTVALEN)
) u_ii_exec_i0_it_jal_base_sext (
    .out(ii_exec_i0_it_jal_base_sext),
    .in(ii_exec_i0_it_jal_base)
);
kv_sign_ext #(
    .OW(32),
    .IW(EXTVALEN)
) u_ii_exec_i1_it_jal_base_sext (
    .out(ii_exec_i1_it_jal_base_sext),
    .in(ii_exec_i1_it_jal_base)
);
assign ii_src1 = ({32{ii_i0_src1_sel[0]}} & rs1_rf_rdata) | ({32{ii_i0_src1_sel[1]}} & {{27{1'b0}},ii_i0_ctrl[318 +:5]}) | ({32{ii_i0_src1_sel[2]}} & ii_i0_pc_ext) | ({32{ii_i0_src1_sel[3]}} & {DEBUG_VEC[31:12],12'd0}) | ({32{ii_i0_src1_sel[4]}} & ii_exec_i0_it_jal_base_sext) | ({32{ii_i0_src1_sel[5]}} & {32{1'b1}});
assign ii_src2 = src2_sel_rf ? rs2_rf_rdata : ii_i0_imm;
assign ii_src3 = ({32{ii_i1_src1_sel[0]}} & rs3_rf_rdata) | ({32{ii_i1_src1_sel[1]}} & {{27{1'b0}},ii_i1_ctrl[318 +:5]}) | ({32{ii_i1_src1_sel[2]}} & ii_i1_pc_ext) | ({32{ii_i1_src1_sel[3]}} & {DEBUG_VEC[31:12],12'd0}) | ({32{ii_i1_src1_sel[4]}} & ii_exec_i1_it_jal_base_sext) | ({32{ii_i1_src1_sel[5]}} & {32{1'b1}});
assign ii_src4 = (src4_sel_rf | ii_is_calu_pair) ? rs4_rf_rdata : ii_i1_imm;
assign ii_mdu_func = (ii_i0_ctrl[181] | ii_i0_ctrl[182]) ? ii_i0_ctrl[221 +:4] : ii_i1_ctrl[221 +:4];
assign ii_ex_i0_ctrl[79] = ii_is_calu_pair & ~trigm_i1_result[0] & ~trigm_i1_result[1] & ~trigm_i0_result[1];
assign ii_ex_i1_ctrl[79] = 1'b0;
assign ii_postsync_replay = (ex_i0_postsync[0] & ex_i0_valid) | (mm_i0_postsync[0] & mm_i0_valid) | (lx_i0_postsync[0] & lx_i0_valid) | (wb_i0_postsync[0] & wb_i0_valid);
assign ii_ex_i0_ctrl[204] = ii_i0_pred_info[6] | (ii_i0_ctrl[249] & ii_i0_ctrl[44]) | (ii_i0_ctrl[305] & ii_i0_ctrl[44]) | ii_postsync_replay;
assign ii_ex_i1_ctrl[204] = ii_i1_pred_info[6] | (ii_i1_ctrl[249] & ii_i1_ctrl[44]) | (ii_i1_ctrl[305] & ii_i1_ctrl[44]);
assign ii_ex_i0_ctrl[189 +:3] = ii_i0_ras_ptr;
assign ii_ex_i1_ctrl[189 +:3] = ii_i1_ras_ptr;
assign ii_ex_i0_ctrl[75 +:4] = 4'd0;
assign ii_ex_i1_ctrl[75 +:4] = ii_i1_ex_bypass;
assign ii_ex_i0_ctrl[162 +:12] = ii_i0_mm_bypass;
assign ii_ex_i1_ctrl[162 +:12] = ii_i1_mm_bypass;
assign ii_ex_i0_ctrl[156 +:4] = 4'd0;
assign ii_ex_i1_ctrl[156 +:4] = ii_i1_lx_bypass;
assign ii_ex_i0_ctrl[185] = ii_i0_ex_nbload_hazard;
assign ii_ex_i1_ctrl[185] = ii_i1_ex_nbload_hazard;
assign ii_ex_i0_ctrl[183] = ii_i0_mm_nbload_hazard;
assign ii_ex_i1_ctrl[183] = ii_i1_mm_nbload_hazard;
assign ii_ex_i0_ctrl[89] = ii_i0_ctrl[85];
assign ii_ex_i1_ctrl[89] = 1'b0;
assign ii_ex_i0_ctrl[132] = ii_i0_ctrl[164] & ~ii_i0_late;
assign ii_ex_i0_ctrl[146] = ii_i0_ctrl[164] & ii_i0_late;
assign ii_ex_i0_ctrl[133] = ii_i0_ctrl[166] & ~ii_i0_late;
assign ii_ex_i0_ctrl[147] = ii_i0_ctrl[166] & ii_i0_late;
assign ii_ex_i0_ctrl[145] = ii_i0_late;
assign ii_ex_i1_ctrl[132] = ii_i1_ctrl[164] & ~ii_i1_late;
assign ii_ex_i1_ctrl[146] = ii_i1_ctrl[164] & ii_i1_late;
assign ii_ex_i1_ctrl[133] = ii_i1_ctrl[166] & ~ii_i1_late;
assign ii_ex_i1_ctrl[147] = ii_i1_ctrl[166] & ii_i1_late;
assign ii_ex_i1_ctrl[145] = ii_i1_late;
assign ii_ex_i0_ctrl[154] = ii_i0_ctrl[196] | insert_hss | insert_trigger_final[1] | trigm_i0_result[1];
assign ii_ex_i1_ctrl[154] = ii_i1_ctrl[196] | trigm_i1_result[1];
assign ii_ex_i0_ctrl[213] = ii_i0_ctrl[317] | ii_i0_illegal_csr | insert_trigger_final[0] | trigm_i0_result[0];
assign ii_ex_i1_ctrl[213] = ii_i1_ctrl[317] | trigm_i1_result[0];
assign ii_ex_i0_ctrl[210] = trigm_i0_result[2];
assign ii_ex_i1_ctrl[210] = trigm_i1_result[2];
assign ii_ex_i0_ctrl[209] = trigm_i0_result[3];
assign ii_ex_i1_ctrl[209] = trigm_i1_result[3];
assign ii_ex_i0_ctrl[208] = trigm_i0_result[4];
assign ii_ex_i1_ctrl[208] = trigm_i1_result[4];
assign ii_i0_tval = ({EXTVALEN{ii_i0_tval_sel[0]}} & ii_i0_npc) | ({EXTVALEN{ii_i0_tval_sel[1]}} & ii_i0_instr_zext);
assign ii_i1_tval = ({EXTVALEN{ii_i1_tval_sel[0]}} & ii_i1_npc) | ({EXTVALEN{ii_i1_tval_sel[1]}} & ii_i1_instr_zext);
assign ii_i0_val = insert_trigger_final[0] ? ii_i0_pc : trigm_i0_result[0] ? ii_i0_pc : (ii_i0_ctrl[317] | ii_i0_1st_pp_micro) ? ii_i0_tval : ii_i0_illegal_csr ? ii_i0_instr_zext : ii_i0_npc;
assign ii_i1_val = trigm_i1_result[0] ? ii_i1_pc : (ii_i1_ctrl[317] | ii_i1_1st_pp_micro) ? ii_i1_tval : ii_i1_npc;
assign ii_ex_i0_ctrl[80 +:6] = trigm_i0_result[1] ? {3'd0,3'd2} : ii_i0_ctrl[196] ? {3'd0,3'd1} : insert_trigger_final[1] ? {3'd0,3'd2} : insert_hss ? {3'd0,3'd4} : insert_trigger_final[0] ? 6'h3 : trigm_i0_result[0] ? 6'h3 : ii_i0_ctrl[317] ? ii_i0_ctrl[76 +:6] : 6'h2;
assign ii_ex_i1_ctrl[80 +:6] = trigm_i1_result[1] ? {3'd0,3'd2} : trigm_i1_result[0] ? 6'h3 : ii_i1_ctrl[76 +:6];
assign ii_ex_i0_ctrl[86 +:3] = ii_i0_ctrl[317] ? ii_i0_ctrl[82 +:3] : 3'd0;
assign ii_ex_i1_ctrl[86 +:3] = ii_i1_ctrl[317] ? ii_i1_ctrl[82 +:3] : 3'd0;
assign ii_ex_i0_ctrl[105 +:3] = ii_i0_ctrl[317] ? ii_i0_ctrl[103 +:3] : ii_i0_illegal_csr_ddcause_sub;
assign ii_ex_i1_ctrl[105 +:3] = ii_i1_ctrl[103 +:3];
assign ii_ex_i0_ctrl[48] = ii_i0_ctrl[47];
assign ii_ex_i1_ctrl[48] = ii_i1_ctrl[47];
assign ii_ex_i0_ctrl[130] = ii_i0_ctrl[140];
assign ii_ex_i1_ctrl[130] = ii_i1_ctrl[140];
assign ace_cmd_priv = 2'd0;
assign ace_cmd_beat = 32'd0;
assign ace_cmd_vl = {32{1'b0}};
assign ace_cmd_vtype = {32{1'b0}};
assign ace_cmd_hartid = {32{1'b0}};
generate
    if ((ACE_SUPPORT_INT == 1)) begin:gen_ace_on
        wire lx_i0_ace;
        wire lx_i1_ace;
        wire mm_i0_ace;
        wire mm_i1_ace;
        wire ex_i0_ace;
        wire ex_i1_ace;
        wire ii_i0_ace_issue;
        wire ii_i1_ace_issue;
        wire wb_ace_issue;
        reg [2:0] credit_cnt;
        wire [2:0] credit_cnt_nx;
        wire cerdit_cnt_update;
        wire [31:7] lx_ace_q_wr_inst;
        wire [31:0] lx_ace_q_wr_src1;
        wire [31:0] lx_ace_q_wr_src2;
        wire [31:0] lx_ace_q_wr_src3;
        wire [31:0] lx_ace_q_wr_src4;
        wire [VALEN - 1:0] lx_ace_q_wr_pc;
        wire lx_ace_q_wr_valid;
        wire nds_unused_lx_ace_q_wr_ready;
        wire lx_i0_ace_q_wr_valid;
        wire lx_i1_ace_q_wr_valid;
        wire [1:0] lx_i0_postsync;
        assign lx_i0_postsync = lx_i0_ctrl[71 +:2];
        assign lx_i0_ace_q_wr_valid = lx_i0_ace & ~lx_abort[0] & ~wb_kill & ~lx_stall;
        assign lx_i1_ace_q_wr_valid = lx_i1_ace & ~wb_kill & ~lx_abort[0] & ~lx_i0_ls_xcpt & ~lx_i0_ls_replay & ~lx_i0_ls_halt & ~lx_i0_ctrl[107] & ~lx_i0_ctrl[154] & ~lx_i0_ctrl[187] & ~lx_i0_ctrl[191] & ~lx_i0_postsync[0] & ~lx_abort[1] & ~lx_stall;
        assign lx_ace_q_wr_valid = lx_i0_ace_q_wr_valid | lx_i1_ace_q_wr_valid;
        assign lx_ace_q_wr_pc = lx_i0_ace ? lx_i0_pc[VALEN - 1:0] : lx_i1_pc[VALEN - 1:0];
        assign lx_ace_q_wr_inst = lx_i0_ace ? lx_i0_instr[31:7] : lx_i1_instr[31:7];
        assign lx_ace_q_wr_src1 = lx_i0_ace ? lx_src1 : lx_src3;
        assign lx_ace_q_wr_src2 = lx_i0_ace ? lx_src2 : lx_src4;
        assign lx_ace_q_wr_src3 = lx_src3;
        assign lx_ace_q_wr_src4 = lx_src4;
        kv_fifo #(
            .DEPTH(5),
            .WIDTH(128 + VALEN + 25)
        ) u_kv_ace_q (
            .clk(core_clk),
            .reset_n(core_reset_n),
            .flush(1'b0),
            .wdata({lx_ace_q_wr_src4,lx_ace_q_wr_src3,lx_ace_q_wr_src2,lx_ace_q_wr_src1,lx_ace_q_wr_inst[31:7],lx_ace_q_wr_pc}),
            .wvalid(lx_ace_q_wr_valid),
            .wready(nds_unused_lx_ace_q_wr_ready),
            .rdata({ace_cmd_rs4,ace_cmd_rs3,ace_cmd_rs2,ace_cmd_rs1,ace_cmd_inst[31:7],ace_cmd_pc}),
            .rvalid(ace_q_rvalid),
            .rready(ace_q_rready)
        );
        assign ace_cmd_valid = ace_q_rvalid;
        assign ace_q_rready = ace_cmd_ready;
        assign lx_i0_ace = lx_i0_valid & lx_i0_ctrl[130];
        assign lx_i1_ace = lx_i1_valid & lx_i1_ctrl[130];
        assign mm_i0_ace = mm_i0_valid & mm_i0_ctrl[147];
        assign mm_i1_ace = mm_i1_valid & mm_i1_ctrl[147];
        assign ex_i0_ace = ex_i0_valid & ex_i0_ctrl[131];
        assign ex_i1_ace = ex_i1_valid & ex_i1_ctrl[131];
        assign ii_i0_ace_issue = ii_alive[0] & ii_i0_ctrl[163] & ~ii_i0_stall & ~lx_stall;
        assign ii_i1_ace_issue = ii_alive[1] & ii_i1_ctrl[163] & ~ii_i1_stall & ~lx_stall;
        assign wb_ace_issue = ace_q_rvalid & ace_q_rready;
        assign cerdit_cnt_update = ii_i0_ace_issue | ii_i1_ace_issue | ex_i0_ace | ex_i1_ace | mm_i0_ace | mm_i1_ace | lx_i0_ace | lx_i1_ace | wb_ace_issue;
        wire lx_i0_ace_abort = lx_i0_ace & (wb_kill | lx_abort[0]) & ~lx_stall;
        wire lx_i1_ace_abort = (lx_i1_ace & wb_kill & ~lx_stall) | (lx_i1_ace & lx_abort[0] & ~lx_stall) | (lx_i1_ace & lx_i0_ls_xcpt & ~lx_stall) | (lx_i1_ace & lx_i0_ls_replay & ~lx_stall) | (lx_i1_ace & lx_i0_ls_halt & ~lx_stall) | (lx_i1_ace & lx_i0_ctrl[107] & ~lx_stall) | (lx_i1_ace & lx_i0_ctrl[154] & ~lx_stall) | (lx_i1_ace & lx_i0_ctrl[187] & ~lx_stall) | (lx_i1_ace & lx_i0_ctrl[191] & ~lx_stall) | (lx_i1_ace & lx_i0_postsync[0] & ~lx_stall) | (lx_i1_ace & lx_abort[1] & ~lx_stall);
        assign credit_cnt_nx = credit_cnt + {2'b0,(ii_i0_ace_issue | ii_i1_ace_issue) & ~wb_kill & ~(mm_redirect & ~mm_redirect_issued)} - {2'b0,(ex_i0_ace | ex_i1_ace) & (mm_redirect & ~mm_redirect_issued | wb_kill)} - {2'b0,((mm_i0_ace & wb_kill) | (mm_i1_ace & ((mm_i0_kill & ~lx_stall) | wb_kill)))} - {2'b0,(lx_i0_ace_abort | lx_i1_ace_abort)} - {2'b0,wb_ace_issue};
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                credit_cnt <= 3'b0;
            end
            else if (cerdit_cnt_update) begin
                credit_cnt <= credit_cnt_nx;
            end
        end

        assign ace_xrf_rd1_ready = ~mdu_resp_return & ~nbload_resp_valid;
        assign ace_xrf_rd2_ready = ~wb_rf_we2;
        assign ace_resp_rd1_valid = ace_xrf_rd1_ready & ace_xrf_rd1_valid;
        assign ace_resp_rd2_valid = ace_xrf_rd2_ready & ace_xrf_rd2_valid;
        assign ace_resp_rd1 = ace_xrf_rd1_index;
        assign ace_resp_rd2 = ace_xrf_rd2_index;
        assign ace_no_credit_stall = (credit_cnt == 3'b101);
        assign ace_interrupt = async_valid & ~csr_halt_mode;
        assign ace_sync_type = rs1_rf_rdata[31:0];
    end
    else begin:gen_ace_off
        assign ace_resp_rd1 = 5'b0;
        assign ace_resp_rd1_valid = 1'b0;
        assign ace_resp_rd2 = 5'b0;
        assign ace_resp_rd2_valid = 1'b0;
        assign ace_no_credit_stall = 1'b0;
        assign ace_cmd_valid = 1'b0;
        assign ace_cmd_inst[31:7] = {25{1'b0}};
        assign ace_cmd_pc = {VALEN{1'b0}};
        assign ace_cmd_rs1 = {32{1'b0}};
        assign ace_cmd_rs2 = {32{1'b0}};
        assign ace_cmd_rs3 = {32{1'b0}};
        assign ace_cmd_rs4 = {32{1'b0}};
        assign ace_xrf_rd1_ready = 1'b0;
        assign ace_xrf_rd2_ready = 1'b0;
        assign ace_interrupt = 1'b0;
        assign ace_sync_type = {32{1'b0}};
        assign ace_q_rvalid = 1'b0;
        assign ace_q_rready = 1'b0;
        wire nds_unused_ace_signals = |{ace_cmd_ready,ace_xrf_rd1_valid,lx_src3};
    end
endgenerate
assign ii_ex_i0_ctrl[186] = ii_i0_ctrl[249];
assign ii_ex_i0_ctrl[108] = ii_i0_ctrl[106];
assign ii_ex_i0_ctrl[184] = ii_i0_ctrl[227];
assign ii_ex_i0_ctrl[207] = ii_i0_ctrl[301];
assign ii_ex_i0_ctrl[212] = ii_i0_ctrl[308];
assign ii_ex_i0_ctrl[109] = ii_i0_ctrl[107];
assign ii_ex_i0_ctrl[110] = ii_i0_ctrl[108];
assign ii_ex_i0_ctrl[90] = ii_i0_ctrl[86];
assign ii_ex_i0_ctrl[103 +:2] = ii_i0_ctrl[100 +:2];
assign ii_ex_i0_ctrl[91 +:12] = ii_i0_ctrl[88 +:12];
assign ii_ex_i0_ctrl[43] = ii_i0_ctrl[42];
assign ii_ex_i0_ctrl[74] = ii_i0_ctrl[73];
assign ii_ex_i0_ctrl[47] = ii_i0_ctrl[46];
assign ii_ex_i0_ctrl[73] = ii_i0_ctrl[72];
assign ii_ex_i0_ctrl[46] = ii_i0_ctrl[45];
assign ii_ex_i0_ctrl[44] = ii_i0_ctrl[43];
assign ii_ex_i0_ctrl[71 +:2] = ii_i0_ctrl[70 +:2];
assign ii_ex_i0_ctrl[45] = ii_i0_ctrl[44];
assign ii_ex_i0_ctrl[49] = ii_i0_ctrl[48];
assign ii_ex_i0_ctrl[50 +:21] = ii_i0_ctrl[49 +:21];
assign ii_ex_i0_ctrl[188] = ii_i0_ctrl[251];
assign ii_ex_i0_ctrl[187] = ii_i0_ctrl[250];
assign ii_ex_i0_ctrl[155] = ii_i0_ctrl[197];
assign ii_ex_i0_ctrl[2] = ii_i0_ctrl[1];
assign ii_ex_i0_ctrl[3] = ii_i0_ctrl[2];
assign ii_ex_i0_ctrl[4] = ii_i0_ctrl[3];
assign ii_ex_i0_ctrl[13] = ii_i0_ctrl[12];
assign ii_ex_i0_ctrl[14] = ii_i0_ctrl[13];
assign ii_ex_i0_ctrl[20] = ii_i0_ctrl[19];
assign ii_ex_i0_ctrl[24 +:4] = ii_i0_ctrl[23 +:4];
assign ii_ex_i0_ctrl[28] = ii_i0_ctrl[27];
assign ii_ex_i0_ctrl[29] = ii_i0_ctrl[28];
assign ii_ex_i0_ctrl[30] = ii_i0_ctrl[29];
assign ii_ex_i0_ctrl[31] = ii_i0_ctrl[30];
assign ii_ex_i0_ctrl[32] = ii_i0_ctrl[31];
assign ii_ex_i0_ctrl[33] = ii_i0_ctrl[32];
assign ii_ex_i0_ctrl[34] = ii_i0_ctrl[33];
assign ii_ex_i0_ctrl[35] = ii_i0_ctrl[34];
assign ii_ex_i0_ctrl[36] = ii_i0_ctrl[35];
assign ii_ex_i0_ctrl[15] = ii_i0_ctrl[14];
assign ii_ex_i0_ctrl[23] = ii_i0_ctrl[22];
assign ii_ex_i0_ctrl[16] = ii_i0_ctrl[15];
assign ii_ex_i0_ctrl[18] = ii_i0_ctrl[17];
assign ii_ex_i0_ctrl[17] = ii_i0_ctrl[16];
assign ii_ex_i0_ctrl[19] = ii_i0_ctrl[18];
assign ii_ex_i0_ctrl[11] = ii_i0_ctrl[10];
assign ii_ex_i0_ctrl[12] = ii_i0_ctrl[11];
assign ii_ex_i0_ctrl[21] = ii_i0_ctrl[20];
assign ii_ex_i0_ctrl[22] = ii_i0_ctrl[21];
assign ii_ex_i0_ctrl[37] = ii_i0_ctrl[36];
assign ii_ex_i0_ctrl[10] = ii_i0_ctrl[9];
assign ii_ex_i0_ctrl[6] = ii_i0_ctrl[5];
assign ii_ex_i0_ctrl[8] = ii_i0_ctrl[7];
assign ii_ex_i0_ctrl[5] = ii_i0_ctrl[4];
assign ii_ex_i0_ctrl[7] = ii_i0_ctrl[6];
assign ii_ex_i0_ctrl[9] = ii_i0_ctrl[8];
assign ii_ex_i0_ctrl[38 +:5] = ii_i0_ctrl[37 +:5];
assign ii_ex_i0_ctrl[192 +:5] = ii_i0_ctrl[255 +:5];
assign ii_ex_i0_ctrl[197] = ii_i0_ctrl[260];
assign ii_ex_i0_ctrl[198 +:5] = ii_i0_ctrl[261 +:5];
assign ii_ex_i0_ctrl[203] = ii_i0_ctrl[266];
assign ii_ex_i0_ctrl[140] = ii_i0_ctrl[174];
assign ii_ex_i0_ctrl[141] = ii_i0_ctrl[175];
assign ii_ex_i0_ctrl[138] = ii_i0_ctrl[172];
assign ii_ex_i0_ctrl[142] = ii_i0_ctrl[176];
assign ii_ex_i0_ctrl[143] = ii_i0_ctrl[177];
assign ii_ex_i0_ctrl[139] = ii_i0_ctrl[173];
assign ii_ex_i0_ctrl[144] = ii_i0_ctrl[178];
assign ii_ex_i0_ctrl[124 +:5] = ii_i0_ctrl[131 +:5];
assign ii_ex_i0_ctrl[129] = ii_i0_ctrl[136];
assign ii_ex_i0_ctrl[131] = ii_i0_ctrl[163];
assign ii_ex_i0_ctrl[0] = ii_i0_ctrl[0];
assign ii_ex_i0_ctrl[135] = ii_i0_ctrl[169];
assign ii_ex_i0_ctrl[137] = ii_i0_ctrl[171];
assign ii_ex_i0_ctrl[136] = ii_i0_ctrl[170];
assign ii_ex_i0_ctrl[148] = ii_i0_ctrl[179];
assign ii_ex_i0_ctrl[151] = ii_i0_ctrl[183];
assign ii_ex_i0_ctrl[134] = ii_i0_ctrl[168];
assign ii_ex_i0_ctrl[149] = ii_i0_ctrl[181];
assign ii_ex_i0_ctrl[150] = ii_i0_ctrl[182];
assign ii_ex_i0_ctrl[153] = ii_i0_ctrl[194];
assign ii_ex_i0_ctrl[152] = ii_i0_ctrl[193];
assign ii_ex_i0_ctrl[123] = ii_i0_ctrl[122];
assign ii_ex_i0_ctrl[205] = ii_i0_ctrl[293];
assign ii_ex_i0_ctrl[206] = ii_i0_ctrl[294];
assign ii_ex_i0_ctrl[211] = ii_i0_ctrl[306];
assign ii_ex_i0_ctrl[111 +:8] = ii_i0_ctrl[109 +:8];
assign ii_ex_i0_ctrl[119] = ii_i0_ctrl[117];
assign ii_ex_i0_ctrl[120 +:3] = ii_i0_ctrl[118 +:3];
assign ii_ex_i0_ctrl[160 +:2] = ii_i0_ctrl[225 +:2];
assign ii_ex_i1_ctrl[186] = ii_i1_ctrl[249];
assign ii_ex_i1_ctrl[108] = ii_i1_ctrl[106];
assign ii_ex_i1_ctrl[184] = ii_i1_ctrl[227];
assign ii_ex_i1_ctrl[207] = ii_i1_ctrl[301];
assign ii_ex_i1_ctrl[212] = ii_i1_ctrl[308];
assign ii_ex_i1_ctrl[109] = ii_i1_ctrl[107];
assign ii_ex_i1_ctrl[110] = ii_i1_ctrl[108];
assign ii_ex_i1_ctrl[90] = ii_i1_ctrl[86];
assign ii_ex_i1_ctrl[103 +:2] = ii_i1_ctrl[100 +:2];
assign ii_ex_i1_ctrl[91 +:12] = ii_i1_ctrl[88 +:12];
assign ii_ex_i1_ctrl[43] = ii_i1_ctrl[42];
assign ii_ex_i1_ctrl[74] = ii_i1_ctrl[73];
assign ii_ex_i1_ctrl[47] = ii_i1_ctrl[46];
assign ii_ex_i1_ctrl[73] = ii_i1_ctrl[72];
assign ii_ex_i1_ctrl[46] = ii_i1_ctrl[45];
assign ii_ex_i1_ctrl[44] = ii_i1_ctrl[43];
assign ii_ex_i1_ctrl[71 +:2] = ii_i1_ctrl[70 +:2];
assign ii_ex_i1_ctrl[45] = ii_i1_ctrl[44];
assign ii_ex_i1_ctrl[49] = ii_i1_ctrl[48];
assign ii_ex_i1_ctrl[50 +:21] = ii_i1_ctrl[49 +:21];
assign ii_ex_i1_ctrl[188] = ii_i1_ctrl[251];
assign ii_ex_i1_ctrl[187] = ii_i1_ctrl[250];
assign ii_ex_i1_ctrl[155] = ii_i1_ctrl[197];
assign ii_ex_i1_ctrl[2] = ii_i1_ctrl[1];
assign ii_ex_i1_ctrl[3] = ii_i1_ctrl[2];
assign ii_ex_i1_ctrl[4] = ii_i1_ctrl[3];
assign ii_ex_i1_ctrl[13] = ii_i1_ctrl[12];
assign ii_ex_i1_ctrl[14] = ii_i1_ctrl[13];
assign ii_ex_i1_ctrl[20] = ii_i1_ctrl[19];
assign ii_ex_i1_ctrl[24 +:4] = ii_i1_ctrl[23 +:4];
assign ii_ex_i1_ctrl[28] = ii_i1_ctrl[27];
assign ii_ex_i1_ctrl[29] = ii_i1_ctrl[28];
assign ii_ex_i1_ctrl[30] = ii_i1_ctrl[29];
assign ii_ex_i1_ctrl[31] = ii_i1_ctrl[30];
assign ii_ex_i1_ctrl[32] = ii_i1_ctrl[31];
assign ii_ex_i1_ctrl[33] = ii_i1_ctrl[32];
assign ii_ex_i1_ctrl[34] = ii_i1_ctrl[33];
assign ii_ex_i1_ctrl[35] = ii_i1_ctrl[34];
assign ii_ex_i1_ctrl[36] = ii_i1_ctrl[35];
assign ii_ex_i1_ctrl[15] = ii_i1_ctrl[14];
assign ii_ex_i1_ctrl[23] = ii_i1_ctrl[22];
assign ii_ex_i1_ctrl[16] = ii_i1_ctrl[15];
assign ii_ex_i1_ctrl[18] = ii_i1_ctrl[17];
assign ii_ex_i1_ctrl[17] = ii_i1_ctrl[16];
assign ii_ex_i1_ctrl[19] = ii_i1_ctrl[18];
assign ii_ex_i1_ctrl[11] = ii_i1_ctrl[10];
assign ii_ex_i1_ctrl[12] = ii_i1_ctrl[11];
assign ii_ex_i1_ctrl[21] = ii_i1_ctrl[20];
assign ii_ex_i1_ctrl[22] = ii_i1_ctrl[21];
assign ii_ex_i1_ctrl[37] = ii_i1_ctrl[36];
assign ii_ex_i1_ctrl[10] = ii_i1_ctrl[9];
assign ii_ex_i1_ctrl[6] = ii_i1_ctrl[5];
assign ii_ex_i1_ctrl[8] = ii_i1_ctrl[7];
assign ii_ex_i1_ctrl[5] = ii_i1_ctrl[4];
assign ii_ex_i1_ctrl[7] = ii_i1_ctrl[6];
assign ii_ex_i1_ctrl[9] = ii_i1_ctrl[8];
assign ii_ex_i1_ctrl[38 +:5] = ii_i1_ctrl[37 +:5];
assign ii_ex_i1_ctrl[192 +:5] = ii_i1_ctrl[255 +:5];
assign ii_ex_i1_ctrl[197] = ii_i1_ctrl[260];
assign ii_ex_i1_ctrl[198 +:5] = ii_i1_ctrl[261 +:5];
assign ii_ex_i1_ctrl[203] = ii_i1_ctrl[266];
assign ii_ex_i1_ctrl[140] = ii_i1_ctrl[174];
assign ii_ex_i1_ctrl[141] = ii_i1_ctrl[175];
assign ii_ex_i1_ctrl[138] = ii_i1_ctrl[172];
assign ii_ex_i1_ctrl[142] = ii_i1_ctrl[176];
assign ii_ex_i1_ctrl[143] = ii_i1_ctrl[177];
assign ii_ex_i1_ctrl[139] = ii_i1_ctrl[173];
assign ii_ex_i1_ctrl[144] = ii_i1_ctrl[178];
assign ii_ex_i1_ctrl[124 +:5] = ii_i1_ctrl[131 +:5];
assign ii_ex_i1_ctrl[129] = ii_i1_ctrl[136];
assign ii_ex_i1_ctrl[131] = ii_i1_ctrl[163];
assign ii_ex_i1_ctrl[0] = ii_i1_ctrl[0];
assign ii_ex_i1_ctrl[135] = ii_i1_ctrl[169];
assign ii_ex_i1_ctrl[137] = ii_i1_ctrl[171];
assign ii_ex_i1_ctrl[136] = ii_i1_ctrl[170];
assign ii_ex_i1_ctrl[148] = ii_i1_ctrl[179];
assign ii_ex_i1_ctrl[151] = ii_i1_ctrl[183];
assign ii_ex_i1_ctrl[134] = ii_i1_ctrl[168];
assign ii_ex_i1_ctrl[149] = ii_i1_ctrl[181];
assign ii_ex_i1_ctrl[150] = ii_i1_ctrl[182];
assign ii_ex_i1_ctrl[153] = ii_i1_ctrl[194];
assign ii_ex_i1_ctrl[152] = ii_i1_ctrl[193];
assign ii_ex_i1_ctrl[123] = ii_i1_ctrl[122];
assign ii_ex_i1_ctrl[205] = ii_i1_ctrl[293];
assign ii_ex_i1_ctrl[206] = ii_i1_ctrl[294];
assign ii_ex_i1_ctrl[211] = ii_i1_ctrl[306];
assign ii_ex_i1_ctrl[111 +:8] = ii_i1_ctrl[109 +:8];
assign ii_ex_i1_ctrl[119] = ii_i1_ctrl[117];
assign ii_ex_i1_ctrl[120 +:3] = ii_i1_ctrl[118 +:3];
assign ii_ex_i1_ctrl[160 +:2] = ii_i1_ctrl[225 +:2];
assign ii_ex_i0_ctrl[1] = ace_sync_ack_status;
assign ii_ex_i1_ctrl[1] = 1'b0;
assign ii_ex_valid[0] = ii_alive[0] & ~ii_i0_stall;
assign ii_ex_valid[1] = ii_alive[1] & ~ii_i1_stall;
assign ii_vpu_i0_ctrl[5] = ii_i0_ctrl[189];
assign ii_vpu_i0_ctrl[1] = ii_i0_ctrl[185];
assign ii_vpu_i0_ctrl[6] = ii_i0_ctrl[190];
assign ii_vpu_i0_ctrl[2] = ii_i0_ctrl[186];
assign ii_vpu_i0_ctrl[4] = ii_i0_ctrl[188];
assign ii_vpu_i0_ctrl[8] = ii_i0_ctrl[192];
assign ii_vpu_i0_ctrl[3] = ii_i0_ctrl[187];
assign ii_vpu_i0_ctrl[7] = ii_i0_ctrl[191];
assign ii_vpu_i0_ctrl[0] = ii_i0_ctrl[184];
assign ii_vpu_i0_ctrl[9] = ii_i0_ctrl[195];
assign ii_vpu_i0_ctrl[13] = ii_i0_ctrl[311];
assign ii_vpu_i0_ctrl[14] = ii_i0_ctrl[313];
assign ii_vpu_i0_ctrl[15] = ii_i0_ctrl[314];
assign ii_vpu_i0_ctrl[16] = ii_i0_ctrl[315];
assign ii_vpu_i0_ctrl[11] = ii_i0_ctrl[309];
assign ii_vpu_i0_ctrl[12] = ii_i0_ctrl[310];
assign ii_vpu_i1_ctrl[5] = ii_i1_ctrl[189];
assign ii_vpu_i1_ctrl[1] = ii_i1_ctrl[185];
assign ii_vpu_i1_ctrl[6] = ii_i1_ctrl[190];
assign ii_vpu_i1_ctrl[2] = ii_i1_ctrl[186];
assign ii_vpu_i1_ctrl[4] = ii_i1_ctrl[188];
assign ii_vpu_i1_ctrl[8] = ii_i1_ctrl[192];
assign ii_vpu_i1_ctrl[3] = ii_i1_ctrl[187];
assign ii_vpu_i1_ctrl[7] = ii_i1_ctrl[191];
assign ii_vpu_i1_ctrl[0] = ii_i1_ctrl[184];
assign ii_vpu_i1_ctrl[9] = ii_i1_ctrl[195];
assign ii_vpu_i1_ctrl[13] = ii_i1_ctrl[311];
assign ii_vpu_i1_ctrl[14] = ii_i1_ctrl[313];
assign ii_vpu_i1_ctrl[15] = ii_i1_ctrl[314];
assign ii_vpu_i1_ctrl[16] = ii_i1_ctrl[315];
assign ii_vpu_i1_ctrl[11] = ii_i1_ctrl[309];
assign ii_vpu_i1_ctrl[12] = ii_i1_ctrl[310];
assign ii_vpu_i0_ctrl[10] = ii_vpu_i0_op1_hazard;
assign ii_vpu_i1_ctrl[10] = ii_vpu_i1_op1_hazard;
assign ii_vpu_i0_op1_sel = ii_i0_ctrl[312];
assign ii_vpu_i1_op1_sel = ii_i1_ctrl[312];
assign ex_i0_valid = ex_valid[0];
assign ex_i1_valid = ex_valid[1];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        ex_valid <= 2'd0;
    end
    else if (~lx_stall) begin
        ex_valid <= ii_ex_valid;
    end
end

assign ex_ctrl_en = ii_valid[0] & ~lx_stall;
always @(posedge core_clk) begin
    if (ex_ctrl_en) begin
        ex_src3_reg <= ii_src3;
        ex_src4_reg <= ii_src4;
        ex_src2_reg <= ii_src2;
        ex_src1_reg <= ii_src1;
        ex_mdu_bypass <= ii_mdu_bypass;
        ex_mdu_func <= ii_mdu_func;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        ex_i0_pc <= {EXTVALEN{1'b0}};
        ex_i0_uinstr_pc <= {(UINS_PCLEN - 2){1'b0}};
        ex_i0_instr <= 32'd0;
        ex_i0_ctrl <= {214{1'b0}};
        ex_i0_val <= {EXTVALEN{1'b0}};
        ex_i0_pred_info <= {12{1'b0}};
    end
    else if (ex_ctrl_en) begin
        ex_i0_pc <= ii_i0_pc;
        ex_i0_uinstr_pc <= ii_i0_uinstr_pc;
        ex_i0_instr <= ii_i0_instr;
        ex_i0_ctrl <= ii_ex_i0_ctrl;
        ex_i0_val <= ii_i0_val;
        ex_i0_pred_info <= ii_i0_pred_info;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        ex_i1_pc <= {EXTVALEN{1'b0}};
        ex_i1_uinstr_pc <= {(UINS_PCLEN - 2){1'b0}};
        ex_i1_instr <= 32'd0;
        ex_i1_ctrl <= {214{1'b0}};
        ex_i1_val <= {EXTVALEN{1'b0}};
        ex_i1_pred_info <= {12{1'b0}};
    end
    else if (ex_ctrl_en) begin
        ex_i1_pc <= ii_i1_pc;
        ex_i1_uinstr_pc <= ii_i1_uinstr_pc;
        ex_i1_instr <= ii_i1_instr;
        ex_i1_ctrl <= ii_ex_i1_ctrl;
        ex_i1_val <= ii_i1_val;
        ex_i1_pred_info <= ii_i1_pred_info;
    end
end

assign ex_alive[0] = ex_i0_valid & ~wb_kill & ~mm_i0_kill & ~mm_i1_kill;
assign ex_alive[1] = ex_i1_valid & ~wb_kill & ~mm_i0_kill & ~mm_i1_kill;
assign ex_abort[0] = ex_i0_ctrl[154] | ex_i0_ctrl[204] | ex_i0_ctrl[213];
assign ex_abort[1] = ex_i1_ctrl[154] | ex_i1_ctrl[204] | ex_i1_ctrl[213];
assign ex_doable[0] = ex_alive[0] & ~ex_abort[0];
assign ex_doable[1] = ex_alive[1] & ~ex_abort[1];
assign alu0_op0 = ex_src1_reg;
assign alu0_op1 = ex_src2_reg;
assign alu0_func[0] = ex_i0_ctrl[2];
assign alu0_func[1] = ex_i0_ctrl[3];
assign alu0_func[2] = ex_i0_ctrl[4];
assign alu0_func[11] = ex_i0_ctrl[13];
assign alu0_func[12] = ex_i0_ctrl[14];
assign alu0_func[18] = ex_i0_ctrl[20];
assign alu0_func[22 +:4] = ex_i0_ctrl[24 +:4];
assign alu0_func[26] = ex_i0_ctrl[28];
assign alu0_func[27] = ex_i0_ctrl[29];
assign alu0_func[28] = ex_i0_ctrl[30];
assign alu0_func[29] = ex_i0_ctrl[31];
assign alu0_func[30] = ex_i0_ctrl[32];
assign alu0_func[31] = ex_i0_ctrl[33];
assign alu0_func[32] = ex_i0_ctrl[34];
assign alu0_func[33] = ex_i0_ctrl[35];
assign alu0_func[34] = ex_i0_ctrl[36];
assign alu0_func[13] = ex_i0_ctrl[15];
assign alu0_func[21] = ex_i0_ctrl[23];
assign alu0_func[14] = ex_i0_ctrl[16];
assign alu0_func[16] = ex_i0_ctrl[18];
assign alu0_func[15] = ex_i0_ctrl[17];
assign alu0_func[17] = ex_i0_ctrl[19];
assign alu0_func[9] = ex_i0_ctrl[11];
assign alu0_func[10] = ex_i0_ctrl[12];
assign alu0_func[19] = ex_i0_ctrl[21];
assign alu0_func[20] = ex_i0_ctrl[22];
assign alu0_func[35] = ex_i0_ctrl[37];
assign alu0_func[8] = ex_i0_ctrl[10];
assign alu0_func[4] = ex_i0_ctrl[6];
assign alu0_func[6] = ex_i0_ctrl[8];
assign alu0_func[3] = ex_i0_ctrl[5];
assign alu0_func[5] = ex_i0_ctrl[7];
assign alu0_func[7] = ex_i0_ctrl[9];
assign alu1_func[0] = ex_i1_ctrl[2];
assign alu1_func[1] = ex_i1_ctrl[3];
assign alu1_func[2] = ex_i1_ctrl[4];
assign alu1_func[11] = ex_i1_ctrl[13];
assign alu1_func[12] = ex_i1_ctrl[14];
assign alu1_func[18] = ex_i1_ctrl[20];
assign alu1_func[22 +:4] = ex_i1_ctrl[24 +:4];
assign alu1_func[26] = ex_i1_ctrl[28];
assign alu1_func[27] = ex_i1_ctrl[29];
assign alu1_func[28] = ex_i1_ctrl[30];
assign alu1_func[29] = ex_i1_ctrl[31];
assign alu1_func[30] = ex_i1_ctrl[32];
assign alu1_func[31] = ex_i1_ctrl[33];
assign alu1_func[32] = ex_i1_ctrl[34];
assign alu1_func[33] = ex_i1_ctrl[35];
assign alu1_func[34] = ex_i1_ctrl[36];
assign alu1_func[13] = ex_i1_ctrl[15];
assign alu1_func[21] = ex_i1_ctrl[23];
assign alu1_func[14] = ex_i1_ctrl[16];
assign alu1_func[16] = ex_i1_ctrl[18];
assign alu1_func[15] = ex_i1_ctrl[17];
assign alu1_func[17] = ex_i1_ctrl[19];
assign alu1_func[9] = ex_i1_ctrl[11];
assign alu1_func[10] = ex_i1_ctrl[12];
assign alu1_func[19] = ex_i1_ctrl[21];
assign alu1_func[20] = ex_i1_ctrl[22];
assign alu1_func[35] = ex_i1_ctrl[37];
assign alu1_func[8] = ex_i1_ctrl[10];
assign alu1_func[4] = ex_i1_ctrl[6];
assign alu1_func[6] = ex_i1_ctrl[8];
assign alu1_func[3] = ex_i1_ctrl[5];
assign alu1_func[5] = ex_i1_ctrl[7];
assign alu1_func[7] = ex_i1_ctrl[9];
wire [3:0] ex_i1_bypass = ex_i1_ctrl[75 +:4];
assign alu1_op0 = ({32{ex_i1_bypass[0]}} & ex_src3_reg) | ({32{ex_i1_bypass[1]}} & alu0_bresult);
assign alu1_op1 = ({32{ex_i0_ctrl[79]}} & ex_i1_calu_imm) | ({32{ex_i1_bypass[2] & ~ex_i0_ctrl[79]}} & ex_src4_reg) | ({32{ex_i1_bypass[3] & ~ex_i0_ctrl[79]}} & alu0_bresult);
assign alu1_bop0 = ({32{ex_i1_bypass[0]}} & ex_src3_reg) | ({32{ex_i1_bypass[1]}} & alu0_result);
assign alu1_bop1 = ({32{ex_i0_ctrl[79]}} & ex_i1_calu_imm) | ({32{ex_i1_bypass[2] & ~ex_i0_ctrl[79]}} & ex_src4_reg) | ({32{ex_i1_bypass[3] & ~ex_i0_ctrl[79]}} & alu0_aresult);
assign bru0_op0 = ex_src1_reg;
assign bru0_op1 = ex_src2_reg;
assign bru1_op0 = alu1_op0;
assign bru1_op1 = alu1_op1;
assign bru1_bop0 = alu1_bop0;
assign bru1_bop1 = ({32{ex_i1_bypass[2]}} & ex_src4_reg) | ({32{ex_i1_bypass[3]}} & alu0_aresult);
assign bru0_pc = ex_i0_pc;
assign bru0_fn = ex_i0_ctrl[38 +:5];
assign bru0_offset = ex_i0_ctrl[50 +:21];
assign bru0_pred_info = ex_i0_pred_info;
assign bru0_pred_npc = ex_i0_val;
assign bru0_type[0] = ex_i0_ctrl[43];
assign bru0_type[1] = ex_i0_ctrl[74];
assign bru0_type[2] = ex_i0_ctrl[47];
assign bru0_type[3] = ex_i0_ctrl[73];
assign bru0_type[4] = ex_i0_ctrl[46];
assign bru0_type[5] = ex_i0_ctrl[44];
assign bru0_type[7] = ex_i0_ctrl[49];
assign bru0_type[8] = ex_i0_ctrl[48];
assign bru0_type[6] = ex_i0_postsync[0];
assign bru1_pc = ex_i1_pc;
assign bru1_fn = ex_i1_ctrl[38 +:5];
assign bru1_offset = ex_i1_ctrl[50 +:21];
assign bru1_pred_info = ex_i1_pred_info;
assign bru1_pred_npc = ex_i1_val;
assign bru1_type[0] = ex_i1_ctrl[43];
assign bru1_type[1] = ex_i1_ctrl[74];
assign bru1_type[2] = ex_i1_ctrl[47];
assign bru1_type[3] = ex_i1_ctrl[73];
assign bru1_type[4] = ex_i1_ctrl[46];
assign bru1_type[5] = ex_i1_ctrl[44];
assign bru1_type[7] = ex_i1_ctrl[49];
assign bru1_type[8] = ex_i1_ctrl[48];
assign bru1_type[6] = ex_i1_postsync[0];
assign mdu_req_valid = ~lx_stall & ((ex_doable[0] & ex_i0_ctrl[149]) | (ex_doable[1] & ex_i1_ctrl[149]));
assign mdu_req_op0_reg = ex_i0_ctrl[149] | ex_i0_ctrl[150] ? ex_src1_reg : ex_src3_reg;
assign mdu_req_op1_reg = ex_i0_ctrl[149] | ex_i0_ctrl[150] ? ex_src2_reg : ex_src4_reg;
assign mdu_req_op0 = ({32{ex_mdu_bypass[0]}} & mdu_req_op0_reg) | ({32{ex_mdu_bypass[1]}} & mm_src2_reg) | ({32{ex_mdu_bypass[2]}} & mm_src4_reg) | ({32{ex_mdu_bypass[3]}} & lx_src2_reg) | ({32{ex_mdu_bypass[4]}} & lx_src4_reg) | ({32{ex_mdu_bypass[5]}} & ls_resp_result) | ({32{ex_mdu_bypass[6]}} & wb_rd1_wdata) | ({32{ex_mdu_bypass[7]}} & wb_rd2_wdata);
assign mdu_req_op1 = ({32{ex_mdu_bypass[8]}} & mdu_req_op1_reg) | ({32{ex_mdu_bypass[9]}} & mm_src2_reg) | ({32{ex_mdu_bypass[10]}} & mm_src4_reg) | ({32{ex_mdu_bypass[11]}} & lx_src2_reg) | ({32{ex_mdu_bypass[12]}} & lx_src4_reg) | ({32{ex_mdu_bypass[13]}} & ls_resp_result) | ({32{ex_mdu_bypass[14]}} & wb_rd1_wdata) | ({32{ex_mdu_bypass[15]}} & wb_rd2_wdata);
assign mdu_req_func = ex_mdu_func;
assign mdu_req_tag = ex_i0_ctrl[149] ? ex_i0_ctrl[192 +:5] : ex_i1_ctrl[192 +:5];
generate
    if ((MULTIPLIER_INT == 0)) begin:gen_fast_mul_enabled
        assign fmul_req = ~lx_stall & ((ex_doable[0] & ex_i0_ctrl[150]) | (ex_doable[1] & ex_i1_ctrl[150]));
        assign fmul_op0 = mdu_req_op0;
        assign fmul_op1 = mdu_req_op1;
        assign fmul_func = ex_mdu_func;
        assign fmul_stall = lx_stall;
    end
    else begin:gen_fast_mul_disabled
        assign fmul_req = 1'b0;
        assign fmul_op0 = {32{1'b0}};
        assign fmul_op1 = {32{1'b0}};
        assign fmul_func = 4'b0;
        assign fmul_stall = 1'b0;
    end
endgenerate
assign vsetvl_op0 = ({32{ex_i0_valid & ex_i0_vsetvl}} & ex_src1_reg) | ({32{ex_i1_valid & ex_i1_vsetvl}} & ex_src3_reg);
assign vsetvl_op1 = ({32{ex_i0_valid & ex_i0_vsetvl}} & ex_src2_reg) | ({32{ex_i1_valid & ex_i1_vsetvl}} & ex_src4_reg);
assign ex_vtype = vsetvl_vtype;
assign ex_vl = vsetvl_result;
assign wb_vtype = 9'd0;
assign ex_vpu_vtype_sel = 5'd0;
assign vpu_req_valid = 2'd0;
assign vpu_req_vtype = 9'd0;
assign vpu_req_i0_op1 = 64'd0;
assign vpu_req_i1_op1 = 64'd0;
assign vpu_req_i0_op2 = 64'd0;
assign vpu_req_i1_op2 = 64'd0;
assign vpu_vtlb_flush = 1'b0;
assign vpu_cmt_valid = 1'b0;
assign vpu_cmt_kill = 1'b0;
assign vpu_cmt_i0_op1 = 64'd0;
assign vpu_cmt_i1_op1 = 64'd0;
assign ii_viq_size = 4'd0;
assign vpu_req_vl = 11'd0;
assign vpu_req_vstart = 10'd0;
assign vpu_req_i0_instr = 32'd0;
assign vpu_req_i1_instr = 32'd0;
assign vpu_req_i0_ctrl = {17{1'b0}};
assign vpu_req_i1_ctrl = {17{1'b0}};
assign ipipe_csr_vtype_wdata = {32{1'b0}};
assign ipipe_csr_vl_we = 1'b0;
assign ipipe_csr_vl_wdata = {32{1'b0}};
assign ipipe_csr_vtype_we = 1'b0;
assign vpu_req_ls_privilege = 2'b0;
assign ex_rd1_wdata = ({32{ex_i0_ctrl[155]}} & bru0_link_result) | ({32{ex_i0_ctrl[132]}} & alu0_result) | ({32{ex_i0_ctrl[135]}} & ex_dsp_rd1) | ({32{ex_i0_ctrl[153]}} & vsetvl_result);
assign ex_rd2_wdata = ({32{ex_i0_ctrl[203]}} & ex_dsp_rd2) | ({32{~ex_i0_ctrl[203] & ex_i1_ctrl[135]}} & ex_dsp_rd1) | ({32{~ex_i0_ctrl[203] & ex_i1_ctrl[155]}} & bru1_link_result) | ({32{~ex_i0_ctrl[203] & ex_i1_ctrl[153]}} & vsetvl_result) | ({32{~ex_i0_ctrl[203] & ex_i0_ctrl[79] & bru0_reso_info[0]}} & ex_src4_reg) | ({32{~ex_i0_ctrl[203] & ex_i0_ctrl[79] & ~bru0_reso_info[0]}} & alu1_result) | ({32{~ex_i0_ctrl[203] & ~ex_i0_ctrl[79] & ex_i1_ctrl[132]}} & alu1_result);
assign int_taken_mask_set = (ex_doable[0] & ex_i0_ctrl[211]) | (ex_doable[1] & ex_i1_ctrl[211]) | lx_pp_int_taken_mask_set;
assign int_taken_mask_clr = resume | wb_pp_int_taken_mask_clr | wb_kill;
assign int_taken_mask_en = int_taken_mask_set | int_taken_mask_clr;
assign int_taken_mask_nx = ~int_taken_mask_clr & int_taken_mask_set;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        int_taken_mask <= 1'd0;
    end
    else if (int_taken_mask_en) begin
        int_taken_mask <= int_taken_mask_nx;
    end
end

wire ex_i1_sel_rd2 = (ex_i0_ctrl[135] & ~ex_i1_valid) | (ex_i1_ctrl[135] & ex_i1_valid) | (ex_i1_ctrl[132] & ex_i1_valid) | (ex_i1_ctrl[153] & ex_i1_valid);
assign ex_src1 = ex_src1_reg;
assign ex_src2 = ex_i0_ctrl[143] ? fpu_fmv_result[31:0] : (ex_i0_ctrl[132] | ex_i0_ctrl[135] | ex_i0_ctrl[153]) ? ex_rd1_wdata : ex_src2_reg;
assign ex_src3 = ex_src3_reg;
assign ex_src4 = (ex_i1_ctrl[143] & ex_doable[1]) ? fpu_fmv_result[31:0] : ex_i1_sel_rd2 ? ex_rd2_wdata : ex_src4_reg;
assign ex_mm_i0_ctrl[87] = ex_i0_ctrl[79] & ex_i1_valid;
assign ex_mm_i1_ctrl[87] = 1'b0;
assign ex_mm_i0_ctrl[75 +:12] = ex_i0_ctrl[162 +:12];
assign ex_mm_i1_ctrl[75 +:12] = ex_i1_ctrl[162 +:12];
assign ex_mm_i0_ctrl[170 +:4] = 4'd0;
assign ex_mm_i1_ctrl[170 +:4] = ex_i1_ctrl[156 +:4];
assign ex_mm_i0_ctrl[177] = ex_i0_ctrl[183];
assign ex_mm_i1_ctrl[177] = ex_i1_ctrl[183];
assign ex_mm_i0_ctrl[168] = ex_i0_ctrl[154];
assign ex_mm_i1_ctrl[168] = ex_i1_ctrl[154];
assign ex_mm_i0_ctrl[196] = ex_i0_ctrl[204] | ex_i0_poisoned | (ex_i0_ctrl[185] & ls_resp_nbload) | ex_mm_i0_random_replay;
assign ex_mm_i1_ctrl[196] = ex_i1_ctrl[204] | ex_i1_poisoned | (ex_i1_ctrl[185] & ls_resp_nbload) | ex_mm_i1_random_replay;
assign ex_mm_i0_ctrl[178] = ex_i0_ctrl[186];
assign ex_mm_i0_ctrl[115] = ex_i0_ctrl[108];
assign ex_mm_i0_ctrl[176] = ex_i0_ctrl[184];
assign ex_mm_i0_ctrl[199] = ex_i0_ctrl[207];
assign ex_mm_i0_ctrl[203] = ex_i0_ctrl[212];
assign ex_mm_i0_ctrl[116] = ex_i0_ctrl[109];
assign ex_mm_i0_ctrl[117] = ex_i0_ctrl[110];
assign ex_mm_i0_ctrl[137] = ex_i0_ctrl[130];
assign ex_mm_i0_ctrl[97] = ex_i0_ctrl[90];
assign ex_mm_i0_ctrl[110 +:2] = ex_i0_ctrl[103 +:2];
assign ex_mm_i0_ctrl[98 +:12] = ex_i0_ctrl[91 +:12];
assign ex_mm_i0_ctrl[150] = ex_i0_ctrl[134];
assign ex_mm_i0_ctrl[148] = ex_i0_ctrl[132];
assign ex_mm_i0_ctrl[163] = ex_i0_ctrl[148];
assign ex_mm_i0_ctrl[166] = ex_i0_ctrl[151];
assign ex_mm_i0_ctrl[164] = ex_i0_ctrl[149];
assign ex_mm_i0_ctrl[165] = ex_i0_ctrl[150];
assign ex_mm_i0_ctrl[161] = ex_i0_ctrl[146];
assign ex_mm_i0_ctrl[162] = ex_i0_ctrl[147];
assign ex_mm_i0_ctrl[149] = ex_i0_ctrl[133];
assign ex_mm_i0_ctrl[151] = ex_i0_ctrl[135];
assign ex_mm_i0_ctrl[153] = ex_i0_ctrl[137];
assign ex_mm_i0_ctrl[152] = ex_i0_ctrl[136];
assign ex_mm_i0_ctrl[147] = ex_i0_ctrl[131];
assign ex_mm_i0_ctrl[0] = ex_i0_ctrl[0];
assign ex_mm_i0_ctrl[1] = ex_i0_ctrl[1];
assign ex_mm_i0_ctrl[167] = ex_i0_ctrl[153];
assign ex_mm_i0_ctrl[43] = ex_i0_ctrl[43];
assign ex_mm_i0_ctrl[74] = ex_i0_ctrl[74];
assign ex_mm_i0_ctrl[47] = ex_i0_ctrl[47];
assign ex_mm_i0_ctrl[73] = ex_i0_ctrl[73];
assign ex_mm_i0_ctrl[46] = ex_i0_ctrl[46];
assign ex_mm_i0_ctrl[44] = ex_i0_ctrl[44];
assign ex_mm_i0_ctrl[71 +:2] = ex_i0_ctrl[71 +:2];
assign ex_mm_i0_ctrl[45] = ex_i0_ctrl[45];
assign ex_mm_i0_ctrl[49] = ex_i0_ctrl[49];
assign ex_mm_i0_ctrl[50 +:21] = ex_i0_ctrl[50 +:21];
assign ex_mm_i0_ctrl[48] = ex_i0_ctrl[48];
assign ex_mm_i0_ctrl[181 +:3] = ex_i0_ctrl[189 +:3];
assign ex_mm_i0_ctrl[180] = ex_i0_ctrl[188];
assign ex_mm_i0_ctrl[179] = ex_i0_ctrl[187];
assign ex_mm_i0_ctrl[88 +:6] = ex_i0_ctrl[80 +:6];
assign ex_mm_i0_ctrl[94 +:3] = ex_i0_ctrl[86 +:3];
assign ex_mm_i0_ctrl[118 +:8] = ex_i0_ctrl[111 +:8];
assign ex_mm_i0_ctrl[126] = ex_i0_ctrl[119];
assign ex_mm_i0_ctrl[127 +:3] = ex_i0_ctrl[120 +:3];
assign ex_mm_i0_ctrl[112 +:3] = ex_i0_ctrl[105 +:3];
assign ex_mm_i0_ctrl[169] = ex_i0_ctrl[155];
assign ex_mm_i0_ctrl[2] = ex_i0_ctrl[2];
assign ex_mm_i0_ctrl[3] = ex_i0_ctrl[3];
assign ex_mm_i0_ctrl[4] = ex_i0_ctrl[4];
assign ex_mm_i0_ctrl[13] = ex_i0_ctrl[13];
assign ex_mm_i0_ctrl[14] = ex_i0_ctrl[14];
assign ex_mm_i0_ctrl[20] = ex_i0_ctrl[20];
assign ex_mm_i0_ctrl[24 +:4] = ex_i0_ctrl[24 +:4];
assign ex_mm_i0_ctrl[28] = ex_i0_ctrl[28];
assign ex_mm_i0_ctrl[29] = ex_i0_ctrl[29];
assign ex_mm_i0_ctrl[30] = ex_i0_ctrl[30];
assign ex_mm_i0_ctrl[31] = ex_i0_ctrl[31];
assign ex_mm_i0_ctrl[32] = ex_i0_ctrl[32];
assign ex_mm_i0_ctrl[33] = ex_i0_ctrl[33];
assign ex_mm_i0_ctrl[34] = ex_i0_ctrl[34];
assign ex_mm_i0_ctrl[35] = ex_i0_ctrl[35];
assign ex_mm_i0_ctrl[36] = ex_i0_ctrl[36];
assign ex_mm_i0_ctrl[15] = ex_i0_ctrl[15];
assign ex_mm_i0_ctrl[23] = ex_i0_ctrl[23];
assign ex_mm_i0_ctrl[16] = ex_i0_ctrl[16];
assign ex_mm_i0_ctrl[18] = ex_i0_ctrl[18];
assign ex_mm_i0_ctrl[17] = ex_i0_ctrl[17];
assign ex_mm_i0_ctrl[19] = ex_i0_ctrl[19];
assign ex_mm_i0_ctrl[11] = ex_i0_ctrl[11];
assign ex_mm_i0_ctrl[12] = ex_i0_ctrl[12];
assign ex_mm_i0_ctrl[21] = ex_i0_ctrl[21];
assign ex_mm_i0_ctrl[22] = ex_i0_ctrl[22];
assign ex_mm_i0_ctrl[37] = ex_i0_ctrl[37];
assign ex_mm_i0_ctrl[10] = ex_i0_ctrl[10];
assign ex_mm_i0_ctrl[6] = ex_i0_ctrl[6];
assign ex_mm_i0_ctrl[8] = ex_i0_ctrl[8];
assign ex_mm_i0_ctrl[5] = ex_i0_ctrl[5];
assign ex_mm_i0_ctrl[7] = ex_i0_ctrl[7];
assign ex_mm_i0_ctrl[9] = ex_i0_ctrl[9];
assign ex_mm_i0_ctrl[38 +:5] = ex_i0_ctrl[38 +:5];
assign ex_mm_i0_ctrl[184 +:5] = ex_i0_ctrl[192 +:5];
assign ex_mm_i0_ctrl[189] = ex_i0_ctrl[197];
assign ex_mm_i0_ctrl[190 +:5] = ex_i0_ctrl[198 +:5];
assign ex_mm_i0_ctrl[195] = ex_i0_ctrl[203];
assign ex_mm_i0_ctrl[156] = ex_i0_ctrl[140];
assign ex_mm_i0_ctrl[157] = ex_i0_ctrl[141];
assign ex_mm_i0_ctrl[154] = ex_i0_ctrl[138];
assign ex_mm_i0_ctrl[158] = ex_i0_ctrl[142];
assign ex_mm_i0_ctrl[159] = ex_i0_ctrl[143];
assign ex_mm_i0_ctrl[155] = ex_i0_ctrl[139];
assign ex_mm_i0_ctrl[160] = ex_i0_ctrl[144];
assign ex_mm_i0_ctrl[131 +:5] = ex_i0_ctrl[124 +:5];
assign ex_mm_i0_ctrl[136] = ex_i0_ctrl[129];
assign ex_mm_i0_ctrl[130] = ex_i0_ctrl[123];
assign ex_mm_i0_ctrl[197] = ex_i0_ctrl[205];
assign ex_mm_i0_ctrl[198] = ex_i0_ctrl[206];
assign ex_mm_i0_ctrl[174 +:2] = ex_i0_ctrl[160 +:2];
assign ex_mm_i0_ctrl[202] = ex_i0_ctrl[210];
assign ex_mm_i0_ctrl[201] = ex_i0_ctrl[209];
assign ex_mm_i0_ctrl[200] = ex_i0_ctrl[208];
assign ex_i0_reso_info = bru0_reso_info & {13{ex_i0_ctrl[133]}};
assign ex_mm_i1_ctrl[178] = ex_i1_ctrl[186];
assign ex_mm_i1_ctrl[115] = ex_i1_ctrl[108];
assign ex_mm_i1_ctrl[176] = ex_i1_ctrl[184];
assign ex_mm_i1_ctrl[199] = ex_i1_ctrl[207];
assign ex_mm_i1_ctrl[203] = ex_i1_ctrl[212];
assign ex_mm_i1_ctrl[116] = ex_i1_ctrl[109];
assign ex_mm_i1_ctrl[117] = ex_i1_ctrl[110];
assign ex_mm_i1_ctrl[137] = ex_i1_ctrl[130];
assign ex_mm_i1_ctrl[97] = ex_i1_ctrl[90];
assign ex_mm_i1_ctrl[110 +:2] = ex_i1_ctrl[103 +:2];
assign ex_mm_i1_ctrl[98 +:12] = ex_i1_ctrl[91 +:12];
assign ex_mm_i1_ctrl[150] = ex_i1_ctrl[134];
assign ex_mm_i1_ctrl[148] = ex_i1_ctrl[132];
assign ex_mm_i1_ctrl[163] = ex_i1_ctrl[148];
assign ex_mm_i1_ctrl[166] = ex_i1_ctrl[151];
assign ex_mm_i1_ctrl[164] = ex_i1_ctrl[149];
assign ex_mm_i1_ctrl[165] = ex_i1_ctrl[150];
assign ex_mm_i1_ctrl[161] = ex_i1_ctrl[146];
assign ex_mm_i1_ctrl[162] = ex_i1_ctrl[147];
assign ex_mm_i1_ctrl[149] = ex_i1_ctrl[133];
assign ex_mm_i1_ctrl[151] = ex_i1_ctrl[135];
assign ex_mm_i1_ctrl[153] = ex_i1_ctrl[137];
assign ex_mm_i1_ctrl[152] = ex_i1_ctrl[136];
assign ex_mm_i1_ctrl[147] = ex_i1_ctrl[131];
assign ex_mm_i1_ctrl[0] = ex_i1_ctrl[0];
assign ex_mm_i1_ctrl[1] = ex_i1_ctrl[1];
assign ex_mm_i1_ctrl[167] = ex_i1_ctrl[153];
assign ex_mm_i1_ctrl[43] = ex_i1_ctrl[43];
assign ex_mm_i1_ctrl[74] = ex_i1_ctrl[74];
assign ex_mm_i1_ctrl[47] = ex_i1_ctrl[47];
assign ex_mm_i1_ctrl[73] = ex_i1_ctrl[73];
assign ex_mm_i1_ctrl[46] = ex_i1_ctrl[46];
assign ex_mm_i1_ctrl[44] = ex_i1_ctrl[44];
assign ex_mm_i1_ctrl[71 +:2] = ex_i1_ctrl[71 +:2];
assign ex_mm_i1_ctrl[45] = ex_i1_ctrl[45];
assign ex_mm_i1_ctrl[49] = ex_i1_ctrl[49];
assign ex_mm_i1_ctrl[50 +:21] = ex_i1_ctrl[50 +:21];
assign ex_mm_i1_ctrl[48] = ex_i1_ctrl[48];
assign ex_mm_i1_ctrl[181 +:3] = ex_i1_ctrl[189 +:3];
assign ex_mm_i1_ctrl[180] = ex_i1_ctrl[188];
assign ex_mm_i1_ctrl[179] = ex_i1_ctrl[187];
assign ex_mm_i1_ctrl[88 +:6] = ex_i1_ctrl[80 +:6];
assign ex_mm_i1_ctrl[94 +:3] = ex_i1_ctrl[86 +:3];
assign ex_mm_i1_ctrl[118 +:8] = ex_i1_ctrl[111 +:8];
assign ex_mm_i1_ctrl[126] = ex_i1_ctrl[119];
assign ex_mm_i1_ctrl[127 +:3] = ex_i1_ctrl[120 +:3];
assign ex_mm_i1_ctrl[112 +:3] = ex_i1_ctrl[105 +:3];
assign ex_mm_i1_ctrl[169] = ex_i1_ctrl[155];
assign ex_mm_i1_ctrl[2] = ex_i1_ctrl[2];
assign ex_mm_i1_ctrl[3] = ex_i1_ctrl[3];
assign ex_mm_i1_ctrl[4] = ex_i1_ctrl[4];
assign ex_mm_i1_ctrl[13] = ex_i1_ctrl[13];
assign ex_mm_i1_ctrl[14] = ex_i1_ctrl[14];
assign ex_mm_i1_ctrl[20] = ex_i1_ctrl[20];
assign ex_mm_i1_ctrl[24 +:4] = ex_i1_ctrl[24 +:4];
assign ex_mm_i1_ctrl[28] = ex_i1_ctrl[28];
assign ex_mm_i1_ctrl[29] = ex_i1_ctrl[29];
assign ex_mm_i1_ctrl[30] = ex_i1_ctrl[30];
assign ex_mm_i1_ctrl[31] = ex_i1_ctrl[31];
assign ex_mm_i1_ctrl[32] = ex_i1_ctrl[32];
assign ex_mm_i1_ctrl[33] = ex_i1_ctrl[33];
assign ex_mm_i1_ctrl[34] = ex_i1_ctrl[34];
assign ex_mm_i1_ctrl[35] = ex_i1_ctrl[35];
assign ex_mm_i1_ctrl[36] = ex_i1_ctrl[36];
assign ex_mm_i1_ctrl[15] = ex_i1_ctrl[15];
assign ex_mm_i1_ctrl[23] = ex_i1_ctrl[23];
assign ex_mm_i1_ctrl[16] = ex_i1_ctrl[16];
assign ex_mm_i1_ctrl[18] = ex_i1_ctrl[18];
assign ex_mm_i1_ctrl[17] = ex_i1_ctrl[17];
assign ex_mm_i1_ctrl[19] = ex_i1_ctrl[19];
assign ex_mm_i1_ctrl[11] = ex_i1_ctrl[11];
assign ex_mm_i1_ctrl[12] = ex_i1_ctrl[12];
assign ex_mm_i1_ctrl[21] = ex_i1_ctrl[21];
assign ex_mm_i1_ctrl[22] = ex_i1_ctrl[22];
assign ex_mm_i1_ctrl[37] = ex_i1_ctrl[37];
assign ex_mm_i1_ctrl[10] = ex_i1_ctrl[10];
assign ex_mm_i1_ctrl[6] = ex_i1_ctrl[6];
assign ex_mm_i1_ctrl[8] = ex_i1_ctrl[8];
assign ex_mm_i1_ctrl[5] = ex_i1_ctrl[5];
assign ex_mm_i1_ctrl[7] = ex_i1_ctrl[7];
assign ex_mm_i1_ctrl[9] = ex_i1_ctrl[9];
assign ex_mm_i1_ctrl[38 +:5] = ex_i1_ctrl[38 +:5];
assign ex_mm_i1_ctrl[184 +:5] = ex_i1_ctrl[192 +:5];
assign ex_mm_i1_ctrl[189] = ex_i1_ctrl[197];
assign ex_mm_i1_ctrl[190 +:5] = ex_i1_ctrl[198 +:5];
assign ex_mm_i1_ctrl[195] = ex_i1_ctrl[203];
assign ex_mm_i1_ctrl[156] = ex_i1_ctrl[140];
assign ex_mm_i1_ctrl[157] = ex_i1_ctrl[141];
assign ex_mm_i1_ctrl[154] = ex_i1_ctrl[138];
assign ex_mm_i1_ctrl[158] = ex_i1_ctrl[142];
assign ex_mm_i1_ctrl[159] = ex_i1_ctrl[143];
assign ex_mm_i1_ctrl[155] = ex_i1_ctrl[139];
assign ex_mm_i1_ctrl[160] = ex_i1_ctrl[144];
assign ex_mm_i1_ctrl[131 +:5] = ex_i1_ctrl[124 +:5];
assign ex_mm_i1_ctrl[136] = ex_i1_ctrl[129];
assign ex_mm_i1_ctrl[130] = ex_i1_ctrl[123];
assign ex_mm_i1_ctrl[197] = ex_i1_ctrl[205];
assign ex_mm_i1_ctrl[198] = ex_i1_ctrl[206];
assign ex_mm_i1_ctrl[174 +:2] = ex_i1_ctrl[160 +:2];
assign ex_mm_i1_ctrl[202] = ex_i1_ctrl[210];
assign ex_mm_i1_ctrl[201] = ex_i1_ctrl[209];
assign ex_mm_i1_ctrl[200] = ex_i1_ctrl[208];
assign ex_i1_reso_info = bru1_reso_info & {13{ex_i1_ctrl[133]}};
assign ex_mm_i0_ctrl[204] = ex_i0_ctrl[213] | ex_i0_illegal_pp;
assign ex_mm_i1_ctrl[204] = ex_i1_ctrl[213] | ex_i1_illegal_pp;
assign ex_mm_i0_val = ex_i0_illegal_pp ? ex_i0_val : ex_i0_ctrl[213] ? ex_i0_val : ex_i0_ctrl[147] ? ex_i0_val : bru0_target;
assign ex_mm_i1_val = ex_i1_illegal_pp ? ex_i1_val : ex_i1_ctrl[213] ? ex_i1_val : ex_i1_ctrl[147] ? ex_i1_val : bru1_target;
wire mm_valid_en = ~lx_stall;
assign mm_i0_valid = mm_valid[0];
assign mm_i1_valid = mm_valid[1];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mm_valid <= 2'd0;
    end
    else if (mm_valid_en) begin
        mm_valid <= ex_alive;
    end
end

assign mm_ctrl_en = ex_i0_valid & ~lx_stall;
always @(posedge core_clk) begin
    if (mm_ctrl_en) begin
        mm_src1_reg <= ex_src1;
        mm_src2_reg <= ex_src2;
        mm_src3_reg <= ex_src3;
        mm_src4_reg <= ex_src4;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mm_i0_pc <= {EXTVALEN{1'b0}};
        mm_i0_uinstr_pc <= {(UINS_PCLEN - 2){1'b0}};
        mm_i0_ctrl <= {205{1'b0}};
        mm_i0_instr <= 32'd0;
        mm_i0_val <= {EXTVALEN{1'b0}};
        mm_i0_reso_info <= {13{1'b0}};
        mm_i0_pred_info <= {12{1'b0}};
    end
    else if (mm_ctrl_en) begin
        mm_i0_pc <= ex_i0_pc;
        mm_i0_uinstr_pc <= ex_i0_uinstr_pc;
        mm_i0_instr <= ex_i0_instr;
        mm_i0_ctrl <= ex_mm_i0_ctrl;
        mm_i0_val <= ex_mm_i0_val;
        mm_i0_reso_info <= ex_i0_reso_info;
        mm_i0_pred_info <= ex_i0_pred_info;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mm_i1_pc <= {EXTVALEN{1'b0}};
        mm_i1_uinstr_pc <= {(UINS_PCLEN - 2){1'b0}};
        mm_i1_ctrl <= {205{1'b0}};
        mm_i1_instr <= 32'd0;
        mm_i1_val <= {EXTVALEN{1'b0}};
        mm_i1_reso_info <= {13{1'b0}};
        mm_i1_pred_info <= {12{1'b0}};
    end
    else if (mm_ctrl_en) begin
        mm_i1_pc <= ex_i1_pc;
        mm_i1_uinstr_pc <= ex_i1_uinstr_pc;
        mm_i1_instr <= ex_i1_instr;
        mm_i1_ctrl <= ex_mm_i1_ctrl;
        mm_i1_val <= ex_mm_i1_val;
        mm_i1_reso_info <= ex_i1_reso_info;
        mm_i1_pred_info <= ex_i1_pred_info;
    end
end

assign mm_alive[0] = mm_i0_valid & ~wb_kill;
assign mm_alive[1] = mm_i1_valid & ~wb_kill & ~mm_i0_kill;
assign mm_i0_xcpt = mm_i0_ctrl[204] | mm_i0_val_misaligned;
assign mm_i1_xcpt = mm_i1_ctrl[204] | mm_i1_val_misaligned;
assign mm_i0_replay = mm_i0_ctrl[196];
assign mm_i1_replay = mm_i1_ctrl[196];
assign mm_i0_nbload_hazard = mm_i0_ctrl[177] & ls_resp_nbload;
assign mm_i1_nbload_hazard = mm_i1_ctrl[177] & ls_resp_nbload;
assign mm_abort[0] = mm_i0_ctrl[168] | mm_i0_xcpt | mm_i0_replay;
assign mm_abort[1] = mm_i1_ctrl[168] | mm_i1_xcpt | mm_i1_replay;
assign mm_lx_abort[0] = mm_abort[0] | mm_i0_nbload_hazard;
assign mm_lx_abort[1] = mm_abort[1] | mm_i1_nbload_hazard;
assign mm_doable[0] = mm_alive[0] & ~mm_abort[0];
assign mm_doable[1] = mm_alive[1] & ~mm_abort[1];
assign mm_uinstr_seg = mm_i0_ctrl[174 +:2];
assign mm_uinstr = (mm_uinstr_seg != 2'b11);
assign mm_i0_kill = mm_doable[0] & mm_i0_mispred & ~mm_i0_ctrl[87] & (mm_i0_ctrl[149] | mm_i0_tb_mispred) & ~mm_i0_ctrl[87];
assign mm_i1_kill = mm_doable[1] & mm_i1_mispred & (mm_i1_ctrl[149] | mm_i1_tb_mispred);
assign mm_i0_val_misaligned = mm_i0_reso_info[0] & mm_i0_val[1] & ~rvc_en;
assign mm_i1_val_misaligned = mm_i1_reso_info[0] & mm_i1_val[1] & ~rvc_en;
assign mm_i0_redirect = (mm_doable[0] & mm_i0_mispred & ~mm_i0_ctrl[87] & mm_i0_ctrl[149] & ~mm_i0_val_misaligned) | (mm_doable[0] & mm_i0_mispred & mm_i0_ctrl[149] & mm_i0_ctrl[45]) | (mm_doable[0] & mm_i0_mispred & ~mm_i0_ctrl[87] & mm_i0_tb_mispred);
assign mm_i1_redirect = (mm_doable[1] & mm_i1_mispred & mm_i1_ctrl[149] & ~mm_i1_val_misaligned) | (mm_doable[1] & mm_i1_mispred & mm_i1_ctrl[149] & mm_i1_ctrl[45]) | (mm_doable[1] & mm_i1_mispred & mm_i1_tb_mispred);
assign mm_i0_redirect_pc_hit_ilm = mm_i0_reso_info[0] ? mm_i0_reso_info[7] : mm_i0_reso_info[8];
assign mm_i1_redirect_pc_hit_ilm = mm_i1_reso_info[0] ? mm_i1_reso_info[7] : mm_i1_reso_info[8];
assign mm_i0_ras_ptr = mm_i0_ctrl[181 +:3];
assign mm_i1_ras_ptr = mm_i1_ctrl[181 +:3];
assign mm_i0_npc = mm_i0_reso_info[0] ? mm_i0_val[EXTVALEN - 1:0] : mm_i0_seq_npc[EXTVALEN - 1:0];
assign mm_i1_npc = mm_i1_reso_info[0] ? mm_i1_val[EXTVALEN - 1:0] : mm_i1_seq_npc[EXTVALEN - 1:0];
wire [11:0] mm_i0_bypass = mm_i0_ctrl[75 +:12];
wire [11:0] mm_i1_bypass = mm_i1_ctrl[75 +:12];
assign mm_rd1_wdata = mm_i0_ctrl[153] ? mm_dsp_rd1 : mm_src2_reg;
assign mm_rd2_wdata = (mm_i1_ctrl[153] & mm_i1_valid) ? mm_dsp_rd1 : (mm_i0_ctrl[153] & ~mm_i1_valid) ? mm_dsp_rd2 : mm_src4_reg;
assign mm_src1 = ({32{mm_i0_bypass[0]}} & mm_src1_reg) | ({32{mm_i0_bypass[1]}} & lx_rd1_wdata) | ({32{mm_i0_bypass[2]}} & lx_rd2_wdata) | ({32{mm_i0_bypass[3]}} & wb_rd1_wdata) | ({32{mm_i0_bypass[4]}} & wb_rd2_wdata);
assign mm_src2 = ({32{mm_i0_bypass[6]}} & mm_rd1_wdata) | ({32{mm_i0_bypass[7]}} & lx_rd1_wdata) | ({32{mm_i0_bypass[8]}} & lx_rd2_wdata) | ({32{mm_i0_bypass[9]}} & wb_rd1_wdata) | ({32{mm_i0_bypass[10]}} & wb_rd2_wdata);
assign mm_src3 = ({32{mm_i1_bypass[0]}} & mm_src3_reg) | ({32{mm_i1_bypass[1]}} & lx_rd1_wdata) | ({32{mm_i1_bypass[2]}} & lx_rd2_wdata) | ({32{mm_i1_bypass[3]}} & wb_rd1_wdata) | ({32{mm_i1_bypass[4]}} & wb_rd2_wdata) | ({32{mm_i1_bypass[5] & mm_i0_ctrl[158]}} & fpu_fmis_result[31:0]) | ({32{mm_i1_bypass[5] & mm_i0_ctrl[159]}} & mm_src2_reg[31:0]);
assign mm_src4 = ({32{mm_i1_bypass[6]}} & mm_rd2_wdata) | ({32{mm_i1_bypass[7]}} & lx_rd1_wdata) | ({32{mm_i1_bypass[8]}} & lx_rd2_wdata) | ({32{mm_i1_bypass[9]}} & wb_rd1_wdata) | ({32{mm_i1_bypass[10]}} & wb_rd2_wdata) | ({32{mm_i1_bypass[11] & mm_i0_ctrl[158]}} & fpu_fmis_result[31:0]) | ({32{mm_i1_bypass[11] & mm_i0_ctrl[159]}} & mm_src2_reg[31:0]);
assign mm_lx_i0_ctrl[155] = mm_i0_ctrl[178];
assign mm_lx_i0_ctrl[107] = mm_i0_ctrl[115];
assign mm_lx_i0_ctrl[154] = mm_i0_ctrl[176];
assign mm_lx_i0_ctrl[187] = mm_i0_ctrl[199];
assign mm_lx_i0_ctrl[191] = mm_i0_ctrl[203];
assign mm_lx_i0_ctrl[108] = mm_i0_ctrl[116];
assign mm_lx_i0_ctrl[109] = mm_i0_ctrl[117];
assign mm_lx_i0_ctrl[129] = mm_i0_ctrl[137];
assign mm_lx_i0_ctrl[89] = mm_i0_ctrl[97];
assign mm_lx_i0_ctrl[102 +:2] = mm_i0_ctrl[110 +:2];
assign mm_lx_i0_ctrl[90 +:12] = mm_i0_ctrl[98 +:12];
assign mm_lx_i0_ctrl[132] = mm_i0_ctrl[150];
assign mm_lx_i0_ctrl[131] = mm_i0_ctrl[148];
assign mm_lx_i0_ctrl[145] = mm_i0_ctrl[163];
assign mm_lx_i0_ctrl[148] = mm_i0_ctrl[166];
assign mm_lx_i0_ctrl[146] = mm_i0_ctrl[164];
assign mm_lx_i0_ctrl[147] = mm_i0_ctrl[165];
assign mm_lx_i0_ctrl[143] = mm_i0_ctrl[161];
assign mm_lx_i0_ctrl[144] = mm_i0_ctrl[162];
assign mm_lx_i0_ctrl[133] = mm_i0_ctrl[151];
assign mm_lx_i0_ctrl[135] = mm_i0_ctrl[153];
assign mm_lx_i0_ctrl[134] = mm_i0_ctrl[152];
assign mm_lx_i0_ctrl[130] = mm_i0_ctrl[147];
assign mm_lx_i0_ctrl[0] = mm_i0_ctrl[0];
assign mm_lx_i0_ctrl[1] = mm_i0_ctrl[1];
assign mm_lx_i0_ctrl[149] = mm_i0_ctrl[167];
assign mm_lx_i0_ctrl[158 +:3] = mm_i0_ctrl[181 +:3];
assign mm_lx_i0_ctrl[43] = mm_i0_ctrl[43];
assign mm_lx_i0_ctrl[74] = mm_i0_ctrl[74];
assign mm_lx_i0_ctrl[47] = mm_i0_ctrl[47];
assign mm_lx_i0_ctrl[73] = mm_i0_ctrl[73];
assign mm_lx_i0_ctrl[46] = mm_i0_ctrl[46];
assign mm_lx_i0_ctrl[44] = mm_i0_ctrl[44];
assign mm_lx_i0_ctrl[71 +:2] = mm_i0_ctrl[71 +:2];
assign mm_lx_i0_ctrl[45] = mm_i0_ctrl[45];
assign mm_lx_i0_ctrl[49] = mm_i0_ctrl[49];
assign mm_lx_i0_ctrl[50 +:21] = mm_i0_ctrl[50 +:21];
assign mm_lx_i0_ctrl[48] = mm_i0_ctrl[48];
assign mm_lx_i0_ctrl[157] = mm_i0_ctrl[180];
assign mm_lx_i0_ctrl[156] = mm_i0_ctrl[179];
assign mm_lx_i0_ctrl[86 +:3] = mm_i0_ctrl[94 +:3];
assign mm_lx_i0_ctrl[110 +:8] = mm_i0_ctrl[118 +:8];
assign mm_lx_i0_ctrl[118] = mm_i0_ctrl[126];
assign mm_lx_i0_ctrl[119 +:3] = mm_i0_ctrl[127 +:3];
assign mm_lx_i0_ctrl[104 +:3] = mm_i0_ctrl[112 +:3];
assign mm_lx_i0_ctrl[151] = mm_i0_ctrl[169];
assign mm_lx_i0_ctrl[79] = mm_i0_ctrl[87];
assign mm_lx_i0_ctrl[2] = mm_i0_ctrl[2];
assign mm_lx_i0_ctrl[3] = mm_i0_ctrl[3];
assign mm_lx_i0_ctrl[4] = mm_i0_ctrl[4];
assign mm_lx_i0_ctrl[13] = mm_i0_ctrl[13];
assign mm_lx_i0_ctrl[14] = mm_i0_ctrl[14];
assign mm_lx_i0_ctrl[20] = mm_i0_ctrl[20];
assign mm_lx_i0_ctrl[24 +:4] = mm_i0_ctrl[24 +:4];
assign mm_lx_i0_ctrl[28] = mm_i0_ctrl[28];
assign mm_lx_i0_ctrl[29] = mm_i0_ctrl[29];
assign mm_lx_i0_ctrl[30] = mm_i0_ctrl[30];
assign mm_lx_i0_ctrl[31] = mm_i0_ctrl[31];
assign mm_lx_i0_ctrl[32] = mm_i0_ctrl[32];
assign mm_lx_i0_ctrl[33] = mm_i0_ctrl[33];
assign mm_lx_i0_ctrl[34] = mm_i0_ctrl[34];
assign mm_lx_i0_ctrl[35] = mm_i0_ctrl[35];
assign mm_lx_i0_ctrl[36] = mm_i0_ctrl[36];
assign mm_lx_i0_ctrl[15] = mm_i0_ctrl[15];
assign mm_lx_i0_ctrl[23] = mm_i0_ctrl[23];
assign mm_lx_i0_ctrl[16] = mm_i0_ctrl[16];
assign mm_lx_i0_ctrl[18] = mm_i0_ctrl[18];
assign mm_lx_i0_ctrl[17] = mm_i0_ctrl[17];
assign mm_lx_i0_ctrl[19] = mm_i0_ctrl[19];
assign mm_lx_i0_ctrl[11] = mm_i0_ctrl[11];
assign mm_lx_i0_ctrl[12] = mm_i0_ctrl[12];
assign mm_lx_i0_ctrl[21] = mm_i0_ctrl[21];
assign mm_lx_i0_ctrl[22] = mm_i0_ctrl[22];
assign mm_lx_i0_ctrl[37] = mm_i0_ctrl[37];
assign mm_lx_i0_ctrl[10] = mm_i0_ctrl[10];
assign mm_lx_i0_ctrl[6] = mm_i0_ctrl[6];
assign mm_lx_i0_ctrl[8] = mm_i0_ctrl[8];
assign mm_lx_i0_ctrl[5] = mm_i0_ctrl[5];
assign mm_lx_i0_ctrl[7] = mm_i0_ctrl[7];
assign mm_lx_i0_ctrl[9] = mm_i0_ctrl[9];
assign mm_lx_i0_ctrl[38 +:5] = mm_i0_ctrl[38 +:5];
assign mm_lx_i0_ctrl[161 +:5] = mm_i0_ctrl[184 +:5];
assign mm_lx_i0_ctrl[166] = mm_i0_ctrl[189];
assign mm_lx_i0_ctrl[167 +:5] = mm_i0_ctrl[190 +:5];
assign mm_lx_i0_ctrl[172] = mm_i0_ctrl[195];
assign mm_lx_i0_ctrl[138] = mm_i0_ctrl[156];
assign mm_lx_i0_ctrl[139] = mm_i0_ctrl[157];
assign mm_lx_i0_ctrl[136] = mm_i0_ctrl[154];
assign mm_lx_i0_ctrl[140] = mm_i0_ctrl[158];
assign mm_lx_i0_ctrl[141] = mm_i0_ctrl[159];
assign mm_lx_i0_ctrl[137] = mm_i0_ctrl[155];
assign mm_lx_i0_ctrl[142] = mm_i0_ctrl[160];
assign mm_lx_i0_ctrl[123 +:5] = mm_i0_ctrl[131 +:5];
assign mm_lx_i0_ctrl[128] = mm_i0_ctrl[136];
assign mm_lx_i0_ctrl[122] = mm_i0_ctrl[130];
assign mm_lx_i0_ctrl[182] = mm_i0_ctrl[197];
assign mm_lx_i0_ctrl[183] = mm_i0_ctrl[198];
assign mm_lx_i0_ctrl[152 +:2] = mm_i0_ctrl[174 +:2];
assign mm_lx_i0_ctrl[190] = mm_i0_ctrl[202];
assign mm_lx_i0_ctrl[189] = mm_i0_ctrl[201];
assign mm_lx_i0_ctrl[188] = mm_i0_ctrl[200];
assign mm_lx_i1_ctrl[155] = mm_i1_ctrl[178];
assign mm_lx_i1_ctrl[107] = mm_i1_ctrl[115];
assign mm_lx_i1_ctrl[154] = mm_i1_ctrl[176];
assign mm_lx_i1_ctrl[187] = mm_i1_ctrl[199];
assign mm_lx_i1_ctrl[191] = mm_i1_ctrl[203];
assign mm_lx_i1_ctrl[108] = mm_i1_ctrl[116];
assign mm_lx_i1_ctrl[109] = mm_i1_ctrl[117];
assign mm_lx_i1_ctrl[129] = mm_i1_ctrl[137];
assign mm_lx_i1_ctrl[89] = mm_i1_ctrl[97];
assign mm_lx_i1_ctrl[102 +:2] = mm_i1_ctrl[110 +:2];
assign mm_lx_i1_ctrl[90 +:12] = mm_i1_ctrl[98 +:12];
assign mm_lx_i1_ctrl[132] = mm_i1_ctrl[150];
assign mm_lx_i1_ctrl[131] = mm_i1_ctrl[148];
assign mm_lx_i1_ctrl[145] = mm_i1_ctrl[163];
assign mm_lx_i1_ctrl[148] = mm_i1_ctrl[166];
assign mm_lx_i1_ctrl[146] = mm_i1_ctrl[164];
assign mm_lx_i1_ctrl[147] = mm_i1_ctrl[165];
assign mm_lx_i1_ctrl[143] = mm_i1_ctrl[161];
assign mm_lx_i1_ctrl[144] = mm_i1_ctrl[162];
assign mm_lx_i1_ctrl[133] = mm_i1_ctrl[151];
assign mm_lx_i1_ctrl[135] = mm_i1_ctrl[153];
assign mm_lx_i1_ctrl[134] = mm_i1_ctrl[152];
assign mm_lx_i1_ctrl[130] = mm_i1_ctrl[147];
assign mm_lx_i1_ctrl[0] = mm_i1_ctrl[0];
assign mm_lx_i1_ctrl[1] = mm_i1_ctrl[1];
assign mm_lx_i1_ctrl[149] = mm_i1_ctrl[167];
assign mm_lx_i1_ctrl[158 +:3] = mm_i1_ctrl[181 +:3];
assign mm_lx_i1_ctrl[43] = mm_i1_ctrl[43];
assign mm_lx_i1_ctrl[74] = mm_i1_ctrl[74];
assign mm_lx_i1_ctrl[47] = mm_i1_ctrl[47];
assign mm_lx_i1_ctrl[73] = mm_i1_ctrl[73];
assign mm_lx_i1_ctrl[46] = mm_i1_ctrl[46];
assign mm_lx_i1_ctrl[44] = mm_i1_ctrl[44];
assign mm_lx_i1_ctrl[71 +:2] = mm_i1_ctrl[71 +:2];
assign mm_lx_i1_ctrl[45] = mm_i1_ctrl[45];
assign mm_lx_i1_ctrl[49] = mm_i1_ctrl[49];
assign mm_lx_i1_ctrl[50 +:21] = mm_i1_ctrl[50 +:21];
assign mm_lx_i1_ctrl[48] = mm_i1_ctrl[48];
assign mm_lx_i1_ctrl[157] = mm_i1_ctrl[180];
assign mm_lx_i1_ctrl[156] = mm_i1_ctrl[179];
assign mm_lx_i1_ctrl[86 +:3] = mm_i1_ctrl[94 +:3];
assign mm_lx_i1_ctrl[110 +:8] = mm_i1_ctrl[118 +:8];
assign mm_lx_i1_ctrl[118] = mm_i1_ctrl[126];
assign mm_lx_i1_ctrl[119 +:3] = mm_i1_ctrl[127 +:3];
assign mm_lx_i1_ctrl[104 +:3] = mm_i1_ctrl[112 +:3];
assign mm_lx_i1_ctrl[151] = mm_i1_ctrl[169];
assign mm_lx_i1_ctrl[79] = mm_i1_ctrl[87];
assign mm_lx_i1_ctrl[2] = mm_i1_ctrl[2];
assign mm_lx_i1_ctrl[3] = mm_i1_ctrl[3];
assign mm_lx_i1_ctrl[4] = mm_i1_ctrl[4];
assign mm_lx_i1_ctrl[13] = mm_i1_ctrl[13];
assign mm_lx_i1_ctrl[14] = mm_i1_ctrl[14];
assign mm_lx_i1_ctrl[20] = mm_i1_ctrl[20];
assign mm_lx_i1_ctrl[24 +:4] = mm_i1_ctrl[24 +:4];
assign mm_lx_i1_ctrl[28] = mm_i1_ctrl[28];
assign mm_lx_i1_ctrl[29] = mm_i1_ctrl[29];
assign mm_lx_i1_ctrl[30] = mm_i1_ctrl[30];
assign mm_lx_i1_ctrl[31] = mm_i1_ctrl[31];
assign mm_lx_i1_ctrl[32] = mm_i1_ctrl[32];
assign mm_lx_i1_ctrl[33] = mm_i1_ctrl[33];
assign mm_lx_i1_ctrl[34] = mm_i1_ctrl[34];
assign mm_lx_i1_ctrl[35] = mm_i1_ctrl[35];
assign mm_lx_i1_ctrl[36] = mm_i1_ctrl[36];
assign mm_lx_i1_ctrl[15] = mm_i1_ctrl[15];
assign mm_lx_i1_ctrl[23] = mm_i1_ctrl[23];
assign mm_lx_i1_ctrl[16] = mm_i1_ctrl[16];
assign mm_lx_i1_ctrl[18] = mm_i1_ctrl[18];
assign mm_lx_i1_ctrl[17] = mm_i1_ctrl[17];
assign mm_lx_i1_ctrl[19] = mm_i1_ctrl[19];
assign mm_lx_i1_ctrl[11] = mm_i1_ctrl[11];
assign mm_lx_i1_ctrl[12] = mm_i1_ctrl[12];
assign mm_lx_i1_ctrl[21] = mm_i1_ctrl[21];
assign mm_lx_i1_ctrl[22] = mm_i1_ctrl[22];
assign mm_lx_i1_ctrl[37] = mm_i1_ctrl[37];
assign mm_lx_i1_ctrl[10] = mm_i1_ctrl[10];
assign mm_lx_i1_ctrl[6] = mm_i1_ctrl[6];
assign mm_lx_i1_ctrl[8] = mm_i1_ctrl[8];
assign mm_lx_i1_ctrl[5] = mm_i1_ctrl[5];
assign mm_lx_i1_ctrl[7] = mm_i1_ctrl[7];
assign mm_lx_i1_ctrl[9] = mm_i1_ctrl[9];
assign mm_lx_i1_ctrl[38 +:5] = mm_i1_ctrl[38 +:5];
assign mm_lx_i1_ctrl[161 +:5] = mm_i1_ctrl[184 +:5];
assign mm_lx_i1_ctrl[166] = mm_i1_ctrl[189];
assign mm_lx_i1_ctrl[167 +:5] = mm_i1_ctrl[190 +:5];
assign mm_lx_i1_ctrl[172] = mm_i1_ctrl[195];
assign mm_lx_i1_ctrl[138] = mm_i1_ctrl[156];
assign mm_lx_i1_ctrl[139] = mm_i1_ctrl[157];
assign mm_lx_i1_ctrl[136] = mm_i1_ctrl[154];
assign mm_lx_i1_ctrl[140] = mm_i1_ctrl[158];
assign mm_lx_i1_ctrl[141] = mm_i1_ctrl[159];
assign mm_lx_i1_ctrl[137] = mm_i1_ctrl[155];
assign mm_lx_i1_ctrl[142] = mm_i1_ctrl[160];
assign mm_lx_i1_ctrl[123 +:5] = mm_i1_ctrl[131 +:5];
assign mm_lx_i1_ctrl[128] = mm_i1_ctrl[136];
assign mm_lx_i1_ctrl[122] = mm_i1_ctrl[130];
assign mm_lx_i1_ctrl[182] = mm_i1_ctrl[197];
assign mm_lx_i1_ctrl[183] = mm_i1_ctrl[198];
assign mm_lx_i1_ctrl[152 +:2] = mm_i1_ctrl[174 +:2];
assign mm_lx_i1_ctrl[190] = mm_i1_ctrl[202];
assign mm_lx_i1_ctrl[189] = mm_i1_ctrl[201];
assign mm_lx_i1_ctrl[188] = mm_i1_ctrl[200];
assign mm_lx_i0_ctrl[192] = mm_i0_xcpt | mm_i0_sp_xcpt;
assign mm_lx_i1_ctrl[192] = mm_i1_xcpt | mm_i1_sp_xcpt;
assign mm_lx_i0_ctrl[184 +:3] = mm_i0_sp_status;
assign mm_lx_i1_ctrl[184 +:3] = mm_i1_sp_status;
assign mm_i0_sp_xcpt = |mm_i0_sp_status[1:0];
assign mm_i1_sp_xcpt = |mm_i1_sp_status[1:0];
assign mm_lx_i0_ctrl[80 +:6] = (mm_i0_ctrl[168] | mm_i0_ctrl[204]) ? mm_i0_ctrl[88 +:6] : mm_i0_sp_status[0] ? 6'h20 : mm_i0_sp_status[1] ? 6'h21 : 6'h0;
assign mm_lx_i1_ctrl[80 +:6] = (mm_i1_ctrl[168] | mm_i1_ctrl[204]) ? mm_i1_ctrl[88 +:6] : mm_i1_sp_status[0] ? 6'h20 : mm_i1_sp_status[1] ? 6'h21 : 6'h0;
assign mm_lx_i0_ctrl[181] = mm_i0_replay | mm_i0_nbload_hazard;
assign mm_lx_i1_ctrl[181] = mm_i1_replay | mm_i1_nbload_hazard;
assign mm_lx_i0_ctrl[75 +:4] = 4'd0;
assign mm_lx_i1_ctrl[75 +:4] = mm_i1_ctrl[170 +:4];
assign mm_lx_i0_ctrl[150] = mm_i0_ctrl[168];
assign mm_lx_i1_ctrl[150] = mm_i1_ctrl[168];
assign mm_lx_i0_ctrl[180] = mm_lx_i0_ctrl[131] | mm_lx_i0_ctrl[133] | mm_lx_i0_ctrl[135] | mm_lx_i0_ctrl[140] | mm_lx_i0_ctrl[141] | mm_lx_i0_ctrl[149];
assign mm_lx_i0_ctrl[177] = mm_lx_i0_ctrl[145];
assign mm_lx_i0_ctrl[179] = mm_lx_i0_ctrl[147];
assign mm_lx_i0_ctrl[178] = mm_lx_i0_ctrl[146];
assign mm_lx_i0_ctrl[173] = mm_lx_i0_ctrl[132];
assign mm_lx_i0_ctrl[176] = mm_lx_i0_ctrl[143];
assign mm_lx_i0_ctrl[174] = mm_lx_i0_ctrl[134];
assign mm_lx_i0_ctrl[175] = 1'b0;
assign mm_lx_i1_ctrl[180] = mm_lx_i1_ctrl[131] & mm_i1_valid | mm_lx_i0_ctrl[133] & ~mm_i1_valid | mm_lx_i0_ctrl[135] & ~mm_i1_valid | mm_lx_i1_ctrl[133] & mm_i1_valid | mm_lx_i1_ctrl[135] & mm_i1_valid | mm_lx_i1_ctrl[141] & mm_i1_valid | mm_lx_i1_ctrl[140] & mm_i1_valid | mm_lx_i1_ctrl[149] & mm_i1_valid;
assign mm_lx_i1_ctrl[177] = mm_lx_i1_ctrl[145] & mm_i1_valid;
assign mm_lx_i1_ctrl[179] = mm_lx_i1_ctrl[147] & mm_i1_valid;
assign mm_lx_i1_ctrl[178] = 1'b0;
assign mm_lx_i1_ctrl[173] = mm_lx_i1_ctrl[132] & mm_i1_valid;
assign mm_lx_i1_ctrl[176] = mm_lx_i1_ctrl[143] & mm_i1_valid;
assign mm_lx_i1_ctrl[174] = mm_lx_i1_ctrl[134] & mm_i1_valid;
assign mm_lx_i1_ctrl[175] = mm_lx_i0_ctrl[134] & ~mm_i1_valid;
assign mm_lx_i0_reso_info[0] = mm_i0_reso_info[0];
assign mm_lx_i0_reso_info[1] = mm_i0_reso_info[1];
assign mm_lx_i0_reso_info[2] = mm_i0_reso_info[2];
assign mm_lx_i0_reso_info[3] = mm_i0_reso_info[3];
assign mm_lx_i0_reso_info[4] = mm_i0_reso_info[4];
assign mm_lx_i0_reso_info[5 +:2] = mm_i0_reso_info[5 +:2];
assign mm_lx_i0_reso_info[7] = mm_i0_reso_info[7];
assign mm_lx_i0_reso_info[8] = mm_i0_reso_info[8];
assign mm_lx_i0_reso_info[9] = mm_i0_reso_info[9];
assign mm_lx_i0_reso_info[10] = mm_i0_reso_info[10];
assign mm_lx_i1_reso_info[0] = mm_i1_reso_info[0];
assign mm_lx_i1_reso_info[1] = mm_i1_reso_info[1];
assign mm_lx_i1_reso_info[2] = mm_i1_reso_info[2];
assign mm_lx_i1_reso_info[3] = mm_i1_reso_info[3];
assign mm_lx_i1_reso_info[4] = mm_i1_reso_info[4];
assign mm_lx_i1_reso_info[5 +:2] = mm_i1_reso_info[5 +:2];
assign mm_lx_i1_reso_info[7] = mm_i1_reso_info[7];
assign mm_lx_i1_reso_info[8] = mm_i1_reso_info[8];
assign mm_lx_i1_reso_info[9] = mm_i1_reso_info[9];
assign mm_lx_i1_reso_info[10] = mm_i1_reso_info[10];
assign mm_lx_i0_reso_info[11] = mm_i0_mispred & ~mm_i0_ctrl[87] & mm_i0_ctrl[149];
assign mm_lx_i1_reso_info[11] = mm_i1_mispred & mm_i1_ctrl[149];
assign mm_lx_i0_reso_info[12] = mm_btb_update_p0 & mm_i0_ctrl[149];
assign mm_lx_i1_reso_info[12] = mm_btb_update_p1 & mm_i1_ctrl[149];
assign lx_i0_valid = lx_valid[0];
assign lx_i1_valid = lx_valid[1];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        lx_valid <= 2'b0;
    end
    else if (~lx_stall) begin
        lx_valid <= mm_alive;
    end
end

assign lx_ctrl_en = mm_alive[0] & ~lx_stall;
wire [31:0] lx_src2_nx;
wire [31:0] lx_src4_nx;
assign lx_src2_nx = (mm_i0_valid & mm_i0_ctrl[158]) ? fpu_fmis_result[31:0] : mm_src2;
assign lx_src4_nx = (mm_i1_valid & mm_i1_ctrl[158]) ? fpu_fmis_result[31:0] : mm_src4;
always @(posedge core_clk) begin
    if (lx_ctrl_en) begin
        lx_src1_reg <= mm_src1;
        lx_src2_reg <= lx_src2_nx;
        lx_src3_reg <= mm_src3;
        lx_src4_reg <= lx_src4_nx;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        lx_i0_pc <= {EXTVALEN{1'b0}};
        lx_i0_instr <= 32'd0;
        lx_i0_ctrl <= {193{1'b0}};
        lx_i0_val <= {EXTVALEN{1'b0}};
        lx_i0_reso_info <= {13{1'b0}};
        lx_i0_pred_info <= {12{1'b0}};
    end
    else if (lx_ctrl_en) begin
        lx_i0_pc <= mm_i0_pc;
        lx_i0_instr <= mm_i0_instr;
        lx_i0_ctrl <= mm_lx_i0_ctrl;
        lx_i0_val <= mm_i0_val;
        lx_i0_reso_info <= mm_lx_i0_reso_info;
        lx_i0_pred_info <= mm_i0_pred_info;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        lx_i1_pc <= {EXTVALEN{1'b0}};
        lx_i1_instr <= 32'd0;
        lx_i1_ctrl <= {193{1'b0}};
        lx_i1_val <= {EXTVALEN{1'b0}};
        lx_i1_reso_info <= {13{1'b0}};
        lx_i1_pred_info <= {12{1'b0}};
    end
    else if (lx_ctrl_en) begin
        lx_i1_pc <= mm_i1_pc;
        lx_i1_instr <= mm_i1_instr;
        lx_i1_ctrl <= mm_lx_i1_ctrl;
        lx_i1_val <= mm_i1_val;
        lx_i1_reso_info <= mm_lx_i1_reso_info;
        lx_i1_pred_info <= mm_i1_pred_info;
    end
end

wire [UINS_PCLEN - 3:0] nds_unused_mm_i0_uinstr_pc = mm_i0_uinstr_pc;
wire [UINS_PCLEN - 3:0] nds_unused_mm_i1_uinstr_pc = mm_i1_uinstr_pc;
assign lx_alive[0] = lx_valid[0] & ~wb_kill;
assign lx_alive[1] = lx_valid[1] & ~wb_kill & ~lx_abort[0];
assign lx_abort[0] = lx_i0_ctrl[150] | lx_i0_ctrl[181] | lx_i0_ctrl[192];
assign lx_abort[1] = lx_i1_ctrl[150] | lx_i1_ctrl[181] | lx_i1_ctrl[192];
assign lx_doable[0] = lx_alive[0] & ~lx_abort[0];
assign lx_doable[1] = lx_alive[1] & ~lx_abort[1];
assign lx_i0_nbload = ~lx_abort[0] & lx_i0_ctrl[145] & ls_resp_nbload;
assign lx_i1_nbload = ~lx_abort[1] & lx_i1_ctrl[145] & ls_resp_nbload;
assign lx_src1 = lx_src1_reg;
assign lx_src2 = lx_src2_reg;
assign lx_src3 = lx_src3_reg;
assign lx_src4 = lx_src4_reg;
assign alu2_op0 = lx_src1;
assign alu2_op1 = lx_src2;
assign alu3_op0 = ({32{lx_i1_bypass[0]}} & lx_src3_reg) | ({32{lx_i1_bypass[1]}} & ls_resp_bresult);
assign alu3_op1 = ({32{lx_i0_ctrl[79]}} & lx_i1_calu_imm) | ({32{lx_i1_bypass[2] & ~lx_i0_ctrl[79]}} & lx_src4_reg) | ({32{lx_i1_bypass[3] & ~lx_i0_ctrl[79]}} & ls_resp_bresult);
assign alu3_bop0 = ({32{lx_i1_bypass[0]}} & lx_src3_reg) | ({32{lx_i1_bypass[1]}} & ls_resp_bresult);
assign alu3_bop1 = ({32{lx_i0_ctrl[79]}} & lx_i1_calu_imm) | ({32{lx_i1_bypass[2] & ~lx_i0_ctrl[79]}} & lx_src4_reg) | ({32{lx_i1_bypass[3] & ~lx_i0_ctrl[79]}} & ls_resp_bresult);
assign lx_i1_poisoned = (ls_resp_status[13] & lx_i1_bypass[1]) | (ls_resp_status[13] & lx_i1_bypass[3] & ~lx_i0_ctrl[79]);
assign alu2_func[0] = lx_i0_ctrl[2];
assign alu2_func[1] = lx_i0_ctrl[3];
assign alu2_func[2] = lx_i0_ctrl[4];
assign alu2_func[11] = lx_i0_ctrl[13];
assign alu2_func[12] = lx_i0_ctrl[14];
assign alu2_func[18] = lx_i0_ctrl[20];
assign alu2_func[22 +:4] = lx_i0_ctrl[24 +:4];
assign alu2_func[26] = lx_i0_ctrl[28];
assign alu2_func[27] = lx_i0_ctrl[29];
assign alu2_func[28] = lx_i0_ctrl[30];
assign alu2_func[29] = lx_i0_ctrl[31];
assign alu2_func[30] = lx_i0_ctrl[32];
assign alu2_func[31] = lx_i0_ctrl[33];
assign alu2_func[32] = lx_i0_ctrl[34];
assign alu2_func[33] = lx_i0_ctrl[35];
assign alu2_func[34] = lx_i0_ctrl[36];
assign alu2_func[13] = lx_i0_ctrl[15];
assign alu2_func[21] = lx_i0_ctrl[23];
assign alu2_func[14] = lx_i0_ctrl[16];
assign alu2_func[16] = lx_i0_ctrl[18];
assign alu2_func[15] = lx_i0_ctrl[17];
assign alu2_func[17] = lx_i0_ctrl[19];
assign alu2_func[9] = lx_i0_ctrl[11];
assign alu2_func[10] = lx_i0_ctrl[12];
assign alu2_func[19] = lx_i0_ctrl[21];
assign alu2_func[20] = lx_i0_ctrl[22];
assign alu2_func[35] = lx_i0_ctrl[37];
assign alu2_func[8] = lx_i0_ctrl[10];
assign alu2_func[4] = lx_i0_ctrl[6];
assign alu2_func[6] = lx_i0_ctrl[8];
assign alu2_func[3] = lx_i0_ctrl[5];
assign alu2_func[5] = lx_i0_ctrl[7];
assign alu2_func[7] = lx_i0_ctrl[9];
assign alu3_func[0] = lx_i1_ctrl[2];
assign alu3_func[1] = lx_i1_ctrl[3];
assign alu3_func[2] = lx_i1_ctrl[4];
assign alu3_func[11] = lx_i1_ctrl[13];
assign alu3_func[12] = lx_i1_ctrl[14];
assign alu3_func[18] = lx_i1_ctrl[20];
assign alu3_func[22 +:4] = lx_i1_ctrl[24 +:4];
assign alu3_func[26] = lx_i1_ctrl[28];
assign alu3_func[27] = lx_i1_ctrl[29];
assign alu3_func[28] = lx_i1_ctrl[30];
assign alu3_func[29] = lx_i1_ctrl[31];
assign alu3_func[30] = lx_i1_ctrl[32];
assign alu3_func[31] = lx_i1_ctrl[33];
assign alu3_func[32] = lx_i1_ctrl[34];
assign alu3_func[33] = lx_i1_ctrl[35];
assign alu3_func[34] = lx_i1_ctrl[36];
assign alu3_func[13] = lx_i1_ctrl[15];
assign alu3_func[21] = lx_i1_ctrl[23];
assign alu3_func[14] = lx_i1_ctrl[16];
assign alu3_func[16] = lx_i1_ctrl[18];
assign alu3_func[15] = lx_i1_ctrl[17];
assign alu3_func[17] = lx_i1_ctrl[19];
assign alu3_func[9] = lx_i1_ctrl[11];
assign alu3_func[10] = lx_i1_ctrl[12];
assign alu3_func[19] = lx_i1_ctrl[21];
assign alu3_func[20] = lx_i1_ctrl[22];
assign alu3_func[35] = lx_i1_ctrl[37];
assign alu3_func[8] = lx_i1_ctrl[10];
assign alu3_func[4] = lx_i1_ctrl[6];
assign alu3_func[6] = lx_i1_ctrl[8];
assign alu3_func[3] = lx_i1_ctrl[5];
assign alu3_func[5] = lx_i1_ctrl[7];
assign alu3_func[7] = lx_i1_ctrl[9];
assign bru2_op0 = lx_src1;
assign bru2_op1 = lx_src2;
assign bru2_pc = lx_i0_pc;
assign bru2_fn = lx_i0_ctrl[38 +:5];
assign bru2_offset = lx_i0_ctrl[50 +:21];
assign bru2_pred_info = lx_i0_pred_info;
assign bru2_pred_npc = lx_i0_val;
assign bru2_type[0] = lx_i0_ctrl[43];
assign bru2_type[1] = lx_i0_ctrl[74];
assign bru2_type[2] = lx_i0_ctrl[47];
assign bru2_type[3] = lx_i0_ctrl[73];
assign bru2_type[4] = lx_i0_ctrl[46];
assign bru2_type[5] = lx_i0_ctrl[44];
assign bru2_type[6] = lx_i0_postsync[0];
assign bru2_type[7] = lx_i0_ctrl[49];
assign bru2_type[8] = lx_i0_ctrl[48];
assign bru3_op0 = alu3_op0;
assign bru3_op1 = ({32{lx_i1_bypass[2]}} & lx_src4_reg) | ({32{lx_i1_bypass[3]}} & ls_resp_bresult);
assign bru3_bop0 = alu3_bop0;
assign bru3_bop1 = ({32{lx_i1_bypass[2]}} & lx_src4_reg) | ({32{lx_i1_bypass[3]}} & ls_resp_bresult);
assign bru3_pc = lx_i1_pc;
assign bru3_fn = lx_i1_ctrl[38 +:5];
assign bru3_offset = lx_i1_ctrl[50 +:21];
assign bru3_pred_info = lx_i1_pred_info;
assign bru3_pred_npc = lx_i1_val;
assign bru3_type[0] = lx_i1_ctrl[43];
assign bru3_type[1] = lx_i1_ctrl[74];
assign bru3_type[2] = lx_i1_ctrl[47];
assign bru3_type[3] = lx_i1_ctrl[73];
assign bru3_type[4] = lx_i1_ctrl[46];
assign bru3_type[5] = lx_i1_ctrl[44];
assign bru3_type[6] = lx_i1_postsync[0];
assign bru3_type[7] = lx_i1_ctrl[49];
assign bru3_type[8] = lx_i1_ctrl[48];
assign ls_resp_result_with_nan_boxing = ls_resp_result | ({32{(lx_i0_valid & lx_i0_ctrl[137])}} & nan_boxing_value[31:0]) | ({32{(lx_i1_valid & lx_i1_ctrl[137])}} & nan_boxing_value[31:0]);
assign lau2_result = lx_i0_ctrl[151] ? bru2_link_result : alu2_result;
assign lau3_result = lx_i1_ctrl[151] ? bru3_link_result : (lx_i0_ctrl[79] & lx_wb_i0_reso_info[0]) ? lx_src4_reg : alu3_result;
assign lx_rd1_wdata = ({32{lx_i0_ctrl[180]}} & lx_src2_reg) | ({32{lx_i0_ctrl[177]}} & ls_resp_result_with_nan_boxing) | ({32{lx_i0_ctrl[179]}} & fmul_result) | ({32{lx_i0_ctrl[173]}} & csr_ipipe_resp_rdata) | ({32{lx_i0_ctrl[176]}} & lau2_result) | ({32{lx_i0_ctrl[178]}} & mdu_resp_result) | ({32{lx_i0_ctrl[174]}} & lx_dsp_rd1);
assign lx_rd2_wdata = ({32{lx_i1_ctrl[180]}} & lx_src4_reg) | ({32{lx_i1_ctrl[177]}} & ls_resp_result_with_nan_boxing) | ({32{lx_i1_ctrl[179]}} & fmul_result) | ({32{lx_i1_ctrl[176]}} & lau3_result) | ({32{lx_i1_ctrl[174]}} & lx_dsp_rd1) | ({32{lx_i1_ctrl[175]}} & lx_dsp_rd2);
assign lx_wait_ls_resp = lx_ls_valid & ~ls_cmt_kill;
assign lx_ls_stall = lx_wait_ls_resp & ~ls_resp_valid;
wire tb_lx_stall;
assign tb_lx_stall = 1'b0;
assign lx_stall = lx_ls_stall | tb_lx_stall & ~wb_kill;
assign lx_i0_ls_cause = ls_resp_status[2 +:6] & {CAUSE_LEN{lx_i0_ctrl[145] | lx_i0_ctrl[148]}};
assign lx_i1_ls_cause = ls_resp_status[2 +:6] & {CAUSE_LEN{lx_i1_ctrl[145] | lx_i1_ctrl[148]}};
wire [2:0] lx_i0_ramid_enc = lx_i0_ctrl[119 +:3];
wire [2:0] lx_i1_ramid_enc = lx_i1_ctrl[119 +:3];
assign lx_i0_ramid = (lx_i0_ramid_enc == 3'b001) ? 4'h8 : {1'b0,lx_i0_ramid_enc};
assign lx_i1_ramid = (lx_i1_ramid_enc == 3'b001) ? 4'h8 : {1'b0,lx_i1_ramid_enc};
assign lx_wb_i0_ctrl[149] = lx_i0_ctrl[192] | lx_i0_ls_xcpt;
assign lx_wb_i1_ctrl[149] = lx_i1_ctrl[192] | lx_i1_ls_xcpt;
assign lx_wb_i0_ctrl[84] = ~lx_abort[0];
assign lx_wb_i0_ctrl[77] = lx_i0_ctrl[118];
assign lx_wb_i0_ctrl[69 +:8] = lx_i0_ctrl[110 +:8];
assign lx_wb_i0_ctrl[80 +:4] = lx_i0_ramid;
assign lx_wb_i0_ctrl[79] = lx_abort[0] | ls_resp_status[27];
assign lx_wb_i1_ctrl[84] = ~lx_abort[1];
assign lx_wb_i1_ctrl[77] = lx_i1_ctrl[118];
assign lx_wb_i1_ctrl[69 +:8] = lx_i1_ctrl[110 +:8];
assign lx_wb_i1_ctrl[80 +:4] = lx_i1_ramid;
assign lx_wb_i1_ctrl[79] = lx_abort[1] | ls_resp_status[27];
assign lx_wb_i0_ctrl[78] = lx_abort[0] ? 1'b0 : lx_i0_ctrl[145] & ls_resp_status[28];
assign lx_wb_i1_ctrl[78] = lx_abort[1] ? 1'b0 : lx_i1_ctrl[145] & ls_resp_status[28];
assign lx_wb_i0_ctrl[111] = lx_i0_ctrl[145] & ls_resp_nbload;
assign lx_wb_i1_ctrl[111] = lx_i1_ctrl[145] & ls_resp_nbload;
assign lx_wb_i0_ctrl[45 +:3] = lx_i0_ctrl[192] ? lx_i0_ctrl[86 +:3] : ls_resp_status[8 +:3];
assign lx_wb_i1_ctrl[45 +:3] = lx_i1_ctrl[192] ? lx_i1_ctrl[86 +:3] : ls_resp_status[8 +:3];
assign lx_i0_ls_halt = (lx_ls_valid & ~lx_ls_killed & lx_i0_ctrl[145] & ls_resp_status[0]) | (lx_ls_valid & ~lx_ls_killed & lx_i0_ctrl[148] & ls_resp_status[0]);
assign lx_i1_ls_halt = (lx_ls_valid & ~lx_ls_killed & lx_i1_ctrl[145] & ls_resp_status[0]) | (lx_ls_valid & ~lx_ls_killed & lx_i1_ctrl[148] & ls_resp_status[0]);
assign lx_i0_ls_replay = (lx_ls_valid & ~lx_ls_killed & lx_i0_ctrl[145] & ls_resp_status[11]) | (lx_ls_valid & ~lx_ls_killed & lx_i0_ctrl[148] & ls_resp_status[11]);
assign lx_i1_ls_replay = (lx_ls_valid & ~lx_ls_killed & lx_i1_ctrl[145] & ls_resp_status[11]) | (lx_ls_valid & ~lx_ls_killed & lx_i1_ctrl[148] & ls_resp_status[11]);
assign lx_i0_ls_xcpt = (lx_ls_valid & ~lx_ls_killed & lx_i0_ctrl[145] & ls_resp_status[1]) | (lx_ls_valid & ~lx_ls_killed & lx_i0_ctrl[148] & ls_resp_status[1]);
assign lx_i1_ls_xcpt = (lx_ls_valid & ~lx_ls_killed & lx_i1_ctrl[145] & ls_resp_status[1]) | (lx_ls_valid & ~lx_ls_killed & lx_i1_ctrl[148] & ls_resp_status[1]);
assign lx_i0_ls_trace_on = (lx_ls_valid & ~lx_ls_killed & lx_i0_ctrl[145] & ls_resp_status[29]) | (lx_ls_valid & ~lx_ls_killed & lx_i0_ctrl[148] & ls_resp_status[29]);
assign lx_i1_ls_trace_on = (lx_ls_valid & ~lx_ls_killed & lx_i1_ctrl[145] & ls_resp_status[29]) | (lx_ls_valid & ~lx_ls_killed & lx_i1_ctrl[148] & ls_resp_status[29]);
assign lx_i0_ls_trace_off = (lx_ls_valid & ~lx_ls_killed & lx_i0_ctrl[145] & ls_resp_status[30]) | (lx_ls_valid & ~lx_ls_killed & lx_i0_ctrl[148] & ls_resp_status[30]);
assign lx_i1_ls_trace_off = (lx_ls_valid & ~lx_ls_killed & lx_i1_ctrl[145] & ls_resp_status[30]) | (lx_ls_valid & ~lx_ls_killed & lx_i1_ctrl[148] & ls_resp_status[30]);
assign lx_i0_ls_trace_notify = (lx_ls_valid & ~lx_ls_killed & lx_i0_ctrl[145] & ls_resp_status[31]) | (lx_ls_valid & ~lx_ls_killed & lx_i0_ctrl[148] & ls_resp_status[31]);
assign lx_i1_ls_trace_notify = (lx_ls_valid & ~lx_ls_killed & lx_i1_ctrl[145] & ls_resp_status[31]) | (lx_ls_valid & ~lx_ls_killed & lx_i1_ctrl[148] & ls_resp_status[31]);
assign lx_wb_i0_ctrl[106] = lx_i0_ctrl[150] | lx_i0_ls_halt;
assign lx_wb_i1_ctrl[106] = lx_i1_ctrl[150] | lx_i1_ls_halt;
assign lx_wb_i0_ctrl[39 +:6] = lx_i0_ctrl[150] ? lx_i0_ctrl[80 +:6] : lx_i0_ls_halt ? {3'd0,3'd2} : lx_i0_ctrl[192] ? lx_i0_ctrl[80 +:6] : lx_i0_ls_cause;
assign lx_wb_i1_ctrl[39 +:6] = lx_i1_ctrl[150] ? lx_i1_ctrl[80 +:6] : lx_i1_ls_halt ? {3'd0,3'd2} : lx_i1_ctrl[192] ? lx_i1_ctrl[80 +:6] : lx_i1_ls_cause;
assign lx_wb_i0_ctrl[138] = lx_i0_ctrl[181] | lx_i0_ls_replay | (lx_i0_ctrl[0] & lx_i0_ctrl[1]);
assign lx_wb_i1_ctrl[138] = lx_i1_ctrl[181] | lx_i1_ls_replay | lx_i1_poisoned;
assign lx_wb_i0_ctrl[147] = lx_i0_ctrl[190] | lx_i0_ls_trace_on;
assign lx_wb_i0_ctrl[146] = lx_i0_ctrl[189] | lx_i0_ls_trace_off;
assign lx_wb_i0_ctrl[145] = lx_i0_ctrl[188] | lx_i0_ls_trace_notify;
assign lx_wb_i1_ctrl[147] = lx_i1_ctrl[190] | lx_i1_ls_trace_on;
assign lx_wb_i1_ctrl[146] = lx_i1_ctrl[189] | lx_i1_ls_trace_off;
assign lx_wb_i1_ctrl[145] = lx_i1_ctrl[188] | lx_i1_ls_trace_notify;
assign lx_wb_i0_ctrl[112] = lx_i0_ctrl[155];
assign lx_wb_i0_ctrl[66] = lx_i0_ctrl[107];
assign lx_wb_i0_ctrl[110] = lx_i0_ctrl[154];
assign lx_wb_i0_ctrl[144] = lx_i0_ctrl[187];
assign lx_wb_i0_ctrl[148] = lx_i0_ctrl[191];
assign lx_wb_i0_ctrl[67] = lx_i0_ctrl[108];
assign lx_wb_i0_ctrl[68] = lx_i0_ctrl[109];
assign lx_wb_i0_ctrl[92] = lx_i0_ctrl[129];
assign lx_wb_i0_ctrl[104] = lx_i0_ctrl[146];
assign lx_wb_i0_ctrl[103] = lx_i0_ctrl[145];
assign lx_wb_i0_ctrl[94] = lx_i0_ctrl[132];
assign lx_wb_i0_ctrl[102] = lx_i0_ctrl[144];
assign lx_wb_i0_ctrl[93] = lx_i0_ctrl[130];
assign lx_wb_i0_ctrl[0] = lx_i0_ctrl[0];
assign lx_wb_i0_ctrl[1] = lx_i0_ctrl[1];
assign lx_wb_i0_ctrl[105] = lx_i0_ctrl[149];
assign lx_wb_i0_ctrl[61 +:2] = lx_i0_ctrl[102 +:2];
assign lx_wb_i0_ctrl[49 +:12] = lx_i0_ctrl[90 +:12];
assign lx_wb_i0_ctrl[48] = lx_i0_ctrl[89];
assign lx_wb_i0_ctrl[123 +:3] = lx_i0_ctrl[158 +:3];
assign lx_wb_i0_ctrl[7] = lx_i0_ctrl[43];
assign lx_wb_i0_ctrl[37] = lx_i0_ctrl[74];
assign lx_wb_i0_ctrl[11] = lx_i0_ctrl[47];
assign lx_wb_i0_ctrl[36] = lx_i0_ctrl[73];
assign lx_wb_i0_ctrl[10] = lx_i0_ctrl[46];
assign lx_wb_i0_ctrl[8] = lx_i0_ctrl[44];
assign lx_wb_i0_ctrl[34 +:2] = lx_i0_ctrl[71 +:2];
assign lx_wb_i0_ctrl[9] = lx_i0_ctrl[45];
assign lx_wb_i0_ctrl[12] = lx_i0_ctrl[49];
assign lx_wb_i0_ctrl[13 +:21] = lx_i0_ctrl[50 +:21];
assign lx_wb_i0_ctrl[122] = lx_i0_ctrl[157];
assign lx_wb_i0_ctrl[121] = lx_i0_ctrl[156];
assign lx_wb_i0_ctrl[107] = lx_i0_ctrl[151];
assign lx_wb_i0_ctrl[38] = lx_i0_ctrl[79];
assign lx_wb_i0_ctrl[63 +:3] = lx_i0_ctrl[104 +:3];
assign lx_wb_i0_ctrl[2 +:5] = lx_i0_ctrl[38 +:5];
assign lx_wb_i0_ctrl[126 +:5] = lx_i0_ctrl[161 +:5];
assign lx_wb_i0_ctrl[131] = lx_i0_ctrl[166];
assign lx_wb_i0_ctrl[132 +:5] = lx_i0_ctrl[167 +:5];
assign lx_wb_i0_ctrl[137] = lx_i0_ctrl[172];
assign lx_wb_i0_ctrl[97] = lx_i0_ctrl[138];
assign lx_wb_i0_ctrl[98] = lx_i0_ctrl[139];
assign lx_wb_i0_ctrl[95] = lx_i0_ctrl[136];
assign lx_wb_i0_ctrl[99] = lx_i0_ctrl[140];
assign lx_wb_i0_ctrl[100] = lx_i0_ctrl[141];
assign lx_wb_i0_ctrl[96] = lx_i0_ctrl[137];
assign lx_wb_i0_ctrl[101] = lx_i0_ctrl[142];
assign lx_wb_i0_ctrl[86 +:5] = lx_i0_ctrl[123 +:5];
assign lx_wb_i0_ctrl[91] = lx_i0_ctrl[128];
assign lx_wb_i0_ctrl[85] = lx_i0_ctrl[122];
assign lx_wb_i0_ctrl[139] = lx_i0_ctrl[182];
assign lx_wb_i0_ctrl[140] = lx_i0_ctrl[183];
assign lx_wb_i0_ctrl[108 +:2] = lx_i0_ctrl[152 +:2];
assign lx_wb_i1_ctrl[112] = lx_i1_ctrl[155];
assign lx_wb_i1_ctrl[66] = lx_i1_ctrl[107];
assign lx_wb_i1_ctrl[110] = lx_i1_ctrl[154];
assign lx_wb_i1_ctrl[144] = lx_i1_ctrl[187];
assign lx_wb_i1_ctrl[148] = lx_i1_ctrl[191];
assign lx_wb_i1_ctrl[67] = lx_i1_ctrl[108];
assign lx_wb_i1_ctrl[68] = lx_i1_ctrl[109];
assign lx_wb_i1_ctrl[92] = lx_i1_ctrl[129];
assign lx_wb_i1_ctrl[104] = lx_i1_ctrl[146];
assign lx_wb_i1_ctrl[103] = lx_i1_ctrl[145];
assign lx_wb_i1_ctrl[94] = lx_i1_ctrl[132];
assign lx_wb_i1_ctrl[102] = lx_i1_ctrl[144];
assign lx_wb_i1_ctrl[93] = lx_i1_ctrl[130];
assign lx_wb_i1_ctrl[0] = lx_i1_ctrl[0];
assign lx_wb_i1_ctrl[1] = lx_i1_ctrl[1];
assign lx_wb_i1_ctrl[105] = lx_i1_ctrl[149];
assign lx_wb_i1_ctrl[61 +:2] = lx_i1_ctrl[102 +:2];
assign lx_wb_i1_ctrl[49 +:12] = lx_i1_ctrl[90 +:12];
assign lx_wb_i1_ctrl[48] = lx_i1_ctrl[89];
assign lx_wb_i1_ctrl[123 +:3] = lx_i1_ctrl[158 +:3];
assign lx_wb_i1_ctrl[7] = lx_i1_ctrl[43];
assign lx_wb_i1_ctrl[37] = lx_i1_ctrl[74];
assign lx_wb_i1_ctrl[11] = lx_i1_ctrl[47];
assign lx_wb_i1_ctrl[36] = lx_i1_ctrl[73];
assign lx_wb_i1_ctrl[10] = lx_i1_ctrl[46];
assign lx_wb_i1_ctrl[8] = lx_i1_ctrl[44];
assign lx_wb_i1_ctrl[34 +:2] = lx_i1_ctrl[71 +:2];
assign lx_wb_i1_ctrl[9] = lx_i1_ctrl[45];
assign lx_wb_i1_ctrl[12] = lx_i1_ctrl[49];
assign lx_wb_i1_ctrl[13 +:21] = lx_i1_ctrl[50 +:21];
assign lx_wb_i1_ctrl[122] = lx_i1_ctrl[157];
assign lx_wb_i1_ctrl[121] = lx_i1_ctrl[156];
assign lx_wb_i1_ctrl[107] = lx_i1_ctrl[151];
assign lx_wb_i1_ctrl[38] = lx_i1_ctrl[79];
assign lx_wb_i1_ctrl[63 +:3] = lx_i1_ctrl[104 +:3];
assign lx_wb_i1_ctrl[2 +:5] = lx_i1_ctrl[38 +:5];
assign lx_wb_i1_ctrl[126 +:5] = lx_i1_ctrl[161 +:5];
assign lx_wb_i1_ctrl[131] = lx_i1_ctrl[166];
assign lx_wb_i1_ctrl[132 +:5] = lx_i1_ctrl[167 +:5];
assign lx_wb_i1_ctrl[137] = lx_i1_ctrl[172];
assign lx_wb_i1_ctrl[97] = lx_i1_ctrl[138];
assign lx_wb_i1_ctrl[98] = lx_i1_ctrl[139];
assign lx_wb_i1_ctrl[95] = lx_i1_ctrl[136];
assign lx_wb_i1_ctrl[99] = lx_i1_ctrl[140];
assign lx_wb_i1_ctrl[100] = lx_i1_ctrl[141];
assign lx_wb_i1_ctrl[96] = lx_i1_ctrl[137];
assign lx_wb_i1_ctrl[101] = lx_i1_ctrl[142];
assign lx_wb_i1_ctrl[86 +:5] = lx_i1_ctrl[123 +:5];
assign lx_wb_i1_ctrl[91] = lx_i1_ctrl[128];
assign lx_wb_i1_ctrl[85] = lx_i1_ctrl[122];
assign lx_wb_i1_ctrl[139] = lx_i1_ctrl[182];
assign lx_wb_i1_ctrl[140] = lx_i1_ctrl[183];
assign lx_wb_i1_ctrl[108 +:2] = lx_i1_ctrl[152 +:2];
assign lx_wb_i0_val = lx_i0_ctrl[192] ? lx_i0_val : lx_i0_ctrl[145] ? ls_resp_fault_addr : lx_i0_ctrl[148] ? ls_resp_fault_addr : lx_i0_ctrl[144] ? bru2_target : lx_i0_val;
assign lx_wb_i1_val = lx_i1_ctrl[192] ? lx_i1_val : lx_i1_ctrl[145] ? ls_resp_fault_addr : lx_i1_ctrl[148] ? ls_resp_fault_addr : lx_i1_ctrl[144] ? bru3_target : lx_i1_val;
assign lx_wb_i0_ctrl[141] = lx_sp_i0_sel_rd1;
assign lx_wb_i1_ctrl[141] = lx_sp_i1_sel_rd1;
assign lx_wb_i0_reso_info[0] = lx_i0_ctrl[144] ? bru2_reso_info[0] : lx_i0_reso_info[0];
assign lx_wb_i0_reso_info[1] = lx_i0_ctrl[144] ? bru2_reso_info[1] : lx_i0_reso_info[1];
assign lx_wb_i0_reso_info[2] = lx_i0_ctrl[144] ? bru2_reso_info[2] : lx_i0_reso_info[2];
assign lx_wb_i0_reso_info[3] = lx_i0_ctrl[144] ? bru2_reso_info[3] : lx_i0_reso_info[3];
assign lx_wb_i0_reso_info[4] = lx_i0_ctrl[144] ? bru2_reso_info[4] : lx_i0_reso_info[4];
assign lx_wb_i0_reso_info[5 +:2] = lx_i0_ctrl[144] ? bru2_reso_info[5 +:2] : lx_i0_reso_info[5 +:2];
assign lx_wb_i0_reso_info[7] = lx_i0_ctrl[144] ? bru2_reso_info[7] : lx_i0_reso_info[7];
assign lx_wb_i0_reso_info[8] = lx_i0_ctrl[144] ? bru2_reso_info[8] : lx_i0_reso_info[8];
assign lx_wb_i0_reso_info[9] = lx_i0_ctrl[144] ? bru2_reso_info[9] : lx_i0_reso_info[9];
assign lx_wb_i0_reso_info[10] = lx_i0_ctrl[144] ? bru2_reso_info[10] : lx_i0_reso_info[10];
assign lx_wb_i0_reso_info[11] = lx_i0_ctrl[144] ? bru2_reso_info[11] : lx_i0_reso_info[11];
assign lx_wb_i0_reso_info[12] = lx_i0_ctrl[144] ? bru2_reso_info[12] : lx_i0_reso_info[12];
assign lx_wb_i1_reso_info[0] = lx_i1_ctrl[144] ? bru3_reso_info[0] : lx_i1_reso_info[0];
assign lx_wb_i1_reso_info[1] = lx_i1_ctrl[144] ? bru3_reso_info[1] : lx_i1_reso_info[1];
assign lx_wb_i1_reso_info[2] = lx_i1_ctrl[144] ? bru3_reso_info[2] : lx_i1_reso_info[2];
assign lx_wb_i1_reso_info[3] = lx_i1_ctrl[144] ? bru3_reso_info[3] : lx_i1_reso_info[3];
assign lx_wb_i1_reso_info[4] = lx_i1_ctrl[144] ? bru3_reso_info[4] : lx_i1_reso_info[4];
assign lx_wb_i1_reso_info[5 +:2] = lx_i1_ctrl[144] ? bru3_reso_info[5 +:2] : lx_i1_reso_info[5 +:2];
assign lx_wb_i1_reso_info[7] = lx_i1_ctrl[144] ? bru3_reso_info[7] : lx_i1_reso_info[7];
assign lx_wb_i1_reso_info[8] = lx_i1_ctrl[144] ? bru3_reso_info[8] : lx_i1_reso_info[8];
assign lx_wb_i1_reso_info[9] = lx_i1_ctrl[144] ? bru3_reso_info[9] : lx_i1_reso_info[9];
assign lx_wb_i1_reso_info[10] = lx_i1_ctrl[144] ? bru3_reso_info[10] : lx_i1_reso_info[10];
assign lx_wb_i1_reso_info[11] = lx_i1_ctrl[144] ? bru3_reso_info[11] : lx_i1_reso_info[11];
assign lx_wb_i1_reso_info[12] = lx_i1_ctrl[144] ? bru3_reso_info[12] : lx_i1_reso_info[12];
assign lx_wb_valid[0] = lx_i0_valid & ~lx_stall & ~wb_kill;
assign lx_wb_valid[1] = lx_i1_valid & ~lx_stall & ~wb_kill;
assign lx_wb_async_stall = lx_stall;
assign wb_ctrl_en = lx_i0_valid & ~(lx_stall);
assign wb_valid_en = ~core_wfi_mode;
assign wb_i0_valid = wb_valid[0];
assign wb_i1_valid = wb_valid[1];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        wb_valid <= 2'b0;
        wb_async_stall <= 1'b0;
    end
    else if (wb_valid_en) begin
        wb_valid <= lx_wb_valid;
        wb_async_stall <= lx_wb_async_stall;
    end
end

wire [31:0] wb_rd1_wdata_nx;
wire [31:0] wb_rd2_wdata_nx;
wire wb_ctrl_rd_en = wb_ctrl_en;
generate
    if (FLEN < 32) begin:gen_wb_rd_wdata_nx_fltx
        assign wb_rd1_wdata_nx = (lx_i0_ctrl[128] & lx_i0_ctrl[138]) ? {{32 - FLEN{1'b1}},fpu_fmac32_result[FLEN - 1:0]} : lx_rd1_wdata;
        assign wb_rd2_wdata_nx = (lx_i1_ctrl[128] & lx_i1_ctrl[138] & lx_i1_valid) ? {{32 - FLEN{1'b1}},fpu_fmac32_result[FLEN - 1:0]} : lx_rd2_wdata;
    end
    else begin:gen_wb_rd_wdata_nx_fbetx
        assign wb_rd1_wdata_nx = (lx_i0_ctrl[128] & lx_i0_ctrl[138]) ? fpu_fmac32_result[31:0] : lx_rd1_wdata;
        assign wb_rd2_wdata_nx = (lx_i1_ctrl[128] & lx_i1_ctrl[138] & lx_i1_valid) ? fpu_fmac32_result[31:0] : lx_rd2_wdata;
    end
endgenerate
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        wb_rd1_wdata_reg <= {32{1'b0}};
    end
    else if (wb_ctrl_rd_en) begin
        wb_rd1_wdata_reg <= wb_rd1_wdata_nx;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        wb_rd2_wdata_reg <= {32{1'b0}};
    end
    else if (wb_ctrl_rd_en) begin
        wb_rd2_wdata_reg <= wb_rd2_wdata_nx;
    end
end

reg [31:0] wb_csr_wdata_reg;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        wb_csr_wdata_reg <= {32{1'b0}};
    end
    else if (wb_ctrl_en) begin
        wb_csr_wdata_reg <= csr_wdata;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        wb_ls_ecc_code <= 8'd0;
        wb_ls_ecc_corr <= 1'b0;
        wb_ls_ecc_ramid <= 4'd0;
    end
    else if (wb_ctrl_en) begin
        wb_ls_ecc_code <= ls_resp_status[14 +:8];
        wb_ls_ecc_corr <= ls_resp_status[26];
        wb_ls_ecc_ramid <= ls_resp_status[22 +:4];
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        wb_i0_instr <= 32'd0;
        wb_i0_pred_info <= {12{1'b0}};
        wb_i0_ctrl <= {150{1'b0}};
        wb_i0_reso_info_reg <= {13{1'b0}};
        wb_i0_val <= {EXTVALEN{1'b0}};
    end
    else if (wb_ctrl_en) begin
        wb_i0_instr <= lx_i0_instr;
        wb_i0_pred_info <= lx_i0_pred_info;
        wb_i0_ctrl <= lx_wb_i0_ctrl;
        wb_i0_reso_info_reg <= lx_wb_i0_reso_info;
        wb_i0_val <= lx_wb_i0_val;
    end
end

always @(posedge core_clk) begin
    if (wb_i0_pc_en) begin
        wb_i0_pc <= wb_i0_pc_nx;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        wb_i0_pc_vec <= 1'b0;
    end
    else if (wb_i0_pc_en) begin
        wb_i0_pc_vec <= wb_i0_pc_vec_nx;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        wb_i1_pc <= {EXTVALEN{1'b0}};
        wb_i1_instr <= 32'd0;
        wb_i1_ctrl <= {150{1'b0}};
        wb_i1_val <= {EXTVALEN{1'b0}};
        wb_i1_pred_info <= {12{1'b0}};
        wb_i1_reso_info_reg <= {13{1'b0}};
    end
    else if (wb_ctrl_en) begin
        wb_i1_pc <= lx_i1_pc;
        wb_i1_instr <= lx_i1_instr;
        wb_i1_ctrl <= lx_wb_i1_ctrl;
        wb_i1_val <= lx_wb_i1_val;
        wb_i1_pred_info <= lx_i1_pred_info;
        wb_i1_reso_info_reg <= lx_wb_i1_reso_info;
    end
end

assign wb_i0_reso_info[0] = wb_i0_reso_info_reg[0];
assign wb_i0_reso_info[1] = wb_i0_reso_info_reg[1];
assign wb_i0_reso_info[2] = wb_i0_reso_info_reg[2];
assign wb_i0_reso_info[3] = wb_i0_reso_info_reg[3];
assign wb_i0_reso_info[4] = wb_i0_reso_info_reg[4];
assign wb_i0_reso_info[5 +:2] = wb_i0_reso_info_reg[5 +:2];
assign wb_i0_reso_info[7] = wb_i0_reso_info_reg[7];
assign wb_i0_reso_info[8] = wb_i0_reso_info_reg[8];
assign wb_i0_reso_info[9] = wb_i0_reso_info_reg[9];
assign wb_i0_reso_info[10] = wb_i0_reso_info_reg[10];
assign wb_i1_reso_info[0] = wb_i1_reso_info_reg[0];
assign wb_i1_reso_info[1] = wb_i1_reso_info_reg[1];
assign wb_i1_reso_info[2] = wb_i1_reso_info_reg[2];
assign wb_i1_reso_info[3] = wb_i1_reso_info_reg[3];
assign wb_i1_reso_info[4] = wb_i1_reso_info_reg[4];
assign wb_i1_reso_info[5 +:2] = wb_i1_reso_info_reg[5 +:2];
assign wb_i1_reso_info[7] = wb_i1_reso_info_reg[7];
assign wb_i1_reso_info[8] = wb_i1_reso_info_reg[8];
assign wb_i1_reso_info[9] = wb_i1_reso_info_reg[9];
assign wb_i1_reso_info[10] = wb_i1_reso_info_reg[10];
assign wb_i0_reso_info[11] = wb_i0_mispred & ~wb_i0_calu_taken;
assign wb_i1_reso_info[11] = wb_i1_mispred;
assign wb_i0_reso_info[12] = wb_btb_update_p0;
assign wb_i1_reso_info[12] = wb_btb_update_p1;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mdu_retired <= 1'b0;
    end
    else begin
        mdu_retired <= mdu_retired_nx;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        core_wfi_mode <= 1'b0;
    end
    else if (core_wfi_mode_en) begin
        core_wfi_mode <= core_wfi_mode_nx;
    end
end

assign wb_i0_micro = wb_i0_ctrl[108 +:2] != 2'b11;
assign wb_i0_micro_last = wb_i0_ctrl[108 +:2] == 2'b01;
assign wb_i0_micro_seg = wb_i0_ctrl[108 +:2];
assign wb_i0_seg_end = wb_i0_micro_seg[0];
assign wb_i1_micro = wb_i1_ctrl[108 +:2] != 2'b11;
assign wb_i1_micro_seg = wb_i1_ctrl[108 +:2];
assign wb_i1_seg_end = wb_i1_micro_seg[0];
assign wb_i0_pc_en = resume | wb_i0_doable & wb_i0_seg_end | (lx_i0_valid & wb_i0_pc_vec);
assign wb_i0_pc_nx = resume ? resume_pc : wb_i0_pc_vec ? lx_i0_pc : wb_i1_doable ? wb_i1_npc : wb_i0_npc;
assign wb_i0_pc_vec_nx = resume ? resume_vectored : 1'b0;
assign wb_i0_target_misaligned = wb_i0_reso_info[0] & wb_i0_val[1] & ~rvc_en;
assign wb_i1_target_misaligned = wb_i1_reso_info[0] & wb_i1_val[1] & ~rvc_en;
assign wb_i0_calu_taken = wb_i0_ctrl[38] & wb_i0_reso_info[0];
assign wb_i0_npc = wb_i0_reso_info[0] ? wb_i0_val[EXTVALEN - 1:0] : wb_i0_seq_npc[EXTVALEN - 1:0];
assign wb_i1_npc = wb_i1_reso_info[0] ? wb_i1_val[EXTVALEN - 1:0] : wb_i1_seq_npc[EXTVALEN - 1:0];
assign wb_i0_redirect = (wb_i0_doable & wb_i0_mispred & ~wb_i0_calu_taken & wb_i0_ctrl[102] & ~wb_i0_target_misaligned) | (wb_i0_doable & wb_i0_mispred & ~wb_i0_calu_taken & wb_i0_tb_mispred & ~wb_i0_target_misaligned) | (wb_i0_doable & wb_i0_mispred & wb_i0_ctrl[102] & wb_i0_ctrl[9]);
assign wb_i1_redirect = (wb_i1_valid & ~wb_i0_kill & ~wb_i1_abort & wb_i1_mispred & wb_i1_ctrl[102] & ~wb_i1_target_misaligned) | (wb_i1_valid & ~wb_i0_kill & ~wb_i1_abort & wb_i1_mispred & wb_i1_tb_mispred & ~wb_i1_target_misaligned) | (wb_i1_valid & ~wb_i0_kill & ~wb_i1_abort & wb_i1_mispred & wb_i1_ctrl[102] & wb_i0_ctrl[9]);
assign wb_i0_redirect_pc_hit_ilm = wb_i0_reso_info[0] ? wb_i0_reso_info[7] : wb_i0_reso_info[8];
assign wb_i1_redirect_pc_hit_ilm = wb_i1_reso_info[0] ? wb_i1_reso_info[7] : wb_i1_reso_info[8];
assign wb_i0_ras_ptr = wb_i0_ctrl[123 +:3];
assign wb_i1_ras_ptr = wb_i1_ctrl[123 +:3];
assign async_ready = ~csr_halt_mode & ~(wb_i0_valid & wb_i0_resume) & ~(wb_i1_valid & wb_i1_resume) & ~(wb_i0_valid & wb_i0_postsync[0]) & ~wb_postsync_resume & ~wb_async_stall & ~wb_i0_pc_vec & ~int_taken_mask & ~(ii_valid[0] & ii_i0_ctrl[0] & ace_sync_ack) & ~(ex_valid[0] & ex_i0_ctrl[0]) & ~(mm_valid[0] & mm_i0_ctrl[0]) & ~(lx_valid[0] & lx_i0_ctrl[0]) & ifu_ipipe_init_done & ~ii_i0_trace_stall;
assign core_wfi_mode_set = wfi_enabled & biu_ipipe_standby_ready & ifu_ipipe_standby_ready & mmu_ipipe_standby_ready & fpu_ipipe_standby_ready & ls_standby_ready & (ace_standby_ready & ~ace_cmd_valid);
assign core_wfi_mode_clr = wfi_done | ~wfi_enabled;
assign core_wfi_mode_nx = ~core_wfi_mode_clr & (core_wfi_mode | core_wfi_mode_set);
assign core_wfi_mode_en = core_wfi_mode_set | core_wfi_mode_clr;
assign mdu_resp_return = mdu_resp_valid & mdu_resp_ready;
assign mdu_inst_retire = (wb_i0_doable & wb_i0_ctrl[104]) | (wb_i1_doable & wb_i1_ctrl[104]);
assign mdu_retired_nx = mdu_inst_retire | (mdu_retired & ~mdu_resp_return);
assign mdu_resp_ready = mdu_retired & ~nbload_resp_valid;
assign mdu_uins_retire = (wb_i0_doable & wb_i0_ctrl[104] & wb_i0_micro) | (wb_i1_doable & wb_i1_ctrl[104] & wb_i1_micro);
assign mdu_uins_wr_rf_en = mdu_uins_wr_rf_set | mdu_uins_wr_rf_clr;
assign mdu_uins_wr_rf_set = mdu_uins_retire;
assign mdu_uins_wr_rf_clr = mdu_resp_return | mdu_kill;
assign mdu_uins_wr_rf_nx = mdu_uins_wr_rf_set & ~mdu_uins_wr_rf_clr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mdu_uins_wr_rf <= 1'b0;
    end
    else if (mdu_uins_wr_rf_en) begin
        mdu_uins_wr_rf <= mdu_uins_wr_rf_nx;
    end
end

assign mdu_uins_rf_we_en = mdu_uins_rf_we_set | mdu_uins_rf_we_clr;
assign mdu_uins_rf_we_set = mdu_resp_return;
assign mdu_uins_rf_we_clr = (mdu_uins_retire | mdu_uins_wr_rf) & wb_async_taken;
assign mdu_uins_rf_we_nx = mdu_uins_rf_we_set | ~mdu_uins_rf_we_clr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mdu_uins_rf_we <= 1'b1;
    end
    else if (mdu_uins_rf_we_en) begin
        mdu_uins_rf_we <= mdu_uins_rf_we_nx;
    end
end

reg resume_d1;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        resume_d1 <= 1'b0;
    end
    else begin
        resume_d1 <= resume;
    end
end

assign rf_sdw_recover = resume_d1;
assign rf_we1 = (wb_i0_doable & wb_i0_ctrl[131]);
assign rf_waddr1 = wb_i0_ctrl[126 +:5];
assign rf_wdata1 = wb_rd1_wdata;
assign wb_rf_we2 = (wb_i0_doable & wb_i0_ctrl[137]) | (wb_i1_doable & wb_i1_ctrl[131]);
assign rf_we2 = wb_rf_we2 | ace_xrf_rd2_valid;
assign rf_waddr2 = (wb_i0_ctrl[137] & wb_i0_doable) ? wb_i0_ctrl[132 +:5] : (wb_i1_ctrl[131] & wb_i1_doable) ? wb_i1_ctrl[126 +:5] : ace_xrf_rd2_index;
assign rf_wdata2 = wb_rf_we2 ? wb_rd2_wdata : ace_xrf_rd2_data;
assign rf_we3 = mdu_resp_return | nbload_resp_valid | ace_resp_rd1_valid | (vpu_srf_wvalid & ~vpu_srf_wfrf);
assign rf_waddr3 = nbload_resp_valid ? nbload_resp_rd : mdu_resp_return ? mdu_resp_tag : ace_resp_rd1_valid ? ace_xrf_rd1_index : vpu_srf_waddr;
assign rf_wdata3 = nbload_resp_valid ? nbload_resp_result : mdu_resp_return ? mdu_resp_result : ace_resp_rd1_valid ? ace_xrf_rd1_data : vpu_srf_wdata[31:0];
assign rf_wstatus3 = nbload_resp_valid ? nbload_resp_status : mdu_resp_return ? ~mdu_uins_rf_we : ace_resp_rd1_valid ? ace_xrf_rd1_status : 1'b0;
assign vpu_srf_wready = ~(nbload_resp_valid | mdu_resp_return | ace_resp_rd1_valid);
assign rf_wstatus1[0] = wb_i0_ctrl[104] | wb_i0_ctrl[111] | wb_i0_ctrl[93];
assign rf_wstatus1[1] = wb_i0_ctrl[131] & wb_i0_doable & wb_i0_xreg_backup;
assign rf_wstatus2[0] = wb_i1_ctrl[104] & wb_i1_doable & ~wb_i0_ctrl[137] | wb_i1_ctrl[111] & wb_i1_doable & ~wb_i0_ctrl[137] | wb_i1_ctrl[93] & wb_i1_doable & wb_i1_ctrl[131] & ~wb_i0_ctrl[137] | wb_i0_ctrl[93] & wb_i0_doable & wb_i0_ctrl[137] | ~wb_rf_we2 & ace_xrf_rd2_status;
assign rf_wstatus2[1] = wb_i1_ctrl[131] & wb_i1_doable & wb_i1_xreg_backup;
assign wb_rd1_wdata = wb_rd1_wdata_reg;
assign wb_rd2_wdata = wb_rd2_wdata_reg;
assign wb_i0_alive = wb_i0_valid;
assign wb_i1_alive = wb_i1_valid & ~wb_i0_kill & ~wb_i0_calu_taken;
assign wb_i0_doable = wb_i0_alive & ~wb_i0_abort;
assign wb_i1_doable = wb_i1_alive & ~wb_i1_abort;
assign wb_i0_retire = wb_i0_doable & wb_i0_seg_end;
assign wb_i1_retire = wb_i1_doable & wb_i0_seg_end;
assign wb_i0_nbload = wb_i0_ctrl[111];
assign wb_i1_nbload = wb_i1_ctrl[111];
assign wb_i0_kill = (wb_i0_alive & wb_i0_resume) | (wb_i0_doable & wb_i0_mispred & ~wb_i0_calu_taken & wb_i0_ctrl[102]) | (wb_i0_doable & wb_i0_mispred & ~wb_i0_calu_taken & wb_i0_tb_mispred) | (wb_i0_doable & wb_i0_mispred & wb_i0_ctrl[102] & wb_i0_ctrl[9]) | wb_postsync_resume;
assign wb_i1_kill = (wb_i1_alive & wb_i1_resume) | (wb_i1_valid & ~wb_i0_kill & ~wb_i1_abort & wb_i1_mispred & wb_i1_ctrl[102]) | (wb_i1_valid & ~wb_i0_kill & ~wb_i1_abort & wb_i1_mispred & wb_i1_tb_mispred) | (wb_i1_valid & ~wb_i0_kill & ~wb_i1_abort & wb_i1_mispred & wb_i1_ctrl[102] & wb_i0_ctrl[9]);
assign wb_kill = wb_i0_kill | wb_i1_kill | wb_async_taken;
assign wb_ras_ptr = (wb_i0_resume) ? wb_i0_ctrl[123 +:3] : wb_i1_ctrl[123 +:3];
assign wb_i0_trace_trigger = {wb_i0_ctrl[145],wb_i0_ctrl[146],wb_i0_ctrl[147]};
assign wb_i1_trace_trigger = {wb_i1_ctrl[145],wb_i1_ctrl[146],wb_i1_ctrl[147]};
assign uinstr_flush = resume | mm_redirect_final & ~mm_non_pp_uinstr | wb_redirect & ~wb_i0_non_pp_micro;
assign uinstr_done = wb_i0_doable & wb_i0_non_pp_micro_last;
assign resume = (wb_i0_alive & wb_i0_resume) | (wb_i1_alive & wb_i1_resume) | (wb_postsync_resume) | wb_async_taken;
assign resume_for_replay = (wb_i0_alive & ~wb_i0_ctrl[106] & wb_i0_ctrl[138]) | (wb_i1_alive & ~wb_i1_ctrl[106] & wb_i1_ctrl[138]);
assign wb_i0_resume = wb_i0_ctrl[106] | wb_i0_ctrl[149] | wb_i0_ctrl[138] | wb_i0_ctrl[66] | wb_i0_ctrl[110] | wb_i0_ctrl[144] | wb_i0_ctrl[148] | wb_postsync_resume;
assign wb_i1_resume = wb_i1_ctrl[106] | wb_i1_ctrl[149] | wb_i1_ctrl[138] | wb_i1_ctrl[66] | wb_i1_ctrl[110] | wb_i1_ctrl[144] | wb_i1_ctrl[148];
assign wb_i0_abort = wb_i0_ctrl[149] | wb_i0_ctrl[138] | wb_i0_ctrl[106];
assign wb_i1_abort = wb_i1_ctrl[149] | wb_i1_ctrl[138] | wb_i1_ctrl[106] | wb_postsync_resume;
reg wb_postsync_resume_reg;
wire wb_postsync_resume_nx = wb_i0_postsync[0] & wb_i0_doable & ~wb_postsync_resume;
assign wb_postsync_resume = wb_postsync_resume_reg;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        wb_postsync_resume_reg <= 1'b0;
    end
    else begin
        wb_postsync_resume_reg <= wb_postsync_resume_nx;
    end
end

kv_sign_ext #(
    .OW(32),
    .IW(EXTVALEN)
) u_i0_seq_npc_sext (
    .out(wb_i0_seq_npc_sext),
    .in(wb_i0_seq_npc)
);
kv_sign_ext #(
    .OW(32),
    .IW(EXTVALEN)
) u_11_seq_npc_sext (
    .out(wb_i1_seq_npc_sext),
    .in(wb_i1_seq_npc)
);
assign wb_i0_fetch_fault_pc_sext = wb_i0_ctrl[85] ? {wb_i0_seq_npc_sext[31:3],3'd0} : wb_i0_val_sext;
assign wb_i1_fetch_fault_pc_sext = wb_i1_ctrl[85] ? {wb_i1_seq_npc_sext[31:3],3'd0} : wb_i1_val_sext;
kv_sign_ext #(
    .OW(32),
    .IW(EXTVALEN)
) u_i0_addr_zext (
    .out(wb_i0_val_sext),
    .in(wb_i0_val)
);
kv_sign_ext #(
    .OW(32),
    .IW(EXTVALEN)
) u_11_addr_zext (
    .out(wb_i1_val_sext),
    .in(wb_i1_val)
);
assign wb_i0_tval = ({32{wb_i0_ctrl[39 +:6] == 6'h2}} & wb_i0_val_sext) | ({32{wb_i0_ctrl[39 +:6] == 6'h1}} & wb_i0_fetch_fault_pc_sext) | ({32{wb_i0_ctrl[39 +:6] == 6'h3}} & wb_i0_val_sext) | ({32{wb_i0_ctrl[39 +:6] == 6'h0}} & wb_i0_val_sext) | ({32{wb_i0_ctrl[39 +:6] == 6'h4}} & wb_i0_val_sext) | ({32{wb_i0_ctrl[39 +:6] == 6'h6}} & wb_i0_val_sext) | ({32{wb_i0_ctrl[39 +:6] == 6'h5}} & wb_i0_val_sext) | ({32{wb_i0_ctrl[39 +:6] == 6'h7}} & wb_i0_val_sext) | ({32{wb_i0_ctrl[39 +:6] == 6'hc}} & wb_i0_fetch_fault_pc_sext) | ({32{wb_i0_ctrl[39 +:6] == 6'hd}} & wb_i0_val_sext) | ({32{wb_i0_ctrl[39 +:6] == 6'hf}} & wb_i0_val_sext);
assign wb_i1_tval = ({32{wb_i1_ctrl[39 +:6] == 6'h2}} & wb_i1_val_sext) | ({32{wb_i1_ctrl[39 +:6] == 6'h1}} & wb_i1_fetch_fault_pc_sext) | ({32{wb_i1_ctrl[39 +:6] == 6'h3}} & wb_i1_val_sext) | ({32{wb_i1_ctrl[39 +:6] == 6'h0}} & wb_i1_val_sext) | ({32{wb_i1_ctrl[39 +:6] == 6'h4}} & wb_i1_val_sext) | ({32{wb_i1_ctrl[39 +:6] == 6'h6}} & wb_i1_val_sext) | ({32{wb_i1_ctrl[39 +:6] == 6'h5}} & wb_i1_val_sext) | ({32{wb_i1_ctrl[39 +:6] == 6'h7}} & wb_i1_val_sext) | ({32{wb_i1_ctrl[39 +:6] == 6'hc}} & wb_i1_fetch_fault_pc_sext) | ({32{wb_i1_ctrl[39 +:6] == 6'hd}} & wb_i1_val_sext) | ({32{wb_i1_ctrl[39 +:6] == 6'hf}} & wb_i1_val_sext);
assign wb_async_taken = async_valid & async_ready;
assign mm_redirect_issued_nx = lx_stall & (mm_redirect | mm_redirect_issued);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mm_redirect_issued <= 1'b0;
    end
    else begin
        mm_redirect_issued <= mm_redirect_issued_nx;
    end
end

assign redirect_ras_ptr = wb_i0_redirect ? wb_i0_ras_ptr[1:0] : wb_i1_redirect ? wb_i1_ras_ptr[1:0] : mm_i0_redirect_final ? mm_i0_ras_ptr[1:0] : mm_i1_redirect_final ? mm_i1_ras_ptr[1:0] : tb_ras_ptr;
assign mm_redirect = mm_i0_redirect_final | mm_i1_redirect_final;
assign wb_redirect = wb_i0_redirect | wb_i1_redirect;
assign mm_redirect_final = mm_redirect & ~mm_redirect_issued;
assign mm_i0_redirect_final = (mm_i0_redirect & ~mm_redirect_issued);
assign mm_i1_redirect_final = (mm_i1_redirect & ~mm_redirect_issued);
assign tb_redirect = 1'b0;
assign tb_redirect_for_cti = 1'b0;
assign tb_redirect_pc = {EXTVALEN{1'b0}};
assign tb_redirect_hit_ilm = 1'b0;
assign tb_ras_ptr = 2'b0;
assign tb_fdiv_resp_ready = 1'b1;
assign redirect = mm_redirect_final & ~mm_non_pp_uinstr | wb_redirect & ~wb_i0_non_pp_micro | tb_redirect;
assign uinstr_redirect = mm_redirect_final & mm_non_pp_uinstr | wb_redirect & wb_i0_non_pp_micro;
assign redirect_for_cti = wb_i0_redirect ? (wb_i0_ctrl[37] | wb_i0_ctrl[11]) & ~wb_i0_non_pp_micro : wb_i1_redirect ? (wb_i1_ctrl[37] | wb_i1_ctrl[11]) & ~wb_i0_non_pp_micro : mm_i0_redirect_final ? (mm_i0_ctrl[74] | mm_i0_ctrl[47]) & ~mm_non_pp_uinstr : mm_i1_redirect_final ? (mm_i1_ctrl[74] | mm_i1_ctrl[47]) & ~mm_non_pp_uinstr : tb_redirect_for_cti;
assign redirect_pc = wb_i0_redirect ? wb_i0_npc : wb_i1_redirect ? wb_i1_npc : mm_i0_redirect_final ? mm_i0_npc : mm_i1_redirect_final ? mm_i1_npc : tb_redirect_pc;
assign redirect_pc_hit_ilm = wb_i0_redirect ? wb_i0_redirect_pc_hit_ilm : wb_i1_redirect ? wb_i1_redirect_pc_hit_ilm : mm_i0_redirect_final ? mm_i0_redirect_pc_hit_ilm : mm_i1_redirect_final ? mm_i1_redirect_pc_hit_ilm : tb_redirect_hit_ilm;
reg [7:0] mm_bhr;
wire [7:0] mm_bhr_nx;
wire mm_bhr_update;
wire mm_i0_bhr_update;
wire mm_i0_br_taken = mm_i0_ctrl[149] ? mm_i0_reso_info[0] : mm_i0_pred_info[1];
wire mm_i1_bhr_update;
wire mm_i1_br_taken = mm_i1_ctrl[149] ? mm_i1_reso_info[0] : mm_i1_pred_info[1];
wire [7:0] mm_i0_bhr_nx;
wire [7:0] mm_i1_bhr_nx;
wire mm_bhr_recover;
wire [7:0] mm_bhr_recover_data;
wire wb_bhr_recover;
wire [7:0] wb_bhr_recover_data;
wire mm_i0_bhr_valid;
wire mm_i1_bhr_valid;
assign mm_i0_bhr_valid = mm_i0_reso_info[2] & ~mm_i0_pred_info[6] & ~mm_i0_pred_info[10] & mm_i0_pred_info[0] & mm_i0_ctrl[149];
assign mm_i1_bhr_valid = mm_i1_reso_info[2] & ~mm_i1_pred_info[6] & ~mm_i1_pred_info[10] & mm_i1_pred_info[0] & mm_i1_ctrl[149];
assign mm_i0_bhr_update = (mm_i0_bhr_valid & mm_doable[0] & csr_mmisc_ctl_brpe & ~csr_halt_mode & mm_i0_ctrl[149] & ~mm_non_pp_uinstr) | (mm_i0_ctrl[47] & mm_i0_pred_info[0] & mm_doable[0] & csr_mmisc_ctl_brpe & ~csr_halt_mode & ~mm_non_pp_uinstr);
assign mm_i1_bhr_update = (mm_i1_bhr_valid & mm_doable[1] & csr_mmisc_ctl_brpe & ~csr_halt_mode & mm_i1_ctrl[149] & ~mm_non_pp_uinstr) | (mm_i1_ctrl[47] & mm_i1_pred_info[0] & mm_doable[1] & csr_mmisc_ctl_brpe & ~csr_halt_mode & ~mm_non_pp_uinstr);
assign mm_bhr_update = (mm_i0_bhr_update | mm_i1_bhr_update) & ~lx_stall | wb_bhr_recover;
assign mm_i0_bhr_nx = {mm_i0_br_taken,mm_bhr[7:1]};
assign mm_i1_bhr_nx = mm_i0_bhr_update ? {mm_i1_br_taken,mm_i0_bhr_nx[7:1]} : {mm_i1_br_taken,mm_bhr[7:1]};
assign mm_bhr_nx = wb_bhr_recover ? wb_bhr_recover_data : mm_i1_bhr_update ? mm_i1_bhr_nx : mm_i0_bhr_update ? mm_i0_bhr_nx : mm_bhr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mm_bhr <= 8'd0;
    end
    else if (mm_bhr_update) begin
        mm_bhr <= mm_bhr_nx;
    end
end

assign mm_bhr_recover = (mm_i0_redirect_final | mm_i1_redirect_final) & ~mm_redirect_issued & ~resume;
assign mm_bhr_recover_data = mm_i0_redirect_final ? mm_i0_bhr_update ? mm_i0_bhr_nx : mm_bhr : mm_i1_bhr_update ? mm_i1_bhr_nx : mm_i0_bhr_update ? mm_i0_bhr_nx : mm_bhr;
wire mm_i0_start = mm_i0_ctrl[180];
wire mm_i1_start = mm_i1_ctrl[180];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mm_btb_update_issued <= 1'b0;
    end
    else begin
        mm_btb_update_issued <= mm_btb_update_issued_nx;
    end
end

assign mm_btb_update_issued_set = (mm_btb_update_p0 | mm_btb_update_p1) & lx_stall;
assign mm_btb_update_issued_clr = ~lx_stall;
assign mm_btb_update_issued_nx = (mm_btb_update_issued | mm_btb_update_issued_set) & ~mm_btb_update_issued_clr;
assign mm_i0_bblk_start_pc = mm_i0_start ? mm_i0_pc[VALEN - 1:0] : mm_bblk_start_pc;
assign mm_i1_bblk_start_pc = mm_i1_start ? mm_i1_pc[VALEN - 1:0] : mm_i0_start ? mm_i0_pc[VALEN - 1:0] : mm_bblk_start_pc;
wire mm_i0_16b = mm_i0_ctrl[43];
wire [VALEN - 1:0] mm_i0_fall_thru_offset;
wire mm_i0_fall_thru_offset_overflow;
wire mm_i0_start_pc_valid;
wire mm_i0_is_start;
wire mm_i1_16b = mm_i1_ctrl[43];
wire [VALEN - 1:0] mm_i1_fall_thru_offset;
wire mm_i1_fall_thru_offset_overflow;
wire mm_i1_start_pc_valid;
wire mm_i1_is_start;
reg mm_start_pc_valid_keep;
wire mm_start_pc_valid_keep_set;
wire mm_start_pc_valid_keep_clr;
wire mm_start_pc_valid_keep_nx;
assign mm_i0_seq_npc = mm_i0_pc[EXTVALEN - 1:0] + {{(EXTVALEN - 3){1'b0}},~mm_i0_16b,mm_i0_16b,1'b0};
assign mm_i0_fall_thru_offset = mm_i0_start ? {{(VALEN - 3){1'b0}},~mm_i0_16b,mm_i0_16b,1'b0} : mm_i0_seq_npc[VALEN - 1:0] - mm_bblk_start_pc[VALEN - 1:0];
assign mm_i0_fall_thru_offset_overflow = rvc_en ? (|mm_i0_fall_thru_offset[VALEN - 1:11]) : (|mm_i0_fall_thru_offset[VALEN - 1:12]);
assign mm_i1_seq_npc = mm_i1_pc[EXTVALEN - 1:0] + {{(EXTVALEN - 3){1'b0}},~mm_i1_16b,mm_i1_16b,1'b0};
assign mm_i1_fall_thru_offset = mm_i1_start ? {{(VALEN - 3){1'b0}},~mm_i1_16b,mm_i1_16b,1'b0} : mm_i0_start ? {{(VALEN - 3){1'b0}},~mm_i1_16b,mm_i1_16b,1'b0} + {{(VALEN - 3){1'b0}},~mm_i0_16b,mm_i0_16b,1'b0} : mm_i1_seq_npc[VALEN - 1:0] - mm_bblk_start_pc[VALEN - 1:0];
assign mm_i1_fall_thru_offset_overflow = rvc_en ? (|mm_i1_fall_thru_offset[VALEN - 1:11]) : (|mm_i1_fall_thru_offset[VALEN - 1:12]);
assign mm_i0_is_start = mm_i0_start & csr_mmisc_ctl_brpe & ~csr_halt_mode & mm_doable[0];
assign mm_i1_is_start = mm_i1_start & csr_mmisc_ctl_brpe & ~csr_halt_mode & mm_doable[1];
assign mm_bblk_start_pc_update = mm_i0_is_start | mm_i1_is_start;
assign mm_bblk_start_pc_nx = (mm_i1_start & mm_doable[1]) ? mm_i1_pc[VALEN - 1:0] : mm_i0_pc[VALEN - 1:0];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mm_bblk_start_pc <= {VALEN{1'b0}};
    end
    else if (mm_bblk_start_pc_update) begin
        mm_bblk_start_pc <= mm_bblk_start_pc_nx;
    end
end

assign mm_start_pc_valid_keep_set = mm_bblk_start_pc_update;
assign mm_start_pc_valid_keep_clr = resume | (mm_i0_ctrl[179] & mm_doable[0]) | (mm_i1_ctrl[179] & mm_doable[1]);
assign mm_start_pc_valid_keep_nx = (mm_start_pc_valid_keep | mm_start_pc_valid_keep_set) & ~mm_start_pc_valid_keep_clr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mm_start_pc_valid_keep <= 1'b0;
    end
    else begin
        mm_start_pc_valid_keep <= mm_start_pc_valid_keep_nx;
    end
end

wire mm_btb_update_i0_invalid;
wire mm_btb_update_i0_alloc;
wire mm_btb_update_i0_revise;
kv_btb_update_ctrl u_kv_btb_update_ctrl_0(
    .reso_info(mm_i0_reso_info),
    .pred_info(mm_i0_pred_info),
    .invalid(mm_btb_update_i0_invalid),
    .alloc(mm_btb_update_i0_alloc),
    .revise(mm_btb_update_i0_revise),
    .way(mm_btb_update_p0_way),
    .call(mm_btb_update_p0_call),
    .ret(mm_btb_update_p0_ret),
    .ucond(mm_btb_update_p0_ucond),
    .mispred(mm_i0_btb_mispred)
);
assign mm_i0_tb_mispred = 1'b0;
assign mm_i0_mispred = mm_i0_btb_mispred | mm_i0_tb_mispred;
assign mm_i0_start_pc_valid = mm_i0_is_start | mm_start_pc_valid_keep;
assign mm_btb_update_p0_invalid = (mm_btb_update_i0_invalid & ~mm_i0_tb_mispred) & mm_i0_ctrl[149] & mm_i0_valid & ~mm_btb_update_issued & ~mm_non_pp_uinstr;
assign mm_btb_update_p0_valid = (mm_btb_update_i0_alloc | mm_btb_update_i0_revise) & ~mm_i0_tb_mispred & mm_i0_ctrl[149] & ~mm_i0_ctrl[179] & mm_i0_start_pc_valid & mm_doable[0] & csr_mmisc_ctl_brpe & ~csr_halt_mode & ~mm_btb_update_issued & ~mm_i0_ctrl[87] & ~mm_i0_fall_thru_offset_overflow & ~mm_non_pp_uinstr;
assign mm_btb_update_p0 = mm_btb_update_p0_invalid | mm_btb_update_p0_valid;
assign mm_btb_update_p0_alloc = mm_btb_update_i0_alloc;
assign mm_btb_update_p0_start_pc = mm_i0_bblk_start_pc;
assign mm_btb_update_p0_blk_offset = rvc_en ? mm_i0_fall_thru_offset[10:1] : mm_i0_fall_thru_offset[11:2];
assign mm_btb_update_p0_target_pc = mm_i0_npc[VALEN - 1:0];
wire mm_btb_update_i1_invalid;
wire mm_btb_update_i1_alloc;
wire mm_btb_update_i1_revise;
kv_btb_update_ctrl u_kv_btb_update_ctrl_1(
    .reso_info(mm_i1_reso_info),
    .pred_info(mm_i1_pred_info),
    .invalid(mm_btb_update_i1_invalid),
    .alloc(mm_btb_update_i1_alloc),
    .revise(mm_btb_update_i1_revise),
    .way(mm_btb_update_p1_way),
    .call(mm_btb_update_p1_call),
    .ret(mm_btb_update_p1_ret),
    .ucond(mm_btb_update_p1_ucond),
    .mispred(mm_i1_btb_mispred)
);
assign mm_i1_tb_mispred = 1'b0;
assign mm_i1_mispred = mm_i1_btb_mispred | mm_i1_tb_mispred;
assign mm_i1_start_pc_valid = mm_i0_is_start | mm_i1_is_start | mm_start_pc_valid_keep;
assign mm_btb_update_p1_invalid = (mm_btb_update_i1_invalid & ~(mm_i1_tb_mispred & ~mm_i1_mispred)) & mm_i1_ctrl[149] & mm_i1_valid & ~mm_btb_update_issued & ~mm_non_pp_uinstr;
assign mm_btb_update_p1_valid = (mm_btb_update_i1_alloc | mm_btb_update_i1_revise) & ~mm_i1_tb_mispred & mm_i1_ctrl[149] & ~mm_i0_ctrl[179] & ~mm_i1_ctrl[179] & mm_i1_start_pc_valid & mm_doable[1] & csr_mmisc_ctl_brpe & ~csr_halt_mode & ~mm_btb_update_issued & ~mm_i1_fall_thru_offset_overflow & ~mm_non_pp_uinstr;
assign mm_btb_update_p1 = mm_btb_update_p1_invalid | mm_btb_update_p1_valid;
assign mm_btb_update_p1_alloc = mm_btb_update_i1_alloc;
assign mm_btb_update_p1_start_pc = mm_i1_bblk_start_pc;
assign mm_btb_update_p1_blk_offset = rvc_en ? mm_i1_fall_thru_offset[10:1] : mm_i1_fall_thru_offset[11:2];
assign mm_btb_update_p1_target_pc = mm_i1_npc[VALEN - 1:0];
reg [7:0] wb_bhr;
wire [7:0] wb_bhr_nx;
wire wb_bhr_update;
wire wb_i0_bhr_update;
wire wb_i0_br_taken = wb_i0_reso_info[0];
wire wb_i1_bhr_update;
wire wb_i1_br_taken = wb_i1_reso_info[0];
wire [7:0] wb_i0_bhr_nx;
wire [7:0] wb_i1_bhr_nx;
wire wb_i0_bhr_valid;
wire wb_i1_bhr_valid;
assign wb_i0_bhr_valid = wb_i0_ctrl[11] & ~wb_i0_pred_info[6] & ~wb_i0_pred_info[10] & wb_i0_pred_info[0];
assign wb_i1_bhr_valid = wb_i1_ctrl[11] & ~wb_i1_pred_info[6] & ~wb_i1_pred_info[10] & wb_i1_pred_info[0];
assign wb_i0_bhr_update = wb_i0_bhr_valid & wb_i0_doable & csr_mmisc_ctl_brpe & ~csr_halt_mode & ~wb_i0_non_pp_micro;
assign wb_i1_bhr_update = wb_i1_bhr_valid & wb_i1_doable & csr_mmisc_ctl_brpe & ~csr_halt_mode & ~wb_i0_non_pp_micro;
assign wb_bhr_update = (wb_i0_bhr_update | wb_i1_bhr_update);
assign wb_i0_bhr_nx = {wb_i0_br_taken,wb_bhr[7:1]};
assign wb_i1_bhr_nx = wb_i0_bhr_update ? {wb_i1_br_taken,wb_i0_bhr_nx[7:1]} : {wb_i1_br_taken,wb_bhr[7:1]};
assign wb_bhr_nx = wb_i1_bhr_update ? wb_i1_bhr_nx : wb_i0_bhr_update ? wb_i0_bhr_nx : wb_bhr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        wb_bhr <= 8'd0;
    end
    else if (wb_bhr_update) begin
        wb_bhr <= wb_bhr_nx;
    end
end

assign wb_bhr_recover = (wb_i0_redirect | wb_i1_redirect) & ~resume;
assign wb_bhr_recover_data = wb_i0_redirect ? wb_i0_bhr_update ? wb_i0_bhr_nx : wb_bhr : wb_i1_bhr_update ? wb_i1_bhr_nx : wb_i0_bhr_update ? wb_i0_bhr_nx : wb_bhr;
assign bhr_recover = wb_bhr_recover | mm_bhr_recover;
assign bhr_recover_data = wb_bhr_recover ? wb_bhr_recover_data : mm_bhr_recover_data;
wire wb_i0_start = wb_i0_ctrl[122];
wire wb_i1_start = wb_i1_ctrl[122];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        wb_bht_btb_update_issued <= 1'b0;
    end
    else begin
        wb_bht_btb_update_issued <= wb_bht_btb_update_issued_nx;
    end
end

assign wb_bht_btb_update_issued_set = (wb_bht_update_p0 | wb_bht_update_p1 | wb_btb_update_p0 | wb_btb_update_p1) & lx_stall;
assign wb_bht_btb_update_issued_clr = ~lx_stall;
assign wb_bht_btb_update_issued_nx = (wb_bht_btb_update_issued | wb_bht_btb_update_issued_set) & ~wb_bht_btb_update_issued_clr;
assign wb_i0_bblk_start_pc = wb_i0_start ? wb_i0_pc[VALEN - 1:0] : wb_bblk_start_pc;
wire i0_sel_sat;
wire i0_dir_sat;
wire [1:0] i0_sel_data_incr1;
wire [1:0] i0_dir_data_incr1;
wire i1_sel_sat;
wire i1_dir_sat;
wire [1:0] i1_sel_data_incr1;
wire [1:0] i1_dir_data_incr1;
assign wb_i0_update_dir_addr = rvc_en ? wb_i0_bblk_start_pc[VALEN - 1:0] ^ {{(VALEN - 9){1'b0}},wb_bhr,1'b0} : wb_i0_bblk_start_pc[VALEN - 1:0] ^ {{(VALEN - 10){1'b0}},wb_bhr,2'b00};
assign wb_bht_update_p0 = wb_i0_ctrl[11] & ~wb_i0_pred_info[6] & wb_i0_pred_info[0] & (~i0_sel_sat | ~i0_dir_sat) & csr_mmisc_ctl_brpe & ~csr_halt_mode & ~wb_bht_btb_update_issued & wb_i0_start_pc_valid & ~wb_i0_ctrl[38] & wb_i0_doable & ~wb_i0_non_pp_micro;
assign i0_dir_sat = ({wb_i0_reso_info[0],wb_i0_pred_info[3:2]} == 3'b111) | ({wb_i0_reso_info[0],wb_i0_pred_info[3:2]} == 3'b000);
assign i0_sel_sat = ({wb_i0_reso_info[0],wb_i0_pred_info[5:4]} == 3'b111) | ({wb_i0_reso_info[0],wb_i0_pred_info[5:4]} == 3'b000);
assign i0_dir_data_incr1 = 2'b01 & {~i0_dir_sat,~i0_dir_sat};
assign i0_sel_data_incr1 = 2'b01 & {~i0_sel_sat,~i0_sel_sat};
assign wb_bht_update_p0_dir_data = wb_i0_reso_info[0] ? wb_i0_pred_info[3:2] + i0_dir_data_incr1 : wb_i0_pred_info[3:2] - i0_dir_data_incr1;
assign wb_bht_update_p0_sel_data = wb_i0_reso_info[0] ? wb_i0_pred_info[5:4] + i0_sel_data_incr1 : wb_i0_pred_info[5:4] - i0_sel_data_incr1;
assign wb_bht_update_p0_dir_addr = rvc_en ? wb_i0_update_dir_addr[8:1] : wb_i0_update_dir_addr[9:2];
assign wb_bht_update_p0_sel_addr = rvc_en ? wb_i0_bblk_start_pc[8:1] : wb_i0_bblk_start_pc[9:2];
assign wb_i1_bblk_start_pc = wb_i1_start ? wb_i1_pc[VALEN - 1:0] : wb_i0_start ? wb_i0_pc[VALEN - 1:0] : wb_bblk_start_pc;
assign wb_i1_update_dir_addr = wb_i0_bhr_update ? rvc_en ? wb_i1_bblk_start_pc[VALEN - 1:0] ^ {{(VALEN - 9){1'b0}},wb_i0_bhr_nx,1'b0} : wb_i1_bblk_start_pc[VALEN - 1:0] ^ {{(VALEN - 10){1'b0}},wb_i0_bhr_nx,2'b00} : rvc_en ? wb_i1_bblk_start_pc[VALEN - 1:0] ^ {{(VALEN - 9){1'b0}},wb_bhr,1'b0} : wb_i1_bblk_start_pc[VALEN - 1:0] ^ {{(VALEN - 10){1'b0}},wb_bhr,2'b00};
assign wb_bht_update_p1 = wb_i1_ctrl[11] & ~wb_i1_pred_info[6] & (~i1_sel_sat | ~i1_dir_sat) & wb_i1_pred_info[0] & ~resume & csr_mmisc_ctl_brpe & ~csr_halt_mode & ~wb_bht_btb_update_issued & wb_i1_start_pc_valid & wb_i1_doable & ~wb_i0_non_pp_micro;
assign i1_dir_sat = ({wb_i1_reso_info[0],wb_i1_pred_info[3:2]} == 3'b111) | ({wb_i1_reso_info[0],wb_i1_pred_info[3:2]} == 3'b000);
assign i1_sel_sat = ({wb_i1_reso_info[0],wb_i1_pred_info[5:4]} == 3'b111) | ({wb_i1_reso_info[0],wb_i1_pred_info[5:4]} == 3'b000);
assign i1_dir_data_incr1 = 2'b01 & {~i1_dir_sat,~i1_dir_sat};
assign i1_sel_data_incr1 = 2'b01 & {~i1_sel_sat,~i1_sel_sat};
assign wb_bht_update_p1_dir_data = wb_i1_reso_info[0] ? wb_i1_pred_info[3:2] + i1_dir_data_incr1 : wb_i1_pred_info[3:2] - i1_dir_data_incr1;
assign wb_bht_update_p1_sel_data = wb_i1_reso_info[0] ? wb_i1_pred_info[5:4] + i1_sel_data_incr1 : wb_i1_pred_info[5:4] - i1_sel_data_incr1;
assign wb_bht_update_p1_dir_addr = rvc_en ? wb_i1_update_dir_addr[8:1] : wb_i1_update_dir_addr[9:2];
assign wb_bht_update_p1_sel_addr = rvc_en ? wb_i1_bblk_start_pc[8:1] : wb_i1_bblk_start_pc[9:2];
assign bht_update_p0 = wb_bht_update_p0;
assign bht_update_p0_sel_data = wb_bht_update_p0_sel_data;
assign bht_update_p0_dir_data = wb_bht_update_p0_dir_data;
assign bht_update_p0_dir_addr = wb_bht_update_p0_dir_addr;
assign bht_update_p0_sel_addr = wb_bht_update_p0_sel_addr;
assign bht_update_p1 = wb_bht_update_p1;
assign bht_update_p1_sel_data = wb_bht_update_p1_sel_data;
assign bht_update_p1_dir_data = wb_bht_update_p1_dir_data;
assign bht_update_p1_dir_addr = wb_bht_update_p1_dir_addr;
assign bht_update_p1_sel_addr = wb_bht_update_p1_sel_addr;
assign wb_i0_seq_npc = wb_i0_pc[EXTVALEN - 1:0] + {{(EXTVALEN - 3){1'b0}},~wb_i0_16b,wb_i0_16b,1'b0};
assign wb_i0_fall_thru_offset = wb_i0_start ? {{(VALEN - 3){1'b0}},~wb_i0_16b,wb_i0_16b,1'b0} : wb_i0_seq_npc[VALEN - 1:0] - wb_bblk_start_pc;
assign wb_i0_fall_thru_offset_overflow = rvc_en ? (|wb_i0_fall_thru_offset[VALEN - 1:11]) : (|wb_i0_fall_thru_offset[VALEN - 1:12]);
assign wb_i1_seq_npc = wb_i1_pc[EXTVALEN - 1:0] + {{(EXTVALEN - 3){1'b0}},~wb_i1_16b,wb_i1_16b,1'b0};
assign wb_i1_fall_thru_offset = wb_i1_start ? {{(VALEN - 3){1'b0}},~wb_i1_16b,wb_i1_16b,1'b0} : wb_i0_start ? {{(VALEN - 3){1'b0}},~wb_i1_16b,wb_i1_16b,1'b0} + {{(VALEN - 3){1'b0}},~wb_i0_16b,wb_i0_16b,1'b0} : wb_i1_seq_npc[VALEN - 1:0] - wb_bblk_start_pc;
assign wb_i1_fall_thru_offset_overflow = rvc_en ? (|wb_i1_fall_thru_offset[VALEN - 1:11]) : (|wb_i1_fall_thru_offset[VALEN - 1:12]);
assign wb_i0_is_start = wb_i0_start & csr_mmisc_ctl_brpe & ~csr_halt_mode & wb_i0_doable;
assign wb_i1_is_start = wb_i1_start & csr_mmisc_ctl_brpe & ~csr_halt_mode & wb_i1_doable;
assign wb_bblk_start_pc_update = wb_i0_is_start | wb_i1_is_start;
assign wb_bblk_start_pc_nx = (wb_i1_start & wb_i1_doable) ? wb_i1_pc[VALEN - 1:0] : wb_i0_pc[VALEN - 1:0];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        wb_bblk_start_pc <= {VALEN{1'b0}};
    end
    else if (wb_bblk_start_pc_update) begin
        wb_bblk_start_pc <= wb_bblk_start_pc_nx;
    end
end

assign wb_start_pc_valid_keep_set = wb_bblk_start_pc_update;
assign wb_start_pc_valid_keep_clr = resume | (wb_i0_ctrl[121] & wb_i0_doable) | (wb_i1_ctrl[121] & wb_i1_doable);
assign wb_start_pc_valid_keep_nx = (wb_start_pc_valid_keep | wb_start_pc_valid_keep_set) & ~wb_start_pc_valid_keep_clr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        wb_start_pc_valid_keep <= 1'b0;
    end
    else begin
        wb_start_pc_valid_keep <= wb_start_pc_valid_keep_nx;
    end
end

wire wb_btb_update_i0_invalid;
wire wb_btb_update_i0_alloc;
wire wb_btb_update_i0_revise;
kv_btb_update_ctrl u_kv_btb_update_ctrl_2(
    .reso_info(wb_i0_reso_info_reg),
    .pred_info(wb_i0_pred_info),
    .invalid(wb_btb_update_i0_invalid),
    .alloc(wb_btb_update_i0_alloc),
    .revise(wb_btb_update_i0_revise),
    .way(wb_btb_update_p0_way),
    .call(wb_btb_update_p0_call),
    .ret(wb_btb_update_p0_ret),
    .ucond(wb_btb_update_p0_ucond),
    .mispred(wb_i0_btb_mispred)
);
assign wb_i0_tb_mispred = 1'b0;
assign wb_i0_mispred = wb_i0_btb_mispred | wb_i0_tb_mispred;
assign wb_i0_start_pc_valid = wb_i0_is_start | wb_start_pc_valid_keep;
assign wb_btb_update_p0_valid = wb_i0_doable & wb_i0_ctrl[102] & ~wb_i0_ctrl[121] & (wb_btb_update_i0_alloc | wb_btb_update_i0_revise) & wb_i0_start_pc_valid & csr_mmisc_ctl_brpe & ~csr_halt_mode & ~wb_bht_btb_update_issued & ~wb_i0_ctrl[38] & ~wb_i0_fall_thru_offset_overflow & ~wb_i0_non_pp_micro;
assign wb_btb_update_p0_invalid = wb_i0_valid & wb_i0_ctrl[102] & wb_btb_update_i0_invalid & ~wb_bht_btb_update_issued & ~wb_i0_non_pp_micro;
assign wb_btb_update_p0 = wb_btb_update_p0_valid | wb_btb_update_p0_invalid;
assign wb_btb_update_p0_alloc = wb_btb_update_i0_alloc;
assign wb_btb_update_p0_start_pc = wb_i0_bblk_start_pc;
assign wb_btb_update_p0_blk_offset = rvc_en ? wb_i0_fall_thru_offset[10:1] : wb_i0_fall_thru_offset[11:2];
assign wb_btb_update_p0_target_pc = wb_i0_npc[VALEN - 1:0];
assign wb_i1_start_pc_valid = wb_i0_is_start | wb_i1_is_start | wb_start_pc_valid_keep;
wire wb_btb_update_i1_invalid;
wire wb_btb_update_i1_alloc;
wire wb_btb_update_i1_revise;
kv_btb_update_ctrl u_kv_btb_update_ctrl_3(
    .reso_info(wb_i1_reso_info_reg),
    .pred_info(wb_i1_pred_info),
    .invalid(wb_btb_update_i1_invalid),
    .alloc(wb_btb_update_i1_alloc),
    .revise(wb_btb_update_i1_revise),
    .way(wb_btb_update_p1_way),
    .call(wb_btb_update_p1_call),
    .ret(wb_btb_update_p1_ret),
    .ucond(wb_btb_update_p1_ucond),
    .mispred(wb_i1_btb_mispred)
);
assign wb_i1_tb_mispred = 1'b0;
assign wb_i1_mispred = wb_i1_btb_mispred | wb_i1_tb_mispred;
assign wb_btb_update_p1_valid = wb_i1_doable & wb_i1_ctrl[102] & ~wb_i0_ctrl[121] & ~wb_i1_ctrl[121] & (wb_btb_update_i1_alloc | wb_btb_update_i1_revise) & wb_i1_start_pc_valid & csr_mmisc_ctl_brpe & ~csr_halt_mode & ~wb_bht_btb_update_issued & ~wb_i1_fall_thru_offset_overflow & ~wb_i0_non_pp_micro;
assign wb_btb_update_p1_invalid = wb_i1_valid & wb_i1_ctrl[102] & wb_btb_update_i1_invalid & ~wb_bht_btb_update_issued & ~wb_i0_non_pp_micro;
assign wb_btb_update_p1 = wb_btb_update_p1_valid | wb_btb_update_p1_invalid;
assign wb_btb_update_p1_alloc = wb_btb_update_i1_alloc;
assign wb_btb_update_p1_start_pc = wb_i1_bblk_start_pc;
assign wb_btb_update_p1_blk_offset = rvc_en ? wb_i1_fall_thru_offset[10:1] : wb_i1_fall_thru_offset[11:2];
assign wb_btb_update_p1_target_pc = wb_i1_npc[VALEN - 1:0];
assign btb_update_p0 = (wb_btb_update_p0 | mm_btb_update_p0);
assign btb_update_p0_way = wb_btb_update_p0 ? wb_btb_update_p0_way : mm_btb_update_p0_way;
assign btb_update_p0_alloc = wb_btb_update_p0 ? wb_btb_update_p0_alloc : mm_btb_update_p0_alloc;
assign btb_update_p0_ucond = wb_btb_update_p0 ? wb_btb_update_p0_ucond : mm_btb_update_p0_ucond;
assign btb_update_p0_call = wb_btb_update_p0 ? wb_btb_update_p0_call : mm_btb_update_p0_call;
assign btb_update_p0_ret = wb_btb_update_p0 ? wb_btb_update_p0_ret : mm_btb_update_p0_ret;
assign btb_update_p0_start_pc = wb_btb_update_p0 ? wb_btb_update_p0_start_pc : mm_btb_update_p0_start_pc;
assign btb_update_p0_blk_offset = wb_btb_update_p0 ? wb_btb_update_p0_blk_offset : mm_btb_update_p0_blk_offset;
assign btb_update_p0_target_pc = wb_btb_update_p0 ? wb_btb_update_p0_target_pc : mm_btb_update_p0_target_pc;
assign btb_update_p1 = (wb_btb_update_p1 | mm_btb_update_p1);
assign btb_update_p1_way = wb_btb_update_p1 ? wb_btb_update_p1_way : mm_btb_update_p1_way;
assign btb_update_p1_alloc = wb_btb_update_p1 ? wb_btb_update_p1_alloc : mm_btb_update_p1_alloc;
assign btb_update_p1_ucond = wb_btb_update_p1 ? wb_btb_update_p1_ucond : mm_btb_update_p1_ucond;
assign btb_update_p1_call = wb_btb_update_p1 ? wb_btb_update_p1_call : mm_btb_update_p1_call;
assign btb_update_p1_ret = wb_btb_update_p1 ? wb_btb_update_p1_ret : mm_btb_update_p1_ret;
assign btb_update_p1_start_pc = wb_btb_update_p1 ? wb_btb_update_p1_start_pc : mm_btb_update_p1_start_pc;
assign btb_update_p1_blk_offset = wb_btb_update_p1 ? wb_btb_update_p1_blk_offset : mm_btb_update_p1_blk_offset;
assign btb_update_p1_target_pc = wb_btb_update_p1 ? wb_btb_update_p1_target_pc : mm_btb_update_p1_target_pc;
reg btb_update_hold_p0_mm;
wire btb_update_hold_p0_mm_set;
wire btb_update_hold_p0_mm_clr;
wire btb_update_hold_p0_mm_nx;
reg btb_update_hold_p0_lx;
wire btb_update_hold_p0_lx_set;
wire btb_update_hold_p0_lx_clr;
wire btb_update_hold_p0_lx_nx;
assign btb_update_hold_p0_mm_set = mm_btb_update_p0;
assign btb_update_hold_p0_mm_clr = ~lx_stall | wb_i0_redirect | wb_i1_redirect | resume | wb_btb_update_p0;
assign btb_update_hold_p0_mm_nx = (btb_update_hold_p0_mm | btb_update_hold_p0_mm_set) & ~btb_update_hold_p0_mm_clr;
assign btb_update_hold_p0_lx_set = ((mm_btb_update_p0 & ~lx_stall) | (btb_update_hold_p0_mm & ~lx_stall)) & ~wb_i0_redirect & ~wb_i1_redirect & ~resume & ~wb_btb_update_p0;
assign btb_update_hold_p0_lx_clr = ~lx_stall | wb_i0_redirect | wb_i1_redirect | resume | wb_btb_update_p0;
assign btb_update_hold_p0_lx_nx = (btb_update_hold_p0_lx & ~btb_update_hold_p0_lx_clr) | btb_update_hold_p0_lx_set;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        btb_update_hold_p0_mm <= 1'b0;
        btb_update_hold_p0_lx <= 1'b0;
    end
    else begin
        btb_update_hold_p0_mm <= btb_update_hold_p0_mm_nx;
        btb_update_hold_p0_lx <= btb_update_hold_p0_lx_nx;
    end
end

assign btb_update_p0_hold = btb_update_hold_p0_mm | btb_update_hold_p0_lx;
reg btb_update_hold_p1_mm;
wire btb_update_hold_p1_mm_set;
wire btb_update_hold_p1_mm_clr;
wire btb_update_hold_p1_mm_nx;
reg btb_update_hold_p1_lx;
wire btb_update_hold_p1_lx_set;
wire btb_update_hold_p1_lx_clr;
wire btb_update_hold_p1_lx_nx;
assign btb_update_hold_p1_mm_set = mm_btb_update_p1;
assign btb_update_hold_p1_mm_clr = ~lx_stall | wb_i0_redirect | wb_i1_redirect | resume | wb_btb_update_p1;
assign btb_update_hold_p1_mm_nx = (btb_update_hold_p1_mm | btb_update_hold_p1_mm_set) & ~btb_update_hold_p1_mm_clr;
assign btb_update_hold_p1_lx_set = ((mm_btb_update_p1 & ~lx_stall) | (btb_update_hold_p1_mm & ~lx_stall)) & ~wb_i0_redirect & ~wb_i1_redirect & ~resume & ~wb_btb_update_p1;
assign btb_update_hold_p1_lx_clr = ~lx_stall | wb_i0_redirect | wb_i1_redirect | resume | wb_btb_update_p1;
assign btb_update_hold_p1_lx_nx = (btb_update_hold_p1_lx & ~btb_update_hold_p1_lx_clr) | btb_update_hold_p1_lx_set;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        btb_update_hold_p1_mm <= 1'b0;
        btb_update_hold_p1_lx <= 1'b0;
    end
    else begin
        btb_update_hold_p1_mm <= btb_update_hold_p1_mm_nx;
        btb_update_hold_p1_lx <= btb_update_hold_p1_lx_nx;
    end
end

assign btb_update_p1_hold = btb_update_hold_p1_mm | btb_update_hold_p1_lx;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        lx_ls_commited <= 1'b0;
    end
    else begin
        lx_ls_commited <= lx_ls_commited_nx;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        ex_ls_base_bypass <= 3'd0;
        ex_ls_func <= {35{1'b0}};
        ex_ls_offset <= 21'd0;
    end
    else if (~lx_stall) begin
        ex_ls_base_bypass <= ii_ls_base_bypass[2:0];
        ex_ls_func <= ii_ls_func;
        ex_ls_offset <= ii_ls_offset;
    end
end

assign ex_i0_ls = ex_i0_ctrl[148] | ex_i0_ctrl[151];
assign ex_i1_ls = ex_i1_ctrl[148] | ex_i1_ctrl[151];
assign ls_req_base = ({32{ex_ls_base_bypass[0]}} & ex_src1_reg) | ({32{ex_ls_base_bypass[1]}} & ex_src3_reg) | ({32{ex_ls_base_bypass[2]}} & ls_resp_bresult);
assign ls_req_base0 = ex_src1_reg;
assign ls_req_base1 = ex_src3_reg;
assign ls_req_base_bypass = ex_ls_base_bypass;
assign ls_req_valid = (ex_i0_valid & ex_i0_ls & ~ex_abort[0]) | (ex_i1_valid & ex_i1_ls & ~ex_abort[1]);
assign ls_req_pc = ({12{ex_i0_valid & ex_i0_ls}} & ex_i0_pc[11:0]) | ({12{ex_i1_valid & ex_i1_ls}} & ex_i1_pc[11:0]);
assign ls_req_stall[0] = wb_kill | mm_i0_kill | mm_i1_kill | (ex_ls_base_bypass[2] & lx_ls_killed) | (ex_i0_valid & ex_i0_ls & ex_i0_ctrl[185] & ls_resp_nbload) | (ex_i1_valid & ex_i1_ls & ex_i1_ctrl[185] & ls_resp_nbload);
assign ls_req_stall[1] = lx_wait_ls_resp;
assign ex_mm_ls_valid = ls_req_valid & ~ls_req_stall[0] & ~(ls_req_stall[1] & ~ls_resp_valid);
assign ls_req_offset = ex_ls_offset;
assign ls_req_func = ex_ls_func;
assign ls_req_asid = ex_src2_reg[8:0];
assign ex_ls_addr_lsbs = ls_req_base[2:0] + ex_ls_offset[2:0];
assign ex_ls_poisoned = ex_ls_base_bypass[2] & ls_resp_status[13];
assign ex_ls_loadb = (ls_req_load & (ls_req_func3[1:0] == 2'b10) & (ex_ls_addr_lsbs[1:0] == 2'd0) & ~ex_ls_poisoned) | (ls_req_load & (ls_req_func3[1:0] == 2'b11) & (ex_ls_addr_lsbs[2:0] == 3'd0) & ~ex_ls_poisoned);
assign ex_i0_poisoned = ex_i0_ls & ex_ls_poisoned;
assign ex_i1_poisoned = ex_i1_ls & ex_ls_poisoned;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mm_ls_valid <= 1'b0;
        mm_ls_killed <= 1'b0;
        mm_ls_loadb <= 1'b0;
    end
    else if (~lx_stall) begin
        mm_ls_valid <= ex_mm_ls_valid;
        mm_ls_loadb <= ex_ls_loadb;
        mm_ls_killed <= mm_ls_killed_nx;
    end
end

assign mm_ls_killed_nx = wb_kill | mm_i0_kill | mm_i1_kill;
assign lx_ls_killed_nx = wb_kill | mm_ls_killed | (mm_i0_kill & ~(mm_i0_ctrl[163] | mm_i0_ctrl[166])) | (mm_alive[0] & (mm_i0_ctrl[163] | mm_i0_ctrl[166]) & mm_lx_abort[0]) | (mm_alive[1] & (mm_i1_ctrl[163] | mm_i1_ctrl[166]) & (mm_lx_abort[0] | mm_lx_abort[1])) | (mm_alive[1] & (mm_i1_ctrl[163] | mm_i1_ctrl[166]) & mm_i0_sp_xcpt);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        lx_ls_valid <= 1'b0;
        lx_ls_killed <= 1'b0;
    end
    else if (~lx_stall) begin
        lx_ls_valid <= mm_ls_valid;
        lx_ls_killed <= lx_ls_killed_nx;
    end
end

assign lx_ls_commited_nx = lx_stall & (lx_ls_commited | ls_cmt_valid);
assign ls_cmt_valid = (lx_ls_valid & ~lx_ls_commited);
assign ls_cmt_kill = lx_ls_killed | wb_kill;
assign ls_cmt_wdata_base = lx_i0_ctrl[148] ? lx_src2 : lx_src4;
assign ls_una_wait = 1'b0;
generate
    if ((STACKSAFE_SUPPORT_INT == 1)) begin:gen_stacksafe_support
        wire sp_i0_alu_top;
        wire sp_i1_alu_top;
        wire sp0_alu_valid;
        wire sp1_alu_valid;
        wire [2:0] sp_i0_status;
        wire [2:0] sp_i1_status;
        wire [1:0] wb_i0_sp_xcpt;
        wire [1:0] wb_i1_sp_xcpt;
        wire lx_csr_mhsp_bound_wen;
        reg wb_csr_mhsp_bound_wen;
        assign mhsp_match_priv_lv = (cur_privilege_m & csr_mhsp_ctl_m) | (cur_privilege_s & csr_mhsp_ctl_s) | (cur_privilege_u & csr_mhsp_ctl_u);
        assign sp0_alu_valid = mhsp_match_priv_lv & mm_i0_ctrl[197];
        kv_stacksafe_alu u_kv_stacksafe_alu0(
            .csr_mhsp_bound(csr_mhsp_bound),
            .csr_mhsp_base(csr_mhsp_base),
            .csr_mhsp_ctl_ovf_en(csr_mhsp_ctl_ovf_en),
            .csr_mhsp_ctl_udf_en(csr_mhsp_ctl_udf_en),
            .csr_mhsp_ctl_schm(csr_mhsp_ctl_schm),
            .sp_check_data(mm_src2_reg),
            .sp_alu_valid(sp0_alu_valid),
            .status(mm_i0_sp_status)
        );
        assign sp1_alu_valid = mhsp_match_priv_lv & mm_i1_ctrl[197];
        kv_stacksafe_alu u_kv_stacksafe_alu1(
            .csr_mhsp_bound(csr_mhsp_bound),
            .csr_mhsp_base(csr_mhsp_base),
            .csr_mhsp_ctl_ovf_en(csr_mhsp_ctl_ovf_en),
            .csr_mhsp_ctl_udf_en(csr_mhsp_ctl_udf_en),
            .csr_mhsp_ctl_schm(csr_mhsp_ctl_schm),
            .sp_check_data(mm_src4_reg),
            .sp_alu_valid(sp1_alu_valid),
            .status(mm_i1_sp_status)
        );
        assign lx_sp_i0_sel_rd1 = sp_i0_status[2];
        assign lx_sp_i1_sel_rd1 = sp_i1_status[2];
        assign lx_wb_i0_ctrl[142 +:2] = sp_i0_status[1:0];
        assign lx_wb_i1_ctrl[142 +:2] = sp_i1_status[1:0];
        assign sp_i0_status = lx_i0_ctrl[184 +:3];
        assign sp_i1_status = lx_i1_ctrl[184 +:3];
        assign sp_i0_alu_top = sp_i0_status[2];
        assign sp_i1_alu_top = sp_i1_status[2];
        assign lx_csr_mhsp_bound_wen = sp_i0_alu_top & lx_doable[0] | sp_i1_alu_top & lx_doable[1];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                wb_csr_mhsp_bound_wen <= 1'b0;
            end
            else if (wb_ctrl_en) begin
                wb_csr_mhsp_bound_wen <= lx_csr_mhsp_bound_wen;
            end
        end

        assign wb_i0_sp_xcpt = wb_i0_ctrl[142 +:2];
        assign wb_i1_sp_xcpt = wb_i1_ctrl[142 +:2];
        assign ipipe_csr_mhsp_bound_wen = wb_csr_mhsp_bound_wen;
        assign ipipe_csr_mhsp_bound_wdata = ({32{wb_i0_ctrl[141]}} & wb_rd1_wdata) | ({32{wb_i1_ctrl[141]}} & wb_rd2_wdata);
        assign ipipe_csr_hsp_xcpt = ((wb_i0_ctrl[39 +:6] == 6'h20) & ~wb_i0_ctrl[138] & wb_i0_sp_xcpt[0] & wb_i0_alive) | ((wb_i0_ctrl[39 +:6] == 6'h21) & ~wb_i0_ctrl[138] & wb_i0_sp_xcpt[1] & wb_i0_alive) | ((wb_i1_ctrl[39 +:6] == 6'h20) & ~wb_i1_ctrl[138] & wb_i1_sp_xcpt[0] & wb_i1_alive) | ((wb_i1_ctrl[39 +:6] == 6'h21) & ~wb_i1_ctrl[138] & wb_i1_sp_xcpt[1] & wb_i1_alive);
    end
    else begin:gen_non_stacksafe_support
        assign mhsp_match_priv_lv = 1'b0;
        assign mm_i0_sp_status = 3'b0;
        assign mm_i1_sp_status = 3'b0;
        assign lx_wb_i0_ctrl[142 +:2] = 2'b0;
        assign lx_wb_i1_ctrl[142 +:2] = 2'b0;
        assign lx_sp_i0_sel_rd1 = 1'b0;
        assign lx_sp_i1_sel_rd1 = 1'b0;
        assign ipipe_csr_hsp_xcpt = 1'b0;
        assign ipipe_csr_mhsp_bound_wen = 1'b0;
        assign ipipe_csr_mhsp_bound_wdata = {32{1'b0}};
        wire nds_unused_stacksafe_signals = |{csr_mhsp_ctl_schm,mhsp_match_priv_lv,csr_mhsp_base,csr_mhsp_bound,csr_mhsp_ctl_udf_en,csr_mhsp_ctl_ovf_en};
    end
endgenerate
generate
    if ((POWERBRAKE_SUPPORT_INT == 1)) begin:gen_throttling_stall
        wire [3:0] throttling_level = csr_t_level;
        reg [3:0] throttling_cycle_cnt;
        wire [3:0] throttling_cycle_cnt_nx;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                throttling_cycle_cnt <= 4'b0;
            end
            else if (csr_pft_en) begin
                throttling_cycle_cnt <= throttling_cycle_cnt_nx;
            end
        end

        assign throttling_cycle_cnt_nx = throttling_cycle_cnt + 4'b1;
        assign throttling_stall = (throttling_cycle_cnt < throttling_level) & csr_pft_en;
    end
    else begin:gen_throttling_stall_else
        assign throttling_stall = 1'b0;
        wire nds_unused_powerbreak_signals = |{csr_t_level,csr_pft_en};
    end
endgenerate
assign ipipe_ifu_stall = core_wfi_mode;
wire [31:0] csrrw_result;
wire [31:0] csrrs_result;
wire [31:0] csrrc_result;
assign csrrw_result = lx_src1;
assign csrrs_result = csr_ipipe_rmw_rdata | lx_src1;
assign csrrc_result = csr_ipipe_rmw_rdata & ~lx_src1;
assign csr_wdata = (lx_i0_ctrl[102 +:2] == 2'd1) ? csrrw_result : (lx_i0_ctrl[102 +:2] == 2'd2) ? csrrs_result : csrrc_result;
assign ipipe_csr_req_wr_valid = wb_i0_doable & wb_i0_ctrl[94];
assign ipipe_csr_req_read_only = wb_i0_ctrl[48];
assign ipipe_csr_req_func = wb_i0_ctrl[61 +:2];
assign ipipe_csr_req_waddr = wb_i0_ctrl[49 +:12];
assign ipipe_csr_req_rd_valid = lx_doable[0] & (lx_i0_ctrl[132] & ~lx_stall);
assign ipipe_csr_req_raddr = lx_i0_ctrl[90 +:12];
assign ipipe_csr_req_mrandstate = lx_i0_ctrl[89];
assign ipipe_csr_req_wdata = wb_csr_wdata_reg;
assign id_i0_pp_instr = id_i0_ctrl[249];
assign ii_i0_1st_pp_micro = ii_valid[0] & ii_i0_ctrl[249] & (ii_i0_ctrl[225 +:2] == 2'b10);
assign ii_i1_1st_pp_micro = ii_valid[1] & ii_i1_ctrl[249] & (ii_i1_ctrl[225 +:2] == 2'b10);
assign ex_i0_illegal_pp = ex_valid[0] & ex_i0_ctrl[186] & ~(|ex_i0_ctrl[192 +:5]) & alu0_func[0] & (|alu0_op0[3:0]);
assign ex_i1_illegal_pp = ex_valid[1] & ex_i1_ctrl[186] & ~(|ex_i1_ctrl[192 +:5]) & alu0_func[0] & (|alu1_op0[3:0]);
assign mm_non_pp_uinstr = mm_uinstr & ~mm_i0_ctrl[178];
assign lx_pp_int_taken_mask_set = (lx_doable[0] & lx_i0_ctrl[155] & (lx_i0_ctrl[152 +:2] != 2'b10)) | (lx_doable[1] & lx_i1_ctrl[155] & (lx_i1_ctrl[152 +:2] != 2'b10));
assign wb_pp_int_taken_mask_clr = (~int_taken_mask_set & wb_i0_pp_retire);
assign wb_i0_non_pp_micro = (wb_i0_micro & ~wb_i0_ctrl[112]);
assign wb_i1_non_pp_micro = (wb_i1_micro & ~wb_i1_ctrl[112]);
assign wb_i0_xreg_backup = ~(wb_i0_seg_end | wb_i0_ctrl[112]);
assign wb_i1_xreg_backup = ~(wb_i1_seg_end | wb_i1_ctrl[112]);
assign wb_i0_non_pp_micro_last = (wb_i0_micro_last & ~wb_i0_ctrl[112]);
assign wb_i0_pp_retire = wb_i0_retire & wb_i0_ctrl[112];
assign wb_pp_insert_hss_clr = (wb_i0_ctrl[138] & wb_i0_alive & wb_i0_ctrl[112]) | (wb_i1_ctrl[138] & wb_i1_alive & wb_i1_ctrl[112]);
function  [7:0] pp_hpm_ecnt_gen;
input [3:0] ctrl;
reg [2:0] rcount;
reg is_popret;
reg [3:0] rcount2n;
reg [3:0] ecnt_ls;
reg [3:0] ecnt_op;
begin
    rcount = ctrl[2:0];
    is_popret = ctrl[3];
    rcount2n = ({4{(rcount == 3'd0)}} & 4'd1) | ({4{(rcount == 3'd1)}} & 4'd2) | ({4{(rcount == 3'd2)}} & 4'd3) | ({4{(rcount == 3'd3)}} & 4'd4) | ({4{(rcount == 3'd4)}} & 4'd5) | ({4{(rcount == 3'd5)}} & 4'd7) | ({4{(rcount == 3'd6)}} & 4'd10) | ({4{(rcount == 3'd7)}} & 4'd13);
    ecnt_ls = rcount2n;
    ecnt_op = rcount2n + {2'd0,is_popret,(~is_popret)};
    pp_hpm_ecnt_gen = {ecnt_op,ecnt_ls};
end
endfunction
assign {lx_wb_i0_ctrl[117 +:4],lx_wb_i0_ctrl[113 +:4]} = pp_hpm_ecnt_gen({lx_i0_instr[5],lx_i0_instr[9:7]});
assign {lx_wb_i1_ctrl[117 +:4],lx_wb_i1_ctrl[113 +:4]} = pp_hpm_ecnt_gen({lx_i0_instr[5],lx_i0_instr[9:7]});
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        ipipe_event <= {1{1'b0}};
    end
    else begin
        ipipe_event <= ipipe_event_nx;
    end
end

assign ipipe_event_nx[0] = ii_doable[0] & event_xrf_busy;
wire nds_unused_ace_error = ace_error;
endmodule


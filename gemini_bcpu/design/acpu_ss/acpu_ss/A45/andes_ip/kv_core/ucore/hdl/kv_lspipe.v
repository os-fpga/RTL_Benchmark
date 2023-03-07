// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lspipe (
    core_clk,
    core_reset_n,
    csr_ls_translate_en,
    csr_milmb_eccen,
    csr_milmb_rwecc,
    csr_mdlmb_eccen,
    csr_mdlmb_rwecc,
    csr_mxstatus_dme,
    csr_mcache_ctl_dc_en,
    csr_halt_mode,
    csr_satp_mode,
    csr_mmisc_ctl_una,
    lsp_event,
    dcu_wna_pending,
    lsp_standby_ready,
    rpt_cmt_valid,
    rpt_cmt_kill,
    rpt_cmt_pc,
    rpt_cmt_va,
    rpt_cmt_status,
    lsp_req_valid,
    lsp_req_stall,
    lsp_req_ptw,
    lsp_req_src,
    lsp_req_func,
    lsp_req_pc,
    lsp_req_va,
    lsp_req_va_lm,
    lsp_req_pa,
    lsp_req_base_va20,
    lsp_req_offset,
    lsp_req_ilm,
    lsp_req_dlm,
    lsp_req_ready,
    lsp_ack_valid,
    lsp_ack_kill,
    lsp_ack_src,
    lsp_ack_result,
    lsp_ack_result2,
    lsp_ack_bresult,
    lsp_ack_va,
    lsp_ack_fault_va,
    lsp_ack_pa,
    lsp_ack_status,
    nbload_resp_valid,
    nbload_resp_rd,
    nbload_resp_result,
    nbload_resp_status,
    lsu_async_read_error,
    prf_resp_valid,
    prf_resp_id,
    prf_resp_status,
    lsp_commit,
    lsp_kill,
    lsp_cmt_wdata,
    lsp_reserve_clr,
    dtlb_lsu_status,
    lsu_dtlb_lru_valid,
    lsu_dtlb_lru_wdata,
    lsu_pmp_req_pa,
    lsu_pmp_req_store,
    pmp_lsu_resp_fault,
    lsu_pma_req_pa,
    pma_lsu_resp_fault,
    pma_lsu_resp_mtype,
    pma_lsu_resp_namo,
    dcu_req_addr,
    dcu_req_func,
    dcu_req_valid,
    dcu_req_stall,
    dcu_req_id,
    dcu_req_ready,
    dcu_ack_valid,
    dcu_ack_id,
    dcu_ack_rdata,
    dcu_ack_status,
    dcu_cmt_valid,
    dcu_cmt_addr,
    dcu_cmt_func,
    dcu_cmt_wdata,
    dcu_cmt_wmask,
    dcu_cri_valid,
    dcu_cri_id,
    dcu_cri_rdata,
    dcu_cri_nbload_result,
    dcu_cri_status,
    lspipe_a_opcode,
    lspipe_a_param,
    lspipe_a_user,
    lspipe_a_size,
    lspipe_a_source,
    lspipe_a_address,
    lspipe_a_data,
    lspipe_a_mask,
    lspipe_a_corrupt,
    lspipe_a_valid,
    lspipe_a_ready,
    lspipe_d_opcode,
    lspipe_d_param,
    lspipe_d_user,
    lspipe_d_size,
    lspipe_d_source,
    lspipe_d_sink,
    lspipe_d_data,
    lspipe_d_denied,
    lspipe_d_corrupt,
    lspipe_d_valid,
    lspipe_d_ready,
    lsu_dlm0_a_addr,
    lsu_dlm0_a_func,
    lsu_dlm0_a_ready,
    lsu_dlm0_a_stall,
    lsu_dlm0_a_user,
    lsu_dlm0_a_valid,
    lsu_dlm1_a_addr,
    lsu_dlm1_a_func,
    lsu_dlm1_a_ready,
    lsu_dlm1_a_stall,
    lsu_dlm1_a_user,
    lsu_dlm1_a_valid,
    lsu_dlm2_a_addr,
    lsu_dlm2_a_func,
    lsu_dlm2_a_ready,
    lsu_dlm2_a_stall,
    lsu_dlm2_a_user,
    lsu_dlm2_a_valid,
    lsu_dlm3_a_addr,
    lsu_dlm3_a_func,
    lsu_dlm3_a_ready,
    lsu_dlm3_a_stall,
    lsu_dlm3_a_user,
    lsu_dlm3_a_valid,
    lsu_dlm0_d_data,
    lsu_dlm0_d_status,
    lsu_dlm0_d_user,
    lsu_dlm0_d_valid,
    lsu_dlm1_d_data,
    lsu_dlm1_d_status,
    lsu_dlm1_d_user,
    lsu_dlm1_d_valid,
    lsu_dlm2_d_data,
    lsu_dlm2_d_status,
    lsu_dlm2_d_user,
    lsu_dlm2_d_valid,
    lsu_dlm3_d_data,
    lsu_dlm3_d_status,
    lsu_dlm3_d_user,
    lsu_dlm3_d_valid,
    lsu_dlm0_w_data,
    lsu_dlm0_w_mask,
    lsu_dlm0_w_ready,
    lsu_dlm0_w_status,
    lsu_dlm0_w_valid,
    lsu_dlm1_w_data,
    lsu_dlm1_w_mask,
    lsu_dlm1_w_ready,
    lsu_dlm1_w_status,
    lsu_dlm1_w_valid,
    lsu_dlm2_w_data,
    lsu_dlm2_w_mask,
    lsu_dlm2_w_ready,
    lsu_dlm2_w_status,
    lsu_dlm2_w_valid,
    lsu_dlm3_w_data,
    lsu_dlm3_w_mask,
    lsu_dlm3_w_ready,
    lsu_dlm3_w_status,
    lsu_dlm3_w_valid,
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
    trigm_ls_load,
    trigm_ls_store,
    trigm_ls_addr,
    trigm_ls_result,
    lsu_async_write_error
);
parameter FLEN = 64;
parameter VALEN = 32;
parameter PALEN = 32;
parameter EXTVALEN = 32;
parameter MMU_SCHEME_INT = 0;
parameter RVA_SUPPORT_INT = 0;
parameter CLUSTER_SUPPORT_INT = 0;
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
parameter DCACHE_PREFETCH_SUPPORT_INT = 0;
parameter TL_SINK_WIDTH = 2;
parameter LSP_SRCS = 6;
parameter PERFORMANCE_MONITOR_INT = 0;
localparam SATP_MODE_BARE = 4'h0;
localparam SATP_MODE_SV39 = 4'h8;
localparam SATP_MODE_SV48 = 4'h9;
localparam BIU_STATE_IDLE = 0;
localparam BIU_STATE_NB = 1;
localparam BIU_STATE_BK = 2;
localparam BIU_STATE_RESP = 3;
localparam BIU_STATE_BITS = 4;
input core_clk;
input core_reset_n;
input csr_ls_translate_en;
input [1:0] csr_milmb_eccen;
input csr_milmb_rwecc;
input [1:0] csr_mdlmb_eccen;
input csr_mdlmb_rwecc;
input csr_mxstatus_dme;
input csr_mcache_ctl_dc_en;
input csr_halt_mode;
input [3:0] csr_satp_mode;
input csr_mmisc_ctl_una;
output [3:0] lsp_event;
input dcu_wna_pending;
output lsp_standby_ready;
output rpt_cmt_valid;
output rpt_cmt_kill;
output [11:0] rpt_cmt_pc;
output [EXTVALEN - 1:0] rpt_cmt_va;
output [16:0] rpt_cmt_status;
input lsp_req_valid;
input lsp_req_stall;
input lsp_req_ptw;
input [LSP_SRCS - 1:0] lsp_req_src;
input [36:0] lsp_req_func;
input [11:0] lsp_req_pc;
input [EXTVALEN - 1:0] lsp_req_va;
input [EXTVALEN - 1:0] lsp_req_va_lm;
input [PALEN - 1:0] lsp_req_pa;
input [2:0] lsp_req_base_va20;
input [2:0] lsp_req_offset;
input lsp_req_ilm;
input lsp_req_dlm;
output lsp_req_ready;
output lsp_ack_valid;
output lsp_ack_kill;
output [LSP_SRCS - 1:0] lsp_ack_src;
output [31:0] lsp_ack_result;
output [63:0] lsp_ack_result2;
output [31:0] lsp_ack_bresult;
output [EXTVALEN - 1:0] lsp_ack_va;
output [EXTVALEN - 1:0] lsp_ack_fault_va;
output [PALEN - 1:0] lsp_ack_pa;
output [44:0] lsp_ack_status;
output nbload_resp_valid;
output [4:0] nbload_resp_rd;
output [31:0] nbload_resp_result;
output nbload_resp_status;
output lsu_async_read_error;
output prf_resp_valid;
output [4:0] prf_resp_id;
output prf_resp_status;
input [LSP_SRCS - 1:0] lsp_commit;
input [LSP_SRCS - 1:0] lsp_kill;
input [63:0] lsp_cmt_wdata;
input lsp_reserve_clr;
input [30:0] dtlb_lsu_status;
output lsu_dtlb_lru_valid;
output [7:0] lsu_dtlb_lru_wdata;
output [PALEN - 1:0] lsu_pmp_req_pa;
output lsu_pmp_req_store;
input pmp_lsu_resp_fault;
output [PALEN - 1:0] lsu_pma_req_pa;
input pma_lsu_resp_fault;
input [3:0] pma_lsu_resp_mtype;
input pma_lsu_resp_namo;
output [PALEN - 1:0] dcu_req_addr;
output [21:0] dcu_req_func;
output dcu_req_valid;
output dcu_req_stall;
output dcu_req_id;
input dcu_req_ready;
input dcu_ack_valid;
input dcu_ack_id;
input [31:0] dcu_ack_rdata;
input [18:0] dcu_ack_status;
output dcu_cmt_valid;
output [PALEN - 1:0] dcu_cmt_addr;
output [10:0] dcu_cmt_func;
output [31:0] dcu_cmt_wdata;
output [3:0] dcu_cmt_wmask;
input dcu_cri_valid;
input [0:0] dcu_cri_id;
input [31:0] dcu_cri_rdata;
input [31:0] dcu_cri_nbload_result;
input [8:0] dcu_cri_status;
output [2:0] lspipe_a_opcode;
output [2:0] lspipe_a_param;
output [7:0] lspipe_a_user;
output [2:0] lspipe_a_size;
output lspipe_a_source;
output [PALEN - 1:0] lspipe_a_address;
output [31:0] lspipe_a_data;
output [3:0] lspipe_a_mask;
output lspipe_a_corrupt;
output lspipe_a_valid;
input lspipe_a_ready;
input [2:0] lspipe_d_opcode;
input [1:0] lspipe_d_param;
input [1:0] lspipe_d_user;
input [2:0] lspipe_d_size;
input lspipe_d_source;
input [TL_SINK_WIDTH - 1:0] lspipe_d_sink;
input [31:0] lspipe_d_data;
input lspipe_d_denied;
input lspipe_d_corrupt;
input lspipe_d_valid;
output lspipe_d_ready;
output [DLM_AMSB:0] lsu_dlm0_a_addr;
output [2:0] lsu_dlm0_a_func;
input lsu_dlm0_a_ready;
output lsu_dlm0_a_stall;
output [0:0] lsu_dlm0_a_user;
output lsu_dlm0_a_valid;
output [DLM_AMSB:0] lsu_dlm1_a_addr;
output [2:0] lsu_dlm1_a_func;
input lsu_dlm1_a_ready;
output lsu_dlm1_a_stall;
output [0:0] lsu_dlm1_a_user;
output lsu_dlm1_a_valid;
output [DLM_AMSB:0] lsu_dlm2_a_addr;
output [2:0] lsu_dlm2_a_func;
input lsu_dlm2_a_ready;
output lsu_dlm2_a_stall;
output [0:0] lsu_dlm2_a_user;
output lsu_dlm2_a_valid;
output [DLM_AMSB:0] lsu_dlm3_a_addr;
output [2:0] lsu_dlm3_a_func;
input lsu_dlm3_a_ready;
output lsu_dlm3_a_stall;
output [0:0] lsu_dlm3_a_user;
output lsu_dlm3_a_valid;
input [31:0] lsu_dlm0_d_data;
input [13:0] lsu_dlm0_d_status;
input [0:0] lsu_dlm0_d_user;
input lsu_dlm0_d_valid;
input [31:0] lsu_dlm1_d_data;
input [13:0] lsu_dlm1_d_status;
input [0:0] lsu_dlm1_d_user;
input lsu_dlm1_d_valid;
input [31:0] lsu_dlm2_d_data;
input [13:0] lsu_dlm2_d_status;
input [0:0] lsu_dlm2_d_user;
input lsu_dlm2_d_valid;
input [31:0] lsu_dlm3_d_data;
input [13:0] lsu_dlm3_d_status;
input [0:0] lsu_dlm3_d_user;
input lsu_dlm3_d_valid;
output [31:0] lsu_dlm0_w_data;
output [3:0] lsu_dlm0_w_mask;
input lsu_dlm0_w_ready;
input lsu_dlm0_w_status;
output lsu_dlm0_w_valid;
output [31:0] lsu_dlm1_w_data;
output [3:0] lsu_dlm1_w_mask;
input lsu_dlm1_w_ready;
input lsu_dlm1_w_status;
output lsu_dlm1_w_valid;
output [31:0] lsu_dlm2_w_data;
output [3:0] lsu_dlm2_w_mask;
input lsu_dlm2_w_ready;
input lsu_dlm2_w_status;
output lsu_dlm2_w_valid;
output [31:0] lsu_dlm3_w_data;
output [3:0] lsu_dlm3_w_mask;
input lsu_dlm3_w_ready;
input lsu_dlm3_w_status;
output lsu_dlm3_w_valid;
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
output trigm_ls_load;
output trigm_ls_store;
output [VALEN - 1:0] trigm_ls_addr;
input [4:0] trigm_ls_result;
output lsu_async_write_error;


wire s0 = (RVA_SUPPORT_INT == 1);
wire s1 = 1'b0;
wire s2 = FLEN == 64;
wire s3 = (EXTVALEN != VALEN);
wire s4 = (DLM_ECC_TYPE_INT == 2);
wire s5 = s4 & (csr_mdlmb_eccen == 2'd2);
wire s6 = s4 & (csr_mdlmb_eccen == 2'd3);
wire s7 = (ILM_ECC_TYPE_INT == 2);
wire s8 = csr_satp_mode == SATP_MODE_SV39;
wire s9;
wire m0_valid;
wire [LSP_SRCS - 1:0] s10 = lsp_req_src;
wire [79:0] s11;
reg m0_id;
wire s12;
wire [3:0] s13;
wire [36:0] s14;
wire [11:0] s15;
wire [1:0] s16 = s14[0 +:2];
wire [2:0] s17 = s14[34 +:3];
wire m0_load = s14[2];
wire s18 = s14[3];
wire s19 = s14[5];
wire s20 = s14[4];
wire s21 = s14[7];
wire s22 = s14[8];
wire s23 = s14[9];
wire s24 = s14[22];
wire s25 = s14[23];
wire s26 = s14[16];
wire [4:0] s27 = s14[17 +:5];
wire s28 = s14[26];
wire s29 = s21 | s22 | s23 | s24 | s25;
wire s30 = s22 | s23;
wire s31;
wire s32;
wire s33 = s14[24];
wire s34;
wire s35 = m0_load | s34;
wire s36 = s18;
wire m0_stall;
wire s37;
wire m0_ilm;
wire m0_dlm;
wire s38 = m0_ilm | m0_dlm;
wire m0_dcu;
wire s39;
wire [EXTVALEN - 1:0] s40 = lsp_req_va;
wire [EXTVALEN - 1:0] s41 = lsp_req_va_lm;
wire [EXTVALEN - 1:0] s42;
wire [EXTVALEN - 1:0] s43;
wire [2:0] s44 = lsp_req_base_va20;
wire [2:0] s45 = lsp_req_offset;
wire s46;
wire [PALEN - 1:0] s47;
wire s48;
wire [3:0] s49;
wire s50;
wire s51;
wire [3:0] s52;
wire s53 = s48;
wire [7:0] s54 = dtlb_lsu_status[0 +:8];
wire s55 = (~(|s54)) & ~s46;
wire s56 = dtlb_lsu_status[8];
wire s57 = dtlb_lsu_status[9];
wire s58 = dtlb_lsu_status[10];
wire s59 = dtlb_lsu_status[11];
wire s60 = dtlb_lsu_status[12];
wire s61 = dtlb_lsu_status[13] | s46;
wire s62 = dtlb_lsu_status[14] & ~s46;
wire [2:0] s63 = dtlb_lsu_status[15 +:3];
wire [7:0] s64 = dtlb_lsu_status[18 +:8];
wire s65 = dtlb_lsu_status[26];
wire [3:0] s66 = dtlb_lsu_status[27 +:4];
reg m1_valid;
reg s67;
wire s68;
wire s69;
wire s70;
reg [LSP_SRCS - 1:0] s71;
reg [79:0] s72;
wire [102:0] s73;
reg [EXTVALEN - 1:0] s74;
reg [2:0] s75;
reg [2:0] s76;
wire [EXTVALEN - 1:0] s77;
wire [EXTVALEN - 1:0] s78 = {s74[EXTVALEN - 1:3],s75};
wire [EXTVALEN - 1:0] s79;
reg [PALEN - 1:0] s80;
reg [3:0] s81;
wire [11:0] s82;
wire m1_id = s72[14];
wire [3:0] m1_bank = s72[3 +:4] & {4{m1_valid}};
wire [1:0] s83 = s72[39 +:2];
wire [2:0] s84 = s72[11 +:3];
wire m1_load = s72[17];
wire m1_nbload = s72[26];
wire s85 = s72[41];
wire s86 = s72[20];
wire s87 = s72[38];
wire s88 = s72[0];
wire m1_dlm = s72[9];
wire m1_ilm = s72[15];
wire m1_dcu = s72[8];
wire s89 = s72[7];
wire s90 = s72[75];
wire [3:0] s91 = s72[21 +:4];
wire s92 = s72[77];
wire s93 = s72[18];
wire s94 = s72[78];
wire s95 = s72[10];
wire s96 = s72[28];
wire s97 = s72[32];
wire s98 = s72[1];
wire s99 = s72[27];
wire s100 = s72[65];
wire s101 = s72[63];
wire s102 = s72[64];
wire s103 = s72[60];
wire s104 = s72[61];
wire s105 = s72[62];
wire s106 = s72[42];
wire [2:0] s107 = s72[43 +:3];
wire [7:0] s108 = s72[46 +:8];
wire s109 = s72[54];
wire [3:0] s110 = s72[55 +:4];
wire [5:0] s111;
wire [4:0] s112;
wire s113 = s76 == 3'd0;
wire s114 = s105 | s104 | s103 | s102 | s101 | s100;
wire s115 = ~s106 & s114;
wire [7:0] s116;
wire [7:1] s117;
wire s118;
wire s119;
wire s120;
wire s121 = pmp_lsu_resp_fault;
wire [3:0] s122 = s95 ? 4'b0000 : pma_lsu_resp_mtype;
wire s123 = (~s119) & (~s95) & pma_lsu_resp_fault;
wire s124 = (~s119) & (s122[3:1] == 3'b000);
wire s125 = (~s119) & (s122[3:1] == 3'b001);
wire s126 = (~s119) & (~s95) & (s86 | s87) & pma_lsu_resp_namo;
wire s127;
wire s128;
wire s129;
reg m1_killed;
wire s130;
wire s131;
wire [7:0] s132;
wire s133;
wire [3:0] s134;
wire s135 = s113 & ~s96 & ~s97 & trigm_ls_result[0];
wire s136 = s113 & ~s96 & ~s97 & trigm_ls_result[1];
wire s137 = s113 & ~s96 & ~s97 & trigm_ls_result[2];
wire s138 = s113 & ~s96 & ~s97 & trigm_ls_result[3];
wire s139 = s113 & ~s96 & ~s97 & trigm_ls_result[4];
wire s140;
wire s141;
wire [3:0] s142;
wire [3:0] s143;
wire s144;
wire s145;
wire [5:0] s146;
wire [5:0] s147;
wire s148;
wire [5:0] s149;
reg m2_valid;
wire m2_alive;
wire s150;
reg [LSP_SRCS - 1:0] s151;
wire s152;
reg s153;
wire s154;
reg s155;
wire s156;
reg [102:0] s157;
reg [EXTVALEN - 1:0] s158;
reg [PALEN - 1:0] s159;
reg [2:0] s160;
reg [2:0] s161;
reg [3:0] s162;
wire s163;
wire s164 = s157[1];
wire [11:0] s165;
wire m2_id = s157[38];
wire [3:0] m2_bank = s157[2 +:4];
wire [1:0] s166 = s157[74 +:2];
wire [7:0] m2_va_onehot = s157[92 +:8];
wire [7:1] m2_offset_onehot = s157[46 +:7];
wire m2_load = s157[41];
wire m2_store = s157[76];
wire m2_sc = s157[73];
wire s167 = s157[0];
wire m2_dlm = s157[19];
wire m2_ilm = s157[39];
wire s168 = m2_ilm | m2_dlm;
wire m2_biu = s157[6];
wire m2_dcu = s157[17];
wire s169 = s157[61];
wire s170 = s157[100];
wire m2_c = s157[7];
wire [3:0] s171 = s157[53 +:4];
wire s172 = s157[37];
wire s173 = s157[102];
wire s174 = s157[77];
wire s175 = s157[33];
wire s176 = s157[42];
wire s177 = s157[57];
wire s178 = s157[90];
wire [2:0] s179 = s157[34 +:3];
wire s180 = s157[58];
wire [5:0] m2_result_sel = s157[67 +:6];
wire [4:0] m2_bresult_sel;
wire s181 = s157[101];
wire s182 = s157[59];
wire s183 = s157[60];
wire m2_nbload = s157[45];
wire [4:0] s184 = s157[62 +:5];
wire s185 = s157[91];
wire s186 = s157[40];
wire s187 = s157[44];
wire s188 = s157[89];
wire s189 = s157[88];
wire s190 = s157[87];
wire [7:0] s191 = s157[20 +:8];
wire s192 = s157[28];
wire [3:0] s193 = s157[29 +:4];
wire s194;
wire s195;
wire m2_abort;
wire s196;
wire [2:0] s197;
wire s198;
wire s199 = s161 == 3'd0;
wire s200;
wire s201;
wire s202 = s200 | s201;
wire [3:0] s203;
wire [3:0] s204;
wire s205 = (s171[3:2] == 2'b01);
wire s206 = ~s171[0];
wire s207 = ~s171[1];
wire m2_lr = s0 & s157[43];
wire [31:0] fmt_result;
wire [63:0] fmt_result2;
wire [31:0] fmt_wdata;
wire [31:0] fmt_bresult;
reg s208;
wire s209;
wire s210;
wire s211;
wire m2_stall;
wire s212 = ~m2_stall;
wire s213;
wire s214;
wire s215;
wire s216;
wire m2_resp_valid;
wire [31:0] ilm_rdata;
wire [31:0] dlm_rdata0;
wire [31:0] dlm_rdata1;
wire [31:0] dlm_rdata2;
wire [31:0] dlm_rdata3;
wire rob_valid;
wire s217;
wire s218;
wire [22:0] ls_rob_status;
wire s219 = ls_rob_status[2];
wire s220 = ls_rob_status[8];
wire s221;
wire s222;
wire s223;
reg [BIU_STATE_BITS - 1:0] s224;
reg [BIU_STATE_BITS - 1:0] s225;
reg s226;
wire s227 = s224[BIU_STATE_IDLE];
wire s228 = s224[BIU_STATE_BK];
wire s229 = s224[BIU_STATE_NB];
wire s230 = s224[BIU_STATE_RESP];
wire s231;
wire biu_bk_valid;
wire biu_bk_error;
wire biu_bk_exokay;
wire [31:0] biu_bk_rdata;
wire biu_resp_valid;
wire biu_stall;
wire s232;
wire s233;
wire dlm_resp_valid0;
wire dlm_resp_valid1;
wire dlm_resp_valid2;
wire dlm_resp_valid3;
wire [22:0] dlm_resp_status0;
wire [22:0] dlm_resp_status1;
wire [22:0] dlm_resp_status2;
wire [22:0] dlm_resp_status3;
wire dlm0_resp_id = lsu_dlm0_d_user;
wire dlm1_resp_id = lsu_dlm1_d_user;
wire dlm2_resp_id = lsu_dlm2_d_user;
wire dlm3_resp_id = lsu_dlm3_d_user;
wire ilm_resp_valid;
wire [22:0] ilm_resp_status;
wire s234;
wire [1:0] s235;
wire s236;
wire s237;
wire s238 = 1'b0;
assign lsp_standby_ready = s227 & ~m1_valid & ~m2_valid;
wire [LSP_SRCS - 1:0] s239 = lsp_kill & lsp_commit;
kv_mux_onehot #(
    .N(LSP_SRCS),
    .W(1)
) u_m0_kill (
    .out(s51),
    .sel(s10),
    .in(s239)
);
kv_mux_onehot #(
    .N(LSP_SRCS),
    .W(1)
) u_m1_kill (
    .out(s129),
    .sel(s71),
    .in(s239)
);
kv_mux_onehot #(
    .N(LSP_SRCS),
    .W(1)
) u_m2_kill (
    .out(s152),
    .sel(s151),
    .in(s239)
);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        m0_id <= 1'b0;
    end
    else if (s12) begin
        m0_id <= ~m0_id;
    end
end

assign lsp_req_ready = ~m0_stall;
assign m0_valid = lsp_req_valid & ~s51;
assign s13 = ({4{m0_dlm & (s235 == 2'b11)}} & 4'b1000) | ({4{m0_dlm & (s235 == 2'b10)}} & 4'b0100) | ({4{m0_dlm & (s235 == 2'b01)}} & 4'b0010) | ({4{m0_dlm & (s235 == 2'b00)}} & 4'b0001);
assign s14 = lsp_req_func;
assign s15 = lsp_req_pc;
assign s39 = lsp_req_ptw;
assign s48 = lsp_req_func[25];
assign s37 = m2_stall | s50;
assign s50 = s213 | (s19 & m1_valid) | lsp_req_stall;
assign m0_stall = (m0_dlm & s18 & ~s232) | (m0_dlm & m0_load & ~s233) | (m0_ilm & s18 & ~s218) | (m0_ilm & m0_load & ~s217) | (m0_dcu & ~dcu_req_ready) | s50 | m2_stall;
assign s12 = m0_valid & ~m0_stall;
assign s42[EXTVALEN - 1:3] = s40[EXTVALEN - 1:3];
assign s42[2] = s40[2] & (s16 <= 2'd2);
assign s42[1] = s40[1] & (s16 <= 2'd1);
assign s42[0] = s40[0] & (s16 == 2'd0);
assign s43[EXTVALEN - 1:3] = s41[EXTVALEN - 1:3];
assign s43[2] = s41[2] & (s16 <= 2'd2);
assign s43[1] = s41[1] & (s16 <= 2'd1);
assign s43[0] = s41[0] & (s16 == 2'd0);
kv_st_mask u_m0_mask(
    .mask(s49),
    .addr(s42[2:0]),
    .size(s16)
);
assign s9 = csr_mcache_ctl_dc_en & ~csr_mxstatus_dme;
generate
    if ((MMU_SCHEME_INT == 3)) begin:gen_m0_bad_va_sv48
        wire s240 = (|lsp_req_va[EXTVALEN - 1:38]) & ~(&lsp_req_va[EXTVALEN - 1:38]) & s8;
        assign s46 = s3 & ((lsp_req_va[EXTVALEN - 1] ^ lsp_req_va[EXTVALEN - 2]) | s240);
    end
    else begin:gen_m0_bad_va_check
        assign s46 = s3 & (lsp_req_va[EXTVALEN - 1] ^ lsp_req_va[EXTVALEN - 2]);
    end
endgenerate
assign m0_dlm = lsp_req_dlm;
assign m0_ilm = lsp_req_ilm;
assign m0_dcu = (s9 & ~s38) | s29;
assign s31 = (s16[1:0] == 2'd0) | (s16[1:0] == 2'd1) | ((s16[1:0] == 2'd2) & s1);
assign s32 = (s16[1:0] == 2'd0) | (s16[1:0] == 2'd1) | ((s16[1:0] == 2'd2) & s1);
assign s34 = (s18 & s31 & m0_ilm & s7) | (s18 & s32 & m0_dlm & s4);
assign s236 = m2_valid & s178 & s199 & (s10 == s151);
assign s52 = s236 ? s171 : s14[12 +:4];
generate
    if (EXTVALEN >= PALEN) begin:gen_m0_pa
        assign s47 = s38 ? s40[PALEN - 1:0] : lsp_req_pa;
    end
    else begin:gen_m0_pa_zext
        wire [PALEN - 1:0] s241;
        kv_zero_ext #(
            .OW(PALEN),
            .IW(EXTVALEN)
        ) u_m0_lm_pa (
            .out(s241),
            .in(s40)
        );
        assign s47 = s38 ? s241 : lsp_req_pa;
    end
endgenerate
assign s11[14] = m0_id;
assign s11[3 +:4] = s13;
assign s11[15] = m0_ilm;
assign s11[9] = m0_dlm;
assign s11[8] = m0_dcu;
assign s11[32] = s39;
assign s11[77] = s29;
assign s11[18] = s24;
assign s11[76] = s25;
assign s11[19] = s33;
assign s11[78] = s30;
assign s11[66 +:8] = s54;
assign s11[74] = s53;
assign s11[59] = s55 & ~m0_ilm & ~m0_dlm & s53;
assign s11[65] = s56 & ~m0_ilm & ~m0_dlm & s53;
assign s11[63] = s57 & ~m0_ilm & ~m0_dlm & s53;
assign s11[64] = s58 & ~m0_ilm & ~m0_dlm & s53;
assign s11[60] = s59 & ~m0_ilm & ~m0_dlm & s53;
assign s11[61] = s60 & ~m0_ilm & ~m0_dlm & s53;
assign s11[62] = s61 & ~m0_ilm & ~m0_dlm & s53;
assign s11[42] = s62 & ~m0_ilm & ~m0_dlm & s53;
assign s11[43 +:3] = s63;
assign s11[46 +:8] = s64;
assign s11[54] = s65;
assign s11[55 +:4] = s66;
assign s11[29] = s28 & (s48 ^ csr_ls_translate_en);
assign s11[2] = s46;
assign s11[17] = s14[2];
assign s11[41] = s14[3];
assign s11[39 +:2] = s14[0 +:2];
assign s11[11 +:3] = s14[34 +:3];
assign s11[20] = s14[4];
assign s11[38] = s14[5];
assign s11[0] = s14[6];
assign s11[7] = s14[10];
assign s11[75] = s14[11];
assign s11[28] = s14[26];
assign s11[79] = s14[25];
assign s11[30] = s14[27];
assign s11[31] = s14[28];
assign s11[10] = s14[29];
assign s11[26] = s14[16];
assign s11[33 +:5] = s14[17 +:5];
assign s11[1] = s14[30];
assign s11[27] = s14[31];
assign s11[16] = s14[33];
assign s11[25] = s14[32];
assign s11[21 +:4] = s52;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        m1_valid <= 1'b0;
        s72 <= {80{1'b0}};
        s74 <= {EXTVALEN{1'b0}};
        s75 <= 3'd0;
        s76 <= 3'd0;
        s80 <= {PALEN{1'b0}};
        s81 <= {4{1'b0}};
        s71 <= {LSP_SRCS{1'b0}};
    end
    else if (~m2_stall) begin
        m1_valid <= m0_valid & ~m0_stall;
        s72 <= s11;
        s74 <= s40;
        s75 <= s44;
        s76 <= s45;
        s80 <= s47;
        s81 <= s49;
        s71 <= s10;
    end
end

kv_dff_gen #(
    .EXPRESSION((DCACHE_PREFETCH_SUPPORT_INT == 1)),
    .W(12)
) u_m1_pc (
    .clk(core_clk),
    .en(s212),
    .d(s15),
    .q(s82)
);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        m1_killed <= 1'b0;
    end
    else begin
        m1_killed <= s130;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s67 <= 1'b0;
    end
    else begin
        s67 <= s68;
    end
end

kv_mux_onehot #(
    .N(LSP_SRCS),
    .W(1)
) u_m1_commit_lsp (
    .out(s69),
    .sel(s71),
    .in(lsp_commit)
);
assign s130 = m2_stall ? s131 : 1'b0;
assign s131 = m1_killed | s129;
assign s68 = m2_stall & (s67 | s69);
assign s70 = s67 | s69;
assign lsu_pma_req_pa = s80;
assign trigm_ls_addr = s78[VALEN - 1:0];
assign trigm_ls_load = m1_load;
assign trigm_ls_store = s85;
assign s119 = s72[15] | s72[9];
assign s120 = (m1_dcu & ~s124 & ~s125) | s92;
assign s127 = s72[19] | (s93 & s124) | (s93 & s125);
assign s118 = ~s119 & ~s120;
assign s237 = m2_valid & s178 & s199 & (s71 == s151);
assign s142 = s237 ? s171 : s72[21 +:4];
assign s143 = pma_lsu_resp_mtype;
assign s144 = (s90 | s96) & ~s119 & ~s113 & ((4'd2 <= s142) && (s142 <= 4'd12));
assign s145 = s144 & (s143 != s142);
assign s116[0] = (s74[1:0] == 2'd0) & ~(s1 & s74[2]);
assign s116[1] = (s74[1:0] == 2'd1) & ~(s1 & s74[2]);
assign s116[2] = (s74[1:0] == 2'd2) & ~(s1 & s74[2]);
assign s116[3] = (s74[1:0] == 2'd3) & ~(s1 & s74[2]);
assign s116[4] = (s74[1:0] == 2'd0) & (s1 & s74[2]);
assign s116[5] = (s74[1:0] == 2'd1) & (s1 & s74[2]);
assign s116[6] = (s74[1:0] == 2'd2) & (s1 & s74[2]);
assign s116[7] = (s74[1:0] == 2'd3) & (s1 & s74[2]);
assign s117[1] = (s76[1:0] == 2'd1) & ~((s1 | s2) & s76[2]);
assign s117[2] = (s76[1:0] == 2'd2) & ~((s1 | s2) & s76[2]);
assign s117[3] = (s76[1:0] == 2'd3) & ~((s1 | s2) & s76[2]);
assign s117[4] = (s76[1:0] == 2'd0) & ((s1 | s2) & s76[2]);
assign s117[5] = (s76[1:0] == 2'd1) & ((s1 | s2) & s76[2]);
assign s117[6] = (s76[1:0] == 2'd2) & ((s1 | s2) & s76[2]);
assign s117[7] = (s76[1:0] == 2'd3) & ((s1 | s2) & s76[2]);
assign s73[18] = s124;
assign s73[53 +:4] = s122;
assign s73[7] = s120;
assign s73[6] = s118;
assign s73[33] = s128;
assign s73[42] = s127;
assign s73[20 +:8] = s132;
assign s73[28] = s133;
assign s73[29 +:4] = s134;
assign s141 = (s90 & ~csr_mmisc_ctl_una) | (s90 & (s86 | s87 | s88)) | (s90 & s124 & s113 & ~s98) | (s99 & s124 & s113) | s89;
assign s140 = s106 | s121 | s123 | s126 | s89 | s145;
assign s149 = (s88 | s85 | s92) ? 6'h7 : 6'h5;
assign s147 = s88 ? 6'h7 : s87 ? 6'h7 : s86 ? 6'h5 : s115 ? s146 : s124 ? s149 : s89 ? s149 : s85 ? 6'h6 : 6'h4;
assign s148 = (s147 == 6'h6) | (s147 == 6'h4);
assign s146 = (s88 | s85 | s92) ? 6'hf : 6'hd;
assign s73[8 +:6] = s135 ? 6'h3 : s141 ? s147 : s115 ? s146 : s140 ? s149 : 6'd0;
assign s73[14 +:3] = s141 ? 3'd4 : s106 ? s107 : s121 ? 3'd2 : s145 ? 3'd6 : s123 ? 3'd5 : s126 ? 3'd7 : 3'd0;
assign s132 = s106 ? s108 : 8'd0;
assign s133 = s106 ? s109 : 1'd0;
assign s134 = s106 ? s110 : 4'd0;
assign s79 = s77;
assign s77[EXTVALEN - 1:3] = s74[EXTVALEN - 1:3];
assign s77[2] = s74[2] & (s83 <= 2'd2);
assign s77[1] = s74[1] & (s83 <= 2'd1);
assign s77[0] = s74[0] & (s83 == 2'd0);
assign s73[102] = s135 | s141 | s115 | s140;
assign s73[37] = s136;
assign s73[89] = s137;
assign s73[88] = s138;
assign s73[87] = s139;
assign s112[0] = m1_load & ((s84[1:0] == 2'd3) | ((s84[1:0] == 2'd2) & ~s74[2]));
assign s112[1] = m1_load & ((s84[1:0] == 2'd2) & s74[2]);
assign s112[2] = m1_load & (s84[1:0] == 2'd3);
assign s112[3] = m1_load & (s84[2:0] == 3'd2) & (s74[2:0] == 3'd0);
assign s112[4] = m1_load & (s84[2:0] == 3'd2) & (s74[2:0] == 3'd4);
assign s111[0] = m1_load & ((s84[1:0] == 2'd3) | (s84[1:0] == 2'd2) | (s84[1:0] == 2'd1));
assign s111[1] = m1_load & ((s84[1:0] == 2'd3) | (s84[1:0] == 2'd2));
assign s111[2] = m1_load & (s84[1:0] == 2'd3);
assign s111[3] = m1_load & (s84[2:0] == 3'd0);
assign s111[4] = m1_load & (s84[2:0] == 3'd1);
assign s111[5] = m1_load & (s84[2:0] == 3'd2);
assign s73[2 +:4] = m1_bank;
assign s73[41] = s72[17];
assign s73[76] = s72[41];
assign s73[74 +:2] = s72[39 +:2];
assign s73[43] = s72[20];
assign s73[73] = s72[38];
assign s73[0] = s72[0];
assign s73[100] = s72[77];
assign s73[39] = s72[15];
assign s73[19] = s72[9];
assign s73[17] = s72[8];
assign s73[78 +:8] = s72[66 +:8];
assign s73[86] = s72[74];
assign s73[77] = s72[59];
assign s73[91] = s72[76];
assign s73[38] = s72[14];
assign s73[57] = s72[28];
assign s73[58] = s72[29];
assign s73[101] = s72[79];
assign s73[59] = s72[30];
assign s73[60] = s72[31];
assign s73[90] = s72[75];
assign s73[45] = s72[26];
assign s73[62 +:5] = s72[33 +:5];
assign s73[61] = s72[32];
assign s73[40] = s72[16];
assign s73[44] = s72[25];
assign s73[34 +:3] = s72[11 +:3];
assign s73[1] = s72[2];
assign s73[46 +:7] = s117;
assign s73[92 +:8] = s116;
assign s73[67 +:6] = s111;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        m2_valid <= 1'b0;
        s157 <= {103{1'b0}};
        s158 <= {EXTVALEN{1'b0}};
        s159 <= {PALEN{1'b0}};
        s161 <= 3'd0;
        s162 <= {4{1'b0}};
        s151 <= {LSP_SRCS{1'b0}};
        s160 <= 3'd0;
    end
    else if (~m2_stall) begin
        m2_valid <= m1_valid;
        s157 <= s73;
        s158 <= s79;
        s159 <= s80;
        s161 <= s76;
        s162 <= s81;
        s151 <= s71;
        s160 <= s75;
    end
end

kv_dff_gen #(
    .EXPRESSION((DCACHE_PREFETCH_SUPPORT_INT == 1)),
    .W(12)
) u_m2_pc (
    .clk(core_clk),
    .en(s212),
    .d(s82),
    .q(s165)
);
kv_dff_gen #(
    .EXPRESSION(1'b0),
    .W(5)
) u_m2_bresult_sel (
    .clk(core_clk),
    .en(s212),
    .d(s112),
    .q(m2_bresult_sel)
);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s153 <= 1'b0;
    end
    else begin
        s153 <= s154;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s208 <= 1'b0;
    end
    else begin
        s208 <= s209;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s155 <= 1'b0;
    end
    else begin
        s155 <= s156;
    end
end

assign m2_alive = m2_valid & ~s153;
kv_mux_onehot #(
    .N(LSP_SRCS),
    .W(1)
) u_m2_commit_lsp (
    .out(s210),
    .sel(s151),
    .in(lsp_commit)
);
assign s154 = m2_stall ? (s153 | s152 | (m2_abort & s211)) : s131;
assign s156 = m2_stall & (s155 | s211);
assign s209 = m2_stall ? (s208 | s211) : s70;
assign s211 = s208 | s210;
assign s194 = m2_sc & ~s175;
assign s195 = s173 | s172 | s194 | s176 | s180;
assign m2_abort = s195 | s174 | s196;
assign s150 = m2_alive & s211 & ~m2_abort & ~s152;
assign s214 = (s150 & m2_c & rob_valid & ls_rob_status[0]);
assign s215 = m2_alive & s211 & s174;
assign s213 = s214 | s215;
assign s216 = s174 | s196 | lsp_ack_status[14] | lsp_ack_status[15];
assign s198 = (m2_load & m2_ilm & csr_milmb_rwecc) | (m2_load & m2_dlm & csr_mdlmb_rwecc);
assign s197[0] = s182;
assign s197[1] = s183;
assign s197[2] = 1'b0;
assign s163 = csr_halt_mode | (s207 & m2_store) | (s206 & m2_load);
assign s196 = m2_load & (s171 == 4'd8) & dcu_wna_pending;
kv_lsu_rob #(
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .EXTVALEN(EXTVALEN)
) u_lsu_rob (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .m0_valid(m0_valid),
    .m0_stall(m0_stall),
    .m0_load(m0_load),
    .m0_id(m0_id),
    .m1_id(m1_id),
    .m2_id(m2_id),
    .m1_bank(m1_bank),
    .m2_bank(m2_bank),
    .m0_ilm(m0_ilm),
    .m0_dlm(m0_dlm),
    .m0_dcu(m0_dcu),
    .m1_valid(m1_valid),
    .m1_killed(m1_killed),
    .m1_ilm(m1_ilm),
    .m1_dlm(m1_dlm),
    .m1_dcu(m1_dcu),
    .m1_load(m1_load),
    .m1_nbload(m1_nbload),
    .m2_valid(m2_valid),
    .m2_alive(m2_alive),
    .m2_committed(s211),
    .m2_abort(m2_abort),
    .m2_ilm(m2_ilm),
    .m2_dlm(m2_dlm),
    .m2_dcu(m2_dcu),
    .m2_biu(m2_biu),
    .m2_c(m2_c),
    .m2_load(m2_load),
    .m2_nbload(m2_nbload),
    .m2_store(m2_store),
    .m2_lr(m2_lr),
    .m2_sc(m2_sc),
    .m2_va_onehot(m2_va_onehot),
    .m2_offset_onehot(m2_offset_onehot),
    .m2_result_sel(m2_result_sel),
    .m2_bresult_sel(m2_bresult_sel),
    .ilm_resp_valid(ilm_resp_valid),
    .ilm_rdata(ilm_rdata),
    .ilm_resp_status(ilm_resp_status),
    .ilm_w_ready(lsu_ilm_w_ready),
    .dlm_resp_valid0(dlm_resp_valid0),
    .dlm_resp_valid1(dlm_resp_valid1),
    .dlm_resp_valid2(dlm_resp_valid2),
    .dlm_resp_valid3(dlm_resp_valid3),
    .dlm_resp_status0(dlm_resp_status0),
    .dlm_resp_status1(dlm_resp_status1),
    .dlm_resp_status2(dlm_resp_status2),
    .dlm_resp_status3(dlm_resp_status3),
    .dlm0_resp_id(dlm0_resp_id),
    .dlm1_resp_id(dlm1_resp_id),
    .dlm2_resp_id(dlm2_resp_id),
    .dlm3_resp_id(dlm3_resp_id),
    .dlm_rdata0(dlm_rdata0),
    .dlm_rdata1(dlm_rdata1),
    .dlm_rdata2(dlm_rdata2),
    .dlm_rdata3(dlm_rdata3),
    .dlm_w_ready(s234),
    .dcu_ack_valid(dcu_ack_valid),
    .dcu_ack_id(dcu_ack_id),
    .dcu_rdata(dcu_ack_rdata),
    .dcu_ack_status(dcu_ack_status),
    .dcu_cri_valid(dcu_cri_valid),
    .dcu_cri_id(dcu_cri_id),
    .dcu_cri_rdata(dcu_cri_rdata),
    .dcu_cri_nbload_result(dcu_cri_nbload_result),
    .dcu_cri_status(dcu_cri_status),
    .biu_bk_valid(biu_bk_valid),
    .biu_bk_error(biu_bk_error),
    .biu_bk_exokay(biu_bk_exokay),
    .biu_bk_rdata(biu_bk_rdata),
    .biu_resp_valid(biu_resp_valid),
    .biu_stall(biu_stall),
    .rob_valid(rob_valid),
    .ls_rob_status(ls_rob_status),
    .fmt_result(fmt_result),
    .fmt_result2(fmt_result2),
    .fmt_bresult(fmt_bresult),
    .m2_stall(m2_stall),
    .m2_resp_valid(m2_resp_valid),
    .nbload_resp_valid(nbload_resp_valid),
    .nbload_resp_rd(nbload_resp_rd),
    .nbload_resp_result(nbload_resp_result),
    .nbload_resp_status(nbload_resp_status),
    .lsu_async_read_error(lsu_async_read_error),
    .prf_resp_valid(prf_resp_valid),
    .prf_resp_id(prf_resp_id),
    .prf_resp_status(prf_resp_status)
);
kv_fmt_store #(
    .FLEN(FLEN)
) u_kv_fmt_store (
    .addr(s158[2:0]),
    .offset(s161[2:0]),
    .cmt_wdata(lsp_cmt_wdata),
    .fmt_wdata(fmt_wdata)
);
assign lsu_dtlb_lru_valid = m2_alive & ~s174 & ~s168 & ~m2_stall & s157[86] & ~s164;
assign lsu_dtlb_lru_wdata = s157[78 +:8];
assign lsu_pmp_req_pa = s80;
assign lsu_pmp_req_store = s85 | s94;
assign dcu_req_valid = m0_valid & ~s37;
assign dcu_req_stall = ~m0_dcu;
assign dcu_req_id = m0_id;
assign dcu_req_addr = s47;
assign dcu_req_func[0] = m0_load;
assign dcu_req_func[1] = s18;
assign dcu_req_func[2] = s20;
assign dcu_req_func[3] = s19;
assign dcu_req_func[4] = s21;
assign dcu_req_func[5] = s22;
assign dcu_req_func[6] = s23;
assign dcu_req_func[7 +:2] = s16;
assign dcu_req_func[18 +:3] = s17;
assign dcu_req_func[15] = s24;
assign dcu_req_func[16] = s25;
assign dcu_req_func[9] = s26;
assign dcu_req_func[10 +:5] = s27;
assign dcu_req_func[17] = s28;
assign dcu_req_func[21] = csr_halt_mode;
assign dcu_cmt_valid = m2_valid & m2_dcu & s211 & ~s155;
assign dcu_cmt_addr = s159;
assign dcu_cmt_wmask = s162;
assign dcu_cmt_wdata = fmt_wdata;
assign dcu_cmt_func[0] = ~s150 | ~m2_c | s238;
assign dcu_cmt_func[1] = s163;
assign dcu_cmt_func[2] = s205;
assign dcu_cmt_func[3 +:4] = s171;
assign dcu_cmt_func[7] = m2_load;
assign dcu_cmt_func[8] = m2_store;
assign dcu_cmt_func[9] = s185;
assign dcu_cmt_func[10] = s177;
assign dlm_rdata0 = lsu_dlm0_d_data;
assign dlm_rdata1 = lsu_dlm1_d_data;
assign dlm_rdata2 = lsu_dlm2_d_data;
assign dlm_rdata3 = lsu_dlm3_d_data;
assign dlm_resp_valid0 = lsu_dlm0_d_valid;
assign dlm_resp_valid1 = lsu_dlm1_d_valid;
assign dlm_resp_valid2 = lsu_dlm2_d_valid;
assign dlm_resp_valid3 = lsu_dlm3_d_valid;
assign dlm_resp_status0[0] = lsu_dlm0_d_status[0];
assign dlm_resp_status0[1] = (s5 & lsu_dlm0_d_status[1]);
assign dlm_resp_status0[2] = (s6 & lsu_dlm0_d_status[1]) | (s6 & lsu_dlm0_d_status[2]) | (s5 & lsu_dlm0_d_status[2]) | lsu_dlm0_d_status[13];
assign dlm_resp_status0[3 +:3] = lsu_dlm0_d_status[13] ? 3'd3 : 3'd1;
assign dlm_resp_status0[6] = 1'b1;
assign dlm_resp_status0[7] = 1'b0;
assign dlm_resp_status0[8] = 1'b0;
assign dlm_resp_status0[9 +:8] = lsu_dlm0_d_status[3 +:8];
assign dlm_resp_status0[17] = lsu_dlm0_d_status[1];
assign dlm_resp_status0[18 +:4] = 4'd9;
assign dlm_resp_status0[22] = 1'b0;
assign dlm_resp_status1[0] = lsu_dlm1_d_status[0];
assign dlm_resp_status1[1] = (s5 & lsu_dlm1_d_status[1]);
assign dlm_resp_status1[2] = (s6 & lsu_dlm1_d_status[1]) | (s6 & lsu_dlm1_d_status[2]) | (s5 & lsu_dlm1_d_status[2]) | lsu_dlm1_d_status[13];
assign dlm_resp_status1[3 +:3] = lsu_dlm1_d_status[13] ? 3'd3 : 3'd1;
assign dlm_resp_status1[6] = 1'b1;
assign dlm_resp_status1[7] = 1'b0;
assign dlm_resp_status1[8] = 1'b0;
assign dlm_resp_status1[9 +:8] = lsu_dlm1_d_status[3 +:8];
assign dlm_resp_status1[17] = lsu_dlm1_d_status[1];
assign dlm_resp_status1[18 +:4] = 4'd9;
assign dlm_resp_status1[22] = 1'b0;
assign dlm_resp_status2[0] = lsu_dlm2_d_status[0];
assign dlm_resp_status2[1] = (s5 & lsu_dlm2_d_status[1]);
assign dlm_resp_status2[2] = (s6 & lsu_dlm2_d_status[1]) | (s6 & lsu_dlm2_d_status[2]) | (s5 & lsu_dlm2_d_status[2]) | lsu_dlm2_d_status[13];
assign dlm_resp_status2[3 +:3] = lsu_dlm2_d_status[13] ? 3'd3 : 3'd1;
assign dlm_resp_status2[6] = 1'b1;
assign dlm_resp_status2[7] = 1'b0;
assign dlm_resp_status2[8] = 1'b0;
assign dlm_resp_status2[9 +:8] = lsu_dlm2_d_status[3 +:8];
assign dlm_resp_status2[17] = lsu_dlm2_d_status[1];
assign dlm_resp_status2[18 +:4] = 4'd9;
assign dlm_resp_status2[22] = 1'b0;
assign dlm_resp_status3[0] = lsu_dlm3_d_status[0];
assign dlm_resp_status3[1] = (s5 & lsu_dlm3_d_status[1]);
assign dlm_resp_status3[2] = (s6 & lsu_dlm3_d_status[1]) | (s6 & lsu_dlm3_d_status[2]) | (s5 & lsu_dlm3_d_status[2]) | lsu_dlm3_d_status[13];
assign dlm_resp_status3[3 +:3] = lsu_dlm3_d_status[13] ? 3'd3 : 3'd1;
assign dlm_resp_status3[6] = 1'b1;
assign dlm_resp_status3[7] = 1'b0;
assign dlm_resp_status3[8] = 1'b0;
assign dlm_resp_status3[9 +:8] = lsu_dlm3_d_status[3 +:8];
assign dlm_resp_status3[17] = lsu_dlm3_d_status[1];
assign dlm_resp_status3[18 +:4] = 4'd9;
assign dlm_resp_status3[22] = 1'b0;
assign s235 = (NUM_DLM_BANKS == 1) ? 2'b00 : (NUM_DLM_BANKS == 2) ? {1'b0,s42[2]} : s42[3:2];
generate
    if ((DLM_SIZE_KB != 0) && (NUM_DLM_BANKS == 1)) begin:gen_one_bank_dlm_ctrl
        wire [DLM_AMSB:0] s242;
        wire [2:0] s243;
        wire s244;
        wire s245;
        wire [0:0] s246;
        wire s247;
        wire s248;
        assign s247 = m0_valid;
        assign s245 = ~m0_dlm | s50 | m2_stall;
        assign s242 = s43[DLM_AMSB:0];
        assign s243[0] = s35;
        assign s243[1] = s36;
        assign s243[2] = csr_mdlmb_rwecc;
        assign s246 = m0_id;
        assign lsu_dlm0_a_valid = s247;
        assign lsu_dlm0_a_stall = s245;
        assign lsu_dlm0_a_addr = s242;
        assign lsu_dlm0_a_func = s243;
        assign lsu_dlm0_a_user = s246;
        assign s244 = lsu_dlm0_a_ready;
        assign lsu_dlm0_w_valid = m2_valid & s211 & m2_store & m2_dlm;
        assign lsu_dlm0_w_data = fmt_wdata;
        assign lsu_dlm0_w_mask = s162 & {4{s150}};
        assign s248 = lsu_dlm0_w_status;
        assign s234 = lsu_dlm0_w_ready;
        assign s233 = s244;
        assign s232 = s244;
        assign s201 = m2_store & m2_dlm & s248;
        assign lsu_dlm1_a_addr = {(DLM_AMSB + 1){1'b0}};
        assign lsu_dlm1_a_func = {3{1'b0}};
        assign lsu_dlm1_a_stall = 1'b0;
        assign lsu_dlm1_a_user = 1'b0;
        assign lsu_dlm1_a_valid = 1'b0;
        assign lsu_dlm2_a_addr = {(DLM_AMSB + 1){1'b0}};
        assign lsu_dlm2_a_func = {3{1'b0}};
        assign lsu_dlm2_a_stall = 1'b0;
        assign lsu_dlm2_a_user = 1'b0;
        assign lsu_dlm2_a_valid = 1'b0;
        assign lsu_dlm3_a_addr = {(DLM_AMSB + 1){1'b0}};
        assign lsu_dlm3_a_func = {3{1'b0}};
        assign lsu_dlm3_a_stall = 1'b0;
        assign lsu_dlm3_a_user = 1'b0;
        assign lsu_dlm3_a_valid = 1'b0;
        assign lsu_dlm1_w_data = {32{1'b0}};
        assign lsu_dlm1_w_mask = {4{1'b0}};
        assign lsu_dlm1_w_valid = 1'b0;
        assign lsu_dlm2_w_data = {32{1'b0}};
        assign lsu_dlm2_w_mask = {4{1'b0}};
        assign lsu_dlm2_w_valid = 1'b0;
        assign lsu_dlm3_w_data = {32{1'b0}};
        assign lsu_dlm3_w_mask = {4{1'b0}};
        assign lsu_dlm3_w_valid = 1'b0;
    end
    else if (DLM_SIZE_KB != 0) begin:gen_multi_bank_dlm_ctrl
        wire [DLM_AMSB:0] s242;
        wire [2:0] s243;
        wire s244;
        wire s245;
        wire [0:0] s246;
        wire s247;
        wire s248;
        wire s249 = (NUM_DLM_BANKS == 4);
        assign s247 = m0_valid;
        assign s245 = ~m0_dlm | s50 | m2_stall;
        assign s242 = s43[DLM_AMSB:0];
        assign s243[0] = s35;
        assign s243[1] = s36;
        assign s243[2] = csr_mdlmb_rwecc;
        assign s246 = m0_id;
        kv_lm_a_bank_sel #(
            .AW(DLM_AMSB + 1),
            .BANKS(NUM_DLM_BANKS),
            .DW(32),
            .UW(1)
        ) u_lsu_a_bank_sel (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .us_bank_sel(s235),
            .us_a_valid(s247),
            .us_a_stall(s245),
            .us_a_ready(s244),
            .us_a_func(s243),
            .us_a_addr(s242),
            .us_a_user(s246),
            .ds0_a_valid(lsu_dlm0_a_valid),
            .ds0_a_ready(lsu_dlm0_a_ready),
            .ds0_a_func(lsu_dlm0_a_func),
            .ds0_a_addr(lsu_dlm0_a_addr),
            .ds0_a_user(lsu_dlm0_a_user),
            .ds0_a_stall(lsu_dlm0_a_stall),
            .ds1_a_valid(lsu_dlm1_a_valid),
            .ds1_a_ready(lsu_dlm1_a_ready),
            .ds1_a_func(lsu_dlm1_a_func),
            .ds1_a_addr(lsu_dlm1_a_addr),
            .ds1_a_user(lsu_dlm1_a_user),
            .ds1_a_stall(lsu_dlm1_a_stall),
            .ds2_a_valid(lsu_dlm2_a_valid),
            .ds2_a_ready(lsu_dlm2_a_ready),
            .ds2_a_func(lsu_dlm2_a_func),
            .ds2_a_addr(lsu_dlm2_a_addr),
            .ds2_a_user(lsu_dlm2_a_user),
            .ds2_a_stall(lsu_dlm2_a_stall),
            .ds3_a_valid(lsu_dlm3_a_valid),
            .ds3_a_ready(lsu_dlm3_a_ready),
            .ds3_a_func(lsu_dlm3_a_func),
            .ds3_a_addr(lsu_dlm3_a_addr),
            .ds3_a_user(lsu_dlm3_a_user),
            .ds3_a_stall(lsu_dlm3_a_stall)
        );
        assign lsu_dlm0_w_valid = m2_valid & s211 & m2_store & m2_dlm & m2_bank[0];
        assign lsu_dlm1_w_valid = m2_valid & s211 & m2_store & m2_dlm & m2_bank[1];
        assign lsu_dlm2_w_valid = m2_valid & s211 & m2_store & m2_dlm & m2_bank[2] & s249;
        assign lsu_dlm3_w_valid = m2_valid & s211 & m2_store & m2_dlm & m2_bank[3] & s249;
        assign lsu_dlm0_w_data = fmt_wdata;
        assign lsu_dlm1_w_data = fmt_wdata;
        assign lsu_dlm2_w_data = fmt_wdata & {32{s249}};
        assign lsu_dlm3_w_data = fmt_wdata & {32{s249}};
        assign lsu_dlm0_w_mask = s162 & {4{s150}};
        assign lsu_dlm1_w_mask = s162 & {4{s150}};
        assign lsu_dlm2_w_mask = s162 & {4{s150 & s249}};
        assign lsu_dlm3_w_mask = s162 & {4{s150 & s249}};
        assign s248 = (lsu_dlm0_w_status & m2_bank[0]) | (lsu_dlm1_w_status & m2_bank[1]) | (lsu_dlm2_w_status & m2_bank[2] & s249) | (lsu_dlm3_w_status & m2_bank[3] & s249);
        assign s234 = (lsu_dlm0_w_ready & m2_bank[0]) | (lsu_dlm1_w_ready & m2_bank[1]) | (lsu_dlm2_w_ready & m2_bank[2] & s249) | (lsu_dlm3_w_ready & m2_bank[3] & s249);
        assign s233 = s244;
        assign s232 = s244;
        assign s201 = m2_store & m2_dlm & s248;
    end
    else begin:gen_dlm_ctrl_stub
        assign s233 = 1'b1;
        assign s232 = 1'b1;
        assign lsu_dlm0_a_addr = {(DLM_AMSB + 1){1'b0}};
        assign lsu_dlm0_a_func = {3{1'b0}};
        assign lsu_dlm0_a_stall = 1'b0;
        assign lsu_dlm0_a_user = 1'b0;
        assign lsu_dlm0_a_valid = 1'b0;
        assign lsu_dlm1_a_addr = {(DLM_AMSB + 1){1'b0}};
        assign lsu_dlm1_a_func = {3{1'b0}};
        assign lsu_dlm1_a_stall = 1'b0;
        assign lsu_dlm1_a_user = 1'b0;
        assign lsu_dlm1_a_valid = 1'b0;
        assign lsu_dlm2_a_addr = {(DLM_AMSB + 1){1'b0}};
        assign lsu_dlm2_a_func = {3{1'b0}};
        assign lsu_dlm2_a_stall = 1'b0;
        assign lsu_dlm2_a_user = 1'b0;
        assign lsu_dlm2_a_valid = 1'b0;
        assign lsu_dlm3_a_addr = {(DLM_AMSB + 1){1'b0}};
        assign lsu_dlm3_a_func = {3{1'b0}};
        assign lsu_dlm3_a_stall = 1'b0;
        assign lsu_dlm3_a_user = 1'b0;
        assign lsu_dlm3_a_valid = 1'b0;
        assign lsu_dlm0_w_data = {32{1'b0}};
        assign lsu_dlm0_w_mask = {4{1'b0}};
        assign lsu_dlm0_w_valid = 1'b0;
        assign lsu_dlm1_w_data = {32{1'b0}};
        assign lsu_dlm1_w_mask = {4{1'b0}};
        assign lsu_dlm1_w_valid = 1'b0;
        assign lsu_dlm2_w_data = {32{1'b0}};
        assign lsu_dlm2_w_mask = {4{1'b0}};
        assign lsu_dlm2_w_valid = 1'b0;
        assign lsu_dlm3_w_data = {32{1'b0}};
        assign lsu_dlm3_w_mask = {4{1'b0}};
        assign lsu_dlm3_w_valid = 1'b0;
        assign s201 = 1'b0;
        assign s234 = 1'b0;
    end
endgenerate
generate
    if (ILM_SIZE_KB != 0) begin:gen_ilm_ctrl
        wire s250 = s7 & (csr_milmb_eccen == 2'd2);
        wire s251 = s7 & (csr_milmb_eccen == 2'd3);
        wire [ILM_AMSB + 3:0] s252;
        wire s253;
        wire nds_unused_ilm_a_fifo_wready;
        wire s254;
        wire s255;
        wire [ILM_AMSB + 3:0] s256;
        wire s257;
        wire s258;
        kv_fifo #(
            .DEPTH(2),
            .WIDTH(ILM_AMSB + 3 + 1)
        ) u_ilm_a_fifo (
            .clk(core_clk),
            .reset_n(core_reset_n),
            .flush(1'b0),
            .wdata(s252),
            .wvalid(s253),
            .wready(nds_unused_ilm_a_fifo_wready),
            .rdata(s256),
            .rvalid(s254),
            .rready(s255)
        );
        assign s252 = {csr_milmb_rwecc,s36,s35,s42[ILM_AMSB:0]};
        assign s253 = m0_valid & m0_ilm & ~m0_stall;
        assign s255 = lsu_ilm_a_ready;
        assign lsu_ilm_a_valid = s254;
        assign lsu_ilm_a_stall = 1'b0;
        assign {lsu_ilm_a_func[2],lsu_ilm_a_func[1],lsu_ilm_a_func[0],lsu_ilm_a_addr} = s256;
        assign lsu_ilm_a_user = {2'd0,lsu_ilm_a_addr[2]};
        assign s258 = m2_stall & lsu_ilm_w_ready;
        kv_stall_filter u_lsu_ilm_w_valid(
            .clk(core_clk),
            .reset_n(core_reset_n),
            .valid_pre(s257),
            .stall(s258),
            .valid(lsu_ilm_w_valid)
        );
        assign s257 = m2_valid & s211 & m2_store & m2_ilm;
        assign lsu_ilm_w_data[31:0] = fmt_wdata[31:0];
        assign lsu_ilm_w_data[63:32] = fmt_wdata[31 -:32];
        assign lsu_ilm_w_mask[3:0] = s162[0 +:4] & {4{(~s158[2] | s1) & s150}};
        assign lsu_ilm_w_mask[7:4] = s162[3 -:4] & {4{(s158[2] | s1) & s150}};
        assign ilm_rdata = (lsu_ilm_d_user[0]) ? lsu_ilm_d_data[63 -:32] : lsu_ilm_d_data[0 +:32];
        assign s217 = lsu_ilm_a_ready;
        assign s218 = lsu_ilm_a_ready;
        assign ilm_resp_valid = lsu_ilm_d_valid;
        assign ilm_resp_status[0] = lsu_ilm_d_status[0];
        assign ilm_resp_status[1] = (s250 & lsu_ilm_d_status[1]);
        assign ilm_resp_status[2] = (s251 & lsu_ilm_d_status[1]) | (s251 & lsu_ilm_d_status[2]) | (s250 & lsu_ilm_d_status[2]) | lsu_ilm_d_status[13];
        assign ilm_resp_status[3 +:3] = lsu_ilm_d_status[13] ? 3'd3 : 3'd1;
        assign ilm_resp_status[6] = 1'b1;
        assign ilm_resp_status[7] = 1'b0;
        assign ilm_resp_status[8] = 1'b0;
        assign ilm_resp_status[9 +:8] = lsu_ilm_d_status[3 +:8];
        assign ilm_resp_status[17] = lsu_ilm_d_status[1];
        assign ilm_resp_status[18 +:4] = 4'd8;
        assign ilm_resp_status[22] = 1'b0;
        assign s200 = m2_store & m2_ilm & lsu_ilm_w_status;
    end
    else begin:gen_ilm_ctrl_stub
        assign s217 = 1'b1;
        assign s218 = 1'b1;
        assign ilm_rdata = {32{1'b0}};
        assign ilm_resp_valid = 1'b0;
        assign ilm_resp_status = {23{1'b0}};
        assign lsu_ilm_a_addr = {(ILM_AMSB + 1){1'b0}};
        assign lsu_ilm_a_func = {3{1'b0}};
        assign lsu_ilm_a_stall = 1'b0;
        assign lsu_ilm_a_user = 3'b0;
        assign lsu_ilm_a_valid = 1'b0;
        assign lsu_ilm_w_data = {64{1'b0}};
        assign lsu_ilm_w_mask = {8{1'b0}};
        assign lsu_ilm_w_valid = 1'b0;
        assign s200 = 1'b0;
        wire [1:0] nds_unused_csr_milmb_eccen = csr_milmb_eccen;
        wire nds_unused_csr_milmb_rwecc = csr_milmb_rwecc;
        wire nds_unused_lsu_ilm_a_ready = lsu_ilm_a_ready;
        wire [63:0] nds_unused_lsu_ilm_d_data = lsu_ilm_d_data;
        wire [13:0] nds_unused_lsu_ilm_d_status = lsu_ilm_d_status;
        wire [2:0] nds_unused_lsu_ilm_d_user = lsu_ilm_d_user;
        wire nds_unused_lsu_ilm_d_valid = lsu_ilm_d_valid;
        wire nds_unused_lsu_ilm_w_status = lsu_ilm_w_status;
    end
endgenerate
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s224 <= {{(BIU_STATE_BITS - 1){1'b0}},1'b1};
    end
    else if (s226) begin
        s224 <= s225;
    end
end

always @* begin
    s225 = {BIU_STATE_BITS{1'b0}};
    case (1'b1)
        s224[BIU_STATE_IDLE]: begin
            s225[BIU_STATE_NB] = m2_store & ~m2_sc;
            s225[BIU_STATE_BK] = ~(m2_store & ~m2_sc);
            s226 = s221;
        end
        s224[BIU_STATE_NB]: begin
            s225[BIU_STATE_IDLE] = 1'b1;
            s226 = s222;
        end
        s224[BIU_STATE_BK]: begin
            s225[BIU_STATE_RESP] = 1'b1;
            s226 = s222;
        end
        s224[BIU_STATE_RESP]: begin
            s225[BIU_STATE_IDLE] = 1'b1;
            s226 = 1'b1;
        end
        default: begin
            s225 = {BIU_STATE_BITS{1'b0}};
            s226 = 1'b0;
        end
    endcase
end

kv_pma2axcache u_axcache(
    .c2nc(1'b1),
    .pma_mtype(s171),
    .arcache(s203),
    .awcache(s204)
);
assign s221 = lspipe_a_valid & lspipe_a_ready;
assign s222 = lspipe_d_valid & lspipe_d_ready;
assign s223 = lspipe_d_denied | lspipe_d_corrupt | lspipe_d_user[1];
assign lspipe_a_valid = s150 & s157[6] & s227;
assign lspipe_a_address[PALEN - 1:3] = s159[PALEN - 1:3];
assign lspipe_a_address[2] = s159[2] & (s166 <= 2'd2);
assign lspipe_a_address[1] = s159[1] & (s166 <= 2'd1);
assign lspipe_a_address[0] = s159[0] & (s166 == 2'd0);
assign lspipe_a_opcode = ({3{s157[41]}} & 3'd4) | ({3{s157[76]}} & 3'd1);
assign lspipe_a_size = {1'b0,s166};
assign lspipe_a_param[2:0] = 3'd0;
assign lspipe_a_user[0 +:3] = s197;
assign lspipe_a_user[3 +:4] = m2_load ? s203 : s204;
assign lspipe_a_user[7] = m2_lr | m2_sc;
assign lspipe_a_corrupt = 1'b0;
assign lspipe_a_data = fmt_wdata;
assign lspipe_a_mask = s162;
assign lspipe_a_source = 1'd0;
assign s231 = (m2_store & ~m2_sc & s227 & lspipe_a_ready);
assign biu_resp_valid = s230 | s231;
assign biu_stall = (m2_alive & m2_biu & ~m2_abort & ~biu_resp_valid);
assign biu_bk_valid = s228 & s222;
assign biu_bk_rdata = lspipe_d_data;
assign biu_bk_error = s223;
assign biu_bk_exokay = lspipe_d_user[0];
assign lsu_async_write_error = (s229 & s222 & s223);
assign lspipe_d_ready = 1'b1;
assign lsp_ack_status[0] = s157[37];
assign lsp_ack_status[13] = s174;
assign lsp_ack_status[1] = m2_abort ? s157[102] : ls_rob_status[2];
assign lsp_ack_status[15] = m2_abort ? s196 : ls_rob_status[0] | s202 | s238;
assign lsp_ack_status[14] = m2_abort ? 1'b0 : ls_rob_status[1];
assign lsp_ack_status[16] = m2_abort ? 1'b0 : ls_rob_status[7];
assign lsp_ack_status[22 +:8] = m2_abort ? s191 : ls_rob_status[9 +:8];
assign lsp_ack_status[30] = m2_abort ? s192 : ls_rob_status[17];
assign lsp_ack_status[31 +:4] = m2_abort ? s193 : ls_rob_status[18 +:4];
assign lsp_ack_status[35] = m2_abort ? 1'd0 : s198;
assign lsp_ack_status[2 +:6] = m2_abort ? s157[8 +:6] : s170 ? 6'h7 : s167 ? 6'h7 : m2_store ? 6'h7 : 6'h5;
assign lsp_ack_status[8 +:3] = m2_abort ? s157[14 +:3] : ls_rob_status[3 +:3];
assign lsp_ack_status[12] = s175 & ls_rob_status[6];
assign lsp_ack_status[11] = m2_sc;
assign lsp_ack_status[17 +:4] = s171;
assign lsp_ack_status[21] = m2_abort ? ~s176 : ls_rob_status[22];
assign lsp_ack_status[37] = s186;
assign lsp_ack_status[36] = s187;
assign lsp_ack_status[38 +:3] = s161;
assign lsp_ack_status[41] = s178;
assign lsp_ack_status[42] = m2_abort ? 1'b0 : s188;
assign lsp_ack_status[43] = m2_abort ? 1'b0 : s189;
assign lsp_ack_status[44] = m2_abort ? 1'b0 : s190;
assign lsp_ack_va = s158;
assign lsp_ack_pa = s159;
assign lsp_ack_src = s151;
assign lsp_ack_kill = s152;
assign lsp_ack_result = fmt_result;
assign lsp_ack_bresult = fmt_bresult;
assign lsp_ack_result2 = fmt_result2;
assign lsp_ack_fault_va = {s158[EXTVALEN - 1:3],s160};
assign lsp_ack_valid = m2_alive & s211 & (m2_resp_valid | m2_abort);
generate
    if (PERFORMANCE_MONITOR_INT == 1) begin:gen_pfm_events
        reg [3:0] s259;
        wire [3:0] s260;
        always @(posedge core_clk) begin
            s259 <= s260;
        end

        assign s260[0] = m2_valid & m2_load & m2_biu & ~m2_stall;
        assign s260[1] = m2_valid & m2_load & m2_biu & m2_stall;
        assign s260[2] = m2_valid & m2_c & m2_stall;
        assign s260[3] = m2_valid & s177 & s220 & ~m2_abort & ~s216;
        assign lsp_event = s259;
    end
    else begin:gen_pfm_events_stub
        assign lsp_event = {4{1'b0}};
    end
endgenerate
generate
    if (RVA_SUPPORT_INT == 1) begin:gen_rva_lrsc
        reg s261;
        wire s262;
        wire s263;
        wire s264;
        reg [EXTVALEN - 1:2] s265;
        wire s266;
        reg s267;
        wire s268 = s166 == 2'b10;
        wire s269 = s83 == 2'b10;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s261 <= 1'b0;
            end
            else begin
                s261 <= s264;
            end
        end

        always @(posedge core_clk) begin
            if (s262) begin
                s265 <= s158[EXTVALEN - 1:2];
                s267 <= s268;
            end
        end

        assign s264 = s262 | (s261 & ~s263);
        assign s262 = s150 & ~m2_stall & m2_lr & ls_rob_status[6] & ~ls_rob_status[0] & ~ls_rob_status[1] & ~ls_rob_status[2];
        assign s263 = (lsp_ack_valid & ~s216 & ~s152) | lsp_reserve_clr;
        assign s266 = (s74[EXTVALEN - 1:2] == s265[EXTVALEN - 1:2]) & (s269 == s267);
        assign s128 = ~s87 | (s261 & s266);
    end
    else begin:gen_no_rva_lrsc
        assign s128 = 1'b0;
    end
endgenerate
generate
    if ((DCACHE_PREFETCH_SUPPORT_INT == 1)) begin:gen_rpt_cmt
        reg s270;
        reg s271;
        reg [11:0] s272;
        reg [EXTVALEN - 1:0] s273;
        reg [16:0] s274;
        wire s275;
        wire s276;
        wire [11:0] s277;
        wire [EXTVALEN - 1:0] s278;
        wire [16:0] s279;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s270 <= 1'b0;
            end
            else begin
                s270 <= s275;
            end
        end

        always @(posedge core_clk) begin
            if (lsp_ack_valid) begin
                s271 <= s276;
                s272 <= s277;
                s273 <= s278;
                s274 <= s279;
            end
        end

        assign s275 = lsp_ack_valid & ~s169;
        assign s276 = s152;
        assign s277 = s165;
        assign s278 = s158;
        assign s279[0] = m2_load & ~s167 & ~m2_lr;
        assign s279[1] = s216;
        assign s279[2] = s177;
        assign s279[4] = s220;
        assign s279[3] = s181;
        assign s279[5] = s195 | s219 | s168;
        assign s279[6 +:4] = s171;
        assign s279[10] = m2_c & ~s163;
        assign s279[11] = m2_nbload;
        assign s279[12 +:5] = s184;
        assign rpt_cmt_valid = s270;
        assign rpt_cmt_kill = s271;
        assign rpt_cmt_pc = s272;
        assign rpt_cmt_va = s273;
        assign rpt_cmt_status = s274;
    end
    else begin:gen_rpt_cmt_stub
        assign rpt_cmt_valid = 1'b0;
        assign rpt_cmt_kill = 1'b0;
        assign rpt_cmt_pc = {12{1'b0}};
        assign rpt_cmt_va = {EXTVALEN{1'b0}};
        assign rpt_cmt_status = {17{1'b0}};
        wire [11:0] nds_unused_m2_pc = s165;
    end
endgenerate
wire nds_unused_signals = |{lsu_dlm0_a_ready,lsu_dlm0_w_ready,lsu_dlm0_w_status,lsu_dlm1_a_ready,lsu_dlm1_w_ready,lsu_dlm1_w_status,lsu_dlm2_a_ready,lsu_dlm2_w_ready,lsu_dlm2_w_status,lsu_dlm3_a_ready,lsu_dlm3_w_ready,lsu_dlm3_w_status,lsp_reserve_clr,lspipe_d_sink,lspipe_d_opcode,lspipe_d_param,lspipe_d_source,lspipe_d_size,s36,s35,s42,s216,s181,s169,s177,s184,s219,s220};
endmodule


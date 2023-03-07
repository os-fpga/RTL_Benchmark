// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lsuop (
    core_clk,
    core_reset_n,
    csr_halt_mode,
    csr_mcache_ctl_dc_en,
    csr_mcache_ctl_ic_rwecc,
    csr_mcache_ctl_tlb_rwecc,
    csr_mcctlbeginaddr,
    csr_milmb_ien,
    csr_mdlmb_den,
    ls_issue_ready,
    ls_standby_ready,
    wfi_enabled,
    ls_privilege_m,
    ls_privilege_s,
    ls_privilege_u,
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
    ls_resp_fault_addr,
    ls_resp_status,
    ls_resp_result_64b,
    ls_cmt_valid,
    ls_cmt_kill,
    ls_cmt_wdata_sel_vpu,
    ls_cmt_wdata_base,
    ls_cmt_wdata_vpu,
    lsu_reserve_clr,
    lsp_reserve_clr,
    ifu_fence_req,
    ifu_fence_done,
    lsu_cctl_raddr,
    lsu_cctl_rdata,
    ifu_cctl_req,
    ifu_cctl_command,
    ifu_cctl_waddr,
    ifu_cctl_wdata,
    ifu_cctl_ack,
    ifu_cctl_status,
    ifu_cctl_raddr,
    ifu_cctl_rdata,
    ifu_cctl_ecc_status,
    dcu_ix_req,
    dcu_ix_addr,
    dcu_ix_command,
    dcu_ix_wdata,
    dcu_ix_ack,
    dcu_ix_rdata,
    dcu_ix_raddr,
    dcu_ix_status,
    dcu_wbf_flush,
    dcu_acctl_ecc_error,
    dcu_acctl_ecc_corr,
    tlb_cctl_req,
    tlb_cctl_command,
    tlb_cctl_waddr,
    tlb_cctl_wdata,
    tlb_cctl_ack,
    tlb_cctl_raddr,
    tlb_cctl_rdata,
    tlb_cctl_ecc_status,
    ifu_ipipe_standby_ready,
    lsp_standby_ready,
    arb_standby_ready,
    dcu_standby_ready,
    prf_standby_ready,
    lsq_empty,
    lsuop_prefetch_clr,
    mmu_fence_req,
    mmu_fence_done,
    mmu_fence_mode,
    mmu_fence_vaddr,
    mmu_fence_asid,
    uop_issue_ready,
    uop_req_valid,
    uop_req_stall,
    uop_req_pc,
    uop_req_addr,
    uop_req_func,
    uop_req_op0,
    uop_req_op1,
    uop_req_ilm,
    uop_req_dlm,
    uop_resp_valid,
    uop_resp_result,
    uop_resp_result64,
    uop_resp_bresult,
    uop_resp_fault_va,
    uop_resp_pa,
    uop_resp_status,
    uop_cmt_valid,
    uop_cmt_kill,
    uop_cmt_wdata_sel_f,
    uop_cmt_wdata_i,
    uop_cmt_wdata_f
);
parameter VALEN = 32;
parameter PALEN = 32;
parameter EXTVALEN = 32;
parameter RVA_SUPPORT_INT = 0;
parameter UNALIGNED_ACCESS_INT = 0;
parameter ILM_SIZE_KB = 8;
parameter ILM_AMSB = 15;
parameter ILM_BASE = 64'h1000_0000;
parameter DLM_SIZE_KB = 0;
parameter DLM_AMSB = 15;
parameter DLM_BASE = 64'h2000_0000;
parameter DCACHE_PREFETCH_SUPPORT_INT = 0;
localparam CS_NORM = 0;
localparam CS_WAIT0 = 1;
localparam CS_WAIT1 = 2;
localparam CS_AMO0 = 3;
localparam CS_AMO1 = 4;
localparam CS_AMO2 = 5;
localparam CS_AMO3 = 6;
localparam CS_FENCE2 = 7;
localparam CS_FENCE3 = 8;
localparam CS_CCTL0 = 9;
localparam CS_CCTL1 = 10;
localparam CS_CCTL2 = 11;
localparam CS_VCCTL = 12;
localparam CS_ICCTL1 = 13;
localparam CS_CCTL_DONE = 14;
localparam CS_TLBCCTL = 15;
localparam CS_ABORT = 16;
localparam STATES = 17;
localparam DCAUSE_ECC_PARITY = 3'b001;
localparam DCAUSE_PMP_ERROR = 3'b010;
localparam DCAUSE_PMA_EMPTY = 3'b101;
localparam DCAUSE_BUS_ERROR = 3'b011;
input core_clk;
input core_reset_n;
input csr_halt_mode;
input csr_mcache_ctl_dc_en;
input csr_mcache_ctl_ic_rwecc;
input csr_mcache_ctl_tlb_rwecc;
input [31:0] csr_mcctlbeginaddr;
input csr_milmb_ien;
input csr_mdlmb_den;
output ls_issue_ready;
output ls_standby_ready;
input wfi_enabled;
input ls_privilege_m;
input ls_privilege_s;
input ls_privilege_u;
input ls_req_valid;
input [11:0] ls_req_pc;
input [1:0] ls_req_stall;
input [31:0] ls_req_base0;
input [31:0] ls_req_base1;
input [2:0] ls_req_base_bypass;
input [20:0] ls_req_offset;
input [8:0] ls_req_asid;
input [34:0] ls_req_func;
output ls_resp_valid;
output [31:0] ls_resp_result;
output [31:0] ls_resp_bresult;
output [EXTVALEN - 1:0] ls_resp_fault_addr;
output [31:0] ls_resp_status;
output [63:0] ls_resp_result_64b;
input ls_cmt_valid;
input ls_cmt_kill;
input ls_cmt_wdata_sel_vpu;
input [31:0] ls_cmt_wdata_base;
input [63:0] ls_cmt_wdata_vpu;
input lsu_reserve_clr;
output lsp_reserve_clr;
output ifu_fence_req;
input ifu_fence_done;
output [31:0] lsu_cctl_raddr;
output [31:0] lsu_cctl_rdata;
output ifu_cctl_req;
output [4:0] ifu_cctl_command;
output [31:0] ifu_cctl_waddr;
output [31:0] ifu_cctl_wdata;
input ifu_cctl_ack;
input [4:0] ifu_cctl_status;
input [31:0] ifu_cctl_raddr;
input [31:0] ifu_cctl_rdata;
input [11:0] ifu_cctl_ecc_status;
output dcu_ix_req;
output [31:0] dcu_ix_addr;
output [7:0] dcu_ix_command;
output [31:0] dcu_ix_wdata;
input dcu_ix_ack;
input [31:0] dcu_ix_rdata;
input [31:0] dcu_ix_raddr;
input [11:0] dcu_ix_status;
output dcu_wbf_flush;
input dcu_acctl_ecc_error;
input dcu_acctl_ecc_corr;
output tlb_cctl_req;
output [1:0] tlb_cctl_command;
output [31:0] tlb_cctl_waddr;
output [31:0] tlb_cctl_wdata;
input tlb_cctl_ack;
input [31:0] tlb_cctl_raddr;
input [31:0] tlb_cctl_rdata;
input [7:0] tlb_cctl_ecc_status;
input ifu_ipipe_standby_ready;
input lsp_standby_ready;
input arb_standby_ready;
input dcu_standby_ready;
input prf_standby_ready;
input lsq_empty;
output lsuop_prefetch_clr;
output mmu_fence_req;
input mmu_fence_done;
output [1:0] mmu_fence_mode;
output [VALEN - 13:0] mmu_fence_vaddr;
output [8:0] mmu_fence_asid;
input uop_issue_ready;
output uop_req_valid;
output [1:0] uop_req_stall;
output [11:0] uop_req_pc;
output [EXTVALEN - 1:0] uop_req_addr;
output [26:0] uop_req_func;
output [VALEN - 1:0] uop_req_op0;
output [20:0] uop_req_op1;
output uop_req_ilm;
output uop_req_dlm;
input uop_resp_valid;
input [31:0] uop_resp_result;
input [63:0] uop_resp_result64;
input [31:0] uop_resp_bresult;
input [EXTVALEN - 1:0] uop_resp_fault_va;
input [PALEN - 1:0] uop_resp_pa;
input [36:0] uop_resp_status;
output uop_cmt_valid;
output uop_cmt_kill;
output uop_cmt_wdata_sel_f;
output [31:0] uop_cmt_wdata_i;
output [63:0] uop_cmt_wdata_f;


wire xlen64 = 1'b0;
wire rva_en = (RVA_SUPPORT_INT == 1);
reg [STATES - 1:0] fsm_cs;
reg [STATES - 1:0] fsm_ns;
reg fsm_en;
wire fsm_norm = fsm_cs[CS_NORM];
wire fsm_wait0 = fsm_cs[CS_WAIT0];
wire fsm_wait1 = fsm_cs[CS_WAIT1];
wire fsm_amo0 = fsm_cs[CS_AMO0] & rva_en;
wire fsm_amo1 = fsm_cs[CS_AMO1] & rva_en;
wire fsm_amo2 = fsm_cs[CS_AMO2] & rva_en;
wire fsm_amo3 = fsm_cs[CS_AMO3] & rva_en;
wire fsm_fence2 = fsm_cs[CS_FENCE2];
wire fsm_fence3 = fsm_cs[CS_FENCE3];
wire fsm_cctl0 = fsm_cs[CS_CCTL0];
wire fsm_cctl1 = fsm_cs[CS_CCTL1];
wire fsm_cctl2 = fsm_cs[CS_CCTL2];
wire fsm_acctl = fsm_cs[CS_VCCTL];
wire fsm_icctl1 = fsm_cs[CS_ICCTL1];
wire fsm_tlbcctl = fsm_cs[CS_TLBCCTL];
wire fsm_cctl_done = fsm_cs[CS_CCTL_DONE];
wire fsm_abort = fsm_cs[CS_ABORT];
wire speculative_cnt_up;
wire speculative_cnt_dn;
wire [2:0] speculative_cnt;
wire [31:0] ag_op0;
wire [20:0] ag_op1;
wire ag_req_ilm;
wire ag_req_dlm;
wire [EXTVALEN - 1:0] ag_result;
wire [31:0] slow_ag_op0;
wire [20:0] slow_ag_op1;
wire slow_ag_hit_ilm;
wire slow_ag_hit_dlm;
wire [EXTVALEN - 1:0] slow_ag_result;
wire [31:0] fast_ag_op0;
wire [20:0] fast_ag_op1;
wire fast_ag_hit_ilm;
wire fast_ag_hit_dlm;
wire [EXTVALEN - 1:0] fast_ag_result;
wire fast_req_ilm;
wire fast_req_dlm;
wire slow_req_ilm;
wire slow_req_dlm;
wire uop_req_grant;
wire [2:0] ls_req_func3 = ls_req_func[0 +:3];
wire ls_req_lr = ls_req_func[5] & rva_en;
wire ls_req_sc = ls_req_func[6] & rva_en;
wire ls_req_amo = ls_req_func[7] & rva_en;
wire [4:0] ls_req_amofn = ls_req_func[8 +:5];
wire ls_req_cctl = ls_req_func[27];
wire ls_req_fence = ls_req_func[29];
wire ls_req_fencei = ls_req_func[30];
wire ls_req_sfence = ls_req_func[31];
wire [7:0] ls_req_cctl_command = ls_req_func[19 +:8];
wire ls_req_grant = ls_req_valid & ~ls_req_stall[0] & ~(ls_req_stall[1] & ~ls_resp_valid);
wire ls_req_amo_grant = ls_req_grant & ls_req_amo;
wire ls_req_cctl_grant = ls_req_grant & ls_req_cctl;
wire ls_req_fence_grant = ls_req_grant & ls_req_fence;
wire ls_req_fencei_grant = ls_req_grant & ls_req_fencei;
wire ls_req_sfence_grant = ls_req_grant & ls_req_sfence;
wire uop_resp_halt = uop_resp_status[0];
wire uop_resp_xcpt = uop_resp_status[1];
wire uop_resp_replay = uop_resp_status[14];
wire uop_resp_abort = uop_resp_halt | uop_resp_xcpt | uop_resp_replay;
wire uop_resp_sc = uop_resp_status[11];
wire uop_resp_exokay = uop_resp_status[12];
wire uop_resp_lock_success = uop_resp_status[17];
wire [7:0] cctl_command;
wire uop_norm_valid;
wire uop_amo_lr_valid;
wire uop_amo_sc_valid;
wire uop_acctl_valid;
wire [26:0] uop_ls;
wire [26:0] uop_amo_lr;
wire [26:0] uop_amo_sc;
wire [26:0] uop_acctl;
wire fsm_cmt_valid;
reg [EXTVALEN - 1:0] fsm_op0;
wire [EXTVALEN - 1:0] fsm_op0_nx;
wire fsm_op0_en;
wire [31:0] fsm_op0_se;
wire fsm_func_en;
reg [2:0] fsm_op1;
wire [2:0] fsm_op1_nx;
wire [20:0] fsm_op1_ze;
wire fsm_op1_en;
wire [31:0] fsm_result;
wire [63:0] fsm_result_64b;
reg [36:0] fsm_status;
wire fsm_status_en;
wire [36:0] fsm_status_nx;
wire [36:0] fsm_status_fence;
wire [36:0] fsm_status_acctl;
wire [36:0] fsm_status_xcctl;
wire [36:0] fsm_status_tlbcctl;
wire [36:0] fsm_status_icctl;
wire [11:0] fsm_pc;
reg [34:0] fsm_func;
wire [2:0] func_func3 = fsm_func[0 +:3];
wire func_load = fsm_func[3];
wire func_store = fsm_func[4];
wire func_amo = fsm_func[7];
wire func_lr = fsm_func[5];
wire func_sc = fsm_func[6];
wire func_fence = fsm_func[29];
wire func_fencei = fsm_func[30];
wire func_sfence = fsm_func[31];
wire func_vm = fsm_func[28];
wire [1:0] func_sfence_mode = fsm_func[32 +:2];
wire func_cctl = fsm_func[27];
reg fsm_killed;
reg fsm_committed;
wire fsm_committed_nx;
wire fsm_committed_en;
wire fsm_committed_set;
wire fsm_committed_clr;
reg fsm_ilm;
reg fsm_dlm;
reg [8:0] fsm_asid;
wire [31:0] amo_result;
wire [31:0] amo_cmt_wdata;
wire amo3_resp_valid;
wire norm_resp_valid;
wire fence_resp_valid;
wire cctl_resp_valid;
wire abort_resp_valid;
wire resp_valid;
wire [31:0] norm_resp_status;
wire [31:0] amo3_resp_status;
wire [31:0] fence_resp_status;
wire [31:0] abort_resp_status;
wire [31:0] cctl_resp_status;
wire ls_req_cctl_l1i_va_inval = ls_req_cctl_command == 8'b00001000;
wire ls_req_cctl_l1i_va_lock = ls_req_cctl_command == 8'b00001011;
wire ls_req_cctl_l1i_va_unlock = ls_req_cctl_command == 8'b00001100;
wire ls_req_cctl_l1i_ix_rdata = ls_req_cctl_command == 8'b00011100;
wire ls_req_cctl_l1i_ix_rtag = ls_req_cctl_command == 8'b00011011;
wire ls_req_cctl_l1i_ix_inval = ls_req_cctl_command == 8'b00011000;
wire ls_req_cctl_l1i_ix_wtag = ls_req_cctl_command == 8'b00011101;
wire ls_req_cctl_l1i_ix_wdata = ls_req_cctl_command == 8'b00011110;
wire ls_req_cctl_l1d_va_lock = ls_req_cctl_command == 8'b00000011;
wire ls_req_cctl_l1d_va_unlock = ls_req_cctl_command == 8'b00000100;
wire ls_req_cctl_l1d_va_inval = ls_req_cctl_command == 8'b00000000;
wire ls_req_cctl_l1d_va_wbinval = ls_req_cctl_command == 8'b00000010;
wire ls_req_cctl_l1d_va_wb = ls_req_cctl_command == 8'b00000001;
wire ls_req_cctl_l1d_wbinval_all = ls_req_cctl_command == 8'b00000110;
wire ls_req_cctl_l1d_wb_all = ls_req_cctl_command == 8'b00000111;
wire ls_req_cctl_l1d_inval_all = ls_req_cctl_command == 8'b00010111;
wire ls_req_cctl_l1d_ix_wb = ls_req_cctl_command == 8'b00010001;
wire ls_req_cctl_l1d_ix_wbinval = ls_req_cctl_command == 8'b00010010;
wire ls_req_cctl_l1d_ix_inval = ls_req_cctl_command == 8'b00010000;
wire ls_req_cctl_l1d_ix_rtag = ls_req_cctl_command == 8'b00010011;
wire ls_req_cctl_l1d_ix_rdata = ls_req_cctl_command == 8'b00010100;
wire ls_req_cctl_l1d_ix_wtag = ls_req_cctl_command == 8'b00010101;
wire ls_req_cctl_l1d_ix_wdata = ls_req_cctl_command == 8'b00010110;
wire ls_req_cctl_tlb_ix_rtag = ls_req_cctl_command == 8'b10010011;
wire ls_req_cctl_tlb_ix_wtag = ls_req_cctl_command == 8'b10010101;
wire ls_req_cctl_tlb_ix_rdata = ls_req_cctl_command == 8'b10010100;
wire ls_req_cctl_tlb_ix_wdata = ls_req_cctl_command == 8'b10010110;
wire ls_req_cctl_l1d_va = ls_req_cctl_l1d_va_inval | ls_req_cctl_l1d_va_wbinval | ls_req_cctl_l1d_va_wb | ls_req_cctl_l1d_va_lock | ls_req_cctl_l1d_va_unlock;
wire ls_req_cctl_l1d_all = ls_req_cctl_l1d_wbinval_all | ls_req_cctl_l1d_wb_all | ls_req_cctl_l1d_inval_all;
wire ls_req_cctl_l1d_ix_rw = ls_req_cctl_l1d_ix_rtag | ls_req_cctl_l1d_ix_rdata | ls_req_cctl_l1d_ix_wtag | ls_req_cctl_l1d_ix_wdata;
wire ls_req_cctl_l1d_ix = ls_req_cctl_l1d_ix_wb | ls_req_cctl_l1d_ix_wbinval | ls_req_cctl_l1d_ix_inval | ls_req_cctl_l1d_ix_rw;
wire ls_req_cctl_l1d = ls_req_cctl_l1d_ix | ls_req_cctl_l1d_va | ls_req_cctl_l1d_all;
wire ls_req_cctl_l1d_inval = ls_req_cctl_l1d_wbinval_all | ls_req_cctl_l1d_inval_all | ls_req_cctl_l1d_ix_wbinval | ls_req_cctl_l1d_ix_inval | ls_req_cctl_l1d_va_wbinval | ls_req_cctl_l1d_va_inval;
wire ls_req_cctl_tlb_ix = ls_req_cctl_tlb_ix_rtag | ls_req_cctl_tlb_ix_wtag | ls_req_cctl_tlb_ix_rdata | ls_req_cctl_tlb_ix_wdata;
wire ls_req_cctl_l1i_cmd = ls_req_cctl_l1i_va_inval | ls_req_cctl_l1i_va_lock | ls_req_cctl_l1i_va_unlock | ls_req_cctl_l1i_ix_rdata | ls_req_cctl_l1i_ix_rtag | ls_req_cctl_l1i_ix_inval | ls_req_cctl_l1i_ix_wtag | ls_req_cctl_l1i_ix_wdata;
wire ls_req_cctl_li1_ix_read = ls_req_cctl_l1i_ix_rtag | ls_req_cctl_l1i_ix_rdata;
wire ls_req_cctl_tlb_ix_read = ls_req_cctl_tlb_ix_rtag | ls_req_cctl_tlb_ix_rdata;
reg fsm_cctl_l1d_va;
reg fsm_cctl_l1d;
reg fsm_cctl_l1d_ix;
reg fsm_cctl_l1d_all;
reg fsm_cctl_l1d_inval;
reg fsm_cctl_l1d_va_inval;
reg fsm_cctl_l1d_va_wb;
reg fsm_cctl_l1d_va_wbinval;
reg fsm_cctl_l1d_va_lock;
reg fsm_cctl_l1d_va_unlock;
reg fsm_cctl_l1i_cmd;
reg fsm_cctl_l1i_ix_read;
reg fsm_cctl_tlb_ix;
reg fsm_cctl_tlb_ix_read;
wire [31:0] cctl_va_next;
wire ls_standby_ready_pre;
wire fence_done;
reg fence_wait_ifu;
wire fence_wait_ifu_set;
wire fence_wait_ifu_clr;
wire fence_wait_ifu_nx;
wire fence_wait_ifu_en;
reg fence_wait_dcu;
wire fence_wait_dcu_set;
wire fence_wait_dcu_clr;
wire fence_wait_dcu_nx;
wire fence_wait_dcu_en;
reg fence_wait_mmu;
wire fence_wait_mmu_set;
wire fence_wait_mmu_clr;
wire fence_wait_mmu_nx;
wire fence_wait_mmu_en;
wire tb_dcu_wbf_flush = 1'b0;
kv_agu #(
    .OP0LEN(32),
    .VALEN(VALEN),
    .EXTVALEN(EXTVALEN),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .ILM_BASE(ILM_BASE),
    .ILM_AMSB(ILM_AMSB),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .DLM_BASE(DLM_BASE),
    .DLM_AMSB(DLM_AMSB)
) u_fast_agu (
    .ag_op0(fast_ag_op0),
    .ag_op1(fast_ag_op1),
    .ag_result(fast_ag_result),
    .hit_ilm(fast_ag_hit_ilm),
    .hit_dlm(fast_ag_hit_dlm)
);
kv_agu #(
    .OP0LEN(32),
    .VALEN(VALEN),
    .EXTVALEN(EXTVALEN),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .ILM_BASE(ILM_BASE),
    .ILM_AMSB(ILM_AMSB),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .DLM_BASE(DLM_BASE),
    .DLM_AMSB(DLM_AMSB)
) u_slow_agu (
    .ag_op0(slow_ag_op0),
    .ag_op1(slow_ag_op1),
    .ag_result(slow_ag_result),
    .hit_ilm(slow_ag_hit_ilm),
    .hit_dlm(slow_ag_hit_dlm)
);
assign fast_ag_op0 = ls_resp_bresult;
assign fast_ag_op1 = ls_req_offset;
assign slow_ag_op0 = ({32{fsm_norm & ls_req_base_bypass[0]}} & ls_req_base0) | ({32{fsm_norm & ls_req_base_bypass[1]}} & ls_req_base1) | ({32{~fsm_norm}} & fsm_op0_se);
assign slow_ag_op1 = fsm_norm ? ls_req_offset : fsm_op1_ze;
assign ag_op0 = ({32{fsm_norm & ls_req_base_bypass[0]}} & ls_req_base0) | ({32{fsm_norm & ls_req_base_bypass[1]}} & ls_req_base1) | ({32{fsm_norm & ls_req_base_bypass[2]}} & ls_resp_bresult) | ({32{~fsm_norm}} & fsm_op0_se);
assign ag_op1 = fsm_norm ? ls_req_offset : fsm_op1_ze;
assign fast_req_ilm = fast_ag_hit_ilm & csr_milmb_ien;
assign fast_req_dlm = fast_ag_hit_dlm & csr_mdlmb_den;
assign slow_req_ilm = slow_ag_hit_ilm & csr_milmb_ien & ~fsm_cctl0;
assign slow_req_dlm = slow_ag_hit_dlm & csr_mdlmb_den & ~fsm_cctl0;
assign ag_req_ilm = (fsm_norm & ls_req_base_bypass[2]) ? fast_req_ilm : slow_req_ilm;
assign ag_req_dlm = (fsm_norm & ls_req_base_bypass[2]) ? fast_req_dlm : slow_req_dlm;
assign ag_result = (fsm_norm & ls_req_base_bypass[2]) ? fast_ag_result : slow_ag_result;
assign uop_req_grant = uop_req_valid & ~uop_req_stall[0] & ~(uop_req_stall[1] & ~uop_resp_valid);
assign speculative_cnt_up = uop_req_grant & ~uop_cmt_valid;
assign speculative_cnt_dn = ~uop_req_grant & uop_cmt_valid;
kv_cnt_johnson #(
    .N(3)
) u_speculative_cnt (
    .clk(core_clk),
    .rst_n(core_reset_n),
    .up(speculative_cnt_up),
    .dn(speculative_cnt_dn),
    .cnt(speculative_cnt)
);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        fsm_cs <= {{(STATES - 1){1'b0}},1'b1};
    end
    else if (fsm_en) begin
        fsm_cs <= fsm_ns;
    end
end

always @(posedge core_clk) begin
    if (fsm_op0_en) begin
        fsm_op0 <= fsm_op0_nx;
    end
end

always @(posedge core_clk) begin
    if (fsm_func_en) begin
        fsm_ilm <= ag_req_ilm;
        fsm_dlm <= ag_req_dlm;
        fsm_func <= ls_req_func;
        fsm_cctl_l1d_va <= ls_req_cctl_l1d_va;
        fsm_cctl_l1d <= ls_req_cctl_l1d;
        fsm_cctl_l1d_ix <= ls_req_cctl_l1d_ix;
        fsm_cctl_l1d_all <= ls_req_cctl_l1d_all;
        fsm_cctl_l1d_inval <= ls_req_cctl_l1d_inval;
        fsm_cctl_l1d_va_inval <= ls_req_cctl_l1d_va_inval;
        fsm_cctl_l1d_va_wb <= ls_req_cctl_l1d_va_wb;
        fsm_cctl_l1d_va_wbinval <= ls_req_cctl_l1d_va_wbinval;
        fsm_cctl_l1d_va_lock <= ls_req_cctl_l1d_va_lock;
        fsm_cctl_l1d_va_unlock <= ls_req_cctl_l1d_va_unlock;
        fsm_cctl_l1i_cmd <= ls_req_cctl_l1i_cmd;
        fsm_cctl_l1i_ix_read <= ls_req_cctl_li1_ix_read;
        fsm_cctl_tlb_ix <= ls_req_cctl_tlb_ix;
        fsm_cctl_tlb_ix_read <= ls_req_cctl_tlb_ix_read;
    end
end

kv_dff_gen #(
    .EXPRESSION((DCACHE_PREFETCH_SUPPORT_INT == 1)),
    .W(12)
) u_fsm_pc (
    .clk(core_clk),
    .en(fsm_op0_en),
    .d(ls_req_pc),
    .q(fsm_pc)
);
always @(posedge core_clk) begin
    if (fsm_op1_en) begin
        fsm_op1 <= fsm_op1_nx;
    end
end

always @(posedge core_clk) begin
    if (ls_req_sfence_grant) begin
        fsm_asid <= ls_req_asid;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        fsm_killed <= 1'b0;
    end
    else if (fsm_committed_clr) begin
        fsm_killed <= 1'b0;
    end
    else if (fsm_committed_set) begin
        fsm_killed <= ls_cmt_kill;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        fsm_committed <= 1'b0;
    end
    else if (fsm_committed_en) begin
        fsm_committed <= fsm_committed_nx;
    end
end

always @(posedge core_clk) begin
    if (fsm_status_en) begin
        fsm_status <= fsm_status_nx;
    end
end

kv_sign_ext #(
    .OW(32),
    .IW(EXTVALEN)
) u_fsm_op0_se (
    .out(fsm_op0_se),
    .in(fsm_op0)
);
kv_zero_ext #(
    .OW(21),
    .IW(3)
) u_fam_op1_ze (
    .out(fsm_op1_ze),
    .in(fsm_op1)
);
assign fsm_cmt_valid = ls_cmt_valid & ~fsm_norm & ~speculative_cnt[0];
assign fsm_committed_en = fsm_committed_set | fsm_committed_clr;
assign fsm_committed_set = fsm_cmt_valid;
assign fsm_committed_clr = ls_req_grant;
assign fsm_committed_nx = ~fsm_committed_clr & (fsm_committed | fsm_committed_set);
assign fsm_op0_en = ls_req_amo_grant | ls_req_cctl_grant | ls_req_fence_grant | ls_req_fencei_grant | ls_req_sfence_grant;
assign fsm_op0_nx = ag_result;
assign fsm_func_en = ls_req_amo_grant | ls_req_cctl_grant | ls_req_fence_grant | ls_req_fencei_grant | ls_req_sfence_grant;
assign fsm_op1_en = fsm_op0_en;
assign fsm_op1_nx = 3'd0;
assign fsm_status_en = (fsm_acctl & uop_resp_valid) | (fsm_cctl2 & dcu_acctl_ecc_error) | (fsm_fence2 & fence_done) | (fsm_amo1 & uop_resp_valid & uop_resp_abort) | (fsm_cctl1 & dcu_ix_ack) | (fsm_tlbcctl & tlb_cctl_ack) | (fsm_icctl1 & ifu_cctl_ack);
assign fsm_status_nx = ({37{fsm_acctl}} & uop_resp_status) | ({37{fsm_cctl1}} & fsm_status_xcctl) | ({37{fsm_cctl2}} & fsm_status_acctl) | ({37{fsm_fence2}} & fsm_status_fence) | ({37{fsm_amo1}} & uop_resp_status) | ({37{fsm_tlbcctl}} & fsm_status_tlbcctl) | ({37{fsm_icctl1}} & fsm_status_icctl);
assign fsm_status_fence[0] = 1'b0;
assign fsm_status_fence[1] = csr_mcache_ctl_dc_en & func_fencei & dcu_ix_status[0];
assign fsm_status_fence[2 +:6] = 6'h7;
assign fsm_status_fence[8 +:3] = 3'd1;
assign fsm_status_fence[11] = 1'b0;
assign fsm_status_fence[12] = 1'b1;
assign fsm_status_fence[13] = 1'b0;
assign fsm_status_fence[15] = 1'b0;
assign fsm_status_fence[14] = 1'b0;
assign fsm_status_fence[16] = 1'b0;
assign fsm_status_fence[17] = 1'b0;
assign fsm_status_fence[18 +:8] = dcu_ix_status[1 +:8];
assign fsm_status_fence[26] = dcu_ix_status[9];
assign fsm_status_fence[27 +:4] = {3'd2,dcu_ix_status[10]};
assign fsm_status_fence[31] = 1'b0;
assign fsm_status_fence[32] = 1'b0;
assign fsm_status_fence[33] = 1'b1;
assign fsm_status_fence[34] = 1'b0;
assign fsm_status_fence[35] = 1'b0;
assign fsm_status_fence[36] = 1'b0;
assign fsm_status_xcctl[0] = 1'b0;
assign fsm_status_xcctl[1] = dcu_ix_status[0];
assign fsm_status_xcctl[2 +:6] = 6'h7;
assign fsm_status_xcctl[8 +:3] = 3'd1;
assign fsm_status_xcctl[11] = 1'b0;
assign fsm_status_xcctl[12] = 1'b1;
assign fsm_status_xcctl[13] = 1'b0;
assign fsm_status_xcctl[15] = 1'b0;
assign fsm_status_xcctl[14] = 1'b0;
assign fsm_status_xcctl[16] = 1'b0;
assign fsm_status_xcctl[17] = 1'b0;
assign fsm_status_xcctl[18 +:8] = dcu_ix_status[1 +:8];
assign fsm_status_xcctl[26] = dcu_ix_status[9];
assign fsm_status_xcctl[27 +:4] = {3'd2,dcu_ix_status[10]};
assign fsm_status_xcctl[31] = 1'b0;
assign fsm_status_xcctl[32] = dcu_ix_status[11];
assign fsm_status_xcctl[33] = 1'b1;
assign fsm_status_xcctl[34] = 1'b0;
assign fsm_status_xcctl[35] = 1'b0;
assign fsm_status_xcctl[36] = 1'b0;
assign fsm_status_acctl[0] = 1'b0;
assign fsm_status_acctl[1] = 1'b1;
assign fsm_status_acctl[2 +:6] = 6'h7;
assign fsm_status_acctl[8 +:3] = 3'd1;
assign fsm_status_acctl[11] = 1'b0;
assign fsm_status_acctl[12] = 1'b1;
assign fsm_status_acctl[13] = 1'b0;
assign fsm_status_acctl[15] = 1'b0;
assign fsm_status_acctl[14] = 1'b0;
assign fsm_status_acctl[16] = 1'b0;
assign fsm_status_acctl[17] = 1'b0;
assign fsm_status_acctl[18 +:8] = 8'd0;
assign fsm_status_acctl[26] = dcu_acctl_ecc_corr;
assign fsm_status_acctl[27 +:4] = 4'd5;
assign fsm_status_acctl[31] = 1'b0;
assign fsm_status_acctl[32] = 1'b0;
assign fsm_status_acctl[33] = 1'b1;
assign fsm_status_acctl[34] = 1'b0;
assign fsm_status_acctl[35] = 1'b0;
assign fsm_status_acctl[36] = 1'b0;
assign fsm_status_tlbcctl[0] = 1'b0;
assign fsm_status_tlbcctl[1] = 1'b0;
assign fsm_status_tlbcctl[2 +:6] = 6'd0;
assign fsm_status_tlbcctl[8 +:3] = 3'd0;
assign fsm_status_tlbcctl[11] = 1'b0;
assign fsm_status_tlbcctl[12] = 1'b0;
assign fsm_status_tlbcctl[13] = 1'b0;
assign fsm_status_tlbcctl[15] = 1'b0;
assign fsm_status_tlbcctl[14] = 1'b0;
assign fsm_status_tlbcctl[16] = 1'b0;
assign fsm_status_tlbcctl[17] = 1'b0;
assign fsm_status_tlbcctl[18 +:8] = tlb_cctl_ecc_status[7:0];
assign fsm_status_tlbcctl[26] = 1'b0;
assign fsm_status_tlbcctl[27 +:4] = 4'd0;
assign fsm_status_tlbcctl[31] = 1'b0;
assign fsm_status_tlbcctl[32] = fsm_cctl_tlb_ix_read & csr_mcache_ctl_tlb_rwecc;
assign fsm_status_tlbcctl[33] = 1'b1;
assign fsm_status_tlbcctl[34] = 1'b0;
assign fsm_status_tlbcctl[35] = 1'b0;
assign fsm_status_tlbcctl[36] = 1'b0;
assign fsm_status_icctl[0] = 1'b0;
assign fsm_status_icctl[1] = |(ifu_cctl_status[4:0]);
assign fsm_status_icctl[2 +:6] = (ifu_cctl_status[4]) ? 6'hf : 6'h7;
assign fsm_status_icctl[8 +:3] = ({3{ifu_cctl_status[0]}} & DCAUSE_ECC_PARITY) | ({3{ifu_cctl_status[1]}} & DCAUSE_PMP_ERROR) | ({3{ifu_cctl_status[2]}} & DCAUSE_PMA_EMPTY) | ({3{ifu_cctl_status[3]}} & DCAUSE_BUS_ERROR);
assign fsm_status_icctl[11] = 1'b0;
assign fsm_status_icctl[12] = 1'b0;
assign fsm_status_icctl[13] = 1'b0;
assign fsm_status_icctl[15] = 1'b0;
assign fsm_status_icctl[14] = 1'b0;
assign fsm_status_icctl[16] = 1'b0;
assign fsm_status_icctl[17] = 1'b0;
assign fsm_status_icctl[18 +:8] = ifu_cctl_ecc_status[7:0];
assign fsm_status_icctl[26] = ifu_cctl_ecc_status[11];
assign fsm_status_icctl[27 +:4] = {1'd0,ifu_cctl_ecc_status[10:8]};
assign fsm_status_icctl[31] = 1'b1;
assign fsm_status_icctl[32] = fsm_cctl_l1i_ix_read & csr_mcache_ctl_ic_rwecc;
assign fsm_status_icctl[33] = 1'b1;
assign fsm_status_icctl[34] = 1'b0;
assign fsm_status_icctl[35] = 1'b0;
assign fsm_status_icctl[36] = 1'b0;
always @* begin
    fsm_ns = {STATES{1'b0}};
    case (1'b1)
        fsm_cs[CS_NORM]: begin
            if (ls_req_cctl_grant) begin
                fsm_ns[CS_WAIT0] = 1'b1;
                fsm_en = 1'b1;
            end
            else if (ls_req_fencei_grant) begin
                fsm_ns[CS_WAIT0] = 1'b1;
                fsm_en = 1'b1;
            end
            else if (ls_req_fence_grant) begin
                fsm_ns[CS_WAIT0] = 1'b1;
                fsm_en = 1'b1;
            end
            else if (ls_req_sfence_grant) begin
                fsm_ns[CS_WAIT0] = 1'b1;
                fsm_en = 1'b1;
            end
            else if (ls_req_amo_grant) begin
                fsm_ns[CS_WAIT0] = 1'b1;
                fsm_en = 1'b1;
            end
            else begin
                fsm_ns[CS_NORM] = 1'b1;
                fsm_en = 1'b0;
            end
        end
        fsm_cs[CS_WAIT0]: begin
            if (func_fence | func_fencei | func_sfence | func_cctl) begin
                fsm_ns[CS_WAIT1] = 1'b1;
                fsm_en = lsq_empty & fsm_committed;
            end
            else begin
                fsm_ns[CS_AMO0] = 1'b1;
                fsm_en = lsq_empty;
            end
        end
        fsm_cs[CS_WAIT1]: begin
            if (fsm_killed) begin
                fsm_ns[CS_NORM] = 1'b1;
                fsm_en = 1'b1;
            end
            else if (func_cctl) begin
                fsm_ns[CS_CCTL0] = 1'b1;
                fsm_en = ls_standby_ready_pre;
            end
            else begin
                fsm_ns[CS_FENCE2] = 1'b1;
                fsm_en = ls_standby_ready_pre & ~(func_sfence & ~ifu_ipipe_standby_ready);
            end
        end
        fsm_cs[CS_AMO0]: begin
            fsm_ns[CS_AMO1] = 1'b1;
            fsm_en = 1'b1;
        end
        fsm_cs[CS_AMO1]: begin
            if (fsm_killed) begin
                fsm_ns[CS_NORM] = 1'b1;
            end
            else if (uop_resp_abort) begin
                fsm_ns[CS_ABORT] = 1'b1;
            end
            else begin
                fsm_ns[CS_AMO2] = 1'b1;
            end
            fsm_en = fsm_killed | uop_resp_valid;
        end
        fsm_cs[CS_AMO2]: begin
            fsm_ns[CS_AMO3] = 1'b1;
            fsm_en = 1'b1;
        end
        fsm_cs[CS_AMO3]: begin
            if (uop_resp_exokay) begin
                fsm_ns[CS_NORM] = 1'b1;
            end
            else begin
                fsm_ns[CS_AMO0] = 1'b1;
            end
            fsm_en = uop_resp_valid;
        end
        fsm_cs[CS_FENCE2]: begin
            fsm_ns[CS_FENCE3] = 1'b1;
            fsm_en = fence_done;
        end
        fsm_cs[CS_FENCE3]: begin
            fsm_ns[CS_NORM] = 1'b1;
            fsm_en = 1'b1;
        end
        fsm_cs[CS_CCTL0]: begin
            if (fsm_cctl_l1d_ix | fsm_cctl_l1d_all) begin
                fsm_ns[CS_CCTL1] = 1'b1;
                fsm_en = 1'b1;
            end
            else if (fsm_cctl_l1d_va) begin
                fsm_ns[CS_VCCTL] = 1'b1;
                fsm_en = 1'b1;
            end
            else if (fsm_cctl_tlb_ix) begin
                fsm_ns[CS_TLBCCTL] = 1'b1;
                fsm_en = 1'b1;
            end
            else begin
                fsm_ns[CS_ICCTL1] = 1'b1;
                fsm_en = 1'b1;
            end
        end
        fsm_cs[CS_ICCTL1]: begin
            fsm_ns[CS_CCTL_DONE] = 1'b1;
            fsm_en = ifu_cctl_ack;
        end
        fsm_cs[CS_CCTL1]: begin
            fsm_ns[CS_CCTL2] = 1'b1;
            fsm_en = dcu_ix_ack;
        end
        fsm_cs[CS_VCCTL]: begin
            fsm_ns[CS_CCTL2] = 1'b1;
            fsm_en = uop_resp_valid;
        end
        fsm_cs[CS_CCTL2]: begin
            fsm_ns[CS_CCTL_DONE] = 1'b1;
            fsm_en = dcu_standby_ready;
        end
        fsm_cs[CS_CCTL_DONE]: begin
            fsm_ns[CS_NORM] = 1'b1;
            fsm_en = 1'b1;
        end
        fsm_cs[CS_TLBCCTL]: begin
            fsm_ns[CS_CCTL_DONE] = 1'b1;
            fsm_en = tlb_cctl_ack;
        end
        fsm_cs[CS_ABORT]: begin
            fsm_ns[CS_NORM] = 1'b1;
            fsm_en = 1'b1;
        end
        default: begin
            fsm_ns = {STATES{1'b0}};
            fsm_en = 1'b0;
        end
    endcase
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        fence_wait_ifu <= 1'b0;
    end
    else if (fence_wait_ifu_en) begin
        fence_wait_ifu <= fence_wait_ifu_nx;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        fence_wait_dcu <= 1'b0;
    end
    else if (fence_wait_dcu_en) begin
        fence_wait_dcu <= fence_wait_dcu_nx;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        fence_wait_mmu <= 1'b0;
    end
    else if (fence_wait_mmu_en) begin
        fence_wait_mmu <= fence_wait_mmu_nx;
    end
end

assign ifu_fence_req = fsm_fence2 & func_fencei & fence_wait_ifu;
assign fence_done = ~(func_fencei & (fence_wait_ifu | fence_wait_dcu)) & ~(func_sfence & fence_wait_mmu);
assign fence_wait_ifu_en = fence_wait_ifu_set | fence_wait_ifu_clr;
assign fence_wait_ifu_nx = fence_wait_ifu_set | (fence_wait_ifu & ~fence_wait_ifu_clr);
assign fence_wait_ifu_set = fsm_wait1 & fsm_en;
assign fence_wait_ifu_clr = ifu_fence_done;
assign fence_wait_dcu_en = fence_wait_dcu_set | fence_wait_dcu_clr;
assign fence_wait_dcu_nx = fence_wait_dcu_set | (fence_wait_dcu & ~fence_wait_dcu_clr);
assign fence_wait_dcu_set = fsm_wait1 & fsm_en;
assign fence_wait_dcu_clr = dcu_ix_ack | ~csr_mcache_ctl_dc_en;
assign fence_wait_mmu_en = fence_wait_mmu_set | fence_wait_mmu_clr;
assign fence_wait_mmu_nx = fence_wait_mmu_set | (fence_wait_mmu & ~fence_wait_mmu_clr);
assign fence_wait_mmu_set = fsm_wait1 & fsm_en;
assign fence_wait_mmu_clr = mmu_fence_done;
assign mmu_fence_req = fsm_fence2 & func_sfence & fence_wait_mmu;
assign mmu_fence_vaddr = fsm_op0[VALEN - 1:12];
assign mmu_fence_mode = func_sfence_mode;
assign mmu_fence_asid = fsm_asid;
assign lsuop_prefetch_clr = mmu_fence_req | (fsm_cctl0 & fsm_cctl_l1d_inval);
assign lsp_reserve_clr = lsu_reserve_clr | fsm_fence2 | fsm_cctl_done;
assign ifu_cctl_req = fsm_icctl1;
assign ifu_cctl_command = cctl_command[4:0];
assign ifu_cctl_wdata = ls_cmt_wdata_base;
assign ifu_cctl_waddr = csr_mcctlbeginaddr;
assign cctl_command = fsm_func[19 +:8];
assign dcu_ix_req = (fsm_fence2 & fence_wait_dcu & csr_mcache_ctl_dc_en & func_fencei) | fsm_cctl1;
assign dcu_ix_command = ({8{fsm_fence2}} & 8'b00000111) | ({8{fsm_cctl1}} & cctl_command[7:0]);
assign tlb_cctl_req = fsm_tlbcctl;
assign tlb_cctl_command = cctl_command[1:0];
assign tlb_cctl_waddr = csr_mcctlbeginaddr;
assign tlb_cctl_wdata = ls_cmt_wdata_base;
reg [31:0] lsu_cctl_rdata;
reg [31:0] lsu_cctl_raddr;
wire [31:0] lsu_cctl_rdata_nx;
wire [31:0] lsu_cctl_raddr_nx;
wire cctl_ack;
wire ifu_cctl_resp = ifu_cctl_ack & fsm_icctl1;
assign cctl_va_next = csr_mcctlbeginaddr + {{25{1'b0}},7'd64};
assign dcu_ix_wdata = ls_cmt_wdata_base;
assign cctl_ack = ifu_cctl_resp | (fsm_acctl & uop_resp_valid) | (fsm_cctl1 & dcu_ix_ack) | (fsm_tlbcctl & tlb_cctl_ack);
assign lsu_cctl_rdata_nx = ({32{fsm_cctl_l1d_va_lock}} & {{31{1'b0}},uop_resp_lock_success}) | ({32{fsm_cctl_l1d}} & dcu_ix_rdata) | ({32{fsm_cctl_tlb_ix}} & tlb_cctl_rdata) | ({32{fsm_cctl_l1i_cmd}} & ifu_cctl_rdata);
assign lsu_cctl_raddr_nx = ({32{(fsm_cctl_l1d & fsm_cctl_l1d_va)}} & cctl_va_next) | ({32{(fsm_cctl_l1d & ~fsm_cctl_l1d_va)}} & dcu_ix_raddr) | ({32{fsm_cctl_l1i_cmd}} & ifu_cctl_raddr) | ({32{fsm_cctl_tlb_ix}} & tlb_cctl_raddr);
always @(posedge core_clk) begin
    if (cctl_ack) begin
        lsu_cctl_rdata <= lsu_cctl_rdata_nx;
        lsu_cctl_raddr <= lsu_cctl_raddr_nx;
    end
end

generate
    if (32 > EXTVALEN) begin:gen_dcu_addr_zext
        assign dcu_ix_addr = {{(32 - EXTVALEN){1'b0}},ag_result};
    end
    else begin:gen_dcu_addr
        assign dcu_ix_addr = ag_result[31:0];
    end
endgenerate
assign dcu_wbf_flush = wfi_enabled | csr_halt_mode | ~csr_mcache_ctl_dc_en | (fsm_wait1 & ~fsm_killed) | tb_dcu_wbf_flush;
assign uop_ls[0 +:3] = ls_req_func[0 +:3];
assign uop_ls[3] = ls_req_func[3];
assign uop_ls[4] = ls_req_func[4];
assign uop_ls[11] = ls_req_func[18];
assign uop_ls[12 +:5] = ls_req_func[13 +:5];
assign uop_ls[5] = ls_req_lr;
assign uop_ls[6] = ls_req_sc;
assign uop_ls[7] = 1'b0;
assign uop_ls[8] = 1'b0;
assign uop_ls[9] = 1'b0;
assign uop_ls[10] = 1'b0;
assign uop_ls[17] = 1'b0;
assign uop_ls[18] = 1'b0;
assign uop_ls[19] = 1'b0;
assign uop_ls[20] = ls_req_func[28];
assign uop_ls[24] = ls_req_func[34];
assign uop_ls[21] = 1'b0;
assign uop_ls[22] = ls_privilege_m | ls_privilege_s;
assign uop_ls[23] = ls_privilege_s | ls_privilege_u;
assign uop_ls[25] = 1'b0;
assign uop_ls[26] = ls_req_amofn[0];
assign uop_amo_lr[0 +:3] = func_func3;
assign uop_amo_lr[3] = 1'b1;
assign uop_amo_lr[4] = 1'b0;
assign uop_amo_lr[11] = 1'b0;
assign uop_amo_lr[12 +:5] = 5'b0;
assign uop_amo_lr[5] = 1'b1;
assign uop_amo_lr[6] = 1'b0;
assign uop_amo_lr[7] = 1'b1;
assign uop_amo_lr[8] = 1'b0;
assign uop_amo_lr[9] = 1'b0;
assign uop_amo_lr[10] = 1'b0;
assign uop_amo_lr[17] = 1'b0;
assign uop_amo_lr[18] = 1'b0;
assign uop_amo_lr[19] = 1'b0;
assign uop_amo_lr[20] = func_vm;
assign uop_amo_lr[24] = 1'b0;
assign uop_amo_lr[21] = 1'b0;
assign uop_amo_lr[22] = ls_privilege_m | ls_privilege_s;
assign uop_amo_lr[23] = ls_privilege_s | ls_privilege_u;
assign uop_amo_lr[25] = 1'b0;
assign uop_amo_lr[26] = 1'b0;
assign uop_amo_sc[0 +:3] = func_func3;
assign uop_amo_sc[3] = 1'b0;
assign uop_amo_sc[4] = 1'b1;
assign uop_amo_sc[11] = 1'b0;
assign uop_amo_sc[12 +:5] = 5'b0;
assign uop_amo_sc[5] = 1'b0;
assign uop_amo_sc[6] = 1'b1;
assign uop_amo_sc[7] = 1'b1;
assign uop_amo_sc[8] = 1'b0;
assign uop_amo_sc[9] = 1'b0;
assign uop_amo_sc[10] = 1'b0;
assign uop_amo_sc[17] = 1'b0;
assign uop_amo_sc[18] = 1'b0;
assign uop_amo_sc[19] = 1'b0;
assign uop_amo_sc[20] = func_vm;
assign uop_amo_sc[24] = 1'b0;
assign uop_amo_sc[21] = 1'b0;
assign uop_amo_sc[22] = ls_privilege_m | ls_privilege_s;
assign uop_amo_sc[23] = ls_privilege_s | ls_privilege_u;
assign uop_amo_sc[25] = 1'b0;
assign uop_amo_sc[26] = 1'b0;
assign uop_acctl[0 +:3] = 3'd0;
assign uop_acctl[3] = 1'b0;
assign uop_acctl[4] = 1'b0;
assign uop_acctl[11] = 1'b0;
assign uop_acctl[12 +:5] = 5'd0;
assign uop_acctl[5] = 1'b0;
assign uop_acctl[6] = 1'b0;
assign uop_acctl[7] = 1'b0;
assign uop_acctl[8] = fsm_cctl_l1d_va_inval;
assign uop_acctl[9] = fsm_cctl_l1d_va_wb;
assign uop_acctl[10] = fsm_cctl_l1d_va_wbinval;
assign uop_acctl[17] = fsm_cctl_l1d_va_lock;
assign uop_acctl[18] = fsm_cctl_l1d_va_unlock;
assign uop_acctl[19] = fsm_ilm | fsm_dlm;
assign uop_acctl[20] = func_vm;
assign uop_acctl[24] = 1'b0;
assign uop_acctl[21] = 1'b0;
assign uop_acctl[22] = ls_privilege_m | ls_privilege_s;
assign uop_acctl[23] = ls_privilege_s | ls_privilege_u;
assign uop_acctl[25] = 1'b0;
assign uop_acctl[26] = 1'b0;
assign uop_amo_lr_valid = fsm_amo0;
assign uop_amo_sc_valid = fsm_amo2;
assign uop_acctl_valid = fsm_cctl0 & fsm_cctl_l1d_va;
assign uop_norm_valid = fsm_norm & ls_req_valid;
assign uop_req_valid = uop_norm_valid | uop_amo_lr_valid | uop_amo_sc_valid | uop_acctl_valid;
assign uop_req_stall[0] = fsm_norm & (ls_req_stall[0] | ls_req_amo | ls_req_cctl | ls_req_fence | ls_req_fencei | ls_req_sfence);
assign uop_req_stall[1] = (fsm_norm & ls_req_stall[1]);
assign uop_req_addr = ag_result;
assign uop_req_op0 = ag_op0[VALEN - 1:0];
assign uop_req_op1 = ag_op1;
assign uop_req_ilm = ag_req_ilm;
assign uop_req_dlm = ag_req_dlm;
assign uop_req_func = ({27{fsm_norm}} & uop_ls) | ({27{fsm_amo0}} & uop_amo_lr) | ({27{fsm_amo2}} & uop_amo_sc) | ({27{fsm_cctl0}} & uop_acctl);
assign uop_req_pc = ({12{fsm_norm}} & ls_req_pc) | ({12{fsm_amo0}} & fsm_pc) | ({12{fsm_amo2}} & fsm_pc) | ({12{fsm_cctl0}} & fsm_pc);
assign uop_cmt_valid = (fsm_norm & ls_cmt_valid) | (fsm_wait0 & ls_cmt_valid & speculative_cnt[0]) | (fsm_amo1 & speculative_cnt[0]) | (fsm_amo3 & speculative_cnt[0]) | (fsm_acctl & speculative_cnt[0]);
assign uop_cmt_kill = (fsm_norm & ls_cmt_kill) | (fsm_wait0 & ls_cmt_kill) | (fsm_amo1 & fsm_killed) | (fsm_amo3 & fsm_killed);
assign uop_cmt_wdata_i = ({32{fsm_amo3}} & amo_cmt_wdata) | ({32{fsm_norm}} & ls_cmt_wdata_base) | ({32{fsm_wait0}} & ls_cmt_wdata_base);
assign uop_cmt_wdata_f = ls_cmt_wdata_vpu;
assign uop_cmt_wdata_sel_f = (fsm_norm & ls_cmt_wdata_sel_vpu) | (fsm_wait0 & ls_cmt_wdata_sel_vpu);
assign cctl_resp_valid = fsm_cctl_done;
assign fence_resp_valid = fsm_fence3;
assign resp_valid = norm_resp_valid | amo3_resp_valid | cctl_resp_valid | fence_resp_valid | abort_resp_valid;
assign ls_resp_valid = resp_valid;
assign ls_resp_result = fsm_amo3 ? amo_result : uop_resp_sc ? {{31{1'b0}},~uop_resp_exokay} : uop_resp_result;
assign ls_resp_bresult = uop_resp_bresult;
assign ls_resp_fault_addr = (fsm_cctl_done | fsm_abort) ? fsm_op0 : uop_resp_fault_va;
assign ls_resp_status = ({32{fsm_norm | fsm_wait0}} & norm_resp_status) | ({32{fsm_amo3}} & amo3_resp_status) | ({32{fsm_cctl_done}} & cctl_resp_status) | ({32{fsm_fence3}} & fence_resp_status) | ({32{fsm_abort}} & abort_resp_status);
assign ls_issue_ready = uop_issue_ready & (fsm_norm) & ~ls_req_amo_grant & ~ls_req_cctl_grant;
assign ls_standby_ready_pre = lsp_standby_ready & dcu_standby_ready & prf_standby_ready & arb_standby_ready & lsq_empty;
assign ls_standby_ready = ls_standby_ready_pre & fsm_norm;
assign norm_resp_valid = uop_resp_valid & (fsm_norm | fsm_wait0);
assign amo3_resp_valid = uop_resp_valid & fsm_amo3 & (uop_resp_exokay);
assign abort_resp_valid = fsm_abort;
assign norm_resp_status[0] = uop_resp_status[0];
assign norm_resp_status[1] = uop_resp_status[1];
assign norm_resp_status[2 +:6] = uop_resp_status[2 +:6];
assign norm_resp_status[8 +:3] = uop_resp_status[8 +:3];
assign norm_resp_status[11] = uop_resp_status[14];
assign norm_resp_status[12] = uop_resp_status[16];
assign norm_resp_status[13] = uop_resp_status[33];
assign norm_resp_status[14 +:8] = uop_resp_status[18 +:8];
assign norm_resp_status[26] = uop_resp_status[26];
assign norm_resp_status[22 +:4] = uop_resp_status[27 +:4];
assign norm_resp_status[27] = uop_resp_status[31];
assign norm_resp_status[28] = uop_resp_status[32];
assign norm_resp_status[29] = uop_resp_status[34];
assign norm_resp_status[30] = uop_resp_status[35];
assign norm_resp_status[31] = uop_resp_status[36];
assign cctl_resp_status[0] = fsm_status[0];
assign cctl_resp_status[1] = fsm_status[1];
assign cctl_resp_status[2 +:6] = fsm_status[2 +:6];
assign cctl_resp_status[8 +:3] = fsm_status[8 +:3];
assign cctl_resp_status[11] = fsm_status[14];
assign cctl_resp_status[12] = 1'b1;
assign cctl_resp_status[13] = 1'b1;
assign cctl_resp_status[14 +:8] = fsm_status[18 +:8];
assign cctl_resp_status[26] = fsm_status[26];
assign cctl_resp_status[22 +:4] = fsm_status[27 +:4];
assign cctl_resp_status[28] = fsm_status[32];
assign cctl_resp_status[27] = fsm_status[31];
assign cctl_resp_status[29] = fsm_status[34];
assign cctl_resp_status[30] = fsm_status[35];
assign cctl_resp_status[31] = fsm_status[36];
assign amo3_resp_status[0] = uop_resp_status[0];
assign amo3_resp_status[1] = uop_resp_status[1];
assign amo3_resp_status[2 +:6] = uop_resp_status[2 +:6];
assign amo3_resp_status[8 +:3] = uop_resp_status[8 +:3];
assign amo3_resp_status[11] = uop_resp_status[14];
assign amo3_resp_status[12] = 1'b0;
assign amo3_resp_status[13] = 1'b0;
assign amo3_resp_status[14 +:8] = uop_resp_status[18 +:8];
assign amo3_resp_status[26] = uop_resp_status[26];
assign amo3_resp_status[22 +:4] = uop_resp_status[27 +:4];
assign amo3_resp_status[28] = uop_resp_status[32];
assign amo3_resp_status[27] = uop_resp_status[31];
assign amo3_resp_status[29] = uop_resp_status[34];
assign amo3_resp_status[30] = uop_resp_status[35];
assign amo3_resp_status[31] = uop_resp_status[36];
assign fence_resp_status[0] = fsm_status[0];
assign fence_resp_status[1] = fsm_status[1];
assign fence_resp_status[2 +:6] = fsm_status[2 +:6];
assign fence_resp_status[8 +:3] = fsm_status[8 +:3];
assign fence_resp_status[11] = fsm_status[14];
assign fence_resp_status[12] = 1'b0;
assign fence_resp_status[13] = 1'b1;
assign fence_resp_status[14 +:8] = fsm_status[18 +:8];
assign fence_resp_status[26] = fsm_status[26];
assign fence_resp_status[22 +:4] = fsm_status[27 +:4];
assign fence_resp_status[28] = fsm_status[32];
assign fence_resp_status[27] = fsm_status[31];
assign fence_resp_status[29] = fsm_status[34];
assign fence_resp_status[30] = fsm_status[35];
assign fence_resp_status[31] = fsm_status[36];
assign abort_resp_status[0] = fsm_status[0];
assign abort_resp_status[1] = fsm_status[1];
assign abort_resp_status[2 +:6] = fsm_status[2 +:6];
assign abort_resp_status[8 +:3] = fsm_status[8 +:3];
assign abort_resp_status[11] = fsm_status[14];
assign abort_resp_status[12] = 1'b0;
assign abort_resp_status[13] = 1'b1;
assign abort_resp_status[14 +:8] = fsm_status[18 +:8];
assign abort_resp_status[26] = fsm_status[26];
assign abort_resp_status[22 +:4] = fsm_status[27 +:4];
assign abort_resp_status[28] = fsm_status[32];
assign abort_resp_status[27] = fsm_status[31];
assign abort_resp_status[29] = fsm_status[34];
assign abort_resp_status[30] = fsm_status[35];
assign abort_resp_status[31] = fsm_status[36];
generate
    if (RVA_SUPPORT_INT == 1) begin:gen_amoalu
        wire [4:0] amo_fn = fsm_func[8 +:5];
        kv_amoalu u_amoalu(
            .op0(fsm_result),
            .op1(ls_cmt_wdata_base),
            .func3(func_func3),
            .func5(amo_fn),
            .result(amo_cmt_wdata)
        );
        assign amo_result = fsm_result;
    end
    else begin:gen_amoalu_none
        assign amo_result = {32{1'b0}};
        assign amo_cmt_wdata = {32{1'b0}};
    end
endgenerate
wire [31:0] fsm_result_xlen;
wire [31:0] fsm_result_xlen_nx;
wire [3:0] fsm_result_xlen_bwe;
assign fsm_result_xlen_nx = uop_resp_result;
assign fsm_result_xlen_bwe = ({4{uop_resp_valid & fsm_amo1}});
kv_dff_bwe #(
    .BYTES(4)
) u_fsm_result_xlen (
    .clk(core_clk),
    .bwe(fsm_result_xlen_bwe),
    .d(fsm_result_xlen_nx),
    .q(fsm_result_xlen)
);
assign fsm_result = fsm_result_xlen;
assign fsm_result_64b = 64'd0;
assign ls_resp_result_64b = uop_resp_result64;
endmodule


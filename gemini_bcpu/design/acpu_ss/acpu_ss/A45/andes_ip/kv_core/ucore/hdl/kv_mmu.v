// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_mmu (
    core_clk,
    core_reset_n,
    csr_satp_ppn,
    csr_satp_mode,
    csr_satp_asid,
    csr_mmu_satp_we,
    csr_mcache_ctl_tlb_eccen,
    csr_mcache_ctl_tlb_rwecc,
    csr_mecc_code,
    tlb_cctl_req,
    tlb_cctl_command,
    tlb_cctl_waddr,
    tlb_cctl_wdata,
    tlb_cctl_ack,
    tlb_cctl_raddr,
    tlb_cctl_rdata,
    tlb_cctl_ecc_status,
    mmu_csr_mitlb_access,
    mmu_csr_mitlb_miss,
    mmu_csr_mdtlb_access,
    mmu_csr_mdtlb_miss,
    mmu_fence_req,
    mmu_fence_mode,
    mmu_fence_vaddr,
    mmu_fence_asid,
    mmu_fence_done,
    mmu_ipipe_standby_ready,
    dtlb_miss_req,
    dtlb_miss_vpn,
    dtlb_miss_resp,
    dtlb_miss_data,
    dtlb_sfence_req,
    dtlb_sfence_mode_flush_all,
    dtlb_sfence_mode_va,
    itlb_miss_req,
    itlb_miss_vpn,
    itlb_miss_resp,
    itlb_miss_data,
    itlb_sfence_req,
    itlb_sfence_mode_flush_all,
    itlb_sfence_mode_va,
    mmu_iptw_req_valid,
    mmu_iptw_req_pa,
    iptw_mmu_req_ready,
    iptw_mmu_resp_valid,
    iptw_mmu_resp_status,
    iptw_mmu_resp_data,
    mmu_dptw_req_valid,
    mmu_dptw_req_pa,
    dptw_mmu_req_ready,
    dptw_mmu_resp_valid,
    dptw_mmu_resp_status,
    dptw_mmu_resp_data,
    stlb0_cs,
    stlb1_cs,
    stlb2_cs,
    stlb3_cs,
    stlb0_we,
    stlb1_we,
    stlb2_we,
    stlb3_we,
    stlb0_addr,
    stlb1_addr,
    stlb2_addr,
    stlb3_addr,
    stlb0_wdata,
    stlb1_wdata,
    stlb2_wdata,
    stlb3_wdata,
    stlb0_rdata,
    stlb1_rdata,
    stlb2_rdata,
    stlb3_rdata,
    stlb_tag0_cs,
    stlb_tag1_cs,
    stlb_tag2_cs,
    stlb_tag3_cs,
    stlb_tag0_we,
    stlb_tag1_we,
    stlb_tag2_we,
    stlb_tag3_we,
    stlb_tag0_addr,
    stlb_tag1_addr,
    stlb_tag2_addr,
    stlb_tag3_addr,
    stlb_tag0_wdata,
    stlb_tag1_wdata,
    stlb_tag2_wdata,
    stlb_tag3_wdata,
    stlb_tag0_rdata,
    stlb_tag1_rdata,
    stlb_tag2_rdata,
    stlb_tag3_rdata,
    stlb_data0_cs,
    stlb_data1_cs,
    stlb_data2_cs,
    stlb_data3_cs,
    stlb_data0_we,
    stlb_data1_we,
    stlb_data2_we,
    stlb_data3_we,
    stlb_data0_addr,
    stlb_data1_addr,
    stlb_data2_addr,
    stlb_data3_addr,
    stlb_data0_wdata,
    stlb_data1_wdata,
    stlb_data2_wdata,
    stlb_data3_wdata,
    stlb_data0_rdata,
    stlb_data1_rdata,
    stlb_data2_rdata,
    stlb_data3_rdata
);
parameter MMU_SCHEME_INT = 2;
parameter VALEN = 48;
parameter EXTVALEN = (((MMU_SCHEME_INT != 0)) && (32 > VALEN)) ? VALEN + 1 : VALEN;
parameter PALEN = 48;
parameter ITLB_ENTRIES = ((MMU_SCHEME_INT == 0)) ? 0 : 4;
parameter DTLB_ENTRIES = ((MMU_SCHEME_INT == 0)) ? 0 : 4;
parameter STLB_ENTRIES = ((MMU_SCHEME_INT == 0)) ? 0 : 32;
parameter STLB_SP_ENTRIES = ((MMU_SCHEME_INT == 0)) ? 0 : 4;
parameter STLB_ECC_TYPE = 0;
localparam ASID_LEN = 9;
localparam STLB_RAM_AW = ((MMU_SCHEME_INT == 0)) ? 1 : $unsigned($clog2(STLB_ENTRIES / 4));
localparam STLB_TAG_REG_DW = ((MMU_SCHEME_INT == 0)) ? 1 : (VALEN - 12 - STLB_RAM_AW + ASID_LEN + 1);
localparam STLB_DATA_REG_DW = ((MMU_SCHEME_INT == 0)) ? 1 : (8 + PALEN - 12);
localparam STLB_REG_DW = ((MMU_SCHEME_INT == 0)) ? 1 : (STLB_TAG_REG_DW + STLB_DATA_REG_DW);
localparam STLB_RAM_DW = ((MMU_SCHEME_INT == 0)) ? 1 : (STLB_TAG_REG_DW + STLB_DATA_REG_DW);
localparam STLB_TAG_RAM_ECC_DW = ((MMU_SCHEME_INT == 0)) ? 0 : ((STLB_ECC_TYPE == 1) ? ((STLB_TAG_REG_DW > 32) ? 8 : 7) : 0);
localparam STLB_TAG_RAM_DW = ((MMU_SCHEME_INT == 0)) ? 1 : STLB_TAG_REG_DW + STLB_TAG_RAM_ECC_DW;
localparam STLB_DATA_RAM_ECC_DW = ((MMU_SCHEME_INT == 0)) ? 0 : ((STLB_ECC_TYPE == 1) ? ((STLB_DATA_REG_DW > 32) ? 8 : 7) : 0);
localparam STLB_DATA_RAM_DW = ((MMU_SCHEME_INT == 0)) ? 1 : STLB_DATA_REG_DW + STLB_DATA_RAM_ECC_DW;
localparam ITLB_V_BIT = 0;
localparam ITLB_X_BIT = ITLB_V_BIT + 1;
localparam ITLB_U_BIT = ITLB_X_BIT + 1;
localparam ITLB_G_BIT = ITLB_U_BIT + 1;
localparam ITLB_A_BIT = ITLB_G_BIT + 1;
localparam ITLB_PAGE_FAULT_BIT = ITLB_A_BIT + 1;
localparam ITLB_PTW_ACCESS_FAULT_BIT = ITLB_PAGE_FAULT_BIT + 1;
localparam ITLB_MDCAUSE_LSB = ITLB_PTW_ACCESS_FAULT_BIT + 1;
localparam ITLB_MDCAUSE_MSB = ITLB_MDCAUSE_LSB + 3 - 1;
localparam ITLB_ECC_CODE_LSB = ITLB_MDCAUSE_MSB + 1;
localparam ITLB_ECC_CODE_MSB = ITLB_ECC_CODE_LSB + 8 - 1;
localparam ITLB_ECC_CORR_BIT = ITLB_ECC_CODE_MSB + 1;
localparam ITLB_ECC_RAMID_LSB = ITLB_ECC_CORR_BIT + 1;
localparam ITLB_ECC_RAMID_MSB = ITLB_ECC_RAMID_LSB + 4 - 1;
localparam ITLB_PPN_LSB = ITLB_ECC_RAMID_MSB + 1;
localparam ITLB_PPN_MSB = ITLB_PPN_LSB + PALEN - 12 - 1;
localparam ITLB_MSB = ITLB_PPN_MSB;
localparam DTLB_V_BIT = 0;
localparam DTLB_X_BIT = DTLB_V_BIT + 1;
localparam DTLB_W_BIT = DTLB_X_BIT + 1;
localparam DTLB_R_BIT = DTLB_W_BIT + 1;
localparam DTLB_U_BIT = DTLB_R_BIT + 1;
localparam DTLB_G_BIT = DTLB_U_BIT + 1;
localparam DTLB_A_BIT = DTLB_G_BIT + 1;
localparam DTLB_D_BIT = DTLB_A_BIT + 1;
localparam DTLB_PAGE_FAULT_BIT = DTLB_D_BIT + 1;
localparam DTLB_PTW_ACCESS_FAULT_BIT = DTLB_PAGE_FAULT_BIT + 1;
localparam DTLB_MDCAUSE_LSB = DTLB_PTW_ACCESS_FAULT_BIT + 1;
localparam DTLB_MDCAUSE_MSB = DTLB_MDCAUSE_LSB + 3 - 1;
localparam DTLB_ECC_CODE_LSB = DTLB_MDCAUSE_MSB + 1;
localparam DTLB_ECC_CODE_MSB = DTLB_ECC_CODE_LSB + 8 - 1;
localparam DTLB_ECC_CORR_BIT = DTLB_ECC_CODE_MSB + 1;
localparam DTLB_ECC_RAMID_LSB = DTLB_ECC_CORR_BIT + 1;
localparam DTLB_ECC_RAMID_MSB = DTLB_ECC_RAMID_LSB + 4 - 1;
localparam DTLB_PPN_LSB = DTLB_ECC_RAMID_MSB + 1;
localparam DTLB_PPN_MSB = DTLB_PPN_LSB + PALEN - 12 - 1;
localparam DTLB_MSB = DTLB_PPN_MSB;
localparam SATP_MODE_BARE = 4'h0;
localparam SATP_MODE_SV39 = 4'h8;
localparam SATP_MODE_SV48 = 4'h9;
localparam KILOPAGE = 2'd0;
localparam MEGAPAGE = 2'd1;
localparam GIGAPAGE = 2'd2;
localparam TERAPAGE = 2'd3;
localparam PRIVILEGE_USER = 2'b00;
localparam PRIVILEGE_SUPERVISOR = 2'b01;
localparam PRIVILEGE_MACHINE = 2'b11;
localparam MEGAPAGE_EXIST = 1'b1;
localparam GIGAPAGE_EXIST = ((MMU_SCHEME_INT == 2)) || ((MMU_SCHEME_INT == 3));
localparam TERAPAGE_EXIST = ((MMU_SCHEME_INT == 3));
localparam VPN0_LSB = 12;
localparam VPN0_MSB = ((MMU_SCHEME_INT == 1)) ? 21 : 20;
localparam VPN1_LSB = VPN0_MSB + 1;
localparam VPN1_MSB = ((MMU_SCHEME_INT == 1)) ? 31 : 29;
localparam VPN2_LSB = VPN1_MSB + 1;
localparam VPN2_MSB = 38;
localparam VPN3_LSB = VPN2_MSB + 1;
localparam VPN3_MSB = 47;
localparam FB_INVALID = 1'd0;
localparam FB_DONE = 1'd1;
localparam STLB_PATH_ITLB = 1'd0;
localparam STLB_PATH_DTLB = 1'd1;
localparam ST_STLB_IDLE = 2'd0;
localparam ST_STLB_SP_DATA = 2'd1;
localparam ST_STLB_KP_DATA = 2'd2;
localparam ST_SFENCE_IDLE = 2'd0;
localparam ST_SFENCE_SCAN = 2'd1;
localparam ST_SFENCE_WAIT_DONE = 2'd2;
localparam SFENCE_ALL_MODE = 2'd0;
localparam SFENCE_ASID_MODE = 2'd1;
localparam SFENCE_VA_MODE = 2'd2;
localparam SFENCE_VA_ASID_MODE = 2'd3;
localparam STLB_V_BIT = 0;
localparam STLB_R_BIT = STLB_V_BIT + 1;
localparam STLB_W_BIT = STLB_R_BIT + 1;
localparam STLB_X_BIT = STLB_W_BIT + 1;
localparam STLB_U_BIT = STLB_X_BIT + 1;
localparam STLB_G_BIT = STLB_U_BIT + 1;
localparam STLB_A_BIT = STLB_G_BIT + 1;
localparam STLB_D_BIT = STLB_A_BIT + 1;
localparam STLB_PPN_LSB = STLB_D_BIT + 1;
localparam STLB_PPN_MSB = STLB_PPN_LSB + PALEN - 12 - 1;
localparam STLB_VALID = STLB_PPN_MSB + 1;
localparam STLB_ASID_LSB = STLB_VALID + 1;
localparam STLB_ASID_MSB = STLB_ASID_LSB + ASID_LEN - 1;
localparam STLB_VPN_LSB = STLB_ASID_MSB + 1;
localparam STLB_VPN_MSB = STLB_VPN_LSB + VALEN - 12 - STLB_RAM_AW - 1;
localparam STLB_VPN1_LSB = STLB_VPN_LSB + VPN1_LSB - VPN0_LSB - STLB_RAM_AW;
localparam STLB_PPN1_LSB = STLB_PPN_LSB + VPN1_LSB - VPN0_LSB;
localparam PTW_PATH_STLB_I = 1'd0;
localparam PTW_PATH_STLB_D = 1'd1;
localparam ST_PTW_IDLE = 2'd0;
localparam ST_PTW_ADDR = 2'd1;
localparam ST_PTW_DATA = 2'd2;
localparam FAULT_CAUSE_NONE = 2'd0;
localparam FAULT_CAUSE_PAGE = 2'd1;
localparam FAULT_CAUSE_BUS = 2'd2;
localparam PTE_V = 0;
localparam PTE_R = PTE_V + 1;
localparam PTE_W = PTE_R + 1;
localparam PTE_X = PTE_W + 1;
localparam PTE_U = PTE_X + 1;
localparam PTE_G = PTE_U + 1;
localparam PTE_A = PTE_G + 1;
localparam PTE_D = PTE_A + 1;
localparam PTE_RESERVED_LSB = PTE_D + 1;
localparam PTE_RESERVED_MSB = PTE_RESERVED_LSB + 1;
localparam PTE_PPN_LSB = PTE_RESERVED_MSB + 1;
localparam PTE_PPN_MSB = PTE_PPN_LSB + PALEN - 12 - 1;
localparam PTE_MSB = ((MMU_SCHEME_INT == 1)) ? 31 : 63;
localparam PTE_SIZE = PTE_MSB + 1;
localparam LSU_ADDR_LSB = ((MMU_SCHEME_INT == 1)) ? 2 : 3;
localparam LSUSIZE_32 = 3'd2;
localparam LSUSIZE_64 = 3'd3;
localparam LSU_ALIGNED_ADDR_LSB = 2;
localparam LSU_DATA_ENTRY_COUNT = 32 / PTE_SIZE;
input core_clk;
input core_reset_n;
input [(PALEN - 1):12] csr_satp_ppn;
input [3:0] csr_satp_mode;
input [8:0] csr_satp_asid;
input csr_mmu_satp_we;
input [1:0] csr_mcache_ctl_tlb_eccen;
input csr_mcache_ctl_tlb_rwecc;
input [31:0] csr_mecc_code;
input tlb_cctl_req;
input [1:0] tlb_cctl_command;
input [31:0] tlb_cctl_waddr;
input [31:0] tlb_cctl_wdata;
output tlb_cctl_ack;
output [31:0] tlb_cctl_raddr;
output [31:0] tlb_cctl_rdata;
output [7:0] tlb_cctl_ecc_status;
output mmu_csr_mitlb_access;
output mmu_csr_mitlb_miss;
output mmu_csr_mdtlb_access;
output mmu_csr_mdtlb_miss;
input mmu_fence_req;
input [1:0] mmu_fence_mode;
input [(VALEN - 1):12] mmu_fence_vaddr;
input [8:0] mmu_fence_asid;
output mmu_fence_done;
output mmu_ipipe_standby_ready;
input dtlb_miss_req;
input [(VALEN - 1):12] dtlb_miss_vpn;
output dtlb_miss_resp;
output [DTLB_MSB:0] dtlb_miss_data;
output dtlb_sfence_req;
output dtlb_sfence_mode_flush_all;
output dtlb_sfence_mode_va;
input itlb_miss_req;
input [(VALEN - 1):12] itlb_miss_vpn;
output itlb_miss_resp;
output [ITLB_MSB:0] itlb_miss_data;
output itlb_sfence_req;
output itlb_sfence_mode_flush_all;
output itlb_sfence_mode_va;
output mmu_iptw_req_valid;
output [(PALEN - 1):0] mmu_iptw_req_pa;
input iptw_mmu_req_ready;
input iptw_mmu_resp_valid;
input [16:0] iptw_mmu_resp_status;
input [31:0] iptw_mmu_resp_data;
output mmu_dptw_req_valid;
output [(PALEN - 1):0] mmu_dptw_req_pa;
input dptw_mmu_req_ready;
input dptw_mmu_resp_valid;
input [16:0] dptw_mmu_resp_status;
input [31:0] dptw_mmu_resp_data;
output stlb0_cs;
output stlb1_cs;
output stlb2_cs;
output stlb3_cs;
output stlb0_we;
output stlb1_we;
output stlb2_we;
output stlb3_we;
output [(STLB_RAM_AW - 1):0] stlb0_addr;
output [(STLB_RAM_AW - 1):0] stlb1_addr;
output [(STLB_RAM_AW - 1):0] stlb2_addr;
output [(STLB_RAM_AW - 1):0] stlb3_addr;
output [(STLB_RAM_DW - 1):0] stlb0_wdata;
output [(STLB_RAM_DW - 1):0] stlb1_wdata;
output [(STLB_RAM_DW - 1):0] stlb2_wdata;
output [(STLB_RAM_DW - 1):0] stlb3_wdata;
input [(STLB_RAM_DW - 1):0] stlb0_rdata;
input [(STLB_RAM_DW - 1):0] stlb1_rdata;
input [(STLB_RAM_DW - 1):0] stlb2_rdata;
input [(STLB_RAM_DW - 1):0] stlb3_rdata;
output stlb_tag0_cs;
output stlb_tag1_cs;
output stlb_tag2_cs;
output stlb_tag3_cs;
output stlb_tag0_we;
output stlb_tag1_we;
output stlb_tag2_we;
output stlb_tag3_we;
output [(STLB_RAM_AW - 1):0] stlb_tag0_addr;
output [(STLB_RAM_AW - 1):0] stlb_tag1_addr;
output [(STLB_RAM_AW - 1):0] stlb_tag2_addr;
output [(STLB_RAM_AW - 1):0] stlb_tag3_addr;
output [(STLB_TAG_RAM_DW - 1):0] stlb_tag0_wdata;
output [(STLB_TAG_RAM_DW - 1):0] stlb_tag1_wdata;
output [(STLB_TAG_RAM_DW - 1):0] stlb_tag2_wdata;
output [(STLB_TAG_RAM_DW - 1):0] stlb_tag3_wdata;
input [(STLB_TAG_RAM_DW - 1):0] stlb_tag0_rdata;
input [(STLB_TAG_RAM_DW - 1):0] stlb_tag1_rdata;
input [(STLB_TAG_RAM_DW - 1):0] stlb_tag2_rdata;
input [(STLB_TAG_RAM_DW - 1):0] stlb_tag3_rdata;
output stlb_data0_cs;
output stlb_data1_cs;
output stlb_data2_cs;
output stlb_data3_cs;
output stlb_data0_we;
output stlb_data1_we;
output stlb_data2_we;
output stlb_data3_we;
output [(STLB_RAM_AW - 1):0] stlb_data0_addr;
output [(STLB_RAM_AW - 1):0] stlb_data1_addr;
output [(STLB_RAM_AW - 1):0] stlb_data2_addr;
output [(STLB_RAM_AW - 1):0] stlb_data3_addr;
output [(STLB_DATA_RAM_DW - 1):0] stlb_data0_wdata;
output [(STLB_DATA_RAM_DW - 1):0] stlb_data1_wdata;
output [(STLB_DATA_RAM_DW - 1):0] stlb_data2_wdata;
output [(STLB_DATA_RAM_DW - 1):0] stlb_data3_wdata;
input [(STLB_DATA_RAM_DW - 1):0] stlb_data0_rdata;
input [(STLB_DATA_RAM_DW - 1):0] stlb_data1_rdata;
input [(STLB_DATA_RAM_DW - 1):0] stlb_data2_rdata;
input [(STLB_DATA_RAM_DW - 1):0] stlb_data3_rdata;


generate
    genvar i;
    genvar l;
    if ((MMU_SCHEME_INT != 0)) begin:gen_mmu_enable
        wire stlb_pipe_idle;
        wire mmu_ptw_req_valid;
        wire [(PALEN - 1):0] mmu_ptw_req_pa;
        wire ptw_mmu_req_ready;
        wire ptw_mmu_resp_valid_nx;
        wire [16:0] ptw_mmu_resp_status_nx;
        wire [31:0] ptw_mmu_resp_data_nx;
        reg ptw_mmu_resp_valid;
        reg [16:0] ptw_mmu_resp_status;
        reg [31:0] ptw_mmu_resp_data;
        wire stlb_path;
        wire stlb_sel_itlb;
        wire stlb_sel_dtlb;
        wire stlb_req;
        wire stlb_kill;
        reg stlb_mask;
        wire stlb_idle;
        wire stlb_ram_req;
        wire [(STLB_RAM_AW - 1):0] stlb_ram_idx;
        wire [47:12] stlb_vpn;
        wire stlb_ptw_req;
        wire stlb0_valid;
        wire stlb1_valid;
        wire stlb2_valid;
        wire stlb3_valid;
        wire [(VALEN - 1):12 + STLB_RAM_AW] stlb0_vpn;
        wire [(VALEN - 1):12 + STLB_RAM_AW] stlb1_vpn;
        wire [(VALEN - 1):12 + STLB_RAM_AW] stlb2_vpn;
        wire [(VALEN - 1):12 + STLB_RAM_AW] stlb3_vpn;
        wire [(ASID_LEN - 1):0] stlb0_asid;
        wire [(ASID_LEN - 1):0] stlb1_asid;
        wire [(ASID_LEN - 1):0] stlb2_asid;
        wire [(ASID_LEN - 1):0] stlb3_asid;
        wire stlb0_g;
        wire stlb1_g;
        wire stlb2_g;
        wire stlb3_g;
        wire stlb_ram_rready;
        wire [(STLB_REG_DW - 1):0] stlb0_ram_rdata;
        wire [(STLB_REG_DW - 1):0] stlb1_ram_rdata;
        wire [(STLB_REG_DW - 1):0] stlb2_ram_rdata;
        wire [(STLB_REG_DW - 1):0] stlb3_ram_rdata;
        wire stlb_itlb_ack;
        wire stlb_itlb_abort;
        wire stlb_dtlb_ack;
        wire stlb_dtlb_abort;
        wire stlb_ram_gnt;
        wire [(PALEN - 1):12] stlb_ppn;
        wire stlb_d;
        wire stlb_a;
        wire stlb_g;
        wire stlb_u;
        wire stlb_x;
        wire stlb_w;
        wire stlb_r;
        wire stlb_v;
        wire stlb_is_terapage;
        wire stlb_is_gigapage;
        wire stlb_is_megapage;
        wire stlb_mecc_code_error;
        wire [7:0] stlb_mecc_code_code;
        wire stlb_mecc_code_corr;
        wire [3:0] stlb_mecc_code_ramid;
        wire stlb_hit_ptw_kp;
        wire stlb_hit_ptw_mp;
        wire stlb_hit_ptw_gp;
        wire stlb_hit_ptw_tp;
        wire stlb_hit_ptw;
        wire stlb_kp_hit;
        wire stlb_sp_hit;
        wire stlb_hit;
        wire [3:0] stlb_kp_hit_vec;
        wire [3:0] stlb_kp_valid_vec;
        wire [3:0] stlb_kp_replacement_vec;
        wire [47:12] ptw_ppn_raw;
        wire ptw_d;
        wire ptw_a;
        wire ptw_g;
        wire ptw_u;
        wire ptw_x;
        wire ptw_w;
        wire ptw_r;
        wire ptw_v;
        wire [1:0] ptw_ps;
        wire ptw_is_terapage;
        wire ptw_is_gigapage;
        wire ptw_is_megapage;
        wire ptw_is_kilopage;
        wire [(PALEN - 1):12] stlb_itlb_ppn;
        wire stlb_itlb_page_fault;
        wire stlb_itlb_access_fault;
        wire [2:0] stlb_itlb_mdcause;
        wire [7:0] stlb_itlb_ecc_code;
        wire stlb_itlb_ecc_corr;
        wire [3:0] stlb_itlb_ecc_ramid;
        wire stlb_itlb_a;
        wire stlb_itlb_g;
        wire stlb_itlb_u;
        wire stlb_itlb_x;
        wire [(PALEN - 1):12] stlb_dtlb_ppn;
        wire stlb_dtlb_page_fault;
        wire stlb_dtlb_access_fault;
        wire [2:0] stlb_dtlb_mdcause;
        wire [7:0] stlb_dtlb_ecc_code;
        wire stlb_dtlb_ecc_corr;
        wire [3:0] stlb_dtlb_ecc_ramid;
        wire stlb_dtlb_d;
        wire stlb_dtlb_a;
        wire stlb_dtlb_g;
        wire stlb_dtlb_u;
        wire stlb_dtlb_x;
        wire stlb_dtlb_w;
        wire stlb_dtlb_r;
        wire [(STLB_REG_DW - 1):0] stlb4_rdata;
        wire [(STLB_REG_DW - 1):0] stlb5_rdata;
        wire [(STLB_REG_DW - 1):0] stlb6_rdata;
        wire [(STLB_REG_DW - 1):0] stlb7_rdata;
        wire [(STLB_REG_DW - 1):0] stlb8_rdata;
        wire [(STLB_REG_DW - 1):0] stlb9_rdata;
        wire [(STLB_REG_DW - 1):0] stlb10_rdata;
        wire [(STLB_REG_DW - 1):0] stlb11_rdata;
        wire [1:0] stlb4_ps;
        wire [1:0] stlb5_ps;
        wire [1:0] stlb6_ps;
        wire [1:0] stlb7_ps;
        wire [1:0] stlb8_ps;
        wire [1:0] stlb9_ps;
        wire [1:0] stlb10_ps;
        wire [1:0] stlb11_ps;
        wire [(ASID_LEN - 1):0] service_asid;
        wire [47:12] service_vpn;
        wire [(PALEN - 1):12] service_ppn;
        wire [3:0] service_mode;
        wire check_vpn;
        wire check_asid;
        wire keep_global_page;
        wire [11:4] stlb_sp_hit_vec;
        wire [11:4] stlb_sp_valid_vec;
        wire [11:4] stlb_sp_replacement_vec;
        wire [11:0] stlb_victim;
        wire [(STLB_REG_DW - 1):0] stlb_sp_wdata;
        wire [6:0] stlb_sp_lru;
        wire [7:0] stlb_sp_lru_hit;
        wire [6:0] stlb_sp_lru_nx;
        wire [STLB_SP_ENTRIES + 3:4] sfence_flush;
        reg self_reset;
        wire sfence_req;
        wire [(VALEN - 1):12] sfence_va;
        wire [(ASID_LEN - 1):0] sfence_asid;
        wire sfence_done;
        wire sfence_mode_flush_all;
        wire sfence_mode_asid;
        wire sfence_mode_va;
        wire sfence_mode_va_asid;
        reg sfence_ram_req;
        wire sfence_ram_gnt;
        wire tlb_cctl_gnt;
        wire ptw_ram_req;
        wire ptw_ram_gnt;
        wire [(STLB_RAM_AW - 1):0] ptw_ram_idx;
        wire [(STLB_REG_DW - 1):0] ptw_ram_wdata;
        wire stlb_kp_fill;
        wire stlb_sp_fill;
        wire ptw_req;
        wire ptw_idle;
        wire ptw_addr_phase;
        wire ptw_data_phase;
        wire valid_lsu_ack;
        wire ptw_sel_stlb_i;
        wire ptw_sel_stlb_d;
        wire ptw_abort;
        wire ptw_access_done;
        wire ptw_leaf_pte;
        wire ptw_stlb_i_ack;
        wire ptw_stlb_d_ack;
        wire ptw_stlb_ack;
        wire ptw_stlb_i_abort;
        wire ptw_stlb_d_abort;
        wire [(PALEN - 1):12] pte_ppn;
        wire [11:LSU_ADDR_LSB] pte_offset;
        wire [47:12] ptw_vpn;
        wire [47:12] ptw_vpn_nx;
        wire [PTE_MSB:0] lsu_rdata;
        wire [PTE_MSB:0] lsu_rdata_pf;
        wire [1:0] ptw_level;
        wire ptw_global;
        wire ptw_page_fault;
        wire ptw_misalign_fault;
        wire ptw_access_fault;
        wire [2:0] ptw_mdcause;
        wire [7:0] ptw_ecc_code;
        wire ptw_ecc_corr;
        wire [3:0] ptw_ecc_ramid;
        wire block_lsu_req;
        wire valid_pte;
        wire [(PALEN - 1):12] ptw_ppn;
        wire [(PALEN - 1):12] pte_ppn_nx;
        wire [11:LSU_ADDR_LSB] pte_offset_nx;
        wire [(PALEN - 1):LSU_ADDR_LSB] ptc_l1i_tag;
        wire [(PALEN - 1):LSU_ADDR_LSB] ptc_l2i_tag;
        wire [(PALEN - 1):LSU_ADDR_LSB] ptc_l3i_tag;
        wire [(PALEN - 1):LSU_ADDR_LSB] ptc_l1d_tag;
        wire [(PALEN - 1):LSU_ADDR_LSB] ptc_l2d_tag;
        wire [(PALEN - 1):LSU_ADDR_LSB] ptc_l3d_tag;
        wire [(PALEN - 1):LSU_ADDR_LSB] ptc_pf_tag;
        wire [PTE_MSB:0] ptc_l1i_rdata;
        wire [PTE_MSB:0] ptc_l2i_rdata;
        wire [PTE_MSB:0] ptc_l3i_rdata;
        wire [PTE_MSB:0] ptc_l1d_rdata;
        wire [PTE_MSB:0] ptc_l2d_rdata;
        wire [PTE_MSB:0] ptc_l3d_rdata;
        wire [PTE_MSB:0] ptc_pf_rdata;
        wire ptc_ifill;
        wire ptc_dfill;
        wire ptc_pf_en;
        wire [(PALEN - 1):LSU_ADDR_LSB] ptc_itag;
        wire [(PALEN - 1):LSU_ADDR_LSB] ptc_dtag;
        wire [PTE_MSB:0] ptc_irdata;
        wire [PTE_MSB:0] ptc_drdata;
        wire ptc_ihit;
        wire ptc_dhit;
        wire ptc_pfhit;
        wire ptc_hit;
        reg ptc_hit_d1;
        reg ptc_ihit_d1;
        reg ptc_dhit_d1;
        reg ptc_pfhit_d1;
        assign mmu_iptw_req_valid = ptw_sel_stlb_i & mmu_ptw_req_valid;
        assign mmu_iptw_req_pa = {(PALEN){ptw_sel_stlb_i}} & mmu_ptw_req_pa;
        assign mmu_dptw_req_valid = ptw_sel_stlb_d & mmu_ptw_req_valid;
        assign mmu_dptw_req_pa = {(PALEN){ptw_sel_stlb_d}} & mmu_ptw_req_pa;
        assign ptw_mmu_req_ready = (ptw_sel_stlb_i & iptw_mmu_req_ready) | (ptw_sel_stlb_d & dptw_mmu_req_ready);
        assign ptw_mmu_resp_valid_nx = (ptw_sel_stlb_i & iptw_mmu_resp_valid) | (ptw_sel_stlb_d & dptw_mmu_resp_valid);
        assign ptw_mmu_resp_status_nx = ({17{ptw_sel_stlb_i}} & iptw_mmu_resp_status) | ({17{ptw_sel_stlb_d}} & dptw_mmu_resp_status);
        assign ptw_mmu_resp_data_nx = ({32{ptw_sel_stlb_i}} & iptw_mmu_resp_data) | ({32{ptw_sel_stlb_d}} & dptw_mmu_resp_data);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                ptw_mmu_resp_valid <= 1'b0;
                ptw_mmu_resp_status <= 17'b0;
                ptw_mmu_resp_data <= {32{1'b0}};
            end
            else if (ptw_access_done | ptw_abort | valid_lsu_ack | ptc_hit_d1) begin
                ptw_mmu_resp_valid <= 1'b0;
                ptw_mmu_resp_status <= 17'b0;
                ptw_mmu_resp_data <= {32{1'b0}};
            end
            else if (ptw_data_phase) begin
                ptw_mmu_resp_valid <= ptw_mmu_resp_valid_nx;
                ptw_mmu_resp_status <= ptw_mmu_resp_status_nx;
                ptw_mmu_resp_data <= ptw_mmu_resp_data_nx;
            end
        end

        assign mmu_ipipe_standby_ready = ptw_idle & stlb_idle;
        wire itlb_stlb_req;
        wire [(STLB_RAM_AW - 1):0] itlb_stlb_idx;
        wire dtlb_stlb_req;
        wire [(STLB_RAM_AW - 1):0] dtlb_stlb_idx;
        wire stlb_itlb_gnt;
        wire stlb_dtlb_gnt;
        assign itlb_miss_resp = stlb_itlb_ack | stlb_itlb_abort;
        assign dtlb_miss_resp = stlb_dtlb_ack | stlb_dtlb_abort;
        assign itlb_stlb_req = itlb_miss_req & ~(~ptw_idle & ptw_sel_stlb_i);
        assign itlb_stlb_idx = itlb_miss_vpn[STLB_RAM_AW - 1 + VPN0_LSB:VPN0_LSB];
        assign dtlb_stlb_req = dtlb_miss_req & ~(~ptw_idle & ptw_sel_stlb_d);
        assign dtlb_stlb_idx = dtlb_miss_vpn[STLB_RAM_AW - 1 + VPN0_LSB:VPN0_LSB];
        assign stlb_req = dtlb_stlb_req | itlb_stlb_req;
        assign stlb_kill = stlb_hit_ptw;
        assign stlb_itlb_gnt = itlb_stlb_req & ~dtlb_stlb_req;
        assign stlb_dtlb_gnt = dtlb_stlb_req;
        assign stlb_ram_req = dtlb_stlb_req | itlb_stlb_req;
        assign stlb_ram_idx = stlb_dtlb_gnt ? dtlb_stlb_idx : itlb_stlb_idx;
        assign stlb_sel_itlb = ~stlb_idle & (stlb_path == STLB_PATH_ITLB);
        assign stlb_sel_dtlb = ~stlb_idle & (stlb_path == STLB_PATH_DTLB);
        if (VALEN < 48) begin:gen_stlb_vpn_zero_extend
            assign stlb_vpn = {{(48 - VALEN){1'b0}},(stlb_sel_dtlb ? dtlb_miss_vpn : itlb_miss_vpn)};
        end
        else begin:gen_stlb_vpn_no_extend
            assign stlb_vpn = stlb_sel_dtlb ? dtlb_miss_vpn[47:12] : itlb_miss_vpn[47:12];
        end
        reg stlb_path_reg;
        wire stlb_path_en;
        wire stlb_path_nx;
        reg [1:0] stlb_cs;
        reg [1:0] stlb_ns;
        wire [(STLB_REG_DW - 1):0] stlb_rdata;
        wire [1:0] stlb_ps;
        wire [47:12] stlb_ppn_mask;
        assign stlb_path_nx = stlb_dtlb_gnt ? STLB_PATH_DTLB : STLB_PATH_ITLB;
        assign stlb_path_en = stlb_req & stlb_idle;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                stlb_path_reg <= 1'b0;
            end
            else if (stlb_path_en) begin
                stlb_path_reg <= stlb_path_nx;
            end
        end

        assign stlb_path = stlb_path_reg;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                stlb_cs <= ST_STLB_IDLE;
            end
            else begin
                stlb_cs <= stlb_ns;
            end
        end

        always @* begin
            case (stlb_cs)
                ST_STLB_SP_DATA: begin
                    if (stlb_sp_hit) begin
                        stlb_ns = ST_STLB_IDLE;
                    end
                    else begin
                        stlb_ns = ST_STLB_KP_DATA;
                    end
                end
                ST_STLB_KP_DATA: begin
                    if (stlb_ram_rready) begin
                        stlb_ns = ST_STLB_IDLE;
                    end
                    else begin
                        stlb_ns = ST_STLB_KP_DATA;
                    end
                end
                ST_STLB_IDLE: begin
                    if ((stlb_itlb_gnt | stlb_dtlb_gnt) & stlb_ram_gnt & ~mmu_fence_req) begin
                        stlb_ns = ST_STLB_SP_DATA;
                    end
                    else begin
                        stlb_ns = ST_STLB_IDLE;
                    end
                end
                default: stlb_ns = 2'b0;
            endcase
        end

        assign stlb_idle = (stlb_cs == ST_STLB_IDLE);
        assign stlb_ptw_req = ((stlb_cs == ST_STLB_KP_DATA) & stlb_ram_rready & ~(stlb_kp_hit | stlb_mecc_code_error));
        assign stlb_kp_hit_vec[0] = stlb0_valid & (stlb0_g | (stlb0_asid == service_asid)) & (stlb0_vpn == stlb_vpn[(VALEN - 1):12 + STLB_RAM_AW]);
        assign stlb_kp_hit_vec[1] = stlb1_valid & (stlb1_g | (stlb1_asid == service_asid)) & (stlb1_vpn == stlb_vpn[(VALEN - 1):12 + STLB_RAM_AW]);
        assign stlb_kp_hit_vec[2] = stlb2_valid & (stlb2_g | (stlb2_asid == service_asid)) & (stlb2_vpn == stlb_vpn[(VALEN - 1):12 + STLB_RAM_AW]);
        assign stlb_kp_hit_vec[3] = stlb3_valid & (stlb3_g | (stlb3_asid == service_asid)) & (stlb3_vpn == stlb_vpn[(VALEN - 1):12 + STLB_RAM_AW]);
        assign stlb_kp_hit = (stlb_cs == ST_STLB_KP_DATA) & stlb_ram_rready & (|stlb_kp_hit_vec);
        assign stlb_sp_hit = (stlb_cs == ST_STLB_SP_DATA) & (|stlb_sp_hit_vec);
        assign stlb_hit = stlb_kp_hit | stlb_sp_hit;
        assign stlb_rdata = ({STLB_REG_DW{((stlb_cs == ST_STLB_KP_DATA) & stlb_ram_rready & stlb_kp_hit_vec[0])}} & stlb0_ram_rdata) | ({STLB_REG_DW{((stlb_cs == ST_STLB_KP_DATA) & stlb_ram_rready & stlb_kp_hit_vec[1])}} & stlb1_ram_rdata) | ({STLB_REG_DW{((stlb_cs == ST_STLB_KP_DATA) & stlb_ram_rready & stlb_kp_hit_vec[2])}} & stlb2_ram_rdata) | ({STLB_REG_DW{((stlb_cs == ST_STLB_KP_DATA) & stlb_ram_rready & stlb_kp_hit_vec[3])}} & stlb3_ram_rdata) | ({STLB_REG_DW{((stlb_cs == ST_STLB_SP_DATA) & stlb_sp_hit_vec[4])}} & stlb4_rdata) | ({STLB_REG_DW{((stlb_cs == ST_STLB_SP_DATA) & stlb_sp_hit_vec[5])}} & stlb5_rdata) | ({STLB_REG_DW{((stlb_cs == ST_STLB_SP_DATA) & stlb_sp_hit_vec[6])}} & stlb6_rdata) | ({STLB_REG_DW{((stlb_cs == ST_STLB_SP_DATA) & stlb_sp_hit_vec[7])}} & stlb7_rdata) | ({STLB_REG_DW{((stlb_cs == ST_STLB_SP_DATA) & stlb_sp_hit_vec[8])}} & stlb8_rdata) | ({STLB_REG_DW{((stlb_cs == ST_STLB_SP_DATA) & stlb_sp_hit_vec[9])}} & stlb9_rdata) | ({STLB_REG_DW{((stlb_cs == ST_STLB_SP_DATA) & stlb_sp_hit_vec[10])}} & stlb10_rdata) | ({STLB_REG_DW{((stlb_cs == ST_STLB_SP_DATA) & stlb_sp_hit_vec[11])}} & stlb11_rdata);
        assign stlb_ppn_mask[VPN3_MSB:VPN3_LSB] = {(VPN3_MSB - VPN3_LSB + 1){1'b0}};
        assign stlb_ppn_mask[VPN2_MSB:VPN2_LSB] = {(VPN2_MSB - VPN2_LSB + 1){stlb_is_terapage}};
        assign stlb_ppn_mask[VPN1_MSB:VPN1_LSB] = {(VPN1_MSB - VPN1_LSB + 1){stlb_is_terapage | stlb_is_gigapage}};
        assign stlb_ppn_mask[VPN0_MSB:VPN0_LSB] = {(VPN0_MSB - VPN0_LSB + 1){stlb_is_terapage | stlb_is_gigapage | stlb_is_megapage}};
        assign stlb_ppn = stlb_rdata[STLB_PPN_MSB:STLB_PPN_LSB] | (stlb_vpn[(PALEN - 1):12] & stlb_ppn_mask[(PALEN - 1):12]);
        assign stlb_d = stlb_rdata[STLB_D_BIT];
        assign stlb_a = stlb_rdata[STLB_A_BIT];
        assign stlb_g = stlb_rdata[STLB_G_BIT];
        assign stlb_u = stlb_rdata[STLB_U_BIT];
        assign stlb_x = stlb_rdata[STLB_X_BIT];
        assign stlb_w = stlb_rdata[STLB_W_BIT];
        assign stlb_r = stlb_rdata[STLB_R_BIT];
        assign stlb_v = stlb_rdata[STLB_V_BIT];
        assign stlb_ps = ({2{((stlb_cs == ST_STLB_SP_DATA) & stlb_sp_hit_vec[4])}} & stlb4_ps) | ({2{((stlb_cs == ST_STLB_SP_DATA) & stlb_sp_hit_vec[5])}} & stlb5_ps) | ({2{((stlb_cs == ST_STLB_SP_DATA) & stlb_sp_hit_vec[6])}} & stlb6_ps) | ({2{((stlb_cs == ST_STLB_SP_DATA) & stlb_sp_hit_vec[7])}} & stlb7_ps) | ({2{((stlb_cs == ST_STLB_SP_DATA) & stlb_sp_hit_vec[8])}} & stlb8_ps) | ({2{((stlb_cs == ST_STLB_SP_DATA) & stlb_sp_hit_vec[9])}} & stlb9_ps) | ({2{((stlb_cs == ST_STLB_SP_DATA) & stlb_sp_hit_vec[10])}} & stlb10_ps) | ({2{((stlb_cs == ST_STLB_SP_DATA) & stlb_sp_hit_vec[11])}} & stlb11_ps);
        assign stlb_is_megapage = (stlb_ps == MEGAPAGE);
        assign stlb_is_gigapage = (stlb_ps == GIGAPAGE) & GIGAPAGE_EXIST;
        assign stlb_is_terapage = (stlb_ps == TERAPAGE) & TERAPAGE_EXIST;
        assign stlb_hit_ptw_kp = ptw_is_kilopage & (stlb_vpn[VPN3_MSB:VPN0_LSB] == ptw_vpn[VPN3_MSB:VPN0_LSB]);
        assign stlb_hit_ptw_mp = ptw_is_megapage & (stlb_vpn[VPN3_MSB:VPN1_LSB] == ptw_vpn[VPN3_MSB:VPN1_LSB]);
        assign stlb_hit_ptw_gp = ptw_is_gigapage & (stlb_vpn[VPN3_MSB:VPN2_LSB] == ptw_vpn[VPN3_MSB:VPN2_LSB]);
        assign stlb_hit_ptw_tp = ptw_is_terapage & (stlb_vpn[VPN3_MSB:VPN3_LSB] == ptw_vpn[VPN3_MSB:VPN3_LSB]);
        assign stlb_hit_ptw = ptw_stlb_ack & (stlb_hit_ptw_kp | stlb_hit_ptw_mp | stlb_hit_ptw_gp | stlb_hit_ptw_tp);
        assign stlb_itlb_ack = (stlb_sel_itlb & (stlb_hit | stlb_mecc_code_error)) | ptw_stlb_i_ack;
        assign stlb_itlb_ppn = ptw_stlb_i_ack ? ptw_ppn : stlb_ppn;
        assign stlb_itlb_a = ptw_stlb_i_ack ? ptw_a : stlb_a;
        assign stlb_itlb_g = ptw_stlb_i_ack ? ptw_g : stlb_g;
        assign stlb_itlb_u = ptw_stlb_i_ack ? ptw_u : stlb_u;
        assign stlb_itlb_x = ptw_stlb_i_ack ? ptw_x : stlb_x;
        assign stlb_itlb_page_fault = (ptw_stlb_i_abort | ptw_stlb_i_ack) ? ptw_page_fault : ~(stlb_v | stlb_mecc_code_error);
        assign stlb_itlb_access_fault = (ptw_stlb_i_abort | ptw_stlb_i_ack) ? ptw_access_fault : stlb_mecc_code_error;
        assign stlb_itlb_mdcause = (ptw_stlb_i_abort | ptw_stlb_i_ack) ? ((ptw_mdcause == 3'd5) ? 3'd4 : ptw_mdcause) : {2'b0,stlb_mecc_code_error};
        assign stlb_itlb_ecc_code = (ptw_stlb_i_abort | ptw_stlb_i_ack) ? ptw_ecc_code : stlb_mecc_code_code;
        assign stlb_itlb_ecc_corr = (ptw_stlb_i_abort | ptw_stlb_i_ack) ? ptw_ecc_corr : stlb_mecc_code_corr;
        assign stlb_itlb_ecc_ramid = (ptw_stlb_i_abort | ptw_stlb_i_ack) ? ptw_ecc_ramid : stlb_mecc_code_ramid;
        assign stlb_itlb_abort = ptw_stlb_i_abort;
        assign stlb_dtlb_ack = (stlb_sel_dtlb & (stlb_hit | stlb_mecc_code_error)) | ptw_stlb_d_ack;
        assign stlb_dtlb_ppn = ptw_stlb_d_ack ? ptw_ppn : stlb_ppn;
        assign stlb_dtlb_d = ptw_stlb_d_ack ? ptw_d : stlb_d;
        assign stlb_dtlb_a = ptw_stlb_d_ack ? ptw_a : stlb_a;
        assign stlb_dtlb_g = ptw_stlb_d_ack ? ptw_g : stlb_g;
        assign stlb_dtlb_u = ptw_stlb_d_ack ? ptw_u : stlb_u;
        assign stlb_dtlb_x = ptw_stlb_d_ack ? ptw_x : stlb_x;
        assign stlb_dtlb_w = ptw_stlb_d_ack ? ptw_w : stlb_w;
        assign stlb_dtlb_r = ptw_stlb_d_ack ? ptw_r : stlb_r;
        assign stlb_dtlb_page_fault = (ptw_stlb_d_abort | ptw_stlb_d_ack) ? ptw_page_fault : ~(stlb_v | stlb_mecc_code_error);
        assign stlb_dtlb_access_fault = (ptw_stlb_d_abort | ptw_stlb_d_ack) ? ptw_access_fault : stlb_mecc_code_error;
        assign stlb_dtlb_mdcause = (ptw_stlb_d_abort | ptw_stlb_d_ack) ? ptw_mdcause : {2'b0,stlb_mecc_code_error};
        assign stlb_dtlb_ecc_code = (ptw_stlb_d_abort | ptw_stlb_d_ack) ? ptw_ecc_code : stlb_mecc_code_code;
        assign stlb_dtlb_ecc_corr = (ptw_stlb_d_abort | ptw_stlb_d_ack) ? ptw_ecc_corr : stlb_mecc_code_corr;
        assign stlb_dtlb_ecc_ramid = (ptw_stlb_d_abort | ptw_stlb_d_ack) ? ptw_ecc_ramid : stlb_mecc_code_ramid;
        assign stlb_dtlb_abort = ptw_stlb_d_abort;
        wire stlb_service_en;
        reg [(VALEN - 1):12] service_vpn_reg;
        wire [(VALEN - 1):12] service_vpn_nx;
        reg [(ASID_LEN - 1):0] service_asid_reg;
        wire [(ASID_LEN - 1):0] service_asid_nx;
        reg [(PALEN - 1):12] service_ppn_reg;
        wire [(PALEN - 1):12] service_ppn_nx;
        reg [3:0] service_mode_reg;
        wire [3:0] service_mode_nx;
        reg check_vpn_reg;
        wire check_vpn_nx;
        reg check_asid_reg;
        wire check_asid_nx;
        reg keep_global_page_reg;
        wire keep_global_page_nx;
        reg [2:0] stlb_lru_arr[0:(STLB_ENTRIES / 4) - 1];
        wire stlb_lru_arr_en[0:(STLB_ENTRIES / 4) - 1];
        wire [(STLB_RAM_AW - 1):0] stlb_lru_idx;
        wire [3:0] stlb_lru_hit;
        wire [2:0] stlb_lru;
        wire [2:0] stlb_lru_nx;
        wire ptw_stlb_gnt;
        reg ptw_path;
        wire ptw_path_nx;
        wire ptw_path_en;
        reg [1:0] ptw_cs;
        reg [1:0] ptw_ns;
        reg [1:0] ptw_level_reg;
        wire [1:0] ptw_level_nx;
        wire ptw_level_rst;
        wire ptw_level_dec;
        reg [(PALEN - 1):12] pte_ppn_reg;
        wire pte_ppn_en;
        reg [11:LSU_ADDR_LSB] pte_offset_reg;
        wire pte_offset_en;
        reg [(VALEN - 1):12] ptw_vpn_reg;
        wire ptw_vpn_en;
        reg ptw_global_reg;
        wire ptw_global_nx;
        wire ptw_global_set;
        wire ptw_global_clr;
        wire [PTE_MSB:0] pte_rdata;
        wire [47:12] ptw_ppn_mask;
        wire [3:0] stlb_ram_arb_req;
        wire [3:0] stlb_ram_arb_gnt;
        assign stlb_ram_arb_req[3] = sfence_ram_req & stlb_pipe_idle;
        assign stlb_ram_arb_req[2] = ptw_ram_req & stlb_pipe_idle;
        assign stlb_ram_arb_req[1] = stlb_ram_req & stlb_pipe_idle & (stlb_cs == ST_STLB_IDLE) & (ptw_cs == ST_PTW_IDLE);
        assign stlb_ram_arb_req[0] = tlb_cctl_req & stlb_pipe_idle;
        assign sfence_ram_gnt = stlb_ram_arb_gnt[3];
        assign ptw_ram_gnt = stlb_ram_arb_gnt[2];
        assign stlb_ram_gnt = stlb_ram_arb_gnt[1];
        assign tlb_cctl_gnt = stlb_ram_arb_gnt[0];
        assign stlb_ram_arb_gnt[3] = (stlb_ram_arb_req[3] == 1'b1);
        assign stlb_ram_arb_gnt[2] = (stlb_ram_arb_req[3:2] == 2'b1);
        assign stlb_ram_arb_gnt[1] = (stlb_ram_arb_req[3:1] == 3'b1);
        assign stlb_ram_arb_gnt[0] = (stlb_ram_arb_req[3:0] == 4'b1);
        assign service_vpn_nx = sfence_ram_gnt ? sfence_va : stlb_dtlb_gnt ? dtlb_miss_vpn : itlb_miss_vpn;
        assign service_asid_nx = sfence_ram_gnt ? sfence_asid : csr_satp_asid;
        assign service_ppn_nx = csr_satp_ppn;
        assign service_mode_nx = csr_satp_mode;
        assign check_vpn_nx = sfence_ram_gnt ? (sfence_mode_va | sfence_mode_va_asid) : 1'b1;
        assign check_asid_nx = sfence_ram_gnt ? (sfence_mode_asid | sfence_mode_va_asid) : 1'b1;
        assign keep_global_page_nx = sfence_ram_gnt & (sfence_mode_asid | sfence_mode_va_asid);
        assign stlb_service_en = stlb_ram_gnt | (sfence_ram_gnt & (stlb_cs == ST_STLB_IDLE));
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                check_vpn_reg <= 1'b0;
                check_asid_reg <= 1'b0;
                keep_global_page_reg <= 1'b0;
            end
            else if (stlb_service_en) begin
                check_vpn_reg <= check_vpn_nx;
                check_asid_reg <= check_asid_nx;
                keep_global_page_reg <= keep_global_page_nx;
            end
        end

        always @(posedge core_clk) begin
            if (stlb_service_en) begin
                service_vpn_reg <= service_vpn_nx;
                service_asid_reg <= service_asid_nx;
                service_ppn_reg <= service_ppn_nx;
                service_mode_reg <= service_mode_nx;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                stlb_mask <= 1'b1;
            end
            else if (stlb_service_en) begin
                stlb_mask <= 1'b1;
            end
            else if (csr_mmu_satp_we) begin
                stlb_mask <= 1'b0;
            end
        end

        if ((VALEN - 12) >= 36) begin:gen_service_vpn
            assign service_vpn = service_vpn_reg[47:12];
        end
        else begin:gen_service_vpn_zext
            kv_zero_ext #(
                .OW(36),
                .IW(VALEN - 12)
            ) u_service_vpn_zext (
                .out(service_vpn),
                .in(service_vpn_reg)
            );
        end
        assign service_asid = service_asid_reg;
        assign service_ppn = service_ppn_reg;
        assign service_mode = service_mode_reg;
        assign check_vpn = check_vpn_reg;
        assign check_asid = check_asid_reg;
        assign keep_global_page = keep_global_page_reg;
        assign stlb_lru_idx = stlb_kp_fill ? ptw_ram_idx : service_vpn[STLB_RAM_AW - 1 + VPN0_LSB:VPN0_LSB];
        assign stlb_lru_hit = stlb_kp_fill ? stlb_victim[3:0] : stlb_kp_hit_vec[3:0];
        assign stlb_lru = stlb_lru_arr[stlb_lru_idx];
        reg stlb_lru_r;
        reg stlb_modified_lru;
        wire [2:0] stlb_lru_final;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                stlb_lru_r <= 1'b0;
                stlb_modified_lru <= 1'b0;
            end
            else if (|stlb_kp_replacement_vec) begin
                stlb_lru_r <= stlb_lru[0];
                stlb_modified_lru <= (stlb_lru_r ^~ stlb_lru[0]);
            end
        end

        assign stlb_victim[0] = ~stlb_lru_final[0] & ~stlb_lru_final[1];
        assign stlb_victim[1] = ~stlb_lru_final[0] & stlb_lru_final[1];
        assign stlb_victim[2] = stlb_lru_final[0] & ~stlb_lru_final[2];
        assign stlb_victim[3] = stlb_lru_final[0] & stlb_lru_final[2];
        assign stlb_lru_final[0] = (stlb_lru[0] & ~(&stlb_kp_valid_vec[3:2])) | (stlb_lru[0] & (&stlb_kp_valid_vec[1:0])) | ((&stlb_kp_valid_vec[1:0]) & ~(&stlb_kp_valid_vec[3:2]));
        assign stlb_lru_final[1] = (stlb_lru[1] & ~(stlb_kp_valid_vec[1])) | (stlb_lru[1] & (stlb_kp_valid_vec[0])) | ((stlb_kp_valid_vec[0]) & ~(stlb_kp_valid_vec[1]));
        assign stlb_lru_final[2] = (stlb_lru[2] & ~(stlb_kp_valid_vec[3])) | (stlb_lru[2] & (stlb_kp_valid_vec[2])) | ((stlb_kp_valid_vec[2]) & ~(stlb_kp_valid_vec[3]));
        assign stlb_lru_nx[0] = stlb_modified_lru ? ~stlb_lru[0] : |stlb_lru_hit[1:0];
        assign stlb_lru_nx[1] = |stlb_lru_hit[1:0] ? stlb_lru_hit[0] : stlb_lru[1];
        assign stlb_lru_nx[2] = |stlb_lru_hit[3:2] ? stlb_lru_hit[2] : stlb_lru[2];
        for (l = 0; l < (STLB_ENTRIES / 4); l = l + 1) begin:gen_stlb_lru
            assign stlb_lru_arr_en[l] = (stlb_lru_idx == l[(STLB_RAM_AW - 1):0]) & (stlb_kp_hit | stlb_kp_fill);
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb_lru_arr[l] <= 3'b0;
                end
                else if (stlb_lru_arr_en[l]) begin
                    stlb_lru_arr[l] <= stlb_lru_nx;
                end
            end

        end
        assign ptw_ram_wdata[STLB_VPN_MSB:STLB_VPN_LSB] = ptw_vpn[(VALEN - 1):12 + STLB_RAM_AW];
        assign ptw_ram_wdata[STLB_ASID_MSB:STLB_ASID_LSB] = service_asid;
        assign ptw_ram_wdata[STLB_VALID] = (ptw_ram_gnt & stlb_kp_fill);
        assign ptw_ram_wdata[STLB_PPN_MSB:STLB_PPN_LSB] = ptw_ppn_raw[(PALEN - 1):12];
        assign ptw_ram_wdata[STLB_D_BIT] = ptw_d;
        assign ptw_ram_wdata[STLB_A_BIT] = ptw_a;
        assign ptw_ram_wdata[STLB_G_BIT] = ptw_g;
        assign ptw_ram_wdata[STLB_U_BIT] = ptw_u;
        assign ptw_ram_wdata[STLB_X_BIT] = ptw_x;
        assign ptw_ram_wdata[STLB_W_BIT] = ptw_w;
        assign ptw_ram_wdata[STLB_R_BIT] = ptw_r;
        assign ptw_ram_wdata[STLB_V_BIT] = ~ptw_page_fault;
        assign stlb_kp_replacement_vec[0] = stlb_victim[0] & stlb_kp_fill & stlb0_valid;
        assign stlb_kp_replacement_vec[1] = stlb_victim[1] & stlb_kp_fill & stlb1_valid;
        assign stlb_kp_replacement_vec[2] = stlb_victim[2] & stlb_kp_fill & stlb2_valid;
        assign stlb_kp_replacement_vec[3] = stlb_victim[3] & stlb_kp_fill & stlb3_valid;
        assign stlb0_valid = stlb0_ram_rdata[STLB_VALID];
        assign stlb1_valid = stlb1_ram_rdata[STLB_VALID];
        assign stlb2_valid = stlb2_ram_rdata[STLB_VALID];
        assign stlb3_valid = stlb3_ram_rdata[STLB_VALID];
        assign stlb_kp_valid_vec = {stlb3_valid,stlb2_valid,stlb1_valid,stlb0_valid};
        assign stlb0_vpn = stlb0_ram_rdata[STLB_VPN_MSB:STLB_VPN_LSB];
        assign stlb1_vpn = stlb1_ram_rdata[STLB_VPN_MSB:STLB_VPN_LSB];
        assign stlb2_vpn = stlb2_ram_rdata[STLB_VPN_MSB:STLB_VPN_LSB];
        assign stlb3_vpn = stlb3_ram_rdata[STLB_VPN_MSB:STLB_VPN_LSB];
        assign stlb0_asid = stlb0_ram_rdata[STLB_ASID_MSB:STLB_ASID_LSB];
        assign stlb1_asid = stlb1_ram_rdata[STLB_ASID_MSB:STLB_ASID_LSB];
        assign stlb2_asid = stlb2_ram_rdata[STLB_ASID_MSB:STLB_ASID_LSB];
        assign stlb3_asid = stlb3_ram_rdata[STLB_ASID_MSB:STLB_ASID_LSB];
        assign stlb0_g = stlb0_ram_rdata[STLB_G_BIT];
        assign stlb1_g = stlb1_ram_rdata[STLB_G_BIT];
        assign stlb2_g = stlb2_ram_rdata[STLB_G_BIT];
        assign stlb3_g = stlb3_ram_rdata[STLB_G_BIT];
        assign stlb_sp_wdata = ptw_ram_wdata;
        assign sfence_req = mmu_fence_req | self_reset;
        assign sfence_va = mmu_fence_vaddr;
        assign sfence_asid = mmu_fence_asid;
        assign mmu_fence_done = sfence_done;
        assign sfence_mode_flush_all = self_reset | (mmu_fence_mode == SFENCE_ALL_MODE);
        assign sfence_mode_va = ~self_reset & (mmu_fence_mode == SFENCE_VA_MODE);
        assign sfence_mode_asid = ~self_reset & (mmu_fence_mode == SFENCE_ASID_MODE);
        assign sfence_mode_va_asid = ~self_reset & (mmu_fence_mode == SFENCE_VA_ASID_MODE);
        assign itlb_sfence_req = sfence_done;
        assign itlb_sfence_mode_flush_all = sfence_mode_flush_all;
        assign itlb_sfence_mode_va = sfence_mode_va;
        assign dtlb_sfence_req = sfence_done;
        assign dtlb_sfence_mode_flush_all = sfence_mode_flush_all;
        assign dtlb_sfence_mode_va = sfence_mode_va;
        wire [11:4] sfence_hit_vec;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                self_reset <= 1'b1;
            end
            else if (sfence_done) begin
                self_reset <= 1'b0;
            end
        end

        assign sfence_hit_vec[11:4] = stlb_sp_hit_vec[11:4];
        assign sfence_flush[STLB_SP_ENTRIES + 3:4] = {(STLB_SP_ENTRIES){sfence_done}} & (sfence_mode_flush_all ? {(STLB_SP_ENTRIES){1'b1}} : sfence_hit_vec[(STLB_SP_ENTRIES + 3):4]);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                sfence_ram_req <= 1'b0;
            end
            else if (sfence_req | sfence_done) begin
                sfence_ram_req <= ~sfence_done;
            end
        end

        assign ptw_req = stlb_ptw_req;
        assign ptw_stlb_gnt = stlb_ptw_req;
        assign ptw_path_en = ptw_idle & ptw_req;
        assign ptw_path_nx = stlb_sel_dtlb ? PTW_PATH_STLB_D : PTW_PATH_STLB_I;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                ptw_path <= 1'b0;
            end
            else if (ptw_path_en) begin
                ptw_path <= ptw_path_nx;
            end
        end

        assign ptw_sel_stlb_i = ~ptw_idle & (ptw_path == PTW_PATH_STLB_I);
        assign ptw_sel_stlb_d = ~ptw_idle & (ptw_path == PTW_PATH_STLB_D);
        assign ptw_vpn_en = ptw_req & ptw_idle;
        wire [(VALEN - 1):12] ptw_vpn_nx_temp = {(VALEN - 12){ptw_stlb_gnt}} & stlb_vpn[(VALEN - 1):12];
        if ((VALEN - 12) >= 36) begin:gen_ptw_vpn_nx
            assign ptw_vpn_nx = ptw_vpn_nx_temp[47:12];
        end
        else begin:gen_ptw_vpn_nx_zext
            kv_zero_ext #(
                .OW(36),
                .IW(VALEN - 12)
            ) u_ptw_vpn_nx_zext (
                .out(ptw_vpn_nx),
                .in(ptw_vpn_nx_temp)
            );
        end
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                ptw_vpn_reg <= {(VALEN - 12){1'b0}};
            end
            else if (ptw_vpn_en) begin
                ptw_vpn_reg <= ptw_vpn_nx[(VALEN - 1):12];
            end
        end

        if ((VALEN - 12) >= 36) begin:gen_ptw_vpn
            assign ptw_vpn = ptw_vpn_reg[47:12];
        end
        else begin:gen_ptw_vpn_zext
            kv_zero_ext #(
                .OW(36),
                .IW(VALEN - 12)
            ) u_ptw_vpn_zext (
                .out(ptw_vpn),
                .in(ptw_vpn_reg)
            );
        end
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                ptw_cs <= ST_PTW_IDLE;
            end
            else begin
                ptw_cs <= ptw_ns;
            end
        end

        always @* begin
            case (ptw_cs)
                ST_PTW_ADDR: begin
                    if (ptw_mmu_req_ready | ptc_hit) begin
                        ptw_ns = ST_PTW_DATA;
                    end
                    else begin
                        ptw_ns = ST_PTW_ADDR;
                    end
                end
                ST_PTW_DATA: begin
                    if (ptw_access_done | ptw_abort) begin
                        ptw_ns = ST_PTW_IDLE;
                    end
                    else if (valid_lsu_ack | ptc_hit_d1) begin
                        ptw_ns = ST_PTW_ADDR;
                    end
                    else begin
                        ptw_ns = ST_PTW_DATA;
                    end
                end
                ST_PTW_IDLE: begin
                    if (ptw_stlb_gnt & ~stlb_kill) begin
                        ptw_ns = ST_PTW_ADDR;
                    end
                    else begin
                        ptw_ns = ST_PTW_IDLE;
                    end
                end
                default: ptw_ns = 2'b0;
            endcase
        end

        assign ptw_idle = (ptw_cs == ST_PTW_IDLE);
        assign ptw_addr_phase = (ptw_cs == ST_PTW_ADDR);
        assign ptw_data_phase = (ptw_cs == ST_PTW_DATA);
        assign ptw_level_rst = ptw_req & ptw_idle;
        assign ptw_level_dec = valid_pte;
        assign ptw_level_nx = ptw_level_rst ? {service_mode[3],service_mode[0]} : ptw_level_dec ? ptw_level - 2'd1 : ptw_level;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                ptw_level_reg <= 2'b0;
            end
            else begin
                ptw_level_reg <= ptw_level_nx;
            end
        end

        assign ptw_level = ((MMU_SCHEME_INT == 1)) ? {1'b0,ptw_level_reg[0]} : {ptw_level_reg};
        assign pte_ppn_en = (ptw_req & ptw_idle) | valid_pte;
        assign pte_ppn_nx = ptw_idle ? service_ppn : pte_rdata[PTE_PPN_MSB:PTE_PPN_LSB];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pte_ppn_reg <= {(PALEN - 12){1'b0}};
            end
            else if (pte_ppn_en) begin
                pte_ppn_reg <= pte_ppn_nx;
            end
        end

        assign pte_ppn = pte_ppn_reg;
        assign pte_offset_en = pte_ppn_en;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pte_offset_reg <= {(12 - LSU_ADDR_LSB){1'b0}};
            end
            else if (pte_offset_en) begin
                pte_offset_reg <= pte_offset_nx;
            end
        end

        assign pte_offset = pte_offset_reg;
        assign ptw_global_set = valid_pte & pte_rdata[PTE_G];
        assign ptw_global_clr = ptw_req & ptw_idle;
        assign ptw_global_nx = (ptw_global_set | ptw_global_reg) & ~ptw_global_clr;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                ptw_global_reg <= 1'b0;
            end
            else begin
                ptw_global_reg <= ptw_global_nx;
            end
        end

        assign ptw_global = ptw_global_reg;
        assign pte_rdata = ({(PTE_MSB + 1){ptc_pfhit_d1}} & ptc_pf_rdata) | ({(PTE_MSB + 1){ptc_ihit_d1}} & ptc_irdata) | ({(PTE_MSB + 1){ptc_dhit_d1}} & ptc_drdata) | ({(PTE_MSB + 1){valid_lsu_ack}} & lsu_rdata);
        if ((PTE_MSB - PTE_PPN_LSB + 1) >= 36) begin:gen_ptw_ppn_raw
            assign ptw_ppn_raw = pte_rdata[PTE_PPN_LSB +:36];
        end
        else begin:gen_ptw_ppn_raw_zext
            kv_zero_ext #(
                .OW(36),
                .IW(PTE_MSB - PTE_PPN_LSB + 1)
            ) u_ptw_ppn_raw_zext (
                .out(ptw_ppn_raw),
                .in(pte_rdata[PTE_MSB:PTE_PPN_LSB])
            );
        end
        assign ptw_ppn_mask[VPN3_MSB:VPN3_LSB] = {(VPN3_MSB - VPN3_LSB + 1){1'b0}};
        assign ptw_ppn_mask[VPN2_MSB:VPN2_LSB] = {(VPN2_MSB - VPN2_LSB + 1){ptw_is_terapage}};
        assign ptw_ppn_mask[VPN1_MSB:VPN1_LSB] = {(VPN1_MSB - VPN1_LSB + 1){ptw_is_terapage | ptw_is_gigapage}};
        assign ptw_ppn_mask[VPN0_MSB:VPN0_LSB] = {(VPN0_MSB - VPN0_LSB + 1){ptw_is_terapage | ptw_is_gigapage | ptw_is_megapage}};
        assign ptw_ppn = ptw_ppn_raw[(PALEN - 1):12] | (ptw_vpn[(PALEN - 1):12] & ptw_ppn_mask[(PALEN - 1):12]);
        assign ptw_d = pte_rdata[PTE_D];
        assign ptw_a = pte_rdata[PTE_A];
        assign ptw_g = pte_rdata[PTE_G] | ptw_global;
        assign ptw_u = pte_rdata[PTE_U];
        assign ptw_x = pte_rdata[PTE_X];
        assign ptw_w = pte_rdata[PTE_W];
        assign ptw_r = pte_rdata[PTE_R];
        assign ptw_v = pte_rdata[PTE_V];
        assign ptw_ps = ptw_level;
        if ((MMU_SCHEME_INT == 1)) begin:gen_pte_offset_sv32
            assign pte_offset_nx = ({(12 - LSU_ADDR_LSB){ptw_idle}} & ptw_vpn_nx[VPN1_MSB:VPN1_LSB]) | ({(12 - LSU_ADDR_LSB){~ptw_idle}} & ptw_vpn[VPN0_MSB:VPN0_LSB]);
        end
        else begin:gen_pte_offset_sv39_sv48
            assign pte_offset_nx = ({(12 - LSU_ADDR_LSB){ptw_idle & (service_mode == SATP_MODE_SV48) & TERAPAGE_EXIST}} & ptw_vpn_nx[VPN3_MSB:VPN3_LSB]) | ({(12 - LSU_ADDR_LSB){ptw_idle & (service_mode == SATP_MODE_SV39) & GIGAPAGE_EXIST}} & ptw_vpn_nx[VPN2_MSB:VPN2_LSB]) | ({(12 - LSU_ADDR_LSB){~ptw_idle & (ptw_level == 2'd3) & TERAPAGE_EXIST}} & ptw_vpn[VPN2_MSB:VPN2_LSB]) | ({(12 - LSU_ADDR_LSB){~ptw_idle & (ptw_level == 2'd2) & GIGAPAGE_EXIST}} & ptw_vpn[VPN1_MSB:VPN1_LSB]) | ({(12 - LSU_ADDR_LSB){~ptw_idle & (ptw_level == 2'd1)}} & ptw_vpn[VPN0_MSB:VPN0_LSB]);
        end
        assign ptw_leaf_pte = ptw_x | ptw_w | ptw_r | (ptw_level == 2'b0);
        assign ptw_abort = ptw_access_fault | (valid_pte & ptw_page_fault & (|ptw_level));
        assign ptw_access_done = valid_pte & ptw_leaf_pte;
        assign valid_lsu_ack = ptw_mmu_resp_valid & ~ptw_access_fault;
        assign valid_pte = valid_lsu_ack | ptc_hit_d1;
        if (32 > PTE_SIZE) begin:gen_lsu_rdata_select
            wire [PTE_MSB:0] lsu_rdata_entry[0:LSU_DATA_ENTRY_COUNT - 1];
            wire [(LSU_ALIGNED_ADDR_LSB - LSU_ADDR_LSB - 1):0] lsu_rdata_entry_index;
            wire [(LSU_ALIGNED_ADDR_LSB - LSU_ADDR_LSB - 1):0] lsu_rdata_entry_index_pf;
            wire [LSU_ALIGNED_ADDR_LSB - LSU_ADDR_LSB:0] lsu_rdata_entry_index_pf_mask;
            for (i = 0; i < LSU_DATA_ENTRY_COUNT; i = i + 1) begin:gen_lsu_rdata_entries
                assign lsu_rdata_entry[i] = ptw_mmu_resp_data[(i * PTE_SIZE) +:PTE_SIZE];
            end
            assign lsu_rdata_entry_index = mmu_ptw_req_pa[(LSU_ALIGNED_ADDR_LSB - 1):LSU_ADDR_LSB];
            assign lsu_rdata_entry_index_pf = mmu_ptw_req_pa[(LSU_ALIGNED_ADDR_LSB - 1):LSU_ADDR_LSB] | lsu_rdata_entry_index_pf_mask[(LSU_ALIGNED_ADDR_LSB - LSU_ADDR_LSB - 1):0];
            assign lsu_rdata_entry_index_pf_mask = {{(LSU_ALIGNED_ADDR_LSB - LSU_ADDR_LSB){1'b0}},1'b1};
            assign lsu_rdata = lsu_rdata_entry[lsu_rdata_entry_index];
            assign lsu_rdata_pf = lsu_rdata_entry[lsu_rdata_entry_index_pf];
            assign ptc_pf_en = ~lsu_rdata_entry_index[0];
        end
        else begin:gen_lsu_rdata
            assign lsu_rdata = ptw_mmu_resp_data;
            assign lsu_rdata_pf = ptw_mmu_resp_data;
            assign ptc_pf_en = 1'b0;
        end
        assign ptw_is_kilopage = (ptw_ps == KILOPAGE);
        assign ptw_is_megapage = (ptw_ps == MEGAPAGE);
        assign ptw_is_gigapage = (ptw_ps == GIGAPAGE) & GIGAPAGE_EXIST;
        assign ptw_is_terapage = (ptw_ps == TERAPAGE) & TERAPAGE_EXIST;
        assign ptw_misalign_fault = (|ptw_ppn_raw[VPN0_MSB:VPN0_LSB]) & ptw_is_megapage | (|ptw_ppn_raw[VPN1_MSB:VPN0_LSB]) & ptw_is_gigapage | (|ptw_ppn_raw[VPN2_MSB:VPN0_LSB]) & ptw_is_terapage;
        assign ptw_stlb_i_ack = ptw_sel_stlb_i & ptw_access_done & ~ptw_abort;
        assign ptw_stlb_d_ack = ptw_sel_stlb_d & ptw_access_done & ~ptw_abort;
        assign ptw_stlb_ack = ptw_stlb_i_ack | ptw_stlb_d_ack;
        assign ptw_access_fault = ptw_data_phase & ptw_mmu_resp_valid & ptw_mmu_resp_status[0];
        assign ptw_mdcause = {3{ptw_data_phase & ptw_mmu_resp_valid}} & ptw_mmu_resp_status[3:1];
        assign ptw_ecc_code = {8{ptw_data_phase & ptw_mmu_resp_valid}} & ptw_mmu_resp_status[11:4];
        assign ptw_ecc_corr = ptw_data_phase & ptw_mmu_resp_valid & ptw_mmu_resp_status[12];
        assign ptw_ecc_ramid = {4{ptw_data_phase & ptw_mmu_resp_valid}} & ptw_mmu_resp_status[16:13];
        assign ptw_page_fault = valid_pte & ((~ptw_v) | (ptw_leaf_pte & ptw_misalign_fault) | (ptw_w & ~ptw_r)) & ~(ptw_access_fault);
        assign ptw_stlb_i_abort = ptw_sel_stlb_i & ptw_abort;
        assign ptw_stlb_d_abort = ptw_sel_stlb_d & ptw_abort;
        assign ptw_ram_req = ptw_stlb_ack & ptw_is_kilopage;
        assign ptw_ram_idx = ptw_vpn[(STLB_RAM_AW + VPN0_LSB - 1):12];
        assign stlb_kp_fill = ptw_stlb_ack & ptw_is_kilopage;
        assign stlb_sp_fill = ptw_stlb_ack & ~ptw_is_kilopage;
        assign block_lsu_req = ptc_hit;
        assign mmu_ptw_req_valid = ptw_addr_phase & ~block_lsu_req;
        assign mmu_ptw_req_pa = {pte_ppn,pte_offset,{LSU_ADDR_LSB{1'b0}}};
        assign ptc_ifill = ptw_sel_stlb_i & valid_lsu_ack & ptw_v & ~ptw_leaf_pte;
        assign ptc_dfill = ptw_sel_stlb_d & valid_lsu_ack & ptw_v & ~ptw_leaf_pte;
        assign ptc_irdata = {(PTE_MSB + 1){(ptw_level == 2'd1)}} & ptc_l1i_rdata | {(PTE_MSB + 1){(ptw_level == 2'd2)}} & ptc_l2i_rdata | {(PTE_MSB + 1){(ptw_level == 2'd3)}} & ptc_l3i_rdata;
        assign ptc_drdata = {(PTE_MSB + 1){(ptw_level == 2'd1)}} & ptc_l1d_rdata | {(PTE_MSB + 1){(ptw_level == 2'd2)}} & ptc_l2d_rdata | {(PTE_MSB + 1){(ptw_level == 2'd3)}} & ptc_l3d_rdata;
        assign ptc_itag = {(PALEN - LSU_ADDR_LSB){(ptw_level == 2'd1)}} & ptc_l1i_tag | {(PALEN - LSU_ADDR_LSB){(ptw_level == 2'd2)}} & ptc_l2i_tag | {(PALEN - LSU_ADDR_LSB){(ptw_level == 2'd3)}} & ptc_l3i_tag;
        assign ptc_dtag = {(PALEN - LSU_ADDR_LSB){(ptw_level == 2'd1)}} & ptc_l1d_tag | {(PALEN - LSU_ADDR_LSB){(ptw_level == 2'd2)}} & ptc_l2d_tag | {(PALEN - LSU_ADDR_LSB){(ptw_level == 2'd3)}} & ptc_l3d_tag;
        assign ptc_ihit = (mmu_ptw_req_pa[(PALEN - 1):LSU_ADDR_LSB] == ptc_itag) & ptc_irdata[PTE_V];
        assign ptc_dhit = (mmu_ptw_req_pa[(PALEN - 1):LSU_ADDR_LSB] == ptc_dtag) & ptc_drdata[PTE_V];
        assign ptc_pfhit = (mmu_ptw_req_pa[(PALEN - 1):LSU_ADDR_LSB] == ptc_pf_tag) & ptc_pf_rdata[PTE_V];
        assign ptc_hit = ptw_addr_phase & (ptc_ihit | ptc_dhit | ptc_pfhit);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                ptc_ihit_d1 <= 1'b0;
                ptc_dhit_d1 <= 1'b0;
                ptc_pfhit_d1 <= 1'b0;
                ptc_hit_d1 <= 1'b0;
            end
            else begin
                ptc_ihit_d1 <= ptc_ihit;
                ptc_dhit_d1 <= ptc_dhit;
                ptc_pfhit_d1 <= ptc_pfhit;
                ptc_hit_d1 <= ptc_hit;
            end
        end

        reg mmu_csr_mitlb_access_reg;
        reg mmu_csr_mitlb_miss_reg;
        reg mmu_csr_mdtlb_access_reg;
        reg mmu_csr_mdtlb_miss_reg;
        wire mmu_csr_mitlb_access_nx;
        wire mmu_csr_mitlb_miss_nx;
        wire mmu_csr_mdtlb_access_nx;
        wire mmu_csr_mdtlb_miss_nx;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                mmu_csr_mitlb_access_reg <= 1'b0;
                mmu_csr_mitlb_miss_reg <= 1'b0;
                mmu_csr_mdtlb_access_reg <= 1'b0;
                mmu_csr_mdtlb_miss_reg <= 1'b0;
            end
            else begin
                mmu_csr_mitlb_access_reg <= mmu_csr_mitlb_access_nx;
                mmu_csr_mitlb_miss_reg <= mmu_csr_mitlb_miss_nx;
                mmu_csr_mdtlb_access_reg <= mmu_csr_mdtlb_access_nx;
                mmu_csr_mdtlb_miss_reg <= mmu_csr_mdtlb_miss_nx;
            end
        end

        assign mmu_csr_mitlb_access_nx = stlb_itlb_gnt & stlb_idle;
        assign mmu_csr_mitlb_miss_nx = stlb_sel_itlb & stlb_ptw_req & ptw_idle;
        assign mmu_csr_mdtlb_access_nx = stlb_dtlb_gnt & stlb_idle;
        assign mmu_csr_mdtlb_miss_nx = stlb_sel_dtlb & stlb_ptw_req & ptw_idle;
        assign mmu_csr_mitlb_access = mmu_csr_mitlb_access_reg;
        assign mmu_csr_mitlb_miss = mmu_csr_mitlb_miss_reg;
        assign mmu_csr_mdtlb_access = mmu_csr_mdtlb_access_reg;
        assign mmu_csr_mdtlb_miss = mmu_csr_mdtlb_miss_reg;
        wire ptc_l1i_fill;
        wire ptc_l1d_fill;
        reg ptc_l1i_v;
        reg ptc_l1d_v;
        wire ptc_l1i_v_clr;
        wire ptc_l1d_v_clr;
        wire ptc_l1i_v_nx;
        wire ptc_l1d_v_nx;
        reg [(PALEN - 1):LSU_ADDR_LSB] ptc_l1i_tag_reg;
        reg [(PALEN - 1):LSU_ADDR_LSB] ptc_l1d_tag_reg;
        reg [(PALEN - 1):12] ptc_l1i_ppn;
        reg [(PALEN - 1):12] ptc_l1d_ppn;
        reg ptc_l1i_g;
        reg ptc_l1d_g;
        assign ptc_l1i_fill = ptc_ifill & (ptw_level == 2'd1);
        assign ptc_l1d_fill = ptc_dfill & (ptw_level == 2'd1);
        assign ptc_l1i_v_clr = sfence_done & (sfence_mode_flush_all | (sfence_mode_asid & ~ptc_l1i_g));
        assign ptc_l1d_v_clr = sfence_done & (sfence_mode_flush_all | (sfence_mode_asid & ~ptc_l1d_g));
        assign ptc_l1i_v_nx = (ptc_l1i_fill | ptc_l1i_v) & ~ptc_l1i_v_clr;
        assign ptc_l1d_v_nx = (ptc_l1d_fill | ptc_l1d_v) & ~ptc_l1d_v_clr;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                ptc_l1i_v <= 1'b0;
            end
            else begin
                ptc_l1i_v <= ptc_l1i_v_nx;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                ptc_l1d_v <= 1'b0;
            end
            else begin
                ptc_l1d_v <= ptc_l1d_v_nx;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                ptc_l1i_g <= 1'b0;
            end
            else if (ptc_l1i_fill) begin
                ptc_l1i_g <= lsu_rdata[PTE_G] | ptw_global;
            end
        end

        always @(posedge core_clk) begin
            if (ptc_l1i_fill) begin
                ptc_l1i_tag_reg <= mmu_ptw_req_pa[(PALEN - 1):LSU_ADDR_LSB];
                ptc_l1i_ppn <= lsu_rdata[PTE_PPN_MSB:PTE_PPN_LSB];
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                ptc_l1d_g <= 1'b0;
            end
            else if (ptc_l1d_fill) begin
                ptc_l1d_g <= lsu_rdata[PTE_G] | ptw_global;
            end
        end

        always @(posedge core_clk) begin
            if (ptc_l1d_fill) begin
                ptc_l1d_tag_reg <= mmu_ptw_req_pa[(PALEN - 1):LSU_ADDR_LSB];
                ptc_l1d_ppn <= lsu_rdata[PTE_PPN_MSB:PTE_PPN_LSB];
            end
        end

        assign ptc_l1i_tag = ptc_l1i_tag_reg;
        assign ptc_l1i_rdata[PTE_V] = ptc_l1i_v;
        assign ptc_l1i_rdata[PTE_R] = 1'b0;
        assign ptc_l1i_rdata[PTE_W] = 1'b0;
        assign ptc_l1i_rdata[PTE_X] = 1'b0;
        assign ptc_l1i_rdata[PTE_U] = 1'b0;
        assign ptc_l1i_rdata[PTE_G] = ptc_l1i_g;
        assign ptc_l1i_rdata[PTE_A] = 1'b0;
        assign ptc_l1i_rdata[PTE_D] = 1'b0;
        assign ptc_l1i_rdata[PTE_RESERVED_MSB:PTE_RESERVED_LSB] = {(PTE_RESERVED_MSB - PTE_RESERVED_LSB + 1){1'b0}};
        kv_zero_ext #(
            .OW(PTE_MSB - PTE_PPN_LSB + 1),
            .IW(PALEN - 12)
        ) u_ptc_l1i_ppn_zext (
            .out(ptc_l1i_rdata[PTE_MSB:PTE_PPN_LSB]),
            .in(ptc_l1i_ppn)
        );
        assign ptc_l1d_tag = ptc_l1d_tag_reg;
        assign ptc_l1d_rdata[PTE_V] = ptc_l1d_v;
        assign ptc_l1d_rdata[PTE_R] = 1'b0;
        assign ptc_l1d_rdata[PTE_W] = 1'b0;
        assign ptc_l1d_rdata[PTE_X] = 1'b0;
        assign ptc_l1d_rdata[PTE_U] = 1'b0;
        assign ptc_l1d_rdata[PTE_G] = ptc_l1d_g;
        assign ptc_l1d_rdata[PTE_A] = 1'b0;
        assign ptc_l1d_rdata[PTE_D] = 1'b0;
        assign ptc_l1d_rdata[PTE_RESERVED_MSB:PTE_RESERVED_LSB] = {(PTE_RESERVED_MSB - PTE_RESERVED_LSB + 1){1'b0}};
        kv_zero_ext #(
            .OW(PTE_MSB - PTE_PPN_LSB + 1),
            .IW(PALEN - 12)
        ) u_ptc_l1d_ppn_zext (
            .out(ptc_l1d_rdata[PTE_MSB:PTE_PPN_LSB]),
            .in(ptc_l1d_ppn)
        );
        if ((MMU_SCHEME_INT != 1)) begin:gen_ptc_l2_rdata
            wire ptc_l2i_fill;
            wire ptc_l2d_fill;
            reg ptc_l2i_v;
            reg ptc_l2d_v;
            wire ptc_l2i_v_clr;
            wire ptc_l2d_v_clr;
            wire ptc_l2i_v_nx;
            wire ptc_l2d_v_nx;
            reg [(PALEN - 1):LSU_ADDR_LSB] ptc_l2i_tag_reg;
            reg [(PALEN - 1):LSU_ADDR_LSB] ptc_l2d_tag_reg;
            reg [(PALEN - 1):12] ptc_l2i_ppn;
            reg [(PALEN - 1):12] ptc_l2d_ppn;
            reg ptc_l2i_g;
            reg ptc_l2d_g;
            assign ptc_l2i_fill = ptc_ifill & (ptw_level == 2'd2);
            assign ptc_l2d_fill = ptc_dfill & (ptw_level == 2'd2);
            assign ptc_l2i_v_clr = sfence_done & (sfence_mode_flush_all | (sfence_mode_asid & ~ptc_l2i_g));
            assign ptc_l2d_v_clr = sfence_done & (sfence_mode_flush_all | (sfence_mode_asid & ~ptc_l2d_g));
            assign ptc_l2i_v_nx = (ptc_l2i_fill | ptc_l2i_v) & ~ptc_l2i_v_clr;
            assign ptc_l2d_v_nx = (ptc_l2d_fill | ptc_l2d_v) & ~ptc_l2d_v_clr;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    ptc_l2i_v <= 1'b0;
                end
                else begin
                    ptc_l2i_v <= ptc_l2i_v_nx;
                end
            end

            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    ptc_l2d_v <= 1'b0;
                end
                else begin
                    ptc_l2d_v <= ptc_l2d_v_nx;
                end
            end

            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    ptc_l2i_g <= 1'b0;
                end
                else if (ptc_l2i_fill) begin
                    ptc_l2i_g <= lsu_rdata[PTE_G] | ptw_global;
                end
            end

            always @(posedge core_clk) begin
                if (ptc_l2i_fill) begin
                    ptc_l2i_tag_reg <= mmu_ptw_req_pa[(PALEN - 1):LSU_ADDR_LSB];
                    ptc_l2i_ppn <= lsu_rdata[PTE_PPN_MSB:PTE_PPN_LSB];
                end
            end

            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    ptc_l2d_g <= 1'b0;
                end
                else if (ptc_l2d_fill) begin
                    ptc_l2d_g <= lsu_rdata[PTE_G] | ptw_global;
                end
            end

            always @(posedge core_clk) begin
                if (ptc_l2d_fill) begin
                    ptc_l2d_tag_reg <= mmu_ptw_req_pa[(PALEN - 1):LSU_ADDR_LSB];
                    ptc_l2d_ppn <= lsu_rdata[PTE_PPN_MSB:PTE_PPN_LSB];
                end
            end

            assign ptc_l2i_tag = ptc_l2i_tag_reg;
            assign ptc_l2i_rdata[PTE_V] = ptc_l2i_v;
            assign ptc_l2i_rdata[PTE_R] = 1'b0;
            assign ptc_l2i_rdata[PTE_W] = 1'b0;
            assign ptc_l2i_rdata[PTE_X] = 1'b0;
            assign ptc_l2i_rdata[PTE_U] = 1'b0;
            assign ptc_l2i_rdata[PTE_G] = ptc_l2i_g;
            assign ptc_l2i_rdata[PTE_A] = 1'b0;
            assign ptc_l2i_rdata[PTE_D] = 1'b0;
            assign ptc_l2i_rdata[PTE_RESERVED_MSB:PTE_RESERVED_LSB] = {(PTE_RESERVED_MSB - PTE_RESERVED_LSB + 1){1'b0}};
            kv_zero_ext #(
                .OW(PTE_MSB - PTE_PPN_LSB + 1),
                .IW(PALEN - 12)
            ) u_ptc_l2i_ppn_zext (
                .out(ptc_l2i_rdata[PTE_MSB:PTE_PPN_LSB]),
                .in(ptc_l2i_ppn)
            );
            assign ptc_l2d_tag = ptc_l2d_tag_reg;
            assign ptc_l2d_rdata[PTE_V] = ptc_l2d_v;
            assign ptc_l2d_rdata[PTE_R] = 1'b0;
            assign ptc_l2d_rdata[PTE_W] = 1'b0;
            assign ptc_l2d_rdata[PTE_X] = 1'b0;
            assign ptc_l2d_rdata[PTE_U] = 1'b0;
            assign ptc_l2d_rdata[PTE_G] = ptc_l2d_g;
            assign ptc_l2d_rdata[PTE_A] = 1'b0;
            assign ptc_l2d_rdata[PTE_D] = 1'b0;
            assign ptc_l2d_rdata[PTE_RESERVED_MSB:PTE_RESERVED_LSB] = {(PTE_RESERVED_MSB - PTE_RESERVED_LSB + 1){1'b0}};
            kv_zero_ext #(
                .OW(PTE_MSB - PTE_PPN_LSB + 1),
                .IW(PALEN - 12)
            ) u_ptc_l2d_ppn_zext (
                .out(ptc_l2d_rdata[PTE_MSB:PTE_PPN_LSB]),
                .in(ptc_l2d_ppn)
            );
        end
        else begin
            assign ptc_l2i_tag = {(PALEN - LSU_ADDR_LSB){1'b0}};
            assign ptc_l2i_rdata = {(PTE_MSB + 1){1'b0}};
            assign ptc_l2d_tag = {(PALEN - LSU_ADDR_LSB){1'b0}};
            assign ptc_l2d_rdata = {(PTE_MSB + 1){1'b0}};
        end
        if ((MMU_SCHEME_INT != 1)) begin:gen_ptc_l3_rdata
            wire ptc_l3i_fill;
            wire ptc_l3d_fill;
            reg ptc_l3i_v;
            reg ptc_l3d_v;
            wire ptc_l3i_v_clr;
            wire ptc_l3d_v_clr;
            wire ptc_l3i_v_nx;
            wire ptc_l3d_v_nx;
            reg [(PALEN - 1):LSU_ADDR_LSB] ptc_l3i_tag_reg;
            reg [(PALEN - 1):LSU_ADDR_LSB] ptc_l3d_tag_reg;
            reg [(PALEN - 1):12] ptc_l3i_ppn;
            reg [(PALEN - 1):12] ptc_l3d_ppn;
            reg ptc_l3i_g;
            reg ptc_l3d_g;
            assign ptc_l3i_fill = ptc_ifill & (ptw_level == 2'd3);
            assign ptc_l3d_fill = ptc_dfill & (ptw_level == 2'd3);
            assign ptc_l3i_v_clr = sfence_done & (sfence_mode_flush_all | (sfence_mode_asid & ~ptc_l3i_g));
            assign ptc_l3d_v_clr = sfence_done & (sfence_mode_flush_all | (sfence_mode_asid & ~ptc_l3d_g));
            assign ptc_l3i_v_nx = (ptc_l3i_fill | ptc_l3i_v) & ~ptc_l3i_v_clr;
            assign ptc_l3d_v_nx = (ptc_l3d_fill | ptc_l3d_v) & ~ptc_l3d_v_clr;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    ptc_l3i_v <= 1'b0;
                end
                else begin
                    ptc_l3i_v <= ptc_l3i_v_nx;
                end
            end

            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    ptc_l3d_v <= 1'b0;
                end
                else begin
                    ptc_l3d_v <= ptc_l3d_v_nx;
                end
            end

            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    ptc_l3i_g <= 1'b0;
                end
                else if (ptc_l3i_fill) begin
                    ptc_l3i_g <= lsu_rdata[PTE_G];
                end
            end

            always @(posedge core_clk) begin
                if (ptc_l3i_fill) begin
                    ptc_l3i_tag_reg <= mmu_ptw_req_pa[(PALEN - 1):LSU_ADDR_LSB];
                    ptc_l3i_ppn <= lsu_rdata[PTE_PPN_MSB:PTE_PPN_LSB];
                end
            end

            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    ptc_l3d_g <= 1'b0;
                end
                else if (ptc_l3d_fill) begin
                    ptc_l3d_g <= lsu_rdata[PTE_G];
                end
            end

            always @(posedge core_clk) begin
                if (ptc_l3d_fill) begin
                    ptc_l3d_tag_reg <= mmu_ptw_req_pa[(PALEN - 1):LSU_ADDR_LSB];
                    ptc_l3d_ppn <= lsu_rdata[PTE_PPN_MSB:PTE_PPN_LSB];
                end
            end

            assign ptc_l3i_tag = ptc_l3i_tag_reg;
            assign ptc_l3i_rdata[PTE_V] = ptc_l3i_v;
            assign ptc_l3i_rdata[PTE_R] = 1'b0;
            assign ptc_l3i_rdata[PTE_W] = 1'b0;
            assign ptc_l3i_rdata[PTE_X] = 1'b0;
            assign ptc_l3i_rdata[PTE_U] = 1'b0;
            assign ptc_l3i_rdata[PTE_G] = ptc_l3i_g;
            assign ptc_l3i_rdata[PTE_A] = 1'b0;
            assign ptc_l3i_rdata[PTE_D] = 1'b0;
            assign ptc_l3i_rdata[PTE_RESERVED_MSB:PTE_RESERVED_LSB] = {(PTE_RESERVED_MSB - PTE_RESERVED_LSB + 1){1'b0}};
            kv_zero_ext #(
                .OW(PTE_MSB - PTE_PPN_LSB + 1),
                .IW(PALEN - 12)
            ) u_ptc_l3i_ppn_zext (
                .out(ptc_l3i_rdata[PTE_MSB:PTE_PPN_LSB]),
                .in(ptc_l3i_ppn)
            );
            assign ptc_l3d_tag = ptc_l3d_tag_reg;
            assign ptc_l3d_rdata[PTE_V] = ptc_l3d_v;
            assign ptc_l3d_rdata[PTE_R] = 1'b0;
            assign ptc_l3d_rdata[PTE_W] = 1'b0;
            assign ptc_l3d_rdata[PTE_X] = 1'b0;
            assign ptc_l3d_rdata[PTE_U] = 1'b0;
            assign ptc_l3d_rdata[PTE_G] = ptc_l3d_g;
            assign ptc_l3d_rdata[PTE_A] = 1'b0;
            assign ptc_l3d_rdata[PTE_D] = 1'b0;
            assign ptc_l3d_rdata[PTE_RESERVED_MSB:PTE_RESERVED_LSB] = {(PTE_RESERVED_MSB - PTE_RESERVED_LSB + 1){1'b0}};
            kv_zero_ext #(
                .OW(PTE_MSB - PTE_PPN_LSB + 1),
                .IW(PALEN - 12)
            ) u_ptc_l3d_ppn_zext (
                .out(ptc_l3d_rdata[PTE_MSB:PTE_PPN_LSB]),
                .in(ptc_l3d_ppn)
            );
        end
        else begin
            assign ptc_l3i_tag = {(PALEN - LSU_ADDR_LSB){1'b0}};
            assign ptc_l3i_rdata = {(PTE_MSB + 1){1'b0}};
            assign ptc_l3d_tag = {(PALEN - LSU_ADDR_LSB){1'b0}};
            assign ptc_l3d_rdata = {(PTE_MSB + 1){1'b0}};
        end
        assign ptc_pf_tag = {(PALEN - LSU_ADDR_LSB){1'b0}};
        assign ptc_pf_rdata = {(PTE_MSB + 1){1'b0}};
        wire nds_unused_ptc_pf_en = ptc_pf_en;
        wire [PTE_MSB:0] nds_unused_lsu_rdata_pf = lsu_rdata_pf;
        assign itlb_miss_data[ITLB_V_BIT] = stlb_itlb_g | (stlb_mask & ~csr_mmu_satp_we);
        assign itlb_miss_data[ITLB_X_BIT] = stlb_itlb_x;
        assign itlb_miss_data[ITLB_U_BIT] = stlb_itlb_u;
        assign itlb_miss_data[ITLB_G_BIT] = stlb_itlb_g;
        assign itlb_miss_data[ITLB_A_BIT] = stlb_itlb_a;
        assign itlb_miss_data[ITLB_PAGE_FAULT_BIT] = stlb_itlb_page_fault;
        assign itlb_miss_data[ITLB_PTW_ACCESS_FAULT_BIT] = stlb_itlb_access_fault;
        assign itlb_miss_data[ITLB_MDCAUSE_MSB:ITLB_MDCAUSE_LSB] = stlb_itlb_mdcause;
        assign itlb_miss_data[ITLB_ECC_CODE_MSB:ITLB_ECC_CODE_LSB] = stlb_itlb_ecc_code;
        assign itlb_miss_data[ITLB_ECC_CORR_BIT] = stlb_itlb_ecc_corr;
        assign itlb_miss_data[ITLB_ECC_RAMID_MSB:ITLB_ECC_RAMID_LSB] = stlb_itlb_ecc_ramid;
        assign itlb_miss_data[ITLB_PPN_MSB:ITLB_PPN_LSB] = stlb_itlb_ppn;
        assign dtlb_miss_data[DTLB_V_BIT] = stlb_dtlb_g | (stlb_mask & ~csr_mmu_satp_we);
        assign dtlb_miss_data[DTLB_R_BIT] = stlb_dtlb_r;
        assign dtlb_miss_data[DTLB_W_BIT] = stlb_dtlb_w;
        assign dtlb_miss_data[DTLB_X_BIT] = stlb_dtlb_x;
        assign dtlb_miss_data[DTLB_U_BIT] = stlb_dtlb_u;
        assign dtlb_miss_data[DTLB_G_BIT] = stlb_dtlb_g;
        assign dtlb_miss_data[DTLB_A_BIT] = stlb_dtlb_a;
        assign dtlb_miss_data[DTLB_D_BIT] = stlb_dtlb_d;
        assign dtlb_miss_data[DTLB_PAGE_FAULT_BIT] = stlb_dtlb_page_fault;
        assign dtlb_miss_data[DTLB_PTW_ACCESS_FAULT_BIT] = stlb_dtlb_access_fault;
        assign dtlb_miss_data[DTLB_MDCAUSE_MSB:DTLB_MDCAUSE_LSB] = stlb_dtlb_mdcause;
        assign dtlb_miss_data[DTLB_ECC_CODE_MSB:DTLB_ECC_CODE_LSB] = stlb_dtlb_ecc_code;
        assign dtlb_miss_data[DTLB_ECC_CORR_BIT] = stlb_dtlb_ecc_corr;
        assign dtlb_miss_data[DTLB_ECC_RAMID_MSB:DTLB_ECC_RAMID_LSB] = stlb_dtlb_ecc_ramid;
        assign dtlb_miss_data[DTLB_PPN_MSB:DTLB_PPN_LSB] = stlb_dtlb_ppn;
        reg [(STLB_SP_ENTRIES - 2):0] stlb_sp_lru_reg;
        wire stlb_sp_lru_en;
        wire [(STLB_SP_ENTRIES + 3):4] stlb_sp_lru_hit_temp = stlb_sp_fill ? stlb_victim[(STLB_SP_ENTRIES + 3):4] : stlb_sp_hit_vec[(STLB_SP_ENTRIES + 3):4];
        if (STLB_SP_ENTRIES >= 8) begin:gen_stlb_sp_lru_hit
            assign stlb_sp_lru_hit = stlb_sp_lru_hit_temp;
        end
        else begin:gen_stlb_sp_lru_hit_zext
            kv_zero_ext #(
                .OW(8),
                .IW(STLB_SP_ENTRIES)
            ) u_stlb_sp_lru_hit_zext (
                .out(stlb_sp_lru_hit),
                .in(stlb_sp_lru_hit_temp)
            );
        end
        assign stlb_sp_lru_en = stlb_req & (|stlb_sp_hit_vec) | stlb_sp_fill;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                stlb_sp_lru_reg <= {(STLB_SP_ENTRIES - 1){1'b0}};
            end
            else if (stlb_sp_lru_en) begin
                stlb_sp_lru_reg <= stlb_sp_lru_nx[(STLB_SP_ENTRIES - 2):0];
            end
        end

        kv_zero_ext #(
            .OW(7),
            .IW(STLB_SP_ENTRIES - 1)
        ) u_stlb_sp_lru_zext (
            .out(stlb_sp_lru),
            .in(stlb_sp_lru_reg)
        );
        if (STLB_SP_ENTRIES == 2) begin:gen_stlb_sp_lru2
            assign stlb_victim[4] = ~stlb_sp_lru[0];
            assign stlb_victim[5] = stlb_sp_lru[0];
            assign stlb_victim[11:6] = 6'b0;
            assign stlb_sp_lru_nx[0] = stlb_sp_lru_hit[0];
            assign stlb_sp_lru_nx[6:1] = 6'b0;
            wire [11:4] nds_unused_stlb_sp_replacement_vec = stlb_sp_replacement_vec;
            wire [11:4] nds_unused_stlb_sp_valid_vec = stlb_sp_valid_vec;
        end
        else if (STLB_SP_ENTRIES == 4) begin:gen_stlb_sp_lru4
            reg stlb_sp_lru_r;
            reg stlb_sp_modified_lru;
            wire [2:0] stlb_sp_lru_final;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb_sp_lru_r <= 1'b0;
                    stlb_sp_modified_lru <= 1'b0;
                end
                else if (|stlb_sp_replacement_vec) begin
                    stlb_sp_lru_r <= stlb_sp_lru[0];
                    stlb_sp_modified_lru <= (stlb_sp_lru_r ^~ stlb_sp_lru[0]);
                end
            end

            assign stlb_victim[4] = ~stlb_sp_lru_final[0] & ~stlb_sp_lru_final[1];
            assign stlb_victim[5] = ~stlb_sp_lru_final[0] & stlb_sp_lru_final[1];
            assign stlb_victim[6] = stlb_sp_lru_final[0] & ~stlb_sp_lru_final[2];
            assign stlb_victim[7] = stlb_sp_lru_final[0] & stlb_sp_lru_final[2];
            assign stlb_victim[11:8] = 4'b0;
            assign stlb_sp_lru_final[0] = (stlb_sp_lru[0] & ~(&stlb_sp_valid_vec[7:6])) | (stlb_sp_lru[0] & (&stlb_sp_valid_vec[5:4])) | ((&stlb_sp_valid_vec[5:4]) & ~(&stlb_sp_valid_vec[7:6]));
            assign stlb_sp_lru_final[1] = (stlb_sp_lru[1] & ~(stlb_sp_valid_vec[5])) | (stlb_sp_lru[1] & (stlb_sp_valid_vec[4])) | ((stlb_sp_valid_vec[4]) & ~(stlb_sp_valid_vec[5]));
            assign stlb_sp_lru_final[2] = (stlb_sp_lru[2] & ~(stlb_sp_valid_vec[7])) | (stlb_sp_lru[2] & (stlb_sp_valid_vec[6])) | ((stlb_sp_valid_vec[6]) & ~(stlb_sp_valid_vec[7]));
            assign stlb_sp_lru_nx[0] = stlb_sp_modified_lru ? ~stlb_sp_lru[0] : |stlb_sp_lru_hit[1:0];
            assign stlb_sp_lru_nx[1] = |stlb_sp_lru_hit[1:0] ? |stlb_sp_lru_hit[0] : stlb_sp_lru[1];
            assign stlb_sp_lru_nx[2] = |stlb_sp_lru_hit[3:2] ? |stlb_sp_lru_hit[2] : stlb_sp_lru[2];
            assign stlb_sp_lru_nx[6:3] = 4'b0;
        end
        else if (STLB_SP_ENTRIES == 8) begin:gen_stlb_sp_lru8
            reg [2:0] stlb_sp_lru_r;
            reg [2:0] stlb_sp_modified_lru;
            wire [6:0] stlb_sp_lru_final;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb_sp_lru_r <= 3'b0;
                    stlb_sp_modified_lru <= 3'b0;
                end
                else if (|stlb_sp_replacement_vec) begin
                    stlb_sp_lru_r[0] <= stlb_sp_lru[0];
                    if (|stlb_sp_replacement_vec[7:4]) begin
                        stlb_sp_lru_r[1] <= stlb_sp_lru[1];
                    end
                    if (|stlb_sp_replacement_vec[11:8]) begin
                        stlb_sp_lru_r[2] <= stlb_sp_lru[2];
                    end
                    stlb_sp_modified_lru <= (stlb_sp_lru_r ^~ stlb_sp_lru[2:0]);
                end
            end

            assign stlb_victim[4] = ~stlb_sp_lru_final[0] & ~stlb_sp_lru_final[1] & ~stlb_sp_lru_final[3];
            assign stlb_victim[5] = ~stlb_sp_lru_final[0] & ~stlb_sp_lru_final[1] & stlb_sp_lru_final[3];
            assign stlb_victim[6] = ~stlb_sp_lru_final[0] & stlb_sp_lru_final[1] & ~stlb_sp_lru_final[4];
            assign stlb_victim[7] = ~stlb_sp_lru_final[0] & stlb_sp_lru_final[1] & stlb_sp_lru_final[4];
            assign stlb_victim[8] = stlb_sp_lru_final[0] & ~stlb_sp_lru_final[2] & ~stlb_sp_lru_final[5];
            assign stlb_victim[9] = stlb_sp_lru_final[0] & ~stlb_sp_lru_final[2] & stlb_sp_lru_final[5];
            assign stlb_victim[10] = stlb_sp_lru_final[0] & stlb_sp_lru_final[2] & ~stlb_sp_lru_final[6];
            assign stlb_victim[11] = stlb_sp_lru_final[0] & stlb_sp_lru_final[2] & stlb_sp_lru_final[6];
            assign stlb_sp_lru_final[0] = (stlb_sp_lru[0] & ~(&stlb_sp_valid_vec[11:8])) | (stlb_sp_lru[0] & (&stlb_sp_valid_vec[7:4])) | ((&stlb_sp_valid_vec[7:4]) & ~(&stlb_sp_valid_vec[11:8]));
            assign stlb_sp_lru_final[1] = (stlb_sp_lru[1] & ~(&stlb_sp_valid_vec[7:6])) | (stlb_sp_lru[1] & (&stlb_sp_valid_vec[5:4])) | ((&stlb_sp_valid_vec[5:4]) & ~(&stlb_sp_valid_vec[7:6]));
            assign stlb_sp_lru_final[2] = (stlb_sp_lru[2] & ~(&stlb_sp_valid_vec[11:10])) | (stlb_sp_lru[2] & (&stlb_sp_valid_vec[9:8])) | ((&stlb_sp_valid_vec[9:8]) & ~(&stlb_sp_valid_vec[11:10]));
            assign stlb_sp_lru_final[3] = (stlb_sp_lru[3] & ~(stlb_sp_valid_vec[5])) | (stlb_sp_lru[3] & (stlb_sp_valid_vec[4])) | ((stlb_sp_valid_vec[4]) & ~(stlb_sp_valid_vec[5]));
            assign stlb_sp_lru_final[4] = (stlb_sp_lru[4] & ~(stlb_sp_valid_vec[7])) | (stlb_sp_lru[4] & (stlb_sp_valid_vec[6])) | ((stlb_sp_valid_vec[6]) & ~(stlb_sp_valid_vec[7]));
            assign stlb_sp_lru_final[5] = (stlb_sp_lru[5] & ~(stlb_sp_valid_vec[9])) | (stlb_sp_lru[5] & (stlb_sp_valid_vec[8])) | ((stlb_sp_valid_vec[8]) & ~(stlb_sp_valid_vec[9]));
            assign stlb_sp_lru_final[6] = (stlb_sp_lru[6] & ~(stlb_sp_valid_vec[11])) | (stlb_sp_lru[6] & (stlb_sp_valid_vec[10])) | ((stlb_sp_valid_vec[10]) & ~(stlb_sp_valid_vec[11]));
            assign stlb_sp_lru_nx[0] = stlb_sp_modified_lru[0] ? ~stlb_sp_lru[0] : |stlb_sp_lru_hit[3:0];
            assign stlb_sp_lru_nx[1] = stlb_sp_modified_lru[1] ? ~stlb_sp_lru[1] : |stlb_sp_lru_hit[3:0] ? |stlb_sp_lru_hit[1:0] : stlb_sp_lru[1];
            assign stlb_sp_lru_nx[2] = stlb_sp_modified_lru[2] ? ~stlb_sp_lru[2] : |stlb_sp_lru_hit[7:4] ? |stlb_sp_lru_hit[5:4] : stlb_sp_lru[2];
            assign stlb_sp_lru_nx[3] = |stlb_sp_lru_hit[1:0] ? stlb_sp_lru_hit[0] : stlb_sp_lru[3];
            assign stlb_sp_lru_nx[4] = |stlb_sp_lru_hit[3:2] ? stlb_sp_lru_hit[2] : stlb_sp_lru[4];
            assign stlb_sp_lru_nx[5] = |stlb_sp_lru_hit[5:4] ? stlb_sp_lru_hit[4] : stlb_sp_lru[5];
            assign stlb_sp_lru_nx[6] = |stlb_sp_lru_hit[7:6] ? stlb_sp_lru_hit[6] : stlb_sp_lru[6];
        end
        else begin:gen_stlb_sp_lru_nx_disabled
            assign stlb_sp_lru_nx = 7'b0;
        end
        if (4 < (STLB_SP_ENTRIES + 4)) begin:gen_stlb4
            reg stlb4_valid_reg;
            wire stlb4_valid_nx;
            wire stlb4_valid_en;
            wire stlb4_en;
            reg [(VALEN - 1):VPN1_LSB] stlb4_vpn_reg;
            reg [(PALEN - 1):VPN1_LSB] stlb4_ppn_reg;
            reg [(ASID_LEN - 1):0] stlb4_asid_reg;
            reg stlb4_d_reg;
            reg stlb4_a_reg;
            reg stlb4_g_reg;
            reg stlb4_u_reg;
            reg stlb4_x_reg;
            reg stlb4_w_reg;
            reg stlb4_r_reg;
            reg stlb4_v_reg;
            reg [1:0] stlb4_ps_reg;
            wire [48:12] stlb4_vpn;
            wire check_vpn1;
            wire check_vpn2;
            wire check_vpn3;
            assign stlb4_valid_en = (stlb_sp_fill & stlb_victim[4]) | sfence_flush[4];
            assign stlb4_valid_nx = sfence_flush[4] ? 1'b0 : 1'b1;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb4_valid_reg <= 1'b0;
                end
                else if (stlb4_valid_en) begin
                    stlb4_valid_reg <= stlb4_valid_nx;
                end
            end

            assign stlb4_en = stlb_sp_fill & stlb_victim[4];
            always @(posedge core_clk) begin
                if (stlb4_en) begin
                    stlb4_vpn_reg <= stlb_sp_wdata[STLB_VPN_MSB:STLB_VPN1_LSB];
                    stlb4_ppn_reg <= stlb_sp_wdata[STLB_PPN_MSB:STLB_PPN1_LSB];
                    stlb4_asid_reg <= stlb_sp_wdata[STLB_ASID_MSB:STLB_ASID_LSB];
                end
            end

            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb4_d_reg <= 1'b0;
                    stlb4_a_reg <= 1'b0;
                    stlb4_g_reg <= 1'b0;
                    stlb4_u_reg <= 1'b0;
                    stlb4_x_reg <= 1'b0;
                    stlb4_w_reg <= 1'b0;
                    stlb4_r_reg <= 1'b0;
                    stlb4_v_reg <= 1'b0;
                    stlb4_ps_reg <= 2'b0;
                end
                else if (stlb4_en) begin
                    stlb4_d_reg <= stlb_sp_wdata[STLB_D_BIT];
                    stlb4_a_reg <= stlb_sp_wdata[STLB_A_BIT];
                    stlb4_g_reg <= stlb_sp_wdata[STLB_G_BIT];
                    stlb4_u_reg <= stlb_sp_wdata[STLB_U_BIT];
                    stlb4_x_reg <= stlb_sp_wdata[STLB_X_BIT];
                    stlb4_w_reg <= stlb_sp_wdata[STLB_W_BIT];
                    stlb4_r_reg <= stlb_sp_wdata[STLB_R_BIT];
                    stlb4_v_reg <= stlb_sp_wdata[STLB_V_BIT];
                    stlb4_ps_reg <= ptw_ps;
                end
            end

            assign stlb4_vpn = {{(49 - VALEN){1'b0}},stlb4_vpn_reg,{(VPN0_MSB - VPN0_LSB + 1){1'b0}}};
            assign stlb4_ps = ((MMU_SCHEME_INT == 1)) ? MEGAPAGE : ((MMU_SCHEME_INT == 2)) ? (stlb4_ps_reg[1] ? GIGAPAGE : MEGAPAGE) : stlb4_ps_reg;
            if ((MMU_SCHEME_INT == 1)) begin:gen_nds_unused_stlb4_ps_reg
                wire [1:0] nds_unused_stlb4_ps_reg = stlb4_ps_reg;
            end
            assign check_vpn1 = check_vpn & (stlb4_ps == MEGAPAGE);
            assign check_vpn2 = check_vpn & GIGAPAGE_EXIST & ((stlb4_ps == MEGAPAGE) | (stlb4_ps == GIGAPAGE));
            assign check_vpn3 = check_vpn & TERAPAGE_EXIST;
            assign stlb_sp_hit_vec[4] = stlb4_valid_reg & ~(keep_global_page & stlb4_g_reg) & (~check_asid | stlb4_g_reg | (stlb4_asid_reg == service_asid)) & (~check_vpn1 | (stlb4_vpn[VPN1_MSB:VPN1_LSB] == service_vpn[VPN1_MSB:VPN1_LSB])) & (~check_vpn2 | (stlb4_vpn[VPN2_MSB:VPN2_LSB] == service_vpn[VPN2_MSB:VPN2_LSB])) & (~check_vpn3 | (stlb4_vpn[VPN3_MSB:VPN3_LSB] == service_vpn[VPN3_MSB:VPN3_LSB]));
            assign stlb_sp_valid_vec[4] = stlb4_valid_reg;
            assign stlb_sp_replacement_vec[4] = stlb4_valid_en & stlb4_valid_reg;
            assign stlb4_rdata[STLB_VPN_MSB:STLB_VPN_LSB] = {stlb4_vpn_reg,{(VPN1_LSB - VPN0_LSB - STLB_RAM_AW){1'b0}}};
            assign stlb4_rdata[STLB_ASID_MSB:STLB_ASID_LSB] = stlb4_asid_reg;
            assign stlb4_rdata[STLB_VALID] = stlb4_valid_reg;
            assign stlb4_rdata[STLB_PPN_MSB:STLB_PPN_LSB] = {stlb4_ppn_reg,{(VPN1_LSB - VPN0_LSB){1'b0}}};
            assign stlb4_rdata[STLB_D_BIT] = stlb4_d_reg;
            assign stlb4_rdata[STLB_A_BIT] = stlb4_a_reg;
            assign stlb4_rdata[STLB_G_BIT] = stlb4_g_reg;
            assign stlb4_rdata[STLB_U_BIT] = stlb4_u_reg;
            assign stlb4_rdata[STLB_X_BIT] = stlb4_x_reg;
            assign stlb4_rdata[STLB_W_BIT] = stlb4_w_reg;
            assign stlb4_rdata[STLB_R_BIT] = stlb4_r_reg;
            assign stlb4_rdata[STLB_V_BIT] = stlb4_v_reg;
        end
        else begin:gen_stlb4_disabled
            assign stlb4_rdata = {STLB_REG_DW{1'b0}};
            assign stlb4_ps = 2'b0;
            assign stlb_sp_hit_vec[4] = 1'b0;
            assign stlb_sp_valid_vec[4] = 1'b0;
            assign stlb_sp_replacement_vec[4] = 1'b0;
        end
        if (5 < (STLB_SP_ENTRIES + 4)) begin:gen_stlb5
            reg stlb5_valid_reg;
            wire stlb5_valid_nx;
            wire stlb5_valid_en;
            wire stlb5_en;
            reg [(VALEN - 1):VPN1_LSB] stlb5_vpn_reg;
            reg [(PALEN - 1):VPN1_LSB] stlb5_ppn_reg;
            reg [(ASID_LEN - 1):0] stlb5_asid_reg;
            reg stlb5_d_reg;
            reg stlb5_a_reg;
            reg stlb5_g_reg;
            reg stlb5_u_reg;
            reg stlb5_x_reg;
            reg stlb5_w_reg;
            reg stlb5_r_reg;
            reg stlb5_v_reg;
            reg [1:0] stlb5_ps_reg;
            wire [48:12] stlb5_vpn;
            wire check_vpn1;
            wire check_vpn2;
            wire check_vpn3;
            assign stlb5_valid_en = (stlb_sp_fill & stlb_victim[5]) | sfence_flush[5];
            assign stlb5_valid_nx = sfence_flush[5] ? 1'b0 : 1'b1;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb5_valid_reg <= 1'b0;
                end
                else if (stlb5_valid_en) begin
                    stlb5_valid_reg <= stlb5_valid_nx;
                end
            end

            assign stlb5_en = stlb_sp_fill & stlb_victim[5];
            always @(posedge core_clk) begin
                if (stlb5_en) begin
                    stlb5_vpn_reg <= stlb_sp_wdata[STLB_VPN_MSB:STLB_VPN1_LSB];
                    stlb5_ppn_reg <= stlb_sp_wdata[STLB_PPN_MSB:STLB_PPN1_LSB];
                    stlb5_asid_reg <= stlb_sp_wdata[STLB_ASID_MSB:STLB_ASID_LSB];
                end
            end

            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb5_d_reg <= 1'b0;
                    stlb5_a_reg <= 1'b0;
                    stlb5_g_reg <= 1'b0;
                    stlb5_u_reg <= 1'b0;
                    stlb5_x_reg <= 1'b0;
                    stlb5_w_reg <= 1'b0;
                    stlb5_r_reg <= 1'b0;
                    stlb5_v_reg <= 1'b0;
                    stlb5_ps_reg <= 2'b0;
                end
                else if (stlb5_en) begin
                    stlb5_d_reg <= stlb_sp_wdata[STLB_D_BIT];
                    stlb5_a_reg <= stlb_sp_wdata[STLB_A_BIT];
                    stlb5_g_reg <= stlb_sp_wdata[STLB_G_BIT];
                    stlb5_u_reg <= stlb_sp_wdata[STLB_U_BIT];
                    stlb5_x_reg <= stlb_sp_wdata[STLB_X_BIT];
                    stlb5_w_reg <= stlb_sp_wdata[STLB_W_BIT];
                    stlb5_r_reg <= stlb_sp_wdata[STLB_R_BIT];
                    stlb5_v_reg <= stlb_sp_wdata[STLB_V_BIT];
                    stlb5_ps_reg <= ptw_ps;
                end
            end

            assign stlb5_vpn = {{(49 - VALEN){1'b0}},stlb5_vpn_reg,{(VPN0_MSB - VPN0_LSB + 1){1'b0}}};
            assign stlb5_ps = ((MMU_SCHEME_INT == 1)) ? MEGAPAGE : ((MMU_SCHEME_INT == 2)) ? (stlb5_ps_reg[1] ? GIGAPAGE : MEGAPAGE) : stlb5_ps_reg;
            if ((MMU_SCHEME_INT == 1)) begin:gen_nds_unused_stlb5_ps_reg
                wire [1:0] nds_unused_stlb5_ps_reg = stlb5_ps_reg;
            end
            assign check_vpn1 = check_vpn & (stlb5_ps == MEGAPAGE);
            assign check_vpn2 = check_vpn & GIGAPAGE_EXIST & ((stlb5_ps == MEGAPAGE) | (stlb5_ps == GIGAPAGE));
            assign check_vpn3 = check_vpn & TERAPAGE_EXIST;
            assign stlb_sp_hit_vec[5] = stlb5_valid_reg & ~(keep_global_page & stlb5_g_reg) & (~check_asid | stlb5_g_reg | (stlb5_asid_reg == service_asid)) & (~check_vpn1 | (stlb5_vpn[VPN1_MSB:VPN1_LSB] == service_vpn[VPN1_MSB:VPN1_LSB])) & (~check_vpn2 | (stlb5_vpn[VPN2_MSB:VPN2_LSB] == service_vpn[VPN2_MSB:VPN2_LSB])) & (~check_vpn3 | (stlb5_vpn[VPN3_MSB:VPN3_LSB] == service_vpn[VPN3_MSB:VPN3_LSB]));
            assign stlb_sp_valid_vec[5] = stlb5_valid_reg;
            assign stlb_sp_replacement_vec[5] = stlb5_valid_en & stlb5_valid_reg;
            assign stlb5_rdata[STLB_VPN_MSB:STLB_VPN_LSB] = {stlb5_vpn_reg,{(VPN1_LSB - VPN0_LSB - STLB_RAM_AW){1'b0}}};
            assign stlb5_rdata[STLB_ASID_MSB:STLB_ASID_LSB] = stlb5_asid_reg;
            assign stlb5_rdata[STLB_VALID] = stlb5_valid_reg;
            assign stlb5_rdata[STLB_PPN_MSB:STLB_PPN_LSB] = {stlb5_ppn_reg,{(VPN1_LSB - VPN0_LSB){1'b0}}};
            assign stlb5_rdata[STLB_D_BIT] = stlb5_d_reg;
            assign stlb5_rdata[STLB_A_BIT] = stlb5_a_reg;
            assign stlb5_rdata[STLB_G_BIT] = stlb5_g_reg;
            assign stlb5_rdata[STLB_U_BIT] = stlb5_u_reg;
            assign stlb5_rdata[STLB_X_BIT] = stlb5_x_reg;
            assign stlb5_rdata[STLB_W_BIT] = stlb5_w_reg;
            assign stlb5_rdata[STLB_R_BIT] = stlb5_r_reg;
            assign stlb5_rdata[STLB_V_BIT] = stlb5_v_reg;
        end
        else begin:gen_stlb5_disabled
            assign stlb5_rdata = {STLB_REG_DW{1'b0}};
            assign stlb5_ps = 2'b0;
            assign stlb_sp_hit_vec[5] = 1'b0;
            assign stlb_sp_valid_vec[5] = 1'b0;
            assign stlb_sp_replacement_vec[5] = 1'b0;
        end
        if (6 < (STLB_SP_ENTRIES + 4)) begin:gen_stlb6
            reg stlb6_valid_reg;
            wire stlb6_valid_nx;
            wire stlb6_valid_en;
            wire stlb6_en;
            reg [(VALEN - 1):VPN1_LSB] stlb6_vpn_reg;
            reg [(PALEN - 1):VPN1_LSB] stlb6_ppn_reg;
            reg [(ASID_LEN - 1):0] stlb6_asid_reg;
            reg stlb6_d_reg;
            reg stlb6_a_reg;
            reg stlb6_g_reg;
            reg stlb6_u_reg;
            reg stlb6_x_reg;
            reg stlb6_w_reg;
            reg stlb6_r_reg;
            reg stlb6_v_reg;
            reg [1:0] stlb6_ps_reg;
            wire [48:12] stlb6_vpn;
            wire check_vpn1;
            wire check_vpn2;
            wire check_vpn3;
            assign stlb6_valid_en = (stlb_sp_fill & stlb_victim[6]) | sfence_flush[6];
            assign stlb6_valid_nx = sfence_flush[6] ? 1'b0 : 1'b1;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb6_valid_reg <= 1'b0;
                end
                else if (stlb6_valid_en) begin
                    stlb6_valid_reg <= stlb6_valid_nx;
                end
            end

            assign stlb6_en = stlb_sp_fill & stlb_victim[6];
            always @(posedge core_clk) begin
                if (stlb6_en) begin
                    stlb6_vpn_reg <= stlb_sp_wdata[STLB_VPN_MSB:STLB_VPN1_LSB];
                    stlb6_ppn_reg <= stlb_sp_wdata[STLB_PPN_MSB:STLB_PPN1_LSB];
                    stlb6_asid_reg <= stlb_sp_wdata[STLB_ASID_MSB:STLB_ASID_LSB];
                end
            end

            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb6_d_reg <= 1'b0;
                    stlb6_a_reg <= 1'b0;
                    stlb6_g_reg <= 1'b0;
                    stlb6_u_reg <= 1'b0;
                    stlb6_x_reg <= 1'b0;
                    stlb6_w_reg <= 1'b0;
                    stlb6_r_reg <= 1'b0;
                    stlb6_v_reg <= 1'b0;
                    stlb6_ps_reg <= 2'b0;
                end
                else if (stlb6_en) begin
                    stlb6_d_reg <= stlb_sp_wdata[STLB_D_BIT];
                    stlb6_a_reg <= stlb_sp_wdata[STLB_A_BIT];
                    stlb6_g_reg <= stlb_sp_wdata[STLB_G_BIT];
                    stlb6_u_reg <= stlb_sp_wdata[STLB_U_BIT];
                    stlb6_x_reg <= stlb_sp_wdata[STLB_X_BIT];
                    stlb6_w_reg <= stlb_sp_wdata[STLB_W_BIT];
                    stlb6_r_reg <= stlb_sp_wdata[STLB_R_BIT];
                    stlb6_v_reg <= stlb_sp_wdata[STLB_V_BIT];
                    stlb6_ps_reg <= ptw_ps;
                end
            end

            assign stlb6_vpn = {{(49 - VALEN){1'b0}},stlb6_vpn_reg,{(VPN0_MSB - VPN0_LSB + 1){1'b0}}};
            assign stlb6_ps = ((MMU_SCHEME_INT == 1)) ? MEGAPAGE : ((MMU_SCHEME_INT == 2)) ? (stlb6_ps_reg[1] ? GIGAPAGE : MEGAPAGE) : stlb6_ps_reg;
            if ((MMU_SCHEME_INT == 1)) begin:gen_nds_unused_stlb6_ps_reg
                wire [1:0] nds_unused_stlb6_ps_reg = stlb6_ps_reg;
            end
            assign check_vpn1 = check_vpn & (stlb6_ps == MEGAPAGE);
            assign check_vpn2 = check_vpn & GIGAPAGE_EXIST & ((stlb6_ps == MEGAPAGE) | (stlb6_ps == GIGAPAGE));
            assign check_vpn3 = check_vpn & TERAPAGE_EXIST;
            assign stlb_sp_hit_vec[6] = stlb6_valid_reg & ~(keep_global_page & stlb6_g_reg) & (~check_asid | stlb6_g_reg | (stlb6_asid_reg == service_asid)) & (~check_vpn1 | (stlb6_vpn[VPN1_MSB:VPN1_LSB] == service_vpn[VPN1_MSB:VPN1_LSB])) & (~check_vpn2 | (stlb6_vpn[VPN2_MSB:VPN2_LSB] == service_vpn[VPN2_MSB:VPN2_LSB])) & (~check_vpn3 | (stlb6_vpn[VPN3_MSB:VPN3_LSB] == service_vpn[VPN3_MSB:VPN3_LSB]));
            assign stlb_sp_valid_vec[6] = stlb6_valid_reg;
            assign stlb_sp_replacement_vec[6] = stlb6_valid_en & stlb6_valid_reg;
            assign stlb6_rdata[STLB_VPN_MSB:STLB_VPN_LSB] = {stlb6_vpn_reg,{(VPN1_LSB - VPN0_LSB - STLB_RAM_AW){1'b0}}};
            assign stlb6_rdata[STLB_ASID_MSB:STLB_ASID_LSB] = stlb6_asid_reg;
            assign stlb6_rdata[STLB_VALID] = stlb6_valid_reg;
            assign stlb6_rdata[STLB_PPN_MSB:STLB_PPN_LSB] = {stlb6_ppn_reg,{(VPN1_LSB - VPN0_LSB){1'b0}}};
            assign stlb6_rdata[STLB_D_BIT] = stlb6_d_reg;
            assign stlb6_rdata[STLB_A_BIT] = stlb6_a_reg;
            assign stlb6_rdata[STLB_G_BIT] = stlb6_g_reg;
            assign stlb6_rdata[STLB_U_BIT] = stlb6_u_reg;
            assign stlb6_rdata[STLB_X_BIT] = stlb6_x_reg;
            assign stlb6_rdata[STLB_W_BIT] = stlb6_w_reg;
            assign stlb6_rdata[STLB_R_BIT] = stlb6_r_reg;
            assign stlb6_rdata[STLB_V_BIT] = stlb6_v_reg;
        end
        else begin:gen_stlb6_disabled
            assign stlb6_rdata = {STLB_REG_DW{1'b0}};
            assign stlb6_ps = 2'b0;
            assign stlb_sp_hit_vec[6] = 1'b0;
            assign stlb_sp_valid_vec[6] = 1'b0;
            assign stlb_sp_replacement_vec[6] = 1'b0;
        end
        if (7 < (STLB_SP_ENTRIES + 4)) begin:gen_stlb7
            reg stlb7_valid_reg;
            wire stlb7_valid_nx;
            wire stlb7_valid_en;
            wire stlb7_en;
            reg [(VALEN - 1):VPN1_LSB] stlb7_vpn_reg;
            reg [(PALEN - 1):VPN1_LSB] stlb7_ppn_reg;
            reg [(ASID_LEN - 1):0] stlb7_asid_reg;
            reg stlb7_d_reg;
            reg stlb7_a_reg;
            reg stlb7_g_reg;
            reg stlb7_u_reg;
            reg stlb7_x_reg;
            reg stlb7_w_reg;
            reg stlb7_r_reg;
            reg stlb7_v_reg;
            reg [1:0] stlb7_ps_reg;
            wire [48:12] stlb7_vpn;
            wire check_vpn1;
            wire check_vpn2;
            wire check_vpn3;
            assign stlb7_valid_en = (stlb_sp_fill & stlb_victim[7]) | sfence_flush[7];
            assign stlb7_valid_nx = sfence_flush[7] ? 1'b0 : 1'b1;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb7_valid_reg <= 1'b0;
                end
                else if (stlb7_valid_en) begin
                    stlb7_valid_reg <= stlb7_valid_nx;
                end
            end

            assign stlb7_en = stlb_sp_fill & stlb_victim[7];
            always @(posedge core_clk) begin
                if (stlb7_en) begin
                    stlb7_vpn_reg <= stlb_sp_wdata[STLB_VPN_MSB:STLB_VPN1_LSB];
                    stlb7_ppn_reg <= stlb_sp_wdata[STLB_PPN_MSB:STLB_PPN1_LSB];
                    stlb7_asid_reg <= stlb_sp_wdata[STLB_ASID_MSB:STLB_ASID_LSB];
                end
            end

            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb7_d_reg <= 1'b0;
                    stlb7_a_reg <= 1'b0;
                    stlb7_g_reg <= 1'b0;
                    stlb7_u_reg <= 1'b0;
                    stlb7_x_reg <= 1'b0;
                    stlb7_w_reg <= 1'b0;
                    stlb7_r_reg <= 1'b0;
                    stlb7_v_reg <= 1'b0;
                    stlb7_ps_reg <= 2'b0;
                end
                else if (stlb7_en) begin
                    stlb7_d_reg <= stlb_sp_wdata[STLB_D_BIT];
                    stlb7_a_reg <= stlb_sp_wdata[STLB_A_BIT];
                    stlb7_g_reg <= stlb_sp_wdata[STLB_G_BIT];
                    stlb7_u_reg <= stlb_sp_wdata[STLB_U_BIT];
                    stlb7_x_reg <= stlb_sp_wdata[STLB_X_BIT];
                    stlb7_w_reg <= stlb_sp_wdata[STLB_W_BIT];
                    stlb7_r_reg <= stlb_sp_wdata[STLB_R_BIT];
                    stlb7_v_reg <= stlb_sp_wdata[STLB_V_BIT];
                    stlb7_ps_reg <= ptw_ps;
                end
            end

            assign stlb7_vpn = {{(49 - VALEN){1'b0}},stlb7_vpn_reg,{(VPN0_MSB - VPN0_LSB + 1){1'b0}}};
            assign stlb7_ps = ((MMU_SCHEME_INT == 1)) ? MEGAPAGE : ((MMU_SCHEME_INT == 2)) ? (stlb7_ps_reg[1] ? GIGAPAGE : MEGAPAGE) : stlb7_ps_reg;
            if ((MMU_SCHEME_INT == 1)) begin:gen_nds_unused_stlb7_ps_reg
                wire [1:0] nds_unused_stlb7_ps_reg = stlb7_ps_reg;
            end
            assign check_vpn1 = check_vpn & (stlb7_ps == MEGAPAGE);
            assign check_vpn2 = check_vpn & GIGAPAGE_EXIST & ((stlb7_ps == MEGAPAGE) | (stlb7_ps == GIGAPAGE));
            assign check_vpn3 = check_vpn & TERAPAGE_EXIST;
            assign stlb_sp_hit_vec[7] = stlb7_valid_reg & ~(keep_global_page & stlb7_g_reg) & (~check_asid | stlb7_g_reg | (stlb7_asid_reg == service_asid)) & (~check_vpn1 | (stlb7_vpn[VPN1_MSB:VPN1_LSB] == service_vpn[VPN1_MSB:VPN1_LSB])) & (~check_vpn2 | (stlb7_vpn[VPN2_MSB:VPN2_LSB] == service_vpn[VPN2_MSB:VPN2_LSB])) & (~check_vpn3 | (stlb7_vpn[VPN3_MSB:VPN3_LSB] == service_vpn[VPN3_MSB:VPN3_LSB]));
            assign stlb_sp_valid_vec[7] = stlb7_valid_reg;
            assign stlb_sp_replacement_vec[7] = stlb7_valid_en & stlb7_valid_reg;
            assign stlb7_rdata[STLB_VPN_MSB:STLB_VPN_LSB] = {stlb7_vpn_reg,{(VPN1_LSB - VPN0_LSB - STLB_RAM_AW){1'b0}}};
            assign stlb7_rdata[STLB_ASID_MSB:STLB_ASID_LSB] = stlb7_asid_reg;
            assign stlb7_rdata[STLB_VALID] = stlb7_valid_reg;
            assign stlb7_rdata[STLB_PPN_MSB:STLB_PPN_LSB] = {stlb7_ppn_reg,{(VPN1_LSB - VPN0_LSB){1'b0}}};
            assign stlb7_rdata[STLB_D_BIT] = stlb7_d_reg;
            assign stlb7_rdata[STLB_A_BIT] = stlb7_a_reg;
            assign stlb7_rdata[STLB_G_BIT] = stlb7_g_reg;
            assign stlb7_rdata[STLB_U_BIT] = stlb7_u_reg;
            assign stlb7_rdata[STLB_X_BIT] = stlb7_x_reg;
            assign stlb7_rdata[STLB_W_BIT] = stlb7_w_reg;
            assign stlb7_rdata[STLB_R_BIT] = stlb7_r_reg;
            assign stlb7_rdata[STLB_V_BIT] = stlb7_v_reg;
        end
        else begin:gen_stlb7_disabled
            assign stlb7_rdata = {STLB_REG_DW{1'b0}};
            assign stlb7_ps = 2'b0;
            assign stlb_sp_hit_vec[7] = 1'b0;
            assign stlb_sp_valid_vec[7] = 1'b0;
            assign stlb_sp_replacement_vec[7] = 1'b0;
        end
        if (8 < (STLB_SP_ENTRIES + 4)) begin:gen_stlb8
            reg stlb8_valid_reg;
            wire stlb8_valid_nx;
            wire stlb8_valid_en;
            wire stlb8_en;
            reg [(VALEN - 1):VPN1_LSB] stlb8_vpn_reg;
            reg [(PALEN - 1):VPN1_LSB] stlb8_ppn_reg;
            reg [(ASID_LEN - 1):0] stlb8_asid_reg;
            reg stlb8_d_reg;
            reg stlb8_a_reg;
            reg stlb8_g_reg;
            reg stlb8_u_reg;
            reg stlb8_x_reg;
            reg stlb8_w_reg;
            reg stlb8_r_reg;
            reg stlb8_v_reg;
            reg [1:0] stlb8_ps_reg;
            wire [48:12] stlb8_vpn;
            wire check_vpn1;
            wire check_vpn2;
            wire check_vpn3;
            assign stlb8_valid_en = (stlb_sp_fill & stlb_victim[8]) | sfence_flush[8];
            assign stlb8_valid_nx = sfence_flush[8] ? 1'b0 : 1'b1;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb8_valid_reg <= 1'b0;
                end
                else if (stlb8_valid_en) begin
                    stlb8_valid_reg <= stlb8_valid_nx;
                end
            end

            assign stlb8_en = stlb_sp_fill & stlb_victim[8];
            always @(posedge core_clk) begin
                if (stlb8_en) begin
                    stlb8_vpn_reg <= stlb_sp_wdata[STLB_VPN_MSB:STLB_VPN1_LSB];
                    stlb8_ppn_reg <= stlb_sp_wdata[STLB_PPN_MSB:STLB_PPN1_LSB];
                    stlb8_asid_reg <= stlb_sp_wdata[STLB_ASID_MSB:STLB_ASID_LSB];
                end
            end

            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb8_d_reg <= 1'b0;
                    stlb8_a_reg <= 1'b0;
                    stlb8_g_reg <= 1'b0;
                    stlb8_u_reg <= 1'b0;
                    stlb8_x_reg <= 1'b0;
                    stlb8_w_reg <= 1'b0;
                    stlb8_r_reg <= 1'b0;
                    stlb8_v_reg <= 1'b0;
                    stlb8_ps_reg <= 2'b0;
                end
                else if (stlb8_en) begin
                    stlb8_d_reg <= stlb_sp_wdata[STLB_D_BIT];
                    stlb8_a_reg <= stlb_sp_wdata[STLB_A_BIT];
                    stlb8_g_reg <= stlb_sp_wdata[STLB_G_BIT];
                    stlb8_u_reg <= stlb_sp_wdata[STLB_U_BIT];
                    stlb8_x_reg <= stlb_sp_wdata[STLB_X_BIT];
                    stlb8_w_reg <= stlb_sp_wdata[STLB_W_BIT];
                    stlb8_r_reg <= stlb_sp_wdata[STLB_R_BIT];
                    stlb8_v_reg <= stlb_sp_wdata[STLB_V_BIT];
                    stlb8_ps_reg <= ptw_ps;
                end
            end

            assign stlb8_vpn = {{(49 - VALEN){1'b0}},stlb8_vpn_reg,{(VPN0_MSB - VPN0_LSB + 1){1'b0}}};
            assign stlb8_ps = ((MMU_SCHEME_INT == 1)) ? MEGAPAGE : ((MMU_SCHEME_INT == 2)) ? (stlb8_ps_reg[1] ? GIGAPAGE : MEGAPAGE) : stlb8_ps_reg;
            if ((MMU_SCHEME_INT == 1)) begin:gen_nds_unused_stlb8_ps_reg
                wire [1:0] nds_unused_stlb8_ps_reg = stlb8_ps_reg;
            end
            assign check_vpn1 = check_vpn & (stlb8_ps == MEGAPAGE);
            assign check_vpn2 = check_vpn & GIGAPAGE_EXIST & ((stlb8_ps == MEGAPAGE) | (stlb8_ps == GIGAPAGE));
            assign check_vpn3 = check_vpn & TERAPAGE_EXIST;
            assign stlb_sp_hit_vec[8] = stlb8_valid_reg & ~(keep_global_page & stlb8_g_reg) & (~check_asid | stlb8_g_reg | (stlb8_asid_reg == service_asid)) & (~check_vpn1 | (stlb8_vpn[VPN1_MSB:VPN1_LSB] == service_vpn[VPN1_MSB:VPN1_LSB])) & (~check_vpn2 | (stlb8_vpn[VPN2_MSB:VPN2_LSB] == service_vpn[VPN2_MSB:VPN2_LSB])) & (~check_vpn3 | (stlb8_vpn[VPN3_MSB:VPN3_LSB] == service_vpn[VPN3_MSB:VPN3_LSB]));
            assign stlb_sp_valid_vec[8] = stlb8_valid_reg;
            assign stlb_sp_replacement_vec[8] = stlb8_valid_en & stlb8_valid_reg;
            assign stlb8_rdata[STLB_VPN_MSB:STLB_VPN_LSB] = {stlb8_vpn_reg,{(VPN1_LSB - VPN0_LSB - STLB_RAM_AW){1'b0}}};
            assign stlb8_rdata[STLB_ASID_MSB:STLB_ASID_LSB] = stlb8_asid_reg;
            assign stlb8_rdata[STLB_VALID] = stlb8_valid_reg;
            assign stlb8_rdata[STLB_PPN_MSB:STLB_PPN_LSB] = {stlb8_ppn_reg,{(VPN1_LSB - VPN0_LSB){1'b0}}};
            assign stlb8_rdata[STLB_D_BIT] = stlb8_d_reg;
            assign stlb8_rdata[STLB_A_BIT] = stlb8_a_reg;
            assign stlb8_rdata[STLB_G_BIT] = stlb8_g_reg;
            assign stlb8_rdata[STLB_U_BIT] = stlb8_u_reg;
            assign stlb8_rdata[STLB_X_BIT] = stlb8_x_reg;
            assign stlb8_rdata[STLB_W_BIT] = stlb8_w_reg;
            assign stlb8_rdata[STLB_R_BIT] = stlb8_r_reg;
            assign stlb8_rdata[STLB_V_BIT] = stlb8_v_reg;
        end
        else begin:gen_stlb8_disabled
            assign stlb8_rdata = {STLB_REG_DW{1'b0}};
            assign stlb8_ps = 2'b0;
            assign stlb_sp_hit_vec[8] = 1'b0;
            assign stlb_sp_valid_vec[8] = 1'b0;
            assign stlb_sp_replacement_vec[8] = 1'b0;
        end
        if (9 < (STLB_SP_ENTRIES + 4)) begin:gen_stlb9
            reg stlb9_valid_reg;
            wire stlb9_valid_nx;
            wire stlb9_valid_en;
            wire stlb9_en;
            reg [(VALEN - 1):VPN1_LSB] stlb9_vpn_reg;
            reg [(PALEN - 1):VPN1_LSB] stlb9_ppn_reg;
            reg [(ASID_LEN - 1):0] stlb9_asid_reg;
            reg stlb9_d_reg;
            reg stlb9_a_reg;
            reg stlb9_g_reg;
            reg stlb9_u_reg;
            reg stlb9_x_reg;
            reg stlb9_w_reg;
            reg stlb9_r_reg;
            reg stlb9_v_reg;
            reg [1:0] stlb9_ps_reg;
            wire [48:12] stlb9_vpn;
            wire check_vpn1;
            wire check_vpn2;
            wire check_vpn3;
            assign stlb9_valid_en = (stlb_sp_fill & stlb_victim[9]) | sfence_flush[9];
            assign stlb9_valid_nx = sfence_flush[9] ? 1'b0 : 1'b1;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb9_valid_reg <= 1'b0;
                end
                else if (stlb9_valid_en) begin
                    stlb9_valid_reg <= stlb9_valid_nx;
                end
            end

            assign stlb9_en = stlb_sp_fill & stlb_victim[9];
            always @(posedge core_clk) begin
                if (stlb9_en) begin
                    stlb9_vpn_reg <= stlb_sp_wdata[STLB_VPN_MSB:STLB_VPN1_LSB];
                    stlb9_ppn_reg <= stlb_sp_wdata[STLB_PPN_MSB:STLB_PPN1_LSB];
                    stlb9_asid_reg <= stlb_sp_wdata[STLB_ASID_MSB:STLB_ASID_LSB];
                end
            end

            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb9_d_reg <= 1'b0;
                    stlb9_a_reg <= 1'b0;
                    stlb9_g_reg <= 1'b0;
                    stlb9_u_reg <= 1'b0;
                    stlb9_x_reg <= 1'b0;
                    stlb9_w_reg <= 1'b0;
                    stlb9_r_reg <= 1'b0;
                    stlb9_v_reg <= 1'b0;
                    stlb9_ps_reg <= 2'b0;
                end
                else if (stlb9_en) begin
                    stlb9_d_reg <= stlb_sp_wdata[STLB_D_BIT];
                    stlb9_a_reg <= stlb_sp_wdata[STLB_A_BIT];
                    stlb9_g_reg <= stlb_sp_wdata[STLB_G_BIT];
                    stlb9_u_reg <= stlb_sp_wdata[STLB_U_BIT];
                    stlb9_x_reg <= stlb_sp_wdata[STLB_X_BIT];
                    stlb9_w_reg <= stlb_sp_wdata[STLB_W_BIT];
                    stlb9_r_reg <= stlb_sp_wdata[STLB_R_BIT];
                    stlb9_v_reg <= stlb_sp_wdata[STLB_V_BIT];
                    stlb9_ps_reg <= ptw_ps;
                end
            end

            assign stlb9_vpn = {{(49 - VALEN){1'b0}},stlb9_vpn_reg,{(VPN0_MSB - VPN0_LSB + 1){1'b0}}};
            assign stlb9_ps = ((MMU_SCHEME_INT == 1)) ? MEGAPAGE : ((MMU_SCHEME_INT == 2)) ? (stlb9_ps_reg[1] ? GIGAPAGE : MEGAPAGE) : stlb9_ps_reg;
            if ((MMU_SCHEME_INT == 1)) begin:gen_nds_unused_stlb9_ps_reg
                wire [1:0] nds_unused_stlb9_ps_reg = stlb9_ps_reg;
            end
            assign check_vpn1 = check_vpn & (stlb9_ps == MEGAPAGE);
            assign check_vpn2 = check_vpn & GIGAPAGE_EXIST & ((stlb9_ps == MEGAPAGE) | (stlb9_ps == GIGAPAGE));
            assign check_vpn3 = check_vpn & TERAPAGE_EXIST;
            assign stlb_sp_hit_vec[9] = stlb9_valid_reg & ~(keep_global_page & stlb9_g_reg) & (~check_asid | stlb9_g_reg | (stlb9_asid_reg == service_asid)) & (~check_vpn1 | (stlb9_vpn[VPN1_MSB:VPN1_LSB] == service_vpn[VPN1_MSB:VPN1_LSB])) & (~check_vpn2 | (stlb9_vpn[VPN2_MSB:VPN2_LSB] == service_vpn[VPN2_MSB:VPN2_LSB])) & (~check_vpn3 | (stlb9_vpn[VPN3_MSB:VPN3_LSB] == service_vpn[VPN3_MSB:VPN3_LSB]));
            assign stlb_sp_valid_vec[9] = stlb9_valid_reg;
            assign stlb_sp_replacement_vec[9] = stlb9_valid_en & stlb9_valid_reg;
            assign stlb9_rdata[STLB_VPN_MSB:STLB_VPN_LSB] = {stlb9_vpn_reg,{(VPN1_LSB - VPN0_LSB - STLB_RAM_AW){1'b0}}};
            assign stlb9_rdata[STLB_ASID_MSB:STLB_ASID_LSB] = stlb9_asid_reg;
            assign stlb9_rdata[STLB_VALID] = stlb9_valid_reg;
            assign stlb9_rdata[STLB_PPN_MSB:STLB_PPN_LSB] = {stlb9_ppn_reg,{(VPN1_LSB - VPN0_LSB){1'b0}}};
            assign stlb9_rdata[STLB_D_BIT] = stlb9_d_reg;
            assign stlb9_rdata[STLB_A_BIT] = stlb9_a_reg;
            assign stlb9_rdata[STLB_G_BIT] = stlb9_g_reg;
            assign stlb9_rdata[STLB_U_BIT] = stlb9_u_reg;
            assign stlb9_rdata[STLB_X_BIT] = stlb9_x_reg;
            assign stlb9_rdata[STLB_W_BIT] = stlb9_w_reg;
            assign stlb9_rdata[STLB_R_BIT] = stlb9_r_reg;
            assign stlb9_rdata[STLB_V_BIT] = stlb9_v_reg;
        end
        else begin:gen_stlb9_disabled
            assign stlb9_rdata = {STLB_REG_DW{1'b0}};
            assign stlb9_ps = 2'b0;
            assign stlb_sp_hit_vec[9] = 1'b0;
            assign stlb_sp_valid_vec[9] = 1'b0;
            assign stlb_sp_replacement_vec[9] = 1'b0;
        end
        if (10 < (STLB_SP_ENTRIES + 4)) begin:gen_stlb10
            reg stlb10_valid_reg;
            wire stlb10_valid_nx;
            wire stlb10_valid_en;
            wire stlb10_en;
            reg [(VALEN - 1):VPN1_LSB] stlb10_vpn_reg;
            reg [(PALEN - 1):VPN1_LSB] stlb10_ppn_reg;
            reg [(ASID_LEN - 1):0] stlb10_asid_reg;
            reg stlb10_d_reg;
            reg stlb10_a_reg;
            reg stlb10_g_reg;
            reg stlb10_u_reg;
            reg stlb10_x_reg;
            reg stlb10_w_reg;
            reg stlb10_r_reg;
            reg stlb10_v_reg;
            reg [1:0] stlb10_ps_reg;
            wire [48:12] stlb10_vpn;
            wire check_vpn1;
            wire check_vpn2;
            wire check_vpn3;
            assign stlb10_valid_en = (stlb_sp_fill & stlb_victim[10]) | sfence_flush[10];
            assign stlb10_valid_nx = sfence_flush[10] ? 1'b0 : 1'b1;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb10_valid_reg <= 1'b0;
                end
                else if (stlb10_valid_en) begin
                    stlb10_valid_reg <= stlb10_valid_nx;
                end
            end

            assign stlb10_en = stlb_sp_fill & stlb_victim[10];
            always @(posedge core_clk) begin
                if (stlb10_en) begin
                    stlb10_vpn_reg <= stlb_sp_wdata[STLB_VPN_MSB:STLB_VPN1_LSB];
                    stlb10_ppn_reg <= stlb_sp_wdata[STLB_PPN_MSB:STLB_PPN1_LSB];
                    stlb10_asid_reg <= stlb_sp_wdata[STLB_ASID_MSB:STLB_ASID_LSB];
                end
            end

            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb10_d_reg <= 1'b0;
                    stlb10_a_reg <= 1'b0;
                    stlb10_g_reg <= 1'b0;
                    stlb10_u_reg <= 1'b0;
                    stlb10_x_reg <= 1'b0;
                    stlb10_w_reg <= 1'b0;
                    stlb10_r_reg <= 1'b0;
                    stlb10_v_reg <= 1'b0;
                    stlb10_ps_reg <= 2'b0;
                end
                else if (stlb10_en) begin
                    stlb10_d_reg <= stlb_sp_wdata[STLB_D_BIT];
                    stlb10_a_reg <= stlb_sp_wdata[STLB_A_BIT];
                    stlb10_g_reg <= stlb_sp_wdata[STLB_G_BIT];
                    stlb10_u_reg <= stlb_sp_wdata[STLB_U_BIT];
                    stlb10_x_reg <= stlb_sp_wdata[STLB_X_BIT];
                    stlb10_w_reg <= stlb_sp_wdata[STLB_W_BIT];
                    stlb10_r_reg <= stlb_sp_wdata[STLB_R_BIT];
                    stlb10_v_reg <= stlb_sp_wdata[STLB_V_BIT];
                    stlb10_ps_reg <= ptw_ps;
                end
            end

            assign stlb10_vpn = {{(49 - VALEN){1'b0}},stlb10_vpn_reg,{(VPN0_MSB - VPN0_LSB + 1){1'b0}}};
            assign stlb10_ps = ((MMU_SCHEME_INT == 1)) ? MEGAPAGE : ((MMU_SCHEME_INT == 2)) ? (stlb10_ps_reg[1] ? GIGAPAGE : MEGAPAGE) : stlb10_ps_reg;
            if ((MMU_SCHEME_INT == 1)) begin:gen_nds_unused_stlb10_ps_reg
                wire [1:0] nds_unused_stlb10_ps_reg = stlb10_ps_reg;
            end
            assign check_vpn1 = check_vpn & (stlb10_ps == MEGAPAGE);
            assign check_vpn2 = check_vpn & GIGAPAGE_EXIST & ((stlb10_ps == MEGAPAGE) | (stlb10_ps == GIGAPAGE));
            assign check_vpn3 = check_vpn & TERAPAGE_EXIST;
            assign stlb_sp_hit_vec[10] = stlb10_valid_reg & ~(keep_global_page & stlb10_g_reg) & (~check_asid | stlb10_g_reg | (stlb10_asid_reg == service_asid)) & (~check_vpn1 | (stlb10_vpn[VPN1_MSB:VPN1_LSB] == service_vpn[VPN1_MSB:VPN1_LSB])) & (~check_vpn2 | (stlb10_vpn[VPN2_MSB:VPN2_LSB] == service_vpn[VPN2_MSB:VPN2_LSB])) & (~check_vpn3 | (stlb10_vpn[VPN3_MSB:VPN3_LSB] == service_vpn[VPN3_MSB:VPN3_LSB]));
            assign stlb_sp_valid_vec[10] = stlb10_valid_reg;
            assign stlb_sp_replacement_vec[10] = stlb10_valid_en & stlb10_valid_reg;
            assign stlb10_rdata[STLB_VPN_MSB:STLB_VPN_LSB] = {stlb10_vpn_reg,{(VPN1_LSB - VPN0_LSB - STLB_RAM_AW){1'b0}}};
            assign stlb10_rdata[STLB_ASID_MSB:STLB_ASID_LSB] = stlb10_asid_reg;
            assign stlb10_rdata[STLB_VALID] = stlb10_valid_reg;
            assign stlb10_rdata[STLB_PPN_MSB:STLB_PPN_LSB] = {stlb10_ppn_reg,{(VPN1_LSB - VPN0_LSB){1'b0}}};
            assign stlb10_rdata[STLB_D_BIT] = stlb10_d_reg;
            assign stlb10_rdata[STLB_A_BIT] = stlb10_a_reg;
            assign stlb10_rdata[STLB_G_BIT] = stlb10_g_reg;
            assign stlb10_rdata[STLB_U_BIT] = stlb10_u_reg;
            assign stlb10_rdata[STLB_X_BIT] = stlb10_x_reg;
            assign stlb10_rdata[STLB_W_BIT] = stlb10_w_reg;
            assign stlb10_rdata[STLB_R_BIT] = stlb10_r_reg;
            assign stlb10_rdata[STLB_V_BIT] = stlb10_v_reg;
        end
        else begin:gen_stlb10_disabled
            assign stlb10_rdata = {STLB_REG_DW{1'b0}};
            assign stlb10_ps = 2'b0;
            assign stlb_sp_hit_vec[10] = 1'b0;
            assign stlb_sp_valid_vec[10] = 1'b0;
            assign stlb_sp_replacement_vec[10] = 1'b0;
        end
        if (11 < (STLB_SP_ENTRIES + 4)) begin:gen_stlb11
            reg stlb11_valid_reg;
            wire stlb11_valid_nx;
            wire stlb11_valid_en;
            wire stlb11_en;
            reg [(VALEN - 1):VPN1_LSB] stlb11_vpn_reg;
            reg [(PALEN - 1):VPN1_LSB] stlb11_ppn_reg;
            reg [(ASID_LEN - 1):0] stlb11_asid_reg;
            reg stlb11_d_reg;
            reg stlb11_a_reg;
            reg stlb11_g_reg;
            reg stlb11_u_reg;
            reg stlb11_x_reg;
            reg stlb11_w_reg;
            reg stlb11_r_reg;
            reg stlb11_v_reg;
            reg [1:0] stlb11_ps_reg;
            wire [48:12] stlb11_vpn;
            wire check_vpn1;
            wire check_vpn2;
            wire check_vpn3;
            assign stlb11_valid_en = (stlb_sp_fill & stlb_victim[11]) | sfence_flush[11];
            assign stlb11_valid_nx = sfence_flush[11] ? 1'b0 : 1'b1;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb11_valid_reg <= 1'b0;
                end
                else if (stlb11_valid_en) begin
                    stlb11_valid_reg <= stlb11_valid_nx;
                end
            end

            assign stlb11_en = stlb_sp_fill & stlb_victim[11];
            always @(posedge core_clk) begin
                if (stlb11_en) begin
                    stlb11_vpn_reg <= stlb_sp_wdata[STLB_VPN_MSB:STLB_VPN1_LSB];
                    stlb11_ppn_reg <= stlb_sp_wdata[STLB_PPN_MSB:STLB_PPN1_LSB];
                    stlb11_asid_reg <= stlb_sp_wdata[STLB_ASID_MSB:STLB_ASID_LSB];
                end
            end

            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    stlb11_d_reg <= 1'b0;
                    stlb11_a_reg <= 1'b0;
                    stlb11_g_reg <= 1'b0;
                    stlb11_u_reg <= 1'b0;
                    stlb11_x_reg <= 1'b0;
                    stlb11_w_reg <= 1'b0;
                    stlb11_r_reg <= 1'b0;
                    stlb11_v_reg <= 1'b0;
                    stlb11_ps_reg <= 2'b0;
                end
                else if (stlb11_en) begin
                    stlb11_d_reg <= stlb_sp_wdata[STLB_D_BIT];
                    stlb11_a_reg <= stlb_sp_wdata[STLB_A_BIT];
                    stlb11_g_reg <= stlb_sp_wdata[STLB_G_BIT];
                    stlb11_u_reg <= stlb_sp_wdata[STLB_U_BIT];
                    stlb11_x_reg <= stlb_sp_wdata[STLB_X_BIT];
                    stlb11_w_reg <= stlb_sp_wdata[STLB_W_BIT];
                    stlb11_r_reg <= stlb_sp_wdata[STLB_R_BIT];
                    stlb11_v_reg <= stlb_sp_wdata[STLB_V_BIT];
                    stlb11_ps_reg <= ptw_ps;
                end
            end

            assign stlb11_vpn = {{(49 - VALEN){1'b0}},stlb11_vpn_reg,{(VPN0_MSB - VPN0_LSB + 1){1'b0}}};
            assign stlb11_ps = ((MMU_SCHEME_INT == 1)) ? MEGAPAGE : ((MMU_SCHEME_INT == 2)) ? (stlb11_ps_reg[1] ? GIGAPAGE : MEGAPAGE) : stlb11_ps_reg;
            if ((MMU_SCHEME_INT == 1)) begin:gen_nds_unused_stlb11_ps_reg
                wire [1:0] nds_unused_stlb11_ps_reg = stlb11_ps_reg;
            end
            assign check_vpn1 = check_vpn & (stlb11_ps == MEGAPAGE);
            assign check_vpn2 = check_vpn & GIGAPAGE_EXIST & ((stlb11_ps == MEGAPAGE) | (stlb11_ps == GIGAPAGE));
            assign check_vpn3 = check_vpn & TERAPAGE_EXIST;
            assign stlb_sp_hit_vec[11] = stlb11_valid_reg & ~(keep_global_page & stlb11_g_reg) & (~check_asid | stlb11_g_reg | (stlb11_asid_reg == service_asid)) & (~check_vpn1 | (stlb11_vpn[VPN1_MSB:VPN1_LSB] == service_vpn[VPN1_MSB:VPN1_LSB])) & (~check_vpn2 | (stlb11_vpn[VPN2_MSB:VPN2_LSB] == service_vpn[VPN2_MSB:VPN2_LSB])) & (~check_vpn3 | (stlb11_vpn[VPN3_MSB:VPN3_LSB] == service_vpn[VPN3_MSB:VPN3_LSB]));
            assign stlb_sp_valid_vec[11] = stlb11_valid_reg;
            assign stlb_sp_replacement_vec[11] = stlb11_valid_en & stlb11_valid_reg;
            assign stlb11_rdata[STLB_VPN_MSB:STLB_VPN_LSB] = {stlb11_vpn_reg,{(VPN1_LSB - VPN0_LSB - STLB_RAM_AW){1'b0}}};
            assign stlb11_rdata[STLB_ASID_MSB:STLB_ASID_LSB] = stlb11_asid_reg;
            assign stlb11_rdata[STLB_VALID] = stlb11_valid_reg;
            assign stlb11_rdata[STLB_PPN_MSB:STLB_PPN_LSB] = {stlb11_ppn_reg,{(VPN1_LSB - VPN0_LSB){1'b0}}};
            assign stlb11_rdata[STLB_D_BIT] = stlb11_d_reg;
            assign stlb11_rdata[STLB_A_BIT] = stlb11_a_reg;
            assign stlb11_rdata[STLB_G_BIT] = stlb11_g_reg;
            assign stlb11_rdata[STLB_U_BIT] = stlb11_u_reg;
            assign stlb11_rdata[STLB_X_BIT] = stlb11_x_reg;
            assign stlb11_rdata[STLB_W_BIT] = stlb11_w_reg;
            assign stlb11_rdata[STLB_R_BIT] = stlb11_r_reg;
            assign stlb11_rdata[STLB_V_BIT] = stlb11_v_reg;
        end
        else begin:gen_stlb11_disabled
            assign stlb11_rdata = {STLB_REG_DW{1'b0}};
            assign stlb11_ps = 2'b0;
            assign stlb_sp_hit_vec[11] = 1'b0;
            assign stlb_sp_valid_vec[11] = 1'b0;
            assign stlb_sp_replacement_vec[11] = 1'b0;
        end
        kv_mmu_stlb #(
            .PALEN(PALEN),
            .VALEN(VALEN),
            .STLB_RAM_AW(STLB_RAM_AW),
            .STLB_REG_DW(STLB_REG_DW),
            .STLB_RAM_DW(STLB_RAM_DW),
            .STLB_TAG_REG_DW(STLB_TAG_REG_DW),
            .STLB_DATA_REG_DW(STLB_DATA_REG_DW),
            .STLB_TAG_RAM_ECC_DW(STLB_TAG_RAM_ECC_DW),
            .STLB_TAG_RAM_DW(STLB_TAG_RAM_DW),
            .STLB_DATA_RAM_ECC_DW(STLB_DATA_RAM_ECC_DW),
            .STLB_DATA_RAM_DW(STLB_DATA_RAM_DW),
            .STLB_ECC_TYPE(STLB_ECC_TYPE)
        ) u_kv_mmu_stlb (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .csr_mcache_ctl_tlb_eccen(csr_mcache_ctl_tlb_eccen),
            .csr_mcache_ctl_tlb_rwecc(csr_mcache_ctl_tlb_rwecc),
            .csr_mecc_code(csr_mecc_code),
            .stlb_pipe_idle(stlb_pipe_idle),
            .tlb_cctl_gnt(tlb_cctl_gnt),
            .tlb_cctl_command(tlb_cctl_command),
            .tlb_cctl_waddr(tlb_cctl_waddr),
            .tlb_cctl_wdata(tlb_cctl_wdata),
            .tlb_cctl_ack(tlb_cctl_ack),
            .tlb_cctl_raddr(tlb_cctl_raddr),
            .tlb_cctl_rdata(tlb_cctl_rdata),
            .tlb_cctl_ecc_status(tlb_cctl_ecc_status),
            .sfence_ram_gnt(sfence_ram_gnt),
            .sfence_va(sfence_va),
            .sfence_asid(sfence_asid),
            .sfence_done(sfence_done),
            .sfence_mode_flush_all(sfence_mode_flush_all),
            .sfence_mode_va(sfence_mode_va),
            .sfence_mode_asid(sfence_mode_asid),
            .sfence_mode_va_asid(sfence_mode_va_asid),
            .ptw_ram_gnt(ptw_ram_gnt),
            .ptw_ram_idx(ptw_ram_idx),
            .ptw_ram_we(stlb_victim[3:0]),
            .ptw_ram_wdata(ptw_ram_wdata),
            .stlb_ram_gnt(stlb_ram_gnt),
            .stlb_ram_idx(stlb_ram_idx),
            .stlb_ram_rready(stlb_ram_rready),
            .stlb0_ram_rdata(stlb0_ram_rdata),
            .stlb1_ram_rdata(stlb1_ram_rdata),
            .stlb2_ram_rdata(stlb2_ram_rdata),
            .stlb3_ram_rdata(stlb3_ram_rdata),
            .stlb_mecc_code_error(stlb_mecc_code_error),
            .stlb_mecc_code_code(stlb_mecc_code_code),
            .stlb_mecc_code_corr(stlb_mecc_code_corr),
            .stlb_mecc_code_ramid(stlb_mecc_code_ramid),
            .stlb0_cs(stlb0_cs),
            .stlb1_cs(stlb1_cs),
            .stlb2_cs(stlb2_cs),
            .stlb3_cs(stlb3_cs),
            .stlb0_we(stlb0_we),
            .stlb1_we(stlb1_we),
            .stlb2_we(stlb2_we),
            .stlb3_we(stlb3_we),
            .stlb0_addr(stlb0_addr),
            .stlb1_addr(stlb1_addr),
            .stlb2_addr(stlb2_addr),
            .stlb3_addr(stlb3_addr),
            .stlb0_wdata(stlb0_wdata),
            .stlb1_wdata(stlb1_wdata),
            .stlb2_wdata(stlb2_wdata),
            .stlb3_wdata(stlb3_wdata),
            .stlb0_rdata(stlb0_rdata),
            .stlb1_rdata(stlb1_rdata),
            .stlb2_rdata(stlb2_rdata),
            .stlb3_rdata(stlb3_rdata),
            .stlb_tag0_cs(stlb_tag0_cs),
            .stlb_tag1_cs(stlb_tag1_cs),
            .stlb_tag2_cs(stlb_tag2_cs),
            .stlb_tag3_cs(stlb_tag3_cs),
            .stlb_tag0_we(stlb_tag0_we),
            .stlb_tag1_we(stlb_tag1_we),
            .stlb_tag2_we(stlb_tag2_we),
            .stlb_tag3_we(stlb_tag3_we),
            .stlb_tag0_addr(stlb_tag0_addr),
            .stlb_tag1_addr(stlb_tag1_addr),
            .stlb_tag2_addr(stlb_tag2_addr),
            .stlb_tag3_addr(stlb_tag3_addr),
            .stlb_tag0_wdata(stlb_tag0_wdata),
            .stlb_tag1_wdata(stlb_tag1_wdata),
            .stlb_tag2_wdata(stlb_tag2_wdata),
            .stlb_tag3_wdata(stlb_tag3_wdata),
            .stlb_tag0_rdata(stlb_tag0_rdata),
            .stlb_tag1_rdata(stlb_tag1_rdata),
            .stlb_tag2_rdata(stlb_tag2_rdata),
            .stlb_tag3_rdata(stlb_tag3_rdata),
            .stlb_data0_cs(stlb_data0_cs),
            .stlb_data1_cs(stlb_data1_cs),
            .stlb_data2_cs(stlb_data2_cs),
            .stlb_data3_cs(stlb_data3_cs),
            .stlb_data0_we(stlb_data0_we),
            .stlb_data1_we(stlb_data1_we),
            .stlb_data2_we(stlb_data2_we),
            .stlb_data3_we(stlb_data3_we),
            .stlb_data0_addr(stlb_data0_addr),
            .stlb_data1_addr(stlb_data1_addr),
            .stlb_data2_addr(stlb_data2_addr),
            .stlb_data3_addr(stlb_data3_addr),
            .stlb_data0_wdata(stlb_data0_wdata),
            .stlb_data1_wdata(stlb_data1_wdata),
            .stlb_data2_wdata(stlb_data2_wdata),
            .stlb_data3_wdata(stlb_data3_wdata),
            .stlb_data0_rdata(stlb_data0_rdata),
            .stlb_data1_rdata(stlb_data1_rdata),
            .stlb_data2_rdata(stlb_data2_rdata),
            .stlb_data3_rdata(stlb_data3_rdata)
        );
    end
    else begin:gen_mmu_disable
        assign mmu_csr_mitlb_access = 1'b0;
        assign mmu_csr_mitlb_miss = 1'b0;
        assign mmu_csr_mdtlb_access = 1'b0;
        assign mmu_csr_mdtlb_miss = 1'b0;
        assign mmu_fence_done = 1'b1;
        assign mmu_ipipe_standby_ready = 1'b1;
        assign dtlb_miss_resp = 1'b0;
        assign dtlb_miss_data = {(DTLB_MSB + 1){1'b0}};
        assign dtlb_sfence_req = 1'b0;
        assign dtlb_sfence_mode_flush_all = 1'b0;
        assign dtlb_sfence_mode_va = 1'b0;
        assign itlb_miss_resp = 1'b0;
        assign itlb_miss_data = {(ITLB_MSB + 1){1'b0}};
        assign itlb_sfence_req = 1'b0;
        assign itlb_sfence_mode_flush_all = 1'b0;
        assign itlb_sfence_mode_va = 1'b0;
        assign mmu_iptw_req_valid = 1'b0;
        assign mmu_iptw_req_pa = {(PALEN){1'b0}};
        assign mmu_dptw_req_valid = 1'b0;
        assign mmu_dptw_req_pa = {(PALEN){1'b0}};
        assign stlb0_cs = 1'b0;
        assign stlb1_cs = 1'b0;
        assign stlb2_cs = 1'b0;
        assign stlb3_cs = 1'b0;
        assign stlb0_we = 1'b0;
        assign stlb1_we = 1'b0;
        assign stlb2_we = 1'b0;
        assign stlb3_we = 1'b0;
        assign stlb0_addr = {STLB_RAM_AW{1'b0}};
        assign stlb1_addr = {STLB_RAM_AW{1'b0}};
        assign stlb2_addr = {STLB_RAM_AW{1'b0}};
        assign stlb3_addr = {STLB_RAM_AW{1'b0}};
        assign stlb0_wdata = {STLB_RAM_DW{1'b0}};
        assign stlb1_wdata = {STLB_RAM_DW{1'b0}};
        assign stlb2_wdata = {STLB_RAM_DW{1'b0}};
        assign stlb3_wdata = {STLB_RAM_DW{1'b0}};
        assign stlb_tag0_cs = 1'b0;
        assign stlb_tag1_cs = 1'b0;
        assign stlb_tag2_cs = 1'b0;
        assign stlb_tag3_cs = 1'b0;
        assign stlb_tag0_we = 1'b0;
        assign stlb_tag1_we = 1'b0;
        assign stlb_tag2_we = 1'b0;
        assign stlb_tag3_we = 1'b0;
        assign stlb_tag0_addr = {STLB_RAM_AW{1'b0}};
        assign stlb_tag1_addr = {STLB_RAM_AW{1'b0}};
        assign stlb_tag2_addr = {STLB_RAM_AW{1'b0}};
        assign stlb_tag3_addr = {STLB_RAM_AW{1'b0}};
        assign stlb_tag0_wdata = {STLB_TAG_RAM_DW{1'b0}};
        assign stlb_tag1_wdata = {STLB_TAG_RAM_DW{1'b0}};
        assign stlb_tag2_wdata = {STLB_TAG_RAM_DW{1'b0}};
        assign stlb_tag3_wdata = {STLB_TAG_RAM_DW{1'b0}};
        assign stlb_data0_cs = 1'b0;
        assign stlb_data1_cs = 1'b0;
        assign stlb_data2_cs = 1'b0;
        assign stlb_data3_cs = 1'b0;
        assign stlb_data0_we = 1'b0;
        assign stlb_data1_we = 1'b0;
        assign stlb_data2_we = 1'b0;
        assign stlb_data3_we = 1'b0;
        assign stlb_data0_addr = {STLB_RAM_AW{1'b0}};
        assign stlb_data1_addr = {STLB_RAM_AW{1'b0}};
        assign stlb_data2_addr = {STLB_RAM_AW{1'b0}};
        assign stlb_data3_addr = {STLB_RAM_AW{1'b0}};
        assign stlb_data0_wdata = {STLB_DATA_RAM_DW{1'b0}};
        assign stlb_data1_wdata = {STLB_DATA_RAM_DW{1'b0}};
        assign stlb_data2_wdata = {STLB_DATA_RAM_DW{1'b0}};
        assign stlb_data3_wdata = {STLB_DATA_RAM_DW{1'b0}};
        assign tlb_cctl_ack = 1'b0;
        assign tlb_cctl_raddr = {32{1'b0}};
        assign tlb_cctl_rdata = {32{1'b0}};
        assign tlb_cctl_ecc_status = 8'b0;
        wire nds_unused_core_clk = core_clk;
        wire nds_unused_core_reset_n = core_reset_n;
        wire [(PALEN - 1):12] nds_unused_csr_satp_ppn = csr_satp_ppn;
        wire [3:0] nds_unused_csr_satp_mode = csr_satp_mode;
        wire [8:0] nds_unused_csr_satp_asid = csr_satp_asid;
        wire nds_unused_csr_mmu_satp_we = csr_mmu_satp_we;
        wire [1:0] nds_unused_csr_mcache_ctl_tlb_eccen = csr_mcache_ctl_tlb_eccen;
        wire nds_unused_mmu_fence_req = mmu_fence_req;
        wire [1:0] nds_unused_mmu_fence_mode = mmu_fence_mode;
        wire [(VALEN - 1):12] nds_unused_mmu_fence_vaddr = mmu_fence_vaddr;
        wire [8:0] nds_unused_mmu_fence_asid = mmu_fence_asid;
        wire nds_unused_dtlb_miss_req = dtlb_miss_req;
        wire [(VALEN - 1):12] nds_unused_dtlb_miss_vpn = dtlb_miss_vpn;
        wire nds_unused_itlb_miss_req = itlb_miss_req;
        wire [(VALEN - 1):12] nds_unused_itlb_miss_vpn = itlb_miss_vpn;
        wire nds_unused_iptw_mmu_req_ready = iptw_mmu_req_ready;
        wire nds_unused_iptw_mmu_resp_valid = iptw_mmu_resp_valid;
        wire [16:0] nds_unused_iptw_mmu_resp_status = iptw_mmu_resp_status;
        wire [31:0] nds_unused_iptw_mmu_resp_data = iptw_mmu_resp_data;
        wire nds_unused_dptw_mmu_req_ready = dptw_mmu_req_ready;
        wire nds_unused_dptw_mmu_resp_valid = dptw_mmu_resp_valid;
        wire [16:0] nds_unused_dptw_mmu_resp_status = dptw_mmu_resp_status;
        wire [31:0] nds_unused_dptw_mmu_resp_data = dptw_mmu_resp_data;
        wire [(STLB_TAG_RAM_DW - 1):0] nds_unused_stlb_tag0_rdata = stlb_tag0_rdata;
        wire [(STLB_TAG_RAM_DW - 1):0] nds_unused_stlb_tag1_rdata = stlb_tag1_rdata;
        wire [(STLB_TAG_RAM_DW - 1):0] nds_unused_stlb_tag2_rdata = stlb_tag2_rdata;
        wire [(STLB_TAG_RAM_DW - 1):0] nds_unused_stlb_tag3_rdata = stlb_tag3_rdata;
        wire [(STLB_DATA_RAM_DW - 1):0] nds_unused_stlb_data0_rdata = stlb_data0_rdata;
        wire [(STLB_DATA_RAM_DW - 1):0] nds_unused_stlb_data1_rdata = stlb_data1_rdata;
        wire [(STLB_DATA_RAM_DW - 1):0] nds_unused_stlb_data2_rdata = stlb_data2_rdata;
        wire [(STLB_DATA_RAM_DW - 1):0] nds_unused_stlb_data3_rdata = stlb_data3_rdata;
        wire nds_unused_tlb_cctl_req = tlb_cctl_req;
        wire [1:0] nds_unused_tlb_cctl_command = tlb_cctl_command;
        wire [31:0] nds_unused_tlb_cctl_waddr = tlb_cctl_waddr;
        wire [31:0] nds_unused_tlb_cctl_wdata = tlb_cctl_wdata;
    end
endgenerate
endmodule


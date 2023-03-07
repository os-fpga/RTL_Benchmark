// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_mmu_stlb (
    core_clk,
    core_reset_n,
    csr_mcache_ctl_tlb_eccen,
    csr_mcache_ctl_tlb_rwecc,
    csr_mecc_code,
    stlb_pipe_idle,
    tlb_cctl_gnt,
    tlb_cctl_command,
    tlb_cctl_waddr,
    tlb_cctl_wdata,
    tlb_cctl_ack,
    tlb_cctl_raddr,
    tlb_cctl_rdata,
    tlb_cctl_ecc_status,
    sfence_ram_gnt,
    sfence_va,
    sfence_asid,
    sfence_done,
    sfence_mode_flush_all,
    sfence_mode_va,
    sfence_mode_asid,
    sfence_mode_va_asid,
    ptw_ram_gnt,
    ptw_ram_idx,
    ptw_ram_we,
    ptw_ram_wdata,
    stlb_ram_gnt,
    stlb_ram_idx,
    stlb_ram_rready,
    stlb0_ram_rdata,
    stlb1_ram_rdata,
    stlb2_ram_rdata,
    stlb3_ram_rdata,
    stlb_mecc_code_error,
    stlb_mecc_code_code,
    stlb_mecc_code_corr,
    stlb_mecc_code_ramid,
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
parameter PALEN = 48;
parameter VALEN = 48;
parameter STLB_RAM_AW = 1;
parameter STLB_REG_DW = 1;
parameter STLB_RAM_DW = 1;
parameter STLB_TAG_REG_DW = 1;
parameter STLB_DATA_REG_DW = 1;
parameter STLB_TAG_RAM_ECC_DW = 0;
parameter STLB_TAG_RAM_DW = 1;
parameter STLB_DATA_RAM_ECC_DW = 0;
parameter STLB_DATA_RAM_DW = 1;
parameter STLB_ECC_TYPE = 1;
localparam FUNC_IDX = STLB_RAM_AW - 1;
localparam FUNC_LAST = FUNC_IDX + 1;
localparam FUNC_WR_LSB = FUNC_LAST + 1;
localparam FUNC_WR_MSB = FUNC_WR_LSB + 3;
localparam FUNC_CCTL = FUNC_WR_MSB + 1;
localparam FUNC_SFENCE = FUNC_CCTL + 1;
localparam FUNC_PTW = FUNC_SFENCE + 1;
localparam FUNC_STLB = FUNC_PTW + 1;
localparam FUNC_SFENCE_MODE_FLUSH = FUNC_STLB + 1;
localparam FUNC_SFENCE_MODE_VA = FUNC_SFENCE_MODE_FLUSH + 1;
localparam FUNC_SFENCE_MODE_ASID = FUNC_SFENCE_MODE_VA + 1;
localparam FUNC_SFENCE_MODE_VA_ASID = FUNC_SFENCE_MODE_ASID + 1;
localparam FUNC_BITS = FUNC_SFENCE_MODE_VA_ASID + 1;
localparam ASID_LEN = 9;
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
localparam CCTL_RTAG = 2'b11;
localparam CCTL_RDATA = 2'b00;
localparam CCTL_WTAG = 2'b01;
localparam CCTL_WDATA = 2'b10;
input core_clk;
input core_reset_n;
input [1:0] csr_mcache_ctl_tlb_eccen;
input csr_mcache_ctl_tlb_rwecc;
input [31:0] csr_mecc_code;
output stlb_pipe_idle;
input tlb_cctl_gnt;
input [1:0] tlb_cctl_command;
input [31:0] tlb_cctl_waddr;
input [31:0] tlb_cctl_wdata;
output tlb_cctl_ack;
output [31:0] tlb_cctl_raddr;
output [31:0] tlb_cctl_rdata;
output [7:0] tlb_cctl_ecc_status;
input sfence_ram_gnt;
input [(VALEN - 1):12] sfence_va;
input [(ASID_LEN - 1):0] sfence_asid;
output sfence_done;
input sfence_mode_flush_all;
input sfence_mode_va;
input sfence_mode_asid;
input sfence_mode_va_asid;
input ptw_ram_gnt;
input [(STLB_RAM_AW - 1):0] ptw_ram_idx;
input [3:0] ptw_ram_we;
input [(STLB_REG_DW - 1):0] ptw_ram_wdata;
input stlb_ram_gnt;
input [(STLB_RAM_AW - 1):0] stlb_ram_idx;
output stlb_ram_rready;
output [(STLB_REG_DW - 1):0] stlb0_ram_rdata;
output [(STLB_REG_DW - 1):0] stlb1_ram_rdata;
output [(STLB_REG_DW - 1):0] stlb2_ram_rdata;
output [(STLB_REG_DW - 1):0] stlb3_ram_rdata;
output stlb_mecc_code_error;
output [7:0] stlb_mecc_code_code;
output stlb_mecc_code_corr;
output [3:0] stlb_mecc_code_ramid;
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


wire s0;
wire [(FUNC_BITS - 1):0] s1;
wire s2;
wire s3;
wire s4;
wire s5;
wire [(STLB_RAM_AW - 1):0] s6;
wire [(STLB_RAM_AW - 1):0] s7 = tlb_cctl_waddr[(STLB_RAM_AW - 1):0];
wire [1:0] s8 = tlb_cctl_waddr[17:16];
wire [3:0] s9 = tlb_cctl_waddr[27:24];
wire s10 = (tlb_cctl_waddr[27:24] == 4'h3);
wire s11 = s10 & (tlb_cctl_command == CCTL_RTAG);
wire s12 = s10 & (tlb_cctl_command == CCTL_WTAG);
wire s13 = s10 & (tlb_cctl_command == CCTL_RDATA);
wire s14 = s10 & (tlb_cctl_command == CCTL_WDATA);
wire s15 = s12 & (s8 == 2'd0);
wire s16 = s12 & (s8 == 2'd1);
wire s17 = s12 & (s8 == 2'd2);
wire s18 = s12 & (s8 == 2'd3);
wire s19 = s14 & (s8 == 2'd0);
wire s20 = s14 & (s8 == 2'd1);
wire s21 = s14 & (s8 == 2'd2);
wire s22 = s14 & (s8 == 2'd3);
wire [3:0] s23 = {(s18 | s22),(s17 | s21),(s16 | s20),(s15 | s19)};
reg s24;
reg [(FUNC_BITS - 1):0] s25;
reg s26;
wire s27;
reg [(FUNC_BITS - 1):0] s28;
wire s29;
wire [(STLB_REG_DW - 1):0] s30;
wire [(STLB_REG_DW - 1):0] s31;
wire [(STLB_REG_DW - 1):0] s32;
wire [(STLB_REG_DW - 1):0] s33;
wire [3:0] s34;
reg [STLB_TAG_RAM_DW - 1:0] s35;
reg [STLB_TAG_RAM_DW - 1:0] s36;
reg [STLB_TAG_RAM_DW - 1:0] s37;
reg [STLB_TAG_RAM_DW - 1:0] s38;
wire [STLB_TAG_RAM_DW - 1:0] s39;
wire [STLB_TAG_RAM_DW - 1:0] s40;
wire [STLB_TAG_RAM_DW - 1:0] s41;
wire [STLB_TAG_RAM_DW - 1:0] s42;
reg [STLB_DATA_RAM_DW - 1:0] s43;
reg [STLB_DATA_RAM_DW - 1:0] s44;
reg [STLB_DATA_RAM_DW - 1:0] s45;
reg [STLB_DATA_RAM_DW - 1:0] s46;
wire [STLB_DATA_RAM_DW - 1:0] s47;
wire [STLB_DATA_RAM_DW - 1:0] s48;
wire [STLB_DATA_RAM_DW - 1:0] s49;
wire [STLB_DATA_RAM_DW - 1:0] s50;
wire s51;
wire [3:0] s52;
assign stlb0_cs = s0 & ((s1[FUNC_WR_MSB:FUNC_WR_LSB] == 4'b0000) | s1[FUNC_WR_LSB + 0]);
assign stlb1_cs = s0 & ((s1[FUNC_WR_MSB:FUNC_WR_LSB] == 4'b0000) | s1[FUNC_WR_LSB + 1]);
assign stlb2_cs = s0 & ((s1[FUNC_WR_MSB:FUNC_WR_LSB] == 4'b0000) | s1[FUNC_WR_LSB + 2]);
assign stlb3_cs = s0 & ((s1[FUNC_WR_MSB:FUNC_WR_LSB] == 4'b0000) | s1[FUNC_WR_LSB + 3]);
assign stlb_tag0_cs = stlb0_cs;
assign stlb_tag1_cs = stlb1_cs;
assign stlb_tag2_cs = stlb2_cs;
assign stlb_tag3_cs = stlb3_cs;
assign stlb_data0_cs = stlb0_cs;
assign stlb_data1_cs = stlb1_cs;
assign stlb_data2_cs = stlb2_cs;
assign stlb_data3_cs = stlb3_cs;
assign stlb0_we = s1[FUNC_WR_LSB + 0];
assign stlb1_we = s1[FUNC_WR_LSB + 1];
assign stlb2_we = s1[FUNC_WR_LSB + 2];
assign stlb3_we = s1[FUNC_WR_LSB + 3];
assign stlb_tag0_we = (~tlb_cctl_gnt & s1[FUNC_WR_LSB + 0]) | (tlb_cctl_gnt & s15);
assign stlb_tag1_we = (~tlb_cctl_gnt & s1[FUNC_WR_LSB + 1]) | (tlb_cctl_gnt & s16);
assign stlb_tag2_we = (~tlb_cctl_gnt & s1[FUNC_WR_LSB + 2]) | (tlb_cctl_gnt & s17);
assign stlb_tag3_we = (~tlb_cctl_gnt & s1[FUNC_WR_LSB + 3]) | (tlb_cctl_gnt & s18);
assign stlb_data0_we = (~tlb_cctl_gnt & s1[FUNC_WR_LSB + 0]) | (tlb_cctl_gnt & s19);
assign stlb_data1_we = (~tlb_cctl_gnt & s1[FUNC_WR_LSB + 1]) | (tlb_cctl_gnt & s20);
assign stlb_data2_we = (~tlb_cctl_gnt & s1[FUNC_WR_LSB + 2]) | (tlb_cctl_gnt & s21);
assign stlb_data3_we = (~tlb_cctl_gnt & s1[FUNC_WR_LSB + 3]) | (tlb_cctl_gnt & s22);
assign stlb0_addr = s1[FUNC_IDX:0];
assign stlb1_addr = s1[FUNC_IDX:0];
assign stlb2_addr = s1[FUNC_IDX:0];
assign stlb3_addr = s1[FUNC_IDX:0];
assign stlb_tag0_addr = stlb0_addr;
assign stlb_tag1_addr = stlb1_addr;
assign stlb_tag2_addr = stlb2_addr;
assign stlb_tag3_addr = stlb3_addr;
assign stlb_data0_addr = stlb0_addr;
assign stlb_data1_addr = stlb1_addr;
assign stlb_data2_addr = stlb2_addr;
assign stlb_data3_addr = stlb3_addr;
generate
    if (STLB_ECC_TYPE == 1) begin:gen_m0_ecc_wdata
        wire [STLB_TAG_RAM_DW - 1:0] s53;
        wire [STLB_DATA_RAM_DW - 1:0] s54;
        assign s53[(STLB_TAG_REG_DW - 1):0] = ptw_ram_wdata[STLB_DATA_REG_DW +:STLB_TAG_REG_DW];
        assign s54[(STLB_DATA_REG_DW - 1):0] = ptw_ram_wdata[0 +:STLB_DATA_REG_DW];
        kv_mmu_eccenc #(
            .DW(STLB_TAG_REG_DW),
            .PW(STLB_TAG_RAM_ECC_DW)
        ) u_m0_ptw_tag_wdata_eccenc (
            .data(s53[(STLB_TAG_REG_DW - 1):0]),
            .dataout(s53[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW])
        );
        kv_mmu_eccenc #(
            .DW(STLB_DATA_REG_DW),
            .PW(STLB_DATA_RAM_ECC_DW)
        ) u_m0_ptw_data_wdata_eccenc (
            .data(s54[(STLB_DATA_REG_DW - 1):0]),
            .dataout(s54[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW])
        );
        wire [STLB_TAG_RAM_DW - 1:0] s55;
        wire [STLB_DATA_RAM_DW - 1:0] s56;
        wire [STLB_TAG_RAM_ECC_DW - 1:0] s57;
        wire [STLB_DATA_RAM_ECC_DW - 1:0] s58;
        assign s55[(STLB_TAG_REG_DW - 1):0] = tlb_cctl_wdata[(STLB_TAG_REG_DW - 1):0];
        assign s56[(STLB_DATA_REG_DW - 1):0] = tlb_cctl_wdata[(STLB_DATA_REG_DW - 1):0];
        kv_mmu_eccenc #(
            .DW(STLB_TAG_REG_DW),
            .PW(STLB_TAG_RAM_ECC_DW)
        ) u_m0_cctl_tag_wdata_eccenc (
            .data(s55[(STLB_TAG_REG_DW - 1):0]),
            .dataout(s57)
        );
        kv_mmu_eccenc #(
            .DW(STLB_DATA_REG_DW),
            .PW(STLB_DATA_RAM_ECC_DW)
        ) u_m0_cctl_data_wdata_eccenc (
            .data(s56[(STLB_DATA_REG_DW - 1):0]),
            .dataout(s58)
        );
        assign s55[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW] = csr_mcache_ctl_tlb_rwecc ? csr_mecc_code[STLB_TAG_RAM_ECC_DW - 1:0] : s57;
        assign s56[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW] = csr_mcache_ctl_tlb_rwecc ? csr_mecc_code[STLB_DATA_RAM_ECC_DW - 1:0] : s58;
        assign stlb0_wdata = {STLB_RAM_DW{1'b0}};
        assign stlb1_wdata = {STLB_RAM_DW{1'b0}};
        assign stlb2_wdata = {STLB_RAM_DW{1'b0}};
        assign stlb3_wdata = {STLB_RAM_DW{1'b0}};
        assign stlb_tag0_wdata = ({STLB_TAG_RAM_DW{tlb_cctl_gnt}} & s55) | ({STLB_TAG_RAM_DW{ptw_ram_gnt}} & s53) | ({STLB_TAG_RAM_DW{s29}} & s39);
        assign stlb_tag1_wdata = ({STLB_TAG_RAM_DW{tlb_cctl_gnt}} & s55) | ({STLB_TAG_RAM_DW{ptw_ram_gnt}} & s53) | ({STLB_TAG_RAM_DW{s29}} & s40);
        assign stlb_tag2_wdata = ({STLB_TAG_RAM_DW{tlb_cctl_gnt}} & s55) | ({STLB_TAG_RAM_DW{ptw_ram_gnt}} & s53) | ({STLB_TAG_RAM_DW{s29}} & s41);
        assign stlb_tag3_wdata = ({STLB_TAG_RAM_DW{tlb_cctl_gnt}} & s55) | ({STLB_TAG_RAM_DW{ptw_ram_gnt}} & s53) | ({STLB_TAG_RAM_DW{s29}} & s42);
        assign stlb_data0_wdata = ({STLB_DATA_RAM_DW{tlb_cctl_gnt}} & s56) | ({STLB_DATA_RAM_DW{ptw_ram_gnt}} & s54) | ({STLB_DATA_RAM_DW{s29}} & s47);
        assign stlb_data1_wdata = ({STLB_DATA_RAM_DW{tlb_cctl_gnt}} & s56) | ({STLB_DATA_RAM_DW{ptw_ram_gnt}} & s54) | ({STLB_DATA_RAM_DW{s29}} & s48);
        assign stlb_data2_wdata = ({STLB_DATA_RAM_DW{tlb_cctl_gnt}} & s56) | ({STLB_DATA_RAM_DW{ptw_ram_gnt}} & s54) | ({STLB_DATA_RAM_DW{s29}} & s49);
        assign stlb_data3_wdata = ({STLB_DATA_RAM_DW{tlb_cctl_gnt}} & s56) | ({STLB_DATA_RAM_DW{ptw_ram_gnt}} & s54) | ({STLB_DATA_RAM_DW{s29}} & s50);
    end
    else begin:gen_m0_no_ecc_wdata
        assign stlb0_wdata = {STLB_RAM_DW{ptw_ram_gnt}} & ptw_ram_wdata;
        assign stlb1_wdata = {STLB_RAM_DW{ptw_ram_gnt}} & ptw_ram_wdata;
        assign stlb2_wdata = {STLB_RAM_DW{ptw_ram_gnt}} & ptw_ram_wdata;
        assign stlb3_wdata = {STLB_RAM_DW{ptw_ram_gnt}} & ptw_ram_wdata;
        assign stlb_tag0_wdata = {STLB_TAG_RAM_DW{1'b0}};
        assign stlb_tag1_wdata = {STLB_TAG_RAM_DW{1'b0}};
        assign stlb_tag2_wdata = {STLB_TAG_RAM_DW{1'b0}};
        assign stlb_tag3_wdata = {STLB_TAG_RAM_DW{1'b0}};
        assign stlb_data0_wdata = {STLB_DATA_RAM_DW{1'b0}};
        assign stlb_data1_wdata = {STLB_DATA_RAM_DW{1'b0}};
        assign stlb_data2_wdata = {STLB_DATA_RAM_DW{1'b0}};
        assign stlb_data3_wdata = {STLB_DATA_RAM_DW{1'b0}};
    end
endgenerate
assign s0 = (tlb_cctl_gnt & ~s24) | sfence_ram_gnt | s4 | ptw_ram_gnt | stlb_ram_gnt | s29;
assign s2 = sfence_ram_gnt & (s1[FUNC_SFENCE_MODE_VA] | s1[FUNC_SFENCE_MODE_VA_ASID]);
assign s3 = sfence_ram_gnt & (s1[FUNC_SFENCE_MODE_FLUSH] | s1[FUNC_SFENCE_MODE_ASID]);
assign s4 = s24 & s25[FUNC_SFENCE] & ~s25[FUNC_LAST] & (s25[FUNC_SFENCE_MODE_FLUSH] | s25[FUNC_SFENCE_MODE_ASID]);
assign s5 = &s6 | s25[FUNC_SFENCE_MODE_VA] | s25[FUNC_SFENCE_MODE_VA_ASID];
assign s6 = s25[(STLB_RAM_AW - 1):0] + {{(STLB_RAM_AW - 1){1'b0}},1'b1};
assign s1[FUNC_STLB:0] = s29 ? {s28[FUNC_STLB:FUNC_CCTL],(s52 | s34),s28[FUNC_LAST],s28[FUNC_IDX:0]} : tlb_cctl_gnt ? {4'b0001,s23,1'b1,s7} : s4 ? {s25[FUNC_STLB:FUNC_CCTL],{4{s25[FUNC_SFENCE_MODE_FLUSH]}},s5,s6} : s2 ? {4'b0010,4'b0,1'b1,sfence_va[(12 + STLB_RAM_AW - 1):12]} : s3 ? {4'b0010,{4{s1[FUNC_SFENCE_MODE_FLUSH]}},1'b0,{(STLB_RAM_AW){1'b0}}} : ptw_ram_gnt ? {4'b0100,ptw_ram_we,1'b1,ptw_ram_idx} : stlb_ram_gnt ? {4'b1000,4'b0,1'b1,stlb_ram_idx} : {(FUNC_STLB + 1){1'b0}};
assign s1[FUNC_SFENCE_MODE_FLUSH] = s29 ? s28[FUNC_SFENCE_MODE_FLUSH] : s4 ? s25[FUNC_SFENCE_MODE_FLUSH] : sfence_mode_flush_all;
assign s1[FUNC_SFENCE_MODE_VA] = s29 ? s28[FUNC_SFENCE_MODE_VA] : s4 ? s25[FUNC_SFENCE_MODE_VA] : sfence_mode_va;
assign s1[FUNC_SFENCE_MODE_ASID] = s29 ? s28[FUNC_SFENCE_MODE_ASID] : s4 ? s25[FUNC_SFENCE_MODE_ASID] : sfence_mode_asid;
assign s1[FUNC_SFENCE_MODE_VA_ASID] = s29 ? s28[FUNC_SFENCE_MODE_VA_ASID] : s4 ? s25[FUNC_SFENCE_MODE_VA_ASID] : sfence_mode_va_asid;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s24 <= 1'b0;
    end
    else begin
        s24 <= s0;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s25 <= {(FUNC_BITS){1'b0}};
    end
    else if (s0) begin
        s25 <= s1;
    end
end

generate
    if (STLB_ECC_TYPE == 1) begin:gen_m2_ecc_rdata_ff
        reg s59;
        reg s60;
        reg [1:0] s61;
        wire [31:0] s62;
        wire [31:0] s63;
        wire [31:0] s64;
        wire [31:0] s65;
        wire [31:0] s66;
        wire [31:0] s67;
        wire [31:0] s68;
        wire [31:0] s69;
        wire [7:0] s70;
        wire [7:0] s71;
        wire [7:0] s72;
        wire [7:0] s73;
        wire [7:0] s74;
        wire [7:0] s75;
        wire [7:0] s76;
        wire [7:0] s77;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s59 <= 1'b0;
                s60 <= 1'b0;
                s61 <= 2'b0;
            end
            else if (s0) begin
                s59 <= s11;
                s60 <= s13;
                s61 <= s8;
            end
        end

        assign tlb_cctl_ack = s24 & s25[FUNC_CCTL];
        assign tlb_cctl_raddr = tlb_cctl_waddr;
        kv_zero_ext #(
            .IW(STLB_TAG_REG_DW),
            .OW(32)
        ) u_m1_cctl_tag0_rdata_zext (
            .in(stlb_tag0_rdata[0 +:STLB_TAG_REG_DW]),
            .out(s62)
        );
        kv_zero_ext #(
            .IW(STLB_TAG_REG_DW),
            .OW(32)
        ) u_m1_cctl_tag1_rdata_zext (
            .in(stlb_tag1_rdata[0 +:STLB_TAG_REG_DW]),
            .out(s64)
        );
        kv_zero_ext #(
            .IW(STLB_TAG_REG_DW),
            .OW(32)
        ) u_m1_cctl_tag2_rdata_zext (
            .in(stlb_tag2_rdata[0 +:STLB_TAG_REG_DW]),
            .out(s66)
        );
        kv_zero_ext #(
            .IW(STLB_TAG_REG_DW),
            .OW(32)
        ) u_m1_cctl_tag3_rdata_zext (
            .in(stlb_tag3_rdata[0 +:STLB_TAG_REG_DW]),
            .out(s68)
        );
        kv_zero_ext #(
            .IW(STLB_TAG_RAM_ECC_DW),
            .OW(8)
        ) u_m1_cctl_tag0_ecc_status_zext (
            .in(stlb_tag0_rdata[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW]),
            .out(s70)
        );
        kv_zero_ext #(
            .IW(STLB_TAG_RAM_ECC_DW),
            .OW(8)
        ) u_m1_cctl_tag1_ecc_status_zext (
            .in(stlb_tag1_rdata[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW]),
            .out(s72)
        );
        kv_zero_ext #(
            .IW(STLB_TAG_RAM_ECC_DW),
            .OW(8)
        ) u_m1_cctl_tag2_ecc_status_zext (
            .in(stlb_tag2_rdata[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW]),
            .out(s74)
        );
        kv_zero_ext #(
            .IW(STLB_TAG_RAM_ECC_DW),
            .OW(8)
        ) u_m1_cctl_tag3_ecc_status_zext (
            .in(stlb_tag3_rdata[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW]),
            .out(s76)
        );
        kv_zero_ext #(
            .IW(STLB_DATA_REG_DW),
            .OW(32)
        ) u_m1_cctl_data0_rdata_zext (
            .in(stlb_data0_rdata[0 +:STLB_DATA_REG_DW]),
            .out(s63)
        );
        kv_zero_ext #(
            .IW(STLB_DATA_REG_DW),
            .OW(32)
        ) u_m1_cctl_data1_rdata_zext (
            .in(stlb_data1_rdata[0 +:STLB_DATA_REG_DW]),
            .out(s65)
        );
        kv_zero_ext #(
            .IW(STLB_DATA_REG_DW),
            .OW(32)
        ) u_m1_cctl_data2_rdata_zext (
            .in(stlb_data2_rdata[0 +:STLB_DATA_REG_DW]),
            .out(s67)
        );
        kv_zero_ext #(
            .IW(STLB_DATA_REG_DW),
            .OW(32)
        ) u_m1_cctl_data3_rdata_zext (
            .in(stlb_data3_rdata[0 +:STLB_DATA_REG_DW]),
            .out(s69)
        );
        kv_zero_ext #(
            .IW(STLB_DATA_RAM_ECC_DW),
            .OW(8)
        ) u_m1_cctl_data0_ecc_status_zext (
            .in(stlb_data0_rdata[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW]),
            .out(s71)
        );
        kv_zero_ext #(
            .IW(STLB_DATA_RAM_ECC_DW),
            .OW(8)
        ) u_m1_cctl_data1_ecc_status_zext (
            .in(stlb_data1_rdata[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW]),
            .out(s73)
        );
        kv_zero_ext #(
            .IW(STLB_DATA_RAM_ECC_DW),
            .OW(8)
        ) u_m1_cctl_data2_ecc_status_zext (
            .in(stlb_data2_rdata[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW]),
            .out(s75)
        );
        kv_zero_ext #(
            .IW(STLB_DATA_RAM_ECC_DW),
            .OW(8)
        ) u_m1_cctl_data3_ecc_status_zext (
            .in(stlb_data3_rdata[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW]),
            .out(s77)
        );
        assign {tlb_cctl_ecc_status,tlb_cctl_rdata} = ({40{s59 & (s61 == 2'b00)}} & {s70,s62}) | ({40{s59 & (s61 == 2'b01)}} & {s72,s64}) | ({40{s59 & (s61 == 2'b10)}} & {s74,s66}) | ({40{s59 & (s61 == 2'b11)}} & {s76,s68}) | ({40{s60 & (s61 == 2'b00)}} & {s71,s63}) | ({40{s60 & (s61 == 2'b01)}} & {s73,s65}) | ({40{s60 & (s61 == 2'b10)}} & {s75,s67}) | ({40{s60 & (s61 == 2'b11)}} & {s77,s69});
        wire s78;
        reg s79;
        wire s80;
        reg [(FUNC_BITS - 1):0] s81;
        reg [STLB_TAG_RAM_DW - 1:0] s82;
        reg [STLB_TAG_RAM_DW - 1:0] s83;
        reg [STLB_TAG_RAM_DW - 1:0] s84;
        reg [STLB_TAG_RAM_DW - 1:0] s85;
        reg [STLB_DATA_RAM_DW - 1:0] s86;
        reg [STLB_DATA_RAM_DW - 1:0] s87;
        reg [STLB_DATA_RAM_DW - 1:0] s88;
        reg [STLB_DATA_RAM_DW - 1:0] s89;
        wire [STLB_TAG_RAM_DW - 1:0] s90;
        wire [STLB_TAG_RAM_DW - 1:0] s91;
        wire [STLB_TAG_RAM_DW - 1:0] s92;
        wire [STLB_TAG_RAM_DW - 1:0] s93;
        wire [STLB_DATA_RAM_DW - 1:0] s94;
        wire [STLB_DATA_RAM_DW - 1:0] s95;
        wire [STLB_DATA_RAM_DW - 1:0] s96;
        wire [STLB_DATA_RAM_DW - 1:0] s97;
        reg [STLB_TAG_RAM_ECC_DW - 1:0] s98;
        reg [STLB_TAG_RAM_ECC_DW - 1:0] s99;
        reg [STLB_TAG_RAM_ECC_DW - 1:0] s100;
        reg [STLB_TAG_RAM_ECC_DW - 1:0] s101;
        reg [STLB_DATA_RAM_ECC_DW - 1:0] s102;
        reg [STLB_DATA_RAM_ECC_DW - 1:0] s103;
        reg [STLB_DATA_RAM_ECC_DW - 1:0] s104;
        reg [STLB_DATA_RAM_ECC_DW - 1:0] s105;
        wire s106;
        wire s107;
        wire s108;
        wire s109;
        wire [7:0] s110;
        wire [7:0] s111;
        wire [7:0] s112;
        wire [7:0] s113;
        wire [3:0] s114;
        wire [3:0] s115;
        wire [3:0] s116;
        wire [3:0] s117;
        wire s118;
        wire s119;
        wire s120;
        wire s121;
        wire [7:0] s122;
        wire [7:0] s123;
        wire [7:0] s124;
        wire [7:0] s125;
        wire [3:0] s126;
        wire [3:0] s127;
        wire [3:0] s128;
        wire [3:0] s129;
        reg [1:0] s130;
        reg [1:0] s131;
        reg [1:0] s132;
        reg [1:0] s133;
        reg [1:0] s134;
        reg [1:0] s135;
        reg [1:0] s136;
        reg [1:0] s137;
        wire [1:0] s138;
        wire [1:0] s139;
        wire [1:0] s140;
        wire [1:0] s141;
        wire [1:0] s142;
        wire [1:0] s143;
        wire [1:0] s144;
        wire [1:0] s145;
        assign stlb_pipe_idle = ~s24 & ~s79 & ~s26;
        assign s80 = s24 & ~(|s25[FUNC_WR_MSB:FUNC_WR_LSB]) & ~s25[FUNC_CCTL];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s79 <= 1'b0;
            end
            else begin
                s79 <= s80;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s81 <= {(FUNC_BITS){1'b0}};
            end
            else if (s80) begin
                s81 <= s25;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s82 <= {(STLB_TAG_RAM_DW){1'b0}};
                s83 <= {(STLB_TAG_RAM_DW){1'b0}};
                s84 <= {(STLB_TAG_RAM_DW){1'b0}};
                s85 <= {(STLB_TAG_RAM_DW){1'b0}};
                s86 <= {(STLB_DATA_RAM_DW){1'b0}};
                s87 <= {(STLB_DATA_RAM_DW){1'b0}};
                s88 <= {(STLB_DATA_RAM_DW){1'b0}};
                s89 <= {(STLB_DATA_RAM_DW){1'b0}};
            end
            else if (s80) begin
                s82 <= stlb_tag0_rdata;
                s83 <= stlb_tag1_rdata;
                s84 <= stlb_tag2_rdata;
                s85 <= stlb_tag3_rdata;
                s86 <= stlb_data0_rdata;
                s87 <= stlb_data1_rdata;
                s88 <= stlb_data2_rdata;
                s89 <= stlb_data3_rdata;
            end
        end

        assign s78 = s79 & csr_mcache_ctl_tlb_eccen[1];
        kv_mmu_eccdec #(
            .DW(STLB_TAG_REG_DW),
            .PW(STLB_TAG_RAM_ECC_DW)
        ) u_stlb_tag0_rdata_eccdec (
            .clk(core_clk),
            .resetn(core_reset_n),
            .i_valid(s78),
            .i_data(s82[0 +:STLB_TAG_REG_DW]),
            .i_par(s82[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW]),
            .o_data(s90[0 +:STLB_TAG_REG_DW]),
            .o_par(s90[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW]),
            .o_ecc_corr(s138[0]),
            .o_ecc_uncorr(s138[1])
        );
        kv_mmu_eccdec #(
            .DW(STLB_DATA_REG_DW),
            .PW(STLB_DATA_RAM_ECC_DW)
        ) u_stlb_data0_rdata_eccdec (
            .clk(core_clk),
            .resetn(core_reset_n),
            .i_valid(s78),
            .i_data(s86[0 +:STLB_DATA_REG_DW]),
            .i_par(s86[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW]),
            .o_data(s94[0 +:STLB_DATA_REG_DW]),
            .o_par(s94[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW]),
            .o_ecc_corr(s139[0]),
            .o_ecc_uncorr(s139[1])
        );
        kv_mmu_eccdec #(
            .DW(STLB_TAG_REG_DW),
            .PW(STLB_TAG_RAM_ECC_DW)
        ) u_stlb_tag1_rdata_eccdec (
            .clk(core_clk),
            .resetn(core_reset_n),
            .i_valid(s78),
            .i_data(s83[0 +:STLB_TAG_REG_DW]),
            .i_par(s83[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW]),
            .o_data(s91[0 +:STLB_TAG_REG_DW]),
            .o_par(s91[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW]),
            .o_ecc_corr(s140[0]),
            .o_ecc_uncorr(s140[1])
        );
        kv_mmu_eccdec #(
            .DW(STLB_DATA_REG_DW),
            .PW(STLB_DATA_RAM_ECC_DW)
        ) u_stlb_data1_rdata_eccdec (
            .clk(core_clk),
            .resetn(core_reset_n),
            .i_valid(s78),
            .i_data(s87[0 +:STLB_DATA_REG_DW]),
            .i_par(s87[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW]),
            .o_data(s95[0 +:STLB_DATA_REG_DW]),
            .o_par(s95[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW]),
            .o_ecc_corr(s141[0]),
            .o_ecc_uncorr(s141[1])
        );
        kv_mmu_eccdec #(
            .DW(STLB_TAG_REG_DW),
            .PW(STLB_TAG_RAM_ECC_DW)
        ) u_stlb_tag2_rdata_eccdec (
            .clk(core_clk),
            .resetn(core_reset_n),
            .i_valid(s78),
            .i_data(s84[0 +:STLB_TAG_REG_DW]),
            .i_par(s84[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW]),
            .o_data(s92[0 +:STLB_TAG_REG_DW]),
            .o_par(s92[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW]),
            .o_ecc_corr(s142[0]),
            .o_ecc_uncorr(s142[1])
        );
        kv_mmu_eccdec #(
            .DW(STLB_DATA_REG_DW),
            .PW(STLB_DATA_RAM_ECC_DW)
        ) u_stlb_data2_rdata_eccdec (
            .clk(core_clk),
            .resetn(core_reset_n),
            .i_valid(s78),
            .i_data(s88[0 +:STLB_DATA_REG_DW]),
            .i_par(s88[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW]),
            .o_data(s96[0 +:STLB_DATA_REG_DW]),
            .o_par(s96[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW]),
            .o_ecc_corr(s143[0]),
            .o_ecc_uncorr(s143[1])
        );
        kv_mmu_eccdec #(
            .DW(STLB_TAG_REG_DW),
            .PW(STLB_TAG_RAM_ECC_DW)
        ) u_stlb_tag3_rdata_eccdec (
            .clk(core_clk),
            .resetn(core_reset_n),
            .i_valid(s78),
            .i_data(s85[0 +:STLB_TAG_REG_DW]),
            .i_par(s85[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW]),
            .o_data(s93[0 +:STLB_TAG_REG_DW]),
            .o_par(s93[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW]),
            .o_ecc_corr(s144[0]),
            .o_ecc_uncorr(s144[1])
        );
        kv_mmu_eccdec #(
            .DW(STLB_DATA_REG_DW),
            .PW(STLB_DATA_RAM_ECC_DW)
        ) u_stlb_data3_rdata_eccdec (
            .clk(core_clk),
            .resetn(core_reset_n),
            .i_valid(s78),
            .i_data(s89[0 +:STLB_DATA_REG_DW]),
            .i_par(s89[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW]),
            .o_data(s97[0 +:STLB_DATA_REG_DW]),
            .o_par(s97[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW]),
            .o_ecc_corr(s145[0]),
            .o_ecc_uncorr(s145[1])
        );
        assign s27 = s79;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s28 <= {(FUNC_BITS){1'b0}};
                s35 <= {(STLB_TAG_RAM_DW){1'b0}};
                s36 <= {(STLB_TAG_RAM_DW){1'b0}};
                s37 <= {(STLB_TAG_RAM_DW){1'b0}};
                s38 <= {(STLB_TAG_RAM_DW){1'b0}};
                s43 <= {(STLB_DATA_RAM_DW){1'b0}};
                s44 <= {(STLB_DATA_RAM_DW){1'b0}};
                s45 <= {(STLB_DATA_RAM_DW){1'b0}};
                s46 <= {(STLB_DATA_RAM_DW){1'b0}};
                s98 <= {(STLB_TAG_RAM_ECC_DW){1'b0}};
                s99 <= {(STLB_TAG_RAM_ECC_DW){1'b0}};
                s100 <= {(STLB_TAG_RAM_ECC_DW){1'b0}};
                s101 <= {(STLB_TAG_RAM_ECC_DW){1'b0}};
                s102 <= {(STLB_DATA_RAM_ECC_DW){1'b0}};
                s103 <= {(STLB_DATA_RAM_ECC_DW){1'b0}};
                s104 <= {(STLB_DATA_RAM_ECC_DW){1'b0}};
                s105 <= {(STLB_DATA_RAM_ECC_DW){1'b0}};
                s130 <= 2'b0;
                s132 <= 2'b0;
                s134 <= 2'b0;
                s136 <= 2'b0;
                s131 <= 2'b0;
                s133 <= 2'b0;
                s135 <= 2'b0;
                s137 <= 2'b0;
            end
            else if (s27) begin
                s28 <= s81;
                s35 <= s90;
                s36 <= s91;
                s37 <= s92;
                s38 <= s93;
                s43 <= s94;
                s44 <= s95;
                s45 <= s96;
                s46 <= s97;
                s98 <= s82[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW];
                s99 <= s83[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW];
                s100 <= s84[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW];
                s101 <= s85[STLB_TAG_REG_DW +:STLB_TAG_RAM_ECC_DW];
                s102 <= s86[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW];
                s103 <= s87[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW];
                s104 <= s88[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW];
                s105 <= s89[STLB_DATA_REG_DW +:STLB_DATA_RAM_ECC_DW];
                s130 <= s138;
                s132 <= s140;
                s134 <= s142;
                s136 <= s144;
                s131 <= s139;
                s133 <= s141;
                s135 <= s143;
                s137 <= s145;
            end
        end

        assign stlb0_ram_rdata = (s26 & csr_mcache_ctl_tlb_eccen[1]) ? {(STLB_REG_DW){~(s130[1] | s131[1])}} & {s35[0 +:STLB_TAG_REG_DW],s43[0 +:STLB_DATA_REG_DW]} : {s35[0 +:STLB_TAG_REG_DW],s43[0 +:STLB_DATA_REG_DW]};
        assign stlb1_ram_rdata = (s26 & csr_mcache_ctl_tlb_eccen[1]) ? {(STLB_REG_DW){~(s132[1] | s133[1])}} & {s36[0 +:STLB_TAG_REG_DW],s44[0 +:STLB_DATA_REG_DW]} : {s36[0 +:STLB_TAG_REG_DW],s44[0 +:STLB_DATA_REG_DW]};
        assign stlb2_ram_rdata = (s26 & csr_mcache_ctl_tlb_eccen[1]) ? {(STLB_REG_DW){~(s134[1] | s135[1])}} & {s37[0 +:STLB_TAG_REG_DW],s45[0 +:STLB_DATA_REG_DW]} : {s37[0 +:STLB_TAG_REG_DW],s45[0 +:STLB_DATA_REG_DW]};
        assign stlb3_ram_rdata = (s26 & csr_mcache_ctl_tlb_eccen[1]) ? {(STLB_REG_DW){~(s136[1] | s137[1])}} & {s38[0 +:STLB_TAG_REG_DW],s46[0 +:STLB_DATA_REG_DW]} : {s38[0 +:STLB_TAG_REG_DW],s46[0 +:STLB_DATA_REG_DW]};
        assign s29 = (s26 & csr_mcache_ctl_tlb_eccen[1] & (|s52)) | (s26 & s28[FUNC_SFENCE] & (|s34));
        assign s39 = {STLB_TAG_RAM_DW{~(s130[1] | s131[1]) & ~s28[FUNC_SFENCE]}} & s35;
        assign s40 = {STLB_TAG_RAM_DW{~(s132[1] | s133[1]) & ~s28[FUNC_SFENCE]}} & s36;
        assign s41 = {STLB_TAG_RAM_DW{~(s134[1] | s135[1]) & ~s28[FUNC_SFENCE]}} & s37;
        assign s42 = {STLB_TAG_RAM_DW{~(s136[1] | s137[1]) & ~s28[FUNC_SFENCE]}} & s38;
        assign s47 = {STLB_DATA_RAM_DW{~(s130[1] | s131[1]) & ~s28[FUNC_SFENCE]}} & s43;
        assign s48 = {STLB_DATA_RAM_DW{~(s132[1] | s133[1]) & ~s28[FUNC_SFENCE]}} & s44;
        assign s49 = {STLB_DATA_RAM_DW{~(s134[1] | s135[1]) & ~s28[FUNC_SFENCE]}} & s45;
        assign s50 = {STLB_DATA_RAM_DW{~(s136[1] | s137[1]) & ~s28[FUNC_SFENCE]}} & s46;
        assign s52 = {((|s136) | (|s137)),((|s134) | (|s135)),((|s132) | (|s133)),((|s130) | (|s131))};
        assign s106 = s26 & s28[FUNC_STLB] & (&csr_mcache_ctl_tlb_eccen[1:0]) & (|s130);
        kv_zero_ext #(
            .IW(STLB_TAG_RAM_ECC_DW),
            .OW(8)
        ) u_stlb_tag0_mecc_code_code_zext (
            .in(s98),
            .out(s110)
        );
        assign s114 = 4'd6;
        assign s107 = s26 & s28[FUNC_STLB] & (&csr_mcache_ctl_tlb_eccen[1:0]) & (|s132);
        kv_zero_ext #(
            .IW(STLB_TAG_RAM_ECC_DW),
            .OW(8)
        ) u_stlb_tag1_mecc_code_code_zext (
            .in(s99),
            .out(s111)
        );
        assign s115 = 4'd6;
        assign s108 = s26 & s28[FUNC_STLB] & (&csr_mcache_ctl_tlb_eccen[1:0]) & (|s134);
        kv_zero_ext #(
            .IW(STLB_TAG_RAM_ECC_DW),
            .OW(8)
        ) u_stlb_tag2_mecc_code_code_zext (
            .in(s100),
            .out(s112)
        );
        assign s116 = 4'd6;
        assign s109 = s26 & s28[FUNC_STLB] & (&csr_mcache_ctl_tlb_eccen[1:0]) & (|s136);
        kv_zero_ext #(
            .IW(STLB_TAG_RAM_ECC_DW),
            .OW(8)
        ) u_stlb_tag3_mecc_code_code_zext (
            .in(s101),
            .out(s113)
        );
        assign s117 = 4'd6;
        assign s118 = s26 & s28[FUNC_STLB] & (&csr_mcache_ctl_tlb_eccen[1:0]) & (|s131);
        kv_zero_ext #(
            .IW(STLB_DATA_RAM_ECC_DW),
            .OW(8)
        ) u_stlb_data0_mecc_code_code_zext (
            .in(s102),
            .out(s122)
        );
        assign s126 = 4'd7;
        assign s119 = s26 & s28[FUNC_STLB] & (&csr_mcache_ctl_tlb_eccen[1:0]) & (|s133);
        kv_zero_ext #(
            .IW(STLB_DATA_RAM_ECC_DW),
            .OW(8)
        ) u_stlb_data1_mecc_code_code_zext (
            .in(s103),
            .out(s123)
        );
        assign s127 = 4'd7;
        assign s120 = s26 & s28[FUNC_STLB] & (&csr_mcache_ctl_tlb_eccen[1:0]) & (|s135);
        kv_zero_ext #(
            .IW(STLB_DATA_RAM_ECC_DW),
            .OW(8)
        ) u_stlb_data2_mecc_code_code_zext (
            .in(s104),
            .out(s124)
        );
        assign s128 = 4'd7;
        assign s121 = s26 & s28[FUNC_STLB] & (&csr_mcache_ctl_tlb_eccen[1:0]) & (|s137);
        kv_zero_ext #(
            .IW(STLB_DATA_RAM_ECC_DW),
            .OW(8)
        ) u_stlb_data3_mecc_code_code_zext (
            .in(s105),
            .out(s125)
        );
        assign s129 = 4'd7;
        assign {stlb_mecc_code_ramid,stlb_mecc_code_corr,stlb_mecc_code_code,stlb_mecc_code_error} = s106 ? {s114,1'b1,s110,1'b1} : s107 ? {s115,1'b1,s111,1'b1} : s108 ? {s116,1'b1,s112,1'b1} : s109 ? {s117,1'b1,s113,1'b1} : s118 ? {s126,1'b1,s122,1'b1} : s119 ? {s127,1'b1,s123,1'b1} : s120 ? {s128,1'b1,s124,1'b1} : s121 ? {s129,1'b1,s125,1'b1} : 14'b0;
        wire nds_unused_stlb_data = (|stlb0_rdata) | (|stlb1_rdata) | (|stlb2_rdata) | (|stlb3_rdata);
        assign sfence_done = (~s24 & ~s79 & s26 & s28[FUNC_SFENCE] & s28[FUNC_LAST] & ~s29) | (s24 & ~s79 & s25[FUNC_SFENCE] & s25[FUNC_LAST] & (|s25[FUNC_WR_MSB:FUNC_WR_LSB]));
    end
    else begin:gen_m2_no_ecc_rdata_ff
        assign tlb_cctl_ack = 1'b0;
        assign tlb_cctl_raddr = {32{1'b0}};
        assign tlb_cctl_rdata = {32{1'b0}};
        assign tlb_cctl_ecc_status = 8'b0;
        assign stlb_pipe_idle = ~s24 & ~s26;
        assign s27 = s24 & ~(|s25[FUNC_WR_MSB:FUNC_WR_LSB]);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s28 <= {(FUNC_BITS){1'b0}};
                s35 <= {(STLB_TAG_RAM_DW){1'b0}};
                s36 <= {(STLB_TAG_RAM_DW){1'b0}};
                s37 <= {(STLB_TAG_RAM_DW){1'b0}};
                s38 <= {(STLB_TAG_RAM_DW){1'b0}};
                s43 <= {(STLB_DATA_RAM_DW){1'b0}};
                s44 <= {(STLB_DATA_RAM_DW){1'b0}};
                s45 <= {(STLB_DATA_RAM_DW){1'b0}};
                s46 <= {(STLB_DATA_RAM_DW){1'b0}};
            end
            else if (s27) begin
                s28 <= s25;
                s35 <= stlb0_rdata[STLB_DATA_RAM_DW +:STLB_TAG_RAM_DW];
                s36 <= stlb1_rdata[STLB_DATA_RAM_DW +:STLB_TAG_RAM_DW];
                s37 <= stlb2_rdata[STLB_DATA_RAM_DW +:STLB_TAG_RAM_DW];
                s38 <= stlb3_rdata[STLB_DATA_RAM_DW +:STLB_TAG_RAM_DW];
                s43 <= stlb0_rdata[0 +:STLB_DATA_RAM_DW];
                s44 <= stlb1_rdata[0 +:STLB_DATA_RAM_DW];
                s45 <= stlb2_rdata[0 +:STLB_DATA_RAM_DW];
                s46 <= stlb3_rdata[0 +:STLB_DATA_RAM_DW];
            end
        end

        wire nds_unused_stlb_data = (|stlb_tag0_rdata) | (|stlb_tag1_rdata) | (|stlb_tag2_rdata) | (|stlb_tag3_rdata) | (|stlb_data0_rdata) | (|stlb_data1_rdata) | (|stlb_data2_rdata) | (|stlb_data3_rdata);
        assign s29 = (s26 & s28[FUNC_SFENCE] & (|s34));
        assign s52 = 4'b0;
        assign stlb_mecc_code_error = 1'b0;
        assign stlb_mecc_code_code = 8'b0;
        assign stlb_mecc_code_corr = 1'b0;
        assign stlb_mecc_code_ramid = 4'b0;
        assign stlb0_ram_rdata = {s35[0 +:STLB_TAG_REG_DW],s43[0 +:STLB_DATA_REG_DW]};
        assign stlb1_ram_rdata = {s36[0 +:STLB_TAG_REG_DW],s44[0 +:STLB_DATA_REG_DW]};
        assign stlb2_ram_rdata = {s37[0 +:STLB_TAG_REG_DW],s45[0 +:STLB_DATA_REG_DW]};
        assign stlb3_ram_rdata = {s38[0 +:STLB_TAG_REG_DW],s46[0 +:STLB_DATA_REG_DW]};
        assign s39 = s35;
        assign s40 = s36;
        assign s41 = s37;
        assign s42 = s38;
        assign s47 = s43;
        assign s48 = s44;
        assign s49 = s45;
        assign s50 = s46;
        assign sfence_done = (~s24 & s26 & s28[FUNC_SFENCE] & s28[FUNC_LAST] & ~s29) | (s24 & s25[FUNC_SFENCE] & s25[FUNC_LAST] & (|s25[FUNC_WR_MSB:FUNC_WR_LSB]));
    end
endgenerate
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s26 <= 1'b0;
    end
    else begin
        s26 <= s27;
    end
end

assign s51 = &s28[FUNC_IDX:0];
assign stlb_ram_rready = s26 & s28[FUNC_STLB];
assign s30 = {s35[0 +:STLB_TAG_REG_DW],s43[0 +:STLB_DATA_REG_DW]};
assign s31 = {s36[0 +:STLB_TAG_REG_DW],s44[0 +:STLB_DATA_REG_DW]};
assign s32 = {s37[0 +:STLB_TAG_REG_DW],s45[0 +:STLB_DATA_REG_DW]};
assign s33 = {s38[0 +:STLB_TAG_REG_DW],s46[0 +:STLB_DATA_REG_DW]};
assign s34[0] = (s26 & s28[FUNC_SFENCE] & s30[STLB_VALID] & (~(s28[FUNC_SFENCE_MODE_ASID] | s28[FUNC_SFENCE_MODE_VA_ASID]) | (~s30[STLB_G_BIT] & (s30[STLB_ASID_MSB:STLB_ASID_LSB] == sfence_asid))) & (~(s28[FUNC_SFENCE_MODE_VA] | s28[FUNC_SFENCE_MODE_VA_ASID]) | (s30[STLB_VPN_MSB:STLB_VPN_LSB] == sfence_va[(VALEN - 1):(12 + STLB_RAM_AW)])));
assign s34[1] = (s26 & s28[FUNC_SFENCE] & s31[STLB_VALID] & (~(s28[FUNC_SFENCE_MODE_ASID] | s28[FUNC_SFENCE_MODE_VA_ASID]) | (~s31[STLB_G_BIT] & (s31[STLB_ASID_MSB:STLB_ASID_LSB] == sfence_asid))) & (~(s28[FUNC_SFENCE_MODE_VA] | s28[FUNC_SFENCE_MODE_VA_ASID]) | (s31[STLB_VPN_MSB:STLB_VPN_LSB] == sfence_va[(VALEN - 1):(12 + STLB_RAM_AW)])));
assign s34[2] = (s26 & s28[FUNC_SFENCE] & s32[STLB_VALID] & (~(s28[FUNC_SFENCE_MODE_ASID] | s28[FUNC_SFENCE_MODE_VA_ASID]) | (~s32[STLB_G_BIT] & (s32[STLB_ASID_MSB:STLB_ASID_LSB] == sfence_asid))) & (~(s28[FUNC_SFENCE_MODE_VA] | s28[FUNC_SFENCE_MODE_VA_ASID]) | (s32[STLB_VPN_MSB:STLB_VPN_LSB] == sfence_va[(VALEN - 1):(12 + STLB_RAM_AW)])));
assign s34[3] = (s26 & s28[FUNC_SFENCE] & s33[STLB_VALID] & (~(s28[FUNC_SFENCE_MODE_ASID] | s28[FUNC_SFENCE_MODE_VA_ASID]) | (~s33[STLB_G_BIT] & (s33[STLB_ASID_MSB:STLB_ASID_LSB] == sfence_asid))) & (~(s28[FUNC_SFENCE_MODE_VA] | s28[FUNC_SFENCE_MODE_VA_ASID]) | (s33[STLB_VPN_MSB:STLB_VPN_LSB] == sfence_va[(VALEN - 1):(12 + STLB_RAM_AW)])));
endmodule


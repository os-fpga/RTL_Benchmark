// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_pmp_csr (
    core_clk,
    core_reset_n,
    csr_cur_privilege,
    csr_pmp_we,
    csr_pmp_waddr,
    csr_pmp_raddr0,
    csr_pmp_raddr1,
    csr_pmp_wdata,
    pmp_csr_hit0,
    pmp_csr_hit1,
    pmp_csr_rdata0,
    pmp_csr_rdata1,
    csr_pmp0cfg,
    csr_pmp1cfg,
    csr_pmp2cfg,
    csr_pmp3cfg,
    csr_pmp4cfg,
    csr_pmp5cfg,
    csr_pmp6cfg,
    csr_pmp7cfg,
    csr_pmp8cfg,
    csr_pmp9cfg,
    csr_pmp10cfg,
    csr_pmp11cfg,
    csr_pmp12cfg,
    csr_pmp13cfg,
    csr_pmp14cfg,
    csr_pmp15cfg,
    csr_pmp16cfg,
    csr_pmp17cfg,
    csr_pmp18cfg,
    csr_pmp19cfg,
    csr_pmp20cfg,
    csr_pmp21cfg,
    csr_pmp22cfg,
    csr_pmp23cfg,
    csr_pmp24cfg,
    csr_pmp25cfg,
    csr_pmp26cfg,
    csr_pmp27cfg,
    csr_pmp28cfg,
    csr_pmp29cfg,
    csr_pmp30cfg,
    csr_pmp31cfg,
    csr_pmp0addr,
    csr_pmp1addr,
    csr_pmp2addr,
    csr_pmp3addr,
    csr_pmp4addr,
    csr_pmp5addr,
    csr_pmp6addr,
    csr_pmp7addr,
    csr_pmp8addr,
    csr_pmp9addr,
    csr_pmp10addr,
    csr_pmp11addr,
    csr_pmp12addr,
    csr_pmp13addr,
    csr_pmp14addr,
    csr_pmp15addr,
    csr_pmp16addr,
    csr_pmp17addr,
    csr_pmp18addr,
    csr_pmp19addr,
    csr_pmp20addr,
    csr_pmp21addr,
    csr_pmp22addr,
    csr_pmp23addr,
    csr_pmp24addr,
    csr_pmp25addr,
    csr_pmp26addr,
    csr_pmp27addr,
    csr_pmp28addr,
    csr_pmp29addr,
    csr_pmp30addr,
    csr_pmp31addr,
    reg_pmp_we
);
parameter PALEN = 32;
parameter PMP_ENTRIES = 1;
parameter PMP_GRANULARITY = 8;
localparam PMPCFG_L = 7;
localparam PMPCFG_A_MSB = 4;
localparam PMPCFG_A_LSB = 3;
localparam PMPCFG_X = 2;
localparam PMPCFG_W = 1;
localparam PMPCFG_R = 0;
localparam PMP_A_OFF = 2'b00;
localparam PMP_A_TOR = 2'b01;
localparam PMP_A_NA4 = 2'b10;
localparam PMP_A_NAPOT = 2'b11;
localparam PRIVILEGE_USER = 2'b00;
localparam PRIVILEGE_SUPERVISOR = 2'b01;
localparam PRIVILEGE_MACHINE = 2'b11;
localparam PMP_G = $unsigned($clog2(PMP_GRANULARITY)) - 2;
input core_clk;
input core_reset_n;
input [1:0] csr_cur_privilege;
input csr_pmp_we;
input [11:0] csr_pmp_waddr;
input [11:0] csr_pmp_raddr0;
input [11:0] csr_pmp_raddr1;
input [31:0] csr_pmp_wdata;
output pmp_csr_hit0;
output pmp_csr_hit1;
output [31:0] pmp_csr_rdata0;
output [31:0] pmp_csr_rdata1;
output [7:0] csr_pmp0cfg;
output [7:0] csr_pmp1cfg;
output [7:0] csr_pmp2cfg;
output [7:0] csr_pmp3cfg;
output [7:0] csr_pmp4cfg;
output [7:0] csr_pmp5cfg;
output [7:0] csr_pmp6cfg;
output [7:0] csr_pmp7cfg;
output [7:0] csr_pmp8cfg;
output [7:0] csr_pmp9cfg;
output [7:0] csr_pmp10cfg;
output [7:0] csr_pmp11cfg;
output [7:0] csr_pmp12cfg;
output [7:0] csr_pmp13cfg;
output [7:0] csr_pmp14cfg;
output [7:0] csr_pmp15cfg;
output [7:0] csr_pmp16cfg;
output [7:0] csr_pmp17cfg;
output [7:0] csr_pmp18cfg;
output [7:0] csr_pmp19cfg;
output [7:0] csr_pmp20cfg;
output [7:0] csr_pmp21cfg;
output [7:0] csr_pmp22cfg;
output [7:0] csr_pmp23cfg;
output [7:0] csr_pmp24cfg;
output [7:0] csr_pmp25cfg;
output [7:0] csr_pmp26cfg;
output [7:0] csr_pmp27cfg;
output [7:0] csr_pmp28cfg;
output [7:0] csr_pmp29cfg;
output [7:0] csr_pmp30cfg;
output [7:0] csr_pmp31cfg;
output [(PALEN - 1):2] csr_pmp0addr;
output [(PALEN - 1):2] csr_pmp1addr;
output [(PALEN - 1):2] csr_pmp2addr;
output [(PALEN - 1):2] csr_pmp3addr;
output [(PALEN - 1):2] csr_pmp4addr;
output [(PALEN - 1):2] csr_pmp5addr;
output [(PALEN - 1):2] csr_pmp6addr;
output [(PALEN - 1):2] csr_pmp7addr;
output [(PALEN - 1):2] csr_pmp8addr;
output [(PALEN - 1):2] csr_pmp9addr;
output [(PALEN - 1):2] csr_pmp10addr;
output [(PALEN - 1):2] csr_pmp11addr;
output [(PALEN - 1):2] csr_pmp12addr;
output [(PALEN - 1):2] csr_pmp13addr;
output [(PALEN - 1):2] csr_pmp14addr;
output [(PALEN - 1):2] csr_pmp15addr;
output [(PALEN - 1):2] csr_pmp16addr;
output [(PALEN - 1):2] csr_pmp17addr;
output [(PALEN - 1):2] csr_pmp18addr;
output [(PALEN - 1):2] csr_pmp19addr;
output [(PALEN - 1):2] csr_pmp20addr;
output [(PALEN - 1):2] csr_pmp21addr;
output [(PALEN - 1):2] csr_pmp22addr;
output [(PALEN - 1):2] csr_pmp23addr;
output [(PALEN - 1):2] csr_pmp24addr;
output [(PALEN - 1):2] csr_pmp25addr;
output [(PALEN - 1):2] csr_pmp26addr;
output [(PALEN - 1):2] csr_pmp27addr;
output [(PALEN - 1):2] csr_pmp28addr;
output [(PALEN - 1):2] csr_pmp29addr;
output [(PALEN - 1):2] csr_pmp30addr;
output [(PALEN - 1):2] csr_pmp31addr;
output reg reg_pmp_we;


wire [31:0] sel_wr_pmpcfg;
wire [31:0] sel_wr_pmpaddr;
wire [31:0] sel0_rd_pmpcfg;
wire [31:0] sel1_rd_pmpcfg;
wire [31:0] sel0_rd_pmpaddr;
wire [31:0] sel1_rd_pmpaddr;
wire [31:0] csr_pmpcfg_we;
wire [31:0] csr_pmpaddr_we;
wire [7:0] reg_pmpcfg[0:31];
wire [7:0] csr_pmpcfg_wdata[0:31];
wire reg_pmpcfg_l[0:31];
wire [1:0] reg_pmpcfg_a[0:31];
wire reg_pmpcfg_x[0:31];
wire reg_pmpcfg_w[0:31];
wire reg_pmpcfg_r[0:31];
wire [(PALEN - 1):2] reg_pmpaddr[0:31];
wire [(PMP_G - 1):0] csr_pmpaddr_g[0:31];
wire [31:0] csr_pmpcfg0[0:7];
wire [31:0] csr_pmpcfg1[0:7];
wire [31:0] csr_pmpaddr0[0:31];
wire [31:0] csr_pmpaddr1[0:31];
generate
    genvar i;
    genvar j;
    for (i = 0; i <= 31; i = i + 1) begin:gen_sel_wr
        if (i[2] == 1'b0) begin:gen_sel_wr_pmpcfg_0_2_even
            assign sel_wr_pmpcfg[i] = (csr_pmp_waddr == {8'h3a,1'b0,i[4:2]});
        end
        else begin:gen_sel_wr_pmpcfg_0_2_odd
            assign sel_wr_pmpcfg[i] = (csr_pmp_waddr == {8'h3a,1'b0,i[4:2]});
        end
        assign sel_wr_pmpaddr[i] = (csr_pmp_waddr == (12'h3b0 + {7'h0,i[4:0]}));
    end
    for (i = 0; i <= 31; i = i + 1) begin:gen_sel_rd
        if (i[2] == 1'b0) begin:gen_sel_rd_pmpcfg_0_2_even
            assign sel0_rd_pmpcfg[i] = (csr_pmp_raddr0 == {8'h3a,1'b0,i[4:2]});
            assign sel1_rd_pmpcfg[i] = (csr_pmp_raddr1 == {8'h3a,1'b0,i[4:2]});
        end
        else begin:gen_sel_rd_pmpcfg_0_2_odd
            assign sel0_rd_pmpcfg[i] = (csr_pmp_raddr0 == {8'h3a,1'b0,i[4:2]});
            assign sel1_rd_pmpcfg[i] = (csr_pmp_raddr1 == {8'h3a,1'b0,i[4:2]});
        end
        assign sel0_rd_pmpaddr[i] = (csr_pmp_raddr0 == (12'h3b0 + {7'h0,i[4:0]}));
        assign sel1_rd_pmpaddr[i] = (csr_pmp_raddr1 == (12'h3b0 + {7'h0,i[4:0]}));
    end
    for (i = 0; i <= 31; i = i + 1) begin:gen_csr_we
        assign csr_pmpcfg_we[i] = csr_pmp_we & sel_wr_pmpcfg[i] & (csr_cur_privilege == PRIVILEGE_MACHINE) & (PMP_ENTRIES >= (i + 1)) & (~reg_pmpcfg_l[i]);
        if (i < 31) begin:gen_csr_pmpaddr_we_lt_normal
            assign csr_pmpaddr_we[i] = csr_pmp_we & sel_wr_pmpaddr[i] & (csr_cur_privilege == PRIVILEGE_MACHINE) & (PMP_ENTRIES >= (i + 1)) & (~reg_pmpcfg_l[i]) & (~((reg_pmpcfg_a[i + 1] == PMP_A_TOR) & reg_pmpcfg_l[i + 1]));
        end
        else begin:gen_csr_pmpaddr_we_ge_last
            assign csr_pmpaddr_we[i] = csr_pmp_we & sel_wr_pmpaddr[i] & (csr_cur_privilege == PRIVILEGE_MACHINE) & (PMP_ENTRIES >= (i + 1)) & (~reg_pmpcfg_l[i]);
        end
    end
    for (i = 0; i <= 7; i = i + 1) begin:gen_csr_wdata_i
        for (j = 0; j <= 3; j = j + 1) begin:gen_csr_wdata_j
            assign csr_pmpcfg_wdata[i * 4 + j] = (csr_pmp_wdata[PMPCFG_A_MSB + j * 8:PMPCFG_A_LSB + j * 8] == PMP_A_NA4) ? {csr_pmp_wdata[7 + j * 8:5 + j * 8],PMP_A_OFF,csr_pmp_wdata[2 + j * 8:0 + j * 8]} : {csr_pmp_wdata[7 + j * 8:0 + j * 8]};
        end
    end
    for (i = 0; i <= 31; i = i + 1) begin:gen_pmpcfg
        assign reg_pmpcfg[i] = {reg_pmpcfg_l[i],2'b00,reg_pmpcfg_a[i],reg_pmpcfg_x[i],reg_pmpcfg_w[i],reg_pmpcfg_r[i]};
        if (PMP_ENTRIES >= (i + 1)) begin:gen_reg_pmpcfg_tmp
            reg reg_pmpcfg_l_tmp;
            reg [1:0] reg_pmpcfg_a_tmp;
            reg reg_pmpcfg_x_tmp;
            reg reg_pmpcfg_w_tmp;
            reg reg_pmpcfg_r_tmp;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    reg_pmpcfg_l_tmp <= 1'b0;
                    reg_pmpcfg_a_tmp <= 2'b0;
                    reg_pmpcfg_x_tmp <= 1'b0;
                    reg_pmpcfg_w_tmp <= 1'b0;
                    reg_pmpcfg_r_tmp <= 1'b0;
                end
                else if (csr_pmpcfg_we[i]) begin
                    reg_pmpcfg_l_tmp <= csr_pmpcfg_wdata[i][PMPCFG_L];
                    reg_pmpcfg_a_tmp <= csr_pmpcfg_wdata[i][PMPCFG_A_MSB:PMPCFG_A_LSB];
                    reg_pmpcfg_x_tmp <= csr_pmpcfg_wdata[i][PMPCFG_X];
                    reg_pmpcfg_w_tmp <= csr_pmpcfg_wdata[i][PMPCFG_W];
                    reg_pmpcfg_r_tmp <= csr_pmpcfg_wdata[i][PMPCFG_R];
                end
            end

            assign reg_pmpcfg_l[i] = reg_pmpcfg_l_tmp;
            assign reg_pmpcfg_a[i] = reg_pmpcfg_a_tmp;
            assign reg_pmpcfg_x[i] = reg_pmpcfg_x_tmp;
            assign reg_pmpcfg_w[i] = reg_pmpcfg_w_tmp;
            assign reg_pmpcfg_r[i] = reg_pmpcfg_r_tmp;
        end
        else begin:gen_no_reg_pmpcfg_tmp
            assign reg_pmpcfg_l[i] = 1'b0;
            assign reg_pmpcfg_a[i] = 2'b0;
            assign reg_pmpcfg_x[i] = 1'b0;
            assign reg_pmpcfg_w[i] = 1'b0;
            assign reg_pmpcfg_r[i] = 1'b0;
            wire [7:0] nds_unused_csr_pmpcfg_wdata = csr_pmpcfg_wdata[i];
        end
    end
    wire sel0_rd_pmpcfg_00_03 = sel0_rd_pmpcfg[3] | sel0_rd_pmpcfg[2] | sel0_rd_pmpcfg[1] | sel0_rd_pmpcfg[0];
    wire sel0_rd_pmpcfg_04_07 = sel0_rd_pmpcfg[7] | sel0_rd_pmpcfg[6] | sel0_rd_pmpcfg[5] | sel0_rd_pmpcfg[4];
    wire sel0_rd_pmpcfg_08_0b = sel0_rd_pmpcfg[11] | sel0_rd_pmpcfg[10] | sel0_rd_pmpcfg[9] | sel0_rd_pmpcfg[8];
    wire sel0_rd_pmpcfg_0c_0f = sel0_rd_pmpcfg[15] | sel0_rd_pmpcfg[14] | sel0_rd_pmpcfg[13] | sel0_rd_pmpcfg[12];
    wire sel0_rd_pmpcfg_10_13 = sel0_rd_pmpcfg[19] | sel0_rd_pmpcfg[18] | sel0_rd_pmpcfg[17] | sel0_rd_pmpcfg[16];
    wire sel0_rd_pmpcfg_14_17 = sel0_rd_pmpcfg[23] | sel0_rd_pmpcfg[22] | sel0_rd_pmpcfg[21] | sel0_rd_pmpcfg[20];
    wire sel0_rd_pmpcfg_18_1b = sel0_rd_pmpcfg[27] | sel0_rd_pmpcfg[26] | sel0_rd_pmpcfg[25] | sel0_rd_pmpcfg[24];
    wire sel0_rd_pmpcfg_1c_1f = sel0_rd_pmpcfg[31] | sel0_rd_pmpcfg[30] | sel0_rd_pmpcfg[29] | sel0_rd_pmpcfg[28];
    wire sel1_rd_pmpcfg_00_03 = sel1_rd_pmpcfg[3] | sel1_rd_pmpcfg[2] | sel1_rd_pmpcfg[1] | sel1_rd_pmpcfg[0];
    wire sel1_rd_pmpcfg_04_07 = sel1_rd_pmpcfg[7] | sel1_rd_pmpcfg[6] | sel1_rd_pmpcfg[5] | sel1_rd_pmpcfg[4];
    wire sel1_rd_pmpcfg_08_0b = sel1_rd_pmpcfg[11] | sel1_rd_pmpcfg[10] | sel1_rd_pmpcfg[9] | sel1_rd_pmpcfg[8];
    wire sel1_rd_pmpcfg_0c_0f = sel1_rd_pmpcfg[15] | sel1_rd_pmpcfg[14] | sel1_rd_pmpcfg[13] | sel1_rd_pmpcfg[12];
    wire sel1_rd_pmpcfg_10_13 = sel1_rd_pmpcfg[19] | sel1_rd_pmpcfg[18] | sel1_rd_pmpcfg[17] | sel1_rd_pmpcfg[16];
    wire sel1_rd_pmpcfg_14_17 = sel1_rd_pmpcfg[23] | sel1_rd_pmpcfg[22] | sel1_rd_pmpcfg[21] | sel1_rd_pmpcfg[20];
    wire sel1_rd_pmpcfg_18_1b = sel1_rd_pmpcfg[27] | sel1_rd_pmpcfg[26] | sel1_rd_pmpcfg[25] | sel1_rd_pmpcfg[24];
    wire sel1_rd_pmpcfg_1c_1f = sel1_rd_pmpcfg[31] | sel1_rd_pmpcfg[30] | sel1_rd_pmpcfg[29] | sel1_rd_pmpcfg[28];
    assign csr_pmpcfg0[0] = {32{sel0_rd_pmpcfg_00_03}} & {reg_pmpcfg[3],reg_pmpcfg[2],reg_pmpcfg[1],reg_pmpcfg[0]};
    assign csr_pmpcfg0[1] = {32{sel0_rd_pmpcfg_04_07}} & {reg_pmpcfg[7],reg_pmpcfg[6],reg_pmpcfg[5],reg_pmpcfg[4]};
    assign csr_pmpcfg0[2] = {32{sel0_rd_pmpcfg_08_0b}} & {reg_pmpcfg[11],reg_pmpcfg[10],reg_pmpcfg[9],reg_pmpcfg[8]};
    assign csr_pmpcfg0[3] = {32{sel0_rd_pmpcfg_0c_0f}} & {reg_pmpcfg[15],reg_pmpcfg[14],reg_pmpcfg[13],reg_pmpcfg[12]};
    assign csr_pmpcfg0[4] = {32{sel0_rd_pmpcfg_10_13}} & {reg_pmpcfg[19],reg_pmpcfg[18],reg_pmpcfg[17],reg_pmpcfg[16]};
    assign csr_pmpcfg0[5] = {32{sel0_rd_pmpcfg_14_17}} & {reg_pmpcfg[23],reg_pmpcfg[22],reg_pmpcfg[21],reg_pmpcfg[20]};
    assign csr_pmpcfg0[6] = {32{sel0_rd_pmpcfg_18_1b}} & {reg_pmpcfg[27],reg_pmpcfg[26],reg_pmpcfg[25],reg_pmpcfg[24]};
    assign csr_pmpcfg0[7] = {32{sel0_rd_pmpcfg_1c_1f}} & {reg_pmpcfg[31],reg_pmpcfg[30],reg_pmpcfg[29],reg_pmpcfg[28]};
    assign csr_pmpcfg1[0] = {32{sel1_rd_pmpcfg_00_03}} & {reg_pmpcfg[3],reg_pmpcfg[2],reg_pmpcfg[1],reg_pmpcfg[0]};
    assign csr_pmpcfg1[1] = {32{sel1_rd_pmpcfg_04_07}} & {reg_pmpcfg[7],reg_pmpcfg[6],reg_pmpcfg[5],reg_pmpcfg[4]};
    assign csr_pmpcfg1[2] = {32{sel1_rd_pmpcfg_08_0b}} & {reg_pmpcfg[11],reg_pmpcfg[10],reg_pmpcfg[9],reg_pmpcfg[8]};
    assign csr_pmpcfg1[3] = {32{sel1_rd_pmpcfg_0c_0f}} & {reg_pmpcfg[15],reg_pmpcfg[14],reg_pmpcfg[13],reg_pmpcfg[12]};
    assign csr_pmpcfg1[4] = {32{sel1_rd_pmpcfg_10_13}} & {reg_pmpcfg[19],reg_pmpcfg[18],reg_pmpcfg[17],reg_pmpcfg[16]};
    assign csr_pmpcfg1[5] = {32{sel1_rd_pmpcfg_14_17}} & {reg_pmpcfg[23],reg_pmpcfg[22],reg_pmpcfg[21],reg_pmpcfg[20]};
    assign csr_pmpcfg1[6] = {32{sel1_rd_pmpcfg_18_1b}} & {reg_pmpcfg[27],reg_pmpcfg[26],reg_pmpcfg[25],reg_pmpcfg[24]};
    assign csr_pmpcfg1[7] = {32{sel1_rd_pmpcfg_1c_1f}} & {reg_pmpcfg[31],reg_pmpcfg[30],reg_pmpcfg[29],reg_pmpcfg[28]};
    for (i = 0; i <= 31; i = i + 1) begin:gen_csr_pmpaddr
        if (PMP_ENTRIES >= (i + 1)) begin:gen_reg_pmp_addr_tmp
            reg [(PALEN - 1):2] reg_pmp_addr_tmp;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    reg_pmp_addr_tmp <= {(PALEN - 2){1'b0}};
                end
                else if (csr_pmpaddr_we[i]) begin
                    reg_pmp_addr_tmp <= csr_pmp_wdata[PALEN - 3:0];
                end
            end

            assign reg_pmpaddr[i] = reg_pmp_addr_tmp;
        end
        else begin:gen_no_reg_pmp_addr_tmp
            assign reg_pmpaddr[i] = {(PALEN - 2){1'b0}};
        end
        if (PMP_G > 1) begin:gen_granularity_bt_1
            assign csr_pmpaddr_g[i] = (reg_pmpcfg_a[i] == PMP_A_NAPOT) ? {reg_pmpaddr[i][(PMP_G - 1 + 2)],{(PMP_G - 1){1'b1}}} : {PMP_G{1'b0}};
        end
        else begin:gen_granularity_eq_1
            assign csr_pmpaddr_g[i] = (reg_pmpcfg_a[i] == PMP_A_NAPOT) ? reg_pmpaddr[i][2] : 1'b0;
        end
        if ((PALEN - 2) == 32) begin:gen_pmpaddr_pa_34b
            assign csr_pmpaddr0[i] = {32{sel0_rd_pmpaddr[i]}} & {reg_pmpaddr[i][(PALEN - 1):(PMP_G + 2)],csr_pmpaddr_g[i]};
            assign csr_pmpaddr1[i] = {32{sel1_rd_pmpaddr[i]}} & {reg_pmpaddr[i][(PALEN - 1):(PMP_G + 2)],csr_pmpaddr_g[i]};
        end
        else begin:gen_pmpaddr_pa_non34b
            assign csr_pmpaddr0[i] = {32{sel0_rd_pmpaddr[i]}} & {{(32 - PALEN + 2){1'b0}},reg_pmpaddr[i][(PALEN - 1):(PMP_G + 2)],csr_pmpaddr_g[i]};
            assign csr_pmpaddr1[i] = {32{sel1_rd_pmpaddr[i]}} & {{(32 - PALEN + 2){1'b0}},reg_pmpaddr[i][(PALEN - 1):(PMP_G + 2)],csr_pmpaddr_g[i]};
        end
    end
endgenerate
assign pmp_csr_rdata0 = {32{1'b0}} | csr_pmpcfg0[0] | csr_pmpcfg0[1] | csr_pmpcfg0[2] | csr_pmpcfg0[3] | csr_pmpcfg0[4] | csr_pmpcfg0[5] | csr_pmpcfg0[6] | csr_pmpcfg0[7] | csr_pmpaddr0[0] | csr_pmpaddr0[1] | csr_pmpaddr0[2] | csr_pmpaddr0[3] | csr_pmpaddr0[4] | csr_pmpaddr0[5] | csr_pmpaddr0[6] | csr_pmpaddr0[7] | csr_pmpaddr0[8] | csr_pmpaddr0[9] | csr_pmpaddr0[10] | csr_pmpaddr0[11] | csr_pmpaddr0[12] | csr_pmpaddr0[13] | csr_pmpaddr0[14] | csr_pmpaddr0[15] | csr_pmpaddr0[16] | csr_pmpaddr0[17] | csr_pmpaddr0[18] | csr_pmpaddr0[19] | csr_pmpaddr0[20] | csr_pmpaddr0[21] | csr_pmpaddr0[22] | csr_pmpaddr0[23] | csr_pmpaddr0[24] | csr_pmpaddr0[25] | csr_pmpaddr0[26] | csr_pmpaddr0[27] | csr_pmpaddr0[28] | csr_pmpaddr0[29] | csr_pmpaddr0[30] | csr_pmpaddr0[31];
assign pmp_csr_rdata1 = {32{1'b0}} | csr_pmpcfg1[0] | csr_pmpcfg1[1] | csr_pmpcfg1[2] | csr_pmpcfg1[3] | csr_pmpcfg1[4] | csr_pmpcfg1[5] | csr_pmpcfg1[6] | csr_pmpcfg1[7] | csr_pmpaddr1[0] | csr_pmpaddr1[1] | csr_pmpaddr1[2] | csr_pmpaddr1[3] | csr_pmpaddr1[4] | csr_pmpaddr1[5] | csr_pmpaddr1[6] | csr_pmpaddr1[7] | csr_pmpaddr1[8] | csr_pmpaddr1[9] | csr_pmpaddr1[10] | csr_pmpaddr1[11] | csr_pmpaddr1[12] | csr_pmpaddr1[13] | csr_pmpaddr1[14] | csr_pmpaddr1[15] | csr_pmpaddr1[16] | csr_pmpaddr1[17] | csr_pmpaddr1[18] | csr_pmpaddr1[19] | csr_pmpaddr1[20] | csr_pmpaddr1[21] | csr_pmpaddr1[22] | csr_pmpaddr1[23] | csr_pmpaddr1[24] | csr_pmpaddr1[25] | csr_pmpaddr1[26] | csr_pmpaddr1[27] | csr_pmpaddr1[28] | csr_pmpaddr1[29] | csr_pmpaddr1[30] | csr_pmpaddr1[31];
assign pmp_csr_hit0 = (|sel0_rd_pmpcfg) | (|sel0_rd_pmpaddr);
assign pmp_csr_hit1 = (|sel1_rd_pmpcfg) | (|sel1_rd_pmpaddr);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        reg_pmp_we <= 1'b0;
    end
    else begin
        reg_pmp_we <= (|csr_pmpcfg_we) | (|csr_pmpaddr_we);
    end
end

assign csr_pmp0cfg = reg_pmpcfg[0];
assign csr_pmp0addr = reg_pmpaddr[0];
assign csr_pmp1cfg = reg_pmpcfg[1];
assign csr_pmp1addr = reg_pmpaddr[1];
assign csr_pmp2cfg = reg_pmpcfg[2];
assign csr_pmp2addr = reg_pmpaddr[2];
assign csr_pmp3cfg = reg_pmpcfg[3];
assign csr_pmp3addr = reg_pmpaddr[3];
assign csr_pmp4cfg = reg_pmpcfg[4];
assign csr_pmp4addr = reg_pmpaddr[4];
assign csr_pmp5cfg = reg_pmpcfg[5];
assign csr_pmp5addr = reg_pmpaddr[5];
assign csr_pmp6cfg = reg_pmpcfg[6];
assign csr_pmp6addr = reg_pmpaddr[6];
assign csr_pmp7cfg = reg_pmpcfg[7];
assign csr_pmp7addr = reg_pmpaddr[7];
assign csr_pmp8cfg = reg_pmpcfg[8];
assign csr_pmp8addr = reg_pmpaddr[8];
assign csr_pmp9cfg = reg_pmpcfg[9];
assign csr_pmp9addr = reg_pmpaddr[9];
assign csr_pmp10cfg = reg_pmpcfg[10];
assign csr_pmp10addr = reg_pmpaddr[10];
assign csr_pmp11cfg = reg_pmpcfg[11];
assign csr_pmp11addr = reg_pmpaddr[11];
assign csr_pmp12cfg = reg_pmpcfg[12];
assign csr_pmp12addr = reg_pmpaddr[12];
assign csr_pmp13cfg = reg_pmpcfg[13];
assign csr_pmp13addr = reg_pmpaddr[13];
assign csr_pmp14cfg = reg_pmpcfg[14];
assign csr_pmp14addr = reg_pmpaddr[14];
assign csr_pmp15cfg = reg_pmpcfg[15];
assign csr_pmp15addr = reg_pmpaddr[15];
assign csr_pmp16cfg = reg_pmpcfg[16];
assign csr_pmp16addr = reg_pmpaddr[16];
assign csr_pmp17cfg = reg_pmpcfg[17];
assign csr_pmp17addr = reg_pmpaddr[17];
assign csr_pmp18cfg = reg_pmpcfg[18];
assign csr_pmp18addr = reg_pmpaddr[18];
assign csr_pmp19cfg = reg_pmpcfg[19];
assign csr_pmp19addr = reg_pmpaddr[19];
assign csr_pmp20cfg = reg_pmpcfg[20];
assign csr_pmp20addr = reg_pmpaddr[20];
assign csr_pmp21cfg = reg_pmpcfg[21];
assign csr_pmp21addr = reg_pmpaddr[21];
assign csr_pmp22cfg = reg_pmpcfg[22];
assign csr_pmp22addr = reg_pmpaddr[22];
assign csr_pmp23cfg = reg_pmpcfg[23];
assign csr_pmp23addr = reg_pmpaddr[23];
assign csr_pmp24cfg = reg_pmpcfg[24];
assign csr_pmp24addr = reg_pmpaddr[24];
assign csr_pmp25cfg = reg_pmpcfg[25];
assign csr_pmp25addr = reg_pmpaddr[25];
assign csr_pmp26cfg = reg_pmpcfg[26];
assign csr_pmp26addr = reg_pmpaddr[26];
assign csr_pmp27cfg = reg_pmpcfg[27];
assign csr_pmp27addr = reg_pmpaddr[27];
assign csr_pmp28cfg = reg_pmpcfg[28];
assign csr_pmp28addr = reg_pmpaddr[28];
assign csr_pmp29cfg = reg_pmpcfg[29];
assign csr_pmp29addr = reg_pmpaddr[29];
assign csr_pmp30cfg = reg_pmpcfg[30];
assign csr_pmp30addr = reg_pmpaddr[30];
assign csr_pmp31cfg = reg_pmpcfg[31];
assign csr_pmp31addr = reg_pmpaddr[31];
endmodule


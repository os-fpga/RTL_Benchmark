// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_pma_csr (
    core_clk,
    core_reset_n,
    csr_cur_privilege,
    csr_pma_we,
    csr_pma_waddr,
    csr_pma_raddr0,
    csr_pma_raddr1,
    csr_pma_wdata,
    pma_csr_hit0,
    pma_csr_hit1,
    pma_csr_rdata0,
    pma_csr_rdata1,
    csr_pma0cfg,
    csr_pma1cfg,
    csr_pma2cfg,
    csr_pma3cfg,
    csr_pma4cfg,
    csr_pma5cfg,
    csr_pma6cfg,
    csr_pma7cfg,
    csr_pma8cfg,
    csr_pma9cfg,
    csr_pma10cfg,
    csr_pma11cfg,
    csr_pma12cfg,
    csr_pma13cfg,
    csr_pma14cfg,
    csr_pma15cfg,
    csr_pma0addr,
    csr_pma1addr,
    csr_pma2addr,
    csr_pma3addr,
    csr_pma4addr,
    csr_pma5addr,
    csr_pma6addr,
    csr_pma7addr,
    csr_pma8addr,
    csr_pma9addr,
    csr_pma10addr,
    csr_pma11addr,
    csr_pma12addr,
    csr_pma13addr,
    csr_pma14addr,
    csr_pma15addr,
    reg_pma_we
);
parameter PALEN = 32;
parameter PMA_ENTRIES = 0;
parameter CLUSTER_SUPPORT_INT = 0;
localparam PMACFG_E_MSB = 1;
localparam PMACFG_E_LSB = 0;
localparam PMACFG_M_MSB = 5;
localparam PMACFG_M_LSB = 2;
localparam PMACFG_NAMO = 6;
localparam PMACFG_UNUSED = 7;
localparam PMA_E_OFF = 2'b00;
localparam PMA_E_TOR = 2'b01;
localparam PMA_E_NA4 = 2'b10;
localparam PMA_E_NAPOT = 2'b11;
localparam PMA_G = ($unsigned($clog2(4096)) - 2);
localparam PRIVILEGE_USER = 2'b00;
localparam PRIVILEGE_SUPERVISOR = 2'b01;
localparam PRIVILEGE_MACHINE = 2'b11;
input core_clk;
input core_reset_n;
input [1:0] csr_cur_privilege;
input csr_pma_we;
input [11:0] csr_pma_waddr;
input [11:0] csr_pma_raddr0;
input [11:0] csr_pma_raddr1;
input [31:0] csr_pma_wdata;
output pma_csr_hit0;
output pma_csr_hit1;
output [31:0] pma_csr_rdata0;
output [31:0] pma_csr_rdata1;
output [7:0] csr_pma0cfg;
output [7:0] csr_pma1cfg;
output [7:0] csr_pma2cfg;
output [7:0] csr_pma3cfg;
output [7:0] csr_pma4cfg;
output [7:0] csr_pma5cfg;
output [7:0] csr_pma6cfg;
output [7:0] csr_pma7cfg;
output [7:0] csr_pma8cfg;
output [7:0] csr_pma9cfg;
output [7:0] csr_pma10cfg;
output [7:0] csr_pma11cfg;
output [7:0] csr_pma12cfg;
output [7:0] csr_pma13cfg;
output [7:0] csr_pma14cfg;
output [7:0] csr_pma15cfg;
output [(PALEN - 1):2] csr_pma0addr;
output [(PALEN - 1):2] csr_pma1addr;
output [(PALEN - 1):2] csr_pma2addr;
output [(PALEN - 1):2] csr_pma3addr;
output [(PALEN - 1):2] csr_pma4addr;
output [(PALEN - 1):2] csr_pma5addr;
output [(PALEN - 1):2] csr_pma6addr;
output [(PALEN - 1):2] csr_pma7addr;
output [(PALEN - 1):2] csr_pma8addr;
output [(PALEN - 1):2] csr_pma9addr;
output [(PALEN - 1):2] csr_pma10addr;
output [(PALEN - 1):2] csr_pma11addr;
output [(PALEN - 1):2] csr_pma12addr;
output [(PALEN - 1):2] csr_pma13addr;
output [(PALEN - 1):2] csr_pma14addr;
output [(PALEN - 1):2] csr_pma15addr;
output reg reg_pma_we;


wire [15:0] sel_wr_pmacfg;
wire [15:0] sel_wr_pmaaddr;
wire [15:0] sel0_rd_pmacfg;
wire [15:0] sel0_rd_pmaaddr;
wire [15:0] sel1_rd_pmacfg;
wire [15:0] sel1_rd_pmaaddr;
wire [15:0] csr_pmacfg_we;
wire [15:0] csr_pmaaddr_we;
wire [7:0] reg_pmacfg[0:15];
wire [7:0] csr_pmacfg_wdata[0:15];
wire [1:0] reg_pmacfg_e[0:15];
wire [3:0] reg_pmacfg_m[0:15];
wire reg_pmacfg_namo[0:15];
wire [(PALEN - 1):2] reg_pmaaddr[0:15];
wire [31:0] csr_pmacfg0[0:3];
wire [31:0] csr_pmacfg1[0:3];
wire [31:0] csr_pmaaddr0[0:15];
wire [31:0] csr_pmaaddr1[0:15];
generate
    genvar i;
    genvar j;
    for (i = 0; i <= 15; i = i + 1) begin:gen_sel_wr
        if (i[2] == 1'b0) begin:gen_sel_wr_pmacfg_0_2
            assign sel_wr_pmacfg[i] = (csr_pma_waddr == {8'hbc,2'b0,i[3:2]});
        end
        else begin:gen_sel_wr_pmacfg_0_2
            assign sel_wr_pmacfg[i] = (csr_pma_waddr == {8'hbc,2'b0,i[3:2]});
        end
        assign sel_wr_pmaaddr[i] = (csr_pma_waddr == {8'hbd,i[3:0]});
    end
    for (i = 0; i <= 15; i = i + 1) begin:gen_csr_we
        assign csr_pmacfg_we[i] = csr_pma_we & sel_wr_pmacfg[i] & (csr_cur_privilege == PRIVILEGE_MACHINE) & (PMA_ENTRIES >= (i + 1));
        assign csr_pmaaddr_we[i] = csr_pma_we & sel_wr_pmaaddr[i] & (csr_cur_privilege == PRIVILEGE_MACHINE) & (PMA_ENTRIES >= (i + 1));
    end
    for (i = 0; i <= 3; i = i + 1) begin:gen_csr_wdata_i
        for (j = 0; j <= 3; j = j + 1) begin:gen_csr_wdata_j
            assign csr_pmacfg_wdata[i * 4 + j][PMACFG_E_MSB:PMACFG_E_LSB] = ((csr_pma_wdata[PMACFG_E_MSB + j * 8:PMACFG_E_LSB + j * 8] != PMA_E_NAPOT) ? PMA_E_OFF : PMA_E_NAPOT);
            reg [3:0] csr_pmacfg_mtype;
            reg csr_pmacfg_namo;
            if (CLUSTER_SUPPORT_INT == 1) begin:gen_mp_pma_cfg
                always @* begin
                    casez (csr_pma_wdata[5 + j * 8:2 + j * 8])
                        4'b00??,4'b10?1: begin
                            csr_pmacfg_mtype = csr_pma_wdata[5 + j * 8:2 + j * 8];
                            csr_pmacfg_namo = csr_pma_wdata[6 + j * 8];
                        end
                        4'b01??: begin
                            csr_pmacfg_mtype = 4'b0011;
                            csr_pmacfg_namo = csr_pma_wdata[6 + j * 8];
                        end
                        4'b10?0: begin
                            csr_pmacfg_mtype = csr_pma_wdata[5 + j * 8:2 + j * 8];
                            csr_pmacfg_namo = 1'b1;
                        end
                        4'b11??: begin
                            csr_pmacfg_mtype = 4'b1111;
                            csr_pmacfg_namo = csr_pma_wdata[6 + j * 8];
                        end
                        default: begin
                            csr_pmacfg_mtype = 4'b0;
                            csr_pmacfg_namo = 1'b0;
                        end
                    endcase
                end

            end
            else begin:gen_sp_pma_cfg
                always @* begin
                    casez (csr_pma_wdata[5 + j * 8:2 + j * 8])
                        4'b00??,4'b10??: begin
                            csr_pmacfg_mtype = csr_pma_wdata[5 + j * 8:2 + j * 8];
                            csr_pmacfg_namo = csr_pma_wdata[6 + j * 8];
                        end
                        4'b01??: begin
                            csr_pmacfg_mtype = {3'b010,csr_pma_wdata[2 + j * 8]};
                            csr_pmacfg_namo = csr_pma_wdata[6 + j * 8];
                        end
                        4'b11??: begin
                            csr_pmacfg_mtype = 4'b1111;
                            csr_pmacfg_namo = csr_pma_wdata[6 + j * 8];
                        end
                        default: begin
                            csr_pmacfg_mtype = 4'b0;
                            csr_pmacfg_namo = 1'b0;
                        end
                    endcase
                end

            end
            assign csr_pmacfg_wdata[i * 4 + j][PMACFG_M_MSB:PMACFG_M_LSB] = csr_pmacfg_mtype;
            assign csr_pmacfg_wdata[i * 4 + j][PMACFG_NAMO] = csr_pmacfg_namo;
            assign csr_pmacfg_wdata[i * 4 + j][PMACFG_UNUSED] = 1'b0;
        end
    end
    for (i = 0; i <= 15; i = i + 1) begin:gen_pmacfg
        assign reg_pmacfg[i] = {1'b0,reg_pmacfg_namo[i],reg_pmacfg_m[i],reg_pmacfg_e[i]};
        if (PMA_ENTRIES >= (i + 1)) begin:gen_reg_pmacfg_tmp
            reg [1:0] reg_pmacfg_e_tmp;
            reg [3:0] reg_pmacfg_m_tmp;
            reg reg_pmacfg_namo_tmp;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    reg_pmacfg_e_tmp <= 2'b0;
                    reg_pmacfg_m_tmp <= 4'b0;
                    reg_pmacfg_namo_tmp <= 1'b0;
                end
                else if (csr_pmacfg_we[i]) begin
                    reg_pmacfg_e_tmp <= csr_pmacfg_wdata[i][PMACFG_E_MSB:PMACFG_E_LSB];
                    reg_pmacfg_m_tmp <= csr_pmacfg_wdata[i][PMACFG_M_MSB:PMACFG_M_LSB];
                    reg_pmacfg_namo_tmp <= csr_pmacfg_wdata[i][PMACFG_NAMO];
                end
            end

            assign reg_pmacfg_e[i] = reg_pmacfg_e_tmp;
            assign reg_pmacfg_m[i] = reg_pmacfg_m_tmp;
            assign reg_pmacfg_namo[i] = reg_pmacfg_namo_tmp;
        end
        else begin:gen_no_reg_pmacfg_tmp
            assign reg_pmacfg_e[i] = 2'b0;
            assign reg_pmacfg_m[i] = 4'b0;
            assign reg_pmacfg_namo[i] = 1'b0;
            wire [7:0] nds_unused_csr_pmacfg_wdata = csr_pmacfg_wdata[i];
        end
    end
    for (i = 0; i <= 15; i = i + 1) begin:gen_sel_rd
        if (i[2] == 1'b0) begin:gen_sel_wr_pmacfg_0_2
            assign sel0_rd_pmacfg[i] = (csr_pma_raddr0 == {8'hbc,2'b0,i[3:2]});
            assign sel1_rd_pmacfg[i] = (csr_pma_raddr1 == {8'hbc,2'b0,i[3:2]});
        end
        else begin:gen_sel_wr_pmacfg_0_2
            assign sel0_rd_pmacfg[i] = (csr_pma_raddr0 == {8'hbc,2'b0,i[3:2]});
            assign sel1_rd_pmacfg[i] = (csr_pma_raddr1 == {8'hbc,2'b0,i[3:2]});
        end
        assign sel0_rd_pmaaddr[i] = (csr_pma_raddr0 == {8'hbd,i[3:0]});
        assign sel1_rd_pmaaddr[i] = (csr_pma_raddr1 == {8'hbd,i[3:0]});
    end
    wire sel0_rd_pmacfg_0_3 = sel0_rd_pmacfg[3] | sel0_rd_pmacfg[2] | sel0_rd_pmacfg[1] | sel0_rd_pmacfg[0];
    wire sel0_rd_pmacfg_4_7 = sel0_rd_pmacfg[7] | sel0_rd_pmacfg[6] | sel0_rd_pmacfg[5] | sel0_rd_pmacfg[4];
    wire sel0_rd_pmacfg_8_b = sel0_rd_pmacfg[11] | sel0_rd_pmacfg[10] | sel0_rd_pmacfg[9] | sel0_rd_pmacfg[8];
    wire sel0_rd_pmacfg_c_f = sel0_rd_pmacfg[15] | sel0_rd_pmacfg[14] | sel0_rd_pmacfg[13] | sel0_rd_pmacfg[12];
    wire sel1_rd_pmacfg_0_3 = sel1_rd_pmacfg[3] | sel1_rd_pmacfg[2] | sel1_rd_pmacfg[1] | sel1_rd_pmacfg[0];
    wire sel1_rd_pmacfg_4_7 = sel1_rd_pmacfg[7] | sel1_rd_pmacfg[6] | sel1_rd_pmacfg[5] | sel1_rd_pmacfg[4];
    wire sel1_rd_pmacfg_8_b = sel1_rd_pmacfg[11] | sel1_rd_pmacfg[10] | sel1_rd_pmacfg[9] | sel1_rd_pmacfg[8];
    wire sel1_rd_pmacfg_c_f = sel1_rd_pmacfg[15] | sel1_rd_pmacfg[14] | sel1_rd_pmacfg[13] | sel1_rd_pmacfg[12];
    assign csr_pmacfg0[0] = {32{sel0_rd_pmacfg_0_3}} & {reg_pmacfg[3],reg_pmacfg[2],reg_pmacfg[1],reg_pmacfg[0]};
    assign csr_pmacfg0[1] = {32{sel0_rd_pmacfg_4_7}} & {reg_pmacfg[7],reg_pmacfg[6],reg_pmacfg[5],reg_pmacfg[4]};
    assign csr_pmacfg0[2] = {32{sel0_rd_pmacfg_8_b}} & {reg_pmacfg[11],reg_pmacfg[10],reg_pmacfg[9],reg_pmacfg[8]};
    assign csr_pmacfg0[3] = {32{sel0_rd_pmacfg_c_f}} & {reg_pmacfg[15],reg_pmacfg[14],reg_pmacfg[13],reg_pmacfg[12]};
    assign csr_pmacfg1[0] = {32{sel1_rd_pmacfg_0_3}} & {reg_pmacfg[3],reg_pmacfg[2],reg_pmacfg[1],reg_pmacfg[0]};
    assign csr_pmacfg1[1] = {32{sel1_rd_pmacfg_4_7}} & {reg_pmacfg[7],reg_pmacfg[6],reg_pmacfg[5],reg_pmacfg[4]};
    assign csr_pmacfg1[2] = {32{sel1_rd_pmacfg_8_b}} & {reg_pmacfg[11],reg_pmacfg[10],reg_pmacfg[9],reg_pmacfg[8]};
    assign csr_pmacfg1[3] = {32{sel1_rd_pmacfg_c_f}} & {reg_pmacfg[15],reg_pmacfg[14],reg_pmacfg[13],reg_pmacfg[12]};
    for (i = 0; i <= 15; i = i + 1) begin:gen_csr_pmaaddr
        wire [(PMA_G - 1):0] pmaaddr_g = (reg_pmacfg[i][PMACFG_E_MSB:PMACFG_E_LSB] == PMA_E_NAPOT) ? {reg_pmaaddr[i][(PMA_G - 1 + 2)],{(PMA_G - 1){1'b1}}} : {PMA_G{1'b0}};
        if ((PALEN - 2) == 32) begin:gen_pmaaddr_pa_34b
            assign csr_pmaaddr0[i] = {32{sel0_rd_pmaaddr[i]}} & {reg_pmaaddr[i][(PALEN - 1):(PMA_G + 2)],pmaaddr_g};
            assign csr_pmaaddr1[i] = {32{sel1_rd_pmaaddr[i]}} & {reg_pmaaddr[i][(PALEN - 1):(PMA_G + 2)],pmaaddr_g};
        end
        else begin:gen_pmaaddr_pa_non34b
            assign csr_pmaaddr0[i] = {32{sel0_rd_pmaaddr[i]}} & {{(32 - PALEN + 2){1'b0}},reg_pmaaddr[i][(PALEN - 1):(PMA_G + 2)],pmaaddr_g};
            assign csr_pmaaddr1[i] = {32{sel1_rd_pmaaddr[i]}} & {{(32 - PALEN + 2){1'b0}},reg_pmaaddr[i][(PALEN - 1):(PMA_G + 2)],pmaaddr_g};
        end
        if (PMA_ENTRIES >= (i + 1)) begin:gen_reg_pmaaddr_tmp
            reg [(PALEN - 1):2] reg_pmaaddr_tmp;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    reg_pmaaddr_tmp <= {(PALEN - 2){1'b0}};
                end
                else if (csr_pmaaddr_we[i]) begin
                    reg_pmaaddr_tmp <= csr_pma_wdata[PALEN - 3:0];
                end
            end

            assign reg_pmaaddr[i] = reg_pmaaddr_tmp;
        end
        else begin:gen_no_reg_pmaaddr_tmp
            assign reg_pmaaddr[i] = {(PALEN - 2){1'b0}};
        end
    end
endgenerate
assign pma_csr_rdata0 = {32{1'b0}} | csr_pmacfg0[0] | csr_pmacfg0[1] | csr_pmacfg0[2] | csr_pmacfg0[3] | csr_pmaaddr0[0] | csr_pmaaddr0[1] | csr_pmaaddr0[2] | csr_pmaaddr0[3] | csr_pmaaddr0[4] | csr_pmaaddr0[5] | csr_pmaaddr0[6] | csr_pmaaddr0[7] | csr_pmaaddr0[8] | csr_pmaaddr0[9] | csr_pmaaddr0[10] | csr_pmaaddr0[11] | csr_pmaaddr0[12] | csr_pmaaddr0[13] | csr_pmaaddr0[14] | csr_pmaaddr0[15];
assign pma_csr_rdata1 = {32{1'b0}} | csr_pmacfg1[0] | csr_pmacfg1[1] | csr_pmacfg1[2] | csr_pmacfg1[3] | csr_pmaaddr1[0] | csr_pmaaddr1[1] | csr_pmaaddr1[2] | csr_pmaaddr1[3] | csr_pmaaddr1[4] | csr_pmaaddr1[5] | csr_pmaaddr1[6] | csr_pmaaddr1[7] | csr_pmaaddr1[8] | csr_pmaaddr1[9] | csr_pmaaddr1[10] | csr_pmaaddr1[11] | csr_pmaaddr1[12] | csr_pmaaddr1[13] | csr_pmaaddr1[14] | csr_pmaaddr1[15];
assign pma_csr_hit0 = (|sel0_rd_pmacfg) | (|sel0_rd_pmaaddr);
assign pma_csr_hit1 = (|sel1_rd_pmacfg) | (|sel1_rd_pmaaddr);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        reg_pma_we <= 1'b0;
    end
    else begin
        reg_pma_we <= (|csr_pmacfg_we) | (|csr_pmaaddr_we);
    end
end

assign csr_pma0cfg = reg_pmacfg[0];
assign csr_pma0addr = reg_pmaaddr[0];
assign csr_pma1cfg = reg_pmacfg[1];
assign csr_pma1addr = reg_pmaaddr[1];
assign csr_pma2cfg = reg_pmacfg[2];
assign csr_pma2addr = reg_pmaaddr[2];
assign csr_pma3cfg = reg_pmacfg[3];
assign csr_pma3addr = reg_pmaaddr[3];
assign csr_pma4cfg = reg_pmacfg[4];
assign csr_pma4addr = reg_pmaaddr[4];
assign csr_pma5cfg = reg_pmacfg[5];
assign csr_pma5addr = reg_pmaaddr[5];
assign csr_pma6cfg = reg_pmacfg[6];
assign csr_pma6addr = reg_pmaaddr[6];
assign csr_pma7cfg = reg_pmacfg[7];
assign csr_pma7addr = reg_pmaaddr[7];
assign csr_pma8cfg = reg_pmacfg[8];
assign csr_pma8addr = reg_pmaaddr[8];
assign csr_pma9cfg = reg_pmacfg[9];
assign csr_pma9addr = reg_pmaaddr[9];
assign csr_pma10cfg = reg_pmacfg[10];
assign csr_pma10addr = reg_pmaaddr[10];
assign csr_pma11cfg = reg_pmacfg[11];
assign csr_pma11addr = reg_pmaaddr[11];
assign csr_pma12cfg = reg_pmacfg[12];
assign csr_pma12addr = reg_pmaaddr[12];
assign csr_pma13cfg = reg_pmacfg[13];
assign csr_pma13addr = reg_pmaaddr[13];
assign csr_pma14cfg = reg_pmacfg[14];
assign csr_pma14addr = reg_pmaaddr[14];
assign csr_pma15cfg = reg_pmacfg[15];
assign csr_pma15addr = reg_pmaaddr[15];
endmodule


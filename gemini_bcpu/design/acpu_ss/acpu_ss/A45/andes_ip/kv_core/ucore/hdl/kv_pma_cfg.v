// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_pma_cfg (
    core_clk,
    core_reset_n,
    pma_req_pa,
    reg_pma_we,
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
    pma_resp_fault,
    pma_resp_mtype,
    pma_resp_namo
);
parameter PMA_ENTRIES = 1;
parameter PALEN = 56;
parameter CLUSTER_SUPPORT_INT = 0;
parameter DEVICE_REGION0_BASE = 64'h00000000_80000000;
parameter DEVICE_REGION0_MASK = 64'h00000000_80000000;
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
parameter WRITETHROUGH_REGION0_BASE = 64'h00000000_40000000;
parameter WRITETHROUGH_REGION0_MASK = 64'h00000000_c0000000;
parameter WRITETHROUGH_REGION1_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION1_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION2_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION2_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION3_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION3_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION4_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION4_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION5_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION5_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION6_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION6_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION7_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION7_MASK = 64'h00000000_00000000;
localparam PMA_ETYP_OFF = 2'b00;
localparam PMA_ETYP_TOR = 2'b01;
localparam PMA_ETYP_NA4 = 2'b10;
localparam PMA_ETYP_NAPOT = 2'b11;
localparam PMA_ETYP_LSB = 0;
localparam PMA_ETYP_MSB = 1;
localparam PMA_MTYP_LSB = 2;
localparam PMA_MTYP_MSB = 5;
localparam PMA_NAMO = 6;
localparam PMA_MTYP_0 = 2;
localparam PMA_MTYP_1 = 3;
localparam PMA_MTYP_2 = 4;
localparam PMA_MTYP_3 = 5;
localparam PMAADDR_CHECK_LSB = 12;
localparam DEVICE_REGION0_MTYPE = 4'b0000;
localparam DEVICE_REGION1_MTYPE = 4'b0000;
localparam DEVICE_REGION2_MTYPE = 4'b0000;
localparam DEVICE_REGION3_MTYPE = 4'b0000;
localparam DEVICE_REGION4_MTYPE = 4'b0000;
localparam DEVICE_REGION5_MTYPE = 4'b0000;
localparam DEVICE_REGION6_MTYPE = 4'b0000;
localparam DEVICE_REGION7_MTYPE = 4'b0000;
localparam WRITETHROUGH_REGION0_MTYPE = (CLUSTER_SUPPORT_INT == 1) ? 4'b0011 : 4'b0101;
localparam WRITETHROUGH_REGION1_MTYPE = (CLUSTER_SUPPORT_INT == 1) ? 4'b0011 : 4'b0101;
localparam WRITETHROUGH_REGION2_MTYPE = (CLUSTER_SUPPORT_INT == 1) ? 4'b0011 : 4'b0101;
localparam WRITETHROUGH_REGION3_MTYPE = (CLUSTER_SUPPORT_INT == 1) ? 4'b0011 : 4'b0101;
localparam WRITETHROUGH_REGION4_MTYPE = (CLUSTER_SUPPORT_INT == 1) ? 4'b0011 : 4'b0101;
localparam WRITETHROUGH_REGION5_MTYPE = (CLUSTER_SUPPORT_INT == 1) ? 4'b0011 : 4'b0101;
localparam WRITETHROUGH_REGION6_MTYPE = (CLUSTER_SUPPORT_INT == 1) ? 4'b0011 : 4'b0101;
localparam WRITETHROUGH_REGION7_MTYPE = (CLUSTER_SUPPORT_INT == 1) ? 4'b0011 : 4'b0101;
localparam WRITEBACK_REGION_MTYPE = 4'b1011;
localparam PMA_BLACK_HOLD = 4'b1111;
input core_clk;
input core_reset_n;
input [PALEN - 1:0] pma_req_pa;
input reg_pma_we;
input [7:0] csr_pma0cfg;
input [7:0] csr_pma1cfg;
input [7:0] csr_pma2cfg;
input [7:0] csr_pma3cfg;
input [7:0] csr_pma4cfg;
input [7:0] csr_pma5cfg;
input [7:0] csr_pma6cfg;
input [7:0] csr_pma7cfg;
input [7:0] csr_pma8cfg;
input [7:0] csr_pma9cfg;
input [7:0] csr_pma10cfg;
input [7:0] csr_pma11cfg;
input [7:0] csr_pma12cfg;
input [7:0] csr_pma13cfg;
input [7:0] csr_pma14cfg;
input [7:0] csr_pma15cfg;
input [PALEN - 1:2] csr_pma0addr;
input [PALEN - 1:2] csr_pma1addr;
input [PALEN - 1:2] csr_pma2addr;
input [PALEN - 1:2] csr_pma3addr;
input [PALEN - 1:2] csr_pma4addr;
input [PALEN - 1:2] csr_pma5addr;
input [PALEN - 1:2] csr_pma6addr;
input [PALEN - 1:2] csr_pma7addr;
input [PALEN - 1:2] csr_pma8addr;
input [PALEN - 1:2] csr_pma9addr;
input [PALEN - 1:2] csr_pma10addr;
input [PALEN - 1:2] csr_pma11addr;
input [PALEN - 1:2] csr_pma12addr;
input [PALEN - 1:2] csr_pma13addr;
input [PALEN - 1:2] csr_pma14addr;
input [PALEN - 1:2] csr_pma15addr;
output pma_resp_fault;
output [3:0] pma_resp_mtype;
output pma_resp_namo;


wire [3:0] s0;
wire s1;
wire s2;
generate
    if (PMA_ENTRIES != 0) begin:gen_pma
        wire [PALEN - 1:PMAADDR_CHECK_LSB - 1] s3[0:PMA_ENTRIES - 1];
        wire [PALEN:PMAADDR_CHECK_LSB - 1] s4[0:PMA_ENTRIES - 1];
        reg [PALEN - 1:PMAADDR_CHECK_LSB - 1] s5[0:PMA_ENTRIES - 1];
        wire [15:0] s6;
        wire [PMA_ENTRIES - 1:0] s7;
        wire [1:0] s8 = csr_pma0cfg[PMA_ETYP_MSB:PMA_ETYP_LSB];
        wire [1:0] s9 = csr_pma1cfg[PMA_ETYP_MSB:PMA_ETYP_LSB];
        wire [1:0] s10 = csr_pma2cfg[PMA_ETYP_MSB:PMA_ETYP_LSB];
        wire [1:0] s11 = csr_pma3cfg[PMA_ETYP_MSB:PMA_ETYP_LSB];
        wire [1:0] s12 = csr_pma4cfg[PMA_ETYP_MSB:PMA_ETYP_LSB];
        wire [1:0] s13 = csr_pma5cfg[PMA_ETYP_MSB:PMA_ETYP_LSB];
        wire [1:0] s14 = csr_pma6cfg[PMA_ETYP_MSB:PMA_ETYP_LSB];
        wire [1:0] s15 = csr_pma7cfg[PMA_ETYP_MSB:PMA_ETYP_LSB];
        wire [1:0] s16 = csr_pma8cfg[PMA_ETYP_MSB:PMA_ETYP_LSB];
        wire [1:0] s17 = csr_pma9cfg[PMA_ETYP_MSB:PMA_ETYP_LSB];
        wire [1:0] s18 = csr_pma10cfg[PMA_ETYP_MSB:PMA_ETYP_LSB];
        wire [1:0] s19 = csr_pma11cfg[PMA_ETYP_MSB:PMA_ETYP_LSB];
        wire [1:0] s20 = csr_pma12cfg[PMA_ETYP_MSB:PMA_ETYP_LSB];
        wire [1:0] s21 = csr_pma13cfg[PMA_ETYP_MSB:PMA_ETYP_LSB];
        wire [1:0] s22 = csr_pma14cfg[PMA_ETYP_MSB:PMA_ETYP_LSB];
        wire [1:0] s23 = csr_pma15cfg[PMA_ETYP_MSB:PMA_ETYP_LSB];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s5[0] <= {(PALEN - PMAADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pma_we) begin
                s5[0] <= s3[0];
            end
        end

        assign s4[0] = ({1'b0,csr_pma0addr[PALEN - 1:PMAADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMAADDR_CHECK_LSB){1'b0}},1'b1});
        assign s3[0] = s4[0][PALEN - 1:PMAADDR_CHECK_LSB - 1] ^~ csr_pma0addr[PALEN - 1:PMAADDR_CHECK_LSB - 1];
        assign s7[0] = ~(|(s5[0][PALEN - 1:PMAADDR_CHECK_LSB] & (csr_pma0addr[PALEN - 1:PMAADDR_CHECK_LSB] ^ pma_req_pa[PALEN - 1:PMAADDR_CHECK_LSB])));
        assign s6[0] = (s8 == PMA_ETYP_NAPOT) ? s7[0] : 1'b0;
        if (PMA_ENTRIES >= 2) begin:gen_pma_entry_1
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s5[1] <= {(PALEN - PMAADDR_CHECK_LSB + 1){1'b0}};
                end
                else if (reg_pma_we) begin
                    s5[1] <= s3[1];
                end
            end

            assign s4[1] = ({1'b0,csr_pma1addr[PALEN - 1:PMAADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMAADDR_CHECK_LSB){1'b0}},1'b1});
            assign s3[1] = s4[1][PALEN - 1:PMAADDR_CHECK_LSB - 1] ^~ csr_pma1addr[PALEN - 1:PMAADDR_CHECK_LSB - 1];
            assign s7[1] = ~(|(s5[1][PALEN - 1:PMAADDR_CHECK_LSB] & (csr_pma1addr[PALEN - 1:PMAADDR_CHECK_LSB] ^ pma_req_pa[PALEN - 1:PMAADDR_CHECK_LSB])));
            assign s6[1] = (s9 == PMA_ETYP_NAPOT) ? s7[1] : 1'b0;
        end
        else begin:gen_no_pma_entry_1
            assign s6[1] = 1'b0;
            wire [PALEN - 1:2] s24 = csr_pma1addr;
            wire [1:0] nds_unused_csr_pma1cfg_etyp = s9;
        end
        if (PMA_ENTRIES >= 3) begin:gen_pma_entry_2
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s5[2] <= {(PALEN - PMAADDR_CHECK_LSB + 1){1'b0}};
                end
                else if (reg_pma_we) begin
                    s5[2] <= s3[2];
                end
            end

            assign s4[2] = ({1'b0,csr_pma2addr[PALEN - 1:PMAADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMAADDR_CHECK_LSB){1'b0}},1'b1});
            assign s3[2] = s4[2][PALEN - 1:PMAADDR_CHECK_LSB - 1] ^~ csr_pma2addr[PALEN - 1:PMAADDR_CHECK_LSB - 1];
            assign s7[2] = ~(|(s5[2][PALEN - 1:PMAADDR_CHECK_LSB] & (csr_pma2addr[PALEN - 1:PMAADDR_CHECK_LSB] ^ pma_req_pa[PALEN - 1:PMAADDR_CHECK_LSB])));
            assign s6[2] = (s10 == PMA_ETYP_NAPOT) ? s7[2] : 1'b0;
        end
        else begin:gen_no_pma_entry_2
            assign s6[2] = 1'b0;
            wire [PALEN - 1:2] s25 = csr_pma2addr;
            wire [1:0] nds_unused_csr_pma2cfg_etyp = s10;
        end
        if (PMA_ENTRIES >= 4) begin:gen_pma_entry_3
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s5[3] <= {(PALEN - PMAADDR_CHECK_LSB + 1){1'b0}};
                end
                else if (reg_pma_we) begin
                    s5[3] <= s3[3];
                end
            end

            assign s4[3] = ({1'b0,csr_pma3addr[PALEN - 1:PMAADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMAADDR_CHECK_LSB){1'b0}},1'b1});
            assign s3[3] = s4[3][PALEN - 1:PMAADDR_CHECK_LSB - 1] ^~ csr_pma3addr[PALEN - 1:PMAADDR_CHECK_LSB - 1];
            assign s7[3] = ~(|(s5[3][PALEN - 1:PMAADDR_CHECK_LSB] & (csr_pma3addr[PALEN - 1:PMAADDR_CHECK_LSB] ^ pma_req_pa[PALEN - 1:PMAADDR_CHECK_LSB])));
            assign s6[3] = (s11 == PMA_ETYP_NAPOT) ? s7[3] : 1'b0;
        end
        else begin:gen_no_pma_entry_3
            assign s6[3] = 1'b0;
            wire [PALEN - 1:2] s26 = csr_pma3addr;
            wire [1:0] nds_unused_csr_pma3cfg_etyp = s11;
        end
        if (PMA_ENTRIES >= 5) begin:gen_pma_entry_4
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s5[4] <= {(PALEN - PMAADDR_CHECK_LSB + 1){1'b0}};
                end
                else if (reg_pma_we) begin
                    s5[4] <= s3[4];
                end
            end

            assign s4[4] = ({1'b0,csr_pma4addr[PALEN - 1:PMAADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMAADDR_CHECK_LSB){1'b0}},1'b1});
            assign s3[4] = s4[4][PALEN - 1:PMAADDR_CHECK_LSB - 1] ^~ csr_pma4addr[PALEN - 1:PMAADDR_CHECK_LSB - 1];
            assign s7[4] = ~(|(s5[4][PALEN - 1:PMAADDR_CHECK_LSB] & (csr_pma4addr[PALEN - 1:PMAADDR_CHECK_LSB] ^ pma_req_pa[PALEN - 1:PMAADDR_CHECK_LSB])));
            assign s6[4] = (s12 == PMA_ETYP_NAPOT) ? s7[4] : 1'b0;
        end
        else begin:gen_no_pma_entry_4
            assign s6[4] = 1'b0;
            wire [PALEN - 1:2] s27 = csr_pma4addr;
            wire [1:0] nds_unused_csr_pma4cfg_etyp = s12;
        end
        if (PMA_ENTRIES >= 6) begin:gen_pma_entry_5
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s5[5] <= {(PALEN - PMAADDR_CHECK_LSB + 1){1'b0}};
                end
                else if (reg_pma_we) begin
                    s5[5] <= s3[5];
                end
            end

            assign s4[5] = ({1'b0,csr_pma5addr[PALEN - 1:PMAADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMAADDR_CHECK_LSB){1'b0}},1'b1});
            assign s3[5] = s4[5][PALEN - 1:PMAADDR_CHECK_LSB - 1] ^~ csr_pma5addr[PALEN - 1:PMAADDR_CHECK_LSB - 1];
            assign s7[5] = ~(|(s5[5][PALEN - 1:PMAADDR_CHECK_LSB] & (csr_pma5addr[PALEN - 1:PMAADDR_CHECK_LSB] ^ pma_req_pa[PALEN - 1:PMAADDR_CHECK_LSB])));
            assign s6[5] = (s13 == PMA_ETYP_NAPOT) ? s7[5] : 1'b0;
        end
        else begin:gen_no_pma_entry_5
            assign s6[5] = 1'b0;
            wire [PALEN - 1:2] s28 = csr_pma5addr;
            wire [1:0] nds_unused_csr_pma5cfg_etyp = s13;
        end
        if (PMA_ENTRIES >= 7) begin:gen_pma_entry_6
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s5[6] <= {(PALEN - PMAADDR_CHECK_LSB + 1){1'b0}};
                end
                else if (reg_pma_we) begin
                    s5[6] <= s3[6];
                end
            end

            assign s4[6] = ({1'b0,csr_pma6addr[PALEN - 1:PMAADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMAADDR_CHECK_LSB){1'b0}},1'b1});
            assign s3[6] = s4[6][PALEN - 1:PMAADDR_CHECK_LSB - 1] ^~ csr_pma6addr[PALEN - 1:PMAADDR_CHECK_LSB - 1];
            assign s7[6] = ~(|(s5[6][PALEN - 1:PMAADDR_CHECK_LSB] & (csr_pma6addr[PALEN - 1:PMAADDR_CHECK_LSB] ^ pma_req_pa[PALEN - 1:PMAADDR_CHECK_LSB])));
            assign s6[6] = (s14 == PMA_ETYP_NAPOT) ? s7[6] : 1'b0;
        end
        else begin:gen_no_pma_entry_6
            assign s6[6] = 1'b0;
            wire [PALEN - 1:2] s29 = csr_pma6addr;
            wire [1:0] nds_unused_csr_pma6cfg_etyp = s14;
        end
        if (PMA_ENTRIES >= 8) begin:gen_pma_entry_7
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s5[7] <= {(PALEN - PMAADDR_CHECK_LSB + 1){1'b0}};
                end
                else if (reg_pma_we) begin
                    s5[7] <= s3[7];
                end
            end

            assign s4[7] = ({1'b0,csr_pma7addr[PALEN - 1:PMAADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMAADDR_CHECK_LSB){1'b0}},1'b1});
            assign s3[7] = s4[7][PALEN - 1:PMAADDR_CHECK_LSB - 1] ^~ csr_pma7addr[PALEN - 1:PMAADDR_CHECK_LSB - 1];
            assign s7[7] = ~(|(s5[7][PALEN - 1:PMAADDR_CHECK_LSB] & (csr_pma7addr[PALEN - 1:PMAADDR_CHECK_LSB] ^ pma_req_pa[PALEN - 1:PMAADDR_CHECK_LSB])));
            assign s6[7] = (s15 == PMA_ETYP_NAPOT) ? s7[7] : 1'b0;
        end
        else begin:gen_no_pma_entry_7
            assign s6[7] = 1'b0;
            wire [PALEN - 1:2] s30 = csr_pma7addr;
            wire [1:0] nds_unused_csr_pma7cfg_etyp = s15;
        end
        if (PMA_ENTRIES >= 9) begin:gen_pma_entry_8
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s5[8] <= {(PALEN - PMAADDR_CHECK_LSB + 1){1'b0}};
                end
                else if (reg_pma_we) begin
                    s5[8] <= s3[8];
                end
            end

            assign s4[8] = ({1'b0,csr_pma8addr[PALEN - 1:PMAADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMAADDR_CHECK_LSB){1'b0}},1'b1});
            assign s3[8] = s4[8][PALEN - 1:PMAADDR_CHECK_LSB - 1] ^~ csr_pma8addr[PALEN - 1:PMAADDR_CHECK_LSB - 1];
            assign s7[8] = ~(|(s5[8][PALEN - 1:PMAADDR_CHECK_LSB] & (csr_pma8addr[PALEN - 1:PMAADDR_CHECK_LSB] ^ pma_req_pa[PALEN - 1:PMAADDR_CHECK_LSB])));
            assign s6[8] = (s16 == PMA_ETYP_NAPOT) ? s7[8] : 1'b0;
        end
        else begin:gen_no_pma_entry_8
            assign s6[8] = 1'b0;
            wire [PALEN - 1:2] s31 = csr_pma8addr;
            wire [1:0] nds_unused_csr_pma8cfg_etyp = s16;
        end
        if (PMA_ENTRIES >= 10) begin:gen_pma_entry_9
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s5[9] <= {(PALEN - PMAADDR_CHECK_LSB + 1){1'b0}};
                end
                else if (reg_pma_we) begin
                    s5[9] <= s3[9];
                end
            end

            assign s4[9] = ({1'b0,csr_pma9addr[PALEN - 1:PMAADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMAADDR_CHECK_LSB){1'b0}},1'b1});
            assign s3[9] = s4[9][PALEN - 1:PMAADDR_CHECK_LSB - 1] ^~ csr_pma9addr[PALEN - 1:PMAADDR_CHECK_LSB - 1];
            assign s7[9] = ~(|(s5[9][PALEN - 1:PMAADDR_CHECK_LSB] & (csr_pma9addr[PALEN - 1:PMAADDR_CHECK_LSB] ^ pma_req_pa[PALEN - 1:PMAADDR_CHECK_LSB])));
            assign s6[9] = (s17 == PMA_ETYP_NAPOT) ? s7[9] : 1'b0;
        end
        else begin:gen_no_pma_entry_9
            assign s6[9] = 1'b0;
            wire [PALEN - 1:2] s32 = csr_pma9addr;
            wire [1:0] nds_unused_csr_pma9cfg_etyp = s17;
        end
        if (PMA_ENTRIES >= 11) begin:gen_pma_entry_10
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s5[10] <= {(PALEN - PMAADDR_CHECK_LSB + 1){1'b0}};
                end
                else if (reg_pma_we) begin
                    s5[10] <= s3[10];
                end
            end

            assign s4[10] = ({1'b0,csr_pma10addr[PALEN - 1:PMAADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMAADDR_CHECK_LSB){1'b0}},1'b1});
            assign s3[10] = s4[10][PALEN - 1:PMAADDR_CHECK_LSB - 1] ^~ csr_pma10addr[PALEN - 1:PMAADDR_CHECK_LSB - 1];
            assign s7[10] = ~(|(s5[10][PALEN - 1:PMAADDR_CHECK_LSB] & (csr_pma10addr[PALEN - 1:PMAADDR_CHECK_LSB] ^ pma_req_pa[PALEN - 1:PMAADDR_CHECK_LSB])));
            assign s6[10] = (s18 == PMA_ETYP_NAPOT) ? s7[10] : 1'b0;
        end
        else begin:gen_no_pma_entry_10
            assign s6[10] = 1'b0;
            wire [PALEN - 1:2] s33 = csr_pma10addr;
            wire [1:0] nds_unused_csr_pma10cfg_etyp = s18;
        end
        if (PMA_ENTRIES >= 12) begin:gen_pma_entry_11
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s5[11] <= {(PALEN - PMAADDR_CHECK_LSB + 1){1'b0}};
                end
                else if (reg_pma_we) begin
                    s5[11] <= s3[11];
                end
            end

            assign s4[11] = ({1'b0,csr_pma11addr[PALEN - 1:PMAADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMAADDR_CHECK_LSB){1'b0}},1'b1});
            assign s3[11] = s4[11][PALEN - 1:PMAADDR_CHECK_LSB - 1] ^~ csr_pma11addr[PALEN - 1:PMAADDR_CHECK_LSB - 1];
            assign s7[11] = ~(|(s5[11][PALEN - 1:PMAADDR_CHECK_LSB] & (csr_pma11addr[PALEN - 1:PMAADDR_CHECK_LSB] ^ pma_req_pa[PALEN - 1:PMAADDR_CHECK_LSB])));
            assign s6[11] = (s19 == PMA_ETYP_NAPOT) ? s7[11] : 1'b0;
        end
        else begin:gen_no_pma_entry_11
            assign s6[11] = 1'b0;
            wire [PALEN - 1:2] s34 = csr_pma11addr;
            wire [1:0] nds_unused_csr_pma11cfg_etyp = s19;
        end
        if (PMA_ENTRIES >= 13) begin:gen_pma_entry_12
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s5[12] <= {(PALEN - PMAADDR_CHECK_LSB + 1){1'b0}};
                end
                else if (reg_pma_we) begin
                    s5[12] <= s3[12];
                end
            end

            assign s4[12] = ({1'b0,csr_pma12addr[PALEN - 1:PMAADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMAADDR_CHECK_LSB){1'b0}},1'b1});
            assign s3[12] = s4[12][PALEN - 1:PMAADDR_CHECK_LSB - 1] ^~ csr_pma12addr[PALEN - 1:PMAADDR_CHECK_LSB - 1];
            assign s7[12] = ~(|(s5[12][PALEN - 1:PMAADDR_CHECK_LSB] & (csr_pma12addr[PALEN - 1:PMAADDR_CHECK_LSB] ^ pma_req_pa[PALEN - 1:PMAADDR_CHECK_LSB])));
            assign s6[12] = (s20 == PMA_ETYP_NAPOT) ? s7[12] : 1'b0;
        end
        else begin:gen_no_pma_entry_12
            assign s6[12] = 1'b0;
            wire [PALEN - 1:2] s35 = csr_pma12addr;
            wire [1:0] nds_unused_csr_pma12cfg_etyp = s20;
        end
        if (PMA_ENTRIES >= 14) begin:gen_pma_entry_13
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s5[13] <= {(PALEN - PMAADDR_CHECK_LSB + 1){1'b0}};
                end
                else if (reg_pma_we) begin
                    s5[13] <= s3[13];
                end
            end

            assign s4[13] = ({1'b0,csr_pma13addr[PALEN - 1:PMAADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMAADDR_CHECK_LSB){1'b0}},1'b1});
            assign s3[13] = s4[13][PALEN - 1:PMAADDR_CHECK_LSB - 1] ^~ csr_pma13addr[PALEN - 1:PMAADDR_CHECK_LSB - 1];
            assign s7[13] = ~(|(s5[13][PALEN - 1:PMAADDR_CHECK_LSB] & (csr_pma13addr[PALEN - 1:PMAADDR_CHECK_LSB] ^ pma_req_pa[PALEN - 1:PMAADDR_CHECK_LSB])));
            assign s6[13] = (s21 == PMA_ETYP_NAPOT) ? s7[13] : 1'b0;
        end
        else begin:gen_no_pma_entry_13
            assign s6[13] = 1'b0;
            wire [PALEN - 1:2] s36 = csr_pma13addr;
            wire [1:0] nds_unused_csr_pma13cfg_etyp = s21;
        end
        if (PMA_ENTRIES >= 15) begin:gen_pma_entry_14
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s5[14] <= {(PALEN - PMAADDR_CHECK_LSB + 1){1'b0}};
                end
                else if (reg_pma_we) begin
                    s5[14] <= s3[14];
                end
            end

            assign s4[14] = ({1'b0,csr_pma14addr[PALEN - 1:PMAADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMAADDR_CHECK_LSB){1'b0}},1'b1});
            assign s3[14] = s4[14][PALEN - 1:PMAADDR_CHECK_LSB - 1] ^~ csr_pma14addr[PALEN - 1:PMAADDR_CHECK_LSB - 1];
            assign s7[14] = ~(|(s5[14][PALEN - 1:PMAADDR_CHECK_LSB] & (csr_pma14addr[PALEN - 1:PMAADDR_CHECK_LSB] ^ pma_req_pa[PALEN - 1:PMAADDR_CHECK_LSB])));
            assign s6[14] = (s22 == PMA_ETYP_NAPOT) ? s7[14] : 1'b0;
        end
        else begin:gen_no_pma_entry_14
            assign s6[14] = 1'b0;
            wire [PALEN - 1:2] s37 = csr_pma14addr;
            wire [1:0] nds_unused_csr_pma14cfg_etyp = s22;
        end
        if (PMA_ENTRIES >= 16) begin:gen_pma_entry_15
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s5[15] <= {(PALEN - PMAADDR_CHECK_LSB + 1){1'b0}};
                end
                else if (reg_pma_we) begin
                    s5[15] <= s3[15];
                end
            end

            assign s4[15] = ({1'b0,csr_pma15addr[PALEN - 1:PMAADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMAADDR_CHECK_LSB){1'b0}},1'b1});
            assign s3[15] = s4[15][PALEN - 1:PMAADDR_CHECK_LSB - 1] ^~ csr_pma15addr[PALEN - 1:PMAADDR_CHECK_LSB - 1];
            assign s7[15] = ~(|(s5[15][PALEN - 1:PMAADDR_CHECK_LSB] & (csr_pma15addr[PALEN - 1:PMAADDR_CHECK_LSB] ^ pma_req_pa[PALEN - 1:PMAADDR_CHECK_LSB])));
            assign s6[15] = (s23 == PMA_ETYP_NAPOT) ? s7[15] : 1'b0;
        end
        else begin:gen_no_pma_entry_15
            assign s6[15] = 1'b0;
            wire [PALEN - 1:2] s38 = csr_pma15addr;
            wire [1:0] nds_unused_csr_pma15cfg_etyp = s23;
        end
        assign {s0,s1,s2} = s6[0] ? {csr_pma0cfg[PMA_MTYP_MSB:PMA_MTYP_LSB],csr_pma0cfg[PMA_NAMO],1'b1} : s6[1] ? {csr_pma1cfg[PMA_MTYP_MSB:PMA_MTYP_LSB],csr_pma1cfg[PMA_NAMO],1'b1} : s6[2] ? {csr_pma2cfg[PMA_MTYP_MSB:PMA_MTYP_LSB],csr_pma2cfg[PMA_NAMO],1'b1} : s6[3] ? {csr_pma3cfg[PMA_MTYP_MSB:PMA_MTYP_LSB],csr_pma3cfg[PMA_NAMO],1'b1} : s6[4] ? {csr_pma4cfg[PMA_MTYP_MSB:PMA_MTYP_LSB],csr_pma4cfg[PMA_NAMO],1'b1} : s6[5] ? {csr_pma5cfg[PMA_MTYP_MSB:PMA_MTYP_LSB],csr_pma5cfg[PMA_NAMO],1'b1} : s6[6] ? {csr_pma6cfg[PMA_MTYP_MSB:PMA_MTYP_LSB],csr_pma6cfg[PMA_NAMO],1'b1} : s6[7] ? {csr_pma7cfg[PMA_MTYP_MSB:PMA_MTYP_LSB],csr_pma7cfg[PMA_NAMO],1'b1} : s6[8] ? {csr_pma8cfg[PMA_MTYP_MSB:PMA_MTYP_LSB],csr_pma8cfg[PMA_NAMO],1'b1} : s6[9] ? {csr_pma9cfg[PMA_MTYP_MSB:PMA_MTYP_LSB],csr_pma9cfg[PMA_NAMO],1'b1} : s6[10] ? {csr_pma10cfg[PMA_MTYP_MSB:PMA_MTYP_LSB],csr_pma10cfg[PMA_NAMO],1'b1} : s6[11] ? {csr_pma11cfg[PMA_MTYP_MSB:PMA_MTYP_LSB],csr_pma11cfg[PMA_NAMO],1'b1} : s6[12] ? {csr_pma12cfg[PMA_MTYP_MSB:PMA_MTYP_LSB],csr_pma12cfg[PMA_NAMO],1'b1} : s6[13] ? {csr_pma13cfg[PMA_MTYP_MSB:PMA_MTYP_LSB],csr_pma13cfg[PMA_NAMO],1'b1} : s6[14] ? {csr_pma14cfg[PMA_MTYP_MSB:PMA_MTYP_LSB],csr_pma14cfg[PMA_NAMO],1'b1} : s6[15] ? {csr_pma15cfg[PMA_MTYP_MSB:PMA_MTYP_LSB],csr_pma15cfg[PMA_NAMO],1'b1} : 6'b0;
        assign pma_resp_fault = (s0 == PMA_BLACK_HOLD);
    end
    else begin:gen_no_pma
        assign s2 = 1'b0;
        assign s0 = 4'b0;
        assign s1 = 1'b0;
        assign pma_resp_fault = 1'b0;
        wire nds_unused_core_clk = core_clk;
        wire nds_unused_core_reset_n = core_reset_n;
        wire nds_unused_reg_pma_we = reg_pma_we;
        wire [7:0] nds_unused_csr_pma0cfg = csr_pma0cfg;
        wire [7:0] nds_unused_csr_pma1cfg = csr_pma1cfg;
        wire [7:0] nds_unused_csr_pma2cfg = csr_pma2cfg;
        wire [7:0] nds_unused_csr_pma3cfg = csr_pma3cfg;
        wire [7:0] nds_unused_csr_pma4cfg = csr_pma4cfg;
        wire [7:0] nds_unused_csr_pma5cfg = csr_pma5cfg;
        wire [7:0] nds_unused_csr_pma6cfg = csr_pma6cfg;
        wire [7:0] nds_unused_csr_pma7cfg = csr_pma7cfg;
        wire [7:0] nds_unused_csr_pma8cfg = csr_pma8cfg;
        wire [7:0] nds_unused_csr_pma9cfg = csr_pma9cfg;
        wire [7:0] nds_unused_csr_pma10cfg = csr_pma10cfg;
        wire [7:0] nds_unused_csr_pma11cfg = csr_pma11cfg;
        wire [7:0] nds_unused_csr_pma12cfg = csr_pma12cfg;
        wire [7:0] nds_unused_csr_pma13cfg = csr_pma13cfg;
        wire [7:0] nds_unused_csr_pma14cfg = csr_pma14cfg;
        wire [7:0] nds_unused_csr_pma15cfg = csr_pma15cfg;
        wire [PALEN - 1:2] s39 = csr_pma0addr;
        wire [PALEN - 1:2] s24 = csr_pma1addr;
        wire [PALEN - 1:2] s25 = csr_pma2addr;
        wire [PALEN - 1:2] s26 = csr_pma3addr;
        wire [PALEN - 1:2] s27 = csr_pma4addr;
        wire [PALEN - 1:2] s28 = csr_pma5addr;
        wire [PALEN - 1:2] s29 = csr_pma6addr;
        wire [PALEN - 1:2] s30 = csr_pma7addr;
        wire [PALEN - 1:2] s31 = csr_pma8addr;
        wire [PALEN - 1:2] s32 = csr_pma9addr;
        wire [PALEN - 1:2] s33 = csr_pma10addr;
        wire [PALEN - 1:2] s34 = csr_pma11addr;
        wire [PALEN - 1:2] s35 = csr_pma12addr;
        wire [PALEN - 1:2] s36 = csr_pma13addr;
        wire [PALEN - 1:2] s37 = csr_pma14addr;
        wire [PALEN - 1:2] s38 = csr_pma15addr;
    end
endgenerate
wire s40 = ((pma_req_pa[PALEN - 1:12] & DEVICE_REGION0_MASK[PALEN - 1:12]) == DEVICE_REGION0_BASE[PALEN - 1:12]) | ((pma_req_pa[PALEN - 1:12] & DEVICE_REGION1_MASK[PALEN - 1:12]) == DEVICE_REGION1_BASE[PALEN - 1:12]) | ((pma_req_pa[PALEN - 1:12] & DEVICE_REGION2_MASK[PALEN - 1:12]) == DEVICE_REGION2_BASE[PALEN - 1:12]) | ((pma_req_pa[PALEN - 1:12] & DEVICE_REGION3_MASK[PALEN - 1:12]) == DEVICE_REGION3_BASE[PALEN - 1:12]) | ((pma_req_pa[PALEN - 1:12] & DEVICE_REGION4_MASK[PALEN - 1:12]) == DEVICE_REGION4_BASE[PALEN - 1:12]) | ((pma_req_pa[PALEN - 1:12] & DEVICE_REGION5_MASK[PALEN - 1:12]) == DEVICE_REGION5_BASE[PALEN - 1:12]) | ((pma_req_pa[PALEN - 1:12] & DEVICE_REGION6_MASK[PALEN - 1:12]) == DEVICE_REGION6_BASE[PALEN - 1:12]) | ((pma_req_pa[PALEN - 1:12] & DEVICE_REGION7_MASK[PALEN - 1:12]) == DEVICE_REGION7_BASE[PALEN - 1:12]);
wire s41 = ((pma_req_pa[PALEN - 1:12] & WRITETHROUGH_REGION0_MASK[PALEN - 1:12]) == WRITETHROUGH_REGION0_BASE[PALEN - 1:12]) | ((pma_req_pa[PALEN - 1:12] & WRITETHROUGH_REGION1_MASK[PALEN - 1:12]) == WRITETHROUGH_REGION1_BASE[PALEN - 1:12]) | ((pma_req_pa[PALEN - 1:12] & WRITETHROUGH_REGION2_MASK[PALEN - 1:12]) == WRITETHROUGH_REGION2_BASE[PALEN - 1:12]) | ((pma_req_pa[PALEN - 1:12] & WRITETHROUGH_REGION3_MASK[PALEN - 1:12]) == WRITETHROUGH_REGION3_BASE[PALEN - 1:12]) | ((pma_req_pa[PALEN - 1:12] & WRITETHROUGH_REGION4_MASK[PALEN - 1:12]) == WRITETHROUGH_REGION4_BASE[PALEN - 1:12]) | ((pma_req_pa[PALEN - 1:12] & WRITETHROUGH_REGION5_MASK[PALEN - 1:12]) == WRITETHROUGH_REGION5_BASE[PALEN - 1:12]) | ((pma_req_pa[PALEN - 1:12] & WRITETHROUGH_REGION6_MASK[PALEN - 1:12]) == WRITETHROUGH_REGION6_BASE[PALEN - 1:12]) | ((pma_req_pa[PALEN - 1:12] & WRITETHROUGH_REGION7_MASK[PALEN - 1:12]) == WRITETHROUGH_REGION7_BASE[PALEN - 1:12]);
assign pma_resp_mtype = s2 ? s0 : (s40 ? DEVICE_REGION0_MTYPE : s41 ? WRITETHROUGH_REGION0_MTYPE : WRITEBACK_REGION_MTYPE);
assign pma_resp_namo = s2 ? s1 : 1'b0;
endmodule


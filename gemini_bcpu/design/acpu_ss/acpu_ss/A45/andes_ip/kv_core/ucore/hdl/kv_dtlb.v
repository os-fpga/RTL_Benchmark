// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dtlb (
    core_clk,
    core_reset_n,
    csr_mstatus_mxr,
    csr_mstatus_sum,
    csr_mmu_satp_we,
    lsu_dtlb_privilege_u,
    lsu_dtlb_va_op0,
    lsu_dtlb_va_op1,
    lsu_dtlb_store,
    dtlb_lsu_ppn,
    dtlb_lsu_status,
    lsu_dtlb_lru_valid,
    lsu_dtlb_lru_wdata,
    lsu_mmu_req_valid,
    lsu_mmu_va,
    mmu_lsu_resp_valid,
    dtlb_miss_req,
    dtlb_miss_vpn,
    dtlb_miss_resp,
    dtlb_miss_data,
    dtlb_sfence_req,
    dtlb_sfence_mode_flush_all,
    dtlb_sfence_mode_va
);
parameter MMU_SCHEME_INT = 2;
parameter VALEN = 48;
parameter EXTVALEN = (((MMU_SCHEME_INT != 0)) && (32 > VALEN)) ? VALEN + 1 : VALEN;
parameter PALEN = 48;
parameter DTLB_ENTRIES = ((MMU_SCHEME_INT == 0)) ? 0 : 4;
parameter STLB_ECC_TYPE = 0;
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
input core_clk;
input core_reset_n;
input csr_mstatus_mxr;
input csr_mstatus_sum;
input csr_mmu_satp_we;
input lsu_dtlb_privilege_u;
input [(VALEN - 1):0] lsu_dtlb_va_op0;
input [20:0] lsu_dtlb_va_op1;
input lsu_dtlb_store;
output [(PALEN - 1):12] dtlb_lsu_ppn;
output [30:0] dtlb_lsu_status;
input lsu_dtlb_lru_valid;
input [7:0] lsu_dtlb_lru_wdata;
input lsu_mmu_req_valid;
input [(EXTVALEN - 1):0] lsu_mmu_va;
output mmu_lsu_resp_valid;
output dtlb_miss_req;
output [(VALEN - 1):12] dtlb_miss_vpn;
input dtlb_miss_resp;
input [DTLB_MSB:0] dtlb_miss_data;
input dtlb_sfence_req;
input dtlb_sfence_mode_flush_all;
input dtlb_sfence_mode_va;


generate
    genvar s;
    genvar i;
    genvar k;
    if ((MMU_SCHEME_INT != 0)) begin:gen_dtlb_enable
        wire s0;
        reg s1;
        reg [(EXTVALEN - 1):0] s2;
        assign s0 = ~s1;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s1 <= 1'b0;
            end
            else if (lsu_mmu_req_valid | mmu_lsu_resp_valid) begin
                s1 <= lsu_mmu_req_valid;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s2 <= {(EXTVALEN){1'b0}};
            end
            else if (lsu_mmu_req_valid) begin
                s2 <= lsu_mmu_va;
            end
        end

        wire [DTLB_MSB:0] s3[0:7];
        wire [DTLB_MSB:0] s4;
        wire s5;
        wire s6;
        wire s7;
        wire s8;
        wire s9;
        wire s10;
        wire s11;
        wire s12;
        wire s13;
        wire [2:0] s14;
        wire [7:0] s15;
        wire s16;
        wire [3:0] s17;
        wire [(PALEN - 1):12] s18;
        wire [6:0] s19;
        wire [6:0] s20;
        wire [7:0] s21;
        wire [7:0] s22;
        wire [7:0] s23;
        wire s24;
        wire [11:0] s25;
        assign {s24,s25} = {1'b0,lsu_dtlb_va_op0[11:0]} + {1'b0,lsu_dtlb_va_op1[11:0]};
        wire [7:0] s26;
        wire [7:0] s27;
        wire s28 = s1 & (|s26);
        wire s29 = s1 & ~(|s26);
        wire [7:0] s30 = s28 ? s26 : lsu_dtlb_lru_wdata;
        wire s31 = ~s10 & s5;
        wire s32 = lsu_dtlb_store & ~s11 & s5;
        wire s33 = ~lsu_dtlb_store & (~s8 & ~(s6 & csr_mstatus_mxr)) & s5;
        wire s34 = lsu_dtlb_store & ~s7 & s5;
        wire s35 = ((~s9 & s5 & lsu_dtlb_privilege_u) | (s9 & s5 & ~csr_mstatus_sum & ~lsu_dtlb_privilege_u));
        reg s36;
        wire s37;
        wire s38;
        wire s39;
        reg [(VALEN - 1):12] s40;
        wire s41;
        assign s38 = s29 & ~dtlb_miss_req;
        assign s39 = dtlb_miss_resp;
        assign s37 = (s38 | dtlb_miss_req) & ~s39;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s36 <= 1'b0;
            end
            else begin
                s36 <= s37;
            end
        end

        assign s41 = s38;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s40 <= {(VALEN - 12){1'b0}};
            end
            else if (s41) begin
                s40 <= s2[(VALEN - 1):12];
            end
        end

        assign dtlb_miss_req = s36;
        assign dtlb_miss_vpn = s40[(VALEN - 1):12];
        assign dtlb_lsu_ppn = s18;
        assign dtlb_lsu_status[27 +:4] = s17;
        assign dtlb_lsu_status[26] = s16;
        assign dtlb_lsu_status[18 +:8] = s15;
        assign dtlb_lsu_status[15 +:3] = s14;
        assign dtlb_lsu_status[14] = s13;
        assign dtlb_lsu_status[13] = s12;
        assign dtlb_lsu_status[12] = s32;
        assign dtlb_lsu_status[11] = s31;
        assign dtlb_lsu_status[10] = s35;
        assign dtlb_lsu_status[9] = s33;
        assign dtlb_lsu_status[8] = s34;
        assign dtlb_lsu_status[0 +:8] = s27;
        assign mmu_lsu_resp_valid = s28;
        reg [(DTLB_ENTRIES - 2):0] s42;
        wire s43;
        assign s43 = lsu_dtlb_lru_valid | s28;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s42 <= {(DTLB_ENTRIES - 1){1'b0}};
            end
            else if (s43) begin
                s42 <= s20[(DTLB_ENTRIES - 2):0];
            end
        end

        kv_zero_ext #(
            .OW(7),
            .IW(DTLB_ENTRIES - 1)
        ) u_dtlb_lru_zext (
            .out(s19),
            .in(s42)
        );
        if (DTLB_ENTRIES == 4) begin:gen_dtlb_lru4
            reg s44;
            reg s45;
            wire [2:0] s46;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s44 <= 1'b0;
                    s45 <= 1'b0;
                end
                else if (|s23) begin
                    s44 <= s19[0];
                    s45 <= (s44 ^~ s19[0]);
                end
            end

            assign s21[0] = ~s46[0] & ~s46[1];
            assign s21[1] = ~s46[0] & s46[1];
            assign s21[2] = s46[0] & ~s46[2];
            assign s21[3] = s46[0] & s46[2];
            assign s21[7:4] = 4'b0;
            assign s46[0] = (s19[0] & ~(&s22[3:2])) | (s19[0] & (&s22[1:0])) | ((&s22[1:0]) & ~(&s22[3:2]));
            assign s46[1] = (s19[1] & ~(s22[1])) | (s19[1] & (s22[0])) | ((s22[0]) & ~(s22[1]));
            assign s46[2] = (s19[2] & ~(s22[3])) | (s19[2] & (s22[2])) | ((s22[2]) & ~(s22[3]));
            assign s20[0] = s45 ? ~s19[0] : |s30[1:0];
            assign s20[1] = |s30[1:0] ? |s30[0] : s19[1];
            assign s20[2] = |s30[3:2] ? |s30[2] : s19[2];
            assign s20[6:3] = 4'b0;
        end
        else if (DTLB_ENTRIES == 8) begin:gen_dtlb_lru8
            reg [2:0] s44;
            reg [2:0] s45;
            wire [6:0] s46;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s44 <= 3'b0;
                    s45 <= 3'b0;
                end
                else if (|s23) begin
                    s44[0] <= s19[0];
                    if (|s23[3:0]) begin
                        s44[1] <= s19[1];
                    end
                    if (|s23[7:4]) begin
                        s44[2] <= s19[2];
                    end
                    s45 <= (s44 ^~ s19[2:0]);
                end
            end

            assign s21[0] = ~s46[0] & ~s46[1] & ~s46[3];
            assign s21[1] = ~s46[0] & ~s46[1] & s46[3];
            assign s21[2] = ~s46[0] & s46[1] & ~s46[4];
            assign s21[3] = ~s46[0] & s46[1] & s46[4];
            assign s21[4] = s46[0] & ~s46[2] & ~s46[5];
            assign s21[5] = s46[0] & ~s46[2] & s46[5];
            assign s21[6] = s46[0] & s46[2] & ~s46[6];
            assign s21[7] = s46[0] & s46[2] & s46[6];
            assign s46[0] = (s19[0] & ~(&s22[7:4])) | (s19[0] & (&s22[3:0])) | ((&s22[3:0]) & ~(&s22[7:4]));
            assign s46[1] = (s19[1] & ~(&s22[3:2])) | (s19[1] & (&s22[1:0])) | ((&s22[1:0]) & ~(&s22[3:2]));
            assign s46[2] = (s19[2] & ~(&s22[7:6])) | (s19[2] & (&s22[5:4])) | ((&s22[5:4]) & ~(&s22[7:6]));
            assign s46[3] = (s19[3] & ~(s22[1])) | (s19[3] & (s22[0])) | ((s22[0]) & ~(s22[1]));
            assign s46[4] = (s19[4] & ~(s22[3])) | (s19[4] & (s22[2])) | ((s22[2]) & ~(s22[3]));
            assign s46[5] = (s19[5] & ~(s22[5])) | (s19[5] & (s22[4])) | ((s22[4]) & ~(s22[5]));
            assign s46[6] = (s19[6] & ~(s22[7])) | (s19[6] & (s22[6])) | ((s22[6]) & ~(s22[7]));
            assign s20[0] = s45[0] ? ~s19[0] : |s30[3:0];
            assign s20[1] = s45[1] ? ~s19[1] : |s30[3:0] ? |lsu_dtlb_lru_wdata[1:0] : s19[1];
            assign s20[2] = s45[2] ? ~s19[2] : |s30[7:4] ? |lsu_dtlb_lru_wdata[5:4] : s19[2];
            assign s20[3] = |s30[1:0] ? s30[0] : s19[3];
            assign s20[4] = |s30[3:2] ? s30[2] : s19[4];
            assign s20[5] = |s30[5:4] ? s30[4] : s19[5];
            assign s20[6] = |s30[7:6] ? s30[6] : s19[6];
        end
        else begin:gen_dtlb_lru_victim_disabled
            assign s21 = 8'b0;
            assign s20 = 7'b0;
        end
        assign s4 = (s3[0] & {(DTLB_MSB + 1){s27[0]}}) | (s3[1] & {(DTLB_MSB + 1){s27[1]}}) | (s3[2] & {(DTLB_MSB + 1){s27[2]}}) | (s3[3] & {(DTLB_MSB + 1){s27[3]}}) | (s3[4] & {(DTLB_MSB + 1){s27[4]}}) | (s3[5] & {(DTLB_MSB + 1){s27[5]}}) | (s3[6] & {(DTLB_MSB + 1){s27[6]}}) | (s3[7] & {(DTLB_MSB + 1){s27[7]}});
        assign s5 = s4[DTLB_V_BIT];
        assign s6 = s4[DTLB_X_BIT];
        assign s7 = s4[DTLB_W_BIT];
        assign s8 = s4[DTLB_R_BIT];
        assign s9 = s4[DTLB_U_BIT];
        assign s10 = s4[DTLB_A_BIT];
        assign s11 = s4[DTLB_D_BIT];
        assign s12 = s4[DTLB_PAGE_FAULT_BIT];
        assign s13 = s4[DTLB_PTW_ACCESS_FAULT_BIT];
        assign s14 = s4[DTLB_MDCAUSE_MSB:DTLB_MDCAUSE_LSB];
        assign s15 = s4[DTLB_ECC_CODE_MSB:DTLB_ECC_CODE_LSB];
        assign s16 = s4[DTLB_ECC_CORR_BIT];
        assign s17 = s4[DTLB_ECC_RAMID_MSB:DTLB_ECC_RAMID_LSB];
        assign s18 = s4[DTLB_PPN_MSB:DTLB_PPN_LSB];
        for (i = 0; i < 8; i = i + 1) begin:gen_dtlb
            if (DTLB_ENTRIES > i) begin:gen_dtlb_enabled
                reg [(VALEN - 1):12] s47;
                wire s48;
                wire s49;
                wire [(VALEN - 1):12] s50;
                wire [(VALEN - 1):12] s51;
                always @(posedge core_clk) begin
                    if (s49) begin
                        s47 <= dtlb_miss_vpn;
                    end
                end

                assign s49 = dtlb_miss_resp & s21[i];
                assign s48 = s3[i][DTLB_V_BIT];
                assign s22[i] = s48;
                assign s23[i] = s48 & s49;
                for (k = 12; k < 21; k = k + 1) begin:gen_ex_dtlb_hit_20
                    assign {s51[k],s50[k]} = {1'b0,lsu_dtlb_va_op0[k]} + {1'b0,lsu_dtlb_va_op1[k]} + {1'b0,~s47[k]};
                end
                for (k = 21; k < VALEN; k = k + 1) begin:gen_ex_dtlb_hit_21_valen
                    assign {s51[k],s50[k]} = {1'b0,lsu_dtlb_va_op0[k]} + {1'b0,lsu_dtlb_va_op1[20]} + {1'b0,~s47[k]};
                end
                assign s26[i] = s48 & (s47 == s2[(VALEN - 1):12]);
                assign s27[i] = s48 & (~s50[(VALEN - 1):12] == {s51[(VALEN - 2):12],s24});
            end
            else begin:gen_dtlb_disabled
                assign s22[i] = 1'b0;
                assign s23[i] = 1'b0;
                assign s26[i] = 1'b0;
                assign s27[i] = 1'b0;
            end
            if (((MMU_SCHEME_INT != 0)) && (DTLB_ENTRIES > i)) begin:gen_dtlb_translation
                reg s52;
                wire s53;
                wire s54;
                wire s55;
                reg [(PALEN - 1):12] s56;
                reg s57;
                reg s58;
                reg s59;
                reg s60;
                reg s61;
                reg s62;
                reg s63;
                reg s64;
                reg s65;
                reg [2:0] s66;
                reg [7:0] s67;
                reg s68;
                reg [3:0] s69;
                wire s49;
                assign s49 = dtlb_miss_resp & s21[i];
                assign s53 = s49 | s55;
                assign s55 = (dtlb_sfence_req & (dtlb_sfence_mode_flush_all | dtlb_sfence_mode_va | (s52 & ~s59))) | (csr_mmu_satp_we & (s52 & ~s59));
                assign s54 = dtlb_miss_data[DTLB_V_BIT] & ~s55;
                always @(posedge core_clk or negedge core_reset_n) begin
                    if (!core_reset_n) begin
                        s52 <= 1'b0;
                    end
                    else if (s53) begin
                        s52 <= s54;
                    end
                end

                always @(posedge core_clk or negedge core_reset_n) begin
                    if (!core_reset_n) begin
                        s57 <= 1'b0;
                        s58 <= 1'b0;
                        s59 <= 1'b0;
                        s60 <= 1'b0;
                        s61 <= 1'b0;
                        s62 <= 1'b0;
                        s63 <= 1'b0;
                        s64 <= 1'b0;
                        s65 <= 1'b0;
                    end
                    else if (s49) begin
                        s57 <= dtlb_miss_data[DTLB_D_BIT];
                        s58 <= dtlb_miss_data[DTLB_A_BIT];
                        s59 <= dtlb_miss_data[DTLB_G_BIT];
                        s60 <= dtlb_miss_data[DTLB_U_BIT];
                        s61 <= dtlb_miss_data[DTLB_X_BIT];
                        s62 <= dtlb_miss_data[DTLB_W_BIT];
                        s63 <= dtlb_miss_data[DTLB_R_BIT];
                        s64 <= dtlb_miss_data[DTLB_PAGE_FAULT_BIT];
                        s65 <= dtlb_miss_data[DTLB_PTW_ACCESS_FAULT_BIT];
                    end
                end

                always @(posedge core_clk) begin
                    if (s49) begin
                        s66 <= dtlb_miss_data[DTLB_MDCAUSE_MSB:DTLB_MDCAUSE_LSB];
                        s67 <= dtlb_miss_data[DTLB_ECC_CODE_MSB:DTLB_ECC_CODE_LSB];
                        s68 <= dtlb_miss_data[DTLB_ECC_CORR_BIT];
                        s69 <= dtlb_miss_data[DTLB_ECC_RAMID_MSB:DTLB_ECC_RAMID_LSB];
                        s56 <= dtlb_miss_data[DTLB_PPN_MSB:DTLB_PPN_LSB];
                    end
                end

                assign s3[i][DTLB_V_BIT] = s52;
                assign s3[i][DTLB_X_BIT] = s61;
                assign s3[i][DTLB_W_BIT] = s62;
                assign s3[i][DTLB_R_BIT] = s63;
                assign s3[i][DTLB_U_BIT] = s60;
                assign s3[i][DTLB_G_BIT] = s59;
                assign s3[i][DTLB_A_BIT] = s58;
                assign s3[i][DTLB_D_BIT] = s57;
                assign s3[i][DTLB_PAGE_FAULT_BIT] = s64;
                assign s3[i][DTLB_PTW_ACCESS_FAULT_BIT] = s65;
                assign s3[i][DTLB_MDCAUSE_MSB:DTLB_MDCAUSE_LSB] = s66;
                assign s3[i][DTLB_ECC_CODE_MSB:DTLB_ECC_CODE_LSB] = s67;
                assign s3[i][DTLB_ECC_CORR_BIT] = s68;
                assign s3[i][DTLB_ECC_RAMID_MSB:DTLB_ECC_RAMID_LSB] = s69;
                assign s3[i][DTLB_PPN_MSB:DTLB_PPN_LSB] = s56;
            end
            else begin:gen_dtlb_translation_disabled
                assign s3[i][DTLB_MSB:0] = {(DTLB_PPN_MSB - DTLB_V_BIT + 1){1'b0}};
            end
        end
        wire nds_unused_lsu_mmu_req_ready = s0;
        wire [11:0] nds_unused_lsu_dtlb_va = s25;
    end
    else begin:gen_dtlb_disable
        assign dtlb_lsu_ppn = {(PALEN - 12){1'b0}};
        assign dtlb_lsu_status = {31{1'b0}};
        assign mmu_lsu_resp_valid = 1'b0;
        assign dtlb_miss_req = 1'b0;
        assign dtlb_miss_vpn = {(VALEN - 12){1'b0}};
        wire nds_unused_core_clk = core_clk;
        wire nds_unused_core_reset_n = core_reset_n;
        wire nds_unused_csr_mstatus_mxr = csr_mstatus_mxr;
        wire nds_unused_csr_mstatus_sum = csr_mstatus_sum;
        wire nds_unused_csr_mmu_satp_we = csr_mmu_satp_we;
        wire nds_unused_lsu_dtlb_privilege_u = lsu_dtlb_privilege_u;
        wire [(VALEN - 1):0] s70 = lsu_dtlb_va_op0;
        wire [20:0] nds_unused_lsu_dtlb_va_op1 = lsu_dtlb_va_op1;
        wire nds_unused_lsu_dtlb_store = lsu_dtlb_store;
        wire nds_unused_lsu_dtlb_lru_valid = lsu_dtlb_lru_valid;
        wire [7:0] nds_unused_lsu_dtlb_lru_wdata = lsu_dtlb_lru_wdata;
        wire nds_unused_lsu_mmu_req_valid = lsu_mmu_req_valid;
        wire [(EXTVALEN - 1):0] s71 = lsu_mmu_va;
        wire nds_unused_dtlb_miss_resp = dtlb_miss_resp;
        wire [DTLB_MSB:0] nds_unused_dtlb_miss_data = dtlb_miss_data;
        wire nds_unused_dtlb_sfence_req = dtlb_sfence_req;
        wire nds_unused_dtlb_sfence_mode_flush_all = dtlb_sfence_mode_flush_all;
        wire nds_unused_dtlb_sfence_mode_va = dtlb_sfence_mode_va;
    end
endgenerate
endmodule


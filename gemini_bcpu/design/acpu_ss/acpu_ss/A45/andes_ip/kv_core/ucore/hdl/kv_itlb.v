// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_itlb (
    core_clk,
    core_reset_n,
    itlb_translate_en,
    csr_cur_privilege,
    csr_satp_mode,
    csr_mmu_satp_we,
    ifu_itlb_req_valid,
    ifu_itlb_va,
    itlb_ifu_pa,
    itlb_ifu_status,
    ifu_mmu_req_valid,
    ifu_mmu_va,
    mmu_ifu_resp_valid,
    itlb_miss_req,
    itlb_miss_vpn,
    itlb_miss_resp,
    itlb_miss_data,
    itlb_sfence_req,
    itlb_sfence_mode_flush_all,
    itlb_sfence_mode_va
);
parameter MMU_SCHEME_INT = 2;
parameter VALEN = 48;
parameter EXTVALEN = (((MMU_SCHEME_INT != 0)) && (32 > VALEN)) ? VALEN + 1 : VALEN;
parameter PALEN = 48;
parameter ITLB_ENTRIES = ((MMU_SCHEME_INT == 0)) ? 0 : 4;
parameter STLB_ECC_TYPE = 0;
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
localparam SATP_MODE_BARE = 4'h0;
localparam SATP_MODE_SV39 = 4'h8;
localparam SATP_MODE_SV48 = 4'h9;
localparam PRIVILEGE_USER = 2'b00;
localparam PRIVILEGE_SUPERVISOR = 2'b01;
localparam PRIVILEGE_MACHINE = 2'b11;
input core_clk;
input core_reset_n;
input itlb_translate_en;
input [1:0] csr_cur_privilege;
input [3:0] csr_satp_mode;
input csr_mmu_satp_we;
input ifu_itlb_req_valid;
input [(EXTVALEN - 1):0] ifu_itlb_va;
output [(PALEN - 1):0] itlb_ifu_pa;
output [18:0] itlb_ifu_status;
input ifu_mmu_req_valid;
input [(EXTVALEN - 1):0] ifu_mmu_va;
output mmu_ifu_resp_valid;
output itlb_miss_req;
output [(VALEN - 1):12] itlb_miss_vpn;
input itlb_miss_resp;
input [ITLB_MSB:0] itlb_miss_data;
input itlb_sfence_req;
input itlb_sfence_mode_flush_all;
input itlb_sfence_mode_va;


generate
    genvar i;
    if ((MMU_SCHEME_INT != 0)) begin:gen_itlb_enable
        wire [ITLB_MSB:0] s0[0:7];
        wire [ITLB_MSB:0] s1;
        wire s2;
        wire s3;
        wire s4;
        wire s5;
        wire s6;
        wire s7;
        wire [2:0] s8;
        wire [7:0] s9;
        wire s10;
        wire [3:0] s11;
        wire [(PALEN - 1):12] s12;
        wire [6:0] s13;
        wire [6:0] s14;
        wire [7:0] s15;
        wire [7:0] s16;
        wire [7:0] s17;
        wire [7:0] s18;
        wire [7:0] s19;
        wire s20 = ifu_mmu_req_valid & (|s18);
        wire s21 = ifu_mmu_req_valid & ~(|s18);
        wire s22 = (|s19);
        wire s23 = ~(|s19);
        wire [7:0] s24 = s20 ? s18 : s19;
        wire s25;
        wire s26;
        if ((MMU_SCHEME_INT == 3)) begin:gen_ifu_va_canonical_check_sv48
            assign s25 = (ifu_mmu_va[EXTVALEN - 1] ^ ifu_mmu_va[VALEN - 1]) | (~(&ifu_mmu_va[(EXTVALEN - 1):38]) & (|ifu_mmu_va[(EXTVALEN - 1):38]) & (csr_satp_mode == SATP_MODE_SV39));
            assign s26 = (ifu_itlb_va[EXTVALEN - 1] ^ ifu_itlb_va[VALEN - 1]) | (~(&ifu_itlb_va[(VALEN - 1):38]) & (|ifu_itlb_va[(VALEN - 1):38]) & (csr_satp_mode == SATP_MODE_SV39));
        end
        else begin:gen_ifu_va_canonical_check
            assign s25 = ifu_mmu_va[EXTVALEN - 1] ^ ifu_mmu_va[VALEN - 1];
            assign s26 = ifu_itlb_va[EXTVALEN - 1] ^ ifu_itlb_va[VALEN - 1];
            wire [3:0] nds_unused_csr_satp_mode = csr_satp_mode;
        end
        wire s27 = ~s5 & s2;
        wire s28 = ~s3 & s2;
        wire s29 = ((~s4 & s2 & (csr_cur_privilege == PRIVILEGE_USER)) | (s4 & s2 & (csr_cur_privilege != PRIVILEGE_USER)));
        reg s30;
        wire s31;
        wire s32;
        wire s33;
        reg [(VALEN - 1):12] s34;
        wire s35;
        assign s32 = s21 & ~itlb_miss_req & ~s25;
        assign s33 = itlb_miss_resp;
        assign s31 = (s32 | itlb_miss_req) & ~s33;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s30 <= 1'b0;
            end
            else begin
                s30 <= s31;
            end
        end

        assign s35 = s32;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s34 <= {(VALEN - 12){1'b0}};
            end
            else if (s35) begin
                s34 <= ifu_mmu_va[(VALEN - 1):12];
            end
        end

        assign itlb_miss_req = s30;
        assign itlb_miss_vpn = s34[(VALEN - 1):12];
        wire [(PALEN - 1):12] s36;
        if (PALEN > EXTVALEN) begin:gen_itlb_vpn_ext
            assign s36 = {{(PALEN - EXTVALEN){1'b0}},ifu_itlb_va[(EXTVALEN - 1):12]};
        end
        else begin:gen_itlb_vpn
            assign s36 = ifu_itlb_va[(PALEN - 1):12];
        end
        assign itlb_ifu_pa = ({(PALEN){itlb_translate_en}} & {s12,ifu_itlb_va[11:0]}) | ({(PALEN){~itlb_translate_en}} & {s36,ifu_itlb_va[11:0]});
        assign itlb_ifu_status[15 +:4] = {4{itlb_translate_en}} & s11;
        assign itlb_ifu_status[14] = itlb_translate_en & s10;
        assign itlb_ifu_status[6 +:8] = {8{itlb_translate_en}} & s9;
        assign itlb_ifu_status[3 +:3] = {3{itlb_translate_en}} & s8;
        assign itlb_ifu_status[2] = itlb_translate_en & s7;
        assign itlb_ifu_status[1] = itlb_translate_en & (~s7) & (s26 | s27 | s28 | s29 | s6);
        assign itlb_ifu_status[0] = itlb_translate_en & (~s26 & s23);
        assign mmu_ifu_resp_valid = ((s20) | (ifu_mmu_req_valid & s25));
        reg [(ITLB_ENTRIES - 2):0] s37;
        wire s38;
        assign s38 = (ifu_itlb_req_valid & s22) | s20;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s37 <= {(ITLB_ENTRIES - 1){1'b0}};
            end
            else if (s38) begin
                s37 <= s14[(ITLB_ENTRIES - 2):0];
            end
        end

        kv_zero_ext #(
            .OW(7),
            .IW(ITLB_ENTRIES - 1)
        ) u_itlb_lru_zext (
            .out(s13),
            .in(s37)
        );
        if (ITLB_ENTRIES == 4) begin:gen_itlb_lru4
            reg s39;
            reg s40;
            wire [2:0] s41;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s39 <= 1'b0;
                    s40 <= 1'b0;
                end
                else if (|s17) begin
                    s39 <= s13[0];
                    s40 <= (s39 ^~ s13[0]);
                end
            end

            assign s15[0] = ~s41[0] & ~s41[1];
            assign s15[1] = ~s41[0] & s41[1];
            assign s15[2] = s41[0] & ~s41[2];
            assign s15[3] = s41[0] & s41[2];
            assign s15[7:4] = 4'b0;
            assign s41[0] = (s13[0] & ~(&s16[3:2])) | (s13[0] & (&s16[1:0])) | ((&s16[1:0]) & ~(&s16[3:2]));
            assign s41[1] = (s13[1] & ~(s16[1])) | (s13[1] & (s16[0])) | ((s16[0]) & ~(s16[1]));
            assign s41[2] = (s13[2] & ~(s16[3])) | (s13[2] & (s16[2])) | ((s16[2]) & ~(s16[3]));
            assign s14[0] = s40 ? ~s13[0] : |s24[1:0];
            assign s14[1] = |s24[1:0] ? |s24[0] : s13[1];
            assign s14[2] = |s24[3:2] ? |s24[2] : s13[2];
            assign s14[6:3] = 4'b0;
        end
        else if (ITLB_ENTRIES == 8) begin:gen_itlb_lru8
            reg [2:0] s39;
            reg [2:0] s40;
            wire [6:0] s41;
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s39 <= 3'b0;
                    s40 <= 3'b0;
                end
                else if (|s17) begin
                    s39[0] <= s13[0];
                    if (|s17[3:0]) begin
                        s39[1] <= s13[1];
                    end
                    if (|s17[7:4]) begin
                        s39[2] <= s13[2];
                    end
                    s40 <= (s39 ^~ s13[2:0]);
                end
            end

            assign s15[0] = ~s41[0] & ~s41[1] & ~s41[3];
            assign s15[1] = ~s41[0] & ~s41[1] & s41[3];
            assign s15[2] = ~s41[0] & s41[1] & ~s41[4];
            assign s15[3] = ~s41[0] & s41[1] & s41[4];
            assign s15[4] = s41[0] & ~s41[2] & ~s41[5];
            assign s15[5] = s41[0] & ~s41[2] & s41[5];
            assign s15[6] = s41[0] & s41[2] & ~s41[6];
            assign s15[7] = s41[0] & s41[2] & s41[6];
            assign s41[0] = (s13[0] & ~(&s16[7:4])) | (s13[0] & (&s16[3:0])) | ((&s16[3:0]) & ~(&s16[7:4]));
            assign s41[1] = (s13[1] & ~(&s16[3:2])) | (s13[1] & (&s16[1:0])) | ((&s16[1:0]) & ~(&s16[3:2]));
            assign s41[2] = (s13[2] & ~(&s16[7:6])) | (s13[2] & (&s16[5:4])) | ((&s16[5:4]) & ~(&s16[7:6]));
            assign s41[3] = (s13[3] & ~(s16[1])) | (s13[3] & (s16[0])) | ((s16[0]) & ~(s16[1]));
            assign s41[4] = (s13[4] & ~(s16[3])) | (s13[4] & (s16[2])) | ((s16[2]) & ~(s16[3]));
            assign s41[5] = (s13[5] & ~(s16[5])) | (s13[5] & (s16[4])) | ((s16[4]) & ~(s16[5]));
            assign s41[6] = (s13[6] & ~(s16[7])) | (s13[6] & (s16[6])) | ((s16[6]) & ~(s16[7]));
            assign s14[0] = s40[0] ? ~s13[0] : |s24[3:0];
            assign s14[1] = s40[1] ? ~s13[1] : |s24[3:0] ? |s24[1:0] : s13[1];
            assign s14[2] = s40[2] ? ~s13[2] : |s24[7:4] ? |s24[5:4] : s13[2];
            assign s14[3] = |s24[1:0] ? s24[0] : s13[3];
            assign s14[4] = |s24[3:2] ? s24[2] : s13[4];
            assign s14[5] = |s24[5:4] ? s24[4] : s13[5];
            assign s14[6] = |s24[7:6] ? s24[6] : s13[6];
        end
        else begin:gen_itlb_lru_victim_disabled
            assign s15 = 8'b0;
            assign s14 = 7'b0;
        end
        assign s1 = (s0[0] & {(ITLB_MSB + 1){s19[0]}}) | (s0[1] & {(ITLB_MSB + 1){s19[1]}}) | (s0[2] & {(ITLB_MSB + 1){s19[2]}}) | (s0[3] & {(ITLB_MSB + 1){s19[3]}}) | (s0[4] & {(ITLB_MSB + 1){s19[4]}}) | (s0[5] & {(ITLB_MSB + 1){s19[5]}}) | (s0[6] & {(ITLB_MSB + 1){s19[6]}}) | (s0[7] & {(ITLB_MSB + 1){s19[7]}});
        assign s2 = s1[ITLB_V_BIT];
        assign s3 = s1[ITLB_X_BIT];
        assign s4 = s1[ITLB_U_BIT];
        assign s5 = s1[ITLB_A_BIT];
        assign s6 = s1[ITLB_PAGE_FAULT_BIT];
        assign s7 = s1[ITLB_PTW_ACCESS_FAULT_BIT];
        assign s8 = s1[ITLB_MDCAUSE_MSB:ITLB_MDCAUSE_LSB];
        assign s9 = s1[ITLB_ECC_CODE_MSB:ITLB_ECC_CODE_LSB];
        assign s10 = s1[ITLB_ECC_CORR_BIT];
        assign s11 = s1[ITLB_ECC_RAMID_MSB:ITLB_ECC_RAMID_LSB];
        assign s12 = s1[ITLB_PPN_MSB:ITLB_PPN_LSB];
        for (i = 0; i < 8; i = i + 1) begin:gen_itlb
            if (ITLB_ENTRIES > i) begin:gen_itlb_enabled
                reg [(VALEN - 1):12] s42;
                wire s43;
                wire s44;
                always @(posedge core_clk) begin
                    if (s44) begin
                        s42 <= itlb_miss_vpn;
                    end
                end

                assign s44 = itlb_miss_resp & s15[i];
                assign s43 = s0[i][ITLB_V_BIT];
                assign s16[i] = s43;
                assign s17[i] = s43 & s44;
                assign s18[i] = s43 & (s42 == ifu_mmu_va[(VALEN - 1):12]);
                assign s19[i] = s43 & (s42 == ifu_itlb_va[(VALEN - 1):12]);
            end
            else begin:gen_itlb_disabled
                assign s16[i] = 1'b0;
                assign s17[i] = 1'b0;
                assign s18[i] = 1'b0;
                assign s19[i] = 1'b0;
            end
            if (((MMU_SCHEME_INT != 0)) && (ITLB_ENTRIES > i)) begin:gen_itlb_translation
                reg s45;
                wire s46;
                wire s47;
                wire s48;
                reg [(PALEN - 1):12] s49;
                reg s50;
                reg s51;
                reg s52;
                reg s53;
                reg s54;
                reg s55;
                reg [2:0] s56;
                reg [7:0] s57;
                reg s58;
                reg [3:0] s59;
                wire s44;
                assign s44 = itlb_miss_resp & s15[i];
                assign s46 = s44 | s48;
                assign s48 = (itlb_sfence_req & (itlb_sfence_mode_flush_all | itlb_sfence_mode_va | (s45 & ~s51))) | (csr_mmu_satp_we & (s45 & ~s51));
                assign s47 = itlb_miss_data[ITLB_V_BIT] & ~s48;
                always @(posedge core_clk or negedge core_reset_n) begin
                    if (!core_reset_n) begin
                        s45 <= 1'b0;
                    end
                    else if (s46) begin
                        s45 <= s47;
                    end
                end

                always @(posedge core_clk or negedge core_reset_n) begin
                    if (!core_reset_n) begin
                        s50 <= 1'b0;
                        s51 <= 1'b0;
                        s52 <= 1'b0;
                        s53 <= 1'b0;
                        s54 <= 1'b0;
                        s55 <= 1'b0;
                    end
                    else if (s44) begin
                        s50 <= itlb_miss_data[ITLB_A_BIT];
                        s51 <= itlb_miss_data[ITLB_G_BIT];
                        s52 <= itlb_miss_data[ITLB_U_BIT];
                        s53 <= itlb_miss_data[ITLB_X_BIT];
                        s54 <= itlb_miss_data[ITLB_PAGE_FAULT_BIT];
                        s55 <= itlb_miss_data[ITLB_PTW_ACCESS_FAULT_BIT];
                    end
                end

                always @(posedge core_clk) begin
                    if (s44) begin
                        s56 <= itlb_miss_data[ITLB_MDCAUSE_MSB:ITLB_MDCAUSE_LSB];
                        s57 <= itlb_miss_data[ITLB_ECC_CODE_MSB:ITLB_ECC_CODE_LSB];
                        s58 <= itlb_miss_data[ITLB_ECC_CORR_BIT];
                        s59 <= itlb_miss_data[ITLB_ECC_RAMID_MSB:ITLB_ECC_RAMID_LSB];
                        s49 <= itlb_miss_data[ITLB_PPN_MSB:ITLB_PPN_LSB];
                    end
                end

                assign s0[i][ITLB_V_BIT] = s45;
                assign s0[i][ITLB_X_BIT] = s53;
                assign s0[i][ITLB_U_BIT] = s52;
                assign s0[i][ITLB_G_BIT] = s51;
                assign s0[i][ITLB_A_BIT] = s50;
                assign s0[i][ITLB_PAGE_FAULT_BIT] = s54;
                assign s0[i][ITLB_PTW_ACCESS_FAULT_BIT] = s55;
                assign s0[i][ITLB_MDCAUSE_MSB:ITLB_MDCAUSE_LSB] = s56;
                assign s0[i][ITLB_ECC_CODE_MSB:ITLB_ECC_CODE_LSB] = s57;
                assign s0[i][ITLB_ECC_CORR_BIT] = s58;
                assign s0[i][ITLB_ECC_RAMID_MSB:ITLB_ECC_RAMID_LSB] = s59;
                assign s0[i][ITLB_PPN_MSB:ITLB_PPN_LSB] = s49;
            end
            else begin:gen_itlb_translation_disabled
                assign s0[i][ITLB_MSB:0] = {(ITLB_MSB + 1){1'b0}};
            end
        end
    end
    else begin:gen_itlb_disable
        assign itlb_ifu_pa = {(PALEN){1'b0}};
        assign itlb_ifu_status = {19{1'b0}};
        assign mmu_ifu_resp_valid = 1'b0;
        assign itlb_miss_req = 1'b0;
        assign itlb_miss_vpn = {(VALEN - 12){1'b0}};
        wire nds_unused_core_clk = core_clk;
        wire nds_unused_core_reset_n = core_reset_n;
        wire nds_unused_itlb_translate_en = itlb_translate_en;
        wire [1:0] nds_unused_csr_cur_privilege = csr_cur_privilege;
        wire [3:0] nds_unused_csr_satp_mode = csr_satp_mode;
        wire nds_unused_csr_mmu_satp_we = csr_mmu_satp_we;
        wire nds_unused_ifu_itlb_req_valid = ifu_itlb_req_valid;
        wire [(EXTVALEN - 1):0] s60 = ifu_itlb_va;
        wire nds_unused_ifu_mmu_req_valid = ifu_mmu_req_valid;
        wire [(EXTVALEN - 1):0] s61 = ifu_mmu_va;
        wire nds_unused_itlb_miss_resp = itlb_miss_resp;
        wire [ITLB_MSB:0] nds_unused_itlb_miss_data = itlb_miss_data;
        wire nds_unused_itlb_sfence_req = itlb_sfence_req;
        wire nds_unused_itlb_sfence_mode_flush_all = itlb_sfence_mode_flush_all;
        wire nds_unused_itlb_sfence_mode_va = itlb_sfence_mode_va;
    end
endgenerate
endmodule


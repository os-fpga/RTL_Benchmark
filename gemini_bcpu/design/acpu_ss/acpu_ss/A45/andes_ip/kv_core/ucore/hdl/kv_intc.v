// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_intc (
    core_clk,
    core_reset_n,
    hart_under_reset,
    hart_unavail,
    csr_halt_mode,
    csr_dcsr_step,
    csr_dcsr_stepie,
    csr_dcsr_debugint,
    csr_resethaltreq,
    resume,
    resume_vectored,
    ifu_ipipe_init_done,
    rf_init,
    epc_init,
    vpu_init_rf,
    csr_cur_privilege,
    csr_mmisc_ctl_vec_plic,
    csr_mstatus_mie,
    csr_mstatus_sie,
    csr_mstatus_uie,
    csr_mip,
    csr_ipipe_slip,
    csr_mie,
    csr_ipipe_slie,
    csr_mideleg,
    csr_sideleg,
    csr_mslideleg,
    csr_dexc2dbg_slpecc,
    csr_dexc2dbg_sbe,
    csr_dexc2dbg_pmov,
    nmi,
    meiack,
    seiack,
    ueiack,
    ipipe_csr_nmi_taken,
    csr_meiid,
    csr_seiid,
    csr_ueiid,
    lsu_async_write_error,
    lsu_async_read_error,
    dcu_async_write_error,
    lm_async_write_error,
    ipipe_csr_nmi_pending,
    ipipe_csr_m_sbe_set,
    ipipe_csr_s_sbe_set,
    ipipe_csr_m_slpecc_clr,
    ipipe_csr_m_hpmint_clr,
    ipipe_csr_m_sbe_clr,
    ipipe_csr_s_slpecc_clr,
    ipipe_csr_s_hpmint_clr,
    ipipe_csr_s_sbe_clr,
    ipipe_csr_int_delegate_s,
    ipipe_csr_int_delegate_u,
    int_code,
    int_cause_detail,
    int_cause_interrupt,
    trigm_int_code,
    trigm_int_result,
    itrigger_fire,
    int_ecc,
    wfi_done,
    async_valid,
    async_ready,
    debugint_valid,
    nmi_valid,
    mint_valid,
    sint_valid,
    uint_valid,
    mei_entry_sel,
    sei_entry_sel,
    uei_entry_sel,
    mint_vec,
    sint_vec,
    uint_vec,
    int_detail_cause_valid,
    int_dex2dbg,
    int_ddcause,
    int_ecc_cause_detail
);
parameter VALEN = 32;
parameter NUM_PRIVILEGE_LEVELS = 1;
parameter CAUSE_LEN = 6;
parameter VECTOR_PLIC_SUPPORT_INT = 0;
parameter LOCALINT_SLPECC = 16;
parameter LOCALINT_SBE = 17;
parameter LOCALINT_HPMINT = 18;
parameter LOCALINT_ACEERR = 24;
parameter SLAVE_PORT_SUPPORT_INT = 0;
parameter ILM_ECC_TYPE_INT = 0;
parameter DLM_ECC_TYPE_INT = 0;
parameter DCACHE_ECC_TYPE_INT = 0;
parameter ICACHE_ECC_TYPE_INT = 0;
localparam PRIVILEGE_USER = 2'b00;
localparam PRIVILEGE_SUPERVISOR = 2'b01;
localparam PRIVILEGE_HYPERVISOR = 2'b10;
localparam PRIVILEGE_MACHINE = 2'b11;
localparam DDCAUSE_SLPECC = LOCALINT_SLPECC[5:0];
localparam DDCAUSE_SBE = LOCALINT_SBE[5:0];
localparam DDCAUSE_HPMINT = LOCALINT_HPMINT[5:0];
localparam INT_BWE_DCAUSE_STORE = 3'd2;
localparam HAS_ECC_LOCALINT = (((ILM_ECC_TYPE_INT != 0) & (SLAVE_PORT_SUPPORT_INT == 1)) | ((DLM_ECC_TYPE_INT != 0) & (SLAVE_PORT_SUPPORT_INT == 1)) | (DCACHE_ECC_TYPE_INT != 0)) ? 1 : 0;
localparam INT_MEI = 11;
localparam INT_MSI = 3;
localparam INT_MTI = 7;
localparam INT_SEI = 9;
localparam INT_SSI = 1;
localparam INT_STI = 5;
localparam INT_UEI = 8;
localparam INT_USI = 0;
localparam INT_UTI = 4;
localparam MEI = 0;
localparam MTI = 1;
localparam MSI = 2;
localparam SEI = 3;
localparam STI = 4;
localparam SSI = 5;
localparam UEI = 6;
localparam UTI = 7;
localparam USI = 8;
localparam LOCALINT_0 = (LOCALINT_HPMINT < LOCALINT_SBE) & (LOCALINT_HPMINT < LOCALINT_SLPECC) ? LOCALINT_HPMINT : (LOCALINT_SLPECC < LOCALINT_SBE) & (LOCALINT_SLPECC < LOCALINT_HPMINT) ? LOCALINT_SLPECC : LOCALINT_SBE;
localparam LOCALINT_2 = (LOCALINT_HPMINT > LOCALINT_SBE) & (LOCALINT_HPMINT > LOCALINT_SLPECC) ? LOCALINT_HPMINT : (LOCALINT_SLPECC > LOCALINT_SBE) & (LOCALINT_SLPECC > LOCALINT_HPMINT) ? LOCALINT_SLPECC : LOCALINT_SBE;
localparam LOCALINT_1 = (LOCALINT_0 != LOCALINT_HPMINT) & (LOCALINT_2 != LOCALINT_HPMINT) ? LOCALINT_HPMINT : (LOCALINT_0 != LOCALINT_SLPECC) & (LOCALINT_2 != LOCALINT_SLPECC) ? LOCALINT_SLPECC : LOCALINT_SBE;
localparam LOCALINT_3 = LOCALINT_ACEERR;
input core_clk;
input core_reset_n;
output hart_under_reset;
output hart_unavail;
input csr_halt_mode;
input csr_dcsr_step;
input csr_dcsr_stepie;
input csr_dcsr_debugint;
input csr_resethaltreq;
input resume;
input resume_vectored;
input ifu_ipipe_init_done;
output rf_init;
output epc_init;
output vpu_init_rf;
input [1:0] csr_cur_privilege;
input csr_mmisc_ctl_vec_plic;
input csr_mstatus_mie;
input csr_mstatus_sie;
input csr_mstatus_uie;
input [31:0] csr_mip;
input [31:0] csr_ipipe_slip;
input [31:0] csr_mie;
input [31:0] csr_ipipe_slie;
input [31:0] csr_mideleg;
input [31:0] csr_sideleg;
input [31:0] csr_mslideleg;
input csr_dexc2dbg_slpecc;
input csr_dexc2dbg_sbe;
input csr_dexc2dbg_pmov;
input nmi;
output meiack;
output seiack;
output ueiack;
input ipipe_csr_nmi_taken;
input [9:0] csr_meiid;
input [9:0] csr_seiid;
input [9:0] csr_ueiid;
input lsu_async_write_error;
input lsu_async_read_error;
input dcu_async_write_error;
input lm_async_write_error;
output ipipe_csr_nmi_pending;
output ipipe_csr_m_sbe_set;
output ipipe_csr_s_sbe_set;
output ipipe_csr_m_slpecc_clr;
output ipipe_csr_m_hpmint_clr;
output ipipe_csr_m_sbe_clr;
output ipipe_csr_s_slpecc_clr;
output ipipe_csr_s_hpmint_clr;
output ipipe_csr_s_sbe_clr;
output ipipe_csr_int_delegate_s;
output ipipe_csr_int_delegate_u;
output [9:0] int_code;
output [2:0] int_cause_detail;
output int_cause_interrupt;
output [4:0] trigm_int_code;
input [4:0] trigm_int_result;
output [4:0] itrigger_fire;
output int_ecc;
output wfi_done;
output async_valid;
input async_ready;
output debugint_valid;
output nmi_valid;
output mint_valid;
output sint_valid;
output uint_valid;
output mei_entry_sel;
output sei_entry_sel;
output uei_entry_sel;
output [11:0] mint_vec;
output [10:0] sint_vec;
output [9:0] uint_vec;
output int_detail_cause_valid;
output int_dex2dbg;
output [15:0] int_ddcause;
input [2:0] int_ecc_cause_detail;


wire s0 = (NUM_PRIVILEGE_LEVELS > 2);
wire s1 = (csr_cur_privilege == PRIVILEGE_MACHINE);
wire s2 = (csr_cur_privilege == PRIVILEGE_SUPERVISOR);
wire s3 = (csr_cur_privilege == PRIVILEGE_USER);
wire s4;
wire s5;
wire s6;
reg s7;
wire s8;
reg s9;
reg s10;
wire s11;
reg s12;
wire s13;
wire s14;
reg hart_under_reset;
wire s15;
wire s16;
wire s17;
wire s18;
wire s19;
wire [3:0] s20;
wire [3:0] s21;
wire [3:0] s22;
wire [9:0] s23;
wire [9:0] s24;
wire [9:0] s25;
wire [9:0] s26;
wire [9:0] s27;
wire [9:0] s28;
wire [9:0] s29;
wire [8:0] s30;
wire [8:3] s31;
wire [8:6] s32;
wire s33;
wire s34;
wire s35;
wire s36;
wire s37;
wire s38;
wire s39;
wire s40;
wire s41;
wire s42;
reg s43;
wire s44;
wire s45;
wire s46;
wire s47;
wire s48;
wire s49;
wire s50;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        hart_under_reset <= 1'b1;
    end
    else begin
        hart_under_reset <= ~ifu_ipipe_init_done;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s12 <= 1'b0;
    end
    else begin
        s12 <= s13;
    end
end

assign hart_unavail = hart_under_reset;
assign s13 = hart_under_reset & (csr_dcsr_debugint | csr_resethaltreq);
assign s14 = hart_under_reset & ifu_ipipe_init_done;
assign rf_init = s14 & ~s12;
assign epc_init = s14 & s12;
assign vpu_init_rf = s14 & ~s12;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s7 <= 1'b0;
    end
    else begin
        s7 <= s8;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s9 <= 1'b0;
        s10 <= 1'b0;
    end
    else begin
        s9 <= nmi;
        s10 <= s9;
    end
end

assign s11 = s9 & ~s10;
assign s8 = s11 | (s7 & ~ipipe_csr_nmi_taken);
assign s16 = s7;
assign ipipe_csr_nmi_pending = s7;
assign s4 = csr_mip[11];
wire s51 = csr_mip[7];
wire s52 = csr_mip[3];
assign s5 = csr_mip[9];
wire s53 = csr_mip[5];
wire s54 = csr_mip[1];
assign s6 = csr_mip[8];
wire s55 = csr_mip[4];
wire s56 = csr_mip[0];
wire s57 = csr_mie[11];
wire s58 = csr_mie[7];
wire s59 = csr_mie[3];
wire s60 = csr_mie[9];
wire s61 = csr_mie[5];
wire s62 = csr_mie[1];
wire s63 = csr_mie[8];
wire s64 = csr_mie[4];
wire s65 = csr_mie[0];
wire s66;
wire s67;
wire s68;
assign s20[0] = csr_mip[LOCALINT_0] & csr_mie[LOCALINT_0];
assign s20[1] = csr_mip[LOCALINT_1] & csr_mie[LOCALINT_1];
assign s20[2] = csr_mip[LOCALINT_2] & csr_mie[LOCALINT_2];
assign s20[3] = csr_mip[LOCALINT_3] & csr_mie[LOCALINT_3];
assign s21[0] = csr_ipipe_slip[LOCALINT_0] & csr_ipipe_slie[LOCALINT_0] & ~csr_mslideleg[LOCALINT_0];
assign s21[1] = csr_ipipe_slip[LOCALINT_1] & csr_ipipe_slie[LOCALINT_1] & ~csr_mslideleg[LOCALINT_1];
assign s21[2] = csr_ipipe_slip[LOCALINT_2] & csr_ipipe_slie[LOCALINT_2] & ~csr_mslideleg[LOCALINT_2];
assign s21[3] = csr_ipipe_slip[LOCALINT_3] & csr_ipipe_slie[LOCALINT_3] & ~csr_mslideleg[LOCALINT_3];
assign s30[MSI] = s52 & s59;
assign s30[MTI] = s51 & s58;
assign s30[MEI] = s4 & s57;
assign s30[SSI] = s54 & s62 & ~csr_mideleg[INT_SSI];
assign s30[STI] = s53 & s61 & ~csr_mideleg[INT_STI];
assign s30[SEI] = s5 & s60 & ~csr_mideleg[INT_SEI];
assign s30[USI] = s56 & s65 & ~csr_mideleg[INT_USI];
assign s30[UTI] = s55 & s64 & ~csr_mideleg[INT_UTI];
assign s30[UEI] = s6 & s63 & ~csr_mideleg[INT_UEI];
assign s22[0] = csr_ipipe_slip[LOCALINT_0] & csr_ipipe_slie[LOCALINT_0] & csr_mslideleg[LOCALINT_0];
assign s22[1] = csr_ipipe_slip[LOCALINT_1] & csr_ipipe_slie[LOCALINT_1] & csr_mslideleg[LOCALINT_1];
assign s22[2] = csr_ipipe_slip[LOCALINT_2] & csr_ipipe_slie[LOCALINT_2] & csr_mslideleg[LOCALINT_2];
assign s22[3] = csr_ipipe_slip[LOCALINT_3] & csr_ipipe_slie[LOCALINT_3] & csr_mslideleg[LOCALINT_3];
assign s31[SSI] = s54 & s62 & csr_mideleg[INT_SSI];
assign s31[STI] = s53 & s61 & csr_mideleg[INT_STI];
assign s31[SEI] = s5 & s60 & csr_mideleg[INT_SEI];
assign s31[USI] = s56 & s65 & csr_mideleg[INT_USI] & ~csr_sideleg[INT_USI];
assign s31[UTI] = s55 & s64 & csr_mideleg[INT_UTI] & ~csr_sideleg[INT_UTI];
assign s31[UEI] = s6 & s63 & csr_mideleg[INT_UEI] & ~csr_sideleg[INT_UEI];
assign s32[USI] = s56 & s65 & csr_mideleg[INT_USI] & csr_sideleg[INT_USI];
assign s32[UTI] = s55 & s64 & csr_mideleg[INT_UTI] & csr_sideleg[INT_UTI];
assign s32[UEI] = s6 & s63 & csr_mideleg[INT_UEI] & csr_sideleg[INT_UEI];
wire [29:0] s69;
wire [29:0] s70;
assign s70[29:27] = {s32[UTI],s32[USI],s32[UEI]};
assign s70[26:17] = {s31[UTI],s31[USI],s31[UEI],s31[STI],s31[SSI],s31[SEI],s22[0],s22[1],s22[2],s22[3]};
assign s70[16:00] = {s30[UTI],s30[USI],s30[UEI],s30[STI],s30[SSI],s30[SEI],s21[0],s21[1],s21[2],s21[3],s30[MTI],s30[MSI],s30[MEI],s20[0],s20[1],s20[2],s20[3]};
wire [29:0] s71 = ~s70[29:0] + 30'b1;
assign s69 = s70 & s71;
assign s23 = csr_mmisc_ctl_vec_plic ? mint_vec[9:0] : s27;
assign s24 = csr_mmisc_ctl_vec_plic ? sint_vec[9:0] : s28;
assign s25 = csr_mmisc_ctl_vec_plic ? uint_vec[9:0] : s29;
assign s26 = (INT_MSI[9:0] & {10{s69[05]}}) | (INT_MTI[9:0] & {10{s69[06]}}) | (INT_SSI[9:0] & {10{s69[12] | s69[22]}}) | (INT_STI[9:0] & {10{s69[13] | s69[23]}}) | (INT_USI[9:0] & {10{s69[15] | s69[25] | s69[28]}}) | (INT_UTI[9:0] & {10{s69[16] | s69[26] | s69[29]}}) | ((LOCALINT_0[9:0]) & {10{s69[3]}}) | ((LOCALINT_1[9:0]) & {10{s69[2]}}) | ((LOCALINT_2[9:0]) & {10{s69[1]}}) | ((LOCALINT_3[9:0]) & {10{s69[0]}}) | ((LOCALINT_0[9:0] + 10'd256) & {10{s69[10] | s69[20]}}) | ((LOCALINT_1[9:0] + 10'd256) & {10{s69[9] | s69[19]}}) | ((LOCALINT_2[9:0] + 10'd256) & {10{s69[8] | s69[18]}}) | ((LOCALINT_3[9:0] + 10'd256) & {10{s69[7] | s69[17]}});
assign s27 = (INT_MEI[9:0] & {10{s69[04]}}) | (INT_SEI[9:0] & {10{s69[11]}}) | (INT_UEI[9:0] & {10{s69[14]}});
assign s28 = (INT_SEI[9:0] & {10{s69[21]}}) | (INT_UEI[9:0] & {10{s69[24]}});
assign s29 = INT_UEI[9:0];
assign int_code = (s23[9:0] & {10{s69[04] | s69[11] | s69[14]}}) | (s24[9:0] & {10{(s69[21] | s69[24])}}) | (s25[9:0] & {10{(s69[27])}}) | s26;
assign int_cause_detail = ({3{(int_code == 10'd16)}} & int_ecc_cause_detail) | ({3{(int_code == 10'd17)}} & INT_BWE_DCAUSE_STORE) | ({3{(int_code == 10'd272)}} & int_ecc_cause_detail) | ({3{(int_code == 10'd273)}} & INT_BWE_DCAUSE_STORE);
assign int_cause_interrupt = ~csr_mmisc_ctl_vec_plic | ~(s69[04] | s69[11] | s69[14] | s69[21] | s69[24] | s69[27]);
assign s66 = s69[11];
assign trigm_int_code = (INT_MEI[4:0] & {5{s69[04]}}) | (INT_SEI[4:0] & {5{(s69[11] | s69[21])}}) | (INT_UEI[4:0] & {5{(s69[14] | s69[24] | s69[27])}}) | s26[4:0];
assign s47 = s69[04];
assign s48 = s69[11] | s69[21];
assign s49 = s69[14] | s69[24] | s69[27];
assign s67 = s69[14];
assign s68 = s69[24];
assign mei_entry_sel = s69[04] | s69[11] | s69[14];
assign sei_entry_sel = s69[21] | s69[24];
assign uei_entry_sel = s69[27];
assign int_detail_cause_valid = s33 | s34 | s35 | s36 | s37 | s38;
assign s17 = |s70[16:00];
assign s18 = |s69[26:17];
assign s19 = |s69[29:27];
assign s33 = s69[LOCALINT_2 - LOCALINT_SLPECC + 1];
assign s34 = s69[LOCALINT_2 - LOCALINT_SBE + 1];
assign s35 = s69[LOCALINT_2 - LOCALINT_HPMINT + 1];
assign s36 = (s69[8 + (LOCALINT_2 - LOCALINT_SLPECC)] | s69[18 + (LOCALINT_2 - LOCALINT_SLPECC)]);
assign s37 = (s69[8 + (LOCALINT_2 - LOCALINT_SBE)] | s69[18 + (LOCALINT_2 - LOCALINT_SBE)]);
assign s38 = (s69[8 + (LOCALINT_2 - LOCALINT_HPMINT)] | s69[18 + (LOCALINT_2 - LOCALINT_HPMINT)]);
assign int_dex2dbg = ((s33 | s36) & csr_dexc2dbg_slpecc) | ((s34 | s37) & csr_dexc2dbg_sbe) | ((s35 | s38) & csr_dexc2dbg_pmov);
assign int_ddcause = ({16{s33 | s36}} & {8'd0,8'd16}) | ({16{s34 | s37}} & {8'd0,8'd17}) | ({16{s35 | s38}} & {8'd0,8'd18});
assign s40 = csr_mstatus_mie | ~s1;
assign s41 = (csr_mstatus_sie & s2) | s3;
assign s42 = csr_mstatus_uie & s3;
assign ipipe_csr_int_delegate_s = sint_valid;
assign ipipe_csr_int_delegate_u = uint_valid;
assign mint_vec[9:0] = ({10{s69[4]}} & csr_meiid) | ({10{s69[11] & csr_mmisc_ctl_vec_plic}} & csr_seiid) | ({10{s69[14] & csr_mmisc_ctl_vec_plic}} & csr_ueiid);
assign sint_vec[9:0] = ({10{s69[21]}} & csr_seiid) | ({10{s69[24] & csr_mmisc_ctl_vec_plic}} & csr_ueiid);
assign uint_vec[9:0] = csr_ueiid;
assign mint_vec[11:10] = ({2{s69[4]}} & 2'd0) | ({2{s69[11] & csr_mmisc_ctl_vec_plic}} & 2'd1) | ({2{s69[14] & csr_mmisc_ctl_vec_plic & s0}} & 2'd2) | ({2{s69[14] & csr_mmisc_ctl_vec_plic & ~s0}} & 2'd1);
assign sint_vec[10] = s69[21] ? 1'd0 : s69[24] ? 1'd1 : 1'd0;
assign int_ecc = s33 | s36;
generate
    if ((VECTOR_PLIC_SUPPORT_INT == 1)) begin:gen_xei
        reg s72;
        wire s73 = mint_valid & async_ready & s47;
        wire s74 = ~s4;
        wire s75 = ~s74 & (s73 | s72);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s72 <= 1'b0;
            end
            else begin
                s72 <= s75;
            end
        end

        assign meiack = s72;
        reg s76;
        wire s77 = sint_valid & async_ready & s48 | mint_valid & async_ready & s66;
        wire s78 = ~s5;
        wire s79 = ~s78 & (s77 | s76);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s76 <= 1'b0;
            end
            else begin
                s76 <= s79;
            end
        end

        assign seiack = s76;
        reg s80;
        wire s81 = uint_valid & async_ready & s49 | sint_valid & async_ready & s68 | mint_valid & async_ready & s67;
        wire s82 = ~s6;
        wire s83 = ~s82 & (s81 | s80);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s80 <= 1'b0;
            end
            else begin
                s80 <= s83;
            end
        end

        assign ueiack = s80;
    end
    else begin:gen_xei_0
        assign meiack = 1'b0;
        assign seiack = 1'b0;
        assign ueiack = 1'b0;
        wire nds_unused_plic_signals = |{s68,s67,s66,s49,s48,s47};
    end
endgenerate
assign s39 = csr_dcsr_step & ~csr_dcsr_stepie;
assign debugint_valid = ~hart_under_reset & s15;
assign nmi_valid = ~hart_under_reset & ~s15 & ~s39 & s16;
assign mint_valid = ~hart_under_reset & ~s15 & ~s39 & ~s16 & (s40 & s17);
assign sint_valid = ~hart_under_reset & ~s15 & ~s39 & ~s16 & (s41 & s18);
assign uint_valid = ~hart_under_reset & ~s15 & ~s39 & ~s16 & (s42 & s19);
assign async_valid = hart_under_reset | debugint_valid | nmi_valid | mint_valid | sint_valid | uint_valid;
assign wfi_done = s15 | s16 | s17 | s18 | s19;
assign s44 = resume ? resume_vectored : 1'b0;
assign s45 = 1'b0;
assign s46 = s44 | (s43 & ~s45);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s43 <= 1'b0;
    end
    else begin
        s43 <= s46;
    end
end

assign s15 = (~csr_halt_mode & csr_dcsr_debugint) | s12;
assign itrigger_fire = {5{(mint_valid | sint_valid | uint_valid) & async_ready}} & trigm_int_result;
generate
    if (HAS_ECC_LOCALINT) begin:gen_async_ecc_error
        assign ipipe_csr_m_slpecc_clr = mint_valid & s33 & async_ready;
        assign ipipe_csr_s_slpecc_clr = (mint_valid | sint_valid) & s36 & async_ready;
    end
    else begin:gen_async_ecc_error_stub
        assign ipipe_csr_m_slpecc_clr = 1'b0;
        assign ipipe_csr_s_slpecc_clr = 1'b0;
    end
endgenerate
assign s50 = lsu_async_write_error | dcu_async_write_error | lm_async_write_error | lsu_async_read_error;
assign ipipe_csr_m_sbe_set = s50 & (s1 | ~s0);
assign ipipe_csr_s_sbe_set = s50 & ~s1 & s0;
assign ipipe_csr_m_sbe_clr = mint_valid & s34 & async_ready;
assign ipipe_csr_s_sbe_clr = (mint_valid | sint_valid) & s37 & async_ready;
assign ipipe_csr_m_hpmint_clr = mint_valid & s35 & async_ready;
assign ipipe_csr_s_hpmint_clr = (mint_valid | sint_valid) & s38 & async_ready;
endmodule


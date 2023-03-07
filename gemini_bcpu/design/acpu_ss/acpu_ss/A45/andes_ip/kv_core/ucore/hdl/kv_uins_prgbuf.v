// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_uins_prgbuf (
    core_reset_n,
    core_clk,
    sync_uins_sel,
    uinstr_end,
    cur_privilege_m,
    cur_privilege_s,
    cur_privilege_u,
    prgbuf_en,
    prgbuf_pc,
    prgbuf_update_pc,
    uinstr_ctrl,
    id_uinstr,
    id_dec_ctrl,
    pp_ucode_ctrl,
    pp_ucode_xcpt,
    pp_offset,
    pp_stackadj,
    instr_index
);
parameter UINS_PCLEN = 32;
parameter ICACHE_SIZE_KB = 0;
parameter DCACHE_SIZE_KB = 0;
parameter STLB_ECC_TYPE = 0;
localparam ILL_OP = 1'b1;
localparam CSR_MCCTLBEGINADDR = 12'h7cb;
localparam CSR_UCCTLBEGINADDR = 12'h80b;
localparam CSR_MCCTLDATA = 12'h7cd;
localparam CSR_SCCTLDATA = 12'h9cd;
localparam FUNC3_CSRRW = 3'b001;
localparam FUNC3_CSRRWI = 3'b101;
localparam OP_SYSTEM = 7'b1110011;
input core_reset_n;
input core_clk;
input cur_privilege_m;
input cur_privilege_s;
input cur_privilege_u;
input sync_uins_sel;
input uinstr_end;
input [7:0] instr_index;
input [31:0] id_uinstr;
input [43:0] id_dec_ctrl;
input prgbuf_en;
input [UINS_PCLEN - 3:0] prgbuf_update_pc;
output [UINS_PCLEN - 3:0] prgbuf_pc;
output [40:0] uinstr_ctrl;
input [2:0] pp_ucode_ctrl;
input pp_ucode_xcpt;
input [11:0] pp_offset;
input [11:0] pp_stackadj;


wire [40:0] s0;
wire [40:0] s1;
wire [40:0] s2;
wire [40:0] s3;
wire [40:0] s4;
wire [40:0] s5;
wire [40:0] s6;
wire [40:0] s7;
wire [40:0] s8;
wire [40:0] s9;
wire [11:0] s10;
wire [11:0] s11;
wire s12;
wire s13;
wire s14;
wire [11:0] s15;
wire s16;
reg [UINS_PCLEN - 3:0] prgbuf_pc;
wire [15:0] s17;
wire [7:0] s18;
wire s19;
wire s20;
wire s21;
wire s22;
wire s23;
wire s24;
wire s25;
wire s26;
wire s27;
wire s28;
wire s29;
wire s30;
wire s31;
wire s32;
wire s33;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        prgbuf_pc <= {(UINS_PCLEN - 2){1'b0}};
    end
    else if (prgbuf_en) begin
        prgbuf_pc <= prgbuf_update_pc;
    end
end

assign s16 = uinstr_end | sync_uins_sel;
assign uinstr_ctrl = ({41{uinstr_end}} & s7) | ({41{sync_uins_sel}} & s5) | ({41{instr_index[7] & ~s16}} & s0) | ({41{instr_index[6] & ~s16}} & s1) | ({41{instr_index[5] & ~s16}} & s2) | ({41{instr_index[4] & ~s16}} & s3) | ({41{instr_index[3] & ~s16}} & s3) | ({41{instr_index[2] & ~s16}} & s3) | ({41{instr_index[1] & ~s16}} & s3) | ({41{instr_index[0] & ~s16}} & s3);
assign s7 = ({41{instr_index[7]}} & s8) | ({41{instr_index[6]}} & s9);
assign s8[39] = {1'b0};
assign s8[40] = {1'b0};
assign s8[38] = {1'b0};
assign s8[12 +:16] = {16'h0001};
assign s8[28 +:5] = {id_uinstr[11:7]};
assign s8[33 +:5] = {5'h07};
assign s8[0 +:12] = {id_uinstr[31:20]};
assign s9[39] = 1'b0;
assign s9[40] = 1'b0;
assign s9[38] = ~s31;
assign s9[12 +:16] = s31 ? 16'h0001 : 16'h0800;
assign s9[28 +:5] = 5'h2;
assign s9[33 +:5] = s31 ? id_uinstr[19:15] : 5'h7;
assign s9[0 +:12] = s31 ? id_uinstr[31:20] : 12'h000;
assign s4[39] = {1'b1};
assign s4[40] = {1'b0};
assign s4[38] = {1'b0};
assign s4[12 +:16] = {16'h0000};
assign s4[28 +:5] = {5'h0};
assign s4[33 +:5] = {5'h0};
assign s4[0 +:12] = {12'd0};
assign s6[39] = {1'b0};
assign s6[40] = {1'b0};
assign s6[38] = {1'b0};
assign s6[12 +:16] = {16'h0000};
assign s6[28 +:5] = {5'h0};
assign s6[33 +:5] = {5'h0};
assign s6[0 +:12] = {12'd0};
assign s3 = {41{1'b0}};
assign s18 = prgbuf_pc[13:6];
assign s19 = (s18 == 8'b00010101) | (s18 == 8'b00010110) | (s18 == 8'b00011101) | (s18 == 8'b00011110) | (s18 == 8'b10010101) | (s18 == 8'b10010110);
assign s21 = (s18 == 8'b00001000) | (s18 == 8'b00001011) | (s18 == 8'b00001100) | (s18 == 8'b00011000) | (s18 == 8'b00011011) | (s18 == 8'b00011100) | (s18 == 8'b00011101) | (s18 == 8'b00011110);
assign s22 = (s18 == 8'b00001000);
assign s23 = s21 & ~s22;
assign s24 = (s18 == 8'b00000000) | (s18 == 8'b00000001) | (s18 == 8'b00000010) | (s18 == 8'b00000011) | (s18 == 8'b00000100) | (s18 == 8'b00000110) | (s18 == 8'b00000111) | (s18 == 8'b00010000) | (s18 == 8'b00010001) | (s18 == 8'b00010010) | (s18 == 8'b00010011) | (s18 == 8'b00010100) | (s18 == 8'b00010101) | (s18 == 8'b00010110) | (s18 == 8'b00010111);
assign s25 = (s18 == 8'b00000000) | (s18 == 8'b00000001) | (s18 == 8'b00000010);
assign s26 = s24 & ~s25;
assign s27 = (s18 == 8'b10010011) | (s18 == 8'b10010101) | (s18 == 8'b10010100) | (s18 == 8'b10010110);
assign s28 = s27;
assign s12 = (ICACHE_SIZE_KB == 0);
assign s13 = (DCACHE_SIZE_KB == 0);
assign s14 = (STLB_ECC_TYPE != 1);
assign s29 = ~(s21 | s24 | s27);
assign s20 = (s21 & s12) | (s24 & s13) | (s27 & s14) | (s23 & cur_privilege_u) | (s26 & cur_privilege_u) | (s28 & cur_privilege_u) | s29;
assign s17 = s19 ? 16'h2022 : 16'h2012;
assign s15 = {7'b0,id_uinstr[19:15]};
assign s10 = {12{cur_privilege_m}} & CSR_MCCTLBEGINADDR | {12{~cur_privilege_m}} & CSR_UCCTLBEGINADDR;
assign s11 = {12{cur_privilege_m}} & CSR_MCCTLDATA | {12{~cur_privilege_m}} & CSR_SCCTLDATA;
wire [40:0] s34;
assign s34[39] = 1'b0;
assign s34[40] = 1'b0;
assign s34[38] = 1'b0;
assign s34[12 +:16] = 16'h0800;
assign s34[28 +:5] = 5'h7;
assign s34[33 +:5] = id_uinstr[19:15];
assign s34[0 +:12] = 12'h000;
wire [40:0] s35;
assign s35[39] = {1'b0};
assign s35[40] = {1'b0};
assign s35[38] = {1'b0};
assign s35[12 +:16] = {16'h0400};
assign s35[28 +:5] = {5'h0};
assign s35[33 +:5] = {5'h0};
assign s35[0 +:12] = {12'hc};
wire [40:0] s36;
assign s36[39] = {1'b0};
assign s36[40] = {1'b0};
assign s36[38] = {1'b0};
assign s36[12 +:16] = {16'h0800};
assign s36[28 +:5] = {5'h7};
assign s36[33 +:5] = {5'h0};
assign s36[0 +:12] = {s15};
wire [40:0] s37;
assign s37[39] = {1'b0};
assign s37[40] = {1'b0};
assign s37[38] = {1'b0};
assign s37[12 +:16] = {16'h0080};
assign s37[28 +:5] = {5'h8};
assign s37[33 +:5] = {5'h7};
assign s37[0 +:12] = {12'd8};
wire [40:0] s38;
assign s38[39] = {1'b0};
assign s38[40] = {1'b0};
assign s38[38] = {1'b0};
assign s38[12 +:16] = {16'h0400};
assign s38[28 +:5] = {5'h0};
assign s38[33 +:5] = {5'h8};
assign s38[0 +:12] = {12'd20};
wire [40:0] s39;
assign s39[39] = {1'b0};
assign s39[40] = {1'b0};
assign s39[38] = {1'b0};
assign s39[12 +:16] = {16'h0200};
assign s39[28 +:5] = {5'h6};
assign s39[33 +:5] = {5'h0};
assign s39[0 +:12] = {s11};
wire [40:0] s40;
assign s40[39] = {1'b0};
assign s40[40] = {1'b0};
assign s40[38] = {1'b0};
assign s40[12 +:16] = {16'h0200};
assign s40[28 +:5] = {5'h5};
assign s40[33 +:5] = {5'h0};
assign s40[0 +:12] = {s10};
wire [40:0] s41;
assign s41[39] = {1'b0};
assign s41[40] = {s20};
assign s41[38] = {1'b1};
assign s41[12 +:16] = {s17};
assign s41[28 +:5] = {5'h6};
assign s41[33 +:5] = {5'h5};
assign s41[0 +:12] = {{4'b0,s18}};
kv_mux #(
    .N(12),
    .W(41)
) kv_cctl_body (
    .out(s0),
    .sel(prgbuf_pc[3:0]),
    .in({{s6},{s6},{s41},{s6},{s40},{s39},{s4},{s38},{s37},{s36},{s35},{s34}})
);
assign s30 = id_dec_ctrl[7] | id_dec_ctrl[8];
assign s31 = id_dec_ctrl[6] & s33;
assign s32 = id_dec_ctrl[12];
assign s33 = id_dec_ctrl[43];
wire [40:0] s42;
assign s42[39] = 1'b0;
assign s42[40] = 1'b0;
assign s42[38] = 1'b0;
assign s42[12 +:16] = {6'h00,s31,5'h00,s32,s30,2'h0};
assign s42[28 +:5] = 5'h7;
assign s42[33 +:5] = id_dec_ctrl[38 +:5];
assign s42[0 +:12] = id_uinstr[31:20];
wire [40:0] s43;
assign s43[39] = 1'b0;
assign s43[40] = 1'b0;
assign s43[38] = 1'b0;
assign s43[12 +:16] = 16'h0800;
assign s43[28 +:5] = 5'h7;
assign s43[33 +:5] = 5'h7;
assign s43[0 +:12] = 12'h000;
wire [40:0] s44;
assign s44[39] = 1'b0;
assign s44[40] = 1'b0;
assign s44[38] = s31;
assign s44[12 +:16] = 16'h002;
assign s44[28 +:5] = 5'h0;
assign s44[33 +:5] = 5'h0;
assign s44[0 +:12] = 12'h000;
kv_mux #(
    .N(8),
    .W(41)
) kv_sp_check_body (
    .out(s1),
    .sel(prgbuf_pc[2:0]),
    .in({{s6},{s6},{s6},{s6},{s6},{s44},{s43},{s42}})
);
wire s45 = pp_ucode_ctrl[0];
wire s46 = pp_ucode_ctrl[1];
wire s47 = pp_ucode_ctrl[2];
wire [4:0] s48 = 5'd0;
wire [4:0] s49 = 5'd1;
wire [4:0] s50 = 5'd2;
wire [15:0] s51 = {16'h0800};
wire [15:0] s52 = s46 ? 16'h8000 : 16'h4000;
wire [15:0] s53 = {12'h280,2'd0,(~s47),1'b0};
wire [15:0] s54 = {16'h2402};
wire s55 = instr_index[5];
wire [40:0] s56;
assign s56[40] = {pp_ucode_xcpt};
assign s56[39] = {s55};
assign s56[38] = {1'b0};
assign s56[12 +:16] = s51;
assign s56[28 +:5] = s48;
assign s56[33 +:5] = s50;
assign s56[0 +:12] = {12'd0};
wire [40:0] s57;
assign s57[40] = {1'b0};
assign s57[39] = {1'b0};
assign s57[38] = {1'b0};
assign s57[12 +:16] = s52;
assign s57[28 +:5] = s46 ? 5'd27 : 5'd27;
assign s57[33 +:5] = s46 ? 5'd2 : 5'd2;
assign s57[0 +:12] = pp_offset;
wire [40:0] s58;
assign s58[40] = {1'b0};
assign s58[39] = {1'b0};
assign s58[38] = {1'b0};
assign s58[12 +:16] = s52;
assign s58[28 +:5] = s46 ? 5'd26 : 5'd26;
assign s58[33 +:5] = s46 ? 5'd2 : 5'd2;
assign s58[0 +:12] = pp_offset;
wire [40:0] s59;
assign s59[40] = {1'b0};
assign s59[39] = {1'b0};
assign s59[38] = {1'b0};
assign s59[12 +:16] = s52;
assign s59[28 +:5] = s46 ? 5'd25 : 5'd25;
assign s59[33 +:5] = s46 ? 5'd2 : 5'd2;
assign s59[0 +:12] = pp_offset;
wire [40:0] s60;
assign s60[40] = {1'b0};
assign s60[39] = {1'b0};
assign s60[38] = {1'b0};
assign s60[12 +:16] = s52;
assign s60[28 +:5] = s46 ? 5'd24 : 5'd24;
assign s60[33 +:5] = s46 ? 5'd2 : 5'd2;
assign s60[0 +:12] = pp_offset;
wire [40:0] s61;
assign s61[40] = {1'b0};
assign s61[39] = {1'b0};
assign s61[38] = {1'b0};
assign s61[12 +:16] = s52;
assign s61[28 +:5] = s46 ? 5'd23 : 5'd23;
assign s61[33 +:5] = s46 ? 5'd2 : 5'd2;
assign s61[0 +:12] = pp_offset;
wire [40:0] s62;
assign s62[40] = {1'b0};
assign s62[39] = {1'b0};
assign s62[38] = {1'b0};
assign s62[12 +:16] = s52;
assign s62[28 +:5] = s46 ? 5'd22 : 5'd22;
assign s62[33 +:5] = s46 ? 5'd2 : 5'd2;
assign s62[0 +:12] = pp_offset;
wire [40:0] s63;
assign s63[40] = {1'b0};
assign s63[39] = {1'b0};
assign s63[38] = {1'b0};
assign s63[12 +:16] = s52;
assign s63[28 +:5] = s46 ? 5'd21 : 5'd21;
assign s63[33 +:5] = s46 ? 5'd2 : 5'd2;
assign s63[0 +:12] = pp_offset;
wire [40:0] s64;
assign s64[40] = {1'b0};
assign s64[39] = {1'b0};
assign s64[38] = {1'b0};
assign s64[12 +:16] = s52;
assign s64[28 +:5] = s46 ? 5'd20 : 5'd20;
assign s64[33 +:5] = s46 ? 5'd2 : 5'd2;
assign s64[0 +:12] = pp_offset;
wire [40:0] s65;
assign s65[40] = {1'b0};
assign s65[39] = {1'b0};
assign s65[38] = {1'b0};
assign s65[12 +:16] = s52;
assign s65[28 +:5] = s46 ? 5'd19 : 5'd19;
assign s65[33 +:5] = s46 ? 5'd2 : 5'd2;
assign s65[0 +:12] = pp_offset;
wire [40:0] s66;
assign s66[40] = {1'b0};
assign s66[39] = {1'b0};
assign s66[38] = {1'b0};
assign s66[12 +:16] = s52;
assign s66[28 +:5] = s46 ? 5'd18 : 5'd18;
assign s66[33 +:5] = s46 ? 5'd2 : 5'd2;
assign s66[0 +:12] = pp_offset;
wire [40:0] s67;
assign s67[40] = {1'b0};
assign s67[39] = {1'b0};
assign s67[38] = {1'b0};
assign s67[12 +:16] = s52;
assign s67[28 +:5] = s46 ? 5'd9 : 5'd9;
assign s67[33 +:5] = s46 ? 5'd2 : 5'd2;
assign s67[0 +:12] = pp_offset;
wire [40:0] s68;
assign s68[40] = {1'b0};
assign s68[39] = {1'b0};
assign s68[38] = {1'b0};
assign s68[12 +:16] = s52;
assign s68[28 +:5] = s46 ? 5'd8 : 5'd8;
assign s68[33 +:5] = s46 ? 5'd2 : 5'd2;
assign s68[0 +:12] = pp_offset;
wire [40:0] s69;
assign s69[40] = {1'b0};
assign s69[39] = {1'b0};
assign s69[38] = {1'b0};
assign s69[12 +:16] = s52;
assign s69[28 +:5] = s46 ? 5'd1 : 5'd1;
assign s69[33 +:5] = s46 ? 5'd2 : 5'd2;
assign s69[0 +:12] = pp_offset;
wire [40:0] s70;
assign s70[40] = {1'b0};
assign s70[39] = {1'b0};
assign s70[38] = {1'b0};
assign s70[12 +:16] = s53;
assign s70[28 +:5] = s50;
assign s70[33 +:5] = s50;
assign s70[0 +:12] = pp_stackadj;
wire [40:0] s71;
assign s71[40] = {1'b0};
assign s71[39] = {1'b0};
assign s71[38] = {1'b0};
assign s71[12 +:16] = s54;
assign s71[28 +:5] = s48;
assign s71[33 +:5] = s49;
assign s71[0 +:12] = {12'd0};
kv_mux #(
    .N(16),
    .W(41)
) kv_pp_body (
    .out(s2),
    .sel(prgbuf_pc[3:0]),
    .in({{s71},{s70},{s69},{s68},{s67},{s66},{s65},{s64},{s63},{s62},{s61},{s60},{s59},{s58},{s57},{s56}})
);
assign s5 = s55 ? s56 : s4;
wire nds_unused_cur_privilege_s = cur_privilege_s;
endmodule


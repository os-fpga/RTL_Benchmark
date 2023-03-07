// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dec (
    cur_privilege_m,
    cur_privilege_s,
    cur_privilege_u,
    csr_mstatus_tw,
    csr_mstatus_tvm,
    csr_mstatus_tsr,
    csr_mhsp_ctl_m,
    csr_mhsp_ctl_s,
    csr_mhsp_ctl_u,
    csr_mmisc_ctl_aces,
    src2_imm,
    id_ctrl,
    instr_from_exec_it,
    csr_frm,
    csr_mstatus_fs,
    csr_mmisc_ctl_rvcompm,
    csr_halt_mode,
    csr_dcsr_step,
    csr_dcsr_ebreakm,
    csr_dcsr_ebreaks,
    csr_dcsr_ebreaku,
    trigm_icount_enabled,
    ifu_vector_resume,
    ifu_pred_bogus,
    ifu_pred_hit,
    ifu_pred_taken,
    ifu_pred_start,
    ifu_pred_brk,
    ifu_fault,
    ifu_fault_dcause,
    ifu_ecc_code,
    ifu_ecc_corr,
    ifu_ecc_ramid,
    ifu_page_fault,
    ifu_fault_upper,
    ifu_instr,
    ifu_instr_16b
);
parameter FLEN = 32;
parameter VLEN = 512;
parameter RVA_SUPPORT_INT = 0;
parameter RVN_SUPPORT_INT = 0;
parameter DSP_SUPPORT_INT = 0;
parameter ACE_SUPPORT_INT = 0;
parameter ISA_GP_INT = 0;
parameter ISA_LEA_INT = 0;
parameter ISA_BEQC_INT = 0;
parameter ISA_BBZ_INT = 0;
parameter ISA_BFO_INT = 0;
parameter ISA_STR_INT = 0;
parameter STACKSAFE_SUPPORT_INT = 0;
parameter NUM_PRIVILEGE_LEVELS = 1;
parameter MULTIPLIER_INT = 1;
parameter VACE_CTRL_BITS = 32;
input cur_privilege_m;
input cur_privilege_s;
input cur_privilege_u;
input csr_mstatus_tw;
input csr_mstatus_tvm;
input csr_mstatus_tsr;
input csr_mhsp_ctl_m;
input csr_mhsp_ctl_s;
input csr_mhsp_ctl_u;
input [1:0] csr_mmisc_ctl_aces;
output [31:0] src2_imm;
output [322:0] id_ctrl;
input instr_from_exec_it;
input [31:0] csr_frm;
input [1:0] csr_mstatus_fs;
input csr_mmisc_ctl_rvcompm;
input csr_halt_mode;
input csr_dcsr_step;
input csr_dcsr_ebreakm;
input csr_dcsr_ebreaks;
input csr_dcsr_ebreaku;
input trigm_icount_enabled;
input ifu_vector_resume;
input ifu_pred_bogus;
input ifu_pred_hit;
input ifu_pred_taken;
input ifu_pred_start;
input ifu_pred_brk;
input ifu_fault;
input [2:0] ifu_fault_dcause;
input [7:0] ifu_ecc_code;
input ifu_ecc_corr;
input [2:0] ifu_ecc_ramid;
input ifu_page_fault;
input ifu_fault_upper;
input [31:0] ifu_instr;
input ifu_instr_16b;
localparam OP_LOAD = 7'b0000011;
localparam OP_MISC_MEM = 7'b0001111;
localparam OP_IMM = 7'b0010011;
localparam OP_AUIPC = 7'b0010111;
localparam OP_IMM32 = 7'b0011011;
localparam OP_STORE = 7'b0100011;
localparam OP_ATOMIC = 7'b0101111;
localparam OP_OP = 7'b0110011;
localparam OP_LUI = 7'b0110111;
localparam OP_OP32 = 7'b0111011;
localparam OP_JALR = 7'b1100111;
localparam OP_JAL = 7'b1101111;
localparam OP_SYSTEM = 7'b1110011;
localparam OP_BRANCH = 7'b1100011;
localparam OP_USYSTEM = 7'b1110010;
localparam OP_ACE = 7'b1111011;
localparam OP_CUSTOM0 = 7'b0001011;
localparam OP_CUSTOM1 = 7'b0101011;
localparam OP_CUSTOM2 = 7'b1011011;
localparam OP_C0 = 2'b00;
localparam OP_C1 = 2'b01;
localparam OP_C2 = 2'b10;
localparam MDUOP_MUL = 4'b0000;
localparam MDUOP_MULH = 4'b0001;
localparam MDUOP_MULHU = 4'b0010;
localparam MDUOP_MULHSU = 4'b0011;
localparam MDUOP_DIV = 4'b0100;
localparam MDUOP_DIVU = 4'b0101;
localparam MDUOP_REM = 4'b0110;
localparam MDUOP_REMU = 4'b0111;
localparam MDUOP_MULW = 4'b1000;
localparam MDUOP_DIVW = 4'b1100;
localparam MDUOP_DIVUW = 4'b1101;
localparam MDUOP_REMW = 4'b1110;
localparam MDUOP_REMUW = 4'b1111;
localparam ATOMIC_LR = 5'b00010;
localparam ATOMIC_SC = 5'b00011;
localparam ATOMIC_AMOSWAP = 5'b00001;
localparam ATOMIC_AMOADD = 5'b00000;
localparam ATOMIC_AMOXOR = 5'b00100;
localparam ATOMIC_AMOAND = 5'b01100;
localparam ATOMIC_AMOOR = 5'b01000;
localparam ATOMIC_AMOMIN = 5'b10000;
localparam ATOMIC_AMOMAX = 5'b10100;
localparam ATOMIC_AMOMINU = 5'b11000;
localparam ATOMIC_AMOMAXU = 5'b11100;
localparam CSR12_MCCTLCOMMAND = 12'h7cc;
localparam CSR12_UCCTLCOMMAND = 12'h80c;
localparam OP_CCTL_RD = 7'b1110111;
localparam OP_CCTL_WR = 7'b1111011;
localparam OP_FP_LOAD = 7'b0000111;
localparam OP_FP_STORE = 7'b0100111;
localparam OP_FP = 7'b1010011;
localparam OP_FP_MADD = 7'b1000011;
localparam OP_FP_MSUB = 7'b1000111;
localparam OP_FP_NMADD = 7'b1001111;
localparam OP_FP_NMSUB = 7'b1001011;
localparam OP_DSP = 7'b1111111;
localparam FUNC3_CSRRW = 3'b001;
localparam FUNC3_CSRRS = 3'b010;
localparam FUNC3_CSRRC = 3'b011;
localparam FUNC3_CSRRWI = 3'b101;
localparam FUNC3_CSRRSI = 3'b110;
localparam FUNC3_CSRRCI = 3'b111;
localparam CSR12_MVENDORID = 12'hf11;
localparam CSR12_MARCHID = 12'hf12;
localparam CSR12_MIMPID = 12'hf13;
localparam CSR12_MHARTID = 12'hf14;
localparam CSR12_MSTATUS = 12'h300;
localparam CSR12_MISA = 12'h301;
localparam CSR12_MEDELEG = 12'h302;
localparam CSR12_MIDELEG = 12'h303;
localparam CSR12_MIE = 12'h304;
localparam CSR12_MTVEC = 12'h305;
localparam CSR12_MSCRATCH = 12'h340;
localparam CSR12_MEPC = 12'h341;
localparam CSR12_MCAUSE = 12'h342;
localparam CSR12_MTVAL = 12'h343;
localparam CSR12_MIP = 12'h344;
localparam CSR12_MCYCLE = 12'hb00;
localparam CSR12_MINSTRET = 12'hb02;
localparam CSR12_MHPMCOUNTER3 = 12'hb03;
localparam CSR12_MHPMCOUNTER4 = 12'hb04;
localparam CSR12_MHPMCOUNTER5 = 12'hb05;
localparam CSR12_MHPMCOUNTER6 = 12'hb06;
localparam CSR12_MHPMCOUNTER7 = 12'hb07;
localparam CSR12_MHPMCOUNTER8 = 12'hb08;
localparam CSR12_MHPMCOUNTER9 = 12'hb09;
localparam CSR12_MHPMCOUNTER10 = 12'hb0a;
localparam CSR12_MHPMCOUNTER11 = 12'hb0b;
localparam CSR12_MHPMCOUNTER12 = 12'hb0c;
localparam CSR12_MHPMCOUNTER13 = 12'hb0d;
localparam CSR12_MHPMCOUNTER14 = 12'hb0e;
localparam CSR12_MHPMCOUNTER15 = 12'hb0f;
localparam CSR12_MHPMCOUNTER16 = 12'hb10;
localparam CSR12_MHPMCOUNTER17 = 12'hb11;
localparam CSR12_MHPMCOUNTER18 = 12'hb12;
localparam CSR12_MHPMCOUNTER19 = 12'hb13;
localparam CSR12_MHPMCOUNTER20 = 12'hb14;
localparam CSR12_MHPMCOUNTER21 = 12'hb15;
localparam CSR12_MHPMCOUNTER22 = 12'hb16;
localparam CSR12_MHPMCOUNTER23 = 12'hb17;
localparam CSR12_MHPMCOUNTER24 = 12'hb18;
localparam CSR12_MHPMCOUNTER25 = 12'hb19;
localparam CSR12_MHPMCOUNTER26 = 12'hb1a;
localparam CSR12_MHPMCOUNTER27 = 12'hb1b;
localparam CSR12_MHPMCOUNTER28 = 12'hb1c;
localparam CSR12_MHPMCOUNTER29 = 12'hb1d;
localparam CSR12_MHPMCOUNTER30 = 12'hb1e;
localparam CSR12_MHPMCOUNTER31 = 12'hb1f;
localparam CSR12_MCYCLEH = 12'hb80;
localparam CSR12_MINSTRETH = 12'hb82;
localparam CSR12_MHPMCOUNTER3H = 12'hb83;
localparam CSR12_MHPMCOUNTER4H = 12'hb84;
localparam CSR12_MHPMCOUNTER5H = 12'hb85;
localparam CSR12_MHPMCOUNTER6H = 12'hb86;
localparam CSR12_MHPMCOUNTER7H = 12'hb87;
localparam CSR12_MHPMCOUNTER8H = 12'hb88;
localparam CSR12_MHPMCOUNTER9H = 12'hb89;
localparam CSR12_MHPMCOUNTER10H = 12'hb8a;
localparam CSR12_MHPMCOUNTER11H = 12'hb8b;
localparam CSR12_MHPMCOUNTER12H = 12'hb8c;
localparam CSR12_MHPMCOUNTER13H = 12'hb8d;
localparam CSR12_MHPMCOUNTER14H = 12'hb8e;
localparam CSR12_MHPMCOUNTER15H = 12'hb8f;
localparam CSR12_MHPMCOUNTER16H = 12'hb90;
localparam CSR12_MHPMCOUNTER17H = 12'hb91;
localparam CSR12_MHPMCOUNTER18H = 12'hb92;
localparam CSR12_MHPMCOUNTER19H = 12'hb93;
localparam CSR12_MHPMCOUNTER20H = 12'hb94;
localparam CSR12_MHPMCOUNTER21H = 12'hb95;
localparam CSR12_MHPMCOUNTER22H = 12'hb96;
localparam CSR12_MHPMCOUNTER23H = 12'hb97;
localparam CSR12_MHPMCOUNTER24H = 12'hb98;
localparam CSR12_MHPMCOUNTER25H = 12'hb99;
localparam CSR12_MHPMCOUNTER26H = 12'hb9a;
localparam CSR12_MHPMCOUNTER27H = 12'hb9b;
localparam CSR12_MHPMCOUNTER28H = 12'hb9c;
localparam CSR12_MHPMCOUNTER29H = 12'hb9d;
localparam CSR12_MHPMCOUNTER30H = 12'hb9e;
localparam CSR12_MHPMCOUNTER31H = 12'hb9f;
localparam CSR12_MXSTATUS = 12'h7c4;
localparam CSR12_MDCAUSE = 12'h7c9;
localparam CSR12_MCCTLBEGINADDR = 12'h7cb;
localparam CSR12_MCCTLDATA = 12'h7cd;
localparam CSR12_MMISC_CTL = 12'h7d0;
localparam CSR12_MSLIDELEG = 12'h7d5;
localparam CSR12_CYCLE = 12'hc00;
localparam CSR12_INSTRET = 12'hc02;
localparam CSR12_HPMCOUNTER3 = 12'hc03;
localparam CSR12_HPMCOUNTER4 = 12'hc04;
localparam CSR12_HPMCOUNTER5 = 12'hc05;
localparam CSR12_HPMCOUNTER6 = 12'hc06;
localparam CSR12_HPMCOUNTER7 = 12'hc07;
localparam CSR12_HPMCOUNTER8 = 12'hc08;
localparam CSR12_HPMCOUNTER9 = 12'hc09;
localparam CSR12_HPMCOUNTER10 = 12'hc0a;
localparam CSR12_HPMCOUNTER11 = 12'hc0b;
localparam CSR12_HPMCOUNTER12 = 12'hc0c;
localparam CSR12_HPMCOUNTER13 = 12'hc0d;
localparam CSR12_HPMCOUNTER14 = 12'hc0e;
localparam CSR12_HPMCOUNTER15 = 12'hc0f;
localparam CSR12_HPMCOUNTER16 = 12'hc10;
localparam CSR12_HPMCOUNTER17 = 12'hc11;
localparam CSR12_HPMCOUNTER18 = 12'hc12;
localparam CSR12_HPMCOUNTER19 = 12'hc13;
localparam CSR12_HPMCOUNTER20 = 12'hc14;
localparam CSR12_HPMCOUNTER21 = 12'hc15;
localparam CSR12_HPMCOUNTER22 = 12'hc16;
localparam CSR12_HPMCOUNTER23 = 12'hc17;
localparam CSR12_HPMCOUNTER24 = 12'hc18;
localparam CSR12_HPMCOUNTER25 = 12'hc19;
localparam CSR12_HPMCOUNTER26 = 12'hc1a;
localparam CSR12_HPMCOUNTER27 = 12'hc1b;
localparam CSR12_HPMCOUNTER28 = 12'hc1c;
localparam CSR12_HPMCOUNTER29 = 12'hc1d;
localparam CSR12_HPMCOUNTER30 = 12'hc1e;
localparam CSR12_HPMCOUNTER31 = 12'hc1f;
localparam CSR12_CYCLEH = 12'hc80;
localparam CSR12_INSTRETH = 12'hc82;
localparam CSR12_HPMCOUNTER3H = 12'hc83;
localparam CSR12_HPMCOUNTER4H = 12'hc84;
localparam CSR12_HPMCOUNTER5H = 12'hc85;
localparam CSR12_HPMCOUNTER6H = 12'hc86;
localparam CSR12_HPMCOUNTER7H = 12'hc87;
localparam CSR12_HPMCOUNTER8H = 12'hc88;
localparam CSR12_HPMCOUNTER9H = 12'hc89;
localparam CSR12_HPMCOUNTER10H = 12'hc8a;
localparam CSR12_HPMCOUNTER11H = 12'hc8b;
localparam CSR12_HPMCOUNTER12H = 12'hc8c;
localparam CSR12_HPMCOUNTER13H = 12'hc8d;
localparam CSR12_HPMCOUNTER14H = 12'hc8e;
localparam CSR12_HPMCOUNTER15H = 12'hc8f;
localparam CSR12_HPMCOUNTER16H = 12'hc90;
localparam CSR12_HPMCOUNTER17H = 12'hc91;
localparam CSR12_HPMCOUNTER18H = 12'hc92;
localparam CSR12_HPMCOUNTER19H = 12'hc93;
localparam CSR12_HPMCOUNTER20H = 12'hc94;
localparam CSR12_HPMCOUNTER21H = 12'hc95;
localparam CSR12_HPMCOUNTER22H = 12'hc96;
localparam CSR12_HPMCOUNTER23H = 12'hc97;
localparam CSR12_HPMCOUNTER24H = 12'hc98;
localparam CSR12_HPMCOUNTER25H = 12'hc99;
localparam CSR12_HPMCOUNTER26H = 12'hc9a;
localparam CSR12_HPMCOUNTER27H = 12'hc9b;
localparam CSR12_HPMCOUNTER28H = 12'hc9c;
localparam CSR12_HPMCOUNTER29H = 12'hc9d;
localparam CSR12_HPMCOUNTER30H = 12'hc9e;
localparam CSR12_HPMCOUNTER31H = 12'hc9f;
localparam CSR12_SSTATUS = 12'h100;
localparam CSR12_SEDELEG = 12'h102;
localparam CSR12_SIDELEG = 12'h103;
localparam CSR12_SIE = 12'h104;
localparam CSR12_STVEC = 12'h105;
localparam CSR12_SSCRATCH = 12'h140;
localparam CSR12_SEPC = 12'h141;
localparam CSR12_SCAUSE = 12'h142;
localparam CSR12_STVAL = 12'h143;
localparam CSR12_SIP = 12'h144;
localparam CSR12_SLIE = 12'h9c4;
localparam CSR12_SLIP = 12'h9c5;
localparam CSR12_SDCAUSE = 12'h9c9;
localparam CSR12_USTATUS = 12'h000;
localparam CSR12_UIE = 12'h004;
localparam CSR12_UTVEC = 12'h005;
localparam CSR12_USCRATCH = 12'h040;
localparam CSR12_UEPC = 12'h041;
localparam CSR12_UCAUSE = 12'h042;
localparam CSR12_UTVAL = 12'h043;
localparam CSR12_UIP = 12'h044;
localparam CSR12_UDCAUSE = 12'h809;
localparam CSR12_TSELECT = 12'h7a0;
localparam CSR12_DPC = 12'h7b1;
localparam CSR12_DSCRATCH0 = 12'h7b2;
localparam CSR12_DSCRATCH1 = 12'h7b3;
localparam CSR12_DDCAUSE = 12'h7e1;
localparam CSR12_FFLAGS = 12'h001;
localparam OP_UINS_SYNC = 7'b1010111;


wire s0 = 1'b0;
wire s1 = (NUM_PRIVILEGE_LEVELS > 2);
wire s2 = (NUM_PRIVILEGE_LEVELS > 1);
wire s3 = 1'b1;
wire s4 = (RVA_SUPPORT_INT == 1);
wire s5 = ((ISA_GP_INT == 1));
wire s6 = ((ISA_LEA_INT == 1));
wire s7 = ((ISA_BEQC_INT == 1));
wire s8 = ((ISA_BBZ_INT == 1));
wire s9 = ((ISA_BFO_INT == 1));
wire s10 = ((ISA_STR_INT == 1));
wire s11 = ~csr_mmisc_ctl_rvcompm;
wire s12 = 1'b0;
wire s13 = 1'b1;
wire s14 = 1'b0;
wire isa_c_dp_fls_en = 1'b1;
wire s15 = 1'b0;
wire s16 = 1'b0;
wire s17 = 1'b0;
wire s18 = 1'b0;
wire s19 = 1'b0;
wire s20 = 1'b0;
wire [4:0] s21;
wire rd1_wen;
wire [4:0] s22;
wire rs1_ren;
wire s23;
wire [4:0] s24;
wire rs2_ren;
wire [4:0] s25;
wire [4:0] s26;
wire [4:0] s27;
wire rd2_wen;
wire rs3_ren;
wire rs4_ren;
wire s28;
wire s29;
wire s30;
wire s31;
wire s32;
wire [4:0] s33 = ifu_instr[11:7];
wire [4:0] s34 = ifu_instr[19:15];
wire [4:0] s35 = ifu_instr[24:20];
wire [4:0] s36 = ifu_instr[11:7];
wire [4:0] s37 = ifu_instr[11:7];
wire [4:0] s38 = ifu_instr[6:2];
wire [2:0] s39 = ifu_instr[4:2];
wire [2:0] s40 = ifu_instr[9:7];
wire [2:0] s41 = ifu_instr[9:7];
wire [5:0] s42 = {ifu_instr[12],ifu_instr[6:2]};
wire s43 = ((s42[5] == 1'b0));
wire s44 = |s42;
wire s45 = (ifu_instr[12:5] != 8'b0);
wire [2:0] s46 = ifu_instr[4:2];
wire s47;
wire ace_dec_xrf_rs1_ren;
wire ace_dec_xrf_rs2_ren;
wire ace_dec_xrf_rs3_ren;
wire ace_dec_xrf_rs4_ren;
wire ace_dec_xrf_rd1_wen;
wire ace_dec_xrf_rd2_wen;
wire s48;
wire s49;
wire s50;
wire s51;
wire [4:0] s52;
wire [4:0] s53;
wire nds_unused_ace_dec_frf_rs1_ren;
wire nds_unused_ace_dec_frf_rs2_ren;
wire nds_unused_ace_dec_frf_rd1_wen;
wire nds_unused_ace_dec_vrf_rs1_ren;
wire nds_unused_ace_dec_vrf_rs2_ren;
wire nds_unused_ace_dec_vrf_rd1_wen;
wire [4:0] ace_dec_rs1_index;
wire [4:0] ace_dec_rs2_index;
wire [4:0] ace_dec_rs3_index;
wire [4:0] ace_dec_rs4_index;
wire [4:0] ace_dec_rd1_index;
wire [4:0] ace_dec_rd2_index;
wire ace_dec_illegal_insn;
wire s54;
wire ace_dec_xcpt;
wire [5:0] ace_dec_xcpt_cause;
wire ace_dec_sync_en;
wire [25:0] vpu_decode;
wire s55;
wire instr_dsp;
wire s56;
wire s57;
wire s58;
wire s59;
wire [4:0] s60;
wire [4:0] s61;
wire [4:0] s62;
wire [4:0] s63;
wire [4:0] s64;
wire [4:0] s65;
wire s66;
wire s67;
wire [2:0] s68;
wire instr_sfp;
wire instr_illegal_sfp;
wire instr_sfp_off_xcpt;
wire sfp_rs1_ren;
wire sfp_rd1_wen;
wire [4:0] sfp_frd1;
wire sfp_frd1_wen;
wire [4:0] sfp_frs1;
wire sfp_frs1_ren;
wire [4:0] sfp_frs2;
wire sfp_frs2_ren;
wire [4:0] sfp_frs3;
wire sfp_frs3_ren;
wire [2:0] sfp_ex_rm;
wire sfp_ex_sign;
wire [2:0] sfp_ex_sew;
wire sfp_ex_fmac;
wire sfp_ex_fdiv;
wire sfp_ex_fmis;
wire sfp_ex_fmv;
wire [5:0] sfp_ex_ctrl;
wire instr_sfp_ls;
wire instr_sfp_lhw;
wire instr_sfp_shw;
wire instr_sfp_lw;
wire instr_sfp_sw;
wire instr_sfp_ld;
wire instr_sfp_sd;
wire instr_sfp_c_lwsp;
wire instr_sfp_c_swsp;
wire instr_sfp_c_ldsp;
wire instr_sfp_c_sdsp;
wire instr_sfp_c_lw;
wire instr_sfp_c_sw;
wire instr_sfp_c_ld;
wire instr_sfp_c_sd;
wire s69;
wire s70;
wire s71;
wire s72;
wire s73 = id_ctrl[121] & instr_from_exec_it & ~s0;
wire s74 = instr_from_exec_it & ifu_instr_16b & ~s0;
wire s75 = s73 | s74;
wire s76 = (ifu_instr[6:0] == OP_OP) | (ifu_instr[6:0] == OP_OP32) | s55;
wire s77 = (ifu_instr[6:0] == OP_STORE) | (ifu_instr[6:0] == OP_FP_STORE);
wire s78 = (ifu_instr[6:0] == OP_BRANCH);
wire s79 = (ifu_instr[6:0] == OP_LUI) | (ifu_instr[6:0] == OP_AUIPC);
wire s80 = (ifu_instr[6:0] == OP_JAL);
wire s81 = (ifu_instr[6:0] == OP_LUI);
wire s82 = (ifu_instr[6:0] == OP_AUIPC);
wire s83 = (ifu_instr[6:0] == OP_JAL);
wire s84 = (ifu_instr[6:0] == OP_JALR) & (ifu_instr[14:12] == 3'b000);
wire s85 = (ifu_instr[6:0] == OP_BRANCH) & (ifu_instr[14:12] == 3'b000);
wire s86 = (ifu_instr[6:0] == OP_BRANCH) & (ifu_instr[14:12] == 3'b001);
wire s87 = (ifu_instr[6:0] == OP_BRANCH) & (ifu_instr[14:12] == 3'b100);
wire s88 = (ifu_instr[6:0] == OP_BRANCH) & (ifu_instr[14:12] == 3'b101);
wire s89 = (ifu_instr[6:0] == OP_BRANCH) & (ifu_instr[14:12] == 3'b110);
wire s90 = (ifu_instr[6:0] == OP_BRANCH) & (ifu_instr[14:12] == 3'b111);
wire s91 = (ifu_instr[6:0] == OP_LOAD) & (ifu_instr[14:12] == 3'b000);
wire s92 = (ifu_instr[6:0] == OP_LOAD) & (ifu_instr[14:12] == 3'b001);
wire s93 = (ifu_instr[6:0] == OP_LOAD) & (ifu_instr[14:12] == 3'b010);
wire s94 = (ifu_instr[6:0] == OP_LOAD) & (ifu_instr[14:12] == 3'b100);
wire s95 = (ifu_instr[6:0] == OP_LOAD) & (ifu_instr[14:12] == 3'b101);
wire s96 = (ifu_instr[6:0] == OP_STORE) & (ifu_instr[14:12] == 3'b000);
wire s97 = (ifu_instr[6:0] == OP_STORE) & (ifu_instr[14:12] == 3'b001);
wire s98 = (ifu_instr[6:0] == OP_STORE) & (ifu_instr[14:12] == 3'b010);
wire s99 = (ifu_instr[6:0] == OP_IMM) & (ifu_instr[14:12] == 3'b000);
wire s100 = (ifu_instr[6:0] == OP_IMM) & (ifu_instr[14:12] == 3'b010);
wire s101 = (ifu_instr[6:0] == OP_IMM) & (ifu_instr[14:12] == 3'b011);
wire s102 = (ifu_instr[6:0] == OP_IMM) & (ifu_instr[14:12] == 3'b100);
wire s103 = (ifu_instr[6:0] == OP_IMM) & (ifu_instr[14:12] == 3'b110);
wire s104 = (ifu_instr[6:0] == OP_IMM) & (ifu_instr[14:12] == 3'b111);
wire s105 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b000) & (ifu_instr[31:25] == 7'b0000000);
wire s106 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b000) & (ifu_instr[31:25] == 7'b0100000);
wire s107 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b001) & (ifu_instr[31:25] == 7'b0000000);
wire s108 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b010) & (ifu_instr[31:25] == 7'b0000000);
wire s109 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b011) & (ifu_instr[31:25] == 7'b0000000);
wire s110 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b100) & (ifu_instr[31:25] == 7'b0000000);
wire s111 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b101) & (ifu_instr[31:25] == 7'b0000000);
wire s112 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b101) & (ifu_instr[31:25] == 7'b0100000);
wire s113 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b110) & (ifu_instr[31:25] == 7'b0000000);
wire s114 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b111) & (ifu_instr[31:25] == 7'b0000000);
wire s115 = (ifu_instr[6:0] == OP_SYSTEM) & (ifu_instr[31:7] == 25'b000000000001_00000_000_00000);
wire s116 = (ifu_instr[6:0] == OP_MISC_MEM) & (ifu_instr[14:12] == 3'b000);
wire s117 = (ifu_instr[6:0] == OP_MISC_MEM) & (ifu_instr[14:12] == 3'b001);
wire instr_csr = (ifu_instr[6:0] == OP_SYSTEM) & (ifu_instr[13:12] != 2'd0);
wire s118 = (ifu_instr[6:0] == OP_SYSTEM) & (ifu_instr[31:7] == 25'b000000000000_00000_000_00000);
wire s119 = (ifu_instr[6:0] == OP_SYSTEM) & (ifu_instr[24:7] == 18'b00010_00000_000_00000) & (ifu_instr[31:25] == 7'b0011000);
wire s120 = (ifu_instr[6:0] == OP_SYSTEM) & (ifu_instr[24:7] == 18'b00010_00000_000_00000) & (ifu_instr[31:25] == 7'b0001000) & s1;
wire s121 = (ifu_instr[6:0] == OP_SYSTEM) & (ifu_instr[24:7] == 18'b00010_00000_000_00000) & (ifu_instr[31:25] == 7'b0000000) & s2 & ((RVN_SUPPORT_INT == 1));
wire s122 = ((ifu_instr[14:12] == FUNC3_CSRRS) | (ifu_instr[14:12] == FUNC3_CSRRC) | (ifu_instr[14:12] == FUNC3_CSRRSI) | (ifu_instr[14:12] == FUNC3_CSRRCI)) & (ifu_instr[19:15] == 5'd0);
wire s123 = ((ifu_instr[14:12] == FUNC3_CSRRW) | (ifu_instr[14:12] == FUNC3_CSRRWI)) & (ifu_instr[11:7] == 5'd0);
wire s124 = instr_csr & s122;
wire s125 = instr_csr & s123;
wire s126 = instr_csr & ~s122;
wire s127 = instr_csr & ~s123;
wire [11:0] s128 = ifu_instr[31:20];
wire s129 = (s128 == CSR12_MSCRATCH) | (s128 == CSR12_MEPC) | (s128 == CSR12_MCAUSE) | (s128 == CSR12_MTVAL) | (s128 == CSR12_MCYCLE) | (s128 == CSR12_MINSTRET) | (s128 == CSR12_MHPMCOUNTER3) | (s128 == CSR12_MHPMCOUNTER4) | (s128 == CSR12_MHPMCOUNTER5) | (s128 == CSR12_MHPMCOUNTER6) | (s128 == CSR12_MHPMCOUNTER7) | (s128 == CSR12_MHPMCOUNTER8) | (s128 == CSR12_MHPMCOUNTER9) | (s128 == CSR12_MHPMCOUNTER10) | (s128 == CSR12_MHPMCOUNTER11) | (s128 == CSR12_MHPMCOUNTER12) | (s128 == CSR12_MHPMCOUNTER13) | (s128 == CSR12_MHPMCOUNTER14) | (s128 == CSR12_MHPMCOUNTER15) | (s128 == CSR12_MHPMCOUNTER16) | (s128 == CSR12_MHPMCOUNTER17) | (s128 == CSR12_MHPMCOUNTER18) | (s128 == CSR12_MHPMCOUNTER19) | (s128 == CSR12_MHPMCOUNTER20) | (s128 == CSR12_MHPMCOUNTER21) | (s128 == CSR12_MHPMCOUNTER22) | (s128 == CSR12_MHPMCOUNTER23) | (s128 == CSR12_MHPMCOUNTER24) | (s128 == CSR12_MHPMCOUNTER25) | (s128 == CSR12_MHPMCOUNTER26) | (s128 == CSR12_MHPMCOUNTER27) | (s128 == CSR12_MHPMCOUNTER28) | (s128 == CSR12_MHPMCOUNTER29) | (s128 == CSR12_MHPMCOUNTER30) | (s128 == CSR12_MHPMCOUNTER31) | (s128 == CSR12_MCYCLEH) | (s128 == CSR12_MINSTRETH) | (s128 == CSR12_MHPMCOUNTER3H) | (s128 == CSR12_MHPMCOUNTER4H) | (s128 == CSR12_MHPMCOUNTER5H) | (s128 == CSR12_MHPMCOUNTER6H) | (s128 == CSR12_MHPMCOUNTER7H) | (s128 == CSR12_MHPMCOUNTER8H) | (s128 == CSR12_MHPMCOUNTER9H) | (s128 == CSR12_MHPMCOUNTER10H) | (s128 == CSR12_MHPMCOUNTER11H) | (s128 == CSR12_MHPMCOUNTER12H) | (s128 == CSR12_MHPMCOUNTER13H) | (s128 == CSR12_MHPMCOUNTER14H) | (s128 == CSR12_MHPMCOUNTER15H) | (s128 == CSR12_MHPMCOUNTER16H) | (s128 == CSR12_MHPMCOUNTER17H) | (s128 == CSR12_MHPMCOUNTER18H) | (s128 == CSR12_MHPMCOUNTER19H) | (s128 == CSR12_MHPMCOUNTER20H) | (s128 == CSR12_MHPMCOUNTER21H) | (s128 == CSR12_MHPMCOUNTER22H) | (s128 == CSR12_MHPMCOUNTER23H) | (s128 == CSR12_MHPMCOUNTER24H) | (s128 == CSR12_MHPMCOUNTER25H) | (s128 == CSR12_MHPMCOUNTER26H) | (s128 == CSR12_MHPMCOUNTER27H) | (s128 == CSR12_MHPMCOUNTER28H) | (s128 == CSR12_MHPMCOUNTER29H) | (s128 == CSR12_MHPMCOUNTER30H) | (s128 == CSR12_MHPMCOUNTER31H) | (s128 == CSR12_MDCAUSE) | (s128 == CSR12_MCCTLBEGINADDR) | (s128 == CSR12_MCCTLDATA) | (s128 == CSR12_CYCLE) | (s128 == CSR12_INSTRET) | (s128 == CSR12_HPMCOUNTER3) | (s128 == CSR12_HPMCOUNTER4) | (s128 == CSR12_HPMCOUNTER5) | (s128 == CSR12_HPMCOUNTER6) | (s128 == CSR12_HPMCOUNTER7) | (s128 == CSR12_HPMCOUNTER8) | (s128 == CSR12_HPMCOUNTER9) | (s128 == CSR12_HPMCOUNTER10) | (s128 == CSR12_HPMCOUNTER11) | (s128 == CSR12_HPMCOUNTER12) | (s128 == CSR12_HPMCOUNTER13) | (s128 == CSR12_HPMCOUNTER14) | (s128 == CSR12_HPMCOUNTER15) | (s128 == CSR12_HPMCOUNTER16) | (s128 == CSR12_HPMCOUNTER17) | (s128 == CSR12_HPMCOUNTER18) | (s128 == CSR12_HPMCOUNTER19) | (s128 == CSR12_HPMCOUNTER20) | (s128 == CSR12_HPMCOUNTER21) | (s128 == CSR12_HPMCOUNTER22) | (s128 == CSR12_HPMCOUNTER23) | (s128 == CSR12_HPMCOUNTER24) | (s128 == CSR12_HPMCOUNTER25) | (s128 == CSR12_HPMCOUNTER26) | (s128 == CSR12_HPMCOUNTER27) | (s128 == CSR12_HPMCOUNTER28) | (s128 == CSR12_HPMCOUNTER29) | (s128 == CSR12_HPMCOUNTER30) | (s128 == CSR12_HPMCOUNTER31) | (s128 == CSR12_CYCLEH) | (s128 == CSR12_INSTRETH) | (s128 == CSR12_HPMCOUNTER3H) | (s128 == CSR12_HPMCOUNTER4H) | (s128 == CSR12_HPMCOUNTER5H) | (s128 == CSR12_HPMCOUNTER6H) | (s128 == CSR12_HPMCOUNTER7H) | (s128 == CSR12_HPMCOUNTER8H) | (s128 == CSR12_HPMCOUNTER9H) | (s128 == CSR12_HPMCOUNTER10H) | (s128 == CSR12_HPMCOUNTER11H) | (s128 == CSR12_HPMCOUNTER12H) | (s128 == CSR12_HPMCOUNTER13H) | (s128 == CSR12_HPMCOUNTER14H) | (s128 == CSR12_HPMCOUNTER15H) | (s128 == CSR12_HPMCOUNTER16H) | (s128 == CSR12_HPMCOUNTER17H) | (s128 == CSR12_HPMCOUNTER18H) | (s128 == CSR12_HPMCOUNTER19H) | (s128 == CSR12_HPMCOUNTER20H) | (s128 == CSR12_HPMCOUNTER21H) | (s128 == CSR12_HPMCOUNTER22H) | (s128 == CSR12_HPMCOUNTER23H) | (s128 == CSR12_HPMCOUNTER24H) | (s128 == CSR12_HPMCOUNTER25H) | (s128 == CSR12_HPMCOUNTER26H) | (s128 == CSR12_HPMCOUNTER27H) | (s128 == CSR12_HPMCOUNTER28H) | (s128 == CSR12_HPMCOUNTER29H) | (s128 == CSR12_HPMCOUNTER30H) | (s128 == CSR12_HPMCOUNTER31H) | (s128 == CSR12_SEPC) | (s128 == CSR12_SCAUSE) | (s128 == CSR12_STVAL) | (s128 == CSR12_SSCRATCH) | (s128 == CSR12_SDCAUSE) | (s128 == CSR12_UDCAUSE) | (s128 == CSR12_TSELECT) | (s128 == CSR12_DPC) | (s128 == CSR12_DSCRATCH0) | (s128 == CSR12_DSCRATCH1) | (s128 == CSR12_DDCAUSE) | (s128 == CSR12_FFLAGS);
wire s130 = (s128 == CSR12_MVENDORID) | (s128 == CSR12_MARCHID) | (s128 == CSR12_MIMPID) | (s128 == CSR12_MHARTID) | (s128 == CSR12_MSTATUS) | (s128 == CSR12_MISA) | (s128 == CSR12_MEDELEG) | (s128 == CSR12_MIDELEG) | (s128 == CSR12_MIE) | (s128 == CSR12_MTVEC) | (s128 == CSR12_MSCRATCH) | (s128 == CSR12_MEPC) | (s128 == CSR12_MCAUSE) | (s128 == CSR12_MTVAL) | (s128 == CSR12_MIP) | (s128 == CSR12_MXSTATUS) | (s128 == CSR12_MDCAUSE) | (s128 == CSR12_MSLIDELEG) | (s128 == CSR12_SSTATUS) | (s128 == CSR12_SEDELEG) | (s128 == CSR12_SIDELEG) | (s128 == CSR12_SIE) | (s128 == CSR12_STVEC) | (s128 == CSR12_SSCRATCH) | (s128 == CSR12_SEPC) | (s128 == CSR12_SCAUSE) | (s128 == CSR12_STVAL) | (s128 == CSR12_SIP) | (s128 == CSR12_SLIE) | (s128 == CSR12_SLIP) | (s128 == CSR12_SDCAUSE) | (s128 == CSR12_USTATUS) | (s128 == CSR12_UIE) | (s128 == CSR12_UTVEC) | (s128 == CSR12_USCRATCH) | (s128 == CSR12_UEPC) | (s128 == CSR12_UCAUSE) | (s128 == CSR12_UTVAL) | (s128 == CSR12_UIP);
wire s131 = 1'b0;
wire s132 = s17 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0010000) & (ifu_instr[14:12] == 3'b010);
wire s133 = 1'b0;
wire s134 = s17 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0010000) & (ifu_instr[14:12] == 3'b100);
wire s135 = 1'b0;
wire s136 = s17 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0010000) & (ifu_instr[14:12] == 3'b110);
wire s137 = 1'b0;
wire s138 = 1'b0;
wire s139 = s18 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0100000) & (ifu_instr[14:12] == 3'b111);
wire s140 = s18 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0100000) & (ifu_instr[14:12] == 3'b110);
wire s141 = s18 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0100000) & (ifu_instr[14:12] == 3'b100);
wire s142 = s18 & (ifu_instr[6:0] == OP_IMM) & (ifu_instr[31:20] == 12'b0110000_00000) & (ifu_instr[14:12] == 3'b001);
wire s143 = 1'b0;
wire s144 = s18 & (ifu_instr[6:0] == OP_IMM) & (ifu_instr[31:20] == 12'b0110000_00001) & (ifu_instr[14:12] == 3'b001);
wire s145 = 1'b0;
wire s146 = s18 & (ifu_instr[6:0] == OP_IMM) & (ifu_instr[31:20] == 12'b0110000_00010) & (ifu_instr[14:12] == 3'b001);
wire s147 = 1'b0;
wire s148 = s18 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0000101) & (ifu_instr[14:12] == 3'b110);
wire s149 = s18 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0000101) & (ifu_instr[14:12] == 3'b111);
wire s150 = s18 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0000101) & (ifu_instr[14:12] == 3'b100);
wire s151 = s18 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0000101) & (ifu_instr[14:12] == 3'b101);
wire s152 = s18 & (ifu_instr[6:0] == OP_IMM) & (ifu_instr[31:20] == 12'b0110000_00100) & (ifu_instr[14:12] == 3'b001);
wire s153 = s18 & (ifu_instr[6:0] == OP_IMM) & (ifu_instr[31:20] == 12'b0110000_00101) & (ifu_instr[14:12] == 3'b001);
wire s154 = s18 & ((ifu_instr[6:0] == OP_OP) & (ifu_instr[31:20] == 12'b0000100_00000) & (ifu_instr[14:12] == 3'b100));
wire s155 = s18 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0110000) & (ifu_instr[14:12] == 3'b001);
wire s156 = 1'b0;
wire s157 = s18 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0110000) & (ifu_instr[14:12] == 3'b101);
wire s158 = 1'b0;
wire s159 = s18 & (ifu_instr[6:0] == OP_IMM) & (ifu_instr[31:26] == 6'b011000) & (ifu_instr[14:12] == 3'b101) & ((ifu_instr[25] == 1'b0));
wire s160 = 1'b0;
wire s161 = s18 & (ifu_instr[6:0] == OP_IMM) & (ifu_instr[31:20] == 12'b0010100_00111) & (ifu_instr[14:12] == 3'b101);
wire s162 = s18 & ((ifu_instr[6:0] == OP_IMM) & (ifu_instr[31:20] == 12'b0110100_11000) & (ifu_instr[14:12] == 3'b101));
wire s163 = s19 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0000101) & (ifu_instr[14:12] == 3'b001);
wire s164 = s19 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0000101) & (ifu_instr[14:12] == 3'b011);
wire s165 = s19 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0000101) & (ifu_instr[14:12] == 3'b010);
wire s166 = s20 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0100100) & (ifu_instr[14:12] == 3'b001);
wire s167 = s20 & (ifu_instr[6:0] == OP_IMM) & (ifu_instr[31:26] == 6'b010010) & (ifu_instr[14:12] == 3'b001) & ((ifu_instr[25] == 1'b0));
wire s168 = s20 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0100100) & (ifu_instr[14:12] == 3'b101);
wire s169 = s20 & (ifu_instr[6:0] == OP_IMM) & (ifu_instr[31:26] == 6'b010010) & (ifu_instr[14:12] == 3'b101) & ((ifu_instr[25] == 1'b0));
wire s170 = s20 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0110100) & (ifu_instr[14:12] == 3'b001);
wire s171 = s20 & (ifu_instr[6:0] == OP_IMM) & (ifu_instr[31:26] == 6'b011010) & (ifu_instr[14:12] == 3'b001) & ((ifu_instr[25] == 1'b0));
wire s172 = s20 & (ifu_instr[6:0] == OP_OP) & (ifu_instr[31:25] == 7'b0010100) & (ifu_instr[14:12] == 3'b001);
wire s173 = s20 & (ifu_instr[6:0] == OP_IMM) & (ifu_instr[31:26] == 6'b001010) & (ifu_instr[14:12] == 3'b001) & ((ifu_instr[25] == 1'b0));
wire s174 = s132 | s133 | s134 | s135 | s136 | s137;
wire s175 = s174 | s131;
wire s176 = s138 | s175;
wire s177 = s139 | s140 | s141 | s142 | s143 | s144 | s145 | s146 | s147 | s148 | s149 | s150 | s151 | s155 | s156 | s157 | s158 | s159 | s160 | s152 | s153 | s154 | s161 | s162;
wire s178 = s163 | s164 | s165;
wire s179 = s166 | s167 | s168 | s169 | s170 | s171 | s172 | s173;
wire s180 = (s17 | s18) & (ifu_instr[6:0] == OP_OP32) | (ifu_instr[6:0] == OP_IMM32);
assign s48 = (s176 & ~s180) | (s177 & ~s180) | (s178 & ~s180) | (s179 & ~s180);
assign id_ctrl[14] = s139 | s140 | s141 | s138;
assign id_ctrl[22] = s155 | s156 | s157 | s158 | s159 | s160;
assign id_ctrl[15] = s148;
assign id_ctrl[17] = s150;
assign id_ctrl[16] = s149;
assign id_ctrl[18] = s151;
assign id_ctrl[10] = s142 | s143 | s144 | s145;
assign id_ctrl[11] = s146 | s147;
assign id_ctrl[20] = s161;
assign id_ctrl[21] = s162;
assign id_ctrl[36] = s152 | s153 | s154;
assign id_ctrl[9] = s163 | s164 | s165;
assign id_ctrl[5] = s168 | s169;
assign id_ctrl[7] = s172 | s173;
assign id_ctrl[4] = s166 | s167;
assign id_ctrl[6] = s170 | s171;
assign id_ctrl[8] = s175;
wire [1:0] s181 = (s133 | s132) ? 2'h1 : (s135 | s134) ? 2'h2 : (s137 | s136) ? 2'h3 : {s153 | s164,s152 | s165};
wire s182 = s131 | s133 | s135 | s137;
wire s183 = s138 | s143 | s145 | s147 | s156 | s158 | s160;
wire s184 = s138 | s144 | s145 | s155 | s156;
wire s185 = s131 | s139 | s140 | s141 | s148 | s149 | s150 | s151 | s155 | s156 | s157 | s158 | s163 | s164 | s165 | s166 | s168 | s170 | s172;
wire s186 = s138 | s142 | s143 | s144 | s145 | s146 | s147 | s159 | s160 | s152 | s153 | s154 | s161 | s162 | s167 | s169 | s171 | s173;
wire s187 = s131;
assign s49 = s185 | s186;
assign s50 = s185 | s186;
assign s51 = s185;
assign s52 = s187 ? ifu_instr[24:20] : ifu_instr[19:15];
assign s53 = s187 ? ifu_instr[19:15] : ifu_instr[24:20];
assign id_ctrl[100 +:2] = ifu_instr[13:12];
assign id_ctrl[225 +:2] = 2'b11;
assign id_ctrl[307] = 1'b0;
assign id_ctrl[306] = 1'b0;
wire s188 = (ifu_instr[6:0] == OP_SYSTEM) & (ifu_instr[31:7] == 25'b011110110010_00000_000_00000);
wire s189 = (ifu_instr[6:0] == OP_SYSTEM) & (ifu_instr[31:7] == 25'b000100000101_00000_000_00000);
wire s190 = (ifu_instr[6:0] == OP_SYSTEM) & (ifu_instr[31:25] == 7'b0001001) & (ifu_instr[14:7] == 8'b0) & s1;
wire s191 = (ifu_instr[6:0] == OP_IMM) & (ifu_instr[14:12] == 3'b001) & (ifu_instr[31:25] == 7'b0000000);
wire s192 = (ifu_instr[6:0] == OP_IMM) & (ifu_instr[14:12] == 3'b101) & (ifu_instr[31:25] == 7'b0000000);
wire s193 = (ifu_instr[6:0] == OP_IMM) & (ifu_instr[14:12] == 3'b101) & (ifu_instr[31:25] == 7'b0100000);
wire s194 = 1'b0;
wire s195 = 1'b0;
wire s196 = 1'b0;
wire s197 = 1'b0;
wire s198 = 1'b0;
wire s199 = 1'b0;
wire s200 = 1'b0;
wire s201 = 1'b0;
wire s202 = 1'b0;
wire s203 = 1'b0;
wire s204 = 1'b0;
wire s205 = 1'b0;
wire s206 = s3 & (ifu_instr[1:0] == OP_C2) & (ifu_instr[15:13] == 3'b010);
wire s207 = s3 & (ifu_instr[1:0] == OP_C2) & (ifu_instr[15:13] == 3'b110);
wire s208 = s3 & (ifu_instr[1:0] == OP_C0) & (ifu_instr[15:13] == 3'b010);
wire s209 = s3 & (ifu_instr[1:0] == OP_C0) & (ifu_instr[15:13] == 3'b110);
wire s210 = s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15:13] == 3'b101);
wire s211 = s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15:13] == 3'b001);
wire s212 = s3 & (ifu_instr[1:0] == OP_C2) & (ifu_instr[12] == 1'b0) & (ifu_instr[15:13] == 3'b100) & (s38 == 5'b0);
wire s213 = s3 & (ifu_instr[1:0] == OP_C2) & (ifu_instr[12] == 1'b1) & (ifu_instr[15:13] == 3'b100) & (s38 == 5'b0) & (s36 != 5'b0);
wire s214 = s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15:13] == 3'b110);
wire s215 = s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15:13] == 3'b111);
wire s216 = s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15:13] == 3'b010);
wire s217 = s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15:13] == 3'b011) & (s37 != 5'b00010);
wire s218 = s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15:13] == 3'b000);
wire s219 = s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15:13] == 3'b011) & (s37 == 5'b00010);
wire s220 = s3 & (ifu_instr[1:0] == OP_C0) & (ifu_instr[15:13] == 3'b000);
wire s221 = s3 & (ifu_instr[1:0] == OP_C2) & (ifu_instr[15:13] == 3'b000);
wire s222 = s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15:13] == 3'b100) & (ifu_instr[11:10] == 2'b00);
wire s223 = s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15:13] == 3'b100) & (ifu_instr[11:10] == 2'b01);
wire s224 = s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15:13] == 3'b100) & (ifu_instr[11:10] == 2'b10);
wire s225 = s3 & (ifu_instr[1:0] == OP_C2) & (ifu_instr[15:13] == 3'b100) & (ifu_instr[12] == 1'b0) & (s38 != 5'b0);
wire s226 = s3 & (ifu_instr[1:0] == OP_C2) & (ifu_instr[15:13] == 3'b100) & (ifu_instr[12] == 1'b1) & (s38 != 5'b0);
wire s227 = s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15:13] == 3'b100) & (ifu_instr[12:10] == 3'b011) & (ifu_instr[6:5] == 2'b11);
wire s228 = s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15:13] == 3'b100) & (ifu_instr[12:10] == 3'b011) & (ifu_instr[6:5] == 2'b10);
wire s229 = s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15:13] == 3'b100) & (ifu_instr[12:10] == 3'b011) & (ifu_instr[6:5] == 2'b01);
wire s230 = s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15:13] == 3'b100) & (ifu_instr[12:10] == 3'b011) & (ifu_instr[6:5] == 2'b00);
wire s231 = s3 & (ifu_instr[1:0] == OP_C2) & (ifu_instr[15:2] == 14'h2400);
wire s232 = s11 & s3 & ((s13 & (ifu_instr[1:0] == OP_C0) & (ifu_instr[15:13] == 3'b100) & (ifu_instr[7] == 1'b0)) | (s14 & (ifu_instr[1:0] == OP_C2) & (ifu_instr[15:13] == 3'b101) & (ifu_instr[12] == 1'b0)));
wire s233 = 1'b0;
wire s234 = 1'b0;
wire s235 = 1'b0;
wire s236 = 1'b0;
wire s237 = 1'b0;
wire s238 = 1'b0;
wire s239 = 1'b0;
wire s240 = s15 & (ifu_instr[1:0] == OP_C0) & (ifu_instr[15:13] == 3'b101);
wire s241 = s15 & (ifu_instr[1:0] == OP_C0) & (ifu_instr[15:13] == 3'b001);
wire s242 = s15 & (ifu_instr[1:0] == OP_C2) & (ifu_instr[15:13] == 3'b101) & (ifu_instr[12] == 1'b1);
wire s243 = s15 & (ifu_instr[1:0] == OP_C2) & (ifu_instr[15:13] == 3'b001);
wire s244 = s240 | s241 | s242 | s243;
wire [20:0] s245 = ({21{s240}} & {16'd0,ifu_instr[11:10],ifu_instr[6:5],ifu_instr[12]}) | ({21{s241}} & {16'd0,ifu_instr[11:10],ifu_instr[6:5],ifu_instr[12]}) | ({21{s242}} & {16'd0,ifu_instr[11:10],ifu_instr[6:5],1'b0}) | ({21{s243}} & {15'd0,ifu_instr[12:10],ifu_instr[6:5],1'b0});
wire s246 = s206 | s233 | s216 | s217 | s218 | s237 | s219 | s221 | instr_sfp_c_lwsp | instr_sfp_c_ldsp;
wire s247 = s207 | s234;
wire s248 = s208 | s235 | instr_sfp_c_lw | instr_sfp_c_ld | s241 | s243;
wire s249 = s209 | s236 | s227 | s228 | s229 | s230 | s238 | s239 | instr_sfp_c_sw | instr_sfp_c_sd | instr_sfp_c_swsp | instr_sfp_c_sdsp | s240 | s242;
wire s250 = s220;
wire s251 = s214 | s215 | s222 | s223 | s224;
wire s252 = s212 | s213 | s225 | s226;
wire s253 = (s252 & ~s225) | (s246 & ~s216 & ~s217) | s248 | s249 | s251 | s250 | s247;
wire s254 = s206 | s233 | s208 | s235 | s241 | s243 | instr_sfp_c_lwsp | instr_sfp_c_ldsp | instr_sfp_c_lw | instr_sfp_c_ld;
wire s255 = s207 | s234 | s209 | s236 | s240 | s242 | instr_sfp_c_swsp | instr_sfp_c_sdsp | instr_sfp_c_sw | instr_sfp_c_sd;
wire s256 = s210 | s211 | s212 | s213;
wire s257 = s214 | s215;
wire s258 = s216 | s217 | s218 | s237 | s219 | s220 | s221 | s222 | s223 | s224 | s225 | s226 | s227 | s228 | s229 | s230 | s238 | s239;
wire s259 = s254 | s255 | s256 | s257 | s258;
wire s260 = (ifu_instr[1:0] != 2'b11) & s3;
wire s261 = s219;
wire s262 = s211 | s213;
wire s263 = s210 | s212;
wire [4:0] s264 = s263 ? 5'h0 : s262 ? 5'h01 : s261 ? 5'h02 : (s252 | s246) ? s37 : (s251 | s249) ? {2'b01,s40} : {2'b01,s39};
wire s265 = s212 & (s22 == 5'b0);
wire s266 = (s206 | s233 | s237) & (s264 == 5'b0);
wire s267 = (s220 & ~s45) | ((s217 | s219) & ~s44) | ((s221 | s222 | s223) & ~s43);
wire s268 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b000) & (ifu_instr[31:25] == 7'b0000001);
wire s269 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b001) & (ifu_instr[31:25] == 7'b0000001);
wire s270 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b010) & (ifu_instr[31:25] == 7'b0000001);
wire s271 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b011) & (ifu_instr[31:25] == 7'b0000001);
wire s272 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b100) & (ifu_instr[31:25] == 7'b0000001);
wire s273 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b101) & (ifu_instr[31:25] == 7'b0000001);
wire s274 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b110) & (ifu_instr[31:25] == 7'b0000001);
wire s275 = (ifu_instr[6:0] == OP_OP) & (ifu_instr[14:12] == 3'b111) & (ifu_instr[31:25] == 7'b0000001);
wire s276 = 1'b0;
wire s277 = 1'b0;
wire s278 = 1'b0;
wire s279 = 1'b0;
wire s280 = 1'b0;
wire s281 = s4 & (ifu_instr[6:0] == OP_ATOMIC) & (ifu_instr[14:12] == 3'b010) & (ifu_instr[24:20] == 5'd0) & (ifu_instr[31:27] == ATOMIC_LR);
wire s282 = s4 & (ifu_instr[6:0] == OP_ATOMIC) & (ifu_instr[14:12] == 3'b010) & (ifu_instr[31:27] == ATOMIC_SC);
wire s283 = s4 & (ifu_instr[6:0] == OP_ATOMIC) & (ifu_instr[14:12] == 3'b010) & (ifu_instr[31:27] == ATOMIC_AMOSWAP);
wire s284 = s4 & (ifu_instr[6:0] == OP_ATOMIC) & (ifu_instr[14:12] == 3'b010) & (ifu_instr[31:27] == ATOMIC_AMOADD);
wire s285 = s4 & (ifu_instr[6:0] == OP_ATOMIC) & (ifu_instr[14:12] == 3'b010) & (ifu_instr[31:27] == ATOMIC_AMOXOR);
wire s286 = s4 & (ifu_instr[6:0] == OP_ATOMIC) & (ifu_instr[14:12] == 3'b010) & (ifu_instr[31:27] == ATOMIC_AMOAND);
wire s287 = s4 & (ifu_instr[6:0] == OP_ATOMIC) & (ifu_instr[14:12] == 3'b010) & (ifu_instr[31:27] == ATOMIC_AMOOR);
wire s288 = s4 & (ifu_instr[6:0] == OP_ATOMIC) & (ifu_instr[14:12] == 3'b010) & (ifu_instr[31:27] == ATOMIC_AMOMIN);
wire s289 = s4 & (ifu_instr[6:0] == OP_ATOMIC) & (ifu_instr[14:12] == 3'b010) & (ifu_instr[31:27] == ATOMIC_AMOMAX);
wire s290 = s4 & (ifu_instr[6:0] == OP_ATOMIC) & (ifu_instr[14:12] == 3'b010) & (ifu_instr[31:27] == ATOMIC_AMOMINU);
wire s291 = s4 & (ifu_instr[6:0] == OP_ATOMIC) & (ifu_instr[14:12] == 3'b010) & (ifu_instr[31:27] == ATOMIC_AMOMAXU);
wire s292 = 1'b0;
wire s293 = 1'b0;
wire s294 = 1'b0;
wire s295 = 1'b0;
wire s296 = 1'b0;
wire s297 = 1'b0;
wire s298 = 1'b0;
wire s299 = 1'b0;
wire s300 = 1'b0;
wire s301 = 1'b0;
wire s302 = 1'b0;
wire s303 = s283 | s284 | s285 | s286 | s287 | s288 | s289 | s290 | s291 | s294 | s295 | s296 | s297 | s298 | s299 | s300 | s301 | s302;
wire s304 = s281 | s292;
wire s305 = s282 | s293;
wire s306 = s304 | s305 | s303;
wire s307 = s304 | s303;
wire s308 = s305 | s303;
wire s309 = (s284 | s295);
wire s310 = (s285 | s296);
wire s311 = (s286 | s297);
wire s312 = (s287 | s298);
assign s55 = s306;
wire s313 = s5 & (ifu_instr[6:0] == OP_CUSTOM0) & (ifu_instr[13:12] == 2'b00);
wire s314 = s5 & (ifu_instr[6:0] == OP_CUSTOM0) & (ifu_instr[13:12] == 2'b10);
wire s315 = s5 & (ifu_instr[6:0] == OP_CUSTOM0) & (ifu_instr[13:12] == 2'b11);
wire s316 = s5 & (ifu_instr[6:0] == OP_CUSTOM0) & (ifu_instr[13:12] == 2'b01);
wire s317 = s5 & (ifu_instr[6:0] == OP_CUSTOM1) & (ifu_instr[14:12] == 3'b001);
wire s318 = s5 & (ifu_instr[6:0] == OP_CUSTOM1) & (ifu_instr[14:12] == 3'b101);
wire s319 = s5 & (ifu_instr[6:0] == OP_CUSTOM1) & (ifu_instr[14:12] == 3'b010);
wire s320 = 1'b0;
wire s321 = 1'b0;
wire s322 = s5 & (ifu_instr[6:0] == OP_CUSTOM1) & (ifu_instr[14:12] == 3'b000);
wire s323 = s5 & (ifu_instr[6:0] == OP_CUSTOM1) & (ifu_instr[14:12] == 3'b100);
wire s324 = 1'b0;
wire s325 = s314 | s313 | s317 | s318 | s319 | s320 | s321;
wire s326 = s315 | s322 | s323 | s324;
wire s327 = (ifu_instr[14:12] == 3'b110) | (ifu_instr[14:12] == 3'b011) | (ifu_instr[14:12] == 3'b111);
wire s328 = ((s5 & (ifu_instr[6:0] == OP_CUSTOM0)) | (s5 & (ifu_instr[6:0] == OP_CUSTOM1) & ~s327));
wire s329 = ~csr_mmisc_ctl_rvcompm & s325;
wire s330 = ~csr_mmisc_ctl_rvcompm & s326;
wire s331 = ~csr_mmisc_ctl_rvcompm & s328;
wire [2:0] s332;
assign s332 = ({3{s313}} & 3'b000) | ({3{s317}} & 3'b001) | ({3{s319}} & 3'b010) | ({3{s321}} & 3'b011) | ({3{s314}} & 3'b100) | ({3{s318}} & 3'b101) | ({3{s320}} & 3'b110) | ({3{s315}} & 3'b000) | ({3{s322}} & 3'b001) | ({3{s323}} & 3'b010) | ({3{s324}} & 3'b011);
wire [31:0] s333 = {{15{ifu_instr[31]}},ifu_instr[16:15],ifu_instr[19:17],ifu_instr[20],ifu_instr[30:21],ifu_instr[14]};
wire s334 = s6 & (ifu_instr[6:0] == OP_CUSTOM2) & (ifu_instr[14:12] == 3'b000) & (ifu_instr[31:25] == 7'b0000101);
wire s335 = s6 & (ifu_instr[6:0] == OP_CUSTOM2) & (ifu_instr[14:12] == 3'b000) & (ifu_instr[31:25] == 7'b0000110);
wire s336 = s6 & (ifu_instr[6:0] == OP_CUSTOM2) & (ifu_instr[14:12] == 3'b000) & (ifu_instr[31:25] == 7'b0000111);
wire s337 = 1'b0;
wire s338 = 1'b0;
wire s339 = 1'b0;
wire s340 = 1'b0;
wire s341 = s337 | s338 | s339 | s340;
wire s342 = s334 | s335 | s336 | s341;
wire s343 = ~csr_mmisc_ctl_rvcompm & s342;
wire s344 = s7 & (ifu_instr[6:0] == OP_CUSTOM2) & (ifu_instr[14:12] == 3'b101);
wire s345 = s7 & (ifu_instr[6:0] == OP_CUSTOM2) & (ifu_instr[14:12] == 3'b110);
wire s346 = s344 | s345;
wire s347 = ~csr_mmisc_ctl_rvcompm & s346;
wire s348 = s8 & (ifu_instr[6:0] == OP_CUSTOM2) & (ifu_instr[14:12] == 3'b111) & ~ifu_instr[30];
wire s349 = s8 & (ifu_instr[6:0] == OP_CUSTOM2) & (ifu_instr[14:12] == 3'b111) & ifu_instr[30];
wire s350 = s348 | s349;
wire s351 = ~csr_mmisc_ctl_rvcompm & s350;
wire s352 = s9 & (ifu_instr[6:0] == OP_CUSTOM2) & (ifu_instr[14:12] == 3'b011);
wire s353 = s9 & (ifu_instr[6:0] == OP_CUSTOM2) & (ifu_instr[14:12] == 3'b010);
wire s354 = s352 | s353;
wire s355 = ~csr_mmisc_ctl_rvcompm & s354;
wire [5:0] s356 = ifu_instr[31:26];
wire [5:0] s357 = ifu_instr[25:20];
wire s358 = (s356 < s357);
wire s359 = ~(|s356);
wire [31:0] s360 = s359 ? {{20{1'b0}},s357,s357} : s358 ? {{20{1'b0}},s357,s356} : {{20{1'b0}},s356,s357};
wire s361 = s354 & (s358 | s359);
wire s362 = s10 & (ifu_instr[6:0] == OP_CUSTOM2) & (ifu_instr[14:12] == 3'b000) & (ifu_instr[31:25] == 7'b0010000);
wire s363 = s10 & (ifu_instr[6:0] == OP_CUSTOM2) & (ifu_instr[14:12] == 3'b000) & (ifu_instr[31:25] == 7'b0010001);
wire s364 = s10 & (ifu_instr[6:0] == OP_CUSTOM2) & (ifu_instr[14:12] == 3'b000) & (ifu_instr[31:25] == 7'b0010010);
wire s365 = s10 & (ifu_instr[6:0] == OP_CUSTOM2) & (ifu_instr[14:12] == 3'b000) & (ifu_instr[31:25] == 7'b0010011);
wire s366 = s362 | s363 | s364 | s365;
wire s367 = ~csr_mmisc_ctl_rvcompm & s366;
wire s368 = ~csr_mmisc_ctl_rvcompm & s232;
wire s369;
wire s370 = ((s21 == 5'h02) & rd1_wen) & s369;
assign s369 = (cur_privilege_m & csr_mhsp_ctl_m) | (cur_privilege_s & csr_mhsp_ctl_s) | (cur_privilege_u & csr_mhsp_ctl_u);
wire s371 = s83 | s84 | s256;
wire s372 = s85 | s86 | s87 | s89 | s88 | s90 | s257 | s347 | s351;
wire s373 = s81 | s82 | s107 | s111 | s112 | s191 | s192 | s193 | s200 | s201 | s202 | s195 | s196 | s197 | s105 | s106 | s99 | s198 | s199 | s194 | s114 | s113 | s110 | s104 | s103 | s102 | s108 | s109 | s100 | s101;
wire s374 = s203 | s93 | s205 | s92 | s95 | s91 | s94 | (s254 & ~instr_sfp_ls) | s304 | s325;
wire s375 = s204 | s98 | s97 | s96 | s255 | s308 | s330 | instr_sfp_shw | instr_sfp_sw | instr_sfp_sd;
wire s376 = s203 | s93 | s205 | s92 | s95 | s91 | s94 | (s254 & ~instr_sfp_ls) | s329;
wire s377 = instr_sfp_lhw | instr_sfp_lw | instr_sfp_ld | instr_sfp_c_lwsp | instr_sfp_c_ldsp | instr_sfp_c_lw | instr_sfp_c_ld;
wire s378 = instr_sfp_shw | instr_sfp_sw | instr_sfp_sd | instr_sfp_c_swsp | instr_sfp_c_sdsp | instr_sfp_c_sw | instr_sfp_c_sd;
wire s379 = s376 | s307 | s377;
wire s380 = s116 | s117;
wire s381 = instr_csr | s119 | s120 | s121 | s188 | s189 | s190 | s115 | s118 | s231;
assign id_ctrl[88 +:12] = s128;
wire s382 = (s22 == 5'd1) | (s22 == 5'd5);
wire s383 = (s33 == 5'd1) | (s33 == 5'd5);
wire s384 = (s84 & s382 & (~s383 | (s22 != s33)) & (ifu_instr[31:20] == 12'd0)) | (s213 & s382 & (s36 != 5'd1)) | (s212 & s382);
wire s385 = (s83 | s84) & (s33 == 5'd1 | s33 == 5'd5) | s211 | s213;
assign vpu_decode = {26{1'b0}};
wire s386 = s328;
wire s387 = ~ifu_instr_16b & ~s386;
wire s388 = (s3 & (ifu_instr[1:0] == OP_C0) & (ifu_instr[15:13] != 3'b0)) | (s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15] == 1'b1)) | s244;
wire s389 = (s3 & (ifu_instr[1:0] == OP_C2) & (ifu_instr[14] == 1'b0) & ~instr_sfp_ls & ~s244) | (s3 & (ifu_instr[1:0] == OP_C1) & (ifu_instr[15] == 1'b0));
wire s390 = (s3 & (ifu_instr[1:0] == OP_C2) & ((ifu_instr[14] == 1'b1) | (ifu_instr[14] == 1'b0) & instr_sfp_ls)) | (s3 & (ifu_instr[1:0] == OP_C0) & (ifu_instr[15:13] == 3'b0));
assign s22 = ({5{s387 & ~s47}} & s34) | ({5{s388 & ~s47}} & {2'b01,s41}) | ({5{s390 & ~s47}} & 5'b00010) | ({5{s389 & ~s47}} & s36) | ({5{s386 & ~s47}} & 5'b00011) | ({5{s47}} & ace_dec_rs1_index);
assign s28 = rs1_ren;
assign s29 = ((ifu_instr[6:0] == OP_SYSTEM) & ifu_instr[14]) | vpu_decode[17];
assign s30 = csr_halt_mode & (s34 == 5'd0) & ((ifu_instr[6:0] == OP_LOAD) | (ifu_instr[6:0] == OP_STORE) | (ifu_instr[6:0] == OP_JALR) | (ifu_instr[6:0] == OP_FP_LOAD) | (ifu_instr[6:0] == OP_FP_STORE));
assign s31 = s82;
assign s23 = id_ctrl[47];
assign s32 = (vpu_decode[11]) & (s33 != 5'd0) & (s34 == 5'd0);
assign rs1_ren = (~ifu_instr_16b & (s34 != 5'd0) & (~s79 & ~s80 & ~s29) & ~s47 & ~instr_sfp) | s328 | (instr_dsp & s56 & (s60 != 5'b0)) | (instr_sfp & sfp_rs1_ren & (s34 != 5'd0)) | (s253 & ((s36 != 5'b0) | s388 | s390)) | (ace_dec_xrf_rs1_ren & (ace_dec_rs1_index != 5'd0)) | vpu_decode[15] | s50;
wire s391 = (s3 & (ifu_instr[1:0] == OP_C0)) | (s3 & (ifu_instr[1:0] == OP_C1)) | s244;
wire s392 = (s3 & (ifu_instr[1:0] == OP_C2) & ~s244);
wire s393 = instr_dsp;
wire s394 = ~ifu_instr_16b;
wire s395 = s47;
assign s24 = ({5{s394 & ~s393 & ~s395}} & s35) | ({5{s393}} & s61) | ({5{s395}} & ace_dec_rs2_index) | ({5{s391}} & {2'b01,s46}) | ({5{s392}} & s38);
assign rs2_ren = ((s76 | s77 | s78 | s326 | s342 | s366 | s190) & (s35 != 5'd0)) | (instr_dsp & s57 & (s61 != 5'b0)) | ((s252 | s247) & (ifu_instr[6:2] != 5'd0)) | s249 | (ace_dec_xrf_rs2_ren & (ace_dec_rs2_index != 5'd0)) | vpu_decode[16] | s51;
wire s396 = s83 | s84 | s256;
wire s397 = s81 | s82;
wire s398 = (ifu_instr[6:0] == OP_IMM) | (ifu_instr[6:0] == OP_IMM32);
wire s399 = s354;
wire s400 = s346;
wire s401 = s350;
wire s402 = s316;
wire s403 = ((s246 & ~s254) | s251 | s250);
wire s404 = vpu_decode[19];
wire s405 = vpu_decode[18];
wire [31:0] s406 = {{20{ifu_instr[31]}},ifu_instr[31:20]};
wire [63:0] s407 = {{32{ifu_instr[31]}},ifu_instr[31:12],12'd0};
wire [31:0] s408 = {{25{1'b0}},ifu_instr[30],ifu_instr[7],ifu_instr[24:20]};
wire [31:0] s409 = {{25{1'b0}},1'b0,ifu_instr[7],ifu_instr[24:20]};
wire [31:0] s410 = s260 ? {{30{1'b0}},2'd2} : {{29{1'b0}},3'd4};
wire [31:0] s411 = {{21{1'b0}},ifu_instr[30:20]};
wire [31:0] s412 = {{22{1'b0}},ifu_instr[29:20]};
wire [31:0] s413 = ({32{s216}} & {{26{ifu_instr[12]}},ifu_instr[12],ifu_instr[6:2]}) | ({32{s217}} & {{14{ifu_instr[12]}},ifu_instr[12],ifu_instr[6:2],12'b0}) | ({32{s218}} & {{26{ifu_instr[12]}},ifu_instr[12],ifu_instr[6:2]}) | ({32{s237}} & {{26{ifu_instr[12]}},ifu_instr[12],ifu_instr[6:2]}) | ({32{s219}} & {{22{ifu_instr[12]}},ifu_instr[12],ifu_instr[4:3],ifu_instr[5],ifu_instr[2],ifu_instr[6],4'b0}) | ({32{s220}} & {{22{1'b0}},ifu_instr[10:7],ifu_instr[12:11],ifu_instr[5],ifu_instr[6],2'b0}) | ({32{s221}} & {{26{1'b0}},ifu_instr[12],ifu_instr[6:2]}) | ({32{s222}} & {{26{1'b0}},ifu_instr[12],ifu_instr[6:2]}) | ({32{s223}} & {{26{1'b0}},ifu_instr[12],ifu_instr[6:2]}) | ({32{s224}} & {{26{ifu_instr[12]}},ifu_instr[12],ifu_instr[6:2]});
assign id_ctrl[318 +:5] = ifu_instr[19:15];
assign src2_imm = ({32{s396}} & s410) | ({32{s397}} & s407[31:0]) | ({32{s398}} & s406) | ({32{s399}} & s360) | ({32{s400}} & s408) | ({32{s401}} & s409) | ({32{s403}} & s413) | ({32{s402}} & s333) | ({32{s404}} & s411) | ({32{s405}} & s412);
assign rs3_ren = (s58 & (s62 != 5'b0)) | (ace_dec_xrf_rs3_ren & (ace_dec_rs3_index != 5'b0));
assign rs4_ren = (s59 & (s63 != 5'b0)) | (ace_dec_xrf_rs4_ren & (ace_dec_rs4_index != 5'b0));
assign s25 = ace_dec_xrf_rs3_ren ? ace_dec_rs3_index : s62;
assign s26 = ace_dec_xrf_rs4_ren ? ace_dec_rs4_index : s63;
assign id_ctrl[2] = s114 | s104 | s227 | s224 | s311 | s139;
assign id_ctrl[19] = s113 | s103 | s81 | s228 | s225 | s312 | s140;
assign id_ctrl[35] = s110 | s102 | s229 | s310 | s141;
assign id_ctrl[1] = s82 | s105 | s99 | s106 | s198 | s194 | s199 | s216 | s217 | s218 | s237 | s219 | s220 | s226 | s230 | s238 | s239 | s309 | s316;
assign id_ctrl[27] = s107 | s191 | s200 | s195 | s221 | s111 | s192 | s201 | s196 | s222 | s112 | s193 | s202 | s197 | s223 | s138;
assign id_ctrl[29] = s108 | s100;
assign id_ctrl[30] = s109 | s101;
assign id_ctrl[3] = s354;
assign id_ctrl[32] = s366;
assign id_ctrl[33] = s106 | s199 | s89 | s90 | s88 | s89 | s87 | s108 | s100 | s109 | s101 | s230 | s239;
assign id_ctrl[28] = s107 | s191 | s200 | s195 | s221 | s361 | s184;
assign id_ctrl[34] = s195 | s196 | s197 | s200 | s201 | s202 | s198 | s199 | s194 | s238 | s239 | s237 | s183;
assign id_ctrl[31] = s112 | s193 | s202 | s197 | s223 | s352;
assign id_ctrl[12] = s342;
assign id_ctrl[121] = s232;
assign id_ctrl[140] = instr_from_exec_it & ~s0;
generate
    if ((ISA_LEA_INT == 1) || (ISA_STR_INT == 1) || 1'b0) begin:gen_alu_shamt
        wire [1:0] s414 = (s342 | s366) ? ifu_instr[26:25] : s181;
        wire [3:0] s415;
        assign s415[0] = s414 == 2'd0;
        assign s415[1] = s414 == 2'd1;
        assign s415[2] = s414 == 2'd2;
        assign s415[3] = s414 == 2'd3;
        assign id_ctrl[23 +:4] = s415;
    end
    else begin:gen_no_alu_func_lea
        assign id_ctrl[23 +:4] = 4'd0;
    end
endgenerate
assign id_ctrl[13] = s341 | s182;
assign id_ctrl[221 +:4] = ({4{s268}} & MDUOP_MUL) | ({4{s269}} & MDUOP_MULH) | ({4{s271}} & MDUOP_MULHU) | ({4{s270}} & MDUOP_MULHSU) | ({4{s272}} & MDUOP_DIV) | ({4{s273}} & MDUOP_DIVU) | ({4{s274}} & MDUOP_REM) | ({4{s275}} & MDUOP_REMU) | ({4{s276}} & MDUOP_MULW) | ({4{s277}} & MDUOP_DIVW) | ({4{s278}} & MDUOP_DIVUW) | ({4{s279}} & MDUOP_REMW) | ({4{s280}} & MDUOP_REMUW);
wire s416;
wire s417;
generate
    if ((MULTIPLIER_INT == 0)) begin:gen_ii_fastmul_enable
        assign s416 = s272 | s273 | s274 | s275 | s277 | s278 | s279 | s280;
        assign s417 = s268 | s269 | s270 | s271 | s276;
    end
    else begin:gen_ii_fastmul_disable
        assign s416 = s268 | s269 | s270 | s271 | s272 | s273 | s274 | s275 | s276 | s277 | s278 | s279 | s280;
        assign s417 = 1'b0;
    end
endgenerate
wire [20:0] s418;
assign s418 = ({21{s80}} & {ifu_instr[31],ifu_instr[19:12],ifu_instr[20],ifu_instr[30:21],1'b0}) | ({21{s78}} & {{8{ifu_instr[31]}},ifu_instr[31],ifu_instr[7],ifu_instr[30:25],ifu_instr[11:8],1'b0}) | ({21{(ifu_instr[6:0] == OP_JALR)}} & {{9{ifu_instr[31]}},ifu_instr[31:20]}) | ({21{s210}} & {{9{ifu_instr[12]}},ifu_instr[12],ifu_instr[8],ifu_instr[10:9],ifu_instr[6],ifu_instr[7],ifu_instr[2],ifu_instr[11],ifu_instr[5:3],1'b0}) | ({21{s211}} & {{9{ifu_instr[12]}},ifu_instr[12],ifu_instr[8],ifu_instr[10:9],ifu_instr[6],ifu_instr[7],ifu_instr[2],ifu_instr[11],ifu_instr[5:3],1'b0}) | ({21{s214}} & {{12{ifu_instr[12]}},ifu_instr[12],ifu_instr[6:5],ifu_instr[2],ifu_instr[11:10],ifu_instr[4:3],1'b0}) | ({21{s214}} & {{12{ifu_instr[12]}},ifu_instr[12],ifu_instr[6:5],ifu_instr[2],ifu_instr[11:10],ifu_instr[4:3],1'b0}) | ({21{s215}} & {{12{ifu_instr[12]}},ifu_instr[12],ifu_instr[6:5],ifu_instr[2],ifu_instr[11:10],ifu_instr[4:3],1'b0}) | ({21{s346}} & {{11{ifu_instr[31]}},ifu_instr[29:25],ifu_instr[11:8],1'b0}) | ({21{s350}} & {{11{ifu_instr[31]}},ifu_instr[29:25],ifu_instr[11:8],1'b0});
wire s419 = (ifu_instr[6:0] == OP_LOAD) | (ifu_instr[6:0] == OP_FP_LOAD);
assign id_ctrl[228 +:21] = ({21{s419}} & {{9{ifu_instr[31]}},ifu_instr[31:20]}) | ({21{s77}} & {{9{ifu_instr[31]}},ifu_instr[31:25],ifu_instr[11:7]}) | ({21{s206}} & {13'b0,ifu_instr[3:2],ifu_instr[12],ifu_instr[6:4],2'b0}) | ({21{s233}} & {12'b0,ifu_instr[4:2],ifu_instr[12],ifu_instr[6:5],3'b0}) | ({21{s207}} & {13'b0,ifu_instr[8:7],ifu_instr[12:9],2'b0}) | ({21{s234}} & {12'b0,ifu_instr[9:7],ifu_instr[12:10],3'b0}) | ({21{s208}} & {14'b0,ifu_instr[5],ifu_instr[12:10],ifu_instr[6],2'b0}) | ({21{s235}} & {13'b0,ifu_instr[6:5],ifu_instr[12:10],3'b0}) | ({21{s209}} & {14'b0,ifu_instr[5],ifu_instr[12:10],ifu_instr[6],2'b0}) | ({21{s236}} & {13'b0,ifu_instr[6:5],ifu_instr[12:10],3'b0}) | ({21{instr_sfp_c_lwsp}} & {13'b0,ifu_instr[3:2],ifu_instr[12],ifu_instr[6:4],2'b0}) | ({21{instr_sfp_c_ldsp}} & {12'b0,ifu_instr[4:2],ifu_instr[12],ifu_instr[6:5],3'b0}) | ({21{instr_sfp_c_swsp}} & {13'b0,ifu_instr[8:7],ifu_instr[12:9],2'b0}) | ({21{instr_sfp_c_sdsp}} & {12'b0,ifu_instr[9:7],ifu_instr[12:10],3'b0}) | ({21{instr_sfp_c_lw}} & {14'b0,ifu_instr[5],ifu_instr[12:10],ifu_instr[6],2'b0}) | ({21{instr_sfp_c_ld}} & {13'b0,ifu_instr[6:5],ifu_instr[12:10],3'b0}) | ({21{instr_sfp_c_sw}} & {14'b0,ifu_instr[5],ifu_instr[12:10],ifu_instr[6],2'b0}) | ({21{instr_sfp_c_sd}} & {13'b0,ifu_instr[6:5],ifu_instr[12:10],3'b0}) | ({21{s210}} & {{9{ifu_instr[12]}},ifu_instr[12],ifu_instr[8],ifu_instr[10:9],ifu_instr[6],ifu_instr[7],ifu_instr[2],ifu_instr[11],ifu_instr[5:3],1'b0}) | ({21{s211}} & {{9{ifu_instr[12]}},ifu_instr[12],ifu_instr[8],ifu_instr[10:9],ifu_instr[6],ifu_instr[7],ifu_instr[2],ifu_instr[11],ifu_instr[5:3],1'b0}) | ({21{s214}} & {{12{ifu_instr[12]}},ifu_instr[12],ifu_instr[6:5],ifu_instr[2],ifu_instr[11:10],ifu_instr[4:3],1'b0}) | ({21{s215}} & {{12{ifu_instr[12]}},ifu_instr[12],ifu_instr[6:5],ifu_instr[2],ifu_instr[11:10],ifu_instr[4:3],1'b0}) | ({21{s313}} & {{4{ifu_instr[31]}},ifu_instr[16:15],ifu_instr[19:17],ifu_instr[20],ifu_instr[30:21],ifu_instr[14]}) | ({21{s314}} & {{4{ifu_instr[31]}},ifu_instr[16:15],ifu_instr[19:17],ifu_instr[20],ifu_instr[30:21],ifu_instr[14]}) | ({21{s317}} & {{4{ifu_instr[31]}},ifu_instr[16:15],ifu_instr[19:17],ifu_instr[20],ifu_instr[30:21],1'b0}) | ({21{s318}} & {{4{ifu_instr[31]}},ifu_instr[16:15],ifu_instr[19:17],ifu_instr[20],ifu_instr[30:21],1'b0}) | ({21{s319}} & {{3{ifu_instr[31]}},ifu_instr[21],ifu_instr[16:15],ifu_instr[19:17],ifu_instr[20],ifu_instr[30:22],2'b0}) | ({21{s320}} & {{3{ifu_instr[31]}},ifu_instr[21],ifu_instr[16:15],ifu_instr[19:17],ifu_instr[20],ifu_instr[30:22],2'b0}) | ({21{s321}} & {{2{ifu_instr[31]}},ifu_instr[22:21],ifu_instr[16:15],ifu_instr[19:17],ifu_instr[20],ifu_instr[30:23],3'b0}) | ({21{s315}} & {{4{ifu_instr[31]}},ifu_instr[16:15],ifu_instr[19:17],ifu_instr[7],ifu_instr[30:25],ifu_instr[11:8],ifu_instr[14]}) | ({21{s322}} & {{4{ifu_instr[31]}},ifu_instr[16:15],ifu_instr[19:17],ifu_instr[7],ifu_instr[30:25],ifu_instr[11:8],1'b0}) | ({21{s323}} & {{3{ifu_instr[31]}},ifu_instr[8],ifu_instr[16:15],ifu_instr[19:17],ifu_instr[7],ifu_instr[30:25],ifu_instr[11:9],2'b0}) | ({21{s324}} & {{2{ifu_instr[31]}},ifu_instr[9:8],ifu_instr[16:15],ifu_instr[19:17],ifu_instr[7],ifu_instr[30:25],ifu_instr[11:10],3'b0}) | ({21{s346}} & {{11{ifu_instr[31]}},ifu_instr[29:25],ifu_instr[11:8],1'b0}) | ({21{s350}} & {{11{ifu_instr[31]}},ifu_instr[29:25],ifu_instr[11:8],1'b0}) | s245;
assign s21 = instr_dsp ? s64 : s47 ? ace_dec_rd1_index : (ifu_instr[1:0] == 2'b11) ? s33 : s264;
assign rd1_wen = s371 | s374 | s416 | s417 | s373 | s83 | s84 | s258 | instr_csr | s308 | (instr_dsp & s66) | (instr_sfp & sfp_rd1_wen) | s342 | s354 | s366 | s316 | (s47 & ace_dec_xrf_rd1_wen) | vpu_decode[14] | s49;
assign s27 = instr_dsp ? s65 : ace_dec_rd2_index;
assign rd2_wen = (instr_dsp & s67) | (s47 & ace_dec_xrf_rd2_wen);
assign id_ctrl[205 +:8] = 8'b0;
assign id_ctrl[204] = 1'b0;
wire [2:0] s420;
assign s420[1:0] = (s206 | s208 | s207 | s209 | instr_sfp_c_lwsp | instr_sfp_c_lw | instr_sfp_c_swsp | instr_sfp_c_sw) ? 2'b10 : (s233 | s235 | s234 | s236 | instr_sfp_c_ldsp | instr_sfp_c_ld | instr_sfp_c_sdsp | instr_sfp_c_sd) ? 2'b11 : (s242 | s243) ? 2'b01 : 2'b00;
assign s420[2] = s241 | s243;
wire s421 = ~ifu_instr_16b & ~s328;
assign id_ctrl[213 +:3] = ({3{s421}} & ((instr_sfp_lhw | instr_sfp_shw) ? 3'b001 : ifu_instr[14:12])) | ({3{s328}} & s332) | ({3{ifu_instr_16b}} & s420);
assign id_ctrl[216] = s379;
assign id_ctrl[220] = s375;
assign id_ctrl[217] = s304;
assign id_ctrl[219] = s305;
assign id_ctrl[198] = s303;
assign id_ctrl[218] = s376 & ~s370;
assign id_ctrl[199 +:5] = s303 ? ifu_instr[31:27] : {4'd0,s72};
wire [4:0] s422;
assign s422[0] = s86 | s85 | s344 | s345 | s214 | s215;
assign s422[1] = s90 | s88 | s89 | s87;
assign s422[2] = s348 | s349;
assign s422[3] = s85 | s214 | s344 | s90 | s88 | s348;
assign s422[4] = s90 | s89;
assign id_ctrl[37 +:5] = s422;
wire s423 = (ifu_instr[2] == 1'b1) & (ifu_instr[1:0] == 2'b11);
wire s424 = (ifu_instr[3:2] == 2'b00) & (ifu_instr[1:0] == 2'b11);
wire s425 = (ifu_instr[3:2] == 2'b10) & (ifu_instr[1:0] == 2'b11);
wire s426 = (ifu_instr[14] == 1'b0) & (ifu_instr[1:0] == 2'b01);
wire s427 = (ifu_instr[14] == 1'b1) & (ifu_instr[1:0] == 2'b01);
wire s428 = s372 & ((ifu_instr[31] & (s423 | s424 | s425)) | (ifu_instr[12] & (s426 | s427)));
wire instr_legal_dsp;
wire s429;
wire s430 = s371 | s372 | s416 | s417 | s373 | s375 | s379 | s381 | s380 | s118 | s115 | s231 | s259 | s306 | s331 | s343 | s347 | s351 | s355 | s367 | s368 | instr_sfp | instr_legal_dsp | s429 | s72 | vpu_decode[13];
wire s431 = ~s265;
wire s432 = 1'b1;
wire s433 = 1'b1;
wire s434 = 1'b1;
wire s435 = ~s266;
wire s436 = ~s266;
wire s437 = ~s267;
wire s438;
assign s438 = 1'b0;
wire s439 = s438 & ifu_instr_16b;
wire s440 = (s189 & cur_privilege_u & ((RVN_SUPPORT_INT == 0))) | (s189 & csr_mstatus_tw & cur_privilege_s) | (s188 & ~csr_halt_mode) | (s119 & ~cur_privilege_m) | (s120 & cur_privilege_u) | (s120 & csr_mstatus_tsr & cur_privilege_s) | (s190 & ((csr_mstatus_tvm & cur_privilege_s) | cur_privilege_u));
wire s441 = ~ifu_pred_bogus & ~(ifu_fault | ifu_page_fault) & (~s430 | ~s431 | ~s432 | ~s433 | ~s434 | ~s435 | ~s436 | ~s437 | s439 | instr_illegal_sfp | s440 | (s75));
wire s442 = ~ifu_pred_bogus & (~s431 | ~s432 | ~s433 | ~s434 | ~s435 | ~s436 | ~s437);
wire [2:0] s443;
wire s444;
wire s445;
wire s446 = s115 | s231;
wire [1:0] s447;
assign s447[0] = s117 | s116 | (s126 & ~s129) | s190;
assign s447[1] = s444;
assign s444 = s370 & (s416 | s379 | instr_csr | s417);
assign s445 = s369 & s72;
assign s443[0] = trigm_icount_enabled | (s126 & (s128 == 12'h7d0));
assign s443[1] = s127;
assign s443[2] = (s126 & (s128 == 12'h003)) | (s126 & (s128 == 12'h002)) | (s126 & (s128 == 12'h001));
assign id_ctrl[316] = s189;
assign s47 = (ifu_instr[6:0] == OP_ACE) & ((ACE_SUPPORT_INT == 1));
assign s429 = s47 & ~ace_dec_illegal_insn & (csr_mmisc_ctl_aces != 2'b0);
assign s54 = s47 & (csr_mmisc_ctl_aces == 2'b0);
ace_pre_dec u_ace_pre_dec(
    .ace_dec_inst(ifu_instr),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .ace_dec_xrf_rs1_ren(ace_dec_xrf_rs1_ren),
    .ace_dec_xrf_rs2_ren(ace_dec_xrf_rs2_ren),
    .ace_dec_xrf_rs3_ren(ace_dec_xrf_rs3_ren),
    .ace_dec_xrf_rs4_ren(ace_dec_xrf_rs4_ren),
    .ace_dec_xrf_rd1_wen(ace_dec_xrf_rd1_wen),
    .ace_dec_xrf_rd2_wen(ace_dec_xrf_rd2_wen),
    .ace_dec_frf_rs1_ren(nds_unused_ace_dec_frf_rs1_ren),
    .ace_dec_frf_rs2_ren(nds_unused_ace_dec_frf_rs2_ren),
    .ace_dec_frf_rd1_wen(nds_unused_ace_dec_frf_rd1_wen),
    .ace_dec_vrf_rs1_ren(nds_unused_ace_dec_vrf_rs1_ren),
    .ace_dec_vrf_rs2_ren(nds_unused_ace_dec_vrf_rs2_ren),
    .ace_dec_vrf_rd1_wen(nds_unused_ace_dec_vrf_rd1_wen),
    .ace_dec_rs1_index(ace_dec_rs1_index),
    .ace_dec_rs2_index(ace_dec_rs2_index),
    .ace_dec_rs3_index(ace_dec_rs3_index),
    .ace_dec_rs4_index(ace_dec_rs4_index),
    .ace_dec_rd1_index(ace_dec_rd1_index),
    .ace_dec_rd2_index(ace_dec_rd2_index),
    .ace_dec_illegal_insn(ace_dec_illegal_insn),
    .ace_dec_xcpt(ace_dec_xcpt),
    .ace_dec_xcpt_cause(ace_dec_xcpt_cause),
    .ace_dec_sync_en(ace_dec_sync_en)
);
generate
    if ((DSP_SUPPORT_INT == 1)) begin:gen_dsp
        kv_dsp_predec #(
            .OP_DSP(OP_DSP)
        ) u_kv_dsp_predec (
            .instr(ifu_instr),
            .csr_mmisc_ctl_rvcompm(csr_mmisc_ctl_rvcompm),
            .instr_dsp(instr_dsp),
            .instr_legal_dsp(instr_legal_dsp),
            .rs1_ren(s56),
            .rs2_ren(s57),
            .rs3_ren(s58),
            .rs4_ren(s59),
            .rs1_addr(s60),
            .rs2_addr(s61),
            .rs3_addr(s62),
            .rs4_addr(s63),
            .rd1_wen(s66),
            .rd2_wen(s67),
            .rd1_addr(s64),
            .rd2_addr(s65),
            .ready_stage(s68)
        );
    end
endgenerate
generate
    if ((DSP_SUPPORT_INT == 0)) begin:gen_dsp_stub
        kv_dsp_predec_stub #(
            .OP_DSP(OP_DSP)
        ) u_kv_dsp_predec_stub (
            .instr(ifu_instr),
            .csr_mmisc_ctl_rvcompm(csr_mmisc_ctl_rvcompm),
            .instr_dsp(instr_dsp),
            .instr_legal_dsp(instr_legal_dsp),
            .rs1_ren(s56),
            .rs2_ren(s57),
            .rs3_ren(s58),
            .rs4_ren(s59),
            .rs1_addr(s60),
            .rs2_addr(s61),
            .rs3_addr(s62),
            .rs4_addr(s63),
            .rd1_wen(s66),
            .rd2_wen(s67),
            .rd1_addr(s64),
            .rd2_addr(s65),
            .ready_stage(s68)
        );
    end
endgenerate
assign id_ctrl[141 +:5] = sfp_frs1;
assign id_ctrl[146] = sfp_frs1_ren;
assign id_ctrl[147 +:5] = sfp_frs2;
assign id_ctrl[152] = sfp_frs2_ren;
assign id_ctrl[153 +:5] = sfp_frs3;
assign id_ctrl[158] = sfp_frs3_ren;
assign id_ctrl[131 +:5] = sfp_frd1;
assign id_ctrl[136] = sfp_frd1_wen;
assign id_ctrl[137 +:3] = sfp_ex_rm;
assign id_ctrl[162] = sfp_ex_sign;
assign id_ctrl[159 +:3] = sfp_ex_sew;
assign id_ctrl[174] = sfp_ex_fmac & (FLEN == 32);
assign id_ctrl[175] = sfp_ex_fmac & (FLEN == 64);
assign id_ctrl[172] = sfp_ex_fdiv;
assign id_ctrl[176] = sfp_ex_fmis;
assign id_ctrl[177] = sfp_ex_fmv;
assign id_ctrl[173] = s377;
assign id_ctrl[178] = s378;
assign id_ctrl[123 +:6] = sfp_ex_ctrl;
generate
    if (FLEN != 1) begin:gen_sfp_predec
        kv_sfp_predec #(
            .FLEN(FLEN)
        ) u_kv_sfp_predec (
            .instr(ifu_instr),
            .vpu_decode(vpu_decode),
            .isa_c_dp_fls_en(isa_c_dp_fls_en),
            .csr_mmisc_ctl_rvcompm(csr_mmisc_ctl_rvcompm),
            .csr_mstatus_fs(csr_mstatus_fs),
            .csr_frm(csr_frm),
            .instr_csr(instr_csr),
            .instr_sfp(instr_sfp),
            .instr_illegal_sfp(instr_illegal_sfp),
            .instr_sfp_off_xcpt(instr_sfp_off_xcpt),
            .sfp_rs1_ren(sfp_rs1_ren),
            .sfp_rd1_wen(sfp_rd1_wen),
            .sfp_frd1(sfp_frd1),
            .sfp_frd1_wen(sfp_frd1_wen),
            .sfp_frs1(sfp_frs1),
            .sfp_frs1_ren(sfp_frs1_ren),
            .sfp_frs2(sfp_frs2),
            .sfp_frs2_ren(sfp_frs2_ren),
            .sfp_frs3(sfp_frs3),
            .sfp_frs3_ren(sfp_frs3_ren),
            .sfp_ex_rm(sfp_ex_rm),
            .sfp_ex_sign(sfp_ex_sign),
            .sfp_ex_sew(sfp_ex_sew),
            .sfp_ex_fmac(sfp_ex_fmac),
            .sfp_ex_fdiv(sfp_ex_fdiv),
            .sfp_ex_fmis(sfp_ex_fmis),
            .sfp_ex_fmv(sfp_ex_fmv),
            .sfp_ex_ctrl(sfp_ex_ctrl),
            .instr_sfp_ls(instr_sfp_ls),
            .instr_sfp_lhw(instr_sfp_lhw),
            .instr_sfp_shw(instr_sfp_shw),
            .instr_sfp_lw(instr_sfp_lw),
            .instr_sfp_sw(instr_sfp_sw),
            .instr_sfp_ld(instr_sfp_ld),
            .instr_sfp_sd(instr_sfp_sd),
            .instr_sfp_c_lwsp(instr_sfp_c_lwsp),
            .instr_sfp_c_swsp(instr_sfp_c_swsp),
            .instr_sfp_c_ldsp(instr_sfp_c_ldsp),
            .instr_sfp_c_sdsp(instr_sfp_c_sdsp),
            .instr_sfp_c_lw(instr_sfp_c_lw),
            .instr_sfp_c_sw(instr_sfp_c_sw),
            .instr_sfp_c_ld(instr_sfp_c_ld),
            .instr_sfp_c_sd(instr_sfp_c_sd)
        );
    end
endgenerate
generate
    if (FLEN == 1) begin:gen_sfp_predec_stub
        kv_sfp_predec_stub #(
            .FLEN(FLEN)
        ) u_kv_sfp_predec_stub (
            .instr(ifu_instr),
            .vpu_decode(vpu_decode),
            .isa_c_dp_fls_en(isa_c_dp_fls_en),
            .csr_mmisc_ctl_rvcompm(csr_mmisc_ctl_rvcompm),
            .csr_mstatus_fs(csr_mstatus_fs),
            .csr_frm(csr_frm),
            .instr_csr(instr_csr),
            .instr_sfp(instr_sfp),
            .instr_illegal_sfp(instr_illegal_sfp),
            .instr_sfp_off_xcpt(instr_sfp_off_xcpt),
            .sfp_rs1_ren(sfp_rs1_ren),
            .sfp_rd1_wen(sfp_rd1_wen),
            .sfp_frd1(sfp_frd1),
            .sfp_frd1_wen(sfp_frd1_wen),
            .sfp_frs1(sfp_frs1),
            .sfp_frs1_ren(sfp_frs1_ren),
            .sfp_frs2(sfp_frs2),
            .sfp_frs2_ren(sfp_frs2_ren),
            .sfp_frs3(sfp_frs3),
            .sfp_frs3_ren(sfp_frs3_ren),
            .sfp_ex_rm(sfp_ex_rm),
            .sfp_ex_sign(sfp_ex_sign),
            .sfp_ex_sew(sfp_ex_sew),
            .sfp_ex_fmac(sfp_ex_fmac),
            .sfp_ex_fdiv(sfp_ex_fdiv),
            .sfp_ex_fmis(sfp_ex_fmis),
            .sfp_ex_fmv(sfp_ex_fmv),
            .sfp_ex_ctrl(sfp_ex_ctrl),
            .instr_sfp_ls(instr_sfp_ls),
            .instr_sfp_lhw(instr_sfp_lhw),
            .instr_sfp_shw(instr_sfp_shw),
            .instr_sfp_lw(instr_sfp_lw),
            .instr_sfp_sw(instr_sfp_sw),
            .instr_sfp_ld(instr_sfp_ld),
            .instr_sfp_sd(instr_sfp_sd),
            .instr_sfp_c_lwsp(instr_sfp_c_lwsp),
            .instr_sfp_c_swsp(instr_sfp_c_swsp),
            .instr_sfp_c_ldsp(instr_sfp_c_ldsp),
            .instr_sfp_c_sdsp(instr_sfp_c_sdsp),
            .instr_sfp_c_lw(instr_sfp_c_lw),
            .instr_sfp_c_sw(instr_sfp_c_sw),
            .instr_sfp_c_ld(instr_sfp_c_ld),
            .instr_sfp_c_sd(instr_sfp_c_sd)
        );
    end
endgenerate
assign s69 = s12 & (ifu_instr[15:13] == 3'b100) & (ifu_instr[12:10] == 3'b100) & (ifu_instr[6:5] == 2'b00) & (ifu_instr[1:0] == OP_C0);
assign s70 = s12 & (ifu_instr[15:13] == 3'b100) & (ifu_instr[12:10] == 3'b100) & (ifu_instr[6:5] == 2'b01) & (ifu_instr[1:0] == OP_C0);
assign s71 = s12 & (ifu_instr[15:13] == 3'b100) & (ifu_instr[12:10] == 3'b100) & (ifu_instr[6:5] == 2'b10) & (ifu_instr[1:0] == OP_C0);
assign s72 = s69 | s70 | s71;
assign id_ctrl[167] = s225;
assign id_ctrl[164] = s373 | s258 | s83 | s84 | s211 | s213 | s342 | s354 | s366 | s316;
assign id_ctrl[165] = s114 | s113 | s110 | s104 | s103 | s102 | s81 | s227 | s228 | s229 | s225 | s85 | s86 | s214 | s215 | s344 | s345;
assign id_ctrl[179] = s379 | s305 | s116 | s117 | s190;
assign id_ctrl[180] = s203 | s93 | s205 | s206 | s233 | s208 | s235 | s319 | s320 | s321;
assign id_ctrl[183] = s375;
assign id_ctrl[168] = instr_csr;
assign id_ctrl[181] = s416;
assign id_ctrl[182] = s417;
assign id_ctrl[166] = (s371 | s372 | s384 | ifu_pred_bogus) | (ifu_pred_hit & ~(s371 | s372 | s384));
assign id_ctrl[169] = s68[0];
assign id_ctrl[171] = s68[1];
assign id_ctrl[170] = s68[2];
assign id_ctrl[163] = s47 & ~ace_dec_sync_en;
assign id_ctrl[0] = ace_dec_sync_en;
assign id_ctrl[194] = vpu_decode[11];
assign id_ctrl[193] = vpu_decode[10];
assign id_ctrl[185] = vpu_decode[2];
assign id_ctrl[189] = vpu_decode[6];
assign id_ctrl[190] = vpu_decode[7];
assign id_ctrl[186] = vpu_decode[3];
assign id_ctrl[188] = vpu_decode[5];
assign id_ctrl[192] = vpu_decode[9];
assign id_ctrl[187] = vpu_decode[4];
assign id_ctrl[191] = vpu_decode[8];
assign id_ctrl[184] = vpu_decode[1];
assign id_ctrl[195] = vpu_decode[12];
assign id_ctrl[311] = vpu_decode[22];
assign id_ctrl[313] = vpu_decode[23];
assign id_ctrl[314] = vpu_decode[24];
assign id_ctrl[315] = vpu_decode[25];
assign id_ctrl[309] = vpu_decode[20];
assign id_ctrl[310] = vpu_decode[21];
assign id_ctrl[312] = vpu_decode[0];
assign id_ctrl[42] = s0 & ifu_instr_16b | ~s0 & (ifu_instr_16b | instr_from_exec_it);
assign id_ctrl[73] = s371;
assign id_ctrl[46] = s372;
assign id_ctrl[72] = s384;
assign id_ctrl[45] = s385;
assign id_ctrl[43] = s428;
assign id_ctrl[70 +:2] = s447;
assign id_ctrl[48] = s84 | s213 | s212 | (~s0 & instr_from_exec_it & s83);
assign id_ctrl[49 +:21] = s418;
assign id_ctrl[47] = ~s0 & instr_from_exec_it & s83;
assign id_ctrl[44] = ifu_pred_hit & ~(s371 | s372 | s384 | s70);
assign id_ctrl[252 +:3] = s443;
assign id_ctrl[197] = s83 | s84 | s213 | s211;
assign id_ctrl[106] = s188;
assign id_ctrl[227] = s119;
assign id_ctrl[301] = s120;
assign id_ctrl[308] = s121;
assign id_ctrl[107] = s446;
assign id_ctrl[108] = s118;
assign id_ctrl[86] = s124;
assign id_ctrl[87] = s125;
assign id_ctrl[102] = s130;
assign id_ctrl[249] = s72;
assign id_ctrl[255 +:5] = s21;
assign id_ctrl[260] = rd1_wen;
assign id_ctrl[261 +:5] = s27;
assign id_ctrl[266] = rd2_wen;
assign id_ctrl[267 +:5] = s22;
assign id_ctrl[272] = rs1_ren;
assign id_ctrl[273 +:5] = s24;
assign id_ctrl[278] = rs2_ren;
assign id_ctrl[279 +:5] = s25;
assign id_ctrl[284] = rs3_ren;
assign id_ctrl[285 +:5] = s26;
assign id_ctrl[290] = rs4_ren;
assign id_ctrl[295 +:6] = {s32,s23,s30,s31,s29,s28};
wire s448 = ifu_page_fault | ifu_fault | s231 & instr_from_exec_it;
wire s449 = (s128[11:0] == CSR12_MCCTLCOMMAND) | (s128[11:0] == CSR12_UCCTLCOMMAND);
wire s450 = id_ctrl[294];
wire s451 = (ifu_instr[6:0] == OP_SYSTEM) & (ifu_instr[14:12] == 3'b001) & s449;
wire s452 = (ifu_instr[6:0] == OP_SYSTEM) & (ifu_instr[14:12] == 3'b101) & s449;
wire s453 = s450 & ~s72 & ~(s451 | s452);
wire s454 = s451 | s452 | s453;
assign id_ctrl[305] = s454;
assign id_ctrl[196] = (s446 & ~s448 & cur_privilege_m & csr_dcsr_ebreakm) | (s446 & ~s448 & cur_privilege_s & csr_dcsr_ebreaks) | (s446 & ~s448 & cur_privilege_u & csr_dcsr_ebreaku) | (s446 & ~s448 & csr_halt_mode);
assign id_ctrl[317] = ifu_page_fault | ifu_fault | (s118 & ~ifu_vector_resume) | (s441 & ~ifu_vector_resume) | (s446 & cur_privilege_m & ~csr_dcsr_ebreakm & ~ifu_vector_resume) | (s446 & cur_privilege_s & ~csr_dcsr_ebreaks & ~ifu_vector_resume) | (s446 & cur_privilege_u & ~csr_dcsr_ebreaku & ~ifu_vector_resume) | ace_dec_xcpt;
assign id_ctrl[304] = ifu_page_fault | ifu_fault | s442 | ifu_pred_bogus | s75 | (s441 & ~ifu_vector_resume) | id_ctrl[44];
wire [5:0] s455 = {3'd0,3'd1};
wire [5:0] s456 = ifu_page_fault ? 6'hc : ifu_fault ? 6'h1 : ace_dec_xcpt ? ace_dec_xcpt_cause : s441 ? 6'h2 : ({6{s118 & cur_privilege_m}} & 6'hb) | ({6{s118 & cur_privilege_s}} & 6'h9) | ({6{s118 & cur_privilege_u}} & 6'h8) | ({6{s446}} & 6'h3);
assign id_ctrl[76 +:6] = id_ctrl[196] ? s455 : s456;
assign id_ctrl[103 +:3] = s440 ? 3'd1 : 3'd0;
assign id_ctrl[302 +:2] = ifu_fault ? 2'b01 : s441 ? 2'b10 : 2'b00;
assign id_ctrl[82 +:3] = ifu_fault ? ifu_fault_dcause : instr_sfp_off_xcpt ? 3'd1 : s54 ? 3'd2 : 3'd0;
assign id_ctrl[109 +:8] = ifu_ecc_code;
assign id_ctrl[117] = ifu_ecc_corr;
assign id_ctrl[118 +:3] = ifu_ecc_ramid;
assign id_ctrl[292] = s381 | s380 | csr_halt_mode | csr_dcsr_step | trigm_icount_enabled | s447[1] | s58 | s59 | s67 | ace_dec_xrf_rs3_ren | ace_dec_xrf_rs4_ren | ace_dec_xrf_rd2_wen | s378 | ace_dec_sync_en;
assign id_ctrl[75] = (s99 | s100 | s101 | s102 | s103 | s104 | s191 | s192 | s193 | s194 | s195 | s196 | s197 | s218 | s221 | s222 | s223 | s224 | s237 | s81 | s82 | s316 | s354 | s216 | s217 | s225) & (s22 != 5'd2) & ~ifu_pred_taken;
assign id_ctrl[74] = s372 & (s418 <= 21'd8) & ~ifu_pred_hit;
assign id_ctrl[251] = ifu_pred_start;
assign id_ctrl[250] = ifu_pred_brk;
assign id_ctrl[130] = s117;
assign id_ctrl[129] = s116;
assign id_ctrl[291] = s190;
assign id_ctrl[122] = ifu_fault_upper;
assign id_ctrl[85] = 1'b0;
generate
    if ((STACKSAFE_SUPPORT_INT == 1)) begin:gen_stacksafe_support
        assign id_ctrl[293] = s370 & id_ctrl[164];
        assign id_ctrl[294] = s444 | s445;
    end
    else begin:gen_stacksafe_non_support
        assign id_ctrl[293] = 1'b0;
        assign id_ctrl[294] = 1'b0;
    end
endgenerate
endmodule


// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_pfm_csr (
    core_clk,
    core_reset_n,
    csr_we,
    csr_waddr,
    csr_wdata,
    csr_raddr0,
    csr_rd_hit0,
    csr_rdata0,
    csr_raddr1,
    csr_rd_hit1,
    csr_rdata1,
    ipipe_csr_pfm_inst_retire,
    wb_i0_instr_event,
    wb_i1_instr_event,
    hint_event,
    csr_dcsr_stopcount,
    csr_halt_mode,
    cur_privilege_m,
    cur_privilege_s,
    cur_privilege_u,
    csr_mcounteren,
    csr_mcounterwen,
    csr_scounteren,
    hpm_m_counter_ovf,
    hpm_s_counter_ovf
);
parameter PERFORMANCE_MONITOR_INT = 0;
parameter NUM_PRIVILEGE_LEVELS = 1;
localparam CSR12_MCOUNTEREN = 12'h306;
localparam CSR12_MCOUNTINHIBIT = 12'h320;
localparam CSR12_MCYCLE = 12'hb00;
localparam CSR12_MINSTRET = 12'hb02;
localparam CSR12_MHPMCOUNTER3 = 12'hb03;
localparam CSR12_MHPMCOUNTER4 = 12'hb04;
localparam CSR12_MHPMCOUNTER5 = 12'hb05;
localparam CSR12_MHPMCOUNTER6 = 12'hb06;
localparam CSR12_MCYCLEH = 12'hb80;
localparam CSR12_MINSTRETH = 12'hb82;
localparam CSR12_MHPMCOUNTER3H = 12'hb83;
localparam CSR12_MHPMCOUNTER4H = 12'hb84;
localparam CSR12_MHPMCOUNTER5H = 12'hb85;
localparam CSR12_MHPMCOUNTER6H = 12'hb86;
localparam CSR12_MHPMEVENT3 = 12'h323;
localparam CSR12_MHPMEVENT4 = 12'h324;
localparam CSR12_MHPMEVENT5 = 12'h325;
localparam CSR12_MHPMEVENT6 = 12'h326;
localparam CSR12_MCOUNTERWEN = 12'h7ce;
localparam CSR12_MCOUNTERINTEN = 12'h7cf;
localparam CSR12_MCOUNTERMASK_M = 12'h7d1;
localparam CSR12_MCOUNTERMASK_S = 12'h7d2;
localparam CSR12_MCOUNTERMASK_U = 12'h7d3;
localparam CSR12_MCOUNTEROVF = 12'h7d4;
localparam CSR12_CYCLE = 12'hc00;
localparam CSR12_INSTRET = 12'hc02;
localparam CSR12_HPMCOUNTER3 = 12'hc03;
localparam CSR12_HPMCOUNTER4 = 12'hc04;
localparam CSR12_HPMCOUNTER5 = 12'hc05;
localparam CSR12_HPMCOUNTER6 = 12'hc06;
localparam CSR12_CYCLEH = 12'hc80;
localparam CSR12_INSTRETH = 12'hc82;
localparam CSR12_HPMCOUNTER3H = 12'hc83;
localparam CSR12_HPMCOUNTER4H = 12'hc84;
localparam CSR12_HPMCOUNTER5H = 12'hc85;
localparam CSR12_HPMCOUNTER6H = 12'hc86;
localparam CSR12_SCOUNTEREN = 12'h106;
localparam CSR12_SCOUNTERINTEN = 12'h9cf;
localparam CSR12_SCOUNTERMASK_M = 12'h9d1;
localparam CSR12_SCOUNTERMASK_S = 12'h9d2;
localparam CSR12_SCOUNTERMASK_U = 12'h9d3;
localparam CSR12_SCOUNTEROVF = 12'h9d4;
localparam CSR12_SCOUNTINHIBIT = 12'h9e0;
localparam CSR12_SHPMEVENT3 = 12'h9e3;
localparam CSR12_SHPMEVENT4 = 12'h9e4;
localparam CSR12_SHPMEVENT5 = 12'h9e5;
localparam CSR12_SHPMEVENT6 = 12'h9e6;
input core_clk;
input core_reset_n;
input csr_we;
input [11:0] csr_waddr;
input [31:0] csr_wdata;
input [11:0] csr_raddr0;
output csr_rd_hit0;
output [31:0] csr_rdata0;
input [11:0] csr_raddr1;
output csr_rd_hit1;
output [31:0] csr_rdata1;
input [1:0] ipipe_csr_pfm_inst_retire;
input [40:0] wb_i0_instr_event;
input [40:0] wb_i1_instr_event;
input [43:0] hint_event;
input csr_dcsr_stopcount;
input csr_halt_mode;
input cur_privilege_m;
input cur_privilege_s;
input cur_privilege_u;
output [31:0] csr_mcounteren;
output [31:0] csr_mcounterwen;
output [31:0] csr_scounteren;
output hpm_m_counter_ovf;
output hpm_s_counter_ovf;
localparam SEL_CYCLE = 0;
localparam SEL_CYCLEH = 1;
localparam SEL_HPMCOUNTER3 = 2;
localparam SEL_HPMCOUNTER3H = 3;
localparam SEL_HPMCOUNTER4 = 4;
localparam SEL_HPMCOUNTER4H = 5;
localparam SEL_HPMCOUNTER5 = 6;
localparam SEL_HPMCOUNTER5H = 7;
localparam SEL_HPMCOUNTER6 = 8;
localparam SEL_HPMCOUNTER6H = 9;
localparam SEL_INSTRET = 10;
localparam SEL_INSTRETH = 11;
localparam SEL_MCOUNTEREN = 12;
localparam SEL_MCOUNTERINTEN = 13;
localparam SEL_MCOUNTERMASK_M = 14;
localparam SEL_MCOUNTERMASK_S = 15;
localparam SEL_MCOUNTERMASK_U = 16;
localparam SEL_MCOUNTEROVF = 17;
localparam SEL_MCOUNTERWEN = 18;
localparam SEL_MCOUNTINHIBIT = 19;
localparam SEL_MCYCLE = 20;
localparam SEL_MCYCLEH = 21;
localparam SEL_MHPMCOUNTER3 = 22;
localparam SEL_MHPMCOUNTER3H = 23;
localparam SEL_MHPMCOUNTER4 = 24;
localparam SEL_MHPMCOUNTER4H = 25;
localparam SEL_MHPMCOUNTER5 = 26;
localparam SEL_MHPMCOUNTER5H = 27;
localparam SEL_MHPMCOUNTER6 = 28;
localparam SEL_MHPMCOUNTER6H = 29;
localparam SEL_MHPMEVENT3 = 30;
localparam SEL_MHPMEVENT4 = 31;
localparam SEL_MHPMEVENT5 = 32;
localparam SEL_MHPMEVENT6 = 33;
localparam SEL_MINSTRET = 34;
localparam SEL_MINSTRETH = 35;
localparam SEL_SCOUNTEREN = 36;
localparam SEL_SCOUNTERINTEN = 37;
localparam SEL_SCOUNTERMASK_M = 38;
localparam SEL_SCOUNTERMASK_S = 39;
localparam SEL_SCOUNTERMASK_U = 40;
localparam SEL_SCOUNTEROVF = 41;
localparam SEL_SCOUNTINHIBIT = 42;
localparam SEL_SHPMEVENT3 = 43;
localparam SEL_SHPMEVENT4 = 44;
localparam SEL_SHPMEVENT5 = 45;
localparam SEL_SHPMEVENT6 = 46;
localparam SEL_BITS = 47;


wire [SEL_BITS - 1:0] s0;
assign s0[SEL_CYCLE] = (csr_waddr == CSR12_CYCLE) & (NUM_PRIVILEGE_LEVELS > 1);
assign s0[SEL_CYCLEH] = (csr_waddr == CSR12_CYCLEH) & (NUM_PRIVILEGE_LEVELS > 1);
assign s0[SEL_HPMCOUNTER3] = (csr_waddr == CSR12_HPMCOUNTER3) & (NUM_PRIVILEGE_LEVELS > 1);
assign s0[SEL_HPMCOUNTER3H] = (csr_waddr == CSR12_HPMCOUNTER3H) & (NUM_PRIVILEGE_LEVELS > 1);
assign s0[SEL_HPMCOUNTER4] = (csr_waddr == CSR12_HPMCOUNTER4) & (NUM_PRIVILEGE_LEVELS > 1);
assign s0[SEL_HPMCOUNTER4H] = (csr_waddr == CSR12_HPMCOUNTER4H) & (NUM_PRIVILEGE_LEVELS > 1);
assign s0[SEL_HPMCOUNTER5] = (csr_waddr == CSR12_HPMCOUNTER5) & (NUM_PRIVILEGE_LEVELS > 1);
assign s0[SEL_HPMCOUNTER5H] = (csr_waddr == CSR12_HPMCOUNTER5H) & (NUM_PRIVILEGE_LEVELS > 1);
assign s0[SEL_HPMCOUNTER6] = (csr_waddr == CSR12_HPMCOUNTER6) & (NUM_PRIVILEGE_LEVELS > 1);
assign s0[SEL_HPMCOUNTER6H] = (csr_waddr == CSR12_HPMCOUNTER6H) & (NUM_PRIVILEGE_LEVELS > 1);
assign s0[SEL_INSTRET] = (csr_waddr == CSR12_INSTRET) & (NUM_PRIVILEGE_LEVELS > 1);
assign s0[SEL_INSTRETH] = (csr_waddr == CSR12_INSTRETH) & (NUM_PRIVILEGE_LEVELS > 1);
assign s0[SEL_MCOUNTEREN] = (csr_waddr == CSR12_MCOUNTEREN) & (NUM_PRIVILEGE_LEVELS > 1);
assign s0[SEL_MCOUNTERINTEN] = (csr_waddr == CSR12_MCOUNTERINTEN);
assign s0[SEL_MCOUNTERMASK_M] = (csr_waddr == CSR12_MCOUNTERMASK_M) & (NUM_PRIVILEGE_LEVELS > 1);
assign s0[SEL_MCOUNTERMASK_S] = (csr_waddr == CSR12_MCOUNTERMASK_S) & (NUM_PRIVILEGE_LEVELS > 2);
assign s0[SEL_MCOUNTERMASK_U] = (csr_waddr == CSR12_MCOUNTERMASK_U) & (NUM_PRIVILEGE_LEVELS > 1);
assign s0[SEL_MCOUNTEROVF] = (csr_waddr == CSR12_MCOUNTEROVF);
assign s0[SEL_MCOUNTERWEN] = (csr_waddr == CSR12_MCOUNTERWEN) & (NUM_PRIVILEGE_LEVELS > 1);
assign s0[SEL_MCOUNTINHIBIT] = (csr_waddr == CSR12_MCOUNTINHIBIT);
assign s0[SEL_MCYCLE] = (csr_waddr == CSR12_MCYCLE);
assign s0[SEL_MCYCLEH] = (csr_waddr == CSR12_MCYCLEH);
assign s0[SEL_MHPMCOUNTER3] = (csr_waddr == CSR12_MHPMCOUNTER3);
assign s0[SEL_MHPMCOUNTER3H] = (csr_waddr == CSR12_MHPMCOUNTER3H);
assign s0[SEL_MHPMCOUNTER4] = (csr_waddr == CSR12_MHPMCOUNTER4);
assign s0[SEL_MHPMCOUNTER4H] = (csr_waddr == CSR12_MHPMCOUNTER4H);
assign s0[SEL_MHPMCOUNTER5] = (csr_waddr == CSR12_MHPMCOUNTER5);
assign s0[SEL_MHPMCOUNTER5H] = (csr_waddr == CSR12_MHPMCOUNTER5H);
assign s0[SEL_MHPMCOUNTER6] = (csr_waddr == CSR12_MHPMCOUNTER6);
assign s0[SEL_MHPMCOUNTER6H] = (csr_waddr == CSR12_MHPMCOUNTER6H);
assign s0[SEL_MHPMEVENT3] = (csr_waddr == CSR12_MHPMEVENT3);
assign s0[SEL_MHPMEVENT4] = (csr_waddr == CSR12_MHPMEVENT4);
assign s0[SEL_MHPMEVENT5] = (csr_waddr == CSR12_MHPMEVENT5);
assign s0[SEL_MHPMEVENT6] = (csr_waddr == CSR12_MHPMEVENT6);
assign s0[SEL_MINSTRET] = (csr_waddr == CSR12_MINSTRET);
assign s0[SEL_MINSTRETH] = (csr_waddr == CSR12_MINSTRETH);
assign s0[SEL_SCOUNTEREN] = (csr_waddr == CSR12_SCOUNTEREN) & (NUM_PRIVILEGE_LEVELS > 2);
assign s0[SEL_SCOUNTERINTEN] = (csr_waddr == CSR12_SCOUNTERINTEN) & (NUM_PRIVILEGE_LEVELS > 2);
assign s0[SEL_SCOUNTERMASK_M] = (csr_waddr == CSR12_SCOUNTERMASK_M) & (NUM_PRIVILEGE_LEVELS > 2);
assign s0[SEL_SCOUNTERMASK_S] = (csr_waddr == CSR12_SCOUNTERMASK_S) & (NUM_PRIVILEGE_LEVELS > 2);
assign s0[SEL_SCOUNTERMASK_U] = (csr_waddr == CSR12_SCOUNTERMASK_U) & (NUM_PRIVILEGE_LEVELS > 2);
assign s0[SEL_SCOUNTEROVF] = (csr_waddr == CSR12_SCOUNTEROVF) & (NUM_PRIVILEGE_LEVELS > 2);
assign s0[SEL_SCOUNTINHIBIT] = (csr_waddr == CSR12_SCOUNTINHIBIT) & (NUM_PRIVILEGE_LEVELS > 2);
assign s0[SEL_SHPMEVENT3] = (csr_waddr == CSR12_SHPMEVENT3) & (NUM_PRIVILEGE_LEVELS > 2);
assign s0[SEL_SHPMEVENT4] = (csr_waddr == CSR12_SHPMEVENT4) & (NUM_PRIVILEGE_LEVELS > 2);
assign s0[SEL_SHPMEVENT5] = (csr_waddr == CSR12_SHPMEVENT5) & (NUM_PRIVILEGE_LEVELS > 2);
assign s0[SEL_SHPMEVENT6] = (csr_waddr == CSR12_SHPMEVENT6) & (NUM_PRIVILEGE_LEVELS > 2);
wire s1 = csr_we & s0[SEL_CYCLE];
wire s2 = csr_we & s0[SEL_CYCLEH];
wire s3 = csr_we & s0[SEL_HPMCOUNTER3];
wire s4 = csr_we & s0[SEL_HPMCOUNTER3H];
wire s5 = csr_we & s0[SEL_HPMCOUNTER4];
wire s6 = csr_we & s0[SEL_HPMCOUNTER4H];
wire s7 = csr_we & s0[SEL_HPMCOUNTER5];
wire s8 = csr_we & s0[SEL_HPMCOUNTER5H];
wire s9 = csr_we & s0[SEL_HPMCOUNTER6];
wire s10 = csr_we & s0[SEL_HPMCOUNTER6H];
wire s11 = csr_we & s0[SEL_INSTRET];
wire s12 = csr_we & s0[SEL_INSTRETH];
wire s13 = csr_we & s0[SEL_MCOUNTEREN];
wire s14 = csr_we & s0[SEL_MCOUNTERINTEN];
wire s15 = csr_we & s0[SEL_MCOUNTERMASK_M];
wire s16 = csr_we & s0[SEL_MCOUNTERMASK_S];
wire s17 = csr_we & s0[SEL_MCOUNTERMASK_U];
wire s18 = csr_we & s0[SEL_MCOUNTEROVF];
wire s19 = csr_we & s0[SEL_MCOUNTERWEN];
wire s20 = csr_we & s0[SEL_MCOUNTINHIBIT];
wire s21 = csr_we & s0[SEL_MCYCLE];
wire s22 = csr_we & s0[SEL_MCYCLEH];
wire s23 = csr_we & s0[SEL_MHPMCOUNTER3];
wire s24 = csr_we & s0[SEL_MHPMCOUNTER3H];
wire s25 = csr_we & s0[SEL_MHPMCOUNTER4];
wire s26 = csr_we & s0[SEL_MHPMCOUNTER4H];
wire s27 = csr_we & s0[SEL_MHPMCOUNTER5];
wire s28 = csr_we & s0[SEL_MHPMCOUNTER5H];
wire s29 = csr_we & s0[SEL_MHPMCOUNTER6];
wire s30 = csr_we & s0[SEL_MHPMCOUNTER6H];
wire s31 = csr_we & s0[SEL_MHPMEVENT3];
wire s32 = csr_we & s0[SEL_MHPMEVENT4];
wire s33 = csr_we & s0[SEL_MHPMEVENT5];
wire s34 = csr_we & s0[SEL_MHPMEVENT6];
wire s35 = csr_we & s0[SEL_MINSTRET];
wire s36 = csr_we & s0[SEL_MINSTRETH];
wire s37 = csr_we & s0[SEL_SCOUNTEREN];
wire s38 = csr_we & s0[SEL_SCOUNTERINTEN];
wire s39 = csr_we & s0[SEL_SCOUNTERMASK_M];
wire s40 = csr_we & s0[SEL_SCOUNTERMASK_S];
wire s41 = csr_we & s0[SEL_SCOUNTERMASK_U];
wire s42 = csr_we & s0[SEL_SCOUNTEROVF];
wire s43 = csr_we & s0[SEL_SCOUNTINHIBIT];
wire s44 = csr_we & s0[SEL_SHPMEVENT3];
wire s45 = csr_we & s0[SEL_SHPMEVENT4];
wire s46 = csr_we & s0[SEL_SHPMEVENT5];
wire s47 = csr_we & s0[SEL_SHPMEVENT6];
wire [SEL_BITS - 1:0] s48;
wire [SEL_BITS - 1:0] s49;
assign s48[SEL_CYCLE] = (csr_raddr0 == CSR12_CYCLE) & (NUM_PRIVILEGE_LEVELS > 1);
assign s48[SEL_CYCLEH] = (csr_raddr0 == CSR12_CYCLEH) & (NUM_PRIVILEGE_LEVELS > 1);
assign s48[SEL_HPMCOUNTER3] = (csr_raddr0 == CSR12_HPMCOUNTER3) & (NUM_PRIVILEGE_LEVELS > 1);
assign s48[SEL_HPMCOUNTER3H] = (csr_raddr0 == CSR12_HPMCOUNTER3H) & (NUM_PRIVILEGE_LEVELS > 1);
assign s48[SEL_HPMCOUNTER4] = (csr_raddr0 == CSR12_HPMCOUNTER4) & (NUM_PRIVILEGE_LEVELS > 1);
assign s48[SEL_HPMCOUNTER4H] = (csr_raddr0 == CSR12_HPMCOUNTER4H) & (NUM_PRIVILEGE_LEVELS > 1);
assign s48[SEL_HPMCOUNTER5] = (csr_raddr0 == CSR12_HPMCOUNTER5) & (NUM_PRIVILEGE_LEVELS > 1);
assign s48[SEL_HPMCOUNTER5H] = (csr_raddr0 == CSR12_HPMCOUNTER5H) & (NUM_PRIVILEGE_LEVELS > 1);
assign s48[SEL_HPMCOUNTER6] = (csr_raddr0 == CSR12_HPMCOUNTER6) & (NUM_PRIVILEGE_LEVELS > 1);
assign s48[SEL_HPMCOUNTER6H] = (csr_raddr0 == CSR12_HPMCOUNTER6H) & (NUM_PRIVILEGE_LEVELS > 1);
assign s48[SEL_INSTRET] = (csr_raddr0 == CSR12_INSTRET) & (NUM_PRIVILEGE_LEVELS > 1);
assign s48[SEL_INSTRETH] = (csr_raddr0 == CSR12_INSTRETH) & (NUM_PRIVILEGE_LEVELS > 1);
assign s48[SEL_MCOUNTEREN] = (csr_raddr0 == CSR12_MCOUNTEREN) & (NUM_PRIVILEGE_LEVELS > 1);
assign s48[SEL_MCOUNTERINTEN] = (csr_raddr0 == CSR12_MCOUNTERINTEN);
assign s48[SEL_MCOUNTERMASK_M] = (csr_raddr0 == CSR12_MCOUNTERMASK_M) & (NUM_PRIVILEGE_LEVELS > 1);
assign s48[SEL_MCOUNTERMASK_S] = (csr_raddr0 == CSR12_MCOUNTERMASK_S) & (NUM_PRIVILEGE_LEVELS > 2);
assign s48[SEL_MCOUNTERMASK_U] = (csr_raddr0 == CSR12_MCOUNTERMASK_U) & (NUM_PRIVILEGE_LEVELS > 1);
assign s48[SEL_MCOUNTEROVF] = (csr_raddr0 == CSR12_MCOUNTEROVF);
assign s48[SEL_MCOUNTERWEN] = (csr_raddr0 == CSR12_MCOUNTERWEN) & (NUM_PRIVILEGE_LEVELS > 1);
assign s48[SEL_MCOUNTINHIBIT] = (csr_raddr0 == CSR12_MCOUNTINHIBIT);
assign s48[SEL_MCYCLE] = (csr_raddr0 == CSR12_MCYCLE);
assign s48[SEL_MCYCLEH] = (csr_raddr0 == CSR12_MCYCLEH);
assign s48[SEL_MHPMCOUNTER3] = (csr_raddr0 == CSR12_MHPMCOUNTER3);
assign s48[SEL_MHPMCOUNTER3H] = (csr_raddr0 == CSR12_MHPMCOUNTER3H);
assign s48[SEL_MHPMCOUNTER4] = (csr_raddr0 == CSR12_MHPMCOUNTER4);
assign s48[SEL_MHPMCOUNTER4H] = (csr_raddr0 == CSR12_MHPMCOUNTER4H);
assign s48[SEL_MHPMCOUNTER5] = (csr_raddr0 == CSR12_MHPMCOUNTER5);
assign s48[SEL_MHPMCOUNTER5H] = (csr_raddr0 == CSR12_MHPMCOUNTER5H);
assign s48[SEL_MHPMCOUNTER6] = (csr_raddr0 == CSR12_MHPMCOUNTER6);
assign s48[SEL_MHPMCOUNTER6H] = (csr_raddr0 == CSR12_MHPMCOUNTER6H);
assign s48[SEL_MHPMEVENT3] = (csr_raddr0 == CSR12_MHPMEVENT3);
assign s48[SEL_MHPMEVENT4] = (csr_raddr0 == CSR12_MHPMEVENT4);
assign s48[SEL_MHPMEVENT5] = (csr_raddr0 == CSR12_MHPMEVENT5);
assign s48[SEL_MHPMEVENT6] = (csr_raddr0 == CSR12_MHPMEVENT6);
assign s48[SEL_MINSTRET] = (csr_raddr0 == CSR12_MINSTRET);
assign s48[SEL_MINSTRETH] = (csr_raddr0 == CSR12_MINSTRETH);
assign s48[SEL_SCOUNTEREN] = (csr_raddr0 == CSR12_SCOUNTEREN) & (NUM_PRIVILEGE_LEVELS > 2);
assign s48[SEL_SCOUNTERINTEN] = (csr_raddr0 == CSR12_SCOUNTERINTEN) & (NUM_PRIVILEGE_LEVELS > 2);
assign s48[SEL_SCOUNTERMASK_M] = (csr_raddr0 == CSR12_SCOUNTERMASK_M) & (NUM_PRIVILEGE_LEVELS > 2);
assign s48[SEL_SCOUNTERMASK_S] = (csr_raddr0 == CSR12_SCOUNTERMASK_S) & (NUM_PRIVILEGE_LEVELS > 2);
assign s48[SEL_SCOUNTERMASK_U] = (csr_raddr0 == CSR12_SCOUNTERMASK_U) & (NUM_PRIVILEGE_LEVELS > 2);
assign s48[SEL_SCOUNTEROVF] = (csr_raddr0 == CSR12_SCOUNTEROVF) & (NUM_PRIVILEGE_LEVELS > 2);
assign s48[SEL_SCOUNTINHIBIT] = (csr_raddr0 == CSR12_SCOUNTINHIBIT) & (NUM_PRIVILEGE_LEVELS > 2);
assign s48[SEL_SHPMEVENT3] = (csr_raddr0 == CSR12_SHPMEVENT3) & (NUM_PRIVILEGE_LEVELS > 2);
assign s48[SEL_SHPMEVENT4] = (csr_raddr0 == CSR12_SHPMEVENT4) & (NUM_PRIVILEGE_LEVELS > 2);
assign s48[SEL_SHPMEVENT5] = (csr_raddr0 == CSR12_SHPMEVENT5) & (NUM_PRIVILEGE_LEVELS > 2);
assign s48[SEL_SHPMEVENT6] = (csr_raddr0 == CSR12_SHPMEVENT6) & (NUM_PRIVILEGE_LEVELS > 2);
assign csr_rd_hit0 = |s48;
assign s49[SEL_CYCLE] = (csr_raddr1 == CSR12_CYCLE) & (NUM_PRIVILEGE_LEVELS > 1);
assign s49[SEL_CYCLEH] = (csr_raddr1 == CSR12_CYCLEH) & (NUM_PRIVILEGE_LEVELS > 1);
assign s49[SEL_HPMCOUNTER3] = (csr_raddr1 == CSR12_HPMCOUNTER3) & (NUM_PRIVILEGE_LEVELS > 1);
assign s49[SEL_HPMCOUNTER3H] = (csr_raddr1 == CSR12_HPMCOUNTER3H) & (NUM_PRIVILEGE_LEVELS > 1);
assign s49[SEL_HPMCOUNTER4] = (csr_raddr1 == CSR12_HPMCOUNTER4) & (NUM_PRIVILEGE_LEVELS > 1);
assign s49[SEL_HPMCOUNTER4H] = (csr_raddr1 == CSR12_HPMCOUNTER4H) & (NUM_PRIVILEGE_LEVELS > 1);
assign s49[SEL_HPMCOUNTER5] = (csr_raddr1 == CSR12_HPMCOUNTER5) & (NUM_PRIVILEGE_LEVELS > 1);
assign s49[SEL_HPMCOUNTER5H] = (csr_raddr1 == CSR12_HPMCOUNTER5H) & (NUM_PRIVILEGE_LEVELS > 1);
assign s49[SEL_HPMCOUNTER6] = (csr_raddr1 == CSR12_HPMCOUNTER6) & (NUM_PRIVILEGE_LEVELS > 1);
assign s49[SEL_HPMCOUNTER6H] = (csr_raddr1 == CSR12_HPMCOUNTER6H) & (NUM_PRIVILEGE_LEVELS > 1);
assign s49[SEL_INSTRET] = (csr_raddr1 == CSR12_INSTRET) & (NUM_PRIVILEGE_LEVELS > 1);
assign s49[SEL_INSTRETH] = (csr_raddr1 == CSR12_INSTRETH) & (NUM_PRIVILEGE_LEVELS > 1);
assign s49[SEL_MCOUNTEREN] = (csr_raddr1 == CSR12_MCOUNTEREN) & (NUM_PRIVILEGE_LEVELS > 1);
assign s49[SEL_MCOUNTERINTEN] = (csr_raddr1 == CSR12_MCOUNTERINTEN);
assign s49[SEL_MCOUNTERMASK_M] = (csr_raddr1 == CSR12_MCOUNTERMASK_M) & (NUM_PRIVILEGE_LEVELS > 1);
assign s49[SEL_MCOUNTERMASK_S] = (csr_raddr1 == CSR12_MCOUNTERMASK_S) & (NUM_PRIVILEGE_LEVELS > 2);
assign s49[SEL_MCOUNTERMASK_U] = (csr_raddr1 == CSR12_MCOUNTERMASK_U) & (NUM_PRIVILEGE_LEVELS > 1);
assign s49[SEL_MCOUNTEROVF] = (csr_raddr1 == CSR12_MCOUNTEROVF);
assign s49[SEL_MCOUNTERWEN] = (csr_raddr1 == CSR12_MCOUNTERWEN) & (NUM_PRIVILEGE_LEVELS > 1);
assign s49[SEL_MCOUNTINHIBIT] = (csr_raddr1 == CSR12_MCOUNTINHIBIT);
assign s49[SEL_MCYCLE] = (csr_raddr1 == CSR12_MCYCLE);
assign s49[SEL_MCYCLEH] = (csr_raddr1 == CSR12_MCYCLEH);
assign s49[SEL_MHPMCOUNTER3] = (csr_raddr1 == CSR12_MHPMCOUNTER3);
assign s49[SEL_MHPMCOUNTER3H] = (csr_raddr1 == CSR12_MHPMCOUNTER3H);
assign s49[SEL_MHPMCOUNTER4] = (csr_raddr1 == CSR12_MHPMCOUNTER4);
assign s49[SEL_MHPMCOUNTER4H] = (csr_raddr1 == CSR12_MHPMCOUNTER4H);
assign s49[SEL_MHPMCOUNTER5] = (csr_raddr1 == CSR12_MHPMCOUNTER5);
assign s49[SEL_MHPMCOUNTER5H] = (csr_raddr1 == CSR12_MHPMCOUNTER5H);
assign s49[SEL_MHPMCOUNTER6] = (csr_raddr1 == CSR12_MHPMCOUNTER6);
assign s49[SEL_MHPMCOUNTER6H] = (csr_raddr1 == CSR12_MHPMCOUNTER6H);
assign s49[SEL_MHPMEVENT3] = (csr_raddr1 == CSR12_MHPMEVENT3);
assign s49[SEL_MHPMEVENT4] = (csr_raddr1 == CSR12_MHPMEVENT4);
assign s49[SEL_MHPMEVENT5] = (csr_raddr1 == CSR12_MHPMEVENT5);
assign s49[SEL_MHPMEVENT6] = (csr_raddr1 == CSR12_MHPMEVENT6);
assign s49[SEL_MINSTRET] = (csr_raddr1 == CSR12_MINSTRET);
assign s49[SEL_MINSTRETH] = (csr_raddr1 == CSR12_MINSTRETH);
assign s49[SEL_SCOUNTEREN] = (csr_raddr1 == CSR12_SCOUNTEREN) & (NUM_PRIVILEGE_LEVELS > 2);
assign s49[SEL_SCOUNTERINTEN] = (csr_raddr1 == CSR12_SCOUNTERINTEN) & (NUM_PRIVILEGE_LEVELS > 2);
assign s49[SEL_SCOUNTERMASK_M] = (csr_raddr1 == CSR12_SCOUNTERMASK_M) & (NUM_PRIVILEGE_LEVELS > 2);
assign s49[SEL_SCOUNTERMASK_S] = (csr_raddr1 == CSR12_SCOUNTERMASK_S) & (NUM_PRIVILEGE_LEVELS > 2);
assign s49[SEL_SCOUNTERMASK_U] = (csr_raddr1 == CSR12_SCOUNTERMASK_U) & (NUM_PRIVILEGE_LEVELS > 2);
assign s49[SEL_SCOUNTEROVF] = (csr_raddr1 == CSR12_SCOUNTEROVF) & (NUM_PRIVILEGE_LEVELS > 2);
assign s49[SEL_SCOUNTINHIBIT] = (csr_raddr1 == CSR12_SCOUNTINHIBIT) & (NUM_PRIVILEGE_LEVELS > 2);
assign s49[SEL_SHPMEVENT3] = (csr_raddr1 == CSR12_SHPMEVENT3) & (NUM_PRIVILEGE_LEVELS > 2);
assign s49[SEL_SHPMEVENT4] = (csr_raddr1 == CSR12_SHPMEVENT4) & (NUM_PRIVILEGE_LEVELS > 2);
assign s49[SEL_SHPMEVENT5] = (csr_raddr1 == CSR12_SHPMEVENT5) & (NUM_PRIVILEGE_LEVELS > 2);
assign s49[SEL_SHPMEVENT6] = (csr_raddr1 == CSR12_SHPMEVENT6) & (NUM_PRIVILEGE_LEVELS > 2);
assign csr_rd_hit1 = |s49;
wire [31:0] s50;
wire [31:0] s51;
wire [31:0] s52;
wire [31:0] s53;
wire [31:0] s54;
wire [31:0] s55;
wire [31:0] s56;
wire [31:0] s57;
wire [31:0] s58;
wire [31:0] s59;
wire [31:0] s60;
wire [31:0] s61;
wire [31:0] csr_mcounteren;
wire [31:0] s62;
wire [31:0] s63;
wire [31:0] s64;
wire [31:0] s65;
wire [31:0] s66;
wire [31:0] csr_mcounterwen;
wire [31:0] s67;
wire [31:0] s68;
wire [31:0] s69;
wire [31:0] s70;
wire [31:0] s71;
wire [31:0] s72;
wire [31:0] s73;
wire [31:0] s74;
wire [31:0] s75;
wire [31:0] s76;
wire [31:0] s77;
wire [31:0] s78;
wire [31:0] s79;
wire [31:0] s80;
wire [31:0] s81;
wire [31:0] s82;
wire [31:0] s83;
wire [31:0] csr_scounteren;
wire [31:0] s84;
wire [31:0] s85;
wire [31:0] s86;
wire [31:0] s87;
wire [31:0] s88;
wire [31:0] s89;
wire [31:0] s90;
wire [31:0] s91;
wire [31:0] s92;
wire [31:0] s93;
wire s94;
wire s95;
wire s96;
wire s97;
wire s98;
wire s99;
wire s100;
assign csr_mcounteren = {{25{1'b0}},s100,s99,s98,s97,s96,s95,s94};
wire s101;
wire s102;
wire s103;
wire s104;
wire s105;
wire s106;
assign csr_mcounterwen = {{25{1'b0}},s106,s105,s104,s103,s102,1'b0,s101};
wire s107;
wire s108;
wire s109;
wire s110;
wire s111;
wire s112;
assign s63 = {{25{1'b0}},s112,s111,s110,s109,s108,1'b0,s107};
wire s113;
wire s114;
wire s115;
wire s116;
wire s117;
wire s118;
assign s64 = {{25{1'b0}},s118,s117,s116,s115,s114,1'b0,s113};
wire s119;
wire s120;
wire s121;
wire s122;
wire s123;
wire s124;
assign s65 = {{25{1'b0}},s124,s123,s122,s121,s120,1'b0,s119};
wire s125;
wire s126;
wire s127;
wire s128;
wire s129;
wire s130;
assign s62 = {{25{1'b0}},s130,s129,s128,s127,s126,1'b0,s125};
wire s131;
wire s132;
wire s133;
wire s134;
wire s135;
wire s136;
assign s66 = {{25{1'b0}},s136,s135,s134,s133,s132,1'b0,s131};
wire s137;
wire s138;
wire s139;
wire s140;
wire s141;
wire s142;
assign s67 = {{25{1'b0}},s142,s141,s140,s139,s138,1'b0,s137};
wire s143;
wire s144;
wire s145;
wire s146;
wire s147;
wire s148;
wire s149;
assign csr_scounteren = {{25{1'b0}},s149,s148,s147,s146,s145,s144,s143};
assign s85 = {{25{1'b0}},s112,s111,s110,s109,s108,1'b0,s107};
assign s86 = {{25{1'b0}},s118,s117,s116,s115,s114,1'b0,s113};
assign s87 = {{25{1'b0}},s124,s123,s122,s121,s120,1'b0,s119};
assign csr_rdata0 = {32{1'b0}} | ({32{s48[SEL_CYCLE]}} & s50) | ({32{s48[SEL_CYCLEH]}} & s51) | ({32{s48[SEL_HPMCOUNTER3]}} & s52) | ({32{s48[SEL_HPMCOUNTER3H]}} & s53) | ({32{s48[SEL_HPMCOUNTER4]}} & s54) | ({32{s48[SEL_HPMCOUNTER4H]}} & s55) | ({32{s48[SEL_HPMCOUNTER5]}} & s56) | ({32{s48[SEL_HPMCOUNTER5H]}} & s57) | ({32{s48[SEL_HPMCOUNTER6]}} & s58) | ({32{s48[SEL_HPMCOUNTER6H]}} & s59) | ({32{s48[SEL_INSTRET]}} & s60) | ({32{s48[SEL_INSTRETH]}} & s61) | ({32{s48[SEL_MCOUNTEREN]}} & csr_mcounteren) | ({32{s48[SEL_MCOUNTERINTEN]}} & s62) | ({32{s48[SEL_MCOUNTERMASK_M]}} & s63) | ({32{s48[SEL_MCOUNTERMASK_S]}} & s64) | ({32{s48[SEL_MCOUNTERMASK_U]}} & s65) | ({32{s48[SEL_MCOUNTEROVF]}} & s66) | ({32{s48[SEL_MCOUNTERWEN]}} & csr_mcounterwen) | ({32{s48[SEL_MCOUNTINHIBIT]}} & s67) | ({32{s48[SEL_MCYCLE]}} & s68) | ({32{s48[SEL_MCYCLEH]}} & s69) | ({32{s48[SEL_MHPMCOUNTER3]}} & s70) | ({32{s48[SEL_MHPMCOUNTER3H]}} & s71) | ({32{s48[SEL_MHPMCOUNTER4]}} & s72) | ({32{s48[SEL_MHPMCOUNTER4H]}} & s73) | ({32{s48[SEL_MHPMCOUNTER5]}} & s74) | ({32{s48[SEL_MHPMCOUNTER5H]}} & s75) | ({32{s48[SEL_MHPMCOUNTER6]}} & s76) | ({32{s48[SEL_MHPMCOUNTER6H]}} & s77) | ({32{s48[SEL_MHPMEVENT3]}} & s78) | ({32{s48[SEL_MHPMEVENT4]}} & s79) | ({32{s48[SEL_MHPMEVENT5]}} & s80) | ({32{s48[SEL_MHPMEVENT6]}} & s81) | ({32{s48[SEL_MINSTRET]}} & s82) | ({32{s48[SEL_MINSTRETH]}} & s83) | ({32{s48[SEL_SCOUNTEREN]}} & csr_scounteren) | ({32{s48[SEL_SCOUNTERINTEN]}} & s84) | ({32{s48[SEL_SCOUNTERMASK_M]}} & s85) | ({32{s48[SEL_SCOUNTERMASK_S]}} & s86) | ({32{s48[SEL_SCOUNTERMASK_U]}} & s87) | ({32{s48[SEL_SCOUNTEROVF]}} & s88) | ({32{s48[SEL_SCOUNTINHIBIT]}} & s89) | ({32{s48[SEL_SHPMEVENT3]}} & s90) | ({32{s48[SEL_SHPMEVENT4]}} & s91) | ({32{s48[SEL_SHPMEVENT5]}} & s92) | ({32{s48[SEL_SHPMEVENT6]}} & s93);
assign csr_rdata1 = {32{1'b0}} | ({32{s49[SEL_CYCLE]}} & s50) | ({32{s49[SEL_CYCLEH]}} & s51) | ({32{s49[SEL_HPMCOUNTER3]}} & s52) | ({32{s49[SEL_HPMCOUNTER3H]}} & s53) | ({32{s49[SEL_HPMCOUNTER4]}} & s54) | ({32{s49[SEL_HPMCOUNTER4H]}} & s55) | ({32{s49[SEL_HPMCOUNTER5]}} & s56) | ({32{s49[SEL_HPMCOUNTER5H]}} & s57) | ({32{s49[SEL_HPMCOUNTER6]}} & s58) | ({32{s49[SEL_HPMCOUNTER6H]}} & s59) | ({32{s49[SEL_INSTRET]}} & s60) | ({32{s49[SEL_INSTRETH]}} & s61) | ({32{s49[SEL_MCOUNTEREN]}} & csr_mcounteren) | ({32{s49[SEL_MCOUNTERINTEN]}} & s62) | ({32{s49[SEL_MCOUNTERMASK_M]}} & s63) | ({32{s49[SEL_MCOUNTERMASK_S]}} & s64) | ({32{s49[SEL_MCOUNTERMASK_U]}} & s65) | ({32{s49[SEL_MCOUNTEROVF]}} & s66) | ({32{s49[SEL_MCOUNTERWEN]}} & csr_mcounterwen) | ({32{s49[SEL_MCOUNTINHIBIT]}} & s67) | ({32{s49[SEL_MCYCLE]}} & s68) | ({32{s49[SEL_MCYCLEH]}} & s69) | ({32{s49[SEL_MHPMCOUNTER3]}} & s70) | ({32{s49[SEL_MHPMCOUNTER3H]}} & s71) | ({32{s49[SEL_MHPMCOUNTER4]}} & s72) | ({32{s49[SEL_MHPMCOUNTER4H]}} & s73) | ({32{s49[SEL_MHPMCOUNTER5]}} & s74) | ({32{s49[SEL_MHPMCOUNTER5H]}} & s75) | ({32{s49[SEL_MHPMCOUNTER6]}} & s76) | ({32{s49[SEL_MHPMCOUNTER6H]}} & s77) | ({32{s49[SEL_MHPMEVENT3]}} & s78) | ({32{s49[SEL_MHPMEVENT4]}} & s79) | ({32{s49[SEL_MHPMEVENT5]}} & s80) | ({32{s49[SEL_MHPMEVENT6]}} & s81) | ({32{s49[SEL_MINSTRET]}} & s82) | ({32{s49[SEL_MINSTRETH]}} & s83) | ({32{s49[SEL_SCOUNTEREN]}} & csr_scounteren) | ({32{s49[SEL_SCOUNTERINTEN]}} & s84) | ({32{s49[SEL_SCOUNTERMASK_M]}} & s85) | ({32{s49[SEL_SCOUNTERMASK_S]}} & s86) | ({32{s49[SEL_SCOUNTERMASK_U]}} & s87) | ({32{s49[SEL_SCOUNTEROVF]}} & s88) | ({32{s49[SEL_SCOUNTINHIBIT]}} & s89) | ({32{s49[SEL_SHPMEVENT3]}} & s90) | ({32{s49[SEL_SHPMEVENT4]}} & s91) | ({32{s49[SEL_SHPMEVENT5]}} & s92) | ({32{s49[SEL_SHPMEVENT6]}} & s93);
assign s50 = s68;
assign s51 = s69;
assign s52 = s70;
assign s53 = s71;
assign s54 = s72;
assign s55 = s73;
assign s56 = s74;
assign s57 = s75;
assign s58 = s76;
assign s59 = s77;
assign s60 = s82;
assign s61 = s83;
assign s84 = s62;
assign s88 = s66;
assign s89 = s67;
assign s90 = s78;
assign s91 = s79;
assign s92 = s80;
assign s93 = s81;
generate
    if ((PERFORMANCE_MONITOR_INT == 1) && (NUM_PRIVILEGE_LEVELS > 1)) begin:gen_csr_mcounteren_yes
        reg s150;
        reg s151;
        reg s152;
        reg s153;
        reg s154;
        reg s155;
        reg s156;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s150 <= 1'b0;
                s151 <= 1'b0;
                s152 <= 1'b0;
                s153 <= 1'b0;
                s154 <= 1'b0;
                s155 <= 1'b0;
                s156 <= 1'b0;
            end
            else if (s13) begin
                s150 <= csr_wdata[0];
                s151 <= csr_wdata[1];
                s152 <= csr_wdata[2];
                s153 <= csr_wdata[3];
                s154 <= csr_wdata[4];
                s155 <= csr_wdata[5];
                s156 <= csr_wdata[6];
            end
        end

        assign s94 = s150;
        assign s95 = s151;
        assign s96 = s152;
        assign s97 = s153;
        assign s98 = s154;
        assign s99 = s155;
        assign s100 = s156;
    end
    else begin:gen_csr_mcounteren_no
        assign s94 = 1'b0;
        assign s95 = 1'b0;
        assign s96 = 1'b0;
        assign s97 = 1'b0;
        assign s98 = 1'b0;
        assign s99 = 1'b0;
        assign s100 = 1'b0;
        wire nds_unused_csr_mcounteren_we = s13;
    end
endgenerate
generate
    if ((PERFORMANCE_MONITOR_INT == 1) && (NUM_PRIVILEGE_LEVELS > 1)) begin:gen_csr_mcounter_yes
        reg s157;
        reg s158;
        reg s159;
        reg s160;
        reg s161;
        reg s162;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s157 <= 1'b0;
                s158 <= 1'b0;
                s159 <= 1'b0;
                s160 <= 1'b0;
                s161 <= 1'b0;
                s162 <= 1'b0;
            end
            else if (s19) begin
                s157 <= csr_wdata[0];
                s158 <= csr_wdata[2];
                s159 <= csr_wdata[3];
                s160 <= csr_wdata[4];
                s161 <= csr_wdata[5];
                s162 <= csr_wdata[6];
            end
        end

        assign s101 = s157;
        assign s102 = s158;
        assign s103 = s159;
        assign s104 = s160;
        assign s105 = s161;
        assign s106 = s162;
        reg s163;
        reg s164;
        reg s165;
        reg s166;
        reg s167;
        reg s168;
        wire s169 = s15 | (s39 & s101);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s163 <= 1'b0;
            end
            else if (s169) begin
                s163 <= csr_wdata[0];
            end
        end

        wire s170 = s15 | (s39 & s102);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s164 <= 1'b0;
            end
            else if (s170) begin
                s164 <= csr_wdata[2];
            end
        end

        wire s171 = s15 | (s39 & s103);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s165 <= 1'b0;
            end
            else if (s171) begin
                s165 <= csr_wdata[3];
            end
        end

        wire s172 = s15 | (s39 & s104);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s166 <= 1'b0;
            end
            else if (s172) begin
                s166 <= csr_wdata[4];
            end
        end

        wire s173 = s15 | (s39 & s105);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s167 <= 1'b0;
            end
            else if (s173) begin
                s167 <= csr_wdata[5];
            end
        end

        wire s174 = s15 | (s39 & s106);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s168 <= 1'b0;
            end
            else if (s174) begin
                s168 <= csr_wdata[6];
            end
        end

        assign s107 = s163;
        assign s108 = s164;
        assign s109 = s165;
        assign s110 = s166;
        assign s111 = s167;
        assign s112 = s168;
        if (NUM_PRIVILEGE_LEVELS > 2) begin:gen_reg_csr_mcountermask_s
            reg s175;
            reg s176;
            reg s177;
            reg s178;
            reg s179;
            reg s180;
            wire s181 = s16 | (s40 & s101);
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s175 <= 1'b0;
                end
                else if (s181) begin
                    s175 <= csr_wdata[0];
                end
            end

            wire s182 = s16 | (s40 & s102);
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s176 <= 1'b0;
                end
                else if (s182) begin
                    s176 <= csr_wdata[2];
                end
            end

            wire s183 = s16 | (s40 & s103);
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s177 <= 1'b0;
                end
                else if (s183) begin
                    s177 <= csr_wdata[3];
                end
            end

            wire s184 = s16 | (s40 & s104);
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s178 <= 1'b0;
                end
                else if (s184) begin
                    s178 <= csr_wdata[4];
                end
            end

            wire s185 = s16 | (s40 & s105);
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s179 <= 1'b0;
                end
                else if (s185) begin
                    s179 <= csr_wdata[5];
                end
            end

            wire s186 = s16 | (s40 & s106);
            always @(posedge core_clk or negedge core_reset_n) begin
                if (!core_reset_n) begin
                    s180 <= 1'b0;
                end
                else if (s186) begin
                    s180 <= csr_wdata[6];
                end
            end

            assign s113 = s175;
            assign s114 = s176;
            assign s115 = s177;
            assign s116 = s178;
            assign s117 = s179;
            assign s118 = s180;
        end
        else begin:gen_no_reg_csr_mcountermask_s
            assign s113 = 1'b0;
            assign s114 = 1'b0;
            assign s115 = 1'b0;
            assign s116 = 1'b0;
            assign s117 = 1'b0;
            assign s118 = 1'b0;
            wire nds_unused_csr_mcountermask_s_we = s16;
            wire nds_unused_csr_scountermask_s_we = s40;
        end
        reg s187;
        reg s188;
        reg s189;
        reg s190;
        reg s191;
        reg s192;
        wire s193 = s17 | (s41 & s101);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s187 <= 1'b0;
            end
            else if (s193) begin
                s187 <= csr_wdata[0];
            end
        end

        wire s194 = s17 | (s41 & s102);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s188 <= 1'b0;
            end
            else if (s194) begin
                s188 <= csr_wdata[2];
            end
        end

        wire s195 = s17 | (s41 & s103);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s189 <= 1'b0;
            end
            else if (s195) begin
                s189 <= csr_wdata[3];
            end
        end

        wire s196 = s17 | (s41 & s104);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s190 <= 1'b0;
            end
            else if (s196) begin
                s190 <= csr_wdata[4];
            end
        end

        wire s197 = s17 | (s41 & s105);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s191 <= 1'b0;
            end
            else if (s197) begin
                s191 <= csr_wdata[5];
            end
        end

        wire s198 = s17 | (s41 & s106);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s192 <= 1'b0;
            end
            else if (s198) begin
                s192 <= csr_wdata[6];
            end
        end

        assign s119 = s187;
        assign s120 = s188;
        assign s121 = s189;
        assign s122 = s190;
        assign s123 = s191;
        assign s124 = s192;
    end
    else begin:gen_csr_mcounter_no
        assign s101 = 1'b0;
        assign s102 = 1'b0;
        assign s103 = 1'b0;
        assign s104 = 1'b0;
        assign s105 = 1'b0;
        assign s106 = 1'b0;
        assign s107 = 1'b0;
        assign s108 = 1'b0;
        assign s109 = 1'b0;
        assign s110 = 1'b0;
        assign s111 = 1'b0;
        assign s112 = 1'b0;
        assign s113 = 1'b0;
        assign s114 = 1'b0;
        assign s115 = 1'b0;
        assign s116 = 1'b0;
        assign s117 = 1'b0;
        assign s118 = 1'b0;
        assign s119 = 1'b0;
        assign s120 = 1'b0;
        assign s121 = 1'b0;
        assign s122 = 1'b0;
        assign s123 = 1'b0;
        assign s124 = 1'b0;
        wire nds_unused_csr_scountermask_m_we = s39;
        wire nds_unused_csr_mcountermask_s_we = s16;
        wire nds_unused_csr_mcountermask_u_we = s17;
        wire nds_unused_csr_mcounterwen_we = s19;
        wire nds_unused_csr_scountermask_u_we = s41;
        wire nds_unused_csr_mcountermask_m_we = s15;
        wire nds_unused_csr_scountermask_s_we = s40;
    end
endgenerate
generate
    if ((PERFORMANCE_MONITOR_INT == 1) && (NUM_PRIVILEGE_LEVELS > 2)) begin:gen_csr_scounteren_yes
        reg s199;
        reg s200;
        reg s201;
        reg s202;
        reg s203;
        reg s204;
        reg s205;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s199 <= 1'b0;
                s200 <= 1'b0;
                s201 <= 1'b0;
                s202 <= 1'b0;
                s203 <= 1'b0;
                s204 <= 1'b0;
                s205 <= 1'b0;
            end
            else if (s37) begin
                s199 <= csr_wdata[0];
                s200 <= csr_wdata[1];
                s201 <= csr_wdata[2];
                s202 <= csr_wdata[3];
                s203 <= csr_wdata[4];
                s204 <= csr_wdata[5];
                s205 <= csr_wdata[6];
            end
        end

        assign s143 = s199;
        assign s144 = s200;
        assign s145 = s201;
        assign s146 = s202;
        assign s147 = s203;
        assign s148 = s204;
        assign s149 = s205;
    end
    else begin:gen_csr_scounteren_no
        assign s143 = 1'b0;
        assign s144 = 1'b0;
        assign s145 = 1'b0;
        assign s146 = 1'b0;
        assign s147 = 1'b0;
        assign s148 = 1'b0;
        assign s149 = 1'b0;
        wire nds_unused_csr_scounteren_we = s37;
    end
endgenerate
generate
    if (PERFORMANCE_MONITOR_INT == 1) begin:gen_performance_monitor_regs
        wire s206 = |ipipe_csr_pfm_inst_retire;
        reg [63:0] s207;
        wire s208;
        wire [63:0] s209;
        wire s210;
        wire s211;
        wire [63:0] s212 = s207 + 64'd1;
        wire [63:0] s213 = {32'd0,s207[63:32]};
        reg [63:0] s214;
        wire s215;
        wire [63:0] s216;
        wire s217;
        wire s218;
        wire [63:0] s219 = {32'd0,s214[63:32]};
        wire [1:0] s220 = {wb_i1_instr_event[17],wb_i0_instr_event[17]};
        wire [1:0] s221 = {(wb_i1_instr_event[0] & wb_i1_instr_event[17] & ~wb_i1_instr_event[18]),(wb_i0_instr_event[0] & wb_i0_instr_event[17] & ~wb_i0_instr_event[18])};
        wire [1:0] s222 = s220 | s221;
        wire [63:0] s223 = s214 + {61'b0,&s222,^s222 | &ipipe_csr_pfm_inst_retire,^ipipe_csr_pfm_inst_retire};
        wire s224 = hint_event[27] ^ hint_event[28];
        wire s225 = hint_event[29] ^ hint_event[30];
        wire [3:0] s226 = {hint_event[30],hint_event[29],hint_event[28],hint_event[27]};
        wire s227 = s224 ^ s225;
        wire s228 = ~(s226 == 4'b0000) & ~(s226 == 4'b0001) & ~(s226 == 4'b0010) & ~(s226 == 4'b0100) & ~(s226 == 4'b1000);
        wire s229 = &s226;
        reg [8:0] s230;
        wire s231;
        wire [1:0] s232;
        wire [1:0] s233;
        wire s234;
        reg [63:0] s235;
        wire [63:0] s236;
        wire s237;
        wire s238;
        wire [1:0] s239 = ~s233 & s232;
        wire [1:0] s240 = s233;
        wire s241 = (s230 == {5'd1,4'd1});
        wire [3:0] s242;
        wire s243 = s241 & s227;
        wire s244 = s241 & s228;
        wire s245 = s241 & s229;
        wire s246 = s234 ? s242[3] : 1'b0;
        wire s247 = s234 ? s242[2] : (s245 | (&s240));
        wire s248 = s234 ? s242[1] : (^s240 | &s239 | s244);
        wire s249 = s234 ? s242[0] : ((^s239) | s243);
        wire [63:0] s250 = s235 + {60'b0,s246,s247,s248,s249};
        wire [63:0] s251 = {32'd0,s235[63:32]};
        reg [8:0] s252;
        wire s253;
        wire [1:0] s254;
        wire [1:0] s255;
        wire s256;
        reg [63:0] s257;
        wire [63:0] s258;
        wire s259;
        wire s260;
        wire [1:0] s261 = ~s255 & s254;
        wire [1:0] s262 = s255;
        wire s263 = (s252 == {5'd1,4'd1});
        wire [3:0] s264;
        wire s265 = s263 & s227;
        wire s266 = s263 & s228;
        wire s267 = s263 & s229;
        wire s268 = s256 ? s264[3] : 1'b0;
        wire s269 = s256 ? s264[2] : (s267 | (&s262));
        wire s270 = s256 ? s264[1] : (^s262 | &s261 | s266);
        wire s271 = s256 ? s264[0] : ((^s261) | s265);
        wire [63:0] s272 = s257 + {60'b0,s268,s269,s270,s271};
        wire [63:0] s273 = {32'd0,s257[63:32]};
        reg [8:0] s274;
        wire s275;
        wire [1:0] s276;
        wire [1:0] s277;
        wire s278;
        reg [63:0] s279;
        wire [63:0] s280;
        wire s281;
        wire s282;
        wire [1:0] s283 = ~s277 & s276;
        wire [1:0] s284 = s277;
        wire s285 = (s274 == {5'd1,4'd1});
        wire [3:0] s286;
        wire s287 = s285 & s227;
        wire s288 = s285 & s228;
        wire s289 = s285 & s229;
        wire s290 = s278 ? s286[3] : 1'b0;
        wire s291 = s278 ? s286[2] : (s289 | (&s284));
        wire s292 = s278 ? s286[1] : (^s284 | &s283 | s288);
        wire s293 = s278 ? s286[0] : ((^s283) | s287);
        wire [63:0] s294 = s279 + {60'b0,s290,s291,s292,s293};
        wire [63:0] s295 = {32'd0,s279[63:32]};
        reg [8:0] s296;
        wire s297;
        wire [1:0] s298;
        wire [1:0] s299;
        wire s300;
        reg [63:0] s301;
        wire [63:0] s302;
        wire s303;
        wire s304;
        wire [1:0] s305 = ~s299 & s298;
        wire [1:0] s306 = s299;
        wire s307 = (s296 == {5'd1,4'd1});
        wire [3:0] s308;
        wire s309 = s307 & s227;
        wire s310 = s307 & s228;
        wire s311 = s307 & s229;
        wire s312 = s300 ? s308[3] : 1'b0;
        wire s313 = s300 ? s308[2] : (s311 | (&s306));
        wire s314 = s300 ? s308[1] : (^s306 | &s305 | s310);
        wire s315 = s300 ? s308[0] : ((^s305) | s309);
        wire [63:0] s316 = s301 + {60'b0,s312,s313,s314,s315};
        wire [63:0] s317 = {32'd0,s301[63:32]};
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s207 <= 64'd0;
            end
            else if (s210) begin
                s207 <= s209;
            end
        end

        assign s208 = ~s211 & ~(s21 | s22 | s1 | s2) & (&s207);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s214 <= 64'd0;
            end
            else if (s217) begin
                s214 <= s216;
            end
        end

        assign s215 = (s206 & ~s218) & ~(s35 | s36 | s11 | s12) & (&s214[63:3]) & (((&s222) & s214[2]) | (((^s222) & (^ipipe_csr_pfm_inst_retire)) & s214[2] & (|s214[1:0])) | (((^s222) | (&ipipe_csr_pfm_inst_retire)) & (&s214[2:1])) | ((|ipipe_csr_pfm_inst_retire) & (&s214[2:0])));
        assign s209[31:0] = (s21 | s1) ? csr_wdata[31:0] : (s211 ? s207[31:0] : s212[31:0]);
        assign s209[63:32] = ((s22) | s2) ? csr_wdata[31:0] : (s211 ? s207[63:32] : s212[63:32]);
        assign s211 = (csr_halt_mode & csr_dcsr_stopcount) | (cur_privilege_m & s107) | (cur_privilege_s & s113) | (cur_privilege_u & s119) | s137 | (s21 | s22 | s1 | s2);
        assign s210 = s21 | s22 | s1 | s2 | ~s211;
        assign s218 = (csr_halt_mode & csr_dcsr_stopcount) | (cur_privilege_m & s108) | (cur_privilege_s & s114) | (cur_privilege_u & s120) | s138 | (s35 | s36 | s11 | s12);
        assign s217 = s35 | s36 | s11 | s12 | (s206 & ~s218);
        assign s216[31:0] = (s35 | s11) ? csr_wdata[31:0] : (s218 ? s214[31:0] : s223[31:0]);
        assign s216[63:32] = ((s36) | s12) ? csr_wdata[31:0] : (s218 ? s214[63:32] : s223[63:32]);
        assign s237 = (csr_halt_mode & csr_dcsr_stopcount) | (cur_privilege_m & s109) | (cur_privilege_s & s115) | (cur_privilege_u & s121) | s139 | (s23 | s24 | s3 | s4);
        assign s231 = (~s237) & (&s235[63:3]) & ((s247 & s235[2]) | (s248 & s249 & s235[2] & (|s235[1:0])) | (s248 & ~s249 & (&s235[2:1])) | (s249 & (&s235[2:0])));
        assign s238 = (|s232 & ~s237) | s23 | s24 | s3 | s4;
        assign s236[31:0] = (s23 | s3) ? csr_wdata[31:0] : (s237 ? s235[31:0] : s250[31:0]);
        assign s236[63:32] = ((s24 | s4)) ? csr_wdata[31:0] : (s237 ? s235[63:32] : s250[63:32]);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s235 <= 64'b0;
            end
            else if (s238) begin
                s235 <= s236;
            end
        end

        wire s318 = s31 | (s44 & s103);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s230 <= 9'b0;
            end
            else if (s318) begin
                s230 <= csr_wdata[8:0];
            end
        end

        assign s71 = s251[31:0];
        assign s70 = s235[31:0];
        assign s78 = {{23{1'b0}},s230};
        assign s232 = (({2{(s230 == {5'd1,4'd0})}} & 2'b01)) | ({2{(s230 == {5'd2,4'd0})}} & ipipe_csr_pfm_inst_retire) | ({2{(s230 == {5'd3,4'd0})}} & {wb_i1_instr_event[21],wb_i0_instr_event[21]}) | ({2{(s230 == {5'd4,4'd0})}} & {wb_i1_instr_event[39],wb_i0_instr_event[39]}) | ({2{(s230 == {5'd5,4'd0})}} & {wb_i1_instr_event[1],wb_i0_instr_event[1]}) | ({2{(s230 == {5'd6,4'd0})}} & {wb_i1_instr_event[40],wb_i0_instr_event[40]}) | ({2{(s230 == {5'd7,4'd0})}} & {wb_i1_instr_event[0],wb_i0_instr_event[0]}) | ({2{(s230 == {5'd8,4'd0})}} & {wb_i1_instr_event[2],wb_i0_instr_event[2]}) | ({2{(s230 == {5'd9,4'd0})}} & {wb_i1_instr_event[4],wb_i0_instr_event[4]}) | ({2{(s230 == {5'd10,4'd0})}} & {wb_i1_instr_event[19],wb_i0_instr_event[19]}) | ({2{(s230 == {5'd11,4'd0})}} & {wb_i1_instr_event[20],wb_i0_instr_event[20]}) | ({2{(s230 == {5'd12,4'd0})}} & {wb_i1_instr_event[37],wb_i0_instr_event[37]}) | ({2{(s230 == {5'd13,4'd0})}} & {wb_i1_instr_event[6],wb_i0_instr_event[6]}) | ({2{(s230 == {5'd14,4'd0})}} & {wb_i1_instr_event[9],wb_i0_instr_event[9]}) | ({2{(s230 == {5'd15,4'd0})}} & {wb_i1_instr_event[24],wb_i0_instr_event[24]}) | ({2{(s230 == {5'd24,4'd0})}} & {wb_i1_instr_event[23],wb_i0_instr_event[23]}) | ({2{(s230 == {5'd16,4'd0})}} & {wb_i1_instr_event[8],wb_i0_instr_event[8]}) | ({2{(s230 == {5'd17,4'd0})}} & {wb_i1_instr_event[13],wb_i0_instr_event[13]}) | ({2{(s230 == {5'd18,4'd0})}} & {wb_i1_instr_event[16],wb_i0_instr_event[16]}) | ({2{(s230 == {5'd19,4'd0})}} & {wb_i1_instr_event[10],wb_i0_instr_event[10]}) | ({2{(s230 == {5'd20,4'd0})}} & {wb_i1_instr_event[14],wb_i0_instr_event[14]}) | ({2{(s230 == {5'd21,4'd0})}} & {wb_i1_instr_event[12],wb_i0_instr_event[12]}) | ({2{(s230 == {5'd22,4'd0})}} & {wb_i1_instr_event[11],wb_i0_instr_event[11]}) | ({2{(s230 == {5'd23,4'd0})}} & {wb_i1_instr_event[15],wb_i0_instr_event[15]}) | ({2{(s230 == {5'd25,4'd0})}} & ipipe_csr_pfm_inst_retire) | ({2{(s230 == {5'd26,4'd0})}} & {wb_i1_instr_event[36],wb_i0_instr_event[36]}) | ({2{(s230 == {5'd27,4'd0})}} & {wb_i1_instr_event[25],wb_i0_instr_event[25]}) | ({2{(s230 == {5'd28,4'd0})}} & {wb_i1_instr_event[26],wb_i0_instr_event[26]}) | ({2{(s230 == {5'd0,4'd1})}} & {1'b0,hint_event[37]}) | ({2{(s230 == {5'd1,4'd1})}} & {1'b0,hint_event[27]}) | ({2{(s230 == {5'd1,4'd1})}} & {1'b0,hint_event[28]}) | ({2{(s230 == {5'd1,4'd1})}} & {1'b0,hint_event[29]}) | ({2{(s230 == {5'd1,4'd1})}} & {1'b0,hint_event[30]}) | ({2{(s230 == {5'd2,4'd1})}} & {1'b0,hint_event[32]}) | ({2{(s230 == {5'd3,4'd1})}} & {1'b0,hint_event[34]}) | ({2{(s230 == {5'd4,4'd1})}} & {1'b0,hint_event[19]}) | ({2{(s230 == {5'd5,4'd1})}} & {1'b0,hint_event[22]}) | ({2{(s230 == {5'd6,4'd1})}} & {1'b0,hint_event[20]}) | ({2{(s230 == {5'd7,4'd1})}} & {1'b0,hint_event[21]}) | ({2{(s230 == {5'd8,4'd1})}} & {1'b0,hint_event[24]}) | ({2{(s230 == {5'd9,4'd1})}} & {1'b0,hint_event[25]}) | ({2{(s230 == {5'd11,4'd1})}} & {1'b0,hint_event[33]}) | ({2{(s230 == {5'd12,4'd1})}} & {1'b0,hint_event[23]}) | ({2{(s230 == {5'd13,4'd1})}} & {1'b0,hint_event[35]}) | ({2{(s230 == {5'd14,4'd1})}} & {1'b0,hint_event[17]}) | ({2{(s230 == {5'd15,4'd1})}} & {1'b0,hint_event[36]}) | ({2{(s230 == {5'd16,4'd1})}} & {1'b0,hint_event[18]}) | ({2{(s230 == {5'd17,4'd1})}} & {1'b0,hint_event[41]}) | ({2{(s230 == {5'd18,4'd1})}} & {1'b0,hint_event[42]}) | ({2{(s230 == {5'd19,4'd1})}} & {1'b0,hint_event[38]}) | ({2{(s230 == {5'd20,4'd1})}} & {1'b0,hint_event[39]}) | ({2{(s230 == {5'd21,4'd1})}} & {1'b0,hint_event[43]}) | ({2{(s230 == {5'd22,4'd1})}} & {1'b0,hint_event[40]}) | ({2{(s230 == {5'd23,4'd1})}} & {1'b0,hint_event[31]}) | ({2{(s230 == {5'd24,4'd1})}} & {1'b0,hint_event[16]}) | ({2{(s230 == {5'd10,4'd1})}} & {1'b0,hint_event[26]}) | ({2{(s230 == {5'd0,4'd3})}} & {1'b0,hint_event[0]}) | ({2{(s230 == {5'd1,4'd3})}} & {1'b0,hint_event[2]}) | ({2{(s230 == {5'd2,4'd3})}} & {1'b0,hint_event[4]}) | ({2{(s230 == {5'd3,4'd3})}} & {1'b0,hint_event[6]}) | ({2{(s230 == {5'd4,4'd3})}} & {1'b0,hint_event[8]}) | ({2{(s230 == {5'd5,4'd3})}} & {1'b0,hint_event[10]}) | ({2{(s230 == {5'd6,4'd3})}} & {1'b0,hint_event[12]}) | ({2{(s230 == {5'd7,4'd3})}} & {1'b0,hint_event[14]}) | ({2{(s230 == {5'd0,4'd4})}} & {1'b0,hint_event[1]}) | ({2{(s230 == {5'd1,4'd4})}} & {1'b0,hint_event[3]}) | ({2{(s230 == {5'd2,4'd4})}} & {1'b0,hint_event[5]}) | ({2{(s230 == {5'd3,4'd4})}} & {1'b0,hint_event[7]}) | ({2{(s230 == {5'd4,4'd4})}} & {1'b0,hint_event[9]}) | ({2{(s230 == {5'd5,4'd4})}} & {1'b0,hint_event[11]}) | ({2{(s230 == {5'd6,4'd4})}} & {1'b0,hint_event[13]}) | ({2{(s230 == {5'd7,4'd4})}} & {1'b0,hint_event[15]}) | ({2{(s230 == {5'd0,4'd2})}} & {wb_i1_instr_event[3],wb_i0_instr_event[3]}) | ({2{(s230 == {5'd1,4'd2})}} & {wb_i1_instr_event[5],wb_i0_instr_event[5]}) | ({2{(s230 == {5'd2,4'd2})}} & {wb_i1_instr_event[38],wb_i0_instr_event[38]}) | ({2{(s230 == {5'd3,4'd2})}} & {wb_i1_instr_event[22],wb_i0_instr_event[22]});
        assign s233 = (({2{(s230 == {5'd2,4'd0})}} & s220)) | ({2{(s230 == {5'd7,4'd0})}} & s221) | ({2{(s230 == {5'd25,4'd0})}} & {wb_i1_instr_event[12],wb_i0_instr_event[12]});
        assign s234 = (((s230 == {5'd3,4'd0}) & wb_i0_instr_event[25])) | ((s230 == {5'd3,4'd0}) & wb_i0_instr_event[26]) | ((s230 == {5'd4,4'd0}) & wb_i0_instr_event[36]) | ((s230 == {5'd25,4'd0}) & wb_i0_instr_event[27]);
        assign s242 = (({4{(s230 == {5'd3,4'd0})}} & wb_i0_instr_event[28 +:4])) | ({4{(s230 == {5'd4,4'd0})}} & wb_i0_instr_event[28 +:4]) | ({4{(s230 == {5'd25,4'd0})}} & wb_i0_instr_event[32 +:4]);
        assign s259 = (csr_halt_mode & csr_dcsr_stopcount) | (cur_privilege_m & s110) | (cur_privilege_s & s116) | (cur_privilege_u & s122) | s140 | (s25 | s26 | s5 | s6);
        assign s253 = (~s259) & (&s257[63:3]) & ((s269 & s257[2]) | (s270 & s271 & s257[2] & (|s257[1:0])) | (s270 & ~s271 & (&s257[2:1])) | (s271 & (&s257[2:0])));
        assign s260 = (|s254 & ~s259) | s25 | s26 | s5 | s6;
        assign s258[31:0] = (s25 | s5) ? csr_wdata[31:0] : (s259 ? s257[31:0] : s272[31:0]);
        assign s258[63:32] = ((s26 | s6)) ? csr_wdata[31:0] : (s259 ? s257[63:32] : s272[63:32]);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s257 <= 64'b0;
            end
            else if (s260) begin
                s257 <= s258;
            end
        end

        wire s319 = s32 | (s45 & s104);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s252 <= 9'b0;
            end
            else if (s319) begin
                s252 <= csr_wdata[8:0];
            end
        end

        assign s73 = s273[31:0];
        assign s72 = s257[31:0];
        assign s79 = {{23{1'b0}},s252};
        assign s254 = (({2{(s252 == {5'd1,4'd0})}} & 2'b01)) | ({2{(s252 == {5'd2,4'd0})}} & ipipe_csr_pfm_inst_retire) | ({2{(s252 == {5'd3,4'd0})}} & {wb_i1_instr_event[21],wb_i0_instr_event[21]}) | ({2{(s252 == {5'd4,4'd0})}} & {wb_i1_instr_event[39],wb_i0_instr_event[39]}) | ({2{(s252 == {5'd5,4'd0})}} & {wb_i1_instr_event[1],wb_i0_instr_event[1]}) | ({2{(s252 == {5'd6,4'd0})}} & {wb_i1_instr_event[40],wb_i0_instr_event[40]}) | ({2{(s252 == {5'd7,4'd0})}} & {wb_i1_instr_event[0],wb_i0_instr_event[0]}) | ({2{(s252 == {5'd8,4'd0})}} & {wb_i1_instr_event[2],wb_i0_instr_event[2]}) | ({2{(s252 == {5'd9,4'd0})}} & {wb_i1_instr_event[4],wb_i0_instr_event[4]}) | ({2{(s252 == {5'd10,4'd0})}} & {wb_i1_instr_event[19],wb_i0_instr_event[19]}) | ({2{(s252 == {5'd11,4'd0})}} & {wb_i1_instr_event[20],wb_i0_instr_event[20]}) | ({2{(s252 == {5'd12,4'd0})}} & {wb_i1_instr_event[37],wb_i0_instr_event[37]}) | ({2{(s252 == {5'd13,4'd0})}} & {wb_i1_instr_event[6],wb_i0_instr_event[6]}) | ({2{(s252 == {5'd14,4'd0})}} & {wb_i1_instr_event[9],wb_i0_instr_event[9]}) | ({2{(s252 == {5'd15,4'd0})}} & {wb_i1_instr_event[24],wb_i0_instr_event[24]}) | ({2{(s252 == {5'd24,4'd0})}} & {wb_i1_instr_event[23],wb_i0_instr_event[23]}) | ({2{(s252 == {5'd16,4'd0})}} & {wb_i1_instr_event[8],wb_i0_instr_event[8]}) | ({2{(s252 == {5'd17,4'd0})}} & {wb_i1_instr_event[13],wb_i0_instr_event[13]}) | ({2{(s252 == {5'd18,4'd0})}} & {wb_i1_instr_event[16],wb_i0_instr_event[16]}) | ({2{(s252 == {5'd19,4'd0})}} & {wb_i1_instr_event[10],wb_i0_instr_event[10]}) | ({2{(s252 == {5'd20,4'd0})}} & {wb_i1_instr_event[14],wb_i0_instr_event[14]}) | ({2{(s252 == {5'd21,4'd0})}} & {wb_i1_instr_event[12],wb_i0_instr_event[12]}) | ({2{(s252 == {5'd22,4'd0})}} & {wb_i1_instr_event[11],wb_i0_instr_event[11]}) | ({2{(s252 == {5'd23,4'd0})}} & {wb_i1_instr_event[15],wb_i0_instr_event[15]}) | ({2{(s252 == {5'd25,4'd0})}} & ipipe_csr_pfm_inst_retire) | ({2{(s252 == {5'd26,4'd0})}} & {wb_i1_instr_event[36],wb_i0_instr_event[36]}) | ({2{(s252 == {5'd27,4'd0})}} & {wb_i1_instr_event[25],wb_i0_instr_event[25]}) | ({2{(s252 == {5'd28,4'd0})}} & {wb_i1_instr_event[26],wb_i0_instr_event[26]}) | ({2{(s252 == {5'd0,4'd1})}} & {1'b0,hint_event[37]}) | ({2{(s252 == {5'd1,4'd1})}} & {1'b0,hint_event[27]}) | ({2{(s252 == {5'd1,4'd1})}} & {1'b0,hint_event[28]}) | ({2{(s252 == {5'd1,4'd1})}} & {1'b0,hint_event[29]}) | ({2{(s252 == {5'd1,4'd1})}} & {1'b0,hint_event[30]}) | ({2{(s252 == {5'd2,4'd1})}} & {1'b0,hint_event[32]}) | ({2{(s252 == {5'd3,4'd1})}} & {1'b0,hint_event[34]}) | ({2{(s252 == {5'd4,4'd1})}} & {1'b0,hint_event[19]}) | ({2{(s252 == {5'd5,4'd1})}} & {1'b0,hint_event[22]}) | ({2{(s252 == {5'd6,4'd1})}} & {1'b0,hint_event[20]}) | ({2{(s252 == {5'd7,4'd1})}} & {1'b0,hint_event[21]}) | ({2{(s252 == {5'd8,4'd1})}} & {1'b0,hint_event[24]}) | ({2{(s252 == {5'd9,4'd1})}} & {1'b0,hint_event[25]}) | ({2{(s252 == {5'd11,4'd1})}} & {1'b0,hint_event[33]}) | ({2{(s252 == {5'd12,4'd1})}} & {1'b0,hint_event[23]}) | ({2{(s252 == {5'd13,4'd1})}} & {1'b0,hint_event[35]}) | ({2{(s252 == {5'd14,4'd1})}} & {1'b0,hint_event[17]}) | ({2{(s252 == {5'd15,4'd1})}} & {1'b0,hint_event[36]}) | ({2{(s252 == {5'd16,4'd1})}} & {1'b0,hint_event[18]}) | ({2{(s252 == {5'd17,4'd1})}} & {1'b0,hint_event[41]}) | ({2{(s252 == {5'd18,4'd1})}} & {1'b0,hint_event[42]}) | ({2{(s252 == {5'd19,4'd1})}} & {1'b0,hint_event[38]}) | ({2{(s252 == {5'd20,4'd1})}} & {1'b0,hint_event[39]}) | ({2{(s252 == {5'd21,4'd1})}} & {1'b0,hint_event[43]}) | ({2{(s252 == {5'd22,4'd1})}} & {1'b0,hint_event[40]}) | ({2{(s252 == {5'd23,4'd1})}} & {1'b0,hint_event[31]}) | ({2{(s252 == {5'd24,4'd1})}} & {1'b0,hint_event[16]}) | ({2{(s252 == {5'd10,4'd1})}} & {1'b0,hint_event[26]}) | ({2{(s252 == {5'd0,4'd3})}} & {1'b0,hint_event[0]}) | ({2{(s252 == {5'd1,4'd3})}} & {1'b0,hint_event[2]}) | ({2{(s252 == {5'd2,4'd3})}} & {1'b0,hint_event[4]}) | ({2{(s252 == {5'd3,4'd3})}} & {1'b0,hint_event[6]}) | ({2{(s252 == {5'd4,4'd3})}} & {1'b0,hint_event[8]}) | ({2{(s252 == {5'd5,4'd3})}} & {1'b0,hint_event[10]}) | ({2{(s252 == {5'd6,4'd3})}} & {1'b0,hint_event[12]}) | ({2{(s252 == {5'd7,4'd3})}} & {1'b0,hint_event[14]}) | ({2{(s252 == {5'd0,4'd4})}} & {1'b0,hint_event[1]}) | ({2{(s252 == {5'd1,4'd4})}} & {1'b0,hint_event[3]}) | ({2{(s252 == {5'd2,4'd4})}} & {1'b0,hint_event[5]}) | ({2{(s252 == {5'd3,4'd4})}} & {1'b0,hint_event[7]}) | ({2{(s252 == {5'd4,4'd4})}} & {1'b0,hint_event[9]}) | ({2{(s252 == {5'd5,4'd4})}} & {1'b0,hint_event[11]}) | ({2{(s252 == {5'd6,4'd4})}} & {1'b0,hint_event[13]}) | ({2{(s252 == {5'd7,4'd4})}} & {1'b0,hint_event[15]}) | ({2{(s252 == {5'd0,4'd2})}} & {wb_i1_instr_event[3],wb_i0_instr_event[3]}) | ({2{(s252 == {5'd1,4'd2})}} & {wb_i1_instr_event[5],wb_i0_instr_event[5]}) | ({2{(s252 == {5'd2,4'd2})}} & {wb_i1_instr_event[38],wb_i0_instr_event[38]}) | ({2{(s252 == {5'd3,4'd2})}} & {wb_i1_instr_event[22],wb_i0_instr_event[22]});
        assign s255 = (({2{(s252 == {5'd2,4'd0})}} & s220)) | ({2{(s252 == {5'd7,4'd0})}} & s221) | ({2{(s252 == {5'd25,4'd0})}} & {wb_i1_instr_event[12],wb_i0_instr_event[12]});
        assign s256 = (((s252 == {5'd3,4'd0}) & wb_i0_instr_event[25])) | ((s252 == {5'd3,4'd0}) & wb_i0_instr_event[26]) | ((s252 == {5'd4,4'd0}) & wb_i0_instr_event[36]) | ((s252 == {5'd25,4'd0}) & wb_i0_instr_event[27]);
        assign s264 = (({4{(s252 == {5'd3,4'd0})}} & wb_i0_instr_event[28 +:4])) | ({4{(s252 == {5'd4,4'd0})}} & wb_i0_instr_event[28 +:4]) | ({4{(s252 == {5'd25,4'd0})}} & wb_i0_instr_event[32 +:4]);
        assign s281 = (csr_halt_mode & csr_dcsr_stopcount) | (cur_privilege_m & s111) | (cur_privilege_s & s117) | (cur_privilege_u & s123) | s141 | (s27 | s28 | s7 | s8);
        assign s275 = (~s281) & (&s279[63:3]) & ((s291 & s279[2]) | (s292 & s293 & s279[2] & (|s279[1:0])) | (s292 & ~s293 & (&s279[2:1])) | (s293 & (&s279[2:0])));
        assign s282 = (|s276 & ~s281) | s27 | s28 | s7 | s8;
        assign s280[31:0] = (s27 | s7) ? csr_wdata[31:0] : (s281 ? s279[31:0] : s294[31:0]);
        assign s280[63:32] = ((s28 | s8)) ? csr_wdata[31:0] : (s281 ? s279[63:32] : s294[63:32]);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s279 <= 64'b0;
            end
            else if (s282) begin
                s279 <= s280;
            end
        end

        wire s320 = s33 | (s46 & s105);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s274 <= 9'b0;
            end
            else if (s320) begin
                s274 <= csr_wdata[8:0];
            end
        end

        assign s75 = s295[31:0];
        assign s74 = s279[31:0];
        assign s80 = {{23{1'b0}},s274};
        assign s276 = (({2{(s274 == {5'd1,4'd0})}} & 2'b01)) | ({2{(s274 == {5'd2,4'd0})}} & ipipe_csr_pfm_inst_retire) | ({2{(s274 == {5'd3,4'd0})}} & {wb_i1_instr_event[21],wb_i0_instr_event[21]}) | ({2{(s274 == {5'd4,4'd0})}} & {wb_i1_instr_event[39],wb_i0_instr_event[39]}) | ({2{(s274 == {5'd5,4'd0})}} & {wb_i1_instr_event[1],wb_i0_instr_event[1]}) | ({2{(s274 == {5'd6,4'd0})}} & {wb_i1_instr_event[40],wb_i0_instr_event[40]}) | ({2{(s274 == {5'd7,4'd0})}} & {wb_i1_instr_event[0],wb_i0_instr_event[0]}) | ({2{(s274 == {5'd8,4'd0})}} & {wb_i1_instr_event[2],wb_i0_instr_event[2]}) | ({2{(s274 == {5'd9,4'd0})}} & {wb_i1_instr_event[4],wb_i0_instr_event[4]}) | ({2{(s274 == {5'd10,4'd0})}} & {wb_i1_instr_event[19],wb_i0_instr_event[19]}) | ({2{(s274 == {5'd11,4'd0})}} & {wb_i1_instr_event[20],wb_i0_instr_event[20]}) | ({2{(s274 == {5'd12,4'd0})}} & {wb_i1_instr_event[37],wb_i0_instr_event[37]}) | ({2{(s274 == {5'd13,4'd0})}} & {wb_i1_instr_event[6],wb_i0_instr_event[6]}) | ({2{(s274 == {5'd14,4'd0})}} & {wb_i1_instr_event[9],wb_i0_instr_event[9]}) | ({2{(s274 == {5'd15,4'd0})}} & {wb_i1_instr_event[24],wb_i0_instr_event[24]}) | ({2{(s274 == {5'd24,4'd0})}} & {wb_i1_instr_event[23],wb_i0_instr_event[23]}) | ({2{(s274 == {5'd16,4'd0})}} & {wb_i1_instr_event[8],wb_i0_instr_event[8]}) | ({2{(s274 == {5'd17,4'd0})}} & {wb_i1_instr_event[13],wb_i0_instr_event[13]}) | ({2{(s274 == {5'd18,4'd0})}} & {wb_i1_instr_event[16],wb_i0_instr_event[16]}) | ({2{(s274 == {5'd19,4'd0})}} & {wb_i1_instr_event[10],wb_i0_instr_event[10]}) | ({2{(s274 == {5'd20,4'd0})}} & {wb_i1_instr_event[14],wb_i0_instr_event[14]}) | ({2{(s274 == {5'd21,4'd0})}} & {wb_i1_instr_event[12],wb_i0_instr_event[12]}) | ({2{(s274 == {5'd22,4'd0})}} & {wb_i1_instr_event[11],wb_i0_instr_event[11]}) | ({2{(s274 == {5'd23,4'd0})}} & {wb_i1_instr_event[15],wb_i0_instr_event[15]}) | ({2{(s274 == {5'd25,4'd0})}} & ipipe_csr_pfm_inst_retire) | ({2{(s274 == {5'd26,4'd0})}} & {wb_i1_instr_event[36],wb_i0_instr_event[36]}) | ({2{(s274 == {5'd27,4'd0})}} & {wb_i1_instr_event[25],wb_i0_instr_event[25]}) | ({2{(s274 == {5'd28,4'd0})}} & {wb_i1_instr_event[26],wb_i0_instr_event[26]}) | ({2{(s274 == {5'd0,4'd1})}} & {1'b0,hint_event[37]}) | ({2{(s274 == {5'd1,4'd1})}} & {1'b0,hint_event[27]}) | ({2{(s274 == {5'd1,4'd1})}} & {1'b0,hint_event[28]}) | ({2{(s274 == {5'd1,4'd1})}} & {1'b0,hint_event[29]}) | ({2{(s274 == {5'd1,4'd1})}} & {1'b0,hint_event[30]}) | ({2{(s274 == {5'd2,4'd1})}} & {1'b0,hint_event[32]}) | ({2{(s274 == {5'd3,4'd1})}} & {1'b0,hint_event[34]}) | ({2{(s274 == {5'd4,4'd1})}} & {1'b0,hint_event[19]}) | ({2{(s274 == {5'd5,4'd1})}} & {1'b0,hint_event[22]}) | ({2{(s274 == {5'd6,4'd1})}} & {1'b0,hint_event[20]}) | ({2{(s274 == {5'd7,4'd1})}} & {1'b0,hint_event[21]}) | ({2{(s274 == {5'd8,4'd1})}} & {1'b0,hint_event[24]}) | ({2{(s274 == {5'd9,4'd1})}} & {1'b0,hint_event[25]}) | ({2{(s274 == {5'd11,4'd1})}} & {1'b0,hint_event[33]}) | ({2{(s274 == {5'd12,4'd1})}} & {1'b0,hint_event[23]}) | ({2{(s274 == {5'd13,4'd1})}} & {1'b0,hint_event[35]}) | ({2{(s274 == {5'd14,4'd1})}} & {1'b0,hint_event[17]}) | ({2{(s274 == {5'd15,4'd1})}} & {1'b0,hint_event[36]}) | ({2{(s274 == {5'd16,4'd1})}} & {1'b0,hint_event[18]}) | ({2{(s274 == {5'd17,4'd1})}} & {1'b0,hint_event[41]}) | ({2{(s274 == {5'd18,4'd1})}} & {1'b0,hint_event[42]}) | ({2{(s274 == {5'd19,4'd1})}} & {1'b0,hint_event[38]}) | ({2{(s274 == {5'd20,4'd1})}} & {1'b0,hint_event[39]}) | ({2{(s274 == {5'd21,4'd1})}} & {1'b0,hint_event[43]}) | ({2{(s274 == {5'd22,4'd1})}} & {1'b0,hint_event[40]}) | ({2{(s274 == {5'd23,4'd1})}} & {1'b0,hint_event[31]}) | ({2{(s274 == {5'd24,4'd1})}} & {1'b0,hint_event[16]}) | ({2{(s274 == {5'd10,4'd1})}} & {1'b0,hint_event[26]}) | ({2{(s274 == {5'd0,4'd3})}} & {1'b0,hint_event[0]}) | ({2{(s274 == {5'd1,4'd3})}} & {1'b0,hint_event[2]}) | ({2{(s274 == {5'd2,4'd3})}} & {1'b0,hint_event[4]}) | ({2{(s274 == {5'd3,4'd3})}} & {1'b0,hint_event[6]}) | ({2{(s274 == {5'd4,4'd3})}} & {1'b0,hint_event[8]}) | ({2{(s274 == {5'd5,4'd3})}} & {1'b0,hint_event[10]}) | ({2{(s274 == {5'd6,4'd3})}} & {1'b0,hint_event[12]}) | ({2{(s274 == {5'd7,4'd3})}} & {1'b0,hint_event[14]}) | ({2{(s274 == {5'd0,4'd4})}} & {1'b0,hint_event[1]}) | ({2{(s274 == {5'd1,4'd4})}} & {1'b0,hint_event[3]}) | ({2{(s274 == {5'd2,4'd4})}} & {1'b0,hint_event[5]}) | ({2{(s274 == {5'd3,4'd4})}} & {1'b0,hint_event[7]}) | ({2{(s274 == {5'd4,4'd4})}} & {1'b0,hint_event[9]}) | ({2{(s274 == {5'd5,4'd4})}} & {1'b0,hint_event[11]}) | ({2{(s274 == {5'd6,4'd4})}} & {1'b0,hint_event[13]}) | ({2{(s274 == {5'd7,4'd4})}} & {1'b0,hint_event[15]}) | ({2{(s274 == {5'd0,4'd2})}} & {wb_i1_instr_event[3],wb_i0_instr_event[3]}) | ({2{(s274 == {5'd1,4'd2})}} & {wb_i1_instr_event[5],wb_i0_instr_event[5]}) | ({2{(s274 == {5'd2,4'd2})}} & {wb_i1_instr_event[38],wb_i0_instr_event[38]}) | ({2{(s274 == {5'd3,4'd2})}} & {wb_i1_instr_event[22],wb_i0_instr_event[22]});
        assign s277 = (({2{(s274 == {5'd2,4'd0})}} & s220)) | ({2{(s274 == {5'd7,4'd0})}} & s221) | ({2{(s274 == {5'd25,4'd0})}} & {wb_i1_instr_event[12],wb_i0_instr_event[12]});
        assign s278 = (((s274 == {5'd3,4'd0}) & wb_i0_instr_event[25])) | ((s274 == {5'd3,4'd0}) & wb_i0_instr_event[26]) | ((s274 == {5'd4,4'd0}) & wb_i0_instr_event[36]) | ((s274 == {5'd25,4'd0}) & wb_i0_instr_event[27]);
        assign s286 = (({4{(s274 == {5'd3,4'd0})}} & wb_i0_instr_event[28 +:4])) | ({4{(s274 == {5'd4,4'd0})}} & wb_i0_instr_event[28 +:4]) | ({4{(s274 == {5'd25,4'd0})}} & wb_i0_instr_event[32 +:4]);
        assign s303 = (csr_halt_mode & csr_dcsr_stopcount) | (cur_privilege_m & s112) | (cur_privilege_s & s118) | (cur_privilege_u & s124) | s142 | (s29 | s30 | s9 | s10);
        assign s297 = (~s303) & (&s301[63:3]) & ((s313 & s301[2]) | (s314 & s315 & s301[2] & (|s301[1:0])) | (s314 & ~s315 & (&s301[2:1])) | (s315 & (&s301[2:0])));
        assign s304 = (|s298 & ~s303) | s29 | s30 | s9 | s10;
        assign s302[31:0] = (s29 | s9) ? csr_wdata[31:0] : (s303 ? s301[31:0] : s316[31:0]);
        assign s302[63:32] = ((s30 | s10)) ? csr_wdata[31:0] : (s303 ? s301[63:32] : s316[63:32]);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s301 <= 64'b0;
            end
            else if (s304) begin
                s301 <= s302;
            end
        end

        wire s321 = s34 | (s47 & s106);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s296 <= 9'b0;
            end
            else if (s321) begin
                s296 <= csr_wdata[8:0];
            end
        end

        assign s77 = s317[31:0];
        assign s76 = s301[31:0];
        assign s81 = {{23{1'b0}},s296};
        assign s298 = (({2{(s296 == {5'd1,4'd0})}} & 2'b01)) | ({2{(s296 == {5'd2,4'd0})}} & ipipe_csr_pfm_inst_retire) | ({2{(s296 == {5'd3,4'd0})}} & {wb_i1_instr_event[21],wb_i0_instr_event[21]}) | ({2{(s296 == {5'd4,4'd0})}} & {wb_i1_instr_event[39],wb_i0_instr_event[39]}) | ({2{(s296 == {5'd5,4'd0})}} & {wb_i1_instr_event[1],wb_i0_instr_event[1]}) | ({2{(s296 == {5'd6,4'd0})}} & {wb_i1_instr_event[40],wb_i0_instr_event[40]}) | ({2{(s296 == {5'd7,4'd0})}} & {wb_i1_instr_event[0],wb_i0_instr_event[0]}) | ({2{(s296 == {5'd8,4'd0})}} & {wb_i1_instr_event[2],wb_i0_instr_event[2]}) | ({2{(s296 == {5'd9,4'd0})}} & {wb_i1_instr_event[4],wb_i0_instr_event[4]}) | ({2{(s296 == {5'd10,4'd0})}} & {wb_i1_instr_event[19],wb_i0_instr_event[19]}) | ({2{(s296 == {5'd11,4'd0})}} & {wb_i1_instr_event[20],wb_i0_instr_event[20]}) | ({2{(s296 == {5'd12,4'd0})}} & {wb_i1_instr_event[37],wb_i0_instr_event[37]}) | ({2{(s296 == {5'd13,4'd0})}} & {wb_i1_instr_event[6],wb_i0_instr_event[6]}) | ({2{(s296 == {5'd14,4'd0})}} & {wb_i1_instr_event[9],wb_i0_instr_event[9]}) | ({2{(s296 == {5'd15,4'd0})}} & {wb_i1_instr_event[24],wb_i0_instr_event[24]}) | ({2{(s296 == {5'd24,4'd0})}} & {wb_i1_instr_event[23],wb_i0_instr_event[23]}) | ({2{(s296 == {5'd16,4'd0})}} & {wb_i1_instr_event[8],wb_i0_instr_event[8]}) | ({2{(s296 == {5'd17,4'd0})}} & {wb_i1_instr_event[13],wb_i0_instr_event[13]}) | ({2{(s296 == {5'd18,4'd0})}} & {wb_i1_instr_event[16],wb_i0_instr_event[16]}) | ({2{(s296 == {5'd19,4'd0})}} & {wb_i1_instr_event[10],wb_i0_instr_event[10]}) | ({2{(s296 == {5'd20,4'd0})}} & {wb_i1_instr_event[14],wb_i0_instr_event[14]}) | ({2{(s296 == {5'd21,4'd0})}} & {wb_i1_instr_event[12],wb_i0_instr_event[12]}) | ({2{(s296 == {5'd22,4'd0})}} & {wb_i1_instr_event[11],wb_i0_instr_event[11]}) | ({2{(s296 == {5'd23,4'd0})}} & {wb_i1_instr_event[15],wb_i0_instr_event[15]}) | ({2{(s296 == {5'd25,4'd0})}} & ipipe_csr_pfm_inst_retire) | ({2{(s296 == {5'd26,4'd0})}} & {wb_i1_instr_event[36],wb_i0_instr_event[36]}) | ({2{(s296 == {5'd27,4'd0})}} & {wb_i1_instr_event[25],wb_i0_instr_event[25]}) | ({2{(s296 == {5'd28,4'd0})}} & {wb_i1_instr_event[26],wb_i0_instr_event[26]}) | ({2{(s296 == {5'd0,4'd1})}} & {1'b0,hint_event[37]}) | ({2{(s296 == {5'd1,4'd1})}} & {1'b0,hint_event[27]}) | ({2{(s296 == {5'd1,4'd1})}} & {1'b0,hint_event[28]}) | ({2{(s296 == {5'd1,4'd1})}} & {1'b0,hint_event[29]}) | ({2{(s296 == {5'd1,4'd1})}} & {1'b0,hint_event[30]}) | ({2{(s296 == {5'd2,4'd1})}} & {1'b0,hint_event[32]}) | ({2{(s296 == {5'd3,4'd1})}} & {1'b0,hint_event[34]}) | ({2{(s296 == {5'd4,4'd1})}} & {1'b0,hint_event[19]}) | ({2{(s296 == {5'd5,4'd1})}} & {1'b0,hint_event[22]}) | ({2{(s296 == {5'd6,4'd1})}} & {1'b0,hint_event[20]}) | ({2{(s296 == {5'd7,4'd1})}} & {1'b0,hint_event[21]}) | ({2{(s296 == {5'd8,4'd1})}} & {1'b0,hint_event[24]}) | ({2{(s296 == {5'd9,4'd1})}} & {1'b0,hint_event[25]}) | ({2{(s296 == {5'd11,4'd1})}} & {1'b0,hint_event[33]}) | ({2{(s296 == {5'd12,4'd1})}} & {1'b0,hint_event[23]}) | ({2{(s296 == {5'd13,4'd1})}} & {1'b0,hint_event[35]}) | ({2{(s296 == {5'd14,4'd1})}} & {1'b0,hint_event[17]}) | ({2{(s296 == {5'd15,4'd1})}} & {1'b0,hint_event[36]}) | ({2{(s296 == {5'd16,4'd1})}} & {1'b0,hint_event[18]}) | ({2{(s296 == {5'd17,4'd1})}} & {1'b0,hint_event[41]}) | ({2{(s296 == {5'd18,4'd1})}} & {1'b0,hint_event[42]}) | ({2{(s296 == {5'd19,4'd1})}} & {1'b0,hint_event[38]}) | ({2{(s296 == {5'd20,4'd1})}} & {1'b0,hint_event[39]}) | ({2{(s296 == {5'd21,4'd1})}} & {1'b0,hint_event[43]}) | ({2{(s296 == {5'd22,4'd1})}} & {1'b0,hint_event[40]}) | ({2{(s296 == {5'd23,4'd1})}} & {1'b0,hint_event[31]}) | ({2{(s296 == {5'd24,4'd1})}} & {1'b0,hint_event[16]}) | ({2{(s296 == {5'd10,4'd1})}} & {1'b0,hint_event[26]}) | ({2{(s296 == {5'd0,4'd3})}} & {1'b0,hint_event[0]}) | ({2{(s296 == {5'd1,4'd3})}} & {1'b0,hint_event[2]}) | ({2{(s296 == {5'd2,4'd3})}} & {1'b0,hint_event[4]}) | ({2{(s296 == {5'd3,4'd3})}} & {1'b0,hint_event[6]}) | ({2{(s296 == {5'd4,4'd3})}} & {1'b0,hint_event[8]}) | ({2{(s296 == {5'd5,4'd3})}} & {1'b0,hint_event[10]}) | ({2{(s296 == {5'd6,4'd3})}} & {1'b0,hint_event[12]}) | ({2{(s296 == {5'd7,4'd3})}} & {1'b0,hint_event[14]}) | ({2{(s296 == {5'd0,4'd4})}} & {1'b0,hint_event[1]}) | ({2{(s296 == {5'd1,4'd4})}} & {1'b0,hint_event[3]}) | ({2{(s296 == {5'd2,4'd4})}} & {1'b0,hint_event[5]}) | ({2{(s296 == {5'd3,4'd4})}} & {1'b0,hint_event[7]}) | ({2{(s296 == {5'd4,4'd4})}} & {1'b0,hint_event[9]}) | ({2{(s296 == {5'd5,4'd4})}} & {1'b0,hint_event[11]}) | ({2{(s296 == {5'd6,4'd4})}} & {1'b0,hint_event[13]}) | ({2{(s296 == {5'd7,4'd4})}} & {1'b0,hint_event[15]}) | ({2{(s296 == {5'd0,4'd2})}} & {wb_i1_instr_event[3],wb_i0_instr_event[3]}) | ({2{(s296 == {5'd1,4'd2})}} & {wb_i1_instr_event[5],wb_i0_instr_event[5]}) | ({2{(s296 == {5'd2,4'd2})}} & {wb_i1_instr_event[38],wb_i0_instr_event[38]}) | ({2{(s296 == {5'd3,4'd2})}} & {wb_i1_instr_event[22],wb_i0_instr_event[22]});
        assign s299 = (({2{(s296 == {5'd2,4'd0})}} & s220)) | ({2{(s296 == {5'd7,4'd0})}} & s221) | ({2{(s296 == {5'd25,4'd0})}} & {wb_i1_instr_event[12],wb_i0_instr_event[12]});
        assign s300 = (((s296 == {5'd3,4'd0}) & wb_i0_instr_event[25])) | ((s296 == {5'd3,4'd0}) & wb_i0_instr_event[26]) | ((s296 == {5'd4,4'd0}) & wb_i0_instr_event[36]) | ((s296 == {5'd25,4'd0}) & wb_i0_instr_event[27]);
        assign s308 = (({4{(s296 == {5'd3,4'd0})}} & wb_i0_instr_event[28 +:4])) | ({4{(s296 == {5'd4,4'd0})}} & wb_i0_instr_event[28 +:4]) | ({4{(s296 == {5'd25,4'd0})}} & wb_i0_instr_event[32 +:4]);
        reg s322;
        reg s323;
        reg s324;
        reg s325;
        reg s326;
        reg s327;
        wire s328 = (s18 & ~csr_wdata[0]) | (s42 & ~csr_wdata[0] & s101);
        wire s329 = s208;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s322 <= 1'b0;
            end
            else if (s328) begin
                s322 <= 1'b0;
            end
            else if (s329) begin
                s322 <= 1'b1;
            end
        end

        wire s330 = (s18 & ~csr_wdata[2]) | (s42 & ~csr_wdata[2] & s102);
        wire s331 = s215;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s323 <= 1'b0;
            end
            else if (s330) begin
                s323 <= 1'b0;
            end
            else if (s331) begin
                s323 <= 1'b1;
            end
        end

        wire s332 = (s18 & ~csr_wdata[3]) | (s42 & ~csr_wdata[3] & s103);
        wire s333 = s231;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s324 <= 1'b0;
            end
            else if (s332) begin
                s324 <= 1'b0;
            end
            else if (s333) begin
                s324 <= 1'b1;
            end
        end

        wire s334 = (s18 & ~csr_wdata[4]) | (s42 & ~csr_wdata[4] & s104);
        wire s335 = s253;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s325 <= 1'b0;
            end
            else if (s334) begin
                s325 <= 1'b0;
            end
            else if (s335) begin
                s325 <= 1'b1;
            end
        end

        wire s336 = (s18 & ~csr_wdata[5]) | (s42 & ~csr_wdata[5] & s105);
        wire s337 = s275;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s326 <= 1'b0;
            end
            else if (s336) begin
                s326 <= 1'b0;
            end
            else if (s337) begin
                s326 <= 1'b1;
            end
        end

        wire s338 = (s18 & ~csr_wdata[6]) | (s42 & ~csr_wdata[6] & s106);
        wire s339 = s297;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s327 <= 1'b0;
            end
            else if (s338) begin
                s327 <= 1'b0;
            end
            else if (s339) begin
                s327 <= 1'b1;
            end
        end

        assign s131 = s322;
        assign s132 = s323;
        assign s133 = s324;
        assign s134 = s325;
        assign s135 = s326;
        assign s136 = s327;
        reg s340;
        reg s341;
        reg s342;
        reg s343;
        reg s344;
        reg s345;
        wire s346 = (s14) | (s38 & s101);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s340 <= 1'b0;
            end
            else if (s346) begin
                s340 <= csr_wdata[0];
            end
        end

        wire s347 = (s14) | (s38 & s102);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s341 <= 1'b0;
            end
            else if (s347) begin
                s341 <= csr_wdata[2];
            end
        end

        wire s348 = (s14) | (s38 & s103);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s342 <= 1'b0;
            end
            else if (s348) begin
                s342 <= csr_wdata[3];
            end
        end

        wire s349 = (s14) | (s38 & s104);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s343 <= 1'b0;
            end
            else if (s349) begin
                s343 <= csr_wdata[4];
            end
        end

        wire s350 = (s14) | (s38 & s105);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s344 <= 1'b0;
            end
            else if (s350) begin
                s344 <= csr_wdata[5];
            end
        end

        wire s351 = (s14) | (s38 & s106);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s345 <= 1'b0;
            end
            else if (s351) begin
                s345 <= csr_wdata[6];
            end
        end

        assign s125 = s340;
        assign s126 = s341;
        assign s127 = s342;
        assign s128 = s343;
        assign s129 = s344;
        assign s130 = s345;
        reg s352;
        reg s353;
        reg s354;
        reg s355;
        reg s356;
        reg s357;
        wire s358 = (s20) | (s43 & s101);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s352 <= 1'b0;
            end
            else if (s358) begin
                s352 <= csr_wdata[0];
            end
        end

        wire s359 = (s20) | (s43 & s102);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s353 <= 1'b0;
            end
            else if (s359) begin
                s353 <= csr_wdata[2];
            end
        end

        wire s360 = (s20) | (s43 & s103);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s354 <= 1'b0;
            end
            else if (s360) begin
                s354 <= csr_wdata[3];
            end
        end

        wire s361 = (s20) | (s43 & s104);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s355 <= 1'b0;
            end
            else if (s361) begin
                s355 <= csr_wdata[4];
            end
        end

        wire s362 = (s20) | (s43 & s105);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s356 <= 1'b0;
            end
            else if (s362) begin
                s356 <= csr_wdata[5];
            end
        end

        wire s363 = (s20) | (s43 & s106);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s357 <= 1'b0;
            end
            else if (s363) begin
                s357 <= csr_wdata[6];
            end
        end

        assign s137 = s352;
        assign s138 = s353;
        assign s139 = s354;
        assign s140 = s355;
        assign s141 = s356;
        assign s142 = s357;
        assign s68 = s207[31:0];
        assign s69 = s213[31:0];
        assign s82 = s214[31:0];
        assign s83 = s219[31:0];
        assign hpm_m_counter_ovf = (s208 & ~s107 & s125) | (s215 & ~s108 & s126) | (s231 & ~s109 & s127) | (s253 & ~s110 & s128) | (s275 & ~s111 & s129) | (s297 & ~s112 & s130);
        assign hpm_s_counter_ovf = (s208 & s107 & s125) | (s215 & s108 & s126) | (s231 & s109 & s127) | (s253 & s110 & s128) | (s275 & s111 & s129) | (s297 & s112 & s130);
    end
    else begin:gen_non_performance_monitor_regs
        assign s68 = {32{1'b0}};
        assign s69 = {32{1'b0}};
        assign s82 = {32{1'b0}};
        assign s83 = {32{1'b0}};
        assign s71 = {32{1'b0}};
        assign s70 = {32{1'b0}};
        assign s78 = {32{1'b0}};
        assign s73 = {32{1'b0}};
        assign s72 = {32{1'b0}};
        assign s79 = {32{1'b0}};
        assign s75 = {32{1'b0}};
        assign s74 = {32{1'b0}};
        assign s80 = {32{1'b0}};
        assign s77 = {32{1'b0}};
        assign s76 = {32{1'b0}};
        assign s81 = {32{1'b0}};
        assign s131 = 1'b0;
        assign s132 = 1'b0;
        assign s133 = 1'b0;
        assign s134 = 1'b0;
        assign s135 = 1'b0;
        assign s136 = 1'b0;
        assign s125 = 1'b0;
        assign s126 = 1'b0;
        assign s127 = 1'b0;
        assign s128 = 1'b0;
        assign s129 = 1'b0;
        assign s130 = 1'b0;
        assign s137 = 1'b0;
        assign s138 = 1'b0;
        assign s139 = 1'b0;
        assign s140 = 1'b0;
        assign s141 = 1'b0;
        assign s142 = 1'b0;
        assign hpm_m_counter_ovf = 1'b0;
        assign hpm_s_counter_ovf = 1'b0;
        wire nds_unused_core_clk = core_clk;
        wire nds_unused_core_reset_n = core_reset_n;
        wire nds_unused_csr_we = csr_we;
        wire [11:0] nds_unused_csr_waddr = csr_waddr;
        wire [31:0] nds_unused_csr_wdata = csr_wdata;
        wire [11:0] nds_unused_csr_raddr0 = csr_raddr0;
        wire [11:0] nds_unused_csr_raddr1 = csr_raddr1;
        wire [1:0] nds_unused_ipipe_csr_pfm_inst_retire = ipipe_csr_pfm_inst_retire;
        wire [40:0] nds_unused_wb_i0_instr_event = wb_i0_instr_event;
        wire [40:0] nds_unused_wb_i1_instr_event = wb_i1_instr_event;
        wire [43:0] nds_unused_hint_event = hint_event;
        wire nds_unused_csr_dcsr_stopcount = csr_dcsr_stopcount;
        wire nds_unused_csr_halt_mode = csr_halt_mode;
        wire nds_unused_cur_privilege_m = cur_privilege_m;
        wire nds_unused_cur_privilege_s = cur_privilege_s;
        wire nds_unused_cur_privilege_u = cur_privilege_u;
        wire nds_unused_csr_cycle_we = s1;
        wire nds_unused_csr_cycleh_we = s2;
        wire nds_unused_csr_hpmcounter3_we = s3;
        wire nds_unused_csr_hpmcounter3h_we = s4;
        wire nds_unused_csr_hpmcounter4_we = s5;
        wire nds_unused_csr_hpmcounter4h_we = s6;
        wire nds_unused_csr_hpmcounter5_we = s7;
        wire nds_unused_csr_hpmcounter5h_we = s8;
        wire nds_unused_csr_hpmcounter6_we = s9;
        wire nds_unused_csr_hpmcounter6h_we = s10;
        wire nds_unused_csr_instret_we = s11;
        wire nds_unused_csr_instreth_we = s12;
        wire nds_unused_csr_mcounterinten_we = s14;
        wire nds_unused_csr_mcounterovf_we = s18;
        wire nds_unused_csr_mcountinhibit_we = s20;
        wire nds_unused_csr_mcycle_we = s21;
        wire nds_unused_csr_mcycleh_we = s22;
        wire nds_unused_csr_mhpmcounter3_we = s23;
        wire nds_unused_csr_mhpmcounter3h_we = s24;
        wire nds_unused_csr_mhpmcounter4_we = s25;
        wire nds_unused_csr_mhpmcounter4h_we = s26;
        wire nds_unused_csr_mhpmcounter5_we = s27;
        wire nds_unused_csr_mhpmcounter5h_we = s28;
        wire nds_unused_csr_mhpmcounter6_we = s29;
        wire nds_unused_csr_mhpmcounter6h_we = s30;
        wire nds_unused_csr_mhpmevent3_we = s31;
        wire nds_unused_csr_mhpmevent4_we = s32;
        wire nds_unused_csr_mhpmevent5_we = s33;
        wire nds_unused_csr_mhpmevent6_we = s34;
        wire nds_unused_csr_minstret_we = s35;
        wire nds_unused_csr_minstreth_we = s36;
        wire nds_unused_csr_scounterinten_we = s38;
        wire nds_unused_csr_scounterovf_we = s42;
        wire nds_unused_csr_scountinhibit_we = s43;
        wire nds_unused_csr_shpmevent3_we = s44;
        wire nds_unused_csr_shpmevent4_we = s45;
        wire nds_unused_csr_shpmevent5_we = s46;
        wire nds_unused_csr_shpmevent6_we = s47;
    end
endgenerate
endmodule


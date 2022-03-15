//
//  Copyright (c) 2003 Launchbird Design Systems, Inc.
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//    Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//    Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
//  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
//  OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
//  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//  
//  
//  Overview:
//  
//    State Space Processor is used for implementing discrete (digital) linear systems, such as
//    finite impulse response filters, infinite impulse response filters, multiple input and output
//    systems, and general state space equations.
//  
//  Architecture:
//  
//    The State Space Processor is designed with a small logic footprint for area limited
//    applications.  The processor requires two external memories: one for program instructions
//    and the other for constants (coefficients) used in calculation.  The processor maintains a
//    register file of 16 N-bit registers used to retain state information and for processing intermediate
//    results.  The register file is also used for handling input and output; registers can be written
//    from an external source and all registers are available as outputs.  For convenience, register 0
//    is wired to ground (0) and instructions updating r0 have no effect on the register file.
//  
//    The processor runs calculations on a cycle basis:
//      1. The external environment writes inputs into the register file.
//      2. The external environment signals a "Cycle" to run the program and calculate a cycle.
//      3. The external environment waits for "Done", then reads output from the register file.
//  
//  Instruction Set:
//  
//    There are 4 instruction types and a total of 8 instructions.  Each instruction is 16-bits.
//    The types include:
//      Unary Operation  : OpCode [15:12], Operand Reg A [11:8], Not Used [7:4], Result Reg X [3:0]
//      Binary Operation : OpCode [15:12], Operand Reg A [11:8], Operand Reg B [7:4], Result Reg X [3:0]
//      Constant Load    : OpCode [15:12], Constant Memory Address [11:4], Result Reg X [3:0]
//      Halt             : OpCode [15:12], Not Used [11:0]
//  
//    Unary Operations (OpCode):
//  
//      ShiftLeft  (0000) : RegX <- lsbs RegA '++' '0'
//                          Flag <- Flag
//      ShiftRight (0001) : RegX <- msb RegA '++' msbs RegA
//                          Flag <- lsb RegA
//      ShiftClip  (0010) : RegX <- lsbs RegA '++' '0' when top 2 bits of RegA == '00' or '11' else
//                                  '0111...1'         when top 2 bits of RegA == '01'         else
//                                  '1000...0'         when top 2 bits of RegA == '10'
//                          Flag <- Flag
//                          Performs a limited/clipped multiplication by 2.
//  
//    Binary Operations (OpCode):
//  
//      Add        (0011) : RegX <- RegA '+' RegB
//                          Flag <- msb Result
//      AddCond    (0100) : RegX <- RegA '+' RegB when Flag == '1' else RegA
//                          Flag <- Flag
//      Sub        (0101) : RegX <- RegA '-' RegB
//                          Flag <- msb Result
//      Switch     (0110) : RegX <- RegA when Flag == '1' else RegB
//                          Flag <- Flag
//  
//    Constant Load Instruction (OpCode):
//  
//      Constant   (0111) : RegX <- Data from constant memory.
//                          Flag <- Flag
//  
//    Halt Instruction (OpCode):
//  
//      Halt       (1---) : Halts processor (prevents further register updates).
//  
//    Booth multiplication can be performed using ShiftRight and AddCond with an accumulation register.
//  
//  Interface:
//  
//    Synchronization:
//      clock_c  : Clock input.
//      reset_state_i : Reset all state registers (register file and ALU flag).
//  
//    Inputs:
//      cycle_i      : Input pulse to perform a cycle (sample) calculation.
//      instr_data_i : Instruction data from instruction memory.
//      const_data_i : Constant data from constant memory.
//      load_write_i : Write enable for writing to register file.
//      load_addr_i  : Address (4-bits) for writing to register file.
//      load_data_i  : Data for writing to register file.
//  
//    Outputs:
//      done_o       : Output flag signaling processor is done calculating cycle (active high).
//      instr_addr_o : Address to instruction memory.
//      const_addr_o : Address to constant memory (8-bits).
//      reg_0_o      : Register 0 value.
//      reg_1_o      : Register 1 value.
//      ...
//      reg_f_o      : Register F value.
//  
//  Built In Parameters:
//  
//    Data Width                = 64
//    Instruction Address Width = 10
//  
//  
//  
//  
//  Generated by Confluence 0.6.3  --  Launchbird Design Systems, Inc.  --  www.launchbird.com
//  
//  Build Date : Fri Aug 22 09:51:43 CDT 2003
//  
//  Interface
//  
//    Build Name    : cf_ssp_64_10
//    Clock Domains : clock_c  
//    Vector Input  : reset_state_i(1)
//    Vector Input  : cycle_i(1)
//    Vector Input  : instr_data_i(16)
//    Vector Input  : const_data_i(64)
//    Vector Input  : load_write_i(1)
//    Vector Input  : load_addr_i(4)
//    Vector Input  : load_data_i(64)
//    Vector Output : done_o(1)
//    Vector Output : instr_addr_o(10)
//    Vector Output : const_addr_o(8)
//    Vector Output : reg_0_o(64)
//    Vector Output : reg_1_o(64)
//    Vector Output : reg_2_o(64)
//    Vector Output : reg_3_o(64)
//    Vector Output : reg_4_o(64)
//    Vector Output : reg_5_o(64)
//    Vector Output : reg_6_o(64)
//    Vector Output : reg_7_o(64)
//    Vector Output : reg_8_o(64)
//    Vector Output : reg_9_o(64)
//    Vector Output : reg_a_o(64)
//    Vector Output : reg_b_o(64)
//    Vector Output : reg_c_o(64)
//    Vector Output : reg_d_o(64)
//    Vector Output : reg_e_o(64)
//    Vector Output : reg_f_o(64)
//  
//  
//  

`timescale 1 ns / 1 ns

module cf_ssp_64_10 (clock_c, reset_state_i, cycle_i, instr_data_i, const_data_i, load_write_i, load_addr_i, load_data_i, done_o, instr_addr_o, const_addr_o, reg_0_o, reg_1_o, reg_2_o, reg_3_o, reg_4_o, reg_5_o, reg_6_o, reg_7_o, reg_8_o, reg_9_o, reg_a_o, reg_b_o, reg_c_o, reg_d_o, reg_e_o, reg_f_o);
input  clock_c;
input  reset_state_i;
input  cycle_i;
input  [15:0] instr_data_i;
input  [63:0] const_data_i;
input  load_write_i;
input  [3:0] load_addr_i;
input  [63:0] load_data_i;
output done_o;
output [9:0] instr_addr_o;
output [7:0] const_addr_o;
output [63:0] reg_0_o;
output [63:0] reg_1_o;
output [63:0] reg_2_o;
output [63:0] reg_3_o;
output [63:0] reg_4_o;
output [63:0] reg_5_o;
output [63:0] reg_6_o;
output [63:0] reg_7_o;
output [63:0] reg_8_o;
output [63:0] reg_9_o;
output [63:0] reg_a_o;
output [63:0] reg_b_o;
output [63:0] reg_c_o;
output [63:0] reg_d_o;
output [63:0] reg_e_o;
output [63:0] reg_f_o;
wire   [9:0] n1;
wire   [7:0] n2;
wire   [63:0] n3;
wire   [63:0] n4;
wire   [63:0] n5;
wire   [63:0] n6;
wire   [63:0] n7;
wire   [63:0] n8;
wire   [63:0] n9;
wire   [63:0] n10;
wire   [63:0] n11;
wire   [63:0] n12;
wire   [63:0] n13;
wire   [63:0] n14;
wire   [63:0] n15;
wire   [63:0] n16;
wire   [63:0] n17;
wire   [63:0] n18;
wire   n19;
cf_ssp_64_10_1 s1 (clock_c, cycle_i, reset_state_i, instr_data_i, const_data_i, load_write_i, load_addr_i, load_data_i, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19);
assign done_o = n19;
assign instr_addr_o = n1;
assign const_addr_o = n2;
assign reg_0_o = n3;
assign reg_1_o = n4;
assign reg_2_o = n5;
assign reg_3_o = n6;
assign reg_4_o = n7;
assign reg_5_o = n8;
assign reg_6_o = n9;
assign reg_7_o = n10;
assign reg_8_o = n11;
assign reg_9_o = n12;
assign reg_a_o = n13;
assign reg_b_o = n14;
assign reg_c_o = n15;
assign reg_d_o = n16;
assign reg_e_o = n17;
assign reg_f_o = n18;
endmodule

module cf_ssp_64_10_1 (clock_c, i1, i2, i3, i4, i5, i6, i7, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11, o12, o13, o14, o15, o16, o17, o18, o19);
input  clock_c;
input  i1;
input  i2;
input  [15:0] i3;
input  [63:0] i4;
input  i5;
input  [3:0] i6;
input  [63:0] i7;
output [9:0] o1;
output [7:0] o2;
output [63:0] o3;
output [63:0] o4;
output [63:0] o5;
output [63:0] o6;
output [63:0] o7;
output [63:0] o8;
output [63:0] o9;
output [63:0] o10;
output [63:0] o11;
output [63:0] o12;
output [63:0] o13;
output [63:0] o14;
output [63:0] o15;
output [63:0] o16;
output [63:0] o17;
output [63:0] o18;
output o19;
wire   n1;
wire   n2;
wire   [9:0] n3;
wire   [9:0] n4;
reg    [9:0] n5;
reg    n6;
reg    n7;
wire   n8;
wire   [1:0] n9;
wire   n10;
wire   n11;
wire   n12;
wire   n13;
wire   n14;
wire   n15;
wire   n16;
wire   n17;
wire   [2:0] n18;
wire   [2:0] n19;
wire   [2:0] n20;
wire   [2:0] n21;
wire   [2:0] n22;
wire   [2:0] n23;
wire   [2:0] n24;
wire   n25;
wire   n26;
wire   n27;
wire   n28;
wire   [2:0] n29;
wire   [2:0] n30;
wire   [2:0] n31;
wire   [2:0] n32;
wire   [2:0] n33;
wire   n34;
wire   n35;
wire   n36;
wire   n37;
wire   n38;
wire   n39;
wire   n40;
wire   n41;
wire   n42;
wire   n43;
wire   n44;
wire   n45;
wire   n46;
wire   n47;
reg    n48;
wire   n49;
wire   n50;
wire   n51;
wire   n52;
wire   n53;
wire   n54;
wire   n55;
wire   n56;
wire   [2:0] n57;
wire   [3:0] n58;
wire   [3:0] n59;
wire   [3:0] n60;
reg    [3:0] n61;
wire   [7:0] n62;
wire   n63;
wire   [3:0] n64;
wire   [4:0] n65;
wire   [15:0] n66;
wire   [15:0] n67;
wire   [15:0] n68;
wire   [15:0] n69;
wire   [15:0] n70;
wire   [15:0] n71;
wire   [15:0] n72;
wire   [15:0] n73;
wire   [15:0] n74;
wire   [15:0] n75;
wire   [15:0] n76;
wire   [15:0] n77;
wire   [15:0] n78;
wire   [15:0] n79;
wire   [15:0] n80;
wire   [15:0] n81;
wire   [15:0] n82;
wire   [4:0] n83;
wire   n84;
wire   [4:0] n85;
wire   n86;
wire   [4:0] n87;
wire   n88;
wire   [4:0] n89;
wire   n90;
wire   [4:0] n91;
wire   n92;
wire   [4:0] n93;
wire   n94;
wire   [4:0] n95;
wire   n96;
wire   [4:0] n97;
wire   n98;
wire   [4:0] n99;
wire   n100;
wire   [4:0] n101;
wire   n102;
wire   [4:0] n103;
wire   n104;
wire   [4:0] n105;
wire   n106;
wire   [4:0] n107;
wire   n108;
wire   [4:0] n109;
wire   n110;
wire   [4:0] n111;
wire   n112;
wire   [4:0] n113;
wire   n114;
wire   [4:0] n115;
wire   n116;
wire   [4:0] n117;
wire   n118;
wire   [4:0] n119;
wire   n120;
wire   [4:0] n121;
wire   n122;
wire   [4:0] n123;
wire   n124;
wire   [4:0] n125;
wire   n126;
wire   [4:0] n127;
wire   n128;
wire   [4:0] n129;
wire   n130;
wire   [4:0] n131;
wire   n132;
wire   [4:0] n133;
wire   n134;
wire   [4:0] n135;
wire   n136;
wire   [4:0] n137;
wire   n138;
wire   [4:0] n139;
wire   n140;
wire   [4:0] n141;
wire   n142;
wire   [4:0] n143;
wire   n144;
wire   [15:0] n145;
wire   [15:0] n146;
wire   [15:0] n147;
wire   [15:0] n148;
wire   [15:0] n149;
wire   [15:0] n150;
wire   [15:0] n151;
wire   [15:0] n152;
wire   [15:0] n153;
wire   [15:0] n154;
wire   [15:0] n155;
wire   [15:0] n156;
wire   [15:0] n157;
wire   [15:0] n158;
wire   [15:0] n159;
wire   [15:0] n160;
wire   [15:0] n161;
wire   [15:0] n162;
wire   [15:0] n163;
wire   [15:0] n164;
wire   [15:0] n165;
wire   [15:0] n166;
wire   [15:0] n167;
wire   [15:0] n168;
wire   [15:0] n169;
wire   [15:0] n170;
wire   [15:0] n171;
wire   [15:0] n172;
wire   [15:0] n173;
wire   [15:0] n174;
wire   [15:0] n175;
wire   [63:0] n176;
wire   n177;
wire   n178;
wire   n179;
wire   n180;
wire   n181;
wire   n182;
wire   n183;
wire   n184;
wire   n185;
wire   n186;
wire   n187;
wire   n188;
wire   n189;
wire   n190;
wire   n191;
reg    [3:0] n192;
wire   [2:0] n193;
wire   n194;
wire   [63:0] n195;
wire   [63:0] n196;
wire   [63:0] n197;
wire   [63:0] n198;
wire   [63:0] n199;
wire   [63:0] n200;
wire   [63:0] n201;
wire   [63:0] n202;
wire   [1:0] n203;
wire   n204;
wire   [63:0] n205;
wire   [63:0] n206;
wire   [63:0] n207;
wire   [63:0] n208;
wire   n209;
wire   n210;
wire   [63:0] n211;
wire   [63:0] n212;
wire   n213;
wire   [63:0] n214;
reg    [3:0] n215;
wire   [2:0] n216;
wire   n217;
wire   [63:0] n218;
wire   [63:0] n219;
wire   [63:0] n220;
wire   [63:0] n221;
wire   [63:0] n222;
wire   [63:0] n223;
wire   [63:0] n224;
wire   [63:0] n225;
wire   [1:0] n226;
wire   n227;
wire   [63:0] n228;
wire   [63:0] n229;
wire   [63:0] n230;
wire   [63:0] n231;
wire   n232;
wire   n233;
wire   [63:0] n234;
wire   [63:0] n235;
wire   n236;
wire   [63:0] n237;
reg    [2:0] n238;
wire   n239;
wire   n240;
wire   [1:0] n241;
wire   [2:0] n242;
wire   [3:0] n243;
wire   [4:0] n244;
wire   [5:0] n245;
wire   [6:0] n246;
wire   [7:0] n247;
wire   [8:0] n248;
wire   [9:0] n249;
wire   [10:0] n250;
wire   [11:0] n251;
wire   [12:0] n252;
wire   [13:0] n253;
wire   [14:0] n254;
wire   [15:0] n255;
wire   [16:0] n256;
wire   [17:0] n257;
wire   [18:0] n258;
wire   [19:0] n259;
wire   [20:0] n260;
wire   [21:0] n261;
wire   [22:0] n262;
wire   [23:0] n263;
wire   [24:0] n264;
wire   [25:0] n265;
wire   [26:0] n266;
wire   [27:0] n267;
wire   [28:0] n268;
wire   [29:0] n269;
wire   [30:0] n270;
wire   [31:0] n271;
wire   [32:0] n272;
wire   [33:0] n273;
wire   [34:0] n274;
wire   [35:0] n275;
wire   [36:0] n276;
wire   [37:0] n277;
wire   [38:0] n278;
wire   [39:0] n279;
wire   [40:0] n280;
wire   [41:0] n281;
wire   [42:0] n282;
wire   [43:0] n283;
wire   [44:0] n284;
wire   [45:0] n285;
wire   [46:0] n286;
wire   [47:0] n287;
wire   [48:0] n288;
wire   [49:0] n289;
wire   [50:0] n290;
wire   [51:0] n291;
wire   [52:0] n292;
wire   [53:0] n293;
wire   [54:0] n294;
wire   [55:0] n295;
wire   [56:0] n296;
wire   [57:0] n297;
wire   [58:0] n298;
wire   [59:0] n299;
wire   [60:0] n300;
wire   [61:0] n301;
wire   [62:0] n302;
wire   [63:0] n303;
wire   [62:0] n304;
wire   n305;
wire   [63:0] n306;
wire   n307;
wire   [62:0] n308;
wire   [63:0] n309;
wire   n310;
wire   n311;
wire   [63:0] n312;
wire   [63:0] n313;
wire   [63:0] n314;
wire   [2:0] n315;
wire   n316;
wire   n317;
wire   [2:0] n318;
wire   n319;
wire   n320;
wire   [2:0] n321;
wire   n322;
wire   n323;
wire   [63:0] n324;
wire   [63:0] n325;
wire   [1:0] n326;
wire   n327;
wire   [63:0] n328;
wire   [63:0] n329;
wire   [63:0] n330;
wire   [63:0] n331;
wire   n332;
wire   n333;
wire   [63:0] n334;
wire   [63:0] n335;
wire   n336;
wire   [63:0] n337;
wire   n338;
wire   n339;
wire   n340;
reg    n341;
wire   [63:0] n342;
reg    [63:0] n343;
reg    [63:0] n344;
reg    [63:0] n345;
reg    [63:0] n346;
reg    [63:0] n347;
reg    [63:0] n348;
reg    [63:0] n349;
reg    [63:0] n350;
reg    [63:0] n351;
reg    [63:0] n352;
reg    [63:0] n353;
reg    [63:0] n354;
reg    [63:0] n355;
reg    [63:0] n356;
reg    [63:0] n357;
wire   [1:0] n358;
wire   [1:0] n359;
wire   [1:0] n360;
wire   [1:0] n361;
wire   [1:0] n362;
wire   [1:0] n363;
wire   [1:0] n364;
wire   [1:0] n365;
wire   [3:0] n366;
wire   [3:0] n367;
wire   [3:0] n368;
wire   [3:0] n369;
wire   [3:0] n370;
wire   [3:0] n371;
wire   [3:0] n372;
wire   [3:0] n373;
wire   [3:0] n374;
wire   [3:0] n375;
wire   n376;
wire   n377;
wire   [3:0] n378;
wire   [3:0] n379;
wire   [3:0] n380;
wire   [3:0] n381;
wire   [3:0] n382;
wire   n383;
wire   n384;
wire   n385;
wire   n386;
wire   n387;
wire   n388;
wire   n389;
wire   n390;
wire   n391;
wire   n392;
wire   [1:0] n393;
wire   [1:0] n394;
wire   [1:0] n395;
wire   [1:0] n396;
wire   [1:0] n397;
wire   [1:0] n398;
wire   [1:0] n399;
wire   [1:0] n400;
wire   [1:0] n401;
wire   [1:0] n402;
reg    [1:0] n403;
wire   n404;
wire   n405;
wire   n406;
wire   n407;
wire   n408;
wire   n409;
wire   n410;
wire   n411;
wire   n412;
wire   [1:0] n413;
wire   n414;
assign n1 = 1'b1;
assign n2 = 1'b0;
assign n3 = 10'b0000000001;
assign n4 = n5 + n3;
initial n5 = 10'b0000000000;
always @ (posedge clock_c)
  if (i1 == 1'b1)
    n5 <= 10'b0000000000;
  else if (n1 == 1'b1)
    n5 <= n4;
initial n6 = 1'b0;
always @ (posedge clock_c)
  if (n2 == 1'b1)
    n6 <= 1'b0;
  else if (n1 == 1'b1)
    n6 <= i1;
initial n7 = 1'b0;
always @ (posedge clock_c)
  if (n2 == 1'b1)
    n7 <= 1'b0;
  else if (n1 == 1'b1)
    n7 <= n6;
assign n8 = i3[15];
assign n9 = {n7, n8};
assign n10 = 1'b0;
assign n11 = 1'b1;
assign n12 = 1'b0;
assign n13 = 1'b1;
assign n14 = 1'b0;
assign n15 = 1'b1;
assign n16 = 1'b0;
assign n17 = 1'b0;
assign n18 = 3'b000;
assign n19 = 3'b010;
assign n20 = 3'b100;
assign n21 = 3'b110;
assign n22 = 3'b001;
assign n23 = 3'b011;
assign n24 = 3'b101;
assign n25 = 1'b0;
assign n26 = 1'b0;
assign n27 = 1'b0;
assign n28 = 1'b0;
assign n29 = 3'b000;
assign n30 = 3'b010;
assign n31 = 3'b100;
assign n32 = 3'b110;
assign n33 = {n9, n48};
assign n34 = n33 == n18;
assign n35 = n33 == n19;
assign n36 = n33 == n20;
assign n37 = n33 == n21;
assign n38 = n33 == n22;
assign n39 = n33 == n23;
assign n40 = n33 == n24;
assign n41 = n40 ? n11 : n10;
assign n42 = n39 ? n12 : n41;
assign n43 = n38 ? n13 : n42;
assign n44 = n37 ? n14 : n43;
assign n45 = n36 ? n15 : n44;
assign n46 = n35 ? n16 : n45;
assign n47 = n34 ? n17 : n46;
initial n48 = 1'b0;
always @ (posedge clock_c)
  if (n2 == 1'b1)
    n48 <= 1'b0;
  else if (n1 == 1'b1)
    n48 <= n47;
assign n49 = n33 == n29;
assign n50 = n33 == n30;
assign n51 = n33 == n31;
assign n52 = n33 == n32;
assign n53 = n52 ? n25 : n412;
assign n54 = n51 ? n26 : n53;
assign n55 = n50 ? n27 : n54;
assign n56 = n49 ? n28 : n55;
assign n57 = {i3[14],
  i3[13],
  i3[12]};
assign n58 = {i3[11],
  i3[10],
  i3[9],
  i3[8]};
assign n59 = {i3[7],
  i3[6],
  i3[5],
  i3[4]};
assign n60 = {i3[3],
  i3[2],
  i3[1],
  i3[0]};
initial n61 = 4'b0000;
always @ (posedge clock_c)
  if (n2 == 1'b1)
    n61 <= 4'b0000;
  else if (n1 == 1'b1)
    n61 <= n60;
assign n62 = {i3[11],
  i3[10],
  i3[9],
  i3[8],
  i3[7],
  i3[6],
  i3[5],
  i3[4]};
assign n63 = i5 | n56;
assign n64 = i5 ? i6 : n61;
assign n65 = {n63, n64};
assign n66 = 16'b1000000000000000;
assign n67 = 16'b0100000000000000;
assign n68 = 16'b0010000000000000;
assign n69 = 16'b0001000000000000;
assign n70 = 16'b0000100000000000;
assign n71 = 16'b0000010000000000;
assign n72 = 16'b0000001000000000;
assign n73 = 16'b0000000100000000;
assign n74 = 16'b0000000010000000;
assign n75 = 16'b0000000001000000;
assign n76 = 16'b0000000000100000;
assign n77 = 16'b0000000000010000;
assign n78 = 16'b0000000000001000;
assign n79 = 16'b0000000000000100;
assign n80 = 16'b0000000000000010;
assign n81 = 16'b0000000000000001;
assign n82 = 16'b0000000000000000;
assign n83 = 5'b00000;
assign n84 = n65 == n83;
assign n85 = 5'b00001;
assign n86 = n65 == n85;
assign n87 = 5'b00010;
assign n88 = n65 == n87;
assign n89 = 5'b00011;
assign n90 = n65 == n89;
assign n91 = 5'b00100;
assign n92 = n65 == n91;
assign n93 = 5'b00101;
assign n94 = n65 == n93;
assign n95 = 5'b00110;
assign n96 = n65 == n95;
assign n97 = 5'b00111;
assign n98 = n65 == n97;
assign n99 = 5'b01000;
assign n100 = n65 == n99;
assign n101 = 5'b01001;
assign n102 = n65 == n101;
assign n103 = 5'b01010;
assign n104 = n65 == n103;
assign n105 = 5'b01011;
assign n106 = n65 == n105;
assign n107 = 5'b01100;
assign n108 = n65 == n107;
assign n109 = 5'b01101;
assign n110 = n65 == n109;
assign n111 = 5'b01110;
assign n112 = n65 == n111;
assign n113 = 5'b01111;
assign n114 = n65 == n113;
assign n115 = 5'b10000;
assign n116 = n65 == n115;
assign n117 = 5'b10001;
assign n118 = n65 == n117;
assign n119 = 5'b10010;
assign n120 = n65 == n119;
assign n121 = 5'b10011;
assign n122 = n65 == n121;
assign n123 = 5'b10100;
assign n124 = n65 == n123;
assign n125 = 5'b10101;
assign n126 = n65 == n125;
assign n127 = 5'b10110;
assign n128 = n65 == n127;
assign n129 = 5'b10111;
assign n130 = n65 == n129;
assign n131 = 5'b11000;
assign n132 = n65 == n131;
assign n133 = 5'b11001;
assign n134 = n65 == n133;
assign n135 = 5'b11010;
assign n136 = n65 == n135;
assign n137 = 5'b11011;
assign n138 = n65 == n137;
assign n139 = 5'b11100;
assign n140 = n65 == n139;
assign n141 = 5'b11101;
assign n142 = n65 == n141;
assign n143 = 5'b11110;
assign n144 = n65 == n143;
assign n145 = n144 ? n67 : n66;
assign n146 = n142 ? n68 : n145;
assign n147 = n140 ? n69 : n146;
assign n148 = n138 ? n70 : n147;
assign n149 = n136 ? n71 : n148;
assign n150 = n134 ? n72 : n149;
assign n151 = n132 ? n73 : n150;
assign n152 = n130 ? n74 : n151;
assign n153 = n128 ? n75 : n152;
assign n154 = n126 ? n76 : n153;
assign n155 = n124 ? n77 : n154;
assign n156 = n122 ? n78 : n155;
assign n157 = n120 ? n79 : n156;
assign n158 = n118 ? n80 : n157;
assign n159 = n116 ? n81 : n158;
assign n160 = n114 ? n82 : n159;
assign n161 = n112 ? n82 : n160;
assign n162 = n110 ? n82 : n161;
assign n163 = n108 ? n82 : n162;
assign n164 = n106 ? n82 : n163;
assign n165 = n104 ? n82 : n164;
assign n166 = n102 ? n82 : n165;
assign n167 = n100 ? n82 : n166;
assign n168 = n98 ? n82 : n167;
assign n169 = n96 ? n82 : n168;
assign n170 = n94 ? n82 : n169;
assign n171 = n92 ? n82 : n170;
assign n172 = n90 ? n82 : n171;
assign n173 = n88 ? n82 : n172;
assign n174 = n86 ? n82 : n173;
assign n175 = n84 ? n82 : n174;
assign n176 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
assign n177 = n175[1];
assign n178 = n175[2];
assign n179 = n175[3];
assign n180 = n175[4];
assign n181 = n175[5];
assign n182 = n175[6];
assign n183 = n175[7];
assign n184 = n175[8];
assign n185 = n175[9];
assign n186 = n175[10];
assign n187 = n175[11];
assign n188 = n175[12];
assign n189 = n175[13];
assign n190 = n175[14];
assign n191 = n175[15];
initial n192 = 4'b0000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n192 <= 4'b0000;
  else if (n1 == 1'b1)
    n192 <= n58;
assign n193 = {n192[3],
  n192[2],
  n192[1]};
assign n194 = n192[0];
assign n195 = n194 ? n343 : n176;
assign n196 = n194 ? n345 : n344;
assign n197 = n194 ? n347 : n346;
assign n198 = n194 ? n349 : n348;
assign n199 = n194 ? n351 : n350;
assign n200 = n194 ? n353 : n352;
assign n201 = n194 ? n355 : n354;
assign n202 = n194 ? n357 : n356;
assign n203 = {n193[2],
  n193[1]};
assign n204 = n193[0];
assign n205 = n204 ? n196 : n195;
assign n206 = n204 ? n198 : n197;
assign n207 = n204 ? n200 : n199;
assign n208 = n204 ? n202 : n201;
assign n209 = n203[1];
assign n210 = n203[0];
assign n211 = n210 ? n206 : n205;
assign n212 = n210 ? n208 : n207;
assign n213 = n209;
assign n214 = n213 ? n212 : n211;
initial n215 = 4'b0000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n215 <= 4'b0000;
  else if (n1 == 1'b1)
    n215 <= n59;
assign n216 = {n215[3],
  n215[2],
  n215[1]};
assign n217 = n215[0];
assign n218 = n217 ? n343 : n176;
assign n219 = n217 ? n345 : n344;
assign n220 = n217 ? n347 : n346;
assign n221 = n217 ? n349 : n348;
assign n222 = n217 ? n351 : n350;
assign n223 = n217 ? n353 : n352;
assign n224 = n217 ? n355 : n354;
assign n225 = n217 ? n357 : n356;
assign n226 = {n216[2],
  n216[1]};
assign n227 = n216[0];
assign n228 = n227 ? n219 : n218;
assign n229 = n227 ? n221 : n220;
assign n230 = n227 ? n223 : n222;
assign n231 = n227 ? n225 : n224;
assign n232 = n226[1];
assign n233 = n226[0];
assign n234 = n233 ? n229 : n228;
assign n235 = n233 ? n231 : n230;
assign n236 = n232;
assign n237 = n236 ? n235 : n234;
initial n238 = 3'b000;
always @ (posedge clock_c)
  if (n2 == 1'b1)
    n238 <= 3'b000;
  else if (n1 == 1'b1)
    n238 <= n57;
assign n239 = n214[63];
assign n240 = ~n239;
assign n241 = {n240, n240};
assign n242 = {n240, n241};
assign n243 = {n240, n242};
assign n244 = {n240, n243};
assign n245 = {n240, n244};
assign n246 = {n240, n245};
assign n247 = {n240, n246};
assign n248 = {n240, n247};
assign n249 = {n240, n248};
assign n250 = {n240, n249};
assign n251 = {n240, n250};
assign n252 = {n240, n251};
assign n253 = {n240, n252};
assign n254 = {n240, n253};
assign n255 = {n240, n254};
assign n256 = {n240, n255};
assign n257 = {n240, n256};
assign n258 = {n240, n257};
assign n259 = {n240, n258};
assign n260 = {n240, n259};
assign n261 = {n240, n260};
assign n262 = {n240, n261};
assign n263 = {n240, n262};
assign n264 = {n240, n263};
assign n265 = {n240, n264};
assign n266 = {n240, n265};
assign n267 = {n240, n266};
assign n268 = {n240, n267};
assign n269 = {n240, n268};
assign n270 = {n240, n269};
assign n271 = {n240, n270};
assign n272 = {n240, n271};
assign n273 = {n240, n272};
assign n274 = {n240, n273};
assign n275 = {n240, n274};
assign n276 = {n240, n275};
assign n277 = {n240, n276};
assign n278 = {n240, n277};
assign n279 = {n240, n278};
assign n280 = {n240, n279};
assign n281 = {n240, n280};
assign n282 = {n240, n281};
assign n283 = {n240, n282};
assign n284 = {n240, n283};
assign n285 = {n240, n284};
assign n286 = {n240, n285};
assign n287 = {n240, n286};
assign n288 = {n240, n287};
assign n289 = {n240, n288};
assign n290 = {n240, n289};
assign n291 = {n240, n290};
assign n292 = {n240, n291};
assign n293 = {n240, n292};
assign n294 = {n240, n293};
assign n295 = {n240, n294};
assign n296 = {n240, n295};
assign n297 = {n240, n296};
assign n298 = {n240, n297};
assign n299 = {n240, n298};
assign n300 = {n240, n299};
assign n301 = {n240, n300};
assign n302 = {n240, n301};
assign n303 = {n239, n302};
assign n304 = {n214[62],
  n214[61],
  n214[60],
  n214[59],
  n214[58],
  n214[57],
  n214[56],
  n214[55],
  n214[54],
  n214[53],
  n214[52],
  n214[51],
  n214[50],
  n214[49],
  n214[48],
  n214[47],
  n214[46],
  n214[45],
  n214[44],
  n214[43],
  n214[42],
  n214[41],
  n214[40],
  n214[39],
  n214[38],
  n214[37],
  n214[36],
  n214[35],
  n214[34],
  n214[33],
  n214[32],
  n214[31],
  n214[30],
  n214[29],
  n214[28],
  n214[27],
  n214[26],
  n214[25],
  n214[24],
  n214[23],
  n214[22],
  n214[21],
  n214[20],
  n214[19],
  n214[18],
  n214[17],
  n214[16],
  n214[15],
  n214[14],
  n214[13],
  n214[12],
  n214[11],
  n214[10],
  n214[9],
  n214[8],
  n214[7],
  n214[6],
  n214[5],
  n214[4],
  n214[3],
  n214[2],
  n214[1],
  n214[0]};
assign n305 = 1'b0;
assign n306 = {n304, n305};
assign n307 = n214[63];
assign n308 = {n214[63],
  n214[62],
  n214[61],
  n214[60],
  n214[59],
  n214[58],
  n214[57],
  n214[56],
  n214[55],
  n214[54],
  n214[53],
  n214[52],
  n214[51],
  n214[50],
  n214[49],
  n214[48],
  n214[47],
  n214[46],
  n214[45],
  n214[44],
  n214[43],
  n214[42],
  n214[41],
  n214[40],
  n214[39],
  n214[38],
  n214[37],
  n214[36],
  n214[35],
  n214[34],
  n214[33],
  n214[32],
  n214[31],
  n214[30],
  n214[29],
  n214[28],
  n214[27],
  n214[26],
  n214[25],
  n214[24],
  n214[23],
  n214[22],
  n214[21],
  n214[20],
  n214[19],
  n214[18],
  n214[17],
  n214[16],
  n214[15],
  n214[14],
  n214[13],
  n214[12],
  n214[11],
  n214[10],
  n214[9],
  n214[8],
  n214[7],
  n214[6],
  n214[5],
  n214[4],
  n214[3],
  n214[2],
  n214[1]};
assign n309 = {n307, n308};
assign n310 = n214[62];
assign n311 = n239 ^ n310;
assign n312 = n311 ? n303 : n306;
assign n313 = n214 + n237;
assign n314 = n214 - n237;
assign n315 = 3'b001;
assign n316 = n238 == n315;
assign n317 = n214[0];
assign n318 = 3'b011;
assign n319 = n238 == n318;
assign n320 = n313[63];
assign n321 = 3'b101;
assign n322 = n238 == n321;
assign n323 = n314[63];
assign n324 = n341 ? n313 : n214;
assign n325 = n341 ? n214 : n237;
assign n326 = {n238[2],
  n238[1]};
assign n327 = n238[0];
assign n328 = n327 ? n309 : n306;
assign n329 = n327 ? n313 : n312;
assign n330 = n327 ? n314 : n324;
assign n331 = n327 ? i4 : n325;
assign n332 = n326[1];
assign n333 = n326[0];
assign n334 = n333 ? n329 : n328;
assign n335 = n333 ? n331 : n330;
assign n336 = n332;
assign n337 = n336 ? n335 : n334;
assign n338 = n322 ? n323 : n341;
assign n339 = n319 ? n320 : n338;
assign n340 = n316 ? n317 : n339;
initial n341 = 1'b0;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n341 <= 1'b0;
  else if (n1 == 1'b1)
    n341 <= n340;
assign n342 = i5 ? i7 : n337;
initial n343 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n343 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
  else if (n177 == 1'b1)
    n343 <= n342;
initial n344 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n344 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
  else if (n178 == 1'b1)
    n344 <= n342;
initial n345 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n345 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
  else if (n179 == 1'b1)
    n345 <= n342;
initial n346 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n346 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
  else if (n180 == 1'b1)
    n346 <= n342;
initial n347 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n347 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
  else if (n181 == 1'b1)
    n347 <= n342;
initial n348 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n348 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
  else if (n182 == 1'b1)
    n348 <= n342;
initial n349 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n349 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
  else if (n183 == 1'b1)
    n349 <= n342;
initial n350 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n350 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
  else if (n184 == 1'b1)
    n350 <= n342;
initial n351 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n351 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
  else if (n185 == 1'b1)
    n351 <= n342;
initial n352 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n352 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
  else if (n186 == 1'b1)
    n352 <= n342;
initial n353 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n353 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
  else if (n187 == 1'b1)
    n353 <= n342;
initial n354 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n354 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
  else if (n188 == 1'b1)
    n354 <= n342;
initial n355 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n355 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
  else if (n189 == 1'b1)
    n355 <= n342;
initial n356 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n356 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
  else if (n190 == 1'b1)
    n356 <= n342;
initial n357 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
always @ (posedge clock_c)
  if (i2 == 1'b1)
    n357 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
  else if (n191 == 1'b1)
    n357 <= n342;
assign n358 = {i1, n56};
assign n359 = 2'b10;
assign n360 = 2'b00;
assign n361 = 2'b01;
assign n362 = 2'b10;
assign n363 = 2'b01;
assign n364 = 2'b01;
assign n365 = 2'b00;
assign n366 = 4'b0000;
assign n367 = 4'b0100;
assign n368 = 4'b1000;
assign n369 = 4'b1100;
assign n370 = 4'b0001;
assign n371 = 4'b0101;
assign n372 = 4'b1001;
assign n373 = 4'b1101;
assign n374 = 4'b0010;
assign n375 = 4'b0110;
assign n376 = 1'b1;
assign n377 = 1'b1;
assign n378 = 4'b0000;
assign n379 = 4'b0100;
assign n380 = 4'b1000;
assign n381 = 4'b1100;
assign n382 = {n358, n403};
assign n383 = n382 == n366;
assign n384 = n382 == n367;
assign n385 = n382 == n368;
assign n386 = n382 == n369;
assign n387 = n382 == n370;
assign n388 = n382 == n371;
assign n389 = n382 == n372;
assign n390 = n382 == n373;
assign n391 = n382 == n374;
assign n392 = n382 == n375;
assign n393 = n392 ? n359 : n413;
assign n394 = n391 ? n360 : n393;
assign n395 = n390 ? n361 : n394;
assign n396 = n389 ? n361 : n395;
assign n397 = n388 ? n362 : n396;
assign n398 = n387 ? n363 : n397;
assign n399 = n386 ? n364 : n398;
assign n400 = n385 ? n364 : n399;
assign n401 = n384 ? n365 : n400;
assign n402 = n383 ? n365 : n401;
initial n403 = 2'b00;
always @ (posedge clock_c)
  if (n2 == 1'b1)
    n403 <= 2'b00;
  else if (n1 == 1'b1)
    n403 <= n402;
assign n404 = n382 == n378;
assign n405 = n382 == n379;
assign n406 = n382 == n380;
assign n407 = n382 == n381;
assign n408 = n407 ? n376 : n414;
assign n409 = n406 ? n376 : n408;
assign n410 = n405 ? n377 : n409;
assign n411 = n404 ? n377 : n410;
assign n412 = 1'b1;
assign n413 = 2'b01;
assign n414 = 1'b0;
assign o19 = n411;
assign o18 = n357;
assign o17 = n356;
assign o16 = n355;
assign o15 = n354;
assign o14 = n353;
assign o13 = n352;
assign o12 = n351;
assign o11 = n350;
assign o10 = n349;
assign o9 = n348;
assign o8 = n347;
assign o7 = n346;
assign o6 = n345;
assign o5 = n344;
assign o4 = n343;
assign o3 = n176;
assign o2 = n62;
assign o1 = n5;
endmodule


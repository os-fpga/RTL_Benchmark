/*##########################################################################################
  Copyright (c) 2019 Dolphin Technology, Inc.
  This verilog is proprietary and confidential information of
  Dolphin Technology, Inc. and can only be used or viewed
  under license or with written permission from Dolphin Technology, Inc.
  Date:    8/28/2019 16:41:55
  Source:  /projects/tsmc/tm16/tm16_ddr/verilog/cir/dti_tm16glp_re_18ud15_lpd4_io_b_jme.ckt
  Path:    andy_dell2:/cygdrive/c/projects/tsmc/tm16/tm16_ddr/verilog/dti_tm16glp_re_18ud15_lpd4_io_b_jme
  Command: /work/perl3/verilog/spice2verilog.pl -sp
           /projects/tsmc/tm16/tm16_ddr/verilog/cir/dti_tm16glp_re_18ud15_lpd4_io_b_jme.ckt
           -v dti_tm16glp_re_18ud15_lpd4_io_b_jme.v -t
           dti_tm16glp_re_18ud15_lpd4_io_b_jme -im ignoreMod -ip ignoreBus -pd
           portDirection
##########################################################################################*/
`timescale 1ns/1ps
module dti_tm16glp_re_18ud15_lpd4_io_b_jme ( CLOCKDR, DATA_H_C, DATA_H_T,
  DATA_L_C, DATA_L_T, DRVSEL0, DRVSEL1, DRVSEL2, E, EC, FENA, GT, IO_MODE0,
  IO_MODE1, IO_MODE2, MODE, MODE_I, NCTLH0, NCTLH1, NCTLH10, NCTLH11, NCTLH2,
  NCTLH3, NCTLH4, NCTLH5, NCTLH6, NCTLH7, NCTLH8, NCTLH9, ODIS, OE, PADC, PADT,
  PCTLH0, PCTLH1, PCTLH10, PCTLH11, PCTLH2, PCTLH3, PCTLH4, PCTLH5, PCTLH6,
  PCTLH7, PCTLH8, PCTLH9, PWDNH, REF, RTTSEL0, RTTSEL1, RTTSEL2, RTT_EN,
  SHIFTDR, SI_AC, SI_AT, SI_YC, SI_YT, SO_OEC, SO_OET, SO_YC, SO_YT, TH, TL,
  TX_CLK, UPDATEDR, VDD, VDDO, VSS, YC_C, YC_T, YO_C, YO_T, Y_C, Y_T );
input		CLOCKDR;
input		DATA_H_C;
input		DATA_H_T;
input		DATA_L_C;
input		DATA_L_T;
input		DRVSEL0;
input		DRVSEL1;
input		DRVSEL2;
input		E;
input		EC;
input		FENA;
input		GT;
input		IO_MODE0;
input		IO_MODE1;
input		IO_MODE2;
input		MODE;
input		MODE_I;
input		NCTLH0;
input		NCTLH1;
input		NCTLH10;
input		NCTLH11;
input		NCTLH2;
input		NCTLH3;
input		NCTLH4;
input		NCTLH5;
input		NCTLH6;
input		NCTLH7;
input		NCTLH8;
input		NCTLH9;
input		ODIS;
input		OE;
inout		PADC;
inout		PADT;
input		PCTLH0;
input		PCTLH1;
input		PCTLH10;
input		PCTLH11;
input		PCTLH2;
input		PCTLH3;
input		PCTLH4;
input		PCTLH5;
input		PCTLH6;
input		PCTLH7;
input		PCTLH8;
input		PCTLH9;
input		PWDNH;
input		REF;
input		RTTSEL0;
input		RTTSEL1;
input		RTTSEL2;
input		RTT_EN;
input		SHIFTDR;
input		SI_AC;
input		SI_AT;
input		SI_YC;
input		SI_YT;
output		SO_OEC;
output		SO_OET;
output		SO_YC;
output		SO_YT;
output		TH;
output		TL;
input		TX_CLK;
input		UPDATEDR;
input		VDD;
input		VDDO;
input		VSS;
output		YC_C;
output		YC_T;
output		YO_C;
output		YO_T;
output		Y_C;
output		Y_T;

wire		IN;
wire		INX;
wire		N1N373;
wire		N1N374;
wire		N1N390;
wire		N1N392;
wire		N1N394;
wire		N1N396;
wire		N1N405;
wire		N1N407;
tm16glp_18ud15_ddr_jtagme_io x1i146 (.VDD(VDD), .VSS(VSS), .AOUT_H(N1N373),
  .AOUT_L(N1N374), .CLOCKDR(CLOCKDR), .DATA_H(DATA_H_T), .DATA_L(DATA_L_T),
  .MODE(MODE), .MODE_I(MODE_I), .OE(OE), .OEOUT(N1N394), .SHIFTDR(SHIFTDR),
  .SI_A(SI_AT), .SI_Y(SI_YT), .SO_OE(SO_OET), .SO_Y(SO_YT), .UPDATEDR(UPDATEDR),
  .Y(Y_T), .YO(YO_T), .YRCV(N1N405));
tm16glp_18ud15_ddr_jtagme_io x1i147 (.VDD(VDD), .VSS(VSS), .AOUT_H(N1N392),
  .AOUT_L(N1N390), .CLOCKDR(CLOCKDR), .DATA_H(DATA_H_C), .DATA_L(DATA_L_C),
  .MODE(MODE), .MODE_I(MODE_I), .OE(OE), .OEOUT(N1N396), .SHIFTDR(SHIFTDR),
  .SI_A(SI_AC), .SI_Y(SI_YC), .SO_OE(SO_OEC), .SO_Y(SO_YC), .UPDATEDR(UPDATEDR),
  .Y(Y_C), .YO(YO_C), .YRCV(N1N407));
dti_tm16glp_re_18ud15_lpd4_bdiffx1 xc (.VDD(VDD), .VDDO(VDDO), .VSS(VSS),
  .DATA_H(N1N392), .DATA_L(N1N390), .DRVSEL2(DRVSEL2), .DRVSEL1(DRVSEL1),
  .DRVSEL0(DRVSEL0), .E(E), .EC(EC), .FENA(FENA), .GT(GT), .IN(INX), .INX(IN),
  .IO_MODE2(IO_MODE2), .IO_MODE1(IO_MODE1), .IO_MODE0(IO_MODE0),
  .NCTLH11(NCTLH11), .NCTLH10(NCTLH10), .NCTLH9(NCTLH9), .NCTLH8(NCTLH8),
  .NCTLH7(NCTLH7), .NCTLH6(NCTLH6), .NCTLH5(NCTLH5), .NCTLH4(NCTLH4),
  .NCTLH3(NCTLH3), .NCTLH2(NCTLH2), .NCTLH1(NCTLH1), .NCTLH0(NCTLH0),
  .ODIS(ODIS), .OE(N1N396), .PAD(PADC), .PCTLH11(PCTLH11), .PCTLH10(PCTLH10),
  .PCTLH9(PCTLH9), .PCTLH8(PCTLH8), .PCTLH7(PCTLH7), .PCTLH6(PCTLH6),
  .PCTLH5(PCTLH5), .PCTLH4(PCTLH4), .PCTLH3(PCTLH3), .PCTLH2(PCTLH2),
  .PCTLH1(PCTLH1), .PCTLH0(PCTLH0), .PWDNH(PWDNH), .REF(REF), .RTTSEL2(RTTSEL2),
  .RTTSEL1(RTTSEL1), .RTTSEL0(RTTSEL0), .RTT_EN(RTT_EN), .TH(TH), .TL(TL),
  .TX_CLK(TX_CLK), .Y(N1N407), .YC(YC_C), .GT_AH(1'b1));
dti_tm16glp_re_18ud15_lpd4_bdiffx1 xt (.VDD(VDD), .VDDO(VDDO), .VSS(VSS),
  .DATA_H(N1N373), .DATA_L(N1N374), .DRVSEL2(DRVSEL2), .DRVSEL1(DRVSEL1),
  .DRVSEL0(DRVSEL0), .E(E), .EC(EC), .FENA(FENA), .GT(GT), .IN(IN), .INX(INX),
  .IO_MODE2(IO_MODE2), .IO_MODE1(IO_MODE1), .IO_MODE0(IO_MODE0),
  .NCTLH11(NCTLH11), .NCTLH10(NCTLH10), .NCTLH9(NCTLH9), .NCTLH8(NCTLH8),
  .NCTLH7(NCTLH7), .NCTLH6(NCTLH6), .NCTLH5(NCTLH5), .NCTLH4(NCTLH4),
  .NCTLH3(NCTLH3), .NCTLH2(NCTLH2), .NCTLH1(NCTLH1), .NCTLH0(NCTLH0),
  .ODIS(ODIS), .OE(N1N394), .PAD(PADT), .PCTLH11(PCTLH11), .PCTLH10(PCTLH10),
  .PCTLH9(PCTLH9), .PCTLH8(PCTLH8), .PCTLH7(PCTLH7), .PCTLH6(PCTLH6),
  .PCTLH5(PCTLH5), .PCTLH4(PCTLH4), .PCTLH3(PCTLH3), .PCTLH2(PCTLH2),
  .PCTLH1(PCTLH1), .PCTLH0(PCTLH0), .PWDNH(PWDNH), .REF(REF), .RTTSEL2(RTTSEL2),
  .RTTSEL1(RTTSEL1), .RTTSEL0(RTTSEL0), .RTT_EN(RTT_EN), .TH(), .TL(),
  .TX_CLK(TX_CLK), .Y(N1N405), .YC(YC_T), .GT_AH(1'b0));
endmodule

module dti_tm16glp_re_18ud15_lpd4_bdiffx1 ( DATA_H, DATA_L, DRVSEL0, DRVSEL1,
  DRVSEL2, E, EC, FENA, GT, IN, INX, IO_MODE0, IO_MODE1, IO_MODE2, NCTLH0,
  NCTLH1, NCTLH10, NCTLH11, NCTLH2, NCTLH3, NCTLH4, NCTLH5, NCTLH6, NCTLH7,
  NCTLH8, NCTLH9, ODIS, OE, PAD, PCTLH0, PCTLH1, PCTLH10, PCTLH11, PCTLH2,
  PCTLH3, PCTLH4, PCTLH5, PCTLH6, PCTLH7, PCTLH8, PCTLH9, PWDNH, REF, RTTSEL0,
  RTTSEL1, RTTSEL2, RTT_EN, TH, TL, TX_CLK, VDD, VDDO, VSS, Y, YC, GT_AH );
input		DATA_H;
input		DATA_L;
input		DRVSEL0;
input		DRVSEL1;
input		DRVSEL2;
input		E;
input		EC;
input		FENA;
input		GT;
output		IN;
input		INX;
input		IO_MODE0;
input		IO_MODE1;
input		IO_MODE2;
input		NCTLH0;
input		NCTLH1;
input		NCTLH10;
input		NCTLH11;
input		NCTLH2;
input		NCTLH3;
input		NCTLH4;
input		NCTLH5;
input		NCTLH6;
input		NCTLH7;
input		NCTLH8;
input		NCTLH9;
input		ODIS;
input		OE;
inout		PAD;
input		PCTLH0;
input		PCTLH1;
input		PCTLH10;
input		PCTLH11;
input		PCTLH2;
input		PCTLH3;
input		PCTLH4;
input		PCTLH5;
input		PCTLH6;
input		PCTLH7;
input		PCTLH8;
input		PCTLH9;
input		PWDNH;
input		REF;
input		RTTSEL0;
input		RTTSEL1;
input		RTTSEL2;
input		RTT_EN;
output		TH;
output		TL;
input		TX_CLK;
input		VDD;
input		VDDO;
input		VSS;
output		Y;
output		YC;
input		GT_AH;

wire		A;
wire		OEi;

assign OEi    = PWDNH ? 1'b0 : FENA | (OE & ~ODIS);
assign A      = PWDNH ? 1'b0  : (TX_CLK? DATA_H : DATA_L);

assign TL     = 1'b0;
assign TH     = 1'b1;

bufif1 (weak0, weak1) (PAD, GT_AH, GT);

bufif1 (PAD, A, OEi);
assign Y = PAD & E;
assign YC = PAD & EC;

endmodule

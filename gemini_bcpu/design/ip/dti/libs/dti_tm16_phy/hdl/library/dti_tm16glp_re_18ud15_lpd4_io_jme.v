/*##########################################################################################
  Copyright (c) 2019 Dolphin Technology, Inc.
  This verilog is proprietary and confidential information of
  Dolphin Technology, Inc. and can only be used or viewed
  under license or with written permission from Dolphin Technology, Inc.
  Date:    8/28/2019 16:10:25
  Source:  /projects/tsmc/tm16/tm16_ddr/verilog/cir/dti_tm16glp_re_18ud15_lpd4_io_jme.ckt
  Path:    andy_dell2:/cygdrive/c/projects/tsmc/tm16/tm16_ddr/verilog/dti_tm16glp_re_18ud15_lpd4_io_jme
  Command: /work/perl3/verilog/spice2verilog.pl -sp
           /projects/tsmc/tm16/tm16_ddr/verilog/cir/dti_tm16glp_re_18ud15_lpd4_io_jme.ckt
           -v dti_tm16glp_re_18ud15_lpd4_io_jme.v -t dti_tm16glp_re_18ud15_lpd4_io_jme
           -im ignoreMod -ip ignoreBus -pd portDirection
##########################################################################################*/
`timescale 1ns/1ps
module dti_tm16glp_re_18ud15_lpd4_io_jme ( CLOCKDR, DATA_H, DATA_L, DRVSEL0,
  DRVSEL1, DRVSEL2, E, EC, EVT, FENA, GT, IO_MODE0, IO_MODE1, IO_MODE2, MODE,
  MODE_I, NCTLH0, NCTLH1, NCTLH10, NCTLH11, NCTLH2, NCTLH3, NCTLH4, NCTLH5,
  NCTLH6, NCTLH7, NCTLH8, NCTLH9, ODIS, OE, PAD, PCTLH0, PCTLH1, PCTLH10,
  PCTLH11, PCTLH2, PCTLH3, PCTLH4, PCTLH5, PCTLH6, PCTLH7, PCTLH8, PCTLH9,
  PWDNH, REF, RTTSEL0, RTTSEL1, RTTSEL2, RTT_EN, SHIFTDR, SI_A, SI_Y, SO_OE,
  SO_Y, TH, TL, TX_CLK, UPDATEDR, VDD, VDDO, VSS, Y, YC, YO, YVT );
input		CLOCKDR;
input		DATA_H;
input		DATA_L;
input		DRVSEL0;
input		DRVSEL1;
input		DRVSEL2;
input		E;
input		EC;
input		EVT;
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
input		SHIFTDR;
input		SI_A;
input		SI_Y;
output		SO_OE;
output		SO_Y;
output		TH;
output		TL;
input		TX_CLK;
input		UPDATEDR;
input		VDD;
input		VDDO;
input		VSS;
output		Y;
output		YC;
output		YO;
output		YVT;

wire		N1N129;
wire		N1N131;
wire		N1N132;
wire		N1N18;
dti_tm16glp_re_18ud15_lpd4_io x1i2 (.VDD(VDD), .VDDO(VDDO), .VSS(VSS),
  .DATA_H(N1N131), .DATA_L(N1N132), .DRVSEL2(DRVSEL2), .DRVSEL1(DRVSEL1),
  .DRVSEL0(DRVSEL0), .E(E), .EC(EC), .EVT(EVT), .FENA(FENA), .GT(GT),
  .IO_MODE2(IO_MODE2), .IO_MODE1(IO_MODE1), .IO_MODE0(IO_MODE0),
  .NCTLH11(NCTLH11), .NCTLH10(NCTLH10), .NCTLH9(NCTLH9), .NCTLH8(NCTLH8),
  .NCTLH7(NCTLH7), .NCTLH6(NCTLH6), .NCTLH5(NCTLH5), .NCTLH4(NCTLH4),
  .NCTLH3(NCTLH3), .NCTLH2(NCTLH2), .NCTLH1(NCTLH1), .NCTLH0(NCTLH0),
  .ODIS(ODIS), .OE(N1N18), .PAD(PAD), .PCTLH11(PCTLH11), .PCTLH10(PCTLH10),
  .PCTLH9(PCTLH9), .PCTLH8(PCTLH8), .PCTLH7(PCTLH7), .PCTLH6(PCTLH6),
  .PCTLH5(PCTLH5), .PCTLH4(PCTLH4), .PCTLH3(PCTLH3), .PCTLH2(PCTLH2),
  .PCTLH1(PCTLH1), .PCTLH0(PCTLH0), .PWDNH(PWDNH), .REF(REF), .RTTSEL2(RTTSEL2),
  .RTTSEL1(RTTSEL1), .RTTSEL0(RTTSEL0), .RTT_EN(RTT_EN), .TH(TH), .TL(TL),
  .TX_CLK(TX_CLK), .Y(N1N129), .YC(YC), .YVT(YVT));
tm16glp_18ud15_ddr_jtagme_io x1i3 (.VDD(VDD), .VSS(VSS), .AOUT_H(N1N131),
  .AOUT_L(N1N132), .CLOCKDR(CLOCKDR), .DATA_H(DATA_H), .DATA_L(DATA_L),
  .MODE(MODE), .MODE_I(MODE_I), .OE(OE), .OEOUT(N1N18), .SHIFTDR(SHIFTDR),
  .SI_A(SI_A), .SI_Y(SI_Y), .SO_OE(SO_OE), .SO_Y(SO_Y), .UPDATEDR(UPDATEDR),
  .Y(Y), .YO(YO), .YRCV(N1N129));
endmodule

module tm16glp_18ud15_ddr_jtagme_io ( AOUT_H, AOUT_L, CLOCKDR, DATA_H, DATA_L,
  MODE, MODE_I, OE, OEOUT, SHIFTDR, SI_A, SI_Y, SO_OE, SO_Y, UPDATEDR, VDD, VSS,
  Y, YO, YRCV );
output		AOUT_H;
output		AOUT_L;
input		CLOCKDR;
input		DATA_H;
input		DATA_L;
input		MODE;
input		MODE_I;
input		OE;
output		OEOUT;
input		SHIFTDR;
input		SI_A;
input		SI_Y;
output		SO_OE;
output		SO_Y;
input		UPDATEDR;
input		VDD;
input		VSS;
output		Y;
output		YO;
input		YRCV;

wire		N1N102;
wire		N1N16;
wire		N1N38;
wire		N1N49;
wire		N1N5;
wire		N1N87;
wire		YINT;
ddr_ckinvx1 x1i4 (.VDD(VDD), .VSS(VSS), .A(MODE_I), .Z(N1N49));
ddr_ckinvx1 x1i44 (.VDD(VDD), .VSS(VSS), .A(SHIFTDR), .Z(N1N38));
ddr_ckinvx1 x1i46 (.VDD(VDD), .VSS(VSS), .A(MODE), .Z(N1N5));
ddr_ckinvx1 x1i84 (.VDD(VDD), .VSS(VSS), .A(YINT), .Z(N1N87));
ddr_ckinvx2 x1i89 (.VDD(VDD), .VSS(VSS), .A(N1N87), .Z(Y));
ddr_ckinvx2 x1i101 (.VDD(VDD), .VSS(VSS), .A(N1N102), .Z(YO));
ddr_ckinvx1 x1i103 (.VDD(VDD), .VSS(VSS), .A(YRCV), .Z(N1N102));
tm16_jtagcell_ddr_me xbs1 (.VDD(VDD), .VSS(VSS), .DH(DATA_H), .DL(DATA_L),
  .MODEX(N1N5), .OUTH(AOUT_H), .OUTL(AOUT_L), .SHIFTX(N1N38), .SI(SI_A),
  .SO(N1N16), .CK({UPDATEDR,CLOCKDR}));
tm16_jtagcell_me xbs2 (.VDD(VDD), .VSS(VSS), .D(OE), .MODEX(N1N5), .OUT(OEOUT),
  .SHIFTX(N1N38), .SI(N1N16), .SO(SO_OE), .CK({UPDATEDR,CLOCKDR}));
tm16_jtagcell_me xbs3 (.VDD(VDD), .VSS(VSS), .D(YRCV), .MODEX(N1N49),
  .OUT(YINT), .SHIFTX(N1N38), .SI(SI_Y), .SO(SO_Y), .CK({UPDATEDR,CLOCKDR}));
endmodule

module tm16_jtagcell_me ( CK, D, MODEX, OUT, SHIFTX, SI, SO, VDD, VSS );
input	[2:1]	CK;
input		D;
input		MODEX;
output		OUT;
input		SHIFTX;
input		SI;
output		SO;
input		VDD;
input		VSS;

wire		N1N10;
wire		N1N81;
ddr_ffqx1 x1i3 (.VDD(VDD), .VSS(VSS), .D(N1N10), .CK(CK[1]), .Q(SO));
ddr_ffqx1 x1i14 (.VDD(VDD), .VSS(VSS), .D(SO), .CK(CK[2]), .Q(N1N81));
ddr_ckmux21x2 x1i77 (.VDD(VDD), .VSS(VSS), .D0(N1N81), .D1(D), .S(MODEX),
  .Z(OUT));
ddr_ckmux21x1 x1i78 (.VDD(VDD), .VSS(VSS), .D0(SI), .D1(D), .S(SHIFTX),
  .Z(N1N10));
endmodule

module ddr_ffqx1 ( CK, D, Q, VDD, VSS );
input		CK;
input		D;
output		Q;
input		VDD;
input		VSS;

reg		Q;
always @ (posedge CK) 
  Q <= D;

endmodule

module ddr_ckmux21x2 ( D0, D1, S, VDD, VSS, Z );
input		D0;
input		D1;
input		S;
input		VDD;
input		VSS;
output		Z;

assign Z = S ? D1 : D0;

endmodule

module ddr_ckmux21x1 ( D0, D1, S, VDD, VSS, Z );
input		D0;
input		D1;
input		S;
input		VDD;
input		VSS;
output		Z;

wire		N1N23;
wire		N1N27;
wire		N1N69;
wire		N1N74;

assign Z = S ? D1 : D0;
endmodule

module tm16_jtagcell_ddr_me ( CK, DH, DL, MODEX, OUTH, OUTL, SHIFTX, SI, SO,
  VDD, VSS );
input	[2:1]	CK;
input		DH;
input		DL;
input		MODEX;
output		OUTH;
output		OUTL;
input		SHIFTX;
input		SI;
output		SO;
input		VDD;
input		VSS;

wire		N1N10;
wire		N1N81;
ddr_ffqx1 x1i3 (.VDD(VDD), .VSS(VSS), .D(N1N10), .CK(CK[1]), .Q(SO));
ddr_ffqx1 x1i14 (.VDD(VDD), .VSS(VSS), .D(SO), .CK(CK[2]), .Q(N1N81));
ddr_ckmux21x2 x1i77 (.VDD(VDD), .VSS(VSS), .D0(N1N81), .D1(DL), .S(MODEX),
  .Z(OUTL));
ddr_ckmux21x1 x1i78 (.VDD(VDD), .VSS(VSS), .D0(SI), .D1(DL), .S(SHIFTX),
  .Z(N1N10));
ddr_ckmux21x2 x1i83 (.VDD(VDD), .VSS(VSS), .D0(N1N81), .D1(DH), .S(MODEX),
  .Z(OUTH));
endmodule

module ddr_ckinvx2 ( A, VDD, VSS, Z );
input		A;
input		VDD;
input		VSS;
output		Z;

not (Z, A);
endmodule

module ddr_ckinvx1 ( A, VDD, VSS, Z );
input		A;
input		VDD;
input		VSS;
output		Z;

not (Z, A);
endmodule

module dti_tm16glp_re_18ud15_lpd4_io ( DATA_H, DATA_L, DRVSEL0, DRVSEL1,
  DRVSEL2, E, EC, EVT, FENA, GT, IO_MODE0, IO_MODE1, IO_MODE2, NCTLH0, NCTLH1,
  NCTLH10, NCTLH11, NCTLH2, NCTLH3, NCTLH4, NCTLH5, NCTLH6, NCTLH7, NCTLH8,
  NCTLH9, ODIS, OE, PAD, PCTLH0, PCTLH1, PCTLH10, PCTLH11, PCTLH2, PCTLH3,
  PCTLH4, PCTLH5, PCTLH6, PCTLH7, PCTLH8, PCTLH9, PWDNH, REF, RTTSEL0, RTTSEL1,
  RTTSEL2, RTT_EN, TH, TL, TX_CLK, VDD, VDDO, VSS, Y, YC, YVT );
input		DATA_H;
input		DATA_L;
input		DRVSEL0;
input		DRVSEL1;
input		DRVSEL2;
input		E;
input		EC;
input		EVT;
input		FENA;
input		GT;
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
output		YVT;

wire		A;
wire		OEi;
wire		LP4;

assign OEi    = PWDNH ? 1'b0 : FENA | (OE & ~ODIS);
assign A      = PWDNH ? 1'b0  : (TX_CLK? DATA_H : DATA_L);

assign TL     = 1'b0;
assign TH     = 1'b1;

assign LP4 = IO_MODE0 & IO_MODE1 & IO_MODE2;

bufif1 (PAD, A, OEi);
assign Y = PAD & E;
assign YC = PAD & EC;
//assign YVT = EVT ? (REF ? PAD : ~PAD) : 1'b0;
assign YVT = EVT ? (LP4 ? ~(REF & PAD) : ~(REF | PAD)) : 1'b0;

endmodule


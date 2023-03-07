`timescale 1ns/1ps

module tm16ffc_dly ( C, FC, IN, INR, OUT, OUTR, PEN, TL, VDD, VSS );
input	[30:0]	C;
input	[6:0]	FC;
input		IN;
input		INR;
output		OUT;
output		OUTR;
input		PEN;
input		TL;
input		VDD;
input		VSS;

wire	[32:1]	F;
wire	[32:1]	R;
wire		N1N188;
wire		TH;
tm16ffc_dlyc x1i27 (.VDD(VDD), .VSS(VSS), .EN(C[22]), .ENP(C[21]),
  .IN(F[23]), .IN2X(R[24]), .INX(F[24]), .OUT(R[23]));
tm16ffc_dlyc x1i28 (.VDD(VDD), .VSS(VSS), .EN(C[21]), .ENP(C[20]),
  .IN(F[22]), .IN2X(R[23]), .INX(F[23]), .OUT(R[22]));
tm16ffc_dlyc x1i29 (.VDD(VDD), .VSS(VSS), .EN(C[20]), .ENP(C[19]),
  .IN(F[21]), .IN2X(R[22]), .INX(F[22]), .OUT(R[21]));
tm16ffc_dlyc x1i30 (.VDD(VDD), .VSS(VSS), .EN(C[19]), .ENP(C[18]),
  .IN(F[20]), .IN2X(R[21]), .INX(F[21]), .OUT(R[20]));
tm16ffc_dlyc x1i31 (.VDD(VDD), .VSS(VSS), .EN(C[23]), .ENP(C[22]),
  .IN(F[24]), .IN2X(R[25]), .INX(F[25]), .OUT(R[24]));
tm16ffc_dlyc x1i36 (.VDD(VDD), .VSS(VSS), .EN(C[24]), .ENP(C[23]),
  .IN(F[25]), .IN2X(R[26]), .INX(F[26]), .OUT(R[25]));
tm16ffc_dlyc x1i40 (.VDD(VDD), .VSS(VSS), .EN(C[25]), .ENP(C[24]),
  .IN(F[26]), .IN2X(R[27]), .INX(F[27]), .OUT(R[26]));
tm16ffc_dlyc x1i45 (.VDD(VDD), .VSS(VSS), .EN(C[26]), .ENP(C[25]),
  .IN(F[27]), .IN2X(R[28]), .INX(F[28]), .OUT(R[27]));
tm16ffc_dlyc x1i49 (.VDD(VDD), .VSS(VSS), .EN(C[27]), .ENP(C[26]),
  .IN(F[28]), .IN2X(R[29]), .INX(F[29]), .OUT(R[28]));
tm16ffc_dlyc x1i50 (.VDD(VDD), .VSS(VSS), .EN(C[28]), .ENP(C[27]),
  .IN(F[29]), .IN2X(R[30]), .INX(F[30]), .OUT(R[29]));
tm16ffc_dlyc x1i51 (.VDD(VDD), .VSS(VSS), .EN(C[29]), .ENP(C[28]),
  .IN(F[30]), .IN2X(R[31]), .INX(F[31]), .OUT(R[30]));
tm16ffc_dlyc x1i80 (.VDD(VDD), .VSS(VSS), .EN(C[13]), .ENP(C[12]),
  .IN(F[14]), .IN2X(R[15]), .INX(F[15]), .OUT(R[14]));
tm16ffc_dlyc x1i81 (.VDD(VDD), .VSS(VSS), .EN(C[12]), .ENP(C[11]),
  .IN(F[13]), .IN2X(R[14]), .INX(F[14]), .OUT(R[13]));
tm16ffc_dlyc x1i82 (.VDD(VDD), .VSS(VSS), .EN(C[11]), .ENP(C[10]),
  .IN(F[12]), .IN2X(R[13]), .INX(F[13]), .OUT(R[12]));
tm16ffc_dlyc x1i83 (.VDD(VDD), .VSS(VSS), .EN(C[10]), .ENP(C[9]),
  .IN(F[11]), .IN2X(R[12]), .INX(F[12]), .OUT(R[11]));
tm16ffc_dlyc x1i84 (.VDD(VDD), .VSS(VSS), .EN(C[9]), .ENP(C[8]),
  .IN(F[10]), .IN2X(R[11]), .INX(F[11]), .OUT(R[10]));
tm16ffc_dlyc x1i85 (.VDD(VDD), .VSS(VSS), .EN(C[14]), .ENP(C[13]),
  .IN(F[15]), .IN2X(R[16]), .INX(F[16]), .OUT(R[15]));
tm16ffc_dlyc x1i89 (.VDD(VDD), .VSS(VSS), .EN(C[15]), .ENP(C[14]),
  .IN(F[16]), .IN2X(R[17]), .INX(F[17]), .OUT(R[16]));
tm16ffc_dlyc x1i93 (.VDD(VDD), .VSS(VSS), .EN(C[16]), .ENP(C[15]),
  .IN(F[17]), .IN2X(R[18]), .INX(F[18]), .OUT(R[17]));
tm16ffc_dlyc x1i96 (.VDD(VDD), .VSS(VSS), .EN(C[17]), .ENP(C[16]),
  .IN(F[18]), .IN2X(R[19]), .INX(F[19]), .OUT(R[18]));
tm16ffc_dlyc x1i103 (.VDD(VDD), .VSS(VSS), .EN(C[8]), .ENP(C[7]),
  .IN(F[9]), .IN2X(R[10]), .INX(F[10]), .OUT(R[9]));
tm16ffc_dlyc x1i108 (.VDD(VDD), .VSS(VSS), .EN(C[7]), .ENP(C[6]),
  .IN(F[8]), .IN2X(R[9]), .INX(F[9]), .OUT(R[8]));
tm16ffc_dlyc x1i112 (.VDD(VDD), .VSS(VSS), .EN(C[6]), .ENP(C[5]),
  .IN(F[7]), .IN2X(R[8]), .INX(F[8]), .OUT(R[7]));
tm16ffc_dlyc x1i117 (.VDD(VDD), .VSS(VSS), .EN(C[5]), .ENP(C[4]),
  .IN(F[6]), .IN2X(R[7]), .INX(F[7]), .OUT(R[6]));
tm16ffc_dlyc x1i120 (.VDD(VDD), .VSS(VSS), .EN(C[1]), .ENP(C[0]),
  .IN(F[2]), .IN2X(R[3]), .INX(F[3]), .OUT(R[2]));
tm16ffc_dlyc x1i121 (.VDD(VDD), .VSS(VSS), .EN(C[2]), .ENP(C[1]),
  .IN(F[3]), .IN2X(R[4]), .INX(F[4]), .OUT(R[3]));
tm16ffc_dlyc x1i122 (.VDD(VDD), .VSS(VSS), .EN(C[3]), .ENP(C[2]),
  .IN(F[4]), .IN2X(R[5]), .INX(F[5]), .OUT(R[4]));
tm16ffc_dlyc x1i123 (.VDD(VDD), .VSS(VSS), .EN(C[4]), .ENP(C[3]),
  .IN(F[5]), .IN2X(R[6]), .INX(F[6]), .OUT(R[5]));
tm16ffc_dlyc x1i175 (.VDD(VDD), .VSS(VSS), .EN(C[0]), .ENP(TH),
  .IN(F[1]), .IN2X(R[2]), .INX(F[2]), .OUT(R[1]));
tm16ffc_dlyc x1i177 (.VDD(VDD), .VSS(VSS), .EN(C[18]), .ENP(C[17]),
  .IN(F[19]), .IN2X(R[20]), .INX(F[20]), .OUT(R[19]));
tm16ffc_dlyc x1i187 (.VDD(VDD), .VSS(VSS), .EN(TL), .ENP(C[30]),
  .IN(F[32]), .IN2X(N1N188), .INX(N1N188), .OUT(R[32]));
tm16ffc_dlyc x1i193 (.VDD(VDD), .VSS(VSS), .EN(C[30]), .ENP(C[29]),
  .IN(F[31]), .IN2X(R[32]), .INX(F[32]), .OUT(R[31]));
tm16ffc_fclq xfc (.VDD(VDD), .VSS(VSS), .IN(IN), .INC(R[1]), .INR(INR),
  .OUT(OUT), .OUTC(F[1]), .OUTR(OUTR), .TH(TH), .TL(TL), .C(FC[6:0]), .PEN(PEN));
endmodule


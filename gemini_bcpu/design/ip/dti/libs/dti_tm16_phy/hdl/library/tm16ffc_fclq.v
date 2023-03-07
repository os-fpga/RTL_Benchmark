`timescale 1ns/1ps

module tm16ffc_fclq (OUT, INC, OUTR, TH, OUTC, IN, INR, TL, C, PEN, VDD, VSS);
output		OUT;
input		INC;
output		OUTR;
output		TH;
output		OUTC;
input		IN;
input		INR;
input		TL;
input	[6:0]	C;
input		PEN;
input		VDD;
input		VSS;
wire		OUTR_int;
wire		net1;

reg		OUT;
reg		OUTR;
wire		OUTRi;

//buf (OUT, INC);
tm16ffc_dlypath_fclq x1 (.OUT(OUTR_int), .IN(INR), .C(7'b0));
tm16ffc_dlypath_fclq x2 (.OUT(OUTC),     .IN(IN),  .C(C));
tm16ffc_dlyc         x3 (.IN(OUTR_int), .INX(net1), .IN2X(1'b0), .OUT(OUTRi), .EN(1'b0), .ENP(1'b1), .VDD(VDD), .VSS(VSS));

always @ (PEN or INC)
  if (PEN)
    OUT <= INC;

always @ (PEN or OUTRi)
  if (PEN)
    OUTR <= OUTRi;


not (TH, TL);

endmodule


module tm16ffc_dlypath_fclq (OUT, IN, C);
output		OUT;
input		IN;
input	[6:0]	C;

buf(OUT, IN);
specify
  if (C[6]==1'b0 && C[5]==1'b0 && C[4]==1'b0 && C[3]==1'b0 && C[2]==1'b0 && C[1]==1'b0 && C[0]==1'b0) (IN=>OUT) = (0.045, 0.045);
  if (C[6]==1'b0 && C[5]==1'b0 && C[4]==1'b0 && C[3]==1'b0 && C[2]==1'b0 && C[1]==1'b0 && C[0]==1'b1) (IN=>OUT) = (0.055, 0.055);
  if (C[6]==1'b0 && C[5]==1'b0 && C[4]==1'b0 && C[3]==1'b0 && C[2]==1'b0 && C[1]==1'b1 && C[0]==1'b1) (IN=>OUT) = (0.065, 0.065);
  if (C[6]==1'b0 && C[5]==1'b0 && C[4]==1'b0 && C[3]==1'b0 && C[2]==1'b1 && C[1]==1'b1 && C[0]==1'b1) (IN=>OUT) = (0.075, 0.075);
  if (C[6]==1'b0 && C[5]==1'b0 && C[4]==1'b0 && C[3]==1'b1 && C[2]==1'b1 && C[1]==1'b1 && C[0]==1'b1) (IN=>OUT) = (0.085, 0.085);
  if (C[6]==1'b0 && C[5]==1'b0 && C[4]==1'b1 && C[3]==1'b1 && C[2]==1'b1 && C[1]==1'b1 && C[0]==1'b1) (IN=>OUT) = (0.095, 0.085);
  if (C[6]==1'b0 && C[5]==1'b1 && C[4]==1'b1 && C[3]==1'b1 && C[2]==1'b1 && C[1]==1'b1 && C[0]==1'b1) (IN=>OUT) = (0.105, 0.105);
  if (C[6]==1'b1 && C[5]==1'b1 && C[4]==1'b1 && C[3]==1'b1 && C[2]==1'b1 && C[1]==1'b1 && C[0]==1'b1) (IN=>OUT) = (0.115, 0.115);
endspecify
endmodule

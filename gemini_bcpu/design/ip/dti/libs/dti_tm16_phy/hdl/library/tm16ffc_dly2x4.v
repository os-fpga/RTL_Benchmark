module tm16ffc_dly2x4 ( CL, CLK1R, CLK2R, CLK3D, CLK3R, CLK4D, CLK4R, CLKI, CR,
  FCL, FCR, PEN, TL, VDD, VSS );
input	[30:0]	CL;
output		CLK1R;
output		CLK2R;
output		CLK3D;
output		CLK3R;
output		CLK4D;
output		CLK4R;
input		CLKI;
input	[30:0]	CR;
input	[6:0]	FCL;
input	[6:0]	FCR;
input		PEN;
input		TL;
input		VDD;
input 		VSS;

wire		CLK1D;
wire		CLK2D;
wire		CLKX2D;
wire		CLKX2R;
wire		CLKX3D;
wire		CLKX3R;
wire		CLKX4D;
wire		CLKX4R;
dti_16f_9t_96_invx1 x1i72 (.A(CLKX4R), .Z(CLK4R), .VDD(VDD), .VSS(VSS));
dti_16f_9t_96_invx1 x1i73 (.A(CLKX3R), .Z(CLK3R), .VDD(VDD), .VSS(VSS));
dti_16f_9t_96_invx1 x1i74 (.A(CLKX4D), .Z(CLK4D), .VDD(VDD), .VSS(VSS));
dti_16f_9t_96_invx1 x1i75 (.A(CLKX3D), .Z(CLK3D), .VDD(VDD), .VSS(VSS));
dti_16f_9t_96_invx1 x1i76 (.A(CLK2D), .Z(CLKX2D), .VDD(VDD), .VSS(VSS));
dti_16f_9t_96_invx1 x1i77 (.A(CLK2R), .Z(CLKX2R), .VDD(VDD), .VSS(VSS));
tm16ffc_dly xph0 (.IN(CLKI), .INR(CLKI), .OUT(CLK1D), .OUTR(CLK1R), .PEN(PEN),
  .TL(TL), .FC(FCL[6:0]), .C(CL[30:0]), .VDD(VDD), .VSS(VSS));
tm16ffc_dly xph1 (.IN(CLK1D), .INR(CLK1R), .OUT(CLK2D), .OUTR(CLK2R), .PEN(PEN),
  .TL(TL), .FC(FCL[6:0]), .C(CL[30:0]), .VDD(VDD), .VSS(VSS));
tm16ffc_dly xph2 (.IN(CLKX2D), .INR(CLKX2R), .OUT(CLKX3D), .OUTR(CLKX3R),
  .PEN(PEN), .TL(TL), .FC(FCR[6:0]), .C(CR[30:0]), .VDD(VDD), .VSS(VSS));
tm16ffc_dly xph3 (.IN(CLKX3D), .INR(CLKX3R), .OUT(CLKX4D), .OUTR(CLKX4R),
  .PEN(PEN), .TL(TL), .FC(FCR[6:0]), .C(CR[30:0]), .VDD(VDD), .VSS(VSS));
endmodule

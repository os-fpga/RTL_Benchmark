
module dly_16f_9t_96_ckbufx4 (VDD, VSS, A, Z);
input	VDD;
input	VSS;
input	A;
output	Z;

wire	Zint;
dti_16f_9t_96_ckbufx4 xgate (
  .VDD(VDD),
  .VSS(VSS),
  .A(A),
  .Z(Zint)
);

assign #(0.010) Z = Zint;
endmodule

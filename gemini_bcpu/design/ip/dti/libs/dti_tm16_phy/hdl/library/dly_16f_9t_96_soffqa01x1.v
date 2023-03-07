
module dly_16f_9t_96_soffqa01x1 (VDD, VSS, CK, D, Q, RN, SD, SE, SO);
input	VDD;
input	VSS;
input	CK;
input	D;
output	Q;
input	RN;
input	SD;
input	SE;
output	SO;

assign #(0.02) Dint = D;
dti_16f_9t_96_soffqbcka01x1 flop (
  .VDD(VDD),
  .VSS(VSS),
  .CK(CK),
  .D(Dint),
  .Q(Q),
  .RN(RN),
  .SD(SD),
  .SE(SE),
  .SO(SO)
);

endmodule

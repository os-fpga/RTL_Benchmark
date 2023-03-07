
module dly_16f_9t_96_llqx1 (VDD, VSS, CPN, D, Q);
input	VDD;
input	VSS;
input	CPN;
input	D;
output	Q;

assign #(0.02) Dint = D;
dti_16f_9t_96_llqx1 latch (
  .VDD(VDD),
  .VSS(VSS),
  .CPN(CPN),
  .D(Dint),
  .Q(Q)
);

endmodule

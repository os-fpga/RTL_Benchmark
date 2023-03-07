`timescale 1ns/1ps

module tm16ffc_dlyc (IN, INX, IN2X, OUT, EN, ENP, VDD, VSS);
input   IN, IN2X, EN, ENP;
output  OUT, INX;
input	VDD;
input	VSS;

assign INX = ~(IN & ENP);
assign OUT = EN ? ~IN2X : IN;

specify
  (IN => INX) = (0.030, 0.030);
  if (EN) (IN2X => OUT) = (0.040, 0.040);
  if (~EN) (IN => OUT) = (0.072, 0.073);
endspecify
endmodule


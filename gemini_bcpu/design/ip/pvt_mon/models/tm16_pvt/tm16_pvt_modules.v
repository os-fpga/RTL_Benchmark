`timescale 1ns/1ps

module tm16_pmon_rosc ( EN, OUT, VDDR, VSS );
input		EN;
output		OUT;
input		VDDR;
input		VSS;

wire		N1N221;
wire		N1N223;
wire		N1N233;
wire		N1N234;
wire		N1N237;
wire		N1N240;
wire		N1N243;
wire		N1N246;
wire		N1N249;
wire		N1N254;
wire		N1N257;
wire		N1N259;
wire		N1N263;
wire		N1N265;
wire		N1N267;
wire		N1N269;
wire		N1N271;
wire		N1N273;
wire		N1N274;
wire		N1N276;
wire		N1N280;
wire		N1N282;
wire		N1N283;
wire		N1N285;
wire		N1N287;
wire		N1N289;
wire		N1N291;
wire		N1N293;
wire		N1N297;
wire		N1N299;
wire		N1N303;
wire		N1N305;
wire		N1N307;
wire		N1N309;
wire		N1N315;
wire		N1N322;
wire		N1N325;
nand (N1N223, N1N221, EN);
inv_p x1i222 (.VSS(VSS), .A(N1N223), .Z(N1N233), .PWR(VDDR));
inv_p x1i225 (.VSS(VSS), .A(N1N223), .Z(OUT), .PWR(VDDR));
inv_p x1i232 (.VSS(VSS), .A(N1N233), .Z(N1N234), .PWR(VDDR));
inv_p x1i236 (.VSS(VSS), .A(N1N234), .Z(N1N237), .PWR(VDDR));
inv_p x1i239 (.VSS(VSS), .A(N1N237), .Z(N1N240), .PWR(VDDR));
inv_p x1i242 (.VSS(VSS), .A(N1N240), .Z(N1N243), .PWR(VDDR));
inv_p x1i245 (.VSS(VSS), .A(N1N243), .Z(N1N246), .PWR(VDDR));
inv_p x1i248 (.VSS(VSS), .A(N1N246), .Z(N1N249), .PWR(VDDR));
inv_p x1i251 (.VSS(VSS), .A(N1N249), .Z(N1N254), .PWR(VDDR));
inv_p x1i253 (.VSS(VSS), .A(N1N254), .Z(N1N257), .PWR(VDDR));
inv_p x1i256 (.VSS(VSS), .A(N1N257), .Z(N1N299), .PWR(VDDR));
inv_p x1i260 (.VSS(VSS), .A(N1N299), .Z(N1N259), .PWR(VDDR));
inv_p x1i261 (.VSS(VSS), .A(N1N259), .Z(N1N263), .PWR(VDDR));
inv_p x1i262 (.VSS(VSS), .A(N1N263), .Z(N1N265), .PWR(VDDR));
inv_p x1i264 (.VSS(VSS), .A(N1N265), .Z(N1N267), .PWR(VDDR));
inv_p x1i266 (.VSS(VSS), .A(N1N267), .Z(N1N269), .PWR(VDDR));
inv_p x1i268 (.VSS(VSS), .A(N1N269), .Z(N1N271), .PWR(VDDR));
inv_p x1i270 (.VSS(VSS), .A(N1N271), .Z(N1N273), .PWR(VDDR));
inv_p x1i272 (.VSS(VSS), .A(N1N273), .Z(N1N274), .PWR(VDDR));
inv_p x1i275 (.VSS(VSS), .A(N1N274), .Z(N1N276), .PWR(VDDR));
inv_p x1i277 (.VSS(VSS), .A(N1N276), .Z(N1N303), .PWR(VDDR));
inv_p x1i279 (.VSS(VSS), .A(N1N280), .Z(N1N315), .PWR(VDDR));
inv_p x1i281 (.VSS(VSS), .A(N1N282), .Z(N1N280), .PWR(VDDR));
inv_p x1i284 (.VSS(VSS), .A(N1N283), .Z(N1N282), .PWR(VDDR));
inv_p x1i286 (.VSS(VSS), .A(N1N285), .Z(N1N283), .PWR(VDDR));
inv_p x1i288 (.VSS(VSS), .A(N1N287), .Z(N1N285), .PWR(VDDR));
inv_p x1i290 (.VSS(VSS), .A(N1N289), .Z(N1N287), .PWR(VDDR));
inv_p x1i292 (.VSS(VSS), .A(N1N291), .Z(N1N289), .PWR(VDDR));
inv_p x1i294 (.VSS(VSS), .A(N1N293), .Z(N1N291), .PWR(VDDR));
inv_p x1i295 (.VSS(VSS), .A(N1N297), .Z(N1N293), .PWR(VDDR));
inv_p x1i296 (.VSS(VSS), .A(N1N303), .Z(N1N297), .PWR(VDDR));
inv_p x1i310 (.VSS(VSS), .A(N1N309), .Z(N1N305), .PWR(VDDR));
inv_p x1i311 (.VSS(VSS), .A(N1N221), .Z(N1N309), .PWR(VDDR));
inv_p x1i312 (.VSS(VSS), .A(N1N307), .Z(N1N221), .PWR(VDDR));
inv_p x1i313 (.VSS(VSS), .A(N1N315), .Z(N1N307), .PWR(VDDR));
inv_p x1i321 (.VSS(VSS), .A(N1N305), .Z(N1N322), .PWR(VDDR));
inv_p x1i324 (.VSS(VSS), .A(N1N322), .Z(N1N325), .PWR(VDDR));
endmodule

module inv_p ( A, PWR, VSS, Z );
input		A;
input		PWR;
input		VSS;
output		Z;
not #(0.005:0.006:0.009, 0.005:0.007:0.009) (Z, A);
endmodule

module tm16_pmon_lvlsh ( IN, OUT, VDDIN, VDDOUT, VSS );
input           IN;
output          OUT;
input           VDDIN;
input           VDDOUT;
input           VSS;

buf (OUT, IN);
endmodule

module tm16_pmon_ckout ( IN, OUT, VDD, VDDIN, VSS );
input           IN;
output          OUT;
input           VDD;
input           VDDIN;
input           VSS;

buf (OUT, IN);
endmodule

module tm16_ts_lvlsh ( A, VDD, VDDO, VSS, ZH, ZXH );
input           A;
input           VDD;
input           VDDO;
input           VSS;
output          ZH;
output          ZXH;

not (ZXH, A);
buf (ZH, A);
endmodule

module tm16_pvt_bias ( B, BIAS, E, EH, NB1, NB2, PB1, PB2, REF, TRIM, TSTEN, TSTOUT, VDD, VDDO, VSS );
output          B;
output          BIAS;
input           E;
output          EH;
output   	NB1, NB2;
output      	PB1, PB2;
output          REF;
input   [3:0]   TRIM;
input           TSTEN;
inout           TSTOUT;
input           VDD;
input           VDDO;
input           VSS;

bufif1(TSTOUT, 1'b0, TSTEN);
assign PB1 = E;
assign PB1 = E;
assign NB1 = E;
assign NB2 = E;
assign REF = E;
assign BIAS = E;
buf (EH, E);
assign B = E;
endmodule

module tm16_ts_adc ( BG, BIAS, C, CMPOUT, E, EH, NB1, NB2, PB1, PB2, TSTEN, TSTOUT, VDD, VDDO, VSS );
input           BG;
input           BIAS;
input   [8:0]   C;
output          CMPOUT;
input           E;
input           EH;
input   	NB1, NB2;
input     	PB1, PB2;
input           TSTEN;
inout           TSTOUT;
input           VDD;
input           VDDO;
input           VSS;

bufif1(TSTOUT, 1'b1, TSTEN);
assign CMPOUT = (C >= `TS_REF) ? 1'b1 : 1'b0;
endmodule

module tm16_vmon_adc ( BIAS, C, CMPOUT, E, NB1, NB2, PB1, PB2, TSTEN, TSTOUT, VDD, VDDO, VIN, VMRANGE, VSS );
input           BIAS;
input   [8:0]   C;
output          CMPOUT;
input           E;
input   	NB1, NB2;
input      	PB1, PB2;
input           TSTEN;
inout           TSTOUT;
input           VDD;
input           VDDO;
input           VIN;
input           VMRANGE;
input           VSS;

bufif1(TSTOUT, 1'b1, TSTEN);
assign CMPOUT = (C >= `VM_REF) ? VIN : 1'b0;
endmodule

module tm16_pmon_reg ( NB1, NB2, PB1, REF, VDD, VDDO, VDDR, VSS, TSTEN, TSTOUT);
input           NB1;
input           NB2;
input           PB1;
input           REF;
input           TSTEN;
inout           TSTOUT;
input		VDD;
input		VDDO;
output          VDDR;
input           VSS;
assign VDDR = 1'b1;
bufif1(TSTOUT, VDDR, TSTEN);
endmodule


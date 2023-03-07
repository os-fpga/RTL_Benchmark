/*##########################################################################################
  Copyright (c) 2013 Dolphin Technology, Inc.
  This verilog is proprietary and confidential information of
  Dolphin Technology, Inc. and can only be used or viewed
  under license or with written permission from Dolphin Technology, Inc.
##########################################################################################*/
`timescale 1ns/1ps
module dti_tm16glp_re_18ud15_lpd4_vss_buf_jme ( 
  NCTLH0, NCTLH1, NCTLH10, NCTLH11, NCTLH2, NCTLH3, NCTLH4,
  NCTLH5, NCTLH6, NCTLH7, NCTLH8, NCTLH9, PCTLH0, PCTLH1, PCTLH10, PCTLH11, 
  PCTLH2, PCTLH3, PCTLH4, PCTLH5, PCTLH6, PCTLH7, PCTLH8, PCTLH9, 
  NCTLHD0, NCTLHD1, NCTLHD10, NCTLHD11, NCTLHD2, NCTLHD3, NCTLHD4,
  NCTLHD5, NCTLHD6, NCTLHD7, NCTLHD8, NCTLHD9, PCTLHD0, PCTLHD1, PCTLHD10, PCTLHD11, 
  PCTLHD2, PCTLHD3, PCTLHD4, PCTLHD5, PCTLHD6, PCTLHD7, PCTLHD8, PCTLHD9, 
  PWDNH, PWDNHD, REF, 
  VDD, VDDO, VSS );
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
output		NCTLHD0;
output		NCTLHD1;
output		NCTLHD10;
output		NCTLHD11;
output		NCTLHD2;
output		NCTLHD3;
output		NCTLHD4;
output		NCTLHD5;
output		NCTLHD6;
output		NCTLHD7;
output		NCTLHD8;
output		NCTLHD9;
output		PCTLHD0;
output		PCTLHD1;
output		PCTLHD10;
output		PCTLHD11;
output		PCTLHD2;
output		PCTLHD3;
output		PCTLHD4;
output		PCTLHD5;
output		PCTLHD6;
output		PCTLHD7;
output		PCTLHD8;
output		PCTLHD9;
input		PWDNH;
output		PWDNHD;
input		REF;
input		VDD;
input		VDDO;
input		VSS;

buf(PCTLHD11, PCTLH11);
buf(PCTLHD10, PCTLH10);
buf(PCTLHD9,  PCTLH9);
buf(PCTLHD8,  PCTLH8);
buf(PCTLHD7,  PCTLH7);
buf(PCTLHD6,  PCTLH6);
buf(PCTLHD5,  PCTLH5);
buf(PCTLHD4,  PCTLH4);
buf(PCTLHD3,  PCTLH3);
buf(PCTLHD2,  PCTLH2);
buf(PCTLHD1,  PCTLH1);
buf(PCTLHD0,  PCTLH0);

buf(NCTLHD11, NCTLH11);
buf(NCTLHD10, NCTLH10);
buf(NCTLHD9,  NCTLH9);
buf(NCTLHD8,  NCTLH8);
buf(NCTLHD7,  NCTLH7);
buf(NCTLHD6,  NCTLH6);
buf(NCTLHD5,  NCTLH5);
buf(NCTLHD4,  NCTLH4);
buf(NCTLHD3,  NCTLH3);
buf(NCTLHD2,  NCTLH2);
buf(NCTLHD1,  NCTLH1);
buf(NCTLHD0,  NCTLH0);

buf(PWDNHD,  PWDNH);


endmodule

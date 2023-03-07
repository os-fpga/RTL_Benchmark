/*##########################################################################################
  Copyright (c) 2013 Dolphin Technology, Inc.
  This verilog is proprietary and confidential information of
  Dolphin Technology, Inc. and can only be used or viewed
  under license or with written permission from Dolphin Technology, Inc.
##########################################################################################*/
`timescale 1ns/1ps
module dti_tm16glp_re_18ud15_lpd4_pwrdn_jme ( 
  NCTLH0, NCTLH1, NCTLH10, NCTLH11, NCTLH2, NCTLH3, NCTLH4,
  NCTLH5, NCTLH6, NCTLH7, NCTLH8, NCTLH9, PCTLH0, PCTLH1, PCTLH10, PCTLH11, 
  PCTLH2, PCTLH3, PCTLH4, PCTLH5, PCTLH6, PCTLH7, PCTLH8, PCTLH9, PWDNH, REF, 
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
output		PWDNH;
input		REF;
input		VDD;
input		VDDO;
input		VSS;

assign PWDNH = ~VDD;

endmodule

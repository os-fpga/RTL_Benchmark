/*##########################################################################################
  Copyright (c) 2014 Dolphin Technology, Inc.
  This verilog is proprietary and confidential information of
  Dolphin Technology, Inc. and can only be used or viewed
  under license or with written permission from Dolphin Technology, Inc.
##########################################################################################*/
`timescale 1ns/1ps
module dti_tm16glp_re_18ud15_lpd4_ref_jme ( E, E_OBS, IO_MODE0, IO_MODE1, IO_MODE2,
  NCTLH0, NCTLH1, NCTLH10, NCTLH11,
  NCTLH2, NCTLH3, NCTLH4, NCTLH5, NCTLH6, NCTLH7,
  NCTLH8, NCTLH9, PAD, PCTLH0, PCTLH1, PCTLH10, PCTLH11, 
  PCTLH2, PCTLH3, PCTLH4, PCTLH5, PCTLH6, PCTLH7, PCTLH8, PCTLH9,
  PWDNH, REF, REF_CTL0, REF_CTL1, REF_CTL2, REF_CTL3, REF_CTL4, REF_CTL5,
  VT_RANGE, VDDO, VDD, VSS );
input		E;
input		E_OBS;
input		IO_MODE0;
input		IO_MODE1;
input		IO_MODE2;
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
inout		PAD;
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
input		PWDNH;
output		REF;
input		REF_CTL0;
input		REF_CTL1;
input		REF_CTL2;
input		REF_CTL3;
input		REF_CTL4;
input		REF_CTL5;
input		VT_RANGE;
input		VDDO;
input		VDD;
input		VSS;

wire	[5:0]	vref_set;

assign vref_set = {REF_CTL5,REF_CTL4,REF_CTL3,REF_CTL2,REF_CTL1,REF_CTL0};
assign REF = ~PWDNH & (E ? (vref_set >= 6'd32 ? 1'b1 : 1'b0) : PAD);
//assign REF = ~PWDNH & (E | PAD);
endmodule


/*##########################################################################################
  Copyright (c) 2022 Dolphin Technology, Inc.
  This verilog is proprietary and confidential information of
  Dolphin Technology, Inc. and can only be used or viewed
  under license or with written permission from Dolphin Technology, Inc.
  Date:    6/1/2022 18:11:13
##########################################################################################*/
`timescale 1ns/1ps

module dti_tm16ffc_18ud15_lpd4_testpad_jme (
TPCK32,
IO_MODE2, 
IO_MODE1, 
IO_MODE0, 
TSTIO_PCTLH11,  
TSTIO_PCTLH10,  
TSTIO_PCTLH9,  
TSTIO_PCTLH8,  
TSTIO_PCTLH7,  
TSTIO_PCTLH6,  
TSTIO_PCTLH5,  
TSTIO_PCTLH4,  
TSTIO_PCTLH3,  
TSTIO_PCTLH2,  
TSTIO_PCTLH1,  
TSTIO_PCTLH0,  
TSTIO_NCTLH11,  
TSTIO_NCTLH10,  
TSTIO_NCTLH9,  
TSTIO_NCTLH8,  
TSTIO_NCTLH7,  
TSTIO_NCTLH6,  
TSTIO_NCTLH5,  
TSTIO_NCTLH4,  
TSTIO_NCTLH3,  
TSTIO_NCTLH2,  
TSTIO_NCTLH1,  
TSTIO_NCTLH0,  
PD,
SEL,
Y,  
E,  
NCTLH0,  
NCTLH1,  
NCTLH2,  
NCTLH3,  
NCTLH4,  
NCTLH5,  
NCTLH6,  
NCTLH7,  
NCTLH8,  
NCTLH9,  
NCTLH10, 
NCTLH11,  
PCTLH0,  
PCTLH1,  
PCTLH2,  
PCTLH3,  
PCTLH4,  
PCTLH5,  
PCTLH6,  
PCTLH7,  
PCTLH8,  
PCTLH9,  
PCTLH10,  
PCTLH11,  
PWDNH,  
REF,  
PAD,  
VDD, 
VSS, 
VDDO 
); 

input 	TPCK32;
input 	IO_MODE2;
input 	IO_MODE1;
input 	IO_MODE0;
input 	PD; 
input 	SEL; 
input 	TSTIO_PCTLH11; 
input 	TSTIO_PCTLH10; 
input 	TSTIO_PCTLH9; 
input 	TSTIO_PCTLH8; 
input 	TSTIO_PCTLH7; 
input 	TSTIO_PCTLH6; 
input 	TSTIO_PCTLH5; 
input 	TSTIO_PCTLH4; 
input 	TSTIO_PCTLH3; 
input 	TSTIO_PCTLH2; 
input 	TSTIO_PCTLH1; 
input 	TSTIO_PCTLH0; 
input 	TSTIO_NCTLH11; 
input 	TSTIO_NCTLH10; 
input 	TSTIO_NCTLH9; 
input 	TSTIO_NCTLH8; 
input 	TSTIO_NCTLH7; 
input 	TSTIO_NCTLH6; 
input 	TSTIO_NCTLH5; 
input 	TSTIO_NCTLH4; 
input 	TSTIO_NCTLH3; 
input 	TSTIO_NCTLH2; 
input 	TSTIO_NCTLH1; 
input 	TSTIO_NCTLH0; 

output 	Y; 
input 	E; 
input 	NCTLH0; 
input 	NCTLH1; 
input 	NCTLH2; 
input 	NCTLH3; 
input 	NCTLH4; 
input 	NCTLH5; 
input 	NCTLH6; 
input 	NCTLH7; 
input 	NCTLH8; 
input 	NCTLH9; 
input 	NCTLH10; 
input 	NCTLH11; 
input 	PCTLH0; 
input 	PCTLH1; 
input 	PCTLH2; 
input 	PCTLH3; 
input 	PCTLH4; 
input 	PCTLH5; 
input 	PCTLH6; 
input 	PCTLH7; 
input 	PCTLH8; 
input 	PCTLH9; 
input 	PCTLH10; 
input 	PCTLH11; 
input 	PWDNH; 
input 	REF; 
inout 	PAD; 
input 	VDDO; 
input 	VDD; 
input 	VSS; 

assign #1 Y = E ? (PD ? TSTIO_NCTLH9 : ~TSTIO_PCTLH8) : 1'b0;

endmodule 

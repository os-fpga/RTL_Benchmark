// Silicon Creations
// Copyright 2019 Silicon Creations LLC. All rights reserved.
// date : Thu Mar 21 05:15:30 EDT 2019
// support@siliconcr.com

`timescale 1ps/1fs

module PLLTS16FFCFRACF ( 
DACEN,
DSKEWCALBYP,
DSKEWCALCNT,
DSKEWCALEN,
DSKEWCALIN,
DSKEWFASTCAL,
DSMEN,
FBDIV,
FOUTCMLEN,
FOUTDIFFEN,
FOUTEN,
FOUTVCOBYP,
FOUTVCOEN,
FRAC,
FREF,
FREFCMLEN,
FREFCMLN,
FREFCMLP,
PLLEN,
POSTDIV0,
POSTDIV1,
POSTDIV2,
POSTDIV3,
POSTDIV4,
REFDIV,
CLKSSCG,
DSKEWCALLOCK,
DSKEWCALOUT,
FOUT,
FOUTCMLN,
FOUTCMLP,
FOUTDIFFN,
FOUTDIFFP,
FOUTVCO,
LOCK
);

input wire  FOUTDIFFEN;
input wire  FOUTCMLEN;
input wire [3:0] FOUTEN;
input wire  FOUTVCOEN;
input wire  FREFCMLEN;
input wire  DACEN;
input wire  DSMEN;
input wire [4:0] FOUTVCOBYP;
input wire [1:0] POSTDIV4;
input wire [3:0] POSTDIV3;
input wire [3:0] POSTDIV2;
input wire [3:0] POSTDIV1;
input wire [3:0] POSTDIV0;
input wire  FREF;
input wire  FREFCMLP;
input wire  FREFCMLN;
input wire  PLLEN;
input wire [5:0] REFDIV;
input wire [11:0] FBDIV;
input wire [23:0] FRAC;
input wire  DSKEWCALEN;
input wire  DSKEWFASTCAL;
input wire [2:0] DSKEWCALCNT;
input wire [11:0] DSKEWCALIN;
input wire  DSKEWCALBYP;
output wire   DSKEWCALLOCK;
output wire  [11:0] DSKEWCALOUT;
output wire   CLKSSCG;
output wire   FOUTVCO;
output wire   FOUTDIFFP;
output wire   FOUTDIFFN;
output wire   FOUTCMLP;
output wire   FOUTCMLN;
output wire  [3:0] FOUT;
output wire   LOCK;


/*output  	*/ assign DSKEWCALLOCK	='d0;
/*output [11:0] */ assign DSKEWCALOUT	='d0;
/*output  	*/ assign CLKSSCG	='d0;
/*output 	*/ assign FOUTVCO	='d0;
/*output  	*/ assign FOUTDIFFP	='d0;
/*output  	*/ assign FOUTDIFFN	='d0;
/*output  	*/ assign FOUTCMLP	='d0;
/*output  	*/ assign FOUTCMLN	='d0;
/*output [3:0] 	*/ assign FOUT		='d0;
/*output  	*/ assign LOCK		='d1;

endmodule


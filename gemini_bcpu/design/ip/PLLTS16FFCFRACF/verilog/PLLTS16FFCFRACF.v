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
`ifdef PLLTS16FFCFRACF_PWR_AWARE
,VDDPOST
,VDDHV
,VDDREF
,VSS
`endif
);


// inputs 
input  FOUTDIFFEN;
// For glitch-free operation when enable goes high, FOUTCMLEN must be 0 (or changed to 1 after FOUTDIFFEN is enabled)
// 0 -> FOUTDIFFP pseudo-differential positive phase output clock is powered down (output held at 1'b0)
//      FOUTDIFFN pseudo-differential negative phase output clock is powered down (output held at 1'b1)
// 1 -> FOUTDIFFP pseudo-differential positive phase output clock is enabled (Frequency is FVCO/(POSTDIV4 value))
//      FOUTDIFFN pseudo-differential negative phase output clock is enabled (Frequency is FVCO/(POSTDIV4 value))

input  FOUTCMLEN;
// 0 -> FOUTCMLP CML positive phase output clock is powered down (output at 0V)
//      FOUTCMLN CML negative phase output clock is powered down (output at 0V)
// 1 -> FOUTCMLP CML positive phase output clock is enabled (Frequency is FVCO/(POSTDIV4 value))
//      FOUTCMLN CML negative phase output clock is enabled (Frequency is FVCO/(POSTDIV4 value))

input [3:0] FOUTEN;
// Bit-wise Post Divide Enable
// FOUTEN[3] enables FOUT[3]
// FOUTEN[2] enables FOUT[2]
// FOUTEN[1] enables FOUT[1]
// FOUTEN[0] enables FOUT[0]
// 0 -> Respective FOUT clock is powered down (output held at 1'b0)
// 1 -> Respective FOUT clock is enabled

input  FOUTVCOEN;
// VCO rate output clock (FOUTVCO) enable
// 0 -> FOUTVCO is powered down (output is held at 1'b0)
// 1 -> FOUTVCO is enabled

input  FREFCMLEN;
// Enable FREF CML Input
// 0 -> Reference clock input is taken from single-ended CMOS level input FREF
// 1 -> Reference clock input is taken from differential CML level inputs FREFCMLP and FREFCMLN

input  DACEN;
// Enable fractional noise canceling DAC in FRAC mode (this has no function in integer mode)
// 0 -> Fractional noise canceling DAC is not active (test mode only)
// 1 -> Fractional noise canceling DAC is active (default mode)

input  DSMEN;
// Enable Delta-Sigma Modulator
// 0 -> DSM is powered down (integer mode)
// 1 -> DSM is active (fractional mode)

input [4:0] FOUTVCOBYP;
// Bypasses undivided VCO clock to respective output
// FOUTVCOBYP[4]=1 bypasses the VCO clock to FOUTCMLP, (inverted to) FOUTCMLN, FOUTDIFFP, (inverted to) FOUTDIFFN
// FOUTVCOBYP[3]=1 bypasses the VCO clock to FOUT[3]
// FOUTVCOBYP[2]=1 bypasses the VCO clock to FOUT[2]
// FOUTVCOBYP[1]=1 bypasses the VCO clock to FOUT[1]
// FOUTVCOBYP[0]=1 bypasses the VCO clock to FOUT[0]

input [1:0] POSTDIV4;
// PLL post divide 4 setting (4 to 12)
// 2'b11=divide-by-12
// 2'b10=divide-by-8
// 2'b01=divide-by-6
// 2'b00=divide-by-4

input [3:0] POSTDIV3;
// PLL post divide 3 setting (2 to 64)
// 4'b1111=divide-by-64
// 4'b1110=divide-by-48
// 4'b1101=divide-by-40
// 4'b1100=divide-by-32
// 4'b1011=divide-by-24
// 4'b1010=divide-by-20
// 4'b1001=divide-by-16
// 4'b1000=divide-by-12
// 4'b0111=divide-by-10
// 4'b0110=divide-by-8
// 4'b0101=divide-by-6
// 4'b0100=divide-by-5
// 4'b0011=divide-by-4
// 4'b0010=divide-by-3
// 4'b0001=divide-by-2
// 4'b0000=FREF bypassed to output

input [3:0] POSTDIV2;
// PLL post divide 2 setting (2 to 64)
// 4'b1111=divide-by-64
// 4'b1110=divide-by-48
// 4'b1101=divide-by-40
// 4'b1100=divide-by-32
// 4'b1011=divide-by-24
// 4'b1010=divide-by-20
// 4'b1001=divide-by-16
// 4'b1000=divide-by-12
// 4'b0111=divide-by-10
// 4'b0110=divide-by-8
// 4'b0101=divide-by-6
// 4'b0100=divide-by-5
// 4'b0011=divide-by-4
// 4'b0010=divide-by-3
// 4'b0001=divide-by-2
// 4'b0000=FREF bypassed to output

input [3:0] POSTDIV1;
// PLL post divide 1 setting (2 to 64)
// 4'b1111=divide-by-64
// 4'b1110=divide-by-48
// 4'b1101=divide-by-40
// 4'b1100=divide-by-32
// 4'b1011=divide-by-24
// 4'b1010=divide-by-20
// 4'b1001=divide-by-16
// 4'b1000=divide-by-12
// 4'b0111=divide-by-10
// 4'b0110=divide-by-8
// 4'b0101=divide-by-6
// 4'b0100=divide-by-5
// 4'b0011=divide-by-4
// 4'b0010=divide-by-3
// 4'b0001=divide-by-2
// 4'b0000=FREF bypassed to output

input [3:0] POSTDIV0;
// PLL post divide 0 setting (2 to 64)
// 4'b1111=divide-by-64
// 4'b1110=divide-by-48
// 4'b1101=divide-by-40
// 4'b1100=divide-by-32
// 4'b1011=divide-by-24
// 4'b1010=divide-by-20
// 4'b1001=divide-by-16
// 4'b1000=divide-by-12
// 4'b0111=divide-by-10
// 4'b0110=divide-by-8
// 4'b0101=divide-by-6
// 4'b0100=divide-by-5
// 4'b0011=divide-by-4
// 4'b0010=divide-by-3
// 4'b0001=divide-by-2
// 4'b0000=FREF bypassed to output

input  FREF;
// Single-ended CMOS reference clock input (8MHz to 650MHz, in integer mode, 10MHz to 650MHz, in fractional mode)
// Only the rising edge is used by the PLL

input  FREFCMLP;
// CML positive phase reference clock input (ground-referenced) (8MHz to 650MHz, in integer mode, 10MHz to 650MHz, in fractional mode)

input  FREFCMLN;
// CML negative phase reference clock input (ground-referenced) (8MHz to 650MHz, in integer mode, 10MHz to 650MHz, in fractional mode)

input  PLLEN;
// Global enable signal for PLL
// 0 -> FREF bypassed to all Outputs (except FOUTVCO)
// 1 -> Entire PLL is enabled

input [5:0] REFDIV;
// Reference divide value (1 to 63)

input [11:0] FBDIV;
// PLL Feedback divide value (16 to 1000 in integer mode, 20 to 1000 in fractional mode)

input [23:0] FRAC;
// Fractional portion of feedback divide value

input  DSKEWCALEN;
// Deskew calibration enable to actively adjust for input skew
// 1'b0 - skew calibration is disabled.  Static phase offset is determined by analog matching only.
// 1'b1 - skew calibration is enabled.  Static phase offset is adjusted by sensing phase at the input.

input  DSKEWFASTCAL;
// Deskew fast calibration enable 
// Set this to 1 for initial calibration if an initial value is not already known
// Should be set to 0 for normal operation

input [2:0] DSKEWCALCNT;
// Programmable counter for deskew calibration loop
// Selects the number of PFD edges to wait after each deskew calibration step. Count is defined as $2^{DSKEWCALCNT+4}$ (e.g. if DSKEWCALCNT=3'd6, the loop will wait 1024 PFD periods before trying a new setting)
// Default setting is 3'd2

input [11:0] DSKEWCALIN;
// DSKEWCALBYP == 1'b0: Initial condition for deskew calibration logic.
// DSKEWCALBYP == 1'b1: Override value for deskew calibration. It is a signed integer with positive values delaying the reset of the faster path, and negative values delaying the reset of the slower path. 5'b0 is the minimum value, with each count increasing the reset time by one buffer delay.  
// If DSKEWCALEN=1, this can be used to force a skew correction value based on a previous readout of DSKEWCALOUT[11:0].  If DSKEWCALBYP=1 this value is forced directly into the calibration logic.  If DSKEWCALBYP=0 this is the initial condition for the calibration sequence.

input  DSKEWCALBYP;
// Deskew calibration bypass
// 1'b0 - use the skew calibration output (when DSKEWCALEN=1) to set the phase correction
// 1'b1 - use the DSKEWCALIN[11:0] value (when DSKEWCALEN=1) to set the phase correction

// outputs 
output  DSKEWCALLOCK;
// Deskew Calibration settled indicator for the PLL 
// 1'b0 --> Deskew calibration not yet settled
// 1'b1 --> Deskew calibration settled

output [11:0] DSKEWCALOUT;
// This is the output of either the skew calibration block (if DSKEWCALBYP=0) or a buffered
// version of DSKEWCALIN[11:0] (if DSKEWCALBYP=1).  It can be used to read out the phase 
// calibration state to use as an override value so that skew calibration can be bypassed
// for faster locking.  The value changes on the rising edge of FREF, so it can be clocked out on the falling edge of FREF.

output  CLKSSCG;
// Synchronization clock for spread spectrum modulation.  Minimum pulse width is 1.0ns.
// Hold time for FBDIV and FRAC is negative when synchronized with CLKSSCG
// Setup time is 1/FPFD - 10/FVCO 

output  FOUTVCO;
// VCO rate output clock (2000MHz to 8000MHz)

output  FOUTDIFFP;
// Require clock gating circuit for glitch-free output when enable goes high 
// Positive phase pseudo-differential output clock (166MHz to 2000MHz)
// Enabled with FOUTDIFFEN
// Output driven low when disabled

output  FOUTDIFFN;
// Require clock gating circuit for glitch-free output when enable goes high 
// Negative phase pseudo-differential output clock (166MHz to 2000MHz)
// Enabled with FOUTDIFFEN
// Output driven high when disabled

output  FOUTCMLP;
// Positive phase CML output clock (166MHz to 2000MHz)
// Enabled with FOUTCMLEN
// Output goes to 0V when disabled

output  FOUTCMLN;
// Negative phase CML output clock (166MHz to 2000MHz)
// Enabled with FOUTCMLEN
// Output goes to 0V when disabled

output [3:0] FOUT;
// PLL post divided CMOS outputs (31MHz to 4000MHz)
// VCO frequency divided by selected post divide value

output  LOCK;
// Lock signal
// Lock detector can measure frequency accuracy down to 0.8% of programmed target frequency
// 0.8% is the value of the lock circuit measurement uncertainty
// Actual frequency will be much closer to the final target.  Phase settling is guaranteed by design after 2000 PFD cycles.

// inouts 

// supplies 
`ifdef PLLTS16FFCFRACF_PWR_AWARE
input  VDDPOST;
// 0.8V supply for post dividers

input  VDDHV;
// 1.8V analog supply

input  VDDREF;
// 0.8V supply for reference rate circuits

input  VSS;
// 0V supply and substrate connection

`endif

`ifndef PLLTS16FFCFRACF_PWR_AWARE
supply1  VDDPOST;
// 0.8V supply for post dividers

supply1  VDDHV;
// 1.8V analog supply

supply1  VDDREF;
// 0.8V supply for reference rate circuits

supply0  VSS;
// 0V supply and substrate connection

`endif

wire PLLEN_int; 
assign PLLEN_int = (VDDREF===1'b1 && VDDHV===1'b1 && VDDPOST===1'b1 && VSS===1'b0) ? PLLEN : 1'b0;
 
initial begin 
`ifdef PLLTS16FFCFRACF_PWR_AWARE 
    $display("%m: Power aware enabled."); 
`endif 
end

 
`ifdef PLLTS16FFCFRACF_PWR_AWARE 
    always @* begin
        if (!(VDDREF===1'b1 && VDDHV===1'b1 && VDDPOST===1'b1 && VSS===1'b0))
           force XPLLTS16FFCFRACF_CORE.FREF_SEL = 0;
        else
           release XPLLTS16FFCFRACF_CORE.FREF_SEL;
    end
`endif 

 
assign XPLLTS16FFCFRACF_CORE.Xpllcore.Xqpmp.Xqpanalog.PD = !PLLEN_int;
assign XPLLTS16FFCFRACF_CORE.Xpllcore.Xvco.Xvcoana.dsmpd = !DSMEN;

PLLTS16FFCFRACF_ASSERTIONS XPLLTS16FFCFRACF_ASSERTIONS (
	.FOUTDIFFEN(FOUTDIFFEN), .FOUTCMLEN(FOUTCMLEN), .FOUTEN(FOUTEN), 
	.FOUTVCOEN(FOUTVCOEN), .FREFCMLEN(FREFCMLEN), .DACEN(DACEN), 
	.DSMEN(DSMEN), .FOUTVCOBYP(FOUTVCOBYP), .POSTDIV4(POSTDIV4), 
	.POSTDIV3(POSTDIV3), .POSTDIV2(POSTDIV2), .POSTDIV1(POSTDIV1), 
	.POSTDIV0(POSTDIV0), .FREF(FREF), .FREFCMLP(FREFCMLP), 
	.FREFCMLN(FREFCMLN), .PLLEN(PLLEN_int), .REFDIV(REFDIV), 
	.FBDIV(FBDIV), .FRAC(FRAC), .DSKEWCALEN(DSKEWCALEN), 
	.DSKEWFASTCAL(DSKEWFASTCAL), .DSKEWCALCNT(DSKEWCALCNT), .DSKEWCALIN(DSKEWCALIN), 
	.DSKEWCALBYP(DSKEWCALBYP), .DSKEWCALLOCK(DSKEWCALLOCK), .DSKEWCALOUT(DSKEWCALOUT), 
	.CLKSSCG(CLKSSCG), .FOUTVCO(FOUTVCO), .FOUTDIFFP(FOUTDIFFP), 
	.FOUTDIFFN(FOUTDIFFN), .FOUTCMLP(FOUTCMLP), .FOUTCMLN(FOUTCMLN), 
	.FOUT(FOUT), .LOCK(LOCK)  
);

PLLTS16FFCFRACF_CORE XPLLTS16FFCFRACF_CORE (
	.FOUTDIFFEN(FOUTDIFFEN), .FOUTCMLEN(FOUTCMLEN), .FOUTEN(FOUTEN), 
	.FOUTVCOEN(FOUTVCOEN), .FREFCMLEN(FREFCMLEN), .DACEN(DACEN), 
	.DSMEN(DSMEN), .FOUTVCOBYP(FOUTVCOBYP), .POSTDIV4(POSTDIV4), 
	.POSTDIV3(POSTDIV3), .POSTDIV2(POSTDIV2), .POSTDIV1(POSTDIV1), 
	.POSTDIV0(POSTDIV0), .FREF(FREF), .FREFCMLP(FREFCMLP), 
	.FREFCMLN(FREFCMLN), .PLLEN(PLLEN_int), .REFDIV(REFDIV), 
	.FBDIV(FBDIV), .FRAC(FRAC), .DSKEWCALEN(DSKEWCALEN), 
	.DSKEWFASTCAL(DSKEWFASTCAL), .DSKEWCALCNT(DSKEWCALCNT), .DSKEWCALIN(DSKEWCALIN), 
	.DSKEWCALBYP(DSKEWCALBYP), .DSKEWCALLOCK(DSKEWCALLOCK), .DSKEWCALOUT(DSKEWCALOUT), 
	.CLKSSCG(CLKSSCG), .FOUTVCO(FOUTVCO), .FOUTDIFFP(FOUTDIFFP), 
	.FOUTDIFFN(FOUTDIFFN), .FOUTCMLP(FOUTCMLP), .FOUTCMLN(FOUTCMLN), 
	.FOUT(FOUT), .LOCK(LOCK), .VDDPOST(VDDPOST), 
	.VDDHV(VDDHV), .VDDREF(VDDREF), .VSS(VSS)
);

	



endmodule


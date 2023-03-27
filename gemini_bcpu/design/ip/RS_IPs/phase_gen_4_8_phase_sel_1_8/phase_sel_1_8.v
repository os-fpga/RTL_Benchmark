////////////////////////////////////////////////////////////////////////////////
// Library          : yk_gemini_0713
// Cell             : phase_sel_1_8
// View             : schematic
// View Search List : verilog functional behavioral cmos.sch cmos_sch schematic symbol
// View Stop List   : functional behavioral symbol
////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////

module phase_sel_1_8( RESETB, phin, s_ph, o_sel_ph, DGND, DVDD );
    // Port declarations
    input RESETB;
    input [3:0]  phin;
    input [2:0]  s_ph;
    output o_sel_ph;
    inout DGND;
    inout DVDD;
    // Net declarations
    wire  RSTB;
    wire  net1;
    wire  net2;
    wire  s_ph01;
    wire  [2:0] s_ph1;
    wire  s_ph23;
    wire  sel_ph_0123;
    wire  sel_ph_0123d;
    wire  sel_ph_0123db;
    RS_INVD3BWP20P90CPDLVT  I56( net1, RSTB, DVDD, DGND, DVDD, DGND );
    RS_INVD2BWP20P90CPDLVT  I36( sel_ph_0123db, net2, DVDD, DGND, DVDD, DGND );
    RS_INVD2BWP20P90CPDLVT  I86( sel_ph_0123, sel_ph_0123db, DVDD, DGND, DVDD, DGND);
    RS_INVD1BWP20P90CPDLVT  I57( RESETB, net1, DVDD, DGND, DVDD, DGND );
    glitchless_mux2d4  I89( RSTB, {sel_ph_0123db, sel_ph_0123d}, s_ph1[2], o_sel_ph, DGND, DVDD );
//glitchless_mux2<=glitchless_mux2d4
    glitchless_mux2d4  I84( RSTB, {s_ph23, s_ph01}, s_ph1[1], sel_ph_0123, DGND, DVDD );
    glitchless_mux2d4  I94( RSTB, {phin[1], phin[0]}, s_ph1[0], s_ph01, DGND, DVDD);
    glitchless_mux2d4  I95( RSTB, {phin[3], phin[2]}, s_ph1[0], s_ph23, DGND, DVDD);
    RS_BUFFD1BWP20P90CPDLVT  I55[2:0]( s_ph, s_ph1, {DVDD, DVDD, DVDD}, {DGND,
        DGND, DGND}, {DVDD, DVDD, DVDD}, {DGND, DGND, DGND} );
    RS_BUFFD2BWP20P90CPDLVT  I85( sel_ph_0123, sel_ph_0123d, DVDD, DGND, DVDD, DGND);
endmodule //phase_sel_1_8

////////////////////////////////////////////////////////////////////////////////
// Library          : yk_gemini_0713
// Cell             : glitchless_mux2
// View             : schematic
// View Search List : verilog functional behavioral cmos.sch cmos_sch schematic symbol
// View Stop List   : functional behavioral symbol
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
module glitchless_mux2d4( RESETB, phin, s_ph, out, DGND, DVDD );
    input RESETB;
    input [1:0]  phin;
    input s_ph;
    output out;
    inout DGND;
    inout DVDD;
    wire  RSTB;
    wire  net146;
    wire  net159;
    wire  net184;
    wire  net185;
    wire  net190;
    wire  net216;
    wire  net219;
    wire  net82;
    wire  s2_ph03;
    wire  s2_ph47;
    RS_INVD3BWP20P90CPDLVT  I56( net82, RSTB, DVDD, DGND, DVDD, DGND );
    RS_PS_CKND2D4BWP20P90CPDLVT  I78( net184, net185, out, DVDD, DGND, DVDD, DGND );
    RS_NR2D1BWP20P90CPDLVT  I75( s2_ph03, s_ph, net216, DVDD, DGND, DVDD, DGND );
    RS_NR2D1BWP20P90CPDLVT  I72( net190, s2_ph47, net159, DVDD, DGND, DVDD, DGND );
    RS_INVD1BWP20P90CPDLVT  I74( s_ph, net190, DVDD, DGND, DVDD, DGND );
    RS_INVD1BWP20P90CPDLVT  I57( RESETB, net82, DVDD, DGND, DVDD, DGND );
    RS_DFNCNQD2BWP20P90CPDLVT  I68( net146, phin[1], RSTB, s2_ph03, DVDD, DGND, DVDD, DGND );
    RS_DFNCNQD2BWP20P90CPDLVT  I71( net219, phin[0], RSTB, s2_ph47, DVDD, DGND, DVDD, DGND );
    RS_CKND2D1BWP20P90CPDLVT  I77( s2_ph47, phin[0], net185, DVDD, DGND, DVDD, DGND);
    RS_CKND2D1BWP20P90CPDLVT  I76( s2_ph03, phin[1], net184, DVDD, DGND, DVDD, DGND);
    RS_DFCNQD2BWP20P90CPDLVT  I70( net216, phin[0], RSTB, net219, DVDD, DGND, DVDD, DGND );
    RS_DFCNQD2BWP20P90CPDLVT  I69( net159, phin[1], RSTB, net146, DVDD, DGND, DVDD, DGND );
endmodule //glitchless_mux2d4

module RS_PS_CKND2D4BWP20P90CPDLVT( A1, A2, ZN, VDD, VSS, VPP, VBB );
    input A1;
    input A2;
    output ZN;
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;

        nand (ZN,A1,A2);
        specify
                specparam
                        tplh0 = 0.035,  // 30ps
                        tphl0 = 0.035,
                        tplh1 = 0.035,
                        tphl1 = 0.035;
                (A2 => ZN) = (tplh0,tphl0);
                (A1 => ZN) = (tplh1,tphl1);
        endspecify
endmodule //RS_CKND2D2BWP20P90CPDLVT


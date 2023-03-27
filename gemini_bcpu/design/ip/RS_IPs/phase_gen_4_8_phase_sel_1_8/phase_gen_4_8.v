////////////////////////////////////////////////////////////////////////////////
// Library          : yk_gemini_0713
// Cell             : phase_gen_4_8
// View             : schematic
// View Search List : verilog functional behavioral cmos.sch cmos_sch schematic symbol
// View Stop List   : functional behavioral symbol
////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module phase_gen_4_8( RESETB, clk, d41_d80, o_ph_clk, DGND, DVDD );
    // Port declarations
    input RESETB;
    input clk;
    input d41_d80;
    output [7:0]  o_ph_clk;
    inout DGND;
    inout DVDD;
    // Net declarations
    wire  RSTB;
    wire  d41d80i;
    wire  net1;
    wire  net2;
    wire  net3;
    wire  [0:1] net4;
    wire  net5;
    wire  [3:0] phi;
    wire  str;
    RS_CKND4BWP20P90CPDLVT  I34( clk, net1, DVDD, DGND, DVDD, DGND );
    RS_CKND4BWP20P90CPDLVT  I35( net1, net2, DVDD, DGND, DVDD, DGND );
    RS_INVD3BWP20P90CPDLVT  I36( net5, RSTB, DVDD, DGND, DVDD, DGND );
    RS_MUX2D1BWP20P90CPDLVT  I45( phi[3], phi[1], d41d80i, net3, DVDD, DGND, DVDD, DGND );
// DFCNQD2_TSPC_LVT<= DFCNQD2BWP20P90CPDLVT
    RS_DFCNQD2BWP20P90CPDLVT  I24( str, net2, RSTB, phi[0], DVDD, DGND, DVDD, DGND );
    RS_DFCNQD2BWP20P90CPDLVT  I28( phi[1], net2, RSTB, phi[2], DVDD, DGND, DVDD, DGND );
    RS_DFCNQD2BWP20P90CPDLVT  I50( phi[0], net1, RSTB, phi[1], DVDD, DGND, DVDD, DGND );
    RS_DFCNQD2BWP20P90CPDLVT  I51( phi[2], net1, RSTB, phi[3], DVDD, DGND, DVDD, DGND );
    RS_PG_CKNR2D4BWP20P90CPDLVT  I57[3:0]( {d41d80i, d41d80i, d41d80i, d41d80i}, phi,
        o_ph_clk[7:4], {DVDD, DVDD, DVDD, DVDD}, {DGND, DGND, DGND, DGND},
        {DVDD, DVDD, DVDD, DVDD}, {DGND, DGND, DGND, DGND} );
    RS_PG_BUFFD4BWP20P90CPDLVT  I48[3:0]( phi, o_ph_clk[3:0], {DVDD, DVDD, DVDD, DVDD}
        , {DGND, DGND, DGND, DGND}, {DVDD, DVDD, DVDD, DVDD}, {DGND, DGND, DGND,
        DGND} );
    RS_BUFFD2BWP20P90CPDLVT  I58( d41_d80, d41d80i, DVDD, DGND, DVDD, DGND );
    RS_CKND1BWP20P90CPDLVT  I46( net3, str, DVDD, DGND, DVDD, DGND );
    RS_INVD2BWP20P90CPDLVT  I54[1:0]( {phi[2],phi[0]}, net4, {DVDD, DVDD}, {DGND,
        DGND}, {DVDD, DVDD}, {DGND, DGND} );
    RS_INVD1BWP20P90CPDLVT  I3( RESETB, net5, DVDD, DGND, DVDD, DGND );
endmodule //phase_gen_4_8

module RS_PG_BUFFD4BWP20P90CPDLVT (I, Z, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input I;
    output Z;
    buf (Z, I);

specify
    specparam
    tplh0 = 0.045, // 10ps
    tphl0 = 0.045;
    (I => Z) = (tplh0,tphl0);
endspecify

endmodule

module RS_PG_CKNR2D4BWP20P90CPDLVT (A1, A2, ZN, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input A1, A2;
    output ZN;
    or (I0_out, A1, A2);
    not (ZN, I0_out);

  specify
    specparam
    tplh0 = 0.045, // 10ps
    tphl0 = 0.045;
    (A1 => ZN) = (tplh0,tphl0);
    (A2 => ZN) = (tplh0,tphl0);
  endspecify
endmodule



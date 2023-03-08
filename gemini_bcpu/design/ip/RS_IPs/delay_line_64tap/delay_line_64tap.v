`timescale 1ns / 1ps

// View             : schematic
// View Search List : verilog functional behavioral cmos.sch cmos_sch schematic symbol
// View Stop List   : functional behavioral symbol
////////////////////////////////////////////////////////////////////////////////

//recompiling module CKND2D1BWP20P90CPDLVT
//recompiling module INVD3BWP20P90CPDLVT
//recompiling module ND3D1BWP20P90CPDLVT
//recompiling module NR2D1BWP20P90CPDLVT
module RS_DL_CKND2D1BWP20P90CPDLVT (A1, A2, ZN, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input A1, A2;
    output ZN;

  CKND2D2_bal i1( ZN, VBB, VDD, VPP, VSS, A1, A2 );

endmodule

module RS_DL_INVD3BWP20P90CPDLVT (I, ZN, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input I;
    output ZN;
    not (ZN, I);

  specify
    (I => ZN) = (0, 0);
  endspecify
endmodule
module RS_DL_ND3D1BWP20P90CPDLVT (A1, A2, A3, ZN, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input A1, A2, A3;
    output ZN;
    and (I0_out, A1, A2, A3);
    not (ZN, I0_out);

  specify
    (A1 => ZN) = (0, 0);
    (A2 => ZN) = (0, 0);
    (A3 => ZN) = (0, 0);
  endspecify
endmodule

module RS_DL_NR2D1BWP20P90CPDLVT (A1, A2, ZN, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input A1, A2;
    output ZN;
    or (I0_out, A1, A2);
    not (ZN, I0_out);

  specify
    (A1 => ZN) = (0, 0);
    (A2 => ZN) = (0, 0);
  endspecify
endmodule

module CKND2D2_bal( ZN, VBB, VDD, VPP, VSS, A1, A2 );
//module CKND2D2_bal( A1, A2, ZN, VDD, VSS, VPP, VBB );
    // Port declarations
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
                        tplh0 = 0.007,  // 7ps
                        tphl0 = 0.007,
                        tplh1 = 0.007,
                        tphl1 = 0.007;
                (A2 => ZN) = (tplh0,tphl0);
                (A1 => ZN) = (tplh1,tphl1);
        endspecify

    // Instances of tcbn16ffcllbwp20p90cpdlvt/CKND2D1BWP20P90CPDLVT/schematic
//    CKND2D1BWP20P90CPDLVT  I19( A2, A1, ZN, VDD, VSS, VPP, VBB );
//    CKND2D1BWP20P90CPDLVT  I18( A1, A2, ZN, VDD, VSS, VPP, VBB );
endmodule //CKND2D2_bal


////////////////////////////////////////////////////////////////////////////////
// Library          : yk_gemini_0713
// Cell             : p_dec6en
// View             : schematic
// View Search List : verilog functional behavioral cmos.sch cmos_sch schematic symbol
// View Stop List   : functional behavioral symbol
////////////////////////////////////////////////////////////////////////////////

module p_dec6en( dout , DGND, DVDD, b );
    // Port declarations
    output [63:0]  dout ;
    inout DGND;
    inout DVDD;
    input [5:0]  b;
    // Net declarations
    wire  [5:0] in;
    wire  [5:0] inb;
    wire  [0:63] net7;
    wire  [0:63] net8;
    // Instances of tcbn16ffcllbwp20p90cpdlvt/INVD3BWP20P90CPDLVT/schematic
    RS_DL_INVD3BWP20P90CPDLVT  I36[5:0]( inb, in, {DVDD, DVDD, DVDD, DVDD, DVDD, DVDD}
        , {DGND, DGND, DGND, DGND, DGND, DGND}, {DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD}, {DGND, DGND, DGND, DGND, DGND, DGND} );
    RS_DL_INVD3BWP20P90CPDLVT  I5[5:0]( b, inb, {DVDD, DVDD, DVDD, DVDD, DVDD, DVDD},
        {DGND, DGND, DGND, DGND, DGND, DGND}, {DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD}, {DGND, DGND, DGND, DGND, DGND, DGND} );
    // Instances of tcbn16ffcllbwp20p90cpdlvt/NR2D1BWP20P90CPDLVT/schematic
    RS_DL_NR2D1BWP20P90CPDLVT  I9[63:0]( net8, net7, dout , {DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD},
        {DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND}, {DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD}, {DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND} );
    // Instances of tcbn16ffcllbwp20p90cpdlvt/ND3D1BWP20P90CPDLVT/schematic
    RS_DL_ND3D1BWP20P90CPDLVT  I10[63:0]( {in[3], in[3], in[3], in[3], in[3], in[3],
        in[3], in[3], inb[3], inb[3], inb[3], inb[3], inb[3], inb[3], inb[3],
        inb[3], in[3], in[3], in[3], in[3], in[3], in[3], in[3], in[3], inb[3],
        inb[3], inb[3], inb[3], inb[3], inb[3], inb[3], inb[3], in[3], in[3],
        in[3], in[3], in[3], in[3], in[3], in[3], inb[3], inb[3], inb[3],
        inb[3], inb[3], inb[3], inb[3], inb[3], in[3], in[3], in[3], in[3],
        in[3], in[3], in[3], in[3], inb[3], inb[3], inb[3], inb[3], inb[3],
        inb[3], inb[3], inb[3]}, {in[4], in[4], in[4], in[4], in[4], in[4],
        in[4], in[4], in[4], in[4], in[4], in[4], in[4], in[4], in[4], in[4],
        inb[4], inb[4], inb[4], inb[4], inb[4], inb[4], inb[4], inb[4], inb[4],
        inb[4], inb[4], inb[4], inb[4], inb[4], inb[4], inb[4], in[4], in[4],
        in[4], in[4], in[4], in[4], in[4], in[4], in[4], in[4], in[4], in[4],
        in[4], in[4], in[4], in[4], inb[4], inb[4], inb[4], inb[4], inb[4],
        inb[4], inb[4], inb[4], inb[4], inb[4], inb[4], inb[4], inb[4], inb[4],
        inb[4], inb[4]}, {in[5], in[5], in[5], in[5], in[5], in[5], in[5],
        in[5], in[5], in[5], in[5], in[5], in[5], in[5], in[5], in[5], in[5],
        in[5], in[5], in[5], in[5], in[5], in[5], in[5], in[5], in[5], in[5],
        in[5], in[5], in[5], in[5], in[5], inb[5], inb[5], inb[5], inb[5],
        inb[5], inb[5], inb[5], inb[5], inb[5], inb[5], inb[5], inb[5], inb[5],
        inb[5], inb[5], inb[5], inb[5], inb[5], inb[5], inb[5], inb[5], inb[5],
        inb[5], inb[5], inb[5], inb[5], inb[5], inb[5], inb[5], inb[5], inb[5],
        inb[5]}, net7, {DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD}, {DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND},
        {DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD}, {DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND} );
    RS_DL_ND3D1BWP20P90CPDLVT  I3[63:0]( {in[0], inb[0], in[0], inb[0], in[0], inb[0],
        in[0], inb[0], in[0], inb[0], in[0], inb[0], in[0], inb[0], in[0],
        inb[0], in[0], inb[0], in[0], inb[0], in[0], inb[0], in[0], inb[0],
        in[0], inb[0], in[0], inb[0], in[0], inb[0], in[0], inb[0], in[0],
        inb[0], in[0], inb[0], in[0], inb[0], in[0], inb[0], in[0], inb[0],
        in[0], inb[0], in[0], inb[0], in[0], inb[0], in[0], inb[0], in[0],
        inb[0], in[0], inb[0], in[0], inb[0], in[0], inb[0], in[0], inb[0],
        in[0], inb[0], in[0], inb[0]}, {in[1], in[1], inb[1], inb[1], in[1],
        in[1], inb[1], inb[1], in[1], in[1], inb[1], inb[1], in[1], in[1],
        inb[1], inb[1], in[1], in[1], inb[1], inb[1], in[1], in[1], inb[1],
        inb[1], in[1], in[1], inb[1], inb[1], in[1], in[1], inb[1], inb[1],
        in[1], in[1], inb[1], inb[1], in[1], in[1], inb[1], inb[1], in[1],
        in[1], inb[1], inb[1], in[1], in[1], inb[1], inb[1], in[1], in[1],
        inb[1], inb[1], in[1], in[1], inb[1], inb[1], in[1], in[1], inb[1],
        inb[1], in[1], in[1], inb[1], inb[1]}, {in[2], in[2], in[2], in[2],
        inb[2], inb[2], inb[2], inb[2], in[2], in[2], in[2], in[2], inb[2],
        inb[2], inb[2], inb[2], in[2], in[2], in[2], in[2], inb[2], inb[2],
        inb[2], inb[2], in[2], in[2], in[2], in[2], inb[2], inb[2], inb[2],
        inb[2], in[2], in[2], in[2], in[2], inb[2], inb[2], inb[2], inb[2],
        in[2], in[2], in[2], in[2], inb[2], inb[2], inb[2], inb[2], in[2],
        in[2], in[2], in[2], inb[2], inb[2], inb[2], inb[2], in[2], in[2],
        in[2], in[2], inb[2], inb[2], inb[2], inb[2]}, net8, {DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD}, {DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND}, {DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD},
        {DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND} );
endmodule //p_dec6en

////////////////////////////////////////////////////////////////////////////////
// Library          : yk_gemini_0713
// Cell             : delay_line_64tap
// View             : schematic
// View Search List : verilog functional behavioral cmos.sch cmos_sch schematic symbol
// View Stop List   : functional behavioral symbol
////////////////////////////////////////////////////////////////////////////////

module delay_line_64tap( DGND, DVDD, in, out, sel );
    // Port declarations
    inout DGND;
    inout DVDD;
    input in;
    output out;
    input [5:0]  sel;
    // Net declarations
    wire  [63:0] dec;
    wire  [0:63] net7;
    wire  [0:63] net8;
    wire  [0:63] next;
    wire  [0:62] ret;
    // Instances of tcbn16ffcllbwp20p90cpdlvt/INVD1BWP20P90CPDLVT/schematic
    RS_DL_INVD3BWP20P90CPDLVT  I36[0:63](
        {dec[0],dec[1],dec[2],dec[3],dec[4],dec[5],dec[6],dec[7],dec[8],dec[9],dec[10],dec[11],dec[12],dec[13],dec[14],dec[15],dec[16],dec[17],dec[18],dec[19],dec[20],dec[21],dec[22],dec[23],dec[24],dec[25],dec[26],dec[27],dec[28],dec[29],dec[30],dec[31],dec[32],dec[33],dec[34],dec[35],dec[36],dec[37],dec[38],dec[39],dec[40],dec[41],dec[42],dec[43],dec[44],dec[45],dec[46],dec[47],dec[48],dec[49],dec[50],dec[51],dec[52],dec[53],dec[54],dec[55],dec[56],dec[57],dec[58],dec[59],dec[60],dec[61],dec[62],dec[63]}
        , net8, {DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD}, {DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND},
        {DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD}, {DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND} );
    // Instances of yk_gemini_0713/p_dec6en/schematic
    p_dec6en  I49( dec, DGND, DVDD, sel );
    // Instances of yk_gemini_0713/CKND2D2_bal/schematic
    CKND2D2_bal  I37[0:63]( next, {DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND}, {DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD}, {DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD}, {DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND},
        {in, next[0:62]}, net8 );
    CKND2D2_bal  I38[0:63]( {out, ret}, {DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND}, {DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD}, {DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD}, {DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND}, net7, {ret, next[63]} );
    // Instances of tcbn16ffcllbwp20p90cpdlvt/CKND2D1BWP20P90CPDLVT/schematic
    RS_DL_CKND2D1BWP20P90CPDLVT  I35[0:63](
        {dec[0],dec[1],dec[2],dec[3],dec[4],dec[5],dec[6],dec[7],dec[8],dec[9],dec[10],dec[11],dec[12],dec[13],dec[14],dec[15],dec[16],dec[17],dec[18],dec[19],dec[20],dec[21],dec[22],dec[23],dec[24],dec[25],dec[26],dec[27],dec[28],dec[29],dec[30],dec[31],dec[32],dec[33],dec[34],dec[35],dec[36],dec[37],dec[38],dec[39],dec[40],dec[41],dec[42],dec[43],dec[44],dec[45],dec[46],dec[47],dec[48],dec[49],dec[50],dec[51],dec[52],dec[53],dec[54],dec[55],dec[56],dec[57],dec[58],dec[59],dec[60],dec[61],dec[62],dec[63]}
        , {in, next[0:62]}, net7, {DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD}, {DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND}, {DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD,
        DVDD, DVDD, DVDD, DVDD, DVDD, DVDD, DVDD}, {DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND,
        DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND, DGND}
        );
endmodule //delay_line_64tap

// Support modules


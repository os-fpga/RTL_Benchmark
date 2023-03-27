`timescale 1ns/1ps     // rs16.v  ** (C) Copyright MMXXII Certus Semiconductor ** 2022.0818

module RS_HP_VDD_EW       (input [4:0] AICN,AICP, input POC, inout VDD,VDDIO,VDD18,VREF,VSS); endmodule
module RS_HP_VDDIO_EW     (input [4:0] AICN,AICP, input POC, inout VDD,VDDIO,VDD18,VREF,VSS); endmodule
module RS_HP_VDDIO_POC_EW (input [4:0] AICN,AICP, inout POC, inout VDD,VDDIO,VDD18,VREF,VSS); pullup(POC); endmodule
module RS_HP_VREF_EW      (input [4:0] AICN,AICP, input EN,POC, inout VDD,VDDIO,VDD18,VREF,VSS); endmodule

module RS_HP_VDD_NS       (input [4:0] AICN,AICP, input POC, inout VDD,VDDIO,VDD18,VREF,VSS); endmodule
module RS_HP_VDDIO_NS     (input [4:0] AICN,AICP, input POC, inout VDD,VDDIO,VDD18,VREF,VSS); endmodule
module RS_HP_VDDIO_POC_NS (input [4:0] AICN,AICP, inout POC, inout VDD,VDDIO,VDD18,VREF,VSS); pullup(POC); endmodule
module RS_HP_VREF_NS      (input [4:0] AICN,AICP, input EN,POC, inout VDD,VDDIO,VDD18,VREF,VSS); endmodule

// module RS_HP_VDDIO_TERM_EW (inout [4:0] AICN,AICP,AIXN,AIXP, input PGEN,POC, inout VDD,VDDIO,VDD18,VREF,VSS);
//    rtranif1 b110[4:0](AICN,AIXN,POC&PGEN); rtranif1 b011[4:0](AICP,AIXP,POC&PGEN); endmodule
module RS_HPIO_RCAL_EW (inout IO, output DOUT, input CK,DIN,IE,MSTR,OE,PE,PUD,RST,
    inout [4:0] AICN,AICP, input POC, inout VDD,VDDIO,VDD18,VREF,VSS);
    bufif1(weak1,weak0)(IO,PUD,POC&!MSTR&PE); bufif1(IO,DIN,POC&!MSTR&OE); buf(DOUT,POC&!MSTR&IE&IO);
    bufif1 aicn[4:0](AICN,~RST,POC&MSTR); bufif1 aicp[4:0](AICP,RST,POC&MSTR); endmodule
module RS_HPIO_DIF_EW (inout IOA,IOB, // 1.2V-1.8V IO PADS
    output CDETA,DOUTA, input DINA,IEA,OEA,PEA,PUDA,SRA, input [3:0] MCA,
    output CDETB,DOUTB, input DINB,IEB,OEB,PEB,PUDB,SRB, input [3:0] MCB,
    output DFRX, input DFTX,DFEN,DFRXEN,DFTXEN,DFODTEN,
    input [4:0] AICN,AICP, input POC, inout VDD,VDDIO,VDD18,VREF,VSS);
    wire MIPI=DFEN&(MCA[3:1]==3'b011),MIPD=DFEN&(MCA==4'b0111),LVC=!DFEN&!MCA[3];
    bufif1 (weak1,weak0) rpa(IOA,PUDA,POC&LVC&PEA);  bufif1 (weak1,weak0) rpb(IOB,PUDB,POC&LVC&PEB);
    bufif1 txa(IOA, DFEN?(MIPI?(DFTXEN? DFTX:DINA): DFTX):DINA, POC&(DFEN?DFTXEN|(MIPI&OEA):OEA));
    bufif1 txb(IOB, DFEN?(MIPI?(DFTXEN?~DFTX:DINB):~DFTX):DINB, POC&(DFEN?DFTXEN|(MIPI&OEB):OEB));
    buf  rxa(DOUTA, POC&IEA&(!DFEN|MIPI)?IOA:1'b0); buf(CDETA,POC&MIPD&(IOA===1'bX));
    buf  rxb(DOUTB, POC&IEB&(!DFEN|MIPI)?IOB:1'b0); buf(CDETB,POC&MIPD&(IOB===1'bX));
    buf  rxd(DFRX,  POC&DFRXEN&DFEN?((IOA===1'b0)&(IOB===1'b1)?1'b0:((IOA===1'b1)&(IOB===1'b0)?1'b1:1'bX)):1'b0);
endmodule

// module RS_HP_VDDIO_TERM_NS (inout [4:0] AICN,AICP,AIXN,AIXP, input PGEN,POC, inout VDD,VDDIO,VDD18,VREF,VSS);
//    rtranif1 b110[4:0](AICN,AIXN,POC&PGEN); rtranif1 b011[4:0](AICP,AIXP,POC&PGEN); endmodule
module RS_HPIO_RCAL_NS (inout IO, output DOUT, input CK,DIN,IE,MSTR,OE,PE,PUD,RST,
    inout [4:0] AICN,AICP, input POC, inout VDD,VDDIO,VDD18,VREF,VSS);
    bufif1(weak1,weak0)(IO,PUD,POC&!MSTR&PE); bufif1(IO,DIN,POC&!MSTR&OE); buf(DOUT,POC&!MSTR&IE&IO);
    bufif1 aicn[4:0](AICN,~RST,POC&MSTR); bufif1 aicp[4:0](AICP,RST,POC&MSTR); endmodule
module RS_HPIO_DIF_NS (inout IOA,IOB, // 1.2V-1.8V IO PADS
    output CDETA,DOUTA, input DINA,IEA,OEA,PEA,PUDA,SRA, input [3:0] MCA,
    output CDETB,DOUTB, input DINB,IEB,OEB,PEB,PUDB,SRB, input [3:0] MCB,
    output DFRX, input DFTX,DFEN,DFRXEN,DFTXEN,DFODTEN,
    input [4:0] AICN,AICP, input POC, inout VDD,VDDIO,VDD18,VREF,VSS);
    wire MIPI=DFEN&(MCA[3:1]==3'b011),MIPD=DFEN&(MCA==4'b0111),LVC=!DFEN&!MCA[3];
    bufif1 (weak1,weak0) rpa(IOA,PUDA,POC&LVC&PEA);  bufif1 (weak1,weak0) rpb(IOB,PUDB,POC&LVC&PEB);
    bufif1 txa(IOA, DFEN?(MIPI?(DFTXEN? DFTX:DINA): DFTX):DINA, POC&(DFEN?DFTXEN|(MIPI&OEA):OEA));
    bufif1 txb(IOB, DFEN?(MIPI?(DFTXEN?~DFTX:DINB):~DFTX):DINB, POC&(DFEN?DFTXEN|(MIPI&OEB):OEB));
    buf  rxa(DOUTA, POC&IEA&(!DFEN|MIPI)?IOA:1'b0); buf(CDETA,POC&MIPD&(IOA===1'bX));
    buf  rxb(DOUTB, POC&IEB&(!DFEN|MIPI)?IOB:1'b0); buf(CDETB,POC&MIPD&(IOB===1'bX));
    buf  rxd(DFRX,  POC&DFRXEN&DFEN?((IOA===1'b0)&(IOB===1'b1)?1'b0:((IOA===1'b1)&(IOB===1'b0)?1'b1:1'bX)):1'b0);
endmodule

module RS_HV_VDD_EW       (input HVEN,LVEN, input POC, inout VDD,VDDIO,VDD18,VREF,VSS); endmodule
module RS_HV_VDD18_EW     (input HVEN,LVEN, input POC, inout VDD,VDDIO,VDD18,VREF,VSS); endmodule
module RS_HV_VDDIO_EW     (input HVEN,LVEN, input POC, inout VDD,VDDIO,VDD18,VREF,VSS); endmodule
module RS_HV_VDDIO_POC_EW (input HVEN,LVEN, inout POC, inout VDD,VDDIO,VDD18,VREF,VSS); pullup(POC); endmodule
module RS_HV_VREF_EW      (input HVEN,LVEN, input EN,POC, inout VDD,VDDIO,VDD18,VREF,VSS); endmodule

module RS_HV_VDD_NS       (input HVEN,LVEN, input POC, inout VDD,VDDIO,VDD18,VREF,VSS); endmodule
module RS_HV_VDD18_NS     (input HVEN,LVEN, input POC, inout VDD,VDDIO,VDD18,VREF,VSS); endmodule
module RS_HV_VDDIO_NS     (input HVEN,LVEN, input POC, inout VDD,VDDIO,VDD18,VREF,VSS); endmodule
module RS_HV_VDDIO_POC_NS (input HVEN,LVEN, inout POC, inout VDD,VDDIO,VDD18,VREF,VSS); pullup(POC); endmodule
module RS_HV_VREF_NS      (input HVEN,LVEN, input EN,POC, inout VDD,VDDIO,VDD18,VREF,VSS); endmodule

module RS_HVIO_DIF_EW (inout IOA,IOB, // 1.8V-3.3V IO PADS
    output DOUTA, input DINA,IEA,OEA,PEA,PUDA,SRA, input [3:0] MCA,
    output DOUTB, input DINB,IEB,OEB,PEB,PUDB,SRB, input [3:0] MCB,
    output DFRX, input DFTX,DFEN,DFRXEN,DFTXEN,DFODTEN,
    input HVEN,LVEN,POC, inout VDD,VDDIO,VDD18,VREF,VSS); wire LVC=!DFEN&!MCA[3];
    bufif1 (weak1,weak0) wrra(IOA,PUDA,POC&LVC&PEA); bufif1 (weak1,weak0) wrrb(IOB,PUDB,POC&LVC&PEB);
    bufif1 txa(IOA, DFEN? DFTX:DINA, POC&(DFEN?DFTXEN:OEA)); buf rxa(DOUTA, POC&IEA&!DFEN?IOA:1'b0);
    bufif1 txb(IOB, DFEN?~DFTX:DINB, POC&(DFEN?DFTXEN:OEB)); buf rxb(DOUTB, POC&IEB&!DFEN?IOB:1'b0);
    buf  rxd(DFRX,  POC&DFRXEN&DFEN?((IOA===1'b0)&(IOB===1'b1)?1'b0:((IOA===1'b1)&(IOB===1'b0)?1'b1:1'bX)):1'b0);
endmodule

module RS_HVIO_DIF_NS (inout IOA,IOB, // 1.8V-3.3V IO PADS
    output DOUTA, input DINA,IEA,OEA,PEA,PUDA,SRA, input [3:0] MCA,
    output DOUTB, input DINB,IEB,OEB,PEB,PUDB,SRB, input [3:0] MCB,
    output DFRX, input DFTX,DFEN,DFRXEN,DFTXEN,DFODTEN,
    input HVEN,LVEN,POC, inout VDD,VDDIO,VDD18,VREF,VSS); wire LVC=!DFEN&!MCA[3];
    bufif1 (weak1,weak0) wrra(IOA,PUDA,POC&LVC&PEA); bufif1 (weak1,weak0) wrrb(IOB,PUDB,POC&LVC&PEB);
    bufif1 txa(IOA, DFEN? DFTX:DINA, POC&(DFEN?DFTXEN:OEA)); buf rxa(DOUTA, POC&IEA&!DFEN?IOA:1'b0);
    bufif1 txb(IOB, DFEN?~DFTX:DINB, POC&(DFEN?DFTXEN:OEB)); buf rxb(DOUTB, POC&IEB&!DFEN?IOB:1'b0);
    buf  rxd(DFRX,  POC&DFRXEN&DFEN?((IOA===1'b0)&(IOB===1'b1)?1'b0:((IOA===1'b1)&(IOB===1'b0)?1'b1:1'bX)):1'b0);
endmodule

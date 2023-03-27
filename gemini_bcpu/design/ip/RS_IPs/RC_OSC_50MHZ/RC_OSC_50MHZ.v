//-----------------------------------------------------------------------------//
//                                                                             //
//-----------------------------------------------------------------------------//

`timescale 1ns / 1ps

module RC_OSC_50MHZ( O_OSC, VR12, VDD18, VSS18, CAL, IB_COP, PD, RSTB, VDDC, BGR, RSV );
    output O_OSC;
    inout VR12;
    inout VDD18;
    inout VSS18;
    inout VDDC;

    input [5:0]  CAL;
    input [1:0]  IB_COP;
    input PD;
    input RSTB;
    input [2:0]  BGR;
    input [2:0]  RSV;
  
    wire O_OSC_w;

//
// Not supportted: 
// BGR, IB_COP, CAL, RSV;
// VR12;    
 
reg OUT_r;

 parameter onecycle = 20; // fclk=50MHz(20n)
 parameter LOCKINGTIME = 20000;      // LOCK time is 20usec


initial OUT_r =0;

wire PD_w;
buf #LOCKINGTIME (PD_w, PD | ~RSTB);

always  begin
     #(0.5*onecycle); OUT_r = (0 && ~PD_w);
     #(0.5*onecycle); OUT_r = (1 && ~PD_w);
end 

assign O_OSC_w = OUT_r && ~PD && RSTB;
    RS_RC_INVD4BWP20P90CPDLVT  I36( O_OSC_w, O_OSC, VDDC, VSS18, VDDC, VSS18 );

endmodule

module RS_RC_INVD4BWP20P90CPDLVT (I, ZN, VDD, VSS, VPP, VBB);
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


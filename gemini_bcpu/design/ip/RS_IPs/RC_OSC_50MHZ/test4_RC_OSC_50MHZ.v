
`timescale 1ns / 1ps

module test;

  reg         PD;
  reg         RSTB;
  reg [2:0]   BGR;
  reg [1:0]   IB_COP;
  reg [5:0]   CAL;
  reg [2:0]   RSV;

wire  O_OSC;

RC_OSC_50MHZ  top  ( O_OSC, VR12, VDD18, VSS18, CAL, IB_COP, PD, RSTB, VDDC, BGR, RSV );


initial begin
$dumpfile("vcd_RC_OSC_50MHZ.vcd");
$dumpvars;

// $fsdbDumpfile("fsdb_RC_OSC_HS_25M.fsdb");
// $fsdbDumpvars;

 PD=0; 
 RSTB=1; 

 #200000;
 PD=1;
 #100000;
 PD=0;

 #200000;
 RSTB=0;
 #100000;
 RSTB=1;

 #400000;

 $finish;

end


endmodule 

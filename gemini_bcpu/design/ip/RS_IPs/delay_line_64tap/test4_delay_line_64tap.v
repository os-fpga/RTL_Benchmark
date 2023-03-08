
`timescale 1ns / 1ps

module test;

/// parameter halfcycle = 1000/50/2;  // fclk=50MHz
//parameter halfcycle = 1000/5000/2;  // fclk=5GHz
parameter halfcycle = 0.2;  // fclk=2.5GHz

  reg         in;
  reg [5:0] sel;
  supply1      DVDD;
  supply0      DGND;


delay_line_64tap top ( DGND, DVDD, in, out, sel );

initial
forever #(halfcycle) in = ~in;

initial begin
$dumpfile("vcd_delay_line_64.vcd");
$dumpvars;

// $fsdbDumpfile("fsdb_RC_OSC_HS_25M.fsdb");
// $fsdbDumpvars;

 in=0;
 sel=0; 

 #2; sel=1;
 #2; sel=3;
 #2; sel=31;
 #2; sel=32;
 #2; sel=62;
 #2; sel=63;
 #2; sel=0;

 #2;

 $finish;

end


endmodule 

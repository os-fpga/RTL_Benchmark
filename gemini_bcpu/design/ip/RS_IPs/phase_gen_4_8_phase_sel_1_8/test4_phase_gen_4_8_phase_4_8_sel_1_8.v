
`timescale 1ns / 1ps

module test;

/// parameter halfcycle = 1000/50/2;  // fclk=50MHz
//parameter halfcycle = 1000/5000/2;  // fclk=5GHz
parameter halfcycle = 0.1;  // fclk=5GHz

  reg         clk;
  reg         d41_d80;
  reg         RESETB;

  supply1      DVDD;
  supply0      DGND;

  reg[2:0]         s_ph;

wire [7:0] o_ph_clk;

phase_gen_4_8 top_1 ( RESETB, clk, d41_d80, o_ph_clk, DGND, DVDD );
phase_sel_1_8 top_2 ( RESETB, o_ph_clk, s_ph, o_sel_ph, DGND, DVDD );


initial
forever #(halfcycle) clk = ~clk;

initial begin
$dumpfile("vcd_phase_gen_sel.vcd");
$dumpvars;

// $fsdbDumpfile("fsdb_RC_OSC_HS_25M.fsdb");
// $fsdbDumpvars;

 clk=0;
 d41_d80=0;  s_ph=0;
 RESETB=1; 

 #20;
  RESETB=0;
 #20;
  RESETB=1;
 #200;
 d41_d80=1;
   #10; s_ph=0;
   #10; s_ph=1;
   #10; s_ph=2;
   #10; s_ph=3;
   #10; s_ph=4;
   #10; s_ph=5;
   #10; s_ph=6;
   #10; s_ph=7;

 #200;
 d41_d80=0;
   #10; s_ph=0;
   #10; s_ph=1;
   #10; s_ph=2;
   #10; s_ph=3;
   #10; s_ph=4;
   #10; s_ph=5;
   #10; s_ph=6;
   #10; s_ph=7;

 #200;

 #200;

 $finish;

end


endmodule 

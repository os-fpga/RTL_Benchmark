// ============================================================================
//  
//                           Copyright (C) 2006 
//                            by M2000, France 
//  
//                           All Rights Reserved 
//  
//  
//  This file contains confidential information, trade secrets, and proprietary
//  products of M2000 or its licensors. No part of this file may be copied,
//  reproduced, translated, transferred, disclosed or otherwise provided to
//  third parties, without the prior written consent of M2000. 
//  
//  M2000 reserves the right to make changes in specifications and other
//  information contained on the file without prior notice, and the user should,
//  in all cases, consult M2000 to determine whether any changes have been made. 
//  
// ============================================================================
// 
//  Title       : 
//
//  Description :  
//                
//
//  Version     :
//
//  Date        : December , 2007
//  
// ============================================================================



`include "defines.v"

module aquarius_wrapper_pw (pass, done, clkout, CLK,load,clk_core,rst_core,IN,OUT);

 
 parameter NUM_UNITS = 6;
 parameter CORE_DATIPUT_WIDTH = 18;
 parameter CORE_DATA_OUTPUT_WIDTH = 18;
   

//////////////////////////////////////////////////////////////////////////////////////	   
// PORTS
    input  CLK;
    input  load; 
    input  clk_core;
    input  rst_core;
    output pass;
	output done;
	output clkout;
	input  [NUM_UNITS-1:0] IN; 
    output [NUM_UNITS-1:0] OUT ; 
    
	wire [CORE_DATIPUT_WIDTH-1:0] core_in [NUM_UNITS-1:0] ; 
	wire [CORE_DATA_OUTPUT_WIDTH-1:0] core_out [NUM_UNITS-1:0]; 

top_75 bbTOP (
              .clk (clk_core),
              .reset (rst_core),
              .pass (pass),
              .done (done),
              .clkout (clkout)
			  );
			  
genvar gv;
  
generate 

 			

for (gv=0; gv < NUM_UNITS ; gv = gv + 1)
begin: aby

///////assign core_out[gv] = core_in[gv];

handsome_wr #(.length(CORE_DATIPUT_WIDTH))  inst_handsome_wr(.clk(CLK), .sr_in(IN[gv]), .par_out(core_in[gv]));
handsome_rd #(.length(CORE_DATA_OUTPUT_WIDTH)) inst_handsome_rd(.clk(CLK), .load(load), .par_in(core_out[gv]), .sr_out(OUT[gv]));
  

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////


top  inst_top(
      .CLK_SRC(clk_core), 
      .RST_n(rst_core),
      .LCDRS(core_out[gv][0]), 
      .LCDRW(core_out[gv][1]), 
      .LCDE(core_out[gv][2]),
	  .LCDDBO(core_out[gv][10:3]), 
	  .LCDDBI(core_in[gv][7:0]),
	  .KEYYO(core_out[gv][15:11]), 
	  .KEYXI(core_in[gv][12:8]),
      .RXD(core_in[gv][13]), 
      .TXD(core_out[gv][16]), 
      .CTS(core_in[gv][14]),  
      .RTS(core_out[gv][17])
    );

 //   input  CLK_SRC; // non stop clock
 //   input  RST_n;
 //   output LCDRS;
 //   output LCDRW;
 //   output LCDE;
 //   output [7:0] LCDDBO;
 //   input  [7:0] LCDDBI;
 //   output [4:0] KEYYO;
 //   input  [4:0] KEYXI;
 //   input  RXD;
 //   output TXD;
 //   input  CTS;
 //   output RTS;





 


 
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////



end  //end for FOR 

endgenerate


 


endmodule  


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

module des_wrapper (CLK,load,clk_core,rst_core,IN,OUT);

 
 //parameter NUM_UNITS = 33;
 parameter NUM_UNITS = 5;
 parameter CORE_DATIPUT_WIDTH = 233;
 parameter CORE_DATA_OUTPUT_WIDTH = 64;
   

//////////////////////////////////////////////////////////////////////////////////////	   
// PORTS
    input  CLK;
    input  load; 
    input  clk_core;
    input  rst_core;
       
	input  [NUM_UNITS-1:0] IN; 
    output [NUM_UNITS-1:0] OUT ; 
    
	wire [CORE_DATIPUT_WIDTH-1:0] core_in [NUM_UNITS-1:0] ; 
	wire [CORE_DATA_OUTPUT_WIDTH-1:0] core_out [NUM_UNITS-1:0]; 

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

des3 inst_top(.desOut(core_out[gv][63:0]), .desIn(core_in[gv][63:0]),
    .key1(core_in[gv][119:64]), .decrypt(core_in[gv][120]), .clk(clk_core),.key2(core_in[gv][176:121]),.key3(core_in[gv][232:177]));
//output	[63:0]	desOut;
//input	[63:0]	desIn;
//input	[55:0]	key;
//input		decrypt;
//input		clk;





 


 
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////



end  //end for FOR 

endgenerate


 


endmodule  


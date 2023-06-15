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



`include "oc8051_defines.v"

module oc8051_wrapper140 (CLK,load,clk_core,rst_core,IN,OUT,my_special_output);

 
 parameter NUM_UNITS = 140;  
 parameter CORE_DATA_INPUT_WIDTH = 88;
 parameter CORE_DATA_OUTPUT_WIDTH = 79;
   

//////////////////////////////////////////////////////////////////////////////////////	   
// PORTS
    input  CLK;
    input  load; 
    input  clk_core;
    input  rst_core;
       
	input  [NUM_UNITS-1:0] IN; 
    output [NUM_UNITS-1:0] OUT ; 

output [9:0] my_special_output;

    
	wire [CORE_DATA_INPUT_WIDTH-1:0] core_in [NUM_UNITS-1:0] ; 
	wire [CORE_DATA_OUTPUT_WIDTH-1:0] core_out [NUM_UNITS-1:0]; 

genvar gv;
  
generate 

 			

for (gv=0; gv < NUM_UNITS ; gv = gv + 1)
begin: aby

///////assign core_out[gv] = core_in[gv];

handsome_wr #(.length(CORE_DATA_INPUT_WIDTH))  inst_handsome_wr(.clk(CLK), .sr_in(IN[gv]), .par_out(core_in[gv]));
handsome_rd #(.length(CORE_DATA_OUTPUT_WIDTH)) inst_handsome_rd(.clk(CLK), .load(load), .par_in(core_out[gv]), .sr_out(OUT[gv]));
  

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
oc8051_top inst_oc8051(
		.wb_rst_i(rst_core), 
		.wb_clk_i(clk_core),
//interface to instruction rom
		.wbi_adr_o(core_out[gv][15:0]),  //16
		.wbi_dat_i(core_in[gv][31:0]),   //32
		.wbi_stb_o(core_out[gv][16]),     //1
		.wbi_ack_i(core_in[gv][32]),      //1
		.wbi_cyc_o(core_out[gv][17]),     //1  
		.wbi_err_i(core_in[gv][33]),      //1

//interface to data ram
		.wbd_dat_i(core_in[gv][41:34]),       // 8
		.wbd_dat_o(core_out[gv][25:18]),      // 8
		.wbd_adr_o(core_out[gv][41:26]),      // 16
		.wbd_we_o(core_out[gv][42]),       //  1
		.wbd_ack_i(core_in[gv][42]),       // 1
		.wbd_stb_o(core_out[gv][43]),      // 1
		.wbd_cyc_o(core_out[gv][44]),      // 1
		.wbd_err_i(core_in[gv][43]),       // 1

// interrupt interface
		.int0_i(core_in[gv][44]),          //1
		.int1_i(core_in[gv][45]),          //1


// port interface
  `ifdef OC8051_PORTS
	`ifdef OC8051_PORT0
		.p0_i(core_in[gv][53:46]),            // 8
		.p0_o(core_out[gv][52:45]),           //8
	`endif

	`ifdef OC8051_PORT1
		.p1_i(core_in[gv][61:54]),             // 8
		.p1_o(core_out[gv][60:53]),             // 8
	`endif

	`ifdef OC8051_PORT2
		.p2_i(core_in[gv][69:62]),             //  8
		.p2_o(core_out[gv][68:61]),            //  8
	`endif

	`ifdef OC8051_PORT3
		.p3_i(core_in[gv][77:70]),           // 8
		.p3_o(core_out[gv][76:69]),          // 8
	`endif
  `endif

// serial interface
	`ifdef OC8051_UART
		.rxd_i(core_in[gv][78]),           // 1
		.txd_o(core_out[gv][77]),          // 1
	`endif

// counter interface
	`ifdef OC8051_TC01
		.t0_i(core_in[gv][79]),             // 1
		.t1_i(core_in[gv][80]),             // 1
	`endif

	`ifdef OC8051_TC2
		.t2_i(core_in[gv][81]),              // 1
		.t2ex_i(core_in[gv][82]),            // 1
	`endif

// BIST
`ifdef OC8051_BIST
         .scanb_rst(core_in[gv][83]),    // 1
         .scanb_clk(core_in[gv][84]),    // 1
         .scanb_si(core_in[gv][85]),     // 1
         .scanb_so(core_out[gv][78]),    // 1
         .scanb_en(core_in[gv][86]),     // 1
`endif
// external access (active low)
		.ea_in(core_in[gv][87])                // 1
		);



 
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////



end  //end for FOR 

endgenerate


 


endmodule  


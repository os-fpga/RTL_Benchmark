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



`include "or1200_defines.v"

module or1k_wrapper (CLK,load,
                    clk_core,rst_core,
                    clk_wishbone_data, rst_wishbone_data,
                    clk_wishbone_inst, rst_wishbone_inst,
                    IN,OUT);

 
 parameter NUM_UNITS = 4;  
 parameter CORE_DATA_INPUT_WIDTH = 161;
 parameter CORE_DATA_OUTPUT_WIDTH = 189;
   

//////////////////////////////////////////////////////////////////////////////////////	   
// PORTS
    input  CLK;
    input  load; 
    input  clk_wishbone_data, rst_wishbone_data;
    input  clk_wishbone_inst, rst_wishbone_inst;
    input  clk_core;
    input  rst_core;
       
	input  [NUM_UNITS-1:0] IN; 
    output [NUM_UNITS-1:0] OUT ; 
    
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
////////////////////////////////////////////////////////////////////////

or1200_top inst_or1200_top (
	// System
	.clk_i(clk_core), 
	.rst_i(rst_core), 
	.pic_ints_i(core_in[gv][19:0]), // PPIC_INTS = 20 change this if PPIC_INTS is changed 
	.clmode_i(core_in[gv][21:20]),

	// Instruction WISHBONE INTERFACE
	.iwb_clk_i(clk_wishbone_inst), 
	.iwb_rst_i(rst_wishbone_inst), 
	.iwb_ack_i(core_in[gv][22]), 
	.iwb_err_i(core_in[gv][23]), 
	.iwb_rty_i(core_in[gv][24]), 
	.iwb_dat_i(core_in[gv][56:25]),  // dw = OR1200_OPERAND_WIDTH = 32  check or1200_defines
	.iwb_cyc_o(core_out[gv][0]), 
	.iwb_adr_o(core_out[gv][32:1]),   // aw = OR1200_OPERAND_WIDTH = 32  check or1200_defines 
	.iwb_stb_o(core_out[gv][33]), 
	.iwb_we_o(core_out[gv][34]), 
	.iwb_sel_o(core_out[gv][38:35]), 
	.iwb_dat_o(core_out[gv][42:39]),
`ifdef OR1200_WB_CAB
	.iwb_cab_o(core_out[gv][43]),
`endif
`ifdef OR1200_WB_B3
	.iwb_cti_o(core_out[gv][46:44]), 
	.iwb_bte_o(core_out[gv][48:47]),
`endif
	// Data WISHBONE INTERFACE
	.dwb_clk_i(clk_wishbone_data), 
	.dwb_rst_i(rst_wishbone_data), 
	.dwb_ack_i(core_in[gv][57]), 
	.dwb_err_i(core_in[gv][58]), 
	.dwb_rty_i(core_in[gv][59]), 
	.dwb_dat_i(core_in[gv][91:60]),          // dw = OR1200_OPERAND_WIDTH = 32  check or1200_defines
	.dwb_cyc_o (core_out[gv][49]), 
	.dwb_adr_o (core_out[gv][81:50]),        // aw = OR1200_OPERAND_WIDTH = 32  check or1200_defines 
	.dwb_stb_o (core_out[gv][82]),
	.dwb_we_o (core_out[gv][83]), 
	.dwb_sel_o(core_out[gv][87:84]), 
	.dwb_dat_o(core_out[gv][119:88]),            // dw = OR1200_OPERAND_WIDTH = 32  check or1200_defines
`ifdef OR1200_WB_CAB
	.dwb_cab_o  (core_out[gv][120]), 
`endif
`ifdef OR1200_WB_B3
	.dwb_cti_o(core_out[gv][123:121]), 
	.dwb_bte_o(core_out[gv][125:124]),
`endif

	// External Debug Interface
	.dbg_stall_i (core_in[gv][92]), 
	.dbg_ewt_i (core_in[gv][93]),	
	.dbg_lss_o(core_out[gv][129:126]), 
	.dbg_is_o(core_out[gv][131:130]),  
	.dbg_wp_o(core_out[gv][142:132]),                                    // (11), 
	.dbg_bp_o(core_out[gv][143]),
	.dbg_stb_i (core_in[gv][94]), 
	.dbg_we_i  (core_in[gv][95]), 
	.dbg_adr_i (core_in[gv][127:96]),          // (aw), 
	.dbg_dat_i (core_in[gv][159:128]),         // (dw), 
	.dbg_dat_o (core_out[gv][175:144]),            // (dw), 
	.dbg_ack_o (core_out[gv][176]), 
	
`ifdef OR1200_BIST
	// RAM BIST
	.mbist_si_i,    // ignore
	.mbist_so_o,    // ignore
	.mbist_ctrl_i,  // ignore
`endif
	// Power Management
	.pm_cpustall_i (core_in[gv][160]),  
	.pm_clksd_o (core_out[gv][180:177]),        // (4), 
	.pm_dc_gate_o (core_out[gv][181]),  
	.pm_ic_gate_o (core_out[gv][182]),  
	.pm_dmmu_gate_o (core_out[gv][183]),  
	.pm_immu_gate_o (core_out[gv][184]),  
	.pm_tt_gate_o (core_out[gv][185]),  
	.pm_cpu_gate_o (core_out[gv][186]),  
	.pm_wakeup_o (core_out[gv][187]),  
	.pm_lvolt_o (core_out[gv][188])

);

 
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////



end  //end for FOR 

endgenerate


 


endmodule  


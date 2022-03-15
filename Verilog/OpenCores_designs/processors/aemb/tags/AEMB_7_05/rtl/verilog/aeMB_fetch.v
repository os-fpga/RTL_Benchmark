/*
 * $Id: aeMB_fetch.v,v 1.5 2007-05-17 09:08:21 sybreon Exp $
 * 
 * AEMB Instruction Fetch
 * Copyright (C) 2004-2007 Shawn Tan Ser Ngiap <shawn.tan@aeste.net>
 *  
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public License
 * as published by the Free Software Foundation; either version 2.1 of
 * the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
 * USA
 *
 * DESCRIPTION
 * Controls the instruction side of AEMB. Instruction cache and branch
 * prediction can be incorporated if needed.
 *
 * HISTORY
 * $Log: not supported by cvs2svn $
 * Revision 1.4  2007/04/27 00:23:55  sybreon
 * Added code documentation.
 * Improved size & speed of rtl/verilog/aeMB_aslu.v
 *
 * Revision 1.3  2007/04/11 04:30:43  sybreon
 * Added pipeline stalling from incomplete bus cycles.
 * Separated sync and async portions of code.
 *
 * Revision 1.2  2007/04/04 14:08:34  sybreon
 * Added initial interrupt/exception support.
 *
 * Revision 1.1  2007/03/09 17:52:17  sybreon
 * initial import
 *
 */

module aeMB_fetch (/*AUTOARG*/
   // Outputs
   iwb_adr_o, iwb_stb_o, rPC, rIWBSTB,
   // Inputs
   iwb_dat_i, nclk, prst, prun, rFSM, rBRA, rRESULT
   );
   parameter ISIZ = 32;

   // Instruction WB I/F
   output [ISIZ-1:0] iwb_adr_o;
   output 	     iwb_stb_o;   
   input [31:0]      iwb_dat_i;
 
   // System
   input 	     nclk, prst, prun;   
   
   // Internal
   output [31:0]     rPC;
   output 	     rIWBSTB;   
   input [1:0] 	     rFSM;   
   input 	     rBRA;
   input [31:0]      rRESULT;
      
   /**
    Instruction WISHBONE bus
    ------------------------
    Signals for the instruction side of the bus.
    */
   
   reg [31:0] 	     rIWBADR, rPC, xIWBADR, xPC;
   wire [31:0] 	     wPCNXT = {(rIWBADR[ISIZ-1:2] + 1'b1),2'b00};   
   assign 	     iwb_adr_o = {rIWBADR[ISIZ-1:2],2'b00}; // Word Aligned
   assign 	     iwb_stb_o = 1'b1;
   assign 	     rIWBSTB = 1'b1;      
   
   always @(/*AUTOSENSE*/rBRA or rFSM or rIWBADR or rRESULT or wPCNXT)
     begin	
	// PC Sources - ALU, Direct, Next
	case (rFSM)
	  //2'b01: xIWBADR <= 32'h00000010; // HWINT
	  //2'b10: xIWBADR <= 32'h00000020; // HWEXC
	  //2'b11: xIWBADR <= #1 32'h00000008; // SWEXC
	  default: xIWBADR <= (rBRA) ? rRESULT : wPCNXT;
	endcase // case (rFSM)
	
	xPC <= {rIWBADR[31:2],2'd0};	
     end // always @ (...

   // PIPELINE REGISTERS //////////////////////////////////////////////////
   
   always @(negedge nclk)
     if (prst) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rIWBADR <= 32'h0;
	rPC <= 32'h0;
	// End of automatics
     end else if (prun) begin
	rPC <= #1 xPC;
	rIWBADR <= #1 xIWBADR;	
     end
   
endmodule // aeMB_fetch
		 
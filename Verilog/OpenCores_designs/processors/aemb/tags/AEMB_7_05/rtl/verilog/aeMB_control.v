/*
 * $Id: aeMB_control.v,v 1.6 2007-05-17 09:08:21 sybreon Exp $
 * 
 * AE68 System Control Unit
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
 * Controls the state of the processor.
 * 
 * HISTORY
 * $Log: not supported by cvs2svn $
 * Revision 1.5  2007/05/16 12:32:21  sybreon
 * Added async BRA/DLY signals for future clock, reset, and interrupt features.
 *
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

module aeMB_control (/*AUTOARG*/
   // Outputs
   rFSM, nclk, prst, prun, frun, drun,
   // Inputs
   sys_rst_i, sys_clk_i, sys_int_i, sys_exc_i, rIWBSTB, iwb_ack_i,
   rDWBSTB, dwb_ack_i, rBRA, rDLY
   );
   // System
   input 	sys_rst_i, sys_clk_i;
   input 	sys_int_i;
   input 	sys_exc_i;   
   
   // Instruction WB
   input 	rIWBSTB;
   input 	iwb_ack_i;

   // Data WB
   input 	rDWBSTB;
   input 	dwb_ack_i;   

   // Internal
   input 	rBRA, rDLY;   
   output [1:0] rFSM;
   //, rLDST;
   output 	nclk, prst, prun;   
   output 	frun, drun;
      
   /**
    RUN Signal
    ----------
    This master run signal will pause or run the entire pipeline. It
    will pause for any incomplete bus transaction.
    */
   
   assign 	prun = ~((rDWBSTB ^ dwb_ack_i) | ((rIWBSTB ^ iwb_ack_i)));

   /**
    Debounce
    --------
    The following external signals are debounced and synchronised:
    - Interrupt
    */
   
   reg [2:0] rEXC, rINT;
   always @(negedge nclk)
     if (prst) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rINT <= 3'h0;
	// End of automatics
     end else if (prun) begin
	//rEXC <= #1 {rEXC[1:0], sys_exc_i};
	rINT <= #1 {rINT[1:0], sys_int_i};	
     end
   
   /**
    Machine States
    --------------
    The internal machine state is affected by external interrupt,
    exception and software exceptions. Only interrupts are
    implemented.
    
    TODO: Implement exceptions.
    */
   parameter [1:0]
		FSM_RUN = 2'o0,
		FSM_SWEXC = 2'o3,
		FSM_HWEXC = 2'o2,
		FSM_HWINT = 2'o1;
   
   reg [1:0] 	  rFSM, rNXT;
   always @(negedge nclk)
     if (prst) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rFSM <= 2'h0;
	// End of automatics
     end else if (prun) begin
	rFSM <= #1 rNXT;
     end

   always @(/*AUTOSENSE*/rFSM or rINT)
     case (rFSM)
       FSM_HWEXC: rNXT <= FSM_RUN;       
       //FSM_SWEXC: rNXT <= FSM_RUN;     
       FSM_HWINT: rNXT <= FSM_RUN;      
       default: begin
	  rNXT <= //(rEXC == 3'h3) ? FSM_HWEXC :
		  (rINT == 3'h3) ? FSM_HWINT :
		  FSM_RUN;	  
       end
     endcase // case (rFSM)
      
   /**
    Bubble
    ------
    Pipeline bubbles are introduced during a branch or interrupt.
    
    TODO: Implement interrupt bubble.
    */
   
   reg [1:0]    rRUN, xRUN;   
   assign 	{drun,frun} = xRUN;

   always @(/*AUTOSENSE*/rBRA or rDLY) begin
       xRUN <= {~(rBRA ^ rDLY), ~rBRA};
   end

   /**
    Clock/Reset
    -----------
    This controls the internal clock/reset signal for the core. Any
    DCM/PLL/DPLL can be instantiated here if needed.
    */
   
   reg [1:0] 	rRST;
   assign 	nclk = sys_clk_i;
   assign 	prst = rRST[1];

   always @(negedge nclk)     
     if (!sys_rst_i) begin
	rRST <= 2'h3;	
	/*AUTORESET*/
     end else begin
	rRST <= {rRST[0],1'b0};
     end

   
endmodule // aeMB_control

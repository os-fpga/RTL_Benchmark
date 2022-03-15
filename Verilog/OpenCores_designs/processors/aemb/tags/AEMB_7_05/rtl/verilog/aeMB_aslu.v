/*
 * $Id: aeMB_aslu.v,v 1.9 2007-05-17 09:08:21 sybreon Exp $
 *
 * AEMB Arithmetic Shift Logic Unit 
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
 * Arithmetic, shift and logic execution unit. It also performs the
 * necessary calculations for branch and load/store targets.
 * 
 * HISTORY
 * $Log: not supported by cvs2svn $
 * Revision 1.8  2007/04/30 15:56:50  sybreon
 * Removed byte acrobatics.
 *
 * Revision 1.7  2007/04/27 00:23:55  sybreon
 * Added code documentation.
 * Improved size & speed of rtl/verilog/aeMB_aslu.v
 *
 * Revision 1.6  2007/04/26 14:29:53  sybreon
 * Made minor performance optimisations.
 *
 * Revision 1.5  2007/04/25 22:15:04  sybreon
 * Added support for 8-bit and 16-bit data types.
 *
 * Revision 1.4  2007/04/11 04:30:43  sybreon
 * Added pipeline stalling from incomplete bus cycles.
 * Separated sync and async portions of code.
 *
 * Revision 1.3  2007/04/04 06:11:05  sybreon
 * Added CMP instruction
 *
 * Revision 1.2  2007/04/03 14:46:26  sybreon
 * Fixed endian correction issues on data bus.
 *
 * Revision 1.1  2007/03/09 17:52:17  sybreon
 * initial import
 *
 */

module aeMB_aslu (/*AUTOARG*/
   // Outputs
   dwb_adr_o, dwb_sel_o, rRESULT, rDWBSEL,
   // Inputs
   sDWBDAT, rBRA, rDLY, rREGA, rREGB, rSIMM, rMXSRC, rMXTGT, rMXALU,
   rOPC, rPC, rIMM, rRD, rRA, rMXLDST, nclk, prst, drun, prun
   );
   parameter DSIZ = 32;

   output [DSIZ-1:0] dwb_adr_o;
   output [3:0]      dwb_sel_o;   
   
   output [31:0]     rRESULT;
   output [3:0]      rDWBSEL;
   input [31:0]      sDWBDAT;   
   input 	     rBRA, rDLY;      
   input [31:0]      rREGA, rREGB;
   input [31:0]      rSIMM;
   input [1:0] 	     rMXSRC,rMXTGT;
   input [1:0] 	     rMXALU;
   input [5:0] 	     rOPC;
   input [31:0]      rPC;   
   input [15:0]      rIMM;
   input [4:0] 	     rRD, rRA;   
   input [1:0] 	     rMXLDST;   
   
   input 	     nclk, prst, drun, prun;   

   reg [31:0] 	    rRESULT, xRESULT;
   reg 		    rMSR_C, xMSR_C;

   /**
    Operand Selection
    -----------------
    Selects the A and B operands depending on the source. All
    forwarding information is controlled by the decode unit.
    */

   wire [31:0] 	    wOPA, wOPB;
   
   assign 	    wOPA =
		    (rMXSRC == 2'b11) ? sDWBDAT :
		    (rMXSRC == 2'b10) ? rRESULT :
		    (rMXSRC == 2'b01) ? rPC : 
		    rREGA;
   assign 	    wOPB =
		    (rMXTGT == 2'b11) ? sDWBDAT :
		    (rMXTGT == 2'b10) ? rRESULT :
		    (rMXTGT == 2'b01) ? rSIMM :
		    rREGB;
   
   /**
    Simple Arithmetic
    -----------------
    Performs addition and subtraction using a single 32-bit adder with
    carry in and out. This is done in parallel with other
    operations. The adder is also used to calculate branch target
    addresses as well as load/store memory addresses.
    
    TODO: Verify signed compare
    */
   
   wire 	    wADDC, wSUBC, wRES_AC, wCMPC, wOPC;
   wire [31:0] 	    wADD, wSUB, wRES_A, wCMP, wOPX;
   
   wire 	    wCMP0 = (wOPA[7:0] > wOPB[7:0]);
   wire 	    wCMP1 = (wOPA[15:8] > wOPB[15:8]);
   wire 	    wCMP2 = (wOPA[23:16] > wOPB[23:16]);
   wire 	    wCMP3 = (wOPA[31:24] > wOPB[31:24]);
   wire 	    wCMPU = (wOPA > wOPB);         
   wire 	    wCMPF = (rIMM[1]) ? wCMPU :
			    ((wCMPU & ~(wOPB[31] ^ wOPA[31])) | (wOPB[31] & ~wOPA[31]));
   
   assign 	    {wCMPC,wCMP} = {wSUBC,wCMPF,wSUB[30:0]};  
   assign 	    wOPX = (rOPC[0] & !rOPC[5]) ? ~wOPA : wOPA ;
   assign 	    wOPC = ((rMSR_C & rOPC[1]) | (rOPC[0] & !rOPC[1])) & (!rOPC[5] & !rMXLDST[1]);
   
   assign 	    {wSUBC,wSUB} = {wADDC,wADD}; 
   assign 	    {wADDC,wADD} = (wOPB + wOPX) + wOPC; 
      
   reg 		    rRES_AC;
   reg [31:0] 	    rRES_A;
   always @(/*AUTOSENSE*/rIMM or rOPC or wADD or wADDC or wCMP
	    or wCMPC or wSUB or wSUBC)
     case ({rOPC[3],rOPC[0],rIMM[0]})
       4'h2, 4'h6, 4'h7: {rRES_AC,rRES_A} <= #1 {~wSUBC,wSUB}; // SUB
       4'h3: {rRES_AC,rRES_A} <= #1 {~wCMPC,wCMP}; // CMP
       default: {rRES_AC,rRES_A} <= #1 {wADDC,wADD};       
     endcase // case ({rOPC[3],rOPC[0],rIMM[0]})
   
   /**
    Logic
    -----
    Performs all the simple logic functions in parallel with other
    operations.
    */
   
   wire [31:0] 	    wOR = wOPA | wOPB;
   wire [31:0] 	    wAND = wOPA & wOPB;
   wire [31:0] 	    wXOR = wOPA ^ wOPB;
   wire [31:0] 	    wANDN = wOPA & ~wOPB;
   
   reg [31:0] 	    rRES_L;
   always @(/*AUTOSENSE*/rOPC or wAND or wANDN or wOR or wXOR)
     case (rOPC[1:0])
       2'o0: rRES_L <= #1 wOR;
       2'o1: rRES_L <= #1 wAND;
       2'o2: rRES_L <= #1 wXOR;
       2'o3: rRES_L <= #1 wANDN;       
     endcase // case (rOPC[1:0])
   
   /**
    Shifter
    -------
    Performs shift instructions as well as sign extension. This is
    done in parallel with the other operations.
    */
   
   wire 	    wSRAC, wSRCC, wSRLC, wRES_SC;
   wire [31:0] 	    wSRA,wSRC, wSRL, wSEXT8, wSEXT16, wRES_S;
   assign 	    {wSRAC,wSRA} = {wOPA[0],wOPA[0],wOPA[31:1]};
   assign 	    {wSRCC,wSRC} = {wOPA[0],rMSR_C,wOPA[31:1]};
   assign 	    {wSRLC,wSRL} = {wOPA[0],1'b0,wOPA[31:1]};
   assign 	    wSEXT8 = {{(24){wOPA[7]}},wOPA[7:0]};
   assign 	    wSEXT16 = {{(16){wOPA[15]}},wOPA[15:0]};
   
   reg 		    rRES_SC;
   reg [31:0] 	    rRES_S;
   
   always @(/*AUTOSENSE*/rIMM or rMSR_C or wSEXT16 or wSEXT8 or wSRA
	    or wSRAC or wSRC or wSRCC or wSRL or wSRLC)
     case (rIMM[6:5])
       2'o0: {rRES_SC,rRES_S} <= #1 {wSRAC,wSRA};
       2'o1: {rRES_SC,rRES_S} <= #1 {wSRCC,wSRC};
       2'o2: {rRES_SC,rRES_S} <= #1 {wSRLC,wSRL};
       2'o3: {rRES_SC,rRES_S} <= #1 (rIMM[0]) ? {rMSR_C,wSEXT16} : {rMSR_C,wSEXT8};       
     endcase // case (rIMM[6:5])

   /**
    Mover
    -----
    Moves an operand from source to destination for move instructions
    done in parallel with other operations.
    */
   
   reg [31:0] 	    rRES_M;
   always @(/*AUTOSENSE*/rRA or wOPA or wOPB)
     rRES_M <= #1 (rRA[3]) ? wOPB : wOPA;   

   /**
    Data WISHBONE Bus
    -----------------
    Asserts the appropriate byte select signals depending on the size
    of the operation and the address location. For faster operation,
    the result of the adder is used as the end selector.
    
    FIXME: It does not check for invalid memory locations.
    FIXME: Endian correction!
    */

   reg [3:0] 	    rDWBSEL, xDWBSEL;
   assign 	    dwb_adr_o = {rRESULT[DSIZ-1:2],2'b00};
   assign 	    dwb_sel_o = rDWBSEL;

   always @(/*AUTOSENSE*/rOPC or wADD)
     case (wADD[1:0])
       2'o0: case (rOPC[1:0])
	       2'o0: xDWBSEL <= 4'h8;
	       2'o1: xDWBSEL <= 4'hC;
	       default: xDWBSEL <= 4'hF;
	     endcase // case (rOPC[1:0])
       2'o1: xDWBSEL <= 4'h4;
       2'o2: xDWBSEL <= (rOPC[0]) ? 4'h3 : 4'h2;       
       2'o3: xDWBSEL <= 4'h1;
     endcase // case (wADD[1:0])
   
   /**
    RESULT + C
    ----------
    The RESULT and MSR[C] are collected at the end of the pipeline,
    depending on the operation selected. This was done in order to
    allow the operations to proceed in parallel for faster speed.
    
    FIXME: rMSR[C] might need to be blocked (drun) during a branch.
    TODO: MTS/MFS instruction
    */
   
   always @(/*AUTOSENSE*/rMXALU or rRES_A or rRES_L or rRES_M
	    or rRES_S) begin
      case (rMXALU)
	2'o0: xRESULT <= #1 rRES_A;
	2'o1: xRESULT <= #1 rRES_L;
	2'o2: xRESULT <= #1 rRES_S;
	2'o3: xRESULT <= #1 rRES_M;	  
      endcase // case (rMXALU)
   end
   
   always @(/*AUTOSENSE*/rMSR_C or rMXALU or rOPC or rRES_AC
	    or rRES_SC) begin
      case (rMXALU)
	2'o0: xMSR_C <= #1 (rOPC[2]) ? rMSR_C : rRES_AC;
	2'o2: xMSR_C <= #1 rRES_SC;
	default: xMSR_C <= #1 rMSR_C;
      endcase // case (rMXALU)
   end
   
   // PIPELINE REGISTER //////////////////////////////////////////////////
   
   always @(negedge nclk)
     if (prst) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rDWBSEL <= 4'h0;
	rMSR_C <= 1'h0;
	rRESULT <= 32'h0;
	// End of automatics
     end else if (prun) begin
	rRESULT <= #1 xRESULT;
	rMSR_C <= #1 xMSR_C;
	rDWBSEL <= #1 xDWBSEL;	
     end
   
endmodule // aeMB_aslu

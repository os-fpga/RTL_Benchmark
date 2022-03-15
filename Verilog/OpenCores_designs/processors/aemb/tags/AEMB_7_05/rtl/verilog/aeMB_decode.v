/*
 * $Id: aeMB_decode.v,v 1.9 2007-05-17 09:08:21 sybreon Exp $
 * 
 * AEMB Instruction Decoder
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
 * Instruction decoder
 *
 * HISTORY
 * $Log: not supported by cvs2svn $
 * Revision 1.8  2007/04/30 15:58:31  sybreon
 * Fixed minor data hazard bug spotted by Matt Ettus.
 *
 * Revision 1.7  2007/04/27 04:23:17  sybreon
 * Removed some unnecessary bubble control.
 *
 * Revision 1.6  2007/04/27 00:23:55  sybreon
 * Added code documentation.
 * Improved size & speed of rtl/verilog/aeMB_aslu.v
 *
 * Revision 1.5  2007/04/25 22:15:04  sybreon
 * Added support for 8-bit and 16-bit data types.
 *
 * Revision 1.4  2007/04/11 04:30:43  sybreon
 * Added pipeline stalling from incomplete bus cycles.
 * Separated sync and async portions of code.
 *
 * Revision 1.3  2007/04/04 06:12:27  sybreon
 * Fixed minor bugs
 *
 * Revision 1.2  2007/04/03 14:46:26  sybreon
 * Fixed endian correction issues on data bus.
 *
 * Revision 1.1  2007/03/09 17:52:17  sybreon
 * initial import
 *
 */

module aeMB_decode (/*AUTOARG*/
   // Outputs
   rSIMM, rMXALU, rMXSRC, rMXTGT, rRA, rRB, rRD, rOPC, rIMM, rDWBSTB,
   rDWBWE, rDLY, rLNK, rBRA, rRWE, rMXLDST, dwb_stb_o, dwb_we_o,
   // Inputs
   sDWBDAT, rDWBSEL, rREGA, rRESULT, iwb_dat_i, nclk, prst, drun,
   frun, prun
   );
   // Internal I/F
   output [31:0] rSIMM;
   output [1:0]  rMXALU;
   output [1:0]  rMXSRC, rMXTGT;
   output [4:0]  rRA, rRB, rRD;
   output [5:0]  rOPC;   
   output [15:0] rIMM;
   output 	 rDWBSTB, rDWBWE;
   output 	 rDLY, rLNK, rBRA, rRWE;
   output [1:0]  rMXLDST;
   input [31:0]  sDWBDAT;   
   input [3:0] 	 rDWBSEL;   
   input [31:0]  rREGA, rRESULT;
   
   // External I/F
   input [31:0]  iwb_dat_i;
   output 	 dwb_stb_o, dwb_we_o;
   
   // System I/F
   input 	 nclk, prst, drun, frun, prun;

   /**
    rOPC/rRD/rRA/rRB/rIMM
    ---------------------
    Instruction latch for the different fields of the instruction
    ISA. This part may be changed in the future to incorporate an
    instruction cache.
   
    FIXME: Endian correction!
    TODO: Modify this for block RAM based instruction cache.
    */
   wire [31:0] 	 wIREG;
   assign 	 wIREG = iwb_dat_i;   
         
   wire [5:0] 	 wOPC = wIREG[31:26];
   wire [4:0] 	 wRD = wIREG[25:21];
   wire [4:0] 	 wRA = wIREG[20:16];
   wire [4:0] 	 wRB = wIREG[15:11];   
   wire [15:0] 	 wIMM = wIREG[15:0];

   reg [5:0] 	 rOPC;
   reg [4:0] 	 rRD, rRA, rRB;
   reg [15:0] 	 rIMM;
   reg [5:0] 	 xOPC;
   reg [4:0] 	 xRD, xRA, xRB;
   reg [15:0] 	 xIMM;

   /*
   assign 	 rOPC = wOPC;
   assign 	 rRA = wRA;
   assign 	 rRB = wRB;
   assign 	 rRD = wRD;
   assign 	 rIMM = wIMM;   
   */
   
   always @(/*AUTOSENSE*/frun or wIMM or wOPC or wRA or wRB or wRD)
     if (frun) begin
	xOPC <= wOPC;
	xRD <= wRD;
	xRA <= wRA;
	xRB <= wRB;
	xIMM <= wIMM;	
     end else begin
	xOPC <= 6'o40;	
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	xIMM <= 16'h0;
	xRA <= 5'h0;
	xRB <= 5'h0;
	xRD <= 5'h0;
	// End of automatics
     end // else: !if(frun)
   
   /**
    Opcode Groups
    -------------
    Start decoding by breaking up the opcode into groups. This should
    infer a bunch of decoders on appropriate synthesis tools.
    */
   
   wire 	 fGH0 = (wOPC[5:3] == 3'o0);
   wire 	 fGH1 = (wOPC[5:3] == 3'o1);
   wire 	 fGH2 = (wOPC[5:3] == 3'o2);
   wire 	 fGH3 = (wOPC[5:3] == 3'o3);
   wire 	 fGH4 = (wOPC[5:3] == 3'o4);
   wire 	 fGH5 = (wOPC[5:3] == 3'o5);
   wire 	 fGH6 = (wOPC[5:3] == 3'o6);
   wire 	 fGH7 = (wOPC[5:3] == 3'o7);
   wire 	 fGL0 = (wOPC[2:0] == 3'o0);
   wire 	 fGL1 = (wOPC[2:0] == 3'o1);
   wire 	 fGL2 = (wOPC[2:0] == 3'o2);
   wire 	 fGL3 = (wOPC[2:0] == 3'o3);
   wire 	 fGL4 = (wOPC[2:0] == 3'o4);
   wire 	 fGL5 = (wOPC[2:0] == 3'o5);
   wire 	 fGL6 = (wOPC[2:0] == 3'o6);
   wire 	 fGL7 = (wOPC[2:0] == 3'o7);
   
   /*
    Main Decoder
    ------------
    As there aren't many instruction groups to decode, we will decode
    all the instruction families here.
    */
   
   wire 	 fADD = ({wOPC[5:4],wOPC[0]} == 3'o0);
   wire 	 fSUB = ({wOPC[5:4],wOPC[0]} == 3'o1);   
   wire 	 fLOGIC = ({wOPC[5:4],wOPC[2]} == 3'o4);
   wire 	 fMUL = ({wOPC[5:4]} == 3'o1);
   
   wire 	 fLD = ({wOPC[5:4],wOPC[2]} == 3'o6);
   wire 	 fST = ({wOPC[5:4],wOPC[2]} == 3'o7);
   
   wire 	 fBCC = (wOPC[5:4] == 2'b10) & fGL7;
   wire 	 fBRU = (wOPC[5:4] == 2'b10) & fGL6;
   wire 	 fBRA = fBRU & wRA[3];   
   
   wire 	 fSHIFT = fGH4 & fGL4;
   wire 	 fIMM = fGH5 & fGL4;
   wire 	 fRET = fGH5 & fGL5;
   wire 	 fMISC = fGH4 & fGL5;

   /**
    MXALU
    -----
    This signal controls the MXALU mux inside the ASLU unit.
    */
   
   reg [1:0] 	 rMXALU, xMXALU;
   always @(/*AUTOSENSE*/fBRA or fLOGIC or fSHIFT) begin // frun
      xMXALU <= //(!fNBR) ? 2'o0 :
		(fSHIFT) ? 2'o2 :
		(fLOGIC) ? 2'o1 :
		(fBRA) ? 2'o3 :
		2'o0;	
   end
   
   /**
    BCC/BRA/RET
    -----------
    This signal controls the associated muxes for BRANCH, DELAY and
    LINK operations.
    */
   
   reg 		 rMXDLY,rMXLNK,xMXDLY,xMXLNK;
   reg [1:0] 	 rMXBRA,xMXBRA;
   always @(/*AUTOSENSE*/fBCC or fBRU or fRET or frun or wRA or wRD)
     if (frun) begin
	xMXBRA <=  //(!fNBR) ? 2'o0 :
		  (fBCC) ? 2'o3 :
		  (fRET) ? 2'o1 :
		  (fBRU) ? 2'o2 :
		  2'o0;	
	xMXDLY <=  //(!fNBR) ? 1'b0 :
		  (fBCC) ? wRD[4] :
		  (fRET) ? 1'b1 :
		  (fBRU) ? wRA[4] :
		  1'b0;
     end else begin // if (frun)
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	xMXBRA <= 2'h0;
	xMXDLY <= 1'h0;
	// End of automatics
     end // else: !if(frun)

   always @(/*AUTOSENSE*/fBRU or wRA) begin
      xMXLNK <=  //(!fNBR) ? 1'b0 :
		 (fBRU) ? wRA[2] : 1'b0;	
   end
   
   /**
    LD/ST
    -----
    This signal controls the mux that controls the LOAD and STORE
    operations.
    */
   
   reg [1:0] 	  rMXLDST,xMXLDST;
   always @(/*AUTOSENSE*/fLD or fST or frun)
     if (frun) begin
	xMXLDST <= //(!fNBR) ? 2'o0 :
		   (fLD) ? 2'o2 :
		   (fST) ? 2'o3 :
		   2'o0;	
     end else begin
	/*UTORESET*/
	// Beginning of autoreset for uninitialized flops
	xMXLDST <= 2'h0;
	// End of automatics
     end // else: !if(frun)
   
   /** 
    SRC/TGT
    -------
    Controls the muxes that select the appropriate sources for the A,
    B and D operands. All data hazards are resolved here.    
    */
   
   reg [1:0] 	  rMXSRC, rMXTGT, rMXALT, xMXSRC,xMXTGT,xMXALT;
   wire 	  fRWE = (|rRD) & !(&rMXBRA) & !(|rMXLDST);

   always @(/*AUTOSENSE*/fBCC or fBRU or fRWE or rMXLDST or rRD
	    or wOPC or wRA or wRB) begin // frun
      xMXSRC <= //(!fNBR) ? 2'o0 :
		(fBRU|fBCC) ? 2'o1 : // PC
		((rRD == wRA) & (rMXLDST == 2'o2)) ? 2'o3 : // DWB
		((rRD == wRA) & fRWE) ? 2'o2 : // FWD
		2'o0; // RA
      xMXTGT <= //(!fNBR) ? 2'o0 :
		(wOPC[3]) ? 2'o1 : // IMM
		((rRD == wRB) & (rMXLDST == 2'o2)) ? 2'o3 : // DWB
		((rRD == wRB) & fRWE) ? 2'o2 : // FWD
		2'o0;	// RB
      xMXALT <= //(!fNBR) ? 2'o0 :
		//(fBRU|fBCC) ? 2'o1 : // PC
		((rRD == wRA) & (rMXLDST == 2'o2)) ? 2'o3 : // DWB
		((rRD == wRA) & fRWE) ? 2'o2 : // FWD
		2'o0; // RA
   end // always @ (...
   
   /**
    IMM Latching
    ------------
    The logic to generate either a full 32-bit or sign extended 32-bit
    immediate is done here.
    */
   
   reg [31:0] 	 rSIMM, xSIMM;
   reg [15:0] 	 rIMMHI, xIMMHI;   
   reg 		 rFIMM, xFIMM;

   always @(/*AUTOSENSE*/fIMM or rFIMM or rIMMHI or wIMM) begin // frun
      xSIMM <= (rFIMM) ? {rIMMHI,wIMM} : {{(16){wIMM[15]}},wIMM};
      xFIMM <= fIMM;	
      xIMMHI <= (fIMM) ? wIMM : rIMMHI;	      
   end
   
   /**
    COMPARATOR
    ----------
    This performs the comparison for conditional branches. It handles
    the necessary data hazards. It generates a branch flag that is
    used by the execution stage.
    */
   
   wire [31:0] wREGA =
	       (rMXALT == 2'o3) ? sDWBDAT :
	       (rMXALT == 2'o2) ? rRESULT :
	       rREGA;   
   
   wire        wBEQ = (wREGA == 32'd0);
   wire        wBNE = ~wBEQ;
   wire        wBLT = wREGA[31];
   wire        wBLE = wBLT | wBEQ;   
   wire        wBGE = ~wBLT;
   wire        wBGT = ~wBLE;   
   
   reg 	       rBCC;   
   always @(/*AUTOSENSE*/rRD or wBEQ or wBGE or wBGT or wBLE or wBLT
	    or wBNE)
     case (rRD[2:0])
       3'o0: rBCC <= wBEQ;
       3'o1: rBCC <= wBNE;
       3'o2: rBCC <= wBLT;
       3'o3: rBCC <= wBLE;
       3'o4: rBCC <= wBGT;
       3'o5: rBCC <= wBGE;
       default: rBCC <= 1'b0;
     endcase // case (rRD[2:0])

   /**
    Branch Signals
    --------------
    This controls the generation of the BRANCH, DELAY and LINK
    signals.
    */
   
   reg 	       rBRA, rDLY, rLNK, xBRA, xDLY, xLNK;
   always @(/*AUTOSENSE*/drun or rBCC or rMXBRA or rMXDLY or rMXLNK)
     if (drun) begin
	case (rMXBRA)
	  2'o0: xBRA <= 1'b0;
	  2'o3: xBRA <= rBCC;
	  default: xBRA <= 1'b1;	  
	endcase // case (rMXBRA)
	
	case (rMXBRA)
	  2'o0: xDLY <= 1'b0;	  
	  2'o3: xDLY <= rBCC & rMXDLY;
	  default: xDLY <= rMXDLY;
	endcase // case (rMXBRA)

	case (rMXBRA)
	  2'o2: xLNK <= rMXLNK;	  
	  default: xLNK <= 1'b0;
	endcase // case (rMXBRA)
     end else begin // if (drun)
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	xBRA <= 1'h0;
	xDLY <= 1'h0;
	xLNK <= 1'h0;
	// End of automatics
     end // else: !if(drun)
   
   /**
    MXRWE
    -----
    This signal controls the flag that determines whether a D register
    is open for writing.
    */
   
   reg 		 rRWE, xRWE;
   wire 	 wRWE = |rRD;   
   always @(/*AUTOSENSE*/drun or rMXBRA or rMXLDST or wRWE)
     if (drun) begin
	case (rMXBRA)
	  default: xRWE <= 1'b0;	 
	  2'o2: xRWE <= wRWE ^ rMXLDST[0];
	  2'o0: xRWE <= wRWE;	  
	endcase // case (rMXBRA)
     end else begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	xRWE <= 1'h0;
	// End of automatics
     end // else: !if(drun)

   /**
    Data WISHBONE Bus
    -----------------
    The STB and WE signals for the DWB are decoded here depending on
    the LOAD/STORE control signal.    
    */
   
   reg rDWBSTB, rDWBWE, xDWBSTB, xDWBWE;
   assign dwb_stb_o = rDWBSTB;
   assign dwb_we_o = rDWBWE;

   always @(/*AUTOSENSE*/drun or rMXLDST)
     if (drun) begin
	xDWBSTB <= rMXLDST[1];
	xDWBWE <= rMXLDST[0];
     end else begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	xDWBSTB <= 1'h0;
	xDWBWE <= 1'h0;
	// End of automatics
     end
   
   // PIPELINE REGISTERS ///////////////////////////////////////////////

   always @(negedge nclk)
     if (prst) begin
	//rOPC <= 6'o40;	
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rBRA <= 1'h0;
	rDLY <= 1'h0;
	rDWBSTB <= 1'h0;
	rDWBWE <= 1'h0;
	rFIMM <= 1'h0;
	rIMM <= 16'h0;
	rIMMHI <= 16'h0;
	rLNK <= 1'h0;
	rMXALT <= 2'h0;
	rMXALU <= 2'h0;
	rMXBRA <= 2'h0;
	rMXDLY <= 1'h0;
	rMXLDST <= 2'h0;
	rMXLNK <= 1'h0;
	rMXSRC <= 2'h0;
	rMXTGT <= 2'h0;
	rOPC <= 6'h0;
	rRA <= 5'h0;
	rRB <= 5'h0;
	rRD <= 5'h0;
	rRWE <= 1'h0;
	rSIMM <= 32'h0;
	// End of automatics
     end else if (prun) begin // if (prst)
	rIMM <= #1 xIMM;
	rOPC <= #1 xOPC;
	rRA <= #1 xRA;
	rRB <= #1 xRB;
	rRD <= #1 xRD;

	rMXALU <= #1 xMXALU;
	rMXBRA <= #1 xMXBRA;
	rMXDLY <= #1 xMXDLY;
	rMXLNK <= #1 xMXLNK;
	rMXLDST <= #1 xMXLDST;

	rMXSRC <= #1 xMXSRC;
	rMXTGT <= #1 xMXTGT;
	rMXALT <= #1 xMXALT;

	rSIMM <= #1 xSIMM;
	rFIMM <= #1 xFIMM;
	rIMMHI <= #1 xIMMHI;	

	rBRA <= #1 xBRA;
	rDLY <= #1 xDLY;
	rLNK <= #1 xLNK;
	rRWE <= #1 xRWE;
	rDWBSTB <= #1 xDWBSTB;
	rDWBWE <= #1 xDWBWE;	
     end // if (prun)
   
endmodule // aeMB_decode

// Local Variables:
// verilog-library-directories:(".")
// verilog-library-files:("")
// End:
/* $Id: aeMB2_bpcu.v,v 1.5 2007-12-21 22:39:38 sybreon Exp $
**
** AEMB2 BRANCH/PROGRAMME COUNTER
** 
** Copyright (C) 2004-2007 Shawn Tan Ser Ngiap <shawn.tan@aeste.net>
**  
** This file is part of AEMB.
**
** AEMB is free software: you can redistribute it and/or modify it
** under the terms of the GNU Lesser General Public License as
** published by the Free Software Foundation, either version 3 of the
** License, or (at your option) any later version.
**
** AEMB is distributed in the hope that it will be useful, but WITHOUT
** ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
** or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General
** Public License for more details.
**
** You should have received a copy of the GNU Lesser General Public
** License along with AEMB. If not, see <http://www.gnu.org/licenses/>.
*/

module aeMB2_bpcu (/*AUTOARG*/
   // Outputs
   iwb_adr_o, rPC_MA, rPC_IF, rIMM_IF, rALT_IF, rOPC_IF, rRD_IF,
   rRA_IF, rRB_IF, rBRA,
   // Inputs
   iwb_dat_i, iwb_ack_i, rOPX_OF, rOPC_OF, rRA_OF, rRD_OF, rRES_EX,
   rRD_EX, rOPD_EX, clk_i, rst_i, ena_i, pha_i
   );
   parameter IWB = 32;
   parameter TXE = 1;   
   
   // IWB
   output [IWB-1:2] iwb_adr_o;
   input [31:0]     iwb_dat_i;
   input 	    iwb_ack_i;
   
   // PIPELINE
   output [31:2]    //rPC_OF,
		    rPC_MA,
		    rPC_IF;    
   output [15:0]    rIMM_IF;
   output [10:0]    rALT_IF;
   output [5:0]     rOPC_IF;
   output [4:0]     rRD_IF,
		    rRA_IF,
		    rRB_IF;

   // BRANCH DETECTION
   output [1:0]     rBRA; // {branch, delay}
   input [31:0]     rOPX_OF; // BCC op test   
   input [5:0] 	    rOPC_OF;
   input [4:0] 	    rRA_OF,
		    rRD_OF;   
   input [31:0]     rRES_EX;  

   // MEMORY HAZARD DETECTION
   input [4:0] 	    rRD_EX; ///< RD
   input [2:0] 	    rOPD_EX; ///< data register source (ALU, MEM/FSL, PC)
   
   // SYSTEM
   input 	    clk_i, 
		    rst_i, 
		    ena_i, 
		    pha_i;
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [1:0]		rBRA;
   reg [15:0]		rIMM_IF;
   reg [5:0]		rOPC_IF;
   reg [31:2]		rPC_IF;
   reg [31:2]		rPC_MA;
   reg [4:0]		rRA_IF;
   reg [4:0]		rRD_IF;
   // End of automatics

   /* Partial decoding */
   wire [5:0] 		rOPC = rOPC_IF;
   wire [4:0] 		rRA = rRA_IF;
   wire [4:0] 		rRB = rRB_IF;   
   wire 		fSFT = (rOPC == 6'o44);
   wire 		fLOG = ({rOPC[5:4],rOPC[2]} == 3'o4);      
   wire 		fMUL = (rOPC == 6'o20) | (rOPC == 6'o30);
   wire 		fBSF = (rOPC == 6'o21) | (rOPC == 6'o31);
   wire 		fDIV = (rOPC == 6'o22);   
   wire 		fRTD = (rOPC == 6'o55);
   wire 		fBCC = (rOPC == 6'o47) | (rOPC == 6'o57);
   wire 		fBRU = (rOPC == 6'o46) | (rOPC == 6'o56);
   wire 		fBRA = fBRU & rRA[3];      
   wire 		fIMM = (rOPC == 6'o54);
   wire 		fMOV = (rOPC == 6'o45);      
   wire 		fLOD = ({rOPC[5:4],rOPC[2]} == 3'o6);
   wire 		fSTR = ({rOPC[5:4],rOPC[2]} == 3'o7);
   wire 		fLDST = (rOPC[5:4] == 2'o3);      
   wire 		fPUT = (rOPC == 6'o33) & rRB[4];
   wire 		fGET = (rOPC == 6'o33) & !rRB[4];
   
   /* Select the PC. */
   
   reg [31:2] 		rPC, // PC
			rPC0, rPC1,// register based 
			rPCL[0:1]; // LUT based

   wire [31:2] 		wPCNXT = (pha_i | !TXE) ? rPC0 : rPC1; 
   wire [31:2] 		wPCINC = (rPC + 1);
   
   /* Check for RW data hazard */
   // TODO: Optimise

   wire 		fLOAD = (rOPD_EX == 3'o2);
   wire 		fMULT = (rOPD_EX == 3'o3);
   wire 		fWRE = |rRD_EX;
   wire 		fOPBHZD = (rRB_IF == rRD_EX) & (fLOAD | fMULT) & !fMOV & !rOPC_IF[3] & fWRE;
   wire 		fOPAHZD = (rRA_IF == rRD_EX) & (fLOAD | fMULT) & !fBRU & fWRE;      
   wire 		fOPDHZD = (rRD_IF == rRD_EX) & (fLOAD | fMULT) & fSTR & fWRE;   
   wire 		fHZD = (fOPBHZD | fOPAHZD | fOPDHZD) & !rBRA[1];

   /* 
    IWB PC OUTPUT
    
    This is part of the address generation stage. It pre-selects the
    next PC to fetch depending on whether it's a branch, retry or
    normal. A retry happens during a special hazard */
   
   wire [1:0] 		wIPCMX = {fHZD, rBRA[1]};
   assign 		iwb_adr_o = rPC[IWB-1:2];
   
   always @ (posedge clk_i) 
     if (rst_i) begin
	rPC <= {(30){1'b1}};
	/*AUTORESET*/
     end else if (ena_i) begin
	case (wIPCMX)
	  2'o0 : rPC <= #1 wPCNXT[IWB-1:2]; // normal
	  2'o1 : rPC <= #1 rRES_EX[IWB-1:2]; // branch/return/break
	  2'o2 : rPC <= #1 rPC_IF[IWB-1:2]; // retry/stall
	  default: rPC <= {(IWB-2){1'bX}}; // undefined
	endcase // case (wIPCMX)
     end

   /* 
    PC INCREMENT
    
    This will store the next PC in a holding register until it is
    needed during the next AG stage. */
   
   always @(posedge clk_i)
     if (rst_i) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rPC0 <= 30'h0;
	rPC1 <= 30'h0;
	// End of automatics
     end else if (ena_i) begin
	if (pha_i) 
	  rPC1 <= #1 wPCINC;
	else
	  rPC0 <= #1 wPCINC;	
     end
   
   /* 
    INSTRUCTION LATCH
    
    This latches onto the instruction. It may not work correctly if
    there is a pipeline stall. */
   
   reg [31:2] 		rPC_OF, rPC_EX;
   assign 		{rRB_IF, rALT_IF} = rIMM_IF;
   
   always @(posedge clk_i)
     if (rst_i) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rIMM_IF <= 16'h0;
	rOPC_IF <= 6'h0;
	rRA_IF <= 5'h0;
	rRD_IF <= 5'h0;
	// End of automatics
     end else if (ena_i & iwb_ack_i) begin
	{rOPC_IF, rRD_IF, rRA_IF, rIMM_IF} <= #1 iwb_dat_i;
     end

   /*
    PC PIPELINE
    
    This merely passes the PC down so that it is available during
    branch instructions. This may be modified to use a shift register.
    */

   always @(posedge clk_i) if (rst_i) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rPC_EX <= 30'h0;
	rPC_IF <= 30'h0;
	rPC_MA <= 30'h0;
	rPC_OF <= 30'h0;
	// End of automatics
   end else if (ena_i) begin
	// TODO: Stuff inside a small LUT FIFO
	{rPC_MA, rPC_EX, rPC_OF, rPC_IF} <= #1 {rPC_EX, rPC_OF, rPC_IF, rPC};	
   end

   /* Branch Control */
   
   wire 		wRTD = (rOPC_OF == 6'o55);
   wire 		wBCC = (rOPC_OF == 6'o47) | (rOPC_OF == 6'o57);
   wire 		wBRU = (rOPC_OF == 6'o46) | (rOPC_OF == 6'o56);
   
   wire 		wBEQ = (rOPX_OF == 32'd0);
   wire 		wBNE = ~wBEQ;
   wire 		wBLT = rOPX_OF[31];
   wire 		wBLE = wBLT | wBEQ;   
   wire 		wBGE = ~wBLT;
   wire 		wBGT = ~wBLE;   

   reg 			xXCC;
   
   always @(/*AUTOSENSE*/rRD_OF or wBEQ or wBGE or wBGT or wBLE
	    or wBLT or wBNE)
     case (rRD_OF[2:0])
       3'o0: xXCC <= wBEQ;
       3'o1: xXCC <= wBNE;
       3'o2: xXCC <= wBLT;
       3'o3: xXCC <= wBLE;
       3'o4: xXCC <= wBGT;
       3'o5: xXCC <= wBGE;
       default: xXCC <= 1'bX;
     endcase // case (rRD_OF[2:0])
   
   always @(posedge clk_i)
     if (rst_i) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rBRA <= 2'h0;
	// End of automatics
     end else if(ena_i) begin
	rBRA[1] <= #1 wRTD | wBRU | (wBCC & xXCC);	
	rBRA[0] <= #1 (wBRU & rRA_OF[4]) | (wBCC & rRD_OF[4]) | wRTD;      	
     end
   
endmodule // aeMB2_bpcu

/* $Log: not supported by cvs2svn $
/* Revision 1.4  2007/12/17 12:53:43  sybreon
/* Made idle thread PC track main PC.
/*
/* Revision 1.3  2007/12/13 20:12:11  sybreon
/* Code cleanup + minor speed regression.
/*
/* Revision 1.2  2007/12/12 19:16:59  sybreon
/* Minor optimisations (~10% faster)
/*
/* Revision 1.1  2007/12/11 00:43:17  sybreon
/* initial import
/* */
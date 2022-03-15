/* $Id: aeMB2_opmx.v,v 1.3 2007-12-13 20:12:11 sybreon Exp $
**
** AEMB2 OPERAND FETCH MUX
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

module aeMB2_opmx (/*AUTOARG*/
   // Outputs
   rOPM_OF, rOPX_OF, rOPA_OF, rOPB_OF,
   // Inputs
   rRES_EX, rRD_EX, rOPD_EX, rOPC_IF, rIMM_IF, rPC_IF, rRD_IF, rRA_IF,
   rRB_IF, rREGD_OF, rREGA_OF, rREGB_OF, rBRA, pha_i, clk_i, rst_i,
   ena_i
   );
   parameter TXE = 1;   

   output [31:0] rOPM_OF, // used for store
		 rOPX_OF, // used for BCC checking
		 rOPA_OF, // OPA as per ISA
		 rOPB_OF; // OPB as per ISA

   input [31:0]  rRES_EX;
   input [4:0] 	 rRD_EX;
   input [1:0] 	 rOPD_EX;   
   
   input [5:0] 	 rOPC_IF;
   input [15:0]  rIMM_IF;
   input [31:2]  rPC_IF;   
   input [4:0] 	 rRD_IF,
		 rRA_IF,
		 rRB_IF;
   
   input [31:0]  rREGD_OF,
		 rREGA_OF,
		 rREGB_OF;

   input [1:0] 	 rBRA;  
   
   // SYSTEM
   input 	 pha_i,
		 clk_i,
		 rst_i,
		 ena_i;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [31:0]		rOPA_OF;
   reg [31:0]		rOPB_OF;
   reg [31:0]		rOPM_OF;
   reg [31:0]		rOPX_OF;
   // End of automatics

   wire 		fSKP = (rBRA == 2'b10); // branch without delay

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
      
   /* IMMI implementation */
   
   reg [15:0] 		rIMM0, rIMM1, rIMML[0:1];
   reg 			rFIM0, rFIM1, rFIML[0:1];
   wire [15:0] 		wIMM = rIMML[!pha_i];
   wire [31:0] 		wSIMM;

   wire 		rFIM = (pha_i) ? rFIM0 : rFIM1;   
   wire [15:0] 		rIMM = (pha_i) ? rIMM0 : rIMM1;
   
   assign 		wSIMM[15:0] = rIMM_IF[15:0];   
   assign 		wSIMM[31:16] = (rFIM) ? 
				       {rIMM} : 
				       {(16){rIMM_IF[15]}};
   
   always @(posedge clk_i)
     if (rst_i) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rFIM0 <= 1'h0;
	rFIM1 <= 1'h0;
	rIMM0 <= 16'h0;
	rIMM1 <= 16'h0;
	// End of automatics
     end else if (ena_i) begin
	if (pha_i) begin  
	   rFIM0 <= #1 fIMM & !fSKP;
	   rIMM0 <= #1 rIMM_IF;
	end else begin
	   rFIM1 <= #1 fIMM & !fSKP;
	   rIMM1 <= #1 rIMM_IF;
	end
     end // else: !if(rst_i)
   
   /* Latch onto the operand */
   // TODO: Optimise
   
   wire 		fALU = (rOPD_EX == 3'o0);
   wire 		fWRE = |rRD_EX;
   wire 		wOPBFWD = !rOPC_IF[3] & (rRB_IF == rRD_EX) & fALU & !fMOV & fWRE;
   wire 		wOPAFWD = !(fBRU|fBCC) & (rRA_IF == rRD_EX) & fALU & fWRE;
   wire 		wOPXFWD = (fBCC) & (rRA_IF == rRD_EX) & fALU & fWRE;   
   wire 		wOPMFWD = (rRD_IF == rRD_EX) & fALU & fWRE;   
   
   wire [1:0] 		wOPB_MX = {rOPC_IF[3], wOPBFWD};
   wire [1:0] 		wOPA_MX = {fBRU|fBCC| (fMOV & !rRB[3]) , wOPAFWD};
   wire [1:0] 		wOPX_MX = {fBCC, wOPXFWD};   
   wire [1:0] 		wOPM_MX = {fSTR, wOPMFWD};   
   
   always @(posedge clk_i)
     if (rst_i) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rOPA_OF <= 32'h0;
	rOPB_OF <= 32'h0;
	rOPM_OF <= 32'h0;
	rOPX_OF <= 32'h0;
	// End of automatics
     end else if (ena_i) begin

	case (wOPX_MX)
	  // BCC
	  2'o2: rOPX_OF <= #1 rREGA_OF;	// reg  
	  2'o3: rOPX_OF <= #1 rRES_EX; // forward
	  default: rOPX_OF <= #1 32'hX;	  
	endcase // case (wOPX_MX)

	case (wOPM_MX)
	  2'o2: rOPM_OF <= #1 rREGD_OF;	// reg
	  2'o3: rOPM_OF <= #1 rRES_EX; // forward
	  default: rOPM_OF <= #1 32'hX;	  
	endcase // case (wOPM_MX)
	
	// OP B
	case (wOPB_MX)
	  2'o0: rOPB_OF <= #1 rREGB_OF; // reg
	  2'o1: rOPB_OF <= #1 rRES_EX; // forward
	  2'o2: rOPB_OF <= #1 wSIMM; // immediate
	  default: rOPB_OF <= #1 32'hX;	  
	endcase // case (wOPB_MX)
	
	case (wOPA_MX)
	  2'o0: rOPA_OF <= #1 rREGA_OF; // reg
	  2'o1: rOPA_OF <= #1 rRES_EX; // forward
	  2'o2: rOPA_OF <= #1 {rPC_IF, 2'd0}; // pc 
	  default: rOPA_OF <= #1 32'hX;	  
	endcase // case (wOPA_MX)

     end // if (ena_i)
   
endmodule // aeMB2_opmx

/* $Log: not supported by cvs2svn $
/* Revision 1.2  2007/12/12 19:16:59  sybreon
/* Minor optimisations (~10% faster)
/*
/* Revision 1.1  2007/12/11 00:43:17  sybreon
/* initial import
/* */
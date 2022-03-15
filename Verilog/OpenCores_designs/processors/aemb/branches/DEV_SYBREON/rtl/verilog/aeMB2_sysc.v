/* $Id: aeMB2_sysc.v,v 1.5 2007-12-21 22:28:56 sybreon Exp $
**
** AEMB2 SYSTEM CONTROL
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

module aeMB2_sysc (/*AUTOARG*/
   // Outputs
   rINT, rXCE, pha_o, clk_o, rst_o, ena_o, iwb_stb_o, iwb_wre_o,
   dwb_cyc_o, dwb_stb_o, dwb_wre_o, cwb_stb_o, cwb_wre_o,
   // Inputs
   rIMM_OF, rOPC_OF, rRA_OF, rMSR_BE, rMSR_BIP, rMSR_IE, rOPC_IF,
   iwb_ack_i, dwb_ack_i, cwb_ack_i, sys_int_i, sys_clk_i, sys_rst_i
   );
   parameter TXE = 1;
   parameter FSL = 1;   
   
   // INTERNAL
   input [15:0] rIMM_OF;   
   input [5:0] 	rOPC_OF;
   input [4:0] 	rRA_OF;
   input 	rMSR_BE,
		rMSR_BIP,
		//rMSR_TXE,
		rMSR_IE;   
   input [5:0] 	rOPC_IF;
   
   output 	rINT,
		rXCE;
   
   output 	pha_o,
		clk_o, 
		rst_o, 
		ena_o;   
   
   // EXTERNAL
   output 	iwb_stb_o,
		iwb_wre_o,
		dwb_cyc_o,
		dwb_stb_o,
		dwb_wre_o,
		cwb_stb_o,
		cwb_wre_o;   
   
   input 	iwb_ack_i,
		dwb_ack_i,
		cwb_ack_i;   
      
   // SYSTEM
   input       sys_int_i,
	       sys_clk_i, 
	       sys_rst_i;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			cwb_stb_o;
   reg			cwb_wre_o;
   reg			dwb_cyc_o;
   reg			dwb_stb_o;
   reg			dwb_wre_o;
   reg			iwb_stb_o;
   reg			pha_o;
   reg			rINT;
   reg			rXCE;
   reg			rst_o;
   // End of automatics

   
   /* Partial decoding */
   wire [5:0] 		rOPC = rOPC_OF;
   wire [4:0] 		rRA = rRA_OF;
   wire [4:0] 		rRB = rIMM_OF[15:11];
   
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
   
   /* instantiate a clock manager if necessary */
   
   assign 		clk_o = sys_clk_i;   

   
   /* delay the reset signal for POR */
     
   always @(posedge clk_o)
     if (sys_rst_i) begin
	rst_o <= 1'b1;	
     end else if (!pha_o) begin
	rst_o <= #1 1'b0;	
     end

   /* calculate the async enable signal */
   
   assign 		ena_o = !((cwb_ack_i ^ cwb_stb_o) | // FSL clean
				  (dwb_ack_i ^ dwb_stb_o) | // DWB clean
				  (iwb_ack_i ^ iwb_stb_o)); // IWB clean  


   /* Toggle the FGMT phase. This toggles twice during POR to reset
   /* the various RAM locations (for a LUT based optimisation). */
   
   always @(posedge clk_o)
     if (sys_rst_i) begin
	pha_o <= 1'b1;	
	/*AUTORESET*/
     end else if (ena_o) begin
	pha_o <= #1 !pha_o;	
     end

   /* Level triggered interrupt latch flag */

   // check for interrupt acknowledge
   wire 		fINTACK = ena_o & (rOPC_OF == 6'o56) & (rRA_OF == 5'h0E);   
		   
   always @(posedge clk_o)
     if (rst_o) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rINT <= 1'h0;
	// End of automatics
     end else if (rMSR_IE) begin
	rINT <= #1 (rINT | sys_int_i) & !fINTACK;	
     end

   /* Hardwre exception catcher */

   // check for exception acknowledge
   wire 		fXCEACK = ena_o & (rOPC_OF == 6'o56) & (rRA_OF == 5'h0F);   

   // check for invalid instruction
   wire 		fILLEGAL;
   assign 		fILLEGAL = ({rOPC_IF[5:4],rOPC_IF[1:0]} == 4'hF) | // LD/ST
				   ((rOPC_IF[5:3] == 3'o3) & 
				    ((rOPC_OF[2:0] != 3'o2) | 
				     (rOPC_OF[2]))) | // GET/PUT
				   ((rOPC_IF[5:3] == 3'o2) &
				    (rOPC_IF[2:1] != 2'o0)) // MUL/BSF
				     ;
      
   /* Handle wishbone handshakes */
   
   assign iwb_wre_o = 1'b0;
   
   always @(posedge clk_o)
     if (rst_o) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	cwb_stb_o <= 1'h0;
	cwb_wre_o <= 1'h0;
	dwb_cyc_o <= 1'h0;
	dwb_stb_o <= 1'h0;
	dwb_wre_o <= 1'h0;
	iwb_stb_o <= 1'h0;
	// End of automatics
     end else if (ena_o) begin
	iwb_stb_o <= #1 (TXE | pha_o);

	dwb_cyc_o <= #1 fLOD | fSTR | rMSR_BE;	
	dwb_stb_o <= #1 fLOD | fSTR;
	dwb_wre_o <= #1 fSTR;
	
	cwb_stb_o <= #1 (FSL) ? (fGET | fPUT) : 1'bX;
	cwb_wre_o <= #1 (FSL) ? fPUT : 1'bX;	
     end
   

   
endmodule // aeMB2_sysc

/* $Log: not supported by cvs2svn $
/* Revision 1.4  2007/12/16 03:25:02  sybreon
/* Added interrupt support.
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
// $Id: aeMB_edk32.v,v 1.11 2007-11-30 17:08:29 sybreon Exp $
//
// AEMB EDK 3.2 Compatible Core
//
// Copyright (C) 2004-2007 Shawn Tan Ser Ngiap <shawn.tan@aeste.net>
//  
// This file is part of AEMB.
//
// AEMB is free software: you can redistribute it and/or modify it
// under the terms of the GNU Lesser General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// AEMB is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
// or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General
// Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with AEMB. If not, see <http://www.gnu.org/licenses/>.
//
// $Log: not supported by cvs2svn $
// Revision 1.10  2007/11/16 21:52:03  sybreon
// Added fsl_tag_o to FSL bus (tag either address or data).
//
// Revision 1.9  2007/11/14 23:19:24  sybreon
// Fixed minor typo.
//
// Revision 1.8  2007/11/14 22:14:34  sybreon
// Changed interrupt handling system (reported by M. Ettus).
//
// Revision 1.7  2007/11/10 16:39:38  sybreon
// Upgraded license to LGPLv3.
// Significant performance optimisations.
//
// Revision 1.6  2007/11/09 20:51:52  sybreon
// Added GET/PUT support through a FSL bus.
//
// Revision 1.5  2007/11/08 17:48:14  sybreon
// Fixed data WISHBONE arbitration problem (reported by J Lee).
//
// Revision 1.4  2007/11/08 14:17:47  sybreon
// Parameterised optional components.
//
// Revision 1.3  2007/11/03 08:34:55  sybreon
// Minor code cleanup.
//
// Revision 1.2  2007/11/02 19:20:58  sybreon
// Added better (beta) interrupt support.
// Changed MSR_IE to disabled at reset as per MB docs.
//
// Revision 1.1  2007/11/02 03:25:40  sybreon
// New EDK 3.2 compatible design with optional barrel-shifter and multiplier.
// Fixed various minor data hazard bugs.
// Code compatible with -O0/1/2/3/s generated code.
//

module aeMB_edk32 (/*AUTOARG*/
   // Outputs
   iwb_stb_o, iwb_adr_o, fsl_wre_o, fsl_tag_o, fsl_stb_o, fsl_dat_o,
   fsl_adr_o, dwb_wre_o, dwb_stb_o, dwb_sel_o, dwb_dat_o, dwb_adr_o,
   // Inputs
   sys_int_i, iwb_dat_i, iwb_ack_i, fsl_dat_i, fsl_ack_i, dwb_dat_i,
   dwb_ack_i, sys_clk_i, sys_rst_i
   );
   // Bus widths
   parameter IW = 32; /// Instruction bus address width
   parameter DW = 32; /// Data bus address width

   // Optional functions
   parameter MUL = 1; // Multiplier
   parameter BSF = 1; // Barrel Shifter
   
   /*AUTOOUTPUT*/
   // Beginning of automatic outputs (from unused autoinst outputs)
   output [DW-1:2]	dwb_adr_o;		// From xecu of aeMB_xecu.v
   output [31:0]	dwb_dat_o;		// From regf of aeMB_regf.v
   output [3:0]		dwb_sel_o;		// From xecu of aeMB_xecu.v
   output		dwb_stb_o;		// From ctrl of aeMB_ctrl.v
   output		dwb_wre_o;		// From ctrl of aeMB_ctrl.v
   output [6:2]		fsl_adr_o;		// From xecu of aeMB_xecu.v
   output [31:0]	fsl_dat_o;		// From regf of aeMB_regf.v
   output		fsl_stb_o;		// From ctrl of aeMB_ctrl.v
   output [1:0]		fsl_tag_o;		// From xecu of aeMB_xecu.v
   output		fsl_wre_o;		// From ctrl of aeMB_ctrl.v
   output [IW-1:2]	iwb_adr_o;		// From bpcu of aeMB_bpcu.v
   output		iwb_stb_o;		// From ibuf of aeMB_ibuf.v
   // End of automatics
   /*AUTOINPUT*/
   // Beginning of automatic inputs (from unused autoinst inputs)
   input		dwb_ack_i;		// To ctrl of aeMB_ctrl.v
   input [31:0]		dwb_dat_i;		// To regf of aeMB_regf.v
   input		fsl_ack_i;		// To ctrl of aeMB_ctrl.v
   input [31:0]		fsl_dat_i;		// To regf of aeMB_regf.v
   input		iwb_ack_i;		// To ibuf of aeMB_ibuf.v, ...
   input [31:0]		iwb_dat_i;		// To ibuf of aeMB_ibuf.v
   input		sys_int_i;		// To ibuf of aeMB_ibuf.v
   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [10:0]		rALT;			// From ibuf of aeMB_ibuf.v
   wire			rBRA;			// From bpcu of aeMB_bpcu.v
   wire			rDLY;			// From bpcu of aeMB_bpcu.v
   wire [31:0]		rDWBDI;			// From regf of aeMB_regf.v
   wire [3:0]		rDWBSEL;		// From xecu of aeMB_xecu.v
   wire [15:0]		rIMM;			// From ibuf of aeMB_ibuf.v
   wire			rMSR_BIP;		// From xecu of aeMB_xecu.v
   wire			rMSR_IE;		// From xecu of aeMB_xecu.v
   wire [1:0]		rMXALT;			// From ctrl of aeMB_ctrl.v
   wire [2:0]		rMXALU;			// From ctrl of aeMB_ctrl.v
   wire [1:0]		rMXDST;			// From ctrl of aeMB_ctrl.v
   wire [1:0]		rMXSRC;			// From ctrl of aeMB_ctrl.v
   wire [1:0]		rMXTGT;			// From ctrl of aeMB_ctrl.v
   wire [5:0]		rOPC;			// From ibuf of aeMB_ibuf.v
   wire [31:2]		rPC;			// From bpcu of aeMB_bpcu.v
   wire [31:2]		rPCLNK;			// From bpcu of aeMB_bpcu.v
   wire [4:0]		rRA;			// From ibuf of aeMB_ibuf.v
   wire [4:0]		rRB;			// From ibuf of aeMB_ibuf.v
   wire [4:0]		rRD;			// From ibuf of aeMB_ibuf.v
   wire [31:0]		rREGA;			// From regf of aeMB_regf.v
   wire [31:0]		rREGB;			// From regf of aeMB_regf.v
   wire [31:0]		rRESULT;		// From xecu of aeMB_xecu.v
   wire [4:0]		rRW;			// From ctrl of aeMB_ctrl.v
   wire [31:0]		rSIMM;			// From ibuf of aeMB_ibuf.v
   wire [31:0]		xIREG;			// From ibuf of aeMB_ibuf.v
   // End of automatics

   input 		sys_clk_i;
   input 		sys_rst_i;
   
   wire 		grst = sys_rst_i;
   wire 		gclk = sys_clk_i;
   wire 		gena = !((dwb_stb_o ^ dwb_ack_i) | (fsl_stb_o ^ fsl_ack_i) | !iwb_ack_i);   
   
   // --- INSTANTIATIONS -------------------------------------
          
   aeMB_ibuf
     ibuf (/*AUTOINST*/
	   // Outputs
	   .rIMM			(rIMM[15:0]),
	   .rRA				(rRA[4:0]),
	   .rRD				(rRD[4:0]),
	   .rRB				(rRB[4:0]),
	   .rALT			(rALT[10:0]),
	   .rOPC			(rOPC[5:0]),
	   .rSIMM			(rSIMM[31:0]),
	   .xIREG			(xIREG[31:0]),
	   .iwb_stb_o			(iwb_stb_o),
	   // Inputs
	   .rBRA			(rBRA),
	   .rMSR_IE			(rMSR_IE),
	   .rMSR_BIP			(rMSR_BIP),
	   .iwb_dat_i			(iwb_dat_i[31:0]),
	   .iwb_ack_i			(iwb_ack_i),
	   .sys_int_i			(sys_int_i),
	   .gclk			(gclk),
	   .grst			(grst),
	   .gena			(gena));   
   
   aeMB_ctrl
     ctrl (/*AUTOINST*/
	   // Outputs
	   .rMXDST			(rMXDST[1:0]),
	   .rMXSRC			(rMXSRC[1:0]),
	   .rMXTGT			(rMXTGT[1:0]),
	   .rMXALT			(rMXALT[1:0]),
	   .rMXALU			(rMXALU[2:0]),
	   .rRW				(rRW[4:0]),
	   .dwb_stb_o			(dwb_stb_o),
	   .dwb_wre_o			(dwb_wre_o),
	   .fsl_stb_o			(fsl_stb_o),
	   .fsl_wre_o			(fsl_wre_o),
	   // Inputs
	   .rDLY			(rDLY),
	   .rIMM			(rIMM[15:0]),
	   .rALT			(rALT[10:0]),
	   .rOPC			(rOPC[5:0]),
	   .rRD				(rRD[4:0]),
	   .rRA				(rRA[4:0]),
	   .rRB				(rRB[4:0]),
	   .rPC				(rPC[31:2]),
	   .rBRA			(rBRA),
	   .rMSR_IE			(rMSR_IE),
	   .xIREG			(xIREG[31:0]),
	   .dwb_ack_i			(dwb_ack_i),
	   .iwb_ack_i			(iwb_ack_i),
	   .fsl_ack_i			(fsl_ack_i),
	   .gclk			(gclk),
	   .grst			(grst),
	   .gena			(gena));

   aeMB_bpcu #(IW)
     bpcu (/*AUTOINST*/
	   // Outputs
	   .iwb_adr_o			(iwb_adr_o[IW-1:2]),
	   .rPC				(rPC[31:2]),
	   .rPCLNK			(rPCLNK[31:2]),
	   .rBRA			(rBRA),
	   .rDLY			(rDLY),
	   // Inputs
	   .rMXALT			(rMXALT[1:0]),
	   .rOPC			(rOPC[5:0]),
	   .rRD				(rRD[4:0]),
	   .rRA				(rRA[4:0]),
	   .rRESULT			(rRESULT[31:0]),
	   .rDWBDI			(rDWBDI[31:0]),
	   .rREGA			(rREGA[31:0]),
	   .gclk			(gclk),
	   .grst			(grst),
	   .gena			(gena));

   aeMB_regf
     regf (/*AUTOINST*/
	   // Outputs
	   .rREGA			(rREGA[31:0]),
	   .rREGB			(rREGB[31:0]),
	   .rDWBDI			(rDWBDI[31:0]),
	   .dwb_dat_o			(dwb_dat_o[31:0]),
	   .fsl_dat_o			(fsl_dat_o[31:0]),
	   // Inputs
	   .rOPC			(rOPC[5:0]),
	   .rRA				(rRA[4:0]),
	   .rRB				(rRB[4:0]),
	   .rRW				(rRW[4:0]),
	   .rRD				(rRD[4:0]),
	   .rMXDST			(rMXDST[1:0]),
	   .rPCLNK			(rPCLNK[31:2]),
	   .rRESULT			(rRESULT[31:0]),
	   .rDWBSEL			(rDWBSEL[3:0]),
	   .rBRA			(rBRA),
	   .rDLY			(rDLY),
	   .dwb_dat_i			(dwb_dat_i[31:0]),
	   .fsl_dat_i			(fsl_dat_i[31:0]),
	   .gclk			(gclk),
	   .grst			(grst),
	   .gena			(gena));   

   aeMB_xecu #(DW, MUL, BSF)
     xecu (/*AUTOINST*/
	   // Outputs
	   .dwb_adr_o			(dwb_adr_o[DW-1:2]),
	   .dwb_sel_o			(dwb_sel_o[3:0]),
	   .fsl_adr_o			(fsl_adr_o[6:2]),
	   .fsl_tag_o			(fsl_tag_o[1:0]),
	   .rRESULT			(rRESULT[31:0]),
	   .rDWBSEL			(rDWBSEL[3:0]),
	   .rMSR_IE			(rMSR_IE),
	   .rMSR_BIP			(rMSR_BIP),
	   // Inputs
	   .rREGA			(rREGA[31:0]),
	   .rREGB			(rREGB[31:0]),
	   .rMXSRC			(rMXSRC[1:0]),
	   .rMXTGT			(rMXTGT[1:0]),
	   .rRA				(rRA[4:0]),
	   .rRB				(rRB[4:0]),
	   .rMXALU			(rMXALU[2:0]),
	   .rBRA			(rBRA),
	   .rDLY			(rDLY),
	   .rALT			(rALT[10:0]),
	   .rSIMM			(rSIMM[31:0]),
	   .rIMM			(rIMM[15:0]),
	   .rOPC			(rOPC[5:0]),
	   .rRD				(rRD[4:0]),
	   .rDWBDI			(rDWBDI[31:0]),
	   .rPC				(rPC[31:2]),
	   .gclk			(gclk),
	   .grst			(grst),
	   .gena			(gena));

   
   // --- SIMULATION KERNEL ----------------------------------
   // synopsys translate_off
   
`ifdef AEMB_SIMULATION_KERNEL

   wire [IW-1:0] 	iwb_adr = {iwb_adr_o, 2'd0};
   wire [DW-1:0] 	dwb_adr = {dwb_adr_o,2'd0};   
   wire [1:0] 		wBRA = {rBRA, rDLY};   
   wire [3:0] 		wMSR = {xecu.rMSR_BIP, xecu.rMSR_C, xecu.rMSR_IE, xecu.rMSR_BE};
   
   always @(posedge gclk) if (gena) begin
      
      $write ("\n", ($stime/10));
      $writeh (" PC=", iwb_adr );
      $writeh ("\t");
      
      case (wBRA)
	2'b00: $write(" ");
	2'b01: $write(".");	
	2'b10: $write("-");
	2'b11: $write("+");	
      endcase // case (wBRA)
      
      case (rOPC)
	6'o00: if (rRD == 0) $write("   "); else $write("ADD");
	6'o01: $write("RSUB");	
	6'o02: $write("ADDC");	
	6'o03: $write("RSUBC");	
	6'o04: $write("ADDK");	
	6'o05: case (rIMM[1:0])
		 2'o0: $write("RSUBK");	
		 2'o1: $write("CMP");	
		 2'o3: $write("CMPU");	
		 default: $write("XXX");
	       endcase // case (rIMM[1:0])
	6'o06: $write("ADDKC");	
	6'o07: $write("RSUBKC");	
	
	6'o10: $write("ADDI");	
	6'o11: $write("RSUBI");	
	6'o12: $write("ADDIC");	
	6'o13: $write("RSUBIC");	
	6'o14: $write("ADDIK");	
	6'o15: $write("RSUBIK");	
	6'o16: $write("ADDIKC");	
	6'o17: $write("RSUBIKC");	

	6'o20: $write("MUL");	
	6'o21: case (rALT[10:9])
		 2'o0: $write("BSRL");		 
		 2'o1: $write("BSRA");		 
		 2'o2: $write("BSLL");		 
		 default: $write("XXX");		 
	       endcase // case (rALT[10:9])
	6'o22: $write("IDIV");	

	6'o30: $write("MULI");	
	6'o31: case (rALT[10:9])
		 2'o0: $write("BSRLI");		 
		 2'o1: $write("BSRAI");		 
		 2'o2: $write("BSLLI");		 
		 default: $write("XXX");		 
	       endcase // case (rALT[10:9])
	6'o33: case (rRB[4:2])
		 3'o0: $write("GET");
		 3'o4: $write("PUT");		 
		 3'o2: $write("NGET");
		 3'o6: $write("NPUT");		 
		 3'o1: $write("CGET");
		 3'o5: $write("CPUT");		 
		 3'o3: $write("NCGET");
		 3'o7: $write("NCPUT");		 
	       endcase // case (rRB[4:2])

	6'o40: $write("OR");
	6'o41: $write("AND");	
	6'o42: if (rRD == 0) $write("   "); else $write("XOR");
	6'o43: $write("ANDN");	
	6'o44: case (rIMM[6:5])
		 2'o0: $write("SRA");
		 2'o1: $write("SRC");
		 2'o2: $write("SRL");
		 2'o3: if (rIMM[0]) $write("SEXT16"); else $write("SEXT8");		 
	       endcase // case (rIMM[6:5])
	
	6'o45: $write("MOV");	
	6'o46: case (rRA[3:2])
		 3'o0: $write("BR");		 
		 3'o1: $write("BRL");		 
		 3'o2: $write("BRA");		 
		 3'o3: $write("BRAL");		 
	       endcase // case (rRA[3:2])
	
	6'o47: case (rRD[2:0])
		 3'o0: $write("BEQ");	
		 3'o1: $write("BNE");	
		 3'o2: $write("BLT");	
		 3'o3: $write("BLE");	
		 3'o4: $write("BGT");	
		 3'o5: $write("BGE");
		 default: $write("XXX");		 
	       endcase // case (rRD[2:0])
	
	6'o50: $write("ORI");	
	6'o51: $write("ANDI");	
	6'o52: $write("XORI");	
	6'o53: $write("ANDNI");	
	6'o54: $write("IMMI");	
	6'o55: case (rRD[1:0])
		 2'o0: $write("RTSD");
		 2'o1: $write("RTID");
		 2'o2: $write("RTBD");
		 default: $write("XXX");		 
	       endcase // case (rRD[1:0])
	6'o56: case (rRA[3:2])
		 3'o0: $write("BRI");		 
		 3'o1: $write("BRLI");		 
		 3'o2: $write("BRAI");		 
		 3'o3: $write("BRALI");		 
	       endcase // case (rRA[3:2])
	6'o57: case (rRD[2:0])
		 3'o0: $write("BEQI");	
		 3'o1: $write("BNEI");	
		 3'o2: $write("BLTI");	
		 3'o3: $write("BLEI");	
		 3'o4: $write("BGTI");	
		 3'o5: $write("BGEI");	
		 default: $write("XXX");		 
	       endcase // case (rRD[2:0])
	
	6'o60: $write("LBU");	
	6'o61: $write("LHU");	
	6'o62: $write("LW");	
	6'o64: $write("SB");	
	6'o65: $write("SH");	
	6'o66: $write("SW");	
	
	6'o70: $write("LBUI");	
	6'o71: $write("LHUI");	
	6'o72: $write("LWI");	
	6'o74: $write("SBI");	
	6'o75: $write("SHI");	
	6'o76: $write("SWI");

	default: $write("XXX");	
      endcase // case (rOPC)

      case (rOPC[3])
	1'b1: $writeh("\tr",rRD,", r",rRA,", h",rIMM);
	1'b0: $writeh("\tr",rRD,", r",rRA,", r",rRB,"  ");	
      endcase // case (rOPC[3])

       
      // ALU
      $write("\t");
      $writeh(" A=",xecu.rOPA);
      $writeh(" B=",xecu.rOPB);
      
      case (rMXALU)
	3'o0: $write(" ADD");
	3'o1: $write(" LOG");
	3'o2: $write(" SFT");
	3'o3: $write(" MOV");
	3'o4: $write(" MUL");
	3'o5: $write(" BSF");
	default: $write(" XXX");
      endcase // case (rMXALU)
      $writeh("=h",xecu.xRESULT);

      // WRITEBACK
      $writeh("\tSR=", wMSR," ");
      
      if (regf.fRDWE) begin
	 case (rMXDST)
	   2'o2: begin
	      if (dwb_stb_o) $writeh("R",rRW,"=RAM(h",regf.xWDAT,")");
	      if (fsl_stb_o) $writeh("R",rRW,"=FSL(h",regf.xWDAT,")");
	   end
	   2'o1: $writeh("R",rRW,"=LNK(h",regf.xWDAT,")");
	   2'o0: $writeh("R",rRW,"=ALU(h",regf.xWDAT,")");
	 endcase // case (rMXDST)
      end
      
      // STORE
      if (dwb_stb_o & dwb_wre_o) begin
	 $writeh("RAM(", dwb_adr ,")=", dwb_dat_o);
	 case (dwb_sel_o)
	   4'hF: $write(":L");
	   4'h3,4'hC: $write(":W");
	   4'h1,4'h2,4'h4,4'h8: $write(":B");
	 endcase // case (dwb_sel_o)
	 
      end
      
   end // if (gena)
   
`endif //  `ifdef AEMB_SIMULATION_KERNEL
   // synopsys translate_on
      
endmodule // aeMB_edk32

/* $Id: aeMB2_edk32.v,v 1.8 2007-12-18 18:54:36 sybreon Exp $
**
** AEMB2 HI-PERFORMANCE CPU
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

module aeMB2_edk32 (/*AUTOARG*/
   // Outputs
   iwb_wre_o, iwb_tga_o, iwb_stb_o, iwb_adr_o, dwb_wre_o, dwb_tga_o,
   dwb_stb_o, dwb_sel_o, dwb_dat_o, dwb_cyc_o, dwb_adr_o, cwb_wre_o,
   cwb_tga_o, cwb_stb_o, cwb_sel_o, cwb_dat_o, cwb_adr_o,
   // Inputs
   sys_rst_i, sys_int_i, sys_clk_i, iwb_dat_i, iwb_ack_i, dwb_dat_i,
   dwb_ack_i, cwb_dat_i, cwb_ack_i
   );
   parameter IWB = 32; // instruction wishbone address space
   parameter DWB = 32; // data wishbone address space

   parameter TXE = 1; // thread execution extension
   
   parameter MUL = 1; // enable multiply instruction
   parameter BSF = 1; // enable barrel shift instructions
   parameter FSL = 1; // enable get/put instructions
   
   /*AUTOOUTPUT*/
   // Beginning of automatic outputs (from unused autoinst outputs)
   output [6:2]		cwb_adr_o;		// From aslu of aeMB2_aslu.v
   output [31:0]	cwb_dat_o;		// From regf of aeMB2_regf.v
   output [3:0]		cwb_sel_o;		// From aslu of aeMB2_aslu.v
   output		cwb_stb_o;		// From sysc of aeMB2_sysc.v
   output [1:0]		cwb_tga_o;		// From aslu of aeMB2_aslu.v
   output		cwb_wre_o;		// From sysc of aeMB2_sysc.v
   output [DWB-1:2]	dwb_adr_o;		// From aslu of aeMB2_aslu.v
   output		dwb_cyc_o;		// From sysc of aeMB2_sysc.v
   output [31:0]	dwb_dat_o;		// From regf of aeMB2_regf.v
   output [3:0]		dwb_sel_o;		// From aslu of aeMB2_aslu.v
   output		dwb_stb_o;		// From sysc of aeMB2_sysc.v
   output		dwb_tga_o;		// From aslu of aeMB2_aslu.v
   output		dwb_wre_o;		// From sysc of aeMB2_sysc.v
   output [IWB-1:2]	iwb_adr_o;		// From bpcu of aeMB2_bpcu.v
   output		iwb_stb_o;		// From sysc of aeMB2_sysc.v
   output		iwb_tga_o;		// From aslu of aeMB2_aslu.v
   output		iwb_wre_o;		// From sysc of aeMB2_sysc.v
   // End of automatics
   /*AUTOINPUT*/
   // Beginning of automatic inputs (from unused autoinst inputs)
   input		cwb_ack_i;		// To sysc of aeMB2_sysc.v, ...
   input [31:0]		cwb_dat_i;		// To regf of aeMB2_regf.v
   input		dwb_ack_i;		// To sysc of aeMB2_sysc.v, ...
   input [31:0]		dwb_dat_i;		// To regf of aeMB2_regf.v
   input		iwb_ack_i;		// To sysc of aeMB2_sysc.v, ...
   input [31:0]		iwb_dat_i;		// To bpcu of aeMB2_bpcu.v
   input		sys_clk_i;		// To sysc of aeMB2_sysc.v
   input		sys_int_i;		// To sysc of aeMB2_sysc.v
   input		sys_rst_i;		// To sysc of aeMB2_sysc.v
   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			clk_i;			// From sysc of aeMB2_sysc.v
   wire			ena_i;			// From sysc of aeMB2_sysc.v
   wire			pha_i;			// From sysc of aeMB2_sysc.v
   wire [10:0]		rALT_IF;		// From bpcu of aeMB2_bpcu.v
   wire [2:0]		rALU_OF;		// From ofid of aeMB2_ofid.v
   wire [1:0]		rBRA;			// From bpcu of aeMB2_bpcu.v
   wire [15:0]		rIMM_IF;		// From bpcu of aeMB2_bpcu.v
   wire [15:0]		rIMM_OF;		// From ofid of aeMB2_ofid.v
   wire			rINT;			// From sysc of aeMB2_sysc.v
   wire			rMSR_BE;		// From aslu of aeMB2_aslu.v
   wire			rMSR_BIP;		// From aslu of aeMB2_aslu.v
   wire			rMSR_IE;		// From aslu of aeMB2_aslu.v
   wire [31:0]		rMUL_MA;		// From aslu of aeMB2_aslu.v
   wire [31:0]		rOPA_OF;		// From ofid of aeMB2_ofid.v
   wire [31:0]		rOPB_OF;		// From ofid of aeMB2_ofid.v
   wire [5:0]		rOPC_IF;		// From bpcu of aeMB2_bpcu.v
   wire [5:0]		rOPC_OF;		// From ofid of aeMB2_ofid.v
   wire [2:0]		rOPD_EX;		// From ofid of aeMB2_ofid.v
   wire [2:0]		rOPD_MA;		// From ofid of aeMB2_ofid.v
   wire [31:0]		rOPM_OF;		// From ofid of aeMB2_ofid.v
   wire [31:0]		rOPX_OF;		// From ofid of aeMB2_ofid.v
   wire [31:2]		rPC_IF;			// From bpcu of aeMB2_bpcu.v
   wire [31:2]		rPC_MA;			// From bpcu of aeMB2_bpcu.v
   wire [4:0]		rRA_IF;			// From bpcu of aeMB2_bpcu.v
   wire [4:0]		rRA_OF;			// From ofid of aeMB2_ofid.v
   wire [4:0]		rRB_IF;			// From bpcu of aeMB2_bpcu.v
   wire [4:0]		rRD_EX;			// From ofid of aeMB2_ofid.v
   wire [4:0]		rRD_IF;			// From bpcu of aeMB2_bpcu.v
   wire [4:0]		rRD_MA;			// From ofid of aeMB2_ofid.v
   wire [4:0]		rRD_OF;			// From ofid of aeMB2_ofid.v
   wire [31:0]		rREGA_OF;		// From regf of aeMB2_regf.v
   wire [31:0]		rREGB_OF;		// From regf of aeMB2_regf.v
   wire [31:0]		rREGD_OF;		// From regf of aeMB2_regf.v
   wire [31:0]		rRES_EX;		// From aslu of aeMB2_aslu.v
   wire [31:0]		rRES_MA;		// From aslu of aeMB2_aslu.v
   wire [3:0]		rSEL_MA;		// From aslu of aeMB2_aslu.v
   wire			rXCE;			// From sysc of aeMB2_sysc.v
   wire			rst_i;			// From sysc of aeMB2_sysc.v
   // End of automatics

   /* aeMB2_sysc AUTO_TEMPLATE (
    .clk_o(clk_i),
    .rst_o(rst_i),
    .ena_o(ena_i),
    .pha_o(pha_i),
    )*/

   /* System/Interrupt Control */
   
   aeMB2_sysc 
     #(/*AUTOINSTPARAM*/
       // Parameters
       .TXE				(TXE),
       .FSL				(FSL))
   sysc (/*AUTOINST*/
	 // Outputs
	 .rINT				(rINT),
	 .rXCE				(rXCE),
	 .pha_o				(pha_i),		 // Templated
	 .clk_o				(clk_i),		 // Templated
	 .rst_o				(rst_i),		 // Templated
	 .ena_o				(ena_i),		 // Templated
	 .iwb_stb_o			(iwb_stb_o),
	 .iwb_wre_o			(iwb_wre_o),
	 .dwb_cyc_o			(dwb_cyc_o),
	 .dwb_stb_o			(dwb_stb_o),
	 .dwb_wre_o			(dwb_wre_o),
	 .cwb_stb_o			(cwb_stb_o),
	 .cwb_wre_o			(cwb_wre_o),
	 // Inputs
	 .rIMM_OF			(rIMM_OF[15:0]),
	 .rOPC_OF			(rOPC_OF[5:0]),
	 .rRA_OF			(rRA_OF[4:0]),
	 .rMSR_BE			(rMSR_BE),
	 .rMSR_BIP			(rMSR_BIP),
	 .rMSR_IE			(rMSR_IE),
	 .rOPC_IF			(rOPC_IF[5:0]),
	 .iwb_ack_i			(iwb_ack_i),
	 .dwb_ack_i			(dwb_ack_i),
	 .cwb_ack_i			(cwb_ack_i),
	 .sys_int_i			(sys_int_i),
	 .sys_clk_i			(sys_clk_i),
	 .sys_rst_i			(sys_rst_i));

   /* Register file */

   aeMB2_regf 
     #(/*AUTOINSTPARAM*/
       // Parameters
       .TXE				(TXE),
       .MUL				(MUL))
   regf (/*AUTOINST*/
	 // Outputs
	 .dwb_dat_o			(dwb_dat_o[31:0]),
	 .cwb_dat_o			(cwb_dat_o[31:0]),
	 .rREGD_OF			(rREGD_OF[31:0]),
	 .rREGA_OF			(rREGA_OF[31:0]),
	 .rREGB_OF			(rREGB_OF[31:0]),
	 // Inputs
	 .dwb_dat_i			(dwb_dat_i[31:0]),
	 .dwb_ack_i			(dwb_ack_i),
	 .cwb_dat_i			(cwb_dat_i[31:0]),
	 .cwb_ack_i			(cwb_ack_i),
	 .rRA_IF			(rRA_IF[4:0]),
	 .rRB_IF			(rRB_IF[4:0]),
	 .rRD_IF			(rRD_IF[4:0]),
	 .rRD_MA			(rRD_MA[4:0]),
	 .rOPM_OF			(rOPM_OF[31:0]),
	 .rOPA_OF			(rOPA_OF[31:0]),
	 .rOPC_OF			(rOPC_OF[5:0]),
	 .rPC_MA			(rPC_MA[31:2]),
	 .rMUL_MA			(rMUL_MA[31:0]),
	 .rRES_MA			(rRES_MA[31:0]),
	 .rOPD_MA			(rOPD_MA[2:0]),
	 .rSEL_MA			(rSEL_MA[3:0]),
	 .clk_i				(clk_i),
	 .rst_i				(rst_i),
	 .ena_i				(ena_i),
	 .pha_i				(pha_i));

   /* Branch/Programme Counter Unit */
   
   aeMB2_bpcu
     #(/*AUTOINSTPARAM*/
       // Parameters
       .IWB				(IWB),
       .TXE				(TXE))     
   bpcu (/*AUTOINST*/
	 // Outputs
	 .iwb_adr_o			(iwb_adr_o[IWB-1:2]),
	 .rPC_MA			(rPC_MA[31:2]),
	 .rPC_IF			(rPC_IF[31:2]),
	 .rIMM_IF			(rIMM_IF[15:0]),
	 .rALT_IF			(rALT_IF[10:0]),
	 .rOPC_IF			(rOPC_IF[5:0]),
	 .rRD_IF			(rRD_IF[4:0]),
	 .rRA_IF			(rRA_IF[4:0]),
	 .rRB_IF			(rRB_IF[4:0]),
	 .rBRA				(rBRA[1:0]),
	 // Inputs
	 .iwb_dat_i			(iwb_dat_i[31:0]),
	 .iwb_ack_i			(iwb_ack_i),
	 .rOPX_OF			(rOPX_OF[31:0]),
	 .rOPC_OF			(rOPC_OF[5:0]),
	 .rRA_OF			(rRA_OF[4:0]),
	 .rRD_OF			(rRD_OF[4:0]),
	 .rRES_EX			(rRES_EX[31:0]),
	 .rRD_EX			(rRD_EX[4:0]),
	 .rOPD_EX			(rOPD_EX[2:0]),
	 .clk_i				(clk_i),
	 .rst_i				(rst_i),
	 .ena_i				(ena_i),
	 .pha_i				(pha_i));

   /* Operand Fetch Mux */
   
   aeMB2_ofid
     #(/*AUTOINSTPARAM*/
       // Parameters
       .TXE				(TXE),
       .MUL				(MUL),
       .BSF				(BSF),
       .FSL				(FSL))
   ofid (/*AUTOINST*/
	 // Outputs
	 .rOPM_OF			(rOPM_OF[31:0]),
	 .rOPX_OF			(rOPX_OF[31:0]),
	 .rOPA_OF			(rOPA_OF[31:0]),
	 .rOPB_OF			(rOPB_OF[31:0]),
	 .rIMM_OF			(rIMM_OF[15:0]),
	 .rOPC_OF			(rOPC_OF[5:0]),
	 .rRA_OF			(rRA_OF[4:0]),
	 .rRD_OF			(rRD_OF[4:0]),
	 .rRD_EX			(rRD_EX[4:0]),
	 .rRD_MA			(rRD_MA[4:0]),
	 .rOPD_EX			(rOPD_EX[2:0]),
	 .rOPD_MA			(rOPD_MA[2:0]),
	 .rALU_OF			(rALU_OF[2:0]),
	 // Inputs
	 .rRES_EX			(rRES_EX[31:0]),
	 .rREGD_OF			(rREGD_OF[31:0]),
	 .rREGA_OF			(rREGA_OF[31:0]),
	 .rREGB_OF			(rREGB_OF[31:0]),
	 .rBRA				(rBRA[1:0]),
	 .rXCE				(rXCE),
	 .rINT				(rINT),
	 .rPC_IF			(rPC_IF[31:2]),
	 .rIMM_IF			(rIMM_IF[15:0]),
	 .rALT_IF			(rALT_IF[10:0]),
	 .rOPC_IF			(rOPC_IF[5:0]),
	 .rRA_IF			(rRA_IF[4:0]),
	 .rRB_IF			(rRB_IF[4:0]),
	 .rRD_IF			(rRD_IF[4:0]),
	 .pha_i				(pha_i),
	 .clk_i				(clk_i),
	 .rst_i				(rst_i),
	 .ena_i				(ena_i));   
   
   
   /* Arithmetic Shift Logic Unit */

   aeMB2_aslu
     #(/*AUTOINSTPARAM*/
       // Parameters
       .DWB				(DWB),
       .TXE				(TXE),
       .MUL				(MUL),
       .BSF				(BSF),
       .FSL				(FSL))     
   aslu (/*AUTOINST*/
	 // Outputs
	 .dwb_adr_o			(dwb_adr_o[DWB-1:2]),
	 .dwb_sel_o			(dwb_sel_o[3:0]),
	 .rSEL_MA			(rSEL_MA[3:0]),
	 .cwb_adr_o			(cwb_adr_o[6:2]),
	 .cwb_tga_o			(cwb_tga_o[1:0]),
	 .cwb_sel_o			(cwb_sel_o[3:0]),
	 .iwb_tga_o			(iwb_tga_o),
	 .dwb_tga_o			(dwb_tga_o),
	 .rMUL_MA			(rMUL_MA[31:0]),
	 .rRES_MA			(rRES_MA[31:0]),
	 .rRES_EX			(rRES_EX[31:0]),
	 .rMSR_IE			(rMSR_IE),
	 .rMSR_BE			(rMSR_BE),
	 .rMSR_BIP			(rMSR_BIP),
	 // Inputs
	 .rIMM_OF			(rIMM_OF[15:0]),
	 .rALU_OF			(rALU_OF[2:0]),
	 .rOPC_OF			(rOPC_OF[5:0]),
	 .rOPC_IF			(rOPC_IF[5:0]),
	 .rRA_OF			(rRA_OF[4:0]),
	 .rRD_OF			(rRD_OF[4:0]),
	 .rOPA_OF			(rOPA_OF[31:0]),
	 .rOPB_OF			(rOPB_OF[31:0]),
	 .pha_i				(pha_i),
	 .clk_i				(clk_i),
	 .rst_i				(rst_i),
	 .ena_i				(ena_i));

      
endmodule // aeMB2_edk32

/* $Log: not supported by cvs2svn $
/* Revision 1.7  2007/12/17 12:53:13  sybreon
/* Changed simulation kernel.
/*
/* Revision 1.6  2007/12/16 03:25:22  sybreon
/* Replaced OF/ID blocks with combined block.
/*
/* Revision 1.5  2007/12/13 21:25:41  sybreon
/* Further optimisations (speed + size).
/*
/* Revision 1.4  2007/12/13 20:12:11  sybreon
/* Code cleanup + minor speed regression.
/*
/* Revision 1.3  2007/12/12 19:16:59  sybreon
/* Minor optimisations (~10% faster)
/*
/* Revision 1.2  2007/12/11 00:43:17  sybreon
/* initial import
/*
/* Revision 1.1  2007/12/07 18:58:51  sybreon
/* initial
/* */
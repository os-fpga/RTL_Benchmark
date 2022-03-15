/*
 * $Id: aeMB_wbbus.v,v 1.1 2007-04-13 13:02:34 sybreon Exp $
 * 
 * AEMB WISHBONE Bus Interface Unit
 * Copyright (C) 2006-2007 Shawn Tan Ser Ngiap <shawn.tan@aeste.net>
 *  
 * This library is free software; you can redistribute it and/or modify it 
 * under the terms of the GNU Lesser General Public License as published by 
 * the Free Software Foundation; either version 2.1 of the License, 
 * or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful, but 
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
 * or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public 
 * License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License 
 * along with this library; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA 
 *
 * DESCRIPTION
 * This contains the internal to external bus unifier as well as cache.
 * Cache is implemented as write-thru direct mapped cache.
 *
 * HISTORY
 * $Log: not supported by cvs2svn $
 */

// 98@90
module aeMB_wbbus (/*AUTOARG*/
   // Outputs
   wb_adr_o, wb_dat_o, wb_sel_o, wb_stb_o, wb_wre_o, dwb_ack_i,
   dwb_dat_i, iwb_ack_i, iwb_dat_i,
   // Inputs
   wb_dat_i, wb_ack_i, dwb_adr_o, dwb_dat_o, dwb_stb_o, dwb_we_o,
   iwb_adr_o, iwb_stb_o, sys_clk_i, sys_rst_i
   );
   parameter ASIZ = 32;
   parameter CSIZ = 7;
   /* DO NOT TOUCH */   
   parameter ISIZ = ASIZ;
   parameter DSIZ = ASIZ;   
   
   // External WISHBONE
   output [ASIZ-1:0] wb_adr_o;
   output [31:0]     wb_dat_o;
   output [3:0]      wb_sel_o;
   output 	     wb_stb_o;
   output 	     wb_wre_o;
   input [31:0]      wb_dat_i;
   input 	     wb_ack_i;

   // Internal WISHBONE
   input [DSIZ-1:0]  dwb_adr_o;
   input [31:0]      dwb_dat_o;
   input 	     dwb_stb_o;
   input 	     dwb_we_o;
   output 	     dwb_ack_i;
   output [31:0]     dwb_dat_i;   

   input [ISIZ-1:0]  iwb_adr_o;
   input 	     iwb_stb_o;
   output 	     iwb_ack_i;
   output [31:0]     iwb_dat_i;   
   
   // System
   input 	     sys_clk_i, sys_rst_i;

   wire 	     nclk = sys_clk_i;
   wire 	     nrst = sys_rst_i;   
   
   // FSM Machine
   parameter [1:0]   
		FSM_STORE = 2'o3,
		FSM_LOAD = 2'o2,
		FSM_FETCH = 2'o1,
		FSM_IDLE = 2'o0;
   reg [1:0] 	     rFSM, rFSM_;
   
   always @(negedge nclk or negedge nrst)
     if (!nrst) rFSM <= FSM_IDLE; else rFSM <= #1 rFSM_;
   
   always @(/*AUTOSENSE*/dwb_ack_i or dwb_stb_o or dwb_we_o
	    or iwb_ack_i or iwb_stb_o or rFSM or wb_ack_i or wb_stb_o)
     case (rFSM)
       FSM_IDLE: rFSM_ <= (iwb_stb_o & !iwb_ack_i) ? FSM_FETCH : 
			  (dwb_stb_o & !dwb_ack_i & dwb_we_o) ? FSM_STORE :
			  (dwb_stb_o & !dwb_ack_i & !dwb_we_o) ? FSM_LOAD :
			  FSM_IDLE;
       FSM_FETCH, FSM_LOAD, FSM_STORE: 
	 rFSM_ <= (wb_ack_i & wb_stb_o) ? FSM_IDLE : rFSM;
     endcase // case (rFSM)
   
   // WISHBONE LOGIC ////////////////////////////////////////////////////
   reg 		     rSTB, xSTB;
   reg 		     rWRE, xWRE;
   reg [ASIZ-1:0]    rADR, xADR;
   reg [31:0] 	     rDAT, xDAT;
   reg 		     rIWE, xIWE;
   
   assign 	     wb_stb_o = rSTB;
   assign 	     wb_wre_o = rWRE;
   assign 	     wb_dat_o = rDAT;
   assign 	     wb_adr_o = rADR;   
   
   // STB
   always @(/*AUTOSENSE*/dwb_ack_i or dwb_stb_o or iwb_ack_i
	    or iwb_stb_o or rFSM or rSTB or wb_ack_i or wb_stb_o)
     case (rFSM)
       FSM_IDLE: xSTB <= (dwb_stb_o & !dwb_ack_i) | (iwb_stb_o & !iwb_ack_i);
       default: xSTB <= (wb_ack_i & wb_stb_o) ^ rSTB;
     endcase
   
   // WRE
   always @(/*AUTOSENSE*/dwb_ack_i or dwb_stb_o or dwb_we_o
	    or iwb_ack_i or iwb_stb_o or rFSM or rWRE or wb_ack_i
	    or wb_stb_o or wb_wre_o)
     case (rFSM)
       FSM_IDLE: xWRE <= (iwb_stb_o & !iwb_ack_i) ? 1'b0 :
			 (dwb_stb_o & dwb_we_o & !dwb_ack_i);
       default: xWRE <= (wb_ack_i & wb_stb_o & wb_wre_o) ^ rWRE;
     endcase // case (rFSM)

   // DAT
   always @(/*AUTOSENSE*/dwb_dat_i or dwb_dat_o or rDAT or rFSM)
     case (rFSM)
       FSM_IDLE: xDAT <= dwb_dat_o;
       FSM_LOAD: xDAT <= dwb_dat_i;
       FSM_STORE: xDAT <= rDAT;
       FSM_FETCH: xDAT <= dwb_dat_i;
     endcase

   // ADR
   always @(/*AUTOSENSE*/dwb_adr_o or iwb_ack_i or iwb_adr_o
	    or iwb_stb_o or rADR or rFSM)
     case (rFSM)
       FSM_IDLE: xADR <= (iwb_stb_o & !iwb_ack_i) ? iwb_adr_o : dwb_adr_o;
       default: xADR <= rADR;
     endcase // case (rFSM)

   // ICWE
   always @(/*AUTOSENSE*/rFSM or wb_ack_i or wb_stb_o)
     case (rFSM)
       FSM_FETCH: xIWE <= (wb_ack_i & wb_stb_o);
       default: xIWE <= 1'b0;
     endcase
   
   // CACHE LOGIC ///////////////////////////////////////////////////////
   
   wire [ASIZ-3:CSIZ] wICHK;
   wire 	      wIVAL;
   reg [CSIZ-1:0]     rILINE;
   reg [ASIZ+32:CSIZ+2] rIMEM[(1<<CSIZ)-1:0];   
   
   assign 		{wIVAL, wICHK, iwb_dat_i} = rIMEM[rILINE];
   assign 		iwb_ack_i = wIVAL & ~|(wICHK ^ iwb_adr_o[ASIZ-1:CSIZ+2]) & iwb_stb_o;   

   wire [CSIZ-1:0] 	wILINE = rADR[CSIZ+1:2];
   wire [ASIZ-3:CSIZ] 	wITAG = rADR[ASIZ-1:CSIZ+2];   
   
   always @(posedge nclk) begin
      if (rIWE) begin
	 rIMEM[wILINE] <= {1'b1,wITAG,rDAT};	 
      end
      rILINE <= iwb_adr_o[CSIZ+1:2];
   end
   
   assign dwb_dat_i = wb_dat_i;
   assign dwb_ack_i = (wb_stb_o & wb_ack_i) & |(rFSM ^ FSM_FETCH);
   
   
   // PIPELINE REGISTERS ///////////////////////////////////////////////
   always @(negedge nclk or negedge nrst)
     if (!nrst) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rADR <= {(1+(ASIZ-1)){1'b0}};
	rDAT <= 32'h0;
	rIWE <= 1'h0;
	rSTB <= 1'h0;
	rWRE <= 1'h0;
	// End of automatics
     end else begin
	rDAT <= #1 xDAT;
	rADR <= #1 xADR;
	rWRE <= #1 xWRE;
	rSTB <= #1 xSTB;
	rIWE <= #1 xIWE;
     end
   
   // SIMULATION ONLY //////////////////////////////////////////////////
   integer i;
   initial begin
      for (i=0;i<((1<<CSIZ));i=i+1) begin
	 rIMEM[i] <= 0;	 
      end
   end
   
endmodule // aeMB_wbbus

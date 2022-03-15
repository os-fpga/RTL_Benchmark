/* $Id: aeMB2_regf.v,v 1.3 2007-12-13 20:12:11 sybreon Exp $
**
** AEMB2 REGISTER FILE
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

module aeMB2_regf (/*AUTOARG*/
   // Outputs
   dwb_dat_o, cwb_dat_o, rREGD_OF, rREGA_OF, rREGB_OF,
   // Inputs
   dwb_dat_i, dwb_ack_i, cwb_dat_i, cwb_ack_i, rRA_IF, rRB_IF, rRD_IF,
   rRD_MA, rOPM_OF, rOPA_OF, rOPC_OF, rPC_MA, rMUL_MA, rRES_MA,
   rOPD_MA, rSEL_MA, clk_i, rst_i, ena_i, pha_i
   );
   parameter TXE = 1;
   parameter MUL = 1;   
   
   // DWB
   output [31:0] dwb_dat_o;
   input [31:0]  dwb_dat_i;
   input 	 dwb_ack_i;   
   
   // FSL
   output [31:0] cwb_dat_o;   
   input [31:0]  cwb_dat_i;
   input 	 cwb_ack_i;   
   
   // INTERNAL
   output [31:0] rREGD_OF,
		 rREGA_OF,
		 rREGB_OF;   

   input [4:0] 	 rRA_IF,
		 rRB_IF,
		 rRD_IF,
		 rRD_MA;

   input [31:0]  rOPM_OF;
   input [31:0]  rOPA_OF;   
   input [5:0] 	 rOPC_OF;
   
   
   input [31:2]  rPC_MA; ///< link PC
   input [31:0]  rMUL_MA; ///< multiplier 2nd stage
   input [31:0]  rRES_MA;   

   input [2:0] 	 rOPD_MA;   
   input [3:0] 	 rSEL_MA; ///< data select info
   
   // SYSTEM
   input 	 clk_i, 
		 rst_i, 
		 ena_i, 
		 pha_i;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [31:0]		cwb_dat_o;
   reg [31:0]		dwb_dat_o;
   // End of automatics


   /*     
    LATCH FSL/RAM. 
    
    This is done on completion of a bus cycle, regardless of the
    pipeline status. It's safe to do this as the data is only written
    to the registers later. */
   
   reg [31:0] 		rCWB_MA,
			rDWB_MA;
   
   always @(posedge clk_i)
     if (rst_i) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rCWB_MA <= 32'h0;
	rDWB_MA <= 32'h0;
	// End of automatics
     end else begin
	if (dwb_ack_i) rDWB_MA <= #1 dwb_dat_i;
	if (cwb_ack_i) rCWB_MA <= #1 cwb_dat_i;	
     end
   
   /* 
    LOAD RESIZER 
    
    Resize the latched data for writing into the register. It also
    acts as a selector between FSL and DWB. */
   
   reg [31:0] 	 rMEM;
   always @(/*AUTOSENSE*/rCWB_MA or rDWB_MA or rSEL_MA) begin
      case (rSEL_MA)
	// 8'bits
	4'h8: rMEM <= {24'd0, rDWB_MA[31:24]};
	4'h4: rMEM <= {24'd0, rDWB_MA[23:16]};
	4'h2: rMEM <= {24'd0, rDWB_MA[15:8]};
	4'h1: rMEM <= {24'd0, rDWB_MA[7:0]};	
	// 16'bits
	4'hC: rMEM <= {16'd0, rDWB_MA[31:16]};
	4'h3: rMEM <= {16'd0, rDWB_MA[15:0]};	
	// 32'bits
	4'h0: rMEM <= rCWB_MA;
	4'hF: rMEM <= rDWB_MA;
	default: rMEM <= 32'hX;	
      endcase // case (rSEL_MA)
   end // always @ (...

   /*
    WRITE BACK
    
    The appropriate data to write into the register file is selected.
    */
   
   wire [31:0] wREGW;   
   reg [31:0] rREGD;
   always @(/*AUTOSENSE*/rMEM or rMUL_MA or rOPD_MA or rPC_MA
	    or rRES_MA or wREGW)
      case (rOPD_MA)
	3'o0: rREGD <= rRES_MA;	// ALU
	3'o1: rREGD <= {rPC_MA, 2'o0}; // PCLNK
	3'o2: rREGD <= rMEM; // RAM/FSL
	3'o3: rREGD <= (MUL) ? rMUL_MA : 32'hX;	// Multiplier
	3'o7: rREGD <= wREGW; // Unchanged
	default: rREGD <= 32'hX; // Undefined 	
      endcase // case (rOPD_MA)

   /* 
    REGISTER FILE
    
    Multi-banked dual-port register file. This should be inferred as
    distributed RAM in an FPGA. */
   
   reg [31:0] 	 rRAMA [(32<<TXE)-1:0],
		 rRAMB [(32<<TXE)-1:0],
		 rRAMD [(32<<TXE)-1:0];

   wire [TXE+4:0] wRA = {!pha_i, rRA_IF};
   wire [TXE+4:0] wRB = {!pha_i, rRB_IF};
   wire [TXE+4:0] wRD = {!pha_i, rRD_IF};   
   wire [TXE+4:0] wRW = {pha_i, rRD_MA};   
   
   assign 	 rREGA_OF = rRAMA[wRA];
   assign 	 rREGB_OF = rRAMB[wRB];
   assign 	 rREGD_OF = rRAMD[wRD];
   assign 	 wREGW = rRAMD[wRW];   
   
   always @(posedge clk_i)
     if ((ena_i & |rRD_MA) | rst_i) begin
	rRAMA[wRW] <= #1 rREGD;
	rRAMB[wRW] <= #1 rREGD;
	rRAMD[wRW] <= #1 rREGD;
     end
   
   /* 
    STORE SIZER
    
    This resizes the data to be placed on the data bus. To make it
    easy, it merely replicates the data across the whole bus. It
    relies on the byte select signal to indicate which lanes to
    use. */
   
   always @(posedge clk_i)
     if (rst_i) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	cwb_dat_o <= 32'h0;
	dwb_dat_o <= 32'h0;
	// End of automatics
     end else if (ena_i) begin
	case (rOPC_OF[1:0])
	  2'o0: dwb_dat_o <= #1 {(4){rOPM_OF[7:0]}};
	  2'o1: dwb_dat_o <= #1 {(2){rOPM_OF[15:0]}};
	  2'o2: dwb_dat_o <= #1 rOPM_OF;
	  default: dwb_dat_o <= #1 32'hX;	 
	endcase // case (rOPC_OF[1:0])

	case (rOPC_OF[1:0])
	  2'o3: cwb_dat_o <= #1 rOPA_OF;	  
	  default: cwb_dat_o <= #1 32'hX;	 
	endcase // case (rOPC_OF[1:0])

     end // if (ena_i)
   
   // synopsys translate_off   
   /* random initial condition for RAM */   
   integer r;
   initial begin
      for (r=0; r<128; r=r+1) begin
	 rRAMA[r] <= $random;	 
	 rRAMB[r] <= $random;	 
	 rRAMD[r] <= $random;	 
      end
   end
   // synopsys translate_on
   
endmodule // aeMB2_regf

/* $Log: not supported by cvs2svn $
/* Revision 1.2  2007/12/12 19:16:59  sybreon
/* Minor optimisations (~10% faster)
/*
/* Revision 1.1  2007/12/11 00:43:17  sybreon
/* initial import
/* */
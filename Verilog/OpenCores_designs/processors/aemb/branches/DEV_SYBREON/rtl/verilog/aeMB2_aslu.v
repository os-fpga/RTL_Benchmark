/* $Id: aeMB2_aslu.v,v 1.10 2008-04-11 15:53:43 sybreon Exp $
**
** AEMB2 INTEGER ARITHMETIC SHIFT LOGIC UNIT
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

module aeMB2_aslu (/*AUTOARG*/
   // Outputs
   dwb_adr_o, dwb_sel_o, rSEL_MA, cwb_adr_o, cwb_tga_o, cwb_sel_o,
   iwb_tga_o, dwb_tga_o, rMUL_MA, rRES_MA, rRES_EX, rMSR_IE, rMSR_BE,
   rMSR_BIP,
   // Inputs
   rIMM_OF, rALU_OF, rOPC_OF, rOPC_IF, rRA_OF, rRD_OF, rOPA_OF,
   rOPB_OF, pha_i, clk_i, rst_i, ena_i
   );

   parameter DWB = 32;
   parameter TXE = 1;
   
   parameter MUL = 0;
   parameter BSF = 1;
   parameter FSL = 1;   
   
   // DWB
   output [DWB-1:2] dwb_adr_o;
   output [3:0]     dwb_sel_o;
   output [3:0]     rSEL_MA;

   // FSL
   output [6:2]     cwb_adr_o;
   output [1:0]     cwb_tga_o;
   output [3:0]     cwb_sel_o;   

   // CACHE ENABLE
   output 	    iwb_tga_o,
		    dwb_tga_o;  
   
   // PIPELINE
   output [31:0]    rMUL_MA;   
   output [31:0]    rRES_MA,
		    rRES_EX;   
   
   output 	    rMSR_IE,
		    rMSR_BE,
		    //rMSR_TXE,
		    //rMSR_DCE,
		    //rMSR_ICE,		    
		    rMSR_BIP;
   
   input [15:0]     rIMM_OF;   
   input [2:0] 	    rALU_OF;   
   input [5:0] 	    rOPC_OF,
		    rOPC_IF;
   
   input [4:0] 	    rRA_OF,
		    rRD_OF;
   
   input [31:0]     rOPA_OF, // RA, PC
		    rOPB_OF; // RB, IMM
   
   // SYSTEM
   input 	    pha_i,
		    clk_i,
		    rst_i,
		    ena_i;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [6:2]		cwb_adr_o;
   reg [3:0]		cwb_sel_o;
   reg [1:0]		cwb_tga_o;
   reg [DWB-1:2]	dwb_adr_o;
   reg [3:0]		dwb_sel_o;
   reg			dwb_tga_o;
   reg			iwb_tga_o;
   reg			rMSR_BE;
   reg			rMSR_BIP;
   reg			rMSR_IE;
   reg [31:0]		rMUL_MA;
   reg [31:0]		rRES_EX;
   reg [31:0]		rRES_MA;
   reg [3:0]		rSEL_MA;
   // End of automatics

   reg 			rMSR_C0, 
			rMSR_C1, 
			rMSR_C,
			rMSR_CC,
			rMSR_CL[0:1];
   
   
   wire [4:0] 		rRD = rRD_OF;   
   wire [31:0] 		rOPA = rOPA_OF;
   wire [31:0] 		rOPB = rOPB_OF;   
   wire [5:0] 		rOPC = rOPC_OF;
   wire [4:0] 		rRA = rRA_OF;   
   wire [15:0] 		rIMM = rIMM_OF;
   wire [10:0] 		rALT = rIMM_OF[10:0];

   /*
    MSR REGISTER
    
    We should keep common configuration bits in the lower 16-bits of
    the MSR in order to avoid using the IMMI instruction.
    
    MSR bits
    31 - CC (carry copy)
    
    30 - HTE (hardware thread enabled)
    29 - PHA (current phase)
    28 - TXE (enable threads)
    
     7 - DCE (data cache enable)   
     5 - ICE (instruction cache enable)
     4 - FSL (FSL available)
    
     3 - BIP (break in progress)
     2 - C (carry flag)
     1 - IE (interrupt enable)
     0 - BE (bus-lock enable)    
    
    */

   wire [31:0] 		wMSR = {rMSR_C, // MSR_CC								
				TXE[0], // (PVR)
				pha_i, // (EIP)
				TXE[0], // (EE)

				20'd0, // Reserved
				
				dwb_tga_o, // MSR_DCE
				1'b0, // reserved for DZ
				iwb_tga_o, // MSR_ICE
				FSL[0], // GET/PUT available
				
				rMSR_BIP, // MSR_BIP
				rMSR_C, // MSR_C
				rMSR_IE, // MSR_IE
				rMSR_BE}; // MSR_BE
   
   
   /*
    C SELECTOR 

    Preselects the C to speed things up.  */

   // TODO: Optimise
   
   wire 		wMSR_CX, wMSR_C;   
   assign 		wMSR_CX = (pha_i) ? rMSR_C0 : rMSR_C1;
   
   assign 		wMSR_C = (rOPC_IF == 6'o44) & wMSR_CX | // SRX
				 (rOPC_IF[5:4] == 2'o0) & rOPC_IF[1] & wMSR_CX | // ADDC/RSUBC
				 (rOPC_IF[5:4] == 2'o0) & (rOPC_IF[1:0] == 2'o1); // RSUB
   /* 
   assign 		wMSR_C = ((rOPC_IF[5:4] == 2'o0) & (rOPC_OF[1:0] == 2'o1)) ? 1'b1 : // RSUB = 1
				 ((rOPC_IF[5:4] == 2'o0) & (rOPC_OF[1:0] == 2'o0)) ? 1'b0 : // ADD = 0
				 wMSR_CX;   
   */
     
   always @(posedge clk_i)
     if (rst_i) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rMSR_C <= 1'h0;
	rMSR_CC <= 1'h0;
	// End of automatics
     end else if (ena_i) begin
	rMSR_C <= #1 wMSR_CX;
	rMSR_CC <= #1 wMSR_C;	
     end
   
   /* 
    ADD/SUB SELECTOR
    
    Current implementation is a clutz. It needs to be
    re-implemented. It is also in the critical path.  */
   
   // FIXME: Redesign
   // TODO: Verify signed compare   
   
   wire 		wADDC, wSUBC, wRES_AC, wCMPC, wOPC;
   wire [31:0] 		wADD, wSUB, wRES_A, wCMP, wOPX;

   wire 		wCMPU = (rOPA > rOPB);         
   wire 		wCMPF = (rIMM[1]) ? wCMPU :
			((wCMPU & ~(rOPB[31] ^ rOPA[31])) | (rOPB[31] & ~rOPA[31]));
   
   assign 		{wCMPC,wCMP} = {wSUBC,wCMPF,wSUB[30:0]};  
   assign 		wOPX = (rOPC[0] & !rOPC[5]) ? ~rOPA : rOPA ;
   //assign 		wOPC = ((rMSR_C & rOPC[1]) | (rOPC[0] & !rOPC[1])) & (!rOPC[5] & ~&rOPC[5:4]);
   assign 		wOPC = rMSR_CC;   
   
   assign 		{wSUBC,wSUB} = {wADDC,wADD}; 
   assign 		{wADDC,wADD} = (rOPB + wOPX) + wOPC; 
   
   reg 			rRES_ADDC;
   reg [31:0] 		rRES_ADD;
   always @(rIMM or rOPC or wADD or wADDC or wCMP
	    or wCMPC or wSUB or wSUBC)
     case ({rOPC[3],rOPC[0],rIMM[0]})
       4'h2, 4'h6, 4'h7: {rRES_ADDC,rRES_ADD} <= #1 {wSUBC,wSUB}; // SUB
       4'h3: {rRES_ADDC,rRES_ADD} <= #1 {wCMPC,wCMP}; // CMP
       default: {rRES_ADDC,rRES_ADD} <= #1 {wADDC,wADD};       
     endcase // case ({rOPC[3],rOPC[0],rIMM[0]})

   /* 
    LOGIC
    
    This can be combined with the shifter below.
    */

   reg [31:0] 		rRES_LOG;
   always @(/*AUTOSENSE*/rOPA or rOPB or rOPC)
     case (rOPC[2:0])
       2'o0: rRES_LOG <= #1 rOPA | rOPB;
       2'o1: rRES_LOG <= #1 rOPA & rOPB;
       2'o2: rRES_LOG <= #1 rOPA ^ rOPB;
       2'o3: rRES_LOG <= #1 rOPA & ~rOPB;
     endcase // case (rOPC[2:0])
   
   /* 
    SIMPLE SHIFTER
        
    Implemented as wiring and registers.
    */
   
   reg [31:0] 		rRES_SFT;
   reg 			rRES_SFTC;
   
   always @(/*AUTOSENSE*/rIMM or rMSR_C or rOPA)
     case (rIMM[6:5])
       2'o0: rRES_SFT <= {rOPA[31],rOPA[31:1]}; // SRA
       2'o1: rRES_SFT <= {rMSR_C,rOPA[31:1]}; // SRC
       2'o2: rRES_SFT <= {1'b0,rOPA[31:1]}; // SRL
       2'o3: rRES_SFT <= (rIMM[0]) ? 
			 {{(16){rOPA[15]}}, rOPA[15:0]} : // SEXT16
			 {{(24){rOPA[7]}}, rOPA[7:0]}; // SEXT8
     endcase // case (rIMM[6:5])

   always @(/*AUTOSENSE*/rIMM or rMSR_C or rOPA)
     rRES_SFTC <= (&rIMM[6:5]) ? rMSR_C : rOPA[0];

   /*
    MOVER
    */
   
   wire 		fMFSR = (rOPC == 6'o45) & !rIMM[14] & rIMM[0];
   wire 		fMFPC = (rOPC == 6'o45) & !rIMM[14] & !rIMM[0];
   reg [31:0] 		rRES_MOV;
   
   always @(/*AUTOSENSE*/fMFSR or rOPA or rOPB or rRA or wMSR)
     case ({fMFSR, rRA[3]})
       2'o0: rRES_MOV <= rOPA; // MFS rpc
       2'o1: rRES_MOV <= rOPB; // BRA       
       2'o2: rRES_MOV <= wMSR; // MFS rmsr
       default: rRES_MOV <= 32'hX;       
     endcase // case ({fMFSR, rRA[3]})


   /*
    COMBINED SHIFT/LOGIC/MOVE
    
    */
   
   reg [31:0] 		rRES_SLM;

   always @(/*AUTOSENSE*/fMFSR or rIMM or rMSR_C or rOPA or rOPB
	    or rOPC or rRA or wMSR)
     case (rOPC[2:0])
       3'o0: rRES_SLM <= #1 rOPA | rOPB;
       3'o1: rRES_SLM <= #1 rOPA & rOPB;
       3'o2: rRES_SLM <= #1 rOPA ^ rOPB;
       3'o3: rRES_SLM <= #1 rOPA & ~rOPB;
       3'o4: case (rIMM[6:5])
	       2'o0: rRES_SLM <= #1 {rOPA[31],rOPA[31:1]}; // SRA
	       2'o1: rRES_SLM <= #1 {rMSR_C,rOPA[31:1]}; // SRC
	       2'o2: rRES_SLM <= #1 {1'b0,rOPA[31:1]}; // SRL
	       2'o3: rRES_SLM <= #1 (rIMM[0]) ? 
				 {{(16){rOPA[15]}}, rOPA[15:0]} : // SEXT16
				 {{(24){rOPA[7]}}, rOPA[7:0]}; // SEXT8
	     endcase // case (rIMM[6:5])
       3'o5: case ({fMFSR, rRA[3]})
	       2'o0: rRES_SLM <= #1 rOPA; // MFS rpc
	       2'o1: rRES_SLM <= #1 rOPB; // BRA       
	       2'o2: rRES_SLM <= #1 wMSR; // MFS rmsr
	       default: rRES_MOV <= #1 32'hX;       
	     endcase // case ({fMFSR, rRA[3]})
       3'o6: rRES_SLM <= #1 rOPB;
       default: rRES_SLM <= #1 32'hX;       
     endcase // case (rOPC[2:0])
   
   
   /* 
    MULTIPLIER
    
    Implemented as a 2-stage multiplier in order to increase clock
    speed. */
   
   reg [31:0] 	    rRES_MUL;
   always @(posedge clk_i) if (ena_i) begin
      rMUL_MA <= #1 rRES_MUL;
      rRES_MUL <= #1 (rOPA * rOPB);
   end
   
   /* 
    BARREL SHIFTER
    
    This can be potentially made 2-stage if it is a
    bottleneck. Doesn't seem necessary at the moment as the critical
    path runs through the adder. */
   
   reg [31:0] 	 rRES_BSF;
   reg [31:0] 	 xBSRL, xBSRA, xBSLL;
   
   /* logical left barrel shifter */
   always @(/*AUTOSENSE*/rOPA or rOPB)
     xBSLL <= rOPA << rOPB[4:0];
   
   /* logical right barrel shifter */
   always @(/*AUTOSENSE*/rOPA or rOPB)
     xBSRL <= rOPA >> rOPB[4:0];

   /* arithmetic right barrel shifter */
   always @(/*AUTOSENSE*/rOPA or rOPB)
     case (rOPB[4:0])
       5'd00: xBSRA <= rOPA;
       5'd01: xBSRA <= {{(1){rOPA[31]}}, rOPA[31:1]};
       5'd02: xBSRA <= {{(2){rOPA[31]}}, rOPA[31:2]};
       5'd03: xBSRA <= {{(3){rOPA[31]}}, rOPA[31:3]};
       5'd04: xBSRA <= {{(4){rOPA[31]}}, rOPA[31:4]};
       5'd05: xBSRA <= {{(5){rOPA[31]}}, rOPA[31:5]};
       5'd06: xBSRA <= {{(6){rOPA[31]}}, rOPA[31:6]};
       5'd07: xBSRA <= {{(7){rOPA[31]}}, rOPA[31:7]};
       5'd08: xBSRA <= {{(8){rOPA[31]}}, rOPA[31:8]};
       5'd09: xBSRA <= {{(9){rOPA[31]}}, rOPA[31:9]};
       5'd10: xBSRA <= {{(10){rOPA[31]}}, rOPA[31:10]};
       5'd11: xBSRA <= {{(11){rOPA[31]}}, rOPA[31:11]};
       5'd12: xBSRA <= {{(12){rOPA[31]}}, rOPA[31:12]};
       5'd13: xBSRA <= {{(13){rOPA[31]}}, rOPA[31:13]};
       5'd14: xBSRA <= {{(14){rOPA[31]}}, rOPA[31:14]};
       5'd15: xBSRA <= {{(15){rOPA[31]}}, rOPA[31:15]};
       5'd16: xBSRA <= {{(16){rOPA[31]}}, rOPA[31:16]};
       5'd17: xBSRA <= {{(17){rOPA[31]}}, rOPA[31:17]};
       5'd18: xBSRA <= {{(18){rOPA[31]}}, rOPA[31:18]};
       5'd19: xBSRA <= {{(19){rOPA[31]}}, rOPA[31:19]};
       5'd20: xBSRA <= {{(20){rOPA[31]}}, rOPA[31:20]};
       5'd21: xBSRA <= {{(21){rOPA[31]}}, rOPA[31:21]};
       5'd22: xBSRA <= {{(22){rOPA[31]}}, rOPA[31:22]};
       5'd23: xBSRA <= {{(23){rOPA[31]}}, rOPA[31:23]};
       5'd24: xBSRA <= {{(24){rOPA[31]}}, rOPA[31:24]};
       5'd25: xBSRA <= {{(25){rOPA[31]}}, rOPA[31:25]};
       5'd26: xBSRA <= {{(26){rOPA[31]}}, rOPA[31:26]};
       5'd27: xBSRA <= {{(27){rOPA[31]}}, rOPA[31:27]};
       5'd28: xBSRA <= {{(28){rOPA[31]}}, rOPA[31:28]};
       5'd29: xBSRA <= {{(29){rOPA[31]}}, rOPA[31:29]};
       5'd30: xBSRA <= {{(30){rOPA[31]}}, rOPA[31:30]};
       5'd31: xBSRA <= {{(31){rOPA[31]}}, rOPA[31]};
     endcase // case (rOPB[4:0])

   /* select the shift result (2nd stage) */
   always @(/*AUTOSENSE*/rALT or xBSLL or xBSRA or xBSRL)
     case (rALT[10:9])
       2'd0: rRES_BSF <= xBSRL;
       2'd1: rRES_BSF <= xBSRA;       
       2'd2: rRES_BSF <= xBSLL;
       default: rRES_BSF <= 32'hX;       
     endcase // case (rALT[10:9])


   /*
    RESULTS
    */
   
   // RESULT   
   always @(posedge clk_i)
     if (rst_i) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rRES_EX <= 32'h0;
	rRES_MA <= 32'h0;
	// End of automatics
     end else if (ena_i) begin
	rRES_MA <= #1 rRES_EX;
	/*
	case (rALU_OF)
	  3'o0: rRES_EX <= #1 rRES_ADD;
	  3'o1: rRES_EX <= #1 rRES_LOG;
	  3'o2: rRES_EX <= #1 rRES_SFT;
	  3'o3: rRES_EX <= #1 rRES_MOV;
	  3'o5: rRES_EX <= #1 (BSF) ? rRES_BSF : 32'hX;	 
	  default: rRES_EX <= #1 32'hX;	  
	endcase // case (rALU_OF)
	 */
	case (rALU_OF[1:0])
	//case (rOPC[5:4])
	  2'o0: rRES_EX <= #1 rRES_ADD;
	  2'o2: rRES_EX <= #1 rRES_SLM;
	  2'o1: rRES_EX <= #1 (BSF) ? rRES_BSF : 32'hX;	  
	  default: rRES_EX <= #1 32'hX;	  
	endcase // case (rALU_OF[1:0])
	
     end // if (ena_i)
   
   
   /*
    MSR REGISTER
   
    Move data to the MSR or change due to break/returns. */
   
   reg 		 xMSR_C;
   
   // C
   wire 	 fMTS = (rOPC == 6'o45) & rIMM[14];
   wire 	 fADDC = ({rOPC[5:4], rOPC[2]} == 3'o0);
   
   always @(/*AUTOSENSE*/fADDC or rALU_OF or rIMM or rMSR_C or rOPC
	    or rRES_ADDC or rRES_SFTC)
     case (rALU_OF[1:0])
     //case (rOPC[5:4])
       3'o0: xMSR_C <= (fADDC) ? rRES_ADDC : rMSR_C; // ADD/SUB
       3'o2: case (rOPC[2:0])
	       3'o5: xMSR_C <= (rIMM[14]) ? rOPA[2] : rMSR_C; // MTS
	       3'o4: xMSR_C <= (&rIMM[6:5]) ? rMSR_C : rRES_SFTC; // SRX
	       default: xMSR_C <= rMSR_C;
	     endcase // case (rOPC[2:0])
       default: xMSR_C <= rMSR_C;       
     endcase // case (rOPC[5:4])
   
     /*
     case (rALU_OF)
       3'o0: xMSR_C <= (fADDC) ? rRES_ADDC : rMSR_C;	 
       3'o1: xMSR_C <= rMSR_C; // LOGIC       
       3'o2: xMSR_C <= rRES_SFTC; // SHIFT
       3'o3: xMSR_C <= (fMTS) ? rOPA[2] : rMSR_C;
       3'o4: xMSR_C <= rMSR_C;	 
       3'o5: xMSR_C <= rMSR_C;	 
       default: xMSR_C <= 1'hX;       
     endcase // case (rALU_OF)
      */
     
   always @(posedge clk_i)
     if (rst_i) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rMSR_C0 <= 1'h0;
	rMSR_C1 <= 1'h0;
	// End of automatics
     end else if (ena_i) begin
	if (pha_i)
	  rMSR_C1 <= #1 xMSR_C;
	else
	  rMSR_C0 <= #1 xMSR_C;	
     end
   
   // IE/BIP/BE
   wire 	    fRTID = (rOPC == 6'o55) & rRD[0];   
   wire 	    fRTBD = (rOPC == 6'o55) & rRD[1];
   wire 	    fBRK = ((rOPC == 6'o56) | (rOPC == 6'o66)) & (rRA == 5'hC);
   wire 	    fINT = ((rOPC == 6'o56) | (rOPC == 6'o66)) & (rRA == 5'hE);

   always @(posedge clk_i)
     if (rst_i) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	dwb_tga_o <= 1'h0;
	iwb_tga_o <= 1'h0;
	rMSR_BE <= 1'h0;
	rMSR_BIP <= 1'h0;
	rMSR_IE <= 1'h0;
	// End of automatics
     end else if (ena_i) begin
	
	// Interrupt enable (compatible)
	rMSR_IE <= #1
		   (fINT) ? 1'b0 :
		   (fRTID) ? 1'b1 : 
		   (fMTS) ? rOPA[1] :
		   rMSR_IE;

	// Break in progress (compatible)
	rMSR_BIP <= #1
		    (fBRK) ? 1'b1 :
		    (fRTBD) ? 1'b0 : 
		    (fMTS) ? rOPA[3] :
		    rMSR_BIP;

	// Forcibly assert dwb_cyc_o signal	
	rMSR_BE <= #1
		   (fMTS) ? rOPA[0] : rMSR_BE;

	// Enable the thread extension
	//rMSR_TXE <= #1 TXE[0];	

	// Enable the caches
	dwb_tga_o <= #1 (fMTS) ? 
		     rOPA[7] : 
		     dwb_tga_o;
	iwb_tga_o <= #1 (fMTS) ? 
		     rOPA[5] : 
		     iwb_tga_o;	
	
     end // if (ena_i)

   /*
    DATA/FSL WISHBONE
    
    Asserts the data address as calculated by the adder and the
    appropriate byte select lanes depending on the byte offset of the
    address. It does not check for mis-aligned addresses.  */

   // TODO: Check for mis-alignment

   always @(posedge clk_i)
     if (rst_i) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	cwb_adr_o <= 5'h0;
	cwb_sel_o <= 4'h0;
	cwb_tga_o <= 2'h0;
	dwb_adr_o <= {(1+(DWB-1)-(2)){1'b0}};
	dwb_sel_o <= 4'h0;
	rSEL_MA <= 4'h0;
	// End of automatics
     end else if (ena_i) begin // if (rst_i)
	rSEL_MA <= #1 dwb_sel_o;	
	
	dwb_adr_o <= #1 wADD[DWB-1:2];	
	case (rOPC[1:0])
	  2'o0: case (wADD[1:0]) // 8'bit
		  2'o0: dwb_sel_o <= #1 4'h8;	       
		  2'o1: dwb_sel_o <= #1 4'h4;	       
		  2'o2: dwb_sel_o <= #1 4'h2;	       
		  2'o3: dwb_sel_o <= #1 4'h1;	       
		endcase // case (wADD[1:0])
	  2'o1: dwb_sel_o <= #1 (wADD[1]) ? 4'h3 : 4'hC; // 16'bit
	  2'o2: dwb_sel_o <= #1 4'hF; // 32'bit
	  2'o3: dwb_sel_o <= #1 4'h0; // FSL
	endcase // case (rOPC[1:0])

	{cwb_adr_o, cwb_tga_o} <= #1 {rIMM_OF[4:0], rIMM_OF[15:14]};
	cwb_sel_o <= #1 {(4){ &rOPC[1:0]}};	
	
     end // if (ena_i)
   
endmodule // aeMB2_aslu

/* $Log: not supported by cvs2svn $
/* Revision 1.9  2008/01/09 19:17:33  sybreon
/* Made multiplier pause with pipeline
/*
/* Revision 1.8  2008/01/09 19:12:59  sybreon
/* multiplier issues
/*
/* Revision 1.7  2007/12/17 12:53:27  sybreon
/* Fixed Carry bit bug.
/*
/* Revision 1.6  2007/12/16 20:38:06  sybreon
/* Minor optimisations.
/*
/* Revision 1.5  2007/12/16 03:25:37  sybreon
/* Some optimisations.
/*
/* Revision 1.4  2007/12/13 21:25:41  sybreon
/* Further optimisations (speed + size).
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
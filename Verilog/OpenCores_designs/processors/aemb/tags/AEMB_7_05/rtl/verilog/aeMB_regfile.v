/*
 * $Id: aeMB_regfile.v,v 1.17 2007-05-17 09:08:21 sybreon Exp $
 * 
 * AEMB Register File
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
 * Implements the 32 registers as memory. Some registers require
 * special actions during hardware exception/interrupts. Data
 * forwarding is also taken care of inside here to simplify decode
 * logic.
 *
 * HISTORY
 * $Log: not supported by cvs2svn $
 * Revision 1.16  2007/05/15 22:44:57  sybreon
 * Corrected speed issues after rev 1.9 update.
 *
 * Revision 1.15  2007/04/30 15:56:50  sybreon
 * Removed byte acrobatics.
 *
 * Revision 1.14  2007/04/27 15:15:49  sybreon
 * Fixed simulation bug.
 *
 * Revision 1.13  2007/04/27 04:22:40  sybreon
 * Fixed minor synthesis bug.
 *
 * Revision 1.12  2007/04/27 00:23:55  sybreon
 * Added code documentation.
 * Improved size & speed of rtl/verilog/aeMB_aslu.v
 *
 * Revision 1.11  2007/04/26 14:29:53  sybreon
 * Made minor performance optimisations.
 *
 * Revision 1.10  2007/04/25 22:52:53  sybreon
 * Fixed minor simulation bug.
 *
 * Revision 1.9  2007/04/25 22:15:04  sybreon
 * Added support for 8-bit and 16-bit data types.
 *
 * Revision 1.8  2007/04/12 20:21:33  sybreon
 * Moved testbench into /sim/verilog.
 * Simulation cleanups.
 *
 * Revision 1.7  2007/04/11 16:30:06  sybreon
 * Cosmetic changes
 *
 * Revision 1.6  2007/04/11 04:30:43  sybreon
 * Added pipeline stalling from incomplete bus cycles.
 * Separated sync and async portions of code.
 *
 * Revision 1.5  2007/04/04 14:08:34  sybreon
 * Added initial interrupt/exception support.
 *
 * Revision 1.4  2007/04/04 06:11:47  sybreon
 * Fixed memory read-write data hazard
 *
 * Revision 1.3  2007/04/03 14:46:26  sybreon
 * Fixed endian correction issues on data bus.
 *
 * Revision 1.2  2007/03/26 12:21:31  sybreon
 * Fixed a minor bug where RD is trashed by a STORE instruction. Spotted by Joon Lee.
 *
 * Revision 1.1  2007/03/09 17:52:17  sybreon
 * initial import
 *
 */

module aeMB_regfile(/*AUTOARG*/
   // Outputs
   dwb_dat_o, rREGA, rREGB, sDWBDAT,
   // Inputs
   dwb_dat_i, rDWBSTB, rDWBWE, rRA, rRB, rRD, rRESULT, rFSM, rPC,
   rOPC, rDWBSEL, rLNK, rRWE, nclk, prst, drun, prun
   );
   // FIXME: This parameter is not used here.
   parameter DSIZ = 32;
   
   // Data WB Signals
   output [31:0] dwb_dat_o;
   input [31:0]  dwb_dat_i;
   
   // Internal Signals
   output [31:0] rREGA, rREGB;
   output [31:0] sDWBDAT;   
   input 	 rDWBSTB, rDWBWE;   
   input [4:0] 	 rRA, rRB, rRD;   
   input [31:0]  rRESULT;
   input [1:0] 	 rFSM;   
   input [31:0]  rPC;
   input [5:0] 	 rOPC;   
   input [3:0] 	 rDWBSEL;   
   input 	 rLNK, rRWE;
   input 	 nclk, prst, drun, prun;   

   /**
    Delay Latches
    ----------
    The PC and RD are latched internally as it will be needed for
    linking and interrupt handling.
    
    FIXME: May need to be blocked (drun).
    */
   
   reg [31:2] 	 rPC_, xPC_;
   reg [4:0] 	 rRD_, xRD_;
   
   always @(/*AUTOSENSE*/rPC or rRD) begin
      xPC_ <= rPC[31:2];
      xRD_ <= rRD;      
   end

   /**
    Control Flags
    -------------
    Various internal flags.
    */
   
   wire [31:0] 	 wRESULT;
   wire 	 fWE = rRWE & !rDWBWE;
   wire 	 fLNK = rLNK;
   wire 	 fLD = rDWBSTB ^ rDWBWE;   
   wire 	 fDFWD = !(rRD ^ rRD_) & fWE;
   wire 	 fMFWD = rDWBSTB & !rDWBWE;      
   
   /**
    Data WISHBONE Bus
    -----------------
    The data word that is read or written between the core and the
    external bus may need to be re-ordered.
    
    FIXME: Endian correction!
    */
   
   wire [31:0] 	 wDWBDAT;
   reg [31:0] 	 sDWBDAT;   
   reg [31:0] 	 rDWBDAT;
   assign 	 dwb_dat_o = rDWBDAT;
   assign 	 wDWBDAT = dwb_dat_i;

   /**
    RAM Based Register File
    -----------------------
    This approach was chosen for implementing the register file as it
    was easier to implement and resulted in a higher speed than a pure
    register based implementation. A comparison was made using
    synthesis data obtained from Xilinx ISE:
    Reg : 1284 slices @ 78 MHz 
    RAM : 227 slices @ 141 MHz
    */
   
   reg [31:0]  rMEMA[0:31], rMEMB[0:31], rMEMD[0:31];
   wire [31:0] wDDAT, wREGA, wREGB, wREGD, wWBDAT;   
   wire        wDWE = (fLD | fLNK | fWE) & |rRD_ & prun;
   assign      wDDAT = (fLD) ? sDWBDAT :
		       (fLNK) ? {rPC_,2'd0} :
		       rRESULT;		       
   
   assign      rREGA = rMEMA[rRA];
   assign      rREGB = rMEMB[rRB];
   assign      wREGD = rMEMD[rRD];
   
   always @(negedge nclk)
     if (wDWE | prst) begin
	rMEMA[rRD_] <= wDDAT;
	rMEMB[rRD_] <= wDDAT;
	rMEMD[rRD_] <= wDDAT;	 
     end

   /**
    Memory Resizer
    --------------
    This moves the appropriate bytes around depending on the size of
    the operation. There is no checking for invalid size selection. It
    also handles forwarding.
    */
   
   reg [31:0] xDWBDAT;
   always @(/*AUTOSENSE*/fDFWD or rOPC or rRESULT or wREGD)
     case ({fDFWD,rOPC[1:0]})
       // 8-bit
       3'o0: xDWBDAT <= {(4){wREGD[7:0]}};
       3'o4: xDWBDAT <= {(4){rRESULT[7:0]}};
       // 16-bit
       3'o1: xDWBDAT <= {(2){wREGD[15:0]}};
       3'o5: xDWBDAT <= {(2){rRESULT[15:0]}};
       // 32-bit
       3'o2, 3'o3: xDWBDAT <= wREGD;
       3'o6, 3'o7: xDWBDAT <= rRESULT;
     endcase // case ({fDFWD,rOPC[1:0]})

   always @(/*AUTOSENSE*/rDWBSEL or wDWBDAT)
     case (rDWBSEL)
       // 8-bit
       4'h8: sDWBDAT <= {24'd0,wDWBDAT[31:24]};
       4'h4: sDWBDAT <= {24'd0,wDWBDAT[23:16]};
       4'h2: sDWBDAT <= {24'd0,wDWBDAT[15:8]};
       4'h1: sDWBDAT <= {24'd0,wDWBDAT[7:0]};
       // 16-bit
       4'hC: sDWBDAT <= {16'd0,wDWBDAT[31:16]};
       4'h3: sDWBDAT <= {16'd0,wDWBDAT[15:0]};
       // 32-bit
       default: sDWBDAT <= wDWBDAT;
     endcase // case (rDWBSEL)

   // PIPELINE REGISTERS //////////////////////////////////////////////////
   
   always @(negedge nclk)
     if (prst) begin
	/*AUTORESET*/
	// Beginning of autoreset for uninitialized flops
	rDWBDAT <= 32'h0;
	rPC_ <= 30'h0;
	rRD_ <= 5'h0;
	// End of automatics
     end else if (prun) begin
	rDWBDAT <= #1 xDWBDAT;
	rPC_ <= xPC_;
	rRD_ <= xRD_;	
     end

   // SIMULATION ONLY ///////////////////////////////////////////////////
   /**
    The register file is initialised with random values to reflect a
    realistic situation where the values are undefined at power-up.
    */
   // synopsys translate_off
   integer i;
   initial begin
      for (i=0;i<32;i=i+1) begin
	 rMEMA[i] <= $random;
	 rMEMB[i] <= $random;
	 rMEMD[i] <= $random;	 
      end
   end
   // synopsys translate_on
   
endmodule // aeMB_regfile

// Local Variables:
// verilog-library-directories:(".")
// verilog-library-files:("")
// End:
/*
 Asynchronous SDM NoC
 (C)2011 Wei Song
 Advanced Processor Technologies Group
 Computer Science, the Univ. of Manchester, UK
 
 Authors: 
 Wei Song     wsong83@gmail.com
 
 License: LGPL 3.0 or later
 
 Unidirectional crossbar using the XY routing algorithm.
 *** SystemVerilog is used ***
 
 History:
 09/07/2009  Initial version. <wsong83@gmail.com>

*/

// the router structure definitions

module cb_xy (/*AUTOARG*/
   // Outputs
   so, wo, no, eo, lo,
   // Inputs
   si, wi, ni, ei, li, scfg, ncfg, wcfg, ecfg, lcfg
   ) ;

   parameter DW = 8;		// the wire count of the crossbar

   input [DW-1:0]      si, wi, ni, ei, li; // data input
   output [DW-1:0]     so, wo, no, eo, lo; // data output
   input [1:0] 	       scfg, ncfg;	   // configuration
   input [3:0] 	       wcfg, ecfg, lcfg;   // configuration
   
   // ANDed wires
   wire [DW-1:0][1:0]  tos, ton;
   wire [DW-1:0][3:0]  tow, toe, tol;
      
   // generate
   genvar 		      i, j;
   
   generate for (i=0; i<DW; i=i+1)
     begin:OPA
	and AN2S (tos[i][0], ni[i], scfg[0]);
	and AL2S (tos[i][1], li[i], scfg[1]);
	assign so[i] = |tos[i];
	
	and AS2W (tow[i][0], si[i], wcfg[0]);
	and AN2W (tow[i][1], ni[i], wcfg[1]);
	and AE2W (tow[i][2], ei[i], wcfg[2]);
	and AL2W (tow[i][3], li[i], wcfg[3]);
	assign wo[i] = |tow[i];

	and AS2N (ton[i][0], si[i], ncfg[0]);
	and AL2N (ton[i][1], li[i], ncfg[1]);
	assign no[i] = |ton[i];

	and AS2E (toe[i][0], si[i], ecfg[0]);
	and AW2E (toe[i][1], wi[i], ecfg[1]);
	and AN2E (toe[i][2], ni[i], ecfg[2]);
	and AL2E (toe[i][3], li[i], ecfg[3]);
	assign eo[i] = |toe[i];

	and AS2L (tol[i][0], si[i], lcfg[0]);
	and AW2L (tol[i][1], wi[i], lcfg[1]);
	and AN2L (tol[i][2], ni[i], lcfg[2]);
	and AE2L (tol[i][3], ei[i], lcfg[3]);
	assign lo[i] = |tol[i];
     end // block: OPA
   endgenerate
	
endmodule // cb_xy




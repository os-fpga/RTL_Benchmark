/*
 Asynchronous SDM NoC
 (C)2011 Wei Song
 Advanced Processor Technologies Group
 Computer Science, the Univ. of Manchester, UK
 
 Authors: 
 Wei Song     wsong83@gmail.com
 
 License: LGPL 3.0 or later
 
 General pipeline stage using the 4-phase 1-of-4 QDI protocol.
 *** SystemVerilog is used ***
 
 History:
 05/05/2009  Initial version. <wsong83@gmail.com>
 17/04/2011  Replace the common ack generation. <wsong83@gmail.com>
 26/05/2011  Clean up for opensource. <wsong83@gmail.com>
 21/06/2011  Remove the eof as it makes confusion. <wsong83@gmail.com>
 
*/

module pipe4(/*AUTOARG*/
   // Outputs
   ia, o0, o1, o2, o3,
   // Inputs
   i0, i1, i2, i3, oa
   );
    
   parameter DW = 32;		// the data width of the pipeline stage
   parameter SCN = DW/2;	// the number of 1-of-4 sub-stage required
   
   input  [SCN-1:0]  i0, i1, i2, i3;
   output [SCN-1:0]  o0, o1, o2, o3;
   input 	     oa;	// input ack
   output 	     ia;	// output ack

   // internal signals
   wire [SCN-1:0]    tack;
   
   // generate the ack line
   genvar       i;
   
   // the data pipe stage
   generate for (i=0; i<SCN; i++) begin:DD
      dc2 DC0 (.d(i0[i]), .a(oa), .q(o0[i]));
      dc2 DC1 (.d(i1[i]), .a(oa), .q(o1[i]));
      dc2 DC2 (.d(i2[i]), .a(oa), .q(o2[i]));
      dc2 DC3 (.d(i3[i]), .a(oa), .q(o3[i]));
   end endgenerate

   // generate the input ack
   assign tack = o0|o1|o2|o3;
   ctree #(.DW(SCN)) ACKT (.ci(tack), .co(ia));

endmodule // pipe4





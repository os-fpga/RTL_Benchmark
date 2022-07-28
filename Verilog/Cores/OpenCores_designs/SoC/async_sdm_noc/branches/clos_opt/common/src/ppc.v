/*
 Asynchronous SDM NoC
 (C)2011 Wei Song
 Advanced Processor Technologies Group
 Computer Science, the Univ. of Manchester, UK
 
 Authors: 
 Wei Song     wsong83@gmail.com
 
 License: LGPL 3.0 or later
 
 Pipeline controller
 
 References
 See the STG and compiled verilog in sdm/stg/, ibctl.g and ibctl.v
 
 History:
 21/06/2009  Initial version. <wsong83@gmail.com>
 
*/

module ppc(/*AUTOARG*/
   // Outputs
   deca, dia,
   // Inputs
   eof, doa, dec
   );
   input 	      eof, doa, dec;
   output 	      deca;	// the ack to eof
   output             dia;	// the pipe stage input ack

   c2p CEoF (.q(deca), .a(doa), .b(eof));
   c2n CDIA (.q(dia), .a(eof|doa), .b(dec&(~deca)));
   
endmodule // ppc

   
   
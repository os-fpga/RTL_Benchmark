/*
 Asynchronous SDM NoC
 (C)2011 Wei Song
 Advanced Processor Technologies Group
 Computer Science, the Univ. of Manchester, UK
 
 Authors: 
 Wei Song     wsong83@gmail.com
 
 License: LGPL 3.0 or later
 
 Unidirectional crossbar 
 *** SystemVerilog is used ***
 
 History:
 07/07/2011  Initial version. <wsong83@gmail.com>
 
*/

module cb (/*AUTOARG*/
   // Outputs
   data_out,
   // Inputs
   data_in, cfg
   ) ;
   // parameters
   parameter NN = 1;	      // number of input ports
   parameter MN = 1;	      // number of output ports
   parameter DW = 1;	      // datawidth a port

   input [NN-1:0][DW-1:0]     data_in;	  // input data
   output [MN-1:0][DW-1:0]    data_out;	  // output requests
   input [MN-1:0][NN-1:0]     cfg; // the crossbar configuration
   
   wire [MN-1:0][DW-1:0][NN-1:0] m; // the internal wires for data
 
   // generate variable
   genvar 		      i, j, k;

   // request matrix
   generate
      for (i=0; i<MN; i++) begin: EN
	 for (j=0; j<DW; j++) begin: SC
	    for (k=0; k<NN; k++) begin: IP
	       and AC (m[i][j][k], data_in[k][j], cfg[i][k]);
	    end
	    
	    // the OR gates
	    assign data_out[i][j] = |m[i][j];
	 end
      end
   endgenerate

endmodule // cb



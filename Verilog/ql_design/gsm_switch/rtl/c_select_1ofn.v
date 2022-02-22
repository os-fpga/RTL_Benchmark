// $Id: c_select_1ofn.v 4079 2011-10-22 21:59:12Z dub $

/*
 Copyright (c) 2007-2011, Trustees of The Leland Stanford Junior University
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 Redistributions of source code must retain the above copyright notice, this 
 list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this
 list of conditions and the following disclaimer in the documentation and/or
 other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

//==============================================================================
// generic select mux (i.e., mux with one-hot control signal)
//==============================================================================

module c_select_1ofn
  (select, data_in, data_out);
   
`include "c_constants.v"
   
   // number of input ports
   parameter num_ports = 4;
   
   // width of each port
   parameter width = 32;
   
   // control signal to select active port
   input [0:num_ports-1] select;
   
   // vector of inputs
   input [0:num_ports*width-1] data_in;
   
   // result
   output [0:width-1] 	       data_out;
   wire [0:width-1] 	       data_out;
   
   generate
      
      // NOTE: This module was intended to represent something like a pass-gate
      // or other multiplexer that requires that no more than one bit in the 
      // 'select' input is high at any given time. As Design Compiler appears 
      // to not like prolific use of tri-state logic, it is currently 
      // functionally identical to 'c_select_mofn' (which ORs all selected 
      // inputs); however, 'c_select_1ofn' should be preferred wherever the 
      // 'select' input is known to be one-hot.
      
      /*
      genvar p;
      for(p = 0; p < num_ports; p = p + 1)
	begin:ports
	   
	   wire sel;
	   assign sel = select[p];
	   
	   wire [0:width-1] data;
	   assign data = data_in[p*width:(p+1)*width-1];
	   
	   assign data_out = sel ? data : {width{1'bz}};
	   
	end
      */
      
      genvar 		       i;
      for(i = 0; i < width; i = i + 1)
	begin:width_loop
	   
	   wire [0:num_ports-1] port_bits;
	   
	   genvar 		j;
	   
	   for(j = 0; j < num_ports; j = j + 1)
	     begin:ports_loop
		
		c_binary_op
		   #(.num_ports(2),
		     .width(1),
		     .op(`BINARY_OP_AND))
		prod
		   (.data_in({data_in[i+j*width], select[j]}),
		    .data_out(port_bits[j]));
		
	     end
	   
	   c_binary_op
	     #(.num_ports(num_ports),
	       .width(1),
	       .op(`BINARY_OP_OR))
	   sum
	     (.data_in(port_bits),
	      .data_out(data_out[i]));
	   
	end
      
   endgenerate
   
endmodule

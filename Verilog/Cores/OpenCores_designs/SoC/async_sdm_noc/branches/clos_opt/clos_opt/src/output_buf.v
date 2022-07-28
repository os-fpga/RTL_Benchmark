/*
 Asynchronous SDM NoC
 (C)2011 Wei Song
 Advanced Processor Technologies Group
 Computer Science, the Univ. of Manchester, UK
 
 Authors: 
 Wei Song     wsong83@gmail.com
 
 License: LGPL 3.0 or later
 
 Output buffer for Wormhole/SDM routers.
 *** SystemVerilog is used ***
 
 References
 * Lookahead pipelines 
     Montek Singh and Steven M. Nowick}, The design of high-performance dynamic asynchronous pipelines: lookahead style, IEEE Transactions on Very Large Scale Integration (VLSI) Systems, 2007(15), 1256-1269. doi:10.1109/TVLSI.2007.902205
 
 History:
 26/05/2009  Initial version. <wsong83@gmail.com>
 20/09/2010  Supporting channel slicing and SDM using macro difinitions. <wsong83@gmail.com>
 22/10/2010  Parameterize the number of pipelines in output buffers. <wsong83@gmail.com>
 23/05/2011  Clean up for opensource. <wsong83@gmail.com>
 21/06/2011  Move the eof logic in every pipeline stage outside the pipe4 module. <wsong83@gmail.com>
 20/07/2011  Preparation for the buffered Clos switch. <wsong83@gmail.com>

*/

// the router structure definitions
`include "define.v"

// the out buffer
module outp_buf (/*AUTOARG*/
   // Outputs
   o0, o1, o2, o3, o4, ia, ia4,
   // Inputs
   rst_n, i0, i1, i2, i3, i4, oa
   );
   
   parameter DW = 16;		// the datawidth of a single virtual circuit
   parameter PD = 2;		// buffer depth
   parameter SCN = DW/2;	// the number of 1-of-4 sub-channel in each virtual circuit

   input                  rst_n;          // global reset, active low
   input [SCN-1:0] 	  i0, i1, i2, i3; // data input
   output [SCN-1:0] 	  o0, o1, o2, o3; // data output
   wire [PD:0][SCN-1:0]   pd0, pd1, pd2, pd3;  // data wires for the internal pipeline satges
`ifdef ENABLE_CHANNEL_SLICING
   input [SCN-1:0] 	  i4, oa; // eof and ack
   output [SCN-1:0] 	  o4, ia;
   wire [SCN-1:0] 	  ian_dly;
   wire [PD:0][SCN-1:0]   pd4, pda, pdan, pd4an; // internal eof and ack
`else
   input 		  i4, oa; // eof and ack
   output 		  o4, ia, ia4;
   wire 		  ian_dly;
   wire [PD:0] 		  pd4, pda, pdan, pd4an; // internal eof and ack
`endif


//-------------------------- pipeline ---------------------------------------//
    genvar       i,j;
   generate for(i=0; i<PD; i++) begin: DP
`ifdef ENABLE_CHANNEL_SLICING
      for(j=0; j<SCN; j++) begin: SC
	 pipe4 #(.DW(2))
	 P (
	    .o0  ( pd0[i][j]   ),
	    .o1  ( pd1[i][j]   ),
	    .o2  ( pd2[i][j]   ),
	    .o3  ( pd3[i][j]   ),
	    .ia  ( pda[i+1][j] ),
	    .i0  ( pd0[i+1][j] ),
	    .i1  ( pd1[i+1][j] ),
	    .i2  ( pd2[i+1][j] ),
	    .i3  ( pd3[i+1][j] ),
	    .oa  ( pdan[i][j]  )
	    );

	 pipen #(.DW(1))
	 PEoF (
	       .d_in_a  (             ),
	       .d_out   ( pd4[i][j]   ),
	       .d_in    ( pd4[i+1][j] ),
	       .d_out_a ( pd4an[i][j] )
	       );
      end // block: SC

`else // !`ifdef ENABLE_CHANNEL_SLICING
      pipe4 #(.DW(DW))
      P (
	 .o0  ( pd0[i]   ),
	 .o1  ( pd1[i]   ),
	 .o2  ( pd2[i]   ),
	 .o3  ( pd3[i]   ),
	 .ia  ( pda[i+1] ),
	 .i0  ( pd0[i+1] ),
	 .i1  ( pd1[i+1] ),
	 .i2  ( pd2[i+1] ),
	 .i3  ( pd3[i+1] ),
	 .oa  ( pdan[i]  )
	 );

      pipen #(.DW(1))
      PEoF (
	    .d_in_a  (          ),
	    .d_out   ( pd4[i]   ),
	    .d_in    ( pd4[i+1] ),
	    .d_out_a ( pd4an[i] )
	    );
      
`endif // !`ifdef ENABLE_CHANNEL_SLICING
   end // block: DP
   endgenerate
      
   // generate the ack lines for data pipelines
   generate for(i=1; i<PD; i++) begin: DPA
      assign pdan[i] = rst_n ? ~(pda[i]|pd4[i-1]) : 0;
   end
   endgenerate

   // generate the input ack, add the AND gate if lookahead pipelines are used
   generate
`ifdef ENABLE_CHANNEL_SLICING
      for(j=0; j<SCN; j++) begin: SCA
 `ifdef ENABLE_LOOKAHEAD
	 and ACKG (ia[j], pda[PD][j], ian_dly[j]);
	 delay DLY ( .q(ian_dly[j]), .a(pdan[PD-1][j]));
 `else
	 assign ia[j] = pda[PD][j];
 `endif
	 assign ia4[j] = pd4[PD-1][j];
	 assign pdan[0][j] = (~oa[j])&rst_n;
	 assign pd4an[0][j] = pdan[0][j];
      end
`else
 `ifdef ENABLE_LOOKAHEAD
      and ACKG (ia, pda[PD], ian_dly);
      delay DLY ( .q(ian_dly), .a(pdan[PD-1]));
 `else
      assign ia = pda[PD];
 `endif
      assign ia4 = pd4[PD-1];
      assign pdan[0] = (~oa)&rst_n;
      assign pd4an[0] = pdan[0];
`endif // !`ifdef ENABLE_LOOKAHEAD
   endgenerate
   
   // name change
   assign pd0[PD] = i0;
   assign pd1[PD] = i1;
   assign pd2[PD] = i2;
   assign pd3[PD] = i3;
   assign pd4[PD] = i4;
   assign o0 = pd0[0];
   assign o1 = pd1[0];
   assign o2 = pd2[0];
   assign o3 = pd3[0];
   assign o4 = pd4[0];

endmodule // outp_buf


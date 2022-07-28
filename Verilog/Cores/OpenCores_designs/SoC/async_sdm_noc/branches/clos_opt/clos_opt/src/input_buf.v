/*
 Asynchronous SDM NoC
 (C)2011 Wei Song
 Advanced Processor Technologies Group
 Computer Science, the Univ. of Manchester, UK
 
 Authors: 
 Wei Song     wsong83@gmail.com
 
 License: LGPL 3.0 or later
 
 Input buffer for Wormhole/SDM routers.
 *** SystemVerilog is used ***
 
 References
 * Lookahead pipelines 
     Montek Singh and Steven M. Nowick, The design of high-performance dynamic asynchronous pipelines: lookahead style, IEEE Transactions on Very Large Scale Integration (VLSI) Systems, 2007(15), 1256-1269. doi:10.1109/TVLSI.2007.902205
 * Channel slicing
     Wei Song and Doug Edwards, A low latency wormhole router for asynchronous on-chip networks, Asia and South Pacific Design Automation Conference, 2010, 437-443.
 * SDM
     Wei Song and Doug Edwards, Asynchronous spatial division multiplexing router, Microprocessors and Microsystems, 2011(35), 85-97.
 
 History:
 05/05/2009  Initial version. <wsong83@gmail.com>
 20/09/2010  Supporting channel slicing and SDM using macro difinitions. <wsong83@gmail.com>
 24/05/2011  Clean up for opensource. <wsong83@gmail.com>
 01/06/2011  Use the comp4 common comparator rather than the chain_comparator defined in this module. <wsong83@gmail.com>
 21/06/2011  Move the eof logic in every pipeline stage outside the pipe4 module. <wsong83@gmail.com>
 12/07/2011  Preparation for the buffered Clos switch. <wsong83@gmail.com>
 
*/

// the router structure definitions
`include "define.v"

module inp_buf (/*AUTOARG*/
   // Outputs
   o0, o1, o2, o3, o4, ia, deco,
   // Inputs
   rst_n, i0, i1, i2, i3, i4, oa, addrx, addry
   );

   //-------------------------- parameters ---------------------------------------//
   parameter DIR = 0;              // the port direction: south, west, north, east, and local
   parameter RN = 4;               // the number of request outputs, must match the direction
   parameter DW = 16;              // the data-width of the data-path
   parameter PD = 2;		   // the depth of the input buffer
   parameter SCN = DW/2;

   //-------------------------- I/O ports ---------------------------------------//
   input                  rst_n;          // global reset, active low
   input [SCN-1:0] 	  i0, i1, i2, i3; // data input
   output [SCN-1:0] 	  o0, o1, o2, o3; // data output
`ifdef ENABLE_CHANNEL_SLICING
   input [SCN-1:0] 	  i4, oa;
   output [SCN-1:0] 	  o4, ia;
`else
   input 		  i4, oa;
   output 		  o4, ia;
`endif
   input [7:0] 		  addrx, addry; // local addresses in 1-of-4 encoding
   output [RN-1:0] 	  deco;	// the decoded routing requests
   
   //-------------------------- control signals ---------------------------------------//
   wire 		  rta;	               // the ack of the dec reg pipeline stage
   wire 		  frame_end;	       // identify the end of a frame
   wire [7:0] 		  pipe_xd, pipe_yd;    // the target address from the incoming frame
   wire [PD:0][SCN-1:0]   pd0, pd1, pd2, pd3;  // data wires for the internal pipeline satges
   wire [5:0] 		  raw_dec;             // the routing decision from the comparator
   wire [4:0] 		  xy_dec;              // the routing decision of the XY routing algorithm
   wire [4:0] 		  dec_reg;             // the routing decision kept by C-gates
   wire 		  x_equal;             // addr x = target x
   wire 		  rt_err;              // route decoder error
   
`ifdef ENABLE_CHANNEL_SLICING
   wire [SCN-1:0] 	  deca;	// the ack for routing requests
   wire [SCN-1:0] 	  pda1;	// the ack for the 1st pipeline stage
   wire [SCN-1:0] 	  acko;	// the ack from CB
   wire [PD:0][SCN-1:0]   pd4, pda, pdan, pd4an; // data wires for the internal pipeline stages

`else
   wire 		  deca;	// the ack for routing requests
   wire 		  pda1;	// the ack for the 1st pipeline stage
   wire 		  acko;	// the ack from CB
   wire [PD:0] 		  pd4, pda, pdan, pda4n; // data wires for the internal pipeline satges
`endif // !`ifdef ENABLE_CHANNEL_SLICING
   wire 		  decan;

   genvar 		  i, j;

   //------------------------- pipelines ------------------------------------- //
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
	       .d_out_a ( pda4n[i][j] )
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
	    .d_out_a ( pda4n[i] )
	    );
      
`endif // !`ifdef ENABLE_CHANNEL_SLICING
   end // block: DP
   endgenerate

   generate 
      for(i=2; i<PD; i++) begin: DPA
	 assign pdan[i] = rst_n ? ~(pda[i]|pd4[i-1]) : 0;
	 assign pda4n[i] = pdan[i];
      end

      // in case only one pipeline stage is configured
      if(PD>1)
	assign ia = pda[PD]|pd4[PD-1];
      else
	assign ia = pda1;
      
   endgenerate

   //assign ia = pda[PD]|pd4[PD-1];
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
   
   //---------------------------- route decoder related -------------------------- //
   // fetch the x and y target
   and Px_0 (pipe_xd[0], ~rta, pd0[1][0]);
   and Px_1 (pipe_xd[1], ~rta, pd1[1][0]);
   and Px_2 (pipe_xd[2], ~rta, pd2[1][0]);
   and Px_3 (pipe_xd[3], ~rta, pd3[1][0]);
   and Px_4 (pipe_xd[4], ~rta, pd0[1][1]);
   and Px_5 (pipe_xd[5], ~rta, pd1[1][1]);
   and Px_6 (pipe_xd[6], ~rta, pd2[1][1]);
   and Px_7 (pipe_xd[7], ~rta, pd3[1][1]);
   and Py_0 (pipe_yd[0], ~rta, pd0[1][2]);
   and Py_1 (pipe_yd[1], ~rta, pd1[1][2]);
   and Py_2 (pipe_yd[2], ~rta, pd2[1][2]);
   and Py_3 (pipe_yd[3], ~rta, pd3[1][2]);
   and Py_4 (pipe_yd[4], ~rta, pd0[1][3]);
   and Py_5 (pipe_yd[5], ~rta, pd1[1][3]);
   and Py_6 (pipe_yd[6], ~rta, pd2[1][3]);
   and Py_7 (pipe_yd[7], ~rta, pd3[1][3]);

   
   routing_decision      // the comparator
   RTD(
       .addrx     ( addrx   ),
       .addry     ( addry   ),
       .pipe_xd   ( pipe_xd ),
       .pipe_yd   ( pipe_yd ),
       .decision  ( raw_dec )
       );

   // translate it into the XY dec; not QDI here as the circuit can be slow
   assign xy_dec[1:0] = raw_dec[1:0];
   assign xy_dec[4:2] = raw_dec[2] ? raw_dec[5:3] : 0;
   
   // the decoded routing requests
   pipen #(.DW(5))
   PDEC (
	 .d_in_a  ( rta      ),
	 .d_out   ( dec_reg  ),
	 .d_in    ( xy_dec   ),
	 .d_out_a ( decan    )
	 );

   assign decan = ~(&deca);

   // generate the arbiter request signals
   assign deco = 
		  DIR == 0 ? {dec_reg[4],dec_reg[2],dec_reg[1],dec_reg[3]} :   // south port
                  DIR == 1 ? {dec_reg[4],dec_reg[2]}                       :   // west port
                  DIR == 2 ? {dec_reg[4],dec_reg[2],dec_reg[3],dec_reg[0]} :   // north port
                  DIR == 3 ? {dec_reg[4],dec_reg[3]}                       :   // east port
                             {dec_reg[2],dec_reg[1],dec_reg[3],dec_reg[0]} ;   // local port
   

   assign rt_err = 
		  DIR == 0 ? |{dec_reg[0]}                        :   // south port
                  DIR == 1 ? |{dec_reg[0],dec_reg[1],dec_reg[3]}  :   // west port
                  DIR == 2 ? |{dec_reg[1]}                        :   // north port
                  DIR == 3 ? |{dec_reg[0],dec_reg[1],dec_reg[2]}  :   // east port
                             |{dec_reg[4]}                        ;   // local port

   // ------------------------ pipeline control ------------------------------ //
   
`ifdef ENABLE_CHANNEL_SLICING
   for(j=0; j<SCN; j++) begin: SC
      // the sub-channel controller
      ppc SCH_C (
		 .deca     ( deca[j]    ),
		 .dia      ( pda1[j]    ),
		 .eof      ( pd4[0][j]  ),
		 .doa      ( acko[j]|(pda[0][j]&rt_err) ),  // to handle faulty frames
		 .dec      ( rta        )
		 );

      // the lookahead pipeline
 `ifdef ENABLE_LOOKAHEAD
      c2n CD (.q(acko[j]), .a(oa[j]), .b(pda[0][j])); // the C2N gate to avoid early withdrawal
 `else
      assign acko[j] = oa[j];
 `endif

      // the ack lines for the last two pipeline stages
      assign pdan[0][j] = (~oa[j])&rst_n;
      assign pda4n[0][j] = (~deca[j])&rst_n;
      assign pdan[1][j] = (~pda1[j])&rst_n;
      assign pda4n[1][j] = pdan[1][j];
 
   end // block: SC
`else // !`ifdef ENABLE_CHANNEL_SLICING
   ppc SCH_C (
	      .deca     ( deca    ),
	      .dia      ( pda1    ),
	      .eof      ( pd4[0]  ),
	      .doa      ( acko|(pda[0]&rt_err) ),  // to handle faulty frames
	      .dec      ( rta     )
	      );
   
   // the lookahead pipeline
 `ifdef ENABLE_LOOKAHEAD
   c2n CD (.q(acko), .a(oa), .b(pda[0])); // the C2N gate to avoid early withdrawal
 `else
   assign acko = oa;
 `endif
   
   // the ack lines for the last two pipeline stages
   assign pdan[0] = (~oa)&rst_n;
   assign pda4n[0] = (~deca)&rst_n;
   assign pdan[1] = (~pda1)&rst_n;
   assign pda4n[1] = pdan[1];
   
`endif // !`ifdef ENABLE_CHANNEL_SLICING
   
   
endmodule // inp_buf


// the routing decision making procedure, comparitors
module routing_decision (
			 addrx
			 ,addry
			 ,pipe_xd
			 ,pipe_yd
			 ,decision
			 );

   // compare with (2,3)
   input [7:0] addrx;
   input [7:0] addry;
   
   input   [7:0]   pipe_xd;
   input [7:0] 	   pipe_yd;
   output [5:0]    decision;

   wire [2:0] 	   x_cmp [1:0];
   wire [2:0] 	   y_cmp [1:0];

   comp4 X0 ( .a(pipe_xd[3:0]), .b(addrx[3:0]), .q(x_cmp[0]));
   comp4 X1 ( .a(pipe_xd[7:4]), .b(addrx[7:4]), .q(x_cmp[1]));
   comp4 Y0 ( .a(pipe_yd[3:0]), .b(addry[3:0]), .q(y_cmp[0]));
   comp4 Y1 ( .a(pipe_yd[7:4]), .b(addry[7:4]), .q(y_cmp[1]));

   assign decision[0] = x_cmp[1][0] | (x_cmp[1][2]&x_cmp[0][0]);       // frame x > addr x
   assign decision[1] = x_cmp[1][1] | (x_cmp[1][2]&x_cmp[0][1]);       // frame x < addr x
   assign decision[2] = x_cmp[1][2] & x_cmp[0][2];                     // frame x = addr x
   assign decision[3] = y_cmp[1][0] | (y_cmp[1][2]&y_cmp[0][0]);       // frame y > addr y
   assign decision[4] = y_cmp[1][1] | (y_cmp[1][2]&y_cmp[0][1]);       // frame y < addr y
   assign decision[5] = y_cmp[1][2] & y_cmp[0][2];                     // frame y = addr y

endmodule // routing_decision

/*
 Asynchronous SDM NoC
 (C)2011 Wei Song
 Advanced Processor Technologies Group
 Computer Science, the Univ. of Manchester, UK
 
 Authors: 
 Wei Song     wsong83@gmail.com
 
 License: LGPL 3.0 or later
 
 An IM of a buffered Clos for SDM-Clos routers
 *** SystemVerilog is used ***
 
 History:
 07/07/2011  Initial version. <wsong83@gmail.com>
 
*/

// the router structure definitions
`include "define.v"

module im (/*AUTOARG*/
   // Outputs
   do0, do1, do2, do3, deco, dia, do4,
   // Inputs
   di0, di1, di2, di3, deci, di4, doa,
`ifndef ENABLE_CRRD
   cms,
`endif
   rst_n
   );
   
   parameter MN = 2;		// the number of CMs
   parameter NN = 2;		// the number of IPs in one IM
   parameter DW = 8;		// the data width of a single IP
   parameter SN = 2;		// the number of possible output directions
   parameter SCN = DW/2;	// the number of sub-channels in one IP

   input [NN-1:0][SCN-1:0]      di0, di1, di2, di3; // data input
   input [NN-1:0][SN-1:0]       deci;		    // decoded dir input
   output [MN-1:0][SCN-1:0] 	do0, do1, do2, do3; // data output
   output [MN-1:0][SN-1:0] 	deco;		    // decoded dir output

   // eof bits and ack lines
`ifdef ENABLE_CHANNEL_SLICING
   input [NN-1:0][SCN-1:0] 	di4; // data input
   output [NN-1:0][SCN-1:0]     dia; // input ack
   output [MN-1:0][SCN-1:0] 	do4; // data output
   input [MN-1:0][SCN-1:0] 	doa; // output ack
`else
   input [NN-1:0] 		di4; // data input
   output [NN-1:0] 		dia; // input ack
   output [MN-1:0] 		do4; // data output
   input [MN-1:0] 		doa; // output ack
`endif // !`ifdef ENABLE_CHANNEL_SLICING
   
`ifndef ENABLE_CRRD
   input [MN-1:0][SN-1:0] 	cms; // the states from CMs
`endif	       

   input rst_n;			// global active low reset

   wire [MN-1:0][NN-1:0]        cfg;			// the configuration for the IM
   wire [MN-1:0][SCN-1:0]       imo0, imo1, imo2, imo3; // the IM output data
   wire [MN-1:0][SN-1:0]        imodec;			// the IM output dec
`ifdef ENABLE_CHANNEL_SLICING
   wire [MN-1:0][SCN-1:0] 	imo4;	     // IM output data
   wire [MN-1:0][SCN-1:0] 	imoa, imoa4; // IM output ack
   wire [MN-1:0][SCN-1:0] 	eofan, doan, deca; // stage control acks
`else
   wire [MN-1:0] 		imo4;	     // IM data output
   wire [MN-1:0] 		imoa, imoa4; // IM output ack
   wire [MN-1:0]                eofan, doan, deca; // stage control acks
`endif // !`ifdef ENABLE_CHANNEL_SLICING
   wire [MN-1:0] 		decan;
 		
   genvar 			i, j;

   // the data crossbar
   dcb #(.NN(NN), .MN(MN), .DW(DW))
   IMDCB (
	.o0  ( imo0    ),
	.o1  ( imo1    ),
	.o2  ( imo2    ),
	.o3  ( imo3    ),
	.o4  ( imo4    ),
	.ia  ( dia     ),
	.i0  ( di0     ),
	.i1  ( di1     ),
	.i2  ( di2     ),
	.i3  ( di3     ),
	.i4  ( di4     ),
	.oa  ( imoa    ),
	.oa4 ( imoa4   ),
	.cfg ( cfg     )
	);

   // the crossbar for decoded direction
   cb  #(.NN(NN), .MN(MN), .DW(SN))
   IMDECCB (
	    .data_in   ( deci   ),
	    .data_out  ( imodec ),
	    .cfg       ( cfg    )
	    );

   // the IM dispatcher
   im_alloc #(.VCN(NN), .CMN(MN), .SN(SN))
   IMD (
	.IMr   ( deci      ),
	.IMa   (           ),
`ifndef ENABLE_CRRD
	.CMs   ( cms       ),
`endif	       
	.cfg   ( cfg       ),
	.rst_n ( rst_n     )
	);

   // the buffer stage for data
   generate
      for(i=0; i<MN; i++) begin: OPD
`ifdef ENABLE_CHANNEL_SLICING
	 for(j=0; j<SCN; j++) begin:SC
	    pipe4 #(.DW(2))
	    P (
	       .o0 ( do0[i][j]  ),
	       .o1 ( do1[i][j]  ),
	       .o2 ( do2[i][j]  ),
	       .o3 ( do3[i][j]  ),
	       .ia ( imoa[i][j] ),
	       .i0 ( imo0[i][j] ),
	       .i1 ( imo1[i][j] ),
	       .i2 ( imo2[i][j] ),
	       .i3 ( imo3[i][j] ),
	       .oa ( doan[i][j] )
	       );
	    
	    pipen #(.DW(1))
	    PEoF (
		  .d_in_a  (             ),
		  .d_out   ( do4[i][j]   ),
		  .d_in    ( imo4[i][j]  ),
		  .d_out_a ( eofan[i][j] ),
		  );
	    
	    ppc PCTL (
		      .deca   ( deca[i][j]  ),
		      .dia    ( imoa4[i][j] ),
		      .eof    ( do4[i][j]   ),
		      .doa    ( doa[i][j]   ),
		      .dec    ( |deco[i]    )
		      );

	    assign doan[i][j] = (~doa[i][j])&rst_n;
	    assign eofan[i][j] = (~deca[i][j])&rst_n;
	 end // block: SC

	 assign decan[i] = (~&deca[i])&rst_n;
	 
`else // !`ifdef ENABLE_CHANNEL_SLICING
	 pipe4 #(.DW(DW))
	 P (
	    .o0 ( do0[i]  ),
	    .o1 ( do1[i]  ),
	    .o2 ( do2[i]  ),
	    .o3 ( do3[i]  ),
	    .ia ( imoa[i] ),
	    .i0 ( imo0[i] ),
	    .i1 ( imo1[i] ),
	    .i2 ( imo2[i] ),
	    .i3 ( imo3[i] ),
	    .oa ( doan[i] )
	    );
	 
	 pipen #(.DW(1))
	 PEoF (
	       .d_in_a  (          ),
	       .d_out   ( do4[i]   ),
	       .d_in    ( imo4[i]  ),
	       .d_out_a ( eofan[i] )
	       );
	 
	 ppc PCTL (
		   .deca   ( deca[i]  ),
		   .dia    ( imoa4[i] ),
		   .eof    ( do4[i]   ),
		   .doa    ( doa[i]   ),
		   .dec    ( |deco[i] )
		   );

	 assign doan[i] = (~doa[i])&rst_n;
	 assign eofan[i] = (~deca[i])&rst_n;

	 assign decan[i] = (~deca[i])&rst_n;
	 
`endif // !`ifdef ENABLE_CHANNEL_SLICING

	 pipen #(.DW(SN))
	 PDEC (
	       .d_in_a   (           ),
	       .d_out    ( deco[i]   ),
	       .d_in     ( imodec[i] ),
	       .d_out_a  ( decan[i]  )
	       );
      end // block: OPD
   endgenerate
   
endmodule // im

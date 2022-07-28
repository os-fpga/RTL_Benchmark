/*
 Asynchronous SDM NoC
 (C)2011 Wei Song
 Advanced Processor Technologies Group
 Computer Science, the Univ. of Manchester, UK
 
 Authors: 
 Wei Song     wsong83@gmail.com
 
 License: LGPL 3.0 or later
 
 Data crossbar for wormhole and SDM routers.
 *** SystemVerilog is used ***
 
 History:
 17/07/2010  Initial version. <wsong83@gmail.com>
 23/05/2011  Clean up for opensource. <wsong83@gmail.com>
 21/06/2011  Prepare to support buffered Clos. <wsong83@gmail.com>
 
*/

// the router structure definitions
`include "define.v"

module dcb (
   // Outputs
   o0, o1, o2, o3, ia, o4,
   // Inputs
   i0, i1, i2, i3, oa, i4, cfg
`ifdef ENABLE_BUFFERED_CLOS
   , oa4
`endif
   );

   parameter NN = 2;		// number of input ports
   parameter MN = 3;		// number of output ports
   parameter DW = 8;		// data-width of a port
   parameter SCN = DW/2;	// number of 1-of-4 sub-channels for one port
   
   input [NN-1:0][SCN-1:0]       i0, i1, i2, i3; // input ports
   output [MN-1:0][SCN-1:0] 	 o0, o1, o2, o3; // output ports

`ifdef ENABLE_CHANNEL_SLICING
   output [NN-1:0][SCN-1:0] 	 ia, o4; // eof and ack
   input [MN-1:0][SCN-1:0] 	 oa, i4;
 `ifdef ENABLE_BUFFERED_CLOS
   input [MN-1:0][SCN-1:0] 	 oa4; // the eof ack from output buffer
 `endif
`else
   output [NN-1:0] 		 ia, o4; // eof and ack
   input [MN-1:0] 		 oa, i4;
 `ifdef ENABLE_BUFFERED_CLOS
   input [MN-1:0] 		 oa4; // the eof ack from output buffer
 `endif
`endif

   input [MN-1:0][NN-1:0] 	 cfg; // crossbar configuration

   wire [MN-1:0][SCN-1:0][NN-1:0] dm0, dm1, dm2, dm3;

`ifdef ENABLE_CHANNEL_SLICING
   wire [NN-1:0][SCN-1:0][MN-1:0] am, dm4;
 `ifdef ENABLE_BUFFERED_CLOS
   wire [NN-1:0][SCN-1:0][MN-1:0] amd, am4;
 `endif   
`else
   wire [NN-1:0][MN-1:0] 	  am, dm4;
 `ifdef ENABLE_BUFFERED_CLOS
   wire [NN-1:0][MN-1:0] 	  amd, am4;
 `endif   
`endif
   
   genvar 			 i, j, k;

   generate
      for(i=0; i<MN; i++) begin: EN
	 for(j=0; j<NN; j++) begin: IP
	    for(k=0; k<SCN; k++) begin: SC
	       and A0 (dm0[i][k][j], i0[j][k], cfg[i][j]);
	       and A1 (dm1[i][k][j], i1[j][k], cfg[i][j]);
	       and A2 (dm2[i][k][j], i2[j][k], cfg[i][j]);
	       and A3 (dm3[i][k][j], i3[j][k], cfg[i][j]);
`ifdef ENABLE_CHANNEL_SLICING
	       and A4 (dm4[i][k][j], i4[j][k], cfg[i][j]);
 `ifdef ENABLE_BUFFERED_CLOS
	       and Aad (amd[j][k][i], oa[i][k], cfg[i][j]);
	       c2  Aa4 (.q(am4[j][k][i]), .a0(oa4[i][k]), .a1(cfg[i][j]));
	       assign am[j][k][i] = amd[j][k][i] | am4[j][k][i];
 `else
	       and Aa (am[j][k][i], oa[i][k], cfg[i][j]);
 `endif	       
`endif
	    end

`ifndef ENABLE_CHANNEL_SLICING
	    and A4 (dm4[i][j], i4[j], cfg[i][j]);
 `ifdef ENABLE_BUFFERED_CLOS
	    and Aa (amd[j][i], oa[i], cfg[i][j]);
	    c2  Aa4 (.q(am4[j][i]), .a0(oa4[i]), .a1(cfg[i][j]));
	    assign am[j][i] = amd[j][i] | am4[j][i];	    
 `else
	    and Aa (am[j][i], oa[i], cfg[i][j]);
 `endif
`endif
	 end // block: IP
      end // block: EN
   endgenerate

   generate
      for(i=0; i<MN; i++) begin: ORTD
	 for(j=0; j<SCN; j++) begin: OP
	    assign o0[i][j] = |dm0[i][j];
	    assign o1[i][j] = |dm1[i][j];
	    assign o2[i][j] = |dm2[i][j];
	    assign o3[i][j] = |dm3[i][j];
`ifdef ENABLE_CHANNEL_SLICING
	    assign o4[i][j] = |dm4[i][j];
`endif
	 end

`ifndef ENABLE_CHANNEL_SLICING
	 assign o4[i] = |dm4[i];
`endif

      end // block: ORTD
   endgenerate

   generate
      for(i=0; i<NN; i++) begin: ORTA
`ifdef ENABLE_CHANNEL_SLICING
	 for(j=0; j<SCN; j++) begin: IP
	   assign ia[i][j] = |am[i][j];
	 end
`else
	 assign ia[i] = |am[i];
`endif
      end
   endgenerate

endmodule // dcb


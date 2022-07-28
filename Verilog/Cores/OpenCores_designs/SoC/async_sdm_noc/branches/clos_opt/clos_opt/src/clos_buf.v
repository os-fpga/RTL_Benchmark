/*
 Asynchronous SDM NoC
 (C)2011 Wei Song
 Advanced Processor Technologies Group
 Computer Science, the Univ. of Manchester, UK
 
 Authors: 
 Wei Song     wsong83@gmail.com
 
 License: LGPL 3.0 or later
 
 Buffered Clos switch for SDM-Clos routers
 *** SystemVerilog is used ***
 
 History:
 09/07/2011  Initial version. <wsong83@gmail.com>
 
*/

// the router structure definitions
`include "define.v"

module clos (/*AUTOARG*/
   // Outputs
   so0, so1, so2, so3, wo0, wo1, wo2, wo3, no0, no1, no2, no3, eo0,
   eo1, eo2, eo3, lo0, lo1, lo2, lo3, so4, wo4, no4, eo4, lo4, sia,
   wia, nia, eia, lia,
   // Inputs
   si0, si1, si2, si3, wi0, wi1, wi2, wi3, ni0, ni1, ni2, ni3, ei0,
   ei1, ei2, ei3, li0, li1, li2, li3, si4, wi4, ni4, ei4, li4, soa,
   woa, noa, eoa, loa, soa4, woa4, noa4, eoa4, loa4, sdec, ndec, ldec,
   wdec, edec, rst_n
   );
   
   parameter MN = 2;		// number of CMs
   parameter NN = 2;		// number of ports in an IM or OM, equ. to number of virtual circuits
   parameter DW = 8;		// datawidth of a single virtual circuit/port
   parameter SCN = DW/2;	// number of 1-of-4 sub-channels in one port

   input [NN-1:0][SCN-1:0]     si0, si1, si2, si3; // south input [0], X+1
   input [NN-1:0][SCN-1:0]     wi0, wi1, wi2, wi3; // west input [1], Y-1
   input [NN-1:0][SCN-1:0]     ni0, ni1, ni2, ni3; // north input [2], X-1
   input [NN-1:0][SCN-1:0]     ei0, ei1, ei2, ei3; // east input [3], Y+1
   input [NN-1:0][SCN-1:0]     li0, li1, li2, li3; // local input
   output [NN-1:0][SCN-1:0]    so0, so1, so2, so3; // south output
   output [NN-1:0][SCN-1:0]    wo0, wo1, wo2, wo3; // west output
   output [NN-1:0][SCN-1:0]    no0, no1, no2, no3; // north output
   output [NN-1:0][SCN-1:0]    eo0, eo1, eo2, eo3; // east output
   output [NN-1:0][SCN-1:0]    lo0, lo1, lo2, lo3; // local output

   // eof bits and ack lines
`ifdef ENABLE_CHANNEL_SLICING
   input [NN-1:0][SCN-1:0]     si4, wi4, ni4, ei4, li4;
   output [NN-1:0][SCN-1:0]    so4, wo4, no4, eo4, lo4;
   output [NN-1:0][SCN-1:0]    sia, wia, nia, eia, lia;
   input [NN-1:0][SCN-1:0]     soa, woa, noa, eoa, loa;
// `ifdef ENABLE_BUFFERED_CLOS
   input [NN-1:0][SCN-1:0]     soa4, woa4, noa4, eoa4, loa4; // the eof ack from output buffers
// `endif
`else
   input [NN-1:0] 	       si4, wi4, ni4, ei4, li4;
   output [NN-1:0] 	       so4, wo4, no4, eo4, lo4;
   output [NN-1:0] 	       sia, wia, nia, eia, lia;
   input [NN-1:0] 	       soa, woa, noa, eoa, loa;
   input [NN-1:0] 	       soa4, woa4, noa4, eoa4, loa4; // the eof ack from output buffers
`endif // !`ifdef ENABLE_CHANNEL_SLICING

   input [NN-1:0][3:0] 	       sdec, ndec, ldec; // the routing requests
   input [NN-1:0][1:0]         wdec, edec;	 // the routing requests

   input 		       rst_n; // global active low reset

   wire [MN-1:0][SCN-1:0]      sim0, sim1, sim2, sim3;
   wire [MN-1:0][SCN-1:0]      wim0, wim1, wim2, wim3;
   wire [MN-1:0][SCN-1:0]      nim0, nim1, nim2, nim3;
   wire [MN-1:0][SCN-1:0]      eim0, eim1, eim2, eim3;
   wire [MN-1:0][SCN-1:0]      lim0, lim1, lim2, lim3;
   wire [MN-1:0][4:0][SCN-1:0] cmi0, cmi1, cmi2, cmi3;
   wire [MN-1:0][4:0][SCN-1:0] cmo0, cmo1, cmo2, cmo3;

`ifdef ENABLE_CHANNEL_SLICING
   wire [MN-1:0][SCN-1:0]      sim4, wim4, nim4, eim4, lim4;
   wire [MN-1:0][SCN-1:0]      sima, wima, nima, eima, lima;
   wire [MN-1:0][SCN-1:0]      sima4, wima4, nima4, eima4, lima4;
   wire [NN-1:0][SCN-1:0]      soa4, woa4, noa4, eoa4, loa4;
   wire [MN-1:0][4:0][SCN-1:0] cmo4, cmi4, cmia, cmoa, cmoa4;
`else
   wire [MN-1:0] 	       sim4, wim4, nim4, eim4, lim4;
   wire [MN-1:0] 	       sima, wima, nima, eima, lima;
   wire [MN-1:0] 	       sima4, wima4, nima4, eima4, lima4;
   wire [NN-1:0] 	       soa4, woa4, noa4, eoa4, loa4;
   wire [MN-1:0][4:0] 	       cmo4, cmi4, cmia, cmoa, cmoa4;
`endif // !`ifdef ENABLE_CHANNEL_SLICING
   
   wire [MN-1:0][3:0] 	       simdec, nimdec, limdec; // the routing requests
   wire [MN-1:0][1:0] 	       wimdec, eimdec;	 // the routing requests

`ifndef ENABLE_CRRD
   wire [MN-1:0][3:0] 	       sims, nims, lims;
   wire [MN-1:0][1:0] 	       wims, eims;
   wire [MN-1:0][4:0] 	       cms;
`endif	       

   genvar 		       i,j;


   // the IMs
   im #(.MN(MN), .NN(NN), .DW(DW), .SN(4))
   SIM (
	.do0   ( sim0   ),
	.do1   ( sim1   ),
	.do2   ( sim2   ),
	.do3   ( sim3   ),
	.deco  ( simdec ),
	.dia   ( sia    ),
	.do4   ( sim4   ),
	.di0   ( si0    ),
	.di1   ( si1    ),
	.di2   ( si2    ),
	.di3   ( si3    ),
	.deci  ( sdec   ),
	.di4   ( si4    ),
	.doa   ( sima   ),
`ifndef ENABLE_CRRD
	.cms   ( sims   ),
`endif
	.rst_n ( rst_n  )
	);
   
   im #(.MN(MN), .NN(NN), .DW(DW), .SN(2))
   WIM (
	.do0   ( wim0   ),
	.do1   ( wim1   ),
	.do2   ( wim2   ),
	.do3   ( wim3   ),
	.deco  ( wimdec ),
	.dia   ( wia    ),
	.do4   ( wim4   ),
	.di0   ( wi0    ),
	.di1   ( wi1    ),
	.di2   ( wi2    ),
	.di3   ( wi3    ),
	.deci  ( wdec   ),
	.di4   ( wi4    ),
	.doa   ( wima   ),
`ifndef ENABLE_CRRD
	.cms   ( wims   ),
`endif
	.rst_n ( rst_n  )
	);
	
   im #(.MN(MN), .NN(NN), .DW(DW), .SN(4))
   NIM (
	.do0   ( nim0   ),
	.do1   ( nim1   ),
	.do2   ( nim2   ),
	.do3   ( nim3   ),
	.deco  ( nimdec ),
	.dia   ( nia    ),
	.do4   ( nim4   ),
	.di0   ( ni0    ),
	.di1   ( ni1    ),
	.di2   ( ni2    ),
	.di3   ( ni3    ),
	.deci  ( ndec   ),
	.di4   ( ni4    ),
	.doa   ( nima   ),
`ifndef ENABLE_CRRD
	.cms   ( nims   ),
`endif
	.rst_n ( rst_n  )
	);
   
   im #(.MN(MN), .NN(NN), .DW(DW), .SN(2))
   EIM (
	.do0   ( eim0   ),
	.do1   ( eim1   ),
	.do2   ( eim2   ),
	.do3   ( eim3   ),
	.deco  ( eimdec ),
	.dia   ( eia    ),
	.do4   ( eim4   ),
	.di0   ( ei0    ),
	.di1   ( ei1    ),
	.di2   ( ei2    ),
	.di3   ( ei3    ),
	.deci  ( edec   ),
	.di4   ( ei4    ),
	.doa   ( eima   ),
`ifndef ENABLE_CRRD
	.cms   ( eims   ),
`endif
	.rst_n ( rst_n  )
	);
	
   im #(.MN(MN), .NN(NN), .DW(DW), .SN(4))
   LIM (
	.do0   ( lim0   ),
	.do1   ( lim1   ),
	.do2   ( lim2   ),
	.do3   ( lim3   ),
	.deco  ( limdec ),
	.dia   ( lia    ),
	.do4   ( lim4   ),
	.di0   ( li0    ),
	.di1   ( li1    ),
	.di2   ( li2    ),
	.di3   ( li3    ),
	.deci  ( ldec   ),
	.di4   ( li4    ),
	.doa   ( lima   ),
`ifndef ENABLE_CRRD
	.cms   ( lims   ),
`endif
	.rst_n ( rst_n  )
	);

   // data wire shuffle
   // the CMs
   generate
      for(i=0; i<MN; i++) begin:CMSH
	 assign cmi0[i][0] = sim0[i];
	 assign cmi1[i][0] = sim1[i];
	 assign cmi2[i][0] = sim2[i];
	 assign cmi3[i][0] = sim3[i];
	 assign sima[i] = cmia[i][0];
	 assign sima4[i] = cmia[i][0];
	 
	 assign cmi0[i][1] = wim0[i];
	 assign cmi1[i][1] = wim1[i];
	 assign cmi2[i][1] = wim2[i];
	 assign cmi3[i][1] = wim3[i];
	 assign wima[i] = cmia[i][1];
	 assign wima4[i] = cmia[i][1];

	 assign cmi0[i][2] = nim0[i];
	 assign cmi1[i][2] = nim1[i];
	 assign cmi2[i][2] = nim2[i];
	 assign cmi3[i][2] = nim3[i];
	 assign nima[i] = cmia[i][2];
	 assign nima4[i] = cmia[i][2];

	 assign cmi0[i][3] = eim0[i];
	 assign cmi1[i][3] = eim1[i];
	 assign cmi2[i][3] = eim2[i];
	 assign cmi3[i][3] = eim3[i];
	 assign eima[i] = cmia[i][3];
	 assign eima4[i] = cmia[i][3];

	 assign cmi0[i][4] = lim0[i];
	 assign cmi1[i][4] = lim1[i];
	 assign cmi2[i][4] = lim2[i];
	 assign cmi3[i][4] = lim3[i];
	 assign lima[i] = cmia[i][4];
	 assign lima4[i] = cmia[i][4];

	 cm #(.KN(5), .DW(DW))
	 CMSW (
	       .do0   ( cmo0[i]   ),
	       .do1   ( cmo1[i]   ),
	       .do2   ( cmo2[i]   ),
	       .do3   ( cmo3[i]   ),
	       .dia   ( cmia[i]   ),
	       .do4   ( cmo4[i]   ),
	       .di0   ( cmi0[i]   ),
	       .di1   ( cmi1[i]   ),
	       .di2   ( cmi2[i]   ),
	       .di3   ( cmi3[i]   ),
	       .sdec  ( simdec[i] ),
	       .ndec  ( nimdec[i] ),
	       .ldec  ( limdec[i] ),
	       .wdec  ( wimdec[i] ),
	       .edec  ( eimdec[i] ),
	       .di4   ( cmi4[i]   ),
	       .doa   ( cmoa[i]   ),
	       .doa4  ( cmoa4[i]  ),
`ifndef ENABLE_CRRD
	       .cms   ( cms[i]    ),
`endif
	       .rst_n ( rst_n     )
	       );
	 
	 assign so0[i] = cmo0[i][0];
	 assign so1[i] = cmo1[i][0];
	 assign so2[i] = cmo2[i][0];
	 assign so3[i] = cmo3[i][0];
	 assign cmoa[i][0] = soa[i];
	 assign cmoa4[i][0] = soa4[i];
	 
	 assign wo0[i] = cmo0[i][1];
	 assign wo1[i] = cmo1[i][1];
	 assign wo2[i] = cmo2[i][1];
	 assign wo3[i] = cmo3[i][1];
	 assign cmoa[i][1] = woa[i];
	 assign cmoa4[i][1] = woa4[i];
	 
	 assign no0[i] = cmo0[i][2];
	 assign no1[i] = cmo1[i][2];
	 assign no2[i] = cmo2[i][2];
	 assign no3[i] = cmo3[i][2];
	 assign cmoa[i][2] = noa[i];
	 assign cmoa4[i][2] = noa4[i];
	 
	 assign eo0[i] = cmo0[i][3];
	 assign eo1[i] = cmo1[i][3];
	 assign eo2[i] = cmo2[i][3];
	 assign eo3[i] = cmo3[i][3];
	 assign cmoa[i][3] = eoa[i];
	 assign cmoa4[i][3] = eoa4[i];
	 
	 assign lo0[i] = cmo0[i][4];
	 assign lo1[i] = cmo1[i][4];
	 assign lo2[i] = cmo2[i][4];
	 assign lo3[i] = cmo3[i][4];
	 assign cmoa[i][4] = loa[i];
	 assign cmoa4[i][4] = loa4[i];

	 assign sims[i] = {cms[i][4],cms[i][3],cms[i][2],cms[i][1]};
	 assign wims[i] = {cms[i][4],cms[i][3]};
	 assign nims[i] = {cms[i][4],cms[i][3],cms[i][1],cms[i][0]};
	 assign eims[i] = {cms[i][4],cms[i][1]};
	 assign lims[i] = {cms[i][3],cms[i][2],cms[i][1],cms[i][0]};

      end
   endgenerate
   

endmodule // clos

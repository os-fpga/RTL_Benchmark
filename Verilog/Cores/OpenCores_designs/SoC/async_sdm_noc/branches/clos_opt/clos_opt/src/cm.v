/*
 Asynchronous SDM NoC
 (C)2011 Wei Song
 Advanced Processor Technologies Group
 Computer Science, the Univ. of Manchester, UK
 
 Authors: 
 Wei Song     wsong83@gmail.com
 
 License: LGPL 3.0 or later
 
 A CM of a buffered Clos for SDM-Clos routers
 *** SystemVerilog is used ***
 
 History:
 08/07/2011  Initial version. <wsong83@gmail.com>
 
*/

// the router structure definitions
`include "define.v"

module cm (
   // Outputs
   do0, do1, do2, do3, dia, do4,
   // Inputs
   di0, di1, di2, di3, sdec, ndec, ldec, wdec, edec, di4, doa, doa4,
`ifndef ENABLE_CRRD
   cms,
`endif
   rst_n
   );

   parameter KN = 5;	       // dummy parameter, the number of IMs
   parameter DW = 8;	       // the data width of each IP
   parameter SCN = DW/2;       // the number of sub-channels in one IP

   input [KN-1:0][SCN-1:0]    di0, di1, di2, di3;      // input data
   input [3:0] 		      sdec, ndec, ldec;	       // the decoded direction requests
   input [1:0] 		      wdec, edec;	       // the decoded direction requests
   output [KN-1:0][SCN-1:0]   do0, do1, do2, do3;      // output data

`ifdef ENABLE_CHANNEL_SLICING
   input [KN-1:0][SCN-1:0]    di4;                     // data input
   output [KN-1:0][SCN-1:0]   dia;		       // input ack
   output [KN-1:0][SCN-1:0]   do4;		       // data output
   input [KN-1:0][SCN-1:0]    doa, doa4;	       // output ack
`else
   input [KN-1:0] 	      di4;                     // data input
   output [KN-1:0] 	      dia;		       // input ack
   output [KN-1:0] 	      do4;		       // data output
   input [KN-1:0] 	      doa, doa4;	       // output ack
`endif // !`ifdef ENABLE_CHANNEL_SLICING
   
`ifndef ENABLE_CRRD
   output [KN-1:0] 	      cms; // the state feedback to IMs
`endif
   
   input 		      rst_n; // global active low reset

   wire [3:0] 		      wcfg, ecfg, lcfg;	// switch configuration
   wire [1:0] 		      scfg, ncfg;	// switch configuration

   genvar 		      i, j;

   // data switch
   dcb_xy #(.VCN(1), .VCW(DW))
   CMDCB (
	  .sia   ( dia[0]    ), 
	  .wia   ( dia[1]    ), 
	  .nia   ( dia[2]    ), 
	  .eia   ( dia[3]    ), 
	  .lia   ( dia[4]    ), 
	  .so0   ( do0[0]    ), 
	  .so1   ( do1[0]    ), 
	  .so2   ( do2[0]    ), 
	  .so3   ( do3[0]    ), 
	  .so4   ( do4[0]    ), 
	  .wo0   ( do0[1]    ), 
	  .wo1   ( do1[1]    ), 
	  .wo2   ( do2[1]    ),
	  .wo3   ( do3[1]    ), 
	  .wo4   ( do4[1]    ), 
	  .no0   ( do0[2]    ), 
	  .no1   ( do1[2]    ), 
	  .no2   ( do2[2]    ), 
	  .no3   ( do3[2]    ), 
	  .no4   ( do4[2]    ), 
	  .eo0   ( do0[3]    ), 
	  .eo1   ( do1[3]    ), 
	  .eo2   ( do2[3]    ), 
	  .eo3   ( do3[3]    ), 
	  .eo4   ( do4[3]    ), 
	  .lo0   ( do0[4]    ),
	  .lo1   ( do1[4]    ), 
	  .lo2   ( do2[4]    ), 
	  .lo3   ( do3[4]    ), 
	  .lo4   ( do4[4]    ),
	  .si0   ( di0[0]    ), 
	  .si1   ( di1[0]    ), 
	  .si2   ( di2[0]    ), 
	  .si3   ( di3[0]    ), 
	  .si4   ( di4[0]    ), 
	  .wi0   ( di0[1]    ), 
	  .wi1   ( di1[1]    ), 
	  .wi2   ( di2[1]    ), 
	  .wi3   ( di3[1]    ), 
	  .wi4   ( di4[1]    ), 
	  .ni0   ( di0[2]    ), 
	  .ni1   ( di1[2]    ), 
	  .ni2   ( di2[2]    ),
	  .ni3   ( di3[2]    ), 
	  .ni4   ( di4[2]    ), 
	  .ei0   ( di0[3]    ), 
	  .ei1   ( di1[3]    ), 
	  .ei2   ( di2[3]    ), 
	  .ei3   ( di3[3]    ), 
	  .ei4   ( di4[3]    ), 
	  .li0   ( di0[4]    ), 
	  .li1   ( di1[4]    ), 
	  .li2   ( di2[4]    ), 
	  .li3   ( di3[4]    ), 
	  .li4   ( di4[4]    ), 
	  .soa   ( doa[0]    ),
	  .woa   ( doa[1]    ),
	  .noa   ( doa[2]    ),
	  .eoa   ( doa[3]    ),
	  .loa   ( doa[4]    ),
	  .soa4  ( doa4[0]   ),
	  .woa4  ( doa4[1]   ),
	  .noa4  ( doa4[2]   ),
	  .eoa4  ( doa4[3]   ),
	  .loa4  ( doa4[4]   ),
	  .wcfg  ( wcfg      ), 
	  .ecfg  ( ecfg      ), 
	  .lcfg  ( lcfg      ), 
	  .scfg  ( scfg      ), 
	  .ncfg  ( ncfg      )
	  );

   // the allocator
   cm_alloc CMD (
`ifndef ENABLE_CRRD
		 .s     ( cms   ),
`endif	       
		 .sra   (       ),
		 .wra   (       ),
		 .nra   (       ),
		 .era   (       ),
		 .lra   (       ),
		 .scfg  ( scfg  ),
		 .ncfg  ( ncfg  ),
		 .wcfg  ( wcfg  ),
		 .ecfg  ( ecfg  ),
		 .lcfg  ( lcfg  ),
		 .sr    ( sdec  ),
		 .wr    ( wdec  ),
		 .nr    ( ndec  ),
		 .er    ( edec  ),
		 .lr    ( ldec  )
		 );

endmodule // cm

/*
 Asynchronous SDM NoC
 (C)2011 Wei Song
 Advanced Processor Technologies Group
 Computer Science, the Univ. of Manchester, UK
 
 Authors: 
 Wei Song     wsong83@gmail.com
 
 License: LGPL 3.0 or later
 
 XY address decoder, 1-of-4 code
 * Assuming the output will be capture for long time
 * The withdrawal of inputs are not guarded
 
 History:
 14/07/2010  Initial version. <wsong83@gmail.com>
 
*/

module addr_dec(/*AUTOARG*/
   // Outputs
   dec,
   // Inputs
   locx, locy, tarx, tary
   );
   input [7:0] locx, locy;	// the local addresses
   input [7:0] tarx, tary;	// the target addresses in the incoming frame
   output [4:0] dec;		// the decoded routing request

   wire [3:0][2:0] cmp;		// compare results

   comp4 X0 (.a(tarx[3:0]), .b(locx[3:0]), .q(dec[0]));
   comp4 X1 (.a(tarx[7:4]), .b(locx[7:4]), .q(dec[1]));
   comp4 Y0 (.a(tary[3:0]), .b(locy[3:0]), .q(dec[2]));
   comp4 Y1 (.a(tary[7:4]), .b(locy[7:4]), .q(dec[3]));

   assign dec[0] = dec[1][1] | (dec[1][2]&dec[0][1]); // south, tarx < locx
   assign dec[1] = dec[1][2]&dec[0][2]&(dec[3][0]|(dec[3][2]&dec[2][0])); // west, tary > locy
   assign dec[2] = dec[1][0] | (dec[1][2]&dec[0][0]); // north, tarx < locx
   assign dec[3] = dec[1][2]&dec[0][2]&(dec[3][1]|(dec[3][2]&dec[2][1])); // west, tary < locy
   assign dec[4] = dec[3][2]&dec[2][2]&dec[1][2]&dec[0][2];
endmodule // addr_dec

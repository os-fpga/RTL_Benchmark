//------------------------------------------------------------------------------
// (C) Copyright 2013, NXP Semiconductors
//     All rights reserved.
//
// PROPRIETARY INFORMATION
//
// The information contained in this file is the property of NXP Semiconductors.
// Except as specifically authorized in writing by NXP, the holder of this
// file: (1) shall keep all information contained herein confidential and
// shall protect same in whole or in part from disclosure and dissemination to
// all third parties and (2) shall use same for operation and maintenance
// purposes only.
// -----------------------------------------------------------------------------
// File name:		trig_filter.v
// Project:		Ctrl4 extended digital, passthru image
// Author: 		Roger Williams <roger.williams@nxp.com> (RAW)
// -----------------------------------------------------------------------------
// 1.07.2  2014-09-14 (RAW) Pass in N
// 0.01.0  2013-09-30 (RAW) Initial entry
//------------------------------------------------------------------------------

`include "timescale.v"

module trig_filter
  (
   output reg		O,
   input wire		I,
   input wire		C,
   input wire [15:0]	N
   );

   reg [15:0] 		tf;

   always @(posedge C)
      if (~I) begin
	 O <= 0;
	 tf <= 0;
      end
      else if (tf == N)
	 O <= 1;
      else
	 tf <= tf + 1;

endmodule

//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2019 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

module
  axis_mac #(W=32)
  (
    axis_if axis_ay,
    axis_if axis_az,
    output [31:0] result,
    output valid,
    input   aclk,
    input   aresetn
  );

  // --------------------------------------------------------------------
  wire both_valid = axis_ay.tvalid & axis_az.tvalid;
  wire tlast_in = both_valid & axis_ay.tlast & axis_az.tlast;

  // --------------------------------------------------------------------
  enum reg [3:0]
    {
      IDLE        = 4'b0001,
      ACCUMULATE  = 4'b0010,
      FLUSH       = 4'b0100,
      READY       = 4'b1000
    } state, next_state;

  // --------------------------------------------------------------------
  always_ff @(posedge aclk)
    if(~aresetn)
      state <= IDLE;
    else
      state <= next_state;

  // --------------------------------------------------------------------
  always_comb
    case(state)
      IDLE:       if(both_valid)
                    next_state <= ACCUMULATE;
                  else
                    next_state <= IDLE;

      ACCUMULATE: if(tlast_in)
                    next_state <= FLUSH;
                  else
                    next_state <= ACCUMULATE;

      FLUSH:      next_state <= READY;

      READY:      if(both_valid)
                    next_state <= ACCUMULATE;
                  else
                    next_state <= IDLE;

      default:    next_state <= IDLE;
    endcase

  // --------------------------------------------------------------------
  wire accumulate = ((state == ACCUMULATE) & both_valid);
  wire ena = aresetn & (accumulate | (state == FLUSH));
  wire [W-1:0] ay = axis_ay.tdata[W-1:0];
  wire [W-1:0] az = axis_az.tdata[W-1:0];
  wire [1:0] aclr = {~aresetn, ~aresetn | valid};

  mac mac(.clk(aclk), .*);

  // --------------------------------------------------------------------
  assign axis_ay.tready = accumulate;
  assign axis_az.tready = accumulate;
  assign valid = (state == READY);

// --------------------------------------------------------------------
endmodule

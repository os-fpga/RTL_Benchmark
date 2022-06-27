//---------------------------------------------------------------------------
// DDS core
//
//
// Description: See description below (which suffices for IP core
//                                     specification document.)
//
// Copyright (C) 2002 John Clayton and OPENCORES.ORG (this Verilog version)
//
// This source file may be used and distributed without restriction provided
// that this copyright statement is not removed from the file and that any
// derivative work contains the original copyright notice and the associated
// disclaimer.
//
// This source file is free software; you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published
// by the Free Software Foundation;  either version 2.1 of the License, or
// (at your option) any later version.
//
// This source is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
// License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this source.
// If not, download it from http://www.opencores.org/lgpl.shtml
//
//---------------------------------------------------------------------------
//
// Author: John Clayton
// Date  : June 28, 2002
//
// (NOTE: Date formatted as day/month/year.)
// Update: 28/06/02 copied initial code from serial.v (pared down).
//
// Description
//---------------------------------------------------------------------------
// This module implements a Direct Digital Synthesizer (DDS).
// It is very simple: A counter advances in phase each clock cycle, and
// the most significant bits are used to index into a waveform lookup table.
// This particular version does not include the lookup table, because I am
// initially looking for squarewave output only, so I am using the most
// significant bit of the counter as the output.
//
// The frequency resolution of a DDS can be very fine indeed, depending on
// how many bits are included in the phase accumulator counter.
//
// The output frequency is given by:
//
// Fout = frequency/(2^DDS_BITS_PP)*Fclk
//
// Generally, outputs up to 40% of Fclk may be generated when using a sine
// wave lookup table, with appropriate filtering.
//
// For the digital squarewave output, such as that produced by this module,
// the output can probably be as high as 50% of Fclk.  There is jitter present
// in the output, in the amount of +/- 0.5T, where T is the period of the
// clock.
//
//---------------------------------------------------------------------------


module square_wave_dds (
                  clk,
                  clk_en,
                  reset,
                  frequency,
                  clk_out
                  );

parameter DDS_BITS_PP  = 6;

input clk;
input clk_en;
input reset;
input[DDS_BITS_PP-1:0] frequency;

output clk_out;

// Simple renaming for readability
wire [DDS_BITS_PP-1:0] dds_phase_increment = frequency; 

reg [DDS_BITS_PP-1:0] dds_phase;

// This is the DDS phase accumulator part
always @(posedge clk)
begin
  if (reset) dds_phase <= 0;
  else if (clk_en) dds_phase <= dds_phase + dds_phase_increment;
end

assign clk_out = dds_phase[DDS_BITS_PP-1];

endmodule



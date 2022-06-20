/*
  Verilog implementation of the iso7816-3 smartcard interface.
  Copyright (C) 2003 Blaise Gassend <blaise at gassend dot com>
  
  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation; either version 2
  of the License, or (at your option) any later version.
  
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  
  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
*/

// This module gets data from a Wishbone interface and outputs it
// asynchronously using BAUD as a clock signal.

// Todo:
// Add support for repeat on error.

module outshifter(CLK_I, CYC_I, STB_I, ACK_O, RST_I, DAT_I, SC_IO, SENDING, BAUD);

  // *****************
  // Interface signals
  // *****************

  // Slave Wishbone interface signals.
  input CLK_I; // This signal also serves as the main clock for this module.
  input CYC_I;
  input STB_I;
  input [7:0] DAT_I;
  output ACK_O;
  input RST_I;
  
  output SC_IO; // The smartcard's IO pin 1 -> do not drive, 0 -> drive low.
  output SENDING; // Indicates that data is being sent.
  input BAUD; // Pulses at the Baud rate.

  
  
  // ******************
  // Signal definitions
  // ******************
  
  reg [10:0] outShifter = 11'h3F; // parity, data[7:0], start, stop from prev
  reg [4:0]  bitCounter = 0;
  reg SENDING = 0;
  reg ACK_O = 0;

  
  
  // *****
  // Logic
  // *****
  
  assign SC_IO = outShifter[0];
  
  always @(posedge CLK_I) begin
    
    ACK_O <= 0;
    
    if (RST_I) 
    begin // Reset everything
      outShifter[0] <= 1;
      bitCounter = 0;
      SENDING <= 0;
      ACK_O <= 0;
    end
    
    else if (bitCounter == 0)  
    begin // We are not currently sending
      outShifter[0] <= 1; // Ensure that we are not driving the output.
      SENDING <= 0;
      if (CYC_I && STB_I && ~ACK_O) 
      begin // We are getting a new byte that we are ready for.
        ACK_O <= 1;
        outShifter <= {((^DAT_I[7:4])^(^DAT_I[3:0])),DAT_I[7:0],2'b01};
	bitCounter = 12;
      end
    end 

    else 
    begin // We are currently sending.
      SENDING <= 1;
      if (BAUD) 
      begin // Time to shift to the next bit.
	outShifter <= {1'b1, outShifter[10:1]};
	bitCounter = bitCounter - 1;
      end
    end
  end
 
endmodule

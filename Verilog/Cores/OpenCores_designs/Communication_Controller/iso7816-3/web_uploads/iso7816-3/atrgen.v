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

// After a reset, this component waits 500 microseconds and outputs its
// predefined ATR (Answer to Reset) string.

//`include "defines.h"

module atrgen(CLK_I, CYC_O, STB_O, ACK_I, RST_I, DAT_O, PULSE);

  // **********
  // Parameters
  // **********
  
  // *** WARNING *** Ensure that waitCounter and byteCounter are wide enough!
  parameter delayCycles = 4000; // The CLK_I cycles to wait.
  parameter atrBytes = 6; // The number of bytes in the ATR.

  // *****************
  // Interface signals
  // *****************

  // Master Wishbone interface signals.
  input CLK_I; // This signal also serves as the main clock for this module.
  output CYC_O;
  output STB_O;
  output [7:0] DAT_O;
  input ACK_I;
  input RST_I;

  input PULSE;

  // ******************
  // Signal definitions
  // ******************
  
  reg [12:0] waitCounter = 0;
  reg [3:0] byteCounter = 0;
  reg STB_O = 0;
  reg [7:0] DAT_O;
  
  reg [7:0] resetCounter = 0;

  // *****
  // Logic
  // *****

  assign CYC_O = STB_O;
  
  always @(posedge CLK_I) begin
    if (RST_I)
    begin // Reset everything
      STB_O <= 0;
      waitCounter = delayCycles;
      byteCounter = atrBytes;
    end
    
    else if (waitCounter != 0)
    begin // Waiting
      STB_O <= 0; // Not actually necessary.
      if (PULSE)
        waitCounter = waitCounter - 1;
    end

    else if (byteCounter != 0)
    begin // Sending
      STB_O <= 1;
      if (ACK_I == 1)
      begin
        byteCounter = byteCounter - 1;
	if (byteCounter == 0)
	begin
	  STB_O <= 0;
          resetCounter <= resetCounter + 1;
	end
      end
    end

    else // Done sending
    begin
      STB_O <= 0;
    end

    case (byteCounter)
      6: DAT_O <= 8'h3b;
      5: DAT_O <= 8'h04;
      4: DAT_O <= 8'h01;
      3: DAT_O <= 8'h23;
      2: DAT_O <= 8'h45;
      1: DAT_O <= resetCounter[7:0];
      default: DAT_O <= 8'hxx;
    endcase
  end

endmodule

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

// Gets bytes through one Wishbone interface, interprets them and outputs
// bytes through the other Wishbone interface.

// FIXME reset if idle time too long?

module control(CLK, RST, CYC_I, STB_I, ACK_O, DAT_I, CYC_O, STB_O, ACK_I, DAT_O);
  
  // *****************
  // Interface signals
  // *****************

  input CLK; // This signal serves as the main clock for this module.
  input RST;
  
  // Master Wishbone interface signals.
  output CYC_O;
  output STB_O;
  output [7:0] DAT_O;
  input ACK_I;

  // Slave Wishbone interface signals.
  input CYC_I;
  input STB_I;
  input [7:0] DAT_I;
  output ACK_O;
  
  // ******************
  // Signal definitions
  // ******************
  
  reg [2:0] inCount = 5;
  reg [3:0] outCount = 0;
  reg STB_O;
  reg [7:0] DAT_O;
  reg ACK_O;

  reg [7:0] outBytes [15:0];
  reg [7:0] inBytes [4:0];
  reg [7:0] oVal;

  // *****
  // Logic
  // *****
  
  assign CYC_O = STB_O;
  
  always @(posedge CLK)
  begin
    ACK_O <= 0; // A priori we don't want to ACK anything.
    
    if (ACK_I) 
    begin // Output signal has been acked.
      STB_O <= 0;
      
    end

    if (inCount == 0)
    begin // Process the command that just came in.
      case (outCount)
        8: oVal = inBytes[3];
        7: oVal = inBytes[4];
        6: oVal = inBytes[3];
        5: oVal = inBytes[2];
        4: oVal = inBytes[1];
        3: oVal = inBytes[0];
        2: oVal = 8'h90;
        1: oVal = 8'h00;
        default: oVal = 8'hxx;
      endcase
      
      outBytes[outCount] <= oVal;

      if (outCount == 1)
      begin
        inCount = 5;
        outCount = 9;
	DAT_O <= inBytes[3];
      end
      else
	outCount = outCount - 1;
    end
    else 
    begin 
      if (STB_I && CYC_I && ~ACK_O)
      begin // Getting a byte.
        ACK_O <= 1;
        inCount = inCount - 1;
        inBytes[inCount] <= DAT_I;
  
        if (inCount == 0)
          outCount = 9;
      end
    
      else
      if (outCount != 0 && ~STB_O)
      begin // Send the next byte.
        if (outCount < 9)
          STB_O <= 1;
	if (outCount < 8)
          DAT_O <= outBytes[outCount];
        outCount = outCount - 1;
      end
    end
    
    if (RST)
    begin // Reset everything.
      STB_O <= 0;
      ACK_O <= 0;
      inCount = 5;
      outCount = 0;
    end
  end
endmodule

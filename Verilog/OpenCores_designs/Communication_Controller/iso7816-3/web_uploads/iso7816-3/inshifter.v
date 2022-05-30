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

// Gets data from an asynchronous serial line and outputs it on a Wishbone
// interface. The Wishbone interface is expected to answer long before the
// next character arrives.

// Todo:
// Detect errors

//`define inBuffDebug

module inshifter(CLK_I, CYC_O, STB_O, ACK_I, RST_I, DAT_O, SC_IO, IGNORE, BAUD_4);

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

  input SC_IO;
  input IGNORE; // Doesn't start receiving when this bit is set.
  input BAUD_4; // Impulses at baud rate x4.
  
  // ******************
  // Signal definitions
  // ******************

  reg [1:0] phase;
  reg [1:0] prevSamples = 0;
  reg [4:0] bitCounter = 0;
  reg [8:0] inShifter = 0;
  reg STB_O = 0; 
  reg nextBit = 0;
  reg [7:0] DAT_O;
  reg [4:0] outputCount = 0;
            
`ifdef inBuffDebug
  reg [127:0] history = 128'h0123456789abcdef0123456789abcdef; // DEBUG
  reg [7:0] historyCount = 0; // DEBUG
  wire dummy; // DEBUG
  jtag#(128,8) jtag(.CK(CLK_I), .IN1(history), .IN2(historyCount), .UPDATE1(dummy)); // DEBUG
`endif
  
  // *****
  // Logic
  // *****

  assign CYC_O = STB_O;

  always @(posedge CLK_I)
  begin                 
    nextBit = 0;
    
`ifdef inBuffDebug
    if (dummy && inShifter == 10'hab && DAT_O == 8'h79) DAT_O <= 0; // DEBUG
`endif    
    if (ACK_I)
      STB_O <= 0;
    
    if (RST_I)
    begin // We are being reset.
      bitCounter = 0;
      STB_O <= 0;
      prevSamples = 0;
      outputCount = 0;
    end

    else // We are not being reset.
    begin
      if (BAUD_4)
      begin // A baud tick has occured.
        if (bitCounter == 0 && prevSamples == 3 && SC_IO == 1)
	begin // We are waiting for a high before the start bit.
	  nextBit = 1;
        end
      
	if (bitCounter == 1)
	begin
	  if (prevSamples == 0 && SC_IO == 0 && IGNORE == 0)
	  begin // We are waiting for start bit.
	    phase = 2;
	    nextBit = 1;
          end 
	  else if (IGNORE)
	    bitCounter = 0;
	end
	  
	else if (phase == 1)
	begin // We just got a bit.
	  inShifter <= { SC_IO, inShifter[8:1] };
	  // FIXME Could detect error here.
	  nextBit = 1;
	  if (bitCounter == 10)
	  begin // Done receiving
            DAT_O <= inShifter[8:1];
`ifdef inBuffDebug
	    history = {history[119:0], inShifter[8:1]}; // DEBUG
	    historyCount = historyCount + 1; // DEBUG
`endif
	    bitCounter = 0;
	    nextBit = 0;
	    outputCount = 30; //12;
	    // FIXME Should check for parity here.
	  end
	end

	// Always update the prevSamples and phase when a baud tick occurs.
	prevSamples = {prevSamples[0], SC_IO};
	phase = phase + 1;
	if (nextBit != 0)
	  bitCounter = bitCounter + 1;
    
        if (outputCount > 0)
        begin
          outputCount = outputCount - 1;
          if (outputCount == 0)
            STB_O <= 1;
        end
      end
    end
  end

endmodule

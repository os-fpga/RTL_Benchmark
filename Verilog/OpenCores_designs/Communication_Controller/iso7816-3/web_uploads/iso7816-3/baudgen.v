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

// Generates pulses at the baud rate and 4 times the baud rate.

module baudgen(PULSE, BAUD, BAUD4, CK);
  parameter bauddiv_4 = `bauddiv / 4;
  
  output BAUD, BAUD4;
  input PULSE, CK;
  
  reg BAUD = 0;
  reg BAUD4 = 0;
  reg [1:0] baudPhase = 0;
  reg [8:0] baudDivCounter = 0;
  
  always @(posedge CK)
  begin
    BAUD4 <= 0;
    BAUD <= 0;
    if (PULSE)
    begin
      if (baudDivCounter == bauddiv_4 - 1) begin
        baudDivCounter <= 0;
        BAUD4 <= 1;
        baudPhase <= baudPhase + 1;
        BAUD <= (baudPhase == 0);
      end else begin
        baudDivCounter <= baudDivCounter + 1;
      end
    end
  end
endmodule

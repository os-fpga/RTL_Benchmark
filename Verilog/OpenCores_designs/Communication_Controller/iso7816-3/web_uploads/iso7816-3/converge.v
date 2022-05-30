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

// Takes two Wishbone Master interfaces and merges them, giving priority to
// interface 1.

module converge(CLK, RST, CYC1, STB1, DAT1, ACK1, CYC2, STB2, DAT2, ACK2,
                CYCS, DATS, STBS, ACKS);
  parameter width = 8;

  input CLK, RST, CYC1, STB1, CYC2, STB2, ACKS;
  input [width - 1:0] DAT1;
  input [width - 1:0] DAT2;
  output ACK1, ACK2, CYCS, STBS;
  output [width - 1:0] DATS;

  reg [width - 1:0] DATS;
  reg STBS = 0;
  reg ACK1 = 0;
  reg ACK2 = 0;
  reg owner = 0; // 0 -> interface 1, 1-> interface 2

  assign CYCS = STBS;
  
  always @(posedge CLK)
  begin
    if (RST)
    begin // Reset everything
      STBS <= 0;
      ACK1 <= 0;
      ACK2 <= 0;
      owner = 0;
    end
    
    else
    begin
      ACK1 <= 0;
      ACK2 <= 0;
      
      if (ACKS)
        STBS <= 0; // Buffer has just been emptied.
      
      if (CYC1 && ~CYC2)
        owner = 0;
  
      else if (CYC2 && ~CYC1)
        owner = 1;
      
      if ((~STBS || ACKS) && CYC1 && STB1 && owner == 0)
      begin // Buffer just got filled by interface 1.
        STBS <= 1;
        DATS <= DAT1;
        ACK1 <= 1;
      end
      
      else if ((~STBS || ACKS) && CYC2 && STB2 && ~CYC1 && owner == 1)
      begin // Buffer just got filled by interface 2.
        STBS <= 1;
        DATS <= DAT2;
        ACK2 <= 1;
      end
    end
  end
endmodule

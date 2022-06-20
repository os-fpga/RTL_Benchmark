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

module simul();
  reg CK = 0;         
  reg SC_CLK = 0;
  tri1 IO;
  reg RST = 0;
  reg forced = 1;

  initial
  begin
    forever #10 SC_CLK = ~SC_CLK;
  end
  
  initial
  begin
    $dumpfile("out.vcd");
    $dumpvars(0, simul);
//    $display("start");
    forever #2 CK = ~CK;
  end
  
  initial
  begin
    #100 RST = 1;
    forever #100000 $display("tick");
  end

  task sendbyte;
    input [7:0] BYTE;
    begin
      forced = 1;
      #1120 forced = 0;
      #560 forced = BYTE[0];
      #560 forced = BYTE[1];
      #560 forced = BYTE[2];
      #560 forced = BYTE[3];
      #560 forced = BYTE[4];
      #560 forced = BYTE[5];
      #560 forced = BYTE[6];
      #560 forced = BYTE[7];
      #560 forced = ^BYTE;
      #560 forced = 1;
    end
  endtask
  
  initial
  begin
    #200000 
    
    sendbyte(0);
    sendbyte(2);
    sendbyte(0);
    sendbyte(0);
    sendbyte(5);
    
    #100000 $finish;
  end

  assign IO = forced ? 1'bz : 0;
  
  interface interface (.SC_CLK(SC_CLK), .SC_IO(IO), .SC_RST(RST), .CK(CK));
endmodule

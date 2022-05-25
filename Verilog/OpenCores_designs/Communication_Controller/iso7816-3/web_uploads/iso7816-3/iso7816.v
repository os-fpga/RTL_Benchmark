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

module iso7816(P_CK,SC_IO,SC_RST,SC_CLK,LED1);          

  input P_CK; // synthesis attrbute PERIOD of P_CK is "20 ns"
  output LED1;
//  output LED2;
//  output LED3;
//  output LED4;
  inout SC_IO;
  input SC_RST;
  input SC_CLK;

// *****************
// Generate CK here.
// *****************

//  wire dCK, ubCK, fbCK, ubfbCK, ubpP_CK; 
//  CLKDLL dll(.CLKIN(P_CK), .CLKFB(dCK), .CLK2X(ubpP_CK));
//  BUFG ckbuf(.I(ubpP_CK), .O(dCK));
//  // synthesis attribute PERIOD of dCK is "10 ns" 

  wire CK50 = P_CK;
//  wire CK100 = dCK;

  wire CK = CK50;
  
// **************************
// Take care of the led here.
// **************************
//  reg [24:0] ledcount; 
//  wire [3:0] leds;

//  assign LED1 = leds[0];//scIOin;//ledcount[23];
//  assign LED2 = leds[1];//scRST;//ledcount[24];
//  assign LED3 = leds[2];//~scCLK;//ledcount[25];
//  assign LED4 = leds[3];//ledcount[24];
  
//  always @(posedge CK) 
//  begin 
//    ledcount = ledcount + 1; 
//  end 

// ********************
// Instantiate the UART
// ********************

  interface interface(.CK(CK), .SC_IO(SC_IO), .SC_CLK(SC_CLK), .SC_RST(SC_RST));

endmodule 

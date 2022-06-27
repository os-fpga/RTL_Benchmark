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

// `include "defines.h"

module interface(CK, SC_IO, SC_RST, SC_CLK);
  inout SC_IO;
  input SC_CLK;
  input SC_RST;
  input CK;
  
// **********************************
// Synchronize the smartcard signals.
// **********************************

  wire scIOin, scIOout, scCLKPulse;
  reg scRST = 0;
  reg [1:0] scIOsync = -1;
  reg [2:0] scRSTsync = -1;
  reg [2:0] scCLKsync = 0;

  assign SC_IO = scIOout ? 1'bz : 0;
  assign scIOin = scIOsync[1];
  assign scCLKPulse = scCLKsync[1] & (~scCLKsync[2]);

  always @(posedge CK)
  begin
    scIOsync <= {scIOsync[0], SC_IO};
    scRSTsync <= {scRSTsync[1:0], SC_RST};
    scCLKsync <= {scCLKsync[1:0], SC_CLK};

    // The follewing trick keeps scRST low until a rising edge is detected
    // on SC_RST.
    if (scRSTsync[2] != scRSTsync[1])
      scRST <= scRSTsync[1]; 
  end
  
  

// ******************
// The baud generator
// ******************

  wire baudPulse;
  wire baudPulse4;

  baudgen baudgen(.BAUD(baudPulse), .BAUD4(baudPulse4), 
    .CK(CK), .PULSE(scCLKPulse));
  
  // 1 is for ATR -> converge.
  // 2 is for control -> converge.
  // 3 is for converge -> outshifter.
  // 4 is for inshifter -> control.
  
  wire CK;
  wire CYC1, CYC2, CYC3, CYC4;
  wire STB1, STB2, STB3, STB4;
  wire ACK1, ACK2, ACK3, ACK4;
  wire [7:0] DAT1;
  wire [7:0] DAT2;
  wire [7:0] DAT3;
  wire [7:0] DAT4;
  wire SENDING;
  
  atrgen atrgen(.CLK_I(CK), .CYC_O(CYC1), .STB_O(STB1), .ACK_I(ACK1), 
    .RST_I(~scRST), .DAT_O(DAT1), .PULSE(scCLKPulse));
  outshifter outshifter(.CLK_I(CK), .CYC_I(CYC3), .STB_I(STB3), .ACK_O(ACK3), 
    .RST_I(~scRST), .DAT_I(DAT3), .SC_IO(scIOout), .BAUD(baudPulse), .SENDING(SENDING));
  inshifter inshifter(.CLK_I(CK), .CYC_O(CYC4), .STB_O(STB4), .ACK_I(ACK4), 
    .RST_I(~scRST), .DAT_O(DAT4), .SC_IO(scIOin), .BAUD_4(baudPulse4), .IGNORE(SENDING));
  converge converge(.CLK(CK), .RST(~scRST), .CYC1(CYC1), .STB1(STB1), .DAT1(DAT1),
    .ACK1(ACK1), .CYC2(CYC2), .STB2(STB2), .ACK2(ACK2), .DAT2(DAT2), .CYCS(CYC3),
    .STBS(STB3), .ACKS(ACK3), .DATS(DAT3));
  control control(.CLK(CK), .RST(~scRST), .CYC_I(CYC4), .STB_I(STB4), .ACK_O(ACK4),
    .DAT_I(DAT4), .CYC_O(CYC2), .STB_O(STB2), .ACK_I(ACK2), .DAT_O(DAT2));
                             
`ifdef oscilloscopeIO
  reg [4:0] counter;

  wire dummy; // synthesis attribute KEEP of dummy is true
  
  always @(posedge CK)
    if (baudPulse4)
    begin
      counter = counter + 1;
    end
  
    oscilloscope#(4) osc(.CK(CK), .EN(baudPulse4), .DAT({scRST,(counter == 0),scIOout, scIOin}),.DUMMY(dummy));
`endif
  
endmodule

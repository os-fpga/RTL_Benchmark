//////////////////////////////////////////////////////////////////////
////                                                              ////
//// i2cSlave.v                                                   ////
////                                                              ////
//// This file is part of the i2cSlave opencores effort.
//// <http://www.opencores.org/cores//>                           ////
////                                                              ////
//// Module Description:                                          ////
//// You will need to modify this file to implement your 
//// interface.
////                                                              ////
//// To Do:                                                       ////
//// 
////                                                              ////
//// Author(s):                                                   ////
//// - Steve Fielding, sfielding@base2designs.com                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2008 Steve Fielding and OPENCORES.ORG          ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE. See the GNU Lesser General Public License for more  ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from <http://www.opencores.org/lgpl.shtml>                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
`timescale 1ns / 10ps


module i2cSlave         (

                        ClockIn,
                        ResetIn,
                        sda,
                        scl,
                        dataFromRegIF,
                        regAddr,
                        writeEn,
                        dataToRegIF,
                        I2CReadDataLatchedOut		// Toggles whenever read data is grabbed
                        );


//-----Port Parameters-----------------
//

// i2c device address
parameter I2C_ADDRESS = 7'h3b;

// System clock frequency in MHz
// If you are using a clock frequency below 24MHz, then the macro
// for SDA_DEL_LEN will result in compile errors for i2cSlave.v
// you will need to hand tweak the SDA_DEL_LEN constant definition
parameter CLK_FREQ    = 24;

// Debounce SCL and SDA over this many clock ticks
// 10 ticks = 208nS @ 48MHz
parameter DEB_I2C_LEN = (10*CLK_FREQ)/48;

// Delay SCL for use as internal sampling clock
// 10 ticks = 208nS @ 48MHz
parameter SCL_DEL_LEN = (10*CLK_FREQ)/48;

// Delay SDA for use in start/stop detection
// 4 ticks = 83nS @ 48MHz
parameter SDA_DEL_LEN = (4*CLK_FREQ)/48;


//-----Port Signals--------------------
//

input                   ClockIn;
input                   ResetIn;
inout                   sda;
input                   scl;
input             [7:0] dataFromRegIF;
output            [7:0] regAddr;
output                  writeEn;
output	          [7:0] dataToRegIF;
output                  I2CReadDataLatchedOut;


wire                    ClockIn;
wire                    ResetIn;
wire                    sda;
wire                    scl;
wire              [7:0] dataFromRegIF;
wire              [7:0] regAddr;
wire                    writeEn;
wire  	          [7:0] dataToRegIF;
wire                    I2CReadDataLatchedOut;


//------Internal Signals-------------------
//

// local wires and regs
reg                     sdaDeb;
reg                     sclDeb;
reg   [DEB_I2C_LEN-1:0] sdaPipe;
reg   [DEB_I2C_LEN-1:0] sclPipe;

reg   [SCL_DEL_LEN-1:0] sclDelayed;
reg   [SDA_DEL_LEN-1:0] sdaDelayed;
reg               [1:0] startStopDetState;
wire                    clearStartStopDet;

wire sdaOut;
wire sdaIn;

reg               [1:0] rstPipe;
wire                    rstSyncToClk;
reg                     startEdgeDet;


//------Define Parameters------------------
//

// start stop detection states
parameter NULL_DET  = 2'b00;
parameter START_DET = 2'b01;
parameter STOP_DET  = 2'b10;


//------Logic Operations-------------------
//

assign sda   = (sdaOut == 1'b0) ? 1'b0 : 1'b1;
assign sdaIn =  sda;

// sync ResetIn rsing edge to ClockIn
always @(posedge ClockIn) 
begin

  if (ResetIn == 1'b1)
    rstPipe <= 2'b11;
  else
    rstPipe <= {rstPipe[0], 1'b0};

end

assign rstSyncToClk = rstPipe[1];

// debounce sda and scl
always @(posedge ClockIn) 
begin

  if (rstSyncToClk == 1'b1) 
  begin

    sdaPipe <= {DEB_I2C_LEN{1'b1}};
    sdaDeb  <= 1'b1;
    sclPipe <= {DEB_I2C_LEN{1'b1}};
    sclDeb  <= 1'b1;

  end
  else 
  begin

    sdaPipe <= {sdaPipe[DEB_I2C_LEN-2:0], sdaIn};
    sclPipe <= {sclPipe[DEB_I2C_LEN-2:0], scl};

    if (&sclPipe[DEB_I2C_LEN-1:1] == 1'b1)
      sclDeb <= 1'b1;
    else if (|sclPipe[DEB_I2C_LEN-1:1] == 1'b0)
      sclDeb <= 1'b0;

    if (&sdaPipe[DEB_I2C_LEN-1:1] == 1'b1)
      sdaDeb <= 1'b1;
    else if (|sdaPipe[DEB_I2C_LEN-1:1] == 1'b0)
      sdaDeb <= 1'b0;
  end
end


// delay scl and sda
// sclDelayed is used as a delayed sampling clock
// sdaDelayed is only used for start stop detection
// Because sda hold time from scl falling is 0nS
// sda must be delayed with respect to scl to avoid incorrect
// detection of start/stop at scl falling edge. 
always @(posedge ClockIn) 
begin

  if (rstSyncToClk == 1'b1) 
  begin
    sclDelayed <= {SCL_DEL_LEN{1'b1}};
    sdaDelayed <= {SDA_DEL_LEN{1'b1}};
  end
  else 
  begin
    sclDelayed <= {sclDelayed[SCL_DEL_LEN-2:0], sclDeb};
    sdaDelayed <= {sdaDelayed[SDA_DEL_LEN-2:0], sdaDeb};
  end

end

// start stop detection
always @(posedge ClockIn) 
begin

  if (rstSyncToClk == 1'b1) 
  begin
    startStopDetState <= NULL_DET;
    startEdgeDet <= 1'b0;
  end
  else 
  begin

    if (sclDeb == 1'b1 && sdaDelayed[SDA_DEL_LEN-2] == 1'b0 && sdaDelayed[SDA_DEL_LEN-1] == 1'b1)
      startEdgeDet <= 1'b1;
    else
      startEdgeDet <= 1'b0;

    if (clearStartStopDet == 1'b1)
      startStopDetState <= NULL_DET;
    else if (sclDeb == 1'b1) 
	begin

      if (sdaDelayed[SDA_DEL_LEN-2] == 1'b1 && sdaDelayed[SDA_DEL_LEN-1] == 1'b0) 
        startStopDetState <= STOP_DET;
      else if (sdaDelayed[SDA_DEL_LEN-2] == 1'b0 && sdaDelayed[SDA_DEL_LEN-1] == 1'b1)
        startStopDetState <= START_DET;

    end
  end
end

i2cSlaveSerialInterface   #(

  .I2C_ADDRESS             (I2C_ADDRESS),
  .NULL_DET                (NULL_DET),
  .START_DET               (START_DET),
  .STOP_DET                (STOP_DET)
  )

   u_i2cSlaveSerialInterface (

  .ClockIn                 (ClockIn), 
  .ResetIn                 (rstSyncToClk | startEdgeDet), 
  .dataIn                  (dataFromRegIF), 
  .dataOut                 (dataToRegIF), 
  .writeEn                 (writeEn),
  .regAddr                 (regAddr), 
  .scl                     (sclDelayed[SCL_DEL_LEN-1]), 
  .sdaIn                   (sdaDeb), 
  .sdaOut                  (sdaOut), 
  .startStopDetState       (startStopDetState),
  .clearStartStopDet       (clearStartStopDet),
  .I2CReadDataLatchedOut   (I2CReadDataLatchedOut)
  );


endmodule

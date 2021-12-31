//////////////////////////////////////////////////////////////////////
////                                                              ////
//// i2cSlaveTop.v                                                ////
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

module i2cSlaveTop (

              ClockIn,
              ResetIn,
              Sda,
              Scl,
              RegAddrOut,
              RegDataIn,
              RegDataOut,
              WriteEnableOut,
              I2CReadDataLatchedOut
);

//-----Port Parameters-----------------
//

// i2c device address
parameter I2C_ADDRESS = 7'h3b;  // Sensor Hub Default Address; 
                                // Note: This should be remapped by the calling module.

// System clock frequency in MHz
// If you are using a clock frequency below 24MHz, then the macro
// for SDA_DEL_LEN will result in compile errors for i2cSlave.v
// you will need to hand tweak the SDA_DEL_LEN constant definition
parameter CLK_FREQ    = 24;


//-----Port Signals--------------------
//

input         ClockIn;
input         ResetIn;
inout         Sda;
inout         Scl;
output  [7:0] RegAddrOut;
input   [7:0] RegDataIn;
output  [7:0] RegDataOut;
output        WriteEnableOut;
output        I2CReadDataLatchedOut;


wire          ClockIn;
wire          ResetIn;
wire          Sda;
wire          Scl;
wire    [7:0] RegAddrOut;
wire    [7:0] RegDataIn;
wire    [7:0] RegDataOut;
wire          WriteEnableOut;
wire          I2CReadDataLatchedOut;


//------Internal Signals-------------------
//


//------Define Parameters------------------
//


//------Logic Operations-------------------
//



//------Instantiate Modules----------------
//

i2cSlave                  #(

   .I2C_ADDRESS            (I2C_ADDRESS),
   .CLK_FREQ               (CLK_FREQ)
   )

   u_i2cSlave              (

  .ClockIn                 (ClockIn),
  .ResetIn                 (ResetIn),
  .sda                     (Sda),
  .scl                     (Scl),
  .regAddr                 (RegAddrOut),
  .dataToRegIF             (RegDataOut),
  .writeEn                 (WriteEnableOut),
  .dataFromRegIF           (RegDataIn),
  .I2CReadDataLatchedOut   (I2CReadDataLatchedOut)

  );


endmodule

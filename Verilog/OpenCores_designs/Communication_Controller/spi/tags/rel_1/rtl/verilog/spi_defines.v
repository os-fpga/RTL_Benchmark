//////////////////////////////////////////////////////////////////////
////                                                              ////
////  spi_define.v                                                ////
////                                                              ////
////  This file is part of the SPI IP core project                ////
////  http://www.opencores.org/projects/spi/                      ////
////                                                              ////
////  Author(s):                                                  ////
////      - Simon Srot (simons@opencores.org)                     ////
////                                                              ////
////  All additional information is avaliable in the Readme.txt   ////
////  file.                                                       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2002 Authors                                   ////
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
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

//
// Number of bits used for devider register. If used in system with
// low frequency of system clock this can be reduced.
// Default is 16.
//
`define SPI_DIVIDER_BIT_NB      16

//
// Maximum nuber of bits that can be send/received at once. Alloved values are
// 32, 16 and 8. SPI_CHAR_LEN_BITS must be also set to 5, 4 or 3 respectively.
// Default is 32.
//
`define SPI_MAX_CHAR            32
`define SPI_CHAR_LEN_BITS       5

//
// Number of device select signals.
//
`define SPI_SS_NB               8
//
// Bits of WISHBONE address used for partial decoding of SPI registers.
//
`define SPI_OFS_BITS	          3:2

//
// Register offset
//
`define SPI_RX                  0
`define SPI_TX                  0
`define SPI_CTRL                1
`define SPI_DEVIDE              2
`define SPI_SS                  3

//
// Number of bits in ctrl register
//
`define SPI_CTRL_BIT_NB         10

//
// Control register bit position
//
`define SPI_CTRL_IE             9
`define SPI_CTRL_LSB            8
`define SPI_CTRL_CHAR_LEN       7:3
`define SPI_CTRL_TX_NEGEDGE     2
`define SPI_CTRL_RX_NEGEDGE     1
`define SPI_CTRL_GO             0



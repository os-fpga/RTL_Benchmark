//////////////////////////////////////////////////////////////////////
////                                                              ////
////  MD5 stimulus                                                ////
////                                                              ////
////  This file is part of the SystemC MD5                        ////
////                                                              ////
////  Description:                                                ////
////  MD5 stimulus file                                           ////
////                                                              ////
////  To Do:                                                      ////
////   - done                                                     ////
////                                                              ////
////  Author(s):                                                  ////
////      - Javier Castillo, jcastilo@opencores.org               ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
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
// CVS Revision History
//
// $Log: not supported by cvs2svn $

#include "stimulus.h"

void
test::tb ()
{

  transactor->resetea ();

  transactor->wait_cycles (5);

  //hash of "a"
  transactor->hash (0x00008061, 0x0, 0x0, 0x0);
  transactor->hash (0x0, 0x0, 0x0, 0x0);
  transactor->hash (0x0, 0x0, 0x0, 0x0);
  transactor->hash (0x0, 0x0, 0x8, 0x0);

  transactor->print_result ();

  transactor->new_text ();

  //hash of lots of "a"
  transactor->hash (0x61616161, 0x61616161, 0x61616161, 0x61616161);
  transactor->hash (0x61616161, 0x61616161, 0x61616161, 0x61616161);
  transactor->hash (0x61616161, 0x61616161, 0x61616161, 0x61616161);
  transactor->hash (0x61616161, 0x61616161, 0x61616161, 0x61616161);

  transactor->print_result ();

  transactor->hash (0x61616161, 0x61616161, 0x61616161, 0x61616161);
  transactor->hash (0x61616161, 0x61616161, 0x61616161, 0x61616161);
  transactor->hash (0x80, 0x0, 0x0, 0x0);
  transactor->hash (0x0, 0x0, 0x300, 0x0);

  transactor->print_result ();

  transactor->new_text ();

  transactor->hash (0x61616161, 0x61616161, 0x61616161, 0x61616161);
  transactor->hash (0x61616161, 0x61616161, 0x61616161, 0x61616161);
  transactor->hash (0x61616161, 0x61616161, 0x61616161, 0x61616161);
  transactor->hash (0x61616161, 0x61616161, 0x61616161, 0x61616161);

  transactor->print_result ();
}

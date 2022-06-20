#!/usr/bin/python3
# Python version: 3.6.7
import re

# //////////////////////////////////////////////////////////////////////
# ////                                                              ////
# ////  Low Pass Filter FIR IP Core                                 ////
# ////                                                              ////
# ////  This file is part of the LPFFIR project                     ////
# ////  https://opencores.org/projects/lpffir                       ////
# ////                                                              ////
# ////  Description                                                 ////
# ////  Implementation of LPFFIR IP core according to               ////
# ////  LPFFIR IP core specification document.                      ////
# ////                                                              ////
# ////  To Do:                                                      ////
# ////  -                                                           ////
# ////                                                              ////
# ////  Author:                                                     ////
# ////  - Vladimir Armstrong, vladimirarmstrong@opencores.org       ////
# ////                                                              ////
# //////////////////////////////////////////////////////////////////////
# ////                                                              ////
# //// Copyright (C) 2019 Authors and OPENCORES.ORG                 ////
# ////                                                              ////
# //// This source file may be used and distributed without         ////
# //// restriction provided that this copyright statement is not    ////
# //// removed from the file and that any derivative work contains  ////
# //// the original copyright notice and the associated disclaimer. ////
# ////                                                              ////
# //// This source file is free software; you can redistribute it   ////
# //// and/or modify it under the terms of the GNU Lesser General   ////
# //// Public License as published by the Free Software Foundation; ////
# //// either version 2.1 of the License, or (at your option) any   ////
# //// later version.                                               ////
# ////                                                              ////
# //// This source is distributed in the hope that it will be       ////
# //// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
# //// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
# //// PURPOSE.  See the GNU Lesser General Public License for more ////
# //// details.                                                     ////
# ////                                                              ////
# //// You should have received a copy of the GNU Lesser General    ////
# //// Public License along with this source; if not, download it   ////
# //// from http://www.opencores.org/lgpl.shtml                     ////
# ////                                                              ////
# //////////////////////////////////////////////////////////////////////

# path
rtl_path = '../../sim/rtl_sim/out/rtl_impulseResponse.txt'
check_path = '../out/check_impulseResponse.txt'

# open
rtl_file = open(rtl_path,'r')
check_file = open(check_path,'w')

# read
rtl_list = rtl_file.readlines()

# remove header text
del rtl_list[0:9]

# remove newlines
rtl_list2 = [x.replace('\n', '') for x in rtl_list]

# Expected from MATLAB, first 0:5 index is one
oneCount = 0
for index in range(6):
   searchObj = re.search( r'1$', rtl_list2[index])
   if searchObj:
       oneCount += 1

# Expected from MATLAB, last 6:$ index is zero
zeroCount = 0
for index in range(6,len(rtl_list2)):
   searchObj = re.search( r'0$', rtl_list2[index])
   if searchObj:
       zeroCount += 1

# check RTL match MATLAB expected
if oneCount == 6 and zeroCount == 7:
    checkResult = "Impulse Response Test: PASS";
else:
    checkResult =  "Impulse Response Test: FAIL";

# Log
print (checkResult);
check_file.write(checkResult)

# close
rtl_file.close()
check_file.close()

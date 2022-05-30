//////////////////////////////////////////////////////////////////////
////                                                              ////
//// APB- SPI 0.1 IP Core READ_ME file                            ////
////                                                              ////
//// This file is part of the APB- SPI 0.1 IP Core project        ////
//// http://www.opencores.org/cores/APB- SPI 0.1                  ////
////                                                              ////
//// Description                                                  ////
//// ------------                                                 ////
////  Initial version of README file. With more additions and     ////
////  changes of RTL and TB, more steps and descriptions will be  ////
////  added                                                       ////
////                                                              ////
////                                                              ////
//// Author(s):                                                   ////
//// - Lakshmi Narayanan Vernugopal, email@opencores.org          ////
//// - Srikumar Kadagambadi,  email@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009 Authors and OPENCORES.ORG                 ////
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
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              //// 
//////////////////////////////////////////////////////////////////////


 Steps to take get the Project up & running by making changes 
 to Makefile and other files.                                 
                                                              
                                                              
 Step 1 : In the makefile under TB directory, there is a variable called         
          "BUILD_NAME". That has to be updated to where the   
          trunk is going to be checked out.                   
 Step 2 : Allow the direcctory "TB" to be parallel to "RTL"   
          directory                                           
 Step 3 : other directories which are under TB should be kept 
          as is under the TB directory.                       
 Step 4 : Ensure that the directory where "defines.v" file is kept
          is added to the incdir in makefile                  


 To Do in the future:                                                       
 ---------------------
 1. Ensure that different configurations of the APB to SPI.   

 2. Add more testcases and ensure that they can be run from   
    command line using the makefile target and a variable     
    along with that which'll be the testcase's name.                                          

 3. Add a testplan which is configurable based on different   
    variations of RTL and change the TB accordingly.          


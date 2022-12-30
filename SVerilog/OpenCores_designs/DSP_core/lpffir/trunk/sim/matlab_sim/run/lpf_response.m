% //////////////////////////////////////////////////////////////////////
% ////                                                              ////
% ////  Low Pass Filter FIR IP Core                                 ////
% ////                                                              ////
% ////  This file is part of the LPFFIR project                     ////
% ////  https://opencores.org/projects/lpffir                       ////
% ////                                                              ////
% ////  Description                                                 ////
% ////  Implementation of LPFFIR IP core according to               ////
% ////  LPFFIR IP core specification document.                      ////
% ////                                                              ////
% ////  To Do:                                                      ////
% ////  -                                                           ////
% ////                                                              ////
% ////  Author:                                                     ////
% ////  - Vladimir Armstrong, vladimirarmstrong@opencores.org       ////
% ////                                                              ////
% //////////////////////////////////////////////////////////////////////
% ////                                                              ////
% //// Copyright (C) 2019 Authors and OPENCORES.ORG                 ////
% ////                                                              ////
% //// This source file may be used and distributed without         ////
% //// restriction provided that this copyright statement is not    ////
% //// removed from the file and that any derivative work contains  ////
% //// the original copyright notice and the associated disclaimer. ////
% ////                                                              ////
% //// This source file is free software; you can redistribute it   ////
% //// and/or modify it under the terms of the GNU Lesser General   ////
% //// Public License as published by the Free Software Foundation; ////
% //// either version 2.1 of the License, or (at your option) any   ////
% //// later version.                                               ////
% ////                                                              ////
% //// This source is distributed in the hope that it will be       ////
% //// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
% //// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
% //// PURPOSE.  See the GNU Lesser General Public License for more ////
% //// details.                                                     ////
% ////                                                              ////
% //// You should have received a copy of the GNU Lesser General    ////
% //// Public License along with this source; if not, download it   ////
% //// from http://www.opencores.org/lgpl.shtml                     ////
% ////                                                              ////
% //////////////////////////////////////////////////////////////////////

% Cleanup
clear;clc;close all;

% Difference equation of low-pass filter
b = [1, 1, 1, 1, 1, 1]; a = [1];

% Response
n = [0:7];
h = impz(b,a,8);
[H,w] = freqz(b,a,100);
magH = abs(H); phaH = angle(H);

% Plot
subplot(4,1,1); stem(n,h);
title('Impulse Response'); xlabel('n'); ylabel('h(n)')
subplot(4,1,2);zplane(b,a);grid
title('Pole-Zero Plot')
subplot(4,1,3);plot(w/pi,magH);grid
xlabel('Frequency in \pi units'); ylabel('Magnitude');
title('Magnitude Response')
subplot(4,1,4);plot(w/pi,phaH/pi);grid
xlabel('Frequency in \pi units'); ylabel('Phase in \pi units');
title('Phase Response')

% Write Tabular Impulse Response Data to Text File
fileID = fopen('matlab_impulseResponse.txt','w');
fprintf(fileID,'%1.1d\n',h);
fclose(fileID);
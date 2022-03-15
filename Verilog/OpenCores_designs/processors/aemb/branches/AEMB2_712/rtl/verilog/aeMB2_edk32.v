/* $Id: aeMB2_edk32.v,v 1.1 2007-12-07 18:58:51 sybreon Exp $
**
** AEMB2 HI-PERFORMANCE CPU
** 
** Copyright (C) 2004-2007 Shawn Tan Ser Ngiap <shawn.tan@aeste.net>
**  
** This file is part of AEMB.
**
** AEMB is free software: you can redistribute it and/or modify it
** under the terms of the GNU Lesser General Public License as
** published by the Free Software Foundation, either version 3 of the
** License, or (at your option) any later version.
**
** AEMB is distributed in the hope that it will be useful, but WITHOUT
** ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
** or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General
** Public License for more details.
**
** You should have received a copy of the GNU Lesser General Public
** License along with AEMB. If not, see <http:**www.gnu.org/licenses/>.
*/



module aeMB2_edk32 (/*AUTOARG*/);

   parameter IWB = 32; ///< instruction wishbone address space
   parameter DWB = 32; ///< data wishbone address space
   parameter MUL = 1; ///< enable hardware multiplier
   parameter BSF = 1; ///< enable barrel shifter
   parameter DIV = 0; ///< enable hardware divider

   
   
endmodule // aeMB2_edk32

/* $Log: not supported by cvs2svn $ */
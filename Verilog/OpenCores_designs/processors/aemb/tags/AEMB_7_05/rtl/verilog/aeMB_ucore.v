/*
 * $Id: aeMB_ucore.v,v 1.1 2007-04-13 13:02:34 sybreon Exp $
 * 
 * AEMB Unified 32-bit Microprocessor Core
 * Copyright (C) 2006-2007 Shawn Tan Ser Ngiap <shawn.tan@aeste.net>
 *  
 * This library is free software; you can redistribute it and/or modify it 
 * under the terms of the GNU Lesser General Public License as published by 
 * the Free Software Foundation; either version 2.1 of the License, 
 * or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful, but 
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
 * or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public 
 * License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License 
 * along with this library; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA 
 *
 * DESCRIPTION
 * This is the top level core with integrated cache and unified memory.
 *
 * HISTORY
 * $Log: not supported by cvs2svn $
 */

// 691@60
module aeMB_ucore (/*AUTOARG*/
   // Outputs
   wb_wre_o, wb_stb_o, wb_sel_o, wb_dat_o, wb_adr_o,
   // Inputs
   wb_dat_i, wb_ack_i, sys_rst_i, sys_int_i, sys_exc_i, sys_clk_i
   );
   /* Bus Address Width */
   parameter ASIZ = 32;
   parameter CSIZ = 7;   
   /* DO NOT TOUCH */
   parameter DSIZ = ASIZ;
   parameter ISIZ = ASIZ;   
   
   /*AUTOOUTPUT*/
   // Beginning of automatic outputs (from unused autoinst outputs)
   output [ASIZ-1:0]	wb_adr_o;		// From wbbus of aeMB_wbbus.v
   output [31:0]	wb_dat_o;		// From wbbus of aeMB_wbbus.v
   output [3:0]		wb_sel_o;		// From wbbus of aeMB_wbbus.v
   output		wb_stb_o;		// From wbbus of aeMB_wbbus.v
   output		wb_wre_o;		// From wbbus of aeMB_wbbus.v
   // End of automatics
   /*AUTOINPUT*/
   // Beginning of automatic inputs (from unused autoinst inputs)
   input		sys_clk_i;		// To wbbus of aeMB_wbbus.v, ...
   input		sys_exc_i;		// To cpu of aeMB_core.v
   input		sys_int_i;		// To cpu of aeMB_core.v
   input		sys_rst_i;		// To wbbus of aeMB_wbbus.v, ...
   input		wb_ack_i;		// To wbbus of aeMB_wbbus.v
   input [31:0]		wb_dat_i;		// To wbbus of aeMB_wbbus.v
   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			dwb_ack_i;		// From wbbus of aeMB_wbbus.v
   wire [DSIZ-1:0]	dwb_adr_o;		// From cpu of aeMB_core.v
   wire [31:0]		dwb_dat_i;		// From wbbus of aeMB_wbbus.v
   wire [31:0]		dwb_dat_o;		// From cpu of aeMB_core.v
   wire			dwb_stb_o;		// From cpu of aeMB_core.v
   wire			dwb_we_o;		// From cpu of aeMB_core.v
   wire			iwb_ack_i;		// From wbbus of aeMB_wbbus.v
   wire [ISIZ-1:0]	iwb_adr_o;		// From cpu of aeMB_core.v
   wire [31:0]		iwb_dat_i;		// From wbbus of aeMB_wbbus.v
   wire			iwb_stb_o;		// From cpu of aeMB_core.v
   // End of automatics
   
   aeMB_wbbus #(ASIZ, CSIZ, ISIZ, DSIZ)
     wbbus (/*AUTOINST*/
	    // Outputs
	    .wb_adr_o			(wb_adr_o[ASIZ-1:0]),
	    .wb_dat_o			(wb_dat_o[31:0]),
	    .wb_sel_o			(wb_sel_o[3:0]),
	    .wb_stb_o			(wb_stb_o),
	    .wb_wre_o			(wb_wre_o),
	    .dwb_ack_i			(dwb_ack_i),
	    .dwb_dat_i			(dwb_dat_i[31:0]),
	    .iwb_ack_i			(iwb_ack_i),
	    .iwb_dat_i			(iwb_dat_i[31:0]),
	    // Inputs
	    .wb_dat_i			(wb_dat_i[31:0]),
	    .wb_ack_i			(wb_ack_i),
	    .dwb_adr_o			(dwb_adr_o[DSIZ-1:0]),
	    .dwb_dat_o			(dwb_dat_o[31:0]),
	    .dwb_stb_o			(dwb_stb_o),
	    .dwb_we_o			(dwb_we_o),
	    .iwb_adr_o			(iwb_adr_o[ISIZ-1:0]),
	    .iwb_stb_o			(iwb_stb_o),
	    .sys_clk_i			(sys_clk_i),
	    .sys_rst_i			(sys_rst_i));

   aeMB_core #(ISIZ, DSIZ)
     cpu (/*AUTOINST*/
	  // Outputs
	  .dwb_adr_o			(dwb_adr_o[DSIZ-1:0]),
	  .dwb_dat_o			(dwb_dat_o[31:0]),
	  .dwb_stb_o			(dwb_stb_o),
	  .dwb_we_o			(dwb_we_o),
	  .iwb_adr_o			(iwb_adr_o[ISIZ-1:0]),
	  .iwb_stb_o			(iwb_stb_o),
	  // Inputs
	  .dwb_ack_i			(dwb_ack_i),
	  .dwb_dat_i			(dwb_dat_i[31:0]),
	  .iwb_ack_i			(iwb_ack_i),
	  .iwb_dat_i			(iwb_dat_i[31:0]),
	  .sys_clk_i			(sys_clk_i),
	  .sys_exc_i			(sys_exc_i),
	  .sys_int_i			(sys_int_i),
	  .sys_rst_i			(sys_rst_i));
   
endmodule // aeMB_ucore

//-----------------------------------------------------------------------------
// Title         : Rxaui Rx Glue Logic
// Project       : SIP
//-----------------------------------------------------------------------------
// File          : sip_rxaui_rx_glue.v
// Author        : Lior Valency
// Created       : 19/02/2008 
// Last modified : 19/02/2008 
//-----------------------------------------------------------------------------
// Description : This module receive the data from rxaui fifo and from serdes
// and muxed between them according to media interface.
// It also sample the data receive from fifo in negedge since the data received
// from serdes is at negedge clock.         
//-----------------------------------------------------------------------------
// Copyright (c) 2007  Marvell International Ltd.
//
// THIS CODE CONTAINS CONFIDENTIAL INFORMATION OF MARVELL SEMICONDUCTOR, INC.
// NO RIGHTS ARE GRANTED HEREIN UNDER ANY PATENT, MASK WORK RIGHT OR COPYRIGHT
// OF MARVELL OR ANY THIRD PARTY. MARVELL RESERVES THE RIGHT AT ITS SOLE
// DISCRETION TO REQUEST THAT THIS CODE BE IMMEDIATELY RETURNED TO MARVELL.
// THIS CODE IS PROVIDED "AS IS". MARVELL MAKES NO WARRANTIES, EXPRESS,
// IMPLIED OR OTHERWISE, REGARDING ITS ACCURACY, COMPLETENESS OR PERFORMANCE.
//
//------------------------------------------------------------------------------
// Modification history :
// 12/12/2007  : created
//-----------------------------------------------------------------------------
`timescale 10ps / 10ps

module sip_rxaui_rx_glue (/*AUTOARG*/
   // Outputs
   comma_aligned_en, rxdata_serdes0, rxdata_serdes1,
   // Inputs
   rx_clk0, rx_clk1, media_interface_mode, serdes_mode,
   rxdata_rxaui_lane0, rxdata_rxaui_lane1, serdes_rx_data,
   lane0_sync_ok, lane1_sync_ok
   );

`include "sip_rxaui_params.inc"

   ///////////////
   // INTERFACE //
   ///////////////

   // General
   input                       rx_clk0;
   input                       rx_clk1;

   // Configuration
   input 		       media_interface_mode;
   input 		       serdes_mode;
   
   // Fifo interface
   input [SERDES_DATA_W-1:0]   rxdata_rxaui_lane0;
   input [SERDES_DATA_W-1:0]   rxdata_rxaui_lane1;

   // Comma detect interface
   output 		       comma_aligned_en;
   
   // Serdes interface
   input [SERDES_DATA_W-1:0]   serdes_rx_data;
   
   // XPCS interface
   input 		       lane0_sync_ok;
   input 		       lane1_sync_ok;
   output [SERDES_DATA_W-1:0]  rxdata_serdes0;
   output [SERDES_DATA_W-1:0]  rxdata_serdes1;

   ////////////////////////////////
   // Internal Registers & Wires //
   ////////////////////////////////

   wire [SERDES_DATA_W-1:0]    rxdata_serdes0_d;
   reg [SERDES_DATA_W-1:0]     rxdata_serdes0;
   reg [SERDES_DATA_W-1:0]     rxdata_serdes1;
	
   ///////////
   // Logic //
   ///////////

   // Bypass rxaui logic
   assign rxdata_serdes0_d = ((media_interface_mode == UNSET) && (serdes_mode == UNSET)) ? 
			     serdes_rx_data : rxdata_rxaui_lane0;

   // Only when both lane (xpcs) are synced the comma detect stop
   // searching for comma
   assign comma_aligned_en = ((lane0_sync_ok == SET) && (lane1_sync_ok == SET)) ? UNSET : SET;

   ////////
   // FF //
   ////////

   always @(negedge rx_clk0)
     begin
       rxdata_serdes0     <= #1 rxdata_serdes0_d;
     end
   
   always @(negedge rx_clk1)
     begin
       rxdata_serdes1     <= #1 rxdata_rxaui_lane1;
     end 
   
endmodule // sip_rxaui_rx_glue

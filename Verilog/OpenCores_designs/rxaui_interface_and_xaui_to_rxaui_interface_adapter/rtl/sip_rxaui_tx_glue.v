//-----------------------------------------------------------------------------
// Title         : Rxaui Tx Glue Logic
// Project       : SIP
//-----------------------------------------------------------------------------
// File          : sip_rxaui_tx_glue.v
// Author        : Lior Valency
// Created       : 19/02/2008 
// Last modified : 19/02/2008 
//-----------------------------------------------------------------------------
// Description : This module receive the data from rxaui fifo and from xpcs
// and muxed between them according to media interface.
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

module sip_rxaui_tx_glue (/*AUTOARG*/
   // Outputs
   fifo_type, rxaui_tx_data,
   // Inputs
   media_interface_mode, serdes_mode, fifo_rxaui_tx_data0,
   fifo_rxaui_tx_data1, txdata_serdes0
   );

`include "sip_rxaui_params.inc"

   ///////////////
   // INTERFACE //
   ///////////////

   // Configuration
   input 		       media_interface_mode;
   input 		       serdes_mode;

   // Fifo interface
   input [SERDES_DATA_W-1:0]   fifo_rxaui_tx_data0;
   input [SERDES_DATA_W-1:0]   fifo_rxaui_tx_data1;
   output 		       fifo_type;
   
   // Serdes interface
   output [SERDES_DATA_W-1:0]  rxaui_tx_data;
   
   // XPCS interface
   input [SERDES_DATA_W-1:0]   txdata_serdes0;

   ////////////////////////////////
   // Internal Registers & Wires //
   ////////////////////////////////
	
   ///////////
   // Logic //
   ///////////

   // In case we are working in Rxaui or mode the input
   // data bus is 20bits and output data to serdes is 10bits (double frequency).
   // Fifo should read every line in 2cc.
   assign fifo_type = media_interface_mode | serdes_mode;

   // Bypass rxaui logic
   assign rxaui_tx_data = ((media_interface_mode == UNSET) || (serdes_mode == SET)) ? fifo_rxaui_tx_data0 : 
			  {fifo_rxaui_tx_data1[SERDES_DATA_W/2-1:0],fifo_rxaui_tx_data0[SERDES_DATA_W/2-1:0]};
  
endmodule // sip_rxaui_tx_glue


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  UART Message Handler Top Module                             ////
////                                                              ////
////  This file is part of the uart2spi  cores project            ////
////  http://www.opencores.org/cores/oms8051min/                  ////
////                                                              ////
////  Description                                                 ////
////  top level integration.                                      ////
////    1. uart_core_nf                                           ////
////    2. uart_msg_handler                                       ////
////                                                              ////
////  To Do:                                                      ////
////    nothing                                                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Dinesh Annayya, dinesha@opencores.org                 ////
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

module msg_handler_top (  
        line_reset_n ,
        line_clk ,

      // Towards Register Interface
        reg_addr,
        reg_wr,  
        reg_wdata,
        reg_req,
	reg_ack,
	reg_rdata,


       // Status information
        frm_error      ,
	par_error      ,

	baud_clk_16x,

       // Line Interface
        rxd,
        txd


     );



//---------------------------------
// Global Dec
// ---------------------------------

input        line_reset_n          ; // line reset
input        line_clk              ; // line clock

//--------------------------------------
// ERROR Indication
// -------------------------------------
output        frm_error            ; // framing error
output        par_error            ; // par error

output        baud_clk_16x         ; // 16x Baud clock


//-------------------------------------
// Message Handler Line Interface
// -------------------------------------
input         rxd                  ; // uart rxd
output        txd                  ; // uart txd

//---------------------------------------
// Register Master Interface
// --------------------------------------
output  [15:0]  reg_addr           ; // Register Address
output  [7:0]   reg_wdata          ; // Register Wdata
output          reg_req            ; // Register Request
output          reg_wr             ; // 1 -> write; 0 -> read
input           reg_ack            ; // Register Ack
input  [7:0]    reg_rdata          ;
//--------------------------------------
// UART TXD Path
// -------------------------------------
wire            tx_data_avail      ; // Indicate valid TXD Data 
wire [7:0]      tx_data            ; // TXD Data to be transmited
wire            tx_rd              ; // Indicate TXD Data Been Read


//--------------------------------------
// UART RXD Path
// -------------------------------------
wire         rx_ready              ; // Indicate Ready to accept the Read Data
wire [7:0]  rx_data                ; // RXD Data 
wire        rx_wr                  ; // Valid RXD Data

//-------------------------------------
// Configuration 
// -------------------------------------
wire          cfg_tx_enable        ; // Tx Enable
wire          cfg_rx_enable        ; // Rx Enable
wire          cfg_stop_bit         ; // 0 -> 1 Stop, 1 -> 2 Stop
wire  [1:0]   cfg_pri_mod          ; // priority mode, 0 -> nop, 1 -> Even, 2 -> Odd
wire  [11:0]  cfg_baud_16x         ; // 16x Baud clock generation


//---------------------------------------------------------------
// UART Core without internal FIFO
// --------------------------------------------------------------

assign        cfg_tx_enable  = 1'b1; // Enable Transmit Path
assign        cfg_rx_enable  = 1'b1; // Enable Received Path
assign        cfg_stop_bit   = 1'b1; // 0 -> 1 Start , 1 -> 2 Stop Bits
assign        cfg_pri_mod    = 1'b1; // priority mode, 0 -> nop, 1 -> Even, 2 -> Odd
assign	      cfg_baud_16x   = 'h1;



uart_core_nf u_core (  
          .line_reset_n       (line_reset_n   ),
          .line_clk           (line_clk       ),

	// configuration control
          .cfg_tx_enable      (cfg_tx_enable  ), 
          .cfg_rx_enable      (cfg_rx_enable  ), 
          .cfg_stop_bit       (cfg_stop_bit   ), 
          .cfg_pri_mod        (cfg_pri_mod    ), 
	  .cfg_baud_16x       (cfg_baud_16x   ),

    // TXD Information
          .tx_data_avail      (tx_data_avail  ),
          .tx_rd              (tx_rd          ),
          .tx_data            (tx_data        ),
         

    // RXD Information
          .rx_ready           (rx_ready       ),
          .rx_wr              (rx_wr          ),
          .rx_data            (rx_data        ),

       // Status information
          .frm_error          (frm_error      ),
	  .par_error          (par_error      ),

	  .baud_clk_16x       (baud_clk_16x   ),

       // Line Interface
          .rxd                (rxd            ),
          .txd                (txd            ) 

     );



msg_handler u_msg (  
          .reset_n            (line_reset_n   ),
          .sys_clk            (baud_clk_16x   ),


    // UART-TX Information
          .tx_data_avail      (tx_data_avail  ),
          .tx_rd              (tx_rd          ),
          .tx_data            (tx_data        ),
         

    // UART-RX Information
          .rx_ready           (rx_ready       ),
          .rx_wr              (rx_wr          ),
          .rx_data            (rx_data        ),

      // Towards Control Unit
          .reg_addr           (reg_addr       ),
          .reg_wr             (reg_wr         ),
          .reg_wdata          (reg_wdata      ),
          .reg_req            (reg_req        ),
          .reg_ack            (reg_ack        ),
	  .reg_rdata          (reg_rdata      ) 

     );

endmodule

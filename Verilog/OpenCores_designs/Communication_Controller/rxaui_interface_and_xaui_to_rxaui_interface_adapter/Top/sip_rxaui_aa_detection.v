//-----------------------------------------------------------------------------
// Title         : {/A/,/A/} detection
// Project       : SIP
//-----------------------------------------------------------------------------
// File          : sip_rxaui_aa_detection.v
// Author        : Lior Valency
// Created       : 11/02/2008 
// Last modified : 11/02/2008 
//-----------------------------------------------------------------------------
// Description : The purpose of this block is to detect the {/A/,/A/} pattern
// and according to this pattern send the first /A/ to lane0 and the second /A/
// to lane1.
// It implement <ReceiveFlow> algorithm describe in chapter <2.2.2> in the SPEC.
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

module sip_rxaui_aa_detection(/*AUTOARG*/
   // Outputs
   lane0_rx, lane1_rx, rxaui_status,
   // Inputs
   clk, reset_, serdes_mode, rx_aligned_data, serdes_rx_data
   );

`include "sip_rxaui_params.inc"

   /*AUTO_CONSTANT(MSB_LANE0 or LSB_LANE0)*/

   //////////////////////
   // Local parameters //
   //////////////////////
   parameter DIS_POS_A  = 10'b001100_0011;  // 0xC3
   parameter DIS_NEG_A  = 10'b110011_1100;  // 0x33C
   parameter AA_ERR_CNT_W = 2;
   parameter AA_ERR_CNT_INIT_VALUE = 2'd2;
   parameter DATA_SHIFT_W = 2;
   
   ///////////////
   // INTERFACE //
   ///////////////

   // General
   input                       clk;
   input 	               reset_;

   // Configuration
   input 		       serdes_mode;

   // Comma detect I/F
   input [SERDES_DATA_W-1:0]   rx_aligned_data;

   // Fifo I/F
   output [STD_DATA_W-1:0]     lane0_rx;
   output [STD_DATA_W-1:0]     lane1_rx;

   // Status
   output [STATUS_REG_W-1:0]   rxaui_status;

   // Serdes Interface
   input [SERDES_DATA_W-1:0]   serdes_rx_data;

   ///////////////////////
   // Registers & Wires //
   ///////////////////////

   
   ////////////////////////////////
   // Internal Registers & Wires //
   ////////////////////////////////
   reg [SERDES_DATA_W-1:0]     rx_data_shift_reg[DATA_SHIFT_W-1:0];
   reg [SERDES_DATA_W-1:0]     rx_data_shift_reg_d[DATA_SHIFT_W-1:0];
   wire [2:0] 		       detect_aa;
   wire 		       any_aa_detect;
   reg 			       pre_aa_state;
   wire 		       aa_state_d;
   reg 			       aa_state;
   wire [AA_ERR_CNT_W-1:0]     aa_staet_err_counter_d;
   reg [AA_ERR_CNT_W-1:0]      aa_staet_err_counter;
   wire 		       aa_err_counter_eq_2;
   wire [STATUS_REG_W-1:0]     rxaui_status_d; 
   reg [STATUS_REG_W-1:0]      rxaui_status; 

   integer 		       i;
   
   ///////////
   // Logic //
   ///////////
   
   // Search for {/A/,/A/} pattern in one of the data.
   // Option 1: (The pattern arrive in 1cc)
   // rx_data_align     : | AA | DD |
   // rx_data_align_del1: | XX | AA |
   // detect_aa:          | 0  | 110|    
   // Option 2: (The pattern arrive in 2cc)
   // rx_data_align     : | AX | DA |
   // rx_data_align_del1: | XX | AX |  
   // detect_aa:          | 0  | 101|    
   assign detect_aa[2] = (rx_data_shift_reg[0][SERDES_DATA_W-1:SERDES_DATA_W/2] == DIS_POS_A) | 
			 (rx_data_shift_reg[0][SERDES_DATA_W-1:SERDES_DATA_W/2] == DIS_NEG_A);
   assign detect_aa[1] = (rx_data_shift_reg[0][SERDES_DATA_W/2-1:0] == DIS_POS_A) | 
			 (rx_data_shift_reg[0][SERDES_DATA_W/2-1:0] == DIS_NEG_A);
   assign detect_aa[0] = (rx_aligned_data[SERDES_DATA_W/2-1:0] == DIS_POS_A) | 
			 (rx_aligned_data[SERDES_DATA_W/2-1:0] == DIS_NEG_A);

   // Check if any {/A/,/A/} was detected
   assign any_aa_detect = (detect_aa[0] & detect_aa[2]) | (detect_aa[2] & detect_aa[1]);

   // Define the state of the transmission, LSB or MSB is to lane0.
   always @(/*AUTOSENSE*/aa_state or detect_aa)
     begin
       pre_aa_state = aa_state;
       case(detect_aa[2:0])
	   3'b110:
	     pre_aa_state = LSB_LANE0;
	   3'b101,3'b111:
	     pre_aa_state = MSB_LANE0;
	   default:
	     pre_aa_state = aa_state;
       endcase // case(detect_aa)
     end // always @ (...
  
   // Check if the state of the {/A/,/A/) is change
   assign aa_state_chg = (pre_aa_state != aa_state);
   
   // Error Counter:
   // Count the number of error from the current state  
   assign aa_staet_err_counter_d = (any_aa_detect == SET) ?
				   (((aa_state_chg == UNSET) || 
				     (aa_err_counter_eq_2 == SET)) ? {AA_ERR_CNT_W{1'b0}} :
				    (aa_staet_err_counter + 2'd1)) : aa_staet_err_counter;
   
   // new aa state is latch only after 3 error are detect from the current state
   assign aa_err_counter_eq_2 = (aa_staet_err_counter == 2'd2);
   assign aa_state_d = ((aa_err_counter_eq_2 == SET) && 
			(aa_state_chg == SET)) ? pre_aa_state : aa_state;

   // Split the data to lane0 and lane1
   // In case working in serdes mode (Data from Serdes = 10bits, Data from
   // block 20bits), we need to use the fifo but not comma detect or AA
   // detection
   assign lane0_rx = (serdes_mode == SET) ? serdes_rx_data[SERDES_DATA_W/2-1:0] :
		     (aa_state == LSB_LANE0) ? rx_data_shift_reg[1][SERDES_DATA_W/2-1:0] :
		     rx_data_shift_reg[1][SERDES_DATA_W-1:SERDES_DATA_W/2];
   assign lane1_rx = (serdes_mode == SET) ? serdes_rx_data[SERDES_DATA_W/2-1:0] :
		     (aa_state == MSB_LANE0) ? rx_data_shift_reg[1][SERDES_DATA_W/2-1:0] :
		     rx_data_shift_reg[1][SERDES_DATA_W-1:SERDES_DATA_W/2];

   // Shift register implementation
   always @(rx_data_shift_reg[0] or rx_data_shift_reg[1]/*AUTOSENSE*/
	    or rx_aligned_data) begin
      for(i=0; i < DATA_SHIFT_W; i=i+1)
           if (i==1'b0) begin
              rx_data_shift_reg_d[i] = rx_aligned_data;
           end
           else begin
              rx_data_shift_reg_d[i] = rx_data_shift_reg[i-1];
           end
   end

   /////////////////////
   // Status Register //
   /////////////////////
   
   assign rxaui_status_d = {
			    detect_aa[2:0],                        // 8:6
			    aa_state_chg,                          // 5
			    pre_aa_state,                          // 4
			    any_aa_detect,                         // 3
			    aa_state,                              // 2
			    aa_staet_err_counter[AA_ERR_CNT_W-1:0] // 1:0  
			    };
   

   ////////////////
   // FF SECTION //
   ////////////////

   always @(posedge clk or negedge reset_)
     begin
       if(~reset_)
	 begin
	   for(i=0; i < DATA_SHIFT_W; i=i+1)
	     begin
	       rx_data_shift_reg[i] <= #1 {SERDES_DATA_W{1'b0}};
	     end
	   aa_state              <= #1 LSB_LANE0;
	   rxaui_status          <= #1 {STATUS_REG_W{1'b0}};
	   // The initial value of this is 3 after reset we are not
	   // sync with the correct lane0/lane1 and we want to sync
	   // after the first detection of {/A/,/A/}
	   aa_staet_err_counter  <= #1 AA_ERR_CNT_INIT_VALUE;
	 end
       else
	 begin
	   for(i=0; i < DATA_SHIFT_W; i=i+1)
	     begin
	       rx_data_shift_reg[i] <= #1 rx_data_shift_reg_d[i];
	     end
	   aa_state              <= #1 aa_state_d;
	   aa_staet_err_counter  <= #1 aa_staet_err_counter_d;
	   rxaui_status          <= #1 rxaui_status_d;
	 end
     end // always @ (posedge clk or negedge reset_)
   
endmodule // sip_rxaui_aa_detection

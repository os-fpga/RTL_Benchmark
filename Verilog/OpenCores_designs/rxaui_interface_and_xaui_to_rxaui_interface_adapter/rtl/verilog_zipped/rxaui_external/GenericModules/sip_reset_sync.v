//-----------------------------------------------------------------------------
// Title         : Reset sync
// Project       : SIP
//-----------------------------------------------------------------------------
// File          : sip_reset_sync.v
// Author        : Lior Valency
// Created       : 20/02/2008
// Last modified : 20/02/2008
//-----------------------------------------------------------------------------
// Description : Synchronizes the reset_ input to the clock and provides
//               load_config_ for configuration inputs
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

/////////////////////////////////////////////
//MODULE tg_p_reset_sync
/////////////////////////////////////////////
module sip_reset_sync (/*AUTOARG*/
  // Outputs
  load_config_, reset_out_, reset_chg_, 
  // Inputs
  clk, reset_in_, scan_mode_
  ); //module hi_reset_sync.




  //-------------------------------------------------------------------------
  // Interface (input/output) signals Declaration file
  //-------------------------------------------------------------------------
  input clk;        
  input reset_in_;   // RESET input pin from pad
  input scan_mode_;   // scan mode indication
  output load_config_ ;   // load_enable_ for configuration inputs
  output reset_out_;   // internal reset_ synchronized to clk
  output reset_chg_;   // Change has occured in reset signal
  //-------------------------------------------------------------------------
  // Internal signals Declaration file
  //-------------------------------------------------------------------------
  reg 	 reset_synch1_; // reset_ synchronizer #1
  reg 	 reset_synch2_; // reset_ synchronizer #2
  reg 	 reset_synch3_; // reset_ synchronizer #3
  reg 	 reset_synch4_; // reset_ synchronizer #4
  wire   reset_chg_tmp_;// difference in value of sync2 and sync3
  //-------------------------------------------------------------------------

///////////////////////////////////////////////////////////////////////////
// 
// CASE#1: RESET PIN ASSERTION (going LOW)  (assertion is not synch'ed)
// 	===============================
// 
//                 |        |        |        |        |        |  
//  clk           _/~~~~\___/~~~~\___/~~~~\___/~~~~\___/~~~~\___/~
//                 |        |        |        |        |        |  
// reset_in_      ~~~~~~~\_______________________________________ input pin
//                 |        |        |        |        |        |
// load_config_   ~~~~~~~\________________________________________ sync load_
//                 |        |        |        |        |        |  
// reset_out_     ~~~~~~~\________________________________________ sync reset_
//                 |        |        |        |        |        |
// reset_chg_     ~~~~~~~~~~~~~~~~~~~~\________/~~~~~~~~~~~~~~~~~
//                 |        |        |        |        |        |
// 
//
// CASE#2: RESET PIN DE-ASSERTION (going HIGH) (de-assertion is synch'ed)
// 	==================================
// 
//                 |        |        |        |        |        |  
//  clk           _/~~~~\___/~~~~\___/~~~~\___/~~~~\___/~~~~\___/~
//                 |        |        |        |        |        |  
// reset_in_      _______/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ input pin
//                 |        |        |        |        |        |  
//  ** CASE2.1 early synchronization
//                 |        |        |        |        |        |  
// load_config_   _____________________________/~~~~~~~~~~~~~~~~~~ sync load_
//                 |        |        |        |        |        |  
// reset_out_     ______________________________________/~~~~~~~~~ sync reset_
//                 |        |        |        |        |        |  
//  ** CASE2.2 late synchronization
//                 |        |        |        |        |        |  
// load_config_   ______________________________________/~~~~~~~~~ sync load_
//                 |        |        |        |        |        |  
// reset_out_     _______________________________________________/~ sync reset_
//                 |        |        |        |        |        |
// reset_chg_     ~~~~~~~~~~~~~~~~~~~~\________/~~~~~~~~~~~~~~~~~
//                 |        |        |        |        |        |
// 
//   NOTE: reset_in_ de-assertion is asynchronous, therefore the internal
//         reset signals may be de-asserted "early" or "late" as
//         described above.
//
///////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------
// module BODY
//-------------------------------------------------------------------------

  // bypass syncronizers if scan_mode_ is active (LOW)
  assign load_config_  = (scan_mode_ == 1'b0) ? (reset_in_) :
			 (reset_synch3_ & reset_in_);
  assign reset_out_    = (scan_mode_ == 1'b0) ? (reset_in_) :
			 (reset_synch4_ & reset_in_);

  assign reset_chg_tmp_ = (((reset_synch2_ == 1'b0) && (reset_synch3_ == 1'b1)) ||
			   ((reset_synch2_ == 1'b1) && (reset_synch3_ == 1'b0))) ? 1'b0 : 1'b1;
  
  assign reset_chg_    = (scan_mode_ == 1'b0) ? (reset_in_) :
			 reset_chg_tmp_;
			 

		 

always @ (posedge clk)
  begin
    
    reset_synch1_       <= #1 reset_in_;
    reset_synch2_       <= #1 reset_synch1_;
    reset_synch3_       <= #1 reset_synch2_;
    reset_synch4_       <= #1 reset_synch3_;
    
  end // always @ (posedge clk)

//-------------------------------------------------------------------------
endmodule // sip_reset_sync
//-------------------------------------------------------------------------

// =============================================================================
//  Unpublished work. Copyright 2021 Siemens           
//  This material contains trade secrets or otherwise    
//  confidential information owned by Siemens Industry Software Inc.
//  or its affiliates (collectively, "SISW"), or its licensors.
//  Access to and use of this information is strictly limited as
//  set forth in the Customer's applicable agreements with SISW.
//
//  THIS FILE MAY NOT BE MODIFIED, DISCLOSED, COPIED OR DISTRIBUTED WITHOUT THE
//  EXPRESSED WRITTEN CONSENT OF PRO DESIGN.
//
// =============================================================================
//!  @project      proFPGA
// =============================================================================
//!  @file         profpga_sync_ipad.vh
//!  @author       Dragan Dukaric
//!  @brief        proFPGA clock sync receiver and transmitter modules (Xilinx specific)
// =============================================================================

   // convert LVDS into single-ended logic
   IBUFDS # (
	     .DIFF_TERM    ( "TRUE"    ),
	     .IBUF_LOW_PWR ( "FALSE"   ),
	     .IOSTANDARD   ( "DEFAULT" )
	     ) 
   LVDS_SYNC (
	      .I            ( sync_p_i  ),
	      .IB           ( sync_n_i  ),
	      .O            ( sync_pad  )
	      );

// =============================================================================
// Revision history :
// Version  Date        Description
// -------  ----------  --------------------------------------------------------
// 0.1      2017-12-02  Initial
// =============================================================================
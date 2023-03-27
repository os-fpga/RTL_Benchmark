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
//!  @brief        proFPGA user fpga clock synchronization module (Xilinx specific)
// =============================================================================

  // convert LVDS clock input into logic
  IBUFGDS  # (
    .DIFF_TERM    ( "TRUE"   ),
    .IBUF_LOW_PWR ( "FALSE"  ),
    .IOSTANDARD   ( "DEFAULT")
  ) U_CLK_PAD (
    .I  ( clk_p   ),
    .IB ( clk_n   ),
    .O  ( clk_pad )
  );
  
  assign clk_o = clk_pad;

  generate 
    if (CLK_CORE_COMPENSATION=="DELAYED_XVUS")
      BUFG clk_buf ( .I (clk_pad), .O (clk_bufio) );
    else
      assign clk_bufio = clk_pad;
  endgenerate

// =============================================================================
// Revision history :
// Version  Date        Description
// -------  ----------  --------------------------------------------------------
// 0.1      2017-12-02  Initial
// =============================================================================
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
//!  @file         profpga_clksync.v
//!  @author       Sebastian Fluegel
//!  @brief        proFPGA user fpga clock synchronization module
//!                (Xilinx Virtex-7 implementation)
// =============================================================================
`timescale 1ns/1ps
module profpga_clocksync (
    // access to FPGA pins
    input wire         clk_p,
    input wire         clk_n,
    input wire         sync_p,
    input wire         sync_n,

    // clock from pad
    output wire        clk_o,

    // clock feedback (either clk_o or 1:1 output from MMCM/PLL)
    input wire         clk_i,
    input wire         clk_locked_i,

    // configuration access from profpga_infrastructure
    input  wire        mmi64_clk,
    input  wire        mmi64_reset,
    input  wire [19:0] cfg_dn_i,
    output wire [19:0] cfg_up_o,

    // sync events
    output wire        user_reset_o,
    output wire        user_strobe1_o,
    output wire        user_strobe2_o,
    output wire [7:0]  user_event_id_o,
    output wire        user_event_en_o
  );
  
  parameter CLK_CORE_COMPENSATION = "DELAYED";  // "DELAYED", "ZHOLD", "DELAYED_XVUS"

  // bit index definitions for CFG vector
  //    downstream
  localparam IDX_DN_DATA_LO      = 0;    // clkX_cfg_dn_o[15:0]  cfg_wdata
  localparam IDX_DN_DATA_HI      = 15;
  localparam IDX_DN_ADDR_LO      = 16;   // clkX_cfg_dn_o[17:16] cfg_addr
  localparam IDX_DN_ADDR_HI      = 17;
  localparam IDX_DN_EN           = 18;   // clkX_cfg_dn_o[18]    cfg_en
  localparam IDX_DN_WE           = 19;   // clkX_cfg_dn_o[19]    cfg_we
  //    upstream
  localparam IDX_UP_DATA_LO      = 0;    // clkX_cfg_up_i[15:0]  cfg_rdata
  localparam IDX_UP_DATA_HI      = 15;
  localparam IDX_UP_ACCEPT       = 16;   // clkX_cfg_up_i[16]    cfg_accept
  localparam IDX_UP_RVALID       = 17;   // clkX_cfg_up_i[17]    cfg_rvalid
  localparam IDX_UP_IS_ACM       = 18;   // clkX_cfg_up_i[18]    is_acm (1=profpga_acm, 0=profpga_clocksync)
  localparam IDX_UP_PRESENT      = 19;   // clkX_cfg_up_i[19]    present (1=yes, 0=port unused)

  reg [5:0]       sync_delay_r = 6'b00000;         // sync configuration register (MMI-64 clock domain)
  reg [5:0]       sync_delay_rEXT = 6'b00000;      // sync configuration register (input clock domain)

  reg sync_delay_changing_r        ;
  reg sync_delay_changing_meta_rEXT;
  reg sync_delay_changing_rEXT     ;
  
  reg sync_delay_changed_rEXT      ;
  reg sync_delay_changed_meta_r    ;
  reg sync_delay_changed_r         ;
  reg mmi64_reset_meta             ;
  reg mmi64_reset_sync             ;
  
  wire            reset;
  (* KEEP = "TRUE" *)                   // this signal may be mentioned in the XDC file
  reg [2:0]       reset_rEXT;           // sync receiver reset generator (input clock domain)
  wire            sync_rx2_reset;

  (* KEEP = "TRUE" *)                   // this signal may be mentioned in the XDC file
  wire            clk_pad;              // clock from pad
  wire            clk_bufio;

//-------------------------------------------
// FPGA Vendor dependent primitives/modules
//-------------------------------------------
`include "profpga_clocksync.vh"

//-------------------------------------------
// Generic part of module
//------------------------------------------- 
  
  
  // one-shot resets
  reg one_shot_rst_mmi64_clk = 1'b1;
  reg one_shot_rst_clk_i     = 1'b1;
  always @(posedge mmi64_clk ) one_shot_rst_mmi64_clk <= 1'b0;
  always @(posedge clk_i )     one_shot_rst_clk_i     <= 1'b0;



  // Note: Using external feedback clk_o --> clk_i. This allows sampling of the SYNC signal
  // with a clock signal driven by PLL/MMCM, which simplifies clock synchronization issues.

  // transport sync delay configuration into input clock frequency
  always @ (posedge clk_i or posedge reset_rEXT[0]) begin: SYNC_DELAY_FF
    if (reset_rEXT[0]) begin
      sync_delay_changing_meta_rEXT <= 1'b0;
      sync_delay_changing_rEXT      <= 1'b0;
      sync_delay_changed_rEXT       <= 1'b0;
    end else begin
      sync_delay_changing_meta_rEXT <= sync_delay_changing_r;
      sync_delay_changing_rEXT      <= sync_delay_changing_meta_rEXT;
      sync_delay_changed_rEXT       <= sync_delay_changing_rEXT;
    end
  end // SYNC_DELAY_FF

  always @ (posedge clk_i) begin
    if (one_shot_rst_clk_i) begin
      // Prevent sync_delay value for reset to avoid that sync events
      // gets a skew on multi-motherboard setups after reset is applied 
      // and clock and sync signal training is not executed afterwards.
      sync_delay_rEXT               <= 6'b000000;
    end else begin
      if (sync_delay_changing_rEXT && ~sync_delay_changed_rEXT)
        sync_delay_rEXT  <= sync_delay_r;
    end
  end 

  // synchronize MMI64 reset on clk_i domain
  always @ (posedge clk_i) begin
    mmi64_reset_meta <= mmi64_reset;
    mmi64_reset_sync <= mmi64_reset_meta;
  end
  
  // reset SYNC receiver when MMI-64 reset is active or when user PLL has not locked yet
  assign reset = mmi64_reset_sync || !clk_locked_i;
  assign sync_rx2_reset = !clk_locked_i;
  always @ (posedge reset, posedge clk_i) begin
    if (reset) begin
      reset_rEXT <= 3'b111;
    end else begin
      reset_rEXT <= {1'b0, reset_rEXT[2:1]};
    end
  end

  // sync receiver
  profpga_sync_rx2 # ( .CLK_CORE_COMPENSATION(CLK_CORE_COMPENSATION) )
  U_SYNC_RX (
    .clk_pad         ( clk_bufio       ),
    .clk_core        ( clk_i           ),
    .rst             ( sync_rx2_reset  ),
    .sync_p_i        ( sync_p          ),
    .sync_n_i        ( sync_n          ),
    .sync_delay_i    ( sync_delay_rEXT ),
    .user_reset_o    ( user_reset_o    ),
    .user_strobe1_o  ( user_strobe1_o  ),
    .user_strobe2_o  ( user_strobe2_o  ),
    .event_id_o      ( user_event_id_o ),
    .event_en_o      ( user_event_en_o )
  );

  // configuration register access from profpga_infrastructure
  always @ (posedge mmi64_clk, posedge mmi64_reset) begin
    if (mmi64_reset) begin
      sync_delay_changing_r     <= 1'b0;
      sync_delay_changed_meta_r <= 1'b0;
      sync_delay_changed_r      <= 1'b0;
    end else begin
      sync_delay_changed_meta_r <= sync_delay_changed_rEXT;
      sync_delay_changed_r      <= sync_delay_changed_meta_r;
      
      if  (cfg_dn_i[IDX_DN_EN] && cfg_dn_i[IDX_DN_WE] && cfg_dn_i[IDX_DN_ADDR_HI : IDX_DN_ADDR_LO]==2'b11 
          && ~sync_delay_changing_r && ~sync_delay_changed_r) 
      begin
        sync_delay_changing_r <= 1'b1;
      end else if (sync_delay_changed_r) begin
        sync_delay_changing_r <= 1'b0;
      end
    end
  end

  always @ (posedge mmi64_clk) begin
    if (one_shot_rst_mmi64_clk) begin
      // Prevent sync_delay value for reset to avoid that sync events
      // gets a skew on multi-motherboard setups after reset is applied 
      // and clock and sync signal training is not executed afterwards.
      sync_delay_r              <= 6'b0;
    end else begin
      if  (cfg_dn_i[IDX_DN_EN] && cfg_dn_i[IDX_DN_WE] && cfg_dn_i[IDX_DN_ADDR_HI : IDX_DN_ADDR_LO]==2'b11 
          && ~sync_delay_changing_r && ~sync_delay_changed_r) 
        sync_delay_r <= cfg_dn_i[IDX_DN_DATA_LO+5 : IDX_DN_DATA_LO];
    end
  end

  // configuration read access
  assign cfg_up_o[IDX_UP_DATA_LO+5 : IDX_UP_DATA_LO] = sync_delay_r;
  assign cfg_up_o[IDX_UP_DATA_HI : IDX_UP_DATA_LO+6] = {(IDX_UP_DATA_HI - (IDX_UP_DATA_LO+6) + 1){1'b0}};
  assign cfg_up_o[IDX_UP_ACCEPT]  = ~sync_delay_changing_r & ~sync_delay_changed_r;
  assign cfg_up_o[IDX_UP_RVALID]  = cfg_dn_i[IDX_DN_EN] &  ~cfg_dn_i[IDX_DN_WE];

  // declare who I am
  assign cfg_up_o[IDX_UP_PRESENT] = 1'b1;  // clocksync module is present
  assign cfg_up_o[IDX_UP_IS_ACM]  = 1'b0;  // this is not an ACM module

endmodule

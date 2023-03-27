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
//!  @file         profpga_sync_rx2.v
//!  @brief        proFPGA clock sync receiver and transmitter modules
// =============================================================================

`timescale 1ns/1ps


module profpga_sync_rx2
  (
    input wire         clk_pad,
    input wire         clk_core,
    input wire         rst,
    input wire         sync_p_i,
    input wire         sync_n_i,
    input wire [5:0]   sync_delay_i,  // input delay (for multi-motherboard operations)

    output wire        user_reset_o,
    output wire        user_strobe1_o,
    output wire        user_strobe2_o,
    output reg  [7:0]  event_id_o,
    output reg         event_en_o
  );
  
  parameter CLK_CORE_COMPENSATION = "DELAYED";  // "DELAYED", "ZHOLD", "DELAYED_XVUS"

  // sync pulse:
  //  IDLE:  SYNC = 0
  //  START: SYNC = 1 (provided as event_en)
  //  EVENT: ID[7:0]  (provided as event_id)
  //  STOP:  SYNC = 0

  // masked sync pulse
  //  IDLE:  SYNC = 0
  //  START: SYNC = 1 (provided as event_en)
  //  EVENT: ID[7:0]  (provided as event_id)
  //  STOP:  SYNC = 1
  //  MASK START  = 0
  //  MASK FLAG
  //  MASK ID(5:0)

  // Info:  Mainboard-to-mainboard phase adjust adds some pipeline stages to the SYNC signal.
  //        Delay must be added to those receivers who are closer to the transmitter.
  localparam  MAX_DELAY        = 64; // 2**6;
  localparam  IDX_EVENT_START  = MAX_DELAY + 8 + 1                 + 8;
  localparam  IDX_EVENT_HI     = IDX_EVENT_START - 1;
  localparam  IDX_EVENT_LO     = MAX_DELAY + 1                     + 8;
  localparam  IDX_EVENT_STOP   = MAX_DELAY                         + 8;
  localparam  IDX_MASK_START   = MAX_DELAY - 1                     + 8; 
  localparam  IDX_MASK_FLAG    = MAX_DELAY - 2                     + 8; 
  localparam  IDX_MASK_HI      = MAX_DELAY - 3                     + 8;
  localparam  IDX_MASK_LO      = MAX_DELAY - 8                     + 8;
  //                                                                 ^
  //                                                                 |
  // additional registers came from masked sync event implementation -

  localparam  EVENTID_NULL      = 8'h00;
  localparam  EVENTID_RESET_0   = 8'h02;
  localparam  EVENTID_RESET_1   = 8'h03;
  localparam  EVENTID_STROBE1_0 = 8'h04;
  localparam  EVENTID_STROBE1_1 = 8'h05;
  localparam  EVENTID_STROBE2_0 = 8'h06;
  localparam  EVENTID_STROBE2_1 = 8'h07;

  wire                  sync;
  reg [1:0]             sync_in_r = 2'b00; // some additinal registers to ease routing
  reg [MAX_DELAY+9+8 : 0] sync_fifo_r = {(MAX_DELAY+9+8+1){1'b0}};
  reg                   sync_error_r = 1'b0;
  reg                   sync_mask_r = 1'b0;
  reg [5:0]             sync_mask_id_r = 6'b0;
  reg                   sync_mask_id_set_r = 1'b0;
  reg                   sync_mask_id_match_r = 1'b0;

  reg                   user_reset_r = 1'b1;
  reg                   user_strobe1_r = 1'b0;
  reg                   user_strobe2_r = 1'b0;

  reg                   one_shot_rst = 1'b1;
  reg [5:0]             sync_delay_r;

  always @ (posedge clk_core) one_shot_rst <= 1'b0;  
  always @ (posedge clk_core) sync_delay_r <= sync_delay_i; // Sample delay value with clk_core in order to prevent data from different clock domain in combinatorial logic

  profpga_sync_ipad # (.CLK_CORE_COMPENSATION (CLK_CORE_COMPENSATION) ) 
  IPAD (
    .clk_pad   ( clk_pad  ),
    .clk_core  ( clk_core ),
    .sync_p_i  ( sync_p_i ),
    .sync_n_i  ( sync_n_i ),
    .sync_o    ( sync     )
  );

  always @ (posedge clk_core, posedge rst) begin
    if (rst) 
      sync_in_r <= 2'b00;
    else 
      sync_in_r <= {sync, sync_in_r[1]};
  end

  always @ (posedge clk_core, posedge rst) begin
    if (rst) begin
      sync_fifo_r     <= {(MAX_DELAY+9+8+1){1'b0}};
      user_reset_r    <= 1'b1;
      user_strobe1_r  <= 1'b0;
      user_strobe2_r  <= 1'b0;
      event_en_o <= 1'b0;
      event_id_o <= 8'b00000000;
    end else begin
      event_en_o <= 1'b0;
      event_id_o <= 8'b00000000;

      // shift sync FIFO
      sync_fifo_r <= {sync_fifo_r[MAX_DELAY+8+9-1 : 0], 1'b0};

      // error handling (typically occurs during MB-to-MB clock training)
      //
      // enter error state when EVENT_START=1 and EVENT_STOP=1
      // leave error state after receiving 10x sync=0 in a row
      if (sync_fifo_r[IDX_EVENT_START-1] && sync_fifo_r[IDX_EVENT_STOP-1] && sync_fifo_r[IDX_MASK_START-1]) begin
        sync_fifo_r[IDX_EVENT_START] <= 1'b0;  // suppress event
      end

      // suppress sync events during error state
      if (sync_error_r)
        sync_fifo_r[IDX_EVENT_START] <= 1'b0;
        
      // clear event ID bits after receiving a complete event
      if (sync_fifo_r[IDX_EVENT_START])
        sync_fifo_r[IDX_EVENT_START : IDX_EVENT_LO] <= {(IDX_EVENT_START-IDX_EVENT_LO+1){1'b0}};
 
      // insert sync at current delay
      sync_fifo_r[MAX_DELAY-sync_delay_r-1] <= sync_in_r[0];

     if (sync_fifo_r[IDX_EVENT_START] && sync_mask_r && sync_fifo_r[IDX_MASK_FLAG]) begin

     end else if (sync_fifo_r[IDX_EVENT_START]) begin

        if ( (sync_mask_r == 1'b0)          // regular event
             || (sync_mask_r && sync_mask_id_match_r))  // masked sync event with correct mask ID
        begin
          
          event_en_o  <= sync_fifo_r[IDX_EVENT_START];
          event_id_o  <= sync_fifo_r[IDX_EVENT_HI:IDX_EVENT_LO];
        
           // decode user reset event
           if (   sync_fifo_r[IDX_EVENT_HI : IDX_EVENT_LO]==EVENTID_RESET_0
                  || sync_fifo_r[IDX_EVENT_HI : IDX_EVENT_LO]==EVENTID_RESET_1  )
             begin
                user_reset_r <= sync_fifo_r[IDX_EVENT_LO];
             end
           
           // decode user strobe1 event
           if (   sync_fifo_r[IDX_EVENT_HI : IDX_EVENT_LO]==EVENTID_STROBE1_0
                  || sync_fifo_r[IDX_EVENT_HI : IDX_EVENT_LO]==EVENTID_STROBE1_1  )
             begin
                user_strobe1_r <= sync_fifo_r[IDX_EVENT_LO];
             end
           
           // decode user strobe2 event
           if (   sync_fifo_r[IDX_EVENT_HI : IDX_EVENT_LO]==EVENTID_STROBE2_0
                  || sync_fifo_r[IDX_EVENT_HI : IDX_EVENT_LO]==EVENTID_STROBE2_1  )
             begin
                user_strobe2_r <= sync_fifo_r[IDX_EVENT_LO];
             end

        end
      end
    end
  end

  always @ (posedge clk_core, posedge one_shot_rst) begin
    if (one_shot_rst) begin
      // Prevent for reset these signals to do not loose the mask ID
      sync_error_r    <= 1'b0;
      sync_mask_r     <= 1'b0;
      sync_mask_id_r  <= 6'b000000;
      sync_mask_id_set_r <= 1'b0;
      sync_mask_id_match_r <= 1'b0;
    end else begin

      // error handling (typically occurs during MB-to-MB clock training)
      //
      // enter error state when EVENT_START=1 and EVENT_STOP=1
      // leave error state after receiving 10x sync=0 in a row
      if (sync_fifo_r[IDX_EVENT_START-1] && sync_fifo_r[IDX_EVENT_STOP-1] && sync_fifo_r[IDX_MASK_START-1]) begin
        sync_error_r <= 1'b1;  // enter error state
      end else if (sync_fifo_r[IDX_EVENT_START-1 : IDX_MASK_LO-1]==18'b0) begin
        sync_error_r <= 1'b0;
      end

      // test if there is a masked sync event
      if (sync_fifo_r[IDX_EVENT_START-1] && sync_fifo_r[IDX_EVENT_STOP-1] && !sync_fifo_r[IDX_MASK_START-1])
        sync_mask_r <= 1'b1;
      else
        sync_mask_r <= 1'b0;
      if (sync_mask_id_r == sync_fifo_r[IDX_MASK_HI-1:IDX_MASK_LO-1]) 
        sync_mask_id_match_r <= sync_mask_id_set_r;
      else
        sync_mask_id_match_r <= 1'b0;
      if (sync_mask_r)
        // Once a masked sync event was recognized (and processed) the error mode
        // is enabled to suppress any sync events during shifting out the remaining sync event bits
        sync_error_r <= 1'b1;
      
     if (sync_fifo_r[IDX_EVENT_START] && sync_mask_r && sync_fifo_r[IDX_MASK_FLAG]) begin

        // sync mask ID programming
        if (sync_mask_id_set_r==1'b0) begin
          // only the first program event will be taken; all further will be ignored
          sync_mask_id_r <= sync_fifo_r[IDX_MASK_HI:IDX_MASK_LO];
          sync_mask_id_set_r <= 1'b1;
        end
        
      end
    end
  end

  assign user_reset_o = user_reset_r;
  assign user_strobe1_o = user_strobe1_r;
  assign user_strobe2_o = user_strobe2_r;

endmodule

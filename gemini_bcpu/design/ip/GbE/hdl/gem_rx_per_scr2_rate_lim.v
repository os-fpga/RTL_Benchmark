//------------------------------------------------------------------------------
// Copyright (c) 2016-2017 Cadence Design Systems, Inc.
//
// The information herein (Cadence IP) contains confidential and proprietary
// information of Cadence Design Systems, Inc. Cadence IP may not be modified,
// copied, reproduced, distributed, or disclosed to third parties in any manner,
// medium, or form, in whole or in part, without the prior written consent of
// Cadence Design Systems Inc. Cadence IP is for use by Cadence Design Systems,
// Inc. customers only. Cadence Design Systems, Inc. reserves the right to make
// changes to Cadence IP at any time and without notice.
//------------------------------------------------------------------------------
//
//   Filename:           gem_rx_per_scr2_rate_lim.v
//   Module Name:        gem_rx_per_scr2_rate_lim
//
//   Release Revision:   r1p12
//   Release SVN Tag:    gem_gxl_det0102_r1p12
//
//   IP Name:            GEM Gigabit Ethernet MAC
//   IP Part Number:     IP7014
//
//   Product Type:       Off-the-shelf
//   IP Type:            Soft
//   IP Family:          Ethernet Controller
//   Technology:         N/A
//   Protocol:           Ethernet
//   Architecture:       N/A
//   Licensable IP:      SIP-Ethernet-MAC+DMA+1588+TSN+PCS-10M/100M/1G-IP7014
//
//------------------------------------------------------------------------------
//   Description :      Implements the per scr2 rate limiting feature
//
//------------------------------------------------------------------------------


module gem_rx_per_scr2_rate_lim (

  n_rxreset,
  rx_clk,
  enable_receive_rck,
  frame_length,
  final_eop_push,
  rx_w_eop,
  end_of_frame,
  scr2_match_vec,
  scr2_rate_lim_regs,
  scr2_rate_lim_drop,
  scr_excess_rate

  );

  parameter [1363:0] grouped_params = {1364{1'b0}};
  `include "ungroup_params.v"

  input                                  n_rxreset;          // reset
  input                                  rx_clk;             // clock
  input                                  enable_receive_rck; // soft reset
  input                           [13:0] frame_length;       // frame length
  input                                  final_eop_push;     // early version of rx_w_eop
  input                                  rx_w_eop;           // end of packet strobe at fifo if
  input                                  end_of_frame;       // sampling point for scr2_match_vec
  input                           [15:0] scr2_match_vec;     // type 2 screener matching vector
  input [(32*p_num_type2_screeners)-1:0] scr2_rate_lim_regs; // type 2 screener rate limiting registers
  output                                 scr2_rate_lim_drop; // drop signal to gem_rx
  output       [p_num_type2_screeners:0] scr_excess_rate;    // Output for statistic registers

  // -----------------------------------------------------------------------------
  // Wire and registers declaration
  // -----------------------------------------------------------------------------
  reg                          [5:0] count_64;
  reg                         [15:0] scr2_match_vec_hold;
  wire [(p_num_type2_screeners)-1:0] scr_rate_lim_drop_vec;

  // -----------------------------------------------------------------------------
  // Start of the Hardware Description
  // -----------------------------------------------------------------------------

  // Holding the scr2_match_vec until we sample
  // the frame length
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      scr2_match_vec_hold <= 16'd0;
    else
      begin
        if(~enable_receive_rck)
          scr2_match_vec_hold <= 16'd0;
        else
          begin
            if(end_of_frame)
              scr2_match_vec_hold <= scr2_match_vec;
            else if(rx_w_eop)
              scr2_match_vec_hold <= 16'd0;
          end
      end
  end

  // This will count 64 clock cycles
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      count_64 <= 6'd0;
    else
      begin
        if(~enable_receive_rck)
          count_64 <= 6'd0;
        else
          count_64 <= count_64 + 6'd1;
      end
  end

  genvar k;
  generate for(k=0; k<p_num_type2_screeners; k=k+1)
  begin: gen_rate_val_scr2
    wire [15:0] max_rate_val;
    wire [15:0] interval_time;
    wire [15:0] rate_val_next;
    wire [16:0] rate_val_incr;
    reg  [15:0] no_64_cycles;
    reg  [15:0] rate_val;
    reg         drop_hold;
    wire        update_rate_val;
    wire        time_window_end;
    wire        limiter_triggered; // Has the frame breached the limit right now?
    wire        limiter_active;    // Has the interval time passed with rate_val over the limit?

    always @ (posedge rx_clk or negedge n_rxreset)
    begin
      if(~n_rxreset)
        begin
          drop_hold    <= 1'b0;
          no_64_cycles <= 16'd0;
          rate_val     <= 16'd0;
        end
      else
        begin
          if(~enable_receive_rck)
            begin
              drop_hold     <= 1'b0;
              no_64_cycles  <= 16'd0;
              rate_val      <= 16'd0;
            end
          else
            begin
              // if the rate_value is over the limit
              // when crossing the end of a time window
              // then error all the frames received
              // during the entire window.
              if(time_window_end)
                begin
                  if(rate_val > max_rate_val)
                    drop_hold <= 1'b1;
                  else
                    drop_hold <= limiter_triggered;
                end

              // The rate value is reset each time_window_end
              // and incremented on the final_eop_push.
              // Note: the implementation prevents the rate_val
              // counter to wrap around, look at rate_val_next assignment
              if(time_window_end)
                rate_val <= 16'd0;
              else if(update_rate_val)
                rate_val <= rate_val_next;

              // The count of the number of 64 clock cycles
              // is reset every time_window_end as well
              if(time_window_end)
                no_64_cycles <= 16'd0;
              else if(&count_64)
                no_64_cycles <= no_64_cycles + 16'd1;

            end
        end
    end

    assign limiter_triggered         = (rate_val_next > max_rate_val) && update_rate_val;
    assign limiter_active            = (drop_hold && update_rate_val);
    assign max_rate_val              = scr2_rate_lim_regs[(32*k)+31:(32*k)+16];
    assign interval_time             = scr2_rate_lim_regs[(32*k)+15:(32*k)];
    assign time_window_end           = (no_64_cycles == interval_time);
    assign rate_val_incr             = rate_val + frame_length;
    assign rate_val_next             = (rate_val_incr[15:0] > rate_val)? rate_val_incr[15:0]: rate_val;
    assign update_rate_val           = (final_eop_push && scr2_match_vec_hold[k]);
    assign scr_rate_lim_drop_vec[k]  = (limiter_triggered || limiter_active) && scr2_match_vec_hold[k] && (interval_time != 16'd0);

    edma_toggle_generate i_scr_excess_rate_toggle_gen (
      .clk      (rx_clk),
      .reset_n  (n_rxreset),
      .din      (scr_rate_lim_drop_vec[k]),
      .dout     (scr_excess_rate[k])
    );

  end
  endgenerate

  assign scr_excess_rate[p_num_type2_screeners] = 1'b0; // the MSB is just always zero in case p_num_type2_screener = 0
  assign scr2_rate_lim_drop = |scr_rate_lim_drop_vec;

endmodule

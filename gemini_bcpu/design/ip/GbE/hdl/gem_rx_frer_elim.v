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
//   Filename:           gem_rx_frer_elim.v
//   Module Name:        gem_rx_frer_elim
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
//   Description    : Module to implement the 802.1CB FRER elimination function.
//                    This module will assert a signal at the end of the frame
//                    to indicate whether this frame should be discarded or not.
//                    The discard is handled by the gem_rx module by signalling
//                    rx_w_err to the FIFO interface.
//
//                    For each frame, the following steps are used:
//                    1. Check if frame has matched assigned StreamID for this
//                      instance. If not, then this module will not do anything.
//                    2. Obtain sequence number either from the frer_rtag_seqnum
//                      input or extracted from the frame based on the static
//                      configuration signal frer_seq_num_offset.
//                    3. Determine whether to discard frame based on Match or
//                      Vector Recovery algorithm as described in IEEE 802.1CB
//                      d2-4, June 2016 specification.
//                    4. Update internal variables on good end of packet.
//
//------------------------------------------------------------------------------


module gem_rx_frer_elim (

  input               rx_clk,           // MAC Receive datapath clock
  input               n_rxreset,        // Async reset for above

  // Static configuration signals
  input       [15:0]  frer_to_cnt,      // Count of number of frer_to_cnt_tog
                                        // without passing frames before timeout
  input               frer_en_vec_alg,  // Select which algorithm to use.
  input               frer_use_rtag,    // Set to use RTag or offset for seqnum
  input       [8:0]   frer_seqnum_oset, // Offset into frame for seqnum
  input       [4:0]   frer_seqnum_len,  // Number of bits of seqnum to use
  input       [3:0]   frer_scr_sel_1,   // Screener match for stream 1
  input       [3:0]   frer_scr_sel_2,   // Screener match for stream 2
  input       [5:0]   frer_vec_win_sz,  // History depth to use for vec rcv alg

  // Dynamic signals
  input               enable_receive,   // rx_clk domain receive enable
  input               bad_frame,        // Frame had errors
  input               frame_matched_pipe, // Filter matched
  input               rx_end_frame,     // EOP sent on FIFO interface
  input       [15:0]  scr2_match_vec,   // Match bits from screeners. Max 16.
  input       [7:0]   frer_oset_cnt,    // Counter from SOF
  input       [15:0]  frer_rtag_seqnum, // Sequence number from RTag
  input               frer_rtag_seqnum_val,
  input               new_pipeline_data,// New data available from pipeline
  input       [19:0]  pipeline_output,  // Output from RX pipeline
  input               frer_en_elim_sync,// Enable this elimination function
  input               frer_en_to_sync,  // Enable timeout mechanism
  input               frer_to_cnt_tog,  // Toggle every 8K rx_clk cycles
  input               frer_32_cnt_tog,  // Toggle every 32 rx_clk cycles
  output  reg         frer_to_tog,      // Toggle to indicate timeout occurred
  output  reg         frer_rogue_tog,   // Toggle to indicate rogue frame rcvd
  output  reg         frer_ooo_tog,     // Toggle to indicate out of order frame
  output  reg         frer_err_upd_tog, // Toggle to enable update latent errors
  output  reg [6:0]   frer_err_upd_val, // Incrememt value, use with above

  output  reg         frer_discard      // Signal that frame should be discarded

);

  parameter       p_hist_depth      = 8'd64;   // Maximum history depth to support
  parameter       p_hist_depth_m1   = p_hist_depth - 8'd1;
  parameter       p_hist_depth_m2   = p_hist_depth - 8'd2;
  parameter [7:0] p_oldest          = p_hist_depth_m1[7:0];
  parameter [7:0] p_n_oldest        = (p_hist_depth_m1 > 8'd1)  ? p_hist_depth_m2[7:0]
                                                                : p_hist_depth_m1[7:0];

  // Internal signals
  wire          frer_to_cnt_edge; // Edge detect toggles
  wire          frer_32_cnt_edge; // Edge detect toggles
  wire          update_enable;    // Update internal state.
  wire  [15:0]  seq_num_mux;      // Selected sequence number
  wire          seq_num_val_mux;  // and valid signal.
  wire  [15:0]  seq_num_masked;   // Masked with seqnum_mask
  reg   [15:0]  seqnum_mask;      // Mask to use for sequence number
  reg   [15:0]  oset_seqnum;      // Sequence number from oset lookup
  reg           oset_seqnum_val;  // oset_seqnum is valid
  reg           oset_byte_cnt;    // Used for building oset_seqnum
  reg           take_any;         // Take whatever comes in initially
  reg   [15:0]  highest_seqnum;   // Highest sequence number stored
  wire  [15:0]  delta_ahead;      // How far ahead is new seqnum
  wire  [15:0]  delta_behind;     // How far behind is new seqnum
  wire          seq_ahead;        // New seq num is ahead of highest
  wire          seq_behind;       // New seq num is behind highest
  wire          in_window;        // Within selected window
  reg   [6:0]   vec_winsize;      // Qualified window size to use for vec alg
  reg   [6:0]   err_accum;        // Accumulator for latent errors.
  wire  [7:0]   err_accum_sum;    // Calculation for lint

  reg   [p_hist_depth-1:0]  hist_vec_seen;  // History of 'seen' bits.
  wire  [256:0]             hist_vec_seen_pad;  // History of 'seen' bits.
  reg   [p_hist_depth-1:0]  hist_vec_dup;   // and of 'duplicates seen' bits.

  reg           hist_match_dup;   // Match recovery algorithm, duplicate seen.
  reg   [6:0]   num_hist_shift;   // Number of shifts remaining in history vec
  wire  [6:0]   num_hist_shift_m2;// Minus 2

  reg   [1:0]   inc_err_value;    // Increment value to use for latent errors

  reg   [15:0]  to_timer;         // Timer for timeout.
  wire  [15:0]  to_timer_m1;      // Minus 1.
  reg           preload_timer;    // Load timer next cycle for initial start
  wire          to_zero;          // Timeout condition

  wire  [7:0]   hist_depth_def;   // History depth from define.

  // Create the shifted versions to get round compilation issues when value
  // of p_hist_depth is small
  wire  [p_hist_depth:0]    hist_vec_seen_s1; // Shifted 1
  wire  [p_hist_depth+1:0]  hist_vec_seen_s2; // Shifted 2
  wire  [p_hist_depth:0]    hist_vec_dup_s1;  // Shifted 1
  wire  [p_hist_depth+1:0]  hist_vec_dup_s2;  // Shifted 2
  wire  [p_hist_depth:0]    hist_vec_seen_s1_p1; // With bit 0 set to 1.
  wire  [p_hist_depth+1:0]  hist_vec_seen_s2_p1; //
  wire                      stream_matched;

  integer loop_j; // Simple loop variable
  integer int_a;

  // Assign p_hist_depth to a wire for bit manipulation later
  assign hist_depth_def = p_hist_depth;


  // Toggle detects
  edma_toggle_detect i_tog_to_cnt (
    .clk      (rx_clk),
    .reset_n  (n_rxreset),
    .din      (frer_to_cnt_tog),
    .rise_edge(),
    .fall_edge(),
    .any_edge (frer_to_cnt_edge)
  );
  edma_toggle_detect i_tog_32_cnt (
    .clk      (rx_clk),
    .reset_n  (n_rxreset),
    .din      (frer_32_cnt_tog),
    .rise_edge(),
    .fall_edge(),
    .any_edge (frer_32_cnt_edge)
  );


  // First look up the scr2_match_vec to see if matched. This vector should be
  // padded up to the maximum supported 16 screener 2 registers.
  assign stream_matched = scr2_match_vec[frer_scr_sel_1] |
                          scr2_match_vec[frer_scr_sel_2];


  // Lookup sequence number from within the frame
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
    begin
      oset_seqnum     <= 16'h0000;
      oset_seqnum_val <= 1'b0;
      oset_byte_cnt   <= 1'b0;
    end
    else
      // Clear down signals when RX disabled or at the end of the current frame.
      if (~enable_receive | ~frer_en_elim_sync | rx_end_frame)
      begin
        oset_seqnum     <= 16'h0000;
        oset_seqnum_val <= 1'b0;
        oset_byte_cnt   <= 1'b0;
      end
      else
        if (new_pipeline_data)
        begin
          // Stored odd number of bytes last cycle and still missing some.
          // Simple here as we are 16-bits which means must be missing 1 byte...
          if (oset_byte_cnt & ~oset_seqnum_val)
          begin
            oset_seqnum[7:0]  <= pipeline_output[7:0];
            oset_seqnum_val   <= 1'b1;
          end
          else
            // Check reached first cycle to store. Note that cycle count denotes
            // 2-byte cycles and idx is in bytes hence the offsetting...
            if (frer_oset_cnt[7:0] == frer_seqnum_oset[8:1])
            begin
              // If we are odd offset, then capture the rest next cycle
              // Note that the MSB of the sequence number is sent down the line
              // first as per normal Ethernet ordering...
              if (frer_seqnum_oset[0])
              begin
                oset_seqnum[15:8] <= pipeline_output[15:8];
                oset_byte_cnt     <= 1'b1;
              end
              else
              begin
                oset_seqnum     <= {pipeline_output[7:0],pipeline_output[15:8]};
                oset_seqnum_val <= 1'b1;
              end
            end
        end

  end


  // Select to use either the sequence number from RTag or above lookup
  assign seq_num_mux      = frer_use_rtag ? frer_rtag_seqnum
                                          : oset_seqnum;
  assign seq_num_val_mux  = frer_use_rtag ? frer_rtag_seqnum_val
                                          : oset_seqnum_val;


  // The frer_seqnum_len is used to set the number of bits of the sequence
  // number to use. This just sets a 16-bit mask. If the number of bits is
  // greater than 16, the full 16-bits is used.
  always@(*)
  begin
    if (~enable_receive | ~frer_en_elim_sync)
      seqnum_mask = 16'h0000;
    else
      if (frer_seqnum_len == 5'd0)
        seqnum_mask = 16'hffff;
      else
        for (loop_j = 0; loop_j < 16; loop_j=loop_j+1)
        begin
          if (frer_seqnum_len > loop_j[4:0])
            seqnum_mask[loop_j] = 1'b1;
          else
            seqnum_mask[loop_j] = 1'b0;
        end
  end

  // Apply mask...
  assign seq_num_masked = seq_num_mux & seqnum_mask;

  // Qualify the frer_vec_win_sz setting with actual available size...
  always@(*)
  begin
    if ((frer_vec_win_sz == 6'd0) || ({2'b00,frer_vec_win_sz} > hist_depth_def))
      vec_winsize = hist_depth_def[6:0];
    else
      vec_winsize = {1'b0,frer_vec_win_sz[5:0]};
  end

  // Calculate difference between new sequence number and previouly stored.
  // Also check if within defined window.
  assign delta_behind = (highest_seqnum - seq_num_masked) & seqnum_mask;
  assign delta_ahead  = (seq_num_masked - highest_seqnum) & seqnum_mask;
  assign seq_ahead    = (delta_ahead  <= {9'd0,vec_winsize});
  assign seq_behind   = (delta_behind < {9'd0,vec_winsize});
  assign in_window    = seq_ahead | seq_behind;

  // The take_any variable is used initially to bypass validation of the checks
  // so that the sequence number is updated with the first frame.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      take_any  <= 1'b1;
    else
      if (~enable_receive | ~frer_en_elim_sync | to_zero)
        take_any  <= 1'b1;
      else
        if (update_enable)
          take_any  <= 1'b0;
  end


  // Update the highest_seqnum with what's came in...
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      highest_seqnum  <= 16'hffff;
    else
      if (~enable_receive | ~frer_en_elim_sync | to_zero)
        highest_seqnum  <= 16'hffff;
      else
        if (update_enable)
        begin
          if (take_any | ~frer_en_vec_alg)
            highest_seqnum  <= seq_num_masked;
          else
            if (seq_ahead)
              highest_seqnum  <= seq_num_masked;
        end
  end


  // When match recovery algorithm is used, we keep track of whether a duplicate
  // has been seen for the highest_seqnum, this is used for updating the latent
  // errors statistics.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      hist_match_dup  <= 1'b0;
    else
      if (~enable_receive | ~frer_en_elim_sync | frer_en_vec_alg |
          take_any | to_zero)
        hist_match_dup  <= 1'b0;
      else
        if (update_enable)
        begin
          if (highest_seqnum == seq_num_masked)
            hist_match_dup  <= 1'b1;
          else
            hist_match_dup  <= 1'b0;
        end
  end


  // When it is time to update at end of good frame, determine the number of
  // shifts of the history vectors will be needed.
  // This is only relevant when in Vector Recovery Algorithm mode.
  // The number of shifts is updated the cycle after the update and on each
  // cycle, the vectors will shift up to 2 locations. When the value is 0, no
  // shifts will be performed.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      num_hist_shift  <= 7'd0;
    else
      if (~enable_receive | ~frer_en_elim_sync | ~frer_en_vec_alg |
          take_any | to_zero)
        num_hist_shift  <= 7'd0;
      else
        if (update_enable & seq_ahead)
          num_hist_shift  <= delta_ahead[6:0];
        else
          if (num_hist_shift > 7'd1)
            num_hist_shift  <= num_hist_shift_m2[6:0];
          else
            num_hist_shift  <= 7'd0;
  end
  assign num_hist_shift_m2  = num_hist_shift - 7'd2;

  // Based on similar principles we can update the 'rogue' frame status.
  // This is just a toggle signal which updates whenever a frame is received
  // with a sequence number outwith the defined window in Vector Recovery mode.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      frer_rogue_tog  <= 1'b0;
    else
      if (enable_receive & frer_en_elim_sync)
      begin
        if (frer_en_vec_alg & ~take_any & update_enable & ~in_window)
          frer_rogue_tog  <= ~frer_rogue_tog;
      end
  end

  // For the out of order stats, this is updated whenever the new sequence
  // number doesn't directly follow the previous.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      frer_ooo_tog  <= 1'b0;
    else
      if (enable_receive & frer_en_elim_sync)
      begin
        if (~take_any & update_enable & (~frer_en_vec_alg |
            (frer_en_vec_alg & in_window)))
        begin
          if ((delta_ahead > 16'd1) & ~frer_discard)
            frer_ooo_tog  <= ~frer_ooo_tog;
        end
      end
  end


  // Create shifted versions of the histor vectors...
  assign hist_vec_seen_s1 = hist_vec_seen << 1;
  assign hist_vec_seen_s2 = hist_vec_seen << 2;
  assign hist_vec_dup_s1  = hist_vec_dup  << 1;
  assign hist_vec_dup_s2  = hist_vec_dup  << 2;

  // Set bit 0 of the 'seen' vectors
  assign hist_vec_seen_s1_p1  = {hist_vec_seen_s1[p_hist_depth:1],1'b1};
  assign hist_vec_seen_s2_p1  = {hist_vec_seen_s2[p_hist_depth+1:1],1'b1};

  // Update history vectors if in Vector Recovery Mode.
  // If take_any is set, then [0] is set as it represents the most recent.
  // otherwise if num_hist_shift is > 2, shift the vectors.
  // If num_hist_shift is 2, then shift once, then push 1'b1 in.
  // If num_hist_shift is 1, then push 1'b1 in.
  // otherwise if seq_behind, mark relevant bits of the vector.
  // Note that if it matches the previous sequence number, then [0] would end
  // up getting set even though both seq_ahead and seq_behind are set.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
    begin
      hist_vec_seen <= {p_hist_depth{1'b0}};
      hist_vec_dup  <= {p_hist_depth{1'b0}};
    end
    else
      if (~enable_receive | ~frer_en_elim_sync | to_zero)
      begin
        hist_vec_seen <= {p_hist_depth{1'b0}};
        hist_vec_dup  <= {p_hist_depth{1'b0}};
      end
      else
        if (update_enable & take_any)
          hist_vec_seen[0]  <= 1'b1;
        else
          if (num_hist_shift > 7'd2)
          begin
            hist_vec_seen <= hist_vec_seen_s2[p_hist_depth-1:0];
            hist_vec_dup  <= hist_vec_dup_s2[p_hist_depth-1:0];
          end
          else
            if (num_hist_shift == 7'd2)
            begin
              hist_vec_seen <= hist_vec_seen_s2_p1[p_hist_depth-1:0];
              hist_vec_dup  <= hist_vec_dup_s2[p_hist_depth-1:0];
            end
            else
              if (num_hist_shift == 7'd1)
              begin
                hist_vec_seen <= hist_vec_seen_s1_p1[p_hist_depth-1:0];
                hist_vec_dup  <= hist_vec_dup_s1[p_hist_depth-1:0];
              end
              else
                if (seq_behind & update_enable)
                begin
                  for (int_a = 0;int_a < p_hist_depth[7:0];int_a = int_a + 1)
                  begin
                    if (int_a[7:0] == delta_behind[7:0])
                    begin
                      hist_vec_seen[int_a] <= 1'b1;
                      hist_vec_dup[int_a]  <= hist_vec_seen[int_a];
                    end
                  end
                end
  end
  assign hist_vec_seen_pad = {{(257-p_hist_depth){1'b0}},hist_vec_seen};

  // The oldest locations are monitored for latent errors and the accumulator
  // is incremented when a shift occurs.
  // Increment based on seen duplicate such that if seen and no
  // duplicate then increment latent errors.
  always@(*)
  begin
    if (num_hist_shift > 7'd0)
    begin
      if (num_hist_shift == 7'd1)
        inc_err_value = {1'b0,hist_vec_seen[p_oldest] & ~hist_vec_dup[p_oldest]};
      else
        inc_err_value = {1'b0,hist_vec_seen[p_oldest] & ~hist_vec_dup[p_oldest]} +
                        {1'b0,hist_vec_seen[p_n_oldest] & ~hist_vec_dup[p_n_oldest]};
    end
    else
      inc_err_value = 2'b00;
  end

  // Accumulate latent errors as the vector is shifted.
  // The result is transferred to frer_err_upd_val periodically every 32
  // clock cycles so we should never get an overflow of this counter.
  // The accumulator is not used when in Match Recovery mode since
  // an error is only signalled once per frame.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      err_accum       <= 7'd0;
    else
      if (~enable_receive | ~frer_en_elim_sync | take_any)
        err_accum       <= 7'd0;
      else
        if (frer_en_vec_alg)
        begin
          if (frer_32_cnt_edge)
            err_accum <= {5'd0,inc_err_value};
          else
            err_accum <= err_accum_sum[6:0];
        end
        else
          err_accum       <= 7'd0;
  end
  assign err_accum_sum  = err_accum + {5'd0,inc_err_value};

  // Update the status to the stats block
  // Note that when in Match Recovery mode, we don't need to
  // wait for the 32 cycle counter since the error is only
  // signalled once per frame anyway.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
    begin
      frer_err_upd_tog  <= 1'b0;
      frer_err_upd_val  <= 7'd0;
    end
    else
      if (enable_receive & frer_en_elim_sync)
      begin
        if (~frer_en_vec_alg & update_enable &&
            (highest_seqnum != seq_num_masked) &&
              ~hist_match_dup && ~take_any)
        begin
          frer_err_upd_tog  <= ~frer_err_upd_tog;
          frer_err_upd_val  <= 7'd1;
        end
        else
          if (frer_en_vec_alg & frer_32_cnt_edge & (|err_accum))
          begin
            frer_err_upd_tog  <= ~frer_err_upd_tog;
            frer_err_upd_val  <= err_accum;
          end
      end
  end

  // Determine whether packet should be discarded...
  // If Match Recovery, then just discard if it matches the previous stored
  // sequence number.
  // If Vector Recovery, discard if it has been seen before or if it is not
  // within the defined history window.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      frer_discard         <= 1'b0;
    else
      // Clear down signals when RX disabled or at the end of the current frame.
      if (~enable_receive | ~frer_en_elim_sync | update_enable
          | take_any | ~seq_num_val_mux | to_zero | ~stream_matched)
        frer_discard         <= 1'b0;
      else
        if (frer_en_vec_alg)
        begin
          if (~in_window | (seq_behind & hist_vec_seen_pad[delta_behind[7:0]]))
            frer_discard  <= 1'b1;
          else
            frer_discard  <= 1'b0;
        end
        else
          if (highest_seqnum == seq_num_masked)
            frer_discard  <= 1'b1;
          else
            frer_discard  <= 1'b0;
  end


  // The timeout mechanism is reset on update_enable if frer_discard is not
  // set, i.e. this function has matched and decided that frame should be
  // passed up the stack.
  // At other times, the timer decrements until it reaches 0 at which point a
  // timeout is triggered.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
    begin
      frer_to_tog   <= 1'b0;
      to_timer      <= {16{1'b1}};
      preload_timer <= 1'b0;
    end
    else
      if (~enable_receive | ~frer_en_elim_sync | ~frer_en_to_sync)
      begin
        to_timer      <= {16{1'b1}};
        preload_timer <= 1'b1;
      end
      else
        if (preload_timer)
        begin
          to_timer      <= frer_to_cnt;
          preload_timer <= 1'b0;
        end
        else
          if (to_zero | (update_enable & ~frer_discard))
          begin
            to_timer    <= frer_to_cnt;
            frer_to_tog <= to_zero ^ frer_to_tog;
          end
          else
            if (frer_to_cnt_edge)
              to_timer    <= to_timer_m1[15:0];
  end
  assign to_timer_m1  = to_timer - 16'd1;

  // Timeout condition. Note that it is also qualified with the frer_to_cnt
  // value so that if it has not been sent properly then timeout will not
  // occur and the timer will stay at 0.
  assign to_zero  = (to_timer == 16'd0) && frer_en_to_sync && (frer_to_cnt != 16'd0);


  // The internal state of this module is updated only when the stream matches
  // the selection for this module and the frame itself is good.
  // The update occurs at the end of the frame where the frer_discard and other
  // frame signals are evaluated.
  assign update_enable  = stream_matched & frame_matched_pipe & seq_num_val_mux &
                          ~bad_frame & rx_end_frame;


endmodule

//------------------------------------------------------------------------------
// Copyright (c) 2002-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_fifo.v
//   Module Name:        gem_fifo
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
//   Description :       A fifo with parameterisable depth and width to
//                       support 128, 64 or 32 bit access. Two clock
//                       domains are present in the fifo and access is
//                       controlled using read and write pointers.
//
//------------------------------------------------------------------------------


module gem_fifo (

   // w_clk domain signals.
   w_clk,
   w_rst_n,
   w_wr,
   w_data,
   w_eop,
   w_sop,
   w_mod,
   w_err,
   w_flush,
   w_control,
   w_overflow,
   w_fifo_count,
   w_flushing,

   // r_clk domain signals.
   r_clk,
   r_rst_n,
   r_rd,
   r_valid,
   r_data,
   r_eop,
   r_sop,
   r_mod,
   r_err,
   r_flushed,
   r_underflow,
   r_fifo_count,
   r_pkt_comp,
   r_control

   );

   parameter DEPTH = 32'd10;         // default depth overwritten when instanced.
   parameter WIDTH = 32'd128;        // default width overwritten when instanced.
   parameter CNT_WIDTH = 32'd4;      // fifo counter width (overwritten when inst.)
   parameter BASE2_DEPTH = 4'ha; // depth in base-2 (overwritten when inst.)


   // declare port inputs and outputs.

   // w_clk domain.
   input          w_clk;               // write clock input.
   input          w_rst_n;             // write reset input.
   input          w_wr;                // push data into fifo.
   input  [(WIDTH - 1): 0]             //
                  w_data;              // fifo data input.
   input          w_eop;               // last word of packet pushed into fifo.
   input          w_sop;               // first word of packet pushed into fifo.
   input    [3:0] w_mod;               // number of valid bytes when w_eop is
                                       // present.
   input          w_err;               // insert error into datastream.
   input          w_flush;             // flush (wipe) contents of fifo.
   input          w_control;           // packet control information
   output         w_overflow;          // fifo overrun.
   output [(CNT_WIDTH - 1):0]          //
                  w_fifo_count;        // current write ptr position.
   output         w_flushing;          // FIFO is still flushing


   // r_clk domain.
   input          r_clk;               // read clock input.
   input          r_rst_n;             // read reset input.
   input          r_rd;                // pop data from fifo.
   output         r_valid;             // validates the r_data, r_eop,
                                       // r_sop and r_mod signals.
   output  [(WIDTH - 1):0]             //
                  r_data;              // fifo data output.
   output         r_eop;               // last word of packet is
                                       // popped out of the fifo.
   output         r_sop;               // first word of packet is
                                       // popped out of the fifo.
   output   [3:0] r_mod;               // number of valid bytes when
                                       // r_eop is detected.
   output         r_err;               // inset error into datastream
   output         r_flushed;           // flushed signal passed to gem_tx to
                                       // aid underrun/col recovery
   output         r_underflow;         // fifo underrun.
   output [(CNT_WIDTH - 1):0]          //
                  r_fifo_count;        // current write ptr position.
   output         r_pkt_comp;          // indicates complete packet in
                                       // fifo.
   output         r_control;           // packet control information

   // internal regs and wires.

   // fifo declaration.
   wire [CNT_WIDTH-1:0]  fifo_depth;                   // FIFO depth in base-2.
   reg  [(WIDTH - 1):0]  fifo_data_h [(DEPTH - 1): 0]; // store for w_data.
   reg  [(DEPTH - 1):0]  fifo_eop;                     // store for w_eop.
   reg  [(DEPTH - 1):0]  fifo_sop;                     // store for w_sop.
   reg  [(DEPTH - 1):0]  fifo_err;                     // store for w_err.
   reg  [(DEPTH - 1):0]  fifo_control;                 // store for w_control.
   reg  [3:0]            fifo_mod [(DEPTH - 1): 0];    // store for w_mod.

   wire [(WIDTH - 1):0]         fifo_data_h_pad [(2**CNT_WIDTH - 1): 0]; // store for w_data.
   wire [(2**CNT_WIDTH - 1):0]  fifo_eop_pad;                     // store for w_eop.
   wire [(2**CNT_WIDTH - 1):0]  fifo_sop_pad;                     // store for w_sop.
   wire [(2**CNT_WIDTH - 1):0]  fifo_err_pad;                     // store for w_err.
   wire [(2**CNT_WIDTH - 1):0]  fifo_control_pad;                 // store for w_control.
   wire [3:0]                   fifo_mod_pad [(2**CNT_WIDTH - 1): 0];    // store for w_mod.

   // signals for the write domain outputs and fill level.
   reg            w_overflow_hold;     // Hold fifo overrun until flushed or
                                       // a successful write.
   reg  [(CNT_WIDTH - 1): 0]           // valid number of words as seen by
                  w_fifo_count;        // w_clk, registered output.
   reg  [(CNT_WIDTH - 1): 0]           // valid number of words as seen by
                  w_fifo_cnt_int;      // w_clk (asynchronous).
   wire           w_fifo_full_int;     // fifo is full (asynchronous).
   reg  [(CNT_WIDTH - 1):0]            //
                  w_ptr;               // ptr to current write location.
   reg  [(CNT_WIDTH - 1):0]            //
                  w_ptr_prev;          // previous value of w_ptr (w_ptr - 1).
   wire           w_almost_full;       // almost full indication in write
                                       // domain.

   // signals for the read domain outputs and fill level.
   reg            r_underflow_hold;    // Hold fifo underrun until flushed or
                                       // a successful read.
   reg  [(CNT_WIDTH - 1):0]            // valid number of words as seen by
                  r_fifo_count;        // r_clk for output (registered).
   reg  [(CNT_WIDTH - 1):0]            // valid number of words as seen by
                  r_fifo_cnt_int;      // r_clk (internal).
   wire           r_fifo_empty_int;    // fifo is empty (asynchronous).
   reg  [(CNT_WIDTH - 1):0]            //
                  next_r_ptr;          // next ptr to current read location.
   reg  [(CNT_WIDTH - 1):0]            //
                  r_ptr;               // ptr to current read location.
   wire           r_almost_empty;      // almost empty indication in read
                                       // domain.

   // signals for w_ptr update in r_clk
   wire           new_w_ptr;           // w_wr when not updating already.
   wire           w_ptr_update;        // Set high when a new w_wr is
                                       // detected or when new pending.
   reg            w_ptr_update_tog;    // Toggle signal to trigger update
                                       // of w_ptr into the r_clk domain.
   reg  [(CNT_WIDTH - 1):0]            //
                  w_ptr_stable;        // Stable version of w_ptr for
                                       // sampling into r_clk domain.
   wire           r_w_ptrup_tog_sync2; // Sync w_ptr_update_tog to r_clk.
   reg            r_w_ptrup_tog_sync3; // Sync w_ptr_update_tog to r_clk.
   wire           r_w_ptr_update;      // Update w_ptr in r_clk.
   reg  [(CNT_WIDTH - 1):0]            //
                  r_clk_w_ptr_sync1;   // w_ptr in the r_clk domain.
   reg  [(CNT_WIDTH - 1):0]            //
                  r_clk_w_ptr;         // w_ptr in the r_clk domain.
   wire           w_ptr_up_detected;   // Detect resynced update signal.
   reg            w_up_in_prog_hold;   // Hold when update is in progress
   wire           w_ptr_up_in_prog;    // An update is in progress.
   reg            w_ptr_up_pending;    // An update is pending.
   wire           new_w_ptr_pending;   // Start a new update from pending
   reg            w_full_stable;       // w_fifo_full_int held stable in w_clk
   reg            r_full_stable_sync1; // w_full_stable sync into r_clk
   reg            r_clk_w_full;        // w_fifo_full_int in r_clk

   // signals for r_ptr update in w_clk
   wire           new_r_ptr;           // r_rd when not updating already.
   wire           r_ptr_update;        // Set high when a new r_rd is
                                       // detected or when new pending.
   reg            r_ptr_update_tog;    // Toggle signal to trigger update
                                       // of r_ptr into the w_clk domain.
   reg[(CNT_WIDTH - 1):0]              //
                  r_ptr_stable;        // Stable version of r_ptr for
                                       // sampling into w_clk domain.
   wire           w_r_ptrup_tog_sync2; // Sync r_ptr_update_tog to w_clk.
   reg            w_r_ptrup_tog_sync3; // Sync r_ptr_update_tog to w_clk.
   wire           w_r_ptr_update;      // Update r_ptr in w_clk.
   reg  [(CNT_WIDTH - 1):0]            //
                  w_clk_r_ptr_sync1;   // r_ptr in the w_clk domain.
   reg  [(CNT_WIDTH - 1):0]            //
                  w_clk_r_ptr;         // r_ptr in the w_clk domain.
   wire           r_ptr_up_detected;   // Detect resynced update signal.
   reg            r_up_in_prog_hold;   // Hold when update is in progress
   wire           r_ptr_up_in_prog;    // An update is in progress.
   reg            r_ptr_up_pending;    // An update is pending.
   wire           new_r_ptr_pending;   // Start a new update from pending
   reg            r_empty_stable;      // r_fifo_empty_int held stable in r_clk
   reg            w_empty_stable_sync1;// r_full_stable sync into w_clk
   reg            w_clk_r_empty;       // r_fifo_empty_int in w_clk

   // Signals for flush mechanism
   reg            w_flush_pend;        // store any pending flushes until
                                       // they are ready to be used
   reg            w_flush_stable;      // hold flush to transfer to r_clk
   wire           w_clk_flush;         // flush signal to be used in w_clk
   wire           w_r_flushed_sync;   // sync r_flushed into w_clk
   integer        h;                   // integer for flush under
                                       // reset condidtion.
   integer        j;                   // integer for flushing
                                       // under w_flush condition.

   // r_pkt_comp state machine signals.
   reg      [1:0] s_gem_fifo;          // current state assignment.
   reg      [1:0] s_gem_fifo_nxt;      // next state assignment.
   reg            w_eop_stored;        // store w_eop if busy updating w_ptr
                                       // in r_clk domain
   reg      [1:0] w_eop_number_stored; // Detect if one or two EOP's stored.
   reg      [1:0] w_eop_stable;        // hold eop in w_clk for sampling in
                                       // r_clk domain.
   reg      [1:0] r_eop_wr_sync1;      // eop written syncronising register 1.
   wire           r_eop_wr_sync;       // one clock wide EOP in rx_clk domain.

   // signals for synchronising FIFO array into rx_clk domain
   reg [(WIDTH - 1):0]                 //
                  r_data_sync1;        // fifo data output.
   reg            r_eop_sync1;         // last word of packet popped from fifo.
   reg            r_sop_sync1;         // first word of packet popped from fifo.
   reg      [3:0] r_mod_sync1;         // number of valid bytes at r_eop.
   reg            r_err_sync1;         // inset error into datastream.
   reg            r_control_sync1;     // packet control information

//------------------------------------------------------------------------------
// Main body of code
//------------------------------------------------------------------------------

   // parameters for state machine which generates r_pkt_comp.
   parameter
      FIFO_IDLE      = 2'b00,          // FIFO has no complete frames in it
      ONE_CMP_FRAME  = 2'b01,          // FIFO has one complete frame in it
      TWO_CMP_FRAME  = 2'b10;          // FIFO has two complete frames in it


   // assign BASE2_DEPTH parameter to a signal so that bit range can
   // be referenced.
   assign fifo_depth[(CNT_WIDTH - 1):0] = BASE2_DEPTH;

//------------------------------------------------------------------------------
// Write ptr control and FIFO elements
//------------------------------------------------------------------------------

   // Write ptr control and FIFO elements
   // fifo fills at w_ptr.
   always@(posedge w_clk or negedge w_rst_n)
   begin
      if (~w_rst_n)
         begin
           // reset all locations.
           w_ptr <= {(CNT_WIDTH){1'b0}};
           w_ptr_prev <= {(CNT_WIDTH){1'b0}};
           for (h = 0; h < DEPTH; h = h + 1)
              begin
                 fifo_data_h[h] <= {WIDTH {1'b0}};
                 fifo_eop[h]    <= 1'b0;
                 fifo_sop[h]    <= 1'b0;
                 fifo_err[h]    <= 1'b0;
                 fifo_mod[h]    <= 4'h0;
                 fifo_control[h]<= 1'b0;
              end
         end
      else
         begin
            // write ptr reset.
            if (w_clk_flush)
              begin
                w_ptr <= {(CNT_WIDTH){1'b0}};
                w_ptr_prev <= {(CNT_WIDTH){1'b0}};
                for (j = 0; j < DEPTH; j = j + 1)
                    begin
                       fifo_data_h[j] <= {WIDTH {1'b0}};
                       fifo_eop[j]    <= 1'b0;
                       fifo_sop[j]    <= 1'b0;
                       fifo_err[j]    <= 1'b0;
                       fifo_mod[j]    <= 4'h0;
                       fifo_control[j]<= 1'b0;
                    end
              end
            // write ptr incremented. Do not allow a write to the fifo
            // if already full.
            else if (w_wr & ~w_fifo_full_int)
               begin
                  for (j = 0; j < DEPTH; j = j + 1)
                  begin
                  if (j[CNT_WIDTH-1:0] == w_ptr[CNT_WIDTH-1:0])
                  begin
                    fifo_data_h[j]  <= w_data[(WIDTH-1):0];
                    fifo_eop[j]     <= w_eop;
                    fifo_sop[j]     <= w_sop;
                    fifo_err[j]     <= w_err;
                    fifo_mod[j]     <= w_mod[3:0];
                    fifo_control[j] <= w_control;
                  end
                  end

                  // write ptr
                  if (w_ptr == (fifo_depth - {{CNT_WIDTH-1{1'b0}},1'b1}))
                     w_ptr <= {(CNT_WIDTH){1'b0}};
                  else
                     w_ptr <= w_ptr + {{CNT_WIDTH-1{1'b0}},1'b1};

                  // update previous verions of pointer
                  w_ptr_prev <= w_ptr;
               end
            // If writing the EOP write and already full then we have an
            // overflow condition. We need to make sure this EOP write happens
            // so set ERR and EOP and zero SOP in the last but one location.
            // Maintain other values.
            else if (w_wr & w_eop)
               begin
                  for (j = 0; j < DEPTH; j = j + 1)
                  begin
                  if (j[CNT_WIDTH-1:0] == w_ptr_prev[CNT_WIDTH-1:0])
                  begin
                    fifo_eop[j] <= 1'b1;
                    fifo_sop[j] <= 1'b0;
                    fifo_err[j] <= 1'b1;
                  end
                  end
                  w_ptr                <= w_ptr;
                  w_ptr_prev           <= w_ptr_prev;
               end

            // else maintain values
            else
               begin
                  for (j = 0; j < DEPTH; j = j + 1)
                  begin
                  if (j[CNT_WIDTH-1:0] == w_ptr[CNT_WIDTH-1:0])
                  begin
                    fifo_eop[j]     <= fifo_eop_pad[j];
                    fifo_sop[j]     <= fifo_sop_pad[j];
                    fifo_err[j]     <= fifo_err_pad[j];
                    fifo_data_h[j]  <= fifo_data_h_pad[j];
                    fifo_mod[j]     <= fifo_mod_pad[j];
                    fifo_control[j] <= fifo_control_pad[j];
                  end
                  end
                  w_ptr               <= w_ptr;
                  w_ptr_prev          <= w_ptr_prev;
               end
         end
   end


//------------------------------------------------------------------------------
// Read ptr control
//------------------------------------------------------------------------------

   // Read ptr control (Next value)
   // seperate read ptr in the r_clk domain pops at r_ptr if the
   // r_ptr is equal to the w_ptr and a pop is attempted then the
   // r_underflow signal is asserted.
   always@(r_flushed or r_rd or r_ptr or fifo_depth or r_fifo_empty_int)
   begin
      // read ptr.
      if (r_flushed)
         next_r_ptr[(CNT_WIDTH-1):0] = {(CNT_WIDTH){1'b0}};
      else if (r_rd & r_fifo_empty_int)
         next_r_ptr = r_ptr;
      else if (r_rd & (r_ptr == (fifo_depth - {{CNT_WIDTH-1{1'b0}},1'b1})))
         next_r_ptr = {(CNT_WIDTH){1'b0}};
      else if (r_rd)
         next_r_ptr = r_ptr + {{CNT_WIDTH-1{1'b0}},1'b1};
      else
         next_r_ptr = r_ptr;
   end

   // Read ptr control (sync version)
   always@(posedge r_clk or negedge r_rst_n)
   begin
      if (~r_rst_n)
        // reset ptr.
        r_ptr[(CNT_WIDTH-1):0] <= {(CNT_WIDTH){1'b0}};
      else
        r_ptr <= next_r_ptr;
   end


//------------------------------------------------------------------------------
// Update w_ptr from w_clk domain into r_clk domain
//------------------------------------------------------------------------------

   // if no update is currently in progess then when a w_wr is detected it
   // can be used directly to update the w_ptr_stable and toggle
   // w_ptr_update_tog to initiate synchronisation
   // Also need to update if going to overflow to ensure EOP is passed
   assign   new_w_ptr = w_wr & ~w_ptr_up_in_prog;


   // signal used to toggle w_ptr_update_tog signal to signal either a new w_wr
   // occured or a pending wr signal needs to be serviced
   assign   w_ptr_update = new_w_ptr | new_w_ptr_pending;


   // w_ptr_update_tog signal is toggled when a w_wr to the fifo and no update
   // is currently being serviced in the r_clk domain or when a pending w_wr
   // is given access
   always@(posedge w_clk or negedge w_rst_n)
      begin
         if (~w_rst_n)
            w_ptr_update_tog <= 1'b0;
         else if (w_ptr_update & ~w_clk_flush)
            w_ptr_update_tog <= ~w_ptr_update_tog;
         else
            w_ptr_update_tog <= w_ptr_update_tog;
      end


   // take in the current value of the w_ptr to update the w_ptr that is shown
   // to the r_clk domain. Potentially the w_ptr value is being taken at the
   // precise time it is being updated by a write. If this is the case
   // we need to add one to the transfered value. If this occurs at the
   // maximum w_ptr value need to wrap back round to zero.
   // Also sample and hold FIFO full flag to transfer over to r_clk domain.
   always@(posedge w_clk or negedge w_rst_n)
      begin
         if (~w_rst_n)
            begin
               w_ptr_stable  <= {(CNT_WIDTH){1'b0}};
               w_full_stable <= 1'b0;
            end
         else if (w_clk_flush)
            begin
               w_ptr_stable  <= {(CNT_WIDTH){1'b0}};
               w_full_stable <= 1'b0;
            end
         else if(w_ptr_update)
            begin
               if (new_w_ptr & (w_ptr == (fifo_depth - {{CNT_WIDTH-1{1'b0}},1'b1})) & ~w_fifo_full_int)
                  w_ptr_stable <= {(CNT_WIDTH){1'b0}};
               else if (new_w_ptr & ~w_fifo_full_int)
                  w_ptr_stable <= w_ptr + {{CNT_WIDTH-1{1'b0}},1'b1};
               else
                  w_ptr_stable <= w_ptr;

               // sample and hold FIFO full flag for transferring to r_clk
               if (new_w_ptr)
                  w_full_stable <= w_almost_full | w_fifo_full_int;
               else
                  w_full_stable <= w_fifo_full_int;
            end
         else
            begin
               w_ptr_stable  <= w_ptr_stable;
               w_full_stable <= w_full_stable;
            end
      end


   // synchronise the w_ptr_update_tog signal to the r_clk domain to generate
   // an edge to latch in w_ptr_stable. At the same time the update signal is
   // sent back to the w_clk domain to allow further updates.
   //
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_ (
      .clk(r_clk),
      .reset_n(r_rst_n),
      .din(w_ptr_update_tog),
      .dout(r_w_ptrup_tog_sync2));

   always @(posedge r_clk or negedge r_rst_n)
      if (~r_rst_n)
         r_w_ptrup_tog_sync3   <= 1'b0;
      else
         r_w_ptrup_tog_sync3   <= r_w_ptrup_tog_sync2;

   // Detect either edge of the toggle signal to allow an update of the
   // r_clk version of the w_ptr from w_ptr_stable.
   assign  r_w_ptr_update = r_w_ptrup_tog_sync2 ^ r_w_ptrup_tog_sync3;


   // first sync w_ptr_stable to read clock to remove glitches
   // Also sync w_full_stable to read clock.
   always@(posedge r_clk or negedge r_rst_n)
   begin
      if (~r_rst_n)
         begin
            r_clk_w_ptr_sync1   <= {(CNT_WIDTH){1'b0}};
            r_full_stable_sync1 <= 1'b0;
         end
      else
         begin
            r_clk_w_ptr_sync1   <= w_ptr_stable;
            r_full_stable_sync1 <= w_full_stable;
         end
   end


   // when the toggle pulse is asserted, pass in the new value for the write
   // ptr w_ptr into the r_clk domain
   always@(posedge r_clk or negedge r_rst_n)
   begin
      if (~r_rst_n)
         r_clk_w_ptr <= {(CNT_WIDTH){1'b0}};
      else if (r_flushed)
         r_clk_w_ptr <= {(CNT_WIDTH){1'b0}};
      else if (r_w_ptr_update)
         r_clk_w_ptr <= r_clk_w_ptr_sync1;
      else
         r_clk_w_ptr <= r_clk_w_ptr;
   end


   // when the toggle pulse is asserted, pass in the new value for the write
   // FIFO full flag into the r_clk domain. Cleared when pointers are
   // not equal.
   always@(posedge r_clk or negedge r_rst_n)
   begin
      if (~r_rst_n)
         r_clk_w_full <= 1'b0;
      else if (r_flushed)
         r_clk_w_full <= 1'b0;
      else if (r_w_ptr_update)
         r_clk_w_full <= r_full_stable_sync1;
      else if (r_clk_w_ptr != r_ptr)
         r_clk_w_full <= 1'b0;
      else
         r_clk_w_full <= r_clk_w_full;
   end


   // synchronise the r_w_ptrup_tog_sync3 signal to the w_clk domain to
   // allow further updates of the pointer now it has been successfully
   // detected.
   edma_sync_toggle_detect i_edma_sync_toggle_detect_r_w_ptrup_tog_sync3 (
      .clk(w_clk),
      .reset_n(w_rst_n),
      .din(r_w_ptrup_tog_sync3),
      .rise_edge(),
      .fall_edge(),
      .any_edge(w_ptr_up_detected));


   // Detect and hold when we are doing an update so we can store any
   // pending updates. Set whenever there's a new update starting, only reset
   // if the previous update has completed and there isn't a new one starting.
   always@(posedge w_clk or negedge w_rst_n)
      begin
         if (~w_rst_n)
            w_up_in_prog_hold <= 1'b0;
         else if (w_clk_flush)
            w_up_in_prog_hold <= 1'b0;
         else if (w_ptr_update)
            w_up_in_prog_hold <= 1'b1;
         else if (w_ptr_up_detected)
            w_up_in_prog_hold <= 1'b0;
         else
            w_up_in_prog_hold <= w_up_in_prog_hold;
      end


   // Signal used to indicate an update in progress to rest of logic.
   // This signal is forced low if an update has just completed to allow
   // for new writes at that same clock edge to be recognised
   assign  w_ptr_up_in_prog = w_up_in_prog_hold & ~w_ptr_up_detected;


   // w_ptr_up_pending signal is generated when a write occurs but currently
   // the r_clk domain is still dealing with the previous update.
   // This is held until the update has finished, at which time
   // a new update will begin.
   always@(posedge w_clk or negedge w_rst_n)
      begin
         if (~w_rst_n)
            w_ptr_up_pending <= 1'b0;
         else if (w_clk_flush)
            w_ptr_up_pending <= 1'b0;
         else if (w_wr & w_ptr_up_in_prog)
            w_ptr_up_pending <= 1'b1;
         else if (w_ptr_up_detected)
            w_ptr_up_pending <= 1'b0;
         else
            w_ptr_up_pending <= w_ptr_up_pending;
      end


   // Generate a new pulse at end of previous update if a pending update
   // is required.
   assign  new_w_ptr_pending = w_ptr_up_pending & w_ptr_up_detected;



//------------------------------------------------------------------------------
// Update r_ptr from r_clk domain into w_clk domain
//------------------------------------------------------------------------------

   // if no update is currently in progess then when a r_rd is detected it
   // can be used directly to update the r_ptr_stable and toggle
   // r_ptr_update_tog to initiate synchronisation
   // Only update if not going to underflow.
   assign   new_r_ptr = r_rd & ~r_ptr_up_in_prog & ~r_fifo_empty_int;


   // signal used to toggle r_ptr_update_tog signal to signal either a new r_rd
   // occured or a pending rd signal needs to be serviced.
   assign   r_ptr_update = new_r_ptr | new_r_ptr_pending;


   // r_ptr_update_tog signal is toggled when a r_rd to the fifo and no update
   // is currently being serviced in the w_clk domain or when a pending r_rd
   // is given access
   always@(posedge r_clk or negedge r_rst_n)
      begin
         if (~r_rst_n)
            r_ptr_update_tog <= 1'b0;
         else if (r_ptr_update & ~r_flushed)
            r_ptr_update_tog <= ~r_ptr_update_tog;
         else
            r_ptr_update_tog <= r_ptr_update_tog;
      end


   // take in the current value of the r_ptr to update the r_ptr that is shown
   // to the w_clk domain. Potentially the r_ptr value is being taken at the
   // precise time it is being updated by a read. If this is the case
   // we need to add one to the transfered value. If this occurs at the
   // maximum r_ptr value need to wrap back round to zero.
   // Also sample and hold FIFO empty flag to transfer over to w_clk domain.
   always@(posedge r_clk or negedge r_rst_n)
      begin
         if (~r_rst_n)
            begin
               r_ptr_stable   <= {(CNT_WIDTH){1'b0}};
               r_empty_stable <= 1'b1;
            end
         else if (r_flushed)
            begin
               r_ptr_stable   <= {(CNT_WIDTH){1'b0}};
               r_empty_stable <= 1'b1;
            end
         else if(r_ptr_update)
            begin
               if (new_r_ptr & (r_ptr == (fifo_depth - {{CNT_WIDTH-1{1'b0}},1'b1})))
                  r_ptr_stable <= {(CNT_WIDTH){1'b0}};
               else if (new_r_ptr)
                  r_ptr_stable <= r_ptr + {{CNT_WIDTH-1{1'b0}},1'b1};
               else
                  r_ptr_stable <= r_ptr;

               // sample and hold FIFO empty flag for transferring to w_clk
               if (new_r_ptr)
                  r_empty_stable <= r_almost_empty | r_fifo_empty_int;
               else
                  r_empty_stable <= r_fifo_empty_int;
            end
         else
            begin
               r_ptr_stable   <= r_ptr_stable;
               r_empty_stable <= r_empty_stable;
            end
      end


   // synchronise the r_ptr_update_tog signal to the w_clk domain to generate
   // an edge to latch in r_ptr_stable. At the same time the update signal is
   // sent back to the r_clk domain to allow further updates.
   //
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_r_ptr_update_tog (
      .clk(w_clk),
      .reset_n(w_rst_n),
      .din(r_ptr_update_tog),
      .dout(w_r_ptrup_tog_sync2));

   always @(posedge w_clk or negedge w_rst_n)
      if (~w_rst_n)
         w_r_ptrup_tog_sync3   <= 1'b0;
      else
         w_r_ptrup_tog_sync3   <= w_r_ptrup_tog_sync2;

   // Detect either edge of the toggle signal to allow an update of the
   // w_clk version of the r_ptr from r_ptr_stable.
   assign  w_r_ptr_update = w_r_ptrup_tog_sync2 ^ w_r_ptrup_tog_sync3;


   // first sync r_ptr_stable to write clock to remove glitches
   // Also sync r_empty_stable to write clock.
   always@(posedge w_clk or negedge w_rst_n)
   begin
      if (~w_rst_n)
         begin
            w_clk_r_ptr_sync1    <= {(CNT_WIDTH){1'b0}};
            w_empty_stable_sync1 <= 1'b1;
         end
      else
         begin
            w_clk_r_ptr_sync1    <= r_ptr_stable;
            w_empty_stable_sync1 <= r_empty_stable;
         end
   end


   // when the toggle pulse is asserted, pass in the new value for the read
   // ptr r_ptr into the w_clk domain
   always@(posedge w_clk or negedge w_rst_n)
   begin
      if (~w_rst_n)
         w_clk_r_ptr <= {(CNT_WIDTH){1'b0}};
      else if (w_clk_flush)
         w_clk_r_ptr <= {(CNT_WIDTH){1'b0}};
      else if (w_r_ptr_update)
         w_clk_r_ptr <= w_clk_r_ptr_sync1;
      else
         w_clk_r_ptr <= w_clk_r_ptr;
   end


   // when the toggle pulse is asserted, pass in the new value for the read
   // FIFO empty flag into the w_clk domain. Cleared when pointers are
   // not equal.
   always@(posedge w_clk or negedge w_rst_n)
   begin
      if (~w_rst_n)
         w_clk_r_empty <= 1'b1;
      else if (w_clk_flush)
         w_clk_r_empty <= 1'b1;
      else if (w_r_ptr_update)
         w_clk_r_empty <= w_empty_stable_sync1;
      else if (w_ptr != w_clk_r_ptr)
         w_clk_r_empty <= 1'b0;
      else
         w_clk_r_empty <= w_clk_r_empty;
   end


   // synchronise the w_r_ptrup_tog_sync3 signal to the r_clk domain to
   // allow further updates of the pointer now it has been successfully
   // detected.
   edma_sync_toggle_detect i_edma_sync_toggle_detect_w_r_ptrup_tog_sync3 (
      .clk(r_clk),
      .reset_n(r_rst_n),
      .din(w_r_ptrup_tog_sync3),
      .rise_edge(),
      .fall_edge(),
      .any_edge(r_ptr_up_detected));


   // Detect and hold when we are doing an update so we can store any
   // pending updates. Set whenever there's a new update starting, only reset
   // if the previous update has completed and there isn't a new one starting.
   always@(posedge r_clk or negedge r_rst_n)
      begin
         if (~r_rst_n)
            r_up_in_prog_hold <= 1'b0;
         else if (r_flushed)
            r_up_in_prog_hold <= 1'b0;
         else if (r_ptr_update)
            r_up_in_prog_hold <= 1'b1;
         else if (r_ptr_up_detected)
            r_up_in_prog_hold <= 1'b0;
         else
            r_up_in_prog_hold <= r_up_in_prog_hold;
      end


   // Signal used to indicate an update in progress to rest of logic.
   // This signal is forced low if an update has just completed to allow
   // for new reads at that same clock edge to be recognised
   assign  r_ptr_up_in_prog = r_up_in_prog_hold & ~r_ptr_up_detected;


   // r_ptr_up_pending signal is generated when a read occurs but currently
   // the w_clk domain is still dealing with the previous update.
   // This is held until the update has finished, at which time
   // a new update will begin.
   always@(posedge r_clk or negedge r_rst_n)
      begin
         if (~r_rst_n)
            r_ptr_up_pending <= 1'b0;
         else if (r_flushed)
            r_ptr_up_pending <= 1'b0;
         else if (r_rd & r_ptr_up_in_prog)
            r_ptr_up_pending <= 1'b1;
         else if (r_ptr_up_detected)
            r_ptr_up_pending <= 1'b0;
         else
            r_ptr_up_pending <= r_ptr_up_pending;
      end


   // Generate a new pulse at end of previous update if a pending update
   // is required.
   assign  new_r_ptr_pending = r_ptr_up_pending & r_ptr_up_detected;


//------------------------------------------------------------------------------
// Read interface level count
//------------------------------------------------------------------------------

   // calculate the number of locations that contain valid data within
   // the fifo, copes with the case where the fifo wraps around.
   always@(r_flushed or r_ptr or r_clk_w_ptr or fifo_depth or r_clk_w_full)
   begin
      if (r_flushed)
         r_fifo_cnt_int = {(CNT_WIDTH){1'b0}};

      else if (r_clk_w_ptr > r_ptr)
         r_fifo_cnt_int = r_clk_w_ptr - r_ptr;

      else if ((r_clk_w_ptr == r_ptr) & (r_clk_w_full))
         r_fifo_cnt_int = fifo_depth;

      else if (r_clk_w_ptr == r_ptr)
         r_fifo_cnt_int = {(CNT_WIDTH){1'b0}};

      else
         r_fifo_cnt_int = fifo_depth - (r_ptr - r_clk_w_ptr);
   end


   // register r_fifo_count for output
   always@(posedge r_clk or negedge r_rst_n)
      begin
         if (~r_rst_n)
            r_fifo_count <= {(CNT_WIDTH){1'b0}};
         else
            r_fifo_count <= r_fifo_cnt_int;
      end


//------------------------------------------------------------------------------
// Write interface level count
//------------------------------------------------------------------------------

   // calculate the number of locations that contain valid locations within
   // the fifo, copes with the case where the fifo wraps around.
   always@(w_clk_flush or w_ptr or w_clk_r_ptr or fifo_depth or w_clk_r_empty)
   begin
      if (w_clk_flush)
         w_fifo_cnt_int = {(CNT_WIDTH){1'b0}};

      else if (w_ptr > w_clk_r_ptr)
         w_fifo_cnt_int = w_ptr - w_clk_r_ptr;

      else if ((w_ptr == w_clk_r_ptr) & (w_clk_r_empty))
         w_fifo_cnt_int = {(CNT_WIDTH){1'b0}};

      else if (w_ptr == w_clk_r_ptr)
         w_fifo_cnt_int = fifo_depth;

      else
         w_fifo_cnt_int = fifo_depth - (w_clk_r_ptr - w_ptr);
   end


   // register w_fifo_count for output
   always@(posedge w_clk or negedge w_rst_n)
      begin
         if (~w_rst_n)
            w_fifo_count <= {(CNT_WIDTH){1'b0}};
         else
            w_fifo_count <= w_fifo_cnt_int;
      end



//------------------------------------------------------------------------------
// Detect FIFO levels - (full, empty, underflow, overflow)
//------------------------------------------------------------------------------

   // fifo almost full/empty indications (one from full or empty)
   assign w_almost_full  = (w_fifo_cnt_int ==
                                (fifo_depth - {{(CNT_WIDTH-1){1'b0}},1'b1}));
   assign r_almost_empty = (r_fifo_cnt_int == {{(CNT_WIDTH-1){1'b0}},1'b1});

   // fifo level indications.
   assign w_fifo_full_int  = (w_fifo_cnt_int == fifo_depth);
   assign r_fifo_empty_int = (r_fifo_cnt_int == {CNT_WIDTH{1'b0}});


   // overflow condition. Set in w_clk domain when already full and
   // we get another write. Hold condition until no longer full,
   // or a flush is made.
   always @(posedge w_clk or negedge w_rst_n)
   begin
      if (~w_rst_n)
         w_overflow_hold <= 1'b0;
      else if (~w_fifo_full_int | w_clk_flush)
         w_overflow_hold <= 1'b0;
      else if (w_fifo_full_int & w_wr)
         w_overflow_hold <= 1'b1;
      else
         w_overflow_hold <= w_overflow_hold;
   end

   // assign w_overflow output
   assign w_overflow = (w_fifo_full_int & w_wr) |
                       (w_overflow_hold & ~w_clk_flush & w_fifo_full_int);

   // underflow condition. Set in r_clk domain when already empty and
   // we get another read.
   always @(posedge r_clk or negedge r_rst_n)
   begin
      if (~r_rst_n)
         r_underflow_hold <= 1'b0;
      else if ((~r_fifo_empty_int & r_rd) | r_flushed)
         r_underflow_hold <= 1'b0;
      else if (r_fifo_empty_int & r_rd)
         r_underflow_hold <= 1'b1;
      else
         r_underflow_hold <= r_underflow_hold;
   end

   // assign r_underflow output
   assign r_underflow = (r_fifo_empty_int & r_rd) |
                       (r_underflow_hold & ~r_flushed &
                        ~(~r_fifo_empty_int & r_rd));


//------------------------------------------------------------------------------
// Flush operation
//------------------------------------------------------------------------------

   // detect w_flush in w_clk domain and hold until properly seen in r_clk.
   always @(posedge w_clk or negedge w_rst_n)
   begin
      if (~w_rst_n)
         begin
            w_flush_pend   <= 1'b0;
            w_flush_stable <= 1'b0;
         end
      else
         begin
            // detect w_flush in w_clk domain and hold as a
            // pending flush (w_flush_pend) until holding
            // synchronising  register (w_flush_stable) is
            // ready to deal with it.
            if (w_flush)
               w_flush_pend <= 1'b1;
            else if (w_flush_stable)
               w_flush_pend <= 1'b0;
            else
               w_flush_pend <= w_flush_pend;

            // once detected in r_clk domain can reset holding
            // register, if w_flush is not still asserted. Hold
            // in reset until it's seen to go low in the r_clk domain.
            // Once seen low again can accept new pending flush.
            if (w_r_flushed_sync & ~w_flush)
               w_flush_stable <= 1'b0;
            else if (w_flush_pend & ~w_r_flushed_sync)
               w_flush_stable <= 1'b1;
            else
               w_flush_stable <= w_flush_stable;
         end
   end

   // assign flush signal for use in w_clk
   assign w_clk_flush = w_flush_stable;


   // detect flush in the r_clk domain
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_w_flush_stable (
      .clk(r_clk),
      .reset_n(r_rst_n),
      .din(w_flush_stable),
      .dout(r_flushed));


   // detect r_flushed back into the w_clk domain for monitoring
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_r_flushed (
      .clk(w_clk),
      .reset_n(w_rst_n),
      .din(r_flushed),
      .dout(w_r_flushed_sync));


   // output to indicate to write side when flushing is complete
   assign w_flushing = w_flush_pend | w_flush_stable | w_r_flushed_sync;


//------------------------------------------------------------------------------
// logic for generating r_pkt_comp
//------------------------------------------------------------------------------
// r_pkt_comp must be signalled whenever there is a valid EOP bit set
// in the FIFO. The logic borrows handshaking from the write pointer clock
// boundary update, to detect when an EOP is written into the FIFO.
// It will keep track of up to two EOP's in the FIFO using a state machine.

   // store w_eop if busy updating w_ptr in r_clk domain
   always@(posedge w_clk or negedge w_rst_n)
   begin
      if (~w_rst_n)
         w_eop_stored <= 1'b0;
      else if (w_clk_flush)
         w_eop_stored <= 1'b0;
      else if (w_eop & w_wr & w_ptr_up_in_prog)
         w_eop_stored <= 1'b1;
      else if (new_w_ptr_pending)
         w_eop_stored <= 1'b0;
      else
         w_eop_stored <= w_eop_stored;
   end

   // Need to store two EOP's as might already be busy updating from previous
   // write pointer update and then get two EOP writes in a row.
   always@(posedge w_clk or negedge w_rst_n)
   begin
      if (~w_rst_n)
         w_eop_number_stored <= 2'b00;
      else if (w_clk_flush)
         w_eop_number_stored <= 2'b00;
      else if (w_eop & w_wr & w_ptr_up_in_prog)
         w_eop_number_stored <= w_eop_number_stored + 2'b01;
      else if (new_w_ptr_pending)
         w_eop_number_stored <= 2'b00;
      else
         w_eop_number_stored <= w_eop_number_stored;
   end


   // generate eop indication for passing to r_clk domain.
   always@(posedge w_clk or negedge w_rst_n)
   begin
      if (~w_rst_n)
         w_eop_stable <= 2'b00;

      // reset when flushing.
      else if (w_clk_flush)
         w_eop_stable <= 2'b00;

      // set to one when not already doing an update
      else if (w_wr & w_eop & ~w_ptr_up_in_prog)
         w_eop_stable <= 2'b01;

      // set to stored number when doin a pending updated
      else if (new_w_ptr_pending & w_eop_stored)
         w_eop_stable <= w_eop_number_stored;

      // when we know it's detected we can reset it.
      else if (w_ptr_up_detected)
         w_eop_stable <= 2'b00;

      // Else maintain value
      else
         w_eop_stable <= w_eop_stable;
   end


   // synchronize end of packet write across clock
   // domain (w_clk to r_clk).
   always@(posedge r_clk or negedge r_rst_n)
   begin
      if (~r_rst_n)
         r_eop_wr_sync1 <= 2'b00;
      else
         r_eop_wr_sync1 <= w_eop_stable;
   end


   // assign eop detected into r_clk domain for r_pkt_comp state machine
   // This is made a pulse by qualifying with r_w_ptr_update, which
   // indicates that the w_ptr is about to be updated in the r_clk domain.
   assign r_eop_wr_sync = |r_eop_wr_sync1 & r_w_ptr_update;


   // State Machine for generating r_pkt_comp output.

   // update the state variable with the next state.
   always@(posedge r_clk or negedge r_rst_n)
   begin
      if (~r_rst_n)
          s_gem_fifo <= FIFO_IDLE;
      else if (r_flushed)
          s_gem_fifo <= FIFO_IDLE;
      else
          s_gem_fifo <= s_gem_fifo_nxt;
   end


   // fifo state machine next state logic.
   // Counts the number of EOP's in the FIFO (up to 2 maximum).
   always@(s_gem_fifo or r_eop_wr_sync or r_eop_wr_sync1 or r_eop or r_valid)
   begin
      case(s_gem_fifo)
         ONE_CMP_FRAME:
            // State indicates that one EOP present in FIFO
            begin
               // If one new EOP detected at same time one is popped
               // stay in ONE_CMP_FRAME
               if (r_eop_wr_sync & r_eop & r_valid)
                  s_gem_fifo_nxt = ONE_CMP_FRAME;

               // Else if new EOP detected goto TWO_CMP_FRAME
               else if (r_eop_wr_sync)
                  s_gem_fifo_nxt = TWO_CMP_FRAME;

               // Else if EOP popped then goto FIFO_IDLE
               else if (r_eop & r_valid)
                  s_gem_fifo_nxt = FIFO_IDLE;

               // Else still one EOP in FIFO
               else
                  s_gem_fifo_nxt = ONE_CMP_FRAME;
            end

         TWO_CMP_FRAME:
            // State indicates that two EOP's present in FIFO
            begin
               // If EOP popped then goto ONE_CMP_FRAME
               if (r_eop & r_valid)
                  s_gem_fifo_nxt = ONE_CMP_FRAME;

               // Else still two EOP's in FIFO
               else
                  s_gem_fifo_nxt = TWO_CMP_FRAME;
            end

         default: //FIFO_IDLE:
            // State indicates that no EOP's present in FIFO
            begin
               // If one new EOP detected goto ONE_CMP_FRAME
               if(r_eop_wr_sync & (r_eop_wr_sync1 == 2'b01))
                  s_gem_fifo_nxt = ONE_CMP_FRAME;

               // Else if two new EOP detected goto ONE_CMP_FRAME
               else if(r_eop_wr_sync & (r_eop_wr_sync1 == 2'b10))
                  s_gem_fifo_nxt = TWO_CMP_FRAME;

               // Else still no EOP's in FIFO
               else
                  s_gem_fifo_nxt = FIFO_IDLE;
            end
      endcase
   end



//------------------------------------------------------------------------------
// drive read interface outputs
//------------------------------------------------------------------------------

   // indicates that there is at least one complete frame in the fifo.
   // combinatorially derive from the current state a flag that
   // end of frame resides in the fifo
   assign   r_pkt_comp = ( s_gem_fifo == ONE_CMP_FRAME |
                           s_gem_fifo == TWO_CMP_FRAME ) ;


   // r_valid validates the r_data currently present on the bus for it to
   // be processed by the reading block. Asserted immediately for this
   // implementation.
   assign   r_valid = r_rd;


   // sync FIFO array outputs from w_clk into r_clk holding register.
   always@(posedge r_clk or negedge r_rst_n)
   begin
      if (~r_rst_n)
         begin
            r_data_sync1    <= {WIDTH {1'b0}};
            r_eop_sync1     <= 1'b0;
            r_sop_sync1     <= 1'b0;
            r_err_sync1     <= 1'b0;
            r_mod_sync1     <= 4'h0;
            r_control_sync1 <= 1'b0;
         end
      else
         begin
            r_data_sync1    <= fifo_data_h_pad[next_r_ptr];
            r_eop_sync1     <= fifo_eop_pad[next_r_ptr];
            r_sop_sync1     <= fifo_sop_pad[next_r_ptr];
            r_err_sync1     <= fifo_err_pad[next_r_ptr];
            r_mod_sync1     <= fifo_mod_pad[next_r_ptr];
            r_control_sync1 <= fifo_control_pad[next_r_ptr];
         end
   end

   // drive fifo output data, eop, sop, err and mod bits from the r_ptr
   // to the respective signals.
   // If underflow has occurred then force EOP low and ERR high.
   assign   r_data    = r_data_sync1;
   assign   r_eop     = r_eop_sync1 & ~r_underflow;
   assign   r_sop     = r_sop_sync1;
   assign   r_err     = r_err_sync1 | r_underflow;
   assign   r_mod     = r_mod_sync1;
   assign   r_control = r_control_sync1;

  genvar gv_i;
  generate for (gv_i=0; gv_i<2**CNT_WIDTH; gv_i=gv_i+1) begin : gen_pad
    if (gv_i < DEPTH) begin : gen_in_range
      assign fifo_data_h_pad[gv_i]  = fifo_data_h[gv_i];
      assign fifo_eop_pad[gv_i]  = fifo_eop[gv_i];
      assign fifo_sop_pad[gv_i]  = fifo_sop[gv_i];
      assign fifo_err_pad[gv_i]  = fifo_err[gv_i];
      assign fifo_mod_pad[gv_i]  = fifo_mod[gv_i];
      assign fifo_control_pad[gv_i]  = fifo_control[gv_i];
    end else begin : gen_not_in_range
      assign fifo_data_h_pad[gv_i]  = {WIDTH{1'b0}};
      assign fifo_eop_pad[gv_i]  = 1'b0;
      assign fifo_sop_pad[gv_i]  = 1'b0;
      assign fifo_err_pad[gv_i]  = 1'b0;
      assign fifo_mod_pad[gv_i]  = 4'h0;
      assign fifo_control_pad[gv_i]  = 1'b0;
    end
  end
  endgenerate

endmodule

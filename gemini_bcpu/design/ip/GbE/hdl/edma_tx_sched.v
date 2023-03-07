//------------------------------------------------------------------------------
// Copyright (c) 2015-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_tx_sched.v
//   Module Name:        edma_tx_sched
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
// Description    : Transmit Scheduler
//
//------------------------------------------------------------------------------


module edma_tx_sched #(

   parameter p_edma_exclude_cbs = 1'b0,
   parameter p_edma_queues      = 32'd1

  ) (

   // System signals
   input                              tx_r_clk,            // tx_clk for fifo read clock.
   input                              tx_r_rst_n,          // n_txreset for fifo read reset.
   input                              complete_flush,      // Soft reset

   input  [p_edma_queues-1:0]         packets_in_q,        // Frames available in queue to transmit
   input  [p_edma_queues-1:0]         packets_in_q_nxt,    // Frames available in queue (early version)
   input  [(19*p_edma_queues)-1:0]    byte_count,          // Number of bytes possible to transmit during the gatestate open phase
   input  [p_edma_queues-1:0]         gatestate,           // Gate State, one per queue
   input  [(14*p_edma_queues)-1:0]    nxt_frame_size_bus,  // length of frame at the head of the SRAM, one per queue
   input                              reschedule_now,      // This is the trigger. When high a new queue will be decided
   input                              cbs_dma_q_a,         // Needed by CBS - information that Queue A is selected
   input                              cbs_dma_q_b,         // Needed by CBS - information that Queue B is selected
   input                              mac_txing_dma_frame, // Mac is transmitting

   input                              ets_credits_upd_tog, // Toggle detect ets_upd_tog

    // Static Signalling from register block
   input  [3:0]                       cbs_q_a_id,          // ID for top queue
   input  [3:0]                       cbs_q_b_id,
   input  [31:0]                      idleslope_q_a,       // Rate of Change of credit for Queue A
   input  [31:0]                      idleslope_q_b,       // Rate of Change of credit for Queue B
   input  [31:0]                      port_tx_rate,        // TX Rate
   input  [31:0]                      dwrr_ets_control,
   input  [127:0]                     bw_rate_limit,

   // instantiate the Traffic Based Shaper ...
   input                              cbs_enable_q_a,
   input                              cbs_enable_q_b,

   output                             nothing_to_xmit,
   output                             any_ets_en,
   output reg [3:0]                   scheduled_queue

   );

// instantiate the Traffic Based Shaper
  wire  [1:0]               cbs_queue;


  generate if (p_edma_exclude_cbs == 1'b0 && p_edma_queues > 32'd1) begin : gen_instance_shaper
  wire                      packets_in_q_a;
  wire                      packets_in_q_b;

  // Select the priorty queues to feed status into the CBS module
  // Use a padded signal to avoid a LINT issue with the indexing ...
  wire [16:0]               packets_in_q_nxt_pad;
  assign packets_in_q_nxt_pad = {{(17-p_edma_queues){1'b0}},packets_in_q_nxt};
  assign packets_in_q_a = packets_in_q_nxt_pad[cbs_q_a_id];
  assign packets_in_q_b = packets_in_q_nxt_pad[cbs_q_b_id];

  edma_tfc_shaper i_edma_tfc_shaper (

    // System signals
    .clk                       (tx_r_clk),
    .rst_n                     (tx_r_rst_n),
    .complete_flush            (complete_flush),
    .cbs_enable_q_a            (cbs_enable_q_a),
    .cbs_enable_q_b            (cbs_enable_q_b),
    .idleslope_q_a             (idleslope_q_a),
    .idleslope_q_b             (idleslope_q_b),
    .port_tx_rate              (port_tx_rate),
    .packets_in_q_a            (packets_in_q_a),
    .packets_in_q_b            (packets_in_q_b),
    .cbs_dma_q_a               (cbs_dma_q_a),
    .cbs_dma_q_b               (cbs_dma_q_b),
    .mac_txing_dma_frame       (mac_txing_dma_frame),

    .cbs_queue                 (cbs_queue)
  );

  end else begin : gen_no_cbs
    assign cbs_queue = 2'h0;
  end
  endgenerate


// Now select the next queue to transmit to
// This is the scheduler.  We support fixed priority, CBS, DWRR and ETS here.
// Only relevant if we have at least 2 queues active
// Before we start the scheduling, extract the packet lengths for each frame at the head
// of the queues ...
  // regenerate the size of the frame ...
  wire [13:0]               nxt_frame_size [p_edma_queues-1:0];
  reg  [15:0]               dwrr_def_cnt [p_edma_queues-1:0];
  wire [7:0]                dwrr_quantum [p_edma_queues-1:0];
  reg  [p_edma_queues-1:0]  queue_can_tx;
  reg  [p_edma_queues-1:0]  queue_can_tx_str;
  reg  [p_edma_queues-1:0]  queue_can_tx_str_nxt;
  wire [p_edma_queues-1:0]  dwrr_en;
  wire [p_edma_queues-1:0]  ets_en;
  reg                       update_ets_credit;
  wire [18:0]               byte_count_arr [p_edma_queues-1:0];
  reg  [p_edma_queues-1:0]  deficit_cntr_rst;
  wire [p_edma_queues-1:0]  dwrr_def_cnt_sat;
  reg                       queue_is_fp;
  reg  [3:0]                top_ets_queue;

  genvar i2;
  generate for (i2=0; i2<p_edma_queues[4:0]; i2=i2+1) begin : gen_nxt_frame_size
    wire queue_can_tx_dwrr;

    assign dwrr_en[i2]            = dwrr_ets_control[(i2*2)+1] && !dwrr_ets_control[(i2*2)];
    assign ets_en[i2]             = dwrr_ets_control[(i2*2)+1] && dwrr_ets_control[(i2*2)];
    assign dwrr_quantum[i2]       = bw_rate_limit[(7+(i2*8)):(i2*8)];
    assign queue_can_tx_dwrr      = gatestate[i2] & packets_in_q[i2] & (dwrr_def_cnt[i2] >= {2'b00,nxt_frame_size[i2]});
    assign nxt_frame_size[i2]     = nxt_frame_size_bus[((14*i2)+13):(14*i2)] ;
    assign byte_count_arr[i2]     = byte_count[((19*i2)+18):(19*i2)] ;

    reg  [15:0]  dwrr_def_cnt_sub;
    reg  [16:0]  dwrr_def_cnt_add;
    // Scheduler Code Start
    //
    //
    always@(*)
    begin
      // repeat process for every queue ...
        deficit_cntr_rst[i2] = 1'b0;

        // If the gatestate is low, or the allowed number of bytes from the 802.1Qbv module is
        // less than the frame size, then do not permit transmission
        if (!gatestate[i2] | ({byte_count_arr[i2]} < {5'b00000,nxt_frame_size[i2]}))
        begin
          queue_can_tx[i2] = 1'b0;
          deficit_cntr_rst[i2] = (!packets_in_q[i2]);
        end

        // If there are no frames to transmit, then we cannot transmit obviously ...
        // We also need to reset the deficit counters if there are no frames ...
        else if (!packets_in_q[i2])
        begin
          queue_can_tx[i2] = 1'b0;
          deficit_cntr_rst[i2] = 1'b1;
        end

        // CBS Specific
        // If CBS is enabled on the top queue, then only allow transmission to
        // continue if the CBS module permits it ...
        else if (cbs_q_a_id == i2[3:0] & cbs_enable_q_a)
          queue_can_tx[i2] = cbs_queue[0];

        // If CBS is enabled on 2nd top queue, then only allow transmission to
        // continue if the CBS module permits it ...
        else if (cbs_q_b_id == i2[3:0] & cbs_enable_q_b)
          queue_can_tx[i2] = cbs_queue[1];

        // Have we previously said we can send a frame on this queue and are still waiting for it to be serviced ?
        // If so, then we can transmit
        else if (queue_can_tx_str[i2])
          queue_can_tx[i2] = 1'b1;

        // ETS / DWRR specific ...
        // Is the deficit counter for this queue >= length of the frame at the head of the queue
        else if ((dwrr_en[i2] || ets_en[i2]) && queue_can_tx_dwrr && !(|queue_can_tx_str))
          queue_can_tx[i2] = 1'b1;

        // Otherwise we cant transmit, but we can increment the deficit counters ...
        else if (dwrr_en[i2] || ets_en[i2])
          queue_can_tx[i2] = 1'b0;

        // Non ETS/DWRR
        // In this case, we must be able to transmit, because there are frames available
        else
          queue_can_tx[i2] = 1'b1;
    end

    // Store the queue_can_tx bus. There will be times when more than one queue is allowed to transmit
    // We will loop through these in tuen in a round robin approach.
    // Also update the deficit counters here.  If ETS is enabled, the deficit counter is updated every 100
    // cycles, as the credit values passed in from the registers are percentage based.
    // For DWRR, the credit values are just weights, so we just update the counters every cycle.
    always @(*)
    begin
      if (reschedule_now & i2[3:0] == scheduled_queue)
        queue_can_tx_str_nxt[i2] = 1'b0;
      else if (reschedule_now & !(|queue_can_tx_str))
        queue_can_tx_str_nxt[i2] = queue_can_tx_dwrr;
      else
        queue_can_tx_str_nxt[i2] = queue_can_tx_str[i2];
    end

    always@(posedge tx_r_clk or negedge tx_r_rst_n)
    begin
      if (~tx_r_rst_n)
      begin
          dwrr_def_cnt[i2] <= 16'h0000;
      end
      else if (complete_flush)
      begin
          dwrr_def_cnt[i2] <= 16'h0000;
      end
      else
      begin
        if (deficit_cntr_rst[i2])
          dwrr_def_cnt[i2] <= 16'h0000;

        else if (!gatestate[i2] || (byte_count_arr[i2] < {5'b00000,nxt_frame_size[i2]}))
          dwrr_def_cnt[i2] <= dwrr_def_cnt[i2];

        else if (dwrr_en[i2]|ets_en[i2])
        begin
          if (|dwrr_def_cnt_sat) // if any of the queues have saturated ...
            dwrr_def_cnt[i2] <= dwrr_def_cnt_add[16:1];
          else
            dwrr_def_cnt[i2] <= dwrr_def_cnt_add[15:0];
        end
      end
    end

    always @(*)
    begin
      if (reschedule_now && (i2[3:0] == scheduled_queue))
        dwrr_def_cnt_sub = dwrr_def_cnt[i2] - {2'd0,nxt_frame_size[i2]};
      else
        dwrr_def_cnt_sub = dwrr_def_cnt[i2];

      if  ((update_ets_credit & ets_en[i2]) | (!(|queue_can_tx) && dwrr_en[i2] && !(|queue_can_tx_str) ))
        dwrr_def_cnt_add = dwrr_def_cnt_sub + dwrr_quantum[i2];
      else
        dwrr_def_cnt_add = {1'b0,dwrr_def_cnt_sub};
    end
    assign dwrr_def_cnt_sat[i2] = dwrr_def_cnt_add[16];

  end
  endgenerate

  assign any_ets_en = |ets_en;

  // For ETS, we need a counter that triggers every 100 or 200 cycles ...
  always@(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
    if (~tx_r_rst_n)
    begin
      update_ets_credit <= 1'b0;
      queue_can_tx_str  <= {p_edma_queues{1'b0}};
    end
    else if (complete_flush)
    begin
      update_ets_credit <= 1'b0;
      queue_can_tx_str  <= {p_edma_queues{1'b0}};
    end
    else
    begin
      if (any_ets_en)
      begin
        // Now we dont want to update the ETS credits if a queue that has an higher index to the ETS queues
        // is currently transmitting. If we dont block this, the credits for all the lower ETS queues will
        // continue to increment ...
        // if top queue is fixed priority, and queue that is transmitting is fixed priority, then stop the credit
        // counter ...
        if ((scheduled_queue > top_ets_queue) & queue_is_fp)
          update_ets_credit <= 1'b0;
        else
          update_ets_credit <= ets_credits_upd_tog;
      end

      queue_can_tx_str  <= queue_can_tx_str_nxt;
    end
  end

  assign nothing_to_xmit = !(|queue_can_tx);

  // Set the queue ID based on the above queue_can_tx bus ...
  // Pick the queue with the highest priority index in queue_can_tx
  integer queue_sel_cnt;
  always@(*)
  begin
    scheduled_queue = 4'h0;
    queue_is_fp     = 1'b0;
    top_ets_queue   = 4'h0;

    // Basically we can just look at queue_can_tx here. However the problem with doing that
    // is that for ETS, the credit will continue to increment on all queues, even if the current
    // queue transmitting is fixed priority. Identify if the queue being selected is fixed
    // priority and use that to block the queue.  Also identify the top ETS queue.
    for (queue_sel_cnt= 0; queue_sel_cnt<p_edma_queues[4:0]; queue_sel_cnt=queue_sel_cnt+ 1)
    begin
      // Identify which is the top ETS queue
      if (ets_en[queue_sel_cnt])
        top_ets_queue     = queue_sel_cnt;

      if (queue_can_tx[queue_sel_cnt])  // Fixed priority - highest queue num wins ...
      begin
        scheduled_queue = queue_sel_cnt;
        queue_is_fp     = ! (cbs_enable_q_a && (queue_sel_cnt[3:0] == cbs_q_a_id)) &&
                          ! (cbs_enable_q_b && (queue_sel_cnt[3:0]  == cbs_q_b_id)) &&
                          ! (dwrr_en[queue_sel_cnt] || ets_en[queue_sel_cnt]);
      end


    end
  end

`ifdef ABV_ON
  // ---------------------------------------------------------------------------------------
  // Write some assertions to check behaviour

  wire [15:0] dwrr_en_pad;
  wire [15:0] ets_en_pad;
  wire [15:0] cbs_en_pad;
  wire [16:0] packets_in_q_pad;
  wire [31:0] queue_can_tx_str_pad;
  wire [15:0] enough_credit;
  wire [15:0] credit_is_0;
  wire        resched_tick;

  assign resched_tick = reschedule_now & tx_r_clk;
  assign packets_in_q_pad[16] = 1'b0;
  generate
  for (i2=0; i2<p_edma_queues; i2=i2+1) begin : gen_pads
    assign dwrr_en_pad[i2]              = dwrr_en[i2];
    assign ets_en_pad[i2]               = ets_en[i2];
    assign cbs_en_pad[i2]               = (cbs_enable_q_a && (i2 == cbs_q_a_id)) ||
                                          (cbs_enable_q_b && (i2 == cbs_q_b_id));
    assign packets_in_q_pad[i2]         = packets_in_q[i2] && gatestate[i2] && ({5'b00000,nxt_frame_size[i2]} <= {byte_count_arr[i2]});
    assign queue_can_tx_str_pad[i2+16]  = queue_can_tx_str[i2];
    assign queue_can_tx_str_pad[i2]     = 1'b0;
    assign enough_credit[i2]            = (dwrr_def_cnt[i2] >= nxt_frame_size[i2]);
    assign credit_is_0[i2]              = dwrr_def_cnt[i2] == 0;
  end
  for (i2=p_edma_queues; i2<16; i2=i2+1) begin : gen_pads_none
    assign dwrr_en_pad[i2]              = 1'b0;
    assign ets_en_pad[i2]               = 1'b0;
    assign cbs_en_pad[i2]               = 1'b0;
    assign packets_in_q_pad[i2]         = 1'b0;
    assign queue_can_tx_str_pad[i2+16]  = 1'b0;
    assign queue_can_tx_str_pad[i2]     = 1'b0;
    assign enough_credit[i2]            = 1'b0;
    assign credit_is_0[i2]              = 1'b0;
  end
  endgenerate

  generate
  // 1. When ETS, CBS and DWRR are off, the scheduler should select the top priority in a fixed priority fashion
  for (i2=0; i2<p_edma_queues; i2=i2+1) begin : gen_prio
    property fipri_chk_q;
      @(negedge resched_tick)
        (!(dwrr_en_pad[i2]) && !(ets_en_pad[i2]) && !(cbs_en_pad[i2]) && packets_in_q_pad[i2] && !(|packets_in_q_pad[16:i2+1])) |-> scheduled_queue == i2;
    endproperty
    AP_fipri_chk_q : assert property (fipri_chk_q);

    // DWRR : Check that queues can only be transmitted when the deficit counter > length of the frame at head of the
    // queue and there are frames available to transmit. Only checks if more than 1 queue active.
    property dwrr_defcnt_chk_q;
      @(negedge resched_tick)
        (dwrr_en_pad[i2] && (scheduled_queue == i2) && (cbs_q_a_id > 0) && ~nothing_to_xmit) |-> packets_in_q_pad[i2] && enough_credit[i2];
    endproperty
    AP_dwrr_defcnt_chk_q : assert property (dwrr_defcnt_chk_q);

    // DWRR : Check that deficit counters reset when there are no frames to transmit ...
    property dwrr_defcnt_rst_q;
      @(negedge (tx_r_clk))
        (dwrr_en_pad[i2] && !packets_in_q_pad[i2]) |=> credit_is_0[i2];
    endproperty
    AP_dwrr_defcnt_rst_q : assert property (dwrr_defcnt_rst_q);

    // ETS and DWRR : Check the round robin like sequence ...
    // Essentially when multiple queues are identified as 'can transmit' on a 'reschedule_now' trigger, then those
    // must all be transmitted in the correct order
    if (p_edma_queues > 1)
    begin : gen_gt_1
    property dwrr_defcnt_rr_seq_q15;
      @(negedge (tx_r_clk))
        (reschedule_now && i2 > 0 && !(|queue_can_tx_str_pad[i2+16:16]) && scheduled_queue == i2) ##1  queue_can_tx_str_pad[(i2+16-1)]  |=> ##[0:$] scheduled_queue == i2 ##1 scheduled_queue == (i2-1);
    endproperty
    AP_dwrr_defcnt_rr_seq_q15 : assert property (dwrr_defcnt_rr_seq_q15);
    end

    if (p_edma_queues > 2)
    begin : gen_gt_2
    property dwrr_defcnt_rr_seq_q14;
      @(negedge (tx_r_clk))
        (reschedule_now && i2 > 1 && !(|queue_can_tx_str_pad[i2+16:16]) && scheduled_queue == i2) ##1 (queue_can_tx_str_pad[(i2+16-2)] && !(|queue_can_tx_str_pad[i2+16:i2+16-1])) |=> ##[0:$] scheduled_queue == i2 ##1 scheduled_queue == (i2-2);
    endproperty
    AP_dwrr_defcnt_rr_seq_q14 : assert property (dwrr_defcnt_rr_seq_q14);
    end

    if (p_edma_queues > 3)
    begin : gen_gt_3
    property dwrr_defcnt_rr_seq_q13;
      @(negedge (tx_r_clk))
        (reschedule_now && i2 > 2 && !(|queue_can_tx_str_pad[i2+16:16]) && scheduled_queue == i2) ##1 (queue_can_tx_str_pad[(i2+16-3)] && !(|queue_can_tx_str_pad[i2+16:i2+16-2])) |=> ##[0:$] scheduled_queue == i2 ##1 scheduled_queue == (i2-3);
    endproperty
    AP_dwrr_defcnt_rr_seq_q13 : assert property (dwrr_defcnt_rr_seq_q13);
    end

    if (p_edma_queues > 4)
    begin : gen_gt_4
    property dwrr_defcnt_rr_seq_q12;
      @(negedge (tx_r_clk))
        (reschedule_now && i2 > 3 && !(|queue_can_tx_str_pad[i2+16:16]) && scheduled_queue == i2) ##1 (queue_can_tx_str_pad[(i2+16-4)] && !(|queue_can_tx_str_pad[i2+16:i2+16-3])) |=> ##[0:$] scheduled_queue == i2 ##1 scheduled_queue == (i2-4);
    endproperty
    AP_dwrr_defcnt_rr_seq_q12 : assert property (dwrr_defcnt_rr_seq_q12);
    end

    if (p_edma_queues > 5)
    begin : gen_gt_5
    property dwrr_defcnt_rr_seq_q11;
      @(negedge (tx_r_clk))
        (reschedule_now && i2 > 4 && !(|queue_can_tx_str_pad[i2+16:16]) && scheduled_queue == i2) ##1 (queue_can_tx_str_pad[(i2+16-5)] && !(|queue_can_tx_str_pad[i2+16:i2+16-4])) |=> ##[0:$] scheduled_queue == i2 ##1 scheduled_queue == (i2-5);
    endproperty
    AP_dwrr_defcnt_rr_seq_q11 : assert property (dwrr_defcnt_rr_seq_q11);
    end

    if (p_edma_queues > 6)
    begin : gen_gt_6
    property dwrr_defcnt_rr_seq_q10;
      @(negedge (tx_r_clk))
        (reschedule_now && i2 > 5 && !(|queue_can_tx_str_pad[i2+16:16]) && scheduled_queue == i2) ##1 (queue_can_tx_str_pad[(i2+16-6)] && !(|queue_can_tx_str_pad[i2+16:i2+16-5])) |=> ##[0:$] scheduled_queue == i2 ##1 scheduled_queue == (i2-6);
    endproperty
    AP_dwrr_defcnt_rr_seq_q10 : assert property (dwrr_defcnt_rr_seq_q10);
    end

    if (p_edma_queues > 7)
    begin : gen_gt_7
    property dwrr_defcnt_rr_seq_q9;
      @(negedge (tx_r_clk))
        (reschedule_now && i2 > 6 && !(|queue_can_tx_str_pad[i2+16:16]) && scheduled_queue == i2) ##1 (queue_can_tx_str_pad[(i2+16-7)] && !(|queue_can_tx_str_pad[i2+16:i2+16-6])) |=> ##[0:$] scheduled_queue == i2 ##1 scheduled_queue == (i2-7);
    endproperty
    AP_dwrr_defcnt_rr_seq_q9 : assert property (dwrr_defcnt_rr_seq_q9);
    end

    if (p_edma_queues > 8)
    begin : gen_gt_8
    property dwrr_defcnt_rr_seq_q8;
      @(negedge (tx_r_clk))
        (reschedule_now && i2 > 7 && !(|queue_can_tx_str_pad[i2+16:16]) && scheduled_queue == i2) ##1 (queue_can_tx_str_pad[(i2+16-8)] && !(|queue_can_tx_str_pad[i2+16:i2+16-7])) |=> ##[0:$] scheduled_queue == i2 ##1 scheduled_queue == (i2-8);
    endproperty
    AP_dwrr_defcnt_rr_seq_q8 : assert property (dwrr_defcnt_rr_seq_q8);
    end

    if (p_edma_queues > 9)
    begin : gen_gt_9
    property dwrr_defcnt_rr_seq_q7;
      @(negedge (tx_r_clk))
        (reschedule_now && i2 > 8 && !(|queue_can_tx_str_pad[i2+16:16]) && scheduled_queue == i2) ##1 (queue_can_tx_str_pad[(i2+16-9)] && !(|queue_can_tx_str_pad[i2+16:i2+16-8])) |=> ##[0:$] scheduled_queue == i2 ##1 scheduled_queue == (i2-9);
    endproperty
    AP_dwrr_defcnt_rr_seq_q7 : assert property (dwrr_defcnt_rr_seq_q7);
    end

    if (p_edma_queues > 10)
    begin : gen_gt_10
    property dwrr_defcnt_rr_seq_q6;
      @(negedge (tx_r_clk))
        (reschedule_now && i2 > 9 && !(|queue_can_tx_str_pad[i2+16:16]) && scheduled_queue == i2) ##1 (queue_can_tx_str_pad[(i2+16-10)] && !(|queue_can_tx_str_pad[i2+16:i2+16-9])) |=> ##[0:$] scheduled_queue == i2 ##1 scheduled_queue == (i2-10);
    endproperty
    AP_dwrr_defcnt_rr_seq_q6 : assert property (dwrr_defcnt_rr_seq_q6);
    end

    if (p_edma_queues > 11)
    begin : gen_gt_11
    property dwrr_defcnt_rr_seq_q5;
      @(negedge (tx_r_clk))
        (reschedule_now && i2 > 10 && !(|queue_can_tx_str_pad[i2+16:16]) && scheduled_queue == i2) ##1 (queue_can_tx_str_pad[(i2+16-11)] && !(|queue_can_tx_str_pad[i2+16:i2+16-10])) |=> ##[0:$] scheduled_queue == i2 ##1 scheduled_queue == (i2-11);
    endproperty
    AP_dwrr_defcnt_rr_seq_q5 : assert property (dwrr_defcnt_rr_seq_q5);
    end

    if (p_edma_queues > 12)
    begin : gen_gt_12
    property dwrr_defcnt_rr_seq_q4;
      @(negedge (tx_r_clk))
        (reschedule_now && i2 > 11 && !(|queue_can_tx_str_pad[i2+16:16]) && scheduled_queue == i2) ##1 (queue_can_tx_str_pad[(i2+16-12)] && !(|queue_can_tx_str_pad[i2+16:i2+16-11])) |=> ##[0:$] scheduled_queue == i2 ##1 scheduled_queue == (i2-12);
    endproperty
    AP_dwrr_defcnt_rr_seq_q4 : assert property (dwrr_defcnt_rr_seq_q4);
    end

    if (p_edma_queues > 13)
    begin : gen_gt_13
    property dwrr_defcnt_rr_seq_q3;
      @(negedge (tx_r_clk))
        (reschedule_now && i2 > 12 && !(|queue_can_tx_str_pad[i2+16:16]) && scheduled_queue == i2) ##1 (queue_can_tx_str_pad[(i2+16-13)] && !(|queue_can_tx_str_pad[i2+16:i2+16-12])) |=> ##[0:$] scheduled_queue == i2 ##1 scheduled_queue == (i2-13);
    endproperty
    AP_dwrr_defcnt_rr_seq_q3 : assert property (dwrr_defcnt_rr_seq_q3);
    end

    if (p_edma_queues > 14)
    begin : gen_gt_14
    property dwrr_defcnt_rr_seq_q2;
      @(negedge (tx_r_clk))
        (reschedule_now && i2 > 13 && !(|queue_can_tx_str_pad[i2+16:16]) && scheduled_queue == i2) ##1 (queue_can_tx_str_pad[(i2+16-14)] && !(|queue_can_tx_str_pad[i2+16:i2+16-13])) |=> ##[0:$] scheduled_queue == i2 ##1 scheduled_queue == (i2-14);
    endproperty
    AP_dwrr_defcnt_rr_seq_q2 : assert property (dwrr_defcnt_rr_seq_q2);
    end

    if (p_edma_queues > 15)
    begin : gen_gt_15
    property dwrr_defcnt_rr_seq_q1;
      @(negedge (tx_r_clk))
        (reschedule_now && i2 > 14 && !(|queue_can_tx_str_pad[i2+16:16]) && scheduled_queue == i2) ##1 (queue_can_tx_str_pad[(i2+16-15)] && !(|queue_can_tx_str_pad[i2+16:i2+16-14])) |=> ##[0:$] scheduled_queue == i2 ##1 scheduled_queue == (i2-15);
    endproperty
    AP_dwrr_defcnt_rr_seq_q1 : assert property (dwrr_defcnt_rr_seq_q1);
    end

  end

  endgenerate

  // When CBS is active on top queue, then it must get priority
  property cbs_top_chk_q;
    @(negedge resched_tick)
      (cbs_queue[0] && packets_in_q_pad[cbs_q_a_id]) |-> scheduled_queue == cbs_q_a_id;
  endproperty
  AP_cbs_top_chk_q : assert property (cbs_top_chk_q);

  // When CBS is active on 2nd top queue, and top queue has fixed pri, then ensure CBS gets 2nd priority
  property cbs_chk_2nd_pri;
    @(negedge resched_tick)
      (cbs_queue[1] && packets_in_q_pad[cbs_q_a_id] && !cbs_enable_q_a && !dwrr_en_pad[cbs_q_a_id] && !ets_en_pad[cbs_q_a_id]) |-> scheduled_queue == cbs_q_a_id;
  endproperty
  AP_cbs_chk_2nd_pri : assert property (cbs_chk_2nd_pri);

  // When CBS is active, with credit on 2nd top queue, and top queue has ETS or DWRR, then ensure it gets 2nd priority
  wire enough_credit2;
  assign enough_credit2 = (dwrr_def_cnt[cbs_q_a_id] >= nxt_frame_size[cbs_q_a_id]);
  property cbs_chk_2nd_pri2;
    @(negedge resched_tick)
      (cbs_queue[1] && packets_in_q_pad[cbs_q_a_id]
          && (dwrr_en_pad[cbs_q_a_id] || ets_en_pad[cbs_q_a_id])
          && (enough_credit2)) |-> scheduled_queue == cbs_q_a_id;
  endproperty
  AP_cbs_chk_2nd_pri2 : assert property (cbs_chk_2nd_pri2);

  // When CBS is active, with credit on 2nd top queue, and top queue has ETS or DWRR but without sufficient credit, then CBS should win ...
  property cbs_chk_2nd_win;
    @(negedge resched_tick)
      (cbs_queue[1] && packets_in_q_pad[cbs_q_a_id]
          && (dwrr_en_pad[cbs_q_a_id] || ets_en_pad[cbs_q_a_id])
          && (dwrr_def_cnt[cbs_q_a_id] < nxt_frame_size[cbs_q_a_id])) |-> scheduled_queue == cbs_q_b_id;
  endproperty
  AP_cbs_chk_2nd_win : assert property (cbs_chk_2nd_win);

 `endif

endmodule

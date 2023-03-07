//------------------------------------------------------------------------------
// Copyright (c) 2005-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_tx_fifo_if.v
//   Module Name:        gem_tx_fifo_if
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
//   Description    : Arbitrates the FIFO interfaces acrss the queues
//                    using the TX scheduler
//
//----------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_tx_fifo_if #(

   parameter p_edma_exclude_cbs       = 1'b0,
   parameter p_edma_exclude_qbv       = 1'b0,
   parameter p_edma_spram             = 1'b0,
   parameter p_edma_queues            = 32'd1,
   parameter p_edma_tsu               = 1'b1,
   parameter p_edma_asf_prot_tx_sched = 1'b0

  ) (

   // System signals
   input                              tx_r_clk,            // tx_clk for fifo read clock.
   input                              tx_r_rst_n,          // n_txreset for fifo read reset.
   
   input                              tx_clk,              // tx_clk, needed for EnST
   input                              n_txreset,           // n_txreset, needed for EnST
   
   // Fifo input signals from gem_tx
   input                              tx_r_rd_int,         // Early version of the MAC FIFO read request

   // Fifo input signals from DMA
   input   [p_edma_queues-1:0]        tx_r_data_rdy_dma,   // Enough data in FIFO to begin TX.
   input                              dma_is_busy,         // Block rdy to MAC
   input   [p_edma_queues-1:0]        tx_r_frame_size_vld, // We have the frame size.
   input   [(p_edma_queues*14)-1:0]   tx_r_frame_size,     // Frame Length, 1 per queue
   input   [p_edma_queues-1:0]        tx_r_launch_time_vld,// Is there a launch time for this frame ?
   input   [(p_edma_queues*32)-1:0]   tx_r_launch_time,    // Launch time
   input                              tx_r_err,            // Some error condition
   input                              tx_r_eop,            // EOP from FIFO i.f
   input                              tx_r_valid,          // Valid from FIFO i/f

   // Fifo output signals to the MAC
   output                             tx_r_data_rdy_mac,   // Enough data in FIFO to begin TX.
   output wire[(p_edma_queues*14)-1:0]tx_r_frame_size_mac, // Frame Length, 1 per queue

   // Fifo output signals to the DMA
   output  [p_edma_queues-1:0]        tx_r_rd_int_dma,     // Early version, specific for C1000
   output  reg [p_edma_queues-1:0]    tx_r_rd_dma,         // gem tx requires a pop from the fifo.
   output  [3:0]                      tx_r_queue_int,      // early version, timed with tx_r_rd_int
   output  [3:0]                      tx_r_queue,          // Queue ID, timed with tx_r_rd

    // Static Signalling from register block
   input  [1:0]                       cbs_enable,          // Enable for CBS queues
   input  [3:0]                       cbs_q_a_id,
   input  [3:0]                       cbs_q_b_id,
   input                              tx_enable,           // Transmit enable
   input                              gigabit,             // Gigabit mode
   input                              bit_rate,            // 1 if 100M, 0 if 10M
   input                              two_pt_five_gig,     // 1 if 2.5Gbps
   // Credit Based Shaping support
   input  [31:0]                      idleslope_q_a,       // Rate of Change of credit for Queue A
   input  [31:0]                      idleslope_q_b,       // Rate of Change of credit for Queue B
   input  [31:0]                      port_tx_rate,        // TX Rate
   input                              mac_txing_dma_frame, // used by traffic shaper, set when MAC is TXing


   input  [31:0]                      dwrr_ets_control,
   input  [127:0]                     bw_rate_limit,

   input                              ets_upd_tog,
   output                             any_ets_en,

   // EnST signals
   input                              tsu_clk,
   input                              n_tsureset,
   input  [7:0]                       enst_en,                   // Enable signal
   input  [93:16]                     tsu_timer_cnt,             // Input from tsu
   input  [255:0]                     start_time,                // start_time of the transmission
   input  [135:0]                     on_time,                   // Number of bytes to transmit during on_time
   input  [135:0]                     off_time,                  // off time of the transmission expressed in bytes
   input  [1:0]                       add_frag_size,             // Encoded value of the number of bytes that pMAC
   output [p_edma_queues-1:0]         tsu_hold,                  // 802.3br support signal, tsu_clk sync-ed                                                       // can xmit before giving priority to the eMAC
   output                             asf_integrity_tx_sched_err // ASF Integrity check error in Transmit Scheduling
   );

  wire  [3:0]               scheduled_queue;
  reg   [3:0]               current_tx_queue_int;
  reg   [3:0]               current_tx_queue;
  wire                      nothing_to_xmit;
  reg                       transmitter_idle;
  reg                       dma_is_busy_r;
  reg                       tx_r_rd_mac;
  reg  [p_edma_queues-1:0]  pkts_in_q;
  wire                      reschedule_now;
  wire                      cbs_dma_q_a;         // used by traffic shaper,  Queue A is selected
  wire                      cbs_dma_q_b;         // used by traffic shaper,  Queue B is selected

  // EnST
  wire [(19*p_edma_queues)-1:0] byte_count_to_sched;
  wire      [p_edma_queues-1:0] gatestate_to_sched;

  // ASF Integrity check error in Transmit Scheduling
  wire                      asf_integrity_tx_enst_err;       // ASF Integrity check error in Transmit EnST
  wire                      asf_integrity_edma_tx_sched_err; // ASF Integrity check error in Transmit Scheduler

  // So basically we can allow frames through just based on tx_r_data_rdy_dma if DWRR/ETS is disabled.
  // For ETS and DWRR we also need the frame_size
  // Here we also perform the launch time checks ..
  //  The 32 bit launch time will be compared against the equivalent 32 bits in the TSU timer when the
  //  descriptor is first read by the DMA. If the 2 seconds bits match then transmission will be delayed
  //  if the 30 bit TSU nanosecond value is less than that of the launch time nanosecond value.
  //  Transmission of the frame will be delayed until the nanoseconds value of the TSU reaches that of the launch time.
  //  Transmission will also be delayed if the 2 seconds bits of the launch time is one more than that of the TSU
  //  regardless of the nanosecond value. This will allow frame transmission to be delayed at least one second
  //  beyond the current TSU time. Transmission will then start when the TSU seconds value matches the launch time value
  //  and the TSU nanoseconds reaches that of the launch time.
  //  If the launch time seconds value is 2 or more above that of the TSU then frame transmission will not be delayed.
  //  The TSU timer value is just synchronised as fast as possible.
  wire [31:0] tsu_timer_cnt_txclk;
  generate if (p_edma_tsu == 1'b1) begin : gen_tsu_sync
    gem_bus_sync #(
      .p_dwidth (32),
      .p_reg_out(1)
    ) i_sync_tsu_cnt_tx_r_clk (
      .src_clk      (tsu_clk),
      .src_rst_n    (n_tsureset),
      .dest_clk     (tx_r_clk),
      .dest_rst_n   (tx_r_rst_n),
      .src_data     (tsu_timer_cnt[47:16]),
      .src_xfer_en  (1'b1),
      .src_data_last(),
      .src_rdy      (),
      .dest_data    (tsu_timer_cnt_txclk),
      .dest_val     ()
    );
  end else begin : gen_no_tsu_sync
    assign tsu_timer_cnt_txclk  = 32'd0;
  end
  endgenerate

  genvar g1;
  generate for (g1=0; g1<p_edma_queues[4:0]; g1=g1+1) begin : gen_current_pkt_len
    wire pkts_in_q_pre;
    assign pkts_in_q_pre      = dwrr_ets_control[g1*2+1] ? tx_r_data_rdy_dma[g1] & tx_r_frame_size_vld[g1]
                                                         : tx_r_data_rdy_dma[g1];
    wire [31:0] launch_time_local;
    assign launch_time_local = tx_r_launch_time[(g1*32)+31:(g1*32)];
    always @(*)
    begin
      casex ({tsu_timer_cnt_txclk[31:30],launch_time_local[31:30]})
        4'b0001,4'b0110,4'b1011,4'b1100   : pkts_in_q[g1]      = !tx_r_launch_time_vld[g1] && pkts_in_q_pre;
        4'b0000,4'b0101,4'b1010,4'b1111   : pkts_in_q[g1]      = pkts_in_q_pre && (!tx_r_launch_time_vld[g1] || (tsu_timer_cnt_txclk[29:0] >= launch_time_local[29:0]));
        default                           : pkts_in_q[g1]      = pkts_in_q_pre;
      endcase
    end
  end
  endgenerate


  // The choice of queue can be made on the last read of the packet.
  // Or if there is nothing currently being transmitted ...
  always@(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
    if (~tx_r_rst_n)
    begin
      transmitter_idle     <= 1'b1;
      current_tx_queue     <= 4'h0;
      current_tx_queue_int <= 4'h0;
      dma_is_busy_r        <= 1'b0;
    end
    else
    begin
      if (!tx_enable)
      begin
        transmitter_idle     <= 1'b1;
        current_tx_queue     <= 4'h0;
        current_tx_queue_int <= 4'h0;
        dma_is_busy_r        <= 1'b0;
      end
      else
      begin
        if (reschedule_now)
          current_tx_queue_int <= scheduled_queue;
        current_tx_queue       <= current_tx_queue_int;
        dma_is_busy_r          <= dma_is_busy;

        if ((tx_r_valid & tx_r_eop) | tx_r_err)
        begin
          transmitter_idle  <= 1'b1;
        end
        else if (tx_r_rd_mac)
        begin
          transmitter_idle  <= 1'b0;
        end
      end
    end
  end

  // Toggle detect ets_upd_tog
  wire ets_credits_upd_tog;
  edma_sync_toggle_detect i_tog_det_ets_upd (
    .clk(tx_r_clk),
    .reset_n(tx_r_rst_n),
    .din(ets_upd_tog),
    .rise_edge(),
    .fall_edge(),
    .any_edge(ets_credits_upd_tog)
  );

// instantiate the Traffic Based Shaper ...
  wire                      cbs_enable_q_a;
  wire                      cbs_enable_q_b;

  generate if (p_edma_exclude_cbs == 1'b0 && p_edma_queues > 32'd1) begin : gen_instance_shaper

  cdnsdru_datasync_v1 #(.CDNSDRU_DATASYNC_DIN_W(2)) i_cdnsdru_datasync_v1_cbs_enable (
    .clk                       (tx_r_clk),
    .reset_n                   (tx_r_rst_n),
    .din                       (cbs_enable),
    .dout                      ({cbs_enable_q_b,cbs_enable_q_a})
  );

  end else begin : gen_no_cbs
    assign cbs_enable_q_a = 1'b0;
    assign cbs_enable_q_b = 1'b0;
  end
  endgenerate
  
  assign reschedule_now = !nothing_to_xmit & tx_r_rd_int & transmitter_idle;
  edma_tx_sched #(.p_edma_exclude_cbs (p_edma_exclude_cbs),
                  .p_edma_queues      (p_edma_queues)
                      ) i_edma_tx_sched (

         .tx_r_clk            (tx_r_clk),
         .tx_r_rst_n          (tx_r_rst_n),
         .complete_flush      (!tx_enable),

         .packets_in_q_nxt    (tx_r_data_rdy_dma),  // Can be set even if there is no frame size (used by CBS function)
         .packets_in_q        (pkts_in_q),
         .byte_count          (byte_count_to_sched),
         .gatestate           (gatestate_to_sched),
         .nxt_frame_size_bus  (tx_r_frame_size),
         .reschedule_now      (reschedule_now),
         .cbs_dma_q_a         (cbs_dma_q_a),
         .cbs_dma_q_b         (cbs_dma_q_b),
         .mac_txing_dma_frame (mac_txing_dma_frame),

         .cbs_q_a_id          (cbs_q_a_id),
         .cbs_q_b_id          (cbs_q_b_id),
         .idleslope_q_a       (idleslope_q_a),
         .idleslope_q_b       (idleslope_q_b),
         .port_tx_rate        (port_tx_rate),
         .dwrr_ets_control    (dwrr_ets_control),
         .bw_rate_limit       (bw_rate_limit),
         .cbs_enable_q_a      (cbs_enable_q_a),
         .cbs_enable_q_b      (cbs_enable_q_b),
         .ets_credits_upd_tog (ets_credits_upd_tog),
         .any_ets_en          (any_ets_en),
         .scheduled_queue     (scheduled_queue),
         .nothing_to_xmit     (nothing_to_xmit)
  );


  //------------------------------------------------------------------------------
  // ASF - instantiate edma_tx_sched
  // Duplication Protection of Transmit Scheduler
  //------------------------------------------------------------------------------
  generate if (p_edma_asf_prot_tx_sched == 1'b1) begin : gen_edma_tx_sched_protect

         wire       any_ets_en_dplc;
         wire [3:0] scheduled_queue_dplc;
         wire       nothing_to_xmit_dplc;

         edma_tx_sched #(.p_edma_exclude_cbs (p_edma_exclude_cbs),
                         .p_edma_queues      (p_edma_queues)
                              ) i_edma_tx_sched_asf_duplc (

                 .tx_r_clk            (tx_r_clk),
                 .tx_r_rst_n          (tx_r_rst_n),
                 .complete_flush      (!tx_enable),

                 .packets_in_q_nxt    (tx_r_data_rdy_dma),  // Can be set even if there is no frame size (used by CBS function)
                 .packets_in_q        (pkts_in_q),
                 .byte_count          (byte_count_to_sched),
                 .gatestate           (gatestate_to_sched),
                 .nxt_frame_size_bus  (tx_r_frame_size),
                 .reschedule_now      (reschedule_now),
                 .cbs_dma_q_a         (cbs_dma_q_a),
                 .cbs_dma_q_b         (cbs_dma_q_b),
                 .mac_txing_dma_frame (mac_txing_dma_frame),

                 .cbs_q_a_id          (cbs_q_a_id),
                 .cbs_q_b_id          (cbs_q_b_id),
                 .idleslope_q_a       (idleslope_q_a),
                 .idleslope_q_b       (idleslope_q_b),
                 .port_tx_rate        (port_tx_rate),
                 .dwrr_ets_control    (dwrr_ets_control),
                 .bw_rate_limit       (bw_rate_limit),
                 .cbs_enable_q_a      (cbs_enable_q_a),
                 .cbs_enable_q_b      (cbs_enable_q_b),
                 .ets_credits_upd_tog (ets_credits_upd_tog),
                 .any_ets_en          (any_ets_en_dplc),
                 .scheduled_queue     (scheduled_queue_dplc),
                 .nothing_to_xmit     (nothing_to_xmit_dplc)
            );

         assign asf_integrity_edma_tx_sched_err = ({any_ets_en,
                                                     scheduled_queue,
                                                     nothing_to_xmit}) != ({any_ets_en_dplc,
                                                                             scheduled_queue_dplc,
                                                                             nothing_to_xmit_dplc});

  end else begin : gen_no_edma_tx_sched_protect
    assign asf_integrity_edma_tx_sched_err = 1'b0;
  end
  endgenerate

  // There is considerable combinatorial logic behind tx_r_rd_int, and since
  // there is a lot of combi logic following it also, it needs to be registered ...
    always@(posedge tx_r_clk or negedge tx_r_rst_n)
    begin
      if (~tx_r_rst_n)
      begin
        tx_r_rd_mac             <= 1'b0;
      end
      else if (!tx_enable)
      begin
        tx_r_rd_mac             <= 1'b0;
      end
      else
      begin
        tx_r_rd_mac             <= tx_r_rd_int;
      end
    end

  assign tx_r_frame_size_mac = tx_r_frame_size;

  genvar g2;
  generate for (g1=0; g1<p_edma_queues[4:0]; g1=g1+1) begin : gen_tx_r_rd_int_dma
  assign tx_r_rd_int_dma[g1]  =  (tx_r_rd_mac & current_tx_queue_int == g1[3:0]);

  end
  endgenerate

  always@(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
    if (~tx_r_rst_n)
    begin
      tx_r_rd_dma       <= {p_edma_queues{1'b0}};
    end
    else
    begin
      if (!tx_enable)
        tx_r_rd_dma     <= {p_edma_queues{1'b0}};
      else
        tx_r_rd_dma     <= tx_r_rd_int_dma;
    end
  end


  assign tx_r_queue_int = current_tx_queue_int;
  assign tx_r_queue     = current_tx_queue;

  assign cbs_dma_q_a = (current_tx_queue == cbs_q_a_id[3:0]);
  assign cbs_dma_q_b = (current_tx_queue == cbs_q_b_id[3:0]);

  // If any of the queues have sufficient data to transmit, then we inform the MAC that we can transmit ...
  // We also hold this until just before the EOP for SPRAM modes ..
  assign tx_r_data_rdy_mac  = !nothing_to_xmit && !dma_is_busy_r ;//| !(transmitter_idle | ((tx_r_valid & tx_r_eop) | tx_r_err));

//----------------------------------------------------------------------------
// EnST instatiation
//----------------------------------------------------------------------------
//

  // No EnSt functions are included in the design
  // Lint warnings will occur due to unused inputs
  generate
    if (p_edma_exclude_qbv == 1)
      begin : gen_no_enst
        assign tsu_hold                  = {p_edma_queues{1'b0}};
        assign gatestate_to_sched        = {p_edma_queues{1'b1}};
        assign byte_count_to_sched       = {(p_edma_queues*19){1'b1}};
        assign asf_integrity_tx_enst_err = 1'b0;
      end
    else
      begin : gen_enst_module
        //Creation of a synthethic parameter named speed indicating the speed_mode.
        reg [1:0] speed;

        always @ (two_pt_five_gig, gigabit, bit_rate)
        begin
          if(two_pt_five_gig)
            speed = 2'b00;
          else
            begin
              if(gigabit)
                speed = 2'b01;
              else
                begin
                  if(bit_rate)
                    speed = 2'b10;
                  else
                    speed = 2'b11;
                end
            end
        end
      if(p_edma_queues < 32'd9)
        begin: gen_enst1
          genvar g3;
          wire      [p_edma_queues-1:0] asf_integrity_tx_enst_fsm_err;
          wire      [p_edma_queues-1:0] asf_integrity_tx_enst_fc_err;
          wire [(19*p_edma_queues)-1:0] byte_count_tx;
          wire      [p_edma_queues-1:0] gatestate_tx;

          for (g3=0; g3<p_edma_queues; g3=g3+1)
            begin : gen_edma_pbuf_tx_enst1
              edma_pbuf_tx_enst #(
                  .p_edma_asf_prot_tx_sched(p_edma_asf_prot_tx_sched)
              ) i_edma_pbuf_tx_enst (
                .tx_clk                       (tx_clk),
                .n_txreset                    (n_txreset),
                .tsu_clk                      (tsu_clk),
                .n_tsureset                   (n_tsureset),
                .enst_en                      (enst_en[g3]),
                .tsu_timer_cnt                (tsu_timer_cnt),
                .start_time                   (start_time[((32*g3)+31):(32*g3)]),
                .on_time                      (on_time[((17*g3)+16):(17*g3)]),
                .off_time                     (off_time[((17*g3)+16):(17*g3)]),
                .speed                        (speed),
                .add_frag_size                (add_frag_size),
                .byte_count                   (byte_count_tx[((19*g3)+18):(19*g3)]),
                .gatestate                    (gatestate_tx[g3]),
                .tsu_hold                     (tsu_hold[g3]),
                .asf_integrity_tx_enst_fsm_err(asf_integrity_tx_enst_fsm_err[g3]),
                .asf_integrity_tx_enst_fc_err (asf_integrity_tx_enst_fc_err[g3])
              );
              
              // We need to synchronize the gatestate and the bytecount output from
              // the EnST module to be sync-ed into the same clock domain they're 
              // used which is the scheduler.
              if(p_edma_spram == 1'b1) begin: gen_sync_from_enst1_to_sched
              
                // Syncronizing byte_count from the EnST module (tx_clk) to
                // the scheduler, which works at tx_r_clk = hclk in this case
                gem_bus_sync #(
                  .p_dwidth (19),
                  .p_reg_out(1)
                ) i_sync_byte_count_enst1_to_sched (
                  .src_clk      (tx_clk),
                  .src_rst_n    (n_txreset),
                  .dest_clk     (tx_r_clk),
                  .dest_rst_n   (tx_r_rst_n),
                  .src_data     (byte_count_tx[((19*g3)+18):(19*g3)]),
                  .src_xfer_en  (1'b1),
                  .src_data_last(),
                  .src_rdy      (),
                  .dest_data    (byte_count_to_sched[((19*g3)+18):(19*g3)]),
                  .dest_val     ()
                );
                
                // Syncronizing gatestate from the EnST module (tx_clk) to
                // the scheduler, which works at tx_r_clk = hclk in this case
                cdnsdru_datasync_v1 #(
                  .CDNSDRU_DATASYNC_DIN_W(1)
                ) i_sync_gatestate_enst1_to_sched (
                  .clk     (tx_r_clk),
                  .reset_n (tx_r_rst_n),
                  .din     (gatestate_tx[g3]),
                  .dout    (gatestate_to_sched[g3])
                );
                
              end else begin: no_gen_sync_from_enst1_to_sched
                // Scheduler works in tx_clk domain so no need for any synchronization
                assign gatestate_to_sched [g3]                   = gatestate_tx [g3];
                assign byte_count_to_sched[((19*g3)+18):(19*g3)] = byte_count_tx[((19*g3)+18):(19*g3)];
              end
              
            end
            
            // we need to synchronize the asf_integrity_tx_enst_fsm_err from the tsu
            // domain to the tx_r_clk domain (in which the scheduler works).
            if (p_edma_asf_prot_tx_sched == 1'b1) begin : gen_asf_sched_prot
              wire  asf_integrity_tx_enst_fsm_err_tx_r_clk;
              gem_pulse_tsync i_psync_asf_dap_dma_err_enst_fsm (
                .src_clk    (tsu_clk),
                .src_rst_n  (n_tsureset),
                .dest_clk   (tx_r_clk),
                .dest_rst_n (tx_r_rst_n),
                .src_in     (|asf_integrity_tx_enst_fsm_err),
                .dest_pulse (asf_integrity_tx_enst_fsm_err_tx_r_clk)
              );
              
              // We need to synchronize the asf_integrity_tx_enst_fc_err from the tx_clk
              // to the tx_r_clk (in which the scheduler works). If in spram mode 
              // then the sync is going to be necessary, otherwise tx_r_clk will be tx_clk
              // and then no sync is required
              wire asf_integrity_tx_enst_fc_err_tx_r_clk;
              if(p_edma_spram == 1'b1) begin: gen_enst_fc_err_sync_to_tx_r_clk
                gem_pulse_tsync i_psync_asf_dap_dma_err_enst_fc (
                  .src_clk    (tx_clk),
                  .src_rst_n  (n_txreset),
                  .dest_clk   (tx_r_clk),
                  .dest_rst_n (tx_r_rst_n),
                  .src_in     (|asf_integrity_tx_enst_fc_err),
                  .dest_pulse (asf_integrity_tx_enst_fc_err_tx_r_clk)
                );
              end else begin: no_gen_enst_fc_err_sync_to_tx_r_clk
                assign asf_integrity_tx_enst_fc_err_tx_r_clk = |asf_integrity_tx_enst_fc_err;
              end
              
              assign asf_integrity_tx_enst_err  = asf_integrity_tx_enst_fsm_err_tx_r_clk | asf_integrity_tx_enst_fc_err_tx_r_clk;
            end else begin : gen_no_asf_sched_prot
              // Don't care when no protection as the modules just drive to 0, no CDC required. This is just to
              // avoid warnings from some synthesis tools.
              assign asf_integrity_tx_enst_err  = |{asf_integrity_tx_enst_fsm_err,asf_integrity_tx_enst_fc_err};
            end
        end
      else
        if(p_edma_queues > 32'd8)
          begin: gen_enst2
            genvar g3;
            wire   [7:0] int_gatestate_tx;
            wire   [7:0] int_gatestate_to_sched;
            wire   [7:0] int_tsu_hold;
            wire [151:0] int_byte_count_tx;
            wire [151:0] int_byte_count_to_sched;
            wire   [7:0] asf_integrity_tx_enst_fsm_err;
            wire   [7:0] asf_integrity_tx_enst_fc_err;

            for (g3=p_edma_queues-8; g3<p_edma_queues; g3=g3+1)
              begin : gen_edma_pbuf_tx_enst2
                edma_pbuf_tx_enst #(
                  .p_edma_asf_prot_tx_sched(p_edma_asf_prot_tx_sched)
                ) i_edma_pbuf_tx_enst (
                .tx_clk                       (tx_clk),
                .n_txreset                    (n_txreset),
                .tsu_clk                      (tsu_clk),
                .n_tsureset                   (n_tsureset),
                .enst_en                      (enst_en[g3-p_edma_queues+8]),
                .tsu_timer_cnt                (tsu_timer_cnt),
                .start_time                   (start_time[((32*(g3[31:0]-p_edma_queues+32'd8))+32'd31):(32*(g3[31:0]-p_edma_queues+32'd8))]),
                .on_time                      (on_time[((17*(g3[31:0]-p_edma_queues+32'd8))+16):(17*(g3[31:0]-p_edma_queues+32'd8))]),
                .off_time                     (off_time[((17*(g3[31:0]-p_edma_queues+32'd8))+16):(17*(g3[31:0]-p_edma_queues+32'd8))]),
                .speed                        (speed),
                .add_frag_size                (add_frag_size),
                .byte_count                   (int_byte_count_tx[((19*(g3[4:0]-p_edma_queues+32'd8))+18):(19*(g3[4:0]-p_edma_queues+32'd8))]),
                .gatestate                    (int_gatestate_tx[g3-p_edma_queues+8]),
                .tsu_hold                     (int_tsu_hold[g3-p_edma_queues+8]),
                .asf_integrity_tx_enst_fsm_err(asf_integrity_tx_enst_fsm_err[g3-p_edma_queues+8]),
                .asf_integrity_tx_enst_fc_err (asf_integrity_tx_enst_fc_err[g3-p_edma_queues+8])
                );
                
                // We need to synchronize the gatestate and the bytecount output from
                // the EnST module to be sync-ed to the same clock domain they're used
                // which is the scheduler.
                if(p_edma_spram == 1'b1) begin: gen_sync_from_enst2_to_sched
                
                  // Syncronizing byte_count from the EnST module (tx_clk) to
                  // the scheduler, which works at tx_r_clk = hclk in this case
                  gem_bus_sync #(
                    .p_dwidth (19),
                    .p_reg_out(1)
                  ) i_sync_byte_count_enst2_to_sched (
                    .src_clk      (tx_clk),
                    .src_rst_n    (n_txreset),
                    .dest_clk     (tx_r_clk),
                    .dest_rst_n   (tx_r_rst_n),
                    .src_data     (int_byte_count_tx[((19*(g3[4:0]-p_edma_queues+32'd8))+18):(19*(g3[4:0]-p_edma_queues+32'd8))]),
                    .src_xfer_en  (1'b1),
                    .src_data_last(),
                    .src_rdy      (),
                    .dest_data    (int_byte_count_to_sched[((19*(g3[4:0]-p_edma_queues+32'd8))+18):(19*(g3[4:0]-p_edma_queues+32'd8))]),
                    .dest_val     ()
                  );
                  
                  // Syncronizing gatestate from the EnST module (tx_clk) to
                  // the scheduler, which works at tx_r_clk = hclk in this case
                  cdnsdru_datasync_v1 #(
                    .CDNSDRU_DATASYNC_DIN_W(1)
                  ) i_sync_gatestate_enst2_to_sched (
                    .clk     (tx_r_clk),
                    .reset_n (tx_r_rst_n),
                    .din     (int_gatestate_tx      [g3-p_edma_queues+8]),
                    .dout    (int_gatestate_to_sched[g3-p_edma_queues+8])
                  );

                end else begin: no_gen_sync_from_enst2_to_sched
                  // Scheduler works in tx_clk domain so no need for any synchronization
                  assign int_gatestate_to_sched[g3-p_edma_queues+8] = 
                         int_gatestate_tx      [g3-p_edma_queues+8];
                         
                  assign int_byte_count_to_sched[((19*(g3[4:0]-p_edma_queues+32'd8))+18):(19*(g3[4:0]-p_edma_queues+32'd8))] = 
                         int_byte_count_tx      [((19*(g3[4:0]-p_edma_queues+32'd8))+18):(19*(g3[4:0]-p_edma_queues+32'd8))];
                end
              end
            assign gatestate_to_sched  = {int_gatestate_to_sched, {((p_edma_queues-8)){1'b1}}};
            assign tsu_hold            = {int_tsu_hold,           {((p_edma_queues-8)){1'b1}}};
            assign byte_count_to_sched = {int_byte_count_to_sched,{(((p_edma_queues-8)*19)){1'b1}}};
            
            // we need to synchronize the asf_integrity_tx_enst_fsm_err from the tsu
            // domain to the tx_r_clk domain (in which the scheduler works).
            if (p_edma_asf_prot_tx_sched == 1'b1) begin : gen_asf_sched_prot
              wire  asf_integrity_tx_enst_fsm_err_tx_r_clk;
              gem_pulse_tsync i_psync_asf_dap_dma_err_enst_fsm_err (
                .src_clk    (tsu_clk),
                .src_rst_n  (n_tsureset),
                .dest_clk   (tx_r_clk),
                .dest_rst_n (tx_r_rst_n),
                .src_in     (|asf_integrity_tx_enst_fsm_err),
                .dest_pulse (asf_integrity_tx_enst_fsm_err_tx_r_clk)
              );
              
              // We need to synchronize the asf_integrity_tx_enst_fc_err from the tx_clk
              // to the tx_r_clk (in which the scheduler works). If in spram mode 
              // then the sync is going to be necessary, otherwise tx_r_clk will be tx_clk
              // and then no sync is required
              wire  asf_integrity_tx_enst_fc_err_tx_r_clk;
              if(p_edma_spram == 1'b1) begin: gen_tx_enst_fc_err_to_tx_r_clk
                gem_pulse_tsync i_psync_asf_dap_dma_err_enst_fc_err (
                  .src_clk    (tx_clk),
                  .src_rst_n  (n_txreset),
                  .dest_clk   (tx_r_clk),
                  .dest_rst_n (tx_r_rst_n),
                  .src_in     (|asf_integrity_tx_enst_fc_err),
                  .dest_pulse (asf_integrity_tx_enst_fc_err_tx_r_clk)
              );
              end else begin: no_gen_tx_enst_fc_err_to_tx_r_clk
                assign asf_integrity_tx_enst_fc_err_tx_r_clk = |asf_integrity_tx_enst_fc_err;
              end
              
              assign asf_integrity_tx_enst_err  = asf_integrity_tx_enst_fsm_err_tx_r_clk | asf_integrity_tx_enst_fc_err_tx_r_clk;
            end else begin : gen_no_asf_sched_prot
              // Don't care when no protection as the modules just drive to 0, no CDC required. This is just to
              // avoid warnings from some synthesis tools.
              assign asf_integrity_tx_enst_err  = |{asf_integrity_tx_enst_fsm_err,asf_integrity_tx_enst_fc_err};
            end

          end
      
      end
  endgenerate

  assign asf_integrity_tx_sched_err = asf_integrity_tx_enst_err | asf_integrity_edma_tx_sched_err;

endmodule


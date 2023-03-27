//------------------------------------------------------------------------------
// Copyright (c) 2012-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_ext_fifo_mux.v
//   Module Name:        gem_ext_fifo_mux
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
//   Description :             Low Latency MUX to prioritise ext fifo port
//                             over DMA path in TX direction.
//                             The status and data paths are controlled
//                             separately as status returns after data path
//                             may have switched.
//
//                             The flushed signal is used differently in the MAC
//                             depending on the tx_r_underflow and underflow_frame
//                             signal activity, ie 'real_underflow' caused by
//                             tx_r_underflow needs flushed but other causes
//                             of undeflow_frame do not.
//                             It has been decided to implement the muxing to expect
//                             a flushed signal whenever MAC status is non-zero as this
//                             is consistent with spec and will unterwork with MAC.
//
//                             The was a requirement (martinj) to add zero latency of
//                             signals through this module.
//
//
//      Original Author :      Brian Torley
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_ext_fifo_mux (

   // tx_clk from MAC
   tx_clk,


   // system interface (resets)
   n_txreset,


   // Connections to external tx fifo interface

   tx_r_data_ext,
   tx_r_data_par_ext,
   tx_r_mod_ext,
   tx_r_sop_ext,
   tx_r_eop_ext,
   tx_r_err_ext,
   tx_r_valid_ext,
   tx_r_data_rdy_ext,
   tx_r_underflow_ext,
   tx_r_rd_ext,
   tx_r_queue_ext,
   tx_r_flushed_ext,
   tx_r_control_ext,
   tx_r_frame_size_ext,
   tx_r_frame_size_vld_ext,
   tx_r_launch_time_ext,
   tx_r_launch_time_vld_ext,
   dma_tx_status_tog_ext,
   dma_tx_end_tog_ext,
   late_coll_occured_ext,
   too_many_retries_ext,
   underflow_frame_ext,
   collision_occured_ext,


   // Connections to DMA interface

   tx_r_data_dma,
   tx_r_data_par_dma,
   tx_r_mod_dma,
   tx_r_sop_dma,
   tx_r_eop_dma,
   tx_r_err_dma,
   tx_r_valid_dma,
   tx_r_data_rdy_dma,
   tx_r_underflow_dma,
   tx_r_rd_dma,
   tx_r_queue_dma,
   tx_r_rd_int_dma,
   tx_r_queue_int_dma,
   tx_r_flushed_dma,
   tx_r_control_dma,
   tx_r_frame_size_vld_dma,
   tx_r_frame_size_dma,
   tx_r_launch_time_vld_dma,
   tx_r_launch_time_dma,
   dma_tx_status_tog_dma,
   dma_tx_end_tog_dma,
   `ifdef extra_spec_add
     add_match_vec_dma,
   `endif // extra_spec_add
   late_coll_occured_dma,
   too_many_retries_dma,
   underflow_frame_dma,
   collision_occured_dma,


   // Connections to MAC

   tx_r_data_mac,
   tx_r_data_par_mac,
   tx_r_mod_mac,
   tx_r_sop_mac,
   tx_r_eop_mac,
   tx_r_err_mac,
   tx_r_valid_mac,
   tx_r_data_rdy_mac,
   tx_r_underflow_mac,
   tx_r_rd_mac,
   tx_r_queue_mac,
   tx_r_rd_int_mac,
   tx_r_queue_int_mac,
   tx_r_flushed_mac,
   tx_r_control_mac,
   tx_r_frame_size_mac,
   tx_r_frame_size_vld_mac,
   tx_r_launch_time_mac,
   tx_r_launch_time_vld_mac,
   dma_tx_status_tog_mac,
   dma_tx_end_tog_mac,
  `ifdef extra_spec_add
     add_match_vec_mac,
   `endif // extra_spec_add
   late_coll_occured_mac,
   too_many_retries_mac,
   underflow_frame_mac,
   collision_occured_mac


   );

   parameter p_edma_queues      = 0;

// data mux state decode paramater declarations.
   parameter
      DATA_IDLE               = 3'b000, // idle state.
      DATA_AVAIL_EXT          = 3'b001, //
      DATA_AVAIL_DMA          = 3'b010, //
      SOP_DET_EXT             = 3'b011, //
      SOP_DET_DMA             = 3'b100; //


// status mux state decode paramater declarations.
   parameter
      STATUS_IDLE              = 2'b00, // idle state.
      WAIT_STATUS_EXT          = 2'b01, //
      WAIT_STATUS_DMA          = 2'b10; //



// define useful names
   parameter SELECT_EXT_FIFO = 1'b1;
   parameter SELECT_DMA      = 1'b0;



//------------------------------------------------------------------------------
// Declare inputs and outputs
//------------------------------------------------------------------------------


   // system interface (resets)
   input          n_txreset;         // tx_clk domain reset


   // gmii / mii ethernet interface.
   input          tx_clk;            // transmit clock from the phy.


   // external tx fifo interface.
   input  [127:0] tx_r_data_ext;     // output data from the transmit fifo
                                     // to the tx module.
   input  [15:0]  tx_r_data_par_ext;
   input    [3:0] tx_r_mod_ext;      // tx number of valid bytes in last
                                     // transfer of the frame.
                                     // 0000 - tx_r_data[127:0] valid,
                                     // 0001 - tx_r_data[7:0] valid,
                                     // 0010 - tx_r_data[15:0] valid, until
                                     // 1111 - tx_r_data[119:0] valid.
   input          tx_r_sop_ext;      // start of packet indicator.
   input          tx_r_eop_ext;      // end of packet indicator.
   input          tx_r_err_ext;      // packet in error indicator.
   output  [p_edma_queues-1:0]  tx_r_rd_ext;       // request new data from fifo.
   output  [3:0]  tx_r_queue_ext;    // Queue ID
   input          tx_r_valid_ext;    // new tx data available from fifo.
   input   [p_edma_queues-1:0]  tx_r_data_rdy_ext; // indicates either a complete packet
                                     // is present in the fifo or a certain
                                     // threshold of data has been crossed,
                                     // the mac uses this input to trigger
                                     // a frame transfer.
   input          tx_r_underflow_ext;// signals tx fifo underrun condition.
   input          tx_r_flushed_ext;  // tx fifo has been flushed.
   input          tx_r_control_ext;  // tx control from in-line FIFO word
   input   [p_edma_queues-1:0]        tx_r_frame_size_vld_ext; // We have the frame size.
   input   [(p_edma_queues*14)-1:0]   tx_r_frame_size_ext;     // Frame Length, 1 per queue
   input   [p_edma_queues-1:0]        tx_r_launch_time_vld_ext; // We have the frame size.
   input   [(p_edma_queues*32)-1:0]   tx_r_launch_time_ext;     // Frame Length, 1 per queue
   input          dma_tx_status_tog_ext; // toggle acknowledge for tx_r_status.
   output         dma_tx_end_tog_ext;    // toggled when tx_r_status is valid.



   // DMA tx interface.
   input  [127:0] tx_r_data_dma;     // output data from the transmit fifo
                                     // to the tx module.
   input  [15:0]  tx_r_data_par_dma;
   input    [3:0] tx_r_mod_dma;      // tx number of valid bytes in last
                                     // transfer of the frame.
                                     // 0000 - tx_r_data[127:0] valid,
                                     // 0001 - tx_r_data[7:0] valid,
                                     // 0010 - tx_r_data[15:0] valid, until
                                     // 1111 - tx_r_data[119:0] valid.
   input          tx_r_sop_dma;      // start of packet indicator.
   input          tx_r_eop_dma;      // end of packet indicator.
   input          tx_r_err_dma;      // packet in error indicator.
   output [p_edma_queues-1:0]   tx_r_rd_dma;       // request new data from fifo.
   output [p_edma_queues-1:0]   tx_r_rd_int_dma;   // request new data from fifo.
   output [3:0]   tx_r_queue_int_dma;// Queue ID, timed with tx_r_rd_int
   output [3:0]   tx_r_queue_dma;    // Queue ID, timed with tx_r_rd
   input          tx_r_valid_dma;    // new tx data available from fifo.
   input  [p_edma_queues-1:0]   tx_r_data_rdy_dma; // indicates either a complete packet
                                     // is present in the fifo or a certain
                                     // threshold of data has been crossed,
                                     // the mac uses this input to trigger
                                     // a frame transfer.
   input          tx_r_underflow_dma;// signals tx fifo underrun condition.
   input          tx_r_flushed_dma;  // tx fifo has been flushed.
   input          tx_r_control_dma;  // tx control from in-line FIFO word
   input   [p_edma_queues-1:0]        tx_r_frame_size_vld_dma; // We have the frame size.
   input   [(p_edma_queues*14)-1:0]   tx_r_frame_size_dma;     // Frame Length, 1 per queue
   input   [p_edma_queues-1:0]        tx_r_launch_time_vld_dma; // We have the frame size.
   input   [(p_edma_queues*32)-1:0]   tx_r_launch_time_dma;     // Frame Length, 1 per queue
   input          dma_tx_status_tog_dma; // toggle acknowledge for tx_r_status.
   output         dma_tx_end_tog_dma;    // toggled when tx_r_status is valid.


   // MAC tx interface.
   output [127:0] tx_r_data_mac;     // output data from the transmit fifo
                                     // to the tx module.
   output [15:0]  tx_r_data_par_mac;
   output   [3:0] tx_r_mod_mac;      // tx number of valid bytes in last
                                     // transfer of the frame.
                                     // 0000 - tx_r_data[127:0] valid,
                                     // 0001 - tx_r_data[7:0] valid,
                                     // 0010 - tx_r_data[15:0] valid, until
                                     // 1111 - tx_r_data[119:0] valid.
   output         tx_r_sop_mac;      // start of packet indicator.
   output         tx_r_eop_mac;      // end of packet indicator.
   output         tx_r_err_mac;      // packet in error indicator.
   input  [p_edma_queues-1:0]   tx_r_rd_mac;       // request new data from fifo.
   input  [3:0]   tx_r_queue_mac;    // Queue ID, timed with tx_r_rd
   input  [p_edma_queues-1:0]   tx_r_rd_int_mac;   // request new data from fifo.
   input  [3:0]   tx_r_queue_int_mac;// Queue ID, timed with tx_r_rd_int
   output         tx_r_valid_mac;    // new tx data available from fifo.
   output [p_edma_queues-1:0]   tx_r_data_rdy_mac; // indicates either a complete packet
                                     // is present in the fifo or a certain
                                     // threshold of data has been crossed,
                                     // the mac uses this input to trigger
                                     // a frame transfer.
   output         tx_r_underflow_mac;// signals tx fifo underrun condition.
   output         tx_r_flushed_mac;  // tx fifo has been flushed.
   output         tx_r_control_mac;  // tx control from in-line FIFO word
   output  [p_edma_queues-1:0]        tx_r_frame_size_vld_mac; // We have the frame size.
   output  [(p_edma_queues*14)-1:0]   tx_r_frame_size_mac;     // Frame Length, 1 per queue
   output  [p_edma_queues-1:0]        tx_r_launch_time_vld_mac; // We have the frame size.
   output  [(p_edma_queues*32)-1:0]   tx_r_launch_time_mac;     // Frame Length, 1 per queue
   output         dma_tx_status_tog_mac; // toggle acknowledge for tx_r_status.
   input          dma_tx_end_tog_mac;    // toggled when tx_r_status is valid.



   // STATUS SIGNALS (o/p from MAC, i/p to DMA/EXT)
   output         late_coll_occured_ext; // part ot tx_r_status
   output         too_many_retries_ext;  // part ot tx_r_status
   output         underflow_frame_ext;   // part ot tx_r_status
   output         collision_occured_ext; // part ot tx_r_status

   output         late_coll_occured_dma; // part ot tx_r_status
   output         too_many_retries_dma;  // part ot tx_r_status
   output         underflow_frame_dma;   // part ot tx_r_status
   output         collision_occured_dma; // part ot tx_r_status

   input          late_coll_occured_mac; // part ot tx_r_status
   input          too_many_retries_mac;  // part ot tx_r_status
   input          underflow_frame_mac;   // part ot tx_r_status
   input          collision_occured_mac; // part ot tx_r_status


//------------------------------------------------------------------------------
// wire and reg declarations.
//------------------------------------------------------------------------------

   wire           dma_tx_status_tog_pulse_ext;
   wire           dma_tx_status_tog_pulse_dma;
   wire           tx_end_tog_pulse_mac;

   wire   [3:0]   tx_r_status_mac;


   reg    [2:0]   data_state;
   reg    [2:0]   data_state_next;
   reg    [1:0]   status_state;
   reg    [1:0]   status_state_next;


   reg    [3:0]   tx_r_status_mac_latched;


   reg            dma_tx_end_tog_mac_d1;
   reg            dma_tx_status_tog_ext_d1;
   reg            dma_tx_status_tog_dma_d1;

   reg            data_mux_ctrl;
   reg            data_mux_ctrl_d1;
   reg            status_mux_ctrl;
   reg            status_mux_ctrl_d1;


   reg            dma_tx_end_tog_ext;
   reg            dma_tx_end_tog_dma;
   reg            dma_tx_status_tog_mac;

   reg            tx_r_underflow_latched_ext;
   reg            tx_r_underflow_latched_dma;


   reg            dma_tx_end_tog_last_ext    ;
   reg            dma_tx_end_tog_last_dma    ;
   reg            dma_tx_status_tog_last_mac ;

   reg    [3:0]   fifo_data  ;
   reg    [1:0]   fifo_cnt   ;
   reg            fifo_wr    ;
   reg            fifo_rd ;

   wire           fifo_dout ;
   reg            fifo_din  ;

   reg            sop_detected_ext ;
   reg            sop_detected_dma ;

//------------------------------------------------------------------------------
// Beginning of code
//------------------------------------------------------------------------------

   // combine to status bits from MAC into bus to use later
   assign tx_r_status_mac[0]     = too_many_retries_mac;
   assign tx_r_status_mac[1]     = late_coll_occured_mac;
   assign tx_r_status_mac[2]     = collision_occured_mac;
   assign tx_r_status_mac[3]     = underflow_frame_mac;


   //////////////////////////////////
   // MUX inputs / outputs depending on port being used
   //////////////////////////////////

   // connect MAC inputs to dma or ext_fifo interface

   //to improve P&R use ctrl_d1
   assign tx_r_data_mac         = data_mux_ctrl_d1 ? tx_r_data_ext            : tx_r_data_dma;
   assign tx_r_data_par_mac     = data_mux_ctrl_d1 ? tx_r_data_par_ext        : tx_r_data_par_dma;
   assign tx_r_mod_mac          = data_mux_ctrl_d1 ? tx_r_mod_ext             : tx_r_mod_dma;
   assign tx_r_sop_mac          = data_mux_ctrl_d1 ? tx_r_sop_ext             : tx_r_sop_dma;
   assign tx_r_eop_mac          = data_mux_ctrl_d1 ? tx_r_eop_ext             : tx_r_eop_dma;
   assign tx_r_err_mac          = data_mux_ctrl_d1 ? tx_r_err_ext             : tx_r_err_dma;
   assign tx_r_valid_mac        = data_mux_ctrl_d1 ? tx_r_valid_ext           : tx_r_valid_dma;
   assign tx_r_frame_size_mac   = data_mux_ctrl_d1 ? tx_r_frame_size_ext      : tx_r_frame_size_dma;
   assign tx_r_frame_size_vld_mac= data_mux_ctrl   ? tx_r_frame_size_vld_ext  : tx_r_frame_size_vld_dma;
   assign tx_r_launch_time_mac   = data_mux_ctrl_d1 ? tx_r_launch_time_ext      : tx_r_launch_time_dma;
   assign tx_r_launch_time_vld_mac= data_mux_ctrl   ? tx_r_launch_time_vld_ext  : tx_r_launch_time_vld_dma;
   assign tx_r_data_rdy_mac     = data_mux_ctrl    ? tx_r_data_rdy_ext        : tx_r_data_rdy_dma;

   // tx_r_underflow is active between data_rdy and eop so use data_mux_ctrl to control
   assign tx_r_underflow_mac    = data_mux_ctrl_d1 ? tx_r_underflow_ext    :tx_r_underflow_dma;

   // tx_r_flushed must be active after _tog handshaking sequence so use status_mux_ctrl to control
   // but is it also active during data phase if tx_r_underflow becomes active
   // so need 'or' dma and ext flushed signals
   // as flushed from one port due to status may not have completed before flushed from
   // next frame (due to tx_r_underflow signal while sending frame)
   assign tx_r_flushed_mac      = tx_r_flushed_ext | tx_r_flushed_dma;

   // tx_r_control must be active at sop so use data_mux_ctrl to control
   assign tx_r_control_mac      = data_mux_ctrl_d1 ? tx_r_control_ext      :tx_r_control_dma;


   // connect MAC outputs to dma or ext_fifo interface

   //to improve P&R use ctrl_d1 as r_rd is always later than mux_ctrl start
   assign tx_r_rd_dma            = data_mux_ctrl_d1 ? {p_edma_queues{1'b0}}: tx_r_rd_mac;
   assign tx_r_queue_dma         = data_mux_ctrl_d1 ? 4'h0: tx_r_queue_mac;
   assign tx_r_rd_int_dma        = data_mux_ctrl    ? {p_edma_queues{1'b0}}: tx_r_rd_int_mac;
   assign tx_r_queue_int_dma     = data_mux_ctrl    ? 4'h0: tx_r_queue_int_mac;

   assign  late_coll_occured_dma = status_mux_ctrl_d1  ? 1'b0: late_coll_occured_mac;
   assign  too_many_retries_dma  = status_mux_ctrl_d1  ? 1'b0: too_many_retries_mac;
   assign  underflow_frame_dma   = status_mux_ctrl_d1  ? 1'b0: underflow_frame_mac;
   assign  collision_occured_dma = status_mux_ctrl_d1  ? 1'b0: collision_occured_mac;


   assign tx_r_rd_ext            = data_mux_ctrl_d1 ? tx_r_rd_int_mac          :{p_edma_queues{1'b0}};
   assign tx_r_queue_ext         = data_mux_ctrl_d1 ? tx_r_queue_mac           :4'h0;


   assign  late_coll_occured_ext = status_mux_ctrl_d1  ? late_coll_occured_mac :1'b0;
   assign  too_many_retries_ext  = status_mux_ctrl_d1  ? too_many_retries_mac  :1'b0;
   assign  underflow_frame_ext   = status_mux_ctrl_d1  ? underflow_frame_mac   :1'b0;
   assign  collision_occured_ext = status_mux_ctrl_d1  ? collision_occured_mac :1'b0;


   // generate a registered version of data_mux_ctrl
   // to select tx_r_rd and status_mux_ctrl to
   // select dma_tx_end_tog_*
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset
         begin
           data_mux_ctrl_d1     <= 1'b0;
           status_mux_ctrl_d1   <= 1'b0;
         end
      else
         begin
           data_mux_ctrl_d1     <= data_mux_ctrl;
           status_mux_ctrl_d1   <= status_mux_ctrl;
         end
   end

   //////////////////////////////////
   // data MUX state machine
   //////////////////////////////////

   // synchronous part of data mux state machine.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset for data mux state machine.
         data_state <= DATA_IDLE ;
      else
         // state machine flip-flops.
         data_state <= data_state_next;
   end


   // asynchronous next state decode for data mux state machine.
   always@( * )
   begin
      // default values.
      data_mux_ctrl        = SELECT_EXT_FIFO ;
      sop_detected_ext     = 1'b0;
      sop_detected_dma     = 1'b0;

      // decodes for next state of data mux state machine.
      case (data_state)

         DATA_IDLE:
            // state used to wait for data available from dma or fifo
            // interface.
            begin
               data_mux_ctrl = SELECT_EXT_FIFO ; // default select ext fifo
               // Note; cannot set default for status mux as status not received when state entered
               // priority given to ext fifo
               if (|tx_r_data_rdy_ext)
                  data_state_next = DATA_AVAIL_EXT;
               else
                 if (|tx_r_data_rdy_dma)
                   begin
                      // dma checked second
                      data_state_next = DATA_AVAIL_DMA;
                      data_mux_ctrl = SELECT_DMA ;
                    end
                  else
                    data_state_next = DATA_IDLE;
            end

         DATA_AVAIL_EXT:  // data available from EXT_FIFO, wait for sop
            begin  // qualify with underflow for test case condition (maybe not actually occuring)
               data_mux_ctrl = SELECT_EXT_FIFO ;
               if (tx_r_sop_ext & tx_r_valid_ext & ~tx_r_underflow_ext)
                  begin
                  // for small frames eop can occur at the same time as sop
                  // so use same logic as SOP_DET_EXT state to work out next state
                  if (tx_r_eop_ext)
                    begin
                       // at eop decide which port to select next
                       // priority given to ext fifo
                       if (|tx_r_data_rdy_ext)
                         data_state_next = DATA_AVAIL_EXT;
                       else
                         if (|tx_r_data_rdy_dma)
                           begin
                             data_mux_ctrl = SELECT_DMA ;
                             // dma checked second
                             data_state_next = DATA_AVAIL_DMA;
                           end
                         else
                           // no data avail so go to idle
                           data_state_next = DATA_IDLE;
                     end
                  else
                    data_state_next = SOP_DET_EXT;
                  end
                else
                    data_state_next = DATA_AVAIL_EXT;

           end

         SOP_DET_EXT: // sop detected, await eop
            begin
               data_mux_ctrl = SELECT_EXT_FIFO ;
               sop_detected_ext = 1'b1;
               // add condition to detect end of data phase when undeflow occurs (which will be followed by flushed)
               if ((tx_r_eop_ext && tx_r_valid_ext) || (tx_r_underflow_ext))
                 begin
                    // at eop decide which port to select next
                    // priority given to ext fifo
                    if (|tx_r_data_rdy_ext)
                      data_state_next = DATA_AVAIL_EXT;
                    else
                      if (|tx_r_data_rdy_dma)
                        begin
                          data_mux_ctrl = SELECT_DMA ;
                          // dma checked second
                          data_state_next = DATA_AVAIL_DMA;
                        end
                      else
                        // no data avail so go to idle
                        data_state_next = DATA_IDLE;
                  end
               else
                 data_state_next = SOP_DET_EXT;
            end

         DATA_AVAIL_DMA:  // data available from DMA, wait for sop
            begin
               data_mux_ctrl = SELECT_DMA ;
               if (tx_r_sop_dma & tx_r_valid_dma & ~tx_r_underflow_dma)
                  begin
                  // for small frames eop can occur at the same time as sop
                  // so use same logic as SOP_DET_DMA state to work out next state
                  if (tx_r_eop_dma)
                    begin
                     // at eop decide which port to select next
                     // priority given to ext fifo
                     if (|tx_r_data_rdy_ext)
                     begin
                       data_mux_ctrl = SELECT_EXT_FIFO ;
                       // priority given to ext fifo
                       data_state_next = DATA_AVAIL_EXT;
                     end
                     else
                       if (|tx_r_data_rdy_dma)
                         // dma checked second
                         data_state_next = DATA_AVAIL_DMA;
                       else
                         // no data avail so go to idle
                         data_state_next = DATA_IDLE;
                    end
                   else
                    data_state_next = SOP_DET_DMA;
                  end
               else
                  data_state_next = DATA_AVAIL_DMA;
            end

         SOP_DET_DMA:  // sop detected, await eop
            begin
               data_mux_ctrl = SELECT_DMA ;
               sop_detected_dma = 1'b1;
               // add condition to detect end of data phase when undeflow occurs (which will be followed by flushed)
               if ((tx_r_eop_dma && tx_r_valid_dma) || (tx_r_underflow_dma))
                 begin
                  // at eop decide which port to select next
                  // priority given to ext fifo
                  if (|tx_r_data_rdy_ext)
                    begin
                      data_mux_ctrl = SELECT_EXT_FIFO ;
                      // priority given to ext fifo
                      data_state_next = DATA_AVAIL_EXT;
                    end
                  else
                    if (|tx_r_data_rdy_dma)
                      // dma checked second
                      data_state_next = DATA_AVAIL_DMA;
                    else
                      // no data avail so go to idle
                      data_state_next = DATA_IDLE;
                 end
               else
                 data_state_next = SOP_DET_DMA;
            end


         default:
            begin
              data_mux_ctrl    = SELECT_EXT_FIFO ;
              data_state_next  = DATA_IDLE;
            end
      endcase
   end

   //////////////////////////////////
   // status MUX state machine
   //////////////////////////////////

   // synchronous part of status mux state machine.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset for status mux state machine.
         status_state <= STATUS_IDLE ;
      else
         // state machine flip-flops.
         status_state <= status_state_next;
   end


   // asynchronous next state decode for status mux state machine.

   // at start of status phase read fifo to set status_mux_ctrl
   // this is needed as we need to keep correct port seelcted
   // when next eop arrives before status_tog received
   // previously used eop to set status_mux_ctrl without keeping track
   // of status phase completing for previous frames
   always@(*)
   begin
      // decodes for next state of data mux state machine.
      case (status_state)

         STATUS_IDLE:
            // use data_mux_ctrl at eop to assign port for next status o/p
            // don't use value at sop as stats may not be back from previous packet yet
            // wait for status from MAC
            // When tx_r_underflow or tx_r_err occur we may not get an eop so use a latched
            // versions of these signals to control mux state
            // Note tx_r_err will still have eop so remove from end of status phase detection
            begin
               // use (underflow/err)_latched signals as non-latched version may have gone before data mux switched
               // priority given to ext fifo port
               // remove tx_r_err condition
               if ((data_mux_ctrl == SELECT_EXT_FIFO) && ((tx_r_eop_ext & tx_r_valid_ext) || (tx_r_underflow_latched_ext)))
                  begin
                    status_mux_ctrl = fifo_dout ;
                    status_state_next = WAIT_STATUS_EXT ;
                  end
               else
                  // remove tx_r_err condition
                  if ((data_mux_ctrl == SELECT_DMA) && ((tx_r_eop_dma && tx_r_valid_dma) || (tx_r_underflow_latched_dma) ))
                    begin
                      status_mux_ctrl = fifo_dout ;
                      status_state_next = WAIT_STATUS_DMA ;
                    end
                  else
                    begin
                      status_mux_ctrl = fifo_dout ;
                      status_state_next = STATUS_IDLE ;
                    end
            end


         WAIT_STATUS_EXT:
            // if status[3:0] = 4'h0, the status handshake finishes when dma_tx_status_tog goes to MAC
            // otherwise hanshake finishes when tx_r_flushed goes to MAC
            begin
               status_mux_ctrl = fifo_dout ;
               if (dma_tx_status_tog_pulse_ext & (tx_r_status_mac_latched == 4'h0))
                  // end of status handshake as no errors reported from MAC
                  status_state_next = STATUS_IDLE;
               else
                  // error must have been reported from MAC and flush has occured
                  if (tx_r_flushed_ext == 1'b1)
                    begin
                      status_state_next = STATUS_IDLE;
                    end
                  else
                      status_state_next = WAIT_STATUS_EXT;
            end

         WAIT_STATUS_DMA:
            // if status[3:0] = 4'h0, the status handshake finishes when dma_tx_status_tog goes to MAC
            // otherwise hanshake finishes when tx_r_flushed goes to MAC
            begin
               status_mux_ctrl = fifo_dout ;
               if (dma_tx_status_tog_pulse_dma & (tx_r_status_mac_latched == 4'h0))
                  // end of status handshake as no errors reported from MAC
                  begin
                    status_state_next = STATUS_IDLE;
                  end
               else
                  // error must have been reported from MAC and flush has occured
                  if (tx_r_flushed_dma == 1'b1)
                    begin
                      status_state_next = STATUS_IDLE;
                    end
                  else
                      status_state_next = WAIT_STATUS_DMA;

            end

         default:
            //
            begin
              status_mux_ctrl = fifo_dout ;
              status_state_next  = STATUS_IDLE ;
            end
      endcase
   end


   //////////////////////////////////
   // FIFO WR CTRL
   //////////////////////////////////

   // when a sop arrives then this defines the source of status_tog expected
   // so write port into fifo

   always@(*)
   begin

       begin  // if underflow seen at sop no end_tog / status_tog occurs
              // so don't write to fifo
              // add ~sop_detected as double sop error caused multiple fifo wr
          if ((data_mux_ctrl == SELECT_EXT_FIFO) & (tx_r_sop_ext & tx_r_valid_ext & ~sop_detected_ext & ~tx_r_underflow_ext))
             begin
               fifo_wr   = 1'b1;
               fifo_din  = SELECT_EXT_FIFO;
             end
          else
            if ((data_mux_ctrl == SELECT_DMA) & (tx_r_sop_dma & tx_r_valid_dma & ~sop_detected_dma & ~tx_r_underflow_dma))
              begin
                 fifo_wr   = 1'b1;
                 fifo_din  = SELECT_DMA;
              end
             else
               begin
                 fifo_wr   = 1'b0;
                 fifo_din  = SELECT_EXT_FIFO;
               end
        end
    end

   //////////////////////////////////
   // FIFO_RD CTRL
   //////////////////////////////////

   // when status_tog aarives it completes the status phase for that port
   // so read next port from fifo

   always@(*)
   begin

     begin
       if (dma_tx_status_tog_pulse_ext || dma_tx_status_tog_pulse_dma)
         begin
           fifo_rd = 1'b1;
         end
       else
         begin
           fifo_rd = 1'b0;
         end
     end
   end



   //////////////////////////////////
   // Simple FIFO
   //////////////////////////////////

  assign   fifo_dout = fifo_data[0];


   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
        begin
          fifo_data  <= 4'h0 ;
          fifo_cnt   <= 2'b00;
        end
      else
        begin
          if (fifo_wr & fifo_rd)
            fifo_cnt <= fifo_cnt;
          else
            if (fifo_wr)
              fifo_cnt <= fifo_cnt + 1'b1;
            else
              if (fifo_rd)
                fifo_cnt <= fifo_cnt - 1'b1;
              else
                fifo_cnt <= fifo_cnt;

          if (fifo_wr & fifo_rd)
            begin  // shift entries down and write to next free space
              case (fifo_cnt)
                2'b00: begin  // not valid as read should only occur after min one entry
                     fifo_data[0]   <= fifo_din;
                   end

                2'b01: begin
                     fifo_data[1]   <= fifo_din;
                     fifo_data[0]   <= fifo_data[1];
                   end

                2'b10: begin
                     fifo_data[2]     <= fifo_din;
                     fifo_data[1:0]   <= fifo_data[2:1];
                   end

                2'b11: begin
                     fifo_data[3]     <= fifo_din;
                     fifo_data[2:0]   <= fifo_data[3:1];

                   end
              endcase

            end
          else
             if (fifo_wr)
               begin  // write to next free space
                 fifo_data[fifo_cnt]   <= fifo_din;
               end
             else
               if (fifo_rd)
                 begin
                   fifo_data[2:0] <= fifo_data[3:1];
                   fifo_data[3]   <= 1'b0;
                 end
               else
                  fifo_data <= fifo_data;

        end

   end



   //////////////////////////////////
   // register some signals.
   // generate pulses to identify transitions on _tog signals
   // generate _tog outputs based on last value for each port

   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         begin
           tx_r_status_mac_latched    <= 4'h0;
           dma_tx_end_tog_mac_d1      <= 1'b0;
           dma_tx_status_tog_ext_d1   <= 1'b0;
           dma_tx_status_tog_dma_d1   <= 1'b0;

           tx_r_underflow_latched_ext <= 1'b0;
           tx_r_underflow_latched_dma <= 1'b0;

           dma_tx_end_tog_last_ext     <= 1'b0;
           dma_tx_end_tog_last_dma     <= 1'b0;
           dma_tx_status_tog_last_mac  <= 1'b0;

         end

      else

        begin
          // latch tx_r_underflow each time it occurs
          // this will be used to switch the status mux at the end of current status phase
          if (tx_r_underflow_ext)
            tx_r_underflow_latched_ext <= 1'b1;
          else
            // clear when tx_r_flushed detected
            if (~tx_r_flushed_ext)
              tx_r_underflow_latched_ext <= 1'b0;
            else
              tx_r_underflow_latched_ext  <= tx_r_underflow_latched_ext;

          // latch tx_r_underflow each time it occurs
          // this will be used to switch the status mux at the end of current status phase
          if (tx_r_underflow_dma)
            tx_r_underflow_latched_dma <= 1'b1;
          else
            // clear when tx_r_flushed detected
            if (~tx_r_flushed_dma)
              tx_r_underflow_latched_dma <= 1'b0;
            else
              tx_r_underflow_latched_dma <= tx_r_underflow_latched_dma;


          // latch status each time it is valid
          if (tx_end_tog_pulse_mac)
            tx_r_status_mac_latched <= tx_r_status_mac;
          else
            tx_r_status_mac_latched <= tx_r_status_mac_latched;


           //generate delayed signals
           dma_tx_status_tog_ext_d1  <= dma_tx_status_tog_ext;
           dma_tx_status_tog_dma_d1  <= dma_tx_status_tog_dma;
           dma_tx_end_tog_mac_d1     <= dma_tx_end_tog_mac;


           // toggle _tog signals to MAC / DMA /  EXT_FIFO based on toggle
           // of selected interface dma/EXT_FIFO

           // signals FROM MAC

           if ((status_mux_ctrl == SELECT_EXT_FIFO) &  tx_end_tog_pulse_mac)
             dma_tx_end_tog_last_ext     <= ~dma_tx_end_tog_last_ext;
           else
             dma_tx_end_tog_last_ext     <= dma_tx_end_tog_last_ext;

           if ((status_mux_ctrl == SELECT_DMA)      &  tx_end_tog_pulse_mac)
             dma_tx_end_tog_last_dma     <= ~dma_tx_end_tog_last_dma;
           else
             dma_tx_end_tog_last_dma     <= dma_tx_end_tog_last_dma;


           // signals TO MAC

           if ((status_mux_ctrl == SELECT_EXT_FIFO) &  dma_tx_status_tog_pulse_ext)
             dma_tx_status_tog_last_mac <= ~dma_tx_status_tog_last_mac;
           else
             if ((status_mux_ctrl == SELECT_DMA) &  dma_tx_status_tog_pulse_dma)
               dma_tx_status_tog_last_mac <= ~dma_tx_status_tog_last_mac;
             else
               dma_tx_status_tog_last_mac <= dma_tx_status_tog_last_mac;


         end


    end


   //////////////////////////////////
   // generate pulses at pos or neg edges of _tog signals
   //

   assign dma_tx_status_tog_pulse_ext = dma_tx_status_tog_ext_d1  ^ dma_tx_status_tog_ext;

   assign dma_tx_status_tog_pulse_dma = dma_tx_status_tog_dma_d1  ^ dma_tx_status_tog_dma;

   assign tx_end_tog_pulse_mac        = dma_tx_end_tog_mac_d1     ^ dma_tx_end_tog_mac;



   // asynchronous end_tog output generation to _ext / _dma.
   always@(*)

   begin

     begin
       if (status_mux_ctrl_d1 == SELECT_EXT_FIFO)
         begin
           dma_tx_end_tog_dma = dma_tx_end_tog_last_dma; // default _dma

            if (tx_end_tog_pulse_mac)
              dma_tx_end_tog_ext = ~dma_tx_end_tog_last_ext;
            else
              dma_tx_end_tog_ext = dma_tx_end_tog_last_ext;
         end
       else  // SELECT_DMA
         begin
           dma_tx_end_tog_ext = dma_tx_end_tog_last_ext; // default _ext

            if (tx_end_tog_pulse_mac)
              dma_tx_end_tog_dma = ~dma_tx_end_tog_last_dma;
            else
               dma_tx_end_tog_dma = dma_tx_end_tog_last_dma;
         end

     end
   end

   // asynchronous status_tog output generation to MAC.


   always@(*)

   begin
     begin
       if (status_mux_ctrl == SELECT_EXT_FIFO)
         begin

            if (dma_tx_status_tog_pulse_ext)
              dma_tx_status_tog_mac = ~dma_tx_status_tog_last_mac;
            else
              dma_tx_status_tog_mac = dma_tx_status_tog_last_mac;
         end
       else  // from _DMA
         begin

            if (dma_tx_status_tog_pulse_dma)
              dma_tx_status_tog_mac = ~dma_tx_status_tog_last_mac;
            else
              dma_tx_status_tog_mac = dma_tx_status_tog_last_mac;
         end

     end
   end


endmodule



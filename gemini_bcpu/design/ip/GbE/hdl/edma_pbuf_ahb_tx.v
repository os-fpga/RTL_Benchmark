//------------------------------------------------------------------------------
// Copyright (c) 2006-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_pbuf_ahb_tx.v
//   Module Name:        edma_pbuf_ahb_tx
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
// Description    : Top Level for the Tx Packet Buffer
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module edma_pbuf_ahb_tx (

    // Paramters/Constants
    TX_PBUF_MAX_FILL_LVL,

    // system signals
    hclk,
    n_hreset,
    tx_r_clk,
    tx_r_rst_n,

    // Async input used to trigger tx_start
    trigger_dma_tx_start,

    // FiFo input signals from gem_tx
    tx_r_rd,
    tx_r_rd_int,
    tx_r_queue_int,
    dma_tx_end_tog,
    dma_tx_small_end_tog,
    collision_occured,
    late_coll_occured,
    too_many_retries,
    underflow_frame,

    // signals coming from gem_hclk_syncs
    new_tx_q_ptr_pulse,
    tx_stat_capt_pulse,
    tx_halt_hclk,
    tx_start_hclk_pulse,
    enable_tx_hclk,
    tx_dma_descr_base_addr,

    // signals coming from gem_registers
    dma_bus_width,
    tx_pbuf_tcp_en,
    tx_pbuf_size,
    ahb_burst_length,
    endian_swap,
    tx_cutthru_threshold,
    tx_cutthru,
    full_duplex,
    force_max_ahb_burst_tx,

    // AHB Inputs
    hgrant_descr,
    hgrant_data,
    hready,
    hresp,
    hrdata,

    // TX Descriptor AHB Outputs
    hbusreq_descr,
    hlock_descr,
    hburst_descr,
    htrans_descr,
    hsize_descr,
    hwrite_descr,
    hprot_descr,
    haddr_descr,
    hwdata_descr,

    // TX Data AHB Outputs
    hbusreq_data,
    hlock_data,
    hburst_data,
    htrans_data,
    hsize_data,
    hwrite_data,
    hprot_data,
    haddr_data,
    hwdata_data,

    // outputs signals to gem_tx
    dma_tx_status_tog,

    // fifo output signals to gem_tx
    tx_r_valid,
    tx_r_data,
    tx_r_data_par,
    tx_r_eop,
    tx_r_sop,
    tx_r_mod,
    tx_r_err,
    tx_r_flushed,
    tx_r_underflow,
    tx_r_data_rdy,
    dma_is_busy,
    tx_r_control,
    tx_r_frame_size_vld,
    tx_r_frame_size,

    // outputs to pclk_syncs
    tx_dma_stable_tog,
    tx_dma_complete_ok,
    tx_dma_hresp_notok,
    tx_dma_late_col,
    tx_dma_toomanyretry,
    tx_dma_underflow,
    tx_dma_buffers_ex,
    tx_dma_buff_ex_mid,
    tx_dma_int_queue,
    tx_dma_go,
    tx_dma_descr_ptr,
    tx_dma_descr_ptr_tog,

    dpram_fill_lvl,

    // Segment allocations
    tx_pbuf_segments,

    // Top enabled queue
    tx_top_q_id,

    // DPRAM interface
    tx_ena,
    tx_wea,
    tx_addra,
    tx_dia,
    tx_dia_par,

    tx_enb,
    tx_web,
    tx_addrb,
    tx_dob,
    tx_dob_par,

    // 64b addressing support
    upper_tx_q_base_addr,
    dma_addr_bus_width,

    tx_bd_extended_mode_en,
    tx_bd_ts_mode,

    // Timestamp for current packet
    tx_timestamp,
    tx_timestamp_prty,

    // PTP frame decoded signals
    event_frame_tx,
    general_frame_tx,

   // lockup detection
   full_pkt_inc,
   used_bit_vec,
   lockup_flush,

   // ASF - signals going to gem_reg_top
   asf_dap_tx_rd_err,
   asf_dap_tx_wr_err

   );


//***************************************************************************
// port declarations
//***************************************************************************

   parameter [1363:0] grouped_params = {
       208'd0,
       32'd1, // p_edma_queue
       32'd64,// p_edma_tx_pbuf_data
       32'd64,// p_edma_rx_pbuf_data
       32'd10,// p_edma_tx_pbuf_addr
       32'd10,// p_edma_rx_pbuf_addr
       32'd1, // p_edma_tx_pbuf_queue_segment_size
       32'd64,// p_emac_bus_width
       32'd64,// p_edma_bus_width
       32'd32,// p_edma_addr_width
       868'd0
   };

   `include "ungroup_params.v"

   // Parameters/Constants
   output [(p_edma_tx_pbuf_addr*p_edma_queues)-1:0] TX_PBUF_MAX_FILL_LVL;

   // System signals
   input          hclk;                // AHB clock.
   input          n_hreset;            // AHB reset.
   input          tx_r_clk;            // tx_clk for fifo read clock.
   input          tx_r_rst_n;          // n_txreset for fifo read reset.

   input          trigger_dma_tx_start;// Async input used to trigger tx_start

   // Fifo input signals from gem_tx
   input    [p_edma_queues-1:0]    tx_r_rd;           // gem tx requires a pop from the fifo.
   input    [p_edma_queues-1:0]    tx_r_rd_int;       // Early version of tx_r_rd
   input    [3:0]                  tx_r_queue_int;    // early version, timed with tx_r_rd_int


   // Signals from MAC
   input          dma_tx_end_tog;      // Toggle signal indicating the end of
                                       // transmission of the oldest frame
   input          dma_tx_small_end_tog;// Toggle signal indicating the end of
                                       // transmission of a smal frame. Used
                                       // for xgm only, where the xgm mac will
                                       // automatically ignore packets <9
                                       // bytes.
   input          collision_occured;   // collision occurred on current frame,
                                       // cause a restart sequence.
   input          late_coll_occured;   // Late Collision Occured (MAC timed)
   input          too_many_retries;    // Too many retries Occured (MAC timed)
   input          underflow_frame;     // Underflow (MAC timed)

   // Signals coming from gem_hclk_syncs
   input          new_tx_q_ptr_pulse;  // New queue pointer written (NOT USED)
   input          tx_stat_capt_pulse;  // Hclk pulse indicating tx dma status
                                       // has been captured within pclk domain.
   input          tx_halt_hclk;        // Hclk pulse indicating that
                                       // transmission should halt after all
                                       // ongoing activity has completed.
   input          tx_start_hclk_pulse; // Hclk pulse indicating that
                                       // transmission should begin.
   input          enable_tx_hclk;      // Enable transmission path (soft reset)
   input [(p_edma_queues*32)-1:0] tx_dma_descr_base_addr; // Base address for the buffer
                                       // descriptor queue.

   // Signals coming from gem_registers
   input    [1:0] dma_bus_width;       // Current programmed width of data bus:
                                       // 00 = 32  bit bus (default)
                                       // 01 = 64  bit bus
                                       // 1x = 128 bit bus
   input          tx_pbuf_tcp_en;      // TCP offload enable
   input          tx_pbuf_size;        // Programmed size of available TX DPRAM
   input    [4:0] ahb_burst_length;    // AHB burst length control
   input    [1:0] endian_swap;
   input         full_duplex;          // full duplex signal from the network.
   input  [p_edma_tx_pbuf_addr-1:0] tx_cutthru_threshold; // Threshold value for cutthru
   input          tx_cutthru;          // Enable for cut-thru operation
   input          force_max_ahb_burst_tx; // force max burst length accesses

   // inputs from AHB
   input           hgrant_descr;
   input           hgrant_data;
   input           hready;
   input   [1:0]   hresp;
   input [p_edma_bus_width-1:0]   hrdata;   // AHB input data.

   // Outputs to AHB - TX Descriptor AHB Master
   output          hbusreq_descr;
   output          hlock_descr;
   output  [2:0]   hburst_descr;
   output  [1:0]   htrans_descr;
   output  [2:0]   hsize_descr;
   output          hwrite_descr;
   output  [3:0]   hprot_descr;
   output  [p_edma_addr_width-1:0]  haddr_descr;
   output  [127:0] hwdata_descr;

   // Outputs to AHB - TX Data AHB Master
   output          hbusreq_data;
   output          hlock_data;
   output  [2:0]   hburst_data;
   output  [1:0]   htrans_data;
   output  [2:0]   hsize_data;
   output          hwrite_data;
   output  [3:0]   hprot_data;
   output  [p_edma_addr_width-1:0]  haddr_data;
   output  [127:0] hwdata_data;

   // Outputs signals to gem_tx
   output         dma_tx_status_tog;   // Signal to gem_tx that both writeback
                                       // and pclk status update have completed.

   // Fifo output signals to gem_tx
   output         tx_r_valid;          // Validates data, eop, sop after a r_rd.
   output  [p_emac_bus_width-1:0]   tx_r_data;           // Read data from FIFO (128/64/32 bits)
   output  [p_emac_bus_pwid-1:0]    tx_r_data_par;
   output         tx_r_eop;            // End of packet present on r_rd.
   output         tx_r_sop;            // Start of packet present on r_rd.
   output   [3:0] tx_r_mod;            // Number of valid bytes in final access.
                                       // Only valid when tx_r_eop also set.
   output         tx_r_err;            // There is a error with the current
                                       // frame being read from the FIFO. TX
                                       // MAC should terminate transmission.
   output         tx_r_flushed;        // Flush has been asserted.
   output         tx_r_underflow;      // r_rd asserted and fifo empty.
   output    [p_edma_queues-1:0]      tx_r_data_rdy;       // Enough data in FIFO to begin TX.
   output                             dma_is_busy;
   output         tx_r_control;        // Packet control information.
   output   [p_edma_queues-1:0]       tx_r_frame_size_vld; // We have the frame size.
   output   [(p_edma_queues*14)-1:0]  tx_r_frame_size;     // Frame Length, 1 per queue


   // Outputs to pclk_syncs
   output         tx_dma_stable_tog;   // Toggles to indicate to PCLK domain
                                       // that the tx dma status outputs are
                                       // stable and ready to be sampled.
   output         tx_dma_complete_ok;  // Frame completed successfully in DMA.
   output         tx_dma_hresp_notok;  // DMA indicates HRESP not OK on frame.
   output         tx_dma_late_col;     // late collision indicator
   output         tx_dma_toomanyretry; // too many retires indicator
   output         tx_dma_underflow;    // Undefflow indicator
   output         tx_dma_buffers_ex;   // DMA indicates buffers were exhausted
                                       // before SOP for frame written to FIFO.
   output         tx_dma_buff_ex_mid;  // DMA indicates buffers were exhausted
                                       // after SOP for frame written to FIFO.
   output   [3:0] tx_dma_int_queue;    // Identifies which queue the interupt is destined
   output         tx_dma_go;           // DMA indicates on-going activity.
   output [(p_edma_queues*32)-1:0] tx_dma_descr_ptr;    // Descriptor queue pointer for debug
   output         tx_dma_descr_ptr_tog;   // handshake for tx_dma_descr_ptr

   output         tx_ena;                      // DPRAM Interface
   output         tx_wea;                      // DPRAM Interface
   output  [p_edma_tx_pbuf_addr-1:0] tx_addra; // DPRAM Interface
   output  [p_edma_tx_pbuf_data-1:0] tx_dia;   // DPRAM Interface
   output  [p_edma_tx_pbuf_pwid-1:0] tx_dia_par;

   output         tx_enb;                      // DPRAM Interface
   output         tx_web;                      // DPRAM Interface
   output  [p_edma_tx_pbuf_addr-1:0] tx_addrb; // DPRAM Interface
   input   [p_edma_tx_pbuf_data-1:0] tx_dob;   // DPRAM Interface
   input   [p_edma_tx_pbuf_pwid-1:0] tx_dob_par;

   output  [(p_edma_tx_pbuf_addr*p_edma_queues)-1:0] dpram_fill_lvl;

   // AXI specific sideband ports
   input  [47:0]   tx_pbuf_segments;

   input  [3:0]    tx_top_q_id;

     // 64b addressing support and extended BD from reg_top
   input  [31:0] upper_tx_q_base_addr; // upper 32b base address for all buffer descriptors
   input         dma_addr_bus_width;

   input         tx_bd_extended_mode_en;   // enable extended BD mode, which is used to Descriptor TS insertion
   input   [1:0] tx_bd_ts_mode;

   // Timestamp for current tx packet
   input  [41:0] tx_timestamp;
   input   [5:0] tx_timestamp_prty; // RAS - parity protection for the TX Timestamp[41:0] to DMA Descriptor


   // PTP frame decoded signals
   input         event_frame_tx;          // sync/delay_req/pdelay_req/pdelay_resp frames
   input         general_frame_tx;        // PTP frame which is not an event frame

   // lockup detection
   output [p_edma_queues-1:0]
                    full_pkt_inc;     // Complete packet written to SRAM
   output [p_edma_queues-1:0]
                    used_bit_vec;     // Used bit read for each queue
   output           lockup_flush;     // Major error flush

   // RAS - signals going to gem_reg_top
   output   asf_dap_tx_rd_err;          // Parity error in tx read block
   output   asf_dap_tx_wr_err;          // Parity error in tx write block

   // -----------------------------------------------------------------------
   //
   //                  Internal Signals
   //
   // -----------------------------------------------------------------------

   wire [p_edma_queues-1:0] end_of_packet_tog;   // Handshaking signal to DPRAM Rd I/f
   wire [p_edma_queues-1:0] cutthru_buffer_pending;   // Buffer full in partial store and forward mode
   wire [(p_edma_queues*4)-1:0] num_pkts_xfer;       // number of frams with end_of_packet_tog
   wire [p_edma_queues-1:0] pkt_captured;        // end_of_packet_tog seen tx_clk domain
   wire [p_edma_queues-1:0] part_of_packet_tog;  // Handshaking signal to DPRAM Rd I/f
   wire [p_edma_queues-1:0] pkt_end_new;  // Good packet written
   wire [p_edma_queues-1:0] dpram_almost_empty;
   wire           pkt_end_flush;       // Handshaking signal to DPRAM Rd I/f
   wire           full_pkt_read;       // Handshaking signal to DPRAM Wr I/f
   wire           part_pkt_read;       // Handshaking signal to DPRAM Wr I/f
   wire           underflow_tog;       // Handshaking signal to DPRAM Wr I/f
   wire   [77:0]  xfer_status_bus;
   wire   [3:0]   part_pkt_queue;
   wire   [48:0]  xfer_status_bus_ts;
   wire   [128:0]  hrdata_pad;
   assign    hrdata_pad = {{(129-p_edma_bus_width){1'b0}},hrdata};

   wire [p_edma_tx_pbuf_queue_segment_size-1:0] TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY [p_edma_queues-1:0];
   wire [p_edma_tx_pbuf_queue_segment_size-1:0] TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY [p_edma_queues-1:0];

   wire [(p_edma_tx_pbuf_queue_segment_size*p_edma_queues)-1:0] TX_PBUF_SEGMENTS_LOWER_ADDR;
   wire [(p_edma_tx_pbuf_queue_segment_size*p_edma_queues)-1:0] TX_PBUF_SEGMENTS_UPPER_ADDR;
   wire [(16*5)-1:0] TX_PBUF_NUM_SEGMENTS;
   wire         xfer_status_captured;
   reg [(p_edma_tx_pbuf_addr*p_edma_queues)-1:0] TX_PBUF_MAX_FILL_LVL;

   wire [p_edma_tx_pbuf_prty+p_edma_tx_pbuf_data-1:0] tx_dia_int;
   wire [p_edma_tx_pbuf_prty+p_edma_tx_pbuf_data-1:0] tx_dob_int;
   generate if (p_edma_asf_dap_prot == 1) begin : gen_asf_sram_par_con
    assign {tx_dia_par,
            tx_dia}   = tx_dia_int;
    assign tx_dob_int = {tx_dob_par,tx_dob};
   end else begin : gen_no_asf_sram_par_con
    assign tx_dia     = tx_dia_int;
    assign tx_dob_int = tx_dob;
    assign tx_dia_par = {p_edma_tx_pbuf_pwid{1'b0}};
   end
   endgenerate

   // -----------------------------------------------------------------------
   //
   //             Calculate segment uppper and lower bounds
   //
   // -----------------------------------------------------------------------

  genvar g;
  generate if (p_edma_queues > 32'd1) begin : gen_priq_set_segments
      // Create an string holding the number of segments for each queue.
      // This would normally be done as a parameter but with basic verilog
      // it's not quite as easy, so a wire has been created. The array accounts
      // for 16 entries but it's unlikely more than 16 entries will be used,
      // but it's very easy to update if that's the case
      wire [4:0] TX_PBUF_NUM_SEGMENTS_ARRAY [15:0];
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[0]  = 5'd2**tx_pbuf_segments[2:0];
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[1]  = 5'd2**tx_pbuf_segments[5:3];
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[2]  = 5'd2**tx_pbuf_segments[8:6];
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[3]  = 5'd2**tx_pbuf_segments[11:9];
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[4]  = 5'd2**tx_pbuf_segments[14:12];
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[5]  = 5'd2**tx_pbuf_segments[17:15];
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[6]  = 5'd2**tx_pbuf_segments[20:18];
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[7]  = 5'd2**tx_pbuf_segments[23:21];
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[8]  = 5'd2**tx_pbuf_segments[26:24];
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[9]  = 5'd2**tx_pbuf_segments[29:27];
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[10] = 5'd2**tx_pbuf_segments[32:30];
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[11] = 5'd2**tx_pbuf_segments[35:33];
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[12] = 5'd2**tx_pbuf_segments[38:36];
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[13] = 5'd2**tx_pbuf_segments[41:39];
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[14] = 5'd2**tx_pbuf_segments[44:42];
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[15] = 5'd2**tx_pbuf_segments[47:45];

      assign TX_PBUF_NUM_SEGMENTS[4:0]   = TX_PBUF_NUM_SEGMENTS_ARRAY[0];
      assign TX_PBUF_NUM_SEGMENTS[9:5]   = TX_PBUF_NUM_SEGMENTS_ARRAY[1];
      assign TX_PBUF_NUM_SEGMENTS[14:10] = TX_PBUF_NUM_SEGMENTS_ARRAY[2];
      assign TX_PBUF_NUM_SEGMENTS[19:15] = TX_PBUF_NUM_SEGMENTS_ARRAY[3];
      assign TX_PBUF_NUM_SEGMENTS[24:20] = TX_PBUF_NUM_SEGMENTS_ARRAY[4];
      assign TX_PBUF_NUM_SEGMENTS[29:25] = TX_PBUF_NUM_SEGMENTS_ARRAY[5];
      assign TX_PBUF_NUM_SEGMENTS[34:30] = TX_PBUF_NUM_SEGMENTS_ARRAY[6];
      assign TX_PBUF_NUM_SEGMENTS[39:35] = TX_PBUF_NUM_SEGMENTS_ARRAY[7];
      assign TX_PBUF_NUM_SEGMENTS[44:40] = TX_PBUF_NUM_SEGMENTS_ARRAY[8];
      assign TX_PBUF_NUM_SEGMENTS[49:45] = TX_PBUF_NUM_SEGMENTS_ARRAY[9];
      assign TX_PBUF_NUM_SEGMENTS[54:50] = TX_PBUF_NUM_SEGMENTS_ARRAY[10];
      assign TX_PBUF_NUM_SEGMENTS[59:55] = TX_PBUF_NUM_SEGMENTS_ARRAY[11];
      assign TX_PBUF_NUM_SEGMENTS[64:60] = TX_PBUF_NUM_SEGMENTS_ARRAY[12];
      assign TX_PBUF_NUM_SEGMENTS[69:65] = TX_PBUF_NUM_SEGMENTS_ARRAY[13];
      assign TX_PBUF_NUM_SEGMENTS[74:70] = TX_PBUF_NUM_SEGMENTS_ARRAY[14];
      assign TX_PBUF_NUM_SEGMENTS[79:75] = TX_PBUF_NUM_SEGMENTS_ARRAY[15];

      // Calculate the upper address bound for each queue and the fill level. Ideally
      // we would use a 2 dimensional array for this, but we cannot pass this down
      // through the hierarchy, so we create one long string with each bound concatenated one
      // after the other
      // Using a simple example of a 3 priority queue configuration, where q0 has 1
      // segment, q1 has 2 segments and q2 has 1 segment the lower address and upper address
      // would be configured as follows:
      //
      //    Queue | Lower Address | Upper Address
      //    ------+---------------+--------------
      //      0   |      0        |      0
      //      1   |      1        |      2
      //      2   |      3        |      3
      //

      assign TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[0] = {p_edma_tx_pbuf_queue_segment_size{1'b0}};
      assign TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[0] = TX_PBUF_NUM_SEGMENTS[4:0] - 1;

      for (g=1; g<p_edma_queues; g=g+1) begin : gen_tx_pbuf_segments_addr_part2
        assign TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[g] = TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[g-1] + 1;
        assign TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[g] = TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[g] + TX_PBUF_NUM_SEGMENTS_ARRAY[g] - 1;
      end

      for (g=0; g<p_edma_queues; g=g+1) begin : gen_tx_pbuf_segments_addr_part3

        assign TX_PBUF_SEGMENTS_LOWER_ADDR[(p_edma_tx_pbuf_queue_segment_size*(g+1))-1:p_edma_tx_pbuf_queue_segment_size*g] = TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[g];

        if (g==p_edma_queues-1) begin : gen_top_q
          assign TX_PBUF_SEGMENTS_UPPER_ADDR[(p_edma_tx_pbuf_queue_segment_size*(g+1))-1:p_edma_tx_pbuf_queue_segment_size*g] = TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[g];
        end else begin : gen_others
          assign TX_PBUF_SEGMENTS_UPPER_ADDR[(p_edma_tx_pbuf_queue_segment_size*(g+1))-1:p_edma_tx_pbuf_queue_segment_size*g] =
                                                                              TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[g] + TX_PBUF_NUM_SEGMENTS_ARRAY[g] - 1;
        end

          // Calculate the maximum fill level

        integer intc;
        wire  [p_edma_tx_pbuf_queue_segment_size-1:0] tx_pbuf_segments_upper_m_lower_addr_array;
        wire  [p_edma_tx_pbuf_queue_segment_size  :0] tx_pbuf_segments_upper_m_lower_addr_array_p1;
        
        assign tx_pbuf_segments_upper_m_lower_addr_array    = (TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[g] - TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[g]);
        assign tx_pbuf_segments_upper_m_lower_addr_array_p1 = {1'b0,tx_pbuf_segments_upper_m_lower_addr_array} + {{(p_edma_tx_pbuf_queue_segment_size){1'b0}},1'b1};
        
        always @(*)
        begin
          for (intc = 0; intc < p_edma_tx_pbuf_addr; intc = intc+1)
          begin
            if (intc < (p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size))
              TX_PBUF_MAX_FILL_LVL[p_edma_tx_pbuf_addr*g+intc] = 1'b1;
            else if ((2**(intc - (p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size)+1)-1) < {{(31-p_edma_tx_pbuf_queue_segment_size){1'b0}},tx_pbuf_segments_upper_m_lower_addr_array_p1})
              TX_PBUF_MAX_FILL_LVL[p_edma_tx_pbuf_addr*g+intc] = 1'b1;
            else
              TX_PBUF_MAX_FILL_LVL[p_edma_tx_pbuf_addr*g+intc] = 1'b0;
          end
        end

      end

   end else begin : gen_one_q
    assign TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[0] = {p_edma_tx_pbuf_queue_segment_size{1'b0}};
    assign TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[0] = {p_edma_tx_pbuf_queue_segment_size{1'b0}};
    assign TX_PBUF_SEGMENTS_LOWER_ADDR = {(p_edma_tx_pbuf_queue_segment_size*p_edma_queues){1'b0}};
    assign TX_PBUF_SEGMENTS_UPPER_ADDR = {(p_edma_tx_pbuf_queue_segment_size*p_edma_queues){1'b0}};
    assign TX_PBUF_NUM_SEGMENTS = 80'd0;
    // Calculate the maximum fill level
    always @(*)
       begin
          if (tx_pbuf_size)
             TX_PBUF_MAX_FILL_LVL = {p_edma_tx_pbuf_addr{1'b1}};
          else
             TX_PBUF_MAX_FILL_LVL = {p_edma_tx_pbuf_addr{1'b1}} >> 1;
       end
   end
   endgenerate



   // -----------------------------------------------------------------------
   //
   //               Cutthru status word FIFO
   //
   // -----------------------------------------------------------------------

  wire [p_edma_tx_pbuf_addr+95:0] cutthru_status_word_valid;
  wire                           cutthru_status_word_pop_empty;
  wire [p_edma_tx_pbuf_addr+95:0] cutthru_status_word_pushd;
  wire                           cutthru_status_word_pop;
  wire                           cutthru_status_word_push;

  generate if (p_edma_pbuf_cutthru == 1) begin : gen_cutthru_fifo
    wire [p_edma_tx_pbuf_addr+95:0] cutthru_status_word_popd;


    edma_gen_async_fifo #(

       .ADDR_W(0),
       .DATA_W(p_edma_tx_pbuf_addr+96)

    ) i_edma_gen_async_fifo_cutthru_status_words (

       .clk_push     (hclk),
       .rst_push_n   (n_hreset),
       .push         (cutthru_status_word_push),
       .pushd        (cutthru_status_word_pushd),
       .push_full    (),
       .push_size    (),
       .push_overflow(),

       .clk_pop      (tx_r_clk),
       .rst_pop_n    (tx_r_rst_n),
       .pop          (cutthru_status_word_pop & ~cutthru_status_word_pop_empty),
       .popd         (cutthru_status_word_popd),
       .pop_empty    (cutthru_status_word_pop_empty),
       .pop_size     (),
       .pop_underflow()
    );

   assign cutthru_status_word_valid = cutthru_status_word_popd &
                                    {(p_edma_tx_pbuf_addr+96){~cutthru_status_word_pop_empty}};

  end else begin : gen_no_cutthru_fifo
   assign cutthru_status_word_valid     = {(p_edma_tx_pbuf_addr+96){1'b0}};
   assign cutthru_status_word_pop_empty = 1'b1;
  end
  endgenerate

  // For the XGM, the MAC datapath is always 64bit.
  wire [1:0] mac_bus_width;
  generate if (p_xgm == 1) begin : gen_set_mac_width_64
    assign mac_bus_width = 2'b01;
  end else begin : gen_set_mac_width
    assign mac_bus_width = dma_bus_width;
  end
  endgenerate

   // -----------------------------------------------------------------------
   //
   //                  pbuf transmit read
   //
   // -----------------------------------------------------------------------

   edma_pbuf_ahb_tx_wr #(

    .p_edma_axi                         (p_edma_axi),
    .p_edma_spram                       (p_edma_spram),
    .p_edma_addr_width                  (p_edma_addr_width),
    .p_edma_tx_pbuf_data                (p_edma_tx_pbuf_data),

    .p_edma_tx_pbuf_addr                (p_edma_tx_pbuf_addr),
    .p_edma_tx_pbuf_queue_segment_size  (p_edma_tx_pbuf_queue_segment_size),
    .p_edma_pbuf_cutthru                (p_edma_pbuf_cutthru),
    .p_edma_queues                      (p_edma_queues),
    .p_edma_hprot_value                 (p_edma_hprot_value),
    .p_edma_asf_dap_prot                (p_edma_asf_dap_prot),
    .p_edma_tx_pbuf_prty                (p_edma_tx_pbuf_prty)

   ) i_edma_pbuf_ahb_tx_wr (
      // Queue upper and lower bound constants
      .TX_PBUF_SEGMENTS_LOWER_ADDR(TX_PBUF_SEGMENTS_LOWER_ADDR),
      .TX_PBUF_SEGMENTS_UPPER_ADDR(TX_PBUF_SEGMENTS_UPPER_ADDR),
      .TX_PBUF_NUM_SEGMENTS(TX_PBUF_NUM_SEGMENTS),

      .TX_PBUF_MAX_FILL_LVL(TX_PBUF_MAX_FILL_LVL),

      // system signals.
      .hclk                 (hclk),
      .n_hreset             (n_hreset),

      .trigger_dma_tx_start (trigger_dma_tx_start),

      .tx_top_q_id          (tx_top_q_id),

      // signals coming from the gem_hclk_syncs block (internal).
      //.too_many_retry_hclk  (too_many_retry_hclk),
      //.late_coll_occ_hclk   (late_coll_occ_hclk),
      .new_tx_q_ptr_pulse   (new_tx_q_ptr_pulse),
      .tx_halt_hclk         (tx_halt_hclk),
      .tx_start_hclk_pulse  (tx_start_hclk_pulse),
      .enable_tx_hclk       (enable_tx_hclk),
      .tx_dma_descr_base_addr(tx_dma_descr_base_addr),
      .tx_stat_capt_pulse   (tx_stat_capt_pulse),

      // signals coming from gem_reg_top (gem_registers).
      .dma_bus_width        (dma_bus_width),
      .tx_pbuf_tcp_en       (tx_pbuf_tcp_en),
      .ahb_burst_length     (ahb_burst_length),
      .endian_swap          (endian_swap),
      //.tx_pbuf_wmark        (tx_pbuf_wmark),
      .tx_cutthru_threshold (tx_cutthru_threshold),
      .tx_cutthru           (tx_cutthru),
      .full_duplex          (full_duplex),
      .force_max_ahb_burst_tx(force_max_ahb_burst_tx),

      // signals going to gem_reg_top (gem_pclk_syncs).
      .tx_dma_complete_ok   (tx_dma_complete_ok),
      .tx_dma_buffers_ex    (tx_dma_buffers_ex),
      .tx_dma_buff_ex_mid   (tx_dma_buff_ex_mid),
      .tx_dma_hresp_notok   (tx_dma_hresp_notok),
      .tx_dma_late_col      (tx_dma_late_col),
      .tx_dma_toomanyretry  (tx_dma_toomanyretry),
      .tx_dma_underflow     (tx_dma_underflow),
      .tx_dma_int_queue     (tx_dma_int_queue),
      .tx_dma_go            (tx_dma_go),
      .tx_dma_descr_ptr     (tx_dma_descr_ptr),
      .tx_dma_descr_ptr_tog (tx_dma_descr_ptr_tog),
      .tx_dma_stable_tog    (tx_dma_stable_tog),

      // Signals going to AHB
      // TX Descriptor Master outputs
      .hbusreq_descr        (hbusreq_descr),
      .hlock_descr          (hlock_descr),
      .hburst_descr         (hburst_descr),
      .htrans_descr         (htrans_descr),
      .hsize_descr          (hsize_descr),
      .hwrite_descr         (hwrite_descr),
      .hprot_descr          (hprot_descr),
      .haddr_descr          (haddr_descr),
      .hwdata_descr         (hwdata_descr),
      // TX DATA Master outputs
      .hbusreq_data         (hbusreq_data),
      .hlock_data           (hlock_data),
      .hburst_data          (hburst_data),
      .htrans_data          (htrans_data),
      .hsize_data           (hsize_data),
      .hwrite_data          (hwrite_data),
      .hprot_data           (hprot_data),
      .haddr_data           (haddr_data),
      .hwdata_data          (hwdata_data),

      // Signals coming from AHB
      .hgrant_descr         (hgrant_descr),
      .hgrant_data          (hgrant_data),
      .hready               (hready),
      .hresp                (hresp),
      .hrdata               (hrdata_pad[127:0]),

      // DPRAM interface
      .tx_ena               (tx_ena),
      .tx_wea               (tx_wea),
      .tx_addra             (tx_addra),
      .tx_dia               (tx_dia_int),

      .end_of_packet_tog    (end_of_packet_tog),
      .cutthru_buffer_pending(cutthru_buffer_pending),
      .num_pkts_xfer        (num_pkts_xfer),
      .pkt_captured         (pkt_captured),
      .xfer_status_bus      (xfer_status_bus),
      .xfer_status_bus_ts   (xfer_status_bus_ts),
      .part_of_packet_tog   (part_of_packet_tog),
      .pkt_end_new          (pkt_end_new),
      .dpram_almost_empty   (dpram_almost_empty),
      .pkt_end_flush        (pkt_end_flush),
      .full_pkt_read        (full_pkt_read),
      .part_pkt_read        (part_pkt_read),
      .part_pkt_queue       (part_pkt_queue),

      .dpram_fill_lvl       (dpram_fill_lvl),

      .underflow_tog        (underflow_tog),
      .xfer_status_captured (xfer_status_captured),

      // 64b addressing
      .upper_tx_q_base_addr     (upper_tx_q_base_addr),
      .dma_addr_bus_width       (dma_addr_bus_width),

      .cutthru_status_word      (cutthru_status_word_pushd),
      .cutthru_status_word_push (cutthru_status_word_push),

      .tx_bd_extended_mode_en   (tx_bd_extended_mode_en),

      // ASF - signals going to gem_reg_top
      .asf_dap_tx_wr_err        (asf_dap_tx_wr_err),

      // lockup detection
      .full_pkt_inc             (full_pkt_inc),
      .used_bit_vec             (used_bit_vec),
      .lockup_flush             (lockup_flush)

   );




   // -----------------------------------------------------------------------
   //
   //                  pbuf transmit read
   //
   // -----------------------------------------------------------------------

   edma_pbuf_ahb_tx_rd #(

    .p_edma_spram                       (p_edma_spram),
    .p_edma_pbuf_cutthru                (p_edma_pbuf_cutthru),
    .p_edma_queues                      (p_edma_queues),
    .p_edma_tx_pbuf_data                (p_edma_tx_pbuf_data),
    .p_edma_tx_pbuf_prty                (p_edma_tx_pbuf_prty),
    .p_edma_tx_pbuf_addr                (p_edma_tx_pbuf_addr),
    .p_emac_bus_width                   (p_emac_bus_width),
    .p_emac_parity_width                (p_emac_parity_width),
    .p_edma_tx_pbuf_queue_segment_size  (p_edma_tx_pbuf_queue_segment_size),
    .p_edma_asf_dap_prot                (p_edma_asf_dap_prot)

   ) i_edma_pbuf_ahb_tx_rd (

      // Queue upper and lower bound constants
      .TX_PBUF_SEGMENTS_LOWER_ADDR(TX_PBUF_SEGMENTS_LOWER_ADDR),
      .TX_PBUF_SEGMENTS_UPPER_ADDR(TX_PBUF_SEGMENTS_UPPER_ADDR),
      .TX_PBUF_NUM_SEGMENTS(TX_PBUF_NUM_SEGMENTS),

      // system signals.
      .tx_r_clk             (tx_r_clk),
      .tx_r_rst_n           (tx_r_rst_n),

      // Mac Interface
      .tx_r_valid           (tx_r_valid),
      .tx_r_data            (tx_r_data),
      .tx_r_data_par        (tx_r_data_par),
      .tx_r_eop             (tx_r_eop),
      .tx_r_sop             (tx_r_sop),
      .tx_r_mod             (tx_r_mod),
      .tx_r_err             (tx_r_err),
      .tx_r_flushed         (tx_r_flushed),
      .tx_r_underflow       (tx_r_underflow),
      .tx_r_control         (tx_r_control),
      .tx_r_frame_size_vld  (tx_r_frame_size_vld),
      .tx_r_frame_size      (tx_r_frame_size),
      .tx_r_data_rdy        (tx_r_data_rdy),
      .dma_is_busy          (dma_is_busy),
      .tx_r_rd              (tx_r_rd),
      .tx_r_rd_int          (tx_r_rd_int),
      .tx_r_queue_int       (tx_r_queue_int),
      .dma_tx_end_tog       (dma_tx_end_tog),
      .dma_tx_small_end_tog (dma_tx_small_end_tog),
      .collision_occured    (collision_occured),
      .late_coll_occured    (late_coll_occured),
      .too_many_retries     (too_many_retries),
      .underflow_frame      (underflow_frame),

      // signals going to gem_mac (gem_tx).
      .dma_tx_status_tog    (dma_tx_status_tog),

      // signals coming from gem_reg_top
      .dma_bus_width        (mac_bus_width),
      .full_duplex          (full_duplex),

      // DPRAM interface
      .tx_enb               (tx_enb),
      .tx_web               (tx_web),
      .tx_addrb             (tx_addrb),
      .tx_dob               (tx_dob_int),

      .end_of_packet_tog    (end_of_packet_tog),
      .cutthru_buffer_pending(cutthru_buffer_pending),
      .num_pkts_xfer        (num_pkts_xfer),
      .pkt_captured         (pkt_captured),
      .part_of_packet_tog   (part_of_packet_tog),
      .pkt_end_new          (pkt_end_new),
      .dpram_almost_empty   (dpram_almost_empty),
      .pkt_end_flush        (pkt_end_flush),
      .full_pkt_read        (full_pkt_read),
      .part_pkt_read        (part_pkt_read),
      .part_pkt_queue       (part_pkt_queue),
      .xfer_status_bus      (xfer_status_bus),
      .xfer_status_bus_ts   (xfer_status_bus_ts),
      .underflow_tog        (underflow_tog),
      .xfer_status_captured (xfer_status_captured),
      .tx_bd_ts_mode        (tx_bd_ts_mode),

      // Timestamp for current packet
      .tx_timestamp         (tx_timestamp),
      .tx_timestamp_prty    (tx_timestamp_prty),

      // PTP frame decoded signals
      .event_frame_tx       (event_frame_tx),
      .general_frame_tx     (general_frame_tx),

      .cutthru_status_word(cutthru_status_word_valid),
      .cutthru_status_word_pop(cutthru_status_word_pop),
      .cutthru_status_word_empty(cutthru_status_word_pop_empty),

      // ASF - signals going to gem_reg_top
      .asf_dap_tx_rd_err    (asf_dap_tx_rd_err)

   );


endmodule

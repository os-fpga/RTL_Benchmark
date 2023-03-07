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
//   Filename:           edma_pbuf_ahb_top.v
//   Module Name:        edma_pbuf_ahb_top
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
//   Description :      module to integrate the various components
//                      of the pbuf ahb dma.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module edma_pbuf_ahb_top (

   // clock and reset.
   tx_r_clk,
   tx_r_rst_n,
   rx_w_clk,
   rx_w_rst_n,
   hclk,
   n_hreset,

   // AHB interface signals.
   hgrant,
   hready,
   hresp,
   hrdata,
   hbusreq,
   hlock,
   haddr,
   htrans,
   hwrite,
   hsize,
   hburst,
   hprot,
   hwdata,

   // signals coming from gem_mac (rx fifo interface).
   rx_w_wr,
   rx_w_data,
   rx_w_data_par,
   rx_w_sop,
   rx_w_eop,
   rx_w_err,

   rx_end_tog,
   rx_status_wr_tog,
   rx_pkt_end_tog,
   rx_pkt_status_wr_tog,

   // signals coming from gem_mac (gem_tx).
   dma_tx_end_tog,
   dma_tx_small_end_tog,
   collision_occured,
   late_coll_occured,
   too_many_retries,
   underflow_frame,

   // signals coming from gem_mac (gem_rx).
   dma_rx_end_tog,
   rx_w_bad_frame,
   rx_w_frame_length,
   rx_w_vlan_tagged,
   rx_w_prty_tagged,
   rx_w_tci,
   queue_ptr_rx,

   // signals coming from gem_mac (gem_filter).
   rx_w_broadcast_frame,
   rx_w_mult_hash_match,
   rx_w_uni_hash_match,
   rx_w_ext_match1,
   rx_w_ext_match2,
   rx_w_ext_match3,
   rx_w_ext_match4,
   rx_w_add_match1,
   rx_w_add_match2,
   rx_w_add_match3,
   rx_w_add_match4,
   rx_w_add_match5,
   rx_w_add_match6,
   rx_w_add_match7,
   rx_w_add_match8,
   rx_w_type_match1,
   rx_w_type_match2,
   rx_w_type_match3,
   rx_w_type_match4,
   rx_w_checksumi_ok,
   rx_w_checksumt_ok,
   rx_w_checksumu_ok,
   rx_w_snap_frame,
   rx_w_crc_error,
   rx_w_l4_offset,
   rx_w_pld_offset,

   // Async input used to trigger tx_start
   trigger_dma_tx_start,

   // signals coming from gem_reg_top (gem_registers).
   tx_cutthru_threshold,
   tx_cutthru,
   full_duplex,
   force_discard_on_err,
   force_discard_on_err_q,
   force_max_ahb_burst_tx,
   rx_dma_stat_capt_tog,
   tx_dma_stat_capt_tog,
   flush_rx_pkt_pclk,
   hdr_data_splitting_en,
   infinite_last_dbuf_size_en,
   force_max_ahb_burst_rx,
   rx_buff_not_rdy_pclk,
   dma_bus_width,
   rx_toe_enable,
   tx_dma_descr_base_addr,
   enable_transmit,
   enable_receive,
   new_receive_q_ptr,
   new_transmit_q_ptr,
   tx_start_pclk,
   tx_halt_pclk,
   rx_dma_descr_base_addr,
   rx_dma_descr_base_par,
   rx_dma_buffer_size,
   rx_dma_buffer_offset,
   ahb_burst_length,
   rx_no_crc_check,
   jumbo_enable,
   jumbo_max_length,
   endian_swap,
   dma_addr_or_mask,
   crc_error_report,

   // signals going to gem_mac (tx fifo interface).
   tx_r_data,
   tx_r_data_par,
   tx_r_mod,
   tx_r_sop,
   tx_r_eop,
   tx_r_err,
   tx_r_valid,
   tx_r_data_rdy,
   dma_is_busy,
   tx_r_underflow,
   tx_r_flushed,
   tx_r_control,
   tx_r_frame_size_vld,
   tx_r_frame_size,

   // signal coming from gem_mac (tx fifo interface).
   tx_r_rd,
   tx_r_rd_int,
   tx_r_queue_int,

   // signals going to gem_mac.
   dma_tx_status_tog,
   dma_rx_status_tog,

   // Stats from pkt buffer to register block ...
   rx_dma_pkt_flushed,
   rx_pkt_dbuff_overflow,
   rx_w_overflow,

   // signals for TX packet buffer if included
   tx_pbuf_size,
   tx_pbuf_tcp_en,

   // signals going to RX packet buffer if included
   rx_pbuf_size,
   rx_cutthru_threshold,
   rx_cutthru,

   // SRAM interface ..
   tx_sram_wea,
   tx_sram_ena,
   tx_sram_addra,
   tx_sram_dia,
   tx_sram_dia_par,
   tx_sram_doa,
   tx_sram_doa_par,
   tx_sram_web,
   tx_sram_enb,
   tx_sram_addrb,
   tx_sram_dob,
   tx_sram_dob_par,

   rx_sram_wea,
   rx_sram_ena,
   rx_sram_addra,
   rx_sram_dia,
   rx_sram_dia_par,
   rx_sram_doa,
   rx_sram_doa_par,
   rx_sram_web,
   rx_sram_enb,
   rx_sram_addrb,
   rx_sram_dob,
   rx_sram_dob_par,

   // signals going to gem_reg_top (gem_reg_top).
   tx_dma_complete_ok,
   tx_dma_buffers_ex,
   tx_dma_buff_ex_mid,
   tx_dma_hresp_notok,
   tx_dma_late_col,
   tx_dma_toomanyretry,
   tx_dma_underflow,
   tx_dma_go,
   tx_dma_descr_ptr,
   tx_dma_descr_ptr_tog,
   rx_dma_stable_tog,
   tx_dma_stable_tog,
   rx_dma_complete_ok,
   rx_dma_resource_err,
   rx_dma_buff_not_rdy,
   rx_dma_hresp_notok,
   tx_dma_int_queue,
   rx_dma_int_queue,

   // Specific inputs to support Priority Queues
   rx_databuf_wr_q,

   rx_dma_descr_ptr,
   rx_dma_descr_ptr_tog,

   tx_pbuf_segments,
   tx_top_q_id,

    // 64b addressing support
    upper_tx_q_base_addr,
    upper_rx_q_base_addr,
    upper_rx_q_base_par,
    dma_addr_bus_width,

    tx_bd_extended_mode_en,
    tx_bd_ts_mode,

    rx_bd_extended_mode_en,
    rx_bd_ts_mode,

    // Timestamp for current tx packet
    tx_timestamp,

    // Timestamp for current rx packet
    rx_timestamp,

    // RAS - Timestamp parity protection
    tx_timestamp_prty,
    rx_timestamp_prty,

    // Debug port
    tx_dpram_fill_lvl,
    rx_dpram_fill_lvl,

    // ASF error signals
    asf_dap_tx_wr_err,
    asf_dap_tx_rd_err,
    asf_dap_rx_wr_err,
    asf_dap_rx_rd_err,

    // TX lockup detection
    tx_edma_full_pkt_inc,
    tx_edma_used_bit_vec,
    tx_edma_lockup_flush,

    // RX lockup detection
    rx_edma_overflow,

    restart_counter_top,

    // AXI configuration, soft config to determine the AXI thresholds
    // when the underlying tx dma is full
    axi_tx_full_adj_0,
    axi_tx_full_adj_1,

    // PTP frame decoded signals
    event_frame_tx,
    general_frame_tx,
    sof_rx,
    event_frame_rx,
    general_frame_rx,

    // Signals to rx-rd module for per-queue rx flushing
    max_val_pclk,
    limit_num_bytes_allowed_ambaclk,
    fill_lvl_breached
);

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

   // clock and reset.
   input          tx_r_clk;             // transmit fifo clock.
   input          tx_r_rst_n;           // transmit fifo reset.
   input          rx_w_clk;             // receive fifo clock.
   input          rx_w_rst_n;           // receive fifo reset.
   input          hclk;                 // AMBA clock.
   input          n_hreset;             // AMBA reset.


   // AHB interface signals.
   input         hgrant;               // AHB arbiter control grant.
   input         hready;               // AHB Slave ready.
   input   [1:0] hresp;                // AHB Slave response (OK, error, retry
                                       // or split).
   input   [p_edma_bus_width-1:0]
                 hrdata;               // AHB input data.
   output        hbusreq;              // AHB bus request.
   output        hlock;                // lock the bus - always asserted with
   output  [p_edma_addr_width-1:0]
                 haddr;                // hbusreq address to be accessed.
   output  [1:0] htrans;               // bus transfer type (nonseq, seq, idle
                                       // or busy.
   output        hwrite;               // AHB write signal (active high).
   output  [2:0] hsize;                // transfer size -
                                       // set to 3'b010 for 32 bit words.
                                       // set to 3'b011 for 64 bit words.
                                       // set to 3'b100 for 128 bit words.
   output  [2:0] hburst;               // burst type (single, incrementing etc).
   output  [3:0] hprot;                // Protection type - unused tied low.
   output  [p_edma_bus_width-1:0]
                 hwdata;               // AHB Write data.


   // signals coming from gem_mac (rx fifo interface).
   input         rx_w_wr;              // write control for rx fifo.
   input [p_emac_bus_width-1:0]
                 rx_w_data;            // write data for rx fifo.
   input [p_emac_bus_pwid-1:0]
                 rx_w_data_par;
   input         rx_w_sop;             // rx start of packet indicator.
   input         rx_w_eop;             // rx end of packet indicator.
   input         rx_w_err;             // rx packet in error indicator.

   // signal coming from gem_mac (tx fifo interface).
   input [p_edma_queues-1:0]
                 tx_r_rd;              // rx fifo read control.
   input [p_edma_queues-1:0]
                 tx_r_rd_int;          // Early version of tx_r_rd
   input [3:0]   tx_r_queue_int;       // early version of the queue ID, timed with tx_r_rd_int

   // signals coming from gem_mac (gem_tx).
   input         dma_tx_end_tog;       // Toggled at the end of frame
                                       // transmission (loads new tx
                                       // address and length), will not update
                                       // until dma_tx_status_tog is returned.
   input         dma_tx_small_end_tog; // Toggle signal indicating the end of
                                       // transmission of a smal frame. Used
                                       // for xgm only, where the xgm mac will
                                       // automatically ignore packets <9
                                       // bytes.
   input         collision_occured;    // set if collision happens during
                                       // frame transmission, cleared when
                                       // dma_tx_status_tog is returned.
   input         late_coll_occured;    // set if late collision occurs in
                                       // gigabit mode (flushes tx fifo),
                                       // cleared when dma_tx_status_tog
                                       // is returned.
   input         too_many_retries;     // signals too many retries error
                                       // condition (flushes tx fifo),
                                       // cleared when dma_tx_status_tog
                                       // is returned.
   input         underflow_frame;      // asserted high at the end of frame
                                       // to indicate a fifo underrun or
                                       // tx_r_err condition, cleared when
                                       // dma_tx_status_tog is returned.

   // When using the packet buffer, we need to delay the
   // handshake between the MAC and the REG block, so
   // that stats are updated at the correct time
   // 'rx_end_tog' comes from the mac to indicate
   // the stats are valid
   // 'rx_status_wr_tog' is sent back to the MAC to indicate
   // the pkt buffer has captured the stats from the MAC
   // 'rx_pkt_end_tog' indicates to the reg block
   // that stats are ready
   // 'rx_pkt_status_wr_tog' indicates from the reg block
   // that stats have been captured
   input         rx_end_tog;
   output        rx_status_wr_tog;
   output        rx_pkt_end_tog;
   input         rx_pkt_status_wr_tog;

   // signals coming from gem_mac (gem_rx).
   input         dma_rx_end_tog;       // Toggled at the end of frame
                                       // reception, will not update until
                                       // dma_rx_status_tog is returned.
   input         rx_w_bad_frame;       // end of bad receive frame.
   input  [13:0] rx_w_frame_length;    // records frame length for status
                                       // reporting.
   input         rx_w_vlan_tagged;     // used for reporting vlan tag.
   input         rx_w_prty_tagged;     // used for reporting priority tag.
   input   [3:0] rx_w_tci;             // used for reporting vlan priority.
   input   [3:0] queue_ptr_rx;         // Priority Queue Number

   input         rx_w_broadcast_frame; // broadcast frame signal from the
                                       // address checker - rx status
                                       // reporting.
   input         rx_w_mult_hash_match; // multicast hash matched frame signal
                                       // for rx status reporting.
   input         rx_w_uni_hash_match;  // unicast hash matched frame signal
                                       // for rx status reporting.
   input         rx_w_ext_match1;      // external matched frame signal
                                       // for rx status reporting.
   input         rx_w_ext_match2;      // external matched frame signal
                                       // for rx status reporting.
   input         rx_w_ext_match3;      // external matched frame signal
                                       // for rx status reporting.
   input         rx_w_ext_match4;      // external matched frame signal
                                       // for rx status reporting.
   input         rx_w_add_match1;      // specific address register 1 matched
                                       // destination address.
   input         rx_w_add_match2;      // specific address register 2 matched
                                       // destination address.
   input         rx_w_add_match3;      // specific address register 3 matched
                                       // destination address.
   input         rx_w_add_match4;      // specific address register 4 matched
                                       // destination address.
   input         rx_w_add_match5;      // specific address register 5 matched
                                       // destination address.
   input         rx_w_add_match6;      // specific address register 6 matched
                                       // destination address.
   input         rx_w_add_match7;      // specific address register 7 matched
                                       // destination address.
   input         rx_w_add_match8;      // specific address register 8 matched
                                       // destination address.
   input         rx_w_type_match1;     // specific type register 1 matched
                                       // type field.
   input         rx_w_type_match2;     // specific type register 2 matched
                                       // type field.
   input         rx_w_type_match3;     // specific type register 3 matched
                                       // type field.
   input         rx_w_type_match4;     // specific type register 4 matched
                                       // type field.
   input         rx_w_checksumi_ok;    // IP checksum checked and was OK.
   input         rx_w_checksumt_ok;    // TCP checksum checked and was OK.
   input         rx_w_checksumu_ok;    // UDP checksum checked and was OK.
   input         rx_w_snap_frame;      // Frame was SNAP encapsulated and
                                       // had no VLAN or VLAN with no CFI.
   input         rx_w_crc_error;       // Frame had FCS error
   input  [11:0] rx_w_l4_offset;       // TCP/UDP offset
   input  [11:0] rx_w_pld_offset;      // PLD offset

   input         trigger_dma_tx_start; // Async input used to trigger tx_start

   // signals coming from gem_reg_top (gem_registers).
   input         rx_dma_stat_capt_tog; // toggle when pclk domain registerred
                                       // rx_dma status signals
   input     [p_edma_tx_pbuf_addr-1:0]
                 tx_cutthru_threshold; // Threshold value
   input         tx_cutthru;           // Enable for cut-thru operation
   input         full_duplex;          // full duplex signal from the network.
                                       // configuration register.
   input         force_discard_on_err; //force packets to be discarded from PBUF
   input         [p_edma_queues-1:0]
                 force_discard_on_err_q; // queue specific version of force_discard_on_err
   input         force_max_ahb_burst_tx; // force max burst length accesses

   input         tx_dma_stat_capt_tog;   // toggle when pclk domain registerred
   input   [8:0] dma_addr_or_mask;       // OR mask for data buf accesses
   input         force_max_ahb_burst_rx; // force max burst length accesses
   input         rx_buff_not_rdy_pclk;   // pclk pulse corresp to posedge of
                                         // rx_dma_buff_not_rdy flag
   input   [1:0] dma_bus_width;          // DMA bus width...
                                         //   00 : 32-bit
                                         //   01 : 64-bit
                                         //   10 : 128-bit
                                         //   11 : 128-bit.
   input         rx_toe_enable;          // Enable RX TCP Offload Engine.
   input   [(p_edma_queues*32)-1:0]      // base address for the buffer descriptor
                 tx_dma_descr_base_addr; // list.
   input         enable_transmit;      // transmit enable signal from network
                                       // control register.
   input         enable_receive;       // receive enable signal from network
                                       // control register.
   input         new_receive_q_ptr;    // asserted when receive queue pointer
                                       // is written.
   input         new_transmit_q_ptr;   // asserted when tx queue pointer
                                       // is written.
   input         tx_start_pclk;        // asserted when bit 9 of network
                                       // control register is written.
   input         tx_halt_pclk;         // asserted when bit 10 of network
                                       // control register is written.
   input         flush_rx_pkt_pclk;    // asserted when bit 18 of network
                                       // control register is written.
   input         hdr_data_splitting_en; // Header Data Splitting Enable
   input         infinite_last_dbuf_size_en; // data buffer pointed to by last descriptor is infinite size
   input         crc_error_report;           // jumbo length reporting
   input [(p_edma_queues*32)-1:0]
                 rx_dma_descr_base_addr;  // rx buffer queue base addr.
   input [(p_edma_queues*4)-1:0]
                 rx_dma_descr_base_par;
   input [(p_edma_queues*8)-1:0]
                  rx_dma_buffer_size;      // buffer depth (in x64 bytes)
   input   [1:0]  rx_dma_buffer_offset;    // offset of the data from buffer start.
   input   [4:0]  ahb_burst_length;        // AHB burst length control
   input          rx_no_crc_check;         // Ignore RX FCS check
   input          jumbo_enable;            // jumbo frames enabled
   input   [13:0] jumbo_max_length;        // jumbo frames size
   input   [1:0]  endian_swap;             // Endian swap enabled

   // signals going to gem_mac (tx fifo interface).
   output  [p_emac_bus_width-1:0]      // output data from the transmit fifo
                 tx_r_data;            // to the tx module.
   output  [p_emac_bus_pwid-1:0]
                 tx_r_data_par;        // Parity

   output  [3:0] tx_r_mod;             // tx number of valid bytes in last
                                       // transfer of the frame.
                                       // 0000 - tx_r_data[127:0] valid,
                                       // 0001 - tx_r_data[7:0] valid,
                                       // 0010 - tx_r_data[15:0] valid, until
                                       // 1111 - tx_r_data[119:0] valid.
   output        tx_r_sop;             // start of packet indicator.
   output        tx_r_eop;             // end of packet indicator.
   output        tx_r_err;             // packet in error indicator.
   output        tx_r_valid;           // new tx data available from fifo.
   output   [p_edma_queues-1:0]
                 tx_r_data_rdy;        // indicates either a complete packet
                                       // is present in the fifo or a certain
                                       // threshold of data has been crossed,
                                       // the mac uses this input to trigger
                                       // a frame transfer.
   output        dma_is_busy;          // DMA is busy - block MAC from requesting
   output        tx_r_underflow;       // signals tx fifo underrun condition.
   output        tx_r_flushed;         // tx fifo has been flushed.
   output        tx_r_control;         // packet control information
   output   [p_edma_queues-1:0]
                 tx_r_frame_size_vld;  // We have the frame size.
   output   [(p_edma_queues*14)-1:0]
                 tx_r_frame_size;      // Frame Length, 1 per queue

   // signals going to gem_mac.
   output        dma_tx_status_tog;    // when toggled, indicates transmit
                                       // status written by dma.
   output        dma_rx_status_tog;    // when toggled, indicates receive
                                       // status written by dma.
   // Stats from pkt buffer to register block
   output         rx_dma_pkt_flushed;     // Frame was dropped due to AHB
                                          // resource error
   output         rx_pkt_dbuff_overflow;  // PBUF overflow
   output         rx_w_overflow;          // Overflow in RX FIFO indication

   // signals for TX packet buffer if included
   input          tx_pbuf_size;        // Programmed size of available TX DPRAM
   input          tx_pbuf_tcp_en;      // TCP TX checksum offload enable

   // signals going to RX packet buffer if included
   input   [1:0]  rx_pbuf_size;        // Programmed size of available RX DPRAM
   input  [p_edma_rx_pbuf_addr-1:0] rx_cutthru_threshold; // Threshold value
   input          rx_cutthru;          // Enable for cut-thru operation

   // SRAM interfaces.
   output         tx_sram_wea;        // Port A is always used for write
   output         tx_sram_ena;
   output [p_edma_tx_pbuf_addr-1:0]
                  tx_sram_addra;
   output [p_edma_tx_pbuf_data-1:0]
                  tx_sram_dia;
   output [p_edma_tx_pbuf_pwid-1:0]
                  tx_sram_dia_par;
   input  [p_edma_tx_pbuf_data-1:0]   // With optional read when SPRAM
                  tx_sram_doa;
   input  [p_edma_tx_pbuf_pwid-1:0]
                  tx_sram_doa_par;
   output         tx_sram_web;        // Port B is always read only
   output         tx_sram_enb;
   output [p_edma_tx_pbuf_addr-1:0]
                  tx_sram_addrb;
   input  [p_edma_tx_pbuf_data-1:0]
                  tx_sram_dob;
   input  [p_edma_tx_pbuf_pwid-1:0]
                  tx_sram_dob_par;

   output         rx_sram_wea;        // Port A is always used for write
   output         rx_sram_ena;
   output [p_edma_rx_pbuf_addr-1:0]
                  rx_sram_addra;
   output [p_edma_rx_pbuf_data-1:0]
                  rx_sram_dia;
   output [p_edma_rx_pbuf_pwid-1:0]
                  rx_sram_dia_par;
   input  [p_edma_rx_pbuf_data-1:0]   // With optional read when SPRAM
                  rx_sram_doa;
   input  [p_edma_rx_pbuf_pwid-1:0]
                  rx_sram_doa_par;
   output         rx_sram_web;        // Port B is always read only
   output         rx_sram_enb;
   output [p_edma_rx_pbuf_addr-1:0]
                  rx_sram_addrb;
   input  [p_edma_rx_pbuf_data-1:0]
                  rx_sram_dob;
   input  [p_edma_rx_pbuf_pwid-1:0]
                  rx_sram_dob_par;


   // signals going to gem_reg_top (gem_pclk_syncs).
   output        tx_dma_complete_ok;   // tx_frame_end indication to the
                                       // register block.
   output        tx_dma_buffers_ex;    // sets bit in transmit status register.
   output        tx_dma_buff_ex_mid;   // sets bit in transmit status register.
   output        tx_dma_hresp_notok;   // error response from ahb during tx.
   output        tx_dma_go;            // sets bit in transmit status register.
   output [(p_edma_queues*32)-1:0]
                 tx_dma_descr_ptr;     // Descriptor queue pointer for debug
   output        tx_dma_descr_ptr_tog; // handshaking for tx_dma_descr_ptr.
   output        tx_dma_late_col;      // late collision indicator
   output        tx_dma_toomanyretry;  // too many retires indicator
   output        tx_dma_underflow;     // Underflow indicator
   output [3:0]  tx_dma_int_queue;     // Identifies which queue the interupt is destined
   output [3:0]  rx_dma_int_queue;     // Identifies which queue the interupt is destined
   output        rx_dma_stable_tog;    // Toggles to indicate signals going
                                       // to pclk register are stable for
                                       // sampling.
   output        tx_dma_stable_tog;    // Toggles to indicate signals going
                                       // to pclk register are stable for
                                       // sampling.
   output        rx_dma_complete_ok;   // sets bit in receive status register.
   output        rx_dma_resource_err;  // sets bit in receive status register.
   output        rx_dma_buff_not_rdy;  // sets bit in receive status register.
   output        rx_dma_hresp_notok;   // error response from ahb during rx.
   output [(p_edma_queues*32)-1:0]
                 rx_dma_descr_ptr;     // Descriptor queue pointer for debug
   output        rx_dma_descr_ptr_tog; // handshaking for rx_dma_descr_ptr.

  // Specific outputs to support Priority Queues
   output [p_edma_queues-1:0]
                 rx_databuf_wr_q; // RA specific

    // Debug port
   output [(p_edma_tx_pbuf_addr*p_edma_queues)-1:0]
                 tx_dpram_fill_lvl;
   output [p_edma_rx_pbuf_addr-1:0]
                 rx_dpram_fill_lvl;

   // lockup detection
   output [p_edma_queues-1:0]
                 tx_edma_full_pkt_inc;  // Complete packet written to SRAM
   output [p_edma_queues-1:0]
                 tx_edma_used_bit_vec;  // Used bit read for each queue
   output        tx_edma_lockup_flush;
   output        rx_edma_overflow;

   // ASF - signals going to gem_reg_top
   output        asf_dap_tx_wr_err;          // DAP error in tx write block
   output        asf_dap_tx_rd_err;          // DAP error in tx read block
   output        asf_dap_rx_wr_err;          // DAP error in rx write block
   output        asf_dap_rx_rd_err;          // DAP error in rx read block

   input [3:0] restart_counter_top;
   input [p_edma_tx_pbuf_addr-1:0]
                 axi_tx_full_adj_0;
   input [p_edma_tx_pbuf_addr-1:0]
                 axi_tx_full_adj_1;

   input [47:0]              tx_pbuf_segments;
   input [3:0]               tx_top_q_id;

  // 64b addressing support and extended BD from reg_top
   input  [31:0] upper_tx_q_base_addr; // upper 32b base address for tx buffer descriptors
   input  [31:0] upper_rx_q_base_addr; // upper 32b base address for rx buffer descriptors
   input  [3:0]  upper_rx_q_base_par;
   input         dma_addr_bus_width;

   input         tx_bd_extended_mode_en;   // enable extended BD mode, which is used to Descriptor TS insertion
   input   [1:0] tx_bd_ts_mode;

   input         rx_bd_extended_mode_en;   // enable extended BD mode, which is used to Descriptor TS insertion
   input   [1:0] rx_bd_ts_mode;


   // Timestamp for current tx packet
   input  [41:0] tx_timestamp;

   // Timestamp for current rx packet
   input  [41:0] rx_timestamp;

   // RAS - Timestamp parity protection
   input   [5:0] tx_timestamp_prty; // RAS - parity protection for the TX Timestamp[41:0] to DMA Descriptor
   input   [5:0] rx_timestamp_prty; // RAS - parity protection for the RX Timestamp[41:0] to DMA Descriptor


    // PTP frame decoded signals
   input         event_frame_tx;
   input         general_frame_tx;
   input         sof_rx;
   input         event_frame_rx;
   input         general_frame_rx;

   // Signals going to rx-rd module for per-queue rx flushing
   input [(16*p_edma_queues)-1:0] max_val_pclk;
   input      [p_edma_queues-1:0] limit_num_bytes_allowed_ambaclk;
   output     [p_edma_queues-1:0] fill_lvl_breached;

   // Internal wire and reg declarations.

   // connections between edma_tx and gem_hclk_syncs.

   wire          enable_tx_hclk;       // transmit enable from control
                                       // register synced to hclk.
   wire          tx_start_hclk_pulse;  // asserted when bit 9 of network
                                       // control register is written.
   wire          tx_halt_hclk;         // asserted when bit 10 of network
                                       // control register is written.
   wire          new_tx_q_ptr_pulse;   // asserted when transmit queue pointer
                                       // register is written.
   wire          tx_stat_capt_pulse;   // toggle signal indicating dma_tx status
                                       // status has been captured

   // connections between edma_rx and gem_hclk_syncs.
   wire          enable_rx_hclk;       // receive enable from control
                                       // register synced to hclk.
   wire          new_rx_q_ptr_pulse;   // asserted when receive queue pointer
                                       // register is written.
   wire          rx_stat_capt_pulse;   // toggle signal indicating dma_rx status
                                       // status has been captured
   wire           flush_rx_pkt_hclk;   // asserted when bit 18 of network
                                       // control register is written.

   // connections between edma_* and edma_ahb.
   wire           hbusreq_00;     //hbusreq for master 00
   wire           hlock_00;       //hlock for master 00
   wire   [2:0]   hburst_00;      //hburst for master 00
   wire   [1:0]   htrans_00;      //htrans for master 00
   wire   [2:0]   hsize_00;       //hsize for master 00
   wire           hwrite_00;      //hwrite for master 00
   wire   [3:0]   hprot_00;       //hprot for master 00
   wire   [p_edma_addr_width-1:0]
                  haddr_00;       //haddr for master 00
   wire   [127:0] hwdata_00;      //hwdata for master 00
   wire           hbusreq_01;     //hbusreq for master 01
   wire           hlock_01;       //hlock for master 01
   wire   [2:0]   hburst_01;      //hburst for master 01
   wire   [1:0]   htrans_01;      //htrans for master 01
   wire   [2:0]   hsize_01;       //hsize for master 01
   wire           hwrite_01;      //hwrite for master 01
   wire   [3:0]   hprot_01;       //hprot for master 01
   wire   [p_edma_addr_width-1:0]
                  haddr_01;       //haddr for master 01
   wire   [127:0] hwdata_01;      //hwdata for master 01
   wire           hbusreq_02;     //hbusreq for master 02
   wire           hlock_02;       //hlock for master 02
   wire   [2:0]   hburst_02;      //hburst for master 02
   wire   [1:0]   htrans_02;      //htrans for master 02
   wire   [2:0]   hsize_02;       //hsize for master 02
   wire           hwrite_02;      //hwrite for master 02
   wire   [3:0]   hprot_02;       //hprot for master 02
   wire   [p_edma_addr_width-1:0]
                  haddr_02;       //haddr for master 02
   wire   [127:0] hwdata_02;      //hwdata for master 02
   wire           hbusreq_03;     //hbusreq for master 03
   wire           hlock_03;       //hlock for master 03
   wire   [2:0]   hburst_03;      //hburst for master 03
   wire   [1:0]   htrans_03;      //htrans for master 03
   wire   [2:0]   hsize_03;       //hsize for master 03
   wire           hwrite_03;      //hwrite for master 03
   wire   [3:0]   hprot_03;       //hprot for master 03
   wire   [p_edma_addr_width-1:0]
                  haddr_03;       //haddr for master 03
   wire   [127:0] hwdata_03;      //hwdata for master 03
   wire           hgrant_00;      //hgrant for master 00
   wire           hgrant_01;      //hgrant for master 01
   wire           hgrant_02;      //hgrant for master 02
   wire           hgrant_03;      //hgrant for master 03

   wire  [p_edma_bus_width-1:0]    hrdata_tx_dma;
   wire  [p_edma_bus_width-1:0]    hrdata_rx_dma;
   wire  [p_edma_bus_pwid-1:0]     hrdata_rx_dma_par;
   wire                            status_word1_capt;
  
   // Create a generic counter that will be used by the TX DMA and RX DMA to restart transmission.
   // For TX it will only be used in AXI mode following the case where there was not enough space
   // in the internal SRAM, but there is a descriptor with valid data waiting. It essentially
   // keeps retriggering a new descriptor read to ensure the packet eventually gets send
   // For RX it is used to retry RX descriptor reads if it had a resource error and there are
   // frames waiting in the internal SRAM buffer to offload to main memory.
   reg [15:0]   restart_counter;
   wire [16:0]  nxt_restart_counter;
   wire         restart_trigger;
   assign nxt_restart_counter = restart_counter + 16'h0001;
   always @(posedge hclk or negedge n_hreset)
   begin
     if  (~n_hreset)
       restart_counter <= 16'd0;
     else
     begin
       if (((restart_counter_top == 4'd0) & restart_counter[0]) |
           ((restart_counter_top == 4'd1) & (&restart_counter[1:0])) |
           ((restart_counter_top == 4'd2) & (&restart_counter[2:0])) |
           ((restart_counter_top == 4'd3) & (&restart_counter[3:0])) |
           ((restart_counter_top == 4'd4) & (&restart_counter[4:0])) |
           ((restart_counter_top == 4'd5) & (&restart_counter[5:0])) |
           ((restart_counter_top == 4'd6) & (&restart_counter[6:0])) |
           ((restart_counter_top == 4'd7) & (&restart_counter[7:0])) |
           ((restart_counter_top == 4'd8) & (&restart_counter[8:0])) |
           ((restart_counter_top == 4'd9) & (&restart_counter[9:0])) |
           ((restart_counter_top == 4'd10) & (&restart_counter[10:0])) |
           ((restart_counter_top == 4'd11) & (&restart_counter[11:0])) |
           ((restart_counter_top == 4'd12) & (&restart_counter[12:0])) |
           ((restart_counter_top == 4'd13) & (&restart_counter[13:0])) |
           ((restart_counter_top == 4'd14) & (&restart_counter[14:0])) |
           ((restart_counter_top == 4'd15) & (&restart_counter[15:0])))
         restart_counter <= 16'd0;
       else
         restart_counter <= nxt_restart_counter[15:0];
     end
   end
   assign restart_trigger = restart_counter == 16'h0000;

   // Some inputs to the DMA are tied off if the AXI is present ...

   wire  [128:0] hrdata_pad;           // hrdata padded to 129-bits
   assign hrdata_pad               = {{129-p_edma_bus_width{1'b0}},hrdata};
   assign hrdata_tx_dma            = hrdata_pad[p_edma_bus_width-1:0];
   assign hrdata_rx_dma            = hrdata_pad[p_edma_bus_width-1:0];

// assertions to check that o/p to MAC is correct

// psl default clock = (posedge tx_r_clk);

// Check that SOP is always followed by an EOP before next SOP.
// psl property EOP_BEFORE_NEXT_SOP_DMA =
//   always ((tx_r_valid & tx_r_sop & ~tx_r_eop & !tx_r_flushed) -> next
//           (((tx_r_valid & tx_r_eop)|tx_r_flushed | !enable_tx_hclk) before (tx_r_valid & tx_r_sop)));
// psl assert EOP_BEFORE_NEXT_SOP_DMA;

  // Internal RAM connections to DMA
  wire                            tx_ena;
  wire                            tx_wea;
  wire  [p_edma_tx_pbuf_addr-1:0] tx_addra;
  wire  [p_edma_tx_pbuf_data-1:0] tx_dia;
  wire  [p_edma_tx_pbuf_pwid-1:0] tx_dia_par;
  wire                            tx_enb;
  wire                            tx_web;
  wire  [p_edma_tx_pbuf_addr-1:0] tx_addrb;
  wire  [p_edma_tx_pbuf_data-1:0] tx_dob;
  wire  [p_edma_tx_pbuf_pwid-1:0] tx_dob_par;
  wire                            asf_dap_tx_wr_err_int;
  wire                            asf_dap_rx_rd_err_int;
  wire                            asf_dap_rx_wr_err_int;
  
  edma_pbuf_ahb_tx #(
     .grouped_params(grouped_params)
   ) i_edma_pbuf_ahb_tx (

      // Constants
      .TX_PBUF_MAX_FILL_LVL(),

      // system signals.
      .hclk                 (hclk),
      .n_hreset             (n_hreset),
      .tx_r_clk             (tx_r_clk),
      .tx_r_rst_n           (tx_r_rst_n),

      .trigger_dma_tx_start (trigger_dma_tx_start),

      // signals going to gem_mac (gem_tx).
      .dma_tx_status_tog    (dma_tx_status_tog),

      // signals going to gem_mac (gem_tx - fifo interface).
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

      // signals coming from gem_mac (gem_tx - fifo interface).
      .tx_r_rd              (tx_r_rd),
      .tx_r_rd_int          (tx_r_rd_int),
      .tx_r_queue_int       (tx_r_queue_int),
      .dma_tx_end_tog       (dma_tx_end_tog),
      .dma_tx_small_end_tog (dma_tx_small_end_tog),
      .collision_occured    (collision_occured),
      .late_coll_occured    (late_coll_occured),
      .too_many_retries     (too_many_retries),
      .underflow_frame      (underflow_frame),

      // signals coming from the gem_hclk_syncs block (internal).
      .new_tx_q_ptr_pulse   (new_tx_q_ptr_pulse),
      .tx_start_hclk_pulse  (tx_start_hclk_pulse),
      .tx_halt_hclk         (tx_halt_hclk),
      .enable_tx_hclk       (enable_tx_hclk),
      .tx_dma_descr_base_addr(tx_dma_descr_base_addr),
      .tx_stat_capt_pulse   (tx_stat_capt_pulse),

      // signals coming from gem_reg_top (gem_registers).
      .dma_bus_width        (dma_bus_width),
      .tx_pbuf_tcp_en       (tx_pbuf_tcp_en),
      .tx_pbuf_size         (tx_pbuf_size),
      .tx_cutthru_threshold (tx_cutthru_threshold),
      .tx_cutthru           (tx_cutthru),
      .full_duplex          (full_duplex),
      .force_max_ahb_burst_tx  (force_max_ahb_burst_tx),
      .endian_swap          (endian_swap),
      .ahb_burst_length     (ahb_burst_length),

      // signals going to gem_reg_top (gem_pclk_syncs).
      .tx_dma_complete_ok   (tx_dma_complete_ok),
      .tx_dma_buffers_ex    (tx_dma_buffers_ex),
      .tx_dma_buff_ex_mid   (tx_dma_buff_ex_mid),
      .tx_dma_hresp_notok   (tx_dma_hresp_notok),
      .tx_dma_late_col      (tx_dma_late_col),
      .tx_dma_toomanyretry  (tx_dma_toomanyretry),
      .tx_dma_underflow     (tx_dma_underflow),
      .tx_dma_go            (tx_dma_go),
      .tx_dma_descr_ptr     (tx_dma_descr_ptr),
      .tx_dma_descr_ptr_tog (tx_dma_descr_ptr_tog),
      .tx_dma_stable_tog    (tx_dma_stable_tog),
      .tx_dma_int_queue     (tx_dma_int_queue),

      // Signals going to AHB
      // TX Descriptor Master outputs
      .hbusreq_descr        (hbusreq_01),
      .hlock_descr          (hlock_01),
      .hburst_descr         (hburst_01),
      .htrans_descr         (htrans_01),
      .hsize_descr          (hsize_01),
      .hwrite_descr         (hwrite_01),
      .hprot_descr          (hprot_01),
      .haddr_descr          (haddr_01),
      .hwdata_descr         (hwdata_01),
      // TX DATA Master outputs
      .hbusreq_data         (hbusreq_03),
      .hlock_data           (hlock_03),
      .hburst_data          (hburst_03),
      .htrans_data          (htrans_03),
      .hsize_data           (hsize_03),
      .hwrite_data          (hwrite_03),
      .hprot_data           (hprot_03),
      .haddr_data           (haddr_03),
      .hwdata_data          (hwdata_03),

      // Signals coming from AHB
      .hgrant_descr         (hgrant_01),
      .hgrant_data          (hgrant_03),
      .hready               (hready),
      .hrdata               (hrdata_tx_dma),
      .hresp                (hresp),

      .dpram_fill_lvl       (tx_dpram_fill_lvl),

      // DPRAM interface
      .tx_ena               (tx_ena),
      .tx_wea               (tx_wea),
      .tx_addra             (tx_addra),
      .tx_dia               (tx_dia),
      .tx_dia_par           (tx_dia_par),
      .tx_enb               (tx_enb),
      .tx_web               (tx_web),
      .tx_addrb             (tx_addrb),
      .tx_dob               (tx_dob),
      .tx_dob_par           (tx_dob_par),

      .tx_pbuf_segments     (tx_pbuf_segments),
      .tx_top_q_id          (tx_top_q_id),

      // 64b addressing
      .upper_tx_q_base_addr (upper_tx_q_base_addr),
      .dma_addr_bus_width   (dma_addr_bus_width),

      .tx_bd_extended_mode_en (tx_bd_extended_mode_en),
      .tx_bd_ts_mode          (tx_bd_ts_mode),

      // Timestamp for current packet
      .tx_timestamp           (tx_timestamp),
      .tx_timestamp_prty      (tx_timestamp_prty),

      // PTP frame decoded signals
      .event_frame_tx         (event_frame_tx),
      .general_frame_tx       (general_frame_tx),

      // lockup detection
      .full_pkt_inc           (tx_edma_full_pkt_inc),
      .used_bit_vec           (tx_edma_used_bit_vec),
      .lockup_flush           (tx_edma_lockup_flush),

      // RAS - signals going to gem_reg_top
      .asf_dap_tx_rd_err        (asf_dap_tx_rd_err),
      .asf_dap_tx_wr_err        (asf_dap_tx_wr_err_int)

   );

  // Internal RAM connections to DMA
  wire                            rx_ena;
  wire                            rx_wea;
  wire  [p_edma_rx_pbuf_addr-1:0] rx_addra;
  wire  [p_edma_rx_pbuf_data-1:0] rx_dia;
  wire  [p_edma_rx_pbuf_pwid-1:0] rx_dia_par;
  wire                            rx_enb;
  wire                            rx_web;
  wire  [p_edma_rx_pbuf_addr-1:0] rx_addrb;
  wire  [p_edma_rx_pbuf_data-1:0] rx_dob;
  wire  [p_edma_rx_pbuf_pwid-1:0] rx_dob_par;

   edma_pbuf_rx #(
       .grouped_params(grouped_params)
   ) i_edma_pbuf_rx (
      // Global clk & reset.
      .hclk                      (hclk),
      .n_hreset                  (n_hreset),
      .rx_clk                    (rx_w_clk),
      .n_rxreset                 (rx_w_rst_n),

      // Signals going to AHB
      // RX Descriptor Master outputs
      .hbusreq_descr             (hbusreq_00),
      .hlock_descr               (hlock_00),
      .hburst_descr              (hburst_00),
      .htrans_descr              (htrans_00),
      .hsize_descr               (hsize_00),
      .hwrite_descr              (hwrite_00),
      .hprot_descr               (hprot_00),
      .haddr_descr               (haddr_00),
      .haddr_descr_par           (),  // TOIMPRV
      .hwdata_descr              (hwdata_00),
      .hwdata_descr_par          (),  // TOIMPRV
      // RX DATA Master outputs
      .hbusreq_data              (hbusreq_02),
      .hlock_data                (hlock_02),
      .hburst_data               (hburst_02),
      .htrans_data               (htrans_02),
      .hsize_data                (hsize_02),
      .hwrite_data               (hwrite_02),
      .hprot_data                (hprot_02),
      .haddr_data                (haddr_02),
      .haddr_data_par            (),  // TOIMPRV
      .hwdata_data               (hwdata_02),
      .hwdata_data_par           (),  // TOIMPRV

      .next_buffer_start_add     (), // RSC Only
      .next_buffer_start_add_par (),
      .host_update_buf_add       (),
      .rsc_coalescing_ended      (),
      .rsc_write_strobe          (),
      .rsc_update_valid          (),
      .rsc_update_ready          (1'b0),
      .rsc_update_descr          (),
      .rsc_update_last           (),
      .rsc_update_addr           (),
      .rsc_update_addr_par       (),
      .rsc_update_data           (),
      .rsc_update_data_par       (),
      .rsc_update_ben            (),
      .queue_ptr_rx_mod          (),

      // Signals coming from AHB
      .hgrant_descr              (hgrant_00),
      .hgrant_data               (hgrant_02),
      .hready                    (hready),
      .hrdata                    (hrdata_rx_dma),
      .hrdata_par                (hrdata_rx_dma_par),
      .hresp                     (hresp),

      .last_data_to_buff_dph     (),
      .status_word1_capt         (status_word1_capt),
      .full_pkt_size             (),
      .from_rx_dma_used_bit_read (),
      .rx_descr_ptr_reset        (),
      .from_rx_dma_queue_ptr     (),
      .new_descr_fetch_trig      (),
      .part_pkt_written          (),
      .from_rx_dma_buff_depth    (),

      .restart_trigger           (restart_trigger),

      // signals coming from gem_mac (gem_rx - fifo interface).
      .rx_w_wr                 (rx_w_wr),
      .rx_w_data               (rx_w_data),
      .rx_w_data_par           (rx_w_data_par),
      .rx_w_sop                (rx_w_sop),
      .rx_w_eop                (rx_w_eop),
      .rx_w_err                (rx_w_err),

      // signals going to gem_mac (gem_rx - fifo interface).
      .rx_w_overflow           (rx_w_overflow),

      // inputs coming from    the gem_mac (gem_rx)
      .dma_rx_end_tog          (dma_rx_end_tog),
      .rx_w_bad_frame          (rx_w_bad_frame),
      .rx_w_frame_length       (rx_w_frame_length),
      .rx_w_vlan_tagged        (rx_w_vlan_tagged),
      .rx_w_prty_tagged        (rx_w_prty_tagged),
      .rx_w_tci                (rx_w_tci),
      .rx_w_broadcast_frame    (rx_w_broadcast_frame),
      .rx_w_mult_hash_match    (rx_w_mult_hash_match),
      .rx_w_uni_hash_match     (rx_w_uni_hash_match),
      .rx_w_ext_match1         (rx_w_ext_match1),
      .rx_w_ext_match2         (rx_w_ext_match2),
      .rx_w_ext_match3         (rx_w_ext_match3),
      .rx_w_ext_match4         (rx_w_ext_match4),
      .rx_w_add_match1         (rx_w_add_match1),
      .rx_w_add_match2         (rx_w_add_match2),
      .rx_w_add_match3         (rx_w_add_match3),
      .rx_w_add_match4         (rx_w_add_match4),
      .rx_w_add_match5         (rx_w_add_match5),
      .rx_w_add_match6         (rx_w_add_match6),
      .rx_w_add_match7         (rx_w_add_match7),
      .rx_w_add_match8         (rx_w_add_match8),
      .rx_w_type_match1        (rx_w_type_match1),
      .rx_w_type_match2        (rx_w_type_match2),
      .rx_w_type_match3        (rx_w_type_match3),
      .rx_w_type_match4        (rx_w_type_match4),
      .rx_w_checksumi_ok       (rx_w_checksumi_ok),
      .rx_w_checksumt_ok       (rx_w_checksumt_ok),
      .rx_w_checksumu_ok       (rx_w_checksumu_ok),
      .rx_w_snap_frame         (rx_w_snap_frame),
      .rx_w_crc_error          (rx_w_crc_error),
      .rx_w_l4_offset          (rx_w_l4_offset),
      .rx_w_pld_offset         (rx_w_pld_offset),

      // Stats going to the register block ...
      .dbuff_overflow          (rx_pkt_dbuff_overflow),
      .rx_dma_pkt_flushed      (rx_dma_pkt_flushed),

      // signals coming from gem_hclk_syncs (internal).
      .enable_rx_hclk            (enable_rx_hclk),
      .new_rx_q_ptr_pulse        (new_rx_q_ptr_pulse),
      .rx_stat_capt_pulse        (rx_stat_capt_pulse),
      .flush_rx_pkt_hclk         (flush_rx_pkt_hclk),

      // signals coming from gem_registers.
      .dma_addr_or_mask          (dma_addr_or_mask),
      .crc_error_report          (crc_error_report),
      .rx_dma_descr_base_addr    (rx_dma_descr_base_addr),
      .rx_dma_descr_base_par     (rx_dma_descr_base_par),
      .rx_dma_buffer_size        (rx_dma_buffer_size),
      .rx_dma_buffer_offset      (rx_dma_buffer_offset),
      .dma_bus_width             (dma_bus_width),
      .ahb_burst_length          (ahb_burst_length),
      .rx_toe_enable             (rx_toe_enable),
      .rx_no_crc_check           (rx_no_crc_check),
      .jumbo_enable              (jumbo_enable),
      .jumbo_max_length          (jumbo_max_length),
      .force_discard_on_err      (force_discard_on_err),
      .force_discard_on_err_q    (force_discard_on_err_q),
      .hdr_data_splitting_en     (hdr_data_splitting_en),
      .infinite_last_dbuf_size_en(infinite_last_dbuf_size_en),
      .force_max_ahb_burst_rx    (force_max_ahb_burst_rx),
      .endian_swap               (endian_swap),
      .rx_pbuf_size              (rx_pbuf_size),
      .rx_cutthru_threshold      (rx_cutthru_threshold),
      .rx_cutthru                (rx_cutthru),
      .enable_receive            (enable_receive),

      // When using the packet buffer, we need to delay the
      // handshake between the MAC and the REG block, so
      // that stats are updated at the correct time
      // 'rx_end_tog' comes from the mac to indicate
      // the stats are valid
      // 'rx_status_wr_tog' is sent back to the MAC to indicate
      // the pkt buffer has captured the stats from the MAC
      // 'rx_pkt_end_tog' indicates to the reg block
      // that stats are ready
      // 'rx_pkt_status_wr_tog' indicates from the reg block
      // that stats have been captured
      .rx_end_tog                   (rx_end_tog),
      .rx_status_wr_tog             (rx_status_wr_tog),
      .rx_pkt_end_tog               (rx_pkt_end_tog),
      .rx_pkt_status_wr_tog         (rx_pkt_status_wr_tog),

      // outputs going to gem_mac (gem_rx).
      .dma_rx_status_tog            (dma_rx_status_tog),

      // outputs going to gem_registers (gem_reg_top).
      .rx_dma_stable_tog            (rx_dma_stable_tog),
      .rx_dma_complete_ok           (rx_dma_complete_ok),
      .rx_dma_resource_err          (rx_dma_resource_err),
      .rx_dma_hresp_notok           (rx_dma_hresp_notok),
      .rx_dma_buff_not_rdy          (rx_dma_buff_not_rdy),
      .rx_dma_int_queue             (rx_dma_int_queue),
      .ahb_queue_ptr_rx             (),
      .queue_ptr_rx_aph             (),
      .rx_dma_descr_ptr             (rx_dma_descr_ptr),
      .rx_dma_descr_ptr_par         (),
      .rx_dma_descr_ptr_tog         (rx_dma_descr_ptr_tog),

      // DPRAM interface
      .rxdpram_ena                  (rx_ena),
      .rxdpram_wea                  (rx_wea),
      .rxdpram_addra                (rx_addra),
      .rxdpram_dia                  (rx_dia),
      .rxdpram_dia_par              (rx_dia_par),
      .rxdpram_enb                  (rx_enb),
      .rxdpram_web                  (rx_web),
      .rxdpram_addrb                (rx_addrb),
      .rxdpram_dob                  (rx_dob),
      .rxdpram_dob_par              (rx_dob_par),

      // RSC specific signalling
      .rsc_en                       (15'd0),
      .rsc_stop                     (1'b0),
      .rsc_push                     (1'b0),
      .tcp_seqnum                   (32'd0),
      .tcp_syn                      (1'b0),
      .tcp_payload_len              (16'd0),
      .rsc_clr_tog                  (),

      // Priorty Queues
      .rx_databuf_wr_q              (rx_databuf_wr_q),
      .queue_ptr_rx                 (queue_ptr_rx),
      // 64b addressing
      .upper_rx_q_base_addr         (upper_rx_q_base_addr),
      .upper_rx_q_base_par          (upper_rx_q_base_par),
      .dma_addr_bus_width           (dma_addr_bus_width),

      .rx_bd_extended_mode_en       (rx_bd_extended_mode_en),
      .rx_bd_ts_mode                (rx_bd_ts_mode),

      // Timestamp for current packet
      .rx_timestamp                 (rx_timestamp),

       // RAS - Timestamp parity protection
       .rx_timestamp_prty           (rx_timestamp_prty),

      // PTP frame decoded signals
      .sof_rx                       (sof_rx),
      .event_frame_rx               (event_frame_rx),
      .general_frame_rx             (general_frame_rx),

      .dpram_fill_lvl               (rx_dpram_fill_lvl),

       // lockup detection
      .rx_edma_overflow             (rx_edma_overflow),

       // RAS - signals going to gem_reg_top
      .asf_dap_rx_rd_err            (asf_dap_rx_rd_err_int),
      .asf_dap_rx_wr_err            (asf_dap_rx_wr_err_int),

      // Signals going to rx-rd side for per-queue rx flush
      .max_val_pclk                   (max_val_pclk),
      .limit_num_bytes_allowed_ambaclk(limit_num_bytes_allowed_ambaclk),
      .fill_lvl_breached              (fill_lvl_breached)
   );

   wire [p_edma_bus_width-1:0] hwdata_pad;

    edma_pbuf_ahb_fe #(
                     .p_edma_addr_width(p_edma_addr_width),
                     .p_edma_bus_width (p_edma_bus_width)
                   ) i_edma_pbuf_ahb_fe (

       // global clk & reset.
       .n_hreset   (n_hreset),
       .hclk       (hclk),

       // ahb top level inputs.
       .hgrant     (hgrant),
       .hready     (hready),

       //RX Descriptor Master inputs
       .hbusreq_00 (hbusreq_00),
       .hlock_00   (hlock_00),
       .hburst_00  (hburst_00),
       .htrans_00  (htrans_00),
       .hsize_00   (hsize_00),
       .hwrite_00  (hwrite_00),
       .hprot_00   (hprot_00),
       .haddr_00   (haddr_00),
       .hwdata_00  (hwdata_00[p_edma_bus_width-1:0]),

       //TX Descriptor Master inputs
       .hbusreq_01 (hbusreq_01),
       .hlock_01   (hlock_01),
       .hburst_01  (hburst_01),
       .htrans_01  (htrans_01),
       .hsize_01   (hsize_01),
       .hwrite_01  (hwrite_01),
       .hprot_01   (hprot_01),
       .haddr_01   (haddr_01),
       .hwdata_01  (hwdata_01[p_edma_bus_width-1:0]),

       //RX Data Master inputs
       .hbusreq_02 (hbusreq_02),
       .hlock_02   (hlock_02),
       .hburst_02  (hburst_02),
       .htrans_02  (htrans_02),
       .hsize_02   (hsize_02),
       .hwrite_02  (hwrite_02),
       .hprot_02   (hprot_02),
       .haddr_02   (haddr_02),
       .hwdata_02  (hwdata_02[p_edma_bus_width-1:0]),

       //TX Data Master inputs
       .hbusreq_03 (hbusreq_03),
       .hlock_03   (hlock_03),
       .hburst_03  (hburst_03),
       .htrans_03  (htrans_03),
       .hsize_03   (hsize_03),
       .hwrite_03  (hwrite_03),
       .hprot_03   (hprot_03),
       .haddr_03   (haddr_03),
       .hwdata_03  (hwdata_03[p_edma_bus_width-1:0]),


       // Outputs
       //arbiter outputs to common AHB
       .hgrant_00  (hgrant_00),
       .hgrant_01  (hgrant_01),
       .hgrant_02  (hgrant_02),
       .hgrant_03  (hgrant_03),

       // ahb output interface
       .htrans     (htrans),
       .hburst     (hburst),
       .hsize      (hsize),
       .hwrite     (hwrite),
       .hbusreq    (hbusreq),
       .hlock      (hlock),
       .haddr      (haddr),
       .hwdata     (hwdata_pad),
       .hprot      (hprot)

    );
   assign hwdata = hwdata_pad[p_edma_bus_width-1:0];

  generate if (p_edma_spram ==  1) begin : gen_spram
      localparam p_tx_sram_w = (p_edma_asf_dap_prot == 0) ? p_edma_tx_pbuf_data
                                                          : p_edma_tx_pbuf_data + p_edma_tx_pbuf_pwid;
      wire  [p_tx_sram_w-1:0]         txdpram_dia_int;
      wire  [p_tx_sram_w-1:0]         txdpram_dob_int;
      wire                            txspram_we;
      wire                            txspram_en;
      wire  [p_edma_tx_pbuf_addr-1:0] txspram_addr;
      wire  [p_tx_sram_w-1:0]         txspram_di;
      wire  [p_tx_sram_w-1:0]         txspram_do;

      edma_spram_controller # (

        .ADDR_W    (p_edma_tx_pbuf_addr),
        .DATA_W    (p_edma_tx_pbuf_data),
        .DATA_W_PAR(p_edma_tx_pbuf_prty),
        `ifdef xgm
        .FIFO_DEPTH (32'd8),
        .FIFO_ADDR_W(32'd4),
        `else
        .FIFO_DEPTH (32'd4),
        .FIFO_ADDR_W(4'd2),
        `endif
        .SYNCHRONOUS(1'b1)

      ) i_edma_spram_controller_tx (

        // tx_wr interface
        // system signals.
        .clka       (hclk),
        .rsta_n     (n_hreset),
        .dpram_wea  (tx_wea),
        .dpram_ena  (tx_ena),
        .dpram_addra(tx_addra),
        .dpram_dia  (txdpram_dia_int),
        .dpram_busya(),

        // tx_rd interface
        .clkb       (hclk),
        .rstb_n     (n_hreset),
        .dpram_web  (tx_web),
        .dpram_enb  (tx_enb),
        .dpram_addrb(tx_addrb),
        .dpram_dob  (txdpram_dob_int),

        // spram interface
        .spram_we   (txspram_we),
        .spram_en   (txspram_en),
        .spram_addr (txspram_addr),
        .spram_di   (txspram_di),
        .spram_do   (txspram_do)
      );

      // Connect up main I/O, only port A is used as R/W port
      assign tx_sram_ena    = txspram_en;
      assign tx_sram_wea    = txspram_we;
      assign tx_sram_addra  = txspram_addr;

      // Control signals are mirrored to port B
      assign tx_sram_enb    = txspram_en;
      assign tx_sram_web    = txspram_we;
      assign tx_sram_addrb  = txspram_addr;

      // Data assignments vary according to parity
      if (p_edma_asf_dap_prot == 1) begin : gen_tx_par
        assign txdpram_dia_int  = {tx_dia_par,tx_dia};
        assign {tx_dob_par,
                tx_dob}         = txdpram_dob_int;
        assign {tx_sram_dia_par,
                tx_sram_dia}    = txspram_di;
        assign txspram_do       = {tx_sram_doa_par,tx_sram_doa};
      end else begin : gen_no_tx_par
        assign txdpram_dia_int  = tx_dia;
        assign tx_dob           = txdpram_dob_int;
        assign tx_dob_par       = {p_edma_tx_pbuf_pwid{1'b0}};
        assign tx_sram_dia      = txspram_di;
        assign tx_sram_dia_par  = {p_edma_tx_pbuf_pwid{1'b0}};
        assign txspram_do       = tx_sram_doa;
      end


      localparam p_rx_sram_w = (p_edma_asf_dap_prot == 0) ? p_edma_rx_pbuf_data
                                                          : p_edma_rx_pbuf_data + p_edma_rx_pbuf_pwid;
      wire  [p_rx_sram_w-1:0]         rxdpram_dia_int;
      wire  [p_rx_sram_w-1:0]         rxdpram_dob_int;
      wire                            rxspram_we;
      wire                            rxspram_en;
      wire  [p_edma_rx_pbuf_addr-1:0] rxspram_addr;
      wire  [p_rx_sram_w-1:0]         rxspram_di;
      wire  [p_rx_sram_w-1:0]         rxspram_do;

      edma_spram_controller # (

        .ADDR_W(p_edma_rx_pbuf_addr),
        .DATA_W(p_edma_rx_pbuf_data),
        .DATA_W_PAR(p_edma_rx_pbuf_prty),
        `ifdef xgm
        .FIFO_DEPTH(32'd8),
        .FIFO_ADDR_W(32'd4),
        `else
        .FIFO_DEPTH(32'd4),
        .FIFO_ADDR_W(4'd2),
        `endif
        .SYNCHRONOUS(1'b0)

      ) i_edma_spram_controller_rx (

        // rx_wr interface
        .clka(rx_w_clk),
        .rsta_n(rx_w_rst_n),
        .dpram_wea(rx_wea),
        .dpram_ena(rx_ena),
        .dpram_addra(rx_addra),
        .dpram_dia(rxdpram_dia_int),
        .dpram_busya(),

        // rx_rd interface
        // tx_rd interface
        .clkb(hclk),
        .rstb_n(n_hreset),
        .dpram_web(rx_web),
        .dpram_enb(rx_enb),
        .dpram_addrb(rx_addrb),
        .dpram_dob(rxdpram_dob_int),

        // spram interface
        .spram_we(rxspram_we),
        .spram_en(rxspram_en),
        .spram_addr(rxspram_addr),
        .spram_di(rxspram_di),
        .spram_do(rxspram_do));


      // Connect up main I/O, only port A is used as R/W port
      assign rx_sram_ena    = rxspram_en;
      assign rx_sram_wea    = rxspram_we;
      assign rx_sram_addra  = rxspram_addr;
      assign rx_sram_enb    = rxspram_en;
      assign rx_sram_web    = rxspram_we;
      assign rx_sram_addrb  = rxspram_addr;

      // Data assignments vary according to parity
      if (p_edma_asf_dap_prot == 1) begin : gen_rx_par
        assign rxdpram_dia_int                = {rx_dia_par,rx_dia};
        assign {rx_dob_par, rx_dob}           = rxdpram_dob_int;
        assign {rx_sram_dia_par, rx_sram_dia} = rxspram_di;
        assign rxspram_do                     = {rx_sram_doa_par,rx_sram_doa};
      end else begin : gen_no_rx_par
        assign rxdpram_dia_int  = rx_dia;
        assign rx_dob           = rxdpram_dob_int;
        assign rx_dob_par       = {p_edma_rx_pbuf_pwid{1'b0}};
        assign rx_sram_dia      = rxspram_di;
        assign rx_sram_dia_par  = {p_edma_rx_pbuf_pwid{1'b0}};
        assign rxspram_do       = rx_sram_doa;
      end

    end else begin : gen_nospram
      assign tx_sram_ena      = tx_ena;
      assign tx_sram_wea      = tx_wea;
      assign tx_sram_addra    = tx_addra;
      assign tx_sram_dia      = tx_dia;
      assign tx_sram_dia_par  = tx_dia_par;
      assign tx_sram_enb      = tx_enb;
      assign tx_sram_web      = tx_web;
      assign tx_sram_addrb    = tx_addrb;
      assign tx_dob           = tx_sram_dob;
      assign tx_dob_par       = tx_sram_dob_par;

      assign rx_sram_ena      = rx_ena;
      assign rx_sram_wea      = rx_wea;
      assign rx_sram_addra    = rx_addra;
      assign rx_sram_dia      = rx_dia;
      assign rx_sram_dia_par  = rx_dia_par;
      assign rx_sram_enb      = rx_enb;
      assign rx_sram_web      = rx_web;
      assign rx_sram_addrb    = rx_addrb;
      assign rx_dob           = rx_sram_dob;
      assign rx_dob_par       = rx_sram_dob_par;

  end
  endgenerate

  edma_hclk_syncs #(
                      .p_edma_rx_pkt_buffer(p_edma_rx_pkt_buffer),
                      .p_edma_tx_pkt_buffer(p_edma_tx_pkt_buffer)
                    ) i_edma_hclk_syncs (

      .hclk                 (hclk),
      .n_hreset             (n_hreset),

      // Inputs from the pclk domain.
      .rx_dma_stat_capt_tog (rx_dma_stat_capt_tog),
      .tx_dma_stat_capt_tog (tx_dma_stat_capt_tog),
      .enable_receive       (enable_receive),
      .enable_transmit      (enable_transmit),
      .new_receive_q_ptr    (new_receive_q_ptr),
      .new_transmit_q_ptr   (new_transmit_q_ptr),
      .tx_start_pclk        (tx_start_pclk),
      .tx_halt_pclk         (tx_halt_pclk),
      .flush_rx_pkt_pclk    (flush_rx_pkt_pclk),
      .rx_buff_not_rdy_pclk (rx_buff_not_rdy_pclk),

      // Inputs from the tx_clk domain.
      .dma_tx_end_tog       (dma_tx_end_tog),
      .late_coll_occured    (late_coll_occured),
      .too_many_retries     (too_many_retries),
      .underflow_frame      (underflow_frame),
      .collision_occured    (collision_occured),

      // Inputs from the rx_clk domain.
      .dma_rx_end_tog       (dma_rx_end_tog),
      .rx_w_bad_frame       (rx_w_bad_frame),
      .rx_w_frame_length    (rx_w_frame_length),
      .rx_w_vlan_tagged     (rx_w_vlan_tagged),
      .rx_w_prty_tagged     (rx_w_prty_tagged),
      .rx_w_tci             (rx_w_tci),
      .rx_w_broadcast_frame (rx_w_broadcast_frame),
      .rx_w_mult_hash_match (rx_w_mult_hash_match),
      .rx_w_uni_hash_match  (rx_w_uni_hash_match),
      .rx_w_ext_match1      (rx_w_ext_match1),
      .rx_w_ext_match2      (rx_w_ext_match2),
      .rx_w_ext_match3      (rx_w_ext_match3),
      .rx_w_ext_match4      (rx_w_ext_match4),
      .rx_w_add_match1      (rx_w_add_match1),
      .rx_w_add_match2      (rx_w_add_match2),
      .rx_w_add_match3      (rx_w_add_match3),
      .rx_w_add_match4      (rx_w_add_match4),
      .rx_w_type_match1     (rx_w_type_match1),
      .rx_w_type_match2     (rx_w_type_match2),
      .rx_w_type_match3     (rx_w_type_match3),
      .rx_w_type_match4     (rx_w_type_match4),
      .rx_w_checksumi_ok    (rx_w_checksumi_ok),
      .rx_w_checksumt_ok    (rx_w_checksumt_ok),
      .rx_w_checksumu_ok    (rx_w_checksumu_ok),
      .rx_w_snap_frame      (rx_w_snap_frame),
      .rx_w_crc_error       (rx_w_crc_error),

      // synchronised hclk outputs going to edma_tx
      .enable_tx_hclk       (enable_tx_hclk),
      .tx_stat_capt_pulse   (tx_stat_capt_pulse),
      .new_tx_q_ptr_pulse   (new_tx_q_ptr_pulse),
      .tx_start_hclk_pulse  (tx_start_hclk_pulse),
      .tx_halt_hclk         (tx_halt_hclk),

      .tx_frame_end_pulse   (),// needed by old dma only
      .too_many_retry_hclk  (),// needed by old dma only
      .underflow_frame_hclk (),// needed by old dma only
      .late_coll_occ_hclk   (),// needed by old dma only
      .coll_occurred_hclk   (),// needed by old dma only

      // synchronised hclk outputs going to edma_rx
      .flush_rx_pkt_hclk    (flush_rx_pkt_hclk),
      .rx_buff_not_rdy_clr  (),// needed by old dma only
      .rx_frame_end_pulse   (),// needed by old dma only
      .rx_w_bad_frame_hclk  (),// needed by old dma only
      .rx_w_frm_lngth_hclk  (),// needed by old dma only
      .rx_w_vlan_tag_hclk   (),// needed by old dma only
      .rx_w_prty_tag_hclk   (),// needed by old dma only
      .rx_w_tci_hclk        (),// needed by old dma only
      .rx_w_broadcast_hclk  (),// needed by old dma only
      .rx_w_mult_hash_hclk  (),// needed by old dma only
      .rx_w_uni_hash_hclk   (),// needed by old dma only
      .rx_w_ext_match1_hclk (),// needed by old dma only
      .rx_w_ext_match2_hclk (),// needed by old dma only
      .rx_w_ext_match3_hclk (),// needed by old dma only
      .rx_w_ext_match4_hclk (),// needed by old dma only
      .rx_w_add_match1_hclk (),// needed by old dma only
      .rx_w_add_match2_hclk (),// needed by old dma only
      .rx_w_add_match3_hclk (),// needed by old dma only
      .rx_w_add_match4_hclk (),// needed by old dma only
      .rx_w_type_mtch1_hclk (),// needed by old dma only
      .rx_w_type_mtch2_hclk (),// needed by old dma only
      .rx_w_type_mtch3_hclk (),// needed by old dma only
      .rx_w_type_mtch4_hclk (),// needed by old dma only
      .rx_w_cksumi_ok_hclk  (),// needed by old dma only
      .rx_w_cksumt_ok_hclk  (),// needed by old dma only
      .rx_w_cksumu_ok_hclk  (),// needed by old dma only
      .rx_w_snap_frame_hclk (),// needed by old dma only
      .rx_w_crc_error_hclk  (),// needed by old dma only

      .enable_rx_hclk       (enable_rx_hclk),
      .new_rx_q_ptr_pulse   (new_rx_q_ptr_pulse),
      .rx_stat_capt_pulse   (rx_stat_capt_pulse)
   );

   `ifdef MDV
      `ifndef CDN_NON_SOC_TEST
        edma_coverage i_edma_coverage ();
      `endif
   `endif

  // Check the RAM write data parity.
  // If ECC is used, then the parity will be replaced at a higher level
  wire  asf_dap_tx_ram_wr_err;
  wire  asf_dap_rx_ram_wr_err;
  generate if (p_edma_asf_dap_prot == 1) begin : gen_ram_par_check
    wire  asf_dap_tx_ram_wr_err_int;
    wire  asf_dap_rx_ram_wr_err_int;

    cdnsdru_asf_parity_check_v1 #(.p_data_width(p_edma_tx_pbuf_data)) i_chk_tx (
      .odd_par    (1'b0),
      .data_in    (tx_sram_dia),
      .parity_in  (tx_sram_dia_par),
      .parity_err (asf_dap_tx_ram_wr_err_int)
    );
    assign asf_dap_tx_ram_wr_err  = tx_sram_wea & tx_sram_ena & asf_dap_tx_ram_wr_err_int;
    cdnsdru_asf_parity_check_v1 #(.p_data_width(p_edma_rx_pbuf_data)) i_chk_rx (
      .odd_par    (1'b0),
      .data_in    (rx_sram_dia),
      .parity_in  (rx_sram_dia_par),
      .parity_err (asf_dap_rx_ram_wr_err_int)
    );
    assign asf_dap_rx_ram_wr_err  = rx_sram_wea & rx_sram_ena & asf_dap_rx_ram_wr_err_int;

    // TOIMPRV replace later when implement host parity
    cdnsdru_asf_parity_gen_v1 #(.p_data_width(p_edma_bus_width)) i_gen_hrdata_rx_dma_par (
      .odd_par    (1'b0),
      .data_in    (hrdata_rx_dma),
      .data_out   (),
      .parity_out (hrdata_rx_dma_par)
    );

  end else begin : gen_no_ram_par_check
    assign asf_dap_tx_ram_wr_err  = 1'b0;
    assign asf_dap_rx_ram_wr_err  = 1'b0;
    assign hrdata_rx_dma_par      = {p_edma_bus_pwid{1'b0}};
  end
  endgenerate

  assign asf_dap_tx_wr_err  = asf_dap_tx_wr_err_int | asf_dap_tx_ram_wr_err;
  assign asf_dap_rx_wr_err  = (p_edma_spram == 1) ? asf_dap_rx_wr_err_int
                                                  : asf_dap_rx_wr_err_int | asf_dap_rx_ram_wr_err;
  assign asf_dap_rx_rd_err  = (p_edma_spram == 1) ? asf_dap_rx_rd_err_int | asf_dap_rx_ram_wr_err
                                                  : asf_dap_rx_rd_err_int;
endmodule

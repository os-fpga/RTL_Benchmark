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
//   Filename:           edma_fifo_ahb_top.v
//   Module Name:        edma_fifo_ahb_top
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
//                      of the FIFO AHB based dma.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module edma_fifo_ahb_top (

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
   rx_w_sop,
   rx_w_eop,
   rx_w_err,
   rx_w_flush,
   rx_w_mod,

   // signals coming from gem_mac (gem_tx).
   dma_tx_end_tog,
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
   rx_w_type_match1,
   rx_w_type_match2,
   rx_w_type_match3,
   rx_w_type_match4,
   rx_w_checksumi_ok,
   rx_w_checksumt_ok,
   rx_w_checksumu_ok,
   rx_w_snap_frame,
   rx_w_crc_error,

   // signals coming from gem_reg_top (gem_registers).
   rx_dma_stat_capt_tog,
   tx_dma_stat_capt_tog,
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
   rx_dma_buffer_size,
   rx_dma_buffer_offset,
   ahb_burst_length,
   rx_no_crc_check,
   jumbo_enable,
   endian_swap,

   // signals going to gem_mac (tx fifo interface).
   tx_r_data,
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

   // signal coming from gem_mac (tx fifo interface).
   tx_r_rd,

   // signals going to gem_mac.
   dma_tx_status_tog,
   dma_rx_status_tog,

   // Stats to register block ...
   rx_w_overflow,

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

   rx_dma_descr_ptr,
   rx_dma_descr_ptr_tog

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
   input [p_edma_bus_width-1:0] hrdata; // AHB input data.
   output        hbusreq;              // AHB bus request.
   output        hlock;                // lock the bus - always asserted with
   output [p_edma_addr_width-1:0] haddr;                // hbusreq address to be accessed.
   output  [1:0] htrans;               // bus transfer type (nonseq, seq, idle
                                       // or busy.
   output        hwrite;               // AHB write signal (active high).
   output  [2:0] hsize;                // transfer size -
                                       // set to 3'b010 for 32 bit words.
                                       // set to 3'b011 for 64 bit words.
                                       // set to 3'b100 for 128 bit words.
   output  [2:0] hburst;               // burst type (single, incrementing etc).
   output  [3:0] hprot;                // Protection type - unused tied low.
   output [p_edma_bus_width-1:0] hwdata;  // AHB Write data.


   // signals coming from gem_mac (rx fifo interface).
   input   [3:0] rx_w_mod;             // rx number of valid bytes in last
                                       // transfer of the frame.
                                       // 0000 - rx_w_data[127:0] valid,
                                       // 0001 - rx_w_data[7:0] valid,
                                       // 0010 - rx_w_data[15:0] valid, until
                                       // 1111 - rx_w_data[119:0] valid.

   input         rx_w_wr;              // write control for rx fifo.
   input [p_emac_bus_width-1:0]
                 rx_w_data;            // write data for rx fifo.
   input         rx_w_sop;             // rx start of packet indicator.
   input         rx_w_eop;             // rx end of packet indicator.
   input         rx_w_err;             // rx packet in error indicator.
   input         rx_w_flush;           // fifo flush from the mac

   // signal coming from gem_mac (tx fifo interface).
   input [p_edma_queues-1:0]      tx_r_rd;              // rx fifo read control.


   // signals coming from gem_mac (gem_tx).
   input         dma_tx_end_tog;       // Toggled at the end of frame
                                       // transmission (loads new tx
                                       // address and length), will not update
                                       // until dma_tx_status_tog is returned.
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

   // signals coming from gem_reg_top (gem_registers).
   input         rx_dma_stat_capt_tog; // toggle when pclk domain registerred
                                       // rx_dma status signals
   input         tx_dma_stat_capt_tog; // toggle when pclk domain registerred
   input         rx_buff_not_rdy_pclk; // pclk pulse corresp to posedge of
                                       // rx_dma_buff_not_rdy flag
   input   [1:0] dma_bus_width;        // DMA bus width...
                                       //   00 : 32-bit
                                       //   01 : 64-bit
                                       //   10 : 128-bit
                                       //   11 : 128-bit.
   input         rx_toe_enable;        // Enable RX TCP Offload Engine.
   input [(p_edma_queues*32)-1:0] tx_dma_descr_base_addr; // base address for the buffer descriptor
                                       // list.
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
   input [(p_edma_queues*32)-1:0] rx_dma_descr_base_addr;  // rx buffer queue base addr.
   input [(p_edma_queues*8)-1:0] rx_dma_buffer_size;       // buffer depth (in x64 bytes)
   input   [1:0] rx_dma_buffer_offset; // offset of the data from buffer start.
   input   [4:0] ahb_burst_length;     // AHB burst length control
   input         rx_no_crc_check;      // Ignore RX FCS check
   input         jumbo_enable;         // jumbo frames enabled
   input   [1:0] endian_swap;          // Endian swap enabled

   // signals going to gem_mac (tx fifo interface).
   output  [p_emac_bus_width-1:0]      // output data from the transmit fifo
                 tx_r_data;            // to the tx module.

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
   output   [p_edma_queues-1:0]       tx_r_data_rdy;        // indicates either a complete packet
                                       // is present in the fifo or a certain
                                       // threshold of data has been crossed,
                                       // the mac uses this input to trigger
                                       // a frame transfer.
   output        dma_is_busy;          // DMA is busy - block MAC from requesting
   output        tx_r_underflow;       // signals tx fifo underrun condition.
   output        tx_r_flushed;         // tx fifo has been flushed.
   output        tx_r_control;         // packet control information

   // signals going to gem_mac.
   output        dma_tx_status_tog;    // when toggled, indicates transmit
                                       // status written by dma.
   output        dma_rx_status_tog;    // when toggled, indicates receive
                                       // status written by dma.
   // Stats from pkt buffer to register block
   output         rx_w_overflow;        // Overflow in RX FIFO indication

   // signals going to RX packet buffer if included
   // signals going to gem_reg_top (gem_pclk_syncs).
   output        tx_dma_complete_ok;   // tx_frame_end indication to the
                                       // register block.
   output        tx_dma_buffers_ex;    // sets bit in transmit status register.
   output        tx_dma_buff_ex_mid;   // sets bit in transmit status register.
   output        tx_dma_hresp_notok;   // error response from ahb during tx.
   output        tx_dma_go;            // sets bit in transmit status register.
   output [(p_edma_queues*32)-1:0] tx_dma_descr_ptr;     // Descriptor queue pointer for debug
   output        tx_dma_descr_ptr_tog;    // handshaking for tx_dma_descr_ptr.
   output        tx_dma_late_col;      // late collision indicator
   output        tx_dma_toomanyretry;  // too many retires indicator
   output        tx_dma_underflow;     // Underflow indicator
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
   output [(p_edma_queues*32)-1:0] rx_dma_descr_ptr;     // Descriptor queue pointer for debug
   output        rx_dma_descr_ptr_tog;    // handshaking for rx_dma_descr_ptr.

   // Internal wire and reg declarations.

   // connections between edma_tx and gem_hclk_syncs.
   wire          coll_occurred_hclk;   // collision_occured synchronised to hclk
   wire          tx_frame_end_pulse;   // Edge detected dma_tx_end_tog in hclk.
   wire          too_many_retry_hclk;  // Sampled too_many_retries from gem_tx.
   wire          underflow_frame_hclk; // Sampled underflow_frame from gem_tx.
   wire          late_coll_occ_hclk;   // Sampled late_coll_occured from gem_tx.
   wire          rx_frame_end_pulse;   // Edge detected dma_rx_end_tog in hclk.
   wire          rx_buff_not_rdy_clr;  // pulse to clear corresp flag
   wire          rx_w_bad_frame_hclk;  // hclk version of rx_w_bad_frame
   wire   [13:0] rx_w_frm_lngth_hclk;  // hclk version of rx_w_frame_length
   wire          rx_w_vlan_tag_hclk;   // hclk version of rx_w_vlan_tagged
   wire          rx_w_prty_tag_hclk;   // hclk version of rx_w_prty_tagged
   wire    [3:0] rx_w_tci_hclk;        // hclk version of rx_w_tci
   wire          rx_w_broadcast_hclk;  // hclk version of rx_w_broadcast_frame
   wire          rx_w_mult_hash_hclk;  // hclk version of rx_w_mult_hash_match
   wire          rx_w_uni_hash_hclk;   // hclk version of rx_w_uni_hash_match
   wire          rx_w_ext_match1_hclk; // hclk version of rx_w_ext_match1
   wire          rx_w_ext_match2_hclk; // hclk version of rx_w_ext_match2
   wire          rx_w_ext_match3_hclk; // hclk version of rx_w_ext_match3
   wire          rx_w_ext_match4_hclk; // hclk version of rx_w_ext_match4
   wire          rx_w_add_match1_hclk; // hclk version of rx_w_add_match1
   wire          rx_w_add_match2_hclk; // hclk version of rx_w_add_match2
   wire          rx_w_add_match3_hclk; // hclk version of rx_w_add_match3
   wire          rx_w_add_match4_hclk; // hclk version of rx_w_add_match4
   wire          rx_w_type_mtch1_hclk; // hclk version of rx_w_type_match1
   wire          rx_w_type_mtch2_hclk; // hclk version of rx_w_type_match2
   wire          rx_w_type_mtch3_hclk; // hclk version of rx_w_type_match3
   wire          rx_w_type_mtch4_hclk; // hclk version of rx_w_type_match4
   wire          rx_w_cksumi_ok_hclk;  // hclk version of rx_w_checksumi_ok
   wire          rx_w_cksumt_ok_hclk;  // hclk version of rx_w_checksumt_ok
   wire          rx_w_cksumu_ok_hclk;  // hclk version of rx_w_checksumu_ok
   wire          rx_w_snap_frame_hclk; // hclk version of rx_w_snap_frame
   wire          rx_w_crc_error_hclk;  // hclk version of rx_w_crc_error

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


    // ---------------------------------------
    // Legacy non Packet Buffer DMA mode -
    // ---------------------------------------

    // connections between edma_tx and edma_ahb.
    wire          tx_last_data_ph;      // signals final ahb data.
    wire          tx_addr_inc_strobe;   // advanced warning of address strobe
    wire          tx_addr_strobe;       // signals an individual ahb address.
    wire          tx_data_strobe;       // signals an individual ahb data.
    wire          tx_addr_bus_owned;    // tx owns address bus.
    wire          tx_burst_error;       // error detected during AHB access.
    wire          tx_dma_state_man_wr;  // data flow sm in dma management write
                                        // state.
    wire          tx_dma_state_man_rd;  // data flow sm in dma management read
                                        // state.
    wire          tx_dma_state_data;    // data flow sm in data transfer state.
    wire          tx_dma_bus_req;       // requests a ahb bus request on any
                                        // management or data next state change.
    wire          tx_dma_flow_error;    // data flow sm requires any ongoing bus
                                        // transactions to be aborted; 1 hclk
                                        // cycle whenunderrun or overrun error.
    wire   [31:0] tx_dma_data_out;      // the data to be placed on the bus
                                        // during ahb data phase; should be
                                        // changed on the next tx_addr_strobe,
                                        // when it will be registered within
                                        // edma_tx; for man_wr, the actual
                                        // descriptor data should always be put
                                        // on dma_wr_data[31:0] - demux should
                                        // place this data on the valid 32b
                                        // word lane according to endianness and
                                        // 4 lsbs of the descriptor address.
    wire   [31:2] tx_dma_burst_addr;    // the address to be placed on the bus
                                        // during ahb ahb address phase for both
                                        // read and write; should be changed on
                                        // the next tx_addr_strobe.
    wire          tx_data_burst_break;  // used to terminate a burst that does
                                        // not require the maximum burst.
    wire          tx_dma_next_data;     // next hclk cycle the edma_tx will
                                        // be in data read state.
    wire          tx_dma_next_man_rd;   // next hclk cycle the edma_tx will
                                        // be in data read management state.
    wire          tx_dma_next_man_wr;   // next hclk cycle the edma_tx will
                                        // be in data write management state.
    wire          tx_dma_eop_burst;     // tx dma initiated eop burst


    // connections between edma_rx and edma_ahb.
    wire          rx_last_addr_ph;      // signals final ahb address.
    wire          rx_last_data_ph;      // signals final ahb data.
    wire          rx_addr_strobe;       // signals an individual ahb address.
    wire          rx_data_strobe;       // signals an individual ahb data.
    wire          rx_addr_bus_owned;    // rx owns address bus.
    wire          rx_burst_error;       // error detected during AHB access.
    wire          rx_addr_inc_strobe;   // strobe for rx address increment.
    wire          rx_dma_state_man_wr;  // rx dma state descriptor write.
    wire          rx_dma_state_man_rd;  // rx dma state descriptor read.
    wire          rx_dma_state_data;    // rx dma state frame storage.
    wire          rx_dma_bus_req;       // rx dma bus request.
    wire          rx_dma_flow_error;    // rx dma data flow error.
    wire   [31:2] rx_dma_burst_addr;    // rx next dma transfer address.
    wire  [127:0] rx_dma_data_out;      // rx dma output data.
    wire          rx_data_burst_break;  // rx data burst must end next cycle.
    wire          rx_dma_next_data;     // rx dma next state is data.
    wire          rx_dma_next_man_wr;   // rx dma next state is management wr.
    wire          rx_dma_next_man_rd;   // rx dma next state is management rd.
    wire          rx_dma_eop_burst;     // rx dma initiated eop burst

    // connections between edma_rx, edma_tx and edma_ahb.
    wire  [127:0] dma_data_rd;          // DMA read data to dma_rx & dma_tx.
    wire          bus_idle;             // AHB bus idle.

    assign tx_dma_late_col = 1'b0;
    assign tx_dma_toomanyretry = 1'b0;
    assign tx_dma_underflow = 1'b0;

    edma_fifo_ahb_tx i_edma_fifo_ahb_tx (

      // system signals.
      .hclk                 (hclk),
      .n_hreset             (n_hreset),
      .tx_r_clk             (tx_r_clk),
      .tx_r_rst_n           (tx_r_rst_n),

      // signals going to gem_mac (gem_tx).
      .dma_tx_status_tog    (dma_tx_status_tog),

      // signals going to gem_mac (gem_tx - fifo interface).
      .tx_r_valid           (tx_r_valid),
      .tx_r_data            (tx_r_data),
      .tx_r_eop             (tx_r_eop),
      .tx_r_sop             (tx_r_sop),
      .tx_r_mod             (tx_r_mod),
      .tx_r_err             (tx_r_err),
      .tx_r_flushed         (tx_r_flushed),
      .tx_r_underflow       (tx_r_underflow),
      .tx_r_control         (tx_r_control),
      .tx_r_data_rdy        (tx_r_data_rdy),

      // signals coming from gem_mac (gem_tx - fifo interface).
      .tx_r_rd              (tx_r_rd),

      // signals coming from the gem_hclk_syncs block (internal).
      .tx_frame_end_pulse   (tx_frame_end_pulse),
      .too_many_retry_hclk  (too_many_retry_hclk),
      .underflow_frame_hclk (underflow_frame_hclk),
      .late_coll_occ_hclk   (late_coll_occ_hclk),
      .new_tx_q_ptr_pulse   (new_tx_q_ptr_pulse),
      .coll_occurred_hclk   (coll_occurred_hclk),
      .tx_halt_hclk         (tx_halt_hclk),
      .tx_start_hclk_pulse  (tx_start_hclk_pulse),
      .enable_tx_hclk       (enable_tx_hclk),
      .tx_buff_q_base_addr  (tx_dma_descr_base_addr[31:2]),
      .tx_stat_capt_pulse   (tx_stat_capt_pulse),

      // signals coming from gem_reg_top (gem_registers).
      .dma_bus_width        (dma_bus_width),
      .ahb_burst_length     (ahb_burst_length),

      // signals going to gem_reg_top (gem_pclk_syncs).
      .tx_dma_complete_ok   (tx_dma_complete_ok),
      .tx_dma_buffers_ex    (tx_dma_buffers_ex),
      .tx_dma_buff_ex_mid   (tx_dma_buff_ex_mid),
      .tx_dma_hresp_notok   (tx_dma_hresp_notok),
      .tx_dma_go            (tx_dma_go),
      .tx_dma_descr_ptr     (tx_dma_descr_ptr[31:2]),
      .tx_dma_ptr_up_tog    (tx_dma_descr_ptr_tog),
      .tx_dma_stable_tog    (tx_dma_stable_tog),

      // signals coming from edma_ahb (internal).
      .tx_last_data_ph      (tx_last_data_ph),
      .tx_addr_inc_strobe   (tx_addr_inc_strobe),
      .tx_addr_strobe       (tx_addr_strobe),
      .tx_data_strobe       (tx_data_strobe),
      .tx_dma_data_in       (dma_data_rd),
      .tx_burst_error       (tx_burst_error),
      .tx_addr_bus_owned    (tx_addr_bus_owned),

      // signals going to edma_ahb (internal).
      .tx_dma_state_man_wr  (tx_dma_state_man_wr),
      .tx_dma_state_man_rd  (tx_dma_state_man_rd),
      .tx_dma_state_data    (tx_dma_state_data),
      .tx_dma_bus_req       (tx_dma_bus_req),
      .tx_dma_flow_error    (tx_dma_flow_error),
      .tx_dma_data_out      (tx_dma_data_out),
      .tx_dma_burst_addr    (tx_dma_burst_addr),
      .tx_data_burst_break  (tx_data_burst_break),
      .tx_dma_eop_burst     (tx_dma_eop_burst),
      .tx_dma_next_data     (tx_dma_next_data),
      .tx_dma_next_man_wr   (tx_dma_next_man_wr),
      .tx_dma_next_man_rd   (tx_dma_next_man_rd)
    );

    assign tx_dma_descr_ptr[1:0] = 2'b00;
    assign dma_is_busy = 1'b0;

    edma_fifo_ahb_rx i_edma_fifo_ahb_rx (

      // global clk & reset.
      .n_hreset             (n_hreset),
      .hclk                 (hclk),
      .rx_w_clk             (rx_w_clk),
      .rx_w_rst_n           (rx_w_rst_n),

      // signals coming from gem_mac (gem_rx - fifo interface).
      .rx_w_wr              (rx_w_wr),
      .rx_w_data            (rx_w_data[p_emac_bus_width-1:0]),
      .rx_w_mod             (rx_w_mod),
      .rx_w_sop             (rx_w_sop),
      .rx_w_eop             (rx_w_eop),
      .rx_w_err             (rx_w_err),
      .rx_w_flush           (rx_w_flush),

      // signals going to gem_mac (gem_rx - fifo interface).
      .rx_w_overflow        (rx_w_overflow),

      // inputs coming from edma_ahb (internal).
      .rx_last_data_ph      (rx_last_data_ph),
      .rx_last_addr_ph      (rx_last_addr_ph),
      .rx_addr_inc_strobe   (rx_addr_inc_strobe),
      .rx_addr_strobe       (rx_addr_strobe),
      .rx_data_strobe       (rx_data_strobe),
      .rx_addr_bus_owned    (rx_addr_bus_owned),
      .rx_dma_data_in       (dma_data_rd[31:0]),
      .bus_idle             (bus_idle),
      .rx_burst_error       (rx_burst_error),

      // inputs coming from the gem_mac (gem_rx) (via hclk_syncs)
      .rx_w_bad_frame_hclk  (rx_w_bad_frame_hclk),
      .rx_w_frm_lngth_hclk  (rx_w_frm_lngth_hclk),
      .rx_w_vlan_tag_hclk   (rx_w_vlan_tag_hclk),
      .rx_w_prty_tag_hclk   (rx_w_prty_tag_hclk),
      .rx_w_tci_hclk        (rx_w_tci_hclk),
      .rx_w_broadcast_hclk  (rx_w_broadcast_hclk),
      .rx_w_mult_hash_hclk  (rx_w_mult_hash_hclk),
      .rx_w_uni_hash_hclk   (rx_w_uni_hash_hclk),
      .rx_w_ext_match1_hclk (rx_w_ext_match1_hclk),
      .rx_w_ext_match2_hclk (rx_w_ext_match2_hclk),
      .rx_w_ext_match3_hclk (rx_w_ext_match3_hclk),
      .rx_w_ext_match4_hclk (rx_w_ext_match4_hclk),
      .rx_w_add_match1_hclk (rx_w_add_match1_hclk),
      .rx_w_add_match2_hclk (rx_w_add_match2_hclk),
      .rx_w_add_match3_hclk (rx_w_add_match3_hclk),
      .rx_w_add_match4_hclk (rx_w_add_match4_hclk),
      .rx_w_type_mtch1_hclk (rx_w_type_mtch1_hclk),
      .rx_w_type_mtch2_hclk (rx_w_type_mtch2_hclk),
      .rx_w_type_mtch3_hclk (rx_w_type_mtch3_hclk),
      .rx_w_type_mtch4_hclk (rx_w_type_mtch4_hclk),
      .rx_w_cksumi_ok_hclk  (rx_w_cksumi_ok_hclk),
      .rx_w_cksumt_ok_hclk  (rx_w_cksumt_ok_hclk),
      .rx_w_cksumu_ok_hclk  (rx_w_cksumu_ok_hclk),
      .rx_w_snap_frame_hclk (rx_w_snap_frame_hclk),
      .rx_w_crc_error_hclk  (rx_w_crc_error_hclk),

      // signals coming from gem_hclk_syncs (internal).
      .enable_rx_hclk       (enable_rx_hclk),
      .new_rx_q_ptr_pulse   (new_rx_q_ptr_pulse),
      .rx_frame_end_pulse   (rx_frame_end_pulse),
      .rx_stat_capt_pulse   (rx_stat_capt_pulse),
      .rx_buff_not_rdy_clr  (rx_buff_not_rdy_clr),

      // signals coming from gem_registers.
      .rx_buff_q_base_addr  (rx_dma_descr_base_addr[31:2]),
      .rx_buffer_size       (rx_dma_buffer_size),
      .rx_buffer_offset     (rx_dma_buffer_offset),
      .dma_bus_width        (dma_bus_width),
      .ahb_burst_length     (ahb_burst_length),
      .rx_toe_enable        (rx_toe_enable),
      .rx_no_crc_check      (rx_no_crc_check),
      .jumbo_enable         (jumbo_enable),

      // outputs going to edma_ahb (internal).
      .rx_dma_burst_addr    (rx_dma_burst_addr),
      .rx_dma_data_out      (rx_dma_data_out),
      .rx_dma_state_man_rd  (rx_dma_state_man_rd),
      .rx_dma_state_man_wr  (rx_dma_state_man_wr),
      .rx_dma_state_data    (rx_dma_state_data),
      .rx_dma_bus_req       (rx_dma_bus_req),
      .rx_data_burst_break  (rx_data_burst_break),
      .rx_dma_eop_burst     (rx_dma_eop_burst),
      .rx_dma_flow_error    (rx_dma_flow_error),
      .rx_dma_next_data     (rx_dma_next_data),
      .rx_dma_next_man_wr   (rx_dma_next_man_wr),
      .rx_dma_next_man_rd   (rx_dma_next_man_rd),

      // outputs going to gem_mac (gem_rx).
      .dma_rx_status_tog    (dma_rx_status_tog),

      // outputs going to gem_registers (gem_reg_top).
      .rx_dma_stable_tog    (rx_dma_stable_tog),
      .rx_dma_complete_ok   (rx_dma_complete_ok),
      .rx_dma_resource_err  (rx_dma_resource_err),
      .rx_dma_hresp_notok   (rx_dma_hresp_notok),
      .rx_dma_buff_not_rdy  (rx_dma_buff_not_rdy),
      .rx_dma_descr_ptr     (rx_dma_descr_ptr[31:2]),
      .rx_dma_ptr_up_tog    (rx_dma_descr_ptr_tog)

    );

    assign rx_dma_descr_ptr[1:0] = 2'd0;

    wire  [128:0]  hrdata_int;
    wire  [127:0]  hwdata_int;
    assign hrdata_int = {{129-p_edma_bus_width{1'b0}},hrdata};
    assign hwdata = hwdata_int[p_edma_bus_width-1:0];

    edma_fifo_ahb i_edma_fifo_ahb (

      // global clk & reset.
      .n_hreset             (n_hreset),
      .hclk                 (hclk),

      // ahb top level inputs.
      .hgrant               (hgrant),
      .hready               (hready),
      .hresp                (hresp),
      .hrdata               (hrdata_int[127:0]),

      // inputs from edma_rx module (internal).
      .rx_dma_state_man_rd  (rx_dma_state_man_rd),
      .rx_dma_state_man_wr  (rx_dma_state_man_wr),
      .rx_dma_state_data    (rx_dma_state_data),
      .rx_dma_bus_req       (rx_dma_bus_req),
      .rx_dma_flow_error    (rx_dma_flow_error),
      .rx_dma_burst_addr    (rx_dma_burst_addr),
      .rx_dma_data_out      (rx_dma_data_out),
      .rx_data_burst_break  (rx_data_burst_break),
      .rx_dma_eop_burst     (rx_dma_eop_burst),
      .rx_dma_next_data     (rx_dma_next_data),
      .rx_dma_next_man_wr   (rx_dma_next_man_wr),
      .rx_dma_next_man_rd   (rx_dma_next_man_rd),

      // inputs from edma_tx module (internal).
      .tx_dma_state_man_wr  (tx_dma_state_man_wr),
      .tx_dma_state_man_rd  (tx_dma_state_man_rd),
      .tx_dma_state_data    (tx_dma_state_data),
      .tx_dma_bus_req       (tx_dma_bus_req),
      .tx_dma_flow_error    (tx_dma_flow_error),
      .tx_dma_burst_addr    (tx_dma_burst_addr),
      .tx_dma_data_out      ({96'd0, tx_dma_data_out[31:0]}),
      .tx_data_burst_break  (tx_data_burst_break),
      .tx_dma_eop_burst     (tx_dma_eop_burst),
      .tx_dma_next_data     (tx_dma_next_data),
      .tx_dma_next_man_wr   (tx_dma_next_man_wr),
      .tx_dma_next_man_rd   (tx_dma_next_man_rd),

      // inputs from gem_register module.
      .dma_bus_width        (dma_bus_width),
      .ahb_burst_length     (ahb_burst_length),
      .endian_swap          (endian_swap),

      // outputs to edma_rx module (internal).
      .rx_last_addr_ph      (rx_last_addr_ph),
      .rx_last_data_ph      (rx_last_data_ph),
      .rx_addr_strobe       (rx_addr_strobe),
      .rx_data_strobe       (rx_data_strobe),
      .rx_addr_bus_owned    (rx_addr_bus_owned),
      .rx_burst_error       (rx_burst_error),
      .rx_addr_inc_strobe   (rx_addr_inc_strobe),

      // outputs to edma_tx module (internal).
      .tx_last_data_ph      (tx_last_data_ph),
      .tx_addr_strobe       (tx_addr_strobe),
      .tx_data_strobe       (tx_data_strobe),
      .tx_addr_bus_owned    (tx_addr_bus_owned),
      .tx_burst_error       (tx_burst_error),
      .tx_addr_inc_strobe   (tx_addr_inc_strobe),

      // outputs to both edma_tx and edma_rx modules.
      .dma_data_rd          (dma_data_rd),
      .bus_idle             (bus_idle),

      // ahb top level outputs
      .htrans               (htrans),
      .hburst               (hburst),
      .hsize                (hsize),
      .hwrite               (hwrite),
      .hbusreq              (hbusreq),
      .hlock                (hlock),
      .haddr                (haddr),
      .hwdata               (hwdata_int),
      .hprot                (hprot)
    );

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
      .flush_rx_pkt_pclk    (1'b0),
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

      .tx_frame_end_pulse   (tx_frame_end_pulse),  // needed by old dma only
      .too_many_retry_hclk  (too_many_retry_hclk), // needed by old dma only
      .underflow_frame_hclk (underflow_frame_hclk),// needed by old dma only
      .late_coll_occ_hclk   (late_coll_occ_hclk),  // needed by old dma only
      .coll_occurred_hclk   (coll_occurred_hclk),  // needed by old dma only

      // synchronised hclk outputs going to edma_rx
      .flush_rx_pkt_hclk    (),
      .rx_buff_not_rdy_clr  (rx_buff_not_rdy_clr), // needed by old dma only
      .rx_frame_end_pulse   (rx_frame_end_pulse),  // needed by old dma only
      .rx_w_bad_frame_hclk  (rx_w_bad_frame_hclk), // needed by old dma only
      .rx_w_frm_lngth_hclk  (rx_w_frm_lngth_hclk), // needed by old dma only
      .rx_w_vlan_tag_hclk   (rx_w_vlan_tag_hclk),  // needed by old dma only
      .rx_w_prty_tag_hclk   (rx_w_prty_tag_hclk),  // needed by old dma only
      .rx_w_tci_hclk        (rx_w_tci_hclk),       // needed by old dma only
      .rx_w_broadcast_hclk  (rx_w_broadcast_hclk), // needed by old dma only
      .rx_w_mult_hash_hclk  (rx_w_mult_hash_hclk), // needed by old dma only
      .rx_w_uni_hash_hclk   (rx_w_uni_hash_hclk),  // needed by old dma only
      .rx_w_ext_match1_hclk (rx_w_ext_match1_hclk),// needed by old dma only
      .rx_w_ext_match2_hclk (rx_w_ext_match2_hclk),// needed by old dma only
      .rx_w_ext_match3_hclk (rx_w_ext_match3_hclk),// needed by old dma only
      .rx_w_ext_match4_hclk (rx_w_ext_match4_hclk),// needed by old dma only
      .rx_w_add_match1_hclk (rx_w_add_match1_hclk),// needed by old dma only
      .rx_w_add_match2_hclk (rx_w_add_match2_hclk),// needed by old dma only
      .rx_w_add_match3_hclk (rx_w_add_match3_hclk),// needed by old dma only
      .rx_w_add_match4_hclk (rx_w_add_match4_hclk),// needed by old dma only
      .rx_w_type_mtch1_hclk (rx_w_type_mtch1_hclk),// needed by old dma only
      .rx_w_type_mtch2_hclk (rx_w_type_mtch2_hclk),// needed by old dma only
      .rx_w_type_mtch3_hclk (rx_w_type_mtch3_hclk),// needed by old dma only
      .rx_w_type_mtch4_hclk (rx_w_type_mtch4_hclk),// needed by old dma only
      .rx_w_cksumi_ok_hclk  (rx_w_cksumi_ok_hclk), // needed by old dma only
      .rx_w_cksumt_ok_hclk  (rx_w_cksumt_ok_hclk), // needed by old dma only
      .rx_w_cksumu_ok_hclk  (rx_w_cksumu_ok_hclk), // needed by old dma only
      .rx_w_snap_frame_hclk (rx_w_snap_frame_hclk),// needed by old dma only
      .rx_w_crc_error_hclk  (rx_w_crc_error_hclk), // needed by old dma only
 
      .enable_rx_hclk       (enable_rx_hclk),
      .new_rx_q_ptr_pulse   (new_rx_q_ptr_pulse),
      .rx_stat_capt_pulse   (rx_stat_capt_pulse)
   );

endmodule

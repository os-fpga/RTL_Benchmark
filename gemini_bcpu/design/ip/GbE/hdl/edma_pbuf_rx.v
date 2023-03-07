//------------------------------------------------------------------------------
// Copyright (c) 2008-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_pbuf_rx.v
//   Module Name:        edma_pbuf_rx
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
//   Description    :   The edma_rx module controls the storing of received
//                      data from the receive FIFO to the AHB memory device.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module edma_pbuf_rx (

 // Inputs

 // global clk & reset
   n_hreset,                       // ahb domain reset
   hclk,                           // ahb clock
   rx_clk,                         // mac rx clock
   n_rxreset,                      // mac rx clock domain reset

   // inputs coming from gem_mac (gem_rx - fifo interface).
   rx_w_wr,                        // fifo write strobe
   rx_w_data,                      // fifo write data (validated by rx_w_wr)
   rx_w_data_par,                  // Parity
   rx_w_sop,                       // flag that rx_w_data has sop in first byte
   rx_w_eop,                       // flag that rx_w_data has eop
   rx_w_err,                       // flag that current packet is corrupted

   rx_end_tog,
   rx_status_wr_tog,
   rx_pkt_end_tog,
   rx_pkt_status_wr_tog,

   // inputs coming from the gem_mac (gem_rx - status), via hclk_syncs
   dma_rx_end_tog,
   rx_w_bad_frame,                 // end of bad receive frame.
   rx_w_frame_length,              // frame length field
   rx_w_ext_match1,                // external address 1 recognized
   rx_w_ext_match2,                // external address 2 recognized
   rx_w_ext_match3,                // external address 3 recognized
   rx_w_ext_match4,                // external address 4 recognized
   rx_w_add_match1,                // specific address 1 recognized
   rx_w_add_match2,                // specific address 2 recognized
   rx_w_add_match3,                // specific address 3 recognized
   rx_w_add_match4,                // specific address 4 recognized
   rx_w_add_match5,
   rx_w_add_match6,
   rx_w_add_match7,
   rx_w_add_match8,
   rx_w_type_match1,               // Type ID 1 recognized
   rx_w_type_match2,               // Type ID 2 recognized
   rx_w_type_match3,               // Type ID 3 recognized
   rx_w_type_match4,               // Type ID 4 recognized
   rx_w_broadcast_frame,           // broadcast address recognized
   rx_w_mult_hash_match,           // multi hash address recognition
   rx_w_uni_hash_match,            // uni hash address recognition
   rx_w_vlan_tagged,               // vlan tag status field
   rx_w_prty_tagged,               // priority field
   rx_w_tci,                       // tci field
   rx_w_checksumi_ok,              // IP checksum checked and was OK.
   rx_w_checksumt_ok,              // TCP checksum checked and was OK.
   rx_w_checksumu_ok,              // UDP checksum checked and was OK.
   rx_w_snap_frame,                // SNAP encapsulated & valid VLAN
   rx_w_crc_error,                 // Frame had bad FCS
   rx_w_l4_offset,
   rx_w_pld_offset,

   restart_trigger,                // Restart RX descriptor reads

 // The actual stats going to the Register block (via pclk_syncs)
   dbuff_overflow,
   rx_dma_pkt_flushed,

 // signals coming from the hclk_syncs block
   enable_rx_hclk,                 // reception enabled - rx module operating
   new_rx_q_ptr_pulse,             // buffer queue base address updated
   rx_stat_capt_pulse,             // dma_rx status has been captured
   flush_rx_pkt_hclk,

 // signals coming from the register block
   dma_addr_or_mask,
   rx_dma_descr_base_addr,         // buffer queue (descriptor list) base addr
   rx_dma_descr_base_par,
   rx_dma_buffer_size,             // buffer depth (in x64 bytes)
   rx_dma_buffer_offset,           // offset of the data from buffer beginning
   dma_bus_width,                  // width of dma data bus
   rx_toe_enable,                  // Enable RX TCP Offload Engine.
   rx_no_crc_check,                // Ignore RX FCS check
   jumbo_enable,                   // Enable jumbo frames
   crc_error_report,
   jumbo_max_length,
   force_discard_on_err,
   force_discard_on_err_q,
   rx_pbuf_size,                   // Size of Packet Buffer
   rx_cutthru_threshold,
   rx_cutthru,
   ahb_burst_length,               // AHB burst length control
   endian_swap,
   enable_receive,
   force_max_ahb_burst_rx,
   hdr_data_splitting_en,
   infinite_last_dbuf_size_en,     // data buffer pointed to by last descriptor is infinite size

   // RSC specific signalling
   rsc_en,
   rsc_stop,
   rsc_push,
   tcp_seqnum,
   tcp_syn,
   tcp_payload_len,
   rsc_clr_tog,

  // AHB Inputs
    hgrant_descr,
    hgrant_data,
    hready,
    hresp,
    hrdata,
    hrdata_par,

  // RX Descriptor AHB Outputs
    hbusreq_descr,
    hlock_descr,
    hburst_descr,
    htrans_descr,
    hsize_descr,
    hwrite_descr,
    hprot_descr,
    haddr_descr,
    haddr_descr_par,
    hwdata_descr,
    hwdata_descr_par,

  // RX Data AHB Outputs
    hbusreq_data,
    hlock_data,
    hburst_data,
    htrans_data,
    hsize_data,
    hwrite_data,
    hprot_data,
    haddr_data,
    haddr_data_par,
    hwdata_data,
    hwdata_data_par,

 // outputs going to gem_mac (gem_rx - fifo interface)
   rx_w_overflow,                  // overflow flag from fifo (write side)

 // outputs going to the gem_mac (gem_rx block)
   dma_rx_status_tog,              // descriptor write for last buffer done

 // outputs doing to the pclk_synch block
   rx_dma_stable_tog,              // Toggle indicating signals going to pclk
                                   // register are stable for sampling
 // outputs going to registers block (gem_registers)
   rx_dma_buff_not_rdy,            // used buffer descriptor read
   rx_dma_complete_ok,             // good frame is successfully stored
   rx_dma_resource_err,            // no buffers available for storage
   rx_dma_hresp_notok,             // hresp error during RX DMA
   rx_dma_descr_ptr,               // Current descriptor value for debug
   rx_dma_descr_ptr_par,
   rx_dma_descr_ptr_tog,              // handshake for rx_dma_descr_ptr
   rx_dma_int_queue,               // Identifies which queue the interupt is destined
   ahb_queue_ptr_rx,               // Identifies which queue
   queue_ptr_rx_aph,               // Early version of queue

   // DPRAM interface
   rxdpram_ena,
   rxdpram_wea,
   rxdpram_addra,
   rxdpram_dia,
   rxdpram_dia_par,
   rxdpram_enb,
   rxdpram_web,
   rxdpram_addrb,
   rxdpram_dob,
   rxdpram_dob_par,

   // Specific inputs to support Priority Queues
   rx_databuf_wr_q,

   last_data_to_buff_dph,
   status_word1_capt,
   full_pkt_size,
   rx_descr_ptr_reset,
   from_rx_dma_used_bit_read,
   from_rx_dma_queue_ptr,
   new_descr_fetch_trig,
   part_pkt_written,
   from_rx_dma_buff_depth,

   queue_ptr_rx,                    // Priority Queue Number

    // 64b addressing support
    upper_rx_q_base_addr,
    upper_rx_q_base_par,
    dma_addr_bus_width,

    rx_bd_extended_mode_en,
    rx_bd_ts_mode,

    // Timestamp for current rx packet
    rx_timestamp,

    // RAS - Timestamp parity protection
    rx_timestamp_prty,

    // PTP frame decoded signals
    sof_rx,
    event_frame_rx,
    general_frame_rx ,

    // signals for RSC to AXI block
    next_buffer_start_add,
    next_buffer_start_add_par,
    host_update_buf_add,
    rsc_coalescing_ended,
    rsc_write_strobe,
    queue_ptr_rx_mod,

    // Memory Update interface
    rsc_update_valid,
    rsc_update_ready,
    rsc_update_descr,
    rsc_update_last,
    rsc_update_addr,
    rsc_update_addr_par,
    rsc_update_data,
    rsc_update_data_par,
    rsc_update_ben,

    //lockup detection
    dpram_fill_lvl,
    rx_edma_overflow,

    // ASF - signals going to gem_reg_top
    asf_dap_rx_rd_err,
    asf_dap_rx_wr_err,

    // Signals to rx-rd module for per-queue rx flushing
    max_val_pclk,
    limit_num_bytes_allowed_ambaclk,
    fill_lvl_breached

 );


//-------------------------------------------
// Inputs declaration
//-------------------------------------------
   parameter [1363:0] grouped_params = {
       208'd0,
       32'd1, // p_edma_queue
       32'd64,// p_edma_tx_pbuf_data
       32'd64,// p_edma_rx_pbuf_data
       32'd10,// p_edma_tx_pbuf_addr
       32'd10,// p_edma_rx_pbuf_addr
       32'd0, // p_edma_tx_pbuf_queue_segment_size
       32'd64,// p_emac_bus_width
       32'd64,// p_edma_bus_width
       32'd32,// p_edma_addr_width
       868'd0
   };


`include "ungroup_params.v"

   // global clk & reset
   input          n_hreset;            // global reset
   input          hclk;                // global clock
   input          rx_clk;              // mac rx clock
   input          n_rxreset;           // mac rx clock domain reset

   // inputs coming from gem_mac (gem_rx - fifo interface).
   input          rx_w_wr;             // fifo write strobe
   input  [p_emac_bus_width-1:0]       //
                  rx_w_data;           // fifo write data (validated by rx_w_wr)
   input  [p_emac_bus_pwid-1:0]
                  rx_w_data_par;
   input          rx_w_sop;            // rx_w_data has sop in first byte
   input          rx_w_eop;            // rx_w_data has eop
   input          rx_w_err;            // current packet is corrupted

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
   input          rx_end_tog;
   output         rx_status_wr_tog;
   output         rx_pkt_end_tog;
   input          rx_pkt_status_wr_tog;

   // inputs coming from the gem_mac (gem_rx - status).
   input          dma_rx_end_tog;      // Toggled at the end of frame
                                       // reception, will not update until
                                       // dma_rx_status_tog is returned.
   input          rx_w_bad_frame;      // Good/bad frame indication
   input   [13:0] rx_w_frame_length;   // frame length field
   input          rx_w_vlan_tagged;    // external address 1 recognized
   input          rx_w_prty_tagged;    // external address 2 recognized
   input    [3:0] rx_w_tci;            // external address 3 recognized
   input          rx_w_broadcast_frame;// external address 4 recognized
   input          rx_w_mult_hash_match;// specific address 1 recognized
   input          rx_w_uni_hash_match; // specific address 2 recognized
   input          rx_w_ext_match1;     // specific address 3 recognized
   input          rx_w_ext_match2;     // specific address 4 recognized
   input          rx_w_ext_match3;     // Type ID 1 recognized
   input          rx_w_ext_match4;     // Type ID 2 recognized
   input          rx_w_add_match1;     // Type ID 3 recognized
   input          rx_w_add_match2;     // Type ID 4 recognized
   input          rx_w_add_match3;     // broadcast address recognized
   input          rx_w_add_match4;     // multi hash address recognition
   input          rx_w_add_match5;     // specific address register 5 matched
                                       // destination address.
   input          rx_w_add_match6;     // specific address register 6 matched
                                       // destination address.
   input          rx_w_add_match7;     // specific address register 7 matched
                                       // destination address.
   input          rx_w_add_match8;     // specific address register 8 matched
                                       // destination address.
   input          rx_w_type_match1;    // uni hash address recognition
   input          rx_w_type_match2;    // vlan tag status field
   input          rx_w_type_match3;    // priority field
   input          rx_w_type_match4;    // tci field
   input          rx_w_checksumi_ok;   // IP checksum checked and was OK.
   input          rx_w_checksumt_ok;   // TCP checksum checked and was OK.
   input          rx_w_checksumu_ok;   // UDP checksum checked and was OK.
   input          rx_w_snap_frame;     // SNAP encapsulated & valid VLAN
   input          rx_w_crc_error;      // Frame had FCS error
   input   [11:0] rx_w_pld_offset;     // PLD offset in bytes
   input   [11:0] rx_w_l4_offset;      // TCP/UDP offset in bytes

   input          restart_trigger;     // Restart RX descriptor reads

   // signals coming from the hclk_syncs block
   input          enable_rx_hclk;      // reception enabled
   input          new_rx_q_ptr_pulse;  // buffer queue base address updated
   input          rx_stat_capt_pulse;  // dma_rx status has been captured
   input          flush_rx_pkt_hclk;   // asserted when bit 18 of network
                                       // control register is written.
   input    [8:0] dma_addr_or_mask;    // OR mask for data buf accesses

   // signals coming from the register block
   input [(p_edma_queues*32)-1:0] rx_dma_descr_base_addr; // buffer queue base addr
   input [(p_edma_queues*4)-1:0]  rx_dma_descr_base_par;
   input [(p_edma_queues*8)-1:0] rx_dma_buffer_size;      // buffer depth (in x64 bytes)
   input    [1:0] rx_dma_buffer_offset;  // offset of the data from buffer start
   input    [1:0] dma_bus_width;       // width of dma data bus
   input    [4:0] ahb_burst_length;    // AHB burst length control
   input    [1:0] endian_swap;
   input          rx_toe_enable;       // Enable RX TCP Offload Engine.
   input          rx_no_crc_check;     // Ignore RX FCS check.
   input          jumbo_enable;        // Enable jumbo packets.
   input          crc_error_report; //
   input          force_discard_on_err;
   input          [p_edma_queues-1:0]
                  force_discard_on_err_q;
   input    [1:0] rx_pbuf_size;        // rx_pbuf_size
   input  [p_edma_rx_pbuf_addr-1:0] rx_cutthru_threshold; // Threshold value
   input          rx_cutthru;          // Enable for cut-thru operation
   input          enable_receive;      // Receive is enabled
   input          force_max_ahb_burst_rx; // Force AHB to issue max len bursts
   input          hdr_data_splitting_en; // Header Data Splitting
   input          infinite_last_dbuf_size_en; // data buffer pointed to by last descriptor is infinite size

   // RSC ports
   input   [14:0] rsc_en;
   input          rsc_stop;               // Set if any of the SYN/FIN/RST/URG
                                          // flags are set in the TCP header
   input          rsc_push;               // Set if the PSH flas is set
   input  [31:0]  tcp_seqnum;             // Identifies the TCP seqnum of the frame
   input          tcp_syn;                // Set if the SYN flas is set
   input  [15:0]  tcp_payload_len;        // Payload Length
   output [p_edma_queues-1:0] rsc_clr_tog; // Receive Side Coalescing clear

    // DPRAM interface
   output         rxdpram_ena;                     // DPRAM Interface
   output         rxdpram_wea;                     // DPRAM Interface
   output  [p_edma_rx_pbuf_addr-1:0]  rxdpram_addra; // DPRAM Interface
   output  [p_edma_rx_pbuf_data-1:0]  rxdpram_dia;   // DPRAM Interface
   output  [p_edma_rx_pbuf_pwid-1:0]  rxdpram_dia_par;

   output         rxdpram_enb;                     // DPRAM Interface
   output         rxdpram_web;                     // DPRAM Interface
   output  [p_edma_rx_pbuf_addr-1:0]  rxdpram_addrb; // DPRAM Interface
   input   [p_edma_rx_pbuf_data-1:0]  rxdpram_dob;   // DPRAM Interface
   input   [p_edma_rx_pbuf_pwid-1:0]  rxdpram_dob_par;

   // inputs from AHB
   input           hgrant_descr;
   input           hgrant_data;
   input           hready;
   input   [1:0]   hresp;
   input [p_edma_bus_width-1:0] hrdata;        // AHB input data.
   input [p_edma_bus_pwid-1:0]  hrdata_par;

   input   [3:0]   queue_ptr_rx;            // Priority Queue Number
   input   [13:0]  jumbo_max_length;    // jumbo frame max length


   output          last_data_to_buff_dph;
   output          status_word1_capt;
   output  [13:0]  full_pkt_size;
   output          from_rx_dma_used_bit_read;
   output          rx_descr_ptr_reset;
   output  [3:0]   from_rx_dma_queue_ptr;
   output          new_descr_fetch_trig;
   output          part_pkt_written;
   output  [11:0]  from_rx_dma_buff_depth;

//-------------------------------------------
// Ouputs declaration
//-------------------------------------------

   // Outputs to AHB - RX Descriptor AHB Master
   output          hbusreq_descr;
   output          hlock_descr;
   output  [2:0]   hburst_descr;
   output  [1:0]   htrans_descr;
   output  [2:0]   hsize_descr;
   output          hwrite_descr;
   output  [3:0]   hprot_descr;
   output  [p_edma_addr_width-1:0]  haddr_descr;
   output  [p_edma_addr_pwid-1:0]   haddr_descr_par;
   output  [127:0] hwdata_descr;
   output  [15:0]  hwdata_descr_par;

   // Outputs to AHB - RX Data AHB Master
   output          hbusreq_data;
   output          hlock_data;
   output  [2:0]   hburst_data;
   output  [1:0]   htrans_data;
   output  [2:0]   hsize_data;
   output          hwrite_data;
   output  [3:0]   hprot_data;
   output  [p_edma_addr_width-1:0]  haddr_data;
   output  [p_edma_addr_pwid-1:0]   haddr_data_par;

   output  [127:0] hwdata_data;
   output  [15:0]  hwdata_data_par;
 // outputs going to gem_mac (gem_rx - fifo interface)
   output         rx_w_overflow;       // overflow flag from fifo (write side)

   // outputs going to the rx block
   output                           dma_rx_status_tog;   // last buffer descriptor write done

   // outputs going to the pclk_syncs (register statistics)
   output                           dbuff_overflow;      // asserted when overflow in RX path
   output                           rx_dma_pkt_flushed;  // Frame was dropped due to AHB
                                                         // resource error

 // outputs doing to the pclk_synch block
   output         rx_dma_stable_tog;   // Toggles to indicate that signals
                                       // going to pclk register are stable
                                       // for sampling
 // outputs going to registers block (pclk)
   output         rx_dma_buff_not_rdy; // used buffer descriptor read
   output         rx_dma_complete_ok;  // good frame is successfully stored
   output         rx_dma_resource_err; // no buffers available for storage
   output         rx_dma_hresp_notok;  // hresp error during RX DMA
   output [(32*p_edma_queues)-1:0] rx_dma_descr_ptr;    // current buffer descriptor address
   output [(4*p_edma_queues)-1:0]  rx_dma_descr_ptr_par;
   output         rx_dma_descr_ptr_tog;   // handshake for rx_dma_descr_ptr
   output   [3:0] rx_dma_int_queue;    // Identifies which queue the interupt is destined
   output   [3:0] ahb_queue_ptr_rx;    // Identifies which queue
   output   [3:0] queue_ptr_rx_aph;    // Early version of queue

   // Specific outputs to support Priority Queues
   output       [p_edma_queues-1:0] rx_databuf_wr_q;

     // 64b addressing support and extended BD from reg_top
   input  [31:0] upper_rx_q_base_addr; // upper 32b base address for all buffer descriptors
   input   [3:0] upper_rx_q_base_par;
   input         dma_addr_bus_width;

   input                            rx_bd_extended_mode_en;  // enable extended BD mode, which is used to Descriptor TS insertion
   input                      [1:0] rx_bd_ts_mode;

   // Timestamp for current rx packet
   input                     [41:0] rx_timestamp;

   // RAS - Timestamp parity protection
   input                      [5:0] rx_timestamp_prty; // RAS - parity protection for the RX Timestamp[41:0] to DMA Descriptor

   // PTP frame decoded signals
   input                            sof_rx;                  // asserted on SFD deasserted at EOF
   input                            event_frame_rx;          // sync/delay_req/pdelay_req/pdelay_resp frames
   input                            general_frame_rx;        // PTP frame which is not an event frame

   // lockup detection
   output [p_edma_rx_pbuf_addr-1:0] dpram_fill_lvl; // Fill level for all queues
   output                           rx_edma_overflow;

   // ASF - Parity errors
   output                           asf_dap_rx_rd_err;
   output                           asf_dap_rx_wr_err;

   // RSC specific signals to AXI block
   output  [p_edma_addr_width-1:0] next_buffer_start_add;
   output  [p_edma_addr_pwid-1:0]  next_buffer_start_add_par;
   output                          host_update_buf_add;
   output                          rsc_coalescing_ended;
   output  [15:0]                  rsc_write_strobe;
   output  [3:0]                   queue_ptr_rx_mod;

   // Memory Update interface
   output                          rsc_update_valid;
   input                           rsc_update_ready;
   output                          rsc_update_descr;
   output                          rsc_update_last;
   output  [p_edma_addr_width-1:0] rsc_update_addr;
   output  [p_edma_addr_pwid-1:0]  rsc_update_addr_par;
   output  [31:0]                  rsc_update_data;
   output  [3:0]                   rsc_update_data_par;
   output  [15:0]                  rsc_update_ben;

   // Signals going to rx-rd module for per-queue rx flushing
   input  [(16*p_edma_queues)-1:0] max_val_pclk;
   input       [p_edma_queues-1:0] limit_num_bytes_allowed_ambaclk;
   output      [p_edma_queues-1:0] fill_lvl_breached;

   wire           pkt_captured;
   wire [3:0]     num_pkts_xfer;
   wire [p_edma_rx_pbuf_addr-1:0] pkt_done_dplocns;
   wire           pkt_done_capt_tog;
   wire           end_of_packet_tog;
   wire           part_of_packet_tog;
   wire [3:0]     part_of_packet_queue_ptr;
   wire [30:0]    part_of_packet_fld_offsets;
   wire           pkt_done_tog;

  wire                            mac_hbusreq_descr;
  wire                            update_databuf_add;
  wire                            write_to_base_descr;
  wire                            mac_in_header;
  wire                            mac_hbusreq_descr_rd;
  wire                            mac_hbusreq_descr_wr;
  wire                            mac_hlock_descr;
  wire   [p_edma_addr_width-1:0]  mac_haddr_descr;
  wire   [p_edma_addr_pwid-1:0]   mac_haddr_descr_par;
  wire   [1:0]                    mac_htrans_descr;
  wire                            mac_hwrite_descr;
  wire   [2:0]                    mac_hsize_descr;
  wire   [2:0]                    mac_hburst_descr;
  wire   [3:0]                    mac_hprot_descr;
  wire   [127:0]                  mac_hwdata_descr;
  wire   [15:0]                   mac_hwdata_descr_par;
  wire                            mac_hbusreq_data;
  wire                            mac_hlock_data;
  wire   [p_edma_addr_width-1:0]  mac_haddr_data;
  wire   [p_edma_addr_pwid-1:0]   mac_haddr_data_par;
  wire   [1:0]                    mac_htrans_data;
  wire                            mac_hwrite_data;
  wire   [2:0]                    mac_hsize_data;
  wire   [2:0]                    mac_hburst_data;
  wire   [3:0]                    mac_hprot_data;
  wire   [127:0]                  mac_hwdata_data;
  wire   [15:0]                   mac_hwdata_data_par;
  wire                            mac_hgrant_descr;
  wire                            mac_hgrant_data;
  wire                            mac_hready;
  wire   [1:0]                    mac_hresp;
  wire   [p_edma_bus_width-1:0]   mac_hrdata;
  wire   [p_edma_bus_pwid-1:0]    mac_hrdata_par;
  wire                            last_data_to_buff_mac;
  wire [127:0]                    mac_hrdata_pad;
  wire  [15:0]                    mac_hrdata_par_pad;

  wire   [11:0]                   pld_offset;        // payload offset in Bytes
  wire   [11:0]                   l4_offset;         // L4 Offset in Bytes
  wire   [4:0]                    l3_offset;         // L4 Offset in Bytes
  wire                            rx_dma_err;        // DMA state machine error

  wire  [13:0]                    full_pkt_size_dma;
  wire                            rsc_stop_from_dma; // Set if any of the SYN/FIN/RST/URG
                                                     // flags are set in the TCP header, or
                                                     // if the seqnum shows a frame has been
                                                     // lost. valid before descriptor
                                                     // fetch.
  wire                            rsc_push_from_dma; // Set if the PSH flag was set in the TCP header
  wire                            rsc_first_frame;
  wire  [3:0]                     queue_ptr_rx_aph;
  wire  [1:0]                     dma_buffer_offset;


   // -----------------------------------------------------------------------
   //
   //               Cutthru status word FIFO
   //
   // -----------------------------------------------------------------------

  parameter p_ct_fifo_sw = (p_edma_tsu == 1) ? 128 : 96;
  parameter p_ct_fifo_pw = p_ct_fifo_sw/8;

  wire [p_edma_rx_pbuf_addr+p_ct_fifo_sw-1:0]
                            cutthru_status_word;
  wire [p_ct_fifo_pw-1:0]   cutthru_status_word_par;
  wire [p_edma_rx_pbuf_addr+p_ct_fifo_sw-1:0]
                            cutthru_status_word_valid;
  wire [p_ct_fifo_pw-1:0]   cutthru_status_word_par_valid;
  wire                      cutthru_status_word_pop;
  wire                      cutthru_status_word_push;
  wire                      cutthru_status_word_pop_empty;

  generate
  if (p_edma_bus_width < 32'd128) begin : gen_hrdata_pad
    assign mac_hrdata_pad     = {{(128-p_edma_bus_width){1'b0}},mac_hrdata};
    assign mac_hrdata_par_pad = {{(16-p_edma_bus_pwid){1'b0}},mac_hrdata_par};
  end else begin : gen_no_hrdata_pad
    assign mac_hrdata_pad     = mac_hrdata;
    assign mac_hrdata_par_pad = mac_hrdata_par;
  end

  if (p_edma_pbuf_cutthru == 1) begin : gen_cutthru
    localparam p_ct_fifo_w = (p_edma_asf_dap_prot == 1)  ? p_edma_rx_pbuf_addr + p_ct_fifo_sw + p_ct_fifo_pw
                                                         : p_edma_rx_pbuf_addr + p_ct_fifo_sw;

   wire  [p_ct_fifo_w-1:0] ct_fifo_in;
   wire  [p_ct_fifo_w-1:0] ct_fifo_out;

   edma_gen_async_fifo #(

      .ADDR_W(0),
      .DATA_W(p_ct_fifo_w)

   ) i_edma_gen_async_fifo_cutthru_status_words (

      .clk_push     (rx_clk),
      .rst_push_n   (n_rxreset),
      .push         (cutthru_status_word_push),
      .pushd        (ct_fifo_in),
      .push_full    (),
      .push_size    (),
      .push_overflow(),

      .clk_pop      (hclk),
      .rst_pop_n    (n_hreset),
      .pop          (cutthru_status_word_pop),
      .popd         (ct_fifo_out),
      .pop_empty    (cutthru_status_word_pop_empty),
      .pop_size     (),
      .pop_underflow()
    );

    if (p_edma_asf_dap_prot == 1) begin : gen_has_par
      assign ct_fifo_in                    = {cutthru_status_word_par,cutthru_status_word};
      assign cutthru_status_word_par_valid = ct_fifo_out[p_ct_fifo_w-1:p_ct_fifo_w-p_ct_fifo_pw] &
                                              {p_ct_fifo_pw{~cutthru_status_word_pop_empty}};
    end else begin : gen_has_no_par
      assign ct_fifo_in                    = cutthru_status_word;
      assign cutthru_status_word_par_valid = {p_ct_fifo_pw{1'b0}};
    end

   assign cutthru_status_word_valid     = ct_fifo_out[p_edma_rx_pbuf_addr+p_ct_fifo_sw-1:0] &
                                          {(p_edma_rx_pbuf_addr+p_ct_fifo_sw){~cutthru_status_word_pop_empty}};

  end else begin : gen_no_cutthru
   assign cutthru_status_word_valid     = {(p_edma_rx_pbuf_addr+p_ct_fifo_sw){1'b0}};
   assign cutthru_status_word_par_valid = {p_ct_fifo_pw{1'b0}};
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

   wire [p_edma_queues-1:0] rx_databuf_wr_q;

   edma_pbuf_rx_wr #(

    .grouped_params(grouped_params)

    ) i_edma_pbuf_rx_wr (

      // global clk & reset.
      .rx_clk                  (rx_clk),
      .n_rxreset               (n_rxreset),

      // inputs coming configuration registers (assumed static)
      .rx_pbuf_size            (rx_pbuf_size),
      .dma_bus_width           (mac_bus_width),
      .enable_receive          (enable_receive),
      .rx_cutthru_threshold    (rx_cutthru_threshold),
      .rx_cutthru              (rx_cutthru),
      .rx_toe_enable           (rx_toe_enable),

      // signals coming from gem_mac (gem_rx - fifo interface).
      .rx_w_wr                 (rx_w_wr),
      .rx_w_data               (rx_w_data),
      .rx_w_data_par           (rx_w_data_par),
      .rx_w_sop                (rx_w_sop),
      .rx_w_eop                (rx_w_eop),
      .rx_w_err                (rx_w_err),

      // Delay the handshake between the MAC and the REG block, so
      // that stats are updated at the correct time
      // 'rx_end_tog' comes from the mac to indicate
      // the stats are valid
      // 'rx_status_wr_tog' is sent back to the MAC to indicate
      // the pkt buffer has captured the stats from the MAC
      .rx_end_tog           (rx_end_tog),
      .rx_status_wr_tog     (rx_status_wr_tog),

      // inputs coming from the gem_mac (gem_rx - DMA status)
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

      .dbuff_overflow          (dbuff_overflow),

      // Outputs going to DPSRAM port A (write)
      .rxdpram_ena             (rxdpram_ena),
      .rxdpram_wea             (rxdpram_wea),
      .rxdpram_addra           (rxdpram_addra),
      .rxdpram_dia             (rxdpram_dia),
      .rxdpram_dia_par         (rxdpram_dia_par),

      // Output handshake controls for clock domain toggles (to gem_rx)
      .dma_rx_status_tog       (dma_rx_status_tog),

      // handshake signals with RD side of PKTBUFFER
      .end_of_packet_tog       (end_of_packet_tog),
      .part_of_packet_tog      (part_of_packet_tog),
      .part_of_packet_queue_ptr(part_of_packet_queue_ptr),
      .part_of_packet_fld_offsets(part_of_packet_fld_offsets),
      .num_pkts_xfer           (num_pkts_xfer),
      .pkt_captured            (pkt_captured),

      .pkt_done_tog            (pkt_done_tog),
      .pkt_done_dplocns        (pkt_done_dplocns),
      .pkt_done_capt_tog       (pkt_done_capt_tog),

      // Outputs going to gem_mac (gem_rx - fifo interface)
      .rx_w_overflow           (rx_w_overflow),

      .queue_ptr_rx            (queue_ptr_rx),

      .rsc_en                  (rsc_en),
      .rsc_stop                (rsc_stop),
      .rsc_push                (rsc_push),
      .tcp_seqnum              (tcp_seqnum),
      .tcp_syn                 (tcp_syn),
      .tcp_payload_len         (tcp_payload_len),

      // enhanced TS enables
      .rx_bd_extended_mode_en  (rx_bd_extended_mode_en),
      .rx_bd_ts_mode           (rx_bd_ts_mode),

      // Timestamp for current rx packet
      .rx_timestamp            (rx_timestamp),

      // RAS - Timestamp parity protection
      .rx_timestamp_prty       (rx_timestamp_prty),

      // PTP decoded signals
      .sof_rx                  (sof_rx),
      .event_frame_rx          (event_frame_rx),
      .general_frame_rx        (general_frame_rx),

      .cutthru_status_word     (cutthru_status_word),
      .cutthru_status_word_par (cutthru_status_word_par),
      .cutthru_status_word_push(cutthru_status_word_push),

      // Debug
      .dpram_fill_lvl          (dpram_fill_lvl),

      // ASF - signals going to gem_reg_top
      .asf_dap_rx_wr_err       (asf_dap_rx_wr_err),
      .edma_overflow           (rx_edma_overflow)
 );

edma_pbuf_rx_rd #(
     .grouped_params(grouped_params)
   ) i_edma_pbuf_rx_rd (

  .hclk                      (hclk),
  .n_hreset                  (n_hreset),

  .rx_cutthru_threshold      (rx_cutthru_threshold),
  .rx_cutthru                (rx_cutthru),
  .dma_bus_width             (dma_bus_width),
  .force_max_ahb_burst_rx    (force_max_ahb_burst_rx),
  .hdr_data_splitting_en     (hdr_data_splitting_en),
  .infinite_last_dbuf_size_en(infinite_last_dbuf_size_en),

  .end_of_packet_tog         (end_of_packet_tog),
  .part_of_packet_tog        (part_of_packet_tog),
  .part_of_packet_queue_ptr  (part_of_packet_queue_ptr),
  .part_of_packet_fld_offsets(part_of_packet_fld_offsets),
  .num_pkts_xfer             (num_pkts_xfer),
  .pkt_captured              (pkt_captured),

  .pkt_done_tog              (pkt_done_tog),
  .pkt_done_capt_tog         (pkt_done_capt_tog),
  .pkt_done_dplocns          (pkt_done_dplocns),

  .rxdpram_enb               (rxdpram_enb),
  .rxdpram_web               (rxdpram_web),
  .rxdpram_addrb             (rxdpram_addrb),
  .rxdpram_dob               (rxdpram_dob),
  .rxdpram_dob_par           (rxdpram_dob_par),

  .enable_rx_hclk            (enable_rx_hclk),
  .new_rx_q_ptr_pulse        (new_rx_q_ptr_pulse),
  .rx_stat_capt_pulse        (rx_stat_capt_pulse),
  .flush_rx_pkt_hclk         (flush_rx_pkt_hclk),

  .dma_addr_or_mask          (dma_addr_or_mask),
  .rx_dma_descr_base_addr    (rx_dma_descr_base_addr),
  .rx_dma_descr_base_par     (rx_dma_descr_base_par),
  .rx_dma_buffer_size        (rx_dma_buffer_size),
  .rx_dma_buffer_offset      (dma_buffer_offset),
  .ahb_burst_length          (ahb_burst_length),
  .rx_no_crc_check           (rx_no_crc_check),
  .jumbo_enable              (jumbo_enable),
  .crc_error_report          (crc_error_report),
  .force_discard_on_err      (force_discard_on_err),
  .force_discard_on_err_q    (force_discard_on_err_q),
  .endian_swap               (endian_swap),
  .restart_trigger           (restart_trigger),

  .status_word1_capt         (status_word1_capt),
  .last_buff_req_dph         (last_data_to_buff_mac),
  .full_pkt_size             (full_pkt_size_dma),
  .from_rx_dma_used_bit_read (from_rx_dma_used_bit_read),
  .rx_descr_ptr_reset        (rx_descr_ptr_reset),
  .from_rx_dma_queue_ptr     (from_rx_dma_queue_ptr),
  .new_descr_fetch_trig      (new_descr_fetch_trig),
  .part_pkt_written          (part_pkt_written),
  .from_rx_dma_buff_depth    (from_rx_dma_buff_depth),

  // Signals going to AHB
  // RX Descriptor Master outputs
  // Specific for RSC
  .hbusreq_descr_rd          (mac_hbusreq_descr_rd),
  .hbusreq_descr_wr          (mac_hbusreq_descr_wr),
  .in_header                 (mac_in_header),
  .write_to_base_descr       (write_to_base_descr),
  .update_databuf_add        (update_databuf_add),
  .rsc_en                    (|rsc_en),
  .rsc_first_frame           (rsc_first_frame),
  .hbusreq_descr             (mac_hbusreq_descr),
  .hlock_descr               (mac_hlock_descr),
  .hburst_descr              (mac_hburst_descr),
  .htrans_descr              (mac_htrans_descr),
  .hsize_descr               (mac_hsize_descr),
  .hwrite_descr              (mac_hwrite_descr),
  .hprot_descr               (mac_hprot_descr),
  .haddr_descr               (mac_haddr_descr),
  .haddr_descr_par           (mac_haddr_descr_par),
  .hwdata_descr              (mac_hwdata_descr),
  .hwdata_descr_par          (mac_hwdata_descr_par),
  // RX DATA Master outputs
  .hbusreq_data              (mac_hbusreq_data),
  .hlock_data                (mac_hlock_data),
  .hburst_data               (mac_hburst_data),
  .htrans_data               (mac_htrans_data),
  .hsize_data                (mac_hsize_data),
  .hwrite_data               (mac_hwrite_data),
  .hprot_data                (mac_hprot_data),
  .haddr_data                (mac_haddr_data),
  .haddr_data_par            (mac_haddr_data_par),
  .hwdata_data               (mac_hwdata_data),
  .hwdata_data_par           (mac_hwdata_data_par),

  // Signals coming from AHB
  .hgrant_descr              (mac_hgrant_descr),
  .hgrant_data               (mac_hgrant_data),
  .hready                    (mac_hready),
  .hresp                     (mac_hresp),
  .hrdata                    (mac_hrdata_pad),
  .hrdata_par                (mac_hrdata_par_pad),

  // Interrupt status bits for the register block ...
  .rx_dma_stable_tog         (rx_dma_stable_tog),
  .rx_dma_buff_not_rdy       (rx_dma_buff_not_rdy),
  .rx_dma_complete_ok        (rx_dma_complete_ok),
  .rx_dma_resource_err       (rx_dma_resource_err),
  .rx_dma_hresp_notok        (rx_dma_hresp_notok),
  .rx_dma_descr_ptr          (rx_dma_descr_ptr),
  .rx_dma_descr_ptr_par      (rx_dma_descr_ptr_par),
  .rx_dma_descr_ptr_tog      (rx_dma_descr_ptr_tog),

  .rx_dma_int_queue          (rx_dma_int_queue),
  .ahb_queue_ptr_rx          (ahb_queue_ptr_rx),
  .queue_ptr_rx_aph          (queue_ptr_rx_aph),
  .l3_offset                 (l3_offset),
  .l4_offset                 (l4_offset),
  .pld_offset                (pld_offset),
  .rx_dma_err                (rx_dma_err),

  // Indicate to reg block that the stats are ready for
  // capturing
  .rx_pkt_end_tog            (rx_pkt_end_tog),
  .rx_pkt_status_wr_tog      (rx_pkt_status_wr_tog),

  // Priorty Queues
  .rx_databuf_wr_q           (rx_databuf_wr_q),

  // Stats going to the register block ...
  .rx_dma_pkt_flushed        (rx_dma_pkt_flushed),

  // 64b addressing
  .upper_rx_q_base_addr      (upper_rx_q_base_addr),
  .upper_rx_q_base_par       (upper_rx_q_base_par),
  .dma_addr_bus_width        (dma_addr_bus_width),

  .cutthru_status_word       (cutthru_status_word_valid),
  .cutthru_status_word_par   (cutthru_status_word_par_valid),
  .cutthru_status_word_pop   (cutthru_status_word_pop),
  .cutthru_status_word_empty (cutthru_status_word_pop_empty),

  .rsc_stop_from_dma         (rsc_stop_from_dma),
  .rsc_push_from_dma         (rsc_push_from_dma),

  .rx_bd_extended_mode_en    (rx_bd_extended_mode_en),

   // lockup detection

   // RAS - signals going to gem_reg_top
  .asf_dap_rx_rd_err        (asf_dap_rx_rd_err),

   // Signals going to edma_pbuf_rx_rd for per-queue rx flush
  .max_val_pclk                    (max_val_pclk),
  .limit_num_bytes_allowed_ambaclk (limit_num_bytes_allowed_ambaclk),
  .fill_lvl_breached               (fill_lvl_breached)

  );


generate if (p_edma_rsc == 1) begin : gen_rsc_module

  wire  [13:0] full_pkt_size_rsc;
  wire   [3:0] rsc_buffer_offset;
  wire  [15:0] rsc_en_int;

  assign rsc_en_int = {rsc_en,1'b0};

  edma_pbuf_rx_rsc   #(
                      .p_edma_addr_width(p_edma_addr_width),
                      .p_edma_bus_width(p_edma_bus_width),
                      .p_edma_queues(p_edma_queues)
                      ) i_edma_pbuf_rx_rsc (

    .hclk                      (hclk),
    .n_hreset                  (n_hreset),

    .mac_hbusreq_descr_rd      (mac_hbusreq_descr_rd),
    .mac_hbusreq_descr_wr      (mac_hbusreq_descr_wr),
    .mac_in_header             (mac_in_header),
    .mac_hlock_descr           (mac_hlock_descr),
    .mac_haddr_descr           (mac_haddr_descr),
    .mac_htrans_descr          (mac_htrans_descr),
    .mac_hwrite_descr          (mac_hwrite_descr),
    .mac_hsize_descr           (mac_hsize_descr),
    .mac_hburst_descr          (mac_hburst_descr),
    .mac_hprot_descr           (mac_hprot_descr),
    .mac_hwdata_descr          (mac_hwdata_descr),
    .mac_hbusreq_data          (mac_hbusreq_data),
    .mac_hlock_data            (mac_hlock_data),
    .mac_haddr_data            (mac_haddr_data),
    .mac_htrans_data           (mac_htrans_data),
    .mac_hwrite_data           (mac_hwrite_data),
    .mac_hsize_data            (mac_hsize_data),
    .mac_hburst_data           (mac_hburst_data),
    .mac_hprot_data            (mac_hprot_data),
    .mac_hwdata_data           (mac_hwdata_data),
    .mac_hgrant_descr          (mac_hgrant_descr),
    .mac_hgrant_data           (mac_hgrant_data),
    .mac_hready                (mac_hready),
    .mac_hresp                 (mac_hresp),
    .mac_hrdata                (mac_hrdata),

    .host_hbusreq_descr        (hbusreq_descr),
    .host_hlock_descr          (hlock_descr),
    .host_haddr_descr          (haddr_descr),
    .host_htrans_descr         (htrans_descr),
    .host_hwrite_descr         (hwrite_descr),
    .host_hsize_descr          (hsize_descr),
    .host_hburst_descr         (hburst_descr),
    .host_hprot_descr          (hprot_descr),
    .host_hwdata_descr         (hwdata_descr),
    .write_to_base_descr       (write_to_base_descr),
    .host_hbusreq_data         (hbusreq_data),
    .host_hlock_data           (hlock_data),
    .host_haddr_data           (haddr_data),
    .host_htrans_data          (htrans_data),
    .host_hwrite_data          (hwrite_data),
    .host_hsize_data           (hsize_data),
    .host_hburst_data          (hburst_data),
    .host_hprot_data           (hprot_data),
    .host_hwdata_data          (hwdata_data),
    .host_hgrant_descr         (hgrant_descr),
    .host_hgrant_data          (hgrant_data),
    .host_hready               (hready),
    .host_hresp                (hresp),
    .host_hrdata               (hrdata),
    .next_buffer_start_add     (next_buffer_start_add),
    .host_update_buf_add       (host_update_buf_add),
    .rsc_coalescing_ended      (rsc_coalescing_ended),
    .queue_ptr_rx_mod          (queue_ptr_rx_mod),
    .jumbo_enable              (jumbo_enable),
    .jumbo_max_length          (jumbo_max_length),

    .rsc_update_valid          (rsc_update_valid),
    .rsc_update_ready          (rsc_update_ready),
    .rsc_update_descr          (rsc_update_descr),
    .rsc_update_last           (rsc_update_last),
    .rsc_update_addr           (rsc_update_addr),
    .rsc_update_data           (rsc_update_data),
    .rsc_update_ben            (rsc_update_ben),

    .update_databuf_add        (update_databuf_add),
    .last_data_to_buff_mac     (last_data_to_buff_mac),
    .last_data_to_buff_rsc     (last_data_to_buff_dph),
    .full_pkt_size_in          (full_pkt_size_dma),
    .full_pkt_size_out         (full_pkt_size_rsc),
    .rsc_write_strobe          (rsc_write_strobe),
    .mac_buffer_offset         (rsc_buffer_offset),
    .dma_bus_width             (dma_bus_width),
    .enable_rx_hclk            (enable_rx_hclk),
    .rsc_en                    (rsc_en_int[p_edma_queues-1:0]),
    .rsc_stop                  (rsc_stop_from_dma),
    .rsc_push                  (rsc_push_from_dma),
    .ahb_queue_ptr_rx          (queue_ptr_rx_aph),
    .l3_offset                 (l3_offset),
    .l4_offset                 (l4_offset),
    .pld_offset                (pld_offset),
    .rx_dma_err                (rx_dma_err),
    .first_frame               (rsc_first_frame),
    .rsc_clr_tog               (rsc_clr_tog)
  );


  // when RSC is configured, the offset comes from the RSC module ...
  // I.e. the register version is ignored.
  assign dma_buffer_offset  = rsc_buffer_offset[1:0];
  assign full_pkt_size      = full_pkt_size_rsc;

  // Generate parity for the following RSC signals. Future IMPRV.
  // This is for compatibility of ASF data/address path parity
  // protection however note that the RSC module is NOT protected!
  // This is not within current ASF scope and should be accounted
  // for during FMEDA.
  if (p_edma_asf_dap_prot == 1) begin : gen_rsc_par
    cdnsdru_asf_parity_gen_v1 #(
      .p_data_width (p_edma_bus_width+p_edma_addr_width+
                      p_edma_addr_width+p_edma_addr_width+
                      128+128+p_edma_addr_width+32)
    ) i_par_gen (
      .odd_par    (1'b0),
      .data_in    ({mac_hrdata,
                    haddr_descr,
                    haddr_data,
                    next_buffer_start_add,
                    hwdata_descr,
                    hwdata_data,
                    rsc_update_addr,
                    rsc_update_data}),
      .data_out   (),
      .parity_out ({mac_hrdata_par,
                    haddr_descr_par,
                    haddr_data_par,
                    next_buffer_start_add_par,
                    hwdata_descr_par,
                    hwdata_data_par,
                    rsc_update_addr_par,
                    rsc_update_data_par})
    );
  end else begin : gen_no_rsc_par
    assign mac_hrdata_par             = {p_edma_bus_pwid{1'b0}};
    assign haddr_descr_par            = {p_edma_addr_pwid{1'b0}};
    assign haddr_data_par             = {p_edma_addr_pwid{1'b0}};
    assign next_buffer_start_add_par  = {p_edma_addr_pwid{1'b0}};
    assign hwdata_descr_par           = 16'h0000;
    assign hwdata_data_par            = 16'h0000;
    assign rsc_update_addr_par        = {p_edma_addr_pwid{1'b0}};
    assign rsc_update_data_par        = 4'h0;
  end

end else begin : gen_no_rsc
  assign last_data_to_buff_dph = last_data_to_buff_mac;
  assign hbusreq_descr         = mac_hbusreq_descr;
  assign hlock_descr           = mac_hlock_descr;
  assign haddr_descr           = mac_haddr_descr;
  assign haddr_descr_par       = mac_haddr_descr_par;
  assign htrans_descr          = mac_htrans_descr;
  assign hwrite_descr          = mac_hwrite_descr;
  assign hsize_descr           = mac_hsize_descr;
  assign hburst_descr          = mac_hburst_descr;
  assign hprot_descr           = mac_hprot_descr;
  assign hwdata_descr          = mac_hwdata_descr;
  assign hwdata_descr_par      = mac_hwdata_descr_par;
  assign hbusreq_data          = mac_hbusreq_data;
  assign hlock_data            = mac_hlock_data;
  assign haddr_data            = mac_haddr_data;
  assign haddr_data_par        = mac_haddr_data_par;
  assign htrans_data           = mac_htrans_data;
  assign hwrite_data           = mac_hwrite_data;
  assign hsize_data            = mac_hsize_data;
  assign hburst_data           = mac_hburst_data;
  assign hprot_data            = mac_hprot_data;
  assign hwdata_data           = mac_hwdata_data;
  assign hwdata_data_par       = mac_hwdata_data_par;
  assign mac_hgrant_descr      = hgrant_descr;
  assign mac_hgrant_data       = hgrant_data;
  assign mac_hready            = hready;
  assign mac_hresp             = hresp;
  assign mac_hrdata            = hrdata;
  assign mac_hrdata_par        = hrdata_par;
  assign update_databuf_add    = 1'b1;
  assign rsc_first_frame       = 1'b1;
  assign host_update_buf_add   = 1'b0;
  assign next_buffer_start_add      = {p_edma_addr_width{1'b0}};
  assign next_buffer_start_add_par  = {p_edma_addr_pwid{1'b0}};
  assign rsc_update_valid      = 1'b0;
  assign rsc_update_descr      = 1'b0;
  assign rsc_update_last       = 1'b0;
  assign rsc_update_addr       = {p_edma_addr_width{1'b0}};
  assign rsc_update_addr_par   = {p_edma_addr_pwid{1'b0}};
  assign rsc_update_data       = 32'd0;
  assign rsc_update_data_par   = 4'h0;
  assign rsc_update_ben        = 16'h0000;
  assign rsc_coalescing_ended  = 1'b0;
  assign rsc_write_strobe      = 16'd0;
  assign queue_ptr_rx_mod      = 4'h0;
  assign rsc_clr_tog           = {p_edma_queues{1'b0}};
  assign dma_buffer_offset     = rx_dma_buffer_offset;
  assign full_pkt_size         = full_pkt_size_dma;

end
endgenerate


endmodule


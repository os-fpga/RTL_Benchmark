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
//   Filename:           edma_pbuf_rx_rd.v
//   Module Name:        edma_pbuf_rx_rd
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
//   Description :
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module edma_pbuf_rx_rd (

 // Inputs

 // global clk & reset
   hclk,
   n_hreset,

 // inputs coming configuration registers (assumed static)
   rx_cutthru_threshold,
   rx_cutthru,
   dma_bus_width,                  // Programmed size of AHB bus
   ahb_burst_length,
   endian_swap,
   force_max_ahb_burst_rx,

 // Interface from write side of packet buffer for identifying that
 // >= 1 pkt has been written into DPRAM
   end_of_packet_tog,
   part_of_packet_tog,
   part_of_packet_queue_ptr,
   part_of_packet_fld_offsets,
   num_pkts_xfer,
   pkt_captured,

 // Interface to write side of packet buffer for identifying that
 // the packet has been written to DPRAM
   pkt_done_tog,
   pkt_done_capt_tog,
   pkt_done_dplocns,

 // DPRAM interface
   rxdpram_enb,
   rxdpram_web,
   rxdpram_addrb,
   rxdpram_dob,
   rxdpram_dob_par,

 // signals coming from the hclk_syncs block
   enable_rx_hclk,                 // reception enabled - rx module operating
   flush_rx_pkt_hclk,              // flush next packet if idle
   new_rx_q_ptr_pulse,             // buffer queue base address updated
   rx_stat_capt_pulse,             // dma_rx status has been captured

 // signals coming from the register block
   dma_addr_or_mask,               // OR mask for data buf accesses
   rx_dma_descr_base_addr,         // buffer queue (descriptor list) base addr
   rx_dma_descr_base_par,
   rx_dma_buffer_size,             // buffer depth (in x64 bytes)
   rx_dma_buffer_offset,           // offset of the data from buffer beginning
   rx_no_crc_check,                // Ignore RX FCS check
   jumbo_enable,                   // Enable jumbo frames
   crc_error_report,               // Enable jumbo frame length reporting
   force_discard_on_err,
   force_discard_on_err_q,
   restart_trigger,                // restart RX descriptor read
   hdr_data_splitting_en,
   infinite_last_dbuf_size_en,     // data buffer pointed to by last descriptor is infinite size
   rsc_en,

   // AHB Inputs
   hgrant_descr,
   hgrant_data,
   hready,
   hresp,
   hrdata,
   hrdata_par,

   // RX Descriptor AHB Outputs
   hbusreq_descr_rd,      // Needed for RSC only
   hbusreq_descr_wr,      // Needed for RSC only
   in_header,             // Needed for RSC only
   write_to_base_descr,   // Needed for RSC only
   rsc_first_frame,
   update_databuf_add,
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
   ahb_queue_ptr_rx,               // Priority Queue Number
   queue_ptr_rx_aph,
   pld_offset,
   l4_offset,
   l3_offset,
   rx_dma_err,

   rsc_stop_from_dma,              // Set if any of the SYN/FIN/RST/URG
                                   // flags are set in the TCP header, or
                                   // if the seqnum shows a packet has been
                                   // dropped
   rsc_push_from_dma,              // Set if the PSH flag was set

  // Indicate to reg block that a stats are ready for capturing
   rx_pkt_end_tog,                  // Stats are ready for capturing
   rx_pkt_status_wr_tog,            // Reg block has captured the stats

   // Specific inputs to support Priority Queues
   rx_databuf_wr_q,

   // AXI specific ports
   last_buff_req_dph,
   status_word1_capt,
   full_pkt_size,
   rx_descr_ptr_reset,
   from_rx_dma_used_bit_read,
   from_rx_dma_queue_ptr,
   from_rx_dma_buff_depth,
   new_descr_fetch_trig,
   part_pkt_written,

 // outputs going to the pclk_syncs (register statistics)
   rx_dma_pkt_flushed,

   // 64b addressing support
   upper_rx_q_base_addr,
   upper_rx_q_base_par,
   dma_addr_bus_width,

   // Cut-thru status word FIFO interface
   cutthru_status_word,
   cutthru_status_word_par,
   cutthru_status_word_pop,
   cutthru_status_word_empty,

   rx_bd_extended_mode_en,

   // lockup detection

   // ASF - signals going to gem_reg_top
   asf_dap_rx_rd_err,

   // Signals for per-queue rx flush
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
       32'd0, // p_edma_tx_pbuf_queue_segment_size
       32'd64,// p_emac_bus_width
       32'd64,// p_edma_bus_width
       32'd32,// p_edma_addr_width
       868'd0
   };

  `include "ungroup_params.v"
  parameter p_ct_fifo_sw = (p_edma_tsu == 1) ? 128 : 96;
  parameter p_ct_fifo_pw = p_ct_fifo_sw/8;

 // global clk & reset
   input          n_hreset;            // global reset
   input          hclk;                // global clock

 // inputs coming configuration registers (assumed static)
   input  [p_edma_rx_pbuf_addr-1:0] rx_cutthru_threshold; // Threshold value
   input          rx_cutthru;          // Enable for cut-thru operation
   input   [1:0]  dma_bus_width;       // Programmed size of AHB bus
   input   [4:0]  ahb_burst_length;    // AHB burst length control
   input   [1:0]  endian_swap;         // Endian swap control
   input          force_max_ahb_burst_rx; // Force AHB to issue max len bursts
   input          restart_trigger;     // used to force a restart RX descriptor read
   input          hdr_data_splitting_en; // Header Data Splitting Enable
   input          infinite_last_dbuf_size_en;     // data buffer pointed to by last descriptor is infinite size
   input          rsc_en;


 // Interface with write side of packet buffer
   input          end_of_packet_tog;   // Packet completely written into DPRAM
   input          part_of_packet_tog;  // Part of packet written into DPRAM
   input   [3:0]  part_of_packet_queue_ptr; // Queue pointer for the part of packet
   input   [30:0] part_of_packet_fld_offsets; // pld offset for the part of packet
   input   [3:0]  num_pkts_xfer;       //
   output         pkt_captured;        //
   output         pkt_done_tog;       // Packet has been read from memory
   output[p_edma_rx_pbuf_addr-1:0] pkt_done_dplocns; // Num of dpram locns to clr
   input          pkt_done_capt_tog;  // Handshake

  // Indicate to reg block that a stats are ready for
  // capturing
   output         rx_pkt_end_tog;       // Stats are ready for capturing
   input          rx_pkt_status_wr_tog; // Reg block has captured the stats

    // DPRAM interface
   output         rxdpram_enb;                     // DPRAM Interface
   output         rxdpram_web;                     // DPRAM Interface
   output  [p_edma_rx_pbuf_addr-1:0]  rxdpram_addrb;    // DPRAM Interface
   input   [p_edma_rx_pbuf_data-1:0]  rxdpram_dob;      // DPRAM Interface
   input   [p_edma_rx_pbuf_pwid-1:0]  rxdpram_dob_par;  // DPRAM Interface

 // inputs from AHB
   input           hgrant_descr;
   input           hgrant_data;
   input           hready;
   input   [1:0]   hresp;
   input  [127:0]  hrdata;
   input  [15:0]   hrdata_par;




 // signals coming from the hclk_syncs block
   input          enable_rx_hclk;      // reception enabled
   input          flush_rx_pkt_hclk;   // flush next packet if idle
   input          new_rx_q_ptr_pulse;  // buffer queue base address updated
   input          rx_stat_capt_pulse;  // dma_rx status has been captured

 // signals coming from the register block
   input    [8:0] dma_addr_or_mask;    // data buffer MUX mask
   input [(p_edma_queues*32)-1:0] rx_dma_descr_base_addr; // buffer queue base addr
   input [(p_edma_queues*4)-1:0]  rx_dma_descr_base_par;
   input [(p_edma_queues*8)-1:0] rx_dma_buffer_size;      // buffer depth (in x64 bytes)
   input    [1:0] rx_dma_buffer_offset;    // offset of the data from buffer start
   input          rx_no_crc_check;     // Ignore RX FCS check.
   input          jumbo_enable;        // Enable jumbo packets.
   input          crc_error_report; // Enable jumbo length reporting
   input          force_discard_on_err;// Forces a packet to be flushed from the
                                         // DPRAM when there is an AHB error
   input [p_edma_queues-1:0] force_discard_on_err_q; // force_discard_on_err - queue specific

   // Signals going to rx-rd module for per-queue rx flushing
   input  [(16*p_edma_queues)-1:0] max_val_pclk;
   input       [p_edma_queues-1:0] limit_num_bytes_allowed_ambaclk;
   output reg  [p_edma_queues-1:0] fill_lvl_breached;

//-------------------------------------------
// Ouputs declaration
//-------------------------------------------

   // Following ports are needed for RSC only
   input           update_databuf_add;  // Allows data buffer address to be updated by descriptor read
   output          hbusreq_descr_rd;
   output          hbusreq_descr_wr;
   output          in_header;
   output          write_to_base_descr;
   input           rsc_first_frame;

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

 // outputs doing to the pclk_synch block
   output         rx_dma_stable_tog;   // Toggles to indicate that signals
                                       // going to pclk register are stable
                                       // for sampling
 // outputs going to registers block (pclk) for interrupt generation
   output         rx_dma_buff_not_rdy; // used buffer descriptor read
   output         rx_dma_complete_ok;  // good frame is successfully stored
   output         rx_dma_resource_err; // no buffers available for storage
   output         rx_dma_hresp_notok;  // hresp error during RX DMA
   output [(p_edma_queues*32)-1:0] rx_dma_descr_ptr;    // current buffer descriptor address
   output [(p_edma_queues*4)-1:0]  rx_dma_descr_ptr_par;
   output         rx_dma_descr_ptr_tog;   // handshake for rx_dma_descr_ptr
   output   [3:0] rx_dma_int_queue;    // Identifies which queue the interupt is destined
   output   [3:0] ahb_queue_ptr_rx;    // Priority Queue Number
   output   [3:0] queue_ptr_rx_aph;    // Early Priority Queue Number
   output  [11:0] pld_offset;          // Payload Offset in Bytes
   output  [11:0] l4_offset;           // L4 Offset in Bytes
   output   [4:0] l3_offset;           // L3 Offset in Bytes
   output         rx_dma_err;          // DMA state machine error

   output         rsc_stop_from_dma;  // Set if any of the SYN/FIN/RST/URG
                                      // flags are set in the TCP header, or
                                      // if the seqnum shows a packet has been
                                      // dropped
   output         rsc_push_from_dma;  // Set if the PSH flag was set

 // outputs going to the pclk_syncs (register statistics)
   output         rx_dma_pkt_flushed;  // Frame was dropped due to AHB
                                       // resource error

  // Specific outputs to support Priority Queues
   output [p_edma_queues-1:0] rx_databuf_wr_q;       // Gemstone Flow Control

   // AXI specific ports
   output          last_buff_req_dph;
   output          status_word1_capt;
   output  [13:0]  full_pkt_size;
   output          rx_descr_ptr_reset;
   output          from_rx_dma_used_bit_read;
   output  [3:0]   from_rx_dma_queue_ptr;
   output  [11:0]  from_rx_dma_buff_depth;
   output          new_descr_fetch_trig;
   output          part_pkt_written;

     // 64b addressing support and extended BD from reg_top
   input  [31:0]  upper_rx_q_base_addr; // upper 32b base address for all buffer descriptors
   input  [3:0]   upper_rx_q_base_par;
   input          dma_addr_bus_width;

   input          rx_bd_extended_mode_en; // enable extended BD mode, which is used to Descriptor TS insertion

   input  [p_edma_rx_pbuf_addr+p_ct_fifo_sw-1:0]
                  cutthru_status_word;
   input  [p_ct_fifo_pw-1:0]
                  cutthru_status_word_par;
   output         cutthru_status_word_pop;
   input          cutthru_status_word_empty;

   // lockup detection

   // ASF - signals going to gem_reg_top
   output   asf_dap_rx_rd_err;

  // Widen address for holding parity, this makes things easier for pipelining
  // the optional parity
  parameter p_awid_par  = (p_edma_asf_dap_prot == 1)  ? 36  : 32;

//-------------------------------------------
// Internal signals declaration
//-------------------------------------------

  wire    [7:0] rx_buffer_size_cur;  // Max buffer size based on Queue

  reg           rx_dma_descr_ptr_tog;   // handshake for rx_dma_descr_ptr
  reg     [3:0] rx_dma_int_queue;    // Identifies which queue the interupt is destined
  reg     [3:0] rx_dma_int_q_str;    // Identifies which queue the interupt is destined

  // Main state machine
  reg   [2:0]   rx_dma_state;        // current rx dma state
  reg   [2:0]   nxt_rx_dma_state;    // next rx dma state
  reg   [2:0]   last_rx_dma_state;   // last rx dma state
  wire          rx_dma_state_data;   // storing frame data
  wire          rx_dma_state_man_rd; // reading buffer descriptor
  wire          rx_dma_state_man_wr; // writing buff status in descriptor
  wire          rx_dma_next_man_rd;
  wire          rx_dma_next_man_wr;
  wire          rx_dma_next_data;


  reg   [127:0] rx_dma_data_out;                              // rx dma output data
  wire  [15:0]  rx_dma_data_out_par;                          // parity of rx dma output data
  reg   [p_awid_par-1:0]  rx_dma_burst_addr;                  // rx dma output data
  reg   [p_awid_par-1:0]  nxt_descr_ptr [p_edma_queues-1:0];  // AHB address of next descriptor with optional parity
  wire   [p_awid_par-1:0]  nxt_descr_ptr_pad [15:0];          // AHB address of next descriptor with optional parity
  reg [p_edma_queues-1:0] rx_databuf_wr_q;                    // Gemstone Flow Control
  reg           allow_wr_q;                                   // Flow Control - 1st write indicator

  wire   [3:0]  queue_ptr_rx_aph;           // Priority Queue Number
  wire   [3:0]  queue_ptr_rx_dph;           // Priority Queue Number
  wire   [3:0]  queue_ptr_rx_rph;           // Priority Queue Number

  wire  [35:0]  nxt_descr_ptr_aph_inc;

  reg   [p_awid_par-1:0]  ahb_data_addr;// AHB address of current pkt data
  reg   [31:0]  ahb_data_addr_inc_val;  // Amount to increment for each data write
  wire  [35:0]  ahb_data_addr_incr;     // ahb_data_addr + ahb_data_addr_inc_val with opt parity
  reg    [1:0]  bit3n2data_add_64;      // bits 3 and 2 of data buffer address
  reg           first_buffer_of_pkt;    // Flag identifying the current
                                        // buffer is first within a packet
  reg   [p_awid_par-1:0]  str_descriptor [p_edma_queues-1:0];
  wire  [p_awid_par-1:0]  str_descriptor_pad [15:0];
  wire  [p_awid_par-1:0]  str_descriptor_addr_msk;  // str_descriptor[queue_ptr_rx_dph] with optional mask modification and parity
  wire  [p_awid_par-1:0]  current_descriptor;
  reg   [11:0]  buffer_fill_lvl;
  wire          buffer_available;
  wire          astrobe_manwr_1st;      // 1st addr strobe in man_wr state
  wire          astrobe_manwr_2nd;      // 2nd addr strobe in man_wr state
  wire          astrobe_manwr_3rd;      // 3rd addr strobe in man_wr state
  wire          astrobe_manwr_4th;      // 4th addr strobe in man_wr state
  wire          manwr_rx_dma_addr_1;    // next addr update allowed
  wire          manwr_rx_dma_addr_2;    // next addr update allowed
  wire          manwr_rx_dma_addr_3;    // next addr update allowed
  wire          inc_rx_dma_mux_addr_1;  // update next addr
  wire          inc_rx_dma_mux_addr_2;  // update next addr
  wire          inc_rx_dma_mux_addr_3;  // update next addr
  reg           manwr_astrobe2_en;      // 2nd ahbaddph_strobe in man wr
  reg           manwr_astrobe3_en;      // 3rd ahbaddph_strobe in man wr
  reg           manwr_astrobe4_en;      // 4th ahbaddph_strobe in man wr
  wire          rx_buffer_used_bit;     // buff already used
  reg           hresp_notok_hold;
  reg           rx_eof_written;         // End of Frame written to Buff
  reg           rx_sof_written;         // Start of Frame written to Buff

   // Handshake with Write side of PBUF
   reg          pkt_captured;
   reg          wait_for_pktdone_capt;
   reg          pkt_done_tog;               // Packet has been read from memory
   reg [p_edma_rx_pbuf_addr-1:0]
                pkt_done_dplocns;           // Num of bytes to clear
   reg [p_edma_rx_pbuf_addr-1:0]
                pkt_done_dplocns_nxt;       // Num of bytes to clear
   reg [p_edma_rx_pbuf_addr-1:0]
                pkt_dplocns_str;            // Num of bytes to clear
   reg [p_edma_rx_pbuf_addr-1:0]
                part_dplocns_left;          // Num of words left in part
   reg [p_edma_rx_pbuf_addr-1:0]
                part_dplocns_pending;       // Num of part pkt words that have been transferred
   reg          part_dplocns_pending_for_new_frame;
   wire [p_edma_rx_pbuf_addr-1:0]           // before the frame has started.
                part_dplocns_left_m1;       // Num of words left in part minus 1
   reg  [18:0]  part_dplocns_left_downsize; // Num of words left in part
   wire [18:0]  near_endofpart;             // Near the end of burst
   reg [18:0] near_endofpart_local;
   reg [p_edma_rx_pbuf_addr-1:0]
                part_dplocns;               // Counts number of AHB writes (part)
   reg  [11:0]  pkt_dplocns;                // Counts number of AHB writes (pkt)
   reg          take_stored_value;          // Num of dpram locations
                                            // stored in pkt_dplocns_str maps
                                            // to more than 1 packets worth
   reg   [p_edma_rx_pbuf_addr-1:0]  num_pkts_needing_read; // Number of pkts in buffer
                                            // still needing read
   reg   [p_edma_rx_pbuf_addr-1:0]  num_pkts_needing_read_nxt;
   reg          num_pkts_needing_read_neq_zero_reg; // Number of pkts in buffer is not zero reg
   reg   [7:0]  num_parts_needing_read;     // part of a packet needing read


   wire         new_descr_fetch_trig;    // Trigger to start a descriptor read
   wire         pkt_written_dpram;    // pkt has been written to dpram
   wire         part_pkt_written;     // part of pkt has been written to dpram
   wire         reading_eop_dpram_rph; // Reading the last word of a pkt
   reg          reading_eop_dpram_aph; // EOP of current pkt is being rd
   wire         nxt_pkt_is_err;
   reg    [2:0] dpram_rd_state;
   reg    [2:0] dpram_rd_state_nxt;
   reg    [2:0] last_dpram_rd_state;

   parameter p_sw_wid = (p_edma_asf_dap_prot == 0)  ? 32  : 36;
   reg    [p_sw_wid-1:0] nxt_status_word_1;
   reg    [p_sw_wid-1:0] nxt_status_word_2;
   reg    [p_sw_wid-1:0] nxt_status_word_3;
   reg    [p_sw_wid-1:0] nxt_status_word_4;
   reg    [p_sw_wid-1:0] status_word_1;
   reg    [p_sw_wid-1:0] status_word_2;
   reg    [p_sw_wid-1:0] status_word_3;
   wire   [p_sw_wid-1:0] status_word_4;
   reg           status_word1_capt;
   reg           status_word2_capt;
   reg           status_word3_capt;
   reg           start_reading_at_risk;

   // Interface with Register block for updating STATS
   reg           rx_pkt_end_tog;
   reg           prev_stats_captured;
   reg           last_data_to_buff_rph;
   wire          last_data_to_buff_aph;
   wire          last_buff_req_dph;

   reg           rxdpram_enb;      // DPRAM Interface
   reg           rxdpram_web;      // DPRAM Interface
   reg  [p_edma_rx_pbuf_addr-1:0]  rxdpram_addrb;    // DPRAM Interface
   reg           rxdpram_enb_nxt;  // DPRAM Interface
   reg           rxdpram_web_nxt;  // DPRAM Interface
   reg  [p_edma_rx_pbuf_addr-1:0]  rxdpram_addrb_nxt;// DPRAM Interface
   reg          wait_for_capt;  // Set until status has been captured
   wire         pclk_has_captured_stat;  // Interrupt Status captured by reg
   reg          rx_dma_stable_tog;
   reg          rx_dma_hresp_notok;
   reg          rx_dma_complete_ok;
   reg          rx_dma_buff_not_rdy;
   reg          rx_dma_resource_err;
   reg          rxdpram_enb_d1;      // DPRAM Interface

  wire          ahbreqph_strobe_data;
  wire          ahbaddph_strobe_data;
  wire          ahbdataph_strobe_data;
  reg           ahbaddph_strobe_en_data;
  reg           ahbdataph_strobe_en_data;
  wire          ahbreqph_strobe_descr;
  wire          ahbreqph_strobe_descr_rd;
  wire          ahbaddph_strobe_descr;
  wire          ahbaddph_strobe_descr_rd;
  wire          ahbdataph_strobe_descr;
  wire          ahbdataph_strobe_descr_rd;
  reg           ahbaddph_strobe_en_descr;
  reg           ahbdataph_strobe_en_descr;
  reg           ahbaddph_strobe_en_descr_rd;
  reg           ahbdataph_strobe_en_descr_rd;

  reg           prev_ahbreqph_strobe;
  reg           prev_ahbaddph_strobe;

  wire          hresp_not_ok;
  reg           hresp_notok_eob;
  reg           hresp_notok_eob_rph;
  wire          ahb_err_discard;
  wire          ahb_sf_err;
  wire          ahb_ct_err;
  wire          ahb_err_discard_recover;

  reg           hbusreq;
  reg   [2:0]   hburst;
  reg   [1:0]   htrans;
  wire  [2:0]   hsize;
  reg           hwrite;
  reg   [63:0]  haddr;
  wire  [7:0]   haddr_par;
  reg   [127:0] hwdata;
  wire  [15:0]  hwdata_par; // parity for hwdata
  wire  [1:0]   hresp;
  reg   [3:0]   ahb_access_cnt;
  wire          endofpkt_burst;
  wire          endofbuf_burst;
  wire          endofpart_burst;
  wire          mac_err_vld;
  reg           nxt_mac_err_vld_pending;
  reg           mac_err_vld_pending;
  reg   [13:0]  full_pkt_size;
  reg           rx_descr_ptr_reset;

  wire          endian_swap_now;       // indicates endian swap required
  reg           rd_endian_swap_now;    // endian_swap_now saved for read data
  reg   [1:0]   sel_word_lane;         // detect which word lane is to be used
  reg   [1:0]   rd_enable_word;        // delayed sel_word_lane for data phase
  reg   [127:0] dma_data_out_endian;     // write data after endian swap
  reg   [15:0]  dma_data_out_endian_par; // parity protection for write data after endian swap
  reg   [127:0] dma_data_in_endian;    // read data before endian swap
  reg   [15:0]  dma_data_in_endian_par;
  reg   [127:0] rx_dma_data_in;        // read data output
  reg   [15:0]  rx_dma_data_in_par;
  wire  [35:0]  rx_dma_data_in_w0_p;  // Word 0 with parity
  wire  [35:0]  rx_dma_data_in_w1_p;  // Word 1 with parity
  wire  [35:0]  rx_dma_data_in_w2_p;  // Word 2 with parity
  wire  [p_awid_par-1:0]  rx_dma_data_in_addr_msk;  // Lower 32-bits with optional mask modification and parity
  reg   [7:0]   ahb_burst_maskh;       // address comparison mask upper bits
  wire          breaks_1k_boundary;    // next burst will break 1K AHB bndry
  wire          brk1kbndry_burst;
  reg   [3:0]   bndry1k_acc_size_128;
  reg   [3:0]   bndry1k_acc_size_64;
  reg   [3:0]   bndry1k_acc_size_32;
  wire  [3:0]   bndry1k_acc_size;
  reg           manwr_reqph4_done;
  reg           manwr_reqph3_done;
  reg           manwr_reqph2_done;
  reg           manwr_reqph1_done;
  reg           eop_burst;
  reg   [4:0]   eop_burst_size;
  reg           cutthru_statavail;     // Status is now available - go read it
  reg           cutthru_revertdata;    // Revert back to data state after status
  reg           cutthru_wait4part;     // Waiting for for next part to be ready
  reg           cutthru_wait4part_reg; // Waiting for for next part to be ready
  wire          cutthru_status_word_valid;
  reg  [p_edma_rx_pbuf_addr-1:0]  saved_addr_nxt;// DPRAM Interface
  reg  [p_edma_rx_pbuf_addr-1:0]  saved_addr; // DPRAM Interface
  reg  [p_edma_rx_pbuf_addr-1:0]  saved_start_nxt;// DPRAM Interface
  reg  [p_edma_rx_pbuf_addr-1:0]  saved_start; // DPRAM Interface
  wire [18:0]   pkt_end_addr;         // Packet End address
  reg           last_partpkt_rph;     // reading last word of pkt part
  wire          last_access_burst_req;
  reg           buff_not_rdy_str;
  reg           hresp_notok_str;
  reg           complete_ok_str;
  wire          int_source;
  wire          int_source_rx_comp;

  wire  [127:0] rxdpram_dob_offset;        // 128 bits of Data after offsetting
  wire  [15:0]  rxdpram_dob_par_offset;    // Parity
  wire    [2:0] words_in_residue;
  wire          real_eop_ahb_rph;          // Arbitrated eop indication
  wire          real_eop_ahb_aph;          // Arbitrated eop indication
  wire          real_eop_ahb_dph;          // Arbitrated eop indication
  reg           reading_eop_dpram_rph_del; // Hold off eop indication if it
                                           // exists in the residue buffer
  reg           reading_eop_dpram_aph_del; // Hold off eop indication if it
                                           // exists in the residue buffer

  reg           ahb_err_pktdiscarded_wait4end;
  reg           hresp_data_cutthru;
  reg           part_pkt_written_d1;
  reg           fetch_rem_part;
  wire          dma_addr_or_mask_edge;
  reg   [7:0]   dma_addr_or_mask_hclk;
  wire  [128:0] rxdpram_dob_pad;
  wire  [16:0]  rxdpram_dob_par_pad;
  reg           frame_reading_as_cutthru;



  wire   [(p_edma_queues*32)-1:0]  rx_dma_descr_ptr;       // current buffer descriptor address
  wire          current_wrap_bit_rph;   // Based on curent ptr's str_descriptor
  wire          current_wrap_bit_aph;   // Based on curent ptr's str_descriptor

  reg          early_queue_info_en;
  reg          nxt_early_queue_info_en;
  reg [3:0]    early_queue_info;
  reg [30:0]   early_fld_offset_info;
  reg [30:0]   early_fld_offset_info_nxt;
  reg [30:0]   part_of_packet_fld_offsets_pending; // A part packet is pending for after the full
                                                   // stored frame has been transmitted.
  reg          flush_wait_for_manrd;    // Used to hold pkt_flush input trigger
                                        // until it can safely be acted upon
  wire         flush_next_packet;       // Triggers a packet flush from the PBUF
  reg          rx_dma_pkt_flushed;      // Frame was dropped due to AHB
  reg          padding_rph;             // Padding to end of burst (req phase)
  reg          padding_aph;             // Padding to end of burst (addr phase)

  reg          last_partpkt_rph_seen_at_error_nxt;
  reg          last_partpkt_rph_seen_at_error;

  reg          descriptor_captured;
  reg          ahb_sf_err_hold;
  reg          ahb_sf_err_vld;
  reg          rx_buffer_used_bit_d1;

  wire         [p_edma_bus_width-1:0] rxdpram_dob_downsize;
  wire         [p_edma_bus_pwid-1:0]  rxdpram_dob_downsize_par;
  wire  [127:0] rxdpram_dob_downsize_pad;
  wire  [15:0]  rxdpram_dob_downsize_par_pad;
  reg          rd_downsize;
  reg          flush_downsize;
  wire [2:0]   size_downsize;
  wire         eop_downsize;
  wire         empty_downsize;
  wire [2:0]   num_used_words_downsize;
  reg          have_performed_read_nxt, have_performed_read;
  reg [2:0]    status_word_early_fetch_count, status_word_early_fetch_count_nxt;
  reg          cutthru_status_word_override;
  wire         gem_rx_pbuf_data_w_is_128;

  assign gem_rx_pbuf_data_w_is_128 = p_edma_rx_pbuf_data == 32'd128;


  reg  [2:0]   descr_rd_reqph_cnt;
  reg  [1:0]   descr_rd_addph_cnt;
  reg  [1:0]   descr_rd_dataph_cnt;

  reg  [p_awid_par-1:0]   ahb_data_addr_2;

  wire [63:0]   haddr_descr_int;  // intermediate haddr for descr
  wire  [7:0]   haddr_descr_par_int;

  wire          gem_dma_addr_w_is_64;

  assign gem_dma_addr_w_is_64 = ((p_edma_addr_width == 32'd64) & dma_addr_bus_width);

  wire          descriptor_rd_1_access;
  wire          descriptor_rd_2_access;
  wire [31:0]   next_descr_ptr_inc_val;

  wire [41:0]   rx_timestamp;
  wire  [5:0]   rx_timestamp_par;
  reg           descr_wback_data_bit_2;
  reg           descr_wback_data_bit_46;
  reg           descr_wback_data_bit_49;

  reg  [3:0]    manwr_astrobe_cnt;

  reg   [p_edma_rx_pbuf_data-1:0] rxdpram_dob_reg;
  wire  [p_edma_rx_pbuf_pwid-1:0] rxdpram_dob_par_reg;

  reg status_word_read;
  wire [p_edma_rx_pbuf_data-1:0]  rxdpram_dob_status_muxed;
  wire [p_edma_rx_pbuf_pwid-1:0]  rxdpram_dob_status_par_muxed;

  reg  [11:0]   pld_offset; // Payload Offset in Bytes
  reg  [11:0]   l4_offset; // L4 Offset in Bytes
  reg  [4:0]    l3_offset; // L3 Offset in Bytes
  wire          rx_dma_err;  // DMA state machine error
  wire          descriptor_wr_1_access;
  wire          descriptor_wr_2_access;
  wire          descriptor_wr_4_access;
  wire          astrobe_manwr_last;
  wire          no_data_pending;
  wire          last_buff_req_aph;
  wire          rx_pkt_status_wr_tog_edge;
  wire          pkt_done_capt_tog_edge;

  // Specific signals for RSC
  reg           rsc_stop_from_dma;  // Set if any of the SYN/FIN/RST/URG
                                    // flags are set in the TCP header, or
                                    // if the seqnum shows a packet has been
                                    // dropped
  reg           rsc_push_from_dma;  // Set if the PSH flag was set
  wire          write_to_base_descr; // Data phase timed signal indicating the last write to the descriptor
  wire          rsc_first_frame;
  reg  [10:0] remaining_hdr_bytes;
  reg  [11:0] nxt_remaining_hdr_bytes;
  reg         offset_has_become_available;
  reg         offset_available_capt;
  reg         in_header;
  reg real_eop_ahb_rph_reg;
  reg real_eop_ahb_aph_reg;
  reg real_eop_ahb_dph_reg;

  reg                     force_discard_on_err_queue;
  wire                    force_discard_on_error;

  wire  dap_err_addr_or_mask; // For ASF parity checking

  wire                   [8:0] num_parts_needing_read_c;
  wire [p_edma_rx_pbuf_addr:0] part_dplocns_pending_c;
  reg [16:0] pkt_end_addr_mod, pkt_length_corrected;
  reg [p_edma_rx_pbuf_addr:0] recover_dplocns_err;
  reg [p_edma_rx_pbuf_addr-1:0] pkt_dplocns_to_flush_plus_st;    // Num of locns to recover following a flush, includes status words

  genvar g;
  integer i;

  parameter  NO_OF_MAN_RD_ACCESS = 4'b0001;

  // For 64b addressing we need to read Word 2 so depending on data bus width
  // we will need to perform different no of accesses.
  // For 32b data bus, 2 accesses
  // For 64b or 128b data bus, 2 accesses (need to max at 64b, even in 128b because descriptors are spaced in multiples of 64b)

  // For 32b addressing the original rules still apply.
  // RULE : Always 1 access or 32b addressing
  // RULE : Never breaks 1k boundary, always aligned to 8 byte boundary
  //
  // Insert an IDLE at the end of the 2nd Request phase
  // This is required because the arbiter uses htrans to
  // change master - htrans is an address phase timed signal,
  // while hgrant is request phase

  assign descriptor_rd_1_access = ( ~gem_dma_addr_w_is_64) ;
  assign descriptor_rd_2_access = ( gem_dma_addr_w_is_64) ;

  // set useful signals for identify no if man_wr accesses
  //
  // dma_bus_width       extended_bd_extended_mode_en                no_of_man_wr_accesses
  //
  //     128/64                       0                               one   64 bit access
  //     128/64                       1                               two   64 bit accesses
  //       32                         0                               two   32 bit accesses
  //       32                         1                               four  32 bit accesses

  assign descriptor_wr_1_access = |dma_bus_width & ~rx_bd_extended_mode_en;
  assign descriptor_wr_2_access = ((|dma_bus_width & rx_bd_extended_mode_en) |
                                   (dma_bus_width == 2'b00 &  ~rx_bd_extended_mode_en));
  assign descriptor_wr_4_access = (dma_bus_width == 2'b00 & rx_bd_extended_mode_en);

  // default BD size is 2 words in legacy mode
  // 6 words for ext_bd AND addr64
  // 4 otherwise
  assign next_descr_ptr_inc_val = (~gem_dma_addr_w_is_64 & ~rx_bd_extended_mode_en) ? 32'h00000008 :
                                  ( gem_dma_addr_w_is_64 &  rx_bd_extended_mode_en) ? 32'h00000018 : 32'h00000010 ;


  // build timesatmp from received status words
  generate if (p_edma_tsu == 1) begin : gen_rx_timestamp
    assign rx_timestamp = {status_word_3[31:26],status_word_2[30:29],status_word_2[27],status_word_2[21], status_word_4[31:0]};

    // The timestamp is built from multiple status words so regenerate parity if required
    if (p_edma_asf_dap_prot) begin : gen_ts_par
      gem_par_chk_regen #(.p_chk_dwid(96),.p_new_dwid(42)) i_regen_par (
        .odd_par  (1'b0),
        .chk_dat  ({status_word_3[31:0],status_word_2[31:0],status_word_4[31:0]}),
        .chk_par  ({status_word_3[35:32],status_word_2[35:32],status_word_4[35:32]}),
        .new_dat  (rx_timestamp),
        .dat_out  (),
        .par_out  (rx_timestamp_par),
        .chk_err  ()
      );
    end else begin : gen_no_ts_par
      assign rx_timestamp_par = 6'h00;
    end
  end else begin : gen_no_rx_timestamp
    assign rx_timestamp     = {42{1'b0}};
    assign rx_timestamp_par = 6'h00;
  end
  endgenerate


//-------------------------------------------
// Parameters declaration
//-------------------------------------------

  // Main AHB Access State Machine
  parameter
     RX_DMA_IDLE          = 3'b000,    // RX disabled
     RX_DMA_WAIT_STATUS   = 3'b001,    // wait for rx_buffer_required
     RX_DMA_MAN_RD        = 3'b010,    // Management read
     RX_DMA_DATA_STORE    = 3'b011,    // Data store
     RX_DMA_MAN_WR        = 3'b100;    // Management write

  // DPRAM Access State Machine
  parameter
    P_IDLE              = 3'b000,
    P_STATUS_WORD_1     = 3'b001,
    P_STATUS_WORD_2     = 3'b010,
    P_STATUS_WORD_3     = 3'b011,
    P_STATUS_WORD_4     = 3'b100,
    P_WAIT_FOR_BUFFER   = 3'b101,
    P_PKT_DATA          = 3'b110;


  // If there is a mismatch in the DPRAM data width and the dma bus
  // width (i.e. the DPRAM is 128 wide and the dma bus width is 64) then
  // the downsize block buffers the 128 bit data into two 64 bit words.
  // The downsize block is only needed if ...
  //  1. The output is not 128bits (max)
  //  2. The input is 128bits.
  // If the input is not 128 bits, then we state in the defs file that output must be the same as input

  generate if ((p_emac_bus_width != 32'd128) && (p_edma_rx_pbuf_data == 32'd128))
  begin : gen_edma_pbuf_downsize

    wire  [p_edma_rx_pbuf_prty+p_edma_rx_pbuf_data-1:0] downsize_in;
    wire  [p_edma_parity_width+p_edma_bus_width-1:0]    downsize_out;

    if (p_edma_asf_dap_prot == 1) begin : gen_ds_has_par
      assign downsize_in              = {rxdpram_dob_status_par_muxed,rxdpram_dob_status_muxed};
      assign {rxdpram_dob_downsize_par,
              rxdpram_dob_downsize}   = downsize_out;
    end else begin : gen_no_ds_par
      assign downsize_in  = rxdpram_dob_status_muxed;
      assign rxdpram_dob_downsize     = downsize_out;
      assign rxdpram_dob_downsize_par = {p_edma_bus_pwid{1'b0}};
    end

    edma_pbuf_dpram_width_downsize # (

     .IDATA_W    (p_edma_rx_pbuf_data),
     .IDATA_W_PAR(p_edma_rx_pbuf_prty),
     .ODATA_W    (p_edma_bus_width),
     .ODATA_W_PAR(p_edma_parity_width)

    ) i_edma_pbuf_dpram_width_downsize (

      .clk    (hclk),
      .reset_n(n_hreset),

      .dma_bus_width(dma_bus_width),

      .ird       (rd_downsize),
      .idata     (downsize_in),
      .imod      (status_word_3[3:0]),
      .iflush    (~enable_rx_hclk | flush_downsize),
      .iflush_nxt(1'b0),

      .size       (size_downsize),
      .ord        (),
      .odata      (downsize_out),
      .oempty     (empty_downsize),
      .oempty_next(),
      .oeop       (eop_downsize),
      .oeop_next  ()
    );
   end
   else
   begin : gen_no_edma_pbuf_downsize
    assign eop_downsize = 1'b1;
    assign empty_downsize = 1'b1;
    assign rxdpram_dob_downsize     = rxdpram_dob_status_muxed;
    assign rxdpram_dob_downsize_par = rxdpram_dob_status_par_muxed;
    assign size_downsize = 3'b011;
   end
   endgenerate

  // A mode exists called status_word_early_fetch_count which utilizes any idle
  // cycles on the AHB to fetch the status words. Owing to the pipelined nature
  // of the AHB/AXI accesses we need to be careful that status_words are
  // inadvertently not sent out on the status bus. We thefore block any status
  // word reads feeding into the data pipeline.


  always@(posedge hclk or negedge n_hreset)
    if (~n_hreset) begin
      rxdpram_dob_reg <= {p_edma_rx_pbuf_data{1'b0}};
      status_word_read <= 1'b0;
    end
    else begin
      if (rxdpram_enb)
      begin
        if ( dpram_rd_state == P_STATUS_WORD_1 ||
             dpram_rd_state == P_STATUS_WORD_2 ||
             dpram_rd_state == P_STATUS_WORD_3 ||
             dpram_rd_state == P_STATUS_WORD_4 )
          status_word_read <= 1'b1;
        else
          status_word_read <= 1'b0;
      end
      if (!status_word_read && rxdpram_enb_d1)
        rxdpram_dob_reg <= rxdpram_dob;
    end

  generate if (p_edma_asf_dap_prot == 1) begin : gen_dpram_dob_par
    reg [p_edma_rx_pbuf_pwid-1:0] rxdpram_dob_par_r;
    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        rxdpram_dob_par_r <= {p_edma_rx_pbuf_pwid{1'b0}};
      else if (!status_word_read && rxdpram_enb_d1)
        rxdpram_dob_par_r <= rxdpram_dob_par;
    end
    assign rxdpram_dob_par_reg  = rxdpram_dob_par_r;
  end else begin : gen_no_dpram_dob_par
    assign rxdpram_dob_par_reg  = {p_edma_rx_pbuf_pwid{1'b0}};
  end
  endgenerate

  assign rxdpram_dob_status_muxed     = (status_word_read | !rxdpram_enb_d1) ? rxdpram_dob_reg      : rxdpram_dob;
  assign rxdpram_dob_status_par_muxed = (status_word_read | !rxdpram_enb_d1) ? rxdpram_dob_par_reg  : rxdpram_dob_par;



  // Create a handy array to keep the base addresses in - makes coding slightly
  // neater. Also pass the current descriptor pointer back to the register block
  // Similar handy uncrompressing of the array for the fill level
  wire [p_awid_par-1:0] rx_dma_base_addr_arr[15:0]; // Handy array to de-serialise the incoming signal
  wire [7:0] rx_buffer_size_array [15:0]; // Handy array to de-serialise the incoming signal
  generate for (g=0; g<p_edma_queues; g=g+1) begin : gen_rx_dma_descr_base_addr
    if (p_edma_asf_dap_prot == 1) begin : gen_base_arr_par
      assign rx_dma_base_addr_arr[g] = {rx_dma_descr_base_par[(g*4)+3:(g*4)],
                                                  rx_dma_descr_base_addr[(g*32)+31:(g*32)]};
    end else begin : gen_no_base_arr_par
      assign rx_dma_base_addr_arr[g] = rx_dma_descr_base_addr[(g*32)+31:(g*32)];
    end
    assign rx_buffer_size_array[g] = rx_dma_buffer_size[(g*8)+7:g*8];
  end
  endgenerate


  // The purpose of the pad signals is to stop a number of warnings that occur
  // when data bus width are less than the maximum size.
  generate if (p_edma_bus_width < 32'd128) begin : gen_dsz_pad
    assign rxdpram_dob_downsize_pad     = {{(128-p_edma_bus_width){1'b0}},rxdpram_dob_downsize};
    assign rxdpram_dob_downsize_par_pad = {{(16-p_edma_bus_pwid){1'b0}},rxdpram_dob_downsize_par};
  end else begin : gen_no_dsz_pad
    assign rxdpram_dob_downsize_pad     = rxdpram_dob_downsize;
    assign rxdpram_dob_downsize_par_pad = rxdpram_dob_downsize_par;
  end
  endgenerate

  // Similarly for the RAM data
  assign rxdpram_dob_pad     = {{(129-p_edma_rx_pbuf_data){1'b0}},rxdpram_dob};
  assign rxdpram_dob_par_pad = {{(17-p_edma_rx_pbuf_pwid){1'b0}},rxdpram_dob_par};

  // Create 32-bit data words for rxdpram_dob_pad with optional parity
  // for easier assignment later
  wire  [35:0]  rxdpram_dob_w0p;
  wire  [35:0]  rxdpram_dob_w1p;
  wire  [35:0]  rxdpram_dob_w2p;
  wire  [35:0]  rxdpram_dob_w3p;
  assign rxdpram_dob_w0p  = {rxdpram_dob_par_pad[3:0],  rxdpram_dob_pad[31:0]};
  assign rxdpram_dob_w1p  = {rxdpram_dob_par_pad[7:4],  rxdpram_dob_pad[63:32]};
  assign rxdpram_dob_w2p  = {rxdpram_dob_par_pad[11:8], rxdpram_dob_pad[95:64]};
  assign rxdpram_dob_w3p  = {rxdpram_dob_par_pad[15:12],rxdpram_dob_pad[127:96]};

  // Similarly for the cutthru data
  wire  [35:0]  ct_fifo_w0p;
  wire  [35:0]  ct_fifo_w1p;
  wire  [35:0]  ct_fifo_w2p;
  wire  [35:0]  ct_fifo_w3p;
  assign ct_fifo_w0p  = {cutthru_status_word_par[3:0],  cutthru_status_word[31:0]};
  assign ct_fifo_w1p  = {cutthru_status_word_par[7:4],  cutthru_status_word[63:32]};
  assign ct_fifo_w2p  = {cutthru_status_word_par[11:8], cutthru_status_word[95:64]};

  // The next status word only exists if TSU is present
  generate if (p_edma_tsu == 1) begin : gen_ct_ts_sw
    assign ct_fifo_w3p  = {cutthru_status_word_par[15:12],cutthru_status_word[127:96]};
  end else begin : gen_no_ct_ts_sw
    assign ct_fifo_w3p  = {36{1'b0}};
  end
  endgenerate

  // Based on the incoming AHB signals, we can create some strobes that
  // relate to the request phase, address phase and data phases for the
  // specific MASTER's.  Note that internally, there is only 1 MASTER
  // that drives 2 MASTER ports based on the state of the main state machine
  // in this module - this is done so that the AHB system arbiter can
  // prioritise TX descriptors over RX data, etc
  //
  // Firstly create the request phase strobes for the management descriptors ...
  // the Descriptor RD state stays active until the data associated with the
  // descriptor has been returned + 1 cycle
  // When we are in 32 bit mode, the man_rd state
  assign        ahbreqph_strobe_descr  =    (hready & hbusreq & hgrant_descr &
                                            (rx_dma_state_man_rd | rx_dma_state_man_wr));

  assign        ahbreqph_strobe_descr_rd  = (hready & hbusreq & hgrant_descr &
                                            (rx_dma_state_man_rd |
                                             (rx_dma_state_man_wr & rx_dma_next_man_rd)));

  //
  // Firstly create the request phase strobes for the pkt data ...
  assign        ahbreqph_strobe_data  =
                       (hready &
                       (~last_data_to_buff_aph | padding_rph) &// Block last address phase
                        hbusreq &
                        rx_dma_state == RX_DMA_DATA_STORE &
                        hgrant_data);

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      ahbaddph_strobe_en_descr  <= 1'b0;
      ahbdataph_strobe_en_descr <= 1'b0;
      ahbaddph_strobe_en_data   <= 1'b0;
      ahbdataph_strobe_en_data  <= 1'b0;
      ahbaddph_strobe_en_descr_rd  <= 1'b0;
      ahbdataph_strobe_en_descr_rd  <= 1'b0;
    end
    else
    begin
      if (hready)
      begin
        // Descriptor reads and writes
        ahbaddph_strobe_en_descr <= ahbreqph_strobe_descr;
        ahbdataph_strobe_en_descr <= ahbaddph_strobe_en_descr;
        ahbaddph_strobe_en_data  <= ahbreqph_strobe_data;
        ahbdataph_strobe_en_data  <= ahbaddph_strobe_en_data;

        // Descriptor reads only
        ahbaddph_strobe_en_descr_rd  <= ahbreqph_strobe_descr_rd;
        ahbdataph_strobe_en_descr_rd <= ahbaddph_strobe_en_descr_rd;

      end
    end
  end


  assign ahbaddph_strobe_descr_rd   = ahbaddph_strobe_en_descr_rd & hready;
  assign ahbdataph_strobe_descr_rd   = ahbdataph_strobe_en_descr_rd & hready;

  assign ahbaddph_strobe_descr   = ahbaddph_strobe_en_descr & hready;
  assign ahbdataph_strobe_descr   = ahbdataph_strobe_en_descr & hready;
  assign ahbaddph_strobe_data    = ahbaddph_strobe_en_data & hready;
  assign ahbdataph_strobe_data    = ahbdataph_strobe_en_data & hready;

  assign hresp_not_ok           = (hresp != 2'b00) & (ahbdataph_strobe_descr |
                                                      ahbdataph_strobe_data)
                                                      & ~hresp_notok_hold;

  // HRESP is only taken into account at the end of the current burst ...
  always @(*)
  begin
    if (hresp_not_ok | hresp_notok_hold)
    begin
      if (|hburst[2:1])
        hresp_notok_eob  = (ahb_access_cnt == 4'h0 & ahbdataph_strobe_data);
      else
        hresp_notok_eob  = ahbdataph_strobe_data | ahbdataph_strobe_descr;
    end
    else
      hresp_notok_eob  = 1'b0;
  end

  always @(*)
  begin
    if (hresp_not_ok | hresp_notok_hold)
    begin
      if (|hburst[2:1])
        hresp_notok_eob_rph  = ((last_access_burst_req | ahb_access_cnt == 4'h0) &
                                ahbdataph_strobe_data);
      else
        hresp_notok_eob_rph  = ahbdataph_strobe_data | ahbdataph_strobe_descr;
    end
    else
      hresp_notok_eob_rph  = 1'b0;
  end


// -----------------------------------------------------------------------------
// AHB read and write databus handling
// -----------------------------------------------------------------------------

   // Work out whether to endian swap on this access depending on the programmed
   // mode. endian_swap[0] indicates the desired endianism for management
   // operations and endian_swap[1] indicates the endianism for data operations.
   assign endian_swap_now = ((endian_swap[0] & ~rx_dma_state_data) |
                             (endian_swap[1] &  rx_dma_state_data));


   // dma_data_out_endian - Byte endian swapped version of write data.
   //                       Bytes only swapped within each 32-bit word
   //                       and then each word is later aligned to correct
   //                       word within the wider bus.
   //                         byte 0  => byte 3
   //                         byte 1  => byte 2
   //                         byte 2  => byte 1
   //                         byte 3  => byte 0
   //                         byte 4  => byte 7
   //                         byte 5  => byte 6
   //                         byte 6  => byte 5
   //                         byte 7  => byte 4
   //------------------------------------------------
   always @(*)
    begin
      if (endian_swap_now)
       begin
         dma_data_out_endian = {rx_dma_data_out[103:96],
                                rx_dma_data_out[111:104],
                                rx_dma_data_out[119:112],
                                rx_dma_data_out[127:120],
                                rx_dma_data_out[71:64],
                                rx_dma_data_out[79:72],
                                rx_dma_data_out[87:80],
                                rx_dma_data_out[95:88],
                                rx_dma_data_out[39:32],
                                rx_dma_data_out[47:40],
                                rx_dma_data_out[55:48],
                                rx_dma_data_out[63:56],
                                rx_dma_data_out[7:0],
                                rx_dma_data_out[15:8],
                                rx_dma_data_out[23:16],
                                rx_dma_data_out[31:24]};
       end
      else
       begin
         dma_data_out_endian = rx_dma_data_out;
       end
    end
   //   Bit endian swapped version of parity off write data.
   always @(*)
    begin
      if (endian_swap_now)
       begin
         dma_data_out_endian_par = {rx_dma_data_out_par[12],
                                rx_dma_data_out_par[13],
                                rx_dma_data_out_par[14],
                                rx_dma_data_out_par[15],
                                rx_dma_data_out_par[8],
                                rx_dma_data_out_par[9],
                                rx_dma_data_out_par[10],
                                rx_dma_data_out_par[11],
                                rx_dma_data_out_par[4],
                                rx_dma_data_out_par[5],
                                rx_dma_data_out_par[6],
                                rx_dma_data_out_par[7],
                                rx_dma_data_out_par[0],
                                rx_dma_data_out_par[1],
                                rx_dma_data_out_par[2],
                                rx_dma_data_out_par[3]};
       end
      else
       begin
         dma_data_out_endian_par = rx_dma_data_out_par;
       end
    end
   //------------------------------------------------


   // sel_word_lane - bus lane corresponding to the accessed words
   //------------------------------------------------
   always@(*)
      // Big endian order: least significant word @ highest address
      if (endian_swap_now)
         casex({dma_bus_width, haddr[3:2]})
            4'b10_xx : sel_word_lane = ~haddr[3:2];
            4'b01_x0 : sel_word_lane = 2'b01;
            default : sel_word_lane  = 2'b00;
         endcase
      // Little endian order: least significant word @ lowest address
      else
         casex({dma_bus_width, haddr[3:2]})
            4'b10_xx : sel_word_lane = haddr[3:2];
            4'b01_x1 : sel_word_lane = 2'b01;
            default : sel_word_lane  = 2'b00;
         endcase
   //------------------------------------------------


   // rd_enable_word - registered version of sel_word_lane.
   //                  required because data phase is one cycle after the
   //                  address phase, therefore we must register the
   //                  word address offset information
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
       begin
         rd_enable_word <= 2'b00;
         rd_endian_swap_now <= 1'b0;
       end

      // hold version of sel_word_lane at end of address phase
      else if (ahbaddph_strobe_descr | ahbaddph_strobe_data)
       begin
         rd_enable_word <= sel_word_lane;
         rd_endian_swap_now <= endian_swap_now;
       end

      // Else default is lane 0 (bits[31:0])
      else if (hready)
       begin
         rd_enable_word <= 2'b00;
         rd_endian_swap_now <= 1'b0;
       end
    end
   //------------------------------------------------


   // hwdata - ahb data output register
   reg  [127:0] dpram_do_str;
   wire [15:0]  dpram_do_str_par;
   reg  [127:0] hwdata_nxt;
   reg  [15:0]  hwdata_par_nxt;
   wire         use_data_imm;

   // Useful signal identifying an AHB phase when we arent padding ...
   wire ahbreqph_strobe_data_nopad;
   wire ahbaddph_strobe_data_nopad;
   assign ahbreqph_strobe_data_nopad = ahbreqph_strobe_data & ~padding_rph;
   assign ahbaddph_strobe_data_nopad = ahbaddph_strobe_data & ~padding_aph;

  // Combinatorial generation of dpram_do_str_nxt and hwdata_nxt with
  // corresponding parity.
  always@(*)
  begin
    hwdata_nxt     = hwdata;
    hwdata_par_nxt = hwdata_par;
    if (use_data_imm)
      casex ({dma_bus_width,sel_word_lane,endian_swap_now})
        5'b10010: begin
                    hwdata_nxt      = {dma_data_out_endian[31:0],    dma_data_out_endian[127:96],   dma_data_out_endian[95:64],    dma_data_out_endian[63:32]};
                    hwdata_par_nxt  = {dma_data_out_endian_par[3:0], dma_data_out_endian_par[15:12], dma_data_out_endian_par[11:8], dma_data_out_endian_par[7:4]};
                  end
        5'b10100: begin
                    hwdata_nxt      = {dma_data_out_endian[63:32],   dma_data_out_endian[31:0],    dma_data_out_endian[127:96],    dma_data_out_endian[95:64]};
                    hwdata_par_nxt  = {dma_data_out_endian_par[7:4], dma_data_out_endian_par[3:0], dma_data_out_endian_par[15:12], dma_data_out_endian_par[11:8]};
                  end
        5'b10110: begin
                    hwdata_nxt      = {dma_data_out_endian[95:64],    dma_data_out_endian[63:32],   dma_data_out_endian[31:0],    dma_data_out_endian[127:96]};
                    hwdata_par_nxt  = {dma_data_out_endian_par[11:8], dma_data_out_endian_par[7:4], dma_data_out_endian_par[3:0], dma_data_out_endian_par[15:12]};
                  end
        5'b10001: begin
                    hwdata_nxt      = {dma_data_out_endian[63:32],   dma_data_out_endian[95:64],    dma_data_out_endian[127:96],    dma_data_out_endian[31:0]}; // Addr 11
                    hwdata_par_nxt  = {dma_data_out_endian_par[7:4], dma_data_out_endian_par[11:8], dma_data_out_endian_par[15:12], dma_data_out_endian_par[3:0]};
                  end
        5'b10011: begin
                    hwdata_nxt      = {dma_data_out_endian[95:64],    dma_data_out_endian[127:96],    dma_data_out_endian[31:0],    dma_data_out_endian[63:32]}; // Addr 10
                    hwdata_par_nxt  = {dma_data_out_endian_par[11:8], dma_data_out_endian_par[15:12], dma_data_out_endian_par[3:0], dma_data_out_endian_par[7:4]};
                  end
        5'b10101: begin
                    hwdata_nxt      = {dma_data_out_endian[127:96],    dma_data_out_endian[31:0],    dma_data_out_endian[63:32],   dma_data_out_endian[95:64]}; // Addr 01
                    hwdata_par_nxt  = {dma_data_out_endian_par[15:12], dma_data_out_endian_par[3:0], dma_data_out_endian_par[7:4], dma_data_out_endian_par[11:8]};
                  end
        5'b10111: begin
                    hwdata_nxt      = {dma_data_out_endian[31:0],   dma_data_out_endian[63:32],    dma_data_out_endian[95:64],    dma_data_out_endian[127:96]}; // Addr 00
                    hwdata_par_nxt  = {dma_data_out_endian_par[3:0], dma_data_out_endian_par[7:4], dma_data_out_endian_par[11:8], dma_data_out_endian_par[15:12]};
                  end
        5'b0101x: begin
                    hwdata_nxt[63:32]   = dma_data_out_endian[31:0];
                    hwdata_par_nxt[7:4] = dma_data_out_endian_par[3:0];
                    hwdata_nxt[31:0]    = dma_data_out_endian[63:32];
                    hwdata_par_nxt[3:0] = dma_data_out_endian_par[7:4];
                  end
        default : begin
                    hwdata_nxt      = dma_data_out_endian;
                    hwdata_par_nxt  = dma_data_out_endian_par;
                  end
      endcase
    else if (ahbaddph_strobe_data)
      casex ({dma_bus_width,sel_word_lane,endian_swap_now})
        5'b10010: begin
                    hwdata_nxt      = {dpram_do_str[31:0],    dpram_do_str[127:96],    dpram_do_str[95:64],    dpram_do_str[63:32]};
                    hwdata_par_nxt  = {dpram_do_str_par[3:0], dpram_do_str_par[15:12], dpram_do_str_par[11:8], dpram_do_str_par[7:4]};
                  end
        5'b10100: begin
                    hwdata_nxt      = {dpram_do_str[63:32],   dpram_do_str[31:0],    dpram_do_str[127:96],    dpram_do_str[95:64]};
                    hwdata_par_nxt  = {dpram_do_str_par[7:4], dpram_do_str_par[3:0], dpram_do_str_par[15:12], dpram_do_str_par[11:8]};
                  end
        5'b10110: begin
                    hwdata_nxt      = {dpram_do_str[95:64],    dpram_do_str[63:32],  dpram_do_str[31:0],     dpram_do_str[127:96]};
                    hwdata_par_nxt  = {dpram_do_str_par[11:8], dpram_do_str_par[7:4], dpram_do_str_par[3:0], dpram_do_str_par[15:12]};
                  end
        5'b10001: begin
                    hwdata_nxt      = {dpram_do_str[63:32],   dpram_do_str[95:64],    dpram_do_str[127:96],    dpram_do_str[31:0]}; // Addr 11
                    hwdata_par_nxt  = {dpram_do_str_par[7:4], dpram_do_str_par[11:8], dpram_do_str_par[15:12], dpram_do_str_par[3:0]};
                  end
        5'b10011: begin
                    hwdata_nxt      = {dpram_do_str[95:64],    dpram_do_str[127:96],  dpram_do_str[31:0],      dpram_do_str[63:32]}; // Addr 10
                    hwdata_par_nxt  = {dpram_do_str_par[11:8], dpram_do_str_par[15:12], dpram_do_str_par[3:0], dpram_do_str_par[7:4]};
                  end
        5'b10101: begin
                    hwdata_nxt      = {dpram_do_str[127:96],    dpram_do_str[31:0],    dpram_do_str[63:32],  dpram_do_str[95:64]}; // Addr 01
                    hwdata_par_nxt  = {dpram_do_str_par[15:12], dpram_do_str_par[3:0], dpram_do_str_par[7:4], dpram_do_str_par[11:8]};
                  end
        5'b10111: begin
                    hwdata_nxt      = {dpram_do_str[31:0],    dpram_do_str[63:32],  dpram_do_str[95:64],     dpram_do_str[127:96]}; // Addr 00
                    hwdata_par_nxt  = {dpram_do_str_par[3:0], dpram_do_str_par[7:4], dpram_do_str_par[11:8], dpram_do_str_par[15:12]};
                  end
        5'b0101x: begin
                    hwdata_nxt[63:32]   = dpram_do_str[31:0];
                    hwdata_par_nxt[7:4] = dpram_do_str_par[3:0];
                    hwdata_nxt[31:0]    = dpram_do_str[63:32];
                    hwdata_par_nxt[3:0] = dpram_do_str_par[7:4];
                  end
        default : begin
                    hwdata_nxt      = dpram_do_str;
                    hwdata_par_nxt  = dpram_do_str_par;
                  end
      endcase
  end

   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
      begin
         hwdata <= {128{1'b0}};
         dpram_do_str <= {128{1'b0}};
         prev_ahbreqph_strobe <= 1'b0;
         prev_ahbaddph_strobe <= 1'b0;
      end
      // The AHB write data will always be available the cycle after
      // the DPRAM is read
      else
      begin
        if (enable_rx_hclk)
          hwdata              <= hwdata_nxt;
        prev_ahbaddph_strobe  <= hready;

        if (hresp_notok_eob | rx_buffer_used_bit | (mac_err_vld & rx_cutthru) | mac_err_vld_pending)
          prev_ahbreqph_strobe <= 1'b0;
        else
          prev_ahbreqph_strobe <= ahbreqph_strobe_data_nopad;

        if (prev_ahbreqph_strobe)
          dpram_do_str     <= dma_data_out_endian;

      end
    end
    assign use_data_imm = (prev_ahbaddph_strobe & ahbaddph_strobe_data) |
                           ahbaddph_strobe_descr;

   // Store dpram_do_str_par and hwdata_par if datapath protection defined
   generate if (p_edma_asf_dap_prot == 1) begin : gen_hwdata_par
    reg   [15:0]  dpram_do_str_par_r;
    reg   [15:0]  hwdata_par_r;
    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
      begin
        dpram_do_str_par_r  <= 16'h0000;
        hwdata_par_r        <= 16'h0000;
      end
      else
      begin
        if (enable_rx_hclk)
          hwdata_par_r        <= hwdata_par_nxt;
        if (prev_ahbreqph_strobe)
          dpram_do_str_par_r  <= dma_data_out_endian_par;
      end
    end
    assign hwdata_par       = hwdata_par_r;
    assign dpram_do_str_par = dpram_do_str_par_r;
   end else begin : gen_no_hwdata_par
    assign hwdata_par       = 16'h0000;
    assign dpram_do_str_par = 16'h0000;
   end
   endgenerate

   //------------------------------------------------


   // rx_dma_data_in_endian - selected input data from AHB. This is transferred
   //                      to both dma_rx and dma_tx blocks via an endian swap
   //------------------------------------------------
   always@(*)
      begin
         dma_data_in_endian     = hrdata; // default
         dma_data_in_endian_par = hrdata_par;
         casex ({dma_bus_width,rd_enable_word,rd_endian_swap_now})

            5'b10_01_0 :
            begin
              dma_data_in_endian      = {hrdata[31:0],  hrdata[127:96], hrdata[95:64],  hrdata[63:32]};
              dma_data_in_endian_par  = {hrdata_par[3:0], hrdata_par[15:12], hrdata_par[11:8], hrdata_par[7:4]};
            end
            5'b10_10_0 :
            begin
              dma_data_in_endian      = {hrdata[63:32], hrdata[31:0],   hrdata[127:96], hrdata[95:64]};
              dma_data_in_endian_par  = {hrdata_par[7:4], hrdata_par[3:0], hrdata_par[15:12], hrdata_par[11:8]};
            end
            5'b10_11_0 :
            begin
              dma_data_in_endian      = {hrdata[95:64], hrdata[63:32],  hrdata[31:0],   hrdata[127:96]};
              dma_data_in_endian_par  = {hrdata_par[11:8], hrdata_par[7:4], hrdata_par[3:0], hrdata_par[15:12]};
            end
            5'b10_00_1 :
            begin
              dma_data_in_endian      = {hrdata[63:32],  hrdata[95:64],  hrdata[127:96], hrdata[31:0]}; // Addr 11
              dma_data_in_endian_par  = {hrdata_par[7:4], hrdata_par[11:8], hrdata_par[15:12], hrdata_par[3:0]};
            end
            5'b10_01_1 :
            begin
              dma_data_in_endian      = {hrdata[95:64],  hrdata[127:96], hrdata[31:0],   hrdata[63:32]}; // Addr 10
              dma_data_in_endian_par  = {hrdata_par[11:8], hrdata_par[15:12], hrdata_par[3:0], hrdata_par[7:4]};
            end
            5'b10_10_1 :
            begin
              dma_data_in_endian      = {hrdata[127:96], hrdata[31:0],   hrdata[63:32],  hrdata[95:64]}; // Addr 01
              dma_data_in_endian_par  = {hrdata_par[15:12], hrdata_par[3:0], hrdata_par[7:4], hrdata_par[11:8]};
            end
            5'b10_11_1 :
            begin
              dma_data_in_endian      = {hrdata[31:0],   hrdata[63:32],  hrdata[95:64],  hrdata[127:96]}; // Addr 00
              dma_data_in_endian_par  = {hrdata_par[3:0], hrdata_par[7:4], hrdata_par[11:8], hrdata_par[15:12]};
            end
            5'b01_01_x :
            begin
              dma_data_in_endian      = {hrdata[127:96],   hrdata[95:64],  hrdata[31:0],  hrdata[63:32]};
              dma_data_in_endian_par  = {hrdata_par[15:12], hrdata_par[11:8], hrdata_par[3:0], hrdata_par[7:4]};
            end

            default :
            begin
              dma_data_in_endian      = hrdata;
              dma_data_in_endian_par  = hrdata_par;
            end
         endcase
      end
   //------------------------------------------------


   // rx_dma_data_in - byte endian swapped version of read data.
   //               Words are already aligned, so just need to
   //               swap bytes within each 32-bit word.
   //                 byte 0  => byte 3
   //                 byte 1  => byte 2
   //                 byte 2  => byte 1
   //                 byte 3  => byte 0
   //                 byte 4  => byte 7
   //                 byte 5  => byte 6
   //                 byte 6  => byte 5
   //                 byte 7  => byte 4
   //------------------------------------------------
   always @( * )
    begin
      if (rd_endian_swap_now)
       begin

         rx_dma_data_in = {dma_data_in_endian[103:96],
                           dma_data_in_endian[111:104],
                           dma_data_in_endian[119:112],
                           dma_data_in_endian[127:120],
                           dma_data_in_endian[71:64],
                           dma_data_in_endian[79:72],
                           dma_data_in_endian[87:80],
                           dma_data_in_endian[95:88],
                           dma_data_in_endian[39:32],
                           dma_data_in_endian[47:40],
                           dma_data_in_endian[55:48],
                           dma_data_in_endian[63:56],
                           dma_data_in_endian[7:0],
                           dma_data_in_endian[15:8],
                           dma_data_in_endian[23:16],
                           dma_data_in_endian[31:24]};
         rx_dma_data_in_par = {dma_data_in_endian_par[12],
                                dma_data_in_endian_par[13],
                                dma_data_in_endian_par[14],
                                dma_data_in_endian_par[15],
                                dma_data_in_endian_par[8],
                                dma_data_in_endian_par[9],
                                dma_data_in_endian_par[10],
                                dma_data_in_endian_par[11],
                                dma_data_in_endian_par[4],
                                dma_data_in_endian_par[5],
                                dma_data_in_endian_par[6],
                                dma_data_in_endian_par[7],
                                dma_data_in_endian_par[0],
                                dma_data_in_endian_par[1],
                                dma_data_in_endian_par[2],
                                dma_data_in_endian_par[3]};
       end
      else
       begin
         rx_dma_data_in     = dma_data_in_endian;
         rx_dma_data_in_par = dma_data_in_endian_par;
       end
    end

   // Separate out rx_dma_data_in into 32-bit words with parity for easier assignment
   // Note that the last word (bits 127:96) is not actually needed so we do not have
   // the assignment here.
   assign rx_dma_data_in_w0_p = {rx_dma_data_in_par[3:0],rx_dma_data_in[31:0]};
   assign rx_dma_data_in_w1_p = {rx_dma_data_in_par[7:4],rx_dma_data_in[63:32]};
   assign rx_dma_data_in_w2_p = {rx_dma_data_in_par[11:8],rx_dma_data_in[95:64]};

   //------------------------------------------------

   // htrans encoding
   parameter
      p_htrans_idle   = 2'b00,         // AHB IDLE access
      p_htrans_nseq   = 2'b10,         // AHB NONSEQ access
      p_htrans_seq    = 2'b11;         // AHB SEQ access

   // hsize encoding
   parameter
      p_hsize_32b    = 3'b010,         // AHB 32-bit access
      p_hsize_64b    = 3'b011,         // AHB 64-bit access
      p_hsize_128b   = 3'b100;         // AHB 128-bit access

   // hburst encoding
   parameter
      p_hburst_single  = 3'b000,       // AHB single access
      p_hburst_incr    = 3'b001,       // AHB INCR access
      p_hburst_incr_4  = 3'b011,       // AHB INCR4 access
      p_hburst_incr_8  = 3'b101,       // AHB INCR8 access
      p_hburst_incr_16 = 3'b111;       // AHB INCR16 access



  // When 128b data bus width
  // 128b accesses when rx_dma_state_data
  // 32b access when rx_data_man_rd (This is to keep implementation complexity down)
  assign hsize = (dma_bus_width[1] & rx_dma_state_data)                       ? p_hsize_128b :
                 (|dma_bus_width & (rx_dma_state_man_wr | rx_dma_state_data)) ? p_hsize_64b
                                                                              : p_hsize_32b;


  // In 32 bit mode, 2 AHB reads are required to obtain the buffer descriptors
  // Just 1 access is required when in 64 bit mode
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      manwr_reqph1_done   <= 1'b0;
      manwr_reqph2_done   <= 1'b0;
      manwr_reqph3_done   <= 1'b0;
      manwr_reqph4_done   <= 1'b0;
    end
    else
    begin
      if (~enable_rx_hclk)
        manwr_reqph1_done  <= 1'b0;
      else if (~rx_dma_state_man_wr & rx_dma_next_man_wr)
        manwr_reqph1_done  <= 1'b0;
      else if (ahbreqph_strobe_descr)
        manwr_reqph1_done  <= 1'b1;

      if (~enable_rx_hclk)
        manwr_reqph2_done  <= 1'b0;
      else if (~rx_dma_state_man_wr & rx_dma_next_man_wr)
        manwr_reqph2_done  <= 1'b0;
      else if (ahbreqph_strobe_descr & manwr_reqph1_done)
        manwr_reqph2_done  <= 1'b1;

      if (~enable_rx_hclk)
        manwr_reqph3_done  <= 1'b0;
      else if (~rx_dma_state_man_wr & rx_dma_next_man_wr)
        manwr_reqph3_done  <= 1'b0;
      else if (ahbreqph_strobe_descr & manwr_reqph2_done)
        manwr_reqph3_done  <= 1'b1;

      if (~enable_rx_hclk)
        manwr_reqph4_done  <= 1'b0;
      else if (~rx_dma_state_man_wr & rx_dma_next_man_wr)
        manwr_reqph4_done  <= 1'b0;
      else if (ahbreqph_strobe_descr & manwr_reqph3_done)
        manwr_reqph4_done  <= 1'b1;
    end
  end


  // Detect the address strobe on the second man write
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      manwr_astrobe2_en  <= 1'b0;
      manwr_astrobe3_en  <= 1'b0;
      manwr_astrobe4_en  <= 1'b0;
      manwr_astrobe_cnt  <= 4'h0;
    end
    else if (~rx_dma_state_man_wr | (~rx_bd_extended_mode_en &(|dma_bus_width)) )
    begin
      manwr_astrobe2_en  <= 1'b0;
      manwr_astrobe3_en  <= 1'b0;
      manwr_astrobe4_en  <= 1'b0;
      manwr_astrobe_cnt  <= 4'h0;
    end
    else
    begin
      if (ahbaddph_strobe_descr)
      begin
        manwr_astrobe2_en  <= 1'b1;
        manwr_astrobe_cnt  <= manwr_astrobe_cnt + 4'h1;
      end
      if (ahbaddph_strobe_descr & manwr_astrobe2_en )
        manwr_astrobe3_en  <= 1'b1;
      if (ahbaddph_strobe_descr & manwr_astrobe3_en )
        manwr_astrobe4_en  <= 1'b1;
    end
  end

assign astrobe_manwr_1st = rx_dma_state_man_wr &
                            ahbaddph_strobe_descr & (manwr_astrobe_cnt == 4'h0);

assign astrobe_manwr_2nd = rx_dma_state_man_wr &
                            ahbaddph_strobe_descr & (manwr_astrobe_cnt == 4'h1);

assign astrobe_manwr_3rd = rx_dma_state_man_wr &
                            ahbaddph_strobe_descr & (manwr_astrobe_cnt == 4'h2);

assign astrobe_manwr_4th = rx_dma_state_man_wr &
                            ahbaddph_strobe_descr & (manwr_astrobe_cnt == 4'h3);

assign manwr_rx_dma_addr_1 = rx_dma_state_man_wr &
                            ~ahbaddph_strobe_descr & (manwr_astrobe_cnt == 4'h1);

assign manwr_rx_dma_addr_2 = rx_dma_state_man_wr &
                            ~ahbaddph_strobe_descr & (manwr_astrobe_cnt == 4'h2);

assign manwr_rx_dma_addr_3 = rx_dma_state_man_wr &
                            ~ahbaddph_strobe_descr & (manwr_astrobe_cnt == 4'h3);

assign inc_rx_dma_mux_addr_1 = (astrobe_manwr_1st  | manwr_rx_dma_addr_1);
assign inc_rx_dma_mux_addr_2 = (astrobe_manwr_2nd  | manwr_rx_dma_addr_2);
assign inc_rx_dma_mux_addr_3 = (astrobe_manwr_3rd  | manwr_rx_dma_addr_3);

// change astrobe_last for 32b / 64b / 128b address and data bus widths
assign  astrobe_manwr_last = ((descriptor_wr_4_access ? astrobe_manwr_4th: (descriptor_wr_2_access ? astrobe_manwr_2nd : astrobe_manwr_1st))|(~rx_bd_extended_mode_en & astrobe_manwr_1st&(|dma_bus_width)));



    // for MAN_RD
    // Detect the address strobe
    // Count ahbaddph_strobe_descr and ahbaddph_strobe_descr
    //
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      descr_rd_reqph_cnt     <= 3'h0;
    else if (~rx_dma_state_man_rd & ahbdataph_strobe_descr_rd)  // reset before man_rd state as count is used in first cycle of DATA read
      descr_rd_reqph_cnt     <= 3'h0;
    else
    begin  // use _rd signals as these can occur in states other that man_rd
      if (ahbreqph_strobe_descr_rd)
        descr_rd_reqph_cnt <= descr_rd_reqph_cnt + 3'h1;
    end
  end

  generate if (p_edma_addr_width == 32'd64) begin : gen_descr_rd_dataph
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      descr_rd_addph_cnt     <= 2'h0;
      descr_rd_dataph_cnt    <= 2'h0;
    end
    else if (~rx_dma_state_man_rd & ahbdataph_strobe_descr_rd)  // reset before man_rd state as count is used in first cycle of DATA read
    begin
      descr_rd_addph_cnt     <= 2'h0;
      descr_rd_dataph_cnt    <= 2'h0;
    end
    else
    begin  // use _rd signals as these can occur in states other that man_rd
      if (ahbaddph_strobe_descr_rd)
        descr_rd_addph_cnt <= descr_rd_addph_cnt + 2'h1;
      if (ahbdataph_strobe_descr_rd)
        descr_rd_dataph_cnt <= descr_rd_dataph_cnt + 2'h1;
    end
  end
  end else begin :gen_no_descr_rd_dataph
    wire zero;
    assign zero = 1'b0;
    always @(*)
    begin
      descr_rd_dataph_cnt = {2{zero}};
      descr_rd_addph_cnt = {2{zero}};
    end
  end
  endgenerate


wire priq_descr_rd_safe;
wire priq_get_status_info;
// num_pkts-xfer is an rx-clk timed signal. It should only be sampled when pkt_written_dpram or part_pkt_written is set
// This useful signal makes the lint tools more easily detect the valid clk boundary and gating term.
wire  [3:0] num_pkts_xfer_fullpkt;
wire  [3:0] num_pkts_xfer_partpkt;
assign num_pkts_xfer_fullpkt = ({4{pkt_written_dpram}} & num_pkts_xfer);
assign num_pkts_xfer_partpkt = ({4{part_pkt_written}} & num_pkts_xfer);
generate if (p_edma_queues > 32'd1) begin : set_priq_logic
  // Set when it is safe to do a descriptor read in priority queue mode
  assign priq_descr_rd_safe = ((((|num_pkts_needing_read | pkt_written_dpram) & (early_queue_info_en || (status_word1_capt & nxt_status_word_1[0]))) | reading_eop_dpram_aph_del)
                              || ((~(|num_pkts_needing_read)) && (|num_parts_needing_read)));

  // When priority queueing is enabled, we want to obtain
  // the status information asap, as the status holds the queue
  // information.  This means we will be reading from the DPRAM
  // more than we really need to, but it is the most efficient
  // way
  // The address should already be pointing to the status word,
  // so we can just enable the DPRAM rd here
  assign priq_get_status_info = (|num_pkts_needing_read && |num_pkts_needing_read_nxt & ~status_word2_capt) | (num_pkts_xfer_fullpkt !=4'd0);

end else begin : set_no_priq_descr_rd_safe
  assign priq_descr_rd_safe = 1'b1;
  assign priq_get_status_info = 1'b0;
end
endgenerate

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      htrans  <= p_htrans_idle;
      hburst  <= p_hburst_incr;
      hwrite  <= 1'b0;
      haddr   <= 64'd0;
      ahb_access_cnt <= 4'h0;
    end
    else
    begin
      if (~enable_rx_hclk)
        haddr   <= 64'd0;
      else if (hready)
         haddr <= {ahb_data_addr_2[31:0], rx_dma_burst_addr[31:0]}; // MS word is only used for data addr, not BD
                                                                    // This is replace by fixed value for BD addr

      if (~enable_rx_hclk)
      begin
        htrans  <= p_htrans_idle;
        hburst  <= p_hburst_incr;
        hwrite  <= 1'b0;
        ahb_access_cnt <= 4'h0;
      end
      else

      case (rx_dma_state)
        RX_DMA_MAN_WR :
        begin
          ahb_access_cnt <= 4'h0;
          // RULE : Always 2 accesses in 32 bit mode, 2nd is always sequential
          // RULE : Always 1 access in 64 bit mode
          // RULE : Never breaks 1k boundary, always aligned to 8 byte boundary
          if (hready & hgrant_descr)
          begin
            if (hresp_notok_eob)
            begin
              hwrite  <= 1'b0;
              htrans  <= p_htrans_idle;
              hburst  <= p_hburst_incr;
            end
            else if (~manwr_reqph1_done)
            begin
              hwrite  <= 1'b1;
              htrans  <= p_htrans_nseq;
              hburst  <= p_hburst_incr;
            end
            else if (descriptor_wr_4_access)
            begin
              if (manwr_reqph4_done)
              begin
                // Jump straight into the next descriptor read ...
                hwrite  <= 1'b0;
                hburst  <= p_hburst_incr;
                if (priq_descr_rd_safe)
                  htrans  <= p_htrans_nseq;
                else
                  htrans  <= p_htrans_idle;
              end
              else if (manwr_reqph3_done)
              begin
                htrans  <= p_htrans_nseq;
                hburst  <= p_hburst_incr;
                hwrite  <= 1'b1;
              end
              else
              begin
                htrans  <= p_htrans_nseq;
                hburst  <= p_hburst_incr;
                hwrite  <= 1'b1;
              end
            end
            else if (descriptor_wr_2_access)
            begin
              if (manwr_reqph2_done)
              begin
                // Jump straight into the next descriptor read ...
                hwrite  <= 1'b0;
                hburst  <= p_hburst_incr;
                if (priq_descr_rd_safe)
                  htrans  <= p_htrans_nseq;
                else
                  htrans  <= p_htrans_idle;
              end
              else
              begin  // first access
                htrans  <= p_htrans_nseq;
                hburst  <= p_hburst_incr;
                hwrite  <= 1'b1;
              end
            end
            else // if (one_man_wr_access)
            begin
              // Jump straight into the next descriptor read ...
              hwrite  <= 1'b0;
              hburst  <= p_hburst_incr;
              if (priq_descr_rd_safe)
                htrans  <= p_htrans_nseq;
              else
                htrans  <= p_htrans_idle;
            end
          end
          else if (hready)
            htrans  <= p_htrans_idle;
        end

        RX_DMA_MAN_RD :
        begin
          // For 64b addressing we need to read Word 2 so depending on data bus width
          // we will need to perform different no of accesses.
          // For 32b data bus, 2 accesses
          // For 64b data bus, 2 accesses
          // For 128b data bus, 1 access

          // For 32b addressing the original rules still apply.
          // RULE : Always 1 access or 32b addressing
          // RULE : Never breaks 1k boundary, always aligned to 8 byte boundary
          //
          // Insert an IDLE at the end of the 2nd Request phase
          // This is required because the arbiter uses htrans to
          // change master - htrans is an address phase timed signal,
          // while hgrant is request phase
          if (hready & hgrant_descr)
          begin
            hwrite  <= 1'b0;
            hburst  <= p_hburst_incr;
            if (hresp_notok_eob)
              htrans  <= p_htrans_idle;
            else if ((~ahbreqph_strobe_descr) & descriptor_rd_1_access)  // single read access for 32b addr or 128b data bus
                                                                       // single read access for 128b
              htrans  <= p_htrans_idle;
            else if  (~ahbreqph_strobe_descr & (descr_rd_reqph_cnt == 3'h2) & descriptor_rd_2_access)   // 2 accesses for other cases
              htrans  <= p_htrans_idle;
            else
              htrans  <= p_htrans_nseq;
          end
          else if (hready)
            htrans  <= p_htrans_idle;
        end

        RX_DMA_DATA_STORE :
        begin
          if (hready & hgrant_data & hbusreq)
          begin
            if (hresp_notok_eob)
              hburst <= p_hburst_incr;
            else if (brk1kbndry_burst & ahb_access_cnt == 4'h0)
            begin
              casex (bndry1k_acc_size[3:0])
                 4'b01xx : hburst <= p_hburst_incr_4; // > 4 access
                 4'b1xxx : hburst <= p_hburst_incr_8; // > 8 accesses
                 default : hburst <= p_hburst_incr;   // > 2 access
              endcase
            end
            else if (eop_burst & ahb_access_cnt == 4'h0)
            begin
              // If buffer_fill_lvl == 0, then eop_burst will be set
              // hburst must be set to p_hburst_single
              casex (eop_burst_size[4:0])
                 5'b001xx : hburst <= p_hburst_incr_4;
                 5'b01xxx : hburst <= p_hburst_incr_8;
                 default  : hburst <= p_hburst_incr;
              endcase
            end
            else if (ahb_access_cnt == 4'h0)
            begin
              case (ahb_burst_length[4:0])
                5'd4    : hburst <= p_hburst_incr_4;
                5'd8    : hburst <= p_hburst_incr_8;
                5'd16   : hburst <= p_hburst_incr_16;
                default : hburst <= p_hburst_incr;
              endcase
            end

            // AHB error or end of buffer (as long as we're not padding the burst)
            if (hresp_notok_eob | (last_data_to_buff_aph & ~padding_rph))
            begin
              hwrite          <= 1'b0;
              htrans          <= p_htrans_idle;
              ahb_access_cnt  <= 4'h0;
            end

            // End of current burst (address phase)
            else if (ahb_access_cnt == 4'h0)
            begin
              // Insert an IDLE at the end of the DATA phase
              // This is required because the arbiter uses htrans to
              // change master - htrans is an address phase timed signal,
              // while hgrant is request phase
              if (last_data_to_buff_aph | cutthru_wait4part | nxt_rx_dma_state == RX_DMA_IDLE)
              begin
                hwrite          <= 1'b0;
                htrans          <= p_htrans_idle;
                ahb_access_cnt  <= ahb_access_cnt;
              end
              else
              begin
                hwrite          <= 1'b1;
                htrans          <= p_htrans_nseq;
                if ((eop_burst_size > 5'h01 | ~eop_burst) & ~breaks_1k_boundary)
                  ahb_access_cnt  <= ahb_access_cnt + 4'h1;
              end
            end

            // Break the current burst if
            //  1) This is the last request phase for the current packet part
            //    (cut through)
            //  2) This is the last request phase for the current buffer
            //  3) This is the last request phase for the current burst
            else if  (last_access_burst_req | breaks_1k_boundary)
            begin
              hwrite          <= 1'b1;
              htrans          <= p_htrans_seq;
              ahb_access_cnt  <= 4'h0;
            end
            else
            begin
              hwrite          <= 1'b1;
              htrans          <= p_htrans_seq;
              ahb_access_cnt  <= ahb_access_cnt + 4'h1;
            end
          end
          else if (hready | nxt_rx_dma_state == RX_DMA_IDLE)
          begin
            hwrite          <= 1'b0;
            htrans          <= p_htrans_idle;
            ahb_access_cnt  <= 4'h0;
            hburst <= p_hburst_incr;
          end
        end

        default :
        begin
          hwrite          <= 1'b0;
          htrans          <= p_htrans_idle;
          ahb_access_cnt  <= 4'h0;
          hburst <= p_hburst_incr;
        end
      endcase
    end
  end

  // Optional parity pipeline of haddr
  generate if (p_edma_asf_dap_prot == 1) begin : gen_haddr_par
    reg [7:0] haddr_par_r;
    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        haddr_par_r <= 8'h00;
      else if (~enable_rx_hclk)
        haddr_par_r <= 8'h00;
      else if (hready)
        haddr_par_r <= {ahb_data_addr_2[35:32],rx_dma_burst_addr[35:32]};
    end
    assign haddr_par  = haddr_par_r;
  end else begin : gen_no_haddr_par
    assign haddr_par  = 8'h00;
  end
  endgenerate

  assign last_access_burst_req =
                     (eop_burst & eop_burst_size == 5'h01) |
                      breaks_1k_boundary |
                     (hburst == p_hburst_incr_16 & ahb_access_cnt == 4'hf) |
                     (hburst == p_hburst_incr_8  & ahb_access_cnt == 4'h7)  |
                     (hburst == p_hburst_incr_4  & ahb_access_cnt == 4'h3);


  // brk1kbndry_burst will be set if the upcoming burst will break the
  //                      1K AHB address boundary.

  // Convert ahb_burst_length to a mask to make it easier to select
  // correct bits for 1K boundary address comparison
  // Note that by this stage ahb_burst_length is one-hot.
  always @ ( * )
  begin
    case (dma_bus_width)
       2'b00  : begin // 32-bit wide access
                 ahb_burst_maskh = {3'b111,
                                    |(ahb_burst_length[4:0]),
                                    |(ahb_burst_length[3:0]),
                                    |(ahb_burst_length[2:0]),
                                    |(ahb_burst_length[1:0]),
                                    ahb_burst_length[0]};
                 end

       2'b01     : begin // 64-bit wide access
                 ahb_burst_maskh = {2'b11,
                                    |(ahb_burst_length[4:0]),
                                    |(ahb_burst_length[3:0]),
                                    |(ahb_burst_length[2:0]),
                                    |(ahb_burst_length[1:0]),
                                    ahb_burst_length[0],
                                    1'b0};
                 end
       default   : begin // 128-bit wide access
                 ahb_burst_maskh = {1'b1,
                                    |(ahb_burst_length[4:0]),
                                    |(ahb_burst_length[3:0]),
                                    |(ahb_burst_length[2:0]),
                                    |(ahb_burst_length[1:0]),
                                    ahb_burst_length[0],
                                    2'b00};
                 end

    endcase
  end

  assign brk1kbndry_burst =
         // Full 16beat burst will cross the 1k boundary
          ((((ahb_data_addr[9:2] &  ahb_burst_maskh) == ahb_burst_maskh) &
            ((ahb_data_addr[9:2] & ~ahb_burst_maskh) != 8'h00))

         // If PKT will end before reaching the 1k boundary ...
          & ~(eop_burst & (eop_burst_size < {1'b0,bndry1k_acc_size})));


  // Calculate the number of accesses before 1k boundary
  always @(*)
    casex (ahb_data_addr[5:2])
      4'b0xxx,4'b1000         : bndry1k_acc_size_32 = 4'd8;
      4'b1101,4'b1110         : bndry1k_acc_size_32 = 4'd2;
      4'b1111                 : bndry1k_acc_size_32 = 4'd1;
//      4'b1001,4'b101x,4'b1100 : bndry1k_acc_size_32 = 4'd4;
      default                : bndry1k_acc_size_32 = 4'd4;
    endcase
  always @(*)
    casex (ahb_data_addr[6:3])
      4'b0xxx,4'b1000         : bndry1k_acc_size_64 = 4'd8;
      4'b1101,4'b1110         : bndry1k_acc_size_64 = 4'd2;
      4'b1111                 : bndry1k_acc_size_64 = 4'd1;
//      4'b1001,4'b101x,4'b1100 : bndry1k_acc_size_64 = 4'd4;
      default                : bndry1k_acc_size_64 = 4'd4;
    endcase
  always @(*)
  begin
    casex (ahb_data_addr[7:4])
      4'b0xxx,4'b1000         : bndry1k_acc_size_128 = 4'd8;
      4'b1101,4'b1110         : bndry1k_acc_size_128 = 4'd2;
      4'b1111                 : bndry1k_acc_size_128 = 4'd1;
      default                 : bndry1k_acc_size_128 = 4'd4;
    endcase
  end

  assign bndry1k_acc_size = dma_bus_width[1] ? bndry1k_acc_size_128 :
                            dma_bus_width == 2'b01 ? bndry1k_acc_size_64
                                                   : bndry1k_acc_size_32;


  // breaks_1k_boundary should be set only on the request phase
  assign breaks_1k_boundary = dma_bus_width[1]
                              ? (rx_dma_burst_addr[9:3] == 7'b1111110)
                              : (rx_dma_burst_addr[9:2] == {7'b1111111,~dma_bus_width[0]});

 // If we are in 128 bit DPRAM mode we need to consider that some data may
 // currently be buffered in the downsize buffer. We also need to factor in if
 // the status has been read. If the status has been read then we may need to subtract
 // some words from the end....this is because the final 128b word read from
 // the DPRAM may not use all bytes - i.e. only 4 bytes of the potential 16
 // bytes could have been used, and we therefore need to factor this into the
 // calculation.
 // One thing that is of noteworthy point here, the dplocns signals (pkt_dplocns,
 // part_dplocns and part_dplocns_left) are used to count dpram words and they
 // count words regardless of the width of the dpram. The
 // part_dplocns_left_downsize signal is however used to count words within
 // the dma bus width - i.e. if the dpram width is 128b and the dma bus width
 // is 32b then part_dplocns_left_downsize will count 4 for every dplocns
 // value. The dplocns signals have a lot going on so it's worth adding a
 // timing diagram to show the interaction of the dplocns signals (with a dma
 // bus width of 64b, a dpram width of 128b and a packet of 32 bytes):
 //
 //                            _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _
 //                      clk _| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_
 //                           _ ___ ___ ___ ___ _______________________________________________
 //            dpram_rd_state _X_0_X_1_X_2_X_3_X_5_____________________________________________
 //                                         ___     ___     ___     ___
 //               rd_downsize _____________|   |___|   |___|   |___|   |_______________________
 //                                             ___             ___
 //               rxdpram_enb _________________|   |___________|   |___________________________
 //                                                 ___     ___     ___     ___
 //      ahbreqph_strobe_data _____________________|   |___|   |___|   |___|   |_______________
 //                           _________________         _______         _______________________
 //            empty_downsize                  |_______|       |_______|
 //                           _________________ _______________ _______________ _______________
 //          pkt_dplocns_left _________________X________2______X______1________X____0__________
 //                           _________________ _______ _______ ___ ___ ___ ___________________
 // pkt_dplocns_left_downsize _________________X___3___X___2___X___1___X___0___________________
 //                                                                         ___
 //     reading_eop_dpram_rph _____________________________________________|   |_______________
 //                           _________________________________ _______________ _______________
 //               pkt_dplocns ______________________0__________X______1________X______0________

 
 assign part_dplocns_left_m1 = part_dplocns_left - {{p_edma_rx_pbuf_addr-1{1'b0}}, 1'b1};

 // Create a modfied version of the byte count - subtract one from the end of
 // packet count to make the particulare word slice easier to identify.
 wire [3:0] pkt_end_mod = status_word_3[3:0] - 4'd1;
 
 // Note: in part_dplocns_left_downsize there is no possibility for the addends to produce an overflow, because
 // they are padded such way that the part_dplocns can just be 19 bits. For example 
 // {1'b0,{17-p_edma_rx_pbuf_addr{1'b0}}, part_dplocns_left_m1,1'b0} + {16'd0, size_downsize} 
 // will assume the value of (assuming that p_edma_rx_pbuf_addr = 16 (max value) and all the bits of the 
 // variables are 1s : 0011111111111111110 + 0000000000000000111 = 0100000000000000101

 always @(*)
   if (~gem_rx_pbuf_data_w_is_128 | dma_bus_width[1])
     part_dplocns_left_downsize = {{19-p_edma_rx_pbuf_addr{1'b0}}, part_dplocns_left};
   else if (dma_bus_width[0]) begin
     if (status_word2_capt)
       part_dplocns_left_downsize = {1'b0,{17-p_edma_rx_pbuf_addr{1'b0}}, part_dplocns_left_m1,1'b0} + {16'd0, size_downsize} - {18'd0, ~pkt_end_mod[3]}; 
     else
       part_dplocns_left_downsize = {1'b0,{17-p_edma_rx_pbuf_addr{1'b0}}, part_dplocns_left_m1,1'b0} + {16'd0, size_downsize}; 
   end
   else
     if (status_word2_capt)
       part_dplocns_left_downsize = {{17-p_edma_rx_pbuf_addr{1'b0}},part_dplocns_left_m1,2'b00} + {16'd0, size_downsize} - {17'd0, ~pkt_end_mod[3:2]}; 
     else
       part_dplocns_left_downsize = {{17-p_edma_rx_pbuf_addr{1'b0}},part_dplocns_left_m1,2'b00} + {16'd0, size_downsize}; 


 // Identify when we are at the end of the data burst

 // Determine how many words have already been ready from the downsize block.
 // The number of words used is the inverse of the current downsize buffer
 // size.
 assign num_used_words_downsize =  {1'b0, ~size_downsize[1], ~size_downsize[0]} + 3'b001;
 always @(*)
   if (~gem_rx_pbuf_data_w_is_128 | dma_bus_width[1])
     near_endofpart_local = {{19-p_edma_rx_pbuf_addr{1'b0}},rx_cutthru_threshold} -
                            {{19-p_edma_rx_pbuf_addr{1'b0}},part_dplocns};
   else if (dma_bus_width[0])
     near_endofpart_local = {{18-p_edma_rx_pbuf_addr{1'b0}},rx_cutthru_threshold,1'b0} -
                            ({{18-p_edma_rx_pbuf_addr{1'b0}},part_dplocns,1'b0} + {17'd0,num_used_words_downsize[2:1]});
   else
     near_endofpart_local = {{17-p_edma_rx_pbuf_addr{1'b0}},rx_cutthru_threshold,2'b00} -
                            ({{17-p_edma_rx_pbuf_addr{1'b0}},part_dplocns,2'b00} + {16'd0,num_used_words_downsize});
 // In case the near_endofpart_local wraps round, stop it wrapping round.
 assign near_endofpart = (!rx_cutthru || status_word2_capt) ? {19{1'b1}} : near_endofpart_local[18] ? 19'd0 : near_endofpart_local;
 assign endofpkt_burst = part_dplocns_left_downsize[16:0] < {12'd0,ahb_burst_length[4:0]};
 assign endofbuf_burst = buffer_fill_lvl  < {7'd0, ahb_burst_length[4:0]};

 // Really only want to do this on the last part b4
 // reading status, but that requires changes to 'cutthru_statavail'
 assign endofpart_burst = (!rx_cutthru || status_word2_capt) ? 1'b0 : (near_endofpart < {14'd0,ahb_burst_length[4:0]});

 always @(*)
 begin
   if (force_max_ahb_burst_rx & |ahb_burst_length[4:2])
     eop_burst      = 1'b0;

   else
     eop_burst      = endofpkt_burst            |
                      reading_eop_dpram_rph_del |
                      endofbuf_burst            |
                      endofpart_burst;
 end

 always @(*)
 begin
   if (reading_eop_dpram_rph_del)
     eop_burst_size = 5'h01;
   else if (endofpkt_burst & (part_dplocns_left_downsize[16:0] < {5'd0, buffer_fill_lvl}) &
                             (part_dplocns_left_downsize[16:0] < near_endofpart[16:0]))
     eop_burst_size = part_dplocns_left_downsize[4:0];
   else if (endofpart_burst & (near_endofpart[15:0] < {4'd0, buffer_fill_lvl}))
     eop_burst_size = near_endofpart[4:0];
   else
     eop_burst_size = buffer_fill_lvl[4:0];
 end


// In 64b addr mode haddr_descr [63:32] comes from a fixed apb register descr_ptr_msb
 assign haddr_descr_int[63:32]    = ~gem_dma_addr_w_is_64 ? 32'd0 : upper_rx_q_base_addr;
 assign haddr_descr_par_int[7:4]  = ~gem_dma_addr_w_is_64 ? 4'd0  : upper_rx_q_base_par;
 assign haddr_descr_int[31:0]     = haddr[31:0];
 assign haddr_descr_par_int[3:0]  = haddr_par[3:0];

 assign hbusreq_descr = ~rx_dma_state_data ? hbusreq : 1'b0;

 assign hbusreq_descr_rd  = p_edma_rsc == 1 && hbusreq & (rx_dma_state_man_rd | (rx_dma_state_man_wr & rx_dma_next_man_rd));
 assign hbusreq_descr_wr  = p_edma_rsc == 1 && hbusreq & ~hbusreq_descr_rd & ~rx_dma_state_data;

 assign hlock_descr       = 1'b0;
 assign hburst_descr      = ~rx_dma_state_data ? hburst  : 3'b000;
 assign htrans_descr      = ~rx_dma_state_data ? htrans  : 2'b00;
 assign hsize_descr       = ~rx_dma_state_data ? hsize   : 3'b010;
 assign hwrite_descr      = ~rx_dma_state_data ? hwrite  : 1'b0;
 assign hprot_descr       = p_edma_hprot_value;
 assign haddr_descr       = ~rx_dma_state_data ? haddr_descr_int[p_edma_addr_width-1:0]     : {p_edma_addr_width{1'b0}};
 assign haddr_descr_par   = ~rx_dma_state_data ? haddr_descr_par_int[p_edma_addr_pwid-1:0]  : {p_edma_addr_pwid{1'b0}};
 assign hwdata_descr      = hwdata;
 assign hwdata_descr_par  = hwdata_par;

 assign hbusreq_data      = rx_dma_state_data ? hbusreq : 1'b0;
 assign hlock_data        = 1'b0;
 assign hburst_data       = rx_dma_state_data ? hburst  : 3'b000;
 assign htrans_data       = rx_dma_state_data ? htrans  : 2'b00;
 assign hsize_data        = rx_dma_state_data ? hsize   : 3'b010;
 assign hwrite_data       = rx_dma_state_data ? hwrite  : 1'b0;
 assign hprot_data        = p_edma_hprot_value;
 assign haddr_data        = rx_dma_state_data ? haddr[p_edma_addr_width-1:0]    : {p_edma_addr_width{1'b0}};
 assign haddr_data_par    = rx_dma_state_data ? haddr_par[p_edma_addr_pwid-1:0] : {p_edma_addr_pwid{1'b0}};
 assign hwdata_data       = hwdata;
 assign hwdata_data_par   = hwdata_par;



//-------------------------------------------
// End of AHB Interface Logic
//-------------------------------------------



  // Communicate with Write side of PKT Buffer
  // Count the packets as they are written into the DPRAM
   edma_sync_toggle_detect # (
     .DIN_W(2)
   ) i_edma_sync_toggle_detect_packet_tog (
     .clk(hclk),
     .reset_n(n_hreset),
     .din({end_of_packet_tog,part_of_packet_tog}),
     .rise_edge(),
     .fall_edge(),
     .any_edge({pkt_written_dpram,part_pkt_written}));

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      pkt_captured         <= 1'b0;
    else if (pkt_written_dpram | part_pkt_written)
      pkt_captured       <= ~pkt_captured;
  end
  
  // If there has been an EOP written in, we know there is a packet waiting
  // to be read
  always@(*)
  begin
    // Count the number of full packets that are sitting in the DPRAM
    // waiting to be written to AHB memory - maximum 256
    if (pkt_written_dpram)
      num_pkts_needing_read_nxt = num_pkts_needing_read + num_pkts_xfer_fullpkt -
                                  (reading_eop_dpram_rph | nxt_pkt_is_err);

    else if (reading_eop_dpram_rph | nxt_pkt_is_err)
      num_pkts_needing_read_nxt = num_pkts_needing_read - {{p_edma_rx_pbuf_addr-1{1'b0}},1'b1};
    else
      num_pkts_needing_read_nxt = num_pkts_needing_read;
  end
  
  assign num_parts_needing_read_c = num_parts_needing_read + num_pkts_xfer_partpkt;
  assign part_dplocns_pending_c   = part_dplocns_pending + rx_cutthru_threshold + {{(p_edma_rx_pbuf_addr-1){1'b0}},1'd1};
  
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      num_pkts_needing_read              <= {p_edma_rx_pbuf_addr{1'b0}};
      num_parts_needing_read             <= 8'h00;
      part_dplocns_pending               <= {p_edma_rx_pbuf_addr{1'b0}};
      part_dplocns_pending_for_new_frame <= 1'b1;
      fetch_rem_part                     <= 1'b0;
    end
    else if (~enable_rx_hclk)
    begin
      num_pkts_needing_read              <= {p_edma_rx_pbuf_addr{1'b0}};
      num_parts_needing_read             <= 8'h00;
      part_dplocns_pending               <= {p_edma_rx_pbuf_addr{1'b0}};
      part_dplocns_pending_for_new_frame <= 1'b1;
      fetch_rem_part                     <= 1'b0;
    end
    else
    begin

      num_pkts_needing_read <= num_pkts_needing_read_nxt;

      // Indicate if the part pkt request coming in are for a new
      // frame or for the current frame.
      if (pkt_written_dpram)
        part_dplocns_pending_for_new_frame <= 1'b1;
      else if (start_reading_at_risk)
        part_dplocns_pending_for_new_frame <= 1'b0;

      // Count the number of packet fragements (size equal to value stored
      // in cut-thru threshold register).  This applies to the most recent
      // packet written in only.  Eg. if num_pkts_needing_read  = 3 and
      // num_parts_needing_read = 7, then there are 3 full packets and 7
      // fragments  of the 4th packet available for reading
      if (pkt_written_dpram) begin
        num_parts_needing_read <= 8'h00;
        part_dplocns_pending   <= {p_edma_rx_pbuf_addr{1'b0}};
      end
      
      else if (part_pkt_written)
      begin
        // Only allow a decrement if non-zero
        if (|num_parts_needing_read & num_pkts_needing_read == {p_edma_rx_pbuf_addr{1'b0}})
          num_parts_needing_read <= num_parts_needing_read + num_pkts_xfer_partpkt - last_partpkt_rph;
        else
          num_parts_needing_read <= num_parts_needing_read_c[7:0];
          part_dplocns_pending   <= part_dplocns_pending_c[p_edma_rx_pbuf_addr-1:0];
      end

      else if (last_partpkt_rph & (|num_parts_needing_read) &
               num_pkts_needing_read == {p_edma_rx_pbuf_addr{1'b0}})
        num_parts_needing_read <= num_parts_needing_read - 8'h01;


      // If we have started fetching a 'part_of_packet' from the DPRAM and the
      // 'pkt_written_dpram' signal is set, we want to make sure we continue to
      // fetch the remainder of that 'part' before we go read the status.  We
      // recognise this time using the fetch_rem_part signal ...
      if (last_partpkt_rph)
        fetch_rem_part  <= 1'b0;
      else if (|num_parts_needing_read & pkt_written_dpram &
                num_pkts_needing_read == {p_edma_rx_pbuf_addr{1'b0}})
        fetch_rem_part  <= 1'b1;
     end
  end


  // When we read the status word for the next packet and it is showing
  // that there is no data associated with the packet,
  assign mac_err_vld = (~status_word_1[0] & status_word1_capt & (~(hbusreq | ahbaddph_strobe_en_data | ahbaddph_strobe_en_descr) | hready));
  assign nxt_pkt_is_err = ((mac_err_vld |
                            ahb_err_pktdiscarded_wait4end | hresp_data_cutthru | flush_next_packet) &
                            status_word1_capt);


  // generate condition that will cause the next packet in the DPRAM to be flushed
  // This can be immediately if flush_rx_pkt_hclk is set when in an IDLE state
  // or it can use a delayed version of the flush input if we are currently performing
  // or about to perform a descriptor read and the outcome of that is a used bit read
  // only do a flush if there is at nleast 1 packet in the DPRAM.  Dont do it if
  // ahb_err_discard_recover occurs, as this performs a packet flush by itself
  // Ignore if currently writing a frame to memory (state = DATA)
  // Block out flush_rx_pkt_hclk when last_dpram_rd_state == P_STATUS_WORD_4 since
  // this cycle is required to recover the status words from dpram_fill_lvl
  assign flush_next_packet =
         (((flush_rx_pkt_hclk & num_pkts_needing_read !={p_edma_rx_pbuf_addr{1'b0}} &
            rx_dma_state == RX_DMA_IDLE & last_dpram_rd_state != P_STATUS_WORD_4) |
            flush_wait_for_manrd) &
            ~ahb_err_discard_recover & status_word1_capt);


  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      flush_wait_for_manrd  <= 1'b0;
      rx_dma_pkt_flushed <= 1'b0;
    end
    else
    begin
      if (flush_wait_for_manrd &
          (status_word1_capt | (ahbdataph_strobe_descr_rd & ~rx_buffer_used_bit) | ahb_err_discard))
        flush_wait_for_manrd <= 1'b0;
      else if (flush_rx_pkt_hclk & num_pkts_needing_read != {p_edma_rx_pbuf_addr{1'b0}} &
              (nxt_rx_dma_state == RX_DMA_WAIT_STATUS |
               nxt_rx_dma_state == RX_DMA_MAN_RD |
               rx_dma_state     == RX_DMA_MAN_RD))
        flush_wait_for_manrd <= 1'b1;

      // Create a toggle on flush_next_packet, which will be used by
      // the registers block to increment the flush stats counter
      if (flush_next_packet | ahb_err_discard_recover)
        rx_dma_pkt_flushed <= ~rx_dma_pkt_flushed;
    end
  end


  assign reading_eop_dpram_rph = (ahbreqph_strobe_data_nopad &
                                  status_word1_capt &
                                  ~hresp_notok_eob_rph &
                                  pkt_dplocns == (status_word_1[26:15] - 12'h001) &
                                  eop_downsize);

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      reading_eop_dpram_aph <= 1'b0;
    else if (~enable_rx_hclk)
      reading_eop_dpram_aph <= 1'b0;
    else if (reading_eop_dpram_rph)
      reading_eop_dpram_aph <= 1'b1;
    else if (ahbaddph_strobe_data)
      reading_eop_dpram_aph <= 1'b0;
  end

  // Setup some useful cut-thru signals
  // 1) cutthru_statavail gets set as soon as the status for a packet
  //    becomes available. The intention is to finish reading the current
  //    packet fragment and then go fetch the packet status. Once we have
  ///   obtained that, we can progress to the end of the packet as normal
  //    Note that we only need to do this if we are actually reading the
  //    packet at risk - this only happens if we are already in the DATA
  //    state and num_pkts_needing_read == 0
  // 2) cutthru_revertdata is just a simple signal that identifies that
  //    the statemachine must revert back to the data state once the
  //    status has been obtained
  // 3) cutthru_wait4part is a signal used to identify that we have
  //    run out of packet fragments to read, and we need to wait for
  //    either more fragments to become available, or a full packet
  //    to become available
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      cutthru_statavail   <= 1'b0;
      cutthru_revertdata  <= 1'b0;
      cutthru_wait4part   <= 1'b0;
      cutthru_wait4part_reg <= 1'b0;
    end
    else if (~enable_rx_hclk)
    begin
      cutthru_statavail <= 1'b0;
      cutthru_revertdata <= 1'b0;
      cutthru_wait4part_reg <= 1'b0;
    end
    else
    begin
      if (pkt_written_dpram & num_pkts_needing_read == {p_edma_rx_pbuf_addr{1'b0}} & rx_cutthru)
        cutthru_statavail <= 1'b1;
      else if (dpram_rd_state == P_STATUS_WORD_4)
        cutthru_statavail <= 1'b0;

      // Wait until the end of the current burst before fetching the status ...
      if (cutthru_statavail & ( dpram_rd_state == P_WAIT_FOR_BUFFER |
                                dpram_rd_state == P_PKT_DATA))
        cutthru_revertdata <= 1'b1;
      else if (dpram_rd_state == P_STATUS_WORD_4)
        cutthru_revertdata <= 1'b0;

      if (num_parts_needing_read == 8'h01 & num_pkts_needing_read == {p_edma_rx_pbuf_addr{1'b0}} &
          last_partpkt_rph & ~part_pkt_written)
        cutthru_wait4part <= 1'b1;
      else if (part_pkt_written | dpram_rd_state == P_STATUS_WORD_4)
        cutthru_wait4part <= 1'b0;
      // Create a delayed verstion of cutthru_wait4part so that we can
      // detected the negative edge, at which point we will read the DPRAM.
      if (dpram_rd_state == P_PKT_DATA)
        cutthru_wait4part_reg <= cutthru_wait4part;
      else
        cutthru_wait4part_reg <= 1'b0;
    end
  end


  // If we have cut-thru operation then monitor for the write side pushing data
  // to the status word FIFO. If data is there then compare the status word
  // with the current frame start address. If there is a match then flag a
  // match and pop the FIFO once the status words have been read.

  generate if (p_edma_pbuf_cutthru == 1) begin : gen_cutthru
    wire [p_edma_rx_pbuf_addr-1:0] ct_fifo_addr;
    reg                            cutthru_status_word_pop_r;
    reg                            cutthru_status_word_valid_r;
    assign ct_fifo_addr = cutthru_status_word[p_edma_rx_pbuf_addr+p_ct_fifo_sw-1:p_ct_fifo_sw];

    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
      begin
        cutthru_status_word_valid_r <= 1'b0;
        cutthru_status_word_pop_r <= 1'b0;
      end
      else
      begin
        // Dont allow 2 pops back to back. The reason is that we pop the FIFO 1 cycle after
        // we use the data to break a data to pop CDC path
        if (cutthru_status_word_pop) begin
          cutthru_status_word_valid_r <= 1'b0;
          cutthru_status_word_pop_r <= 1'b0;
        end

        // If the state machine is in idle them just pop the FIFO.
        else if (!cutthru_status_word_empty && dpram_rd_state == P_IDLE)
        begin
          cutthru_status_word_valid_r <= 1'b0;
          cutthru_status_word_pop_r <= 1'b1;
        end
        // Determine if the status words in the cutthru status word FIFO match the
        // current frame. Additionally if we have captured the status words then
        // pop the FIFO.
        else if (!cutthru_status_word_empty && ct_fifo_addr == saved_start)
        begin
          cutthru_status_word_valid_r <= 1'b1;
          // If we have read all of the status words then pop the FIFO
          if (dpram_rd_state == P_STATUS_WORD_4)
            cutthru_status_word_pop_r <= 1'b1;
        end
      end
    end
    assign cutthru_status_word_valid = cutthru_status_word_valid_r;
    assign cutthru_status_word_pop = cutthru_status_word_pop_r;
  end else begin : gen_no_cutthru
    assign cutthru_status_word_valid  = 1'b0;
    assign cutthru_status_word_pop    = 1'b0;
  end
  endgenerate
  
  wire [13:0] full_pkt_size_1;
  wire [14:0] full_pkt_size_2;
  wire [13:0] full_pkt_size_3;
  
  assign full_pkt_size_1 = {1'b0,(status_word_1[26:15]-(|status_word_3[3:0])),status_word_3[3]} + {13'h0000,|status_word_3[2:0]} + {12'h000,words_in_residue[1:0]};
  assign full_pkt_size_2 = {     (status_word_1[26:15]-(|status_word_3[3:0])),status_word_3[3:2]} + {13'h0000,|status_word_3[1:0]} + {12'h000,words_in_residue[1:0]};
  assign full_pkt_size_3 = {2'h0,(status_word_1[26:15])}                                          + {12'h000,words_in_residue[1:0]};
  
   // Synchronous store state machine assignments
   // rx disabled = soft reset
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      dpram_rd_state                 <= P_IDLE;
      last_dpram_rd_state            <= P_IDLE;
      rxdpram_web                    <= 1'b0;
      rxdpram_enb                    <= 1'b0;
      rxdpram_enb_d1                 <= 1'b0;
      rxdpram_addrb                  <= {p_edma_rx_pbuf_addr{1'b0}};
      status_word_1                  <= {p_sw_wid{1'b0}};
      status_word_2                  <= {p_sw_wid{1'b0}};
      status_word_3                  <= {p_sw_wid{1'b0}};
      full_pkt_size                  <= 14'h0000;
      status_word2_capt              <= 1'b0;
      status_word3_capt              <= 1'b0;
      saved_addr                     <= {p_edma_rx_pbuf_addr{1'b0}};
      saved_start                    <= {p_edma_rx_pbuf_addr{1'b0}};
      have_performed_read            <= 1'b0;
      status_word_early_fetch_count  <= 3'd0;
      last_partpkt_rph_seen_at_error <= 1'b0;
    end
    else if (~enable_rx_hclk)
    begin
      dpram_rd_state                 <= P_IDLE;
      last_dpram_rd_state            <= P_IDLE;
      rxdpram_web                    <= 1'b0;
      rxdpram_enb                    <= 1'b0;
      rxdpram_enb_d1                 <= 1'b0;
      rxdpram_addrb                  <= {p_edma_rx_pbuf_addr{1'b0}};
      status_word_1                  <= {p_sw_wid{1'b0}};
      status_word_2                  <= {p_sw_wid{1'b0}};
      status_word_3                  <= {p_sw_wid{1'b0}};
      full_pkt_size                  <= 14'h0000;
      status_word2_capt              <= 1'b0;
      status_word3_capt              <= 1'b0;
      saved_addr                     <= {p_edma_rx_pbuf_addr{1'b0}};
      saved_start                    <= {p_edma_rx_pbuf_addr{1'b0}};
      have_performed_read            <= 1'b0;
      status_word_early_fetch_count  <= 3'd0;
      last_partpkt_rph_seen_at_error <= 1'b0;
    end
    else
    begin
      dpram_rd_state      <= dpram_rd_state_nxt;
      last_dpram_rd_state <= dpram_rd_state;
      rxdpram_web         <= rxdpram_web_nxt;
      rxdpram_enb         <= rxdpram_enb_nxt & ~hresp_notok_eob;  // Don't care about SRAM data when major error occurs.
      rxdpram_enb_d1      <= rxdpram_enb;
      rxdpram_addrb       <= rxdpram_addrb_nxt;
      status_word_1       <= nxt_status_word_1;
      status_word_2       <= nxt_status_word_2;
      status_word_3       <= nxt_status_word_3;
      if (p_edma_axi == 1)
        full_pkt_size     <= (p_edma_rx_pbuf_data == 32'd128 & dma_bus_width == 2'b01) ? full_pkt_size_1:
                             (p_edma_rx_pbuf_data == 32'd128 & dma_bus_width == 2'b00) ? full_pkt_size_2[13:0]:
                                                                                         full_pkt_size_3;
      if (real_eop_ahb_rph | nxt_pkt_is_err)
      begin
        status_word2_capt <= 1'b0;
        status_word3_capt <= 1'b0;
      end
      else
      begin
        status_word2_capt <= status_word1_capt;
        status_word3_capt <= status_word2_capt;
      end
      saved_addr                     <= saved_addr_nxt;
      saved_start                    <= saved_start_nxt;
      have_performed_read            <= have_performed_read_nxt;
      status_word_early_fetch_count  <= status_word_early_fetch_count_nxt;
      last_partpkt_rph_seen_at_error <= last_partpkt_rph_seen_at_error_nxt;
    end
  end

  generate if (p_edma_tsu == 1) begin: gen_status_word_4_tsu
    reg [p_sw_wid-1:0] status_word_4_r;
    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        status_word_4_r     <= {p_sw_wid{1'b0}};
      else if (~enable_rx_hclk)
        status_word_4_r    <= {p_sw_wid{1'b0}};
      else
        status_word_4_r    <= nxt_status_word_4;
    end
    assign status_word_4 = status_word_4_r;
  end else begin: gen_status_word_4_no_tsu
    assign status_word_4 = {p_sw_wid{1'b0}};
  end
  endgenerate


  // The eop address can be calculated using the formula:
  // eop address = start address + packet length + pkt eop address mod
  // Note. The calculation has been extended to 16 bits to account for the
  // cases where the pbuf address with is larger or smaller than the packet
  // length

  // capture the packets lengths and the end address mod from the status wrods
  // coming from the rx_wr side.
  // We also detect if the incoming frame has an error. If this is the case then
  // the frame will be discarded and the pkt_length is only valid for recovering
  // locations and not for calculating the packet end address.
  // Note. The above differs for partial store and forward mode, as this mode doesn't
  // silently drop frames, so the pkt length must be used to calculate the end address.

  always @(*) begin

    // Is there an error on the frame
    if (status_word_1[0] || rx_cutthru)
      pkt_length_corrected = {5'd0,status_word_1[26:15]};
    else
      pkt_length_corrected = 17'd0;

    // Depending on the dma bus width the pkt_end_addr_mod is valid at differing
    // times
    if (dma_bus_width[0] || gem_rx_pbuf_data_w_is_128 || |status_word_early_fetch_count || rx_bd_extended_mode_en )
      pkt_end_addr_mod = {{9{status_word_2[7]}}, status_word_2[7:0]};

    else if (cutthru_status_word_valid)
      pkt_end_addr_mod = {{9{ct_fifo_w1p[7]}}, ct_fifo_w1p[7:0]};

    else
      pkt_end_addr_mod = {{9{rxdpram_dob_w0p[7]}}, rxdpram_dob_w0p[7:0]};

  end

  assign pkt_end_addr = {{17-p_edma_rx_pbuf_addr{1'b0}},saved_start} + pkt_length_corrected + pkt_end_addr_mod;

  // Helper funciton to stop code bloat. The address increment is implemented in
  // a number of place, so this function is used to keep the code tidy.
  function [p_edma_rx_pbuf_addr-1:0] get_next_addr;
    input                           inc;
    input [p_edma_rx_pbuf_addr-1:0] saved_addr;
    input [p_edma_rx_pbuf_addr-1:0] current_addr;
    input                     [1:0] dma_bus_width;
    input                           rx_bd_extended_mode_en;
    
    reg   [p_edma_rx_pbuf_addr:0] current_addr_p1;
    reg   [p_edma_rx_pbuf_addr:0] current_addr_p2;
    reg   [p_edma_rx_pbuf_addr:0] current_addr_p3;
    reg   [p_edma_rx_pbuf_addr:0] current_addr_p4;
    reg   [p_edma_rx_pbuf_addr:0] current_addr_p5;
    
    begin
      // First off we calculate some values before getting into the core of
      // this function. This is done for LINT purposes
      current_addr_p1 = current_addr + {{(p_edma_rx_pbuf_addr-1){1'b0}},1'b1};
      current_addr_p2 = current_addr + {{(p_edma_rx_pbuf_addr-2){1'b0}},2'd2};
      current_addr_p3 = current_addr + {{(p_edma_rx_pbuf_addr-2){1'b0}},2'd3};
      current_addr_p4 = current_addr + {{(p_edma_rx_pbuf_addr-3){1'b0}},3'd4};
      current_addr_p5 = current_addr + {{(p_edma_rx_pbuf_addr-3){1'b0}},3'd5};
      
      // If the next address matches the start address - i.e. we have wrapped
      // round in cut-thru mode when we have a relatively small packet buffer,
      // then jump over the saved address.
      if ((current_addr_p1[p_edma_rx_pbuf_addr-1:0]) == saved_addr & inc)
        if (p_edma_rx_pbuf_data == 32'd128)
          get_next_addr = current_addr_p2[p_edma_rx_pbuf_addr-1:0];
        else if (dma_bus_width[0])
          get_next_addr = current_addr_p3[p_edma_rx_pbuf_addr-1:0];
        else if (~rx_bd_extended_mode_en)
          get_next_addr = current_addr_p4[p_edma_rx_pbuf_addr-1:0];
        else
          get_next_addr = current_addr_p5[p_edma_rx_pbuf_addr-1:0];

      // Increment if we are doing an increment.
      else if (inc)
        get_next_addr = current_addr_p1[p_edma_rx_pbuf_addr-1:0];
      else
        get_next_addr = current_addr;
    end
  endfunction

  // Helper signal that used below in a number of places to identify when no
  // frame data is pending.
  assign no_data_pending = (reading_eop_dpram_rph | cutthru_wait4part | ahb_err_pktdiscarded_wait4end |
                              (rx_cutthru &
                              last_partpkt_rph &
                                (~(|num_pkts_needing_read) |
                                // At an error frame the entire frame won't be written by the write side, so at the last part pkt it
                                // could well be the last part of the frame, as there will be no more data. In this case we need to
                                // block the next reads to the RAM. An error occurred here when there was only one frame and the read side
                                // was writing the end of a new (small) frame as the rd side read past the end of the current frame.
                                // In this case a DPRAM clash occurred. We therefore now block the write in this case.
                               ((num_pkts_needing_read == {{p_edma_rx_pbuf_addr-1{1'b0}},1'd1}) & (status_word_early_fetch_count >= 3'd1) & (dpram_rd_state != P_STATUS_WORD_1) & ~status_word_1[0] & (part_dplocns_left_downsize[16:0] == 17'd0))) &
                              num_parts_needing_read[7:1] == 7'h00 &
                              ~part_pkt_written));


  // DPRAM read state machine
  // Note. As part of the 128b DPRAM changes quite a few edits were made to
  // the DPRAM addressing to make accesses more predictable. The original
  // design read the same locations multiple times and the dpram enable and
  // address didn't need to step at the same time. The 128b changes required
  // a read, only when data was needed, rather than continually reading the
  // same location. This was needed as a read to the downsize buffer would
  // increment to the next data slices and it's effectively not possible to
  // read and re-read the same data more than once. There are therefore
  // a number of changes around the DPRAM addressing.
  
  // Here there are a few signals created to store the result of 
  // additions that according to AFL can potentially bring to overflow
  wire   [p_edma_rx_pbuf_addr:0] rxdpram_addrb_p1;
  wire   [p_edma_rx_pbuf_addr:0] rxdpram_addrb_p2;
  wire   [p_edma_rx_pbuf_addr:0] rxdpram_addrb_p3;
  wire   [p_edma_rx_pbuf_addr:0] rxdpram_addrb_p4;
  wire   [p_edma_rx_pbuf_addr:0] rxdpram_addrb_nxt_c1;
  wire   [p_edma_rx_pbuf_addr:0] rxdpram_addrb_nxt_c2;
  wire   [p_edma_rx_pbuf_addr:0] saved_start_p2;
  wire   [p_edma_rx_pbuf_addr:0] saved_start_p3;
  wire   [p_edma_rx_pbuf_addr:0] part_dplocns_p2;
  wire   [p_edma_rx_pbuf_addr:0] part_dplocns_p3;
  wire   [p_edma_rx_pbuf_addr:0] part_dplocns_p4;
  wire   [p_edma_rx_pbuf_addr:0] part_dplocns_p5;
  wire   [p_edma_rx_pbuf_addr:0] recover_dplocns_err_p1;
  wire   [p_edma_rx_pbuf_addr:0] recover_dplocns_err_p2;
  wire   [p_edma_rx_pbuf_addr:0] recover_dplocns_err_p3;
  wire   [p_edma_rx_pbuf_addr:0] recover_dplocns_err_p4;
  wire   [p_edma_rx_pbuf_addr:0] part_dplocns_left_c1;
  wire   [p_edma_rx_pbuf_addr:0] part_dplocns_left_c2;
  wire   [p_edma_rx_pbuf_addr:0] part_dplocns_left_c3;
  wire   [p_edma_rx_pbuf_addr:0] pkt_dplocns_str_c1;
  wire   [p_edma_rx_pbuf_addr:0] pkt_dplocns_str_c2;
  wire   [p_edma_rx_pbuf_addr:0] pkt_dplocns_str_c3;
  wire                     [3:0] status_word_early_fetch_count_p2;
  wire   [p_edma_rx_pbuf_addr:0] rx_cutthru_threshold_p1;
  wire                    [11:0] pkt_dplocns_c1;
  
  assign rxdpram_addrb_p1                 = rxdpram_addrb + {{p_edma_rx_pbuf_addr-1{1'b0}},1'd1};
  assign rxdpram_addrb_p2                 = rxdpram_addrb + {{p_edma_rx_pbuf_addr-2{1'b0}},2'd2};
  assign rxdpram_addrb_p3                 = rxdpram_addrb + {{p_edma_rx_pbuf_addr-2{1'b0}},2'd3};
  assign rxdpram_addrb_p4                 = rxdpram_addrb + {{p_edma_rx_pbuf_addr-3{1'b0}},3'd4};
  assign rxdpram_addrb_nxt_c1             = rxdpram_addrb + part_dplocns_left + {{p_edma_rx_pbuf_addr-1{1'b0}},~have_performed_read};
  assign rxdpram_addrb_nxt_c2             = rxdpram_addrb + part_dplocns_left;
  assign saved_start_p2                   = saved_start   + {{p_edma_rx_pbuf_addr-2{1'b0}},2'd2};
  assign saved_start_p3                   = saved_start   + {{p_edma_rx_pbuf_addr-2{1'b0}},2'd3};
  assign part_dplocns_p2                  = part_dplocns  + {{p_edma_rx_pbuf_addr-2{1'b0}},2'd2};
  assign part_dplocns_p3                  = part_dplocns  + {{p_edma_rx_pbuf_addr-2{1'b0}},2'd3};
  assign part_dplocns_p4                  = part_dplocns  + {{p_edma_rx_pbuf_addr-3{1'b0}},3'd4};
  assign part_dplocns_p5                  = part_dplocns  + {{p_edma_rx_pbuf_addr-3{1'b0}},3'd5};
  assign recover_dplocns_err_p1           = recover_dplocns_err[p_edma_rx_pbuf_addr-1:0] + {{p_edma_rx_pbuf_addr-1{1'b0}},1'd1};
  assign recover_dplocns_err_p2           = recover_dplocns_err[p_edma_rx_pbuf_addr-1:0] + {{p_edma_rx_pbuf_addr-2{1'b0}},2'd2};
  assign recover_dplocns_err_p3           = recover_dplocns_err[p_edma_rx_pbuf_addr-1:0] + {{p_edma_rx_pbuf_addr-2{1'b0}},2'd3};
  assign recover_dplocns_err_p4           = recover_dplocns_err[p_edma_rx_pbuf_addr-1:0] + {{p_edma_rx_pbuf_addr-3{1'b0}},3'd4};
  assign part_dplocns_left_c1             = part_dplocns_pending + rx_cutthru_threshold + {{p_edma_rx_pbuf_addr-1{1'b0}},1'd1};
  assign part_dplocns_left_c2             = part_dplocns_left    + rx_cutthru_threshold;
  assign part_dplocns_left_c3             = part_dplocns_left    + rx_cutthru_threshold + {{p_edma_rx_pbuf_addr-1{1'b0}},1'd1};
  assign pkt_dplocns_str_c1               = pkt_dplocns_str      + status_word_1[p_edma_rx_pbuf_addr+14:15];
  assign pkt_dplocns_str_c2               = pkt_dplocns_str      + pkt_dplocns_to_flush_plus_st;
  assign pkt_dplocns_str_c3               = pkt_dplocns_str      + part_dplocns + {{p_edma_rx_pbuf_addr-1{1'b0}},1'b1};
  assign rx_cutthru_threshold_p1          = rx_cutthru_threshold + {{p_edma_rx_pbuf_addr-1{1'b0}},1'b1};
  assign status_word_early_fetch_count_p2 = status_word_early_fetch_count + 3'd2;
  
  // This whole generate if statement is because we want to avoid LINT warnings...
  generate if(p_edma_rx_pbuf_addr > 32'd11) begin: gen_pkt_dplocns_c1_1
  
    wire [p_edma_rx_pbuf_addr+1:0] pkt_dplocns_aux;
    assign                         pkt_dplocns_aux = rx_cutthru_threshold_p1 + {{(p_edma_rx_pbuf_addr-11){1'b0}},pkt_dplocns};
    assign                         pkt_dplocns_c1  = pkt_dplocns_aux[11:0];
    
  end else if(p_edma_rx_pbuf_addr == 32'd11) begin: gen_pkt_dplocns_c1_2
  
    wire [p_edma_rx_pbuf_addr+1:0] pkt_dplocns_aux;
    assign                         pkt_dplocns_aux = rx_cutthru_threshold_p1 + pkt_dplocns;
    assign                         pkt_dplocns_c1  = pkt_dplocns_aux[11:0];
    
  end else begin: gen_pkt_dplocns_c1_3
  
    wire [12:0] pkt_dplocns_aux2;  
    assign      pkt_dplocns_aux2 = {{(11-p_edma_rx_pbuf_addr){1'b0}},rx_cutthru_threshold_p1} + pkt_dplocns;
    assign      pkt_dplocns_c1   = pkt_dplocns_aux2[11:0];
    
  end
  endgenerate  
  
  always @ ( * )
  begin
    rxdpram_enb_nxt                    = 1'b0;
    rxdpram_web_nxt                    = 1'b0;
    rxdpram_addrb_nxt                  = rxdpram_addrb;
    status_word1_capt                  = status_word2_capt;
    saved_addr_nxt                     = saved_addr;
    saved_start_nxt                    = saved_start;
    dpram_rd_state_nxt                 = dpram_rd_state;
    rd_downsize                        = 1'b0;
    flush_downsize                     = 1'b0;
    have_performed_read_nxt            = have_performed_read;
    cutthru_status_word_override       = 1'b0;
    status_word_early_fetch_count_nxt  = status_word_early_fetch_count;
    last_partpkt_rph_seen_at_error_nxt = last_partpkt_rph_seen_at_error;
    start_reading_at_risk = 1'b0;

    case (dpram_rd_state)
      P_IDLE  :
      begin
        flush_downsize                     = 1'b1;
        have_performed_read_nxt            = 1'b0;
        status_word_early_fetch_count_nxt  = 3'd0;
        last_partpkt_rph_seen_at_error_nxt = 1'b0;

        if (priq_get_status_info) begin
          rxdpram_enb_nxt = 1'b1;
        end

        if (
            // Wait until the stats for previous pkt have been
            // captured by REG block
            prev_stats_captured & last_dpram_rd_state != P_STATUS_WORD_4 &

            // Cant start reading the next status until we are
            // sure we are done with the current status - some bits
            // are needed for the writeback so wait until the
            // writeback is compeleted before starting a new read
            rx_dma_state != RX_DMA_MAN_WR & ~reading_eop_dpram_aph &
            ~reading_eop_dpram_aph_del & ~padding_aph &

            ~status_word1_capt)
        begin
          saved_addr_nxt     = rxdpram_addrb;
          saved_start_nxt    = rxdpram_addrb;

          if (|num_pkts_needing_read)
          begin
            dpram_rd_state_nxt = P_STATUS_WORD_1;
            rxdpram_enb_nxt    = (~cutthru_status_word_valid & p_edma_queues == 32'd1) | priq_get_status_info;
          end
          else if (|num_parts_needing_read)
          begin

            // Record that we have status words pending to read.
            start_reading_at_risk = 1'b1;

            //  we are going to write the
            // data to memory 'at risk' because we are in cutthru.  Since the
            // status is not available yet, we just jump straight to data state
            // and set bit zero of statusword1 for now - this bit identifies
            // there is valid data to reasd from the dpram
            cutthru_status_word_override = 1'b1;
            if (buffer_available)
            begin
              flush_downsize      = 1'b0;
              dpram_rd_state_nxt  = P_PKT_DATA;
              saved_start_nxt     = rxdpram_addrb;
              rxdpram_enb_nxt     = 1'b1;
              rd_downsize         = 1'b1;
              rxdpram_addrb_nxt = gem_rx_pbuf_data_w_is_128 ? rxdpram_addrb_p1[p_edma_rx_pbuf_addr-1:0]
                                  : dma_bus_width[0]        ? rxdpram_addrb_p2[p_edma_rx_pbuf_addr-1:0]
                                  : ~rx_bd_extended_mode_en ? rxdpram_addrb_p3[p_edma_rx_pbuf_addr-1:0]
                                                            : rxdpram_addrb_p4[p_edma_rx_pbuf_addr-1:0];
            end
            else
            begin
              dpram_rd_state_nxt = P_WAIT_FOR_BUFFER;
              rxdpram_enb_nxt    = 1'b0;
              saved_start_nxt    = rxdpram_addrb;
              // If We don't have a buffer available then position the address pointer at
              // the last status word location. The wait_for_buffer state will then
              // increment the address to the first data word.
              rxdpram_addrb_nxt = gem_rx_pbuf_data_w_is_128 ? rxdpram_addrb
                                  : dma_bus_width[0]        ? rxdpram_addrb_p1[p_edma_rx_pbuf_addr-1:0]
                                  : ~rx_bd_extended_mode_en ? rxdpram_addrb_p2[p_edma_rx_pbuf_addr-1:0]
                                                            : rxdpram_addrb_p3[p_edma_rx_pbuf_addr-1:0];
            end
          end
          else
          // When priority queueing is enabled, we want to obtain
          // the status information asap, as the status holds the queue
          // information.  This means we will be reading from the DPRAM
          // more than we really need to, but it is the most efficient
          // way
          // The address should already be pointing to the status word,
          // so we can just enable the DPRAM rd here
            rxdpram_enb_nxt = priq_get_status_info;
        end
        else
          rxdpram_enb_nxt = priq_get_status_info;
      end

      P_STATUS_WORD_1 :
      begin


        // If we are in status_word_early_fetch_count mode then we are only fetching
        // one status word at a time so we go back to the state we came from, in case
        // any AHB or AXI accesses are taking place
        if (|status_word_early_fetch_count) begin

          rxdpram_addrb_nxt = saved_addr;
          if (last_dpram_rd_state == P_WAIT_FOR_BUFFER)
            dpram_rd_state_nxt = P_WAIT_FOR_BUFFER;
          else begin
            dpram_rd_state_nxt  = P_PKT_DATA;
              // Read the RAM if a new AXI REquest has come in
            if (ahbreqph_strobe_data_nopad)
            begin
              rxdpram_addrb_nxt = get_next_addr(empty_downsize,saved_start,saved_addr,dma_bus_width,rx_bd_extended_mode_en);
              rxdpram_enb_nxt   = empty_downsize & ~no_data_pending;
              rd_downsize       = 1'b1;
            end
          end

        end
        else begin
          dpram_rd_state_nxt  = P_STATUS_WORD_2;
          if (~gem_rx_pbuf_data_w_is_128) begin
            rxdpram_addrb_nxt = rxdpram_addrb_p1[p_edma_rx_pbuf_addr-1:0];
            rxdpram_enb_nxt   = ~cutthru_status_word_valid;
          end
        end

      end

      P_STATUS_WORD_2 :
      begin

        // If we are in status_word_early_fetch_count mode then we are only fetching
        // one status word at a time so we go back to the state we came from, in case
        // any AHB or AXI accesses are taking place
        if (|status_word_early_fetch_count) begin

          rxdpram_addrb_nxt = saved_addr;
          if (last_dpram_rd_state == P_WAIT_FOR_BUFFER)
            dpram_rd_state_nxt = P_WAIT_FOR_BUFFER;
          else begin
            dpram_rd_state_nxt  = P_PKT_DATA;
            // Read the RAM if a new AXI REquest has come in
            if (ahbreqph_strobe_data_nopad)
            begin
              rxdpram_addrb_nxt = get_next_addr(empty_downsize,saved_start,saved_addr,dma_bus_width,rx_bd_extended_mode_en);
              rxdpram_enb_nxt = empty_downsize & ~no_data_pending;
              rd_downsize = 1'b1;
            end
          end

        end

        else begin
          // Setup Request phase of STATUS WORD3
          // Setup Address phase of STATUS WORD2
          // Data phase of STATUS WORD1
          if (gem_rx_pbuf_data_w_is_128) begin
            rxdpram_addrb_nxt = rxdpram_addrb;
            rxdpram_enb_nxt   = 1'b0;
          end
          else if (dma_bus_width[0]) begin
            rxdpram_addrb_nxt = rxdpram_addrb;
            rxdpram_enb_nxt   = 1'b0;
          end
          else
          begin
            rxdpram_enb_nxt   = ~cutthru_status_word_valid;
            rxdpram_addrb_nxt = rxdpram_addrb_p1[p_edma_rx_pbuf_addr-1:0];
          end
          if (~rx_bd_extended_mode_en)
            dpram_rd_state_nxt= P_STATUS_WORD_4; // jump STATUS_3 for legacy mode
          else
            dpram_rd_state_nxt= P_STATUS_WORD_3;
        end

      end

      P_STATUS_WORD_3 : // only used for extra status word read
      begin

        // If we are in status_word_early_fetch_count mode then we are only fetching
        // one status word at a time so we go back to the state we came from, in case
        // any AHB or AXI accesses are taking place
        if (|status_word_early_fetch_count) begin

          rxdpram_addrb_nxt = saved_addr;
          if (last_dpram_rd_state == P_WAIT_FOR_BUFFER)
            dpram_rd_state_nxt = P_WAIT_FOR_BUFFER;
          else begin
            dpram_rd_state_nxt  = P_PKT_DATA;
            // Read the RAM if a new AXI REquest has come in
            if (ahbreqph_strobe_data_nopad)
            begin
              rxdpram_addrb_nxt = get_next_addr(empty_downsize,saved_start,saved_addr,dma_bus_width,rx_bd_extended_mode_en);
              rxdpram_enb_nxt = empty_downsize & ~no_data_pending;
              rd_downsize = 1'b1;
            end
          end

        end

        else begin
          if (~gem_rx_pbuf_data_w_is_128)
          begin
            if (dma_bus_width[0])
            begin
              rxdpram_addrb_nxt = rxdpram_addrb;
              rxdpram_enb_nxt   = 1'b0;
            end
            else
            begin
              rxdpram_enb_nxt   = ~cutthru_status_word_valid;
              rxdpram_addrb_nxt = rxdpram_addrb_p1[p_edma_rx_pbuf_addr-1:0];
            end
          end
          dpram_rd_state_nxt= P_STATUS_WORD_4;
        end
      end

      P_STATUS_WORD_4 :   // last status word state
      begin

        status_word1_capt = 1'b1;
        last_partpkt_rph_seen_at_error_nxt = 1'b0;

        // If there is an error with the data, then when cutthru is OFF,
        // there will be no data associated with the packet.  If cut-thru
        // is ON, there will be rubbish data in the dpram that we need
        // to clear out - we dont need to pass this to AHB however ...
        // Jump the address to the end of the packet
        if (((~status_word_1[0] | ahb_err_pktdiscarded_wait4end) & (rx_cutthru | force_discard_on_error))
            | flush_next_packet | ahb_err_discard_recover)
          rxdpram_addrb_nxt = pkt_end_addr[p_edma_rx_pbuf_addr-1:0];

        // If we are doing the early fetch then we will do a read
        // if a new axi requests comes in.
        else if (|status_word_early_fetch_count) begin
          rxdpram_addrb_nxt = saved_addr;
          // Read the RAM if a new AXI REquest has come in
          if (ahbreqph_strobe_data_nopad)
            rxdpram_addrb_nxt = get_next_addr(empty_downsize,saved_start,saved_addr,dma_bus_width,rx_bd_extended_mode_en);
        end

        else if (cutthru_revertdata)
        begin
          // If we have come from the pkt_data state (we must have done so if
          // cutthru_revertdata is active), when we are in cut through mode,
          // then the status has become available at the end of part packet. When
          // we go pack to the packet data state then the buffer must be available,
          // so we will increment to the next address read.
          rxdpram_addrb_nxt = get_next_addr(1'b1, saved_start, saved_addr , dma_bus_width, rx_bd_extended_mode_en);
          if (gem_rx_pbuf_data_w_is_128)
            saved_addr_nxt = rxdpram_addrb;
          else if (dma_bus_width[0])
            saved_addr_nxt = rxdpram_addrb-{{p_edma_rx_pbuf_addr-1{1'b0}},1'd1};
          else
            if (rx_bd_extended_mode_en)
              saved_addr_nxt = rxdpram_addrb-{{p_edma_rx_pbuf_addr-2{1'b0}},2'd3};
            else
              saved_addr_nxt = rxdpram_addrb-{{p_edma_rx_pbuf_addr-2{1'b0}},2'd2};
        end

        // When a part packet is sent and we can get status, we will retrieve the status.
        // Once the status has been obtained a new buffer may not be available, so we
        // will wait for new data (i.e. go to the P_WAIT_FOR_BUFFER state). If this is
        // the case then we won't increment the ram address. When a buffer is
        // available, we will read the next data within the P_WAIT_FOR_BUFFER state.
        else if (status_word_1[0] & ~ahb_err_pktdiscarded_wait4end & ~flush_next_packet & ~ahb_err_discard_recover) begin
          if (buffer_available)
            rxdpram_addrb_nxt = get_next_addr(empty_downsize,saved_start,rxdpram_addrb,dma_bus_width,rx_bd_extended_mode_en);
          else
            rxdpram_addrb_nxt = rxdpram_addrb;
        end
        // The packet was received with an error, so we will just increment the
        // address and will move back to idle
        else
          rxdpram_addrb_nxt = rxdpram_addrb_p1[p_edma_rx_pbuf_addr-1:0];

        // [31] set means that we dont have status info, but can
        // start reading the data at risk ...
        // [0] means that the status is available and data is available
        if (status_word_1[0] & ~ahb_err_pktdiscarded_wait4end & ~flush_next_packet & ~ahb_err_discard_recover)
        begin
          if (|status_word_early_fetch_count) begin
            if (last_dpram_rd_state == P_WAIT_FOR_BUFFER)
              dpram_rd_state_nxt = P_WAIT_FOR_BUFFER;
            else begin
              dpram_rd_state_nxt = P_PKT_DATA;
              if (ahbreqph_strobe_data_nopad && !no_data_pending) begin
                rxdpram_enb_nxt = empty_downsize;
                rd_downsize = 1'b1;
              end
            end
          end
          else if (buffer_available)
          begin
            dpram_rd_state_nxt = P_PKT_DATA;
            rxdpram_enb_nxt = empty_downsize;
            rd_downsize = 1'b1;
          end
          else
          begin
            dpram_rd_state_nxt = P_WAIT_FOR_BUFFER;
            rxdpram_enb_nxt = 1'b0;
          end
        end
        else
        begin
          dpram_rd_state_nxt = P_IDLE;
          rxdpram_enb_nxt = 1'b0;
        end
      end

      P_WAIT_FOR_BUFFER :
      begin

        if (flush_next_packet | (ahb_err_discard_recover & status_word1_capt))
        begin
          dpram_rd_state_nxt = P_IDLE;
          rxdpram_enb_nxt = 1'b0;
          // The DPRAM state machine is designed to perform an address increment when we
          // actually need the next data. If we have for example 8 locations left
          // (part_dplocns_left) then we have 8 increments left to do, but we will also
          // need 1 extra increment to put us to the start of the next packet - this is why
          // the have_performed_read signal is added to the end.
          rxdpram_addrb_nxt = rxdpram_addrb_nxt_c1[p_edma_rx_pbuf_addr-1:0];
        end
        else if (buffer_available | ahb_err_pktdiscarded_wait4end | ahb_err_discard_recover)
        begin
          dpram_rd_state_nxt = P_PKT_DATA;
          have_performed_read_nxt = 1'b0;
          // It's possible that we may have run out of buffer data at the same time as
          // a part packet has finished. In this case, we could have fetched a new buffer
          // location but may not have part packet ready. If this is the case then we will
          // only do a DPRAM read if a part packet or full packet is available.
          if ((|num_parts_needing_read & rx_cutthru) | (|num_pkts_needing_read)) begin
            rxdpram_enb_nxt = empty_downsize & ~have_performed_read;
            rd_downsize = ~have_performed_read;
            rxdpram_addrb_nxt = get_next_addr(empty_downsize & ~have_performed_read,saved_start,rxdpram_addrb,dma_bus_width,rx_bd_extended_mode_en);
          end
        end
        // Fix for CUTTHRU_BUG (28/8/2013) - same fix as within the p_pkt_data section
        else if (cutthru_statavail && status_word_early_fetch_count != 3'd4) begin

          saved_addr_nxt = rxdpram_addrb;

          case (status_word_early_fetch_count)

            3'b000 : begin
              rxdpram_enb_nxt = ~cutthru_status_word_valid;
              rxdpram_addrb_nxt = saved_start;
              dpram_rd_state_nxt = P_STATUS_WORD_1;
              status_word_early_fetch_count_nxt = status_word_early_fetch_count + 3'd1;
            end
            3'b001 : begin
              rxdpram_enb_nxt = ~gem_rx_pbuf_data_w_is_128 & ~cutthru_status_word_valid; // Only do a read if we are not in 128b mode
              rxdpram_addrb_nxt = saved_start + {{p_edma_rx_pbuf_addr-1{1'b0}},1'd1};
              dpram_rd_state_nxt = P_STATUS_WORD_2;
              status_word_early_fetch_count_nxt = status_word_early_fetch_count + 3'd1;
            end
            // If rx_bd_extended_mode_en is off then we jump over P_STATUS_WORD_3.
            // However, there is a bit of a complication here for errored
            // frames. All existing code is designed to recover frames
            // locations at an errored frame in P_STATUS_WORD_4, and once this
            // state has been reached we go back to IDLE straight away as the
            // frame is errored. This doesn't work for status_word_early_fetch
            // mode as we may have been mid-way through an AMBA burst when we
            // read the status words, so we want to finish the burst before
            // going back to idle. When a frame is errored we therefore avoid
            // reading the last status word until the end of a part packet.
            // The 4th status word is redundant for errored frames - only
            // status words 1-3 are needed, so we can hold off moving into the
            // 4th status word state until a noticeable boundary has passed
            // (part packet for example). If the write side overwrites the
            // 4th status word then it doesn't matter as it's not used anyway.
            3'b010 : begin
              rxdpram_enb_nxt   = ~gem_rx_pbuf_data_w_is_128 & ~dma_bus_width[0] & ~cutthru_status_word_valid; // Only do a read if we are in 32b mode;
              rxdpram_addrb_nxt = saved_start_p2[p_edma_rx_pbuf_addr-1:0];
              // At an error always move to P_STATUS_WORD_3
              if (!status_word_1[0]) begin
                dpram_rd_state_nxt = P_STATUS_WORD_3;
                status_word_early_fetch_count_nxt = status_word_early_fetch_count + 3'd1;
              end
              // If we are in extended bd mode then move to read status word 3
              // or jump over P_STATUS_WORD_3
              else begin
                if (!rx_bd_extended_mode_en) begin
                  dpram_rd_state_nxt = P_STATUS_WORD_4;
                  status_word_early_fetch_count_nxt = status_word_early_fetch_count_p2[2:0];
                end
                else begin
                  dpram_rd_state_nxt = P_STATUS_WORD_3;
                  status_word_early_fetch_count_nxt = status_word_early_fetch_count + 3'd1;
                end
              end
            end

            default : begin // 3'b011
              if (!status_word_1[0]) begin
                dpram_rd_state_nxt                = P_STATUS_WORD_4;
                status_word_early_fetch_count_nxt = status_word_early_fetch_count + 3'd1;
              end
              else begin
                rxdpram_enb_nxt    = ~gem_rx_pbuf_data_w_is_128 & ~dma_bus_width[0] & ~cutthru_status_word_valid; // Only do a read if we are in 32b mode;
                rxdpram_addrb_nxt  = saved_start_p3[p_edma_rx_pbuf_addr-1:0];
                dpram_rd_state_nxt = P_STATUS_WORD_4;
                status_word_early_fetch_count_nxt = status_word_early_fetch_count + 3'd1;
              end
            end

          endcase

        end
        else
        begin
          dpram_rd_state_nxt = P_WAIT_FOR_BUFFER;
          rxdpram_enb_nxt = 1'b0;
        end
      end

      P_PKT_DATA :
      begin

        // When there is an HRESP error after the status has been
        // captured in cut thru modes, then we just jump the packet
        // to the end of the current packet and move to an IDLE
        // state
        if ((hresp_data_cutthru & status_word1_capt) | flush_next_packet)
        begin
          rxdpram_enb_nxt   = 1'b0;
          rxdpram_addrb_nxt = rxdpram_addrb_nxt_c2[p_edma_rx_pbuf_addr-1:0];
        end

        // If there are major errors, like an hresp error
        // we will just restart the packet.  To do this, we jump the
        // dpram address back to the start of the packet and move to
        // the P_WAIT_FOR_BUFFER state
        else if (hresp_notok_eob_rph & ~rx_cutthru)
        begin
          rxdpram_enb_nxt   = 1'b0;
          // At a hresp error, we should set the address to the last status word location.
          // When the packet re-starts (it will re-start because of the error) then the
          // next read access will increment the address to the first data word, as the
          // DPRAM state machine is designed to incrmenet to the next address when the
          // next data has to be used.
          flush_downsize = 1'b1;
          if (gem_rx_pbuf_data_w_is_128)
            rxdpram_addrb_nxt = saved_addr;
          else if (dma_bus_width[0])
            rxdpram_addrb_nxt = saved_addr + {{p_edma_rx_pbuf_addr-2{1'b0}},2'b01};
          else
            rxdpram_addrb_nxt = saved_start_p2[p_edma_rx_pbuf_addr-1:0];
        end

        // If we are currently using cut through mode and
        // the status is now available, wait until the end of the current
        // packet part, and then go read the status.  Also can fetch the
        // status if we are IDLE
        else if (cutthru_statavail && status_word_early_fetch_count == 3'd0 && (last_partpkt_rph ||
                                                                                cutthru_wait4part ||
                                                                                ahb_err_pktdiscarded_wait4end))
        begin
          rxdpram_enb_nxt = ~cutthru_status_word_valid;
          saved_addr_nxt = rxdpram_addrb;
          rxdpram_addrb_nxt = saved_addr;
        end

        // Cut-thru bug  (28/8/2013) - referred to as CUTTHRU_BUG
        // Using the SOC environment cutthru mode had a big issue, where the fabric
        // would back off for a period of time mid cutthru frame. If this back-off happened
        // to be in the middle of a part packet then all state machines, and in particular
        // status word fetches, are on hold until the part packet is finished. While
        // waiting on the part packet to finish a number of frames may be received.
        // It's therefore possible to have the scenario where the cut-thru frame currently
        // being sent over AXI has almost been sent and we are at position 900 out of
        // a 1000 byte frame when the fabric backs-off. The status words are written at the
        // start of the frame but these status words cannot be accessed until the part packet
        // is complete, even although they are available. The rx_wr side will however
        // re-claim the 900 bytes as it correctly believes these have been sent on. By
        // writing to this 900 byte area the rx_wr side also overwrites the status words
        // for the current cutthru frame.
        // To resolve this issue we fetch status words much earlier if the AXI or AHB
        // is not doing an access. In normal operation (before this fix) we will fetch
        // all 4 status words in a row as we have a known big gap. For this fix we
        // we could be in the middle of an AHB/AXI burst so we will fetch one status word
        // at a time.
        //
        else if ((cutthru_statavail && status_word_early_fetch_count != 3'd4 && ~last_data_to_buff_rph) &&
                    // We are not currently reading data
                  ( !(ahbreqph_strobe_data_nopad && empty_downsize) ||
                    // We are currently at the last part pkt of an error frame so we will abort the frame
                    (ahbreqph_strobe_data_nopad && last_partpkt_rph && !status_word_1[0])) )
        begin
          saved_addr_nxt = rxdpram_addrb;
          rd_downsize = ahbreqph_strobe_data;

          case (status_word_early_fetch_count)

            3'b000 : begin
              rxdpram_enb_nxt = ~cutthru_status_word_valid;
              rxdpram_addrb_nxt = saved_start;
              status_word_early_fetch_count_nxt = status_word_early_fetch_count + 3'd1;
            end
            3'b001 : begin
              rxdpram_enb_nxt = ~gem_rx_pbuf_data_w_is_128 & ~cutthru_status_word_valid; // Only do a read if we are not in 128b mode
              rxdpram_addrb_nxt = saved_start + {{p_edma_rx_pbuf_addr-1{1'b0}},1'd1};
              status_word_early_fetch_count_nxt = status_word_early_fetch_count + 3'd1;
            end
            // If rx_bd_extended_mode_en is off then we jump over P_STATUS_WORD_3.
            // However, there is a bit of a complication here for errored
            // frames. All existing code is designed to recover frames
            // locations at an errored frame in P_STATUS_WORD_4, and once this
            // state has been reached we go back to IDLE straight away as the
            // frame is errored. This doesn't work for status_word_early_fetch
            // mode as we may have been mid-way through an AMBA burst when we
            // read the status words, so we want to finish the burst before
            // going back to idle. When a frame is errored we therefore avoid
            // reading the last status word until the end of a part packet.
            // The 4th status word is redundant for errored frames - only
            // status words 1-3 are needed, so we can hold off moving into the
            // 4th status word state until a noticeable boundary has passed
            // (part packet for example). If the write side overwrites the
            // 4th status word then it doesn't matter as it's not used anyway.
            3'b010 : begin
              rxdpram_enb_nxt   = ~gem_rx_pbuf_data_w_is_128 & ~dma_bus_width[0] & ~cutthru_status_word_valid; // Only do a read if we are in 32b mode;
              rxdpram_addrb_nxt = saved_start_p2[p_edma_rx_pbuf_addr-1:0];
              // At an error always move to P_STATUS_WORD_3
              if (!status_word_1[0]) begin
                status_word_early_fetch_count_nxt = status_word_early_fetch_count + 3'd1;
              end
              // If we are in extended bd mode then move to read status word 3
              // or jump over P_STATUS_WORD_3
              else begin
                if (!rx_bd_extended_mode_en) begin
                  status_word_early_fetch_count_nxt = status_word_early_fetch_count_p2[2:0];
                end
                else begin
                  status_word_early_fetch_count_nxt = status_word_early_fetch_count + 3'd1;
                end
              end
            end

            default : begin // 3'b011
              // If the frame is errored then we will wait until a
              // recongisable boundary before moving to P_STATUS_WORD_4 to
              // allow us to clean up neatly.
              if (!status_word_1[0]) begin
                // Don't need the last data so don't bother doing the read.
                if (last_partpkt_rph ||
                    cutthru_wait4part ||
                    ahb_err_pktdiscarded_wait4end ||
                    last_partpkt_rph_seen_at_error ||
                    (part_dplocns_left == {p_edma_rx_pbuf_addr{1'b0}} && rx_cutthru)) begin
                  status_word_early_fetch_count_nxt = status_word_early_fetch_count + 3'd1;
                end
              end
              else begin
                rxdpram_enb_nxt   = ~gem_rx_pbuf_data_w_is_128 & ~dma_bus_width[0] & ~cutthru_status_word_valid; // Only do a read if we are in 32b mode;
                rxdpram_addrb_nxt = saved_start_p3[p_edma_rx_pbuf_addr-1:0];
                status_word_early_fetch_count_nxt = status_word_early_fetch_count + 3'd1;
              end
            end

          endcase

        end

        else if (ahbreqph_strobe_data_nopad)
        begin
          // Don't read the RAM as there is currenlty no data to be read.
          if (no_data_pending) begin
            rxdpram_enb_nxt   = 1'b0;
            // If the last access was an eop then move the address on.
            rxdpram_addrb_nxt = reading_eop_dpram_rph ? rxdpram_addrb_p1[p_edma_rx_pbuf_addr-1:0] : rxdpram_addrb;
          end

          // Move to the next address at a read.
          else begin
            rxdpram_enb_nxt   = empty_downsize;
            rd_downsize       = 1'b1;
            rxdpram_addrb_nxt = get_next_addr(empty_downsize,saved_start,rxdpram_addrb,dma_bus_width,rx_bd_extended_mode_en);
          end

        end

        else
        begin
          // At the falling edge of cutthru_wait4part new data has become available as
          // a result of part pkt being availble. When this occurs we will read the next
          // word, so that it's ready for the ahb/axi side.
          if (rx_cutthru) begin
            if ((|num_parts_needing_read | (|num_pkts_needing_read)) & ((~cutthru_wait4part)&cutthru_wait4part_reg)
                & ~ahb_err_pktdiscarded_wait4end) begin
              rxdpram_enb_nxt   = empty_downsize;
              rd_downsize       = 1'b1;
              rxdpram_addrb_nxt = get_next_addr(empty_downsize,saved_start,rxdpram_addrb,dma_bus_width,rx_bd_extended_mode_en);
            end
          end
          // Corner case. Padding is signalled once cycle later than what it should be
          // - i.e. we read data for the next access and then padding is signalled once
          // cycle later. If we happen to run out of buffer space at this point then we
          // will move to the P_WAIT_FOR_BUFFER state. The P_WAIT_FOR_BUFFER state
          // automatically increments the address to the next location when a buffer
          // becomes available. We don't want this to happen though as we have already
          // fetched the data.
          if (padding_rph)
             have_performed_read_nxt = 1'b1;
        end

        if (reading_eop_dpram_rph)
          dpram_rd_state_nxt  = P_IDLE;
        else if ((status_word1_capt & hresp_data_cutthru) | flush_next_packet)
          dpram_rd_state_nxt  = P_IDLE;
        else if (hresp_notok_eob_rph & ~rx_cutthru)
          dpram_rd_state_nxt  = P_WAIT_FOR_BUFFER;
        else if (cutthru_statavail && status_word_early_fetch_count == 3'd0 && (last_partpkt_rph ||
                                                                                cutthru_wait4part ||
                                                                                ahb_err_pktdiscarded_wait4end))
          dpram_rd_state_nxt  = P_STATUS_WORD_1;
        else if (last_data_to_buff_rph)
        begin
          dpram_rd_state_nxt  = P_WAIT_FOR_BUFFER;
          // Address override. When we run out of buffer space, don't increment the
          // address or perform a read. We only want to perform a read or increment
          // the address when a buffer becomes available.
          rd_downsize       = 1'b0;
          rxdpram_enb_nxt   = 1'b0;
          rxdpram_addrb_nxt = rxdpram_addrb ;
          saved_addr_nxt    = saved_addr;
        end
        else if ((cutthru_statavail && status_word_early_fetch_count != 3'd4 && ~last_data_to_buff_rph) &&
                    // We are not currently reading data
                  ( !(ahbreqph_strobe_data_nopad && empty_downsize) ||
                    // We are currently at the last part pkt of an errored frame so we will abort the frame
                    (ahbreqph_strobe_data_nopad && last_partpkt_rph && !status_word_1[0])) )
        begin

          // Record if we have already seen the last_partpkt_rph signal whilst
          // mid-way through reading the status words.
          if (last_partpkt_rph && !status_word_1[0] && status_word_early_fetch_count >= 3'd1)
            last_partpkt_rph_seen_at_error_nxt = 1'b1;


          case (status_word_early_fetch_count)

            3'b000 : begin
              dpram_rd_state_nxt = P_STATUS_WORD_1;
            end
            3'b001 : begin
              dpram_rd_state_nxt = P_STATUS_WORD_2;
            end
            3'b010 : begin
              // At an error always move to P_STATUS_WORD_3
              if (!status_word_1[0]) begin
                dpram_rd_state_nxt = P_STATUS_WORD_3;
              end
              // If we are in extended bd mode then move to read status word 3
              // or jump over P_STATUS_WORD_3
              else begin
                if (!rx_bd_extended_mode_en) begin
                  dpram_rd_state_nxt = P_STATUS_WORD_4;
                end
                else begin
                  dpram_rd_state_nxt = P_STATUS_WORD_3;
                end
              end
            end

            default : begin // 3'b011
               if (!status_word_1[0]) begin
                // Don't need the last data so don't bother doing the read.
                if (last_partpkt_rph ||
                    cutthru_wait4part ||
                    ahb_err_pktdiscarded_wait4end ||
                    last_partpkt_rph_seen_at_error ||
                    (part_dplocns_left == {p_edma_rx_pbuf_addr{1'b0}} && rx_cutthru)) begin
                  dpram_rd_state_nxt = P_STATUS_WORD_4;
                end
              end
              else begin
                dpram_rd_state_nxt = P_STATUS_WORD_4;
              end
            end

          endcase
        end
        else
          dpram_rd_state_nxt  = P_PKT_DATA;
      end

      default : dpram_rd_state_nxt  = P_IDLE; // Default
    endcase
  end

  // For cut thru modes, if there are errors that stop us reading all
  // the packet from DPRAM, we must have a means to identify how much
  // space we need to recover.  It is possible that some of the packet
  // will have been read and this pkt data will have already been
  // recovered before we realisd there was an error - we want to recover
  // the remainder of total pkt length in terms of dpram locns - num of
  // locns that have already been recovered
  wire  [16:0] tmp_recovery_bus;
  assign tmp_recovery_bus =  {5'd0,status_word_1[26:15]} - {5'd0,pkt_dplocns};
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      recover_dplocns_err <= {p_edma_rx_pbuf_addr+1{1'b0}};
    end
    else
    begin
      if (dpram_rd_state == P_STATUS_WORD_4)
      begin
        if ((~status_word_1[0] | ahb_err_pktdiscarded_wait4end | ahb_err_discard_recover) & rx_cutthru & !reading_eop_dpram_rph) begin
          if (|status_word_early_fetch_count) begin
            if (~last_partpkt_rph)
              recover_dplocns_err <=  tmp_recovery_bus[p_edma_rx_pbuf_addr-1:0] + part_dplocns;
            else
              recover_dplocns_err <=  {1'b0,tmp_recovery_bus[p_edma_rx_pbuf_addr-1:0]};
          end
          else
            recover_dplocns_err <=  {1'b0,tmp_recovery_bus[p_edma_rx_pbuf_addr-1:0]};
        end
        else
          recover_dplocns_err <=  {p_edma_rx_pbuf_addr+1{1'b0}};
      end
    end
  end


  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      ahb_err_pktdiscarded_wait4end <= 1'b0;
    else
    begin
      if (status_word1_capt | last_data_to_buff_aph)
        ahb_err_pktdiscarded_wait4end <= 1'b0;
      else if (ahb_err_discard_recover)
        ahb_err_pktdiscarded_wait4end <= 1'b1;
    end
  end

  wire  [35:0]  sts_val_1p; // Pad 1 with parity.
  assign sts_val_1p = 36'h100000001;

  // Sample the status words after they have been read from the RAM. This code
  // was originally in the P_STATUS_WORD_N states but was removed to be
  // common as the status_word_early_fetch mode can have the status words valid
  // in the P_PKT_DATA state.
  // Depending on the various bus widths the status words are sampled at
  // differing times.

  always @(*) begin

    nxt_status_word_1   = status_word_1;
    nxt_status_word_2   = status_word_2;
    nxt_status_word_3   = status_word_3;
    nxt_status_word_4   = status_word_4;

    if (cutthru_status_word_override)
      nxt_status_word_1 = sts_val_1p[p_sw_wid-1:0];

    else
      case (last_dpram_rd_state)

        P_STATUS_WORD_1 : begin

          if (cutthru_status_word_valid) nxt_status_word_1  = ct_fifo_w0p[p_sw_wid-1:0]; else nxt_status_word_1 = rxdpram_dob_w0p[p_sw_wid-1:0];
          if (gem_rx_pbuf_data_w_is_128) begin
            if (cutthru_status_word_valid) nxt_status_word_2  = ct_fifo_w1p[p_sw_wid-1:0]; else nxt_status_word_2 = rxdpram_dob_w1p[p_sw_wid-1:0];
            if (cutthru_status_word_valid) nxt_status_word_3  = ct_fifo_w2p[p_sw_wid-1:0]; else nxt_status_word_3 = rxdpram_dob_w2p[p_sw_wid-1:0];
            if (cutthru_status_word_valid) nxt_status_word_4  = ct_fifo_w3p[p_sw_wid-1:0]; else nxt_status_word_4 = rxdpram_dob_w3p[p_sw_wid-1:0];
          end
          else if (dma_bus_width[0]) begin
            if (cutthru_status_word_valid) nxt_status_word_2  = ct_fifo_w1p[p_sw_wid-1:0]; else nxt_status_word_2 = rxdpram_dob_w1p[p_sw_wid-1:0];
          end
        end

        P_STATUS_WORD_2 :

          if (~gem_rx_pbuf_data_w_is_128)
          begin
            if (dma_bus_width[0])
            begin
              if (cutthru_status_word_valid) nxt_status_word_3 = ct_fifo_w2p[p_sw_wid-1:0]; else nxt_status_word_3  = rxdpram_dob_w0p[p_sw_wid-1:0];
              if (cutthru_status_word_valid) nxt_status_word_4 = ct_fifo_w3p[p_sw_wid-1:0]; else nxt_status_word_4 = rxdpram_dob_w1p[p_sw_wid-1:0];
            end
            else if (cutthru_status_word_valid) nxt_status_word_2 = ct_fifo_w1p[p_sw_wid-1:0]; else nxt_status_word_2  = rxdpram_dob_w0p[p_sw_wid-1:0];
          end

        P_STATUS_WORD_3 :

          if (~gem_rx_pbuf_data_w_is_128 & ~dma_bus_width[0])
          begin
            if (cutthru_status_word_valid)
              nxt_status_word_3 = ct_fifo_w2p[p_sw_wid-1:0];
            else
              nxt_status_word_3  = rxdpram_dob_w0p[p_sw_wid-1:0];
          end


        P_STATUS_WORD_4 :

          if (dma_bus_width==2'b00 & ~gem_rx_pbuf_data_w_is_128)
          begin
            if ((~|status_word_early_fetch_count) || status_word_1[0])
            begin
              if(~rx_bd_extended_mode_en)
              begin
                if (cutthru_status_word_valid)
                  nxt_status_word_3 = ct_fifo_w2p[p_sw_wid-1:0];
                else
                  nxt_status_word_3  = rxdpram_dob_w0p[p_sw_wid-1:0];
              end
              else
              begin
                if (cutthru_status_word_valid)
                  nxt_status_word_4 = ct_fifo_w3p[p_sw_wid-1:0];
                else
                  nxt_status_word_4 = rxdpram_dob_w0p[p_sw_wid-1:0];
              end
            end
          end
      endcase

    end

//******************************************************************************
// Main state machine
//******************************************************************************

  // rx_dma_state - current state of the state machine
  //------------------------------------------------
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      rx_dma_state        <= RX_DMA_IDLE;
      last_rx_dma_state   <= RX_DMA_IDLE;
      mac_err_vld_pending <= 1'b0;
    end
    else
    begin
      rx_dma_state        <= nxt_rx_dma_state;
      // last_rx_dma_state is only used to indicate when to generate interrupts
      // for normal frames or frames that require a writeback
      // Since hresp_notok_eob can generate an interrupt itself, we dont
      // need to generate a 2nd interrupt
      if (hresp_notok_eob)
        last_rx_dma_state <= RX_DMA_IDLE;
      else if (hready)
        last_rx_dma_state <= rx_dma_state;

      mac_err_vld_pending <= nxt_mac_err_vld_pending;
    end
  end

  // Use  'pkt_written_dpram' as an event to get a descriptor. Also routinely trigger an RX descriptor read
  // if there are frames waiting to be received and a pkt_written_dpram is not forthcoming. This avoids
  // packets being kept in the internal SRAm for prolonged periods of time.
  assign new_descr_fetch_trig = (pkt_written_dpram | (restart_trigger & (|num_pkts_needing_read)));

  // nxt_rx_dma_state - next state evaluation for the dma_rx state machine
  always@( * )
  begin
    nxt_mac_err_vld_pending = hready ? 1'b0 : mac_err_vld_pending;
    // If receive is disabled return to idle
    if (~enable_rx_hclk)
      nxt_rx_dma_state = RX_DMA_IDLE;

    else
    begin
      // ... IMPORTANT ...
      // Note this statemachine works in the address phase.  This has
      // implications when using data-phase timed signals, like data.
      // For example, the first data strobe in RX_DMA_DATA_STORE actually
      // relates to the data strobe for the RX_DMA_MAN_RD
      // state -
      case (rx_dma_state)

        // After a error event or after RX is enabled
        // we need to get a buffer ...
        RX_DMA_IDLE:

          // If the packet was discarded, just wait in IDLE for the packet
          // to end ...
          if (ahb_err_discard_recover | ahb_err_pktdiscarded_wait4end | hresp_data_cutthru | flush_rx_pkt_hclk)
            nxt_rx_dma_state = RX_DMA_IDLE;

          // Use  'pkt_written_dpram' as an event to get a descriptor. Also routinely trigger an RX descriptor read
          // if there are frames waiting to be received and a pkt_written_dpram is not forthcoming. This avoids
          // packets being kept in the internal SRAm for prolonged periods of time.
          else if (new_descr_fetch_trig &
                    ~(ahb_err_discard_recover | ahb_sf_err_hold)) // ETH-252 block if waiting for previous status from last dropped frame
          // For priority queues we always have to read the status words to get the
          // priority queue when it's a full frame.
          begin
            if (p_edma_queues == 32'd1)
              nxt_rx_dma_state = RX_DMA_MAN_RD;
            else
              nxt_rx_dma_state = RX_DMA_WAIT_STATUS;
          end
          else if (part_pkt_written & ~(ahb_err_discard_recover | ahb_sf_err_hold)) begin // ETH-252 block if waiting for previous status from last dropped frame
            if (p_edma_queues == 32'd1 || early_queue_info_en)
              nxt_rx_dma_state = RX_DMA_MAN_RD;
            else
              nxt_rx_dma_state = RX_DMA_WAIT_STATUS;
          end

          // Otherwise wait for rx_buffer_required
          else
            nxt_rx_dma_state = RX_DMA_IDLE;

        RX_DMA_WAIT_STATUS :
        begin
          if (early_queue_info_en |
              (status_word1_capt & nxt_status_word_1[0]))
            nxt_rx_dma_state = RX_DMA_MAN_RD;
          else
            nxt_rx_dma_state = RX_DMA_WAIT_STATUS;
        end

        // RX_DMA_MAN_RD:
        // read current buffer descriptor word_0; ahb read burst and
        // transition according to the state of the ownership bit:
        RX_DMA_MAN_RD: begin

           // bus err from previous state
          if (hresp_notok_eob)
             nxt_rx_dma_state = RX_DMA_IDLE;

          // not used so go to data state
          // Only transfer if all queues have been updated
          else if ( (ahbaddph_strobe_descr_rd & descriptor_rd_1_access)                                     // single read
                  | ((ahbaddph_strobe_descr_rd & (descr_rd_addph_cnt == 2'h1)) & descriptor_rd_2_access))     // 2 reads
             nxt_rx_dma_state = RX_DMA_DATA_STORE;

          // buffer descriptor not read yet
          else
             nxt_rx_dma_state = RX_DMA_MAN_RD;

          // It's possible in cutthru mode that the status can be fetched and an error can be
          // detected while the we are waiting for the descriptor read data. If this is the
          // case then we will let the descritpor read finish and abort after that.
          if (mac_err_vld)
            nxt_mac_err_vld_pending = rx_cutthru;
          else
            nxt_mac_err_vld_pending = mac_err_vld_pending;

        end

        // RX_DMA_DATA_STORE:
        //
        RX_DMA_DATA_STORE:

          // bus err or rx_buffer_used_bit (remember the first address
          // phase here is actually
          // the data phase of the management read
          if (hresp_notok_eob | rx_buffer_used_bit | (mac_err_vld & rx_cutthru) | (mac_err_vld_pending & hready))
              nxt_rx_dma_state = RX_DMA_IDLE;

          // current buffer full or whole frame transferred and last addr
          // phase of the bus transaction
          else if ((last_data_to_buff_aph & ~padding_rph) |
                   (ahb_access_cnt == 4'h0 & padding_aph))
          begin
            // Buffer is full, or pkt is fully written to memory,
            // so do the writeback
            nxt_rx_dma_state = RX_DMA_MAN_WR;
          end

          // more frame data to be transferred and space is available
          else
             nxt_rx_dma_state = RX_DMA_DATA_STORE;


        // write back the buffer descriptor according to the frame storage
        // status ahb write burst
        default : // RX_DMA_MAN_WR:

          // hresp or other error in writeback, can't recover buffer.
          if (hresp_notok_eob)
             nxt_rx_dma_state = RX_DMA_IDLE;

          //
          else if (astrobe_manwr_last)
          begin
            if (p_edma_queues > 32'd1)
            begin
              if ((|num_pkts_needing_read) | pkt_written_dpram | reading_eop_dpram_aph_del | (|num_parts_needing_read) | part_pkt_written)
              begin
                if (early_queue_info_en | (status_word1_capt & nxt_status_word_1[0]) | reading_eop_dpram_aph_del)
                  nxt_rx_dma_state = RX_DMA_MAN_RD;
                else
                  nxt_rx_dma_state = RX_DMA_WAIT_STATUS;
              end
              else
                nxt_rx_dma_state = RX_DMA_IDLE;
            end
            else
              nxt_rx_dma_state = RX_DMA_MAN_RD;
          end

          // status for current buff not written yet
          else
             nxt_rx_dma_state = RX_DMA_MAN_WR;

      endcase
    end
  end


   // Determine if an error condition has occured in the state machine and pass this to the rsc
   assign rx_dma_err  = (rx_dma_state == RX_DMA_DATA_STORE & rx_buffer_used_bit);

   // Decoding of the current and next state
   assign rx_dma_state_data   = rx_dma_state==RX_DMA_DATA_STORE;
   assign rx_dma_state_man_rd = rx_dma_state==RX_DMA_MAN_RD;
   assign rx_dma_state_man_wr = rx_dma_state==RX_DMA_MAN_WR;
   assign rx_dma_next_man_rd  = nxt_rx_dma_state==RX_DMA_MAN_RD;
   assign rx_dma_next_man_wr  = nxt_rx_dma_state==RX_DMA_MAN_WR;
   assign rx_dma_next_data    = nxt_rx_dma_state==RX_DMA_DATA_STORE;


  always @(*)
  begin
    if (cutthru_status_word_valid)
    begin
      early_fld_offset_info_nxt[11:0]   = ct_fifo_w2p[25:14];//[cutthru_status_word[89:78];
      early_fld_offset_info_nxt[23:12]  = ct_fifo_w0p[12:1];
      early_fld_offset_info_nxt[28:24]  =  // l3 and rest from sw3
                                           ct_fifo_w1p[23] & ct_fifo_w1p[9] ? 5'd26 : // VLAN and SNAP
                                           ct_fifo_w1p[23]                  ? 5'd18 : // VLAN
                                           ct_fifo_w1p[9]                   ? 5'd22 : // SNAP
                                                                              5'd14;
//      Currently RSC is not supported with cutthru operation
//      if (p_edma_rsc == 1)
//        early_fld_offset_info_nxt[30:29] = ct_fifo_w2p[27:26];
//      else
        early_fld_offset_info_nxt[30:29] = 2'b00;
    end
    else
    begin
      early_fld_offset_info_nxt[11:0]   = 12'h000; // l4_offset from sw3 (not needed early)
      early_fld_offset_info_nxt[23:12]  = rxdpram_dob_w0p[12:1]; // pld_offset from sw1
      early_fld_offset_info_nxt[28:24]  =  5'h1f;
      if (p_edma_rsc == 1)
        early_fld_offset_info_nxt[30:29] = rxdpram_dob_w0p[14:13];
      else
        early_fld_offset_info_nxt[30:29] = 2'b00;
    end
  end

// Priority Queue Number
// Use the Queue from the screener logic (if priority queuing is enabled)
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      early_fld_offset_info <= 31'd0;
      nxt_early_queue_info_en <= 1'b0;
      part_of_packet_fld_offsets_pending <= 31'd0;
      num_pkts_needing_read_neq_zero_reg <= 1'b0;
    end
    else if (~enable_rx_hclk)
    begin
      early_fld_offset_info <= 31'd0;
      nxt_early_queue_info_en <= 1'b0;
      part_of_packet_fld_offsets_pending <= 31'd0;
      num_pkts_needing_read_neq_zero_reg <= 1'b0;
    end
    else
    begin
      nxt_early_queue_info_en <= (rx_dma_state == RX_DMA_MAN_WR &
                                  rxdpram_enb &
                                 (|num_pkts_needing_read) & first_buffer_of_pkt);

      num_pkts_needing_read_neq_zero_reg <= |num_pkts_needing_read;

      // An early read of the DPRAM is running, so store the queue info.
      if (rx_dma_state == RX_DMA_MAN_WR & nxt_early_queue_info_en)
      begin
        early_fld_offset_info <= early_fld_offset_info_nxt;
      end
      // A part packet has been written and there are no pending frames.
      else if (part_pkt_written && (pkt_written_dpram == 1'b0 && !(|num_pkts_needing_read))) begin
        early_fld_offset_info <= part_of_packet_fld_offsets;
      end
      // When the num_pkts_needing_read hits empty and there are part packets pending then
      // use the pending pointer address.
      else if (!(|num_pkts_needing_read) && num_pkts_needing_read_neq_zero_reg && |num_parts_needing_read && !pkt_written_dpram) begin
        early_fld_offset_info <= part_of_packet_fld_offsets_pending;
      end

      // A part packet has been written and there are pending frames. In this
      // case we store the part packet pointers, which can be used once the full
      // frame has been sent.
      if (part_pkt_written)
        part_of_packet_fld_offsets_pending <= part_of_packet_fld_offsets;
    end
  end

// This code should reflect the combi and sync processes above, but are specific for priority queues
// They were separated just for LINT reasons
// Priority Queue Number
// Use the Queue from the screener logic (if priority queuing is enabled)
generate if (p_edma_queues > 32'd1) begin : gen_set_early_queue_id
  reg          early_queue_info_en_nxt;
  reg [3:0]    early_queue_info_nxt;
  reg [3:0]    part_of_packet_queue_ptr_pending; // A part packet is pending for after the full
                                                 // stored frame has been transmitted.

  always @(*)
  begin
    if (cutthru_status_word_valid)
    begin
      early_queue_info_nxt              = ct_fifo_w0p[30:27];
      early_queue_info_en_nxt           = ct_fifo_w0p[0];
    end
    else
    begin
      early_queue_info_nxt              = rxdpram_dob_w0p[30:27];
      early_queue_info_en_nxt           = rxdpram_dob_w0p[0];
    end
  end

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      early_queue_info                 <= 4'h0;
      early_queue_info_en              <= 1'h0;
      part_of_packet_queue_ptr_pending <= 4'd0;
    end
    else if (~enable_rx_hclk)
    begin
      early_queue_info                 <= 4'h0;
      early_queue_info_en              <= 1'h0;
      part_of_packet_queue_ptr_pending <= 4'd0;
    end
    else
    begin
      // An early read of the DPRAM is running, so store the queue info.
      if (rx_dma_state == RX_DMA_MAN_WR & nxt_early_queue_info_en)
      begin
        early_queue_info    <= early_queue_info_nxt;
        early_queue_info_en <= early_queue_info_en_nxt;
      end
      // A part packet has been written and there are no pending frames.
      else if (part_pkt_written && (pkt_written_dpram == 1'b0 && !(|num_pkts_needing_read))) begin
        early_queue_info    <= part_of_packet_queue_ptr;
        early_queue_info_en <= 1'b1;
      end
      // When the num_pkts_needing_read hits empty and there are part packets pending then
      // use the pending pointer address.
      else if (!(|num_pkts_needing_read) && num_pkts_needing_read_neq_zero_reg && |num_parts_needing_read && !pkt_written_dpram) begin
        early_queue_info    <= part_of_packet_queue_ptr_pending;
        early_queue_info_en <= 1'b1;
      end
      else if (dpram_rd_state == P_STATUS_WORD_2 | status_word1_capt)
        early_queue_info_en <= 1'h0;

      // A part packet has been written and there are pending frames. In this
      // case we store the part packet pointers, which can be used once the full
      // frame has been sent.
      if (part_pkt_written)
        part_of_packet_queue_ptr_pending <= part_of_packet_queue_ptr;
    end
  end
  end else begin : gen_set_early_no_queue
    wire   zero;
    assign zero = 1'b0;
    always @(*)
    begin
      early_queue_info_en = zero;
      early_queue_info    = {4{zero}};
    end
  end
  endgenerate

  always @(*)
    // The status words haven't been updated yet, so use the early queue
    // info - dont do this for the descriptor write state
    if (early_queue_info_en & ~real_eop_ahb_dph_reg)
    begin
      pld_offset                      = early_fld_offset_info[23:12];
      l4_offset                       = early_fld_offset_info[11:0];
      l3_offset                       = early_fld_offset_info[28:24];
      rsc_stop_from_dma               = p_edma_rsc == 1 && early_fld_offset_info[29];
      rsc_push_from_dma               = p_edma_rsc == 1 && early_fld_offset_info[30];
      offset_has_become_available     = ~(rx_dma_next_man_wr & first_buffer_of_pkt);
    end

    else
    begin
      rsc_stop_from_dma = p_edma_rsc == 1 && status_word_1[13];
      rsc_push_from_dma = p_edma_rsc == 1 && status_word_1[14];
      pld_offset = status_word_1[12:1];
      l4_offset = status_word_3[25:14];
      l3_offset = status_word_2[23] & status_word_2[9]  ? 5'd26 : // VLAN and SNAP
                  status_word_2[23]                     ? 5'd18 : // VLAN
                  status_word_2[9]                      ? 5'd22 : // SNAP
                                                          5'd14;
      offset_has_become_available = status_word3_capt;
    end


generate if (p_edma_queues > 32'd1) begin : gen_set_queues
  reg [3:0] queue_ptr_rx_rph_r;
  reg [3:0] queue_ptr_rx_aph_r;
  reg [3:0] queue_ptr_rx_dph_r;
  always @(*)
    // If we are doing the descriptor writeback for the previous frame,
    // hold the old data.
    if (rx_dma_next_man_wr & first_buffer_of_pkt)
      queue_ptr_rx_rph_r = status_word_1[30:27];
    // The status words haven't been ready yet, so use the early queue
    // info
    else if (early_queue_info_en)
      queue_ptr_rx_rph_r = early_queue_info;
    else
      queue_ptr_rx_rph_r = status_word_1[30:27];

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      queue_ptr_rx_aph_r <= 4'h0;
      queue_ptr_rx_dph_r <= 4'h0;
    end
    else
    begin
      if (hready)
      begin
        queue_ptr_rx_aph_r <= queue_ptr_rx_rph;
        queue_ptr_rx_dph_r <= queue_ptr_rx_aph;
      end
    end
  end
  assign  queue_ptr_rx_rph = queue_ptr_rx_rph_r;
  assign  queue_ptr_rx_aph = queue_ptr_rx_aph_r;
  assign  queue_ptr_rx_dph = queue_ptr_rx_dph_r;

end else begin : gen_set_no_queues
  assign  queue_ptr_rx_rph = 4'd0;
  assign  queue_ptr_rx_aph = 4'd0;
  assign  queue_ptr_rx_dph = 4'd0;
end
endgenerate

  edma_sync_toggle_detect i_edma_sync_toggle_detect_dma_addr_or_mask (
    .clk(hclk),
    .reset_n(n_hreset),
    .din(dma_addr_or_mask[8]),
    .rise_edge(),
    .fall_edge(),
    .any_edge(dma_addr_or_mask_edge));

  always@(posedge hclk or negedge n_hreset)
    if (~n_hreset)
      dma_addr_or_mask_hclk  <= 8'h00;
    else
      if (dma_addr_or_mask_edge)
        dma_addr_or_mask_hclk  <= dma_addr_or_mask[7:0];

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      descriptor_captured <= 1'b0;
      hbusreq      <= 1'b0;
      for (i=0; i<p_edma_queues; i=i+1) begin
        nxt_descr_ptr[i] <= {p_awid_par{1'b0}};
        str_descriptor[i] <= {p_awid_par{1'b0}};
      end
      rx_dma_descr_ptr_tog   <= 1'b0;
      ahb_data_addr       <= {p_awid_par{1'b0}};
      ahb_data_addr_2     <= {p_awid_par{1'b0}};
      bit3n2data_add_64   <= 2'd0;
      first_buffer_of_pkt <= 1'b1;
      rx_sof_written      <= 1'b0;
      rx_eof_written      <= 1'b0;
    end
    else
    begin
      if (~enable_rx_hclk)
      begin
        descriptor_captured <= 1'b0;
        hbusreq               <= 1'b0;
        for (i=0; i<p_edma_queues; i=i+1)
        begin
          str_descriptor[i] <= {p_awid_par{1'b0}};
          if (i == 0)
          begin
            if (new_rx_q_ptr_pulse)
              nxt_descr_ptr[i] <= rx_dma_base_addr_arr[0];
          end
          else
            nxt_descr_ptr[i] <= rx_dma_base_addr_arr[i];
        end
        ahb_data_addr         <= {p_awid_par{1'b0}};
        ahb_data_addr_2       <= {p_awid_par{1'b0}};
        bit3n2data_add_64     <= 2'd0;
        first_buffer_of_pkt   <= 1'b1;
        rx_sof_written        <= 1'b0;
        rx_eof_written        <= 1'b0;
      end
      else
      begin
        case (rx_dma_state)

          RX_DMA_IDLE,RX_DMA_WAIT_STATUS :
          begin
            descriptor_captured <= 1'b0;
            if (ahbdataph_strobe_descr & p_edma_queues > 32'd1)
            begin
              rx_sof_written  <= 1'b0;
              rx_eof_written  <= 1'b0;
            end
            for (i=0; i<p_edma_queues; i=i+1) begin
              str_descriptor[i] <= {p_awid_par{1'b0}};
            end
            // request the bus to obtain the data buffer address
            if (nxt_rx_dma_state == RX_DMA_MAN_RD)
              hbusreq <= 1'b1;
            /* Following code removed because it cannot currently be hit due to the rx enable blocking the pulse
            from being generated. commenting code rather than removing it because it might be reversed in the future

            if (new_rx_q_ptr_pulse)
              for (i=0; i<p_edma_queues; i=i+1)
                nxt_descr_ptr[i] <= rx_dma_base_addr_arr[i][31:2];*/
          end

          RX_DMA_MAN_RD :
          begin
            descriptor_captured <= 1'b0;
            if (ahbdataph_strobe_descr)
            begin
              rx_sof_written  <= 1'b0;
              rx_eof_written  <= 1'b0;
            end

            if (hresp_notok_eob)
              first_buffer_of_pkt   <= 1'b1;

            // If hbusreq is high in this state, then it means that the request
            // for the descriptor read has not started yet - as this state
            // machine is address phase timed, the request will usually
            // start in the preceding state, which is usually the dma
            // writeback state.
            // Now, since we dont know yet if there is a buffer available
            // to write to yet (indicated via used bit in buffer descriptor),
            // we will want to just perform 1 access - therefore hbusreq
            // always set low here.
            if ((ahbreqph_strobe_descr & descriptor_rd_1_access)                                   // 1 accesses needed
               | (ahbreqph_strobe_descr & (descr_rd_reqph_cnt == 3'h1) & descriptor_rd_2_access))  // extend when 2 accesses needed
                      hbusreq <= 1'b0;
            // For the case where the previous state was the manwr state,
            // then there will be 1 further data strobe here
            // reset the nxt_descr_ptr to the start of the packet if
            // there was a hresp error
            /* Following code removed because it cannot currently be hit due to the rx enable blocking the pulse
               from being generated. commenting code rather than removing it because it might be reversed in the future

            if (new_rx_q_ptr_pulse)
              for (i=0; i<p_edma_queues; i=i+1)
                nxt_descr_ptr[i] <= rx_dma_base_addr_arr[i][31:2];
            */


            if  ((ahbdataph_strobe_descr_rd & descriptor_rd_1_access)
                | (ahbdataph_strobe_descr_rd & (descr_rd_addph_cnt == 2'h1) & descriptor_rd_2_access))
              for (i=0; i<p_edma_queues; i=i+1)
                if (i[3:0] == queue_ptr_rx_dph) str_descriptor[i] <= rx_dma_data_in_w0_p[p_awid_par-1:0];
          end


          RX_DMA_DATA_STORE :
          begin

            // The last data phase of the descriptor is actually in this state
            // If there is an AHB error in the descr rd or the pkt data,
            // reset the next descriptor AHB address to the start of the
            // current packet
            /* Following code removed because it cannot currently be hit due to the rx enable blocking the pulse
               from being generated. commenting code rather than removing it because it might be reversed in the future
            if (new_rx_q_ptr_pulse)
              nxt_descr_ptr[queue_ptr_rx_aph] <= rx_dma_base_addr_arr[queue_ptr_rx_aph][31:2];
            */

            if (ahbreqph_strobe_data) // increment ahb_address (after initially setup in else below) for each data write
              ahb_data_addr  <= ahb_data_addr_incr[p_awid_par-1:0];

            // set first data address from last man_rd data (as last man_rd data arrives in data state
            // for 64b addr this is word 2 ie MSB addr
            // but word 0 has already been captured in  str_descriptor so use that as well here
            else if (ahbdataph_strobe_descr)
            begin
              descriptor_captured <= 1'b1;

              if (descriptor_rd_1_access)
              begin
                ahb_data_addr <= rx_dma_data_in_addr_msk[p_awid_par-1:0];
                if (p_edma_axi == 1)
                  ahb_data_addr_2 <= rx_dma_data_in_w1_p[p_awid_par-1:0];
                else
                  ahb_data_addr_2 <= rx_dma_data_in_w2_p[p_awid_par-1:0];
                if ((|dma_bus_width & first_buffer_of_pkt) | (p_edma_rsc == 1 & ~rsc_first_frame))
                  bit3n2data_add_64   <= rx_dma_data_in_w0_p[3:2];
              end
              else  // descriptor_rd_2_access
              begin
                ahb_data_addr <= str_descriptor_addr_msk[p_awid_par-1:0];
                if (p_edma_axi == 1)
                  ahb_data_addr_2 <= rx_dma_data_in_w1_p[p_awid_par-1:0];
                else
                  ahb_data_addr_2 <= rx_dma_data_in_w0_p[p_awid_par-1:0];
                if ((|dma_bus_width & first_buffer_of_pkt) | (p_edma_rsc == 1 & ~rsc_first_frame))
                  bit3n2data_add_64   <= str_descriptor_pad[queue_ptr_rx_dph][3:2];
              end
            end

            if (ahbdataph_strobe_descr_rd & descriptor_rd_1_access)
              for (i=0; i<p_edma_queues; i=i+1)
                if (i[3:0]==queue_ptr_rx_dph) str_descriptor[i] <= rx_dma_data_in_w0_p[p_awid_par-1:0];

            // hbusreq cears when there is an AHB error,
            // or when are in cut-thru mode and the status has
            // been read (with error) whilst in this state
            // Note that under normal conditons, the bus request
            // will just stay active because we will always go into
            // the descripor read or write state after this, unless there
            // is a hresp error
            if (hresp_notok_eob | (status_word1_capt & ~status_word_1[0] & hready))
            begin
              hbusreq <= 1'b0;
            end

            // Also clears if the used bit was read
            else if (rx_buffer_used_bit)
              hbusreq <= 1'b0;

            // Drop hbusreq while we wait for the next part or while we wait for
            // the status to be fetched
            else if (last_partpkt_rph & ~last_data_to_buff_rph &
                    ~status_word1_capt &
                      num_parts_needing_read[7:1] == 7'h00 & ~part_pkt_written)
              hbusreq <= 1'b0;

            // Drive high for fetching the packet parts,
            // or the full packet if the status has been captured
            // (dpram_rd_state == P_PKT_DATA) is added here as this ensures
            // hbusreq is driven high a cycle later than if that condition
            // was removed - this ensures that we dont have 2 conditions
            // within the resource freeing logic happening at the same
            // time - simpler
            else if (
                      // dont start until descriptor is fetched!
                     (descriptor_captured | ahbdataph_strobe_descr) &

                     ((dpram_rd_state == P_PKT_DATA &

                     // Something to receive ...
                    ((|num_parts_needing_read | fetch_rem_part) |
                     (|num_pkts_needing_read & status_word1_capt))) |
                     reading_eop_dpram_aph_del))
              hbusreq <= 1'b1;


            if (hresp_notok_eob |
               (rx_buffer_used_bit & (rx_cutthru | force_discard_on_error)) |
                mac_err_vld | mac_err_vld_pending)
            begin
              rx_eof_written      <= 1'b0;
              first_buffer_of_pkt <= 1'b1;
            end
            // To set rx_eof_written, we want to use the EOP read from the DPRAM
            // When we are padding the burst however, we need to wait until the
            // end of the padding
            else if (real_eop_ahb_aph)
            begin
              rx_eof_written      <= 1'b1;
              first_buffer_of_pkt <= 1'b1;
            end
            else if (ahbaddph_strobe_data_nopad)
            begin
              first_buffer_of_pkt <= 1'b0;
              if (first_buffer_of_pkt)
                rx_sof_written    <= 1'b1;
            end


          end


        // write back the buffer descriptor according to the frame storage
        // status ahb write burst
        default : // RX_DMA_MAN_WR:
        begin
          // Reset hbusreq once the request phase for the next descriptor
          // is completed - this is the same time as the address phase
          // of the 2nd MANWR (assuming we are still granted at this stage
          // - we can gate in ahbreqph_strobe_descr to ensure this)
          if (astrobe_manwr_last | hresp_notok_eob)
          begin
            if (ahbreqph_strobe_descr)
            begin
              if (descriptor_rd_2_access)
                hbusreq <= 1'b1;           //  extend if 64b addressing (when not 128b data bus)
              else
                hbusreq <= 1'b0;           // set to 0 for single rd here ie 32b addressing
            end
            rx_dma_descr_ptr_tog   <= ~rx_dma_descr_ptr_tog;
          end
          descriptor_captured <= 1'b0;

          if (hresp_notok_eob)
            first_buffer_of_pkt <= 1'b1;
          else
            first_buffer_of_pkt <= rx_eof_written;

          /* Following code removed because it cannot currently be hit due to the rx enable blocking the pulse
              from being generated. commenting code rather than removing it because it might be reversed in the future
          if (new_rx_q_ptr_pulse)
            nxt_descr_ptr[queue_ptr_rx_aph] <= rx_dma_base_addr_arr[queue_ptr_rx_aph][31:2];
          */

          // Once the descriptor has been finished with, increment
          // (unless wrap bit  was set, in which case, reset to base)
          for (i=0; i<p_edma_queues; i=i+1)
            if  (astrobe_manwr_last & update_databuf_add && i[3:0] == queue_ptr_rx_aph)
            begin
              if (current_wrap_bit_aph)
                nxt_descr_ptr[i] <= rx_dma_base_addr_arr[queue_ptr_rx_aph];
              else
                nxt_descr_ptr[i] <= nxt_descr_ptr_aph_inc[p_awid_par-1:0];
            end
        end
        endcase
      end
    end
  end

  // Optional modification based on dma_addr_or_mask_hclk
  assign str_descriptor_addr_msk[31]  = dma_addr_or_mask_hclk[3]  ? dma_addr_or_mask_hclk[7]  : str_descriptor_pad[queue_ptr_rx_dph][31];
  assign str_descriptor_addr_msk[30]  = dma_addr_or_mask_hclk[2]  ? dma_addr_or_mask_hclk[6]  : str_descriptor_pad[queue_ptr_rx_dph][30];
  assign str_descriptor_addr_msk[29]  = dma_addr_or_mask_hclk[1]  ? dma_addr_or_mask_hclk[5]  : str_descriptor_pad[queue_ptr_rx_dph][29];
  assign str_descriptor_addr_msk[28]  = dma_addr_or_mask_hclk[0]  ? dma_addr_or_mask_hclk[4]  : str_descriptor_pad[queue_ptr_rx_dph][28];
  assign str_descriptor_addr_msk[27:0]= str_descriptor_pad[queue_ptr_rx_dph][27:0];
  assign rx_dma_data_in_addr_msk[31]  = dma_addr_or_mask_hclk[3]  ? dma_addr_or_mask_hclk[7]  : rx_dma_data_in_w0_p[31];
  assign rx_dma_data_in_addr_msk[30]  = dma_addr_or_mask_hclk[2]  ? dma_addr_or_mask_hclk[6]  : rx_dma_data_in_w0_p[30];
  assign rx_dma_data_in_addr_msk[29]  = dma_addr_or_mask_hclk[1]  ? dma_addr_or_mask_hclk[5]  : rx_dma_data_in_w0_p[29];
  assign rx_dma_data_in_addr_msk[28]  = dma_addr_or_mask_hclk[0]  ? dma_addr_or_mask_hclk[4]  : rx_dma_data_in_w0_p[28];
  assign rx_dma_data_in_addr_msk[27:0]= rx_dma_data_in_w0_p[27:0];

  // If parity protection, then regenerate parity
  generate if (p_edma_asf_dap_prot == 1) begin : gen_addr_or_mask_par
    gem_par_chk_regen #(.p_chk_dwid (64)) i_regen_par (
      .odd_par  (1'b0),
      .chk_dat  ({rx_dma_data_in_w0_p[31:0],str_descriptor_pad[queue_ptr_rx_dph][31:0]}),
      .chk_par  ({rx_dma_data_in_w0_p[35:32],str_descriptor_pad[queue_ptr_rx_dph][35:32]}),
      .new_dat  ({str_descriptor_addr_msk[31:0],rx_dma_data_in_addr_msk[31:0]}),
      .dat_out  (),
      .par_out  ({str_descriptor_addr_msk[35:32],rx_dma_data_in_addr_msk[35:32]}),
      .chk_err  (dap_err_addr_or_mask)
    );
  end else begin : gen_no_addr_or_mask_par
    assign dap_err_addr_or_mask = 1'b0;
  end
  endgenerate

  // Determine how much ahb_data_addr should increment for each data write
  always@(*)
  begin
    if (dma_bus_width[1])
      ahb_data_addr_inc_val = 32'h00000010;
    else if (dma_bus_width==2'b01)
      ahb_data_addr_inc_val = 32'h00000008;
    else
      ahb_data_addr_inc_val = 32'h00000004;
  end

  // Increment of ahb_data_addr by ahb_data_addr_inc_val taking into account
  // possible parity
  edma_arith_par #(
    .p_dwidth (32),
    .p_pwidth (4),
    .p_has_par(p_edma_asf_dap_prot)
  ) i_arith_ahb_data_addr_incr (
    .in_val (ahb_data_addr[31:0]),
    .in_par (ahb_data_addr[p_awid_par-1:p_awid_par-4]),
    .op_val (ahb_data_addr_inc_val),
    .op_add (1'b1),
    .out_val(ahb_data_addr_incr[31:0]),
    .out_par(ahb_data_addr_incr[35:32])
  );

  // Increment of nxt_descr_ptr[queue_ptr_rx_aph] by next_descr_ptr_inc_val taking into account
  // possible parity
  edma_arith_par #(
    .p_dwidth (32),
    .p_pwidth (4),
    .p_has_par(p_edma_asf_dap_prot)
  ) i_arith_rx_descr_ptr_aph_inc (
    .in_val (nxt_descr_ptr_pad[queue_ptr_rx_aph][31:0]),
    .in_par (nxt_descr_ptr_pad[queue_ptr_rx_aph][p_awid_par-1:p_awid_par-4]),
    .op_val (next_descr_ptr_inc_val),
    .op_add (1'b1),
    .out_val(nxt_descr_ptr_aph_inc[31:0]),
    .out_par(nxt_descr_ptr_aph_inc[35:32])
  );

  // Get max rx buffer size based on current Queue
  assign rx_buffer_size_cur = rx_buffer_size_array[queue_ptr_rx_aph];

  // When hdr/data splitting is on, in terms of writing the TCP/IP header out on the AHB interface,
  // we need to add in the buffer start offset
  wire [12:0] pld_offset_ahb;
  assign pld_offset_ahb    = pld_offset + ({bit3n2data_add_64 & {dma_bus_width[1],|dma_bus_width},
                                            rx_dma_buffer_offset});

  // Convert pld_offset into words based on current data width
  // This will match the number of DPRAM reads required to reach the payload offset
  wire [10:0] pld_offset_words_ahb;
  assign pld_offset_words_ahb  = dma_bus_width[1] ? {3'h0, pld_offset_ahb[11:4]} + |pld_offset_ahb[3:0] :
                                 dma_bus_width[0] ? {2'h0, pld_offset_ahb[11:3]} + |pld_offset_ahb[2:0] :
                                                    {1'b0, pld_offset_ahb[11:2]} + |pld_offset_ahb[1:0];

  // Calculate buffer depth per datawidth based on buffer_size register only
  reg [11:0] buffer_size_words;
  always @(*)
  begin
    if (dma_bus_width[1])
      buffer_size_words  = {2'b00,rx_buffer_size_cur[7:0],2'd0};
    else if (dma_bus_width[0])
      buffer_size_words  = {1'b0,rx_buffer_size_cur[7:0],3'd0};
    else
      buffer_size_words  = {rx_buffer_size_cur[7:0],4'd0};
  end

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      offset_available_capt <= 1'b0;
    else
    begin
      if (~enable_rx_hclk)
        offset_available_capt <= 1'b0;
      else
      begin
        if ((rx_dma_next_man_wr & rx_eof_written) | (nxt_rx_dma_state == RX_DMA_IDLE)) // end of frame
          offset_available_capt <= 1'b0;
        else if (offset_has_become_available & descriptor_captured & rx_dma_state == RX_DMA_DATA_STORE) // Need to wait until descriptor_captured because offset is not fully setup until here
          offset_available_capt <= 1'b1;
      end
    end
  end

  always @(*)
  begin
    if (offset_has_become_available & first_buffer_of_pkt & ~offset_available_capt)
    begin
      if ({1'b0,pld_offset_words_ahb} <= buffer_size_words)
        nxt_remaining_hdr_bytes = 12'h000;
      else
        nxt_remaining_hdr_bytes = {1'b0,pld_offset_words_ahb} - buffer_size_words;
    end
      else if ({1'b0,remaining_hdr_bytes} <= buffer_size_words)
        nxt_remaining_hdr_bytes = 12'h000;
      else
        nxt_remaining_hdr_bytes = {1'b0,remaining_hdr_bytes} - buffer_size_words;
  end


  // Calculate the RX buffer depth in stripes
  // In non hdr data splitting modes, it is based directly on the rx buffer size register
  // and the datawidth
  // in hdr data splitting modes, it must take into account the payload offset, which essentially
  // indicates the length of the header
  // when infinite_last_dbuf_size_en mode is enabled, then the databuffer pointed to by the descriptor
  // at the top of the descriptor table is of infinite size 
  generate if(p_edma_axi == 1'b1) begin: gen_from_rx_dma_buff_depth
    reg [11:0] rx_buff_depth; // buffer depth (in 32-bit words)

    always @ *
    begin
      if (infinite_last_dbuf_size_en & current_wrap_bit_aph)
        rx_buff_depth = 12'hfff;  // Set to max size
      else if (hdr_data_splitting_en & (|remaining_hdr_bytes) & ({1'b0,remaining_hdr_bytes} < buffer_size_words))
        rx_buff_depth = {1'b0,remaining_hdr_bytes};
      else
        rx_buff_depth = buffer_size_words;
    end
    assign from_rx_dma_buff_depth = rx_buff_depth;
    
  end else begin: no_gen_from_rx_dma_buff_depth
    assign from_rx_dma_buff_depth = 12'd0;
  end
  endgenerate
  
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      buffer_fill_lvl     <= 12'h000;
      remaining_hdr_bytes <= 11'h000;
    end
    else
    begin
      if (~enable_rx_hclk)
      begin
        buffer_fill_lvl <= 12'h000;
        remaining_hdr_bytes <= 11'h000;
      end
      else
      begin
        //  reset buffer_fill_lvl to something other than 0 as soon as we have the required data.
        // In priority queues, this is when the queue information is ready.
        // In all modes, we also have to have the pld_offset for cases where header/data splitting is enabled
        // When infinite_last_dbuf_size_en mode is enabled, the buffer fill level is set to infinite if this is
        // the last descriptor in the ring
        if (ahbreqph_strobe_data & infinite_last_dbuf_size_en & current_wrap_bit_rph)
          buffer_fill_lvl <= 12'hfff;

        // First buffer of packet.
        else if (offset_has_become_available & first_buffer_of_pkt & ~offset_available_capt)
        begin
          // If there are less bytes in the payload offset than in the max programmed buffer depth, then set
          // to pld_offset_words_ahb, otherwise buffer_size from register.
          // Its possible offset_has_become_available happens at same time as first AHB request strobe.
          // This is okay as we will always expect frames to be bigger than 1 write, however, we need to take
          // it into account here.
          remaining_hdr_bytes <= pld_offset_words_ahb;
          if (|pld_offset_words_ahb & ({1'b0,pld_offset_words_ahb} <= buffer_size_words) & hdr_data_splitting_en)
            buffer_fill_lvl <= {1'd0, {pld_offset_words_ahb - {10'd0,ahbreqph_strobe_data}}};
          else
            buffer_fill_lvl <= buffer_size_words - {11'd0,ahbreqph_strobe_data};
        end

        else if (rx_dma_state == RX_DMA_MAN_RD & last_rx_dma_state != RX_DMA_MAN_RD)
        begin
          // On the first descriptor rd of a frame, just set buffer_fill_lvl to something non zero. This is so that
          // buffer_available can get set. buffer_fill_lvl enters that logic to drive buffer_available just
          // to make it easier to reset buffer_available once a buffer has become exhausted - i.e. after
          // loads of data accesses.  This is never the case following the first man_rd.
          // Note we must guarantee that this logic is just used after the 1st descriptor read to set buffer_fill_lvl
          // to something, and will be updated with the correct value when 'offset_has_become_available' as above.
          if (first_buffer_of_pkt)
          begin
            remaining_hdr_bytes <= remaining_hdr_bytes;
            buffer_fill_lvl <= buffer_size_words;
          end

          // If not the furst buffer of the frame, then set to either nxt_remaining_hdr_bytes if this is the last
          // buffer of the header, or buffer_size_words
          else
          begin
            remaining_hdr_bytes <= nxt_remaining_hdr_bytes[10:0];
            if (({1'b0,nxt_remaining_hdr_bytes[10:0]} <= buffer_size_words) & hdr_data_splitting_en & (|nxt_remaining_hdr_bytes[10:0]))
              buffer_fill_lvl <= {1'b0,nxt_remaining_hdr_bytes[10:0]};
            else
              buffer_fill_lvl <= buffer_size_words;
          end
        end

        else if (ahbreqph_strobe_data & |buffer_fill_lvl)
          buffer_fill_lvl <= buffer_fill_lvl - 12'h001;
      end
    end
  end

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      in_header     <= 1'b1;
    else
    begin
      if (~enable_rx_hclk )
        in_header   <= 1'b1;
      else if (nxt_rx_dma_state != RX_DMA_MAN_WR & rx_dma_state == RX_DMA_MAN_WR &
              ({1'b0,remaining_hdr_bytes} <= buffer_size_words))
      begin
        if (rx_eof_written)
          in_header   <= 1'b1;
        else
          in_header   <= 1'b0;
      end
    end
  end


  // Identify the period of time the AHB will be writing out PAD to the memory
  // This is the case when force_max_ahb_burst_rx is set and the EOP is not at
  // the end of a max length burst
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      padding_rph <= 1'b0;
      padding_aph <= 1'b0;
    end
    else
    begin
      if (~enable_rx_hclk)
      begin
        padding_rph <= 1'b0;
        padding_aph <= 1'b0;
      end
      else
      begin
        if (padding_rph & last_access_burst_req & ahbreqph_strobe_data)
          padding_rph <= 1'b0;
        else if (force_max_ahb_burst_rx & |ahb_burst_length[4:2] &

                 // The next request is the last one either of the packet or the buffer ...
                 (real_eop_ahb_rph |
                  (buffer_fill_lvl == 12'h001 & ~real_eop_ahb_aph & hready)) &

                 // The next access is not the last of a burst
                 ~last_access_burst_req &

                 // if at the end of the packet we are close to a 1k boundary(< 4 words),
                 // then we might have to block the padding.  In order to pad,
                 // one of the following 3 things must be true
                 //   1. We are not close to a 1k boundary
                 //   2. We are already in the middle of a burst, which means there must
                 //      be enough room to complete that burst
                 //   3. If we are about to start a new burst (ahb_access_cnt == 4'h0) and
                 //      there is at least enough room for a burst of 4
                 // Else do NOT pad
                 (~brk1kbndry_burst |
                 (|hburst[2:1] & |ahb_access_cnt) |
                 (ahb_access_cnt == 4'h0 & |bndry1k_acc_size[3:2])) &

                 // Ensure this only happen in the data state! there is also a cycle
                 // at the end of the data state we want to ignore - this is the cycle
                 // following the end of padding_rph
                 ~padding_aph &
                 rx_dma_state == RX_DMA_DATA_STORE)
          padding_rph <= 1'b1;

        if (hready)
          padding_aph <= padding_rph;
      end
    end
  end


  // last_data_to_buffer (AHB Request phase)
  // Set at the end of each buffer at EOP
  // Held off until next req phase if offset is used and residue is
  always @(*)
  begin
    if (force_max_ahb_burst_rx & |ahb_burst_length[4:2])
      last_data_to_buff_rph = ahbreqph_strobe_data &
              (last_access_burst_req &
              (buffer_fill_lvl <= 12'h001 | padding_rph));

    else
      last_data_to_buff_rph = ahbreqph_strobe_data &
              (buffer_fill_lvl == 12'h001 | real_eop_ahb_rph);
  end

  // If the eop resides in the residue buffer then another AHB access
  // is required so hold off the eop indication.
  // This access will take place on the next AHB data strobe when the
  // indication can be reset.
  wire real_eop_ahb_rph_pulse;
  wire real_eop_ahb_aph_pulse;
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      reading_eop_dpram_rph_del   <= 1'b0;
    else if (~enable_rx_hclk)
      reading_eop_dpram_rph_del   <= 1'b0;
    else if (real_eop_ahb_rph)
      reading_eop_dpram_rph_del  <= 1'b0;
    else if (reading_eop_dpram_rph & ahbreqph_strobe_data)
      reading_eop_dpram_rph_del  <= 1'b1;
  end

  // If the eop resides in the residue buffer then another AHB access
  // is required so hold off the eop indication.
  // This access will take place on the next AHB data strobe when the
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      reading_eop_dpram_aph_del   <= 1'b0;
    end
    else if (~enable_rx_hclk)
      reading_eop_dpram_aph_del   <= 1'b0;
    else if (real_eop_ahb_aph)
      reading_eop_dpram_aph_del  <= 1'b0;
    else if (reading_eop_dpram_aph & ahbaddph_strobe_data)
      reading_eop_dpram_aph_del  <= 1'b1;
  end

  // last_data_to_buffer (AHB Address phase)
  assign last_data_to_buff_aph = ahbaddph_strobe_data &
                                (buffer_fill_lvl == 12'h000 |
                                 real_eop_ahb_aph |
                                (padding_aph & ~padding_rph));


  assign last_buff_req_aph = last_data_to_buff_aph & ~padding_rph;
  reg last_buff_req_aph_d1;
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      last_buff_req_aph_d1 <= 1'b0;
    else if (~enable_rx_hclk)
      last_buff_req_aph_d1 <= 1'b0;
    else
    begin
      if (hready)
      begin
        if (last_buff_req_aph)
          last_buff_req_aph_d1 <= 1'b1;
        else
          last_buff_req_aph_d1 <= 1'b0;  // Holds until end of burst to ensure this works for force burst mode
      end
    end
  end
  assign last_buff_req_dph   = last_buff_req_aph_d1 & hready;

  assign buffer_available    = (rx_dma_next_data & |buffer_fill_lvl &
                               (~hresp_notok_hold | rx_cutthru));

  // Fix for Jira ETH-358
  // used bit read in 64bit addressing was not being picked up correctly.
  reg rx_used_bit_2_acc;
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      rx_used_bit_2_acc  <= 1'b0;
    else if (ahbdataph_strobe_descr_rd)
      rx_used_bit_2_acc  <= rx_dma_data_in_w0_p[0] & descriptor_rd_2_access & (descr_rd_dataph_cnt == 2'h0);

  end
  assign rx_buffer_used_bit  = ((rx_dma_data_in_w0_p[0] & descriptor_rd_1_access) | rx_used_bit_2_acc) &
                               ahbdataph_strobe_descr_rd & rx_dma_state != RX_DMA_IDLE;

  // Need to use the current str_descriptor based on which queue is being accessed
  // to check the wrap bit
  assign current_wrap_bit_rph  = str_descriptor_pad[queue_ptr_rx_rph][1];
  assign current_wrap_bit_aph  = str_descriptor_pad[queue_ptr_rx_aph][1];

  reg   [1:0]             rx_dma_burst_addr_src;
  reg   [31:0]            rx_dma_burst_dscr_inc_val;
  wire  [35:0]            rx_dma_burst_addr_inc;
  reg   [31:0]            ahb_data_addr_shift;
  wire  [p_awid_par-1:0]  ahb_data_addr_shift_p;

  // Calculate the address used on the AHB.  This is made combinatorial
  // There are 3 possible sources for rx_dma_burst_addr:
  //  rx_dma_base_addr_arr[queue_ptr_rx_rph]
  //  nxt_descr_ptr[queue_ptr_rx_rph] with arithmetic operation
  //  ahb_data_addr with shift operation
  // For the purposes of parity protection of these operations they are separated
  // out such that this process will select the source and increment value which
  // will be used to update rx_dma_burst_addr in the next process.
  // The encodings for rx_dma_burst_addr_src are:
  //    0:  rx_dma_base_addr_arr[queue_ptr_rx_rph]
  //    1:  nxt_descr_ptr[queue_ptr_rx_rph] + rx_dma_burst_dscr_inc_val
  //    2:  ahb_data_addr which will be shifted based on dma_bus_width.
  always @ ( * )
  begin
    rx_dma_burst_dscr_inc_val = 32'd0;  // Default no increment

    // Setup address for upcoming MANRD
    // If current access has been made to the top queue and as the
    // address for this needs to be set up in the last man_write state
    // then check wrap bit for that queue.
    // Only applies when accessing the top queue
    if (ahbreqph_strobe_descr_rd)
    begin
      if (astrobe_manwr_last & current_wrap_bit_rph & queue_ptr_rx_rph == queue_ptr_rx_aph) // Wrap
        rx_dma_burst_addr_src = 2'b00;  // rx_dma_burst_addr = rx_dma_base_addr_arr[queue_ptr_rx_rph];
      else if (astrobe_manwr_last & queue_ptr_rx_rph == queue_ptr_rx_aph)
      begin
        rx_dma_burst_addr_src     = 2'b01;  // rx_dma_burst_addr = nxt_descr_ptr_pad[queue_ptr_rx_rph] + NEXT_DESCR_PTR_INC;
        rx_dma_burst_dscr_inc_val = next_descr_ptr_inc_val;
      end
      // update address for next MANRD word access
      else if (rx_dma_state_man_rd & descriptor_rd_2_access)
      begin
        rx_dma_burst_addr_src     = 2'b01;  // rx_dma_burst_addr = nxt_descr_ptr_pad[queue_ptr_rx_rph] + {26'd0,descr_rd_reqph_cnt,3'd0};
        rx_dma_burst_dscr_inc_val = {26'd0,descr_rd_reqph_cnt,3'd0};
      end
      else
        rx_dma_burst_addr_src = 2'b01;  // rx_dma_burst_addr = nxt_descr_ptr_pad[queue_ptr_rx_rph];
    end

    else if (rx_dma_state_data)
      rx_dma_burst_addr_src = 2'b10;  // rx_dma_burst_addr = ahb_data_addr_shift;  // Shifted according to dma_bus_width


    // Setup address for MAN WR
    // For single man wr accesses all words are written to nxt_descr_ptr* address
    // For two or four man wr accesses the address depends on data bus width
    // and if 64b addressing is enabled


    else if(descriptor_wr_1_access)
      rx_dma_burst_addr_src = 2'b01;  // rx_dma_burst_addr = nxt_descr_ptr_pad[queue_ptr_rx_rph];

    else if(descriptor_wr_2_access) begin

       // Setup address for Last management write (with WORD containing Ownership bit)
       if (inc_rx_dma_mux_addr_1)
         rx_dma_burst_addr_src  = 2'b01;  // rx_dma_burst_addr = nxt_descr_ptr_pad[queue_ptr_rx_rph];

       // Setup address for First management write
       else
         if (~rx_bd_extended_mode_en)
         begin
           rx_dma_burst_addr_src      = 2'b01;  // rx_dma_burst_addr = nxt_descr_ptr_pad[queue_ptr_rx_rph] + 32'h00000004;
           rx_dma_burst_dscr_inc_val  = 32'h00000004;
         end
         else
           if ( ~gem_dma_addr_w_is_64)
           begin
             rx_dma_burst_addr_src      = 2'b01;  // rx_dma_burst_addr = nxt_descr_ptr_pad[queue_ptr_rx_rph] + 32'h00000008;
             rx_dma_burst_dscr_inc_val  = 32'h00000008;
           end
           else
           begin
             rx_dma_burst_addr_src      = 2'b01;  // rx_dma_burst_addr = nxt_descr_ptr_pad[queue_ptr_rx_rph] + 32'h00000010;
             rx_dma_burst_dscr_inc_val  = 32'h00000010;
           end

    end

    else begin // descriptor_wr_4_access

      // Setup address for 4th (Last) management write (with WORD containing Ownership bit)
      if (inc_rx_dma_mux_addr_3)
        rx_dma_burst_addr_src = 2'b01;  // rx_dma_burst_addr = nxt_descr_ptr_pad[queue_ptr_rx_rph];

      // Setup address for 3rd management write
      else if (inc_rx_dma_mux_addr_2)
      begin
        rx_dma_burst_addr_src     = 2'b01;  // rx_dma_burst_addr = nxt_descr_ptr_pad[queue_ptr_rx_rph] + 32'h00000004;
        rx_dma_burst_dscr_inc_val = 32'h00000004;
      end

      // Setup address for 2nd management write
      else if (inc_rx_dma_mux_addr_1)
      begin
        if (~gem_dma_addr_w_is_64)
        begin
          rx_dma_burst_addr_src     = 2'b01;  // rx_dma_burst_addr = nxt_descr_ptr_pad[queue_ptr_rx_rph] + 32'h00000008;
          rx_dma_burst_dscr_inc_val = 32'h00000008;
        end
        else
        begin
          rx_dma_burst_addr_src     = 2'b01;  // rx_dma_burst_addr = nxt_descr_ptr_pad[queue_ptr_rx_rph] + 32'h00000010;
          rx_dma_burst_dscr_inc_val = 32'h00000010;
        end
      end
      // Setup address for 1st management write
      else // default setup addr if ((~astrobe_manwr_1st & ~manwr_astrobe2_en) & (manwr_astrobe_cnt == 4'h0))
      begin
        if (~gem_dma_addr_w_is_64)
        begin
          rx_dma_burst_addr_src     = 2'b01;  // rx_dma_burst_addr = nxt_descr_ptr_pad[queue_ptr_rx_rph] + 32'h0000000c;
          rx_dma_burst_dscr_inc_val = 32'h0000000c;
        end
        else
        begin
          rx_dma_burst_addr_src     = 2'b01;  // rx_dma_burst_addr = nxt_descr_ptr_pad[queue_ptr_rx_rph] + 32'h00000014;
          rx_dma_burst_dscr_inc_val = 32'h00000014;
        end
      end
    end

  end

  // Shift ahb_data_addr based on dma_bus_width
  always@(*)
  begin
    if (dma_bus_width == 2'b00)
      ahb_data_addr_shift = {ahb_data_addr[31:2],2'b00};
    else if (dma_bus_width == 2'b01)
      ahb_data_addr_shift = {ahb_data_addr[31:3],3'b000};
    else
      ahb_data_addr_shift = {ahb_data_addr[31:4],4'b0000};
  end

  assign ahb_data_addr_shift_p[31:0]  = ahb_data_addr_shift;

  // Optional parity regeneration:
  generate if (p_edma_asf_dap_prot == 1) begin : gen_ahb_data_addr_shift_par
    gem_par_chk_regen #(.p_chk_dwid (32),.p_new_dwid(32)) i_regen_par (
      .odd_par  (1'b0),
      .chk_dat  (ahb_data_addr[31:0]),
      .chk_par  (ahb_data_addr[p_awid_par-1:p_awid_par-4]),
      .new_dat  (ahb_data_addr_shift),
      .dat_out  (),
      .par_out  (ahb_data_addr_shift_p[35:32]),
      .chk_err  ()  // No need to check here as parity will be stored in register soon for checking.
    );
  end
  endgenerate

  // The adder for nxt_descr_ptr to generate rx_dma_burst_addr_inc
  edma_arith_par #(
    .p_dwidth (32),
    .p_pwidth (4),
    .p_has_par(p_edma_asf_dap_prot)
  ) i_arith_rx_dma_burst_addr_inc (
    .in_val (nxt_descr_ptr_pad[queue_ptr_rx_rph][31:0]),
    .in_par (nxt_descr_ptr_pad[queue_ptr_rx_rph][p_awid_par-1:p_awid_par-4]),
    .op_val (rx_dma_burst_dscr_inc_val),
    .op_add (1'b1),
    .out_val(rx_dma_burst_addr_inc[31:0]),
    .out_par(rx_dma_burst_addr_inc[35:32])
  );

  // Finally select the source for rx_dma_burst_addr:
  always@(*)
  begin
    case (rx_dma_burst_addr_src)
      2'b01:    rx_dma_burst_addr = rx_dma_burst_addr_inc[p_awid_par-1:0];
      2'b10:    rx_dma_burst_addr = ahb_data_addr_shift_p[p_awid_par-1:0];
      default:  rx_dma_burst_addr = rx_dma_base_addr_arr[queue_ptr_rx_rph];
    endcase
  end

  // instantiate the alignment block
  reg [3:0] eob_mod_in;
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      eob_mod_in <= 4'h0;
    else if (hdr_data_splitting_en & in_header & ({1'b0,remaining_hdr_bytes} <= buffer_size_words))
      eob_mod_in <= (pld_offset[3:0] & {dma_bus_width[1],|dma_bus_width[1:0],2'b11});
    else
      eob_mod_in <= 4'h0;
  end

  edma_pbuf_rx_align #(.p_edma_asf_dap_prot(p_edma_asf_dap_prot)) i_edma_pbuf_rx_align (

   .hclk                 (hclk),
   .n_hreset             (n_hreset),

   .dma_bus_width        (dma_bus_width),
   .hdr_data_splitting_en(hdr_data_splitting_en),
   .soft_reset           (~enable_rx_hclk | hresp_notok_eob),
   .data_in              (rxdpram_dob_downsize_pad),
   .par_in               (rxdpram_dob_downsize_par_pad),
   .data_in_vld          (prev_ahbreqph_strobe & ~padding_aph),

   .start_byte_in       ({bit3n2data_add_64,rx_dma_buffer_offset} & {dma_bus_width[1],|dma_bus_width[1:0],2'b11}),
   .eob_mod_in           (eob_mod_in & {4{buffer_fill_lvl == 12'h000}}),


   .eop_in               (reading_eop_dpram_aph),
   .mod_in               (status_word_3[3:0] & {dma_bus_width[1],|dma_bus_width[1:0],2'b11}),
   .early_eop_in         (reading_eop_dpram_rph),
   .all_outputs_sampled  (real_eop_ahb_dph),
   .eob_in               (buffer_fill_lvl == 12'h000),
   .push_residue         (prev_ahbreqph_strobe),

   .data_out             (rxdpram_dob_offset),
   .par_out              (rxdpram_dob_par_offset),
   .eop_out              (real_eop_ahb_aph_pulse),
   .early_eop_out        (real_eop_ahb_rph_pulse),
   .words_in_residue     (words_in_residue)
   );

  // real_eop_ahb_aph_pulse is a pulse that is generated 1 cycle after the request phase.
  // We need to time real_eop_ahb_aph to the address phase, so this needs to be stretched
  // until prev_ahbaddph_strobe
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      real_eop_ahb_rph_reg   <= 1'b0;
      real_eop_ahb_aph_reg   <= 1'b0;
      real_eop_ahb_dph_reg   <= 1'b0;
    end
    else
    begin
      if (~enable_rx_hclk)
      begin
        real_eop_ahb_rph_reg <= 1'b0;
        real_eop_ahb_aph_reg <= 1'b0;
      end
      else
      begin
        if (ahbreqph_strobe_data_nopad)
          real_eop_ahb_rph_reg <= 1'b0;
        else if (real_eop_ahb_rph_pulse)
          real_eop_ahb_rph_reg <= 1'b1;

        if (ahbaddph_strobe_data_nopad)
          real_eop_ahb_aph_reg <= 1'b0;
        else if (real_eop_ahb_aph_pulse)
          real_eop_ahb_aph_reg <= 1'b1;

        if (ahbdataph_strobe_data & real_eop_ahb_dph_reg)
          real_eop_ahb_dph_reg <= 1'b0;
        else if (real_eop_ahb_aph)
          real_eop_ahb_dph_reg <= 1'b1;
      end
    end
  end
  assign real_eop_ahb_rph = (real_eop_ahb_rph_reg | real_eop_ahb_rph_pulse) & ahbreqph_strobe_data_nopad;
  assign real_eop_ahb_aph = (real_eop_ahb_aph_reg | real_eop_ahb_aph_pulse) & ahbaddph_strobe_data_nopad;
  assign real_eop_ahb_dph = real_eop_ahb_dph_reg & ahbdataph_strobe_data;

  assign current_descriptor = str_descriptor_pad[queue_ptr_rx_aph];

  always @(*)
  begin
    if (~rx_bd_extended_mode_en | ~rx_eof_written)
      descr_wback_data_bit_2  = current_descriptor[2];
    else
      descr_wback_data_bit_2  = status_word_2[31];

    if (~jumbo_enable & rx_no_crc_check & ~rsc_en)
      descr_wback_data_bit_46 = status_word_2[28];    // rx_w_crc_error_hclk
    else
      descr_wback_data_bit_46 = status_word_3[13];   // rx_w_frame_length[13]

    if (crc_error_report)
      descr_wback_data_bit_49 = status_word_2[28];    // rx_w_crc_error_hclk
    else
      descr_wback_data_bit_49 = status_word_2[17];   // rx_w_tci_hclk[0]
  end

  // The actual packet data driven to AHB will originate from the DPRAM.
  // However,
  always @ ( * )
  begin
    if (rx_dma_state_data & padding_aph)
      rx_dma_data_out   = 128'd0;

    else if (rx_dma_state_data)
      rx_dma_data_out   = rxdpram_dob_offset[127:0];

    // Provide data for the 1st descriptor write (which actually happens second)
    // rx_dma_data_out is stored in dpram_do_str register before going into
    // hwdata register.  HWDATA is AHB dataphase, so we need dpram_do_str to be
    // address phase, and therefore rx_dma_data_out must be request phase
    else if (descriptor_wr_1_access)
    begin
      rx_dma_data_out[127:64] = {22'd0, rx_timestamp};
      rx_dma_data_out[31:0]   = {current_descriptor[31:3],
                                descr_wback_data_bit_2 ,
                                current_descriptor[1],
                                1'b1};
      if (rx_eof_written)  // last BD of frame contains stats updates
        rx_dma_data_out[63:32] = {
                           status_word_2[26],      // rx_w_broadcast_frame
                           status_word_2[25],      // rx_w_mult_hash_match
                           status_word_2[24],      // rx_w_uni_hash_match
                           status_word_2[13],      // |rx_w_ext_match
                           status_word_2[12],      // |rx_w_add_match
                           status_word_2[11:10],   // rx_add_match_code
                           status_word_2[16:14],   // rx_type_match_code
                           status_word_2[23],      // rx_w_vlan_tag_hclk
                           status_word_2[22],      // rx_w_prty_tag_hclk
                           status_word_2[20:18],   // rx_w_tci_hclk[3:1]
                           descr_wback_data_bit_49,
                           rx_eof_written,
                           rx_sof_written,
                           descr_wback_data_bit_46,// rx_w_frame_length[13]
                           status_word_3[12:0]};   // rx_w_frame_length[12:0]
      else  // if not the last BD of frame
        rx_dma_data_out[63:32] = {
                           14'd0,
                           (hdr_data_splitting_en & in_header & ({1'b0,remaining_hdr_bytes} <= buffer_size_words)),
                           (hdr_data_splitting_en & in_header),
                           1'b0,
                           rx_sof_written,
                           2'b00,
                           ({12{hdr_data_splitting_en & in_header}} & pld_offset)};

    end
    else  if(descriptor_wr_2_access)
    begin
      if (dma_bus_width == 2'b00)  // 32b data bus
      begin
        if (rx_dma_state_man_wr & manwr_astrobe2_en)   // last BD word to be written contains ownership bit
          if (rx_eof_written)  // update descr_wback_data_bit_2 in last BD of frame
            rx_dma_data_out = {96'd0,
                               current_descriptor[31:3],
                               descr_wback_data_bit_2 ,
                               current_descriptor[1],
                               1'b1};
          else
            rx_dma_data_out = {96'd0,current_descriptor[31:1],1'b1};



        // Provide data FIRST BD WRITE word after whole frame has been stored
        // in the memory. The 2nd descriptor word actually is written first
        // If not doing jumbo frames the top bit of the length field is borrowed
        // for indicating a frame which was copied but had bad CRC (in ignore
        // FCS mode).
        else if (rx_dma_next_man_wr & rx_eof_written) // last BD of frame contains stats updates
          rx_dma_data_out = {96'd0,
                             status_word_2[26],      // rx_w_broadcast_frame
                             status_word_2[25],      // rx_w_mult_hash_match
                             status_word_2[24],      // rx_w_uni_hash_match
                             status_word_2[13],      // |rx_w_ext_match
                             status_word_2[12],      // |rx_w_add_match
                             status_word_2[11:10],   // rx_add_match_code
                             status_word_2[16:14],   // rx_type_match_code
                             status_word_2[23],      // rx_w_vlan_tag_hclk
                             status_word_2[22],      // rx_w_prty_tag_hclk
                             status_word_2[20:18],   // rx_w_tci_hclk[3:1]
                             descr_wback_data_bit_49,
                             rx_eof_written,
                             rx_sof_written,
                             descr_wback_data_bit_46,// rx_w_frame_length[13]
                             status_word_3[12:0]};   // rx_w_frame_length[12:0]

        // provide data for  first descrptr write but the buffer is not the last
        // one for current frame so we don't update stats
        else  // if not last BD of frame
          rx_dma_data_out = {110'd0,
                             (hdr_data_splitting_en & in_header & ({1'b0,remaining_hdr_bytes} <= buffer_size_words)),
                             (hdr_data_splitting_en & in_header),
                             1'b0,
                             rx_sof_written,
                             2'b00,
                             ({12{hdr_data_splitting_en & in_header}} & pld_offset)};
      end
      else  // 64b and 128b data bus
      begin
        if (rx_dma_state_man_wr & manwr_astrobe2_en)   // last BD word to be written contains ownership bit
          if (rx_eof_written)  // update descr_wback_data_bit_2 in last BD of frame
            begin
              rx_dma_data_out[127:64] = {22'd0, rx_timestamp};
              rx_dma_data_out[31:0] = {current_descriptor[31:3],
                                       descr_wback_data_bit_2 ,
                                       current_descriptor[1],
                                       1'b1};
              rx_dma_data_out[63:32] = {
                                 status_word_2[26],      // rx_w_broadcast_frame
                                 status_word_2[25],      // rx_w_mult_hash_match
                                 status_word_2[24],      // rx_w_uni_hash_match
                                 status_word_2[13],      // |rx_w_ext_match
                                 status_word_2[12],      // |rx_w_add_match
                                 status_word_2[11:10],   // rx_add_match_code
                                 status_word_2[16:14],   // rx_type_match_code
                                 status_word_2[23],      // rx_w_vlan_tag_hclk
                                 status_word_2[22],      // rx_w_prty_tag_hclk
                                 status_word_2[20:18],   // rx_w_tci_hclk[3:1]
                                 descr_wback_data_bit_49,
                                 rx_eof_written,
                                 rx_sof_written,
                                 descr_wback_data_bit_46,// rx_w_frame_length[13]
                                 status_word_3[12:0]};   // rx_w_frame_length[12:0]

            // provide data for  first descrptr write but the buffer is not the last
            // one for current frame so we don't update stats
            end
          else
          begin
            rx_dma_data_out[127:32] = {78'd0,
                                       (hdr_data_splitting_en & in_header & ({1'b0,remaining_hdr_bytes} <= buffer_size_words)),
                                       (hdr_data_splitting_en & in_header),
                                       1'b0,
                                       rx_sof_written,
                                       2'b00,
                                      ({12{hdr_data_splitting_en & in_header}} & pld_offset)};
            rx_dma_data_out[31:0] = {current_descriptor[31:3],
                                     current_descriptor[2],
                                     current_descriptor[1],
                                     1'b1};

          end
        // Provide data FIRST BD WRITE word after whole frame has been stored
        // in the memory. The 2nd descriptor word actually is written first
        // If not doing jumbo frames the top bit of the length field is borrowed
        // for indicating a frame which was copied but had bad CRC (in ignore
        // FCS mode).
        else if (rx_dma_next_man_wr & rx_eof_written) // last BD of frame contains stats updates
          rx_dma_data_out = {86'd0, rx_timestamp };

        // provide data for  first descrptr write but the buffer is not the last
        // one for current frame so we don't update stats
        else  // if not last BD of frame
          rx_dma_data_out = {128'd0};
      end
    end

    else // if(descriptor_wr_4_access) only for 32b data bus
    begin
      if (rx_dma_state_man_wr & manwr_astrobe4_en)   // BD word 0 to be written contains ownership bit
        if (rx_eof_written)  // update ts-to_be_written in last BD of frame
          rx_dma_data_out = {96'd0,
                             current_descriptor[31:3],
                             descr_wback_data_bit_2 ,
                             current_descriptor[1],
                             1'b1};
        else
          rx_dma_data_out = {96'd0,current_descriptor[31:1],1'b1};


      // Provide data for 2nd last word after whole frame has been stored
      // in the memory. The 2nd descriptor word actually is written first
      // If not doing jumbo frames the top bit of the length field is borrowed
      // for indicating a frame which was copied but had bad CRC (in ignore
      // FCS mode).
      else if (rx_dma_state_man_wr & manwr_astrobe3_en)   // BD word 1 to be written contains stats
        if (rx_eof_written) // last BD of frame contains stats updates
          rx_dma_data_out = {96'd0,
                             status_word_2[26],      // rx_w_broadcast_frame
                             status_word_2[25],      // rx_w_mult_hash_match
                             status_word_2[24],      // rx_w_uni_hash_match
                             status_word_2[13],      // |rx_w_ext_match
                             status_word_2[12],      // |rx_w_add_match
                             status_word_2[11:10],   // rx_add_match_code
                             status_word_2[16:14],   // rx_type_match_code
                             status_word_2[23],      // rx_w_vlan_tag_hclk
                             status_word_2[22],      // rx_w_prty_tag_hclk
                             status_word_2[20:18],   // rx_w_tci_hclk[3:1]
                             descr_wback_data_bit_49,
                             rx_eof_written,
                             rx_sof_written,
                             descr_wback_data_bit_46,
                             status_word_3[12:0]};   // rx_w_frame_length[12:0]

        // provide data for  first descrptr write but the buffer is not the last
        // one for current frame
        else  // if not last BD of frame
          rx_dma_data_out = {110'd0,
                             (hdr_data_splitting_en & in_header & ({1'b0,remaining_hdr_bytes} <= buffer_size_words)),
                             (hdr_data_splitting_en & in_header),
                             1'b0,
                             rx_sof_written,
                             2'd0,
                             ({12{hdr_data_splitting_en & in_header}} & pld_offset)};

      else if (rx_dma_state_man_wr & manwr_astrobe2_en)   // 2nd BD word to be written
          rx_dma_data_out = {96'd0, rx_timestamp[31:0]};

      else // 1st BD word to be written
          rx_dma_data_out = {118'd0, rx_timestamp[41:32]};

    end

  end

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      hresp_notok_hold   <= 1'b0;
    else
    begin
      if (~enable_rx_hclk | hresp_notok_eob)
        hresp_notok_hold   <= 1'b0;
      else if (hresp_not_ok)
        hresp_notok_hold  <= 1'b1;
    end
  end

  generate for (g=0; g<p_edma_queues; g=g+1) begin : gen_rx_dma_descr_ptr
    assign rx_dma_descr_ptr[(g*32)+31:g*32]   = nxt_descr_ptr_pad[g][31:0];
    assign rx_dma_descr_ptr_par[(g*4)+3:g*4]  = (p_edma_asf_dap_prot == 1)  ? nxt_descr_ptr_pad[g][p_awid_par-1:p_awid_par-4] : 4'h0;
  end
  endgenerate


  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      rx_descr_ptr_reset <= 1'b0;
    else
      rx_descr_ptr_reset <= p_edma_axi == 1 & mac_err_vld & ~rx_dma_state_man_wr ;
  end


  // ---------------------------------------------------------------
  // Update the Statistics in the PCLK domain
  // This can be done as soon as the STATUS words have been read

  edma_sync_toggle_detect i_edma_sync_toggle_detect_rx_pkt_status_wr_tog (
    .clk(hclk),
    .reset_n(n_hreset),
    .din(rx_pkt_status_wr_tog),
    .rise_edge(),
    .fall_edge(),
    .any_edge(rx_pkt_status_wr_tog_edge));

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      rx_pkt_end_tog      <= 1'b0;
      prev_stats_captured <= 1'b1;
    end
    else
    begin
      if (~enable_rx_hclk)
      begin
        rx_pkt_end_tog      <= rx_pkt_end_tog;
        prev_stats_captured <= 1'b1;
      end

      else if (last_dpram_rd_state == P_STATUS_WORD_4)
      begin
        rx_pkt_end_tog      <= ~rx_pkt_end_tog;
        prev_stats_captured <= 1'b0;
      end

      // If we are waiting for the register block to capture the
      // stats off the status_word busses, we must ensure these
      // busses remain static - i.e we cant start reading a new pkt
      // from the DPRAM until the register block indicates it is done
      // with the data ...
      else if (rx_pkt_status_wr_tog_edge)
        prev_stats_captured <= 1'b1;
    end
  end


  // ---------------------------------------------------------------
  // When the packet is completely read from the DPRAM, inform the
  // write side of the packet buffer how many bytes can be recovered ..
  always @(*)
  begin
    if (ahbreqph_strobe_data & ~status_word1_capt & rx_cutthru)
    begin
      if (hresp_notok_eob)
        last_partpkt_rph = 1'b0;
      else
        last_partpkt_rph = ((part_dplocns == rx_cutthru_threshold) & empty_downsize);
    end

    else if  (hresp_data_cutthru | flush_next_packet)
      last_partpkt_rph = 1'b1;

    else if (ahb_err_pktdiscarded_wait4end)
    // While we are waiting for the end of the packet to be read after an error
    // event then just recover every time a part of packet is read in
      last_partpkt_rph = part_pkt_written_d1;

    else
      last_partpkt_rph = 1'b0;
  end

  // ahb_err_discard_recover will be set when a packet needs to be flushed ...
  // This only occurs when an ahb error happens and we are configured in cut-thru modes
  // or when force_discard_on_err is set ...
  // For the case where we want to use rx_buffer_used_bit in store/forward, we need to make
  // sure we have read the status from the DPRAM and the part_dplocns_left is
  // updated properly before we can act on it -
  // otherwise we wont know how many locations to clear up
  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      rx_buffer_used_bit_d1 <= 1'b0;
      ahb_sf_err_hold <= 1'b0;
      ahb_sf_err_vld <= 1'b0;
    end
    else
    begin
      rx_buffer_used_bit_d1 <= rx_buffer_used_bit;

      if (status_word1_capt | nxt_rx_dma_state != RX_DMA_IDLE | flush_next_packet)
        ahb_sf_err_hold <= 1'b0;
      else if (ahbdataph_strobe_descr_rd & (|num_pkts_needing_read))
        ahb_sf_err_hold <= rx_buffer_used_bit | hresp_notok_eob;
      ahb_sf_err_vld <= (rx_buffer_used_bit | (ahb_sf_err_hold & rx_dma_state == RX_DMA_IDLE) |
                            (hresp_notok_eob & ahbdataph_strobe_descr_rd & ~rx_cutthru)) &
                            status_word1_capt & status_word_1[0] & ~flush_next_packet;

    end
  end

  // -----------------------------------------------------------------------------
  // Per-queue receive flushing Mode1 implementation
  // -----------------------------------------------------------------------------
  // This has to be a register because otherwise there would
  // be a combinatorial loop between queue_ptr_rx_rph
  // and force_discard_on_err_queue
  wire [15:0] force_discard_on_err_q_pad;
  assign force_discard_on_err_q_pad[p_edma_queues-1:0] = force_discard_on_err_q;
  always @ (posedge hclk or negedge n_hreset)
  begin
    if(~n_hreset)
      force_discard_on_err_queue <= 1'b0;
    else
      begin
        if(force_discard_on_err_q_pad[queue_ptr_rx_rph])
          force_discard_on_err_queue <= 1'b1;
        else
          force_discard_on_err_queue <= 1'b0;
      end
  end

  assign force_discard_on_error = force_discard_on_err_queue | force_discard_on_err;


  // In store and forward mode, we can discard a packet when a resource error occurs,
  // but only after the status has been captured.  We can also discard when an HRESP
  // error occurs in either the descriptor read or data write states
  assign ahb_sf_err = ~(rx_cutthru & frame_reading_as_cutthru) &
                       (force_discard_on_error | rx_cutthru)  &
                      ((hresp_notok_eob & ahbdataph_strobe_data & ~rx_cutthru) | ahb_sf_err_vld);

  // In cut-thru modes, things are done a little differently and we can discard based on the
  // raw information.
  assign ahb_ct_err =  rx_cutthru &
                        ((hresp_notok_eob & rx_dma_state != RX_DMA_IDLE)     |
                         (rx_buffer_used_bit_d1 & frame_reading_as_cutthru)) &
                         (ahbdataph_strobe_data    |
                         (|num_parts_needing_read) |
                         (|num_pkts_needing_read));

  assign ahb_err_discard  =  (ahb_sf_err | ahb_ct_err);

  assign ahb_err_discard_recover = ahb_err_discard;

  edma_sync_toggle_detect i_edma_sync_toggle_detect_pkt_done_capt_tog (
    .clk(hclk),
    .reset_n(n_hreset),
    .din(pkt_done_capt_tog),
    .rise_edge(),
    .fall_edge(),
    .any_edge(pkt_done_capt_tog_edge));

  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      frame_reading_as_cutthru  <= 1'b0;
    end
    else
    begin
      if (dpram_rd_state == P_IDLE)
        frame_reading_as_cutthru <= start_reading_at_risk;
    end
  end


// This section has come out to try improve code coverage ...
always @(*)
begin
  if (~(|recover_dplocns_err[p_edma_rx_pbuf_addr-1:0]) & (last_partpkt_rph | reading_eop_dpram_rph)) begin
    if (gem_rx_pbuf_data_w_is_128)    pkt_done_dplocns_nxt = part_dplocns_p2[p_edma_rx_pbuf_addr-1:0];
    else if (dma_bus_width[0])        pkt_done_dplocns_nxt = part_dplocns_p3[p_edma_rx_pbuf_addr-1:0];
    else if (~rx_bd_extended_mode_en) pkt_done_dplocns_nxt = part_dplocns_p4[p_edma_rx_pbuf_addr-1:0];
    else                              pkt_done_dplocns_nxt = part_dplocns_p5[p_edma_rx_pbuf_addr-1:0];
  end
  else begin
    if (gem_rx_pbuf_data_w_is_128)    pkt_done_dplocns_nxt = recover_dplocns_err_p1[p_edma_rx_pbuf_addr-1:0];
    else if (dma_bus_width[0])        pkt_done_dplocns_nxt = recover_dplocns_err_p2[p_edma_rx_pbuf_addr-1:0];
    else if (~rx_bd_extended_mode_en) pkt_done_dplocns_nxt = recover_dplocns_err_p3[p_edma_rx_pbuf_addr-1:0];
    else                              pkt_done_dplocns_nxt = recover_dplocns_err_p4[p_edma_rx_pbuf_addr-1:0];
  end
end

// Helper signal ...
  always @(*)
  begin
    if (gem_rx_pbuf_data_w_is_128)
      pkt_dplocns_to_flush_plus_st    = recover_dplocns_err_p1[p_edma_rx_pbuf_addr-1:0];
    else if (dma_bus_width[0])
      pkt_dplocns_to_flush_plus_st    = recover_dplocns_err_p2[p_edma_rx_pbuf_addr-1:0];
    else
      if (~rx_bd_extended_mode_en)
        pkt_dplocns_to_flush_plus_st  = recover_dplocns_err_p3[p_edma_rx_pbuf_addr-1:0];
      else
        pkt_dplocns_to_flush_plus_st  = recover_dplocns_err_p4[p_edma_rx_pbuf_addr-1:0];
  end

  wire [16:0] pkt_dplocns_plus_part_dplocns_left;  
  assign      pkt_dplocns_plus_part_dplocns_left = {5'd0,pkt_dplocns} + {{(17-p_edma_rx_pbuf_addr){1'b0}},part_dplocns_left};

  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      pkt_done_tog          <= 1'b0;
      part_dplocns_left     <= {p_edma_rx_pbuf_addr{1'b0}};
      part_dplocns          <= {p_edma_rx_pbuf_addr{1'b0}};
      pkt_dplocns           <= 12'h000;
      pkt_dplocns_str       <= {p_edma_rx_pbuf_addr{1'b0}};
      pkt_done_dplocns      <= {p_edma_rx_pbuf_addr{1'b0}};
      wait_for_pktdone_capt <= 1'b0;
      take_stored_value     <= 1'b0;
      hresp_data_cutthru    <= 1'b0;
      part_pkt_written_d1   <= 1'b0;
    end
    else
    begin
      hresp_data_cutthru    <= ahb_err_discard_recover;
      part_pkt_written_d1   <= part_pkt_written;

      if (~enable_rx_hclk)
      begin
        pkt_done_tog          <= pkt_done_tog;
        part_dplocns_left     <= {p_edma_rx_pbuf_addr{1'b0}};
        part_dplocns          <= {p_edma_rx_pbuf_addr{1'b0}};
        pkt_dplocns           <= 12'h000;
        pkt_dplocns_str       <= {p_edma_rx_pbuf_addr{1'b0}};
        pkt_done_dplocns      <= {p_edma_rx_pbuf_addr{1'b0}};
        wait_for_pktdone_capt <= 1'b0;
        take_stored_value     <= 1'b0;
      end
      else
      begin
        // pkt_dplocns,part_dplocns and part_dplocns_left are used to identify where the EOP
        // of a packet is, and also to calculate how many DPRAM locations must be recovered
        // after either an EOP, an end of "part", or after some error event.
        // 'pkt_dplocns' keeps track of the number of DPRAM reads.
        // 'part_dplocns' also keeps track of the number of DPRAM reads, but resets when
        // we reach a part of packet boundary
        // 'part_dplocns_left' is used to understand how many reads remain until we hit a
        // part of packet boundary - NOTE we need both part_dplocns and part_dplocns_left
        //
        // MAJOR COMPLICATION !
        // In normal operating modes, the packet does not start to be fetched from DPRAM
        // until we have obtained the status of that packet, and therefore know the length
        // of the packet, and if the packet was errored in some way.  For cut-thru modes,
        // we dont have this information, so we read "at risk".  At some point before the end
        // of the packet, we will obtain the status (actually this will always be on a
        // 'part of packet' boundary).  For every 'part of packet' that we successuly fetch
        // we will free up the resources that that 'part of packet' used in the DPRAM.  If we
        // eventually discover that the packet was BAD (errored from the MAC side of DPRAM),
        // then we will want to stop fetching data, and free up the remaining resources of
        // that packet.  Since we know we will be on a part of packet boundary, we can
        // guarantee that the remaining resources = (total pkt length - pkt_dplocns)
        // If there is an error on this side of the DPRAM, like an HRESP error, then we
        // cannot guarantee that this will happen on a 'part of packet' boundary.  Furthermore,
        // it is quite possible due to cut-thru that the packet has not even been fully written
        // into the DPRAM yet and writes on the AHB side continue.  If we simply stop fetching
        // data until the status is known, there is a real risk of overflow which will
        // just confuse the software and is not very elegant.  Therefore, we need to do 3 things
        // on discovering errors on the AHB side of the DPRAM whilst in cut-thru
        //  1) On discovering the error(like hresp, or resource error),  we need to bump
        //     'pkt_dplocns' and 'part_dplocns' up to a packet boundary and initiate a
        //     part_of_packet dpram space recovery
        //  2) On every subsequent 'part_pkt_written' we perform a part_of_packet dpram
        //     space recovery
        //  3) When 'pkt_written_dpram' is written, we need to recover the last few locations
        //     of the packet
        //     as identified by part_dplocns_left

        // On an AHB error, bump 'pkt_dplocns' up to a part of pkt boundary.
        if (ahb_err_discard_recover)
          pkt_dplocns  <= pkt_dplocns_plus_part_dplocns_left[11:0];

        // ahb_err_pktdiscarded_wait4end indicates that we are just reading the remaining
        // packet data from DPRAM but discarding it without forwarding to AHB
        // Essentially we can just keep adding rx_cutthru_threshold to pkt_dplocns
        // whenever a full part has been read from DPRAM
        // Once the status has been obtained we can reset pkt_dplocns
        else if (ahb_err_pktdiscarded_wait4end)
        begin
          if (status_word1_capt)
            pkt_dplocns  <= 12'h000;
          else if (part_pkt_written & (num_pkts_needing_read == {p_edma_rx_pbuf_addr{1'b0}}))
            pkt_dplocns  <= pkt_dplocns_c1;
        end

        // Can clear down when we are done with it ...
        //  - when we read the status, we should be done with this packet
        //  - or an hresp error while not in cut-thru
        //  - or when we are flushing the frame and ahb_err_pktdiscarded_wait4end is low
        else if ((last_dpram_rd_state == P_STATUS_WORD_4 & ~status_word_1[0]) |
                  hresp_notok_eob | hresp_data_cutthru | flush_next_packet)
          pkt_dplocns  <= 12'h000;

        // Else just increment when we read
        else if (ahbreqph_strobe_data_nopad & ~reading_eop_dpram_rph_del)
        begin
          if (reading_eop_dpram_rph)
            pkt_dplocns  <= 12'h000;
          else if (empty_downsize && dpram_rd_state != P_IDLE)
              pkt_dplocns  <= pkt_dplocns + 12'h001;

        end



        // On an AHB error, bump 'part_dplocns' up to a part of pkt boundary.
        if (ahb_err_discard_recover)
          part_dplocns  <= part_dplocns + part_dplocns_left
                          - {{p_edma_rx_pbuf_addr-1{1'b0}},1'b1};

        // ahb_err_pktdiscarded_wait4end indicates that we are just reading the remaining
        // packet data from DPRAM but discarding it without forwarding to AHB
        // Essentially we can just set part_dplocns to rx_cutthru_threshold and
        // whenever a full part has been read from DPRAM, we can just recover it
        // Once the status has been obtained, we are done with the frame and can
        // reset part_dplocns
        else if (ahb_err_pktdiscarded_wait4end)
        begin
          if (status_word_early_fetch_count > 3'd0 || status_word1_capt ||
              last_dpram_rd_state == P_STATUS_WORD_1 || last_dpram_rd_state == P_STATUS_WORD_2)
            part_dplocns  <= {p_edma_rx_pbuf_addr{1'b0}};
          else if (part_pkt_written)
            part_dplocns  <= rx_cutthru_threshold;
        end

        // Can clear down when we are done with it ...
        //  - when we read the status
        //  - or an hresp error while not in cut-thru
        //  - or when we are flushing the frame and ahb_err_pktdiscarded_wait4end is low
        else if ((last_dpram_rd_state == P_STATUS_WORD_4 & ~status_word_1[0]) |
                 hresp_notok_eob | hresp_data_cutthru | flush_next_packet)
          part_dplocns  <= {p_edma_rx_pbuf_addr{1'b0}};

        // Else just increment when we read
        else if (ahbreqph_strobe_data_nopad & ~reading_eop_dpram_rph_del)
        begin
          if (last_partpkt_rph | reading_eop_dpram_rph)
            part_dplocns  <= {p_edma_rx_pbuf_addr{1'b0}};
          else if (empty_downsize && dpram_rd_state != P_IDLE)
            part_dplocns  <= part_dplocns + {{p_edma_rx_pbuf_addr-1{1'b0}},1'b1};
        end

        // part_dplocns_left is similar to part_dplocns except that it is
        // a decrementing counter. It is used to calculate the end
        // of a burst when there are no more packet parts to fetch
        // If hburst, then we will replay the full packet, but since we
        // already have the status, we can just reload part_dplocns_left
        if (hresp_notok_eob & ~rx_cutthru & dpram_rd_state == P_PKT_DATA)
          part_dplocns_left  <= status_word_1[14+p_edma_rx_pbuf_addr:15];

        else if (hresp_data_cutthru | ahb_err_pktdiscarded_wait4end | flush_next_packet)
          part_dplocns_left <= {p_edma_rx_pbuf_addr{1'b0}};

        else if (status_word1_capt & ~status_word2_capt & status_word_1[0])
          part_dplocns_left  <= tmp_recovery_bus[p_edma_rx_pbuf_addr-1:0] - {{p_edma_rx_pbuf_addr-1{1'b0}}, ahbreqph_strobe_data_nopad & empty_downsize};

        else if (start_reading_at_risk) begin
          if (part_pkt_written)
            part_dplocns_left  <= part_dplocns_left_c1[p_edma_rx_pbuf_addr-1:0];
          else
            part_dplocns_left  <= part_dplocns_pending;
        end
        else if (part_pkt_written && !part_dplocns_pending_for_new_frame) begin
          if (ahbreqph_strobe_data_nopad & empty_downsize)
            part_dplocns_left  <= part_dplocns_left_c2[p_edma_rx_pbuf_addr-1:0];
          else
            part_dplocns_left  <= part_dplocns_left_c3[p_edma_rx_pbuf_addr-1:0];
        end

        // Standard decrement when we perform an AHB write
        else if (ahbreqph_strobe_data_nopad & (empty_downsize|reading_eop_dpram_rph))
          // Don't allow to decrement beyond 0
          if (part_dplocns_left!={p_edma_rx_pbuf_addr{1'b0}})
            part_dplocns_left  <= part_dplocns_left - {{p_edma_rx_pbuf_addr-1{1'b0}},1'b1};

        // ---------------------------------------------------------------------------------

        // Identify how many locations we can clear the PKTBUFFER ...
        // If there was no data associated with the packet, then we should
        // always clear 3 locations (= to the number of status words)
        // If we have finished reading a part of a packet, then we can
        // clear the number of locations = to the part size
        // If we have finished reading the packet, then we can clear the
        // remaining number of locations ...
        if (~wait_for_pktdone_capt | pkt_done_capt_tog_edge)
        begin
          if (take_stored_value)
          begin
            pkt_done_tog          <= ~pkt_done_tog;
            wait_for_pktdone_capt <= 1'b1;
            pkt_done_dplocns      <= pkt_dplocns_str;
          end

          else if (flush_next_packet)
          begin
            pkt_done_tog          <= ~pkt_done_tog;
            wait_for_pktdone_capt <= 1'b1;
            pkt_done_dplocns      <= status_word_1[p_edma_rx_pbuf_addr+14:15];
          end

          // 3 events cause us to want to recover some dpram storage
          else if ((last_dpram_rd_state == P_STATUS_WORD_4)|
                    last_partpkt_rph |
                    reading_eop_dpram_rph)
          begin
            pkt_done_tog          <= ~pkt_done_tog;
            wait_for_pktdone_capt <= 1'b1;

            // Clear 3 locations when the status is read
            // If cut-thru mode is active, then we need to caluclate how many
            // locations to clear.  This is actually quite complex, as we might
            // have already cleared away a lot of the packet as we were writing
            // it to AHB memory.  The total number of locations we need to clear
            // is given to us in status_word_1, bits [26:15].  The number
            // of locations we have already cleared is given by pkt_dplocns
            // This will already be a direct multiple of cut-thru threshold, as
            // the status is only read after the end of writing a full pkt fragment
            // To calculate the remainder, we need to subtract ...
            if (last_dpram_rd_state == P_STATUS_WORD_4)
              pkt_done_dplocns   <= pkt_done_dplocns_nxt;
            // Clear rx_cutthru_threshold locations when the
            // part_dplocns == rx_cutthru_threshold
            // Clear remaining number of locations when eop is read ...
            else // if (last_partpkt_rph | reading_eop_dpram_rph)
              pkt_done_dplocns    <= part_dplocns + {{p_edma_rx_pbuf_addr-1{1'b0}},1'd1};
          end

          else
            wait_for_pktdone_capt <= 1'b0;
        end

        // Store up dpram locations to recover while the handshake logic
        // is busy
        if (wait_for_pktdone_capt)
        begin
          if (pkt_done_capt_tog_edge)
          begin
            if (flush_next_packet)
            begin
              take_stored_value  <= 1'b1;
              pkt_dplocns_str    <= status_word_1[p_edma_rx_pbuf_addr+14:15];
            end

            // Clear 3 locations when the status is read
            else if (last_dpram_rd_state == P_STATUS_WORD_4 & take_stored_value)
              pkt_dplocns_str   <= pkt_dplocns_to_flush_plus_st;

            // Clear rx_cutthru_threshold locations when the
            // part_dplocns == rx_cutthru_threshold
            // Clear remaining number of locations when eop is read ...
            else if ((last_partpkt_rph | reading_eop_dpram_rph) & take_stored_value)
            begin
              pkt_dplocns_str   <= part_dplocns + {{p_edma_rx_pbuf_addr-1{1'b0}},1'b1};
            end

            else
            begin
              take_stored_value <= 1'b0;
              pkt_dplocns_str   <= {p_edma_rx_pbuf_addr{1'b0}};
            end
          end
          else
          begin
            if (flush_next_packet)
            begin
              take_stored_value <= 1'b1;
              pkt_dplocns_str   <= pkt_dplocns_str_c1[p_edma_rx_pbuf_addr-1:0];
            end

            // Clear 3 locations when the status is read
            else if (last_dpram_rd_state == P_STATUS_WORD_4)
            begin
              take_stored_value <= 1'b1;
              pkt_dplocns_str   <= pkt_dplocns_str_c2[p_edma_rx_pbuf_addr-1:0];
            end

            // Clear rx_cutthru_threshold locations when the
            // part_dplocns == rx_cutthru_threshold
            // Clear remaining number of locations when eop is read ...
            else if ((last_partpkt_rph & ~last_partpkt_rph_seen_at_error) | reading_eop_dpram_rph)
            begin
              take_stored_value <= 1'b1;
              pkt_dplocns_str   <= pkt_dplocns_str_c3[p_edma_rx_pbuf_addr-1:0];
            end
          end
        end

        else
        begin
          take_stored_value     <= 1'b0;
          pkt_dplocns_str       <= {p_edma_rx_pbuf_addr{1'b0}};
        end
      end
    end
  end


  parameter WAIT      = 1'b1;
  parameter DONT_WAIT = 1'b0;

  // Interrupt generation
  // Write the status updates to the upper layer, which will in turn
  // create the interrupt based on the information we send ...
  assign pclk_has_captured_stat = (rx_stat_capt_pulse & wait_for_capt);
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      rx_dma_stable_tog   <= 1'b0;
      wait_for_capt       <= DONT_WAIT;
      rx_dma_buff_not_rdy <= 1'b0;
      rx_dma_complete_ok  <= 1'b0;
      rx_dma_hresp_notok  <= 1'b0;
      rx_dma_resource_err <= 1'b0;
      buff_not_rdy_str    <= 1'b0;
      hresp_notok_str     <= 1'b0;
      complete_ok_str     <= 1'b0;
      rx_dma_int_queue    <= 4'h0;
      rx_dma_int_q_str    <= 4'h0;
    end
    else
    begin
      if (~enable_rx_hclk)
      begin
        buff_not_rdy_str    <= 1'b0;
        hresp_notok_str     <= 1'b0;
        complete_ok_str     <= 1'b0;
        rx_dma_stable_tog   <= 1'b0;
        wait_for_capt       <= DONT_WAIT;
        rx_dma_buff_not_rdy <= 1'b0;
        rx_dma_hresp_notok  <= 1'b0;
        rx_dma_complete_ok  <= 1'b0;
        rx_dma_resource_err <= 1'b0;
        rx_dma_int_queue    <= 4'h0;
        rx_dma_int_q_str    <= 4'h0;
      end
      else
      begin
        // Interrupt information has been captured by PCLK ?
        if (wait_for_capt)
        begin
          if (pclk_has_captured_stat)
          begin
            buff_not_rdy_str <= 1'b0;
            hresp_notok_str <= 1'b0;
            complete_ok_str <= 1'b0;
            if (buff_not_rdy_str | hresp_notok_str | complete_ok_str)
            begin
              wait_for_capt <= WAIT;
              rx_dma_stable_tog <= ~rx_dma_stable_tog;
              rx_dma_buff_not_rdy <= buff_not_rdy_str;
              rx_dma_resource_err <= buff_not_rdy_str;
              rx_dma_hresp_notok  <= hresp_notok_str;
              rx_dma_complete_ok  <= complete_ok_str;
              rx_dma_int_queue    <= rx_dma_int_q_str;
            end

            else if (int_source)
            begin
              wait_for_capt <= WAIT;
              rx_dma_stable_tog <= ~rx_dma_stable_tog;
              rx_dma_buff_not_rdy <= rx_buffer_used_bit;
              rx_dma_resource_err <= rx_buffer_used_bit;
              rx_dma_hresp_notok  <= hresp_notok_eob;
              rx_dma_complete_ok  <= (int_source_rx_comp &
                                      ~rx_buffer_used_bit &
                                      ~hresp_notok_eob);
              rx_dma_int_queue    <= queue_ptr_rx_dph;
            end
            else
            begin
              wait_for_capt <= DONT_WAIT;
              rx_dma_buff_not_rdy <= 1'b0;
              rx_dma_resource_err <= 1'b0;
              rx_dma_hresp_notok  <= 1'b0;
              rx_dma_complete_ok  <= 1'b0;
            end
          end

          else if (int_source)
          begin
            buff_not_rdy_str <= rx_buffer_used_bit;
            hresp_notok_str  <= hresp_notok_eob;
            complete_ok_str  <= (int_source_rx_comp &
                                 ~rx_buffer_used_bit &
                                 ~hresp_notok_eob &
                                 ~rx_dma_buff_not_rdy &
                                 ~rx_dma_resource_err &
                                 ~rx_dma_hresp_notok);
            rx_dma_int_q_str    <= queue_ptr_rx_dph;
          end
        end

        else if (int_source)
        begin
              wait_for_capt <= WAIT;
              rx_dma_stable_tog <= ~rx_dma_stable_tog;
              rx_dma_buff_not_rdy <= rx_buffer_used_bit;
              rx_dma_resource_err <= rx_buffer_used_bit;
              rx_dma_hresp_notok  <= hresp_notok_eob;
              rx_dma_complete_ok  <= (int_source_rx_comp &
                                      ~hresp_notok_eob & ~hresp_notok_hold);
              rx_dma_int_queue    <= queue_ptr_rx_dph;
        end
      end
    end
  end

// Condition to generate interrupt
// Generate interrupt once the writeback for the packet has finished ...
// or when a buffer was requested but is not available
// or when there is an AHB error
// or when a non zero pause frame is received
assign int_source_rx_comp =  (rx_dma_state != RX_DMA_MAN_WR &
                              last_rx_dma_state == RX_DMA_MAN_WR & rx_eof_written & hready);

assign int_source = (int_source_rx_comp | rx_buffer_used_bit | hresp_notok_eob );

assign from_rx_dma_used_bit_read  = p_edma_axi == 1 ? rx_buffer_used_bit : 1'b0;
assign from_rx_dma_queue_ptr      = p_edma_axi == 1 ? queue_ptr_rx_dph : 4'h0;

// Gemstone Specific for Flow Control

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      allow_wr_q    <= 1'b0;
    else if (ahbreqph_strobe_data)
      allow_wr_q    <= 1'b1;
    else if (astrobe_manwr_1st)
      allow_wr_q    <= 1'b0;
  end

  generate for (g=0; g<p_edma_queues; g=g+1) begin : gen_rx_databuf_wr_q
    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        rx_databuf_wr_q[g] <= 1'b0;
      else if (ahbreqph_strobe_data & ~allow_wr_q & queue_ptr_rx_rph == g[3:0])
        rx_databuf_wr_q[g] <= ~rx_databuf_wr_q[g];
    end
  end
  endgenerate

  assign ahb_queue_ptr_rx = queue_ptr_rx_dph;

  assign write_to_base_descr = p_edma_rsc == 1 && astrobe_manwr_last;

  ///////////////////////////////////////////
  // ASF - data path parity protection
  generate if(p_edma_asf_dap_prot == 1) begin:gen_edma_dp_par

    wire  [p_edma_queues-1:0] dap_err_nxt_descr_ptr;
    wire                      dap_err_dpram_dob_offset_c;
    wire                      dap_err_dma_data_c;
    reg                       dap_err_dma_data_r;
    wire                      dap_err_hwdata;
    wire                      dap_err_haddr;
    wire                      dap_err_status_words;
    reg                       asf_dap_rx_rd_err_r;
    wire                      dap_err_dma_data;
    // Check various sources that are used for creating rx_dma_data_out and regenerate
    // parity for it based on new data.
    // This is based on the following:
    //  rxdpram_dob_offset
    //  rx_timestamp - this is already based on status_word_2/3/4 so already checked those
    //  current_descriptor
    //  status_word_1
    gem_par_chk_regen #(
      .p_chk_dwid(42+32+32),
      .p_new_dwid(128)
    ) i_regen_rx_dma_data_out_par (
      .odd_par  (1'b0),
      .chk_dat  ({rx_timestamp,
                  status_word_1[31:0],
                  current_descriptor[31:0]}),
      .chk_par  ({rx_timestamp_par,
                  status_word_1[35:32],
                  current_descriptor[35:32]}),
      .new_dat  (rx_dma_data_out),
      .dat_out  (),
      .par_out  (rx_dma_data_out_par),
      .chk_err  (dap_err_dma_data_c)
    );

    // The rxdpram_dob_offset check is separated out as this comes direct from the RAM
    // and can be unclean. This doesn't matter as it is not used in those circumstances
    // but we still want to separate out the checking as the regen module above performs
    // feed forward poisoning so if the RAM data is not needed, the poisoning will still
    // affect the other sources.
    cdnsdru_asf_parity_check_v1 #(.p_data_width(128)) i_par_chk_dob_offset (
      .odd_par(1'b0),
      .data_in(rxdpram_dob_offset),
      .parity_in(rxdpram_dob_par_offset),
      .parity_err(dap_err_dpram_dob_offset_c)
    );

    // Register the parity check result as this is looking at RAM data which may be changing
    // so register to keep it clean.. also only care when use_data_imm is set which is the
    // sample point...
    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        dap_err_dma_data_r  <= 1'b0;
      else
        if (use_data_imm)
          dap_err_dma_data_r  <= dap_err_dma_data_c | (dap_err_dpram_dob_offset_c & rx_dma_state_data);
        else
          dap_err_dma_data_r  <= 1'b0;
    end
    assign dap_err_dma_data = dap_err_dma_data_r;


    // nxt_descr_ptr is present for each queue
    genvar loop_q;
    for (loop_q=0;loop_q<p_edma_queues;loop_q=loop_q+1) begin : gen_chk_nxt_descr_ptr
      cdnsdru_asf_parity_check_v1 #(.p_data_width(32)) i_par_chk (
        .odd_par(1'b0),
        .data_in(nxt_descr_ptr_pad[loop_q][31:0]),
        .parity_in(nxt_descr_ptr_pad[loop_q][35:32]),
        .parity_err(dap_err_nxt_descr_ptr[loop_q])
      );
    end

    // haddr is 64-bits
    cdnsdru_asf_parity_check_v1 #(.p_data_width(64)) i_par_chk_haddr (
      .odd_par(1'b0),
      .data_in(haddr[63:0]),
      .parity_in(haddr_par[7:0]),
      .parity_err(dap_err_haddr)
    );

    // Check the status words
    cdnsdru_asf_parity_check_v1 #(.p_data_width(128)) i_par_chk_status_words (
      .odd_par(1'b0),
      .data_in({status_word_4[31:0],
                status_word_3[31:0],
                status_word_2[31:0],
                status_word_1[31:0]}),
      .parity_in({status_word_4[35:32],
                  status_word_3[35:32],
                  status_word_2[35:32],
                  status_word_1[35:32]}),
      .parity_err(dap_err_status_words)
    );

    //////////////
    // Parity check at the hwdata
    // Module output and is in fact the overall
    // data output for the entire GEM when the DMA is included.
    cdnsdru_asf_parity_check_v1 #(.p_data_width(128)) i_par_chk_hwdata (
      .odd_par(1'b0),
      .data_in(hwdata[127:0]),
      .parity_in(hwdata_par[15:0]),
      .parity_err(dap_err_hwdata)
    );

    // Register the output
    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        asf_dap_rx_rd_err_r <= 1'b0;
      else
        asf_dap_rx_rd_err_r <= dap_err_hwdata |
                                dap_err_haddr |
                                dap_err_dma_data |
                                (|dap_err_nxt_descr_ptr) |
                                dap_err_status_words |
                                dap_err_addr_or_mask;
    end
    assign asf_dap_rx_rd_err  = asf_dap_rx_rd_err_r;
  end // gen_edma_dp_par
  else begin : gen_no_dp_parity
    assign rx_dma_data_out_par     = 16'd0;
    assign asf_dap_rx_rd_err       = 1'b0;
  end
  endgenerate


  //------------------------------------------------------------------------------
  // RX PER-QUEUE RX FLUSH : Per-queue DPSRAM Buffer Fill Level Detection (Mode2)
  //------------------------------------------------------------------------------
  reg [p_edma_rx_pbuf_addr-1:0] num_locns_to_free;
  reg                     [2:0] num_status_words;
  wire                          dpram_push;
  wire                          dpram_pop;

  always @ *
  begin
    if(gem_rx_pbuf_data_w_is_128)
      num_status_words = 3'd1;
    else
      begin
        if(dma_bus_width[0]) // 64 bits
          num_status_words = 3'd2;
        else
          begin // 32 bits
            if(~rx_bd_extended_mode_en)
              num_status_words = 3'd3;
            else
              num_status_words = 3'd4;
          end

      end
  end

  always @ (*)
  begin
    if(flush_next_packet)
      num_locns_to_free = status_word_1[p_edma_rx_pbuf_addr+14:15];
    else if(last_dpram_rd_state == P_STATUS_WORD_4)
      num_locns_to_free = pkt_done_dplocns_nxt;
    else //if (last_partpkt_rph | reading_eop_dpram_rph)
      num_locns_to_free = part_dplocns + {{p_edma_rx_pbuf_addr-1{1'b0}},1'd1};
  end

  assign dpram_pop    = flush_next_packet || (last_dpram_rd_state == P_STATUS_WORD_4) || last_partpkt_rph || reading_eop_dpram_rph;
  assign dpram_push   = (dpram_rd_state == P_STATUS_WORD_4);

  genvar s;
  generate for (s=0; s<p_edma_queues; s=s+1) begin: gen_fill_lvl_q
    wire                          dpram_push_q;
    wire                          dpram_pop_q;
    wire                   [16:0] fill_lvl_q_incr;
    wire                   [16:0] fill_lvl_q_decr;
    wire                   [15:0] max_val_pclk_q;
    reg [p_edma_rx_pbuf_addr-1:0] fill_lvl_q;
    reg [p_edma_rx_pbuf_addr-1:0] fill_lvl_128_q;

    assign dpram_push_q    = dpram_push & ({{28{1'b0}},queue_ptr_rx_rph} == s);
    assign dpram_pop_q     = dpram_pop  & ({{28{1'b0}},queue_ptr_rx_rph} == s);
    assign fill_lvl_q_incr = {17{dpram_push_q}} & (pkt_length_corrected + {14'd0,num_status_words});
    assign fill_lvl_q_decr = {17{dpram_pop_q}}  & {{(17-p_edma_rx_pbuf_addr){1'b0}},num_locns_to_free};
    assign max_val_pclk_q  = (max_val_pclk[(15+(16*s)):(16*s)]);

    always @ (posedge hclk or negedge n_hreset)
    begin
      if(~n_hreset)
        fill_lvl_q <= {p_edma_rx_pbuf_addr{1'b0}};
      else
        begin
          if (~enable_rx_hclk)
            fill_lvl_q <= {p_edma_rx_pbuf_addr{1'b0}};
          else
            fill_lvl_q <= fill_lvl_q + fill_lvl_q_incr[p_edma_rx_pbuf_addr-1:0] - fill_lvl_q_decr[p_edma_rx_pbuf_addr-1:0];
        end
    end

    // In this section we will just create a signal which counts the
    // 128 bytes chunks from fill_lvl_q, which counts words.
    // This is made accordingly to the IP configuration
    always @ *
    begin
      if(gem_rx_pbuf_data_w_is_128)
        // 128 bits: we need to divide by 8
        fill_lvl_128_q = {3'd0,fill_lvl_q[p_edma_rx_pbuf_addr-1:3]};
      else if(dma_bus_width[0])
        // 64 bits: we need to divide by 16
        fill_lvl_128_q = {4'd0,fill_lvl_q[p_edma_rx_pbuf_addr-1:4]};
      else
        // 32 bits: we need to divide by 32
        fill_lvl_128_q = {5'd0,fill_lvl_q[p_edma_rx_pbuf_addr-1:5]};
    end

    // We are dealing with a static watermark event
    // that will be high when the fill level is > the static level and low otherwise.
    // The static nature means it can be safely passed across a domain regardless of clock frequency,
    // hence there is no need for handshaking in this case.
    // This signal will be registered before passing it to the rx_clk domain
    // so there will be no logic before the Synchronizers. This will improve
    // the MTBF.
    always @ (posedge hclk or negedge n_hreset)
    begin
      if(~n_hreset)
        fill_lvl_breached[s] <= 1'b0;
      else
        fill_lvl_breached[s] <= ((fill_lvl_128_q > max_val_pclk_q[p_edma_rx_pbuf_addr-1:0]) && limit_num_bytes_allowed_ambaclk[s]);
    end

  end
  endgenerate

  // The following is just for lint
  genvar q_cnt_1;
  generate for (q_cnt_1=0; q_cnt_1<p_edma_queues; q_cnt_1 = q_cnt_1+1) begin : gen_pad_sigs
    assign nxt_descr_ptr_pad[q_cnt_1] = nxt_descr_ptr[q_cnt_1];
    assign str_descriptor_pad[q_cnt_1] = str_descriptor[q_cnt_1];
  end
  endgenerate
  genvar q_cnt;
  generate for (q_cnt=p_edma_queues; q_cnt<16; q_cnt = q_cnt+1)
  begin : set_unused_sigs
    assign rx_dma_base_addr_arr[q_cnt] = {p_awid_par{1'b0}};
    assign str_descriptor_pad[q_cnt] = {p_awid_par{1'b0}};
    assign rx_buffer_size_array[q_cnt]= 8'h00;
    assign force_discard_on_err_q_pad[q_cnt] = 1'b0;
    assign nxt_descr_ptr_pad[q_cnt] = {p_awid_par{1'b0}};
  end
  endgenerate

endmodule

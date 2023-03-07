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
//   Filename:           edma_pbuf_rx_wr.v
//   Module Name:        edma_pbuf_rx_wr
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
// Description    :
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module edma_pbuf_rx_wr (

  // Inputs

  // global clk & reset
  rx_clk,                         // mac rx clock
  n_rxreset,                      // mac rx clock domain reset

  // inputs coming configuration registers (assumed static)
  rx_pbuf_size,                   // Programmed size of available DPRAM
  dma_bus_width,                  // Programmed size of AHB bus
  enable_receive,
  rx_cutthru_threshold,
  rx_cutthru,
  rx_toe_enable,                  // Enable RX TCP Offload Engine.

  // inputs coming from gem_mac (gem_rx - fifo interface).
  rx_w_wr,                        // fifo write strobe
  rx_w_data,                      // fifo write data (validated by rx_w_wr)
  rx_w_data_par,
  rx_w_sop,                       // flag that rx_w_data has sop in first byte
  rx_w_eop,                       // flag that rx_w_data has eop
  rx_w_err,                       // flag that current packet is corrupted

  // inputs handshake control coming from the gem_rx
  dma_rx_end_tog,                 // toggled at the end of frame for DMA status
  rx_end_tog,                     // toggled at the end of frame for reg status

  // Output handshake controls for clock domain toggles (to gem_rx)
  dma_rx_status_tog,              // acknowledge for DMA status
  rx_status_wr_tog,               // acknowledge for register status

  // Interface to read side of packet buffer for identifying that
  // >= 1 pkt has been written into DPRAM
  end_of_packet_tog,
  part_of_packet_tog,
  part_of_packet_queue_ptr,
  part_of_packet_fld_offsets,
  num_pkts_xfer,
  pkt_captured,

  // Interface from read side of packet buffer for identifying that
  // the packet has been written to DPRAM
  // pkt_done_dplocns identifies how many locations can now be released
  pkt_done_tog,
  pkt_done_capt_tog,
  pkt_done_dplocns,

  // inputs coming from the gem_mac (gem_rx - status)
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
  rx_w_pld_offset,                // PLD offset in bytes
  rx_w_l4_offset,                 // L4 offset in bytes

  // Outputs going to gem_mac (gem_rx - fifo interface).
  rx_w_overflow,                  // RX FIFO overflowed

  dbuff_overflow,

  // DPRAM interface
  rxdpram_ena,
  rxdpram_wea,
  rxdpram_addra,
  rxdpram_dia,
  rxdpram_dia_par,

  // Priority Queue
  queue_ptr_rx,

  rsc_en,
  rsc_push,
  rsc_stop,
  tcp_seqnum,
  tcp_syn,
  tcp_payload_len,

  // enhanced TS enables
  rx_bd_extended_mode_en,         // enable extended BD mode, which is used to Descriptor TS insertion
  rx_bd_ts_mode,

  // Timestamp for current rx packet
  rx_timestamp,

  // RAS - Timestamp parity protection
  rx_timestamp_prty,

  // Write to the cutthru FIFO when the write pointer is getting
  // close to status words.
  cutthru_status_word,
  cutthru_status_word_par, // Only protecting status words
  cutthru_status_word_push,

  // PTP decoded signals
  sof_rx,
  event_frame_rx,
  general_frame_rx,
  dpram_fill_lvl,

  // ASF - signals going to gem_reg_top
  asf_dap_rx_wr_err,

  // Helper signal for lockup detection
  edma_overflow

);


//-------------------------------------------
// Parameter declaration
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

   // Store FSM parameters
   parameter SFSM_IDLE    = 3'b000;      // Store FSM idle
   parameter SFSM_DATA    = 3'b001;      // Store FSM write packet data
   parameter SFSM_EOF     = 3'b010;      // Store FSM write EOF
   parameter SFSM_STATUS1 = 3'b011;      // Store FSM write STATUS word 1
   parameter SFSM_STATUS2 = 3'b100;      // Store FSM write STATUS word 2
   parameter SFSM_STATUS3 = 3'b101;      // Store FSM write STATUS word 3
   parameter SFSM_STATUS4 = 3'b110;      // Store FSM write STATUS word 4

   parameter p_ct_fifo_sw = (p_edma_tsu == 1) ? 128 : 96;
   parameter p_ct_fifo_pw = p_ct_fifo_sw/8;

//-------------------------------------------
// Inputs declaration
//-------------------------------------------

  // global clk & reset
  input          rx_clk;              // mac rx clock
  input          n_rxreset;           // mac rx clock domain reset

  // inputs coming configuration registers (assumed static)
  input    [1:0] rx_pbuf_size;        // Programmed size of available DPRAM
  input    [1:0] dma_bus_width;       // Programmed size of AHB bus
  input          enable_receive;      // Receive is enabled
  input  [p_edma_rx_pbuf_addr-1:0] rx_cutthru_threshold; // Threshold value
  input          rx_cutthru;          // Enable for cut-thru operation
  input          rx_toe_enable;       // Enable RX TCP Offload Engine.

  // inputs coming from gem_mac (gem_rx - fifo interface).
  input          rx_w_wr;             // fifo write strobe
  input [p_emac_bus_width-1:0]
                 rx_w_data;           // fifo write data (validated by rx_w_wr)
  input [p_emac_bus_pwid-1:0]
                 rx_w_data_par;
  input          rx_w_sop;            // rx_w_data has sop in first byte
  input          rx_w_eop;            // rx_w_data has eop
  input          rx_w_err;            // current packet is corrupted

  // inputs handshake control coming from the gem_rx
  input          dma_rx_end_tog;      // toggled at the EOF for DMA status
  input          rx_end_tog;          // toggled at the EOF for reg status

  // Output handshake controls for clock domain toggles (to gem_rx)
  output         dma_rx_status_tog;   // acknowledge for DMA status
  output         rx_status_wr_tog;    // acknowledge for register status

  // Interface to read side of packet buffer
  output         end_of_packet_tog;   // Packet completely written into DPRAM
  output         part_of_packet_tog;  // part of packet written into DPRAM
  output  [3:0]  part_of_packet_queue_ptr; // Queue pointer for the part of packet
  output  [30:0] part_of_packet_fld_offsets; //PLD offset
  output  [3:0]  num_pkts_xfer;
  input          pkt_captured;
  input          pkt_done_tog;       // Packet has been read from memory
  input [p_edma_rx_pbuf_addr-1:0] pkt_done_dplocns; // Num of bytes to clear
  output         pkt_done_capt_tog;  // Handshake


  // inputs coming from the gem_mac (gem_rx - status).
  input          rx_w_crc_error;      // Frame had bad FCS
  input   [11:0] rx_w_pld_offset;     // PLD offset in bytes
  input   [11:0] rx_w_l4_offset;      // TCP/UDP offset in bytes
  input          rx_w_bad_frame;      // end of bad receive frame.
  input   [13:0] rx_w_frame_length;   // frame length field
  input          rx_w_ext_match1;     // external address 1 recognized
  input          rx_w_ext_match2;     // external address 2 recognized
  input          rx_w_ext_match3;     // external address 3 recognized
  input          rx_w_ext_match4;     // external address 4 recognized
  input          rx_w_add_match1;     // specific address 1 recognized
  input          rx_w_add_match2;     // specific address 2 recognized
  input          rx_w_add_match3;     // specific address 3 recognized
  input          rx_w_add_match4;     // specific address 4 recognized
  input          rx_w_add_match5;     // specific address register 5 matched
                                      // destination address.
  input          rx_w_add_match6;     // specific address register 6 matched
                                      // destination address.
  input          rx_w_add_match7;     // specific address register 7 matched
                                      // destination address.
  input          rx_w_add_match8;     // specific address register 8 matched
                                      // destination address.
  input          rx_w_type_match1;    // Type ID 1 recognized
  input          rx_w_type_match2;    // Type ID 2 recognized
  input          rx_w_type_match3;    // Type ID 3 recognized
  input          rx_w_type_match4;    // Type ID 4 recognized
  input          rx_w_broadcast_frame;// broadcast address recognized
  input          rx_w_mult_hash_match;// multi hash address recognition
  input          rx_w_uni_hash_match; // uni hash address recognition
  input          rx_w_vlan_tagged;    // vlan tag status field
  input          rx_w_prty_tagged;    // priority field
  input    [3:0] rx_w_tci;            // tci field
  input          rx_w_checksumi_ok;   // IP checksum checked and was OK.
  input          rx_w_checksumt_ok;   // TCP checksum checked and was OK.
  input          rx_w_checksumu_ok;   // UDP checksum checked and was OK.
  input          rx_w_snap_frame;     // SNAP encapsulated & valid VLAN

  // Outputs going to gem_mac (gem_rx - fifo interface).
  output         rx_w_overflow;       // RX FIFO overflowed
  output         dbuff_overflow;      // DBUFF overflow

  // DPRAM interface
  output reg     rxdpram_ena;                     // DPRAM Interface
  output reg     rxdpram_wea;                     // DPRAM Interface
  output reg [p_edma_rx_pbuf_addr-1:0]
                 rxdpram_addra; // DPRAM Interface
  output reg [p_edma_rx_pbuf_data-1:0]
                 rxdpram_dia;   // DPRAM Interface
  output     [p_edma_rx_pbuf_pwid-1:0]
                 rxdpram_dia_par;

  input  [3:0]   queue_ptr_rx;        // RX priority Queue number

  input  [14:0]  rsc_en;              // Receive Side Coalescing enable
  input          rsc_stop;            // Set if any of the SYN/FIN/RST/URG
                                      // flags are set in the TCP header
  input          rsc_push;            // Set if the PSH flag is set
  input  [31:0]  tcp_seqnum;          // Extracted TCP sequence number
  input          tcp_syn;             // Set if the SYN flag is set
  input  [15:0]  tcp_payload_len;     // Payload Length

  // Timestamp for current rx packet
  input  [41:0] rx_timestamp;

  // RAS - Timestamp parity protection
  input   [5:0] rx_timestamp_prty; // RAS - parity protection for the RX Timestamp[41:0] to DMA Descriptor

  // ASF - signals going to gem_reg_top
  output       asf_dap_rx_wr_err;   // Parity error

  input         rx_bd_extended_mode_en;  // enable extended BD mode, which is used to Descriptor TS insertion
  input  [1:0]  rx_bd_ts_mode;

   // PTP frame decoded signals
  input         sof_rx;             // asserted on SFD deasserted at EOF
  input         event_frame_rx;     // sync/delay_req/pdelay_req/pdelay_resp frames
  input         general_frame_rx;   // PTP frame which is not an event frame

  output [p_edma_rx_pbuf_addr-1:0] dpram_fill_lvl; // DPRAM Fill level

  output [p_edma_rx_pbuf_addr+p_ct_fifo_sw-1:0]
                               cutthru_status_word;
  output [p_ct_fifo_pw-1:0]    cutthru_status_word_par;
  output reg cutthru_status_word_push;

  // Helper signal for lockup detection to indicate packet will not be complete
  output edma_overflow;

  // Store FSM signals
  reg    [2:0]   store_fsm;         // Current store FSM state
  reg    [2:0]   last_store_fsm;    // Last store FSM state
  reg    [2:0]   nxt_store_fsm;     // Next store FSM state
  reg            dma_rx_status_tog;
  reg            rx_status_wr_tog;


//-------------------------------------------
// Internal signals declaration
//-------------------------------------------

  // Write DPSRAM signals
  reg                    nxt_rxdpram_wea;   // Next value of rxdpram_wea
  reg                    nxt_rxdpram_ena;   // Next value of rxdpram_ena
  reg  [p_edma_rx_pbuf_addr:0] nxt_rxdpram_addra; // Next value of rxdpram_addra
  reg  [127:0]           nxt_rxdpram_dia;   // Next value of rxdpram_dia
  reg  [15:0]            nxt_rxdpram_dia_par;

  // Write data pointer signals
  reg  [p_edma_rx_pbuf_addr-1:0] saved_start;       // Saved write pointer to SOP
  reg  [p_edma_rx_pbuf_addr:0]   nxt_saved_start;   // Next value of saved_start
  reg  [p_edma_rx_pbuf_addr-1:0] saved_end;         // Saved write pointer to EOP
  reg  [p_edma_rx_pbuf_addr:0]   nxt_saved_end;     // Next value of saved_end

  wire                   dbuff_full;        // Data area is full
  wire                   dbuff_overflow;    // Data area has overflowed
  reg                    dbuff_overflow_hold;    // Data area has overflowed


  // handshake controls (GEM_RX interface)
  reg           end_of_packet_tog;
  reg           part_of_packet_tog;
  reg    [3:0]  part_of_packet_queue_ptr;
  reg    [30:0] part_of_packet_fld_offsets;
  wire          end_of_pkt;         // Detect edges on tog => EOP
  wire          bad_end_of_pkt;     // end_of_pkt and bad frame
  reg           end_of_pkt_seen;    // end_of_pkt latched

  wire          pkt_read_done;          // Edge detected do_writeback_tog
  reg   [p_edma_rx_pbuf_addr-1:0] dpram_fill_lvl; // DPRAM Fill level
  reg   [11:0] pkt_length_wr;         // Num DPRAM locns in pkt
  reg   [p_edma_rx_pbuf_addr-1:0] part_length_wr;// Num DPRAM locns in part
  reg           new_pkt_capt_req;     // More packets are ready to be
                                      // read by RD side of PBUF, but
                                      // waiting for current handshake to
                                      // be captured
  reg           new_part_pkt_capt_req;//
  reg   [3:0]   num_pkts_xfer;        // Number of packets to be declared
                                      // as ready to be read by RD side
  reg   [3:0]   num_pkts_xfer_local;  // Count num of packets that are ready
                                      // to be read by the RD side of PBUF
                                      // but which cannot be taken right now
  reg           waiting_for_pkt_capt; // RD side is busy processing the
                                      // last handshake
  reg           pkt_done_capt_tog;    // Captured num DPRAM locns to free up
  reg           pkt_flush;
  reg           nxt_pkt_flush;
  wire  [31:0]  status_word_1;
  wire  [31:0]  status_word_2;
  wire  [31:0]  status_word_3;
  wire  [31:0]  status_word_4;
  wire   [3:0]  status_word_1_par;
  wire   [3:0]  status_word_2_par;
  wire   [3:0]  status_word_3_par;
  wire   [3:0]  status_word_4_par;
  reg           pkt_rx_xfer_req;   // Signal to Rd side of PKT buffer that
  reg  [p_edma_rx_pbuf_addr-1:0]  nxt_rxdpram_add_norm;
  wire [p_edma_rx_pbuf_addr-1:0]  rxdpram_addra_p1;  // rxdpram_addra + 1 truncated
  wire [p_edma_rx_pbuf_addr-1:0]  rxdpram_addra_p2;  // rxdpram_addra + 2 truncated
  wire [p_edma_rx_pbuf_addr-1:0]  rxdpram_addra_p3;  // rxdpram_addra + 3 truncated
  wire [p_edma_rx_pbuf_addr-1:0]  rxdpram_addra_p4;  // rxdpram_addra + 4 truncated
  wire [p_edma_rx_pbuf_addr-1:0]  rxdpram_addra_p5;  // rxdpram_addra + 5 truncated
  wire   [p_edma_rx_pbuf_addr:0]  f_rxdpram_addra_p1;// rxdpram_addra + 1
  wire   [p_edma_rx_pbuf_addr:0]  f_rxdpram_addra_p2;// rxdpram_addra + 2
  wire   [p_edma_rx_pbuf_addr:0]  f_rxdpram_addra_p3;// rxdpram_addra + 3
  wire   [p_edma_rx_pbuf_addr:0]  f_rxdpram_addra_p4;// rxdpram_addra + 4
  wire   [p_edma_rx_pbuf_addr:0]  f_rxdpram_addra_p5;// rxdpram_addra + 4

                                      // pkt data can be read
  reg           part_pkt_xfer_req;
  wire          enable_receive_sync;
  wire          dpram_write;
  wire          status_write_complete;
  wire          pkt_capt;
  wire [127:0]  rx_w_data_pad;
  wire [15:0]   rx_w_data_par_pad;

  wire           negedge_sof_rx;
  wire           rx_w_wr_upsized;
  wire           rx_w_sop_upsized;
  reg            sof_rx_d1;
  reg            event_frame_rx_d1;
  reg            general_frame_rx_d1;
  wire  [41:0]   timestamp_cpt;
  wire  [5:0]    timestamp_cpt_par;
  reg            ts_to_be_written;
  reg            frame_was_errored;

  wire           rsc_stop_seqnum;
  wire           gem_rx_pbuf_data_w_is_128;

  wire           dap_ts_cpt_err;  // Parity error of captured timestamp

  wire [p_edma_rx_pbuf_addr-1:0] pkt_done_dplocns_gated;

  assign gem_rx_pbuf_data_w_is_128 = p_edma_rx_pbuf_data == 32'd128;

  assign negedge_sof_rx = sof_rx_d1 & ~sof_rx;

  // Register rx timestamp
  // indicate ts is to be written to BD based on decoded frame type
  // and rx_bd_ts_mode
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      begin
      ts_to_be_written    <= 1'b0;
      sof_rx_d1           <= 1'b0;
      event_frame_rx_d1   <= 1'b0;
      general_frame_rx_d1 <= 1'b0;
      end
    else
    begin
      sof_rx_d1           <=  sof_rx;
      event_frame_rx_d1   <=  event_frame_rx;
      general_frame_rx_d1 <=  general_frame_rx;

      if (negedge_sof_rx == 1'b1)
      begin
         casex ({rx_bd_ts_mode, general_frame_rx_d1, event_frame_rx_d1})
           4'b00xx:  // no frames
                    ts_to_be_written <= 1'b0;
           4'b0101:  // event frames only
                    ts_to_be_written <= 1'b1;
           4'b1010:  // general frames
                    ts_to_be_written <= 1'b1;
           4'b1001:  // event frames
                    ts_to_be_written <= 1'b1;
           4'b11xx:  // all frames
                    ts_to_be_written <= 1'b1;
           default: ts_to_be_written <= 1'b0;
         endcase

      end
    end
  end

  // The timestamp itself only exists if p_edma_tsu is set to 1
  generate if (p_edma_tsu == 1) begin : gen_ts_capt
    reg [41:0]  timestamp_cpt_r;
    always@(posedge rx_clk or negedge n_rxreset)
    begin
      if (~n_rxreset)
        timestamp_cpt_r <= 42'd0;
      else if (negedge_sof_rx == 1'b1)
        timestamp_cpt_r <= rx_timestamp;
    end
    assign timestamp_cpt      = timestamp_cpt_r;
    if (p_edma_asf_dap_prot == 1) begin : gen_store_ts_par
      reg   [5:0] timestamp_cpt_par_r;
      always@(posedge rx_clk or negedge n_rxreset)
      begin
        if (~n_rxreset)
          timestamp_cpt_par_r <= 6'h00;
        else
          if (negedge_sof_rx)
            timestamp_cpt_par_r <= rx_timestamp_prty;
      end
      assign timestamp_cpt_par  = timestamp_cpt_par_r;
    end else begin : gen_no_store_ts_par
      assign timestamp_cpt_par  = 6'h00;
    end
  end else begin : gen_no_ts_capt
    assign timestamp_cpt      = {42{1'b0}};
    assign timestamp_cpt_par  = 6'h00;
  end
  endgenerate

  // Synchronise enable_receive signal
  // This is generated in the PCLK domain within the registers block
  // and can change dynamically.
  // Hence full metastability protection is applied.
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_enable_receive (
    .clk(rx_clk),
    .reset_n(n_rxreset),
    .din(enable_receive),
    .dout(enable_receive_sync));



//------------------------------------------------------------------------------
// Handshake control (GEM_RX interface)
//------------------------------------------------------------------------------

   assign end_of_pkt = rx_w_eop & rx_w_wr;

   reg [2:0] frame_count;
   always @(posedge rx_clk or negedge n_rxreset)
     begin
       if(~n_rxreset)
         begin
           frame_count   <= 3'h0;
         end
       else
         begin
           if (rx_w_sop)
             begin
               frame_count   <= 3'h6;
             end
           else if (frame_count > 3'h0)
             begin
               frame_count   <= frame_count - 3'b001;
             end
         end
     end

   // detect bad end of packet
  // Use bad_end_of_pkt to indicate that there will only be status written
  // into the DPRAM
   assign bad_end_of_pkt = end_of_pkt & (rx_w_bad_frame | frame_count != 3'h0 | rx_w_sop);

  // Latch end_of_pkt until used in store FSM
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      end_of_pkt_seen <= 1'b0;
    else if (~enable_receive_sync)
      end_of_pkt_seen <= 1'b0;
    else if (end_of_pkt)
      end_of_pkt_seen <= 1'b1;
    else if (store_fsm == SFSM_EOF | store_fsm == SFSM_STATUS1)
      end_of_pkt_seen <= 1'b0;
    else
      end_of_pkt_seen <= end_of_pkt_seen;
  end


  // Synchronous store state machine assignments
  // Flush whole packet buffer when flush is active (rx disabled = soft reset)
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
    begin
      store_fsm     <= SFSM_IDLE;
      last_store_fsm<= SFSM_IDLE;
      rxdpram_wea   <= 1'b0;
      rxdpram_ena   <= 1'b0;
      rxdpram_addra <= {p_edma_rx_pbuf_addr{1'b0}};
      rxdpram_dia   <= {p_edma_rx_pbuf_data{1'b0}};
      saved_start   <= {p_edma_rx_pbuf_addr{1'b0}};
      saved_end     <= {p_edma_rx_pbuf_addr{1'b1}};
    end
    else if (~enable_receive_sync)
    begin
      store_fsm     <= SFSM_IDLE;
      last_store_fsm<= SFSM_IDLE;
      rxdpram_wea   <= 1'b0;
      rxdpram_ena   <= 1'b0;
      rxdpram_addra <= {p_edma_rx_pbuf_addr{1'b0}};
      rxdpram_dia   <= {p_edma_rx_pbuf_data{1'b0}};
      saved_start   <= {p_edma_rx_pbuf_addr{1'b0}};
      saved_end     <= {p_edma_rx_pbuf_addr{1'b1}};
    end
    else
    begin
      store_fsm     <= nxt_store_fsm;
      last_store_fsm<= store_fsm;
      rxdpram_wea   <= nxt_rxdpram_wea;
      rxdpram_ena   <= nxt_rxdpram_ena;
      rxdpram_addra <= nxt_rxdpram_addra[p_edma_rx_pbuf_addr-1:0];
      rxdpram_dia   <= nxt_rxdpram_dia[p_edma_rx_pbuf_data-1:0];
      saved_start   <= nxt_saved_start[p_edma_rx_pbuf_addr-1:0];
      saved_end     <= nxt_saved_end[p_edma_rx_pbuf_addr-1:0];
    end
  end

  generate if (p_edma_asf_dap_prot == 0) begin : gen_no_rxdpram_dia_par
    assign rxdpram_dia_par  = {p_edma_rx_pbuf_pwid{1'b0}};
  end else begin : gen_rxdpram_dia_par
    reg [p_edma_rx_pbuf_pwid-1:0] rxdpram_dia_par_r;
    always @(posedge rx_clk or negedge n_rxreset)
    begin
      if (~n_rxreset)
        rxdpram_dia_par_r <= {p_edma_rx_pbuf_pwid{1'b0}};
      else if (~enable_receive_sync)
        rxdpram_dia_par_r <= {p_edma_rx_pbuf_pwid{1'b0}};
      else
        rxdpram_dia_par_r <= nxt_rxdpram_dia_par[p_edma_rx_pbuf_pwid-1:0];
    end
    assign rxdpram_dia_par  = rxdpram_dia_par_r;
  end
  endgenerate

  assign f_rxdpram_addra_p1 = rxdpram_addra + {{(p_edma_rx_pbuf_addr-3){1'b0}},3'b001};
  assign f_rxdpram_addra_p2 = rxdpram_addra + {{(p_edma_rx_pbuf_addr-3){1'b0}},3'b010};
  assign f_rxdpram_addra_p3 = rxdpram_addra + {{(p_edma_rx_pbuf_addr-3){1'b0}},3'b011};
  assign f_rxdpram_addra_p4 = rxdpram_addra + {{(p_edma_rx_pbuf_addr-3){1'b0}},3'b100};
  assign f_rxdpram_addra_p5 = rxdpram_addra + {{(p_edma_rx_pbuf_addr-3){1'b0}},3'b101};

  assign rxdpram_addra_p1   = f_rxdpram_addra_p1[p_edma_rx_pbuf_addr-1:0];
  assign rxdpram_addra_p2   = f_rxdpram_addra_p2[p_edma_rx_pbuf_addr-1:0];
  assign rxdpram_addra_p3   = f_rxdpram_addra_p3[p_edma_rx_pbuf_addr-1:0];
  assign rxdpram_addra_p4   = f_rxdpram_addra_p4[p_edma_rx_pbuf_addr-1:0];
  assign rxdpram_addra_p5   = f_rxdpram_addra_p5[p_edma_rx_pbuf_addr-1:0];

  // Upsize the MAC data to the DPRAM width if the DPRAM size is 128 bits
  generate if (p_emac_bus_width < 32'd128) begin : gen_rx_w_data_pad
    assign rx_w_data_pad      = {{(128-p_emac_bus_width){1'b0}},rx_w_data};
    assign rx_w_data_par_pad  = {{(16-p_emac_bus_pwid){1'b0}},rx_w_data_par};
  end else begin : gen_no_rx_w_data_pad
    assign rx_w_data_pad      = rx_w_data;
    assign rx_w_data_par_pad  = rx_w_data_par;
  end
  endgenerate


  // If the dma bus width is configured to be larger than the theoretical maximum
  // mac bus width then we need to limit the mac bus width to be the correct
  // size
  wire [1:0] emac_bus_width_max = p_emac_bus_width == 32'd32 ? 2'b00 :
                                  p_emac_bus_width == 32'd64 ? 2'b01 :
                                                               2'b10 ;
  wire [1:0] emac_bus_width = (dma_bus_width > emac_bus_width_max) ? emac_bus_width_max : dma_bus_width;

  wire [p_edma_rx_pbuf_prty+p_edma_rx_pbuf_data-1:0]
                 rx_w_data_upsized_tmp;
  wire  [p_edma_rx_pbuf_data-1:0] rx_w_data_upsized;
  wire  [p_edma_rx_pbuf_pwid-1:0] rx_w_data_upsized_par;

  edma_pbuf_dpram_width_upsize #(

      .ODATA_W(p_edma_rx_pbuf_data),
      .ODATA_W_PAR(p_edma_rx_pbuf_prty) // TOIMPRV Parameterise

   ) i_edma_pbuf_dpram_width_upsize (

      .clk(rx_clk),
      .reset_n(n_rxreset),

      .iwr(rx_w_wr),
      .idata({rx_w_data_par_pad,rx_w_data_pad}),
      .iwidth(emac_bus_width),
      .imod(4'd0),
      .ieop(rx_w_eop | rx_w_err | dbuff_full),
      .isop(rx_w_sop),
      .iflush(~enable_receive_sync),

      .owr(rx_w_wr_upsized),
      .osop(rx_w_sop_upsized),
      .odata(rx_w_data_upsized_tmp),
      .omod());

  generate if (p_edma_asf_dap_prot == 1) begin : gen_upsz_par
    assign {rx_w_data_upsized_par,
            rx_w_data_upsized}    = rx_w_data_upsized_tmp;
  end else begin : gen_no_upsz_par
    assign rx_w_data_upsized      = rx_w_data_upsized_tmp;
    assign rx_w_data_upsized_par  = {p_edma_rx_pbuf_pwid{1'b0}};
  end
  endgenerate

  // Calcualte the next address under normal circumstances
  always @(*)
  begin
    if (rxdpram_addra_p1 == saved_start)
    begin
      if (gem_rx_pbuf_data_w_is_128)
      begin
        if (rx_w_wr_upsized)
          nxt_rxdpram_add_norm = rxdpram_addra_p2;
        else
          nxt_rxdpram_add_norm = rxdpram_addra;
      end
      else if (dma_bus_width == 2'b01)
        nxt_rxdpram_add_norm = rxdpram_addra_p3;
      else if (~rx_bd_extended_mode_en)
        nxt_rxdpram_add_norm = rxdpram_addra_p4;
      else
        nxt_rxdpram_add_norm = rxdpram_addra_p5;
    end
    else if (rx_w_wr_upsized & ~rx_w_sop_upsized & ~(rx_w_err | dbuff_full))
      nxt_rxdpram_add_norm = rxdpram_addra_p1;
    else
      nxt_rxdpram_add_norm = rxdpram_addra;
  end

  ////////////////////////////
  // Pad signals for easier use
  wire  [127:0]           rxdpram_dia_pad;
  wire  [15:0]            rxdpram_dia_par_pad;
  wire  [127:0]           rx_w_data_upsized_pad;
  wire  [15:0]            rx_w_data_upsized_par_pad;
  generate if (p_edma_rx_pbuf_data < 32'd128) begin : gen_pbuf_data_pad
    assign rxdpram_dia_pad            = {{(128-p_edma_rx_pbuf_data){1'b0}},rxdpram_dia};
    assign rxdpram_dia_par_pad        = {{(16-p_edma_rx_pbuf_pwid){1'b0}},rxdpram_dia_par};
    assign rx_w_data_upsized_pad      = {{(128-p_edma_rx_pbuf_data){1'b0}},rx_w_data_upsized};
    assign rx_w_data_upsized_par_pad  = {{(16-p_edma_rx_pbuf_pwid){1'b0}},rx_w_data_upsized_par};
  end else begin : gen_no_pbuf_data_pad
    assign rxdpram_dia_pad            = rxdpram_dia;
    assign rxdpram_dia_par_pad        = rxdpram_dia_par;
    assign rx_w_data_upsized_pad      = rx_w_data_upsized;
    assign rx_w_data_upsized_par_pad  = rx_w_data_upsized_par;
  end
  endgenerate
  ///////////////////////////

  always @( * )
  begin
      // defaults for fsm decodes
      nxt_rxdpram_wea     = 1'b0;
      nxt_rxdpram_ena     = 1'b0;
      nxt_rxdpram_addra   = {1'b0,rxdpram_addra};
      nxt_rxdpram_dia     = rxdpram_dia_pad;
      nxt_rxdpram_dia_par = rxdpram_dia_par_pad;
      nxt_saved_start     = {1'b0,saved_start};
      nxt_saved_end       = {1'b0,saved_end};
      nxt_pkt_flush       = 1'b0;
      cutthru_status_word_push = 1'b0;

    case (store_fsm)
      SFSM_IDLE :
        begin
          // Point saved_start to location of FIRST STATUS word
          nxt_saved_start   = saved_end+{{p_edma_rx_pbuf_addr-1{1'b0}},1'b1};
          // Point address to location of FIRST DATA word
          nxt_rxdpram_addra = gem_rx_pbuf_data_w_is_128 ? saved_end+{{p_edma_rx_pbuf_addr-2{1'b0}},2'b10} :
                              dma_bus_width[0]          ? saved_end+{{p_edma_rx_pbuf_addr-2{1'b0}},2'b11} :
                              ~rx_bd_extended_mode_en   ? saved_end+{{p_edma_rx_pbuf_addr-3{1'b0}},3'b100} :
                                                          saved_end+{{p_edma_rx_pbuf_addr-3{1'b0}},3'b101};
          // If the dbuff is full and we are in the IDLE state, we simply cant
          // store anything else.  This means the packets will be silently
          // dropped
          if (dbuff_full)
          begin
            nxt_store_fsm     = SFSM_IDLE;
            nxt_saved_end     = {1'b0,saved_end};
          end

          // Detect new SOP write with no error
          // Note if both SOP and EOP we can drop packet as
          // frame will be too small.
          else if (rx_w_wr & rx_w_sop & ~rx_w_eop & ~rx_w_err & ~bad_end_of_pkt)
          begin
            nxt_store_fsm       = SFSM_DATA;
            nxt_rxdpram_wea     = rx_w_wr_upsized;
            nxt_rxdpram_ena     = rx_w_wr_upsized;
            nxt_rxdpram_dia     = rx_w_data_upsized_pad;
            nxt_rxdpram_dia_par = rx_w_data_upsized_par_pad;
          end

          else
            nxt_store_fsm     = SFSM_IDLE;
        end

      SFSM_DATA  :
      begin
        // If error signalled then drop packet
        // Drop packet by re-loading saved pointers.
        if (rx_w_wr & (rx_w_err | dbuff_full))
        begin
          nxt_rxdpram_wea     = 1'b0;
          nxt_rxdpram_ena     = 1'b0;
          nxt_rxdpram_dia     = {128{1'b0}};
          nxt_rxdpram_dia_par = {16{1'b0}};

          // If We have already received the end_of_pkt then we don't need to
          // wait for it and we can go staight to writing the status.
          if (end_of_pkt) begin
            nxt_store_fsm     = SFSM_STATUS1;
            if (~rx_cutthru)
              nxt_saved_end     = gem_rx_pbuf_data_w_is_128 ? {1'b0,saved_start}:
                                  dma_bus_width[0]          ? saved_start + {{p_edma_rx_pbuf_addr-1{1'd0}},1'd1}:
                                  ~rx_bd_extended_mode_en   ? saved_start + {{p_edma_rx_pbuf_addr-2{1'd0}},2'd2}:
                                                              saved_start + {{p_edma_rx_pbuf_addr-2{1'd0}},2'd3};
            else
              nxt_saved_end = {1'b0,nxt_rxdpram_add_norm};
          end
          else
            nxt_store_fsm     = SFSM_EOF;

          // Point address to end of packet minus 1
          // In non-cutthru modes, we want to drop the packet silently here
          // In these cases, there is only status to write in,
          // so end of packet -1 is just the start address + num status words
          // minus 1
          if (~rx_cutthru)
          begin
            nxt_rxdpram_addra = gem_rx_pbuf_data_w_is_128 ? {1'b0,saved_start}:
                                dma_bus_width[0]          ? saved_start + {{p_edma_rx_pbuf_addr-1{1'd0}},1'd1}:
                                ~rx_bd_extended_mode_en   ? saved_start + {{p_edma_rx_pbuf_addr-2{1'd0}},2'd2}:
                                                            saved_start + {{p_edma_rx_pbuf_addr-2{1'd0}},2'd3};
            nxt_pkt_flush     = 1'b1;
          end
        end
        // Else if good EOP signalled write final data and then
        // go onto updating LUT with status
        else if (rx_w_wr & rx_w_eop)
        begin
          nxt_store_fsm       = SFSM_STATUS1;
          nxt_saved_end       = {1'b0,nxt_rxdpram_add_norm};
          nxt_rxdpram_wea     = 1'b1;
          nxt_rxdpram_ena     = 1'b1;
          nxt_rxdpram_addra   = {1'b0,nxt_rxdpram_add_norm};
          nxt_rxdpram_dia     = rx_w_data_upsized_pad;
          nxt_rxdpram_dia_par = rx_w_data_upsized_par_pad;
        end
        // Else if good write then update data area of RAM
        else if (rx_w_wr)
        begin
          nxt_store_fsm       = SFSM_DATA;
          nxt_rxdpram_wea     = rx_w_wr_upsized;
          nxt_rxdpram_ena     = rx_w_wr_upsized;
          nxt_rxdpram_addra   = {1'b0,nxt_rxdpram_add_norm};
          nxt_rxdpram_dia     = rx_w_data_upsized_pad;
          nxt_rxdpram_dia_par = rx_w_data_upsized_par_pad;
        end
        // Else stay where we are and do nothing
        else
          nxt_store_fsm     = SFSM_DATA;
      end


      SFSM_EOF   :
      begin
        // Wait here until we have received all statistics
        // information from the GEM_RX.
        // Must always store status for statistics update so
        // goto STATUS writeback next.
        nxt_saved_end     = {1'b0,rxdpram_addra};
        if (end_of_pkt)
          nxt_store_fsm     = SFSM_STATUS1;
        else
          nxt_store_fsm     = SFSM_EOF;
      end

      SFSM_STATUS1  :
      begin
        // Update LUT word 1 and move onto LUT2
        nxt_rxdpram_wea   = 1'b1;
        nxt_rxdpram_ena   = 1'b1;
        nxt_rxdpram_addra = {1'b0,saved_start};

        if (gem_rx_pbuf_data_w_is_128) begin
          // If we are in a 10G mode or above then it's possible to
          // get an eop direclty following an sop. In this case, we
          // will jump straight to the data state, rather than going
          // to idle.
          if (rx_w_wr & rx_w_sop & ~rx_w_eop & ~rx_w_err & ~dbuff_full & ~dbuff_overflow_hold) begin
            // Point saved_start to location of FIRST STATUS word
            nxt_store_fsm       = SFSM_DATA;
            nxt_rxdpram_wea     = rx_w_wr_upsized;
            nxt_rxdpram_ena     = rx_w_wr_upsized;
            nxt_rxdpram_dia     = rx_w_data_upsized_pad;
            nxt_rxdpram_dia_par = rx_w_data_upsized_par_pad;
            nxt_saved_start     = saved_end+{{p_edma_rx_pbuf_addr-1{1'b0}},1'b1};
          end
          // No new packet is coming in so move back to idle.
          else begin
            nxt_store_fsm       = SFSM_IDLE;
            nxt_rxdpram_dia     = {status_word_4,status_word_3,status_word_2,status_word_1};
            nxt_rxdpram_dia_par = {status_word_4_par,status_word_3_par,status_word_2_par,status_word_1_par};
          end
          // If we are in cut-thru mode and the current frame size is greater
          // than half of the buffer size then push the status words to the
          // cutthru status_word FIFO.
          if ({5'd0, pkt_length_wr} > {{17-p_edma_rx_pbuf_addr{1'b0}}, {p_edma_rx_pbuf_addr{1'b1}}>>1})
             cutthru_status_word_push = rx_cutthru & (p_edma_pbuf_cutthru == 1);
        end
        else if (dma_bus_width[0]) begin
          nxt_store_fsm       = SFSM_STATUS2;
          nxt_rxdpram_dia     = {{64{1'b0}},status_word_2,status_word_1};
          nxt_rxdpram_dia_par = {{8{1'b0}},status_word_2_par,status_word_1_par};
        end
        else begin
          nxt_store_fsm     = SFSM_STATUS2;
          nxt_rxdpram_dia     = {{64{1'b0}},status_word_4,status_word_1};
          nxt_rxdpram_dia_par = {{8{1'b0}},status_word_4_par,status_word_1_par};
        end
      end

      SFSM_STATUS2  :
      begin
        // Update LUT word 2 and move onto LUT3
        nxt_rxdpram_wea   = 1'b1;
        nxt_rxdpram_ena   = 1'b1;
        nxt_rxdpram_addra = {1'b0,rxdpram_addra_p1};
        if (dma_bus_width[0])
        begin
          nxt_store_fsm       = SFSM_IDLE;
          nxt_rxdpram_dia     = {{64{1'b0}},status_word_4,status_word_3};
          nxt_rxdpram_dia_par = {{8{1'b0}},status_word_4_par,status_word_3_par};
          // If we are in cut-thru mode and the current frame size is greater
          // than half of the buffer size then push the status words to the
          // cutthru status_word FIFO.
          if ({5'd0, pkt_length_wr} > {{17-p_edma_rx_pbuf_addr{1'b0}}, {p_edma_rx_pbuf_addr{1'b1}}>>1})
             cutthru_status_word_push = rx_cutthru & (p_edma_pbuf_cutthru == 1);
        end
        else
        begin
          nxt_store_fsm       = SFSM_STATUS3;
          nxt_rxdpram_dia     = {{96{1'b0}},status_word_2};
          nxt_rxdpram_dia_par = {{12{1'b0}},status_word_2_par};
        end
      end

      SFSM_STATUS3 : // only gets here in 32b data bus width  :
      begin
        // Update LUT word 3 and move onto LUT3
        if (~rx_bd_extended_mode_en) begin
          nxt_store_fsm   = SFSM_IDLE;
          // If we are in cut-thru mode and the current frame size is greater
          // than half of the buffer size then push the status words to the
          // cutthru status_word FIFO.
          if ({5'd0, pkt_length_wr} > {{17-p_edma_rx_pbuf_addr{1'b0}}, {p_edma_rx_pbuf_addr{1'b1}}>>1})
             cutthru_status_word_push = rx_cutthru & (p_edma_pbuf_cutthru == 1);
        end
        else
          nxt_store_fsm   = SFSM_STATUS4;
        nxt_rxdpram_wea   = 1'b1;
        nxt_rxdpram_ena   = 1'b1;
        nxt_rxdpram_addra = {1'b0,rxdpram_addra_p1};
          nxt_rxdpram_dia     = {{96{1'b0}},status_word_3};
          nxt_rxdpram_dia_par = {{12{1'b0}},status_word_3_par};
      end

      SFSM_STATUS4  :
      begin
        // Update LUT word 4 & goto IDLE to wait new packet
        nxt_store_fsm       = SFSM_IDLE;
        nxt_rxdpram_wea     = 1'b1;
        nxt_rxdpram_ena     = 1'b1;
        nxt_rxdpram_addra   = {1'b0,rxdpram_addra_p1};
        nxt_rxdpram_dia     = {{96{1'b0}},status_word_4};
        nxt_rxdpram_dia_par = {{12{1'b0}},status_word_4_par};
        // If we are in cut-thru mode and the current frame size is greater
        // than half of the buffer size then push the status words to the
        // cutthru status_word FIFO.
        if ({5'd0, pkt_length_wr} > {{17-p_edma_rx_pbuf_addr{1'b0}}, {p_edma_rx_pbuf_addr{1'b1}}>>1})
           cutthru_status_word_push = rx_cutthru & (p_edma_pbuf_cutthru == 1);
      end


      default    :
      begin
         nxt_store_fsm     = SFSM_IDLE;
      end
    endcase
  end

  // Helper variable to determine when the status write is complete
  assign status_write_complete = (((store_fsm == SFSM_STATUS3) & ~rx_bd_extended_mode_en) | (store_fsm == SFSM_STATUS4)) |
                                 (store_fsm == SFSM_STATUS2 & dma_bus_width[0]) |
                                 (store_fsm == SFSM_STATUS1 & gem_rx_pbuf_data_w_is_128);


  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      frame_was_errored <= 1'b0;
    else if (rx_w_wr & rx_w_eop)
      frame_was_errored <= rx_w_err;
  end


  // If there is an error while we are writing to the DPRAM, we need
  // to flush the DPRAM, and update the fill level appropriately.
  // To do this, we need to keep track of the number of locns used
  // per packet
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      pkt_length_wr <=  12'h000;

    // Reset pointer to 1 if flush or end of packet
    else if (~enable_receive_sync)
      pkt_length_wr <=  12'h000;

    else if (nxt_store_fsm == SFSM_DATA & store_fsm != SFSM_DATA) begin
      if (nxt_rxdpram_wea & nxt_rxdpram_ena)
        pkt_length_wr <=  12'h001;
      else
        pkt_length_wr <=  12'h000;
    end

    else if (pkt_flush)
      pkt_length_wr <=  12'h000;

    else if (status_write_complete)
     pkt_length_wr <=  12'h000;

    // Increment pkt length
    else if (nxt_rxdpram_wea & nxt_rxdpram_ena & (store_fsm == SFSM_DATA || nxt_store_fsm == SFSM_DATA))
      pkt_length_wr <= pkt_length_wr + 12'h001;
  end

  wire [p_edma_rx_pbuf_addr:0] part_length_wr_p1;
  assign part_length_wr_p1 = part_length_wr + {{p_edma_rx_pbuf_addr-1{1'b0}},1'b1};
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      part_length_wr <=  {p_edma_rx_pbuf_addr{1'b0}};

    // Reset pointer to 1 if flush or end of packet
    else if (~enable_receive_sync)
      part_length_wr <=  {p_edma_rx_pbuf_addr{1'b0}};

    else if (nxt_store_fsm == SFSM_DATA & store_fsm != SFSM_DATA)
      part_length_wr <=  {p_edma_rx_pbuf_addr{1'b0}};

    // Increment pkt length
    else if (rxdpram_wea & rxdpram_ena & (store_fsm == SFSM_DATA |
                                          end_of_pkt_seen | store_fsm == SFSM_EOF))
    begin
      if (rx_cutthru & part_length_wr == rx_cutthru_threshold)
        part_length_wr <= {p_edma_rx_pbuf_addr{1'b0}};
      else
        part_length_wr <= part_length_wr_p1[p_edma_rx_pbuf_addr-1:0];
    end
  end

wire     [3:0] rx_add_match_code;   // encoded specific address number
wire           rx_w_ext_match_code; // encoded ext match


genvar spec_add_filter_var;
generate if (p_num_spec_add_filters > 32'd0) begin : gen_spec_add_filters
  if (p_num_spec_add_filters > 32'd4)
  begin : gen_more_than_4
    // rx_add_match_code  - Encode match signals for writeback.
    assign rx_add_match_code   = {(rx_w_add_match8 | rx_w_add_match7 |
                                   rx_w_add_match6 | rx_w_add_match5 |
                                   rx_w_add_match4 | rx_w_add_match3 |
                                   rx_w_add_match2 | rx_w_add_match1),
                                   rx_w_add_match8 ? 3'b111 :
                                   rx_w_add_match7 ? 3'b110 :
                                   rx_w_add_match6 ? 3'b101 :
                                   rx_w_add_match5 ? 3'b100 :
                                   rx_w_add_match4 ? 3'b011 :
                                   rx_w_add_match3 ? 3'b010 :
                                   rx_w_add_match2 ? 3'b001 :
                                                      3'b000};
  end else begin : gen_4
    // rx_add_match_code  - Encode match signals for writeback.
    assign rx_add_match_code= { rx_w_ext_match_code,
                               (rx_w_add_match4 |
                                rx_w_add_match3 |
                                rx_w_add_match2 |
                                rx_w_add_match1),
                                rx_w_add_match4 ? 2'b11 :
                                rx_w_add_match3 ? 2'b10 :
                                rx_w_add_match2 ? 2'b01 :
                                                  2'b00};
  end
end else begin : gen_no_spec_add_filters
    assign rx_add_match_code= {rx_w_ext_match_code,3'b000};
end
endgenerate


  assign rx_w_ext_match_code   = (rx_w_ext_match1 | rx_w_ext_match2 |
                                  rx_w_ext_match3 | rx_w_ext_match4);

  reg      [2:0] rx_type_match_code;  // encoded type id number
  // rx_type_match_code - If TOE is disabled then rx_type_match_code[1:0]
  //                      matches bits[32:22] of descriptor. If TOE is
  //                      enabled then IP checksum is in these bits.
  //                      Bit [2] of rx_type_match_code identifies whether
  //                      there is a type match if TOE is disabled, or
  //                      it was SNAP encoded if TOE is enabled
  always @( * )
  begin
    // RX TCP Offload Engine not enabled
    if (~rx_toe_enable)
      rx_type_match_code = {(rx_w_type_match4 |
                             rx_w_type_match3 |
                             rx_w_type_match2 |
                             rx_w_type_match1),

                            rx_w_type_match4 ? 2'b11 :
                            rx_w_type_match3 ? 2'b10 :
                            rx_w_type_match2 ? 2'b01 :
                                               2'b00};

    // RX TCP Offload Engine enabled
    else
      rx_type_match_code = {rx_w_snap_frame,
                            rx_w_checksumu_ok ? 2'b11 :
                            rx_w_checksumt_ok ? 2'b10 :
                            rx_w_checksumi_ok ? 2'b01 :
                                                2'b00};
  end


  // The following calculation denotes the the position of the end of
  // frame address. There are not enough bits in the status words to
  // pass the end of frame address, so we instead calculate the end of
  // frame address based on the current address.  We extend the calculation
  // to 16 bits to account for the scenario
  // where the edma_rx_pbuf_addr paramater is larger or smaller than the 12
  // bits allocated for the size of frame.

  wire [16:0] pkt_end_addr_mod;
  wire [17:0] pkt_end_addr;
  reg  [16:0] pkt_length_wr_corrected;

  // We however firstly detect if the incoming frame has an error. If this is the case then
  // the frame will be discarded and the pkt_length is only valid for recovering
  // locations and not for calculating the packet end address.
  // Note. The above differs for partial store and forward mode, as this mode doesn't
  // silently drop frames, so the pkt length must be used to calculate the end address.

  always @(*)
    // Is there an error on the frame
    if (status_word_1[0] || rx_cutthru)
      pkt_length_wr_corrected = {5'd0,status_word_1[26:15]};
    else
      pkt_length_wr_corrected = 17'd0;

  assign pkt_end_addr =  {{17-p_edma_rx_pbuf_addr{saved_end[p_edma_rx_pbuf_addr-1]}},saved_end} + 16'd1;
  assign pkt_end_addr_mod = pkt_end_addr[16:0]
                            - {{17-p_edma_rx_pbuf_addr{saved_start[p_edma_rx_pbuf_addr-1]}},saved_start}
                            - pkt_length_wr_corrected;

   // Word to write in first LUT element for this entry
   // Note this word is unique to the others because it is read and used early in the edma_pbuf_rx_rd.v
   // in order to understand which queue the frame is destined.  The pld_offset and bit 0 also
   // is needed up front.
   assign status_word_1 = { 1'd0,
                            queue_ptr_rx,
                            pkt_length_wr,
                           (rsc_push && p_edma_rsc == 1), // 14
                           ((rsc_stop | rsc_stop_seqnum) && p_edma_rsc == 1), // 13
                            rx_w_pld_offset,
                           (~frame_was_errored & ~dbuff_overflow_hold & frame_count == 3'h0 & ~rx_w_sop)
                         };

   // Word to write in second LUT element for this entry
   assign status_word_2 = {(ts_to_be_written & rx_bd_extended_mode_en),  // 31
                        (timestamp_cpt[35] & rx_bd_extended_mode_en), // 30
                        (timestamp_cpt[34] & rx_bd_extended_mode_en), // 29
                        rx_w_crc_error,                    // 28
                        (timestamp_cpt[33] & rx_bd_extended_mode_en), // 27
                        rx_w_broadcast_frame,              // 26
                        rx_w_mult_hash_match,              // 25
                        rx_w_uni_hash_match,               // 24
                        rx_w_vlan_tagged,                  // 23
                        rx_w_prty_tagged,                  // 22
                        (timestamp_cpt[32] & rx_bd_extended_mode_en), // 21
                        rx_w_tci[3:0],                     // 20:17
                        rx_type_match_code,                // 16:14
                        rx_add_match_code,                 // 12:10
                        rx_w_snap_frame,                   // 9
                        1'b0,                              // 8
                        pkt_end_addr_mod[7:0]};            // 7:0

   // Word to write in third LUT element for this entry
   // IP offset - 7 bits (128 bytes)
   // TCP offset - 12 bits (4KB)
   // payload offset - 12 bits (4KB)
   // TCP/IP enable - 1 bit

   assign status_word_3 = {(timestamp_cpt[41:36] & {6{rx_bd_extended_mode_en}}),
                           rx_w_l4_offset,
                           rx_w_frame_length
                          };

   // No need to pass timestamp which is mostly in status_word_4 if p_edma_tsu is not set.
   generate if (p_edma_tsu == 1) begin : gen_ct_ts
     assign cutthru_status_word     = {saved_start, status_word_4, status_word_3, status_word_2, status_word_1};
     assign cutthru_status_word_par = {status_word_4_par, status_word_3_par, status_word_2_par, status_word_1_par};
   end else begin : gen_no_ct_ts
     assign cutthru_status_word     = {saved_start, status_word_3, status_word_2, status_word_1};
     assign cutthru_status_word_par = {status_word_3_par, status_word_2_par, status_word_1_par};
   end
   endgenerate

   // Word to write in fourth LUT element for this entry
   assign status_word_4     = timestamp_cpt[31:0];    // Will be 0 if p_edma_tsu is not set to 1.
   assign status_word_4_par = timestamp_cpt_par[3:0]; // Parity already comes in from timestamp if required

  // Optionally generate parity for status_word_1/2/3
  generate if (p_edma_asf_dap_prot == 1) begin : gen_status_word_par

    // Parity check
    cdnsdru_asf_parity_check_v1 #(.p_data_width(42)) i_gem_par_chk_ts (
      .odd_par(1'b0),
      .data_in(timestamp_cpt),
      .parity_in(timestamp_cpt_par),
      .parity_err(dap_ts_cpt_err)
    );

    // parity generation for status_word_1/2/3
    cdnsdru_asf_parity_gen_v1 #(.p_data_width(96)) i_gem_par_status_word(
        .odd_par(1'b0),
        .data_in({status_word_3,status_word_2,status_word_1}),
        .data_out(),
        .parity_out({status_word_3_par,status_word_2_par,status_word_1_par})
        );
  end else begin : gen_no_status_word_par
    assign status_word_1_par  = 4'd0;
    assign status_word_2_par  = 4'd0;
    assign status_word_3_par  = 4'd0;
    assign dap_ts_cpt_err     = 1'b0;
  end
  endgenerate
  
generate if (p_edma_rsc == 1) begin : gen_rsc_seqnumchk
genvar seqnum_int;
  // For RSC, we need to monitor the sequence number changes from one frame to the next
  // It should match the payload length of the previous frame.
  // When the SYN flag is set in the TCP frame, this marks the beginning of the TCP
  // sequence and the first byte's seq num = seqnum+1. When SYN flag is not set,
  // the first bytes seq num = seqnum.
  // example : Receive 2 frames, A and B.
  // Frame A - SYN flag set and extracted seqnum = 32'h00000000, payload length = 0x100 bytes.
  //           This means the sequence number of the first byte of that frame = 0x00000001
  //           and the sequence number of the last byte is 0x00000100
  // Frame B - SYN flag not set, extracted seqnum should be 0x00000101. If its not, then we should
  //           flag an error to indicate somewhere a TCP segment has gone missing.
  integer seqnum_tmp_int;
  reg [p_edma_queues-2:0] seqnum_chk_en;
  wire  [16:0] seqnum_chk_en_pad;
  wire  [31:0] zero = 32'h00000000;
  reg   [31:0] nxt_seqnum     [1:p_edma_queues-1];
  reg   [31:0] nxt_seqnum_tmp [0:16];
  wire  [32:0] seqnum_ppldlen ;
  assign seqnum_ppldlen = {16'h0000,tcp_payload_len} + tcp_seqnum;
  wire  [32:0] seqnum_ppldlen_p1 ;
  assign seqnum_ppldlen_p1 = {16'h0000,tcp_payload_len} + 32'h00000001 + tcp_seqnum;
  for (seqnum_int = 1;seqnum_int < p_edma_queues;seqnum_int=seqnum_int+1)
  begin : gen_priq_seqnum
    always @(posedge rx_clk or negedge n_rxreset)
    begin
      if (~n_rxreset)
      begin
        nxt_seqnum[seqnum_int] <= 32'h00000000;
        seqnum_chk_en[seqnum_int-1] <= 1'b0;
      end
      else if (~enable_receive_sync)
      begin
        nxt_seqnum[seqnum_int] <= 32'h00000000;
        seqnum_chk_en[seqnum_int-1] <= 1'b0;
      end
      else
      begin
        if (!rsc_en[seqnum_int-1])
          seqnum_chk_en[seqnum_int-1] <= 1'b0;
        else if (status_write_complete)
          seqnum_chk_en[seqnum_int-1] <= 1'b1;

        if (seqnum_int[3:0] == queue_ptr_rx)
        begin
          if (status_write_complete)
          begin
            if (tcp_syn)
              nxt_seqnum[seqnum_int] <= seqnum_ppldlen_p1[31:0];
            else
              nxt_seqnum[seqnum_int] <= seqnum_ppldlen[31:0];
          end
        end
      end
    end
  end

  always @(*)
  begin
    nxt_seqnum_tmp[0] = zero;
    for (seqnum_tmp_int = 1;seqnum_tmp_int < p_edma_queues;seqnum_tmp_int=seqnum_tmp_int+1)
      nxt_seqnum_tmp[seqnum_tmp_int] = nxt_seqnum[seqnum_tmp_int];
    for (seqnum_tmp_int = p_edma_queues;seqnum_tmp_int < 17;seqnum_tmp_int=seqnum_tmp_int+1)
      nxt_seqnum_tmp[seqnum_tmp_int] = zero;
  end
  assign seqnum_chk_en_pad = {{17-p_edma_queues{1'b0}},seqnum_chk_en,1'b0};
  assign rsc_stop_seqnum = queue_ptr_rx != 4'h0 & (~tcp_syn & tcp_seqnum != nxt_seqnum_tmp[queue_ptr_rx] & seqnum_chk_en_pad[queue_ptr_rx]);
end else begin : gen_rsc_noseqnumchk
  assign rsc_stop_seqnum = 1'b0;
end
endgenerate

  // Toggle acknowledge to GEM_RX when status has been used.
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
    begin
      dma_rx_status_tog <= 1'b0;
      rx_status_wr_tog  <= 1'b0;
    end

    // Update to input value when successfully written last STATUS word.
    // This way we only toggle the same signals as the GEM_RX did.
    else if (status_write_complete | ~enable_receive_sync)
    begin
      dma_rx_status_tog <= dma_rx_end_tog;
      rx_status_wr_tog  <= rx_end_tog;
    end

    // If we silently dropped the packet, then we must also toggle these
    // signals ...
    // Silently dropped if dbuff is full on SOP
    // or if the packet is rediculously small or there was an error with SOP
    // This can be simplified by saying we can drive the status if we
    // see an end of packet in the IDLE state ...
    else if (store_fsm == SFSM_IDLE & end_of_pkt)
    begin
      dma_rx_status_tog <= dma_rx_end_tog;
      rx_status_wr_tog  <= rx_end_tog;
    end

    // Else maintain value
    else
    begin
      dma_rx_status_tog <= dma_rx_status_tog;
      rx_status_wr_tog  <= rx_status_wr_tog;
    end
  end

  //------------------------------------------------------------------------------
  // DPSRAM Buffer Fill Level Detection
  //------------------------------------------------------------------------------
  // Need to detect when the AHB side of PKT buffer is completely
  // done with some data
  // First pass pkt_done_tog into mac rx domain
  edma_sync_toggle_detect i_edma_sync_toggle_detect_pkt_done_tog (
    .clk      (rx_clk),
    .reset_n  (n_rxreset),
    .din      (pkt_done_tog),
    .rise_edge(),
    .fall_edge(),
    .any_edge (pkt_read_done)
  );

  // Determined current fill level and length of packet being written.
  assign dpram_write = (nxt_rxdpram_wea & nxt_rxdpram_ena);

  assign pkt_done_dplocns_gated   = {p_edma_rx_pbuf_addr{pkt_read_done}} & pkt_done_dplocns;

  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      pkt_flush  <= 1'b0;
    else
      begin
        if (~enable_receive_sync)
          pkt_flush  <= 1'b0;
        else
          pkt_flush  <= nxt_pkt_flush;
      end
  end

  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      pkt_done_capt_tog <= 1'b0;
    else
      begin
        if (~enable_receive_sync)
          pkt_done_capt_tog <= pkt_done_capt_tog;
        else if(pkt_read_done)
          pkt_done_capt_tog <= ~pkt_done_capt_tog;
      end
  end

  wire [16:0] dpram_fill_lvl_inc;
  wire [16:0] dpram_fill_lvl_dec;

  assign dpram_fill_lvl_inc = {16'd0,dpram_write};
  assign dpram_fill_lvl_dec = ({{(17-p_edma_rx_pbuf_addr){1'b0}},pkt_done_dplocns_gated} & {17{pkt_read_done}}) + ({5'd0,pkt_length_wr} & {17{pkt_flush}});

  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      dpram_fill_lvl    <= {p_edma_rx_pbuf_addr{1'b0}};
    else
      begin
        if (~enable_receive_sync)
          dpram_fill_lvl <= {p_edma_rx_pbuf_addr{1'b0}};
        else
          dpram_fill_lvl <= dpram_fill_lvl + dpram_fill_lvl_inc[p_edma_rx_pbuf_addr-1:0] - dpram_fill_lvl_dec[p_edma_rx_pbuf_addr-1:0];
      end
  end

  assign dbuff_full =
      // Set full when <=4 locations remaining
      rx_pbuf_size == 2'b11 ?  dpram_fill_lvl >= ({p_edma_rx_pbuf_addr{1'b1}} - 4) :
      rx_pbuf_size == 2'b10 ?  dpram_fill_lvl[p_edma_rx_pbuf_addr-2:0] >= ({p_edma_rx_pbuf_addr-1{1'b1}} - 4) :
      rx_pbuf_size == 2'b01 ?  dpram_fill_lvl[p_edma_rx_pbuf_addr-3:0] >= ({p_edma_rx_pbuf_addr-2{1'b1}} - 4) :
                               dpram_fill_lvl[p_edma_rx_pbuf_addr-4:0] >= ({p_edma_rx_pbuf_addr-3{1'b1}} - 4);

  // Compare read and write pointers to detect overflow of data buffer.
  assign dbuff_overflow = (rx_w_wr & dbuff_full & (~dbuff_overflow_hold | rx_w_sop));
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      dbuff_overflow_hold <= 1'b0;

    // Reset on flush
    else if (~enable_receive_sync)
      dbuff_overflow_hold <= 1'b0;

    else if (dbuff_overflow)
      dbuff_overflow_hold <= 1'b1;

    // reset overflow if dropping frame and have completed LUT writeback
    else if ((dbuff_overflow_hold & status_write_complete) | (rx_w_sop & rx_w_wr))
       begin
          dbuff_overflow_hold <= 1'b0;
       end

    // Else maintain value until used
    else
       begin
          dbuff_overflow_hold <= dbuff_overflow_hold;
       end
  end

  // Signal FIFO overflow to GEM_RX when DMA has overflowed or packet data
  // buffer has overflowed.
  // Only signal data buffer overflow back to GEM_RX if not EOP (too late).
  //  assign rx_w_overflow = (dbuff_full & rx_w_wr & ~rx_w_err & ~rx_w_eop);
  // Actually dont need to do this - this will end up flushing the MAC
  // which we dont want to do - we will handle everything in DMA
  assign rx_w_overflow = 1'b0;

  // ----------------------------------------------------
  // Create a toggle on end_of_packet so that it can be
  // passed across clock domains to indicate a full packet is
  // ready to be read from DPRAM
  //
  // To support cut through modes, we also pass a trigger when
  // the fill-level passes a watermark figure.  When cut through
  // mode is enabled, the status words will not have been written
  // yet, so the stats, info for the writeback and info
  // stored in status_word 1 (num_ramlocns_used, rx_w_frame_length,
  // and whether the packet was in error) is not known in advance
  // Therefore in this mode, the read side of the packet buffer must
  // start to retrieve the packet "at risk"
  //
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
    begin
      pkt_rx_xfer_req   <= 1'b0;
      part_pkt_xfer_req <= 1'b0;
    end
    else
    begin
      if (~enable_receive_sync)
      begin
        pkt_rx_xfer_req   <= 1'b0;
        part_pkt_xfer_req <= 1'b0;
      end

      // full packet has been written in when rx_cutthru is low
      // low watermark has been crossed when rx_cutthru is high
      else
      begin
        pkt_rx_xfer_req <= status_write_complete;

        part_pkt_xfer_req <=  rxdpram_ena & rx_cutthru &
                              last_store_fsm == SFSM_DATA &
                              (store_fsm != SFSM_EOF & store_fsm != SFSM_STATUS1) &
                              (part_length_wr ==
                               rx_cutthru_threshold[p_edma_rx_pbuf_addr-1:0]);
      end
    end
  end

  edma_sync_toggle_detect i_edma_sync_toggle_detect_pkt_captured (
    .clk      (rx_clk),
    .reset_n  (n_rxreset),
    .din      (pkt_captured),
    .rise_edge(),
    .fall_edge(),
    .any_edge (pkt_capt)
  );

  wire [4:0] rx_w_l3_offset;
  assign rx_w_l3_offset = status_word_2[23] & status_word_2[9]  ? 5'd26 : // VLAN and SNAP
                          status_word_2[23]                     ? 5'd18 : // VLAN
                          status_word_2[9]                      ? 5'd22 : // SNAP
                                                                  5'd14;

  wire  [4:0] num_pkts_xfer_local_ppkt;
  assign num_pkts_xfer_local_ppkt = num_pkts_xfer_local + pkt_rx_xfer_req;
  wire  [4:0] num_pkts_xfer_local_p1;
  assign num_pkts_xfer_local_p1 = num_pkts_xfer_local + 4'h1;

  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
    begin
      end_of_packet_tog          <= 1'b0;
      part_of_packet_tog         <= 1'b0;
      new_pkt_capt_req           <= 1'b0;
      new_part_pkt_capt_req      <= 1'b0;
      num_pkts_xfer              <= 4'h0;
      num_pkts_xfer_local        <= 4'h0;
      waiting_for_pkt_capt       <= 1'b0;
      part_of_packet_queue_ptr   <= 4'd0;
      part_of_packet_fld_offsets <= 31'd0;
    end
    else
    begin

      if (~enable_receive_sync)
      begin
        end_of_packet_tog          <= end_of_packet_tog;
        part_of_packet_tog         <= part_of_packet_tog;
        new_pkt_capt_req           <= 1'b0;
        new_part_pkt_capt_req      <= 1'b0;
        num_pkts_xfer              <= 4'h0;
        num_pkts_xfer_local        <= 4'h0;
        waiting_for_pkt_capt       <= 1'b0;
        part_of_packet_queue_ptr   <= 4'd0;
        part_of_packet_fld_offsets <= 31'd0;
      end

      // Enough of a packet has been received by MAC and written into DPRAM
      // Inform read side of PBUF that it can now start reading the packet ...
      else if ((pkt_rx_xfer_req|part_pkt_xfer_req) & ~waiting_for_pkt_capt)
      begin
        num_pkts_xfer_local   <= 4'h0;
        num_pkts_xfer         <= 4'h1;
        if (pkt_rx_xfer_req)
          end_of_packet_tog   <= ~end_of_packet_tog;
        else begin
          part_of_packet_tog         <= ~part_of_packet_tog;
          part_of_packet_queue_ptr   <= queue_ptr_rx;
          part_of_packet_fld_offsets <= {
                                          rsc_push,rsc_stop,
                                          rx_w_l3_offset,rx_w_pld_offset,rx_w_l4_offset};
        end
        waiting_for_pkt_capt  <= 1'b1;
      end

      // Read side has captured the information we passed over ..
      // If there have been more pkts written into DPRAM since we first
      // indicated available data, then send a new handshake
      else if (pkt_capt)
      begin
        num_pkts_xfer_local   <= 4'h0;
        if (new_pkt_capt_req|pkt_rx_xfer_req |
            part_pkt_xfer_req|new_part_pkt_capt_req)
        begin
          new_pkt_capt_req      <= 1'b0;
          new_part_pkt_capt_req <= 1'b0;
          num_pkts_xfer         <= num_pkts_xfer_local_ppkt[3:0];
          if (new_pkt_capt_req | pkt_rx_xfer_req)
            end_of_packet_tog     <= ~end_of_packet_tog;
          else begin
            part_of_packet_tog         <= ~part_of_packet_tog;
            part_of_packet_queue_ptr   <= queue_ptr_rx;
            part_of_packet_fld_offsets <= {rsc_push,rsc_stop,
                                           rx_w_l3_offset,rx_w_pld_offset,rx_w_l4_offset};
          end
          waiting_for_pkt_capt  <= 1'b1;
        end
      // Not any new pkt information received, so just go quiet
        else
        begin
          num_pkts_xfer         <= 4'h0;
          waiting_for_pkt_capt  <= 1'b0;
          new_pkt_capt_req      <= 1'b0;
          new_part_pkt_capt_req <= 1'b0;
        end
      end

      // Read side has not captured anything yet, and there has been another pkt received
      // from MAC since
      else if (pkt_rx_xfer_req)
      begin
        if (new_part_pkt_capt_req)
          num_pkts_xfer_local <= 4'h1;
        else
          num_pkts_xfer_local <= num_pkts_xfer_local_p1[3:0];
        new_pkt_capt_req <= 1'b1;
        new_part_pkt_capt_req <= 1'b0;
      end

      // Read side has not captured anything yet, and there has been another pkt received
      // from MAC since
      else if (part_pkt_xfer_req)
      begin
        num_pkts_xfer_local    <= 4'h1;
        new_part_pkt_capt_req  <= 1'b1;
      end
    end
  end

  // Helper signal for RX lockup detection.
  // This signal can be used to gate the EOP for packet incrementing as the packet will
  // be flushed.
  assign edma_overflow  = dbuff_overflow | dbuff_overflow_hold;

  // Remaining parity checks
  generate if (p_edma_asf_dap_prot == 1) begin : gen_dp_par_chk
    wire        ct_sw_par_err_c;
    reg         ct_sw_par_err_r;

    // Parity checker for cutthru_status_word
    cdnsdru_asf_parity_check_v1 #(.p_data_width(p_ct_fifo_sw)) i_par_chk_ct_sw (
      .odd_par(1'b0),
      .data_in(cutthru_status_word[p_ct_fifo_sw-1:0]),
      .parity_in(cutthru_status_word_par[p_ct_fifo_pw-1:0]),
      .parity_err(ct_sw_par_err_c)
    );

    // Register the parity error when actually pushing to the FIFO.
    always@(posedge rx_clk or negedge n_rxreset)
    begin
      if (~n_rxreset)
        ct_sw_par_err_r <= 1'b0;
      else if (~enable_receive_sync)
        ct_sw_par_err_r <= 1'b0;
      else if (cutthru_status_word_push)
        ct_sw_par_err_r <= ct_sw_par_err_c;
    end
    assign asf_dap_rx_wr_err = dap_ts_cpt_err | ct_sw_par_err_r;
  end else begin : gen_no_dp_par_chk
    assign asf_dap_rx_wr_err = 1'b0;
  end
  endgenerate

endmodule

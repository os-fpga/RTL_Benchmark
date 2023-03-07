//------------------------------------------------------------------------------
// Copyright (c) 2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_reg_stats.v
//   Module Name:        gem_reg_stats
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
//   Description    : Contains packet statistics including the optional
//                    snapshot registers.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_reg_stats (
  input               pclk,                   // APB clock
  input               n_preset,               // Active low reset
  input   [11:0]      i_paddr,                // Full APB address
  input               psel,                   // APB select
  input               write_registers,        // write to apb registers.
  input               read_registers,         // read from apb registers.
  input   [31:0]      pwdata,                 // APB write data
  input               stats_write_en,         // Network control allow stats write
  input               inc_all_stats_regs,     // Network control increment all stats
  input               clear_all_stats_regs,   // Network control clear stats
  input               stats_take_snap,        // Network control take snapshot
  input               stats_read_snap,        // Network control read snapshot
  input               tx_lpi_en,              // LPI enable from Network control
  input               tx_mac_ok_pclk,         // Packet transmitted, update stat
  input   [13:0]      tx_bytes_pclk,          // Num bytes in frame txed OK
  input               tx_broadcast_pclk,      // pclk pulse for broadcast txed OK
  input               tx_multicast_pclk,      // pclk pulse for multicast txed OK
  input               tx_single_col_pclk,     // pclk pulse when frame eventually
                                              // txed OK but had a single collision.
  input               tx_multi_col_pclk,      // pclk pulse when frame eventually
                                              // txed OK but had multiple collisions
  input               tx_late_col_pclk,       // pclk pulse on late collision frame.
  input               tx_late_col_mac_pclk,   // pclk pulse on late collision frame.
                                              // set to tx_late_col_pclk when not
                                              // using pktbuf
  input               tx_deferred_pclk,       // pclk pulse if frame was deferred.
  input               tx_crs_err_pclk,        // pclk pulse if frame had crs error.
  input               tx_toomanyretry_pclk,   // pclk pulse if frame had too many
                                              // retries.
  input               tx_pause_ok_pclk,       // pclk pulse for 802.3 pause frame
                                              // txed OK
  input               tx_pfc_pause_ok_pclk,   // pclk pulse for PFC pause frame
                                              // txed OK
  input               tx_underrun_pclk,       // pclk pulse when tx underrun occured
  input               ok_to_update_rx_stats,  // OK to update the stats
  input               rx_mac_ok_pclk,         // == rx_ok_pclk when not using
                                              // pktbuff. Done this way so that LEC
                                              // proves the old non PBUF versions
                                              // are still equivalent tx_mac_ok_pclk
                                              // is simply a delayed MAC version of
                                              // rx_ok_pclk whilst in pktbuff mode
  input   [13:0]      rx_bytes_pclk,          // Number of bytes in frame rxed OK
  input               rx_broadcast_pclk,      // pclk pulse for broadcast rxed OK
  input               rx_multicast_pclk,      // pclk pulse for multicast rxed OK
  input               rx_align_err_pclk,      // pclk pulse when rx frame discarded
                                              // because of an alignment error.
  input               rx_crc_err_pclk,        // pclk pulse when rx frame discarded
                                              // because of a CRC/FCS error.
  input               rx_short_err_pclk,      // pclk pulse when rx frame discarded
                                              // because of a too short error.
  input               rx_long_err_pclk,       // pclk pulse when rx frame discarded
                                              // because of a too long error.
  input               rx_jabber_err_pclk,     // pclk pulse when rx frame discarded
                                              // because of a jabber error.
  input               rx_symbol_err_pclk,     // pclk pulse when rx frame discarded
                                              // because of a symbol error.
  input               rx_pause_ok_pclk,       // pclk pulse for 802.3 or PFC
                                              // pause frame rxed OK.
  input               rx_length_err_pclk,     // pclk pulse when rx frame discarded
                                              // because of a length field error.
  input               rx_ip_ck_err_pclk,      // pclk pulse when rx frame discarded
                                              // because of a IP checksum error.
  input               rx_tcp_ck_err_pclk,     // pclk pulse when rx frame discarded
                                              // because of a TCP checksum error.
  input               rx_udp_ck_err_pclk,     // pclk pulse when rx frame discarded
                                              // because of a UDP checksum error.
  input               rx_dma_pkt_flushed_pclk,// pclk pulse when rx frame discarded
                                              // because of a AHB resource error
  input               rx_overflow_pclk,       // pclk pulse when the RX pipeline or
                                              // FIFO overflowed due to bandwidth.
  input               rx_resource_err_pclk,   // pclk pulse when rx frame discarded
                                              // because a buffer was unavailable.
  input               lpi_indicate_pclk,      // rx LPI indication has been detected
  input               lpi_indicate_del,       // lpi_indicate_pclk delayed by one pclk

  input               frame_flushed_pclk,     // frame being flushed by per queue rx flushing
                                              // Mode2, 3 or 4
  output  reg [31:0]  prdata_stats,           // Read data (combinatorial)
  output  reg         perr_stats              // Similarly perr signal

);

  // Module parameterisation
  parameter p_edma_no_snapshot    = 1'b0;  // Optional exclude snapshot registers.
  parameter p_edma_rx_pkt_buffer  = 1'b1;  // Optional packet buffer stats

  wire          read_stats_registers;   // apb read of a real statistic reg.
  wire          reset_all_stats_regs;   // set for both clear_all_stats_regs
                                        // and when snapshot is taken
  wire          inc_octets_txed_top;    // increment octets_txed_top count
  wire  [32:0]  octets_txed_bot_next;   // next count value for bottom half
  reg   [31:0]  octets_txed_bottom;     // number of octets txed (bottom half)
  wire  [16:0]  octets_txed_top_next;   // next count value for top half
  reg   [15:0]  octets_txed_top;        // number of octets txed (top half)
  reg   [31:0]  frames_txed_ok;         // number of frames transmitted ok.
  reg   [31:0]  broadcast_txed;         // number of broadcast frames txed
  reg   [31:0]  multicast_txed;         // number of multicast frames txed
  reg   [15:0]  pause_frames_txed;      // number of pause frames transmitted.
  reg   [31:0]  frames_txed_64;         // number of tx frames 64 bytes long
  reg   [31:0]  frames_txed_65;         // number of tx frames 65-127 bytes
  reg   [31:0]  frames_txed_128;        // number of tx frames 128-255 bytes
  reg   [31:0]  frames_txed_256;        // number of tx frames 256-511 bytes
  reg   [31:0]  frames_txed_512;        // number of tx frames 512-1023 bytes
  reg   [31:0]  frames_txed_1024;       // number of tx frames 1024-1518 bytes
  reg   [31:0]  frames_txed_1519;       // number of tx frames over 1518 bytes
  wire          inc_frames_txed_64;     // increment frames_txed_64 count
  reg           inc_frames_txed_65;     // increment frames_txed_65 count
  reg           inc_frames_txed_128;    // increment frames_txed_128 count
  reg           inc_frames_txed_256;    // increment frames_txed_256 count
  reg           inc_frames_txed_512;    // increment frames_txed_512 count
  reg           inc_frames_txed_1024;   // increment frames_txed_1024 count
  wire          inc_frames_txed_1519;   // increment frames_txed_1519 count
  reg   [9:0]   tx_underruns;           // number of frames tx underrun errors.
  reg   [17:0]  single_collisions;      // number of single collisions frames.
  reg   [17:0]  multiple_collisions;    // number of multi collisions frames.
  reg   [9:0]   excessive_collisions;   // number of excessive collision frames
  reg   [9:0]   late_collisions;        // number of late collision frames.
  reg   [17:0]  deferred_frames;        // number of deferred frames.
  reg   [9:0]   crs_errors;             // number of frames with crs errors.
  reg   [31:0]  octets_rxed_bottom;     // number of octets rxed (bottom half)
  reg   [15:0]  octets_rxed_top;        // number of octets rxed (top half)
  wire  [32:0]  octets_rxed_bot_next;   // next count value for bottom half
  wire  [16:0]  octets_rxed_top_next;   // next count value for top half
  wire          upd_rx_stats;           // increment rx statistics
  wire          inc_octets_rxed_top;    // increment octets_rxed_top count
  reg   [31:0]  frames_rxed_ok;         // number of frames received ok.
  reg   [31:0]  broadcast_rxed;         // number of broadcast frames rxed
  reg   [31:0]  multicast_rxed;         // number of multicast frames rxed
  reg   [15:0]  pause_frames_rxed;      // number of pause frames received.
  reg   [31:0]  frames_rxed_64;         // number of rx frames 64 bytes long
  reg   [31:0]  frames_rxed_65;         // number of rx frames 65-127 bytes
  reg   [31:0]  frames_rxed_128;        // number of rx frames 128-255 bytes
  reg   [31:0]  frames_rxed_256;        // number of rx frames 256-511 bytes
  reg   [31:0]  frames_rxed_512;        // number of rx frames 512-1023 bytes
  reg   [31:0]  frames_rxed_1024;       // number of rx frames 1024-1518 bytes
  reg   [31:0]  frames_rxed_1519;       // number of rx frames over 1518 bytes
  wire          inc_frames_rxed_64;     // increment frames_rxed_64 count
  reg           inc_frames_rxed_65;     // increment frames_rxed_65 count
  reg           inc_frames_rxed_128;    // increment frames_rxed_128 count
  reg           inc_frames_rxed_256;    // increment frames_rxed_256 count
  reg           inc_frames_rxed_512;    // increment frames_rxed_512 count
  reg           inc_frames_rxed_1024;   // increment frames_rxed_1024 count
  wire          inc_frames_rxed_1519;   // increment frames_rxed_1519 count
  reg   [9:0]   undersize_frames;       // number of undersize frames.
  reg   [9:0]   excessive_rx_length;    // number of rx excessive length frames
  reg   [9:0]   rx_jabbers;             // number of frames with jabber errors.
  reg   [9:0]   fcs_errors;             // number of frames with crc errors.
  reg   [9:0]   rx_length_errors;       // number of frames with length error
  reg   [9:0]   rx_symbol_errors;       // number of frames with symbol errors.
  reg   [9:0]   alignment_errors;       // number of frames alignment errors.
  reg   [17:0]  rx_resource_errors;     // number of frames rx resource errors.
  reg   [9:0]   rx_overruns;            // number of frames rx overrun errors.
  reg   [7:0]   rx_ip_ck_errors;        // number of frames IP checksum errors.
  reg   [7:0]   rx_tcp_ck_errors;       // number of frames TCP checksum errors
  reg   [7:0]   rx_udp_ck_errors;       // number of frames UDP checksum errors
  wire  [15:0]  rx_auto_flushed_pkts;   // number of frames flushed
  reg   [23:0]  rx_lpi_asserted;        // time rx lpi is asserted
  reg   [23:0]  tx_lpi_asserted;        // time tx lpi is asserted
  reg   [15:0]  tx_lpi_count;           // count of tx lpi transitions
  reg   [15:0]  rx_lpi_count;           // count of rx lpi transitions
  reg           tx_lpi_en_del;          // for edge detect
  reg   [3:0]   pclk_cnt;               // count of pclk to slow down lpi count

  reg   [31:0]  r_octets_txed_bottom;   // value of octets txed (bottom half)
  reg   [15:0]  r_octets_txed_top;      // value of octets txed (top half)
  reg   [31:0]  r_frames_txed_ok;       // value of frames transmitted ok.
  reg   [31:0]  r_broadcast_txed;       // value of broadcast frames txed
  reg   [31:0]  r_multicast_txed;       // value of multicast frames txed
  reg   [15:0]  r_pause_frames_txed;    // value of pause frames transmitted.
  reg   [31:0]  r_frames_txed_64;       // value of tx frames 64 bytes long
  reg   [31:0]  r_frames_txed_65;       // value of tx frames 65-127 bytes
  reg   [31:0]  r_frames_txed_128;      // value of tx frames 128-255 bytes
  reg   [31:0]  r_frames_txed_256;      // value of tx frames 256-511 bytes
  reg   [31:0]  r_frames_txed_512;      // value of tx frames 512-1023 bytes
  reg   [31:0]  r_frames_txed_1024;     // value of tx frames 1024-1518 bytes
  reg   [31:0]  r_frames_txed_1519;     // value of tx frames over 1518 bytes
  reg   [9:0]   r_tx_underruns;         // value of frames tx underrun errors.
  reg   [17:0]  r_single_collisions;    // value of single collisions frames.
  reg   [17:0]  r_multiple_colls;       // value of multi collisions frames.
  reg   [9:0]   r_excessive_colls;      // value of excessive collision frames
  reg   [9:0]   r_late_collisions;      // value of late collision frames.
  reg   [17:0]  r_deferred_frames;      // value of deferred frames.
  reg   [9:0]   r_crs_errors;           // value of frames with crs errors.
  reg   [31:0]  r_octets_rxed_bottom;   // value of octets rxed (bottom half)
  reg   [15:0]  r_octets_rxed_top;      // value of octets rxed (top half)
  reg   [31:0]  r_frames_rxed_ok;       // value of frames received ok.
  reg   [31:0]  r_broadcast_rxed;       // value of broadcast frames rxed
  reg   [31:0]  r_multicast_rxed;       // value of multicast frames rxed
  reg   [15:0]  r_pause_frames_rxed;    // value of pause frames received.
  reg   [31:0]  r_frames_rxed_64;       // value of rx frames 64 bytes long
  reg   [31:0]  r_frames_rxed_65;       // value of rx frames 65-127 bytes
  reg   [31:0]  r_frames_rxed_128;      // value of rx frames 128-255 bytes
  reg   [31:0]  r_frames_rxed_256;      // value of rx frames 256-511 bytes
  reg   [31:0]  r_frames_rxed_512;      // value of rx frames 512-1023 bytes
  reg   [31:0]  r_frames_rxed_1024;     // value of rx frames 1024-1518 bytes
  reg   [31:0]  r_frames_rxed_1519;     // value of rx frames over 1518 bytes
  reg   [9:0]   r_undersize_frames;     // value of undersize frames.
  reg   [9:0]   r_excessive_rx_lngth;   // value of rx excessive length frames
  reg   [9:0]   r_rx_jabbers;           // value of frames with jabber errors.
  reg   [9:0]   r_fcs_errors;           // value of frames with crc errors.
  reg   [9:0]   r_rx_length_errors;     // value of frames with length error
  reg   [9:0]   r_rx_symbol_errors;     // value of frames with symbol errors.
  reg   [9:0]   r_alignment_errors;     // value of frames alignment errors.
  reg   [17:0]  r_rx_resource_errors;   // value of frames rx resource errors.
  reg   [9:0]   r_rx_overruns;          // value of frames rx overrun errors.
  reg   [7:0]   r_rx_ip_ck_errors;      // value of frames IP checksum errors.
  reg   [7:0]   r_rx_tcp_ck_errors;     // value of frames TCP checksum errors
  reg   [7:0]   r_rx_udp_ck_errors;     // value of frames UDP checksum errors
  reg   [15:0]  r_rx_auto_flushed_pkts; // value of flushed frame count
  wire  [23:0]  r_rx_lpi_asserted;      // time rx lpi is asserted
  wire  [23:0]  r_tx_lpi_asserted;      // time tx lpi is asserted
  wire  [15:0]  r_tx_lpi_count;         // count of tx lpi transitions
  wire  [15:0]  r_rx_lpi_count;         // count of rx lpi transitions

  // If reading the real statistic registers then they must be cleared
  // If reading the snapshot then don't clear the real statistic registers
  assign read_stats_registers = read_registers & ~stats_read_snap;


  // reset all statistic registers when commanded or when snapshot taken
  assign reset_all_stats_regs = clear_all_stats_regs | stats_take_snap;


  // --------------------------------------------------------------------------
  // TX Statistics
  // --------------------------------------------------------------------------


  // --------------------------------------------------------------------------
  // Octets transmitted in frame without error
  // This includes destination address, source address, type fields, data
  // and FCS, but excludes preamble, SFD and carrier extension.
  // This counter is split into an upper and lower half.

  // calculate next count for bottom counter
  assign octets_txed_bot_next[32:0] = octets_txed_bottom[31:0] +
                                      {18'd0, tx_bytes_pclk[13:0]};

  // Octets transmitted in frame without error (lower)
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      octets_txed_bottom <= 32'h00000000;

    // if reset_all_stats_regs or if reading register and no new increment
    // then zero count.
    // else if reset_all_stats_regs or if reading register and there is
    // a new increment then new count is tx_bytes_pclk.
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_octets_txed_bottom))
      octets_txed_bottom <= {18'd0, tx_bytes_pclk[13:0]} & {32{tx_mac_ok_pclk}};

    // else if stats write enabled then allow write to count
    else if (write_registers & stats_write_en & i_paddr == `gem_octets_txed_bottom)
      octets_txed_bottom <= pwdata[31:0];

    // else if increment causes an overflow then set to maximum value
    else if (tx_mac_ok_pclk & octets_txed_top_next[16])
      octets_txed_bottom <= 32'hffffffff;

    // else if not overflowing then take on new count value
    else if (tx_mac_ok_pclk & ~octets_txed_top_next[16])
      octets_txed_bottom <= octets_txed_bot_next[31:0];

    // else if inc_all_stats_regs and not overflowing then add 1
    else if (inc_all_stats_regs & ~(&octets_txed_bottom))
      octets_txed_bottom <= octets_txed_bottom + 32'h00000001;

    // else maintain value
    else
      octets_txed_bottom <= octets_txed_bottom;
  end

   // determine when the higher count should be incremented
   // do not increment the top counter if the bottom counter
   // has been incremented and read at the same time
   assign inc_octets_txed_top = tx_mac_ok_pclk & octets_txed_bot_next[32] &
                                    ~(read_stats_registers &
                                      i_paddr == `gem_octets_txed_bottom);

   // calcualte next count for top counter
   assign octets_txed_top_next[16:0] = ({1'b0, octets_txed_top[15:0]} +
                                        {16'h0000, octets_txed_bot_next[32]});


  // Octets transmitted in frame without error (upper count)
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      octets_txed_top <= 16'h0000;

    // if reset_all_stats_regs or if reading register and no new increment
    // then zero count, or if incrementing then new count is one.
    else if (reset_all_stats_regs |
             (read_stats_registers & i_paddr == `gem_octets_txed_top))
      octets_txed_top <= 16'h0000;

    // else if stats write enabled then allow write to count
    else if (write_registers & stats_write_en & i_paddr == `gem_octets_txed_top)
      octets_txed_top <= pwdata[15:0];

    // else if increment and already full then set to maximum value
    else if (inc_octets_txed_top & (&octets_txed_top))
      octets_txed_top <= 16'hffff;

    // else if not already full then take on new count value
    else if (inc_octets_txed_top & ~(&octets_txed_top) & tx_mac_ok_pclk)
      octets_txed_top <= octets_txed_top_next[15:0];

    // else if inc_all_stats_regs and not already full then add 1
    else if (inc_all_stats_regs & ~(&octets_txed_top))
      octets_txed_top <= octets_txed_top + 16'h0001;

    // else maintain value
    else
      octets_txed_top <= octets_txed_top;
  end

   // --------------------------------------------------------------------------
   // frames transmitted OK.
   // counts number of frames successfully transmitted excluding automatically
   // generated pause frames.
   always @(posedge pclk or negedge n_preset)
   begin
    if (~n_preset)
      frames_txed_ok <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_frames_txed_ok))
      frames_txed_ok <= {31'd0, tx_mac_ok_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_frames_txed_ok)
      frames_txed_ok <= pwdata[31:0];
    else if ((tx_mac_ok_pclk | inc_all_stats_regs) & ~(&frames_txed_ok))
      frames_txed_ok <= frames_txed_ok + 32'h00000001;
    else
      frames_txed_ok <= frames_txed_ok;
   end

  // --------------------------------------------------------------------------
  // broadcast frames transmitted OK.
  // counts number of broadcast frames successfully transmitted excluding
  // automatically generated pause frames.
  wire   broadcast_event;
  assign broadcast_event = (tx_broadcast_pclk & tx_mac_ok_pclk);
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      broadcast_txed <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_broadcast_txed))
      broadcast_txed <= {31'd0,broadcast_event};
    else if (write_registers &
           i_paddr == `gem_broadcast_txed & stats_write_en)
      broadcast_txed <= pwdata[31:0];
    else if ((broadcast_event | inc_all_stats_regs) &
            ~(&broadcast_txed))
      broadcast_txed <= broadcast_txed + 32'h00000001;
    else
      broadcast_txed <= broadcast_txed;
  end

  // --------------------------------------------------------------------------
  // multicast frames transmitted OK.
  // counts number of multicast frames successfully transmitted excluding
  // automatically generated pause frames.
  wire   multicast_event;
  assign multicast_event = (tx_multicast_pclk & tx_mac_ok_pclk);
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      multicast_txed <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_multicast_txed))
      multicast_txed <= {31'd0, multicast_event};
    else if (write_registers & stats_write_en & i_paddr == `gem_multicast_txed)
      multicast_txed <= pwdata[31:0];
    else if ((multicast_event | inc_all_stats_regs) &
            ~(&multicast_txed))
      multicast_txed <= multicast_txed + 32'h00000001;
    else
      multicast_txed <= multicast_txed;
  end


  // --------------------------------------------------------------------------
  // count of automatically generated pause frames transmitted.
  // This count does not include pause frames transmitted through normal
  // buffer queue method (i.e. the path for normal frames)
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      pause_frames_txed <= 16'h0000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_pause_frames_txed))
      pause_frames_txed <= {15'h0000,(tx_pause_ok_pclk | tx_pfc_pause_ok_pclk)};
    else if (write_registers & stats_write_en & i_paddr == `gem_pause_frames_txed)
      pause_frames_txed <= pwdata[15:0];
    else if (((tx_pause_ok_pclk | tx_pfc_pause_ok_pclk) | inc_all_stats_regs) &
                ~(&pause_frames_txed))
      pause_frames_txed <= pause_frames_txed + 16'h0001;
    else
      pause_frames_txed <= pause_frames_txed;
  end


  // --------------------------------------------------------------------------
  // Distribute successfully transmitted frames based on their length.
  // The following length ranges are defined...
  //       64 byte frames
  //   65-127 byte frames
  //  128-255 byte frames
  //  256-511 byte frames
  //  512-1023 byte frames
  // 1024-1518 byte frames
  // over 1519 byte frames

  // detect when exactly 64 bytes in frame
  assign inc_frames_txed_64   = tx_mac_ok_pclk & (tx_bytes_pclk[13:0] == 14'h0040);

  // detect when 1519 or over
  assign inc_frames_txed_1519 = tx_mac_ok_pclk & (tx_bytes_pclk[13:0] > 14'd1518);

  // decode frame size at end of a successful frame
  always @(*)
  begin
    // Defaults
    inc_frames_txed_65   = 1'b0;
    inc_frames_txed_128  = 1'b0;
    inc_frames_txed_256  = 1'b0;
    inc_frames_txed_512  = 1'b0;
    inc_frames_txed_1024 = 1'b0;
    if (tx_mac_ok_pclk)
    begin
      // case of number of bytes in frame
      casex (tx_bytes_pclk[13:0])
        14'b00_0000_0xxx_xxxx: inc_frames_txed_65   = ~inc_frames_txed_64 &
                                                      tx_bytes_pclk[6];
        14'b00_0000_1xxx_xxxx: inc_frames_txed_128  = 1'b1;
        14'b00_0001_xxxx_xxxx: inc_frames_txed_256  = 1'b1;
        14'b00_001x_xxxx_xxxx: inc_frames_txed_512  = 1'b1;
        default              : inc_frames_txed_1024 = ~inc_frames_txed_1519;
      endcase
    end
  end

  // tx frame length of 64
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      frames_txed_64 <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_frames_txed_64))
      frames_txed_64 <= {31'd0, inc_frames_txed_64};
    else if (write_registers & stats_write_en & i_paddr == `gem_frames_txed_64)
      frames_txed_64 <= pwdata[31:0];
    else if ((inc_frames_txed_64 | inc_all_stats_regs) & ~(&frames_txed_64))
      frames_txed_64 <= frames_txed_64 + 32'h00000001;
    else
      frames_txed_64 <= frames_txed_64;
  end

  // tx frame length of 65-127
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      frames_txed_65 <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_frames_txed_65))
      frames_txed_65 <= {31'd0, inc_frames_txed_65};
    else if (write_registers & stats_write_en & i_paddr == `gem_frames_txed_65)
      frames_txed_65 <= pwdata[31:0];
    else if ((inc_frames_txed_65 | inc_all_stats_regs) & ~(&frames_txed_65))
      frames_txed_65 <= frames_txed_65 + 32'h00000001;
    else
      frames_txed_65 <= frames_txed_65;
  end

  // tx frame length of 128-255
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      frames_txed_128 <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_frames_txed_128))
      frames_txed_128 <= {31'd0, inc_frames_txed_128};
    else if (write_registers & stats_write_en & i_paddr == `gem_frames_txed_128)
      frames_txed_128 <= pwdata[31:0];
    else if ((inc_frames_txed_128 | inc_all_stats_regs) & ~(&frames_txed_128))
      frames_txed_128 <= frames_txed_128 + 32'h00000001;
    else
      frames_txed_128 <= frames_txed_128;
  end

  // tx frame length of 256-511
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      frames_txed_256 <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_frames_txed_256))
      frames_txed_256 <= {31'd0, inc_frames_txed_256};
    else if (write_registers & stats_write_en & i_paddr == `gem_frames_txed_256)
      frames_txed_256 <= pwdata[31:0];
    else if ((inc_frames_txed_256 | inc_all_stats_regs) & ~(&frames_txed_256))
      frames_txed_256 <= frames_txed_256 + 32'h00000001;
    else
      frames_txed_256 <= frames_txed_256;
  end

  // tx frame length of 512-1023
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      frames_txed_512 <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_frames_txed_512))
      frames_txed_512 <= {31'd0, inc_frames_txed_512};
    else if (write_registers & stats_write_en & i_paddr == `gem_frames_txed_512)
      frames_txed_512 <= pwdata[31:0];
    else if ((inc_frames_txed_512 | inc_all_stats_regs) & ~(&frames_txed_512))
      frames_txed_512 <= frames_txed_512 + 32'h00000001;
    else
      frames_txed_512 <= frames_txed_512;
  end

  // tx frame length of 1024-1518
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      frames_txed_1024 <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_frames_txed_1024))
      frames_txed_1024 <= {31'd0, inc_frames_txed_1024};
    else if (write_registers & stats_write_en & i_paddr == `gem_frames_txed_1024)
      frames_txed_1024 <= pwdata[31:0];
    else if ((inc_frames_txed_1024 | inc_all_stats_regs) & ~(&frames_txed_1024))
      frames_txed_1024 <= frames_txed_1024 + 32'h00000001;
    else
      frames_txed_1024 <= frames_txed_1024;
  end

  // tx frame length of 1519 or over
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      frames_txed_1519 <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_frames_txed_1519))
      frames_txed_1519 <= {31'd0, inc_frames_txed_1519};
    else if (write_registers & stats_write_en & i_paddr == `gem_frames_txed_1519)
      frames_txed_1519 <= pwdata[31:0];
    else if ((inc_frames_txed_1519 | inc_all_stats_regs) & ~(&frames_txed_1519))
      frames_txed_1519 <= frames_txed_1519 + 32'h00000001;
    else
      frames_txed_1519 <= frames_txed_1519;
  end


  // --------------------------------------------------------------------------
  // transmit underrun errors.
  // Counts frames not transmitted completely because of an underrun in the DMA
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      tx_underruns <= 10'd0;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_tx_underruns))
      tx_underruns <= {9'd0, tx_underrun_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_tx_underruns)
      tx_underruns <= pwdata[9:0];
    else if ((tx_underrun_pclk | inc_all_stats_regs) & ~(&tx_underruns))
      tx_underruns <= tx_underruns + 10'h001;
    else
      tx_underruns <= tx_underruns;
  end


  // --------------------------------------------------------------------------
  // single collision frames.
  // counts number of frames that experience a single collision before
  // being successfully transmitted
  wire   tx_single_col_event;
  assign tx_single_col_event = (tx_single_col_pclk & tx_mac_ok_pclk);
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      single_collisions <= 18'd0;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_single_collisions))
      single_collisions <= {17'd0, tx_single_col_event};
    else if (write_registers & stats_write_en & i_paddr == `gem_single_collisions)
      single_collisions <= pwdata[17:0];
    else if ((tx_single_col_event | inc_all_stats_regs) &
           ~(&single_collisions))
      single_collisions <= single_collisions + 18'h00001;
    else
      single_collisions <= single_collisions;
  end


  // --------------------------------------------------------------------------
  // multiple collision frames.
  // counts number of frames that experience between 2 and 15 collisions
  // before being successfully transmitted
  wire   tx_multi_col_event;
  assign tx_multi_col_event = (tx_multi_col_pclk & tx_mac_ok_pclk);
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      multiple_collisions <= 18'd0;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_multiple_collisions))
      multiple_collisions <= {17'd0, tx_multi_col_event};
    else if (write_registers & stats_write_en & i_paddr == `gem_multiple_collisions)
      multiple_collisions <= pwdata[17:0];
    else if ((tx_multi_col_event | inc_all_stats_regs) &
           ~(&multiple_collisions))
      multiple_collisions <= multiple_collisions + 18'h00001;
    else
      multiple_collisions <= multiple_collisions;
  end


  // --------------------------------------------------------------------------
  // excessive collisions.
  // counts number of frames that experience 16 collisions and hence
  // are aborted
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      excessive_collisions <= 10'd0;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_excessive_collisions))
      excessive_collisions <= {9'd0, tx_toomanyretry_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_excessive_collisions)
      excessive_collisions <= pwdata[9:0];
    else if ((tx_toomanyretry_pclk | inc_all_stats_regs) & ~(&excessive_collisions))
      excessive_collisions <= excessive_collisions + 10'h001;
    else
      excessive_collisions <= excessive_collisions;
  end


  // --------------------------------------------------------------------------
  // late collision frames.
  // Counts the number of frames experiencing collisions after the slot time
  // (512 bit times) has expired. In 10/100 mode late collisions are
  // also counted in the single or multiple collision statistic register.
  // For gigabit mode a late collision causes the frame to be aborted and
  // thus the single/multi collision stats are not updated.
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      late_collisions <= 10'd0;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_late_collisions))
      late_collisions <= {9'd0, tx_late_col_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_late_collisions)
      late_collisions <= pwdata[9:0];
    else if ((tx_late_col_mac_pclk | inc_all_stats_regs) & ~(&late_collisions))
      late_collisions <= late_collisions + 10'h001;
    else
      late_collisions <= late_collisions;
  end


  // --------------------------------------------------------------------------
  // deferred transmission frames.
  // counts the number of frames that are deferred due to carrier sense
  // being active on the first attempt at transmission. Frames involved
  // in collisions or underruns are not counted.
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      deferred_frames <= 18'd0;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_deferred_frames))
      deferred_frames <= {17'd0, tx_deferred_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_deferred_frames)
      deferred_frames <= pwdata[17:0];
    else if ((tx_deferred_pclk | inc_all_stats_regs) & ~(&deferred_frames))
      deferred_frames <= deferred_frames + 18'h00001;
    else
      deferred_frames <= deferred_frames;
  end


  // --------------------------------------------------------------------------
  // tx carrier sense error frames.
  // counts frames where carrier sense was not seen during transmission
  // Only incremented on half duplex mode
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      crs_errors <= 10'd0;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_crs_errors))
      crs_errors <= {9'd0, tx_crs_err_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_crs_errors)
      crs_errors <= pwdata[9:0];
    else if ((tx_crs_err_pclk | inc_all_stats_regs) & ~(&crs_errors))
      crs_errors <= crs_errors + 10'h001;
    else
      crs_errors <= crs_errors;
  end


  // --------------------------------------------------------------------------
  // Receive Statistics
  // --------------------------------------------------------------------------


  // --------------------------------------------------------------------------
  // Octets received in frame without error
  // This includes destination address, source address, type fields, data
  // and FCS, but excludes preamble, SFD and carrier extension.
  // This counter is split into an upper and lower half.

  // determine when the rx statistics should be incremented
  assign upd_rx_stats = rx_mac_ok_pclk & ok_to_update_rx_stats;

  // calculate next count for bottom counter
  assign octets_rxed_bot_next[32:0] = octets_rxed_bottom[31:0] + {18'd0, rx_bytes_pclk[13:0]};

  // Octets received in frame without error (lower)
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      octets_rxed_bottom <= 32'h00000000;

    // if reset_all_stats_regs or if reading register and no new increment
    // then zero count.
    else if (~upd_rx_stats & (reset_all_stats_regs |
             (read_stats_registers & i_paddr == `gem_octets_rxed_bottom)))
      octets_rxed_bottom <= 32'h00000000;

    // else if reset_all_stats_regs or if reading register and there is
    // a new increment then new count is rx_bytes_pclk.
    else if (upd_rx_stats & (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_octets_rxed_bottom)))
      octets_rxed_bottom <= {18'd0, rx_bytes_pclk[13:0]};

    // else if stats write enabled then allow write to count
    else if (write_registers & stats_write_en & i_paddr == `gem_octets_rxed_bottom)
      octets_rxed_bottom <= pwdata[31:0];

    else if (upd_rx_stats)
    begin
      // else if increment causes an overflow then set to maximum value
      if (octets_rxed_top_next[16])
        octets_rxed_bottom <= 32'hffffffff;
      // else if not overflowing then take on new count value
      else
        octets_rxed_bottom <= octets_rxed_bot_next[31:0];
    end

    // else if inc_all_stats_regs and not overflowing then add 1
    else if (inc_all_stats_regs & ~(&octets_rxed_bottom))
      octets_rxed_bottom <= octets_rxed_bottom + 32'h00000001;

    // else maintain value
    else
      octets_rxed_bottom <= octets_rxed_bottom;
  end


  // determine when the higher count should be incremented
  // do not increment the top counter if the bottom counter
  // is being read and incremented at the same time
  assign inc_octets_rxed_top = upd_rx_stats & octets_rxed_bot_next[32] &
                                 ~(read_stats_registers & i_paddr == `gem_octets_rxed_bottom);

  // calculate next count for top counter
  assign octets_rxed_top_next[16:0] = {1'b0, octets_rxed_top[15:0]} +
                                    {16'h0000, octets_rxed_bot_next[32]};


  // Octets received in frame without error (upper count)
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      octets_rxed_top <= 16'h0000;

    // if reset_all_stats_regs or if reading register and no new increment
    // then zero count, or if incrementing then new count is one.
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_octets_rxed_top))
      octets_rxed_top <= 16'h0000;

    // else if stats write enabled then allow write to count
    else if (write_registers & stats_write_en & i_paddr == `gem_octets_rxed_top)
      octets_rxed_top <= pwdata[15:0];

    // else if increment and already full then set to maximum value
    else if (inc_octets_rxed_top & (&octets_rxed_top))
      octets_rxed_top <= 16'hffff;

    // else if not already full then take on new count value
    else if (inc_octets_rxed_top & ~(&octets_rxed_top))
      octets_rxed_top <= octets_rxed_top_next[15:0];

    // else if inc_all_stats_regs and not already full then add 1
    else if (inc_all_stats_regs & ~(&octets_rxed_top))
      octets_rxed_top <= octets_rxed_top + 16'h0001;

    // else maintain value
    else
      octets_rxed_top <= octets_rxed_top;
  end


  // --------------------------------------------------------------------------
  // frames received OK.
  // counts number of frames successfully received excluding pause frames.
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      frames_rxed_ok <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_frames_rxed_ok))
      frames_rxed_ok <= {31'd0, upd_rx_stats};
    else if (write_registers & stats_write_en & i_paddr == `gem_frames_rxed_ok)
      frames_rxed_ok <= pwdata[31:0];
    else if ((upd_rx_stats | inc_all_stats_regs) & ~(&frames_rxed_ok))
      frames_rxed_ok <= frames_rxed_ok + 32'h00000001;
    else
      frames_rxed_ok <= frames_rxed_ok;
  end


  // --------------------------------------------------------------------------
  // broadcast frames received OK.
  // counts number of broadcast frames successfully received excluding
  // pause frames.
  wire   rx_broadcast_event;
  assign rx_broadcast_event = (rx_broadcast_pclk & upd_rx_stats);
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      broadcast_rxed <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_broadcast_rxed))
      broadcast_rxed <= {31'd0, rx_broadcast_event};
    else if (write_registers & stats_write_en & i_paddr == `gem_broadcast_rxed)
      broadcast_rxed <= pwdata[31:0];
    else if ((rx_broadcast_event | inc_all_stats_regs) &
              ~(&broadcast_rxed))
      broadcast_rxed <= broadcast_rxed + 32'h00000001;
    else
      broadcast_rxed <= broadcast_rxed;
  end


  // --------------------------------------------------------------------------
  // multicast frames received OK.
  // counts number of multicast frames successfully received excluding
  // pause frames.
  wire   rx_multicast_event;
  assign rx_multicast_event = (rx_multicast_pclk & upd_rx_stats);
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      multicast_rxed <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_multicast_rxed))
      multicast_rxed <= {31'd0, rx_multicast_event};
    else if (write_registers & stats_write_en & i_paddr == `gem_multicast_rxed)
      multicast_rxed <= pwdata[31:0];
    else if ((rx_multicast_event | inc_all_stats_regs) &
              ~(&multicast_rxed))
      multicast_rxed <= multicast_rxed + 32'h00000001;
    else
      multicast_rxed <= multicast_rxed;
  end



  // --------------------------------------------------------------------------
  // pause frames received OK.
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      pause_frames_rxed <= 16'h0000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_pause_frames_rxed))
      pause_frames_rxed <= {15'h0000,(rx_pause_ok_pclk)};
    else if (write_registers & stats_write_en & i_paddr == `gem_pause_frames_rxed)
      pause_frames_rxed <= pwdata[15:0];
    else if ((rx_pause_ok_pclk|inc_all_stats_regs) & ~(&pause_frames_rxed))
      pause_frames_rxed <= pause_frames_rxed + 16'h0001;
    else
      pause_frames_rxed <= pause_frames_rxed;
  end


  // --------------------------------------------------------------------------
  // Distribute successfully received frames based on their length.
  // The following length ranges are defined...
  //       64 byte frames
  //   65-127 byte frames
  //  128-255 byte frames
  //  256-511 byte frames
  //  512-1023 byte frames
  // 1024-1518 byte frames
  // over 1519 byte frames

  // detect when exactly 64 bytes in frame
  assign inc_frames_rxed_64   = upd_rx_stats & (rx_bytes_pclk[13:0] == 14'h0040);

  // detect when 1519 or over
  assign inc_frames_rxed_1519 = upd_rx_stats & (rx_bytes_pclk[13:0] > 14'd1518);


  // decode frame size at end of a successful frame
  always @(*)
  begin
    // Defaults
    inc_frames_rxed_65   = 1'b0;
    inc_frames_rxed_128  = 1'b0;
    inc_frames_rxed_256  = 1'b0;
    inc_frames_rxed_512  = 1'b0;
    inc_frames_rxed_1024 = 1'b0;
    if (upd_rx_stats)
    begin
      // case of number of bytes in frame
      casex (rx_bytes_pclk[13:0])
        14'b00_0000_01xx_xxxx: inc_frames_rxed_65   = ~inc_frames_rxed_64;
        14'b00_0000_1xxx_xxxx: inc_frames_rxed_128  = 1'b1;
        14'b00_0001_xxxx_xxxx: inc_frames_rxed_256  = 1'b1;
        14'b00_001x_xxxx_xxxx: inc_frames_rxed_512  = 1'b1;
        default              : inc_frames_rxed_1024 = ~inc_frames_rxed_1519;
      endcase
    end
  end

  // rx frame length of 64
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      frames_rxed_64 <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_frames_rxed_64))
      frames_rxed_64 <= {31'd0, inc_frames_rxed_64};
    else if (write_registers & stats_write_en & i_paddr == `gem_frames_rxed_64)
      frames_rxed_64 <= pwdata[31:0];
    else if ((inc_frames_rxed_64 | inc_all_stats_regs) & ~(&frames_rxed_64))
      frames_rxed_64 <= frames_rxed_64 + 32'h00000001;
    else
      frames_rxed_64 <= frames_rxed_64;
  end

  // rx frame length of 65-127
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      frames_rxed_65 <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_frames_rxed_65))
      frames_rxed_65 <= {31'd0, inc_frames_rxed_65};
    else if (write_registers & stats_write_en & i_paddr == `gem_frames_rxed_65)
      frames_rxed_65 <= pwdata[31:0];
    else if ((inc_frames_rxed_65 | inc_all_stats_regs) & ~(&frames_rxed_65))
      frames_rxed_65 <= frames_rxed_65 + 32'h00000001;
    else
      frames_rxed_65 <= frames_rxed_65;
  end

  // rx frame length of 128-255
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      frames_rxed_128 <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_frames_rxed_128))
      frames_rxed_128 <= {31'd0, inc_frames_rxed_128};
    else if (write_registers & stats_write_en & i_paddr == `gem_frames_rxed_128)
      frames_rxed_128 <= pwdata[31:0];
    else if ((inc_frames_rxed_128 | inc_all_stats_regs) & ~(&frames_rxed_128))
      frames_rxed_128 <= frames_rxed_128 + 32'h00000001;
    else
      frames_rxed_128 <= frames_rxed_128;
  end

  // rx frame length of 256-511
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      frames_rxed_256 <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_frames_rxed_256))
      frames_rxed_256 <= {31'd0, inc_frames_rxed_256};
    else if (write_registers & stats_write_en & i_paddr == `gem_frames_rxed_256)
      frames_rxed_256 <= pwdata[31:0];
    else if ((inc_frames_rxed_256 | inc_all_stats_regs) & ~(&frames_rxed_256))
      frames_rxed_256 <= frames_rxed_256 + 32'h00000001;
    else
      frames_rxed_256 <= frames_rxed_256;
  end

  // rx frame length of 512-1023
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      frames_rxed_512 <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_frames_rxed_512))
      frames_rxed_512 <= {31'd0, inc_frames_rxed_512};
    else if (write_registers & stats_write_en & i_paddr == `gem_frames_rxed_512)
      frames_rxed_512 <= pwdata[31:0];
    else if ((inc_frames_rxed_512 | inc_all_stats_regs) & ~(&frames_rxed_512))
      frames_rxed_512 <= frames_rxed_512 + 32'h00000001;
    else
      frames_rxed_512 <= frames_rxed_512;
  end

  // rx frame length of 1024-1518
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      frames_rxed_1024 <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_frames_rxed_1024))
      frames_rxed_1024 <= {31'd0, inc_frames_rxed_1024};
    else if (write_registers & stats_write_en & i_paddr == `gem_frames_rxed_1024)
      frames_rxed_1024 <= pwdata[31:0];
    else if ((inc_frames_rxed_1024 | inc_all_stats_regs) & ~(&frames_rxed_1024))
      frames_rxed_1024 <= frames_rxed_1024 + 32'h00000001;
    else
      frames_rxed_1024 <= frames_rxed_1024;
  end

  // rx frame length of 1519 or over
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      frames_rxed_1519 <= 32'h00000000;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_frames_rxed_1519))
      frames_rxed_1519 <= {31'd0, inc_frames_rxed_1519};
    else if (write_registers & stats_write_en & i_paddr == `gem_frames_rxed_1519)
      frames_rxed_1519 <= pwdata[31:0];
    else if ((inc_frames_rxed_1519 | inc_all_stats_regs) & ~(&frames_rxed_1519))
      frames_rxed_1519 <= frames_rxed_1519 + 32'h00000001;
    else
      frames_rxed_1519 <= frames_rxed_1519;
  end


  // --------------------------------------------------------------------------
  // short frame statistics.
  // counts the number of frames received under minFrameSize (64 bytes)
  // in length, and do not have other errors associated with them.
  // Additionally in gigabit half duplex mode this counts frames which
  // do not satisfy the minSlotTime (4096 bits) including carrier extension.
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      undersize_frames <= 10'd0;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_undersize_frames))
      undersize_frames <= {9'd0, rx_short_err_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_undersize_frames)
      undersize_frames <= pwdata[9:0];
    else if ((rx_short_err_pclk | inc_all_stats_regs) & ~(&undersize_frames))
      undersize_frames <= undersize_frames + 10'h001;
    else
      undersize_frames <= undersize_frames;
  end


  // --------------------------------------------------------------------------
  // excessive length rx frames.
  // Counts received frames which are over the maximum allowed frame length
  // and do not have CRC, code or alignment errors
  // By default maximum length is set at 1518 bytes, but this can be increased
  // to 1536 bytes or 10 kbytes for rx_1536_en or jumbo modes.
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      excessive_rx_length <= 10'd0;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_excessive_rx_length))
      excessive_rx_length <= {9'd0, rx_long_err_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_excessive_rx_length)
      excessive_rx_length <= pwdata[9:0];
    else if ((rx_long_err_pclk | inc_all_stats_regs) & ~(&excessive_rx_length))
      excessive_rx_length <= excessive_rx_length + 10'h001;
    else
      excessive_rx_length <= excessive_rx_length;
  end


  // --------------------------------------------------------------------------
  // rx jabber statistics - long bad frames.
  // Counts number of received frames which are too long and have bad CRC,
  // alignment or code error.
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      rx_jabbers <= 10'd0;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_rx_jabbers))
      rx_jabbers <= {9'd0, rx_jabber_err_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_rx_jabbers)
      rx_jabbers <= pwdata[9:0];
    else if ((rx_jabber_err_pclk | inc_all_stats_regs) & ~(&rx_jabbers))
      rx_jabbers <= rx_jabbers + 10'h001;
    else
      rx_jabbers <= rx_jabbers;
  end


  // --------------------------------------------------------------------------
  // frame check sequence errors.
  // Count frames with bad CRC and of correct length/alignment
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      fcs_errors <= 10'd0;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_fcs_errors))
      fcs_errors <= {9'd0, rx_crc_err_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_fcs_errors)
      fcs_errors <= pwdata[9:0];
    else if ((rx_crc_err_pclk | inc_all_stats_regs) & ~(&fcs_errors))
      fcs_errors <= fcs_errors + 10'h001;
    else
      fcs_errors <= fcs_errors;
  end


  // --------------------------------------------------------------------------
  // rx length field error statistics.
  // counts frames that are of valid length but have a mismatch between
  // the length field and the measured length. The length field is only valid
  // if greater than or equal to 0x600.
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      rx_length_errors <= 10'd0;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_rx_length_errors))
      rx_length_errors <= {9'd0, rx_length_err_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_rx_length_errors)
      rx_length_errors <= pwdata[9:0];
    else if ((rx_length_err_pclk | inc_all_stats_regs) & ~(&rx_length_errors))
      rx_length_errors <= rx_length_errors + 10'h001;
    else
      rx_length_errors <= rx_length_errors;
  end


  // --------------------------------------------------------------------------
  // Receive symbol error frames.
  // Counts the number of frames that have a code/symbol error in them
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      rx_symbol_errors <= 10'd0;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_rx_symbol_errors))
      rx_symbol_errors <= {9'd0, rx_symbol_err_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_rx_symbol_errors)
      rx_symbol_errors <= pwdata[9:0];
    else if ((rx_symbol_err_pclk | inc_all_stats_regs) & ~(&rx_symbol_errors))
      rx_symbol_errors <= rx_symbol_errors + 10'h001;
    else
      rx_symbol_errors <= rx_symbol_errors;
  end


  // --------------------------------------------------------------------------
  // alignment errors.
  // counts frames that do not have an integral number of bytes and also
  // have bad CRC, but are correct length.
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      alignment_errors <= 10'd0;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_alignment_errors))
      alignment_errors <= {9'd0, rx_align_err_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_alignment_errors)
      alignment_errors <= pwdata[9:0];
    else if ((rx_align_err_pclk | inc_all_stats_regs) & ~(&alignment_errors))
      alignment_errors <= alignment_errors + 10'h001;
    else
      alignment_errors <= alignment_errors;
  end


  // --------------------------------------------------------------------------
  // Rx resource_error
  // counts frames that are not stored correctly in the DMA due to no
  // rx buffer being available.
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      rx_resource_errors <= 18'd0;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_rx_resource_errors))
      rx_resource_errors <= {17'd0, rx_resource_err_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_rx_resource_errors)
      rx_resource_errors <= pwdata[17:0];
    else if ((rx_resource_err_pclk | inc_all_stats_regs) & ~(&rx_resource_errors))
      rx_resource_errors <= rx_resource_errors + 18'h00001;
    else
      rx_resource_errors <= rx_resource_errors;
  end


  // --------------------------------------------------------------------------
  // receive overrun errors.
  // counts frames that are not stored correctly in the DMA due to an
  // overrun of the DMA FIFOs or the RX pipeline.
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      rx_overruns <= 10'd0;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_rx_overruns))
      rx_overruns <= {9'd0, rx_overflow_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_rx_overruns)
      rx_overruns <= pwdata[9:0];
    else if ((rx_overflow_pclk | inc_all_stats_regs) & ~(&rx_overruns))
      rx_overruns <= rx_overruns + 10'h001;
    else
      rx_overruns <= rx_overruns;
  end


  // --------------------------------------------------------------------------
  // receive IP header checksum errors.
  // counts frames that are bad due to an IP header checksum error.
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      rx_ip_ck_errors <= 8'h00;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_rx_ip_ck_errors))
      rx_ip_ck_errors <= {7'h00, rx_ip_ck_err_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_rx_ip_ck_errors)
      rx_ip_ck_errors <= pwdata[7:0];
    else if ((rx_ip_ck_err_pclk | inc_all_stats_regs) & ~(&rx_ip_ck_errors))
      rx_ip_ck_errors <= rx_ip_ck_errors + 8'h01;
    else
      rx_ip_ck_errors <= rx_ip_ck_errors;
  end


  // --------------------------------------------------------------------------
  // receive TCP checksum errors.
  // counts frames that are bad due to a TCP checksum error.
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      rx_tcp_ck_errors <= 8'h00;
    else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_rx_tcp_ck_errors))
      rx_tcp_ck_errors <= {7'h00, rx_tcp_ck_err_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_rx_tcp_ck_errors)
      rx_tcp_ck_errors <= pwdata[7:0];
    else if ((rx_tcp_ck_err_pclk | inc_all_stats_regs) & ~(&rx_tcp_ck_errors))
      rx_tcp_ck_errors <= rx_tcp_ck_errors + 8'h01;
    else
      rx_tcp_ck_errors <= rx_tcp_ck_errors;
  end


  // --------------------------------------------------------------------------
  // receive UDP checksum errors.
  // counts frames that are bad due to a UDP checksum error.
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      rx_udp_ck_errors <= 8'h00;
    else if (reset_all_stats_regs |
              (read_stats_registers & (i_paddr == `gem_rx_udp_ck_errors)))
      rx_udp_ck_errors <= {7'h00, rx_udp_ck_err_pclk};
    else if (write_registers & stats_write_en & i_paddr == `gem_rx_udp_ck_errors)
      rx_udp_ck_errors <= pwdata[7:0];
    else if ((rx_udp_ck_err_pclk | inc_all_stats_regs) & ~(&rx_udp_ck_errors))
      rx_udp_ck_errors <= rx_udp_ck_errors + 8'h01;
    else
      rx_udp_ck_errors <= rx_udp_ck_errors;
  end


  generate if (p_edma_rx_pkt_buffer == 1) begin : gen_flush_pkt_cnt
    // Flushed RX DMA packet counter
    // counts frames that are flushed due to AHB resource error
    reg [15:0] rx_auto_flushed_pkts_r;
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        rx_auto_flushed_pkts_r <= 16'h0000;
      else if (reset_all_stats_regs |
              (read_stats_registers & i_paddr == `gem_auto_flushed_pkts))
        rx_auto_flushed_pkts_r <= {15'h0000, (rx_dma_pkt_flushed_pclk | frame_flushed_pclk)};
      else if (write_registers & stats_write_en & i_paddr == `gem_auto_flushed_pkts)
        rx_auto_flushed_pkts_r <= pwdata[15:0];
      else if ((rx_dma_pkt_flushed_pclk | frame_flushed_pclk | inc_all_stats_regs) &
             ~(&rx_auto_flushed_pkts_r))
        rx_auto_flushed_pkts_r <= rx_auto_flushed_pkts_r + 16'h0001;
      else
        rx_auto_flushed_pkts_r <= rx_auto_flushed_pkts_r;
    end
    assign rx_auto_flushed_pkts = rx_auto_flushed_pkts_r;
  end else begin : gen_no_flush_pkt_cnt
    assign rx_auto_flushed_pkts = 16'h0000;
  end
  endgenerate

  //------------------------------------------------------------------------------
  // LPI statistics
  //------------------------------------------------------------------------------

  // count rx lpi indicate transitions to high
  wire   lpi_indicate_event;
  assign lpi_indicate_event = (lpi_indicate_pclk & ~lpi_indicate_del);
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      rx_lpi_count <= 16'h0000;
    else if (reset_all_stats_regs |
              (read_stats_registers & (i_paddr == `gem_rx_lpi)))
      rx_lpi_count <= {15'h0000, lpi_indicate_event};
    else if (write_registers & stats_write_en & i_paddr == `gem_rx_lpi)
      rx_lpi_count <= pwdata[15:0];
    else if ((lpi_indicate_event | inc_all_stats_regs) &
              ~(&rx_lpi_count))
      rx_lpi_count <= rx_lpi_count + 16'h0001;
    else
      rx_lpi_count <= rx_lpi_count;
  end

  // delay tx_lpi_en for edge detect
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      tx_lpi_en_del <= 1'b0;
    else
      tx_lpi_en_del <= tx_lpi_en;
  end

  // count tx lpi transitions
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      tx_lpi_count <= 16'h0000;
    else if (reset_all_stats_regs |
              (read_stats_registers & (i_paddr == `gem_tx_lpi)))
      tx_lpi_count <= {15'h0000, (tx_lpi_en & ~tx_lpi_en_del)};
    else if (write_registers & stats_write_en & i_paddr == `gem_tx_lpi)
      tx_lpi_count <= pwdata[15:0];
    else if (((tx_lpi_en & ~tx_lpi_en_del) | inc_all_stats_regs) &
              ~(&tx_lpi_count))
      tx_lpi_count <= tx_lpi_count + 16'h0001;
    else
      tx_lpi_count <= tx_lpi_count;
  end

  // count pclk to slow down lpi counters
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      pclk_cnt <= 4'h0;
    else
      pclk_cnt <= pclk_cnt + 4'h1;
  end

  // count time rx lpi_indicate is high
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      rx_lpi_asserted <= 24'h000000;
    else
      if ((i_paddr == `gem_rx_lpi_time) & read_registers)
        rx_lpi_asserted <= 24'h000000;
      else if ((pclk_cnt == 4'h0) & lpi_indicate_pclk)
        rx_lpi_asserted <= rx_lpi_asserted + 24'h000001;
  end

  // count time tx lpi_en is high
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      tx_lpi_asserted <= 24'h000000;
    else
      if ((i_paddr == `gem_tx_lpi_time) & read_registers)
        tx_lpi_asserted <= 24'h000000;
      else if ((pclk_cnt == 4'h0) & tx_lpi_en)
        tx_lpi_asserted <= tx_lpi_asserted + 24'h000001;
  end

  //------------------------------------------------------------------------------
  // statistics snapshot.
  //------------------------------------------------------------------------------

  // Snapshot statistic registers
  // Assigned to snapshot register value if exists otherwise tied to 0.
  wire  [31:0]  s_octets_txed_bottom;
  wire  [15:0]  s_octets_txed_top;
  wire  [31:0]  s_frames_txed_ok;
  wire  [31:0]  s_broadcast_txed;
  wire  [31:0]  s_multicast_txed;
  wire  [15:0]  s_pause_frames_txed;
  wire  [31:0]  s_frames_txed_64;
  wire  [31:0]  s_frames_txed_65;
  wire  [31:0]  s_frames_txed_128;
  wire  [31:0]  s_frames_txed_256;
  wire  [31:0]  s_frames_txed_512;
  wire  [31:0]  s_frames_txed_1024;
  wire  [31:0]  s_frames_txed_1519;
  wire  [9:0]   s_tx_underruns;
  wire  [17:0]  s_single_collisions;
  wire  [17:0]  s_multiple_colls;
  wire  [9:0]   s_excessive_colls;
  wire  [9:0]   s_late_collisions;
  wire  [17:0]  s_deferred_frames;
  wire  [9:0]   s_crs_errors;
  wire  [31:0]  s_octets_rxed_bottom;
  wire  [15:0]  s_octets_rxed_top;
  wire  [31:0]  s_frames_rxed_ok;
  wire  [31:0]  s_broadcast_rxed;
  wire  [31:0]  s_multicast_rxed;
  wire  [15:0]  s_pause_frames_rxed;
  wire  [31:0]  s_frames_rxed_64;
  wire  [31:0]  s_frames_rxed_65;
  wire  [31:0]  s_frames_rxed_128;
  wire  [31:0]  s_frames_rxed_256;
  wire  [31:0]  s_frames_rxed_512;
  wire  [31:0]  s_frames_rxed_1024;
  wire  [31:0]  s_frames_rxed_1519;
  wire  [9:0]   s_undersize_frames;
  wire  [9:0]   s_excessive_rx_lngth;
  wire  [9:0]   s_rx_jabbers;
  wire  [9:0]   s_fcs_errors;
  wire  [9:0]   s_rx_length_errors;
  wire  [9:0]   s_rx_symbol_errors;
  wire  [9:0]   s_alignment_errors;
  wire  [17:0]  s_rx_resource_errors;
  wire  [9:0]   s_rx_overruns;
  wire  [7:0]   s_rx_ip_ck_errors;
  wire  [7:0]   s_rx_tcp_ck_errors;
  wire  [7:0]   s_rx_udp_ck_errors;
  wire  [15:0]  s_rx_auto_flushed_pkts;


  generate if (p_edma_no_snapshot == 1) begin : gen_no_snapshot_stats

    // No snapshot statistic registers required so tie to zero
    assign s_octets_txed_bottom = 32'h00000000;
    assign s_octets_txed_top    = 16'h0000;
    assign s_frames_txed_ok     = 32'h00000000;
    assign s_broadcast_txed     = 32'h00000000;
    assign s_multicast_txed     = 32'h00000000;
    assign s_pause_frames_txed  = 16'h0000;
    assign s_frames_txed_64     = 32'h00000000;
    assign s_frames_txed_65     = 32'h00000000;
    assign s_frames_txed_128    = 32'h00000000;
    assign s_frames_txed_256    = 32'h00000000;
    assign s_frames_txed_512    = 32'h00000000;
    assign s_frames_txed_1024   = 32'h00000000;
    assign s_frames_txed_1519   = 32'h00000000;
    assign s_tx_underruns       = 10'h000;
    assign s_single_collisions  = 18'h00000;
    assign s_multiple_colls     = 18'h00000;
    assign s_excessive_colls    = 10'h000;
    assign s_late_collisions    = 10'h000;
    assign s_deferred_frames    = 18'h00000;
    assign s_crs_errors         = 10'h000;
    assign s_octets_rxed_bottom = 32'h00000000;
    assign s_octets_rxed_top    = 16'h0000;
    assign s_frames_rxed_ok     = 32'h00000000;
    assign s_broadcast_rxed     = 32'h00000000;
    assign s_multicast_rxed     = 32'h00000000;
    assign s_pause_frames_rxed  = 16'h0000;
    assign s_frames_rxed_64     = 32'h00000000;
    assign s_frames_rxed_65     = 32'h00000000;
    assign s_frames_rxed_128    = 32'h00000000;
    assign s_frames_rxed_256    = 32'h00000000;
    assign s_frames_rxed_512    = 32'h00000000;
    assign s_frames_rxed_1024   = 32'h00000000;
    assign s_frames_rxed_1519   = 32'h00000000;
    assign s_undersize_frames   = 10'h000;
    assign s_excessive_rx_lngth = 10'h000;
    assign s_rx_jabbers         = 10'h000;
    assign s_fcs_errors         = 10'h000;
    assign s_rx_length_errors   = 10'h000;
    assign s_rx_symbol_errors   = 10'h000;
    assign s_alignment_errors   = 10'h000;
    assign s_rx_resource_errors = 18'h00000;
    assign s_rx_overruns        = 10'h000;
    assign s_rx_ip_ck_errors    = 8'h00;
    assign s_rx_tcp_ck_errors   = 8'h00;
    assign s_rx_udp_ck_errors   = 8'h00;
    assign s_rx_auto_flushed_pkts= 16'h0000;

  end else begin : gen_snapshot_stats

    // Snapshot registers
    reg   [31:0]  sr_octets_txed_bottom;
    reg   [15:0]  sr_octets_txed_top;
    reg   [31:0]  sr_frames_txed_ok;
    reg   [31:0]  sr_broadcast_txed;
    reg   [31:0]  sr_multicast_txed;
    reg   [15:0]  sr_pause_frames_txed;
    reg   [31:0]  sr_frames_txed_64;
    reg   [31:0]  sr_frames_txed_65;
    reg   [31:0]  sr_frames_txed_128;
    reg   [31:0]  sr_frames_txed_256;
    reg   [31:0]  sr_frames_txed_512;
    reg   [31:0]  sr_frames_txed_1024;
    reg   [31:0]  sr_frames_txed_1519;
    reg   [9:0]   sr_tx_underruns;
    reg   [17:0]  sr_single_collisions;
    reg   [17:0]  sr_multiple_colls;
    reg   [9:0]   sr_excessive_colls;
    reg   [9:0]   sr_late_collisions;
    reg   [17:0]  sr_deferred_frames;
    reg   [9:0]   sr_crs_errors;
    reg   [31:0]  sr_octets_rxed_bottom;
    reg   [15:0]  sr_octets_rxed_top;
    reg   [31:0]  sr_frames_rxed_ok;
    reg   [31:0]  sr_broadcast_rxed;
    reg   [31:0]  sr_multicast_rxed;
    reg   [15:0]  sr_pause_frames_rxed;
    reg   [31:0]  sr_frames_rxed_64;
    reg   [31:0]  sr_frames_rxed_65;
    reg   [31:0]  sr_frames_rxed_128;
    reg   [31:0]  sr_frames_rxed_256;
    reg   [31:0]  sr_frames_rxed_512;
    reg   [31:0]  sr_frames_rxed_1024;
    reg   [31:0]  sr_frames_rxed_1519;
    reg   [9:0]   sr_undersize_frames;
    reg   [9:0]   sr_excessive_rx_lngth;
    reg   [9:0]   sr_rx_jabbers;
    reg   [9:0]   sr_fcs_errors;
    reg   [9:0]   sr_rx_length_errors;
    reg   [9:0]   sr_rx_symbol_errors;
    reg   [9:0]   sr_alignment_errors;
    reg   [17:0]  sr_rx_resource_errors;
    reg   [9:0]   sr_rx_overruns;
    reg   [7:0]   sr_rx_ip_ck_errors;
    reg   [7:0]   sr_rx_tcp_ck_errors;
    reg   [7:0]   sr_rx_udp_ck_errors;
    reg   [15:0]  sr_rx_auto_flushed_pkts;

    // Take snapshot when instructed
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
      begin
        sr_octets_txed_bottom <= 32'h00000000;
        sr_octets_txed_top    <= 16'h0000;
        sr_frames_txed_ok     <= 32'h00000000;
        sr_broadcast_txed     <= 32'h00000000;
        sr_multicast_txed     <= 32'h00000000;
        sr_pause_frames_txed  <= 16'h0000;
        sr_frames_txed_64     <= 32'h00000000;
        sr_frames_txed_65     <= 32'h00000000;
        sr_frames_txed_128    <= 32'h00000000;
        sr_frames_txed_256    <= 32'h00000000;
        sr_frames_txed_512    <= 32'h00000000;
        sr_frames_txed_1024   <= 32'h00000000;
        sr_frames_txed_1519   <= 32'h00000000;
        sr_tx_underruns       <= 10'h000;
        sr_single_collisions  <= 18'h00000;
        sr_multiple_colls     <= 18'h00000;
        sr_excessive_colls    <= 10'h000;
        sr_late_collisions    <= 10'h000;
        sr_deferred_frames    <= 18'h00000;
        sr_crs_errors         <= 10'h000;
        sr_octets_rxed_bottom <= 32'h00000000;
        sr_octets_rxed_top    <= 16'h0000;
        sr_frames_rxed_ok     <= 32'h00000000;
        sr_broadcast_rxed     <= 32'h00000000;
        sr_multicast_rxed     <= 32'h00000000;
        sr_pause_frames_rxed  <= 16'h0000;
        sr_frames_rxed_64     <= 32'h00000000;
        sr_frames_rxed_65     <= 32'h00000000;
        sr_frames_rxed_128    <= 32'h00000000;
        sr_frames_rxed_256    <= 32'h00000000;
        sr_frames_rxed_512    <= 32'h00000000;
        sr_frames_rxed_1024   <= 32'h00000000;
        sr_frames_rxed_1519   <= 32'h00000000;
        sr_undersize_frames   <= 10'h000;
        sr_excessive_rx_lngth <= 10'h000;
        sr_rx_jabbers         <= 10'h000;
        sr_fcs_errors         <= 10'h000;
        sr_rx_length_errors   <= 10'h000;
        sr_rx_symbol_errors   <= 10'h000;
        sr_alignment_errors   <= 10'h000;
        sr_rx_resource_errors <= 18'h00000;
        sr_rx_overruns        <= 10'h000;
        sr_rx_ip_ck_errors    <= 8'h00;
        sr_rx_tcp_ck_errors   <= 8'h00;
        sr_rx_udp_ck_errors   <= 8'h00;
        sr_rx_auto_flushed_pkts  <= 16'h0000;
      end
      else if (stats_take_snap)
      begin
        sr_octets_txed_bottom <= octets_txed_bottom;
        sr_octets_txed_top    <= octets_txed_top;
        sr_frames_txed_ok     <= frames_txed_ok;
        sr_broadcast_txed     <= broadcast_txed;
        sr_multicast_txed     <= multicast_txed;
        sr_pause_frames_txed  <= pause_frames_txed;
        sr_frames_txed_64     <= frames_txed_64;
        sr_frames_txed_65     <= frames_txed_65;
        sr_frames_txed_128    <= frames_txed_128;
        sr_frames_txed_256    <= frames_txed_256;
        sr_frames_txed_512    <= frames_txed_512;
        sr_frames_txed_1024   <= frames_txed_1024;
        sr_frames_txed_1519   <= frames_txed_1519;
        sr_tx_underruns       <= tx_underruns;
        sr_single_collisions  <= single_collisions;
        sr_multiple_colls     <= multiple_collisions;
        sr_excessive_colls    <= excessive_collisions;
        sr_late_collisions    <= late_collisions;
        sr_deferred_frames    <= deferred_frames;
        sr_crs_errors         <= crs_errors;
        sr_octets_rxed_bottom <= octets_rxed_bottom;
        sr_octets_rxed_top    <= octets_rxed_top;
        sr_frames_rxed_ok     <= frames_rxed_ok;
        sr_broadcast_rxed     <= broadcast_rxed;
        sr_multicast_rxed     <= multicast_rxed;
        sr_pause_frames_rxed  <= pause_frames_rxed;
        sr_frames_rxed_64     <= frames_rxed_64;
        sr_frames_rxed_65     <= frames_rxed_65;
        sr_frames_rxed_128    <= frames_rxed_128;
        sr_frames_rxed_256    <= frames_rxed_256;
        sr_frames_rxed_512    <= frames_rxed_512;
        sr_frames_rxed_1024   <= frames_rxed_1024;
        sr_frames_rxed_1519   <= frames_rxed_1519;
        sr_undersize_frames   <= undersize_frames;
        sr_excessive_rx_lngth <= excessive_rx_length;
        sr_rx_jabbers         <= rx_jabbers;
        sr_fcs_errors         <= fcs_errors;
        sr_rx_length_errors   <= rx_length_errors;
        sr_rx_symbol_errors   <= rx_symbol_errors;
        sr_alignment_errors   <= alignment_errors;
        sr_rx_resource_errors <= rx_resource_errors;
        sr_rx_overruns        <= rx_overruns;
        sr_rx_ip_ck_errors    <= rx_ip_ck_errors;
        sr_rx_tcp_ck_errors   <= rx_tcp_ck_errors;
        sr_rx_udp_ck_errors   <= rx_udp_ck_errors;
        sr_rx_auto_flushed_pkts <= rx_auto_flushed_pkts;
      end
    end

    // Assign registers to the wires
    assign s_octets_txed_bottom   = sr_octets_txed_bottom;
    assign s_octets_txed_top      = sr_octets_txed_top;
    assign s_frames_txed_ok       = sr_frames_txed_ok;
    assign s_broadcast_txed       = sr_broadcast_txed;
    assign s_multicast_txed       = sr_multicast_txed;
    assign s_pause_frames_txed    = sr_pause_frames_txed;
    assign s_frames_txed_64       = sr_frames_txed_64;
    assign s_frames_txed_65       = sr_frames_txed_65;
    assign s_frames_txed_128      = sr_frames_txed_128;
    assign s_frames_txed_256      = sr_frames_txed_256;
    assign s_frames_txed_512      = sr_frames_txed_512;
    assign s_frames_txed_1024     = sr_frames_txed_1024;
    assign s_frames_txed_1519     = sr_frames_txed_1519;
    assign s_tx_underruns         = sr_tx_underruns;
    assign s_single_collisions    = sr_single_collisions;
    assign s_multiple_colls       = sr_multiple_colls;
    assign s_excessive_colls      = sr_excessive_colls;
    assign s_late_collisions      = sr_late_collisions;
    assign s_deferred_frames      = sr_deferred_frames;
    assign s_crs_errors           = sr_crs_errors;
    assign s_octets_rxed_bottom   = sr_octets_rxed_bottom;
    assign s_octets_rxed_top      = sr_octets_rxed_top;
    assign s_frames_rxed_ok       = sr_frames_rxed_ok;
    assign s_broadcast_rxed       = sr_broadcast_rxed;
    assign s_multicast_rxed       = sr_multicast_rxed;
    assign s_pause_frames_rxed    = sr_pause_frames_rxed;
    assign s_frames_rxed_64       = sr_frames_rxed_64;
    assign s_frames_rxed_65       = sr_frames_rxed_65;
    assign s_frames_rxed_128      = sr_frames_rxed_128;
    assign s_frames_rxed_256      = sr_frames_rxed_256;
    assign s_frames_rxed_512      = sr_frames_rxed_512;
    assign s_frames_rxed_1024     = sr_frames_rxed_1024;
    assign s_frames_rxed_1519     = sr_frames_rxed_1519;
    assign s_undersize_frames     = sr_undersize_frames;
    assign s_excessive_rx_lngth   = sr_excessive_rx_lngth;
    assign s_rx_jabbers           = sr_rx_jabbers;
    assign s_fcs_errors           = sr_fcs_errors;
    assign s_rx_length_errors     = sr_rx_length_errors;
    assign s_rx_symbol_errors     = sr_rx_symbol_errors;
    assign s_alignment_errors     = sr_alignment_errors;
    assign s_rx_resource_errors   = sr_rx_resource_errors;
    assign s_rx_overruns          = sr_rx_overruns;
    assign s_rx_ip_ck_errors      = sr_rx_ip_ck_errors;
    assign s_rx_tcp_ck_errors     = sr_rx_tcp_ck_errors;
    assign s_rx_udp_ck_errors     = sr_rx_udp_ck_errors;
    assign s_rx_auto_flushed_pkts = sr_rx_auto_flushed_pkts;
  end
  endgenerate

  // Assign values for APB read. This is either the real statistics or the
  // snapshot value if stats_read_snap is high.
  always @(*)
  begin
    if (stats_read_snap)
    begin
      r_octets_txed_bottom = s_octets_txed_bottom;
      r_octets_txed_top    = s_octets_txed_top;
      r_frames_txed_ok     = s_frames_txed_ok;
      r_broadcast_txed     = s_broadcast_txed;
      r_multicast_txed     = s_multicast_txed;
      r_pause_frames_txed  = s_pause_frames_txed;
      r_frames_txed_64     = s_frames_txed_64;
      r_frames_txed_65     = s_frames_txed_65;
      r_frames_txed_128    = s_frames_txed_128;
      r_frames_txed_256    = s_frames_txed_256;
      r_frames_txed_512    = s_frames_txed_512;
      r_frames_txed_1024   = s_frames_txed_1024;
      r_frames_txed_1519   = s_frames_txed_1519;
      r_tx_underruns       = s_tx_underruns;
      r_single_collisions  = s_single_collisions;
      r_multiple_colls     = s_multiple_colls;
      r_excessive_colls    = s_excessive_colls;
      r_late_collisions    = s_late_collisions;
      r_deferred_frames    = s_deferred_frames;
      r_crs_errors         = s_crs_errors;
      r_octets_rxed_bottom = s_octets_rxed_bottom;
      r_octets_rxed_top    = s_octets_rxed_top;
      r_frames_rxed_ok     = s_frames_rxed_ok;
      r_broadcast_rxed     = s_broadcast_rxed;
      r_multicast_rxed     = s_multicast_rxed;
      r_pause_frames_rxed  = s_pause_frames_rxed;
      r_frames_rxed_64     = s_frames_rxed_64;
      r_frames_rxed_65     = s_frames_rxed_65;
      r_frames_rxed_128    = s_frames_rxed_128;
      r_frames_rxed_256    = s_frames_rxed_256;
      r_frames_rxed_512    = s_frames_rxed_512;
      r_frames_rxed_1024   = s_frames_rxed_1024;
      r_frames_rxed_1519   = s_frames_rxed_1519;
      r_undersize_frames   = s_undersize_frames;
      r_excessive_rx_lngth = s_excessive_rx_lngth;
      r_rx_jabbers         = s_rx_jabbers;
      r_fcs_errors         = s_fcs_errors;
      r_rx_length_errors   = s_rx_length_errors;
      r_rx_symbol_errors   = s_rx_symbol_errors;
      r_alignment_errors   = s_alignment_errors;
      r_rx_resource_errors = s_rx_resource_errors;
      r_rx_overruns        = s_rx_overruns;
      r_rx_ip_ck_errors    = s_rx_ip_ck_errors;
      r_rx_tcp_ck_errors   = s_rx_tcp_ck_errors;
      r_rx_udp_ck_errors   = s_rx_udp_ck_errors;
      r_rx_auto_flushed_pkts = s_rx_auto_flushed_pkts;
    end
    else
    begin
      r_octets_txed_bottom = octets_txed_bottom;
      r_octets_txed_top    = octets_txed_top;
      r_frames_txed_ok     = frames_txed_ok;
      r_broadcast_txed     = broadcast_txed;
      r_multicast_txed     = multicast_txed;
      r_pause_frames_txed  = pause_frames_txed;
      r_frames_txed_64     = frames_txed_64;
      r_frames_txed_65     = frames_txed_65;
      r_frames_txed_128    = frames_txed_128;
      r_frames_txed_256    = frames_txed_256;
      r_frames_txed_512    = frames_txed_512;
      r_frames_txed_1024   = frames_txed_1024;
      r_frames_txed_1519   = frames_txed_1519;
      r_tx_underruns       = tx_underruns;
      r_single_collisions  = single_collisions;
      r_multiple_colls     = multiple_collisions;
      r_excessive_colls    = excessive_collisions;
      r_late_collisions    = late_collisions;
      r_deferred_frames    = deferred_frames;
      r_crs_errors         = crs_errors;
      r_octets_rxed_bottom = octets_rxed_bottom;
      r_octets_rxed_top    = octets_rxed_top;
      r_frames_rxed_ok     = frames_rxed_ok;
      r_broadcast_rxed     = broadcast_rxed;
      r_multicast_rxed     = multicast_rxed;
      r_pause_frames_rxed  = pause_frames_rxed;
      r_frames_rxed_64     = frames_rxed_64;
      r_frames_rxed_65     = frames_rxed_65;
      r_frames_rxed_128    = frames_rxed_128;
      r_frames_rxed_256    = frames_rxed_256;
      r_frames_rxed_512    = frames_rxed_512;
      r_frames_rxed_1024   = frames_rxed_1024;
      r_frames_rxed_1519   = frames_rxed_1519;
      r_undersize_frames   = undersize_frames;
      r_excessive_rx_lngth = excessive_rx_length;
      r_rx_jabbers         = rx_jabbers;
      r_fcs_errors         = fcs_errors;
      r_rx_length_errors   = rx_length_errors;
      r_rx_symbol_errors   = rx_symbol_errors;
      r_alignment_errors   = alignment_errors;
      r_rx_resource_errors = rx_resource_errors;
      r_rx_overruns        = rx_overruns;
      r_rx_ip_ck_errors    = rx_ip_ck_errors;
      r_rx_tcp_ck_errors   = rx_tcp_ck_errors;
      r_rx_udp_ck_errors   = rx_udp_ck_errors;
      r_rx_auto_flushed_pkts = rx_auto_flushed_pkts;
    end
  end


  // The LPI count stats do not have snapshot capability
  assign r_rx_lpi_count      = rx_lpi_count;
  assign r_tx_lpi_count      = tx_lpi_count;
  assign r_rx_lpi_asserted   = rx_lpi_asserted;
  assign r_tx_lpi_asserted   = tx_lpi_asserted;


  // APB read of statistics registers.
  // The prdata_stats should be registered externally.
  always @(*)
  begin
    if (read_registers)
      case (i_paddr)
        `gem_octets_txed_bottom   : prdata_stats  = r_octets_txed_bottom[31:0];
        `gem_octets_txed_top      : prdata_stats  = {16'h0000,r_octets_txed_top[15:0]};
        `gem_frames_txed_ok       : prdata_stats  = r_frames_txed_ok[31:0];
        `gem_broadcast_txed       : prdata_stats  = r_broadcast_txed[31:0];
        `gem_multicast_txed       : prdata_stats  = r_multicast_txed[31:0];
        `gem_pause_frames_txed    : prdata_stats  = {16'h0000,r_pause_frames_txed[15:0]};
        `gem_frames_txed_64       : prdata_stats  = r_frames_txed_64[31:0];
        `gem_frames_txed_65       : prdata_stats  = r_frames_txed_65[31:0];
        `gem_frames_txed_128      : prdata_stats  = r_frames_txed_128[31:0];
        `gem_frames_txed_256      : prdata_stats  = r_frames_txed_256[31:0];
        `gem_frames_txed_512      : prdata_stats  = r_frames_txed_512[31:0];
        `gem_frames_txed_1024     : prdata_stats  = r_frames_txed_1024[31:0];
        `gem_frames_txed_1519     : prdata_stats  = r_frames_txed_1519[31:0];
        `gem_tx_underruns         : prdata_stats  = {22'd0,r_tx_underruns[9:0]};
        `gem_single_collisions    : prdata_stats  = {14'd0,r_single_collisions[17:0]};
        `gem_multiple_collisions  : prdata_stats  = {14'd0,r_multiple_colls[17:0]};
        `gem_excessive_collisions : prdata_stats  = {22'd0,r_excessive_colls[9:0]};
        `gem_late_collisions      : prdata_stats  = {22'd0,r_late_collisions[9:0]};
        `gem_deferred_frames      : prdata_stats  = {14'd0,r_deferred_frames[17:0]};
        `gem_crs_errors           : prdata_stats  = {22'd0,r_crs_errors[9:0]};
        `gem_octets_rxed_bottom   : prdata_stats  = r_octets_rxed_bottom[31:0];
        `gem_octets_rxed_top      : prdata_stats  = {16'h0000,r_octets_rxed_top[15:0]};
        `gem_frames_rxed_ok       : prdata_stats  = r_frames_rxed_ok[31:0];
        `gem_broadcast_rxed       : prdata_stats  = r_broadcast_rxed[31:0];
        `gem_multicast_rxed       : prdata_stats  = r_multicast_rxed[31:0];
        `gem_pause_frames_rxed    : prdata_stats  = {16'h0000,r_pause_frames_rxed[15:0]};
        `gem_frames_rxed_64       : prdata_stats  = r_frames_rxed_64[31:0];
        `gem_frames_rxed_65       : prdata_stats  = r_frames_rxed_65[31:0];
        `gem_frames_rxed_128      : prdata_stats  = r_frames_rxed_128[31:0];
        `gem_frames_rxed_256      : prdata_stats  = r_frames_rxed_256[31:0];
        `gem_frames_rxed_512      : prdata_stats  = r_frames_rxed_512[31:0];
        `gem_frames_rxed_1024     : prdata_stats  = r_frames_rxed_1024[31:0];
        `gem_frames_rxed_1519     : prdata_stats  = r_frames_rxed_1519[31:0];
        `gem_undersize_frames     : prdata_stats  = {22'd0,r_undersize_frames[9:0]};
        `gem_excessive_rx_length  : prdata_stats  = {22'd0,r_excessive_rx_lngth[9:0]};
        `gem_rx_jabbers           : prdata_stats  = {22'd0,r_rx_jabbers[9:0]};
        `gem_fcs_errors           : prdata_stats  = {22'd0,r_fcs_errors[9:0]};
        `gem_rx_length_errors     : prdata_stats  = {22'd0,r_rx_length_errors[9:0]};
        `gem_rx_symbol_errors     : prdata_stats  = {22'd0,r_rx_symbol_errors[9:0]};
        `gem_alignment_errors     : prdata_stats  = {22'd0,r_alignment_errors[9:0]};
        `gem_rx_resource_errors   : prdata_stats  = {14'd0,r_rx_resource_errors[17:0]};
        `gem_rx_overruns          : prdata_stats  = {22'd0,r_rx_overruns[9:0]};
        `gem_rx_ip_ck_errors      : prdata_stats  = {24'd0,r_rx_ip_ck_errors[7:0]};
        `gem_rx_tcp_ck_errors     : prdata_stats  = {24'd0,r_rx_tcp_ck_errors[7:0]};
        `gem_rx_udp_ck_errors     : prdata_stats  = {24'd0,r_rx_udp_ck_errors[7:0]};
        `gem_auto_flushed_pkts    : prdata_stats  = {16'h0000,r_rx_auto_flushed_pkts[15:0]};
        `gem_rx_lpi               : prdata_stats  = {16'h0000,r_rx_lpi_count};
        `gem_rx_lpi_time          : prdata_stats  = {8'h00,r_rx_lpi_asserted};
        `gem_tx_lpi               : prdata_stats  = {16'h0000,r_tx_lpi_count};
        `gem_tx_lpi_time          : prdata_stats  = {8'h00,r_tx_lpi_asserted};
        default                   : prdata_stats  = 32'h00000000;
      endcase
    else
      prdata_stats  = 32'h00000000;
  end

  // Perr signal is similar to above. This is registered to match previous implementation
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      perr_stats  <= 1'b0;
    else if (psel)
      case (i_paddr)
        `gem_octets_txed_bottom   : perr_stats  <= 1'b0;
        `gem_octets_txed_top      : perr_stats  <= 1'b0;
        `gem_frames_txed_ok       : perr_stats  <= 1'b0;
        `gem_broadcast_txed       : perr_stats  <= 1'b0;
        `gem_multicast_txed       : perr_stats  <= 1'b0;
        `gem_pause_frames_txed    : perr_stats  <= 1'b0;
        `gem_frames_txed_64       : perr_stats  <= 1'b0;
        `gem_frames_txed_65       : perr_stats  <= 1'b0;
        `gem_frames_txed_128      : perr_stats  <= 1'b0;
        `gem_frames_txed_256      : perr_stats  <= 1'b0;
        `gem_frames_txed_512      : perr_stats  <= 1'b0;
        `gem_frames_txed_1024     : perr_stats  <= 1'b0;
        `gem_frames_txed_1519     : perr_stats  <= 1'b0;
        `gem_tx_underruns         : perr_stats  <= 1'b0;
        `gem_single_collisions    : perr_stats  <= 1'b0;
        `gem_multiple_collisions  : perr_stats  <= 1'b0;
        `gem_excessive_collisions : perr_stats  <= 1'b0;
        `gem_late_collisions      : perr_stats  <= 1'b0;
        `gem_deferred_frames      : perr_stats  <= 1'b0;
        `gem_crs_errors           : perr_stats  <= 1'b0;
        `gem_octets_rxed_bottom   : perr_stats  <= 1'b0;
        `gem_octets_rxed_top      : perr_stats  <= 1'b0;
        `gem_frames_rxed_ok       : perr_stats  <= 1'b0;
        `gem_broadcast_rxed       : perr_stats  <= 1'b0;
        `gem_multicast_rxed       : perr_stats  <= 1'b0;
        `gem_pause_frames_rxed    : perr_stats  <= 1'b0;
        `gem_frames_rxed_64       : perr_stats  <= 1'b0;
        `gem_frames_rxed_65       : perr_stats  <= 1'b0;
        `gem_frames_rxed_128      : perr_stats  <= 1'b0;
        `gem_frames_rxed_256      : perr_stats  <= 1'b0;
        `gem_frames_rxed_512      : perr_stats  <= 1'b0;
        `gem_frames_rxed_1024     : perr_stats  <= 1'b0;
        `gem_frames_rxed_1519     : perr_stats  <= 1'b0;
        `gem_undersize_frames     : perr_stats  <= 1'b0;
        `gem_excessive_rx_length  : perr_stats  <= 1'b0;
        `gem_rx_jabbers           : perr_stats  <= 1'b0;
        `gem_fcs_errors           : perr_stats  <= 1'b0;
        `gem_rx_length_errors     : perr_stats  <= 1'b0;
        `gem_rx_symbol_errors     : perr_stats  <= 1'b0;
        `gem_alignment_errors     : perr_stats  <= 1'b0;
        `gem_rx_resource_errors   : perr_stats  <= 1'b0;
        `gem_rx_overruns          : perr_stats  <= 1'b0;
        `gem_rx_ip_ck_errors      : perr_stats  <= 1'b0;
        `gem_rx_tcp_ck_errors     : perr_stats  <= 1'b0;
        `gem_rx_udp_ck_errors     : perr_stats  <= 1'b0;
        `gem_auto_flushed_pkts    : perr_stats  <= p_edma_rx_pkt_buffer == 0;
        `gem_rx_lpi               : perr_stats  <= 1'b0;
        `gem_rx_lpi_time          : perr_stats  <= 1'b0;
        `gem_tx_lpi               : perr_stats  <= 1'b0;
        `gem_tx_lpi_time          : perr_stats  <= 1'b0;
        default                   : perr_stats  <= 1'b1;  // No match for this module
      endcase
    else
      perr_stats  <= 1'b0;
  end

  generate if (p_edma_rx_pkt_buffer == 1) begin: gen_auto_flushed_pkts_assertion
    `ifdef ABV_ON
      // Check that the stats are incremented when packets are dropped
      // check 1.2.3.19 802p3Qci_Traffic_policing.vplanx
      reg [15:0] rx_auto_flushed_pkts_reg;

      always @ (posedge pclk or negedge n_preset)
      begin
        if(~n_preset)
          rx_auto_flushed_pkts_reg <= 16'd0;
        else
          rx_auto_flushed_pkts_reg <= rx_auto_flushed_pkts;
      end

      property check_stats_incr_802p3qci;
      @(posedge pclk)
        ((frame_flushed_pclk|rx_dma_pkt_flushed_pclk|inc_all_stats_regs) &
        ~(&rx_auto_flushed_pkts) &
        ~(read_registers & i_paddr == `gem_auto_flushed_pkts) &
        ~(write_registers & stats_write_en & i_paddr == `gem_auto_flushed_pkts) &
        ~(reset_all_stats_regs))
         |-> (##1 rx_auto_flushed_pkts == rx_auto_flushed_pkts_reg + 16'd1);
      endproperty
      assert_check_stats_incr_802p3qci : assert property (check_stats_incr_802p3qci);

    `endif
  end
  endgenerate

endmodule

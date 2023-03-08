//------------------------------------------------------------------------------
// Copyright (c) 2001-2021 Cadence Design Systems, Inc.
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
//   Filename:           gem_rx.v
//   Module Name:        gem_rx
//
//   Release Revision:   r1p12f5
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
//   Description :      Implements the ethernet receive medium access control
//                      protocol
//
//                             This module deserialises frames received on rxd
//                             and outputs 32/64/128 bit words on the fifo
//                             interface to either the DMA or the exposed FIFO
//                             interface. It also then reports status and
//                             statistics to the register module.
//
//
//                             This module is spilt into five main parts:
//                                Decoding logic
//                                Filter logic
//                                Pipeline delay logic
//                                FIFO interface control
//                                Error detection and status/statistics update
//
//
//             Decoding logic: There are three input paths for the received
//                             data:
//                                MII 4-bit interface for 10/100 operation,
//                                GMII 8-bit interface for 1G no PCS operation,
//                                PCS 16-bit interface for 1G internal PCS.
//
//                             All of these paths are converted into a 16-bit
//                             data path (using the 16-bit current data buffer).
//                             This is then analysed for the valid frame
//                             parts such as start/end of frame, start/end
//                             of data, start/end of carrier extension,
//                             preamble, SFD and code errors.
//
//                             This information is used to control the main
//                             RX state machine to keep track of the decoding
//                             of the frame.
//                             For gigabit half duplex mode the information
//                             is also used to detect minimum slot time, and
//                             bursting mode.
//
//                             After the preamble and SFD are removed from
//                             the data stream, an alignment buffer re-aligns
//                             the data back to a 16-bit boundary.
//
//                             The received frame's destination address, source
//                             address, typeID/Length and VLAN fields are then
//                             extracted and presented to both the internal
//                             filter module and the external filter interface.
//
//
//               Filter logic: The internal filter module uses the values for
//                             expected destination address and type field to
//                             match or discard the incoming frame. It also
//                             detects pause, unicast, multicast and broadcast
//                             frames and VLAN tags.
//                             This module also monitors the external match
//                             signals which will force a match if enabled.
//
//
//             pipeline delay: This portion of the code is a 16-bit pipeline of
//                             configurable depth, that is used to delay the
//                             data presented by the decoding stage, for long
//                             enough to allow the filtering operation to
//                             complete.
//                             If the frame has not been matched by the time
//                             the first data is at the pipeline output, the
//                             frame is discarded, and no FIFO activity will
//                             be seen.
//                             Information from the decoding and filtering
//                             stages must be saved for use at the end of the
//                             pipeline stage, since the earlier stages may
//                             now be decoding the next incoming frame.
//
//
//             FIFO interface: The FIFO interface takes the 16-bit data from
//                             the pipeline output and formats it according
//                             to the current bus width (32, 64 or 128 bit),
//                             using the 128-bit buffer.
//                             When a complete word is available the data is
//                             pushed out into the FIFO (either in the DMA or
//                             externally). Start and End of packet is indicated
//                             on the control signals to delimit the packet.
//                             Error and valid bytes are indicated at end of
//                             packet.
//                             The stripping of FCS is performed at this stage
//                             if required.
//                             End of packet may be forced before the true
//                             end of frame if the frame is too long.
//                             The fifo is continuously flushed whilst the
//                             receive block is disabled, and the overflow
//                             input monitored and saved for reporting at end
//                             of packet.
//
//
//       Error detection and : The output of the pipeline stage is also fed
//  status/statistics update   to error detection logic to detect valid length,
//                             CRC and alignment. These errors along with
//                             the status saved from the decoding process
//                             is reported to both the DMA and registers
//                             modules using appropriate handshaking.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

// The gem_rx code module definition
module gem_rx (
  // system signals
  n_rxreset,
  rx_clk,
  n_tsureset,
  tsu_clk,
  pclk,
  n_preset,

  // match registers for priortiy queues
  screener_type1_regs,
  screener_type2_regs,
  scr2_compare_regs,
  scr2_ethtype_regs,

  // Halt signal from BR MMSL
  rx_br_halt,

   // GMII/MII Interface
  rxd_gmii,
  rx_er_gmii,
  rx_dv_gmii,

  // Dedicated PCS Interface
  rxd_pcs,
  rxd_pcs_par,
  rx_er_pcs,
  rx_dv_pcs,

  // signals coming from the register block
  enable_receive,
  retry_test,
  gigabit,
  tbi,
  tx_byte_mode,
  full_duplex,
  dma_bus_width,
  jumbo_enable,
  rx_1536_en,
  pause_enable,
  pfc_enable,
  strip_rx_fcs,
  rx_no_pause_frames,
  rx_toe_enable,
  check_rx_length,
  rx_status_wr_tog,
  rx_no_crc_check,
  rx_bad_preamble,
  ign_ipg_rx_er,
  ptp_unicast_ena,
  rx_ptp_unicast,
  store_udp_offset,
  store_rx_ts,

  // filter control signals coming from the gem_reg_top (gem_registers).
  ext_match_en,
  uni_hash_en,
  multi_hash_en,
  no_broadcast,
  copy_all_frames,
  rm_non_vlan,
  hash,
  mask_add1,
  spec_add_filter_regs,
  spec_add_filter_active,
  spec_type1,
  spec_type2,
  spec_type3,
  spec_type4,
  spec_type1_active,
  spec_type2_active,
  spec_type3_active,
  spec_type4_active,
  wol_ip_addr,
  wol_mask,
  loopback_local,
  en_half_duplex_rx,

  // signals coming from the external filter block
  ext_match1_from_loop,
  ext_match2_from_loop,
  ext_match3_from_loop,
  ext_match4_from_loop,

  // signals coming from the dma block
  dma_rx_status_tog,

  // signals coming from the receive fifo interface.
  rx_w_overflow,

  // signals coming from the tx block
  tx_en,

  // signals going to the hclk_syncs block.
  dma_rx_end_tog,

  // signals going to the dma block
  rx_w_bad_frame,
  rx_w_frame_length,
  rx_w_vlan_tagged,
  rx_w_prty_tagged,
  rx_w_tci,

  // signals going to the receive fifo interface.
  rx_w_wr,
  rx_w_data,
  rx_w_data_par,
  rx_w_mod,
  rx_w_sop,
  rx_w_eop,
  rx_w_err,
  rx_w_flush,
  rx_w_timestamp,
  rx_w_timestamp_prty,

  // signals going to the external filter block
  ext_da,
  ext_da_stb,
  ext_sa,
  ext_sa_stb,
  ext_type,
  ext_type_stb,
  ext_ip_sa,
  ext_ip_sa_stb,
  ext_ip_da,
  ext_ip_da_stb,
  ext_source_port,
  ext_sp_stb,
  ext_dest_port,
  ext_dp_stb,
  ext_ipv6,

  // Stacked VLAN tag support
  stacked_vlantype,
  ext_vlan_tag1,
  ext_vlan_tag1_stb,
  ext_vlan_tag2,
  ext_vlan_tag2_stb,

  // precision time protocol signals for IEEE 1588 support
  sof_rx,
  sync_frame_rx,
  delay_req_rx,
  pdelay_req_rx,
  pdelay_resp_rx,
  general_frame_rx,


  // filter signals going to gem_dma_top (or external rx fifo interface).
  rx_w_broadcast_frame,
  rx_w_mult_hash_match,
  rx_w_uni_hash_match,
  rx_w_ext_match1,
  rx_w_ext_match2,
  rx_w_ext_match3,
  rx_w_ext_match4,
  rx_w_add_match,
  rx_w_type_match1,
  rx_w_type_match2,
  rx_w_type_match3,
  rx_w_type_match4,
  rx_w_checksumi_ok,
  rx_w_checksumt_ok,
  rx_w_checksumu_ok,
  rx_w_snap_frame,
  rx_w_length_error,
  rx_w_crc_error,
  rx_w_too_short,
  rx_w_too_long,
  rx_w_code_error,
  rx_w_l4_offset,
  rx_w_pld_offset,
  rx_w_pld_offset_vld,

  // signals going to the pclk_syncs block
  rx_end_tog,
  rx_frame_rxed_ok,
  rx_align_error,
  rx_crc_error,
  rx_short_error,
  rx_long_error,
  rx_jabber_error,
  rx_symbol_error,
  rx_pause_frame,
  rx_pause_nonzero,
  rx_pfc_pause_frame,
  rx_pfc_pause_nonzero,
  rx_length_error,
  rx_ip_ck_error,
  rx_tcp_ck_error,
  rx_udp_ck_error,
  rx_overflow,
  rx_broadcast_frame,
  rx_multicast_frame,
  rx_bytes_in_frame,
  lpi_indicate,

  // signals going to the tx block
  new_pause_time,
  new_pause_tog,

  // Time from TSU
  tsu_timer_cnt,
  tsu_timer_cnt_par,

  tsu_ptp_rx_timer_out,
  // RAS - Timestamp parity protection
  tsu_ptp_rx_timer_prty_out,

  // signals going to top level outputs
  wol,

  rx_dv_bp,
  queue_ptr_rx,

  // ASF - signals going to gem_reg_top
  asf_dap_mac_rx_err,

  // PFC signals
  pfc_negotiate,
  rx_pfc_paused,

  rsc_stop,
  rsc_push,
  tcp_seqnum,
  tcp_syn,
  tcp_payload_len,

  jumbo_max_length,
  ext_rxq_sel_en,

  // rx_q_flush signals ready to use by gem_rx_per_queue_flush module
  max_val_pclk,
  limit_frames_size_rx_clk,
  drop_all_frames_rx_clk,
  fill_lvl_breached,

  // per type 2 screener rate limiting algorithm registers
  scr2_rate_lim,
  scr_excess_rate,

  // toggle to stats, indicating a frame flushed by mode2, 3, or 4
  frame_flushed_tog,

  // 802.1CB Control and Status
  frer_to_cnt,
  frer_rtag_ethertype,
  frer_strip_rtag,
  frer_6b_tag,
  frer_en_vec_alg,
  frer_use_rtag,
  frer_seqnum_oset,
  frer_seqnum_len,
  frer_scr_sel_1,
  frer_scr_sel_2,
  frer_vec_win_sz,
  frer_en_elim,
  frer_en_to,
  frer_to_tog,
  frer_rogue_tog,
  frer_ooo_tog,
  frer_err_upd_tog,
  frer_err_upd_val

  );


// -----------------------------------------------------------------------------
// declare Inputs and Outputs
// -----------------------------------------------------------------------------

  parameter [1363:0] grouped_params = {1364{1'b0}};
  `include "ungroup_params.v"

  // system signals
  input         n_rxreset;                  // RX clock system reset
  input         rx_clk;                     // RX clock input
  input         tsu_clk;                    // TSU clock
  input         n_tsureset;                 // TSU reset
  input         pclk;                       // APB clock
  input         n_preset;                   // APB reset

  // 802.3br support signals
  input         rx_br_halt;                 // Halt RX datapath mid-frame

  // GMII/MII Interface
  input   [8:0] rxd_gmii;                   // receive data from the PHY
                                            // bit 8: parity
  input         rx_er_gmii;                 // receive error signal from the PHY
  input         rx_dv_gmii;                 // receive data valid signal from PHY

  // Dedicated PCS Interface
  input  [15:0] rxd_pcs;                    // receive data from the PCS
  input   [1:0] rxd_pcs_par;                // Parity
  input   [1:0] rx_er_pcs;                  // receive error signal from the PCS
  input   [1:0] rx_dv_pcs;                  // receive data valid signal from PCS

  // signals coming from the register block
  input         enable_receive;              // receive enable signal from network
                                             // control register
  input         retry_test;                  // reduces back off time - must be set
                                             // to zero for normal operation.
  input         gigabit;                     // high for gigabit operation
  input         tbi;                         // high for PCS i/f, low for GMII
  input         tx_byte_mode;                // tbi or gigabit
                                             // when = 1, byte mode
                                             // when = 0, nibble mode
  input         full_duplex;                 // high for full duplex operation
  input  [16:0] stacked_vlantype;            // VLAN tag TPID (bit 16 enables
                                             // stacked VLAN tag support)
  input   [1:0] dma_bus_width;               // DMA bus width...
                                             // 00 : 32 bit
                                             // 01 : 64 bit
                                             // 10 : 128 bit
                                             // 11 : 128 bit
  input         jumbo_enable;                // enable reception of jumbo frames
  input         rx_1536_en;                  // enable reception of 1536 byte frame
  input         pause_enable;                // enable reception of pause frames
  input         pfc_enable;                  // PFC pause frame enable
  input         strip_rx_fcs;                // stops rx fcs/crc being copied
  input         rx_no_pause_frames;          // Don't copy any pause frames
  input         rx_toe_enable;               // Enable RX TCP Offload Engine.
  input         check_rx_length;             // enables rx length field checking
  input         rx_status_wr_tog;            // acknowledge from register block
  input         rx_no_crc_check;             // disables crc checking on receive
  input         rx_bad_preamble;             // enables reception of frames with
                                             // bad preamble
  input         ign_ipg_rx_er;               // ignore rx_er when rx_dv is low
  input         ptp_unicast_ena;             // enable PTPv2 IPv4 unicast IP DA
                                             // detection
  input  [31:0] rx_ptp_unicast;              // rx PTPv2 IPv4 unicast IP DA
  input         store_udp_offset;            // store UDP and TCP offsets to mem
  input         store_rx_ts;                 // store receive time stamp to memory

  // filter control signals coming from the gem_reg_top (gem_registers).
  input         ext_match_en;                // external match enable from
                                             // the network configuration register.
  input         uni_hash_en;                 // unicast hash enable from the
                                             // network configuration register.
  input         multi_hash_en;               // multicast hash enable signal from
                                             // the network configuration register.
  input         no_broadcast;                // signal to disable reception of
                                             // broadcast frames from the network
                                             // configuration register.
  input         copy_all_frames;             // copy all frames signal from the
                                             // network configuration register.
  input         rm_non_vlan;                 // Discard non-VLAN frames
  input  [63:0] hash;                        // hash register for destination
                                             // address filtering.
  input [55*(p_num_spec_add_filters+1)-1:0]
                spec_add_filter_regs;        // specific address filters
  input [p_num_spec_add_filters:0]
                spec_add_filter_active;      // specific address filter active
  input  [47:0] mask_add1;                   // specific address 1 mask for
                                             // destination address comparison.
  input  [15:0] spec_type1;                  // specific type 1 for type comparison
  input  [15:0] spec_type2;                  // specific type 2 for type comparison
  input  [15:0] spec_type3;                  // specific type 3 for type comparison
  input  [15:0] spec_type4;                  // specific type 4 for type comparison
  input         spec_type1_active;           // spec_type1 can be used for type
                                             // comparison.
  input         spec_type2_active;           // spec_type2 can be used for type
                                             // comparison.
  input         spec_type3_active;           // spec_type3 can be used for type
                                             // comparison.
  input         spec_type4_active;           // spec_type4 can be used for type
                                             // comparison.
  input  [15:0] wol_ip_addr;                 // lower bits of IP address for WoL
  input   [3:0] wol_mask;                    // Wake-onLAN enable mask
  input         loopback_local;              // internal loopback mode.
  input         en_half_duplex_rx;           // enable receiving of frames whilst
                                             // transmiting in half duplex.

  // signals coming from the external filter block
  input         ext_match1_from_loop;        // external match (frame to be copied)
  input         ext_match2_from_loop;        // external match (frame to be copied)
  input         ext_match3_from_loop;        // external match (frame to be copied)
  input         ext_match4_from_loop;        // external match (frame to be copied)

  // signals coming from the dma block
  input         dma_rx_status_tog;           // DMA has written frame status for
                                             // first frame

  // signals coming from the receive fifo interface.
  input         rx_w_overflow;               // Overflow in RX FIFO indication

  // signals coming from the tx block
  input         tx_en;                       // transmit enable signal to the PHY.

  // signals going to the hclk_syncs block.
  output        dma_rx_end_tog;              // end of frame toggle, indicating
                                             // that status has been setup
                                             // for the DMA block to sample.

  // signals going to the dma block
  output        rx_w_bad_frame;              // rx frame bad (rx_er or too long)
                                             // held until end of frame
  output [13:0] rx_w_frame_length;           // records frame length for status
                                             // reporting
  output        rx_w_vlan_tagged;            // used for reporting VLAN tag
  output        rx_w_prty_tagged;            // used for reporting priority tag
  output  [3:0] rx_w_tci;                    // used for reporting VLAN priority

  // signals going to the receive fifo interface.
  output        rx_w_wr;                     // rx push output to the receive fifo
  output[127:0] rx_w_data;                   // output data to the receive fifo.
  output [15:0] rx_w_data_par;
  output  [3:0] rx_w_mod;                    // rx number of valid bytes in last
                                             // transfer of the frame.
                                             // 0001 - rx_w_data[7:0] valid,
                                             // 0010 - rx_w_data[15:0] valid, ...
                                             // 1111 - rx_w_data[119:0] valid.
                                             // 0000 - rx_w_data[127:0] valid,
  output        rx_w_sop;                    // rx start of packet indicator.
  output        rx_w_eop;                    // rx end of packet indicator.
  output        rx_w_err;                    // rx packet in error indicator.
  output        rx_w_flush;                  // rx fifo flush from the mac
  output [77:0] rx_w_timestamp;
  output  [9:0] rx_w_timestamp_prty;         // parity protection for rx_w_timestamp

  // signals going to the external filter block
  output [47:0] ext_da;                      // destination address from rx data
  output        ext_da_stb;                  // set when destination address valid
  output [47:0] ext_sa;                      // source address from rx data
  output        ext_sa_stb;                  // set when source address valid
  output [15:0] ext_type;                    // length field from rx frame
  output        ext_type_stb;                // length/TypeID field valid
  output[127:0] ext_ip_sa;                   // IP source address
  output        ext_ip_sa_stb;               // IP source address valid strobe
  output[127:0] ext_ip_da;                   // IP destination address
  output        ext_ip_da_stb;               // IP destination address valid strobe
  output [15:0] ext_source_port;             // source port number
  output        ext_sp_stb;                  // validates source port number
  output [15:0] ext_dest_port;               // destination port number
  output        ext_dp_stb;                  // validates destination port number
  output        ext_ipv6;                    // high for ipv6

  output [31:0] ext_vlan_tag1;               // VLAN tag 1
  output        ext_vlan_tag1_stb;           // VLAN tag 1 strobe
  output [31:0] ext_vlan_tag2;               // VLAN tag 2
  output        ext_vlan_tag2_stb;           // VLAN tag 2 strobe

  // precision time protocol signals for IEEE 1588 support
  output        sof_rx;                      // asserted on SFD deasserted at EOF
  output        sync_frame_rx;               // asserted if PTP sync frame
  output        delay_req_rx;                // asserted if PTP delay_req
  output        pdelay_req_rx;               // asserted if PTP pdelay_req
  output        pdelay_resp_rx;              // asserted if PTP pdelay_resp
  output        general_frame_rx;            // asserted if PTP general frame

  // filter signals going to gem_dma_top (or external rx fifo interface).
  output        rx_w_broadcast_frame;        // broadcast frame signal from the
                                             // address checker - rx status
                                             // reporting.
  output        rx_w_mult_hash_match;        // multicast hash matched frame signal
                                             // for rx status reporting.
  output        rx_w_uni_hash_match;         // unicast hash matched frame signal
                                             // for rx status reporting.
  output        rx_w_ext_match1;             // external matched frame signal
                                             // for rx status reporting.
  output        rx_w_ext_match2;             // external matched frame signal
                                             // for rx status reporting.
  output        rx_w_ext_match3;             // external matched frame signal
                                             // for rx status reporting.
  output        rx_w_ext_match4;             // external matched frame signal
                                             // for rx status reporting.
  output [p_num_spec_add_filters:0]
                rx_w_add_match;              // specific address register matched
  output        rx_w_type_match1;            // specific type register 1 matched
                                             // type field.
  output        rx_w_type_match2;            // specific type register 2 matched
                                             // type field.
  output        rx_w_type_match3;            // specific type register 3 matched
                                             // type field.
  output        rx_w_type_match4;            // specific type register 4 matched
                                             // type field.
  output        rx_w_checksumi_ok;           // IP checksum checked and was OK.
  output        rx_w_checksumt_ok;           // TCP checksum checked and was OK.
  output        rx_w_checksumu_ok;           // UDP checksum checked and was OK.
  output        rx_w_snap_frame;             // Frame was SNAP encapsulated and
                                             // had no VLAN or VLAN with no CFI.
  output        rx_w_length_error;           // rx_w_status length field error
  output        rx_w_crc_error;              // rx_w_status crc error
  output        rx_w_too_short;              // rx_w_status rx length short error
  output        rx_w_too_long;               // rx_w_status rx length long error
  output        rx_w_code_error;             // rx_w_status code error
  output [11:0] rx_w_l4_offset;              // UDP/TCP Offset in bytes
  output [11:0] rx_w_pld_offset;             // PLD Offset in bytes
  output        rx_w_pld_offset_vld;         // PLD Offset in bytes, valid

  // signals going to the pclk_syncs block
  output        rx_end_tog;                  // end of frame toggle, indicating
                                             // that status has been setup
  output        rx_frame_rxed_ok;            // frame received OK by MAC
  output        rx_align_error;              // misaligned frame (non-integral
                                             // number of bytes and bad crc)
  output        rx_crc_error;                // crc errored frame (integral number
                                             // of bytes and bad crc)
  output        rx_short_error;              // short frame (less than 64 bytes and
                                             // good crc)
  output        rx_long_error;               // long frame (greater than 1518/1536/
                                             // 10k bytes and good crc)
  output        rx_jabber_error;             // long frame with bad crc (greater
                                             // than 1518/1536/10k  bytes)
  output        rx_symbol_error;             // signal indicating a rx_er frame
  output        rx_pause_frame;              // indicates a 802.3 pause frame
                                             // has been received
  output        rx_pause_nonzero;            // indicates a 802.3 pause frame
                                             // has been received with
                                             // non-zero quantum.
  output        rx_pfc_pause_frame;          // indicates a PFC pause frame
                                             // has been received
  output        rx_pfc_pause_nonzero;        // indicates a PFC pause frame
                                             // has been received (pause_enable=1)
                                             // equivalent to rx_pause_nonzero for
                                             // classic pause frame
  output        rx_length_error;             // indicates a frame has been received
                                             // where the length field is incorrect
  output        rx_ip_ck_error;              // frame had IP header checksum error
  output        rx_tcp_ck_error;             // frame had TCP checksum error
  output        rx_udp_ck_error;             // frame had UDP checksum error
  output        rx_overflow;                 // Indicates an overrun in the RX path
  output [13:0] rx_bytes_in_frame;           // number of bytes in rx frame.
  output        rx_broadcast_frame;          // asserted on end_frame if the frame
                                             // received was broadcast.
  output        rx_multicast_frame;          // asserted on end_frame if the frame
                                             // received was multicast.
  output        lpi_indicate;                // rx LPI indication has been detected

  // signals going to the tx block
  output [15:0] new_pause_time;              // value of decoded new pause time
  output        new_pause_tog;               // indicates a new pause time rxed

  // Time from TSU
  input [93:16] tsu_timer_cnt;               // Timer value
  input [11:2]  tsu_timer_cnt_par;           // Parity

  output [77:0] tsu_ptp_rx_timer_out;        // RX Timestamp in PCLk domain to registers
  // RAS - Timestamp parity protection
  output  [9:0] tsu_ptp_rx_timer_prty_out;   // parity protection for tsu_ptp_rx_timer_out

  // signals going to top level outputs
  output        wol;                         // Wake-on-LAN output

  output        rx_dv_bp;                    // Data detection for backpressure
  output  [3:0] queue_ptr_rx;                // Priorty Queue ptr for RX

  // ASF - signals to gem_reg_top
  output        asf_dap_mac_rx_err;          // data path error indications in rxclk

  // PFC pause frame signals
  output        pfc_negotiate;               // indicates a received PFC pause frame

  output [7:0]  rx_pfc_paused;               // each bit is set when PFC frame has
                                             // been received and the associated
                                             // PFC counter != 0


  input  [13:0] jumbo_max_length;            // programable max length
  input         ext_rxq_sel_en;              // enable external receive queue selection

  output         rsc_stop;                   // Set if any of the SYN/FIN/RST/URG
                                             // flags are set in the TCP header
  output         rsc_push;                   // Set if the PSH flas is set
  output [31:0]  tcp_seqnum;                 // Identifies the TCP seqnum of the frame
  output         tcp_syn;                    // Set if the SYN flas is set
  output [15:0]  tcp_payload_len;            // Payload Length

  input  [(32*p_num_type1_screeners):0]
                 screener_type1_regs;
  input  [(32*p_num_type2_screeners):0]
                 screener_type2_regs;
  input  [(43*p_num_scr2_compare_regs):0]
                 scr2_compare_regs;
  input  [(16*p_num_scr2_ethtype_regs):0]
                 scr2_ethtype_regs;

  // 802.1CB control and status
  input  [15:0]  frer_to_cnt;                // Count of number of frer_to_cnt_tog
                                             // without passing frames before timeout
  input  [15:0]  frer_rtag_ethertype;        // Ethertype for redundancy tag detect
  input          frer_strip_rtag;            // Strip redundancy tags
  input          frer_6b_tag;                // R-Tag is 6 bytes not 4 bytes
  input  [p_gem_num_cb_streams-1:0]
                 frer_en_vec_alg;            // Select which algorithm to use.
  input  [p_gem_num_cb_streams-1:0]
                 frer_use_rtag;              // Set to use RTag or offset for seqnum

  input  [(p_gem_num_cb_streams*9)-1:0]
                 frer_seqnum_oset;           // Offset into frame for seqnum
  input  [(p_gem_num_cb_streams*5)-1:0]
                 frer_seqnum_len;            // Number of bits of seqnum to use
  input  [(p_gem_num_cb_streams*4)-1:0]
                 frer_scr_sel_1;             // Screener match for stream 1
  input  [(p_gem_num_cb_streams*4)-1:0]
                 frer_scr_sel_2;             // Screener match for stream 2
  input  [(p_gem_num_cb_streams*6)-1:0]
                 frer_vec_win_sz;            // History depth to use for vec rcv alg

  input  [p_gem_num_cb_streams-1:0]
                 frer_en_elim;               // Enable 802.1CB elimination function
  input  [p_gem_num_cb_streams-1:0]
                 frer_en_to;                 // Enable 802.1CB timeout function

  output [p_gem_num_cb_streams-1:0]
                 frer_to_tog;                // Toggle to indicate timeout occurred

  output [p_gem_num_cb_streams-1:0]
                 frer_rogue_tog;             // Toggle to indicate rogue frame rcvd
  output [p_gem_num_cb_streams-1:0]
                 frer_ooo_tog;               // Toggle to indicate out of order frame
  output [p_gem_num_cb_streams-1:0]
                 frer_err_upd_tog;           // Toggle to enable update latent errors
  output [(p_gem_num_cb_streams*7)-1:0]
                 frer_err_upd_val;           // Incrememt value, use with above

  // rx_q_flush registers signals ready to use by gem_rx_per_queue_flush module
  input  [(16*p_edma_queues)-1:0]            // This is the upper 16 bits of each of the
               max_val_pclk;                 // rx_q_flush registers
  input  [p_edma_queues-1:0]                 // This is the bit indicating if Mode3 is enabled
               limit_frames_size_rx_clk;     // for the per-queue rx flush functionality
  input  [p_edma_queues-1:0]                 // This is the bit indicating if Mode0 is enabled
               drop_all_frames_rx_clk;       // for the per-queue rx flush functionality
  input  [p_edma_queues-1:0]                 // This is the bit indicating if Mode2 is enabled
               fill_lvl_breached;            // for the per-queue rx flush functionality

  // per type 2 screener rate limiting algorithm registers
  input [(32*p_num_type2_screeners):0]       // This is the whole set of registers for the
               scr2_rate_lim;                // per-screener rate limiting functionality
  output[p_num_type2_screeners:0]            // This is a signal going to the registers
               scr_excess_rate;              // block

  // toggle to stats, indicating a frame flushed by mode2, or 3
  output       frame_flushed_tog;            // Going to the stats registers


// -----------------------------------------------------------------------------
// declare reg's and wire's
// -----------------------------------------------------------------------------

  // output reg's
  reg           rx_w_wr;                 // rx write output to the receive fifo
  reg     [3:0] rx_w_mod;                // rx number of valid bytes in last
                                         // transfer of the frame.
                                         // 0001 - rx_w_data[7:0] valid,
                                         // 0010 - rx_w_data[15:0] valid, ...
                                         // 1111 - rx_w_data[119:0] valid.
                                         // 0000 - rx_w_data[127:0] valid,
  reg           rx_w_sop;                // rx start of packet indicator.
  reg           rx_w_eop;                // rx end of packet indicator.
  reg           rx_w_err;                // rx packet in error indicator.
  wire          rx_w_err_next;           // rx packet in error indicator next value
  reg    [13:0] rx_w_frame_length;       // records frame length for status
                                         // reporting
  reg           rx_w_vlan_tagged;        // used for reporting VLAN tag
  reg           rx_w_prty_tagged;        // used for reporting priority tag
  reg     [3:0] rx_w_tci;                // used for reporting VLAN priority
                                         // frame have been loaded into d_add
  reg           rx_w_broadcast_frame;    // broadcast frame signal from the
                                         // address checker - rx status
                                         // reporting.
  reg           rx_w_mult_hash_match;    // multicast hash matched frame signal
                                         // for rx status reporting.
  reg           rx_w_uni_hash_match;     // unicast hash matched frame signal
                                         // for rx status reporting.
  reg           rx_w_ext_match1;         // external matched frame signal
                                         // for rx status reporting.
  reg           rx_w_ext_match2;         // external matched frame signal
                                         // for rx status reporting.
  reg           rx_w_ext_match3;         // external matched frame signal
                                         // for rx status reporting.
  reg           rx_w_ext_match4;         // external matched frame signal
                                         // for rx status reporting.
  wire [p_num_spec_add_filters:0] rx_w_add_match;  // specific address register matched
  reg           rx_w_type_match1;        // specific type register 1 matched
                                         // type field.
  reg           rx_w_type_match2;        // specific type register 2 matched
                                         // type field.
  reg           rx_w_type_match3;        // specific type register 3 matched
                                         // type field.
  reg           rx_w_type_match4;        // specific type register 4 matched
                                         // type field.
  reg           rx_w_checksumi_ok;       // IP checksum checked and was OK.
  reg           rx_w_checksumt_ok;       // TCP checksum checked and was OK.
  reg           rx_w_checksumu_ok;       // UDP checksum checked and was OK.
  reg           rx_w_snap_frame;         // Frame was SNAP encapsulated and
                                         // had no VLAN or VLAN with no CFI.
  reg           rx_w_length_error;       // rx_w_status length field error
  reg           rx_w_crc_error;          // rx_w_status crc error
  reg           rx_w_too_short;          // rx_w_status rx length short error
  reg           rx_w_too_long;           // rx_w_status rx length long error
  reg           rx_w_code_error;         // rx_w_status code error
  wire   [15:0] pld_offset;               // PLD offset in bytes
  wire   [77:0] rx_w_timestamp;          // Timestamp value
  wire   [9:0]  rx_w_timestamp_prty;     // parity protection for rx_w_timestamp Timestamp value
  reg           dma_rx_end_tog;          // end of frame toggle, indicating
                                         // that status has been setup
                                         // for the DMA block to sample.
  reg           rx_end_tog;              // end of frame toggle, indicating
                                         // that status has been setup
                                         // for the register block to sample.
  reg           rx_w_bad_frame;          // rx frame bad (rx_er or too long)
                                         // held until end of frame
  reg           rx_frame_rxed_ok;        // frame recieved OK by MAC
  reg           rx_align_error;          // misaligned frame (non-integral
                                         // number of bytes and bad crc)
  reg           rx_crc_error;            // crc errored frame (integral number
                                         // of bytes and bad crc)
  reg           rx_short_error;          // short frame (less than 64 bytes and
                                         // good crc)
  reg           rx_long_error;           // long frame (greater than 1518/1536/
                                         // 10k bytes and good crc)
  reg           rx_jabber_error;         // long frame with bad crc (greater
                                         // than 1518/1536/10k bytes)
  reg           rx_symbol_error;         // signal indicating a rx_er frame
  reg           rx_pause_frame;          // indicates a 802.3 pause frame
                                         // has been received
  reg           rx_pause_nonzero;        // indicates a 802.3 pause frame
                                         // has been received with non-zero
  reg           rx_pfc_pause_frame;      // quantum indicates a PFC pause frame
                                         // has been received
  reg           rx_pfc_pause_nonzero;    // indicates a PFC pause frame
                                         // has been received (pause_enable=1)
                                         // equivalent to rx_pause_nonzero for
                                         // classic pause frame
  reg           rx_length_error;         // indicates a frame has been received
                                         // where the length field is incorrect
  reg           rx_ip_ck_error;          // frame had IP header checksum error
  reg           rx_tcp_ck_error;         // frame had TCP checksum error
  reg           rx_udp_ck_error;         // frame had UDP checksum error
  reg           rx_overflow;             // indicates an overrun in the RX path
  reg    [13:0] rx_bytes_in_frame;       // number of bytes in rx frame.
  reg           rx_broadcast_frame;      // asserted on end_frame if the frame
                                         // received was broadcast.
  reg           rx_multicast_frame;      // asserted on end_frame if the frame
                                         // received was multicast.
  reg    [15:0] new_pause_time;          // value of decoded new pause time
  reg           new_pause_tog;           // indicates a new pause time rxed
  reg           lpi_indicate;            // rx LPI indication has been detected

  // Register block dynamic outputs synchronisation
  wire          enable_receive_rck;      // second stage of metastability prot
  wire          pause_enable_rck;        // second stage of metastability prot
  wire          pfc_enable_rck;          // second stage of metastability prot
  reg           retry_test_rck;          // retry_test synced with rc_clk
  wire          ptp_unicast_ena_rck;     // second stage of metastability prot
  wire          ext_rxq_sel_en_rck;      // second stage of metastability prot

  // GMII/MII & PCS synchronisation
  reg     [8:0] rxd_gmii_sync;           // resynchronisation stage
  reg           rx_er_gmii_sync;         // resynchronisation stage
  reg           rx_dv_gmii_sync;         // resynchronisation stage
  wire   [15:0] rxd_pcs_sync;            // resynchronisation stage
  wire    [1:0] rxd_pcs_par_sync;        // resynchronisation stage
  wire    [1:0] rx_er_pcs_sync;          // resynchronisation stage
  wire    [1:0] rx_dv_pcs_sync;          // resynchronisation stage

  // Interface selection muxes
  wire   [17:0] rxd_int;                 // Selected rxd + twice parity protection bit and valid parity
                                         // Bit 7:0   : Data Byte 1
                                         // Bits 15:8   : Data Byte 2
                                         // Bit 16  : parity for Data Byte 1
                                         // Bit 17  : parity for Data Byte 2
  wire    [1:0] rx_dv_int;               // Selected rx_dv (one bit per byte)
  wire    [1:0] rx_er_in;                // Selected rx_er (one bit per byte)
  reg     [1:0] rx_er_int;               // Selected rx_er (one bit per byte)

  // Validate incoming data and build into 16 bit current data buffer
  reg     [1:0] nibble_pntr;             // Points to current addressed nibble
                                         // within selected buffer
  wire    [2:0] nibble_pntr_inc;         // Amount to increment nibble pointer
  wire    [3:0] next_nibble_pntr;        // Next value of nibble pointer
  reg           prev_nibble_was_pre;     // Previous nibble was 4'h5
  wire          odd_pre_nibbles;         // odd number of preamble nibbles rxed
                                         // so force an extra one to realign.
  reg           curr_buf_full;           // Current 16-bit data buffer is full
  reg     [1:0] curr_rx_dv;              // RX_DV tags in current 16-bit word
  reg     [1:0] curr_rx_er;              // RX_ER tags in current 16-bit word
  reg    [17:0] curr_data_16;            // current 16-bit data word + twice parity protection bit and valid parity
                                         // Bit 7:0   : Data Byte 1
                                         // Bits 15:8   : Data Byte 2
                                         // Bit 16  : parity for Data Byte 1
                                         // Bit 17  : parity for Data Byte 2


  // detect preamble and SFD and ensure only data passed on
  wire    [1:0] det_sfd;                 // bytes with SFD
  wire    [1:0] det_sfd_qual;            // Qualify so only first SFD detected
  wire          valid_sfd;               // Data word contains valid SFD
  wire    [1:0] det_pre;                 // bytes with preamble
  wire    [1:0] det_pre_qual;            // Qualify so only valid preamble
  wire          valid_pre;               // Data word contains valid preamble
  wire    [1:0] det_data;                // Bytes that contain valid data
                                         // excluding SFD, preamble and carrier
                                         // extension
  wire          valid_data;              // Data word contains valid data

  // detect carrier extension
  wire    [1:0] det_cxt;                 // bytes with carrier extension
  wire          valid_cxt;               // new data containing carr ext loaded
  wire    [1:0] det_cxt_err;             // bytes with carrier ext error
  wire    [1:0] det_cxt_err_qual;        // Qualify so only valid carr ext err
  wire          valid_cxt_err;           // Data word contains valid cxt error
  wire          valid_code_err;          // Data word contains valid code error
  reg           code_error;              // code error held until end of frame

  // detect start and end of frame & current state of interface
  reg     [1:0] rx_dv_int_del;           // Used for edge detection of rx_dv
  reg     [1:0] rx_er_int_del;           // Used for edge detection of rx_er
  wire          rx_dv_int_le;            // Leading edge of selected RX_DV
  wire          rx_dv_int_te;            // Trailing edge of selected RX_DV
  wire          rx_er_int_le;            // Leading edge of selected RX_ER
  wire          rx_er_int_te;            // Trailing edge of selected RX_ER
  wire          start_of_data;           // start of data detected
  wire          end_of_data;             // end of data valid detected
  wire          end_of_frame;            // end of frame detected
  wire          start_of_carr_ext;       // Detect carrier extension beginning
  wire          end_of_carr_ext;         // Detect carrier extension ending
  reg           giga_bursting;           // gigabit burst mode
  reg     [1:0] rx_state;                // indicates receive state:- RX_IDLE,
                                         // RX_PREAMBLE, RX_DATA or RX_CARR_EXT
  reg     [1:0] rx_state_nxt;            // next rx_state logic
  wire          rx_state_preamble;       // Current state is RX_PREAMBLE
  wire          rx_state_data;           // Current state is RX_DATA
  wire          rx_state_carr_ext;       // Current state is RX_CARR_EXT
  wire          rx_state_idle;           // Current state is RX_IDLE
  reg           valid_frame_detected;    // valid frame detected
  wire          frame_being_decoded;     // valid frame is being decoded
  reg           decoding_finished;       // end of frame has been seen

  // Slot time measurement
  reg     [9:0] slot_time_cnt;           // Minimum Slot time counter
  wire   [10:0] next_slot_time_cnt;      // Next slot time counter value
  wire    [2:0] slot_time_cnt_inc;       // Slot time counter increment
  wire          slot_time_dec;           // minimum slot time just reached
  reg           not_min_slot_time;       // minimum slot time not reached yet
  wire          slot_time_done;          // minimum slot time has been reached

  // re-alignment buffer control
  reg           align_pntr;              // Points to next byte to fill
  reg           next_align_pntr;         // Next value of align_pntr
  reg           next_align_full;         // Alignment buffer about to be filled
  reg           next_align_overflow;     // Alignment buffer about to overflow
  reg           prev_align_overflowd;    // Alignment buffer overflowed
  reg    [17:0] curr_data_align;         // incoming data right justified
  reg    [26:0] new_data_align;          // buffer containing aligned data
                                         // in lowest 16 bits and residue
                                         // in upper 8 bits and
                                         // 24:26 parity bits for the 8 bytes
  reg           new_aligned_data;        // new 32 bit aligned data ready
  reg     [1:0] no_aligned_data;         // valid number of bytes in new
                                         // aligned data
  reg           last_aligned_data;       // last aligned data detected
  wire          last_align_data_tag;     // last data being written to pipeline
  wire          last_odd_nibble;         // last data forced by odd nibble
  reg           force_over_align;        // force overflow into align buffer

  // decode frame elements
  wire          vlan_tagged;             // used for detecting VLAN tag
  wire          priority_tagged;         // used for detecting priority tag
  wire    [3:0] tci;                     // used for extacting VLAN priority
  wire   [15:0] length_field;            // length field saved at end frame
  wire          pause_frame;             // used for detecting pause frame
  wire   [15:0] pause_time;              // pause time value decoded
  wire          snap_frame;              // Detect SNAP encapsulated frame.
  wire          ip_v4_frame;             // Used for detecting IP ver 4 frame.
  wire          ip_v6_frame;             // Used for detecting IP ver 6 frame.
  wire          arp_frame;               // Used for detecting ARP frame.
  wire          tcp_frame;               // Used for detecting TCP frame.
  wire          udp_frame;               // Used for detecting UDP frame.
  wire          ip_ck_err;               // IP header checksum error.
  wire          tcp_udp_ck_err;          // TCP/UDP checksum error.
  wire          drop_pause_frame;        // drops pause frames using error
  wire          frer_rtag_mark_early;    // Marks that pipeline data is RTag

  // internal signals to/from filter block
  wire          pause_add_match;         // dest address indicates pause frame
  wire          rx_store_frame;          // frame should be stored.
  wire          fil_broadcast_frame;     // filter matched as broadcast
  wire          fil_multicast_frame;     // filter matched as multicast
  wire          fil_mult_hash_match;     // filter matched as mulitcast hash
  wire          fil_uni_hash_match;      // filter matched as unicast hash
  wire          fil_ext_match1;          // filter matched as external 1
  wire          fil_ext_match2;          // filter matched as external 2
  wire          fil_ext_match3;          // filter matched as external 3
  wire          fil_ext_match4;          // filter matched as external 4
  wire          [p_num_spec_add_filters:0]
                fil_add_match;           // specific address register match
  wire          fil_type_match1;         // filter matched as spec type 1
  wire          fil_type_match2;         // filter matched as spec type 2
  wire          fil_type_match3;         // filter matched as spec type 3
  wire          fil_type_match4;         // filter matched as spec type 4

  // Detect when frame is matched by filter
  reg           frame_matched;           // Frame has been matched by filter

  // Signals generated during decoding process need saving for status reporting
  reg           nibble_cnt_odd_saved;    // odd number of nibbles in frame
  reg           slot_time_saved;         // slot time done saved at end frame
  reg           code_error_saved;        // code error saved at end frame
  reg    [15:0] length_field_saved;      // length field saved at end frame
  reg           vlan_tagged_saved;       // vlan tagged saved at end frame
  reg           pause_frame_saved;       // pause_frame saved at end frame
  reg    [15:0] pause_time_saved;        // pause time saved at end frame
  reg           snap_frame_saved;        // snap_frame saved at EOF
  reg           ip_v4_frame_saved;       // ip_v4_frame saved at EOF
  reg           arp_req_frame_saved;     // arp_req_frame saved at EOF
  reg           tcp_frame_saved;         // tcp_frame saved at EOF
  reg           udp_frame_saved;         // udp_frame saved at EOF
  reg           ip_ck_err_saved;         // ip_ck_err saved at EOF
  reg           tcp_udp_ck_err_saved;    // tcp_udp_ck_err saved at EOF
  reg           drop_pause_frame_saved;  // Drops all pause frames using error
  wire          frer_discard;            // Discard frame due to FRER duplicate
  reg           frame_matched_saved;     // frame_matched saved at end of frame
  reg           broad_frame_saved;       // fil_broadcast_frame saved at EOF
  reg           multi_frame_saved;       // fil_multicast_frame saved at EOF
  reg           multi_match_saved;       // fil_mult_hash_match saved at EOF
  reg           uni_match_saved;         // fil_uni_hash_match saved at EOF
  reg           ext_match1_saved;        // fil_ext_match1 saved at EOF
  reg           ext_match2_saved;        // fil_ext_match2 saved at EOF
  reg           ext_match3_saved;        // fil_ext_match3 saved at EOF
  reg           ext_match4_saved;        // fil_ext_match4 saved at EOF
  wire  [p_num_spec_add_filters:0]
                add_match_saved;         // fil_add_match saved at EOF
  wire          add_match_saved_bot;     //
  reg           type_match1_saved;       // fil_type_match1 saved at EOF
  reg           type_match2_saved;       // fil_type_match2 saved at EOF
  reg           type_match3_saved;       // fil_type_match3 saved at EOF
  reg           type_match4_saved;       // fil_type_match4 saved at EOF

  // Pipeline Delay to allow time for Address and type matching
  reg           frame_in_pipeline;       // frame being pushed through pipeline
  reg           last_in_pipeline;        // last data within the pipeline
  reg           last_out_of_pipeline;    // last has come out of the pipeline
  reg           force_push_pipeline;     // advance pipeline when last is in
  wire          push_pipeline;           // advance the pipeline
  reg    [21:0] pipeline_input;          // Input to the pipeline
                                         // 21:20 Parity for 16-bits of data
  reg    [21:0] pipeline_delay [p_gem_rx_pipeline_delay - 1:0];
                                         // Delayed aligned data & status
  integer       i;                       // References array in for loop
  wire   [21:0] pipeline_output;         // Output from the pipeline
                                         // 20:21 bis valid parity,parity of first 8 bits
                                         // 22:23 bis valid parity,parity of second 8 bits
  wire   [21:0] pipeline_delay_fcs1;     // used for stripping FCS
  wire   [21:0] pipeline_delay_fcs2;     // used for stripping FCS
  reg    [17:0] data_store_16;           // pipeline_out modified to replace
                                         // CRC with time stamp if necessary
                                         // 17:16 parity bits

  wire          stop_fifo_wr_fcs;        // used for stripping FCS
  wire          no_more_128_data;        // used for stripping FCS
  wire          new_pipeline_data;       // New data at pipeline output
  wire          new_pipeline_data_comb;  // Combine with discard bit
  wire    [1:0] no_pipeline_data;        // Number of bytes at pipeline output
  reg     [1:0] no_pipe_data_fcs;        // Number of bytes at pipeline output
                                         // when accounting for strip_fcs
  reg     [1:0] last_no_pipe_save;       // Store number of valid bytes in last
                                         // push from 16bit pipeline (1-2)
  reg           last_pipeline_data;      // last data at output of pipeline
  reg           pipeline_finished;       // finish the pipeline

  // Pipeline matching
  reg           match_too_late_pipe;     // filter too slow in matching
  reg           frame_match_pipe_det;    // frame matched at pipeline output
  wire          frame_matched_pipe;      // frame matched in time.

  // 32/64/128 bit buffer to transfer data DMA
  wire          dma_32bit_mode;          // Uses only lowest 32 bits
  wire          dma_64bit_mode;          // Uses only lowest 64 bits
  reg   [127:0] data_store_128;          // 32/64/128 bit data store
  reg    [15:0] data_store_128_par;      // Parity
  reg     [2:0] word_pntr_128;           // pointer to 16-bit word in 128 bits
  wire    [3:0] next_word_pntr_128;      // next 128 bit buffer word offset
  reg     [2:0] prev_word_pntr_128;      // previous value of 128 bit buffer
  reg     [4:0] no_bytes_in_wordpntr;    // number of bytes in 128 bit buffer
  wire          next_128_full;           // 128 bit buffer about to be filled
  reg           rx_w_sop_next;           // Next push is start of packet.
  reg     [3:0] next_rx_w_mod;           // Next value of rx_w_mod ouput.

  // overrun detection
  wire          rx_pipeline_overflow;    // Indicates that a second end of
                                         // frame has been loaded into the FIFO
                                         // before the first has finished
  reg           two_ends_in_pipe;        // Two ends written into pipeline
  reg           overflow_saved;          // Store overflow until reported
  reg           update_overflow;         // Store status update overflow

  // Frame length measurement for min and max frame size and length/type field
  reg    [13:0] frm_byte_cnt;            // counts rx frame length in bytes
  wire   [14:0] next_frm_byte_cnt;       // next frame length
  wire    [1:0] frm_byte_cnt_inc;        // amount to increment frame length
  reg           not_min_frame_size;      // minimum frame size not reached yet
  wire          too_short;               // indicates whether a received frame
                                         // is too short
  reg           too_long_dec;            // indicates whether a received frame
                                         // is too long
  reg           too_long;                // too_long_dec held until EOF
  reg           length_error;            // mismatch in frame size and length
                                         // field
  wire          bad_frame;               // Indicate a bad frame has been rxed

  // handshaking for DMA and registers status
  reg           dma_rx_end_frame;        // end of frame, status has been setup
                                         // for the DMA block to sample.
  wire          dma_update_finished;     // DMA update has finished
  reg           rx_end_frame;            // end of frame, status has been setup
                                         // for the register block to sample.
  wire          reg_update_finished;     // Register update has finished
  wire          update_in_progress;      // Either the DMA or Register block
                                         // status update is still in progress.
  wire          update_finished;         // Pulsed when both updates to DMA
                                         // and register block have finished.
  // CRC error detection in incoming frame
  reg    [31:0] crc_h;                   // used for calculating received crc
  reg           crc_error_reg;           // indicates good or bad crc, updated
                                         // with every byte received
  wire   [31:0] rx_stripe_out0;          // used for crc generation
  wire   [31:0] rx_stripe_out1;          // used for crc generation
  wire   [31:0] rx_stripe_out2;          // used for crc generation
  wire   [31:0] rx_stripe_out3;          // used for crc generation
  wire   [31:0] rx_stripe_out4;          // used for crc generation
  wire   [31:0] rx_stripe_out5;          // used for crc generation
  wire   [31:0] rx_stripe_out6;          // used for crc generation
  wire   [31:0] rx_stripe_out7;          // used for crc generation
  wire   [31:0] rx_stripe_out8;          // used for crc generation
  wire   [31:0] rx_stripe_out9;          // used for crc generation
  wire   [31:0] rx_stripe_out10;         // used for crc generation
  wire   [31:0] rx_stripe_out11;         // used for crc generation
  wire   [31:0] rx_stripe_out12;         // used for crc generation
  wire   [31:0] rx_stripe_out13;         // used for crc generation
  wire   [31:0] rx_stripe_out14;         // used for crc generation
  wire   [31:0] rx_stripe_out15;         // used for crc generation


  // ARP request detection
  reg     [3:0] arp_count;               // Used for identifying ARP fields.
  wire    [3:0] arp_count_nxt;           // Next value of arp_count.
  reg           arp_req_frame;           // ARP request frame detected

  // Wake-on-LAN assertion
  wire    [3:0] wol_mask_rck;            // double synch wol_mask input
  reg           wol;                     // Wake-on-LAN output
  reg     [5:0] wol_drive_cnt;           // counts 64 rx_clks for wol output
  wire    [5:0] wol_drive_cnt_nxt;       // next value of wol_drive_cnt

  // Matches for screener module - Queue Priority
  wire    [7:0] ip_v4_tos;               // value of ipv4 TOS.
  wire    [7:0] ip_v6_tc;                // value of ipv6 TC.
  wire   [15:0] udp_dest_addr;           // value of UDP Destination Addr.
  wire    [3:0] queue_ptr_rx_scn;        // Priority queue number
  wire   [15:0] scr2_match_vec;          // Raw match from screener 2
  wire          reset_queue_ptr;         // Reset default queue
  reg     [3:0] queue_ptr_rx;            // Priority queue number
  reg           queue_ptr_rx_enable;     // Pass the queue pointr to pbuf


  // Indicate datapath width. In gigabit TBI this is 16 bits, in
  // 10/100 SGMII or GMII this is 8 bits, in MII it is 4 bits
  wire          data_in_8bits;           // true if GMII or 10/100 SGMII
  wire          data_in_16bits;          // true if gigabit tbi


  // PFC pause frame signals
  wire          pfc_pause_frame;         // rx PFC pause_frame decoded
  reg           pfc_pause_frame_saved;   // PFC pause_frame saved at end frame
  wire    [15:0] new_pfc_pause_time0;    // value of decoded new PFC pause time
                                         // for priority 0
  wire    [15:0] new_pfc_pause_time1;    // value of decoded new PFC pause time
                                         // for priority 1
  wire    [15:0] new_pfc_pause_time2;    // value of decoded new PFC pause time
                                         // for priority 2
  wire    [15:0] new_pfc_pause_time3;    // value of decoded new PFC pause time
                                         // for priority 3
  wire    [15:0] new_pfc_pause_time4;    // value of decoded new PFC pause time
                                         // for priority 4
  wire    [15:0] new_pfc_pause_time5;    // value of decoded new PFC pause time
                                         // for priority 5
  wire    [15:0] new_pfc_pause_time6;    // value of decoded new PFC pause time
                                         // for priority 6
  wire   [15:0]  new_pfc_pause_time7;    // value of decoded new PFC pause time
                                         // for priority 7
  reg            new_pfc_pause_tog;      // indicates a new PFC pause time rxed


  wire   [15:0] pfc_pause_time0;       // decoded PFC pause time (priority 0)
  wire   [15:0] pfc_pause_time1;       // decoded PFC pause time (priority 1)
  wire   [15:0] pfc_pause_time2;       // decoded PFC pause time (priority 2)
  wire   [15:0] pfc_pause_time3;       // decoded PFC pause time (priority 3)
  wire   [15:0] pfc_pause_time4;       // decoded PFC pause time (priority 4)
  wire   [15:0] pfc_pause_time5;       // decoded PFC pause time (priority 5)
  wire   [15:0] pfc_pause_time6;       // decoded PFC pause time (priority 6)
  wire   [15:0] pfc_pause_time7;       // decoded PFC pause time (priority 7)

  wire    [7:0] rx_pfc_paused;         // each bit is set when PFC frame has
                                       // been received and the associated
                                       // PFC counter != 0
  reg           pfc_negotiate;         // indicates at least one PFC pause
                                       // frame has beenreceived
  wire    [7:0] priority_enable;       // PFC pasue operands to enable
                                       // the corresponding time_vector
                                       // field
  wire    [7:0] new_priority_enable;   // priority enable of new PFC pause
                                       // frame
  wire   [13:0] jumbo_max_length;      // jumbo packet max length

  wire   [6:0]  index_cnt_sof;
  wire   [6:0]  index_cnt_type;
  wire   [6:0]  index_cnt_l3;
  wire   [6:0]  index_cnt_l4;
  wire   [32:0] scr2_compare_match;    // Type 2 ext screening compare match bus
  wire   [8:0]  scr2_ethtype_match;    // Type 2 ext screening ethtype match bus
  wire   [10:0] udptcp_offset;
  reg    [10:0] udptcp_offset_str;
  wire   [1:0]  udptcp_offset_str_par;
  reg    [11:0] pld_offset_str;
  wire          set_last_aligned_data,pld_offset_vld;
  wire          sof_rx_tog;            // Toggle version of sof_tx
  wire   [77:0] tsu_ptp_rx_timer_out;  // Timestamp in PCLK domain
  wire   [9:0]  tsu_ptp_rx_timer_prty_out;    // RAS - parity protection for tsu_ptp_rx_timer_out
  reg           rx_dv_bp;              // Data detection for backpressure

  wire          final_eop_push;        // Signal to write end to FIFO i/f

  wire          rx_br_halt_pipe;       // Registered version of rx_br_halt
  wire          scr_drop_frame;        // indicates the screeners (types 1 or 2) are dropping a frame on a match
  reg           scr_drop_frame_saved;
  wire          rx_drop_frame;
  wire          scr2_rate_lim_drop;

  wire          ext_has_2vlans;       // 2 VLANs were detected

  assign data_in_8bits = (~tbi & gigabit) | (tbi & ~gigabit);
  assign data_in_16bits = (tbi & gigabit);


  // RX state machine labels
  parameter
     RX_IDLE      = 2'b00,             // RX idle state
     RX_PREAMBLE  = 2'b01,             // RX preamble state
     RX_DATA      = 2'b10,             // RX data state
     RX_CARR_EXT  = 2'b11;             // RX carrier extension state

  // define magic packet state machine states
  parameter
     RX_MP_WAIT_SYNC1 = 4'b0000,       // waiting for first FF
     RX_MP_WAIT_SYNC2 = 4'b0001,       // waiting for second FF
     RX_MP_WAIT_SYNC3 = 4'b0010,       // waiting for third FF
     RX_MP_WAIT_SYNC4 = 4'b0011,       // waiting for fourth FF
     RX_MP_WAIT_SYNC5 = 4'b0100,       // waiting for fifth FF
     RX_MP_WAIT_SYNC6 = 4'b0101,       // waiting for sixth FF
     RX_MP_WAIT_ADD1  = 4'b0110,       // waiting for spec_add1
     RX_MP_WAIT_ADD2  = 4'b0111,       // waiting for spec_add1
     RX_MP_WAIT_ADD3  = 4'b1000,       // waiting for spec_add1
     RX_MP_WAIT_ADD4  = 4'b1001,       // waiting for spec_add1
     RX_MP_WAIT_ADD5  = 4'b1010,       // waiting for spec_add1
     RX_MP_WAIT_ADD6  = 4'b1011,       // waiting for spec_add1
     RX_MP_WAIT_CRC   = 4'b1100;       // waiting for good CRC

  // define valid ARP request opcode
  parameter
     ARP_REQ_OP = 16'h0001;            // Valid ARP request opcode


// -----------------------------------------------------------------------------
// Beginning of code
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// Synchronised APB control signals to rx_clk domain
// -----------------------------------------------------------------------------

  // Synchronise enable_receive and ptp_unicast_ena signals
  // This is generated in the PCLK domain within the registers block
  // and can change dynamically.
  // Hence full metastability protection is applied.
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_enable_receive (
     .clk(rx_clk),
     .reset_n(n_rxreset),
     .din(enable_receive),
     .dout(enable_receive_rck));

  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_ptp_unicast_ena (
     .clk(rx_clk),
     .reset_n(n_rxreset),
     .din(ptp_unicast_ena),
     .dout(ptp_unicast_ena_rck));

  // synchronise retry_test signal from pclk domain to rx_clk domain.
  // only used for test so single sync register is adequate
  always@(posedge rx_clk or negedge n_rxreset)
  begin
     if (~n_rxreset)
        // asynchronous reset.
        retry_test_rck <= 1'b0;
     else
        retry_test_rck <= retry_test;
  end

  // synchronise pause_enable from the PCLK domain to rx_clk
  // This is generated in the PCLK domain within the registers block
  // and can change dynamically.
  // Hence full metastability protection is applied.
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_pause_enable (
     .clk(rx_clk),
     .reset_n(n_rxreset),
     .din(pause_enable),
     .dout(pause_enable_rck));
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_pfc_enable (
     .clk(rx_clk),
     .reset_n(n_rxreset),
     .din(pfc_enable),
     .dout(pfc_enable_rck));


  // synchronize ext_rxq_sel_en
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_ext_rxq_sel_en(
     .clk(rx_clk),
     .reset_n(n_rxreset),
     .din(ext_rxq_sel_en),
     .dout(ext_rxq_sel_en_rck));


// -----------------------------------------------------------------------------
// Synchronise GMII/MII & PCS interface signals
// -----------------------------------------------------------------------------

  // These signals are synchronous to the incoming clocks but are
  // resynchronised here for I/O timing.
  // Full metastability protection is therefore NOT required.
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      begin
        rxd_gmii_sync   <= {1'b0,8'h00};  // parity and rxd_gmii
        rx_er_gmii_sync <= 1'b0;
        rx_dv_gmii_sync <= 1'b0;
      end
    else
      begin
        // GMII/MII interface
        rxd_gmii_sync   <= rxd_gmii;
        rx_er_gmii_sync <= rx_er_gmii;
        rx_dv_gmii_sync <= rx_dv_gmii;
      end
  end

  // Only generate the synchronization for the rx_br_halt
  // signal when 802p3_br is defined, otherwise tie it to zero.
  // Note: this is going to be reported as unmapped keypoint in LEC
  // anyway if we are in 802p3_br configuration and this is the eMAC,
  // as the MMSL only drives it to the pMAC, but still, if no br is defined 
  // this way of coding will avoid to get any unmapped point for that register.
  generate if (p_edma_has_br == 1'b1) begin: gen_rx_br_halt_sync_logic
    reg rx_br_halt_pipe_r;
    always @(posedge rx_clk or negedge n_rxreset)
    begin
      if (~n_rxreset)
        rx_br_halt_pipe_r <= 1'b0;
      else 
        rx_br_halt_pipe_r <= rx_br_halt;
    end    
    assign rx_br_halt_pipe = rx_br_halt_pipe_r;
  end else begin: no_gen_rx_br_halt_sync_logic
    assign rx_br_halt_pipe = 1'b0;
  end
  endgenerate
  
  // Only generate the synchronization for the PCS signals
  // if the PCS is defined in the defs file, otherwise just 
  // tie them to zero. This will avoid to create registers 
  // in first place, which would be optimized out by 
  // the synt and PandR tool and cause reports of unmapped 
  // keypoints during LEC 
  generate if (p_edma_has_pcs == 1'b1) begin: gen_pcs_sync_logic
    reg [15:0] rxd_pcs_sync_r;
    reg  [1:0] rxd_pcs_par_sync_r;
    reg  [1:0] rx_er_pcs_sync_r;
    reg  [1:0] rx_dv_pcs_sync_r;
    always @(posedge rx_clk or negedge n_rxreset)
    begin
      if (~n_rxreset)
        begin
          rxd_pcs_sync_r     <= 16'h0000;
          rxd_pcs_par_sync_r <= 2'b00;
          rx_er_pcs_sync_r   <= 2'b00;
          rx_dv_pcs_sync_r   <= 2'b00;
        end
      else
        begin
          rxd_pcs_sync_r     <= rxd_pcs;
          rxd_pcs_par_sync_r <= rxd_pcs_par;
          rx_er_pcs_sync_r   <= rx_er_pcs;
          rx_dv_pcs_sync_r   <= rx_dv_pcs;
        end
    end
    assign rxd_pcs_sync       = rxd_pcs_sync_r;    
    assign rxd_pcs_par_sync   = rxd_pcs_par_sync_r;
    assign rx_er_pcs_sync     = rx_er_pcs_sync_r;
    assign rx_dv_pcs_sync     = rx_dv_pcs_sync_r;
  end else begin: no_gen_pcs_sync_logic
    assign rxd_pcs_sync       = 16'h0000;
    assign rxd_pcs_par_sync   = 2'b00;
    assign rx_er_pcs_sync     = 2'b00;
    assign rx_dv_pcs_sync     = 2'b00;
  end
  endgenerate
  

// -----------------------------------------------------------------------------
// Multiplex GMII/MII & PCS interface signals to make easier to reference
// -----------------------------------------------------------------------------

  // Data Indicator for backpressure application.
  // No need for rx_br_halt_pipe here as irrelevant once frame has started.
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      rx_dv_bp <= 1'b0;
    else
      rx_dv_bp <= rx_dv_int[0] | rx_dv_int[1];
  end

  // Select RXD source
  assign rxd_int[17:0] = (data_in_16bits)?    {rxd_pcs_par_sync,
                                               rxd_pcs_sync[15:0]} :  // Gig TBI
                                    (tbi)? {{2{rxd_pcs_par_sync[0]}},
                                               rxd_pcs_sync[7:0],     // 10/100
                                               rxd_pcs_sync[7:0]} :   // SGMII
                                (gigabit)? {{2{rxd_gmii_sync[8]}},
                                               rxd_gmii_sync[7:0],    // GMII
                                               rxd_gmii_sync[7:0]} :  // MII
                                           {{2{rxd_gmii_sync[8]}},
                                               rxd_gmii_sync[3:0],
                                               rxd_gmii_sync[3:0],
                                               rxd_gmii_sync[3:0],
                                               rxd_gmii_sync[3:0]};

  // Select RX_DV source (one bit per byte)
  assign rx_dv_int[1:0] = (data_in_16bits)? {rx_dv_pcs_sync[1],
                                             rx_dv_pcs_sync[0]} :
                                     (tbi)? {rx_dv_pcs_sync[0],
                                             rx_dv_pcs_sync[0]} :
                                            {rx_dv_gmii_sync,
                                             rx_dv_gmii_sync};

  // Select RX_ER source (one bit per byte)
  assign rx_er_in[1:0]  = (data_in_16bits)? {rx_er_pcs_sync[1],
                                             rx_er_pcs_sync[0]} :
                                     (tbi)? {rx_er_pcs_sync[0],
                                             rx_er_pcs_sync[0]} :
                                            {rx_er_gmii_sync,
                                             rx_er_gmii_sync};

  // ignore rx_er when rx_dv is low if necessary
  always @(*)
    if (ign_ipg_rx_er)
      rx_er_int[1:0] = rx_er_in & rx_dv_int;
    else
      rx_er_int[1:0] = rx_er_in;


// --------------------------------------------------------------------------
// detect reception of Low Power Idle
// set when LPI is detected
// reset when normal idle is detected
// Don't need to look at rx_br_halt_pipe as always want to monitor for LPI..
// --------------------------------------------------------------------------
  always @(posedge rx_clk or negedge n_rxreset)
  begin
     if(~n_rxreset)
       lpi_indicate <= 1'b0;
     else
       begin
          // Gig TBI
          if (data_in_16bits)
            begin
               if ((rx_dv_int == 2'b00) &
                   ((rx_er_in == 2'b11) & (rxd_int[15:0] == 16'h0101) |
                    (rx_er_in == 2'b01) & (rxd_int[15:0] == 16'h0001) |
                    (rx_er_in == 2'b10) & (rxd_int[15:0] == 16'h0100)))
                    lpi_indicate <= 1'b1;
               else if ((rx_er_in == 2'b00) | (rxd_int[15:0] == 16'h0000))
                         lpi_indicate <= 1'b0;
            end
          // 10/100 TBI or GMII
          else if (tbi | gigabit)
            begin
               if ((rx_dv_int == 2'b00) &
                   ((rx_er_in == 2'b11) & (rxd_int[15:0] == 16'h0101)))
                   lpi_indicate <= 1'b1;
               else if ((rx_er_in != 2'b11) | (rxd_int[15:0] != 16'h0101))
                          lpi_indicate <= 1'b0;
            end
          else // MII
            begin
               if ((rx_dv_int == 2'b00) &
                   ((rx_er_in == 2'b11) & (rxd_int[15:0] == 16'h1111)))
                   lpi_indicate <= 1'b1;
               else if ((rx_er_in != 2'b11) | (rxd_int[15:0] != 16'h1111))
                          lpi_indicate <= 1'b0;
            end
       end
  end


// -----------------------------------------------------------------------------
// Validate incoming data and build into 16 bit current data buffer
// All RXD is validated with RX_DV or RX_ER, and placed into a 16 bit
// buffer (curr_data_16).
// The loading of this buffer needs to work in nibbles to cope with MII.
// -----------------------------------------------------------------------------

  // Current Nibble Pointer
  // Used to keep track of current nibble being written to in current data
  // buffer. Incremented depending on interface mode selected only when
  // rx_dv or rx_er are active.
  // Also increment on curr_rx_dv or curr_rx_er to ensure that always
  // see two bytes without valid data at end of frame. This ensures proper
  // edge detection and flushing through of data.
  // Halt pipeline with rx_br_halt_pipe
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      nibble_pntr <= 2'b00;
    else
      if (~enable_receive_rck)
        nibble_pntr <= 2'b00;
      else if (rx_br_halt_pipe)
        nibble_pntr <= nibble_pntr;
      else if ((rx_dv_int != 2'b00) | (rx_er_int != 2'b00) |
               (curr_rx_dv != 2'b00) | (curr_rx_er != 2'b00))
        nibble_pntr <= next_nibble_pntr[1:0];
      else
        nibble_pntr <= 2'b00;
  end


  // Nibble pointer increment
  // This depends on the mode selected. Also if there is an odd number of
  // preamble in 10/100 mode then skip one and force in new preamble nibble.
  assign nibble_pntr_inc =
                      (data_in_16bits)? 3'b100 : // Gig TBI mode
     (data_in_8bits | odd_pre_nibbles)? 3'b010 : // GMII mode or
                                                 // MII mode & odd number
                                                 // of preamble
                                        3'b001 ; // MII mode (normal)


  // decode next nibble pointer value (extra bit for full/overflow)
  assign next_nibble_pntr = {1'b0, nibble_pntr[1:0]} + nibble_pntr_inc[2:0];


  // Detect that previous was a "5".
  // Use pointer to next location to be filled to work out what previous was.
  // This is used for detecting an odd number of preamble in 10/100 mode.
  always @(*)
  begin
     case (nibble_pntr[1:0])
        2'b11   : prev_nibble_was_pre = (curr_data_16[11:8]  == 4'h5);
        2'b10   : prev_nibble_was_pre = (curr_data_16[7:4]   == 4'h5);
        2'b01   : prev_nibble_was_pre = (curr_data_16[3:0]   == 4'h5);
        default : prev_nibble_was_pre = (curr_data_16[15:12] == 4'h5);
     endcase
  end


  // Detect when receiving an odd number of preamble nibbles in 10/100 mode.
  // This will be indicated when receiving the "D" nibble of the SFD and
  // we are supposed to write it to either nibble 0 or 2 of the current data
  // buffer. Note that the previous nibble must be a "5" to be SFD.
  // If this happens an extra preamble nibble will be inserted so that the
  // "D" SFD nibble now appears in nibble 1 or 3 of the current data buffer.
  assign odd_pre_nibbles = ~rx_state_data & ~gigabit & ~tbi & ~valid_sfd &
                           (rxd_int[3:0] == 4'hd) & prev_nibble_was_pre &
                           ((nibble_pntr == 2'b00) | (nibble_pntr == 2'b10));


  // determine if current data buffer is full
  // Current data buffer is full if about to increment and next_nibble_pntr is
  // indicating full or overflow. This signal is used to pass the data in
  // curr_data_16 onto the next stage.
  always @(posedge rx_clk or negedge n_rxreset)
  begin
     if (~n_rxreset)
       curr_buf_full <= 1'b0;
     else if (~enable_receive_rck)
       curr_buf_full <= 1'b0;
     else if (~rx_br_halt_pipe)
       curr_buf_full <= next_nibble_pntr[2];
  end


  // 16-bit Current data buffer
  // Forms incoming RXD into 16 bit words, by loading up next location pointed
  // to by nibble_pntr.
  // Buffer is always filled to the top of the buffer, and then overwritten
  // by next access. This makes this filling independent of mode.
  always @(posedge rx_clk or negedge n_rxreset)
  begin
     if (~n_rxreset)
       curr_data_16 <= {2'b00,16'h0000}; // 2{parity}, 2{data}

     // Halt datapath
     else if (rx_br_halt_pipe)
       curr_data_16 <= curr_data_16;

     // clear buffer when receive is disabled and at end of frame when there
     // is to be no carrier extension. The later prevents any residue CRC
     // data causing problems.
     else if (~enable_receive_rck | (end_of_frame & rx_state_data))
       curr_data_16 <= {2'b00,16'h0000}; // 2{parity}, 2{data}

     // If there has been an odd number of preamble nibbles detected then
     // need to force "5" at current pointer and a "d" at next nibble.
     // pointer will automatically increment by two to compensate.
     // odd_pre_nibbles is only set for nibble_pntr values of 0 or 2.
     else if (odd_pre_nibbles)
        begin
          case (nibble_pntr[1:0])
             2'b10   : begin
                         curr_data_16[11:8]  <= 4'h5;
                         curr_data_16[15:12] <= 4'hd;
                         curr_data_16[17]    <= 1'b1;  // Parity
                       end
             default : begin // will only be nibble_pntr == 2'b00
                         curr_data_16[3:0]   <= 4'h5;
                         curr_data_16[7:4]   <= 4'hd;
                         curr_data_16[16]    <= 1'b1; // parity
                       end
          endcase
        end

     // Otherwise load next nibble pointed to by nibble_pntr with rxd_int.
     else
       begin
         case (nibble_pntr[1:0])
           2'b11   : {curr_data_16[17],curr_data_16[15:12]}    <= {rxd_int[16],rxd_int[3:0]};
           2'b10   : {curr_data_16[17],curr_data_16[15:8]}     <= {rxd_int[16],rxd_int[7:0]};
           2'b01   : {curr_data_16[17:16],curr_data_16[15:4]}  <= {rxd_int[17:16],rxd_int[11:0]};
           default : curr_data_16[17:0]                        <=  rxd_int[17:0];
         endcase
       end
  end


  // Current interface selection (GMII, MII or PCS)
  // Selects source for RX_ER and RX_DV, depending on interface
  // mode selected in the registers block, indicated by data_in_8bits
  // and data_in_16bits signals.
  // Update the RX_DV and RX_ER only when either of the 2 bytes
  // in the curr_data_16 buffer are about to be complete. This
  // is detemined by the mode and the current nibble offset pointer
  always @(posedge rx_clk or negedge n_rxreset)
  begin
     if (~n_rxreset)
       begin
         curr_rx_dv     <= 2'b00;
         curr_rx_er     <= 2'b00;
       end
     else if (~enable_receive_rck)
       begin
         curr_rx_dv     <= 2'b00;
         curr_rx_er     <= 2'b00;
       end

     // Halt datapath
     else if (rx_br_halt_pipe)
       begin
         curr_rx_dv     <= curr_rx_dv;
         curr_rx_er     <= curr_rx_er;
       end

     // If there has been an odd number of preamble nibbles detected then
     // pointer will automatically increment by two to compensate, therefore
     // need to tag correct rx_dv and rx_er bytes. (10/100 mode only)
     // Only signalled when nibble_pntr is 0 or 2.
     // Odd number of preamble nibbles detected and nibble_pntr is 0.
     else if (odd_pre_nibbles & (nibble_pntr == 2'b00))
       begin
         curr_rx_dv[0]   <= rx_dv_int[0];
         curr_rx_er[0]   <= rx_er_int[0];
       end

     // Odd number of preamble nibbles detected and nibble_pntr is 2.
     else if (odd_pre_nibbles & (nibble_pntr == 2'b10))
       begin
         curr_rx_dv[1]   <= rx_dv_int[1];
         curr_rx_er[1]   <= rx_er_int[1];
       end

     else
       begin
         case ({nibble_pntr[1:0], data_in_8bits, data_in_16bits})

            // MII nibble mode (4 bits)
            // Only update curr_rx_dv on byte boundary, so that odd nibbles
            // are not passed through data stream.
            // Any occurance of rx_er_int in either nibble must be saved for
            // symbol error detection. Since curr_rx_er is later gated with
            // curr_rx_dv, symbol errors on the odd nibble of an missaligned
            // frame cannot be detected.
            4'b11_00: begin
                        curr_rx_dv[1]   <= rx_dv_int[1];
                        curr_rx_er[1]   <= rx_er_int[1] | curr_rx_er[1];
                      end
            4'b10_00: begin
                        curr_rx_dv[1]   <= curr_rx_dv[1];
                        curr_rx_er[1]   <= rx_er_int[1];
                      end
            4'b01_00: begin
                        curr_rx_dv[0]   <= rx_dv_int[0];
                        curr_rx_er[0]   <= rx_er_int[0] | curr_rx_er[0];
                      end
            4'b00_00: begin
                        curr_rx_dv[1:0] <= 2'b00;
                        curr_rx_er[1:0] <= {1'b0, rx_er_int[0]};
                      end

            // GMII mode or 10/100 SGMII (8 bits)
            4'b10_10: begin
                        curr_rx_dv[1]   <= rx_dv_int[1];
                        curr_rx_er[1]   <= rx_er_int[1];
                      end
            4'b00_10: begin
                        curr_rx_dv[0]   <= rx_dv_int[0];
                        curr_rx_er[0]   <= rx_er_int[0];
                        curr_rx_dv[1]   <= 1'b0;
                        curr_rx_er[1]   <= 1'b0;
                      end

            // Gigabit TBI mode (16 bits)
            default : begin
                        curr_rx_dv[1:0] <= rx_dv_int[1:0];
                        curr_rx_er[1:0] <= rx_er_int[1:0];
                      end
         endcase
       end
  end


// -----------------------------------------------------------------------------
// Distinguish between SFD, preamble, carrier extension and valid data nibbles
// -----------------------------------------------------------------------------

  // Detect SFD
  // -----------------
  // Detect any bytes that have SFD in them
  assign det_sfd[1:0] = {(curr_data_16[15:8] == 8'hd5),
                         (curr_data_16[7:0]  == 8'hd5)};

  // Qualify detection of SFD
  // Only detect when curr_rx_dv is high, and then only select
  // first instance of SFD occurance.
  assign det_sfd_qual[1:0] = (det_sfd[0] & curr_rx_dv[0])? 2'b01 :
                             (det_sfd[1] & curr_rx_dv[1])? 2'b10 :
                                                           2'b00 ;

  // Valid SFD is detected when any of the detect bits are matched
  // and curr_buf_full is valid
  assign valid_sfd = (det_sfd_qual != 2'b00) & curr_buf_full;


  // Detect preamble
  // -----------------
  // detect any bytes that have preamble in them. If we are not
  // checking for good pre-amble then force detection of good
  // pre-amble. Doing this ensures UNH test 4.1.9 will pass
  assign det_pre[1:0] = (rx_bad_preamble)? 2'b11 :
                                          {(curr_data_16[15:8] == 8'h55),
                                           (curr_data_16[7:0]  == 8'h55)};

  // qualify detection of preamble
  // If SFD in lower byte then can't be any preamble in buffer.
  // If SFD is in upper byte then lower byte must contain preamble if
  // rx_dv is set. If rx_dv is not set then force preamble in lower
  // byte to keep state machine happy.
  // Else if no SFD present then detect only preamble in bytes with rx_dv.
  assign det_pre_qual =
     (det_sfd_qual[0])?  2'b00 :
     (det_sfd_qual[1])? {1'b0,((det_pre[0] & curr_rx_dv[0]) | ~curr_rx_dv[0])}:
                        det_pre[1:0] & curr_rx_dv[1:0];

  // ensure that all bytes before SFD are correct preamble
  // This signal is only set when curr_buf_full is valid
  // If SFD in lower byte then force valid_pre.
  // Else if SFD in upper byte then det_pre_qual[0] must be high.
  // Else if no SFD detected then valid pre is active if latest byte (upper)
  // has qualified preamble
  assign valid_pre =
     (det_sfd_qual[0])? curr_buf_full :
     (det_sfd_qual[1])? det_pre_qual[0] & curr_buf_full:
                        det_pre_qual[1] & curr_buf_full;


  // Detect valid data
  // -----------------
  // Detect which bytes contain valid data
  // Don't include preamble or SFD when not in RX_DATA state.
  assign det_data =
            curr_rx_dv &
            ~((det_sfd_qual | det_pre_qual) & {2{~rx_state_data}});


  // valid_data indicates when a new 16-bit data word containing
  // valid data is ready to analyse.
  // Need also to ensure that this is part of a valid ongoing frame.
  assign valid_data = (det_data != 2'b00) & frame_being_decoded &
                       (curr_buf_full | end_of_data);



  // Detect carrier extension
  // ------------------------
  // Detect carrier extension
  // Carrier extension is defined as RX_DV low and RX_ER high.
  // RXD should also be the value 0x0f, but this will not be checked
  // in this implementation. Instead carrier extension error will be checked.
  assign det_cxt[1:0] = curr_rx_er & ~curr_rx_dv;

  // valid_cxt indicates when a new 16-bit data word containing
  // valid carrier extension is ready to analyse and either in
  // carrier extend state or about to go into it.
  assign valid_cxt = (rx_state_carr_ext | start_of_carr_ext) &
                     (det_cxt != 2'b00) & (curr_buf_full | end_of_carr_ext);



  // Detect code errors
  // ------------------
  // Detect any bytes that have carrier extension error in them
  assign det_cxt_err[1:0] = {(curr_data_16[15:8]  == 8'h1f),
                             (curr_data_16[7:0]   == 8'h1f)};

  // qualify detection of carrier extension error with RX_DV and RX_ER
  assign det_cxt_err_qual = det_cxt_err & ~curr_rx_dv & curr_rx_er;

  // detect carrier extension error if any of the nibbles contain
  // the carrier extension code (0x1f) and already in or about to
  // enter carrier extension state
  assign valid_cxt_err = (rx_state_carr_ext | start_of_carr_ext) &
                         (det_cxt_err_qual != 2'b00) & curr_buf_full;

  // detect RX_ER assertion during RX_DV asserted (code error)
  // This is will cause a symbol error or jabber error or both
  assign valid_code_err = |(rx_dv_int & rx_er_int);

  // hold rx_er until end of frame
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      code_error <= 1'b0;
    else if (rx_br_halt_pipe)
      code_error <= code_error;
    else if (end_of_frame | ~enable_receive_rck | rx_state_idle)
      code_error <= 1'b0;
    else if (valid_cxt_err | valid_code_err)
      code_error <= 1'b1;
    else
      code_error <= code_error;
  end

// -----------------------------------------------------------------------------
// Detect start and end of frame and the beginning of carrier extension
//  -----------------------------------------------------------------------------

  // Edge detection for Start/End of frame and carrier extension recognition
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      begin
        rx_dv_int_del <= 2'b00;
        rx_er_int_del <= 2'b00;
      end
    else if (~rx_br_halt_pipe)
      begin
        rx_dv_int_del <= rx_dv_int;
        rx_er_int_del <= rx_er_int & ~rx_dv_int;
      end
  end

  // Detect edges on selected RX_DV and RX_ER
  // These will be used for start and end of frame detections
  // Only detect when both bits are high or low (this only affects
  // PCS operation)
  // Exclude symbol errors from rx_er edge detection as it is only used for
  // detecting start and end of carrier extension.
  assign rx_dv_int_le=  (rx_dv_int == 2'b11) & (rx_dv_int_del != 2'b11);
  assign rx_dv_int_te=  (rx_dv_int == 2'b00) & (rx_dv_int_del != 2'b00);
  assign rx_er_int_le=  (&(rx_er_int & ~rx_dv_int)) & (rx_er_int_del != 2'b11);
  assign rx_er_int_te= ~(&(rx_er_int & ~rx_dv_int)) & (rx_er_int_del == 2'b11);


  // define start of data condition
  // This is when we are about to enter the RX_DATA state from RX_PREAMBLE
  // Also gated with rx_dv_int to show that there is some valid data as well.
  assign start_of_data = enable_receive_rck & valid_pre & valid_sfd &
                         |rx_dv_int & rx_state_preamble;

  // define end of data condition
  // End of data always indicated on falling edge of RX_DV when in
  // RX_DATA state
  assign end_of_data = rx_state_data & rx_dv_int_te;


  // detect start of carrier extension
  // detected by looking for a rising edge on rx_er and rx_dv low,
  // whilst in RX_DATA state (i.e. will exit this state next cycle)
  // Only detect in gigabit half duplex mode.
  assign start_of_carr_ext =
         rx_state_data & ~full_duplex & gigabit & rx_er_int_le;


  // detect end of carrier extension
  // detected by looking for a falling edge on rx_er and in RX_CARR_EXT state.
  assign end_of_carr_ext = rx_state_carr_ext & rx_er_int_te;



  // define end of frame condition
  // end_of_frame always indicated on falling edge of RX_DV if any of the
  // following requirements are met:
  //   1. no valid carrier extension or
  //   2. if slotTime requirement has already been reached or
  //   3. if already in a burst.
  // If already in carrier extension then set end_of_frame...
  //   1. at the falling edge of RX_ER or
  //   2. after slot time has elapsed.
  assign end_of_frame =
            (end_of_data & (~start_of_carr_ext | slot_time_done)) |
            (rx_state_carr_ext & (end_of_carr_ext | slot_time_done));



// -----------------------------------------------------------------------------
// Minimum Slot time counter
// -----------------------------------------------------------------------------
// Must check that ethernet frame meets minimum slot time requirements.
//
// For 10/100 mode this is 512 bit times (or 64 bytes) which must be taken up
// by the data (excluding preamble and SFD). This requirement will be redundant
// since MinFrameSize is checked later.
//
// For Gigabit Full Duplex mode this is 512 bit times (or 64 bytes) which must
// be taken up by the data (excluding preamble and SFD). This requirement will
// be redundant since MinFrameSize is checked later.
//
// For Gigabit half duplex mode this is 4096 bit times (or 512 bytes) which may
// be a combination of data (excluding preamble and SFD) and carrier extension.
//
// For gigabit half duplex mode bursting, the first in a burst must meet the
// above requirement of 512 bytes, but successive frames in a burst need only
// occupy the 64 bytes of data (excluding preamble and SFD). Again the later
// is checked by the MinFrameSize check.


  // Count number of bytes that have valid data or valid carrier extension.
  // Only count if in gigabit half duplex mode or if already in a burst.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
     if (~n_rxreset)
       slot_time_cnt <= 10'b0000000000;
     else if (end_of_frame | ~enable_receive_rck | ~frame_being_decoded |
              ~gigabit | full_duplex | giga_bursting)
       slot_time_cnt <= 10'b0000000000;
     else if ((valid_data | valid_cxt)) // should add in "& ~rx_br_halt_pipe" here if supporting gigabit half duplex which we are not..
       slot_time_cnt <= next_slot_time_cnt[9:0];
     else
       slot_time_cnt <= slot_time_cnt;
  end


  // Count number of bytes that have either valid data or carrier extension
  assign slot_time_cnt_inc = ({1'b0, det_data[0]} +
                              {1'b0, det_data[1]} +
                              {1'b0, det_cxt[0]}  +
                              {1'b0, det_cxt[1]});

  // assign next value for slot time counter (equals current plus increment)
  assign next_slot_time_cnt = slot_time_cnt[9:0] +
                                       {8'h00, slot_time_cnt_inc[1:0]};


  // Decode when required count is reached.
  // Set if new data or carrier extension is available and we have
  // now reached the minimum slotTime requirement.
  // forces to true if not in gigabit half duplex or already bursting.
  assign slot_time_dec = ((valid_data | valid_cxt) &
                         not_min_slot_time & next_slot_time_cnt[9]) |
                         ~gigabit | full_duplex | giga_bursting;


  // Determine whether slot time is too short
  // Starts with the presumption that it is under sized and clears
  // once required count is reached.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      not_min_slot_time <= 1'b1;

    // Halt pipeline
    else if (rx_br_halt_pipe)
      not_min_slot_time <= not_min_slot_time;

    // if finished or not enabled then preset
    else if (end_of_frame | ~enable_receive_rck | ~frame_being_decoded)
      not_min_slot_time <= 1'b1;

    // else if the slot time is decoded reset not_min_slot_time
    else if (slot_time_dec)
      not_min_slot_time <= 1'b0;

    // else maintain value
    else
      not_min_slot_time <= not_min_slot_time;
  end


  // assign a signal to show when slot time is complete
  assign slot_time_done = slot_time_dec | ~not_min_slot_time;


  //detect when in burst mode
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      giga_bursting <= 1'b0;

    // Halt pipeline
    else if (rx_br_halt_pipe)
      giga_bursting <= giga_bursting;

    // if not in correct mode or no valid frame then reset
    else if (~gigabit | ~enable_receive_rck | full_duplex)
      giga_bursting <= 1'b0;

    // maintain bursting until both RX_DV and RX_ER are low
    else if ((curr_rx_dv == 2'b00) & (curr_rx_er == 2'b00) & curr_buf_full)
      giga_bursting <= 1'b0;

    // go into bursting mode if reach slot time
    else if (slot_time_done)
      giga_bursting <= 1'b1;

    // else maintain value
    else
      giga_bursting <= giga_bursting;
  end


// -----------------------------------------------------------------------------
// RX state machine to keep track of current phase during reception
// -----------------------------------------------------------------------------

  // receive state machine. Used for checking and filtering out preamble
  // and SFD.
  // Stay in IDLE when receive is disabled or after a frame is determined bad.
  // Always move to IDLE when bad preamble seen.
  // Move from IDLE to PREAMBLE when a rising edge on RX_DV seen. All data
  // should be preamble until a valid SFD seen. Once SFD seen move to data.
  // If at the end of RX_DATA, carrier extension is detected move into
  // RX_CARR_EXT state, else move back to IDLE.
  // In RX_CARR_EXT wait for either a new frame (bursting) or end
  // of carrier extension (indicated by end_of_frame)
  always @(*)
  begin
    case(rx_state)
       RX_PREAMBLE: // currently receiving preamble

                // Premature end of frame detected
                if (rx_dv_int_te)
                   rx_state_nxt = RX_IDLE;

                // Bad preamble detected
                else if (~valid_pre & curr_buf_full)
                   rx_state_nxt = RX_IDLE;

                // Valid SFD and preamble detected
                else if (start_of_data)
                   rx_state_nxt = RX_DATA;

                // Good preamble, no SFD yet
                else
                   rx_state_nxt = RX_PREAMBLE;


       RX_DATA: // currently receiving data

                // End of frame seen (i.e no carrier extenion)
                if (end_of_frame)
                   rx_state_nxt = RX_IDLE;

                // Beginning of carrier extension detected
                else if (start_of_carr_ext)
                   rx_state_nxt = RX_CARR_EXT;

                // More data to handle
                else
                   rx_state_nxt = RX_DATA;


       RX_CARR_EXT: // Currently receiving carrier extension

                // beginning of new frame detected (bursting)
                if (rx_dv_int_le)
                   rx_state_nxt = RX_PREAMBLE;

                // end of carrier extension detected
                else if (end_of_frame)
                   rx_state_nxt = RX_IDLE;

                // more valid carrier extension to handle
                else
                   rx_state_nxt = RX_CARR_EXT;


       default: // RX_IDLE:
                // IDLE waiting for enable from control register and
                // a leading edge on rx_dv
                if (rx_dv_int_le)
                   rx_state_nxt = RX_PREAMBLE;
                else
                   rx_state_nxt = RX_IDLE;

    endcase
  end

  // synchronise state machine next state logic
  // If rx id disabled then synchronously reset state machine.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      rx_state <= RX_IDLE;
    else if (~enable_receive_rck)
      rx_state <= RX_IDLE;
    else if (~rx_br_halt_pipe)
      rx_state <= rx_state_nxt;
  end

  // decode states to make referencing easier
  assign rx_state_preamble = (rx_state == RX_PREAMBLE);
  assign rx_state_data     = (rx_state == RX_DATA);
  assign rx_state_carr_ext = (rx_state == RX_CARR_EXT);
  assign rx_state_idle     = ~rx_state_preamble & ~rx_state_data &
                             ~rx_state_carr_ext;

// -----------------------------------------------------------------------------
// Detect when a valid frame is being handled by the decoding logic
// -----------------------------------------------------------------------------

  // Detect beginning of valid data and hold until end of frame
  // This is used for enabling/resetting the logic associated with
  // the frame decoding.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      valid_frame_detected <= 1'b0;
    else if (~enable_receive_rck)
      valid_frame_detected <= 1'b0;
    else if (rx_br_halt_pipe)
      valid_frame_detected <= valid_frame_detected;
    else if (start_of_data)
      valid_frame_detected <= 1'b1;

    // Detection of tiny runt frame - ensure this unique case where
    // end_of_frame for runt frame is coincident with decoding_finished
    // from previous frame - this ensures the runt is dropped
    else if (end_of_frame & decoding_finished & pipeline_finished)
      valid_frame_detected <= 1'b0;

    else if (last_aligned_data & (decoding_finished | end_of_frame))
      valid_frame_detected <= 1'b0;
    else
      valid_frame_detected <= valid_frame_detected;
  end

  // frame_being_decoded is combination of the next state being data
  // or already have valid_frame_detected
  assign frame_being_decoded = start_of_data | valid_frame_detected;

  // Hold end of frame until pipeline_finished
  // This will always be after decoding has completed.
  // Special case to reset decoding_finished when only one nibble of
  // data is present in the frame.
  // Don't set decoding_finished if already set.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      decoding_finished <= 1'b0;
    else if (~enable_receive_rck)
      decoding_finished <= 1'b0;
    else if (rx_br_halt_pipe)
      decoding_finished <= decoding_finished;
//    else if (end_of_frame & ~decoding_finished)
    else if (end_of_frame | rx_state_idle) // ETH-1706
      decoding_finished <= 1'b1;
    else if (pipeline_finished |
             (~frame_in_pipeline & ~last_align_data_tag))
      decoding_finished <= 1'b0;
    else
      decoding_finished <= decoding_finished;
  end

// -----------------------------------------------------------------------------
// Buffer to realign valid data after striping out SFD and preamble
// -----------------------------------------------------------------------------
// Strip out Preamble and SFD from incoming 16 bit data and align
// back into a new 16 bit word (new_data_align).
// Incoming data from current data buffer (curr_data_16), includes SFD and
// preamble bytes. These must be removed by only taking valid data bytes
// indicated by det_data[1:0] (i.e either 0, 1 or 2 bytes of valid data
// may be present).
// This valid data must then be re-aligned into a single 16 bit word again.

  // Keep an offset pointer to keep track of current byte being
  // written to in 16 bit alignment buffer.
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      align_pntr <= 1'b0;

    // Halt pipeline
    else if (rx_br_halt_pipe)
      align_pntr <= align_pntr;

    // If receive is disabled reset alignment pointer to byte 0
    else if (~enable_receive_rck | ~frame_being_decoded | last_aligned_data)
      align_pntr <= 1'b0;

    // If last data transfered has overflowed a new transfer will
    // be initiated. Zero pointer after this event
    // Note that if this event doesn't happen then the pointer will
    // already be zero (no overflow)
    else if (force_over_align)
      align_pntr <= 1'b0;

    // When new valid data available, assign align_pntr to new value
    else if (valid_data)
      align_pntr <= next_align_pntr;

    // Else maintain value
    else
      align_pntr <= align_pntr;
  end


  // Decode next state of alignment buffer.
  // Need to know next offset value (next_align_pntr), whether the buffer
  // will be full on the next clock (next_align_full), and whether the buffer
  // will overflow (next_align_overflow).
  // Decoding depends on current offset (align_pntr) and number of new data
  // bytes (det_data).
  always @(det_data or align_pntr)
  begin
    case ({det_data, align_pntr})
       3'b00_0 : begin // nothing in buffer, nothing new
                   next_align_pntr     = 1'b0;
                   next_align_full     = 1'b0;
                   next_align_overflow = 1'b0;
                 end

       3'b00_1 : begin // one byte in buffer, nothing new
                   next_align_pntr     = 1'b1;
                   next_align_full     = 1'b0;
                   next_align_overflow = 1'b0;
                 end

       3'b01_0 : begin // nothing in buffer, one byte new
                   next_align_pntr     = 1'b1;
                   next_align_full     = 1'b0;
                   next_align_overflow = 1'b0;
                 end

       3'b01_1 : begin // one byte in buffer, one byte new
                   next_align_pntr     = 1'b0;
                   next_align_full     = 1'b1;
                   next_align_overflow = 1'b0;
                 end

       3'b10_0 : begin // nothing in buffer, one byte new
                   next_align_pntr     = 1'b1;
                   next_align_full     = 1'b0;
                   next_align_overflow = 1'b0;
                 end

       3'b10_1 : begin // one byte in buffer, one byte new
                   next_align_pntr     = 1'b0;
                   next_align_full     = 1'b1;
                   next_align_overflow = 1'b0;
                 end

       3'b11_0 : begin // nothing in buffer, two bytes new
                   next_align_pntr     = 1'b0;
                   next_align_full     = 1'b1;
                   next_align_overflow = 1'b0;
                 end

       default : begin //3'b11_1
                   next_align_pntr     = 1'b1;
                   next_align_full     = 1'b1;
                   next_align_overflow = 1'b1;
                 end
    endcase
  end

  // Indicate when there has been an overflow of the alignment buffer.
  // This will be used to force the residue back into the alignment buffer,
  // ready for the next new data or at the end of a frame.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      prev_align_overflowd <= 1'b0;
    else if (rx_br_halt_pipe)
      prev_align_overflowd <= prev_align_overflowd;
    else if (~enable_receive_rck | ~frame_being_decoded | last_aligned_data)
      prev_align_overflowd <= 1'b0;
    else if (next_align_overflow & valid_data)
      prev_align_overflowd <= 1'b1;
    else if (valid_data | force_over_align)
      prev_align_overflowd <= 1'b0;
    else
      prev_align_overflowd <= prev_align_overflowd;
  end

  // detect when final data in frame loaded into the alignment buffer
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      last_aligned_data <= 1'b0;
    else if (~enable_receive_rck)
      last_aligned_data <= 1'b0;
    else if (rx_br_halt_pipe)
      last_aligned_data <= last_aligned_data;
    else if (set_last_aligned_data)
      last_aligned_data <= 1'b1;
    else if (~frame_being_decoded | decoding_finished)
      last_aligned_data <= 1'b0;
    else
      last_aligned_data <= last_aligned_data;
  end

  assign set_last_aligned_data = ((end_of_data & valid_data & ~next_align_overflow) |
                                  (end_of_data & ~valid_data & ~prev_align_overflowd) |
                                   force_over_align);


  // async assign last_align_data_tag for writing into pipeline, so that
  // special case of missaligned 10/100 nibble frame is recognised.
  assign last_align_data_tag = last_aligned_data | last_odd_nibble;


  // Detect when an missaligned 10/100 nibble frame forces the last data
  // into the alignment buffer. Not set when a force_over_align is done.
  assign last_odd_nibble = nibble_pntr[0] & end_of_data &
                           ~((valid_data & next_align_overflow) |
                             (~valid_data & prev_align_overflowd));


  // force overflow to be transfered to alignment buffer at end_of_data.
  // If there is more valid data, then force overflow into the alignment
  // buffer if there will be further overflow once data is loaded.
  // If there is no valid data incoming, then need to see if the previous
  // valid data caused an overflow and then force it into the alignment buffer.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      force_over_align <= 1'b0;
    else if (~enable_receive_rck)
      force_over_align <= 1'b0;

    // Halt pipeline
    else if (rx_br_halt_pipe)
      force_over_align <= force_over_align;

    // Detection of tiny runt frame - ensure this unique case where
    // end_of_frame for runt frame is coincident with decoding_finished
    // from previous frame - this ensures the runt is dropped
    else if (end_of_frame & decoding_finished & pipeline_finished)
      force_over_align <= 1'b0;

    else if ((end_of_data & valid_data & next_align_overflow) |
             (end_of_data & ~valid_data & prev_align_overflowd))
      force_over_align <= 1'b1;
    else
      force_over_align <= 1'b0;
  end

  // right justify incoming new data
  // This will strip out any invalid data (e.g. SFD or preamble) that happened
  // before valid data came in.
  always @(curr_data_16 or det_data)
  begin
    case (det_data)
       2'b10  : curr_data_align[17:0] = {1'b0,curr_data_16[17],8'h00, curr_data_16[15:8]};
       2'b01  : curr_data_align[17:0] = {1'b0,curr_data_16[16],8'h00, curr_data_16[7:0]};
       default: curr_data_align[17:0] = curr_data_16[17:0];
    endcase
  end

  // new_data_align data alignment buffer
  // Used to re-align data into 16 bit chunks after stripping out
  // preamble and SFD.
  // This buffer is split into two halves. Firstly the lower 16 bits
  // is the alignment buffer itself, that will be used to present aligned
  // data for further processing.
  // Secondly the upper 8 bits forms the residue for overspill from the
  // lower 16 bits. This residue is moved back into the lower 16 bits
  // when an overflow is detected.
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      new_data_align[26:0] <= {3'h0,24'h000000};  // 3{parity} . orginal data_align

    // synchronous reset
    else if (~enable_receive_rck)
      new_data_align[26:0] <= {3'h0,24'h000000};  // 3{parity} . orginal data_align

    // Halt pipeline
    else if (rx_br_halt_pipe)
      new_data_align  <= new_data_align;

    // if new valid data is available, and we didn't overflow last time
    // load up the correct number of valid bytes into the buffer.
    // If align_pntr is low then start new data at the 1st byte, and zero
    // the residue.
    else if (valid_data & ~align_pntr & ~prev_align_overflowd)
      begin
        new_data_align[15:0]  <= curr_data_align[15:0];
        new_data_align[23:16] <= 8'h00;
        new_data_align[26:24] <= {1'b0,curr_data_align[17:16]}; // Parity
      end

    // if new valid data is available, and we didn't overflow last time
    // load up the correct number of valid bytes into the buffer.
    // If align_pntr is high then start new data at the 2nd byte, and
    // maintain the 1st byte. (align_pntr must be high because of IF order)
    else if (valid_data & ~prev_align_overflowd)
      begin
        new_data_align[7:0]   <= new_data_align[7:0];
        new_data_align[23:8]  <= curr_data_align[15:0];
        new_data_align[24]    <= new_data_align[24];
        new_data_align[26:25] <= curr_data_align[17:16]; // passing parity of curr_data_align[15:0]
      end

    // if previous store overflowed and we have more new valid data, need
    // to ensure residue is placed in the bottom byte (marked as used by
    // this point). (prev_align_overflowd must be high because of IF order)
    // Always start new data at the 2nd byte.
    else if (valid_data)
      begin
        new_data_align[7:0]   <= new_data_align[23:16];
        new_data_align[23:8]  <= curr_data_align[15:0];
        new_data_align[24]    <= new_data_align[26];
        new_data_align[26:25] <= curr_data_align[17:16]; // passing parity of curr_data_align[15:0]
      end

    // if previous store overflowed and was the last data, a force_overflow
    // will be activated. Copy residue into lowest byte and zero rest of
    // alignment buffer.
    else if (force_over_align)
      begin
        new_data_align[7:0]   <= new_data_align[23:16];
        new_data_align[23:8]  <= 16'h0000;
        new_data_align[24]    <= new_data_align[26];
        new_data_align[26:25] <= 2'b00;                 // parity of 16'h0000
      end
  end

  // Indicate when new aligned data is available
  // Either when the alignment buffer is filled or when the last data in
  // a frame is about to be written into the pipeline (either when last current
  // data nibble or when forced overflow of the alignment buffer).
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
       new_aligned_data <= 1'b0;
    else if (~enable_receive_rck | ~frame_being_decoded | last_aligned_data |
              rx_br_halt_pipe)
      new_aligned_data <= 1'b0;

    // Detection of tiny runt frame - ensure this unique case where
    // end_of_frame for runt frame is coincident with decoding_finished
    // from previous frame - this ensures the runt is dropped
    else if (end_of_frame & decoding_finished & pipeline_finished)
      new_aligned_data <= 1'b0;

    else if ((next_align_full & valid_data) |
             (end_of_data & valid_data) |
             force_over_align)
      new_aligned_data <= 1'b1;
    else
      new_aligned_data <= 1'b0;
  end

  // Indicate how many bytes are valid in new aligned data
  // This is updated whenever new align data is available and
  // excludes any overflow (i.e. a maximum of 2 bytes)
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      no_aligned_data  <= 2'b00;

    // If frame is complete ensure that no_aligned_data is reset
    else if (last_aligned_data | ~enable_receive_rck | ~frame_being_decoded |
              rx_br_halt_pipe)
      no_aligned_data <= 2'b00;

    // if there is new data about to be loaded into the align buffer
    // which will fill or overflow it then there is a maximum of 2 bytes
    else if (next_align_full & (valid_data | end_of_data))
      no_aligned_data <= 2'b10;

    // Else if there is new data about to be loaded into the align buffer
    // which doesn't fill it then there must be either zero or one
    // byte as indicated by the next alignment pointer value.
    else if (valid_data | end_of_data)
      no_aligned_data <= {1'b0, next_align_pntr};

    // if the last data in a frame caused an overflow of the
    // align buffer then there will always be one byte for
    // the force_over_align
    else if (force_over_align)
      no_aligned_data <= 2'b01;

    // Else maintain value
    else
      no_aligned_data <= no_aligned_data;
  end

// -----------------------------------------------------------------------------
// Extract specific fields from frame
// Decoder operates based on new_data_align strobe.
// -----------------------------------------------------------------------------
  assign udp_dest_addr = ext_dest_port;
  // instantiate the decoding module
  gem_rx_decode  #(
       .grouped_params(grouped_params)
  ) i_rx_deco (

    // system signals
    .n_rxreset            (n_rxreset),
    .rx_clk               (rx_clk),

    // Mode selection
    .enable_receive_rck   (enable_receive_rck),
    .pause_enable_rck     (pause_enable_rck),
    .rx_toe_enable        (rx_toe_enable),
    .frer_6b_tag          (frer_6b_tag),

    // Decode control signals
    .frame_being_decoded  (frame_being_decoded),
    .end_of_frame         (set_last_aligned_data),
    .pause_add_match      (pause_add_match),
    .start_of_data        (start_of_data),
    .new_aligned_data     (new_aligned_data),
    .new_data_align       (new_data_align[23:0]),
    .rx_no_pause_frames   (rx_no_pause_frames),

    // external filter interface outputs
    .ext_da               (ext_da),
    .ext_da_stb           (ext_da_stb),
    .ext_sa               (ext_sa),
    .ext_sa_stb           (ext_sa_stb),
    .ext_type             (ext_type),
    .ext_type_stb         (ext_type_stb),
    .ext_ip_sa            (ext_ip_sa),
    .ext_ip_sa_stb        (ext_ip_sa_stb),
    .ext_ip_da            (ext_ip_da),
    .ext_ip_da_stb        (ext_ip_da_stb),
    .ext_source_port      (ext_source_port),
    .ext_sp_stb           (ext_sp_stb),
    .ext_dest_port        (ext_dest_port),
    .ext_dp_stb           (ext_dp_stb),
    .ext_ipv6             (ext_ipv6),

    .stacked_vlantype     (stacked_vlantype),
    .ext_vlan_tag1        (ext_vlan_tag1),
    .ext_vlan_tag1_stb    (ext_vlan_tag1_stb),
    .ext_vlan_tag2        (ext_vlan_tag2),
    .ext_vlan_tag2_stb    (ext_vlan_tag2_stb),
    .ext_has_2vlans       (ext_has_2vlans),
    .drop_pause_frame     (drop_pause_frame),

    .frer_rtag_ethertype  (frer_rtag_ethertype),
    .frer_rtag_mark_early (frer_rtag_mark_early),
    //      .frer_rtag_seqnum     (),   // This version is not used, it is extracted later
    //      .frer_rtag_seqnum_stb (),   // based on frer_rtag_mark_early to match pipeline

    // precision time protocol signals for IEEE 1588 support
    .sof_rx               (sof_rx),
    .sof_rx_tog           (sof_rx_tog),
    .sync_frame_rx        (sync_frame_rx),
    .delay_req_rx         (delay_req_rx),
    .pdelay_req_rx        (pdelay_req_rx),
    .pdelay_resp_rx       (pdelay_resp_rx),
    .general_frame_rx     (general_frame_rx),
    .ptp_unicast_ena      (ptp_unicast_ena_rck),
    .rx_ptp_unicast       (rx_ptp_unicast),

    // Index for Packet Fields
    .index_cnt_sof        (index_cnt_sof),
    .index_cnt_type       (index_cnt_type),
    .index_cnt_l3         (index_cnt_l3),
    .index_cnt_l4         (index_cnt_l4),
    .udptcp_offset        (udptcp_offset),
    .pld_offset           (pld_offset),
    .pld_offset_vld       (pld_offset_vld),

    // Frame type and status outputs
    .vlan_tagged          (vlan_tagged),
    .priority_tagged      (priority_tagged),
    .tci                  (tci),
    .length_field         (length_field),
    .pause_frame          (pause_frame),
    .pause_time           (pause_time),
    .snap_frame           (snap_frame),
    .ip_v4_frame          (ip_v4_frame),
    .ip_v6_frame          (ip_v6_frame),
    .arp_frame            (arp_frame),
    .tcp_frame            (tcp_frame),
    .udp_frame            (udp_frame),
    .ip_ck_err            (ip_ck_err),
    .tcp_udp_ck_err       (tcp_udp_ck_err),

    // Matches for screener module - Queue Priority
    .ip_v4_tos            (ip_v4_tos),
    .ip_v6_tc             (ip_v6_tc),

    .rsc_stop             (rsc_stop),
    .rsc_push             (rsc_push),
    .tcp_seqnum           (tcp_seqnum),
    .tcp_syn              (tcp_syn),
    .tcp_payload_len      (tcp_payload_len),

    // PFC pause frame signals
    .pfc_enable_rck       (pfc_enable_rck),
    .pfc_pause_frame      (pfc_pause_frame),
    .pfc_pause_time0      (pfc_pause_time0),
    .pfc_pause_time1      (pfc_pause_time1),
    .pfc_pause_time2      (pfc_pause_time2),
    .pfc_pause_time3      (pfc_pause_time3),
    .pfc_pause_time4      (pfc_pause_time4),
    .pfc_pause_time5      (pfc_pause_time5),
    .pfc_pause_time6      (pfc_pause_time6),
    .pfc_pause_time7      (pfc_pause_time7),
    .priority_enable      (priority_enable)

  );

// -----------------------------------------------------------------------------
// instantiate the rx PFC pause counter
// Note that the counter continues even if rx_br_halt_pipe is set.
// -----------------------------------------------------------------------------

  gem_rx_pfc_counter i_rx_pfc_counter(

    // system signals.
    .n_rxreset               (n_rxreset),
    .rx_clk                  (rx_clk),

    // register signals
    .enable_receive_rck      (enable_receive_rck),
    .retry_test_rck          (retry_test_rck),
    .tx_byte_mode            (tx_byte_mode),

    // PFC pause framesignals
    .pfc_enable_rck          (pfc_enable_rck),
    .new_pfc_pause_time0     (new_pfc_pause_time0),
    .new_pfc_pause_time1     (new_pfc_pause_time1),
    .new_pfc_pause_time2     (new_pfc_pause_time2),
    .new_pfc_pause_time3     (new_pfc_pause_time3),
    .new_pfc_pause_time4     (new_pfc_pause_time4),
    .new_pfc_pause_time5     (new_pfc_pause_time5),
    .new_pfc_pause_time6     (new_pfc_pause_time6),
    .new_pfc_pause_time7     (new_pfc_pause_time7),
    .new_pfc_pause_tog       (new_pfc_pause_tog),
    .new_priority_enable     (new_priority_enable),
    .rx_pfc_paused           (rx_pfc_paused)
  );

// -----------------------------------------------------------------------------
// instantiate the rx filter block to filter out unwanted frames
// -----------------------------------------------------------------------------
  gem_filter #(
     .p_num_spec_add_filters     (p_num_spec_add_filters)
   )

     i_filter (

     // system inputs.
     .n_rxreset            (n_rxreset),
     .rx_clk               (rx_clk),

     .tx_en                (tx_en),
     // signals coming via loop back module.
     .ext_match1_from_loop (ext_match1_from_loop),
     .ext_match2_from_loop (ext_match2_from_loop),
     .ext_match3_from_loop (ext_match3_from_loop),
     .ext_match4_from_loop (ext_match4_from_loop),

     // signals coming from gem_rx
     .frame_being_decoded  (frame_being_decoded),
     .ext_da               (ext_da),
     .ext_da_stb           (ext_da_stb),
     .ext_sa               (ext_sa),
     .ext_sa_stb           (ext_sa_stb),
     .ext_type             (ext_type),
     .ext_type_stb         (ext_type_stb),
     .code_error           (code_error),
     .rx_no_pause_frames   (rx_no_pause_frames),
     .rm_non_vlan          (rm_non_vlan),
     .vlan_tagged          (vlan_tagged),

     // signals going to gem_rx
     .pause_add_match      (pause_add_match),
     .rx_store_frame       (rx_store_frame),

     // signals coming from gem_reg_top (gem_registers).
     .ext_match_en         (ext_match_en),
     .uni_hash_en          (uni_hash_en),
     .multi_hash_en        (multi_hash_en),
     .no_broadcast         (no_broadcast),
     .copy_all_frames      (copy_all_frames),
     .hash                 (hash),
     .spec_add_filter_regs    (spec_add_filter_regs),
     .spec_add_filter_active  (spec_add_filter_active),
     .fil_add_match           (fil_add_match),
     .mask_add1            (mask_add1),
     .spec_type1           (spec_type1),
     .spec_type2           (spec_type2),
     .spec_type3           (spec_type3),
     .spec_type4           (spec_type4),
     .spec_type1_active    (spec_type1_active),
     .spec_type2_active    (spec_type2_active),
     .spec_type3_active    (spec_type3_active),
     .spec_type4_active    (spec_type4_active),
     .full_duplex          (full_duplex),
     .loopback_local       (loopback_local),
     .en_half_duplex_rx    (en_half_duplex_rx),

     // signals going to gem_dma_top
     .fil_broadcast_frame  (fil_broadcast_frame),
     .fil_multicast_frame  (fil_multicast_frame),
     .fil_mult_hash_match  (fil_mult_hash_match),
     .fil_uni_hash_match   (fil_uni_hash_match),
     .fil_ext_match1       (fil_ext_match1),
     .fil_ext_match2       (fil_ext_match2),
     .fil_ext_match3       (fil_ext_match3),
     .fil_ext_match4       (fil_ext_match4),
     .fil_type_match1      (fil_type_match1),
     .fil_type_match2      (fil_type_match2),
     .fil_type_match3      (fil_type_match3),
     .fil_type_match4      (fil_type_match4)
  );

// -----------------------------------------------------------------------------
// Detect when frame is matched by filter
// -----------------------------------------------------------------------------

  // Detect when frame is matched and hold until end of frame
  // Only set when rx_store_frame pulse is sent from filter block and
  // it's not already high and we are still decoding.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      frame_matched <= 1'b0;
    else if (last_aligned_data | ~enable_receive_rck | ~frame_being_decoded)
      frame_matched <= 1'b0;
    else if (rx_store_frame & ~frame_matched)
      frame_matched <= 1'b1;
    else
      frame_matched <= frame_matched;
  end

// -----------------------------------------------------------------------------
// Signals generated during decoding process need saving for status report
// -----------------------------------------------------------------------------

  // Save decoding stage outputs for use at end of packet status update.
  // Require save versions as the decoding process may be processing a
  // new incoming frame by this stage.
  // Status of decoding signals is sampled and held at end_of_frame only if
  // not waiting for the end of the previous frame (decoding_finished still
  // high).
  generate if (p_num_spec_add_filters > 32'd0) begin : gen_spec_add_filter
   reg  [p_num_spec_add_filters-1:0] add_match_saved_r;
   always@(posedge rx_clk or negedge n_rxreset)
   begin
     if (~n_rxreset)
           add_match_saved_r      <= {p_num_spec_add_filters{1'b0}}; // specific address register match
     else if (pipeline_finished | ~enable_receive_rck)
           add_match_saved_r      <= {p_num_spec_add_filters{1'b0}};
     else if (end_of_frame & ~decoding_finished)
           add_match_saved_r      <= fil_add_match[p_num_spec_add_filters:1];
   end
   assign add_match_saved = {add_match_saved_r,1'b0};
   assign add_match_saved_bot = add_match_saved_r[0];
  end else begin : gen_no_spec_add
   assign add_match_saved = 1'b0;
   assign add_match_saved_bot = 1'b0;
  end
  endgenerate

  always@(posedge rx_clk or negedge n_rxreset)
  begin
   if (~n_rxreset)
     begin
       scr_drop_frame_saved   <= 1'b0;
       slot_time_saved        <= 1'b0;
       code_error_saved       <= 1'b0;
       vlan_tagged_saved      <= 1'b0;
       length_field_saved     <= 16'hffff;
       pause_frame_saved      <= 1'b0;
       pause_time_saved       <= 16'h0000;
       pfc_pause_frame_saved  <= 1'b0;
       snap_frame_saved       <= 1'b0;
       ip_v4_frame_saved      <= 1'b0;
       arp_req_frame_saved    <= 1'b0;
       tcp_frame_saved        <= 1'b0;
       udp_frame_saved        <= 1'b0;
       ip_ck_err_saved        <= 1'b0;
       tcp_udp_ck_err_saved   <= 1'b0;
       drop_pause_frame_saved <= 1'b0;
       broad_frame_saved      <= 1'b0;
       multi_frame_saved      <= 1'b0;
       multi_match_saved      <= 1'b0;
       uni_match_saved        <= 1'b0;
       ext_match1_saved       <= 1'b0;
       ext_match2_saved       <= 1'b0;
       ext_match3_saved       <= 1'b0;
       ext_match4_saved       <= 1'b0;
       type_match1_saved      <= 1'b0;
       type_match2_saved      <= 1'b0;
       type_match3_saved      <= 1'b0;
       type_match4_saved      <= 1'b0;
       frame_matched_saved    <= 1'b0;
     end
   else if (pipeline_finished | ~enable_receive_rck)
     begin
       scr_drop_frame_saved   <= 1'b0;
       slot_time_saved        <= 1'b0;
       code_error_saved       <= 1'b0;
       vlan_tagged_saved      <= 1'b0;
       length_field_saved     <= 16'hffff;
       pause_frame_saved      <= 1'b0;
       pause_time_saved       <= 16'h0000;
       pfc_pause_frame_saved  <= 1'b0;
       snap_frame_saved       <= 1'b0;
       ip_v4_frame_saved      <= 1'b0;
       arp_req_frame_saved    <= 1'b0;
       tcp_frame_saved        <= 1'b0;
       udp_frame_saved        <= 1'b0;
       ip_ck_err_saved        <= 1'b0;
       tcp_udp_ck_err_saved   <= 1'b0;
       drop_pause_frame_saved <= 1'b0;
       broad_frame_saved      <= 1'b0;
       multi_frame_saved      <= 1'b0;
       multi_match_saved      <= 1'b0;
       uni_match_saved        <= 1'b0;
       ext_match1_saved       <= 1'b0;
       ext_match2_saved       <= 1'b0;
       ext_match3_saved       <= 1'b0;
       ext_match4_saved       <= 1'b0;
       type_match1_saved      <= 1'b0;
       type_match2_saved      <= 1'b0;
       type_match3_saved      <= 1'b0;
       type_match4_saved      <= 1'b0;
       frame_matched_saved    <= 1'b0;
     end
   else if (end_of_frame & ~decoding_finished)
     begin
       scr_drop_frame_saved   <= scr_drop_frame;
       slot_time_saved        <= slot_time_done;
       code_error_saved       <= code_error | valid_code_err;
       vlan_tagged_saved      <= vlan_tagged;
       length_field_saved     <= length_field;
       pause_frame_saved      <= pause_frame;
       pause_time_saved       <= pause_time;
       pfc_pause_frame_saved  <= pfc_pause_frame;
       snap_frame_saved       <= snap_frame;
       ip_v4_frame_saved      <= ip_v4_frame;
       arp_req_frame_saved    <= arp_req_frame;
       tcp_frame_saved        <= tcp_frame;
       udp_frame_saved        <= udp_frame;
       ip_ck_err_saved        <= ip_ck_err;
       tcp_udp_ck_err_saved   <= tcp_udp_ck_err;
       drop_pause_frame_saved <= drop_pause_frame;
       broad_frame_saved      <= fil_broadcast_frame;
       multi_frame_saved      <= fil_multicast_frame;
       multi_match_saved      <= fil_mult_hash_match;
       uni_match_saved        <= fil_uni_hash_match;
       ext_match1_saved       <= fil_ext_match1;
       ext_match2_saved       <= fil_ext_match2;
       ext_match3_saved       <= fil_ext_match3;
       ext_match4_saved       <= fil_ext_match4;
       type_match1_saved      <= fil_type_match1;
       type_match2_saved      <= fil_type_match2;
       type_match3_saved      <= fil_type_match3;
       type_match4_saved      <= fil_type_match4;
       frame_matched_saved    <= frame_matched | rx_store_frame;
     end
  end

  // Determine when odd number of nibbles is present in current frame.
  // Used for deciding if aligment error or CRC error
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      nibble_cnt_odd_saved <= 1'b0;
    else if (pipeline_finished | ~enable_receive_rck)
      nibble_cnt_odd_saved <= 1'b0;
    else if (end_of_data)
      nibble_cnt_odd_saved <= nibble_pntr[0];
    else
      nibble_cnt_odd_saved <= nibble_cnt_odd_saved;
  end

// -----------------------------------------------------------------------------
// Match filtering logic at end of pipeline
// -----------------------------------------------------------------------------

  // If new data appears at pipeline output before matched then
  // discard rest of frame
  // Set when new_pipeline_data for a new frame and not already matched or
  // overflow is already set
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      match_too_late_pipe <= 1'b0;
    else if (~enable_receive_rck | pipeline_finished | ~frame_in_pipeline)
      match_too_late_pipe <= 1'b0;
    else if (new_pipeline_data_comb & rx_w_sop_next &
             ~(rx_store_frame | frame_matched | frame_matched_saved))
      match_too_late_pipe <= 1'b1;
    else if (new_pipeline_data_comb & rx_w_sop_next & rx_w_overflow)
      match_too_late_pipe <= 1'b1;
    else
      match_too_late_pipe <= match_too_late_pipe;
  end

  // Hold frame_matched for pipeline stage.
  // Needs to be held at the point the first data in a frame is appearing
  // at the output of the pipeline, and is held until the pipeline
  // is finished.
  // Do not allow frame to match if FIFO is still in an overflow state.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      frame_match_pipe_det <= 1'b0;
    else if (~enable_receive_rck | ~frame_in_pipeline | pipeline_finished)
      frame_match_pipe_det <= 1'b0;
    else if (new_pipeline_data_comb & rx_w_sop_next & ~rx_w_overflow)
      frame_match_pipe_det <= frame_matched | rx_store_frame |
                               frame_matched_saved;
    else
      frame_match_pipe_det <= frame_match_pipe_det;
  end

  // Only allow data to be written if matched in time (by the time the
  // first data in a frame comes out of the pipeline).
  // Do not allow frame to match if FIFO is still in an overflow state.
  assign frame_matched_pipe = ~match_too_late_pipe &
                              (frame_match_pipe_det |
                               (new_pipeline_data_comb & rx_w_sop_next &
                                ~rx_w_overflow & (frame_matched |
                                                  rx_store_frame |
                                                  frame_matched_saved)));



// -----------------------------------------------------------------------------
// Pipeline Delay to allow time for Address and type matching
// Detect state of pipeline.
// -----------------------------------------------------------------------------

  // Detect when frame is being pushed through the pipeline
  // Set when new aligned data is pushed into the pipeline.
  // Reset when the pipeline has completed a frame, provided a new frame
  // is not coming in.
  // Flush second frame from pipeline when previously attempted to put
  // 2 ends into pipeline (overflow due to short runt frame).
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      frame_in_pipeline <= 1'b0;
    else if (~enable_receive_rck)
      frame_in_pipeline <= 1'b0;
    else if (pipeline_finished & two_ends_in_pipe)
      frame_in_pipeline <= 1'b0;
    else if (pipeline_finished & end_of_frame & decoding_finished)
      frame_in_pipeline <= 1'b0;
    else if (new_aligned_data)
      frame_in_pipeline <= 1'b1;
    else if (pipeline_finished & ~frame_being_decoded)
      frame_in_pipeline <= 1'b0;
    else
      frame_in_pipeline <= frame_in_pipeline;
  end

  // Detect when the last aligned data is put into the pipeline
  // and hold until it pops out the end. This is used for advancing the
  // pipeline, without new aligned data being available.
  // Also detect and hold when the last is popped out of the pipeline
  // until the pipeline has finished.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      begin
        last_in_pipeline     <= 1'b0;
        last_out_of_pipeline <= 1'b0;
      end
    else if (pipeline_finished | ~enable_receive_rck)
      begin
        last_in_pipeline     <= 1'b0;
        last_out_of_pipeline <= 1'b0;
      end
    else if (last_align_data_tag & new_aligned_data)
      begin
        last_in_pipeline     <= 1'b1;
        last_out_of_pipeline <= 1'b0;
      end
    else if (pipeline_output[18] & last_in_pipeline)
      begin
        last_in_pipeline     <= 1'b0;
        last_out_of_pipeline <= 1'b1;
      end
    else
      begin
        last_in_pipeline     <= last_in_pipeline;
        last_out_of_pipeline <= last_out_of_pipeline;
      end
  end

  // advance pipeline on when no more new valid data coming in
  // In PBUF mode, forcing is done to ensure we apply the
  // residual data in the pipeline to the DMA in a consistent
  // manner as when there is valid data coming in
  // In non-pbuf mode, the residual data is actually passed
  // to the DMA at half the rate when compared to when valid
  // the pipeline is full and getting topped up
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      force_push_pipeline <= 1'b0;
    else if (pipeline_finished | ~enable_receive_rck |
             ~frame_in_pipeline | last_out_of_pipeline)
      force_push_pipeline <= 1'b0;
    else if (last_in_pipeline)
      force_push_pipeline <= ~force_push_pipeline |
                              (data_in_16bits && p_edma_rx_pkt_buffer == 1);
    else
      force_push_pipeline <= force_push_pipeline;
  end

  // detect when pipeline has finished for current frame
  // since last_pipeline_data always waits for decoding_finished, this will
  // always happend after the decoding has completed.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      pipeline_finished  <= 1'b0;
    else if (~enable_receive_rck)
      pipeline_finished <= 1'b0;
    else if (last_pipeline_data)
      pipeline_finished <= 1'b1;
    else
      pipeline_finished <= 1'b0;
  end

// -----------------------------------------------------------------------------
// Pipeline for received data
// -----------------------------------------------------------------------------

  // Pipeline consists of the last aligned data, number of valid bytes
  // and the 16-bit data from the decoding stage.
  // Only assign a value to the pipeline input when it is new data being
  // pushed in so that pipeline is flushed with zeros otherwise.
  always @(*)
    if (new_aligned_data)
      pipeline_input = {new_data_align[25:24],frer_rtag_mark_early,
                        last_align_data_tag,
                        no_aligned_data[1:0],
                        new_data_align[15:0]};
    else
      pipeline_input = {2'b00,20'd0};


  // Determine when to advance the pipeline.
  // Either when some new data is pushed in or if the last is in the
  // pipeline.
  assign push_pipeline = new_aligned_data | force_push_pipeline;

  // Data delay pipeline.
  // Configurable depth pipeline, p_gem_rx_pipeline_delay deep by 19 bits
  // Flush second frame from pipeline when previously attempted to put
  // 2 ends into pipeline (overflow due to short runt frame).
  always@(posedge rx_clk or negedge n_rxreset)
  begin
     if (~n_rxreset)
       begin
         for (i = 0; i < p_gem_rx_pipeline_delay[31:0]; i = i + 1)
           pipeline_delay[i] <= {2'b00,20'd0};  // parity and orginal signal
       end
     else if (~enable_receive_rck)
       begin
         // synchronous reset, flush pipeline
         for (i = 0; i < p_gem_rx_pipeline_delay[31:0]; i = i + 1)
           pipeline_delay[i] <= {2'b00,20'd0};  // parity and orginal signal
       end
     else if (pipeline_finished & (overflow_saved |
                                   two_ends_in_pipe |
                                   (end_of_frame & decoding_finished)))
       begin
         // rx overflow, flush pipeline at pipeline finished
         for (i = 0; i < p_gem_rx_pipeline_delay[31:0]; i = i + 1)
           pipeline_delay[i] <= {2'b00,20'd0};  // parity and orginal signal
       end
     else if (push_pipeline)
       begin
          // if new aligned data is available then shift pipeline on.
          // Or if the last aligned data has been written into the
          // pipeline carry on shifting until it comes out.
          pipeline_delay[0] <= pipeline_input;
          for (i = 1; i < p_gem_rx_pipeline_delay[31:0]; i = i + 1)
            pipeline_delay[i] <= pipeline_delay[i - 1];
       end
     else
       begin
          // Maintain value
         for (i = 0; i < p_gem_rx_pipeline_delay[31:0]; i = i + 1)
            pipeline_delay[i] <= pipeline_delay[i];
       end
  end

  // assign last three locations of pipeline_delay[n] to signals so can
  // reference individual bits.
  // As well as defining the output of the pipeline, this is also used
  // for stripping FCS.
  assign pipeline_output     = pipeline_delay[p_gem_rx_pipeline_delay - 1];
  assign pipeline_delay_fcs2 = pipeline_delay[p_gem_rx_pipeline_delay - 2];
  assign pipeline_delay_fcs1 = pipeline_delay[p_gem_rx_pipeline_delay - 3];

  // Determine when data is not valid for 32/64/128 bit buffer if striping FCS.
  assign no_more_128_data = strip_rx_fcs & (pipeline_delay_fcs2[18] |
                                            pipeline_output[18]);

  // Determine when to block fifo writes if striping FCS
  assign stop_fifo_wr_fcs = strip_rx_fcs & (pipeline_delay_fcs1[18] |
                                            pipeline_delay_fcs2[18] |
                                            pipeline_output[18]);

  // Decode number of bytes in pipeline output
  assign no_pipeline_data = pipeline_output[17:16];

  // Decode when new valid pipeline data is available
  assign new_pipeline_data = push_pipeline & frame_in_pipeline &
                             (no_pipeline_data != 2'b00);

  // Combine with optional removal of CB RTag
  assign new_pipeline_data_comb  = new_pipeline_data & ~(pipeline_output[19] & frer_strip_rtag);

  // Detect last data coming out of pipeline
  // This is used to read the result of the CRC, so it must be one clock
  // after the last data appears from pipeline to allow CRC including
  // last data to be calculated.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      last_pipeline_data <= 1'b0;

    // if frame in pipeline has finshed zero last_pipeline_data
    else if (~frame_in_pipeline | pipeline_finished | ~enable_receive_rck)
      last_pipeline_data <= 1'b0;

    // if the last data is now out of the pipeline and we have finished
    // decoding the frame then start of last_pipeline_data sequence.
    // This will be pulsed for one cycle only.
    else if (decoding_finished & last_out_of_pipeline & ~last_pipeline_data)
      last_pipeline_data <= 1'b1;
    else
      last_pipeline_data <= 1'b0;
  end

  // The amount of data on the final push out of the pipeline depends
  // on whether FCS is being stripped out. If it is need to look forward
  // to where the last byte of CRC data currently is (pipeline_delay_fcs1)
  always @(*)
    if (strip_rx_fcs & pipeline_delay_fcs1[18])
      no_pipe_data_fcs = pipeline_delay_fcs1[17:16];
    else
      no_pipe_data_fcs = no_pipeline_data[1:0];

  // Store how many bytes come out of the last pipeline data. This will be
  // used to determine how full the last 16-bit slot is at the EOP.
  // Note that the last pipeline data will be indicated early if striping FCS.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      last_no_pipe_save <= 2'b00;
    else if (~enable_receive_rck)
      last_no_pipe_save <= 2'b00;
    else if ((pipeline_delay_fcs1[18] & strip_rx_fcs) |
             (pipeline_output[18] & ~strip_rx_fcs))
      last_no_pipe_save[1:0] <= no_pipe_data_fcs[1:0];
    else
      last_no_pipe_save[1:0] <= last_no_pipe_save[1:0];
  end

// -----------------------------------------------------------------------------
// Form 32/64/128 bit data to transfer to DMA FIFO
// -----------------------------------------------------------------------------

  // Decode DMA data bus width
  assign dma_32bit_mode  = (dma_bus_width == 2'b00);
  assign dma_64bit_mode  = (dma_bus_width == 2'b01);

  // word_pntr_128 is a pointer to the next 16 bit word to be filled
  // in 32/64/128 bit store from the aligned data.
  // This is reset as the last data in a frame is written.
  // Keep a track of the previous count for use at the end of frame in
  // calculating the MOD signal on the FIFO interface
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      begin
        word_pntr_128      <= 3'b000;
        prev_word_pntr_128 <= 3'b000;
      end

    // reset word pointer as last data in frame is written to the DMA FIFO
    // or if receive is disabled.
    else if (pipeline_finished | ~enable_receive_rck | ~frame_in_pipeline)
      begin
        word_pntr_128      <= 3'b000;
        prev_word_pntr_128 <= 3'b000;
      end

    // If about to be filled then reset
    else if (new_pipeline_data_comb & next_128_full & ~no_more_128_data)
      begin
        word_pntr_128      <= 3'b000;
        prev_word_pntr_128 <= word_pntr_128;
      end

    // Word pointer is updated when new aligned data is available.
    else if (new_pipeline_data_comb & ~no_more_128_data)
      begin
        word_pntr_128      <= next_word_pntr_128[2:0];
        prev_word_pntr_128 <= word_pntr_128;
      end

    // Else maintain value
    else
      begin
        word_pntr_128      <= word_pntr_128;
        prev_word_pntr_128 <= prev_word_pntr_128;
      end
  end

  // work out next value of word_pntr_128 (always increments by 1)
  assign next_word_pntr_128[3:0] = {1'b0,word_pntr_128[2:0]} + 4'b0001;

  // Work out if buffer will be filled next clock.
  // This depends on the DMA bus width selected.
  assign next_128_full = (dma_32bit_mode)? next_word_pntr_128[1] :
                         (dma_64bit_mode)? next_word_pntr_128[2] :
                                           next_word_pntr_128[3];

  // At end of frame, sample udptcp_offset into udptcp_offset_str
  // This will let the udptcp_offset counter inside gem_rx_decode
  // free to begin counting on the next inbound frame, and
  // we keep hold of the actual count value while the data is
  // passing through the pipeline
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
    begin
      udptcp_offset_str <= 11'h000;
      pld_offset_str <= 12'h000;
    end
    else if (end_of_frame)
    begin
     pld_offset_str <= pld_offset[11:0];
     if (~tcp_frame & ~udp_frame)
       udptcp_offset_str <= 11'h000;
     else
       udptcp_offset_str <= udptcp_offset;
    end
  end

  // If store_rx_ts is set then replace the CRC with the rx TSU timestamp
  // or the IP and TCP/UDP offset (in bytes) when the CRC emerges from the
  // receive pipeline
  always @(*)
  begin
    if (store_rx_ts & p_edma_tsu == 1)
    begin
      if (pipeline_delay_fcs1[18] & ~pipeline_delay_fcs1[17])
        data_store_16 = {rx_w_timestamp_prty[0],pipeline_output[20],rx_w_timestamp[7:0],pipeline_output[7:0]};
      else if (pipeline_delay_fcs2[18] & ~pipeline_delay_fcs2[17])
        data_store_16 = {rx_w_timestamp_prty[2],rx_w_timestamp_prty[1],rx_w_timestamp[23:8]};
      else if (pipeline_delay_fcs2[18])
        data_store_16 = {rx_w_timestamp_prty[1],rx_w_timestamp_prty[0],rx_w_timestamp[15:0]};
      else if (pipeline_output[18] & ~pipeline_output[17])
        data_store_16 = {1'b0,rx_w_timestamp_prty[3],8'd0,rx_w_timestamp[31:24]};
      else if (pipeline_output[18])
        data_store_16 = {rx_w_timestamp_prty[3],rx_w_timestamp_prty[2],rx_w_timestamp[31:16]};
      else
        data_store_16 = {pipeline_output[21:20],pipeline_output[15:0]};
    end

    else if (store_udp_offset)
    begin
      if (pipeline_delay_fcs1[18] & ~pipeline_delay_fcs1[17])
        data_store_16 = {udptcp_offset_str_par[0],pipeline_output[20],udptcp_offset_str[7:0],pipeline_output[7:0]};
      else if (pipeline_delay_fcs2[18] & ~pipeline_delay_fcs2[17])
        data_store_16 = {1'b0,udptcp_offset_str_par[1],13'h0000,udptcp_offset_str[10:8]};
      else if (pipeline_delay_fcs2[18])
        data_store_16 = {udptcp_offset_str_par[1:0],5'h00,udptcp_offset_str[10:0]};
      else if (pipeline_output[18])
        data_store_16 = {2'b00,16'h0000};
      else
        data_store_16 = {pipeline_output[21:20],pipeline_output[15:0]};
    end

    else
      data_store_16 = {pipeline_output[21:20],pipeline_output[15:0]};
  end

  // Store aligned data in 128 bit store ready to transfer to DMA.
  // Always put the beginning of the new aligned data (1 or 2 bytes) into
  // the location pointed to by word_pntr_128.
  // Do not push data in if striping FCS and the last bit is set in any
  // of the last three locations in the pipeline.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
     if (~n_rxreset) begin
        data_store_128[127:0]   <= 128'd0;
        data_store_128_par[15:0]<= 16'd0;
     end else if (new_pipeline_data_comb & ~no_more_128_data)
        casex ({no_pipe_data_fcs, word_pntr_128})

           // one new valid byte from pipeline data
           // This is only possible in the last push.
           5'b01_000  : begin // clear upper bits to avoid confusion
                           data_store_128[7:0]     <= data_store_16[7:0];
                           data_store_128[127:8]   <= 120'd0;
                           data_store_128_par      <= {15'd0,data_store_16[16]};
                        end
           5'b01_001  : begin data_store_128[23:16]   <= data_store_16[7:0]; data_store_128_par[2]   <= data_store_16[16]; end
           5'b01_010  : begin data_store_128[39:32]   <= data_store_16[7:0]; data_store_128_par[4]   <= data_store_16[16]; end
           5'b01_011  : begin data_store_128[55:48]   <= data_store_16[7:0]; data_store_128_par[6]   <= data_store_16[16]; end
           5'b01_100  : begin data_store_128[71:64]   <= data_store_16[7:0]; data_store_128_par[8]   <= data_store_16[16]; end
           5'b01_101  : begin data_store_128[87:80]   <= data_store_16[7:0]; data_store_128_par[10]  <= data_store_16[16]; end
           5'b01_110  : begin data_store_128[103:96]  <= data_store_16[7:0]; data_store_128_par[12]  <= data_store_16[16]; end
           5'b01_111  : begin data_store_128[119:112] <= data_store_16[7:0]; data_store_128_par[14]  <= data_store_16[16]; end

           // two new valid bytes from pipeline data
           5'b1x_000  : begin // clear upper bits to avoid confusion
                           data_store_128[15:0]    <= data_store_16[15:0];
                           data_store_128[127:16]  <= 112'd0;
                           data_store_128_par      <= {14'd0,data_store_16[17:16]};
                        end
           5'b1x_001  : begin data_store_128[31:16]   <= data_store_16[15:0]; data_store_128_par[3:2]    <= data_store_16[17:16]; end
           5'b1x_010  : begin data_store_128[47:32]   <= data_store_16[15:0]; data_store_128_par[5:4]    <= data_store_16[17:16]; end
           5'b1x_011  : begin data_store_128[63:48]   <= data_store_16[15:0]; data_store_128_par[7:6]    <= data_store_16[17:16]; end
           5'b1x_100  : begin data_store_128[79:64]   <= data_store_16[15:0]; data_store_128_par[9:8]    <= data_store_16[17:16]; end
           5'b1x_101  : begin data_store_128[95:80]   <= data_store_16[15:0]; data_store_128_par[11:10]  <= data_store_16[17:16]; end
           5'b1x_110  : begin data_store_128[111:96]  <= data_store_16[15:0]; data_store_128_par[13:12]  <= data_store_16[17:16]; end
           default    : begin //5'b1x_111  :
                          data_store_128[127:112]    <= data_store_16[15:0];
                          data_store_128_par[15:14]  <= data_store_16[17:16];
                        end
        endcase
     else begin
        data_store_128     <= data_store_128;
        data_store_128_par <= data_store_128_par;
     end
  end

  // count the number of bytes left in the buffer after the last push from
  // the pipeline output. This is used to generate the FIFO MOD signal.
  //
  // If terminating normally then this is equal to ...
  //    (2 * [number of 16-bit locations previously filled])
  //  + [number of bytes in final push]
  //
  // Else if terminating because too long then this is equal to ...
  //    (2 * [number of 16-bit locations currently filled])
  //  + [number of bytes in current push]
  //
  always @(too_long_dec or prev_word_pntr_128 or last_no_pipe_save or
           no_pipe_data_fcs or word_pntr_128)
     begin
        if (too_long_dec)
           no_bytes_in_wordpntr = {word_pntr_128[2:0], 1'b0} +
                                       {2'b00, no_pipe_data_fcs[1:0]};
        else
           no_bytes_in_wordpntr = {prev_word_pntr_128[2:0], 1'b0} +
                                       {2'b00, last_no_pipe_save[1:0]};
     end

// -----------------------------------------------------------------------------
// FIFO interface
// -----------------------------------------------------------------------------

  // rx_w_sop_next is used to keep track of when next write will
  // be the first in a frame. Set at last data write, reset when
  // next write is complete (must be first in frame).
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      rx_w_sop_next <= 1'b1;
    else if (~enable_receive_rck)
      rx_w_sop_next <= 1'b1;
    else if (rx_w_wr & rx_w_eop)
      rx_w_sop_next <= 1'b1;
    else if (rx_w_wr)
      rx_w_sop_next <= 1'b0;
    else
      rx_w_sop_next <= rx_w_sop_next;
  end

  // Next MOD signal generation.
  // no_bytes_in_wordpntr will currently indicate how many bytes were used
  // in the 128 bit buffer.
  // Need to zero upper unused bits for 32 and 64 bit bus width modes.
  always @(*)
  begin
    case (dma_bus_width)
       2'b00   : next_rx_w_mod[3:0] = {2'b00, no_bytes_in_wordpntr[1:0]};
       2'b01   : next_rx_w_mod[3:0] = { 1'b0, no_bytes_in_wordpntr[2:0]};
       default : next_rx_w_mod[3:0] = {       no_bytes_in_wordpntr[3:0]};
    endcase
  end

  assign rx_w_err_next = bad_frame | drop_pause_frame_saved | frer_discard;
  // Write data into RX DMA FIFO
  // Write data to DMA FIFO when more aligned data is becoming available
  // and already have a push pending, or when the last data has been loaded.
  // Indicate when end of packet is written into the FIFO
  // Indicate when start of packet is written into the FIFO
  // Work out how much data is to be transfered on last write
  // Indicate when when there is an error with the current packet
  // The TCI information can be output at SOP time also
  // This will ensure priority fields are passed early enough
  // for higher layers to work with it
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      begin
        rx_w_wr      <= 1'b0;
        rx_w_sop     <= 1'b0;
        rx_w_eop     <= 1'b0;
        rx_w_mod     <= 4'h0;
        rx_w_err     <= 1'b0;
        rx_w_tci     <= 4'h0;
        rx_w_vlan_tagged <= 1'b0;
        rx_w_prty_tagged <= 1'b0;
      end

    // synchronous reset
    else if (~enable_receive_rck)
      begin
        rx_w_wr      <= 1'b0;
        rx_w_sop     <= 1'b0;
        rx_w_eop     <= 1'b0;
        rx_w_mod     <= 4'h0;
        rx_w_err     <= 1'b0;
        rx_w_tci     <= 4'h0;
        rx_w_vlan_tagged <= 1'b0;
        rx_w_prty_tagged <= 1'b0;
      end

    // Push data out onto the FIFO interface when the 128 bit buffer is
    // full. If it is not the last data then keep EOP, ERR and MOD zero.
    // Signal SOP if the last push was an EOP (signalled by rx_w_sop_next).
    else if (frame_in_pipeline & new_pipeline_data_comb & next_128_full &
             ~(pipeline_output[18] | last_out_of_pipeline |
               stop_fifo_wr_fcs | too_long_dec | too_long) &
             frame_matched_pipe)
      begin
        rx_w_wr  <= 1'b1;
        rx_w_eop <= 1'b0;
        rx_w_err <= 1'b0;
        rx_w_sop <= rx_w_sop_next;
        rx_w_mod <= 4'h0;
        if (rx_w_sop_next)
        begin
          rx_w_tci <= tci;
          rx_w_vlan_tagged <= vlan_tagged;
          rx_w_prty_tagged <= priority_tagged;
        end
      end

    // Final push is forced if
    // 1) too_long_dec is detected to prevent excessive length frames unnecessarily filling the FIFO.
    // 2) Final push data out onto the FIFO interface when the 128 bit buffer is
    //    full. If it is the last data then set EOP. Also set ERR if bad frame
    //    is indicated. SOP may also be set if length is less than one location.
    //    The MOD signal now must indicate how many bytes are valid.
    else if (final_eop_push)
      begin
        rx_w_wr  <= 1'b1;
        rx_w_eop <= 1'b1;
        rx_w_err <= rx_w_err_next;
        rx_w_sop <= rx_w_sop_next;
        rx_w_mod <= next_rx_w_mod;
        if (rx_w_sop_next)
        begin
          rx_w_tci <= tci;
          rx_w_vlan_tagged <= vlan_tagged;
          rx_w_prty_tagged <= priority_tagged;
        end
      end

    // Else reset to ensure that signals are just a pulse
    else
      begin
        rx_w_wr  <= 1'b0;
        rx_w_eop <= 1'b0;
        rx_w_err <= 1'b0;
        rx_w_sop <= 1'b0;
        rx_w_mod <= 4'h0;
        rx_w_tci <= rx_w_tci;
        rx_w_vlan_tagged <= rx_w_vlan_tagged;
        rx_w_prty_tagged <= rx_w_prty_tagged;
      end
  end

  // Final push to FIFO i/f, see above for comments, this is done as a signal
  // here to avoid replication later.
  assign final_eop_push  = frame_in_pipeline & frame_matched_pipe & ~too_long &
                           (too_long_dec | pipeline_finished);

  // assign FIFO write data output.
  assign rx_w_data     = data_store_128[127:0];
  assign rx_w_data_par = data_store_128_par[15:0];


  // FIFO flush. Only asserted when receive is not enabled.
  assign rx_w_flush = ~enable_receive_rck;

// -----------------------------------------------------------------------------
// Detect overrun of the RX path
// -----------------------------------------------------------------------------

  // indicate internal GEM_RX overrun condition if the previous fifo
  // frame has not had it's status written back and we get a new
  // pipeline_finished
  assign rx_pipeline_overflow =

      // Status update still in progress and new frame is valid length
      (pipeline_finished & update_in_progress & ~too_long &
                                        ~(crc_error_reg & too_short)) |

      // Special case for if new frame is too long
      (pipeline_finished & rx_end_frame & too_long);


  // Hold overflow condition if the pipeline hasn't finished
  // (decoding_finished still high) and we get a new end_of_frame
  // This implies there is a runt from the decoding stage and hence this
  // saved condition is used to flush the runt from the pipeline.
  // This logic therefore implies a limit on the depth of the pipeline.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      two_ends_in_pipe <= 1'b0;
    else if (~enable_receive_rck)
      two_ends_in_pipe <= 1'b0;
    else if (pipeline_finished)
      two_ends_in_pipe <= 1'b0;
    else if (end_of_frame & decoding_finished)
      two_ends_in_pipe <= 1'b1;
  end

  // detect any overrun failure that happens during the limits of the frame
  // and store until status has been transferred to the handshaking block
  // when pipeline_finished is high.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      overflow_saved <= 1'b0;
    else if (~enable_receive_rck)
      overflow_saved <= 1'b0;
    else if (pipeline_finished)
      overflow_saved <= 1'b0;
    else if (frame_in_pipeline & (rx_pipeline_overflow | rx_w_overflow))
      overflow_saved <= 1'b1;
  end

  // Detect a new overflow when current update is in progress and was not
  // indicating an overflow. This is then used to start a new update to
  // the register block to immediately signal an overflow.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      update_overflow <= 1'b0;
    else if (~enable_receive_rck)
      update_overflow <= 1'b0;
    else if (update_finished)
      update_overflow <= 1'b0;
    else if (update_in_progress & ~rx_overflow & (rx_pipeline_overflow |
                                                  rx_w_overflow))
      update_overflow <= 1'b1;
  end

// -----------------------------------------------------------------------------
// Count number of bytes in frame coming from the pipeline
// -----------------------------------------------------------------------------

  // count frame length in bytes
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      frm_byte_cnt <= 14'd0;
    else if (pipeline_finished | ~enable_receive_rck | ~frame_in_pipeline)
      frm_byte_cnt <= 14'd0;
    else if (new_pipeline_data_comb & ~too_long)
      frm_byte_cnt <= next_frm_byte_cnt[13:0];
  end

  // detect how many valid bytes are in next aligned data
  assign frm_byte_cnt_inc[1:0] = no_pipeline_data[1:0];

  // add increment onto frame count in terms of number of complete bytes
  assign next_frm_byte_cnt = frm_byte_cnt + {12'd0, frm_byte_cnt_inc[1:0]};

// -----------------------------------------------------------------------------
// Minimum Frame Size Check
// -----------------------------------------------------------------------------
// Determine whether frame is less than MinFrameSize (less than 64 bytes of
// valid data excluding preamble, SFD and carrier extension).
// Starts with the presumption that it is under sized and clears
// once required count is reached.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      not_min_frame_size <= 1'b1;

    // if finished or not enabled then preset
    else if (pipeline_finished | ~enable_receive_rck | ~frame_in_pipeline)
      not_min_frame_size <= 1'b1;

    // else if the min size is decoded reset not_min_frame_size
    else if ((next_frm_byte_cnt[13:0] == 14'h0040) & new_pipeline_data_comb)
      not_min_frame_size <= 1'b0;

  end

// -----------------------------------------------------------------------------
// Frame too short
// -----------------------------------------------------------------------------
// Used to discard frame if minFrameSize is not met or slot time including
// carrier extension is not met in half duplex mode
// Also used to report too short statistics
  assign too_short = not_min_frame_size | ~slot_time_saved;

// -----------------------------------------------------------------------------
// Check for overlength frames
// -----------------------------------------------------------------------------

  // Determine whether frame is oversized
  // If jumbo enable is set then up to 10240 bytes are allowed.
  // Else if rx_1536_en is set, frames up to 1536 bytes are allowed,
  // otherwise only 1518 bytes are allowed.
  always @(jumbo_enable or new_pipeline_data_comb or frm_byte_cnt or rx_1536_en or jumbo_max_length)
  begin
    if (jumbo_enable & new_pipeline_data_comb &
          (frm_byte_cnt == jumbo_max_length))
      too_long_dec = 1'b1;
    else if (~jumbo_enable & rx_1536_en & new_pipeline_data_comb &
             (frm_byte_cnt == 14'h0600))
      too_long_dec = 1'b1;
    else if (~jumbo_enable & ~rx_1536_en & new_pipeline_data_comb &
             (frm_byte_cnt == 14'h05ee))
      too_long_dec = 1'b1;
    else
      too_long_dec = 1'b0;
  end

  // When too_long_dec is signalled hold until pipeline has finished
  // processing all of frame. This will be used to stop any further pushes
  // on the FIFO interface and then used for statistic reporting.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      too_long <= 1'b0;
    else if (pipeline_finished | ~enable_receive_rck | ~frame_in_pipeline)
      too_long <= 1'b0;
    else if (too_long_dec)
      too_long <= 1'b1;
  end

// -----------------------------------------------------------------------------
// Check for measured frame lengths less than length field
// -----------------------------------------------------------------------------

  // determine whether frame has correct length field
  // if length field is greater than equal to 16'h0600 then it represents
  // type rather than length.
  // If frame length is greater than length field then assume the
  // frame is padded or jumbo, and don't reject.
  // Don't set length_error for frames that are too long
  // By comparing length_field_saved to 16'h0600, we only need to compare
  // 11 bits of the length_field_saved to the frm_byte_cnt.
  always@(frm_byte_cnt or length_field_saved or check_rx_length or too_long or
          vlan_tagged_saved)
  begin
     if (check_rx_length &
         (frm_byte_cnt[13:0] < {3'b000,(length_field_saved[10:0] +
                               (vlan_tagged_saved ? 11'h016 : 11'h012))}) &
         (length_field_saved < 16'h0600) & ~too_long)
        length_error = 1'b1;
     else
        length_error = 1'b0;
  end

// -----------------------------------------------------------------------------
// Calculate the CRC for the incoming data
// -----------------------------------------------------------------------------
// Calculate CRC on received frame. The last 32 bit of the frame contain the
// inverted CRC. The means a frame received with good CRC will always
// produce a final CRC value of 32'hc704dd7b.

  // Update the current CRC value every time new aligned data is available.
  // In all but the last data a full 32 bits will be processed. In the last
  // data any number of bytes from 1 to 4 will be present so need to tap off
  // at the right position.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      crc_h <= 32'hffffffff;
    else if (pipeline_finished | ~enable_receive_rck | ~frame_in_pipeline)
      crc_h <= 32'hffffffff;
    else if (new_pipeline_data & no_pipeline_data[1:0] == 2'b01)
      crc_h <= rx_stripe_out7;
    else if (new_pipeline_data)
      crc_h <= rx_stripe_out15;
  end

  // The 32 instantiations below form the CRC arithmetic functions
  gem_stripe i_str_rx0 (.din(pipeline_output[0]),
                                .stripe_in(crc_h         ),
                                .stripe_out(rx_stripe_out0));
  gem_stripe i_str_rx1 (.din(pipeline_output[1]),
                                .stripe_in(rx_stripe_out0),
                                .stripe_out(rx_stripe_out1));
  gem_stripe i_str_rx2 (.din(pipeline_output[2]),
                                .stripe_in(rx_stripe_out1),
                                .stripe_out(rx_stripe_out2));
  gem_stripe i_str_rx3 (.din(pipeline_output[3]),
                                .stripe_in(rx_stripe_out2),
                                .stripe_out(rx_stripe_out3));
  gem_stripe i_str_rx4 (.din(pipeline_output[4]),
                                .stripe_in(rx_stripe_out3),
                                .stripe_out(rx_stripe_out4));
  gem_stripe i_str_rx5 (.din(pipeline_output[5]),
                                .stripe_in(rx_stripe_out4),
                                .stripe_out(rx_stripe_out5));
  gem_stripe i_str_rx6 (.din(pipeline_output[6]),
                                .stripe_in(rx_stripe_out5),
                                .stripe_out(rx_stripe_out6));
  gem_stripe i_str_rx7 (.din(pipeline_output[7]),
                                .stripe_in(rx_stripe_out6),
                                .stripe_out(rx_stripe_out7));
  gem_stripe i_str_rx8 (.din(pipeline_output[8]),
                                .stripe_in(rx_stripe_out7),
                                .stripe_out(rx_stripe_out8));
  gem_stripe i_str_rx9 (.din(pipeline_output[9]),
                                .stripe_in(rx_stripe_out8),
                                .stripe_out(rx_stripe_out9));
  gem_stripe i_str_rx10(.din(pipeline_output[10]),
                                .stripe_in(rx_stripe_out9),
                                .stripe_out(rx_stripe_out10));
  gem_stripe i_str_rx11(.din(pipeline_output[11]),
                                .stripe_in(rx_stripe_out10),
                                .stripe_out(rx_stripe_out11));
  gem_stripe i_str_rx12(.din(pipeline_output[12]),
                                .stripe_in(rx_stripe_out11),
                                .stripe_out(rx_stripe_out12));
  gem_stripe i_str_rx13(.din(pipeline_output[13]),
                                .stripe_in(rx_stripe_out12),
                                .stripe_out(rx_stripe_out13));
  gem_stripe i_str_rx14(.din(pipeline_output[14]),
                                .stripe_in(rx_stripe_out13),
                                .stripe_out(rx_stripe_out14));
  gem_stripe i_str_rx15(.din(pipeline_output[15]),
                                .stripe_in(rx_stripe_out14),
                                .stripe_out(rx_stripe_out15));

  // Detect if good CRC at end of frame
  // Good CRC is 32'hc704dd7b for this implementation because
  // of the way the stripe block is implemented
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      crc_error_reg <= 1'b0;
    else if (~enable_receive_rck)
      crc_error_reg <= 1'b0;
    else if (last_pipeline_data & (crc_h == 32'hc704dd7b))
      crc_error_reg <= 1'b0;
    else if (new_pipeline_data)
      crc_error_reg <= 1'b1;
  end

// -----------------------------------------------------------------------------
// Magic packet detection
// -----------------------------------------------------------------------------

  // Magic packet detection state machine
  // For magic packet detection must be address matched frame
  // with no errors and contain 6 bytes of FF sync pattern
  // followed by spec add 1 repeated 16 times.
  // magic_packet signal is asserted for 64 rx_clk cycles.
  wire magic_packet;
  generate if (p_num_spec_add_filters > 32'd0) begin : gen_magic_pkt
    reg           magic_packet_r;
    reg     [3:0] rx_mp_state;             // magic packet state machine variable
    reg     [3:0] mp_add_cnt;              // counts 16 addresses in magic packet
    wire    [3:0] mp_add_cnt_nxt;          // next value of mp_add_cnt
    always@(posedge rx_clk or negedge n_rxreset)
    begin
      if (~n_rxreset)
        begin
          magic_packet_r <= 1'b0;
          rx_mp_state  <= RX_MP_WAIT_SYNC1;
          mp_add_cnt   <= 4'hF;
        end
      else if (~enable_receive_rck |
              ~spec_add_filter_active[0] |
              (pipeline_finished & (rx_mp_state != RX_MP_WAIT_CRC)))
        begin
          magic_packet_r <= 1'b0;
          rx_mp_state  <= RX_MP_WAIT_SYNC1;
          mp_add_cnt   <= 4'hF;
        end
      else
        case(rx_mp_state)
           RX_MP_WAIT_SYNC2: // waiting for second and third FF sync bytes
              if (new_pipeline_data_comb & (pipeline_output[15:0] == 16'hffff))
                 rx_mp_state <= RX_MP_WAIT_SYNC4;
              else if (new_pipeline_data_comb & (pipeline_output[15:8] == 8'hff))
                 rx_mp_state <= RX_MP_WAIT_SYNC2;
              else if (new_pipeline_data_comb)
                 rx_mp_state <= RX_MP_WAIT_SYNC1;
              else
                 rx_mp_state <= RX_MP_WAIT_SYNC2;

           RX_MP_WAIT_SYNC3: // waiting for third and fourth FF sync bytes
              if (new_pipeline_data_comb & (pipeline_output[15:0] == 16'hffff))
                 rx_mp_state <= RX_MP_WAIT_SYNC5;
              else if (new_pipeline_data_comb & (pipeline_output[15:8] == 8'hff))
                 rx_mp_state <= RX_MP_WAIT_SYNC2;
              else if (new_pipeline_data_comb)
                 rx_mp_state <= RX_MP_WAIT_SYNC1;
              else
                 rx_mp_state <= RX_MP_WAIT_SYNC3;

           RX_MP_WAIT_SYNC4: // waiting for fourth and fifth FF sync bytes
              if (new_pipeline_data_comb & (pipeline_output[15:0] == 16'hffff))
                 rx_mp_state <= RX_MP_WAIT_SYNC6;
              else if (new_pipeline_data_comb & (pipeline_output[15:8] == 8'hff))
                 rx_mp_state <= RX_MP_WAIT_SYNC2;
              else if (new_pipeline_data_comb)
                 rx_mp_state <= RX_MP_WAIT_SYNC1;
              else
                 rx_mp_state <= RX_MP_WAIT_SYNC4;

           RX_MP_WAIT_SYNC5: // waiting for fifth and sixth FF sync bytes
              if (new_pipeline_data_comb & (pipeline_output[15:0] == 16'hffff))
                 rx_mp_state <= RX_MP_WAIT_ADD1;
              else if (new_pipeline_data_comb & (pipeline_output[15:8] == 8'hff))
                 rx_mp_state <= RX_MP_WAIT_SYNC2;
              else if (new_pipeline_data_comb)
                 rx_mp_state <= RX_MP_WAIT_SYNC1;
              else
                 rx_mp_state <= RX_MP_WAIT_SYNC5;

           RX_MP_WAIT_SYNC6: // waiting for sixth FF sync and spec_add1[7:0]
              if (new_pipeline_data_comb & (pipeline_output[7:0] == 8'hff) &
                       (pipeline_output[15:8] == spec_add_filter_regs[7:0]))
                 rx_mp_state <= RX_MP_WAIT_ADD2;
              else if (new_pipeline_data_comb & (pipeline_output[15:0] == 16'hffff))
                 rx_mp_state <= RX_MP_WAIT_ADD1;
              else if (new_pipeline_data_comb & (pipeline_output[15:8] == 8'hff))
                 rx_mp_state <= RX_MP_WAIT_SYNC2;
              else if (new_pipeline_data_comb)
                 rx_mp_state <= RX_MP_WAIT_SYNC1;
              else
                 rx_mp_state <= RX_MP_WAIT_SYNC6;

           RX_MP_WAIT_ADD1: // waiting for first spec_add1 byte
              if (new_pipeline_data_comb &
                  (pipeline_output[15:0] == spec_add_filter_regs[15:0]))
                 rx_mp_state <= RX_MP_WAIT_ADD3;
              else if (new_pipeline_data_comb & (pipeline_output[7:0] == 8'hff) &
                       (pipeline_output[15:8] == spec_add_filter_regs[7:0]) &
                       (mp_add_cnt == 4'hF))
                 rx_mp_state <= RX_MP_WAIT_ADD2;
              else if (new_pipeline_data_comb & (mp_add_cnt == 4'hF) &
                       (pipeline_output[15:0] == 16'hffff))
                 rx_mp_state <= RX_MP_WAIT_ADD1;
              else if (new_pipeline_data_comb & (pipeline_output[15:0] == 16'hffff))
                 rx_mp_state <= RX_MP_WAIT_SYNC3;
              else if (new_pipeline_data_comb & (pipeline_output[15:8] == 8'hff))
                 rx_mp_state <= RX_MP_WAIT_SYNC2;
              else if (new_pipeline_data_comb)
                 rx_mp_state <= RX_MP_WAIT_SYNC1;
              else
                 rx_mp_state <= RX_MP_WAIT_ADD1;

           RX_MP_WAIT_ADD2: // waiting for second spec_add1 byte
              if (new_pipeline_data_comb &
                  (pipeline_output[15:0] == spec_add_filter_regs[23:8]))
                 rx_mp_state <= RX_MP_WAIT_ADD4;
              else if (new_pipeline_data_comb & (pipeline_output[15:0] == 16'hffff))
                 rx_mp_state <= RX_MP_WAIT_SYNC3;
              else if (new_pipeline_data_comb & (pipeline_output[15:8] == 8'hff))
                 rx_mp_state <= RX_MP_WAIT_SYNC2;
              else if (new_pipeline_data_comb)
                 rx_mp_state <= RX_MP_WAIT_SYNC1;
              else
                 rx_mp_state <= RX_MP_WAIT_ADD2;

           RX_MP_WAIT_ADD3: // waiting for third spec_add1 byte
              if (new_pipeline_data_comb &
                  (pipeline_output[15:0] == spec_add_filter_regs[31:16]))
                 rx_mp_state <= RX_MP_WAIT_ADD5;
              else if (new_pipeline_data_comb & (pipeline_output[15:0] == 16'hffff))
                 rx_mp_state <= RX_MP_WAIT_SYNC3;
              else if (new_pipeline_data_comb & (pipeline_output[15:8] == 8'hff))
                 rx_mp_state <= RX_MP_WAIT_SYNC2;
              else if (new_pipeline_data_comb)
                 rx_mp_state <= RX_MP_WAIT_SYNC1;
              else
                 rx_mp_state <= RX_MP_WAIT_ADD3;

           RX_MP_WAIT_ADD4: // waiting for fourth spec_add1 byte
              if (new_pipeline_data_comb &
                  (pipeline_output[15:0] == spec_add_filter_regs[39:24]))
                 rx_mp_state <= RX_MP_WAIT_ADD6;
              else if (new_pipeline_data_comb & (pipeline_output[15:0] == 16'hffff))
                 rx_mp_state <= RX_MP_WAIT_SYNC3;
              else if (new_pipeline_data_comb & (pipeline_output[15:8] == 8'hff))
                 rx_mp_state <= RX_MP_WAIT_SYNC2;
              else if (new_pipeline_data_comb)
                 rx_mp_state <= RX_MP_WAIT_SYNC1;
              else
                 rx_mp_state <= RX_MP_WAIT_ADD4;

           RX_MP_WAIT_ADD5: // waiting for fifth spec_add1
              if (new_pipeline_data_comb & (mp_add_cnt == 4'h0) &
                  (pipeline_output[15:0] == spec_add_filter_regs[47:32]))
                 rx_mp_state <= RX_MP_WAIT_CRC;
              else if (new_pipeline_data_comb &
                       (pipeline_output[15:0] == spec_add_filter_regs[47:32]))
                 begin
                    rx_mp_state <= RX_MP_WAIT_ADD1;
                    mp_add_cnt  <= mp_add_cnt_nxt;
                 end
              else if (new_pipeline_data_comb & (pipeline_output[15:0] == 16'hffff))
                 rx_mp_state <= RX_MP_WAIT_SYNC3;
              else if (new_pipeline_data_comb & (pipeline_output[15:8] == 8'hff))
                 rx_mp_state <= RX_MP_WAIT_SYNC2;
              else if (new_pipeline_data_comb)
                 rx_mp_state <= RX_MP_WAIT_SYNC1;
              else
                 rx_mp_state <= RX_MP_WAIT_ADD5;

           RX_MP_WAIT_ADD6: // waiting for sixth spec_add1
              if (new_pipeline_data_comb & (mp_add_cnt == 4'h0) &
                  (pipeline_output[7:0] == spec_add_filter_regs[47:40]))
                 rx_mp_state <= RX_MP_WAIT_CRC;
              else if (new_pipeline_data_comb &
                       (pipeline_output[7:0] == spec_add_filter_regs[47:40]) &
                       (pipeline_output[15:8] == spec_add_filter_regs[7:0]))
                 begin
                    rx_mp_state <= RX_MP_WAIT_ADD2;
                    mp_add_cnt  <= mp_add_cnt_nxt;
                 end
              else if (new_pipeline_data_comb & (pipeline_output[15:0] == 16'hffff))
                 rx_mp_state <= RX_MP_WAIT_SYNC3;
              else if (new_pipeline_data_comb & (pipeline_output[15:8] == 8'hff))
                 rx_mp_state <= RX_MP_WAIT_SYNC2;
              else if (new_pipeline_data_comb)
                 rx_mp_state <= RX_MP_WAIT_SYNC1;
              else
                 rx_mp_state <= RX_MP_WAIT_ADD6;

           RX_MP_WAIT_CRC: // waiting for good CRC
              if (pipeline_finished)
                 begin
                    magic_packet_r <= ~bad_frame;
                    rx_mp_state  <= RX_MP_WAIT_SYNC1;
                    mp_add_cnt   <= 4'hF;
                 end
              else
                 rx_mp_state <= RX_MP_WAIT_CRC;

           default: //RX_MP_WAIT_SYNC1: // waiting for first FF sync bytes
              if (new_pipeline_data_comb & (pipeline_output[15:0] == 16'hffff))
                 begin
                    magic_packet_r <= 1'b0;
                    rx_mp_state <= RX_MP_WAIT_SYNC3;
                    mp_add_cnt  <= 4'hF;
                 end
              else if (new_pipeline_data_comb & (pipeline_output[15:8] == 8'hff))
                 begin
                    magic_packet_r <= 1'b0;
                    rx_mp_state <= RX_MP_WAIT_SYNC2;
                    mp_add_cnt  <= 4'hF;
                 end
              else
                 begin
                    magic_packet_r <= 1'b0;
                    rx_mp_state <= RX_MP_WAIT_SYNC1;
                    mp_add_cnt  <= 4'hF;
                 end

        endcase
    end
    assign mp_add_cnt_nxt = mp_add_cnt - 4'h1;
    assign magic_packet = magic_packet_r;
  end else begin : gen_no_magic_packet
    assign magic_packet = 1'b0;
  end
  endgenerate

// -----------------------------------------------------------------------------
// Detect ARP request frame
// -----------------------------------------------------------------------------

  parameter IDLE      = 4'h0;
  parameter OP_FIELD  = 4'h3;
  parameter PROT_ADDR = 4'hd;
  parameter ALL_FIELD = 4'he;

  // Detect an ARP request frame for WoL purposes.
  // An ARP type is already detected and signalled by arp_frame.
  // Fields checked are ARP operation for a request opcode and target protocol
  // address (only bottom 16 bits).
  // Fields not checked are hardware and protocol types address lengths,
  // sender hardware and protocol address, and target hardware address.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
     if (~n_rxreset)
       begin
         arp_count     <= IDLE;
         arp_req_frame <= 1'b0;
       end

     // Wait for an ARP frame type to be recognised to allow further
     // processing. Only process when enabled and a valid frame is detected.
     else if (~enable_receive_rck | pipeline_finished |
              ~frame_in_pipeline | ~arp_frame)
       begin
         arp_count     <= IDLE;
         arp_req_frame <= 1'b0;
       end

     // new pipeline data to process
     else if (new_aligned_data)
       begin
          // Use arp_count to work out which field in ARP frame
          case (arp_count)
             OP_FIELD: begin // ARP operation field

                          // increment count
                          arp_count <= arp_count_nxt;

                          // Check operation field for correct ARP
                          // request opcode.
                          if ({new_data_align[7:0],
                               new_data_align[15:8]} == ARP_REQ_OP)
                            arp_req_frame <= 1'b1;
                          else
                            arp_req_frame <= 1'b0;
                       end

          PROT_ADDR  : begin // ARP target protocol address

                          // increment count
                          arp_count <= arp_count_nxt;

                          // Check bottom 16 bytes of target protocol address
                          // match expected wop_ip_addr
                          if ((wol_ip_addr != 16'h0000) &
                               {new_data_align[7:0],
                                new_data_align[15:8]} == wol_ip_addr)
                            arp_req_frame <= arp_req_frame;
                          else
                            arp_req_frame <= 1'b0;

                       end

          ALL_FIELD : begin // All field processed
                         arp_count     <= arp_count;
                         arp_req_frame <= arp_req_frame;
                       end

             default : begin // wait for all field to happen, increment count
                         arp_count     <= arp_count_nxt;
                         arp_req_frame <= arp_req_frame;
                       end
          endcase
       end
  end

  // assign next value of arp_count
  assign arp_count_nxt = arp_count + 4'h1;

// -----------------------------------------------------------------------------
// Wake-on-LAN assertion
// -----------------------------------------------------------------------------

  // syncrhonise WoL enable mask
  cdnsdru_datasync_v1 #(
     .CDNSDRU_DATASYNC_DIN_W(4)
  ) i_cdnsdru_datasync_v1_wol_mask (
     .clk(rx_clk),
     .reset_n(n_rxreset),
     .din(wol_mask),
     .dout(wol_mask_rck));

  // wol signal is asserted for 64 rx_clk cycles when wakeup event is seen.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      begin
        wol_drive_cnt <= 6'h00;
        wol           <= 1'b0;
      end
    else if (~enable_receive_rck)
      begin
        wol_drive_cnt <= 6'h00;
        wol           <= 1'b0;
      end
    else if (wol_drive_cnt != 6'h00)
      begin
        wol_drive_cnt <= wol_drive_cnt_nxt;
        wol           <= 1'b1;
      end
    else if (

           // magic packet detected and mask enabled
           (magic_packet & wol_mask_rck[0]) |

           // or ARP request frame with bottom 16 bits of DA that matches
           // wol_ip_addr and mask is enabled
           (pipeline_finished & arp_req_frame_saved & frame_matched_pipe &
                                     broad_frame_saved & wol_mask_rck[1]) |

           // or specific address 1 match and mask is enabled
           (pipeline_finished & frame_matched_pipe & add_match_saved_bot &
                                                         wol_mask_rck[2]) |

           // or multicast hash filter match and not broadcast and mask set
           (pipeline_finished & frame_matched_pipe & multi_match_saved &
                                    ~broad_frame_saved & wol_mask_rck[3])

            )
      begin
         wol_drive_cnt <= 6'h3F;
         wol           <= 1'b1;
      end
    else
      begin
         wol_drive_cnt <= 6'h00;
         wol           <= 1'b0;
      end
  end

  // next count variables with overflow bit
  assign wol_drive_cnt_nxt = wol_drive_cnt - 6'h01;

// -----------------------------------------------------------------------------
// Status and Error Reporting (to both register and DMA blocks)
// -----------------------------------------------------------------------------

  // dma_rx_end_tog is toggled at the end of every frame (or if too long)
  // and is used as handshaking to the DMA module.
  // dma_rx_end_frame is used as an indication that an update is already in
  // progress so that we can detect if the updates happen too often (overflow).
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      begin
        dma_rx_end_tog      <= 1'b0;
        dma_rx_end_frame    <= 1'b0;
      end
    else
      begin

         // dma_rx_end_tog indicates to the DMA block that status
         // is available for a new received frame. This is either
         // at the end of a frame if not too long, or immediately if
         // frame exceeds length. Do not signal if frame has not been
         // matched as the DMA knows nothing about it.
         if (~enable_receive_rck)
           begin
             dma_rx_end_tog    <= dma_rx_end_tog;
             dma_rx_end_frame  <= 1'b0;
           end
         else if ((pipeline_finished | too_long_dec) & ~too_long &
                  frame_matched_pipe & ~update_in_progress)
           begin
             dma_rx_end_tog    <= ~dma_rx_end_tog;
             dma_rx_end_frame  <= 1'b1;
           end
         else if (dma_update_finished)
           begin
             dma_rx_end_tog    <= dma_rx_end_tog;
             dma_rx_end_frame  <= 1'b0;
           end
       end
  end

  // When there is a DMA, need to wait for DMA to indicated that it has completed status
  // capture, otherwise base off the registers capture status.
  generate if (p_edma_ext_fifo_interface == 1'b0) begin : gen_has_dma
    // detect either edge on synchronised dma_rx_status_tog to indicate
    // that DMA update has completed.
    edma_sync_toggle_detect i_edma_sync_toggle_detect_dma_rx_status_tog (
      .clk      (rx_clk),
      .reset_n  (n_rxreset),
      .din      (dma_rx_status_tog),
      .rise_edge(),
      .fall_edge(),
      .any_edge (dma_update_finished)
     );
  end else begin : gen_has_no_dma
    assign dma_update_finished = reg_update_finished;
  end
  endgenerate


  // rx_end_tog is toggled at the end of every frame and is used as
  // handshaking to the register module.
  // rx_end_frame is used as an indication that an update is already in
  // progress so that we can detect if the updates happen too often (overflow).
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      begin
        rx_end_tog         <= 1'b0;
        rx_end_frame       <= 1'b0;
      end
    else
      begin

         // rx_end_tog indicates to the registers block that status
         // is available for a new received frame. This is always at end
         // of frame if the status is not already being updated (overflow).
         // If an overflow has occured for this reason then there will a
         // further update once the current update has completed.
         if (~enable_receive_rck)
           begin
             rx_end_tog    <= rx_end_tog;
             rx_end_frame  <= 1'b0;
           end
         else if ((pipeline_finished & ~((update_in_progress & ~too_long) |
                                    (rx_end_frame & too_long))) |
             (update_finished & update_overflow))
           begin
             rx_end_tog    <= ~rx_end_tog;
             rx_end_frame  <= 1'b1;
           end
         else if (reg_update_finished)
           begin
             rx_end_tog    <= rx_end_tog;
             rx_end_frame  <= 1'b0;
           end
      end
  end

  // detect either edge on synchronised rx_status_wr_tog to indicate
  // that DMA update has completed.
  edma_sync_toggle_detect i_edma_sync_toggle_detect_rx_status_wr_tog (
     .clk(rx_clk),
     .reset_n(n_rxreset),
     .din(rx_status_wr_tog),
     .rise_edge(),
     .fall_edge(),
     .any_edge(reg_update_finished));


  // detect when a status update is still in progress. This is when either
  // the DMA or register block updates are still active
  assign update_in_progress = (rx_end_frame & ~reg_update_finished) |
                              (dma_rx_end_frame & ~dma_update_finished);

  // Detect when update has finished. This is a pulse signalled when both
  // updates have completed.
  assign update_finished =
     // Pulse when the register update is just finishing and the dma
     // update has already finished or about to finish, or...
     (rx_end_frame & reg_update_finished &
      (~dma_rx_end_frame | dma_update_finished)) |

     // pulse when the DMA update is just finishing and the register
     // update has already finished or about to finish, or...
     (dma_rx_end_frame & dma_update_finished &
      (~rx_end_frame | reg_update_finished));

  //-------------------------------------------
  // Per queue rx flushing
  //-------------------------------------------
  reg [13:0] frame_length;
  always @ *
  begin
    if (strip_rx_fcs & (frm_byte_cnt >= 14'h0004))
      frame_length = frm_byte_cnt[13:0] - 14'h0004;
    else
      frame_length = frm_byte_cnt[13:0];
  end

  gem_rx_per_queue_flush # (
      .grouped_params (grouped_params)
    ) i_gem_rx_per_queue_flush (
      .n_rxreset                (n_rxreset),                // reset
      .rx_clk                   (rx_clk),                   // clock
      .enable_receive_rck       (enable_receive_rck),       // soft reset
      .max_val_pclk             (max_val_pclk),             // bits 31:16 of rx_q_flush register (for each queue)
      .drop_all_frames_rx_clk   (drop_all_frames_rx_clk),   // bit 0 (for each queue)
      .limit_frames_size_rx_clk (limit_frames_size_rx_clk), // bit 3 (for each queue)
      .queue_ptr_rx             (queue_ptr_rx),             // queue pointer in SRAM push phase
      .final_eop_push           (final_eop_push),           // Early end of packet strobe
      .frame_length             (frame_length),             // it counts the frame length expressed in bytes
      .rx_drop_frame            (rx_drop_frame),            // Output associated to Mode0, Mode2, 3, and 4
      .frame_flushed_tog        (frame_flushed_tog),        // toggle to stats regs: flush by mode 2, 3, or 4
      .fill_lvl_breached        (fill_lvl_breached)         // Coming from EDMA RX-RD, signalling a breach on the fill level
  );

  //-------------------------------------------
  // Per type 2 screener rate limiting
  //-------------------------------------------
  generate if((p_num_type2_screeners > 8'd0))
  begin: gen_per_scr2_rate_lim
    gem_rx_per_scr2_rate_lim # (
        .grouped_params (grouped_params)
      ) i_gem_rx_per_scr2_rate_lim (
        .n_rxreset          (n_rxreset),                                   // reset
        .rx_clk             (rx_clk),                                      // clock
        .enable_receive_rck (enable_receive_rck),                          // soft reset
        .frame_length       (frame_length),                                // frame length
        .final_eop_push     (final_eop_push),                              // early version of rx_w_eop
        .rx_w_eop           (rx_w_eop),                                    // end of packet strobe at fifo if
        .end_of_frame       (end_of_frame),                                // sampling point for scr2_match_vec
        .scr2_match_vec     (scr2_match_vec),                              // type 2 screener matching vector
        .scr2_rate_lim_regs (scr2_rate_lim[(32*p_num_type2_screeners):1]), // type 2 screener rate limiting registers
        .scr2_rate_lim_drop (scr2_rate_lim_drop),                          // drop signal to gem_rx
        .scr_excess_rate    (scr_excess_rate)                              // ouput for statistic registers
    );
  end
  else
  begin: no_gen_per_scr2_rate_lim
    assign scr2_rate_lim_drop = 1'b0;
    assign scr_excess_rate    = 1'b0;
  end
  endgenerate

  // decide what is a bad frame
  assign bad_frame = too_long | too_long_dec | too_short |
                     (crc_error_reg & ~rx_no_crc_check) |
                     code_error_saved | length_error | update_overflow |
                     overflow_saved | rx_pipeline_overflow  | rx_w_overflow |
                     ip_ck_err_saved | tcp_udp_ck_err_saved | rx_drop_frame |
                     scr_drop_frame_saved | scr2_rate_lim_drop;

  // status back to DMA block.
  // Only load when frame finished (or too long) and valid length has
  // been measured and the previous status has been taken by the DMA.
  // Do not signal if frame has not been matched as the DMA know nothing
  // about the frame.
  // Generate rx_w_bad_frame if any of the error conditions are true.
  generate if (p_num_spec_add_filters > 32'd0) begin : gen_spec_add2
   reg  [p_num_spec_add_filters-1:0] rx_w_add_match_r;
   always@(posedge rx_clk or negedge n_rxreset)
   begin
     if (~n_rxreset)
           rx_w_add_match_r       <= {p_num_spec_add_filters{1'b0}};
     else if ((pipeline_finished | too_long_dec) & ~too_long &
               frame_matched_pipe & ~update_in_progress &
               (frm_byte_cnt != 14'd0))
           rx_w_add_match_r       <= add_match_saved[p_num_spec_add_filters:1];
   end
   assign rx_w_add_match = {rx_w_add_match_r,1'b0};
  end else begin : gen_no_spec_add2
   assign rx_w_add_match = 1'b0;
  end
  endgenerate
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      begin
        rx_w_bad_frame       <= 1'b0;
        rx_w_frame_length    <= 14'd0;
        rx_w_broadcast_frame <= 1'b0;
        rx_w_mult_hash_match <= 1'b0;
        rx_w_uni_hash_match  <= 1'b0;
        rx_w_ext_match1      <= 1'b0;
        rx_w_ext_match2      <= 1'b0;
        rx_w_ext_match3      <= 1'b0;
        rx_w_ext_match4      <= 1'b0;
        rx_w_type_match1     <= 1'b0;
        rx_w_type_match2     <= 1'b0;
        rx_w_type_match3     <= 1'b0;
        rx_w_type_match4     <= 1'b0;
        rx_w_checksumi_ok    <= 1'b0;
        rx_w_checksumt_ok    <= 1'b0;
        rx_w_checksumu_ok    <= 1'b0;
        rx_w_snap_frame      <= 1'b0;
        rx_w_length_error    <= 1'b0;
        rx_w_crc_error       <= 1'b0;
        rx_w_too_short       <= 1'b0;
        rx_w_too_long        <= 1'b0;
        rx_w_code_error      <= 1'b0;
      end
    else if ((pipeline_finished | too_long_dec) & ~too_long &
              frame_matched_pipe & ~update_in_progress &
              (frm_byte_cnt != 14'd0))
      begin
        rx_w_bad_frame          <= bad_frame;
        rx_w_broadcast_frame    <= broad_frame_saved;
        rx_w_mult_hash_match    <= multi_match_saved;
        rx_w_uni_hash_match     <= uni_match_saved;
        rx_w_ext_match1         <= ext_match1_saved;
        rx_w_ext_match2         <= ext_match2_saved;
        rx_w_ext_match3         <= ext_match3_saved;
        rx_w_ext_match4         <= ext_match4_saved;
        rx_w_type_match1        <= type_match1_saved;
        rx_w_type_match2        <= type_match2_saved;
        rx_w_type_match3        <= type_match3_saved;
        rx_w_type_match4        <= type_match4_saved;
        rx_w_checksumi_ok       <= rx_toe_enable & ip_v4_frame_saved &
                                   ~ip_ck_err_saved;
        rx_w_checksumt_ok       <= rx_toe_enable & tcp_frame_saved &
                                   ~tcp_udp_ck_err_saved & ~ip_ck_err_saved;
        rx_w_checksumu_ok       <= rx_toe_enable & udp_frame_saved &
                                   ~tcp_udp_ck_err_saved & ~ip_ck_err_saved;
        rx_w_snap_frame         <= snap_frame_saved;

        rx_w_length_error       <= length_error;
        rx_w_crc_error          <= crc_error_reg & ~too_long_dec;
        rx_w_too_short          <= too_short;
        rx_w_too_long           <= too_long_dec;
        rx_w_code_error         <= code_error_saved;
        rx_w_frame_length[13:0] <= frame_length;

      end
  end

  // When the first sof is passed to the pbuf, pass
  // the decoded screen to the pbuf, then hold the
  // value when frame decode has stopped.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      begin
        queue_ptr_rx <= 4'd0;
        queue_ptr_rx_enable <= 1'd0;
      end
    else
      begin
        if (rx_w_sop && frame_being_decoded)
          queue_ptr_rx_enable <= 1'b1;
        else if (!frame_being_decoded)
          queue_ptr_rx_enable <= 1'b0;

        if (queue_ptr_rx_enable & ext_rxq_sel_en_rck)
          queue_ptr_rx <= {ext_match4_from_loop,ext_match3_from_loop,ext_match2_from_loop,ext_match1_from_loop};
        else if (queue_ptr_rx_enable)
          queue_ptr_rx <= queue_ptr_rx_scn;
      end
  end

  // Status signals to register block. Only updated when frame finished,
  // and previous status has been taken.
  // If an overflow has occured for this reason then there will a
  // further update once the current update has completed.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
     if (~n_rxreset)
       begin
         rx_frame_rxed_ok   <= 1'b0;
         rx_align_error     <= 1'b0;
         rx_crc_error       <= 1'b0;
         rx_short_error     <= 1'b0;
         rx_long_error      <= 1'b0;
         rx_jabber_error    <= 1'b0;
         rx_symbol_error    <= 1'b0;
         rx_length_error    <= 1'b0;
         rx_ip_ck_error     <= 1'b0;
         rx_tcp_ck_error    <= 1'b0;
         rx_udp_ck_error    <= 1'b0;
         rx_overflow        <= 1'b0;
         rx_pause_frame     <= 1'b0;
         rx_pause_nonzero   <= 1'b0;
         rx_broadcast_frame <= 1'b0;
         rx_multicast_frame <= 1'b0;
         rx_bytes_in_frame  <= 14'h0000;
         rx_pfc_pause_frame <= 1'b0;
         rx_pfc_pause_nonzero <= 1'b0;
       end
     else if ((pipeline_finished & ~((update_in_progress & ~too_long) |
                                     (rx_end_frame & too_long))) |
              (update_finished & update_overflow))
       begin
         rx_frame_rxed_ok   <= ~rx_w_err_next & frame_matched_pipe;
         rx_align_error     <= ~too_long & ~too_short & nibble_cnt_odd_saved
                               & (crc_error_reg | code_error_saved);
         rx_crc_error       <= ~too_long & ~too_short & ~nibble_cnt_odd_saved
                               & (crc_error_reg | code_error_saved);
         rx_short_error     <= too_short & ~crc_error_reg;
         rx_long_error      <= too_long & ~crc_error_reg & ~code_error_saved;
         rx_jabber_error    <= too_long & (crc_error_reg | code_error_saved);
         rx_symbol_error    <= code_error_saved & ~(gigabit & too_short);
         rx_length_error    <= length_error;
         rx_ip_ck_error     <= ~too_long & ~too_short & ~code_error_saved &
                               ~crc_error_reg & ip_ck_err_saved;
         rx_tcp_ck_error    <= ~too_long & ~too_short & ~code_error_saved &
                               ~crc_error_reg & tcp_frame_saved &
                               tcp_udp_ck_err_saved;
         rx_udp_ck_error    <= ~too_long & ~too_short & ~code_error_saved &
                               ~crc_error_reg & udp_frame_saved &
                               tcp_udp_ck_err_saved;
         rx_overflow        <= overflow_saved | rx_pipeline_overflow |
                               rx_w_overflow | update_overflow;
         rx_pause_frame     <= pause_frame_saved & ~bad_frame & ~pfc_negotiate;
         rx_pause_nonzero   <= pause_frame_saved & ~bad_frame & ~pfc_negotiate &
                               (pause_time_saved != 16'h0000);
         rx_broadcast_frame <= broad_frame_saved & ~bad_frame &
                               frame_matched_pipe;
         rx_multicast_frame <= multi_frame_saved & ~bad_frame &
                               frame_matched_pipe;

         // Always signal full byte count to statistic registers
         // even if striping FCS.
         rx_bytes_in_frame  <= frm_byte_cnt;
         rx_pfc_pause_frame <= pfc_pause_frame_saved & ~bad_frame &
                               pfc_enable_rck;
         rx_pfc_pause_nonzero <= pfc_pause_frame_saved & ~bad_frame &
                                 pfc_enable_rck;
       end
  end

  // Generate PFC pause frame negotiate, the signal is set when a
  // PFC pause frame is detected and is reset when pfc_enable is low
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      pfc_negotiate     <= 1'b0;
    else
      begin
        if (~pfc_enable_rck)
          pfc_negotiate <= 1'b0;
        else
          begin
            if (rx_pfc_pause_frame)
              pfc_negotiate <= 1'b1;
            else
              pfc_negotiate <= pfc_negotiate;
          end
      end
  end

// -----------------------------------------------------------------------------
// Signal pause frame and new time to GEM_TX
// -----------------------------------------------------------------------------

  // signal to GEM_TX when a new pause time is available. This will be done
  // by a toggle signal that changes state every time a new pause frame is
  // received and decoded successfully.
  // Only active when both pause is enabled and in full duplex mode.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      begin
        new_pause_time <= 16'h0000;
        new_pause_tog  <= 1'b0;
      end
    else if (pipeline_finished & pause_frame_saved & ~bad_frame &
             pause_enable_rck & full_duplex & (~pfc_negotiate))
      begin
        new_pause_time <= pause_time_saved;
        new_pause_tog  <= ~new_pause_tog;
      end
  end

// -----------------------------------------------------------------------------
// Signal PFC pause frame and new time to GEM_RX_PFC_TIMER
// -----------------------------------------------------------------------------

  // signal to GEM_RX_PFC_TIMER when a new PFC pause time is available.
  // This will be done by a toggle signal that changes state every time
  // a PFC new pause frame is received and decoded successfully.
  // Only active when both PFC is enabled and in full duplex mode.
  assign new_pfc_pause_time0 = pfc_pause_time0;
  assign new_pfc_pause_time1 = pfc_pause_time1;
  assign new_pfc_pause_time2 = pfc_pause_time2;
  assign new_pfc_pause_time3 = pfc_pause_time3;
  assign new_pfc_pause_time4 = pfc_pause_time4;
  assign new_pfc_pause_time5 = pfc_pause_time5;
  assign new_pfc_pause_time6 = pfc_pause_time6;
  assign new_pfc_pause_time7 = pfc_pause_time7;
  assign new_priority_enable = priority_enable;

  // drive new_pfc_pause_tog
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      new_pfc_pause_tog   <= 1'b0;
    else if (pipeline_finished & pfc_pause_frame_saved & ~bad_frame &
             pfc_enable_rck & full_duplex )
      new_pfc_pause_tog   <= ~new_pfc_pause_tog;
  end

// -----------------------------------------------------------------------------
// Priority Queue Screeners
// -----------------------------------------------------------------------------

  assign reset_queue_ptr = (dma_update_finished | start_of_data);
  generate if (p_num_type1_screeners == 8'd0 && p_num_type2_screeners == 8'd0) begin : gen_no_screeners
    assign queue_ptr_rx_scn = 4'd0;
    assign scr_drop_frame   = 1'b0;
  end else begin : gen_screeners
    gem_screener_top # (
                          .p_num_type1_screeners (p_num_type1_screeners),
                          .p_num_type2_screeners (p_num_type2_screeners)
                       ) i_gem_screener_top(
      .n_rxreset           (n_rxreset),
      .rx_clk              (rx_clk),
      .reset_queue_ptr     (reset_queue_ptr),
      .screener_type1_regs (screener_type1_regs),
      .ip_v4_frame         (ip_v4_frame),
      .ip_v6_frame         (ip_v6_frame),
      .udp_frame           (udp_frame),
      .ip_v4_tos           (ip_v4_tos),
      .ip_v6_tc            (ip_v6_tc),
      .udp_dest_addr       (udp_dest_addr),

      .screener_type2_regs (screener_type2_regs),
      .scr2_ethtype_match  (scr2_ethtype_match[7:0]),
      .scr2_compare_match  (scr2_compare_match[31:0]),
      .tci                 (tci[3:1]),
      .vlan_tagged         (vlan_tagged),

      .priority_queue      (queue_ptr_rx_scn),
      .drop_frame          (scr_drop_frame),
      .scr2_match_vec      (scr2_match_vec)
    );
  end
  endgenerate

  generate if (p_num_scr2_compare_regs != 8'd0 && p_num_type2_screeners != 8'd0) begin : gen_comp2_regs
  genvar a;
  genvar b;
    wire  frame_has_valid_ctag;
    wire  frame_has_valid_stag;
    wire [p_num_scr2_compare_regs-1:0] offset_type_0,offset_type_1,offset_type_2,offset_odd;
    reg [p_num_scr2_compare_regs-1:0] frameatoffset;
    reg [15:0] last_databyte;
    reg [15:0] last_last_databyte;
    reg [32:0] scr2_compare_match_r;  // Type 2 ext screening compare match bus

    // The S-TAG for VLAN matching is defined only if it matches the stacked vlan type programmed into
    // the registers.
    // The C-TAG will always be the 2nd VLAN if two VLANs were seen or the first VLAN only if it
    // matches the standard 8100 VLAN type.
    assign frame_has_valid_stag = {1'b1,ext_vlan_tag1[31:16]} == stacked_vlantype[16:0];
    assign frame_has_valid_ctag = ext_has_2vlans  ? 1'b1            // ext_has_2vlans will always be set only for 8100 type.
                                                  : ext_vlan_tag1[31:16] == 16'h8100;

    always@(posedge rx_clk or negedge n_rxreset)
    begin
      if (~n_rxreset)
      begin
        last_databyte       <= 16'd0;
        last_last_databyte  <= 16'd0;
      end
      else if (new_aligned_data)
      begin
        last_databyte       <= new_data_align[15:0];
        last_last_databyte  <= last_databyte[15:0];
      end
    end

    for (a=0; a<p_num_scr2_compare_regs; a = a+1)
    begin : screener_type2_compare_process
      wire        comp_reg_no_mask;
      wire [15:0] comp_reg_value;
      wire [15:0] comp_reg_mask;
      assign comp_reg_no_mask     = scr2_compare_regs[(43*a)+41+1];
      assign comp_reg_value       = scr2_compare_regs[(43*a)+31+1:(43*a)+16+1]; // Compare Value from screener
      assign comp_reg_mask        = scr2_compare_regs[(43*a)+15+1:(43*a+1)];    // Compare Mask from screener

      assign offset_type_0[a]    = scr2_compare_regs[(43*a)+39+1];
      assign offset_type_1[a]    = scr2_compare_regs[(43*a)+40+1];
      assign offset_type_2[a]    = scr2_compare_regs[(43*a)+42+1];
      assign offset_odd[a]       = scr2_compare_regs[(43*a)+32+1];

      // For the packet inspection, the offset from the compare register is defined in bytes, but the data passing through the pipe
      // is in nibbles.  When compare mask is being used (as defined by clearing bit 9 of the 2nd compare register, which is bit 41 wh both comapre
      // registers are concatenated), then we will always do the comparison 1 cycle after the index = offset[6:1]. If offset[0] is cle, then we should
      // compare the previous cycles data stripe with the cmpare value from the comp reg.  If offset[1] is set, we compare the upper 8its of the
      // previous cycles data stripe and the lower 8 bits of the current cycles datastripe with the comp reg.
      // When the compare mask is not used, then we will always do the comparison 2 cycles after the index = offset[6:1]. If offset[0]s clear, then we should
      // compare the previous 2 cycles data stripes (=32 bits) with the cmpare value from the comp reg.  If offset[1] is set, we compa the upper 8 bits of the
      // data 2 cycles previous, the full 16 bits of the previous stripe, and the lower 8 bits of the current cycles datastripe with t 32 bit comp reg.
      // Note that for VLAN matching, the software will have written the offset value to be 0 so we effectively compare straight after the Ethertype by which
      // time all the VLAN decoding would have finished.
      // If the match is set to compare S-TAG but no S-TAG seen, then the frameatoffset[x] signal would not be activated. Similarly for C-TAG.

      wire [6:0] index_from_screener;
      assign index_from_screener = scr2_compare_regs[(43*a)+38+1:(43*a)+33+1] + {4'h0,comp_reg_no_mask,~comp_reg_no_mask};
      always@(*)
      begin
        casex ({offset_type_2[a],offset_type_1[a],offset_type_0[a]})
          3'b000   : // Offset from SOF
          begin
            if (index_cnt_sof == index_from_screener)
              frameatoffset[a]  = 1'b1;
            else
              frameatoffset[a]  = 1'b0;
          end
          3'b001:   // Offset from ethertype
          begin
            if (index_cnt_type == index_from_screener)  // index_from_screener
              frameatoffset[a]  = 1'b1;
            else
              frameatoffset[a]  = 1'b0;
          end
          3'b1x0  : // VLAN CTAG
          begin
            if (index_cnt_type == 7'h01)  // Match just after the Ethertype
              frameatoffset[a]  = frame_has_valid_ctag;
            else
              frameatoffset[a]  = 1'b0;
          end
          3'b1x1  : // VLAN STAG
          begin
            if (index_cnt_type == 7'h01)  // Match just after the Ethertype
              frameatoffset[a]  = frame_has_valid_stag;
            else
              frameatoffset[a]  = 1'b0;
          end

          3'b010   : // Offset from L3 header
          begin
            if (index_cnt_l3 == index_from_screener)
              frameatoffset[a]  = 1'b1;
            else
              frameatoffset[a]  = 1'b0;
          end
          default : // Offset from L4 header
          begin
            if (index_cnt_l4 == index_from_screener)
              frameatoffset[a]  = 1'b1;
            else
              frameatoffset[a]  = 1'b0;
          end
        endcase
      end

      // Perform the comparison as defined above. frameatoffset will go high on the cycle the comparison should take place. new_data_agn is
      // the data from the current stripe, last_databyte is the data from the previous stripe. last_last_databyte is the data from stre 2
      // cycles back
      wire [15:0] scr2_comp_masked;
      wire [31:0] comp_reg32_value;
      wire [15:0] comp_stag_value;
      wire [15:0] comp_ctag_value;
      reg  [15:0] comp_dat_value16;
      reg  [31:0] comp_dat_value32;

      assign comp_ctag_value      = ext_has_2vlans  ? ext_vlan_tag2[15:0] : ext_vlan_tag1[15:0];
      assign comp_stag_value      = ext_vlan_tag1[15:0];
      assign scr2_comp_masked     = comp_reg_value & comp_reg_mask;
      assign comp_reg32_value     = scr2_compare_regs[(43*a)+31+1:(43*a)+1];

      always@(*)
      begin
        if (offset_type_2[a] & ~offset_type_0[a])     // CTAG matching
          comp_dat_value16  = comp_ctag_value;
        else if (offset_type_2[a] & offset_type_0[a]) // STAG matching
          comp_dat_value16  = comp_stag_value;
        else if (offset_odd[a])                       // Normal data match
          comp_dat_value16  = {new_data_align[7:0],last_databyte[15:8]};
        else                                          // Normal data match
          comp_dat_value16  = last_databyte[15:0];

        if (offset_odd[a])
          comp_dat_value32  = {new_data_align[7:0],last_databyte,last_last_databyte[15:8]};
        else
          comp_dat_value32  = {last_databyte,last_last_databyte};
      end

      always@(posedge rx_clk or negedge n_rxreset)
      begin
        if (~n_rxreset)
          scr2_compare_match_r[a] <= 1'b0;
        else if (~enable_receive_rck | ~frame_being_decoded | last_aligned_data)
          scr2_compare_match_r[a] <= 1'b0;
        else if (new_aligned_data)
        begin
          if (frameatoffset[a])
          begin
            if (~comp_reg_no_mask)  // use_mask
              scr2_compare_match_r[a] <= scr2_comp_masked == (comp_dat_value16 & comp_reg_mask);
            else
              scr2_compare_match_r[a] <= comp_reg32_value == comp_dat_value32;
          end
        end
      end
    end
    
    wire   zero;
    assign zero = 1'b0;
    
    // Tie scr2_compare_match bits mapping to non-present compare regs to zero
    for (b={24'd0,p_num_scr2_compare_regs}; b<33; b = b+1)
    begin :scr2_comp_match
      always @(*)
        scr2_compare_match_r[b] = zero;
    end
    assign scr2_compare_match[32:0] = scr2_compare_match_r;

  end else begin  : gen_no_comp2_regs
    assign scr2_compare_match[32:0] = 33'd0;
  end
  endgenerate

  generate if (p_num_scr2_ethtype_regs != 8'd0 && p_num_type2_screeners != 8'd0) begin : gen_ethtype_regs
  genvar c;
  genvar d;
    reg   [8:0]   scr2_ethtype_match_r;  // Type 2 ext screening ethtype match bus
    for (c=0; c<p_num_scr2_ethtype_regs; c = c+1)
    begin :scr2_eth_match
      always@(posedge rx_clk or negedge n_rxreset)
      begin
        if (~n_rxreset)
          scr2_ethtype_match_r[c] <= 1'b0;
        else if (~enable_receive_rck | ~frame_being_decoded | last_aligned_data)
          scr2_ethtype_match_r[c] <= 1'b0;
        else if (ext_type_stb)
          scr2_ethtype_match_r[c] <=  ext_type == scr2_ethtype_regs[(16*c)+16:(16*c)+1];
      end
    end
    
    wire   zero;
    assign zero = 1'b0;
    
    // Tie scr2_compare_match bits mapping to non-present compare regs to zero
    for (d={24'd0,p_num_scr2_ethtype_regs}; d<9; d = d+1)
    begin : scr2_eth_match2
      always @(*)
        scr2_ethtype_match_r[d] = zero;
    end
    assign scr2_ethtype_match[8:0] = scr2_ethtype_match_r;
  end else begin  : gen_no_ethtype_regs
    assign scr2_ethtype_match[8:0] = 9'd0;
  end
  endgenerate


  // Timestamp capture

  generate if (p_edma_tsu == 1'b1) begin : gen_tsu

    reg     [77:0] rx_w_timestamp_r;
    reg     [9:0]  rx_w_timestamp_prty_r;      // parity protection for the rx_w_timestamp_r
    reg            tsu_timer_safe_to_sample;   // Qualifer
    wire           tsu_timer_safe_to_sample_c; // Qualifer
    reg     [77:0] tsu_timer_sampled_on_sof;             // TSU timer count value
    reg     [9:0]  tsu_timer_prty_sampled_on_sof;        // parity protection for the TSU timer count value
    wire           sof_rx_sync;                // 2nd Sync flop for sof_tx (into tsu_clk)
    reg            sof_rx_sync_d1;             // delayed flop for rising edge detect
    wire           rx_sof_pclk,rx_sof_tsu;
    reg     [77:0] tsu_ptp_rx_timer_out_r;      // Timestamp in PCLK domain
    reg     [9:0]  tsu_ptp_rx_timer_out_prty_r; // parity protection for tsu_ptp_rx_timer_out_r Timestamp in PCLK domain

    // In order to support single step timestamp insertion with maximum accuracy, the timstamp
    // must be captured based on the tx_sof event, passed into the TSU clock. that way the timestamp
    // can be accurately captured asap.  the captured TS must then be passed back to the TX clock for
    // insertion into the timestamp.
    // Timestamp location for PTPoE is offset 48 (34 of PTP frame + 14 ethernet header)
    // It is > than this for PTPoIP, so use PTPoE as worst case
    // Minimum sized ethernet frame is 64bytes
    // By enforcing the rule that TSU clock is > 1/8th the frequency of TX_CLK, this allows for 6 TSU clocks
    // to create a toggle signal on tx_sof, pass into TSU domain and sample the TS into a stable bank of registers.
    // This final register bank will be stable for an entire frame, i.e. >= 64 tx_clks. It will also be stable at
    // the point this module needs to sample it for insertion into the frame, and it will be stable at the point
    // gem_dma_pbuf_tx_rd.v needs to sample it on tx_r_eop.

    // first synchronize the SOF event to the TSU clock domain
     cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_sof_rx_tog (
        .clk(tsu_clk),
        .reset_n(n_tsureset),
        .din(sof_rx_tog),
        .dout(sof_rx_sync));

    always@(posedge tsu_clk or negedge n_tsureset)
      if (~n_tsureset)
        sof_rx_sync_d1  <= 1'b0;
      else
        sof_rx_sync_d1  <= sof_rx_sync;

    // detect the SOF event in TSU clock domain
    assign rx_sof_tsu = sof_rx_sync_d1 ^ sof_rx_sync;

    // sample the time in TSU clock domain.  This will remain valid for an entire frame
    // From sof_tx to next sof_tx
    always@(posedge tsu_clk or negedge n_tsureset)
    begin
      if (~n_tsureset)
      begin
        tsu_timer_sampled_on_sof      <= {78{1'b0}};
        tsu_timer_prty_sampled_on_sof <= {10{1'b0}};
      end
      else
      begin
        if (rx_sof_tsu) begin
          tsu_timer_sampled_on_sof      <= tsu_timer_cnt[93:16];
          tsu_timer_prty_sampled_on_sof <= tsu_timer_cnt_par[11:2];
        end
      end
    end
    edma_sync_toggle_detect i_edma_sync_toggle_detect_sof_tx_sync_d1 (
      .clk(rx_clk),
      .reset_n(n_rxreset),
      .din(sof_rx_sync_d1),
      .rise_edge(),
      .fall_edge(),
      .any_edge(tsu_timer_safe_to_sample_c));

     always@(posedge rx_clk or negedge n_rxreset)
     begin
        if (~n_rxreset)
           // asynchronous reset.
          tsu_timer_safe_to_sample <= 1'b0;
        else if (tsu_timer_safe_to_sample_c)
          tsu_timer_safe_to_sample <= 1'b1;
        else if (rx_dv_int_te)
          tsu_timer_safe_to_sample <= 1'b0;
     end

    // Now sample it at a point we know the timer value is stable ...
    always@(posedge rx_clk or negedge n_rxreset)
    begin
      if (~n_rxreset) begin
        rx_w_timestamp_r      <= {78{1'b0}};
        rx_w_timestamp_prty_r <= {10{1'b0}};
      end
      else
      begin
        if (rx_dv_int_te & tsu_timer_safe_to_sample) begin
          rx_w_timestamp_r      <= tsu_timer_sampled_on_sof;
          rx_w_timestamp_prty_r <= tsu_timer_prty_sampled_on_sof;
        end
      end
    end

    // Now synchonize to pclk
     edma_sync_toggle_detect i_edma_sync_toggle_detect_sof_rx_sync_d1 (
        .clk(pclk),
        .reset_n(n_preset),
        .din(sof_rx_sync_d1),
        .rise_edge(),
        .fall_edge(),
        .any_edge(rx_sof_pclk));

    always@(posedge pclk or negedge n_preset)
      if (~n_preset) begin
        tsu_ptp_rx_timer_out_r      <= {78{1'b0}};
        tsu_ptp_rx_timer_out_prty_r <= {10{1'b0}};
      end else
        if (rx_sof_pclk) begin
          tsu_ptp_rx_timer_out_r      <= tsu_timer_sampled_on_sof;
          tsu_ptp_rx_timer_out_prty_r <= tsu_timer_prty_sampled_on_sof;
        end

    assign rx_w_timestamp       = rx_w_timestamp_r;
    assign rx_w_timestamp_prty   = rx_w_timestamp_prty_r;
    assign tsu_ptp_rx_timer_out = tsu_ptp_rx_timer_out_r;
    assign tsu_ptp_rx_timer_prty_out = tsu_ptp_rx_timer_out_prty_r;

  end else begin : gen_no_tsu
    assign rx_w_timestamp            = 78'd0;
    assign rx_w_timestamp_prty       = 10'd0;
    assign tsu_ptp_rx_timer_out      = 78'd0;
    assign tsu_ptp_rx_timer_prty_out = 10'd0;
  end
  endgenerate

  assign rx_w_l4_offset      = {udptcp_offset_str[10:0],1'b0};
  assign rx_w_pld_offset     = pld_offset_str[11:0];
  assign rx_w_pld_offset_vld = pld_offset_vld;


  // This section detects and extracts the FRER 802.1CB RTag Sequence Number
  // and instantiates the elimination function and associated logic.
  generate if ((p_gem_has_cb == 1'b1) && (p_num_type2_screeners > 8'd0))
  begin : gen_cb

    wire  [p_gem_num_cb_streams-1:0]  frer_en_elim_sync;  // Synchronisers
    wire  [p_gem_num_cb_streams-1:0]  frer_en_to_sync;    // Synchronisers
    wire  [p_gem_num_cb_streams-1:0]  frer_discard_strm;  // Discard per func

    reg   [1:0]   frer_seq_num_cap_nxt;   // Signals for detection of the
    reg   [15:0]  frer_rtag_seqnum;       // embedded 802.1CB Redundancy
    reg           frer_rtag_seqnum_val;   // Tag which was marked by rx_dec
    reg   [15:0]  frer_match_vec;         // Sample screener type 2 regs
    reg   [8:0]   frer_oset_cnt;          // Regenerate counter from SoF
    wire  [9:0]   frer_oset_cnt_p1;       // + 1
    reg   [5:0]   frer_32_count;          // Counter for stats transfer
    wire  [6:0]   frer_32_count_p1;       // + 1
    reg   [8:0]   frer_8k_count;          // Counter for rx_clk cycles
    wire  [9:0]   frer_8k_count_p1;       // + 1
    wire  [9:0]   frer_8k_count_p256;     // + 256

    // Synchronise the enable signals
    cdnsdru_datasync_v1 #(.CDNSDRU_DATASYNC_DIN_W({24'd0,p_gem_num_cb_streams})) i_sync_en_elim (
      .clk      (rx_clk),
      .reset_n  (n_rxreset),
      .din      (frer_en_elim),
      .dout     (frer_en_elim_sync)
    );
    cdnsdru_datasync_v1 #(.CDNSDRU_DATASYNC_DIN_W({24'd0,p_gem_num_cb_streams})) i_sync_en_to (
      .clk      (rx_clk),
      .reset_n  (n_rxreset),
      .din      (frer_en_to),
      .dout     (frer_en_to_sync)
    );

    // The RX decoder has already marked the Redundancy Tag in the pipeline
    // so we just extract it here...
    always@(posedge rx_clk or negedge n_rxreset)
    begin
      if (~n_rxreset)
      begin
        frer_rtag_seqnum      <= 16'h0000;
        frer_rtag_seqnum_val  <= 1'b0;
        frer_seq_num_cap_nxt  <= 2'b00;
      end
      else
        // Clear down signals when RX disabled or at the end of the current frame.
        if (~enable_receive_rck | final_eop_push)
        begin
          frer_rtag_seqnum      <= 16'h0000;
          frer_rtag_seqnum_val  <= 1'b0;
          frer_seq_num_cap_nxt  <= 2'b00;
        end
        else
          if (new_pipeline_data)
          begin
            if (&frer_seq_num_cap_nxt)
            begin
              frer_seq_num_cap_nxt  <= 2'b00;
              frer_rtag_seqnum_val  <= 1'b1;
              frer_rtag_seqnum      <= {pipeline_output[7:0],pipeline_output[15:8]};
            end
            else
              frer_seq_num_cap_nxt  <= {pipeline_output[19],((~frer_6b_tag & pipeline_output[19]) | frer_seq_num_cap_nxt[1])};
          end
    end

    // Generate a counter that starts from the start of frame.
    // This is used for cases where the Redundancy Tag is not used to extract the
    // sequence number.
    // Also sample the screener compare match result
    always@(posedge rx_clk or negedge n_rxreset)
    begin
      if (~n_rxreset)
      begin
        frer_oset_cnt   <= 9'h000;
        frer_match_vec  <= 16'h0000;
      end
      else
        if (~enable_receive_rck | pipeline_finished)
        begin
          frer_oset_cnt <= 9'h000;
          frer_match_vec  <= 16'h0000;
        end
        else
        begin
          frer_match_vec  <= frer_match_vec | scr2_match_vec[15:0];
          if (new_pipeline_data & ~frer_oset_cnt[8])
            frer_oset_cnt <= frer_oset_cnt_p1[8:0];
        end
    end
    assign frer_oset_cnt_p1 = frer_oset_cnt + 9'h001;

    // The following counter is used to allow periodic transfer of stats to the
    // APB registers.
    // It is disabled if no elimination functions are enabled.
    always@(posedge rx_clk or negedge n_rxreset)
    begin
      if (~n_rxreset)
        frer_32_count <= 6'd0;
      else
        if (~enable_receive_rck | ~(|frer_en_elim_sync))
          frer_32_count <= 6'd0;
        else
          frer_32_count <= frer_32_count_p1[5:0];
    end
    assign frer_32_count_p1 = {1'b0,frer_32_count} + 7'd1;

    // The following counter is used for the timeout function in the elimination
    // function. It is used in conjunction with the above counter to save gates
    // and power.
    // It is disabled if no elimination function or no timeout functions are
    // enabled.
    // If the retry_test_rck test mode is set, then this counter will
    // increment by 256 every clock cycle, i.e. will cause frer_8k_count[8] to
    // toggle every cycle.
    always@(posedge rx_clk or negedge n_rxreset)
    begin
      if (~n_rxreset)
        frer_8k_count <= 9'd0;
      else
        if (~enable_receive_rck | ~(|frer_en_elim_sync) | ~(|frer_en_to_sync))
          frer_8k_count <= 9'd0;
        else
          if (retry_test_rck)
            frer_8k_count <= frer_8k_count_p256[8:0];
          else
            if (frer_32_count[4:0] == 5'd31)
              frer_8k_count <= frer_8k_count_p1[8:0];
    end
    assign frer_8k_count_p256 = frer_8k_count + 9'd256;
    assign frer_8k_count_p1   = frer_8k_count + 9'd1;

    // Instantiate the FRER elimination module...
    gem_rx_frer_elim
      #(
        .p_hist_depth(p_gem_cb_history_len)
        ) i_frer_elim[p_gem_num_cb_streams-1:0] (
      .rx_clk               (rx_clk),
      .n_rxreset            (n_rxreset),
      .frer_to_cnt          (frer_to_cnt),
      .frer_en_vec_alg      (frer_en_vec_alg),
      .frer_use_rtag        (frer_use_rtag),
      .frer_seqnum_oset     (frer_seqnum_oset),
      .frer_seqnum_len      (frer_seqnum_len),
      .frer_scr_sel_1       (frer_scr_sel_1),
      .frer_scr_sel_2       (frer_scr_sel_2),
      .frer_vec_win_sz      (frer_vec_win_sz),
      .enable_receive       (enable_receive_rck),
      .bad_frame            (bad_frame),
      .frame_matched_pipe   (frame_matched_pipe),
      .rx_end_frame         (final_eop_push),
      .scr2_match_vec       (frer_match_vec),
      .frer_oset_cnt        (frer_oset_cnt[7:0]),
      .frer_rtag_seqnum     (frer_rtag_seqnum),
      .frer_rtag_seqnum_val (frer_rtag_seqnum_val),
      .new_pipeline_data    (new_pipeline_data),
      .pipeline_output      (pipeline_output[19:0]),
      .frer_en_elim_sync    (frer_en_elim_sync),
      .frer_en_to_sync      (frer_en_to_sync),
      .frer_to_cnt_tog      (frer_8k_count[8]),
      .frer_32_cnt_tog      (frer_32_count[5]),
      .frer_to_tog          (frer_to_tog),
      .frer_rogue_tog       (frer_rogue_tog),
      .frer_ooo_tog         (frer_ooo_tog),
      .frer_err_upd_tog     (frer_err_upd_tog),
      .frer_err_upd_val     (frer_err_upd_val),
      .frer_discard         (frer_discard_strm)
    );
    assign frer_discard = |frer_discard_strm;
  end
  else
  begin : gen_no_cb
    assign frer_discard        = 1'b0;
    assign frer_to_tog         = {p_gem_num_cb_streams{1'b0}};
    assign frer_rogue_tog      = {p_gem_num_cb_streams{1'b0}};
    assign frer_ooo_tog        = {p_gem_num_cb_streams{1'b0}};
    assign frer_err_upd_tog    = {p_gem_num_cb_streams{1'b0}};
    assign frer_err_upd_val    = {p_gem_num_cb_streams{7'd0}};
  end
  endgenerate

// -----------------------------------------------------------------------------
// RAS - End to end data path parity protection
// -----------------------------------------------------------------------------

  /////////////////////////////////////////////////
  // RAS - end to end parity check
  generate if (p_edma_asf_dap_prot == 1'b1) begin : gen_dp_parity
   // First parity check at the MAC RX output
    cdnsdru_asf_parity_check_v1 #(.p_data_width(128)) i_gem_par_chk_dp_rx_mac_o (
     .odd_par(1'b0),
     .data_in(data_store_128),
     .parity_in(data_store_128_par),
     .parity_err(asf_dap_mac_rx_err)
    );

    // Need to generate parity for udptcp_offset_str
    cdnsdru_asf_parity_gen_v1 #(
      .p_data_width (11)
    ) i_par_gen_udptcp_offset_str_par (
      .odd_par    (1'b0),
      .data_in    (udptcp_offset_str),
      .data_out   (),
      .parity_out (udptcp_offset_str_par)
    );

  end else begin : gen_no_dp_parity
    assign asf_dap_mac_rx_err     = 1'b0;
    assign udptcp_offset_str_par  = 2'b00;
  end
  endgenerate

endmodule

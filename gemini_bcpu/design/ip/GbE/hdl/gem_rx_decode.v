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
//   Filename:           gem_rx_decode.v
//   Module Name:        gem_rx_decode
//
//   Release Revision:   r1p12f6
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
//             Decoding logic: The received frame's destination address, source
//                             address, typeID/Length and VLAN fields are
//                             extracted and presented to both the internal
//                             filter module and the external filter interface.
//
//------------------------------------------------------------------------------


// The gem_rx_decode module definition
module gem_rx_decode (

   // system signals
   n_rxreset,
   rx_clk,

   // Mode selection
   enable_receive_rck,
   pause_enable_rck,
   rx_toe_enable,
   frer_6b_tag,

   // Decode control signals
   frame_being_decoded,
   end_of_frame,
   pause_add_match,
   start_of_data,
   new_aligned_data,
   new_data_align,
   rx_no_pause_frames,

   // external filter interface outputs
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
   drop_pause_frame,

   // Stacked VLAN tag support
   stacked_vlantype,
   ext_vlan_tag1,
   ext_vlan_tag1_stb,
   ext_vlan_tag2,
   ext_vlan_tag2_stb,
   ext_has_2vlans,

   // 802.1CB RTag support
   frer_rtag_ethertype,
   frer_rtag_mark_early,
//   frer_rtag_seqnum,
//   frer_rtag_seqnum_stb,

   // precision time protocol signals for IEEE 1588 support
   sof_rx,
   sof_rx_tog,
   sync_frame_rx,
   delay_req_rx,
   pdelay_req_rx,
   pdelay_resp_rx,
   general_frame_rx,
   ptp_unicast_ena,
   rx_ptp_unicast,

   // Index for Packet Fields
   index_cnt_sof,
   index_cnt_type,
   index_cnt_l3,
   index_cnt_l4,
   udptcp_offset,
   pld_offset,
   pld_offset_vld,

   // Frame type and status outputs
   length_field,
   vlan_tagged,
   priority_tagged,
   tci,
   pause_frame,
   pause_time,
   snap_frame,
   ip_v4_frame,
   ip_v6_frame,
   arp_frame,
   tcp_frame,
   udp_frame,
   ip_ck_err,
   tcp_udp_ck_err,

   // Matches for screener module - Queue Priority
   ip_v4_tos,
   ip_v6_tc,

   // RSC Flags
   rsc_stop,
   rsc_push,
   tcp_seqnum,
   tcp_syn,
   tcp_payload_len,

   // PFC pause frame
   pfc_enable_rck,
   pfc_pause_frame,
   pfc_pause_time0,
   pfc_pause_time1,
   pfc_pause_time2,
   pfc_pause_time3,
   pfc_pause_time4,
   pfc_pause_time5,
   pfc_pause_time6,
   pfc_pause_time7,
   priority_enable

   );

   parameter [1363:0] grouped_params = {1364{1'b0}};
   `include "ungroup_params.v"

// -----------------------------------------------------------------------------
// declare Inputs and Outputs
// -----------------------------------------------------------------------------

   // system inputs
   input         n_rxreset;               // RX clock system reset
   input         rx_clk;                  // RX clock input

   // Mode selection
   input         enable_receive_rck;      // Enable receive logic
   input         pause_enable_rck;        // Enable pause frame operation
   input         rx_toe_enable;           // Enable RX TCP Offload Engine
   input         frer_6b_tag;             // R-Tag is 6 bytes not 4 bytes

   // Decode control signals
   input         frame_being_decoded;     // valid frame is being decoded
   input         end_of_frame;            // end of frame detected.
   input         pause_add_match;         // dest address indicates pause frame
   input         start_of_data;           // new frame data coming in
   input         new_aligned_data;        // new 32 bit aligned data ready
   input  [23:0] new_data_align;          // buffer containing aligned data
                                          // in lowest 16 bits and residue
                                          // in upper 8 bits
   input         rx_no_pause_frames;      // pause frames dropped

   // external filter interface outputs
   output [47:0] ext_da;                  // destination address from rx data
   output        ext_da_stb;              // destination address valid strobe
   output [47:0] ext_sa;                  // source address from rx data
   output        ext_sa_stb;              // source address valid strobe
   output [15:0] ext_type;                // length/TypeID field from rx frame
   output        ext_type_stb;            // length/TypeID field valid strobe
   output [127:0] ext_ip_sa;              // IP source address
   output        ext_ip_sa_stb;           // IP source address valid strobe
   output [127:0] ext_ip_da;              // IP destination address
   output        ext_ip_da_stb;           // IP destination address valid strobe
   output [15:0] ext_source_port;         // source port number
   output        ext_sp_stb;              // validates source port number
   output [15:0] ext_dest_port;           // destination port number
   output        ext_dp_stb;              // validates destination port number
   output        ext_ipv6;                // high for ipv6
   output        drop_pause_frame;        // causes pause frames to be dropped

   // Stacked VLAN tag support
   input  [16:0] stacked_vlantype;        // VLAN tag TPID (bit 16 enables
                                          // stacked VLAN tag support)
   output [31:0] ext_vlan_tag1;           // VLAN tag 1
   output        ext_vlan_tag1_stb;       // VLAN tag 1 strobe
   output [31:0] ext_vlan_tag2;           // VLAN tag 2
   output        ext_vlan_tag2_stb;       // VLAN tag 2 strobe
   output        ext_has_2vlans;          // Indicates that 2 VLANs were detected

   // 802.1CB RTag support
   input  [15:0] frer_rtag_ethertype;     // Ethertype used to identify RTags
   output        frer_rtag_mark_early;    // Mark that new_data_align is RTag
//   output [15:0] frer_rtag_seqnum;        // Extracted sequence number
//   output        frer_rtag_seqnum_stb;    // Sequence number is valid

   // precision time protocol signals for IEEE 1588 support
   output        sof_rx;                  // asserted on SFD deasserted at EOF
   output        sof_rx_tog;              // asserted on SFD deasserted at EOF
   output        sync_frame_rx;           // asserted on PTP sync frame
   output        delay_req_rx;            // asserted on PTP delay_req frame
   output        pdelay_req_rx;           // asserted on PTP pdelay_req
   output        pdelay_resp_rx;          // asserted on PTP pdelay_resp frame
   output        general_frame_rx;        // asserted for PTP general message frames
   input         ptp_unicast_ena;         // enable PTPv2 IPv4 unicast IP DA
                                          // detection
   input  [31:0] rx_ptp_unicast;          // rx PTPv2 IPv4 unicast IP DA

   // Frame type and status outputs
   output [15:0] length_field;            // Length field from rx frame
   output        vlan_tagged;             // used for detecting VLAN tag.
   output        priority_tagged;         // used for detecting priority tag.
   output  [3:0] tci;                     // used for extacting VLAN priority.
   output        pause_frame;             // used for detecting pause frame.
   output [15:0] pause_time;              // pause time value decoded.
   output        snap_frame;              // Detect SNAP encapsulated frame.
   output        ip_v4_frame;             // Used for detecting IP ver 4 frame.
   output        ip_v6_frame;             // Used for detecting IP ver 6 frame
   output        arp_frame;               // Used for detecting ARP frame.
   output        tcp_frame;               // Used for detecting TCP frame.
   output        udp_frame;               // Used for detecting UDP frame.
   output        ip_ck_err;               // IP header checksum error.
   output        tcp_udp_ck_err;          // TCP/UDP checksum error.
   output [6:0]  index_cnt_sof;           // Index of Frame from SOF
   output [6:0]  index_cnt_type;          // Index of Frame from ethertype
   output [6:0]  index_cnt_l3;            // Index of Frame from L3
   output [6:0]  index_cnt_l4;            // Index of Frame from L4
   output [10:0]  udptcp_offset;          // Index of L4
   output [15:0]  pld_offset;             // Index of PLD
   output         pld_offset_vld;         // Index of PLD

   // Matches for screener module - Queue Priority
   output  [7:0]  ip_v4_tos;              // value of ipv4 TOS.
   output  [7:0]  ip_v6_tc;               // value of ipv6 TC.

   output         rsc_stop;               // Set if any of the SYN/FIN/RST/URG
                                          // flags are set in the TCP header
   output         rsc_push;               // Set if the PSH flas is set
   output [31:0]  tcp_seqnum;             // Identifies the TCP seqnum of the frame
   output         tcp_syn;                // Set if the SYN flas is set
   output [15:0]  tcp_payload_len;        // Payload Length

   // PFC pause frame signals
   input          pfc_enable_rck;         // enable PFC puase_frame reception
   output         pfc_pause_frame;        // used for detecting PFC pause frame.

   output [15:0]  pfc_pause_time0;        // pause time valude decoded
                                          //(priority 0)
   output [15:0]  pfc_pause_time1;        // pause time valude decoded
                                          //(priority 1)
   output [15:0]  pfc_pause_time2;        // pause time valude decoded
                                          //(priority 2)
   output [15:0]  pfc_pause_time3;        // pause time valude decoded
                                          //(priority 3)
   output [15:0]  pfc_pause_time4;        // pause time valude decoded
                                          //(priority 4)
   output [15:0]  pfc_pause_time5;        // pause time valude decoded
                                          //(priority 5)
   output [15:0]  pfc_pause_time6;        // pause time valude decoded
                                          //(priority 6)
   output [15:0]  pfc_pause_time7;        // pause time valude decoded
                                          //(priority 7)
   output  [7:0]  priority_enable;        // PFC pasue operands to enable
                                          // the corresponding time_vector
                                          // field


// -----------------------------------------------------------------------------
// declare reg's and wire's
// -----------------------------------------------------------------------------

   // State machine signals
   reg     [5:0] rx_dec_state;            // Current decoder state.
   reg     [5:0] rx_dec_state_nxt;        // Next decoder state.

   // Extracted fields for external filter interface
   reg    [47:0] ext_da;                  // Destination address from rx data.
   reg    [47:0] ext_da_nxt;              // Next value of ext_da.
   reg           ext_da_stb;              // Destination address valid strobe.
   reg           ext_da_stb_nxt;          // Next value of ext_da_stb.
   reg    [47:0] ext_sa;                  // Source address from rx data.
   reg    [47:0] ext_sa_nxt;              // Next value of ext_sa.
   reg           ext_sa_stb;              // Source address valid strobe.
   reg           ext_sa_stb_nxt;          // Next value of ext_sa_stb.
   reg    [15:0] ext_type;                // Length/TypeID field from rx frame.
   reg    [15:0] ext_type_nxt;            // Next value of ext_type.
   reg           ext_type_stb;            // Length/TypeID field valid strobe.
   reg           ext_type_stb_nxt;        // Next value of ext_type_stb.
   reg   [127:0] ext_ip_sa;               // IP source address.
   reg   [127:0] ext_ip_sa_nxt;           // Next value of ext_ip_sa.
   reg           ext_ip_sa_stb;           // IP source address valid strobe.
   reg           ext_ip_sa_stb_nxt;       // Next value of ext_ip_sa_stb.
   reg   [127:0] ext_ip_da;               // IP destination address.
   reg   [127:0] ext_ip_da_nxt;           // Next value of ext_ip_da.
   reg           ext_ip_da_stb;           // IP destination address valid strb.
   reg           ext_ip_da_stb_nxt;       // Next value of ext_ip_da_stb.
   reg    [15:0] ext_source_port;         // source port number
   reg    [15:0] ext_source_port_nxt;     // source port number
   reg           ext_sp_stb;              // validates source port number
   reg           ext_sp_stb_nxt;          // validates source port number
   reg    [15:0] ext_dest_port;           // destination port number
   reg    [15:0] ext_dest_port_nxt;       // destination port number
   reg           ext_dp_stb;              // validates destination port number
   reg           ext_dp_stb_nxt;          // validates destination port number
   reg           ext_ipv6;                // high for ipv6
   reg           ext_ipv6_nxt;            // high for ipv6
   reg           drop_pause_frame_nxt;    // Valid on ext_type_stb_nxt
   reg           drop_pause_frame;        // Valid on ext_type_stb

   // Stacked VLAN tag support:
   reg           second_vlan;             // State bit to indicate 2nd vlan tag
   reg           second_vlan_nxt;         // indicates 2nd vlan tag (next)

   reg    [31:0] ext_vlan_tag1;           // VLAN tag 1
   reg    [31:0] ext_vlan_tag1_nxt;       // VLAN tag 1 (next)
   reg           ext_vlan_tag1_stb;       // VLAN tag 1 strobe
   reg           ext_vlan_tag1_stb_nxt;   // VLAN tag 1 strobe (next)

   reg    [31:0] ext_vlan_tag2;           // VLAN tag 2
   reg    [31:0] ext_vlan_tag2_nxt;       // VLAN tag 2 (next)
   reg           ext_vlan_tag2_stb;       // VLAN tag 2 strobe
   reg           ext_vlan_tag2_stb_nxt;   // VLAN tag 2 strobe (next)

//   reg    [15:0] frer_rtag_seqnum;        // Extracted 802.1CB RTag seq number
//   reg           frer_rtag_seqnum_stb;    // Sequence number is valid
//   reg    [15:0] frer_rtag_seqnum_nxt;    // Extracted 802.1CB RTag seq number
//   reg           frer_rtag_seqnum_stb_nxt;// Sequence number is valid

   // Extracted length field for checking if enabled
   reg    [15:0] length_field;            // Length field from rx frame.
   reg    [15:0] length_field_nxt;        // Next value of length_field.

   // Extract VLAN information
   reg           vlan_tagged;             // Used for detecting VLAN tag.
   reg           vlan_tagged_nxt;         // Next value of vlan_tagged.
   reg     [3:0] tci;                     // Used for extacting VLAN priority.
   reg     [3:0] tci_nxt;                 // Next value of tci.
   reg           priority_tagged;         // Used for detecting priority tag.
   reg           priority_tag_nxt;        // Next value of priority_tagged.

   // Extracted pause information
   reg           pause_frame;             // Used for detecting pause frame.
   reg           pause_frame_nxt;         // Next value of pause_frame.
   reg    [15:0] pause_time;              // Pause time value decoded.
   reg    [15:0] pause_time_nxt;          // Next value of pause_time.

   // Extracted IP frame information
   reg           snap_frame;              // Detect SNAP encapsulated frame.
   reg           snap_frame_nxt;          // Next value of snap_frame.
   reg     [7:0] ip_opt_length;           // IP header options length value.
   reg     [7:0] ip_opt_length_nxt;       // Next value of ip_opt_length.
   reg    [15:0] ip_totlength;            // Total length of datagram.
   reg    [15:0] ip_totlength_nxt;        // Next value of ip_totlength.
   reg           ip_v4_frame;             // Used for detecting IP ver 4 frame.
   reg           ip_v4_frame_nxt;         // Next value for ip_v4_frame
   reg           arp_frame;               // Used for detecting ARP frame.
   reg           arp_frame_nxt;           // Next value of arp_frame.
   reg           tcp_frame;               // Used for detecting TCP frame.
   reg           tcp_frame_nxt;           // Next value of tcp_frame.
   reg           udp_frame;               // Used for detecting UDP frame.
   reg           udp_frame_nxt;           // Next value of udp_frame.
   reg           ptp_frame;               // Used for detecting PTP frame.
   reg           ptp_frame_nxt;           // Next value of ptp_frame.
   reg           ip_v6_frame;             // IP Version 6 tagged frame
   reg           ip_v6_frame_nxt;         // Next value of ip_v6_frame
   reg           store_tcp_csum;          // Store current value of TCP checksum
   reg           store_tcp_csum_nxt;      // Next value of TCP checksum
   reg           state_count_inc;         // Increment state counter
   reg           state_count_rst;         // reset state counter
   reg    [7:0]  ip_v4_tos;               // value of ipv4 TOS.
   reg    [7:0]  ip_v4_tos_nxt;           // Next value of ipv4 TOS.
   reg    [7:0]  ip_v6_tc;                // value of ipv6 TC.
   reg    [7:0]  ip_v6_tc_nxt;            // Next value of ipv6 TC.
   reg           last_tcpudp_header;      // Increment state counter
   reg    [3:0]  tcp_offset_nxt;          // Increment state counter
   reg    [3:0]  tcp_offset;              // Increment state counter

   reg           rsc_stop_nxt;            // Set if URG/RST/SYN or FIN bits are set in TCP hdr
   wire          rsc_stop;                // Set if URG/RST/SYN or FIN bits are set in TCP hdr
   reg           rsc_push_nxt;            // Set if PUSH flag are set in TCP hdr
   wire          rsc_push;                // Set if PUSH flag are set in TCP hdr
   reg           tcp_syn_nxt;             // Set if SYN flag is set in TCP hdr
   wire          tcp_syn;                 // Set if SYN flag is set in TCP hdr
   reg    [15:0] tcp_seqnum_low_nxt;      // Extracted low half of seqnum
   reg    [15:0] tcp_seqnum_high_nxt;     // Extracted high half of seqnum
   wire   [31:0] tcp_seqnum ;             // Extracted seqnum


   // Indicate when to add value into checksum calculation
   reg           ip_check;                // IP header checksum to be done.
   reg           ip_check_nxt;            // Next value of ip_check.
   reg           tcp_udp_check;           // UDP/TCP checksum to be done.
   reg           tcp_udp_check_nxt;       // Next value of tcp_udp_check.
   reg           no_tcp_udp_ck;           // Block UDP/TCP checksum calculation.
   reg           no_tcp_udp_ck_nxt;       // Next value of no_tcp_udp_ck.

   // Verify IP header checksum
   reg     [8:0] ip_options_cnt;          // Count correct number of IP options.
   wire    [8:0] ip_options_cnt_nxt;      // Next value of ip_options_cnt.
   wire          last_ip_header;          // Current data is last in IPv4 header
   wire          last_ipv6_header;        // Current data is last in IPv6 header
   reg    [15:0] ip_checksum_val;         // Running IP header checksum value.
   wire   [16:0] ip_checksum_val_nxt;     // Next value of ip_checksum_val.
   reg           ip_checksum_carry;       // Carry of current value plus next.
   wire          ip_checksum_ok;          // IP header checksum verified as OK.
   reg           ip_ck_err_det;           // IP header checksum error detected.
   reg    [16:0] stored_tcp_csum;         // Stored Checksum val (for ipv6 ONLY)

   // Verify TCP/UDP datagram checksum
   reg    [15:0] ip_length_cnt;           // Count correct datagram length.
   wire   [15:0] ip_length_cnt_nxt;       // Next value of ip_length_cnt.
   wire   [15:0] ip_totlength_rounded;    // Length rounded up to 16 bits words.
   wire    [9:0] udp_checksum;            // Identify where UDP chcksum will be.
   wire          udp_checksum_zero;       // UDP checksum value is zero (ipv4 frame).
   wire          udp_checksum_zero_ipv6;  // UDP checksum value is zero.
   reg           zero_udp_csum_ipv6;      // stored value of udp_checksum_zero_ipv6
   wire          end_tcpudp_payload;      // Current data is last TCP data.
   reg    [16:0] tcp_checksum_init;       // Running TCP/UDP checksum value.
   reg    [15:0] tcp_checksum_val;        // Running TCP/UDP checksum value.
   reg    [16:0] tcp_checksum_val_nxt;    // Next value of tcp_checksum_val.
   reg           tcp_checksum_carry;      // Carry of current value plus next.
   wire          tcp_udp_checksum_ok;     // TCP/UDP checksum verified as OK.
   reg           tcp_udp_ck_err_det;      // TCP/UDP checksum error detected.
   reg    [10:0] state_count;             // State Counter
   reg           ipv6_ext_hdr;            // IPv6 Extension header detected
   reg           ipv6_ext_hdr_nxt;        // Next value of IPv6 Extension header
   reg           nxt_hdr_is_frag;         // Nxt Extension Hdr is a FRAG HDR
   reg           nxt_hdr_is_route;        // Nxt Extension Hdr is a ROUTING HDR
   reg           cur_hdr_is_frag;         // Cur Extension Hdr is a FRAG HDR
   reg           segments_left;           // Segments left field in rte ext hdr
   reg           cur_hdr_is_route;        // Cur Extension Hdr is a ROUTING HDR
   reg           nxt_hdr_is_frag_nxt;     // Next Header will be Frag ext HDR
   reg           nxt_hdr_is_route_nxt;    // Next Header will be Route ext HDR

   // 1588 stuff
   reg           sof_rx;                  // asserted on SFD deasserted at EOF
   reg           sof_rx_tog;              // toggled on SOF
   reg           sync_frame_rx;           // asserted for PTP sync frame
   reg           delay_req_rx;            // asserted for PTP delay_req frame
   reg           pdelay_req_rx;           // asserted for PTP pdelay_req frame
   reg           pdelay_resp_rx;          // asserted for PTP pdelay_resp frame
   reg           general_frame_rx;        // asserted for PTP general message frames
   wire          ip_lsb_ptp_dec;          // used in PTP frame detection
   reg           en_ptp_count;            // used to enablse ptp_count
   reg    [4:0]  ptp_count;               // used for counting through PTP frame
   reg           ptp_primary_set;         // used to store the PTP primary event
   reg           ptp_primary_load;        // used to store the PTP primary event
   reg           ptp_primary_nxt;         // next PTP primary event
   reg           ptp_pdelay_set;          // used to store the PTP pdelay event
   reg           ptp_pdelay_load;         // used to store the PTP pdelay event
   reg           ptp_pdelay_nxt;          // next PTP pdelay event
   reg           ptp_v1;                  // PTP version 1 frame
   wire  [31:0]  unicast_address;         // used in PTP frame detection
   reg           udp_event_frame;         // set for udp PTP event frame
   reg           udp_gener_frame;         // set for udp PTP general frame

   // PFC pause frame signals
   reg           pfc_decoded;             // when PFC pause frame opcode decoded
   reg           pfc_decoded_nxt;         // next value of pfc_decoded
   reg    [7:0]  priority_enable;         // PFC pasue operands to enable
                                          // the corresponding time_vector field
   reg    [7:0]  priority_enable_nxt;     // next value of priority_enable
   reg    [3:0]  pause2_cnt;              // counter in RX_DEC_PAUSE2 state to
                                          // indicate PFC pause operand
                                          // reception of priority enable and
                                          // the 8 timer values
   reg    [3:0]  pause2_cnt_nxt;          // next value of pause2_cnt
   reg           pfc_pause_frame;         // Used for detecting PFC pause frame.
   reg           pfc_pause_frame_nxt;     // Next value of PFC pause_frame.
   reg    [15:0] pfc_pause_time0;         // pause time valude decoded
                                          //(priority 0)
   reg    [15:0] pfc_pause_time1;         // pause time valude decoded
                                          //(priority 1)
   reg    [15:0] pfc_pause_time2;         // pause time valude decoded
                                          //(priority 2)
   reg    [15:0] pfc_pause_time3;         // pause time valude decoded
                                          //(priority 3)
   reg    [15:0] pfc_pause_time4;         // pause time valude decoded
                                          //(priority 4)
   reg    [15:0] pfc_pause_time5;         // pause time valude decoded
                                          //(priority 5)
   reg    [15:0] pfc_pause_time6;         // pause time valude decoded
                                          //(priority 6)
   reg    [15:0] pfc_pause_time7;         // pause time valude decoded
                                          //(priority 7)
   reg    [15:0] pfc_pause_time0_nxt;     // next value of pfc_pause_time0
   reg    [15:0] pfc_pause_time1_nxt;     // next value of pfc_pause_time1
   reg    [15:0] pfc_pause_time2_nxt;     // next value of pfc_pause_time2
   reg    [15:0] pfc_pause_time3_nxt;     // next value of pfc_pause_time3
   reg    [15:0] pfc_pause_time4_nxt;     // next value of pfc_pause_time4
   reg    [15:0] pfc_pause_time5_nxt;     // next value of pfc_pause_time5
   reg    [15:0] pfc_pause_time6_nxt;     // next value of pfc_pause_time6
   reg    [15:0] pfc_pause_time7_nxt;     // next value of pfc_pause_time7

   reg     [10:0]  udptcp_offset;         // UDP/TCP offset
   reg     [15:0]  pld_offset;            //PLD offset
   reg             in_payload;            //State machine is currently processing non hdr bytes
   reg             in_payload_nxt;        //State machine is currently processing non hdr bytes
   reg             pld_offset_vld;        //State machine is currently processing non hdr bytes
   // 2-byte Indexes into frame
   wire    [6:0]   index_cnt_sof;         // Index of Frame from SOF
   wire    [6:0]   index_cnt_type;        // Index of Frame from ethertype
   wire    [6:0]   index_cnt_l3;          // Index of Frame from L3 header
   wire    [6:0]   index_cnt_l4;          // Index of Frame from L4 header

   reg             last_vlan_hdr;         // Set in last cycle of a valid VLAN hdr
   reg             last_snap_hdr;         // Set in last cycle of a valid SNAP hdr
   reg             in_other_hdr  ;        // Set in last cycle of a valid other hdr, including IPv4 or IPv6

   // Constants used for frame comparisons
   // (note that byte ordering is sometimes reveresed)
   parameter VLAN_TYPE     = 16'h8100;    // VLAN frame type
   parameter PAUSE_TYPE    = 16'h8808;    // PAUSE frame type
   parameter PAUSE_OPCODE  = 16'h0001;    // Valid PAUSE opcode
   parameter PFC_PAUSE_OPCODE = 16'h0101; // Valid PFC PAUSE opcode
   parameter SNAP_TYPE     = 16'h05dc;    // SNAP encapsulation type
   parameter SNAP_DSAP     = 8'haa;       // SNAP encapsulation valid DSAP
   parameter SNAP_SSAP     = 8'haa;       // SNAP encapsulation valid SSAP
   parameter SNAP_CONT     = 8'h03;       // SNAP encapsulation valid control
   parameter SNAP_ID_7_0   = 8'h00;       // SNAP encapsulation valid ID [7:0]
   parameter SNAP_ID_15_8  = 8'h00;       // SNAP encapsulation valid ID [15:8]
   parameter SNAP_ID_23_16 = 8'h00;       // SNAP encapsulation valid ID [23:16]
   parameter ARP_TYPE      = 16'h0806;    // ARP encapsulation type
   parameter PTP_TYPE      = 16'h88f7;    // non encapsulated PTP type
   parameter IP_TYPEv4     = 16'h0800;    // IP encapsulation type (v4)
   parameter IP_TYPEv6     = 16'h86dd;    // IP encapsulation type (v6)
   parameter IP_VERSION4   = 4'h4;        // IP valid version
   parameter IP_VERSION6   = 4'h6;        // IP valid version
   parameter IP_IHL_MIN    = 4'h5;        // IP minimum IHL
   parameter IP_NFRAG_VAL1 = 16'h0000;    // IP no fragmentation - value 1
   parameter IP_NFRAG_VAL2 = 16'h4000;    // IP no fragmentation - value 2
   parameter IP_TCP        = 8'h06;       // IP TCP protocol
   parameter IP_UDP        = 8'h11;       // IP UDP protocol
   parameter IPV6_HOP      = 8'h00;       // HOP EXTENSION HDR FOR IPv6
   parameter IPV6_ROUTE    = 8'd43;       // ROUTE EXTENSION HDR FOR IPv6
   parameter IPV6_FRAG     = 8'd44;       // FRAG EXTENSION HDR FOR IPv6
   parameter IPV6_DEST     = 8'd60;       // DEST EXTENSION HDR FOR IPv6

   // TCP Offload Engine state machine labels
   parameter RX_DEC_IDLE   = 6'h00;    // RX DEC IDLE state
   parameter RX_DEC_DA1    = 6'h01;    // RX DEC DA1 state
   parameter RX_DEC_DA2    = 6'h02;    // RX DEC DA2 state
   parameter RX_DEC_DA3    = 6'h03;    // RX DEC DA3 state
   parameter RX_DEC_SA1    = 6'h04;    // RX DEC SA1 state
   parameter RX_DEC_SA2    = 6'h05;    // RX DEC SA2 state
   parameter RX_DEC_SA3    = 6'h06;    // RX DEC SA3 state
   parameter RX_DEC_TYPE   = 6'h07;    // RX DEC TYPE state
   parameter RX_DEC_VLAN1  = 6'h08;    // RX DEC VLAN1 state
   parameter RX_DEC_VLAN2  = 6'h09;    // RX DEC VLAN2 state
   parameter RX_DEC_PAUSE1 = 6'h0a;    // RX DEC PAUSE1 state
   parameter RX_DEC_PAUSE2 = 6'h0b;    // RX DEC PAUSE2 state
   parameter RX_DEC_SNAP1  = 6'h0c;    // RX DEC SNAP1 state
   parameter RX_DEC_SNAP2  = 6'h0d;    // RX DEC SNAP2 state
   parameter RX_DEC_SNAP3  = 6'h0e;    // RX DEC SNAP3 state
   parameter RX_DEC_SNAP4  = 6'h0f;    // RX DEC SNAP4 state
   parameter RX_DEC_IP1    = 6'h10;    // RX DEC IP1 state
   parameter RX_DEC_IP2    = 6'h11;    // RX DEC IP2 state
   parameter RX_DEC_IP3    = 6'h12;    // RX DEC IP3 state
   parameter RX_DEC_IP4    = 6'h13;    // RX DEC IP4 state
   parameter RX_DEC_IP5    = 6'h14;    // RX DEC IP5 state
   parameter RX_DEC_IP6    = 6'h15;    // RX DEC IP6 state
   parameter RX_DEC_IP7    = 6'h16;    // RX DEC IP7 state
   parameter RX_DEC_IP8    = 6'h17;    // RX DEC IP8 state
   parameter RX_DEC_IP9    = 6'h18;    // RX DEC IP9 state
   parameter RX_DEC_IP10   = 6'h19;    // RX DEC IP10 state
   parameter RX_DEC_IP11   = 6'h1a;    // RX DEC IP11 state
   parameter RX_DEC_PTP1   = 6'h1b;    // RX DEC PTP1 state
   parameter RX_DEC_IPv6_1 = 6'h1c;    // RX DEC IPv6_1 state
   parameter RX_DEC_IPv6_2 = 6'h1d;    // RX DEC IPv6_2 state
   parameter RX_DEC_CKSUM  = 6'h1f;    // RX DEC CKSUM state
   parameter PPPoE1        = 6'h20;    // PPPoE state 1
   parameter PPPoE2        = 6'h21;    // PPPoE state 2
   parameter PPPoE3        = 6'h22;    // PPPoE state 3
   parameter PPPoE4        = 6'h23;    // PPPoE state 4
   parameter CB_RTAG       = 6'h30;    // Detected 802.1CB RTag
   parameter CB_TAG_RSVD   = 6'h31;    // Reserved fields


// -----------------------------------------------------------------------------
// Beginning of code
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// Receive Decode State Machine
// -----------------------------------------------------------------------------

   // Receive Decode State Machine (synchronous part)

  wire [16:0]   pld_offset_p2;
  wire [16:0]   pld_offset_p4;
  wire [16:0]   pld_offset_p8;
  assign pld_offset_p2 = pld_offset + 16'd2;
  assign pld_offset_p4 = pld_offset + 16'd4;
  assign pld_offset_p8 = pld_offset + 16'd8;
   always@(posedge rx_clk or negedge n_rxreset)
     begin
      if (~n_rxreset)
         begin
            rx_dec_state    <= RX_DEC_IDLE;
            ext_da          <= 48'd0;
            ext_da_stb      <= 1'b0;
            ext_sa          <= 48'd0;
            ext_sa_stb      <= 1'b0;
            ext_type        <= 16'h0000;
            ext_type_stb    <= 1'b0;
            ext_ip_sa       <= 128'h00000000000000000000000000000000;
            ext_ip_sa_stb   <= 1'b0;
            ext_ip_da       <= 128'h00000000000000000000000000000000;
            ext_ip_da_stb   <= 1'b0;
            ext_source_port <= 16'h0000;
            ext_sp_stb      <= 1'b0;
            ext_dest_port   <= 16'h0000;
            ext_dp_stb      <= 1'b0;
            ext_ipv6        <= 1'b0;
            drop_pause_frame<= 1'b0;
            length_field    <= 16'hffff;
            vlan_tagged     <= 1'b0;
            tci             <= 4'h0;
            priority_tagged <= 1'b0;
            pause_frame     <= 1'b0;
            pause_time      <= 16'h0000;
            pfc_pause_time0 <= 16'h0000;
            pfc_pause_time1 <= 16'h0000;
            pfc_pause_time2 <= 16'h0000;
            pfc_pause_time3 <= 16'h0000;
            pfc_pause_time4 <= 16'h0000;
            pfc_pause_time5 <= 16'h0000;
            pfc_pause_time6 <= 16'h0000;
            pfc_pause_time7 <= 16'h0000;
            pfc_pause_frame <= 1'b0;
            pfc_decoded     <= 1'b0;
            pause2_cnt      <= 4'h0;
            priority_enable <= 8'h00;
            snap_frame      <= 1'b0;
            ip_opt_length   <= 8'h00;
            ip_totlength    <= 16'h0000;
            ip_v4_frame     <= 1'b0;
            arp_frame       <= 1'b0;
            tcp_frame       <= 1'b0;
            udp_frame       <= 1'b0;
            ptp_frame       <= 1'b0;
            ip_check        <= 1'b0;
            tcp_udp_check   <= 1'b0;
            no_tcp_udp_ck   <= 1'b0;
            ip_v4_tos       <= 8'h00;
            ip_v6_tc        <= 8'h00;
            // Stacked VLAN tag support
            second_vlan       <= 1'b0;
            ext_vlan_tag1     <= 32'h0000_0000;
            ext_vlan_tag2     <= 32'h0000_0000;
            ext_vlan_tag1_stb <= 1'b0;
            ext_vlan_tag2_stb <= 1'b0;
            ip_v6_frame     <= 1'b0;
            store_tcp_csum  <= 1'b0;
            ipv6_ext_hdr    <= 1'b0;
            cur_hdr_is_frag <= 1'b0;
            nxt_hdr_is_frag <= 1'b0;
            cur_hdr_is_route<= 1'b0;
            nxt_hdr_is_route<= 1'b0;
            ptp_primary_load<= 1'b0;
            ptp_pdelay_load <= 1'b0;
            udptcp_offset   <= 11'h000;
            pld_offset      <= 16'd0;
            in_payload      <= 1'b0;
            pld_offset_vld  <= 1'b0;
            tcp_offset      <= 4'h0;
//            frer_rtag_seqnum<= 16'h0000;
//            frer_rtag_seqnum_stb  <= 1'b0;
         end
      else if (~enable_receive_rck | ~frame_being_decoded)
         begin
            rx_dec_state    <= RX_DEC_IDLE;
            ext_da          <= 48'd0;
            ext_da_stb      <= 1'b0;
            ext_sa          <= 48'd0;
            ext_sa_stb      <= 1'b0;
            ext_type        <= 16'h0000;
            ext_type_stb    <= 1'b0;
            ext_ip_sa       <= 128'h00000000000000000000000000000000;
            ext_ip_sa_stb   <= 1'b0;
            ext_ip_da       <= 128'h00000000000000000000000000000000;
            ext_ip_da_stb   <= 1'b0;
            ext_sp_stb      <= 1'b0;
            ext_source_port <= 16'h0000;
            ext_dest_port   <= 16'h0000;
            ext_dp_stb      <= 1'b0;
            ext_ipv6        <= 1'b0;
            drop_pause_frame<= 1'b0;
            length_field    <= 16'hffff;
            vlan_tagged     <= 1'b0;
            tci             <= 4'h0;
            priority_tagged <= 1'b0;
            pause_frame     <= 1'b0;
            pause_time      <= 16'h0000;
            pfc_pause_frame <= 1'b0;
            pfc_decoded     <= 1'b0;
            pause2_cnt      <= 4'h0;
            snap_frame      <= 1'b0;
            ip_v4_frame     <= 1'b0;
            arp_frame       <= 1'b0;
            tcp_frame       <= 1'b0;
            udp_frame       <= 1'b0;
            ptp_frame       <= 1'b0;
            ip_check        <= 1'b0;
            tcp_udp_check   <= 1'b0;
            no_tcp_udp_ck   <= 1'b0;
            ip_v4_tos       <= 8'h00;
            ip_v6_tc        <= 8'h00;
            in_payload      <= 1'b0;
            // Stacked VLAN tag support
            second_vlan       <= 1'b0;
            ext_vlan_tag1     <= 32'h0000_0000;
            ext_vlan_tag2     <= 32'h0000_0000;
            ext_vlan_tag1_stb <= 1'b0;
            ext_vlan_tag2_stb <= 1'b0;
            ip_v6_frame     <= 1'b0;
            store_tcp_csum  <= 1'b0;
            ipv6_ext_hdr    <= 1'b0;
            nxt_hdr_is_frag <= 1'b0;
            cur_hdr_is_frag <= 1'b0;
            cur_hdr_is_route<= 1'b0;
            nxt_hdr_is_route<= 1'b0;
            ptp_primary_load<= 1'b0;
            ptp_pdelay_load <= 1'b0;
            pld_offset_vld  <= 1'b0;
//            frer_rtag_seqnum_stb  <= 1'b0;
            if (~enable_receive_rck)
            begin
              pfc_pause_time0 <= 16'h0000;
              pfc_pause_time1 <= 16'h0000;
              pfc_pause_time2 <= 16'h0000;
              pfc_pause_time3 <= 16'h0000;
              pfc_pause_time4 <= 16'h0000;
              pfc_pause_time5 <= 16'h0000;
              pfc_pause_time6 <= 16'h0000;
              pfc_pause_time7 <= 16'h0000;
              priority_enable <= 8'h00;
              ip_opt_length   <= 8'h00;
              ip_totlength    <= 16'h0000;
              udptcp_offset   <= 11'h000;
              pld_offset      <= 16'h0000;
              tcp_offset      <= 4'h0;
//              frer_rtag_seqnum<= 16'h0000;
            end
         end
      else
         begin
            rx_dec_state    <= rx_dec_state_nxt;
            ext_da          <= ext_da_nxt;
            ext_da_stb      <= ext_da_stb_nxt;
            ext_sa          <= ext_sa_nxt;
            ext_sa_stb      <= ext_sa_stb_nxt;
            ext_type        <= ext_type_nxt;
            ext_type_stb    <= ext_type_stb_nxt;
            ext_ip_sa       <= ext_ip_sa_nxt;
            ext_ip_sa_stb   <= ext_ip_sa_stb_nxt;
            ext_ip_da       <= ext_ip_da_nxt;
            ext_ip_da_stb   <= ext_ip_da_stb_nxt;
            ext_sp_stb      <= ext_sp_stb_nxt;
            ext_dp_stb      <= ext_dp_stb_nxt;
            ext_source_port <= ext_source_port_nxt;
            ext_dest_port   <= ext_dest_port_nxt;
            ext_ipv6        <= ext_ipv6_nxt;
            drop_pause_frame<= drop_pause_frame_nxt;
            length_field    <= length_field_nxt;
            vlan_tagged     <= vlan_tagged_nxt;
            tci             <= tci_nxt;
            priority_tagged <= priority_tag_nxt;
            pause_frame     <= pause_frame_nxt;
            pause_time      <= pause_time_nxt;
            pfc_pause_time0 <= pfc_pause_time0_nxt;
            pfc_pause_time1 <= pfc_pause_time1_nxt;
            pfc_pause_time2 <= pfc_pause_time2_nxt;
            pfc_pause_time3 <= pfc_pause_time3_nxt;
            pfc_pause_time4 <= pfc_pause_time4_nxt;
            pfc_pause_time5 <= pfc_pause_time5_nxt;
            pfc_pause_time6 <= pfc_pause_time6_nxt;
            pfc_pause_time7 <= pfc_pause_time7_nxt;
            pfc_pause_frame <= pfc_pause_frame_nxt;
            pfc_decoded     <= pfc_decoded_nxt;
            pause2_cnt      <= pause2_cnt_nxt;
            priority_enable <= priority_enable_nxt;
            snap_frame      <= snap_frame_nxt;
            ip_opt_length   <= ip_opt_length_nxt;
            ip_totlength    <= ip_totlength_nxt;
            ip_v4_frame     <= ip_v4_frame_nxt;
            arp_frame       <= arp_frame_nxt;
            tcp_frame       <= tcp_frame_nxt;
            udp_frame       <= udp_frame_nxt;
            ptp_frame       <= ptp_frame_nxt;
            ip_check        <= ip_check_nxt;
            tcp_udp_check   <= tcp_udp_check_nxt;
            in_payload      <= in_payload_nxt;
            no_tcp_udp_ck   <= no_tcp_udp_ck_nxt;
            // Stacked VLAN tag support
            second_vlan     <= second_vlan_nxt;
            ext_vlan_tag1   <= ext_vlan_tag1_nxt;
            ext_vlan_tag2   <= ext_vlan_tag2_nxt;
            ext_vlan_tag1_stb <= ext_vlan_tag1_stb_nxt;
            ext_vlan_tag2_stb <= ext_vlan_tag2_stb_nxt;
            ip_v6_frame     <= ip_v6_frame_nxt;
            store_tcp_csum  <= store_tcp_csum_nxt;
            ipv6_ext_hdr    <= ipv6_ext_hdr_nxt;
            nxt_hdr_is_frag <= nxt_hdr_is_frag_nxt;
            nxt_hdr_is_route<= nxt_hdr_is_route_nxt;
            ip_v4_tos       <= ip_v4_tos_nxt;
            ip_v6_tc        <= ip_v6_tc_nxt;
            tcp_offset      <= tcp_offset_nxt;
//            frer_rtag_seqnum<= frer_rtag_seqnum_nxt;
//            frer_rtag_seqnum_stb  <= frer_rtag_seqnum_stb_nxt;
            if ((((rx_dec_state == RX_DEC_IPv6_1) & state_count == 11'h013)
                |
                  ((rx_dec_state == RX_DEC_IPv6_2) &
                    (state_count == ({1'b0,ip_opt_length,2'b00} + 11'd3))))
                & new_aligned_data)
               begin
                  cur_hdr_is_frag  <= nxt_hdr_is_frag;
                  cur_hdr_is_route <= nxt_hdr_is_route;
               end
            ptp_primary_load<= ptp_primary_nxt;
            ptp_pdelay_load <= ptp_pdelay_nxt;

            if (start_of_data)
            begin
              pld_offset    <= 16'd14;
              udptcp_offset <= 11'h000;
            end
            else if (~in_payload & new_aligned_data)
            begin
              if (last_vlan_hdr)
                pld_offset    <= pld_offset_p4[15:0];
              else if (last_snap_hdr)
                pld_offset    <= pld_offset_p8[15:0];
              else if (in_other_hdr | rx_dec_state == RX_DEC_CKSUM)
                pld_offset    <= pld_offset_p2[15:0];

              if ((rx_dec_state != RX_DEC_CKSUM) & (rx_dec_state != RX_DEC_IDLE))
                udptcp_offset <= udptcp_offset + 11'h001;
            end

            if (new_aligned_data)
            begin
              pld_offset_vld  <= in_payload_nxt & ~in_payload;
            end

         end
     end
   assign ext_has_2vlans = second_vlan;

generate if (p_edma_rsc == 1) begin : gen_rsc_extractions
   reg          rsc_stop_r;
   reg          rsc_push_r;
   reg          tcp_syn_r;
   reg  [31:0]  tcp_seqnum_r;
   
   always@(posedge rx_clk or negedge n_rxreset)
     begin
      if (~n_rxreset)
         begin
            rsc_stop_r        <= 1'b0;
            rsc_push_r        <= 1'b0;
            tcp_syn_r         <= 1'b0;
            tcp_seqnum_r      <= 32'h00000000;
         end
      else if (~enable_receive_rck | ~frame_being_decoded)
         begin
            rsc_stop_r        <= (~enable_receive_rck)? 1'b0 : rsc_stop;
            rsc_push_r        <= (~enable_receive_rck)? 1'b0 : rsc_push;
            tcp_syn_r         <= (~enable_receive_rck)? 1'b0 : tcp_syn;
            tcp_seqnum_r      <= (~enable_receive_rck)? 32'h00000000 : tcp_seqnum;
         end
      else
         begin
            rsc_stop_r        <= rsc_stop_nxt;
            rsc_push_r        <= rsc_push_nxt;
            tcp_syn_r         <= tcp_syn_nxt;
            tcp_seqnum_r      <= {tcp_seqnum_high_nxt,tcp_seqnum_low_nxt};
         end
     end
     assign rsc_stop         = rsc_stop_r;
     assign rsc_push         = rsc_push_r;
     assign tcp_syn          = tcp_syn_r;
     assign tcp_seqnum       = tcp_seqnum_r;
end else begin : gen_no_edma_rsc
     assign rsc_stop         = 1'b0;
     assign rsc_push         = 1'b0;
     assign tcp_syn          = 1'b0;
     assign tcp_seqnum       = 32'h00000000;
end
endgenerate



generate if (p_num_type2_screeners > 8'd0 && p_num_scr2_compare_regs > 8'd0) begin : gen_screener_extractions
   reg    [6:0]   index_cnt_sof_r;           // Index of Frame from SOF
   reg    [6:0]   index_cnt_type_r;          // Index of Frame from ethertype
   reg            index_cnt_l3_en_r;         // Enables the L3 index counter
   reg            index_cnt_l4_en_r;         // Enables the L4 index counter
   reg    [6:0]   index_cnt_l3_r;            // Index of Frame from L3 header
   reg    [6:0]   index_cnt_l4_r;            // Index of Frame from L4 header
   always@(posedge rx_clk or negedge n_rxreset)
     begin
      if (~n_rxreset)
         begin
            index_cnt_sof_r   <= 7'd0;
            index_cnt_type_r  <= 7'd0;
            index_cnt_l3_en_r <= 1'b0;
            index_cnt_l4_en_r <= 1'b0;
            index_cnt_l3_r    <= 7'd0;
            index_cnt_l4_r    <= 7'd0;
         end
      else if (~enable_receive_rck | ~frame_being_decoded)
         begin
            index_cnt_sof_r   <= 7'd0;
            index_cnt_type_r  <= 7'd0;
            index_cnt_l3_en_r <= 1'b0;
            index_cnt_l4_en_r <= 1'b0;
            index_cnt_l3_r    <= 7'd0;
            index_cnt_l4_r    <= 7'd0;
         end
      else
         begin
            // Create Index counters into frame. Note we need 2
            // seperate indexes here as the compare registers in
            // the type2 extended screeners can independantly use either
            if (new_aligned_data & (index_cnt_sof != 7'b1111111))
              index_cnt_sof_r   <= index_cnt_sof + 7'b0000001;

            if (rx_dec_state != RX_DEC_DA1  &
                rx_dec_state != RX_DEC_DA2  &
                rx_dec_state != RX_DEC_DA3  &
                rx_dec_state != RX_DEC_SA1  &
                rx_dec_state != RX_DEC_SA2  &
                rx_dec_state != RX_DEC_SA3  &
                rx_dec_state != RX_DEC_TYPE &
                rx_dec_state != CB_RTAG &
                rx_dec_state != CB_TAG_RSVD &
                rx_dec_state != RX_DEC_VLAN1 &
                rx_dec_state != RX_DEC_VLAN2 &
                ~(rx_dec_state == RX_DEC_SNAP1 & rx_dec_state_nxt == RX_DEC_SNAP2) &
                rx_dec_state != RX_DEC_SNAP2 &
                rx_dec_state != RX_DEC_SNAP3 &
                rx_dec_state != RX_DEC_SNAP4 &
                (index_cnt_type != 7'b1111111) & new_aligned_data)
              index_cnt_type_r  <= index_cnt_type + 7'b0000001;

            if (last_ip_header | last_ipv6_header)
              index_cnt_l3_en_r    <= 1'b1;

            if (index_cnt_l3_en_r & new_aligned_data & (index_cnt_l3 != 7'b1111111))
              index_cnt_l3_r    <= index_cnt_l3 + 7'b0000001;

            if (last_tcpudp_header)
              index_cnt_l4_en_r    <= 1'b1;

            if (index_cnt_l4_en_r & new_aligned_data & (index_cnt_l4 != 7'b1111111))
              index_cnt_l4_r    <= index_cnt_l4 + 7'b0000001;
         end
     end

     assign  index_cnt_sof   = index_cnt_sof_r;
     assign  index_cnt_type  = index_cnt_type_r;
     assign  index_cnt_l3    = index_cnt_l3_r;
     assign  index_cnt_l4    = index_cnt_l4_r;
 end else begin : gen_no_screener_extract
     assign  index_cnt_sof   = 7'h00;
     assign  index_cnt_type  = 7'h00;
     assign  index_cnt_l3    = 7'h00;
     assign  index_cnt_l4    = 7'h00;
 end
 endgenerate




   // TCP Receive checksum offload state machine (asynchronous part)
   always@(*)
   begin
      // defaults for next value is current value
      ext_da_nxt        = ext_da;
      ext_sa_nxt        = ext_sa;
      ext_type_nxt      = ext_type;
      ext_ip_sa_nxt     = ext_ip_sa;
      ext_ip_da_nxt     = ext_ip_da;
      ext_source_port_nxt = ext_source_port;
      ext_dest_port_nxt = ext_dest_port;
      ext_ipv6_nxt      = ext_ipv6;
      length_field_nxt  = length_field;
      vlan_tagged_nxt   = vlan_tagged;
      tci_nxt           = tci;
      priority_tag_nxt  = priority_tagged;
      pause_frame_nxt   = pause_frame;
      pause_time_nxt    = pause_time;
      pfc_pause_time0_nxt = pfc_pause_time0;
      pfc_pause_time1_nxt = pfc_pause_time1;
      pfc_pause_time2_nxt = pfc_pause_time2;
      pfc_pause_time3_nxt = pfc_pause_time3;
      pfc_pause_time4_nxt = pfc_pause_time4;
      pfc_pause_time5_nxt = pfc_pause_time5;
      pfc_pause_time6_nxt = pfc_pause_time6;
      pfc_pause_time7_nxt = pfc_pause_time7;
      pfc_pause_frame_nxt = pfc_pause_frame;
      pfc_decoded_nxt     = pfc_decoded;
      pause2_cnt_nxt      = pause2_cnt;
      priority_enable_nxt = priority_enable;
      snap_frame_nxt    = snap_frame;
      ip_opt_length_nxt = ip_opt_length;
      ip_totlength_nxt  = ip_totlength;
      ip_v4_tos_nxt     = ip_v4_tos;
      ip_v6_tc_nxt      = ip_v6_tc;
      ip_v4_frame_nxt   = ip_v4_frame;
      arp_frame_nxt     = arp_frame;
      tcp_frame_nxt     = tcp_frame;
      udp_frame_nxt     = udp_frame;
      ptp_frame_nxt     = ptp_frame;
      ip_check_nxt      = ip_check;
      tcp_udp_check_nxt = tcp_udp_check;
      no_tcp_udp_ck_nxt = no_tcp_udp_ck;
      // Stacked VLAN tag support
      second_vlan_nxt   = second_vlan;
      ext_vlan_tag1_nxt = ext_vlan_tag1;
      ext_vlan_tag2_nxt = ext_vlan_tag2;
      ip_v6_frame_nxt   = ip_v6_frame;
      ipv6_ext_hdr_nxt  = ipv6_ext_hdr;
      nxt_hdr_is_frag_nxt = nxt_hdr_is_frag;
      nxt_hdr_is_route_nxt = nxt_hdr_is_route;
      ptp_primary_nxt   = ptp_primary_load;
      ptp_pdelay_nxt    = ptp_pdelay_load;
      drop_pause_frame_nxt = drop_pause_frame;
      in_payload_nxt    = in_payload;
      rsc_stop_nxt      = rsc_stop && p_edma_rsc == 1;
      rsc_push_nxt      = rsc_push && p_edma_rsc == 1;
      tcp_syn_nxt       = tcp_syn && p_edma_rsc == 1;
      tcp_seqnum_high_nxt = tcp_seqnum[31:16] & {16{p_edma_rsc}};
      tcp_seqnum_low_nxt = tcp_seqnum[15:0] & {16{p_edma_rsc}};
      tcp_offset_nxt    = tcp_offset;
//      frer_rtag_seqnum_nxt  = frer_rtag_seqnum;
      // Default strobe values to zero to ensure they are only one clock wide.
      ext_da_stb_nxt    = 1'b0;
      ext_sa_stb_nxt    = 1'b0;
      ext_type_stb_nxt  = 1'b0;
      ext_ip_sa_stb_nxt = 1'b0;
      ext_ip_da_stb_nxt = 1'b0;
      ext_sp_stb_nxt    = 1'b0;
      ext_dp_stb_nxt    = 1'b0;
      store_tcp_csum_nxt= 1'b0;
      state_count_inc   = 1'b0;
      state_count_rst   = 1'b0;
      ext_vlan_tag1_stb_nxt = 1'b0;
      ext_vlan_tag2_stb_nxt = 1'b0;
      last_tcpudp_header= 1'b0;

      last_vlan_hdr     = 1'b0;
      in_other_hdr      = 1'b0;
      last_snap_hdr     = 1'b0;
//      frer_rtag_seqnum_stb_nxt  = 1'b0;

      // default vaule for PFC pause frame signals

      // decode current state
      case (rx_dec_state)


         RX_DEC_DA1 : // decode DA from bytes 1-6 (first two)
            begin
               if (new_aligned_data)
                  begin
                     // Clear all signals at beginning of frame.
                     drop_pause_frame_nxt = 1'b0;
                     ext_da_nxt[15:0]  = new_data_align[15:0];
                     ext_da_nxt[47:16] = 32'h00000000;
                     ext_da_stb_nxt    = 1'b0;
                     ext_sa_nxt        = 48'd0;
                     ext_sa_stb_nxt    = 1'b0;
                     ext_type_nxt      = 16'h0000;
                     ext_type_stb_nxt  = 1'b0;
                     ext_ip_sa_nxt     = 128'h00000000000000000000000000000000;
                     ext_ip_sa_stb_nxt = 1'b0;
                     ext_ip_da_nxt     = 128'h00000000000000000000000000000000;
                     ext_ip_da_stb_nxt = 1'b0;
                     ext_dest_port_nxt = 16'h0000;
                     ext_source_port_nxt = 16'h0000;
                     ext_ipv6_nxt      = 1'b0;
                     length_field_nxt  = 16'hffff;
                     vlan_tagged_nxt   = 1'b0;
                     tci_nxt           = 4'h0;
                     priority_tag_nxt  = 1'b0;
                     pause_frame_nxt   = 1'b0;
                     pause_time_nxt    = 16'h0000;
                     pfc_pause_frame_nxt = 1'b0;
                     pfc_decoded_nxt     = 1'b0;
                     pause2_cnt_nxt      = 4'h0;
                     snap_frame_nxt    = 1'b0;
                     ip_v4_frame_nxt   = 1'b0;
                     arp_frame_nxt     = 1'b0;
                     tcp_frame_nxt     = 1'b0;
                     udp_frame_nxt     = 1'b0;
                     ptp_frame_nxt     = 1'b0;
                     ip_check_nxt      = 1'b0;
                     tcp_udp_check_nxt = 1'b0;
                     no_tcp_udp_ck_nxt = 1'b0;
                     // Stacked VLAN tag support
                     second_vlan_nxt       = 1'b0;
                     ext_vlan_tag1_nxt     = 32'h0000_0000;
                     ext_vlan_tag2_nxt     = 32'h0000_0000;
                     ext_vlan_tag1_stb_nxt = 1'b0;
                     ext_vlan_tag2_stb_nxt = 1'b0;
                     ip_v4_tos_nxt         = 8'h00;
                     ip_v6_tc_nxt          = 8'h00;
                     rx_dec_state_nxt  = RX_DEC_DA2;
                     in_payload_nxt    = 1'b0;
                  end
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_DA1;
                  end
            end


         RX_DEC_DA2 : // decode DA from bytes 1-6 (middle two)
            begin
               if (new_aligned_data)
                  begin
                     ext_da_nxt[31:16] = new_data_align[15:0];
                     rx_dec_state_nxt  = RX_DEC_DA3;
                  end
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_DA2;
                  end
            end


         RX_DEC_DA3 : // decode DA from bytes 1-6 (last two)
            begin
               if (new_aligned_data)
                  begin
                     ext_da_nxt[47:32] = new_data_align[15:0];
                     ext_da_stb_nxt    = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_SA1;
                  end
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_DA3;
                  end
            end


         RX_DEC_SA1 : // decode SA from bytes 7-12 (first two)
            begin
               if (new_aligned_data)
                  begin
                     ext_sa_nxt[15:0]  = new_data_align[15:0];
                     rx_dec_state_nxt  = RX_DEC_SA2;
                  end
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_SA1;
                  end
            end


         RX_DEC_SA2 : // decode SA from bytes 7-12 (middle two)
            begin
               if (new_aligned_data)
                  begin
                     ext_sa_nxt[31:16] = new_data_align[15:0];
                     rx_dec_state_nxt  = RX_DEC_SA3;
                  end
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_SA2;
                  end
            end


         RX_DEC_SA3 : // decode SA from bytes 7-12 (last two)
            begin
               if (new_aligned_data)
                  begin
                     ext_sa_nxt[47:32] = new_data_align[15:0];
                     ext_sa_stb_nxt    = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_TYPE;
                  end
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_SA3;
                  end
            end


         RX_DEC_TYPE : // extract type id from bytes 13&14
            begin
                // reset tcp flags as late as we can to compensate for delay in MAC to DMA.
               rsc_stop_nxt       = 1'b0;
               rsc_push_nxt       = 1'b0;
               tcp_syn_nxt        = 1'b0;
               tcp_seqnum_high_nxt = 16'h0000;
               tcp_seqnum_low_nxt = 16'h0000;
               ip_opt_length_nxt  = 8'h00;
               ip_totlength_nxt   = 16'h0000;
               tcp_offset_nxt     = 4'h0;

               // Save external type & length field
               ext_type_nxt[15:0]= {new_data_align[7:0], new_data_align[15:8]};
               length_field_nxt[15:0]= {new_data_align[7:0],
                                        new_data_align[15:8]};


               // VLAN tagged frame
               // Stacked VLAN tag support
               if (new_aligned_data & (
                     ({new_data_align[7:0],
                       new_data_align[15:8]} == VLAN_TYPE)
                   | ({1'b1, new_data_align[7:0],
                             new_data_align[15:8]} == stacked_vlantype) ) )

                  begin
                     ext_vlan_tag1_nxt[31:16] =
                                   {new_data_align[7:0], new_data_align[15:8]};
                     vlan_tagged_nxt   = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_VLAN1;
                  end
               // PAUSE frame
               else if (new_aligned_data &
                        ({new_data_align[7:0],
                          new_data_align[15:8]} == PAUSE_TYPE))
                  begin
                     ext_type_stb_nxt  = 1'b1;
                     in_payload_nxt       = 1'b1;
                     drop_pause_frame_nxt  = rx_no_pause_frames;
                     if (pause_add_match)
                     begin
                       pause_frame_nxt   = 1'b1;
                       pfc_pause_frame_nxt = 1'b1;
                       rx_dec_state_nxt  = RX_DEC_PAUSE1;
                     end
                     else
                       rx_dec_state_nxt  = RX_DEC_IDLE;
                  end

               // ARP encapsulated frame
               else if (new_aligned_data & ({new_data_align[7:0],
                                             new_data_align[15:8]} == ARP_TYPE))
                  begin
                     ext_type_stb_nxt  = 1'b1;
                     arp_frame_nxt     = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_IDLE;
                     in_payload_nxt       = 1'b1;
                  end

               // IPv4 encapsulated frame
               else if (new_aligned_data &
                        ({new_data_align[7:0],
                          new_data_align[15:8]} == IP_TYPEv4))
                  begin
                     ext_type_stb_nxt  = 1'b1;
                     ip_check_nxt      = rx_toe_enable;
                     rx_dec_state_nxt  = RX_DEC_IP1;
                  end

               // IPv6 encapsulated frame
               else if (new_aligned_data &
                        ({new_data_align[7:0],
                          new_data_align[15:8]} == IP_TYPEv6))
                  begin
                     ext_type_stb_nxt  = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_IPv6_1;
                  end

               // SNAP encapsulated frame
               else if (new_aligned_data &
                          ({new_data_align[7:0],
                            new_data_align[15:8]} <= SNAP_TYPE))
                  begin
                     rx_dec_state_nxt  = RX_DEC_SNAP1;
                  end

               // non encapsulated PTP frame
               else if (new_aligned_data &
                          ({new_data_align[7:0],
                            new_data_align[15:8]} == PTP_TYPE))
                  begin
                     rx_dec_state_nxt  = RX_DEC_PTP1;
                     ext_type_stb_nxt  = 1'b1;
                     ptp_frame_nxt     = 1'b1;
                     if (ext_da[47:0] == 48'h000000191b01)
                        begin
                           ptp_primary_nxt = 1'b1;
                        end
                     if (ext_da[47:0] == 48'h0e0000c28001)
                        begin
                           ptp_pdelay_nxt  = 1'b1;
                        end
                  end

               // PPPoE encapsulated frame
               else if (new_aligned_data &
                          ({new_data_align[7:0],
                            new_data_align[15:8]} == 16'h8864))
                  begin
                     ext_type_stb_nxt  = 1'b1;
                     rx_dec_state_nxt  = PPPoE1;
                  end

               // 802.1CB Redundancy Tag
               else if (new_aligned_data &
                        ({new_data_align[7:0],
                          new_data_align[15:8]} == frer_rtag_ethertype))
                  begin
                     if (~frer_6b_tag)
                       rx_dec_state_nxt = CB_RTAG;
                     else
                       rx_dec_state_nxt = CB_TAG_RSVD;
                  end

               // Other type - just present to external filter interface
               else if (new_aligned_data)
                  begin
                     ext_type_stb_nxt  = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_IDLE;
                     in_payload_nxt    = 1'b1;
                  end

               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_TYPE;
                  end
            end

         CB_TAG_RSVD : // Ignore the 2 bytes following the type and before the sequence number
            begin
               if (new_aligned_data)
                  rx_dec_state_nxt      = CB_RTAG;
               else
                  rx_dec_state_nxt      = CB_TAG_RSVD;
            end

         CB_RTAG : // Extract sequence number from next two bytes
            begin
               // Extract sequence number from next two bytes.
               if (new_aligned_data)
               begin
                  if (vlan_tagged)
                     rx_dec_state_nxt      = RX_DEC_VLAN2;
                  else
                     rx_dec_state_nxt      = RX_DEC_TYPE;
//                  frer_rtag_seqnum_nxt  = {new_data_align[7:0],
//                                            new_data_align[15:8]};
//                  frer_rtag_seqnum_stb_nxt  = 1'b1;
               end
               else
                  rx_dec_state_nxt  = CB_RTAG;
            end

         RX_DEC_VLAN1 : // Extract vlan tag from bytes 15-16
            begin
               // Extract vlan tag from bytes 15-16
               // presented as {user priority, CFI, VID[11:0]}
               // The UPPER nibble of byte 15 contains the priority and CFI bit.
               // The LOWER nibble of byte 15 and both nibbles of byte 16
               // contains VID (should=0 for priority tagged)
               if (new_aligned_data)
                  begin
                     tci_nxt           = new_data_align[7:4];
                     priority_tag_nxt  = (new_data_align[3:0]  == 4'h0) &
                                         (new_data_align[15:8] == 8'h00);
                     rx_dec_state_nxt  = RX_DEC_VLAN2;
                     // Stacked VLAN tag support
                     //
                     if (~second_vlan)
                        begin
                           ext_vlan_tag1_nxt[15:0] = {new_data_align[7:0],
                                                      new_data_align[15:8]};
                           ext_vlan_tag1_stb_nxt   = 1'b1;
                        end
                     else
                        begin
                           ext_vlan_tag2_nxt[15:0] = {new_data_align[7:0],
                                                      new_data_align[15:8]};
                           ext_vlan_tag2_stb_nxt   = 1'b1;
                        end
                  end
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_VLAN1;
                  end
            end


         RX_DEC_VLAN2 : // extract type id from bytes 17&18 after VLAN tag
            begin

              last_vlan_hdr     = 1'b1;

               // Save external type and length field
               ext_type_nxt[15:0]= {new_data_align[7:0], new_data_align[15:8]};
               length_field_nxt[15:0]= {new_data_align[7:0],
                                        new_data_align[15:8]};

               // Stacked VLAN tag support
               if (new_aligned_data & ~second_vlan & stacked_vlantype[16] &
                     ({new_data_align[7:0], new_data_align[15:8]} == VLAN_TYPE))
                  begin
                     second_vlan_nxt = 1'b1;
                     ext_vlan_tag2_nxt[31:16] =
                                    {new_data_align[7:0], new_data_align[15:8]};
                     rx_dec_state_nxt  = RX_DEC_VLAN1;
                  end

               // IPv4 encapsulated frame -  only check IP if no VLAN CFI.
               else if (new_aligned_data & ~tci[0] &
                   ({new_data_align[7:0],
                     new_data_align[15:8]} == IP_TYPEv4))
                  begin
                     ext_type_stb_nxt  = 1'b1;
                     ip_check_nxt      = rx_toe_enable;
                     rx_dec_state_nxt  = RX_DEC_IP1;
                  end

               // IPv6 encapsulated frame -  only check IP if no VLAN CFI.
               else if (new_aligned_data & ~tci[0] &
                   ({new_data_align[7:0],
                     new_data_align[15:8]} == IP_TYPEv6))
                  begin
                     ext_type_stb_nxt  = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_IPv6_1;
                  end

               // ARP encapsulated frame
               else if (new_aligned_data & ({new_data_align[7:0],
                                             new_data_align[15:8]} == ARP_TYPE))
                  begin
                     ext_type_stb_nxt  = 1'b1;
                     arp_frame_nxt     = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_IDLE;
                     in_payload_nxt    = 1'b1;
                  end

               // SNAP encapsulated frame -  only check SNAP if no VLAN CFI.
               else if (new_aligned_data & ~tci[0] &
                          ({new_data_align[7:0],
                            new_data_align[15:8]} <= SNAP_TYPE))
                  begin
                     rx_dec_state_nxt  = RX_DEC_SNAP1;
                  end

               // non encapsulated PTP frame
               else if (new_aligned_data &
                          ({new_data_align[7:0],
                            new_data_align[15:8]} == PTP_TYPE))
                  begin
                     in_payload_nxt    = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_PTP1;
                     ext_type_stb_nxt  = 1'b1;
                     ptp_frame_nxt     = 1'b1;
                     if (ext_da[47:0] == 48'h000000191b01)
                        begin
                           ptp_primary_nxt = 1'b1;
                        end
                     if (ext_da[47:0] == 48'h0e0000c28001)
                        begin
                           ptp_pdelay_nxt  = 1'b1;
                        end
                  end

               // PPPoE encapsulated frame
               else if (new_aligned_data &
                          ({new_data_align[7:0],
                            new_data_align[15:8]} == 16'h8864))
                  begin
                     ext_type_stb_nxt  = 1'b1;
                     rx_dec_state_nxt  = PPPoE1;
                  end

               // 802.1CB Redundancy Tag
               else if (new_aligned_data &
                        ({new_data_align[7:0],
                          new_data_align[15:8]} == frer_rtag_ethertype))
                  begin
                     if (~frer_6b_tag)
                        rx_dec_state_nxt = CB_RTAG;
                     else
                        rx_dec_state_nxt = CB_TAG_RSVD;
                  end

               // Other type - just present to external filter interface
               else if (new_aligned_data)
                  begin
                     in_payload_nxt    = 1'b1;
                     ext_type_stb_nxt  = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_IDLE;
                  end

               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_VLAN2;
                  end
            end


         PPPoE1 :
            begin
               in_other_hdr      = 1'b1;
               if (new_aligned_data)
                  begin
                     rx_dec_state_nxt  = PPPoE2;
                  end
               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = PPPoE1;
                  end
            end


         PPPoE2 :
            begin
               in_other_hdr      = 1'b1;
               if (new_aligned_data)
                  begin
                     rx_dec_state_nxt  = PPPoE3;
                  end
               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = PPPoE2;
                  end
            end


         PPPoE3 :
            begin
               in_other_hdr      = 1'b1;
               if (new_aligned_data)
                  begin
                     rx_dec_state_nxt  = PPPoE4;
                  end
               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = PPPoE3;
                  end
            end


         PPPoE4 :
            begin
               in_other_hdr      = 1'b1;
               // IPv4 encapsulated frame
               if (new_aligned_data &
                   ({new_data_align[7:0],
                     new_data_align[15:8]} == 16'h0021))
                  begin
                     ip_check_nxt      = rx_toe_enable;
                     rx_dec_state_nxt  = RX_DEC_IP1;
                  end
               // IPv6 encapsulated frame
               else if (new_aligned_data &
                   ({new_data_align[7:0],
                     new_data_align[15:8]} == 16'h0057))
                  begin
                     rx_dec_state_nxt  = RX_DEC_IPv6_1;
                  end
               else if (new_aligned_data)
                  begin
                     in_payload_nxt    = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_IDLE;
                  end
               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = PPPoE4;
                  end
            end


         RX_DEC_PAUSE1 : // check pause opcode from bytes 15-16
            begin
               // 802.3 pause frame op-code decoded
               if (new_aligned_data & ({new_data_align[7:0],
                                        new_data_align[15:8]} == PAUSE_OPCODE))
                  begin
                     pfc_pause_frame_nxt = 1'b0;
                     rx_dec_state_nxt  = RX_DEC_PAUSE2;
                  end

               // PFC pause frame op-code decoded
               else if (new_aligned_data & ({new_data_align[7:0],
                                    new_data_align[15:8]} == PFC_PAUSE_OPCODE))
                  begin
                     pfc_decoded_nxt   = 1'b1;
                     pause_frame_nxt   = 1'b0;
                     rx_dec_state_nxt  = RX_DEC_PAUSE2;
                  end

               // Invalid pause opcode, wait for next frame
               else if (new_aligned_data)
                  begin
                     drop_pause_frame_nxt  = 1'b0;
                     pause_frame_nxt   = 1'b0;
                     pfc_pause_frame_nxt = 1'b0;
                     rx_dec_state_nxt  = RX_DEC_IDLE;
                  end

               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_PAUSE1;
                  end
            end


         RX_DEC_PAUSE2 : // extract pause time value from bytes 17-18
            begin
               // Check pause opcode, but pause is disabled
               if (new_aligned_data &
                  ((~pause_enable_rck & pause_frame) |
                   (~pfc_enable_rck & pfc_decoded)))

                  begin
                     pause_time_nxt    = pause_time;
                     rx_dec_state_nxt  = RX_DEC_IDLE;
                  end

               // Check pause opcode, and pause is enabled
               else if (new_aligned_data)
                  //-----------------------------------------------
                  //------- PFC pause_frame op-code decoded    ----
                  //-----------------------------------------------
                  if (pfc_decoded)
                  begin
                      pause2_cnt_nxt = pause2_cnt + 4'h1;
                      case (pause2_cnt)
                         4'b0000 : // load priority enable vector
                         begin
                           priority_enable_nxt = new_data_align[15:8];
                           rx_dec_state_nxt  = RX_DEC_PAUSE2;
                         end
                         4'b0001 : // load pause time length for data frame
                                   // with priority 0
                         begin
                           rx_dec_state_nxt  = RX_DEC_PAUSE2;
                           pfc_pause_time0_nxt = {new_data_align[7:0],
                                                  new_data_align[15:8]};
                         end
                         4'b0010 : // load pause time length for data frame
                                   // with priority 1
                         begin
                           rx_dec_state_nxt  = RX_DEC_PAUSE2;
                           pfc_pause_time1_nxt = {new_data_align[7:0],
                                                  new_data_align[15:8]};
                         end
                         4'b0011 :  // load pause time length for data frame
                                    // with priority 2
                         begin
                           rx_dec_state_nxt  = RX_DEC_PAUSE2;
                           pfc_pause_time2_nxt = {new_data_align[7:0],
                                                  new_data_align[15:8]};
                         end
                         4'b0100 :  // load pause time length for data frame
                                    // with priority 3
                         begin
                           rx_dec_state_nxt  = RX_DEC_PAUSE2;
                           pfc_pause_time3_nxt = {new_data_align[7:0],
                                                  new_data_align[15:8]};
                         end
                         4'b0101 :  // load pause time length for data frame
                                    // with  priority 4
                         begin
                           rx_dec_state_nxt  = RX_DEC_PAUSE2;
                           pfc_pause_time4_nxt = {new_data_align[7:0],
                                                  new_data_align[15:8]};
                         end
                         4'b0110 :  // load pause time length for data frame
                                    // with  priority 5
                         begin
                           rx_dec_state_nxt  = RX_DEC_PAUSE2;
                           pfc_pause_time5_nxt = {new_data_align[7:0],
                                                  new_data_align[15:8]};
                         end
                         4'b0111 :  // load pause time length for data frame
                                    // with  priority 6
                         begin
                           rx_dec_state_nxt  = RX_DEC_PAUSE2;
                           pfc_pause_time6_nxt = {new_data_align[7:0],
                                                  new_data_align[15:8]};
                         end
                         default :  // load pause time length for data frame
                                    // with  priority 7
                         begin
                           rx_dec_state_nxt  = RX_DEC_IDLE;
                           pfc_pause_time7_nxt = {new_data_align[7:0],
                                                  new_data_align[15:8]};
                         end
                      endcase
                  end
                  else // else of "if pfc_decoded"
                  //-----------------------------------------------
                  //------- 802.3 pause frame op-code decoded -----
                  //-----------------------------------------------
                    begin
                       pause_time_nxt    = {new_data_align[7:0],
                                            new_data_align[15:8]};
                       rx_dec_state_nxt  = RX_DEC_IDLE;
                    end

               //----------------------------------------------------------
               // else of "if (new_aligned_data & ~pause_enable_rck)"
               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_PAUSE2;
                  end

            end


         RX_DEC_SNAP1 : // Check for valid DSAP and SSAP in SNAP encapsulation
            begin
               if (new_aligned_data & (new_data_align[7:0]  == SNAP_DSAP) &
                                      (new_data_align[15:8] == SNAP_SSAP))
                  begin
                     rx_dec_state_nxt  = RX_DEC_SNAP2;
                  end

               // Invalid DSAP or SSAP, wait for next frame.
               // Present previously saved type field to filter interface
               else if (new_aligned_data)
                  begin
                     in_payload_nxt    = 1'b1;
                     ext_type_stb_nxt  = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_IDLE;
                  end

               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_SNAP1;
                  end
            end


         RX_DEC_SNAP2 : // Check for valid control and ID[7:0] in SNAP
            begin
               if (new_aligned_data & (new_data_align[7:0]  == SNAP_CONT) &
                                      (new_data_align[15:8] == SNAP_ID_7_0))
                  begin
                     rx_dec_state_nxt  = RX_DEC_SNAP3;
                  end

               // Invalid control or ID[7:0], wait for next frame
               // Present previously saved type field to filter interface
               else if (new_aligned_data)
                  begin
                     in_payload_nxt    = 1'b1;
                     ext_type_stb_nxt  = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_IDLE;
                  end

               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_SNAP2;
                  end
            end


         RX_DEC_SNAP3 : // Check for valid ID[23:8] in SNAP
            begin
               if (new_aligned_data & (new_data_align[7:0]  == SNAP_ID_15_8) &
                                      (new_data_align[15:8] == SNAP_ID_23_16))
                  begin
                     snap_frame_nxt    = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_SNAP4;
                  end

               // Invalid control or ID[23:8], wait for next frame
               // Present previously saved type field to filter interface
               else if (new_aligned_data)
                  begin
                     in_payload_nxt    = 1'b1;
                     ext_type_stb_nxt  = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_IDLE;
                  end

               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_SNAP3;
                  end
            end


         RX_DEC_SNAP4 : // Check ethernet type for IP
            begin
               last_snap_hdr    = 1'b1;
               // Save external type
               ext_type_nxt[15:0]= {new_data_align[7:0], new_data_align[15:8]};


               if (new_aligned_data & ({new_data_align[7:0],
                                        new_data_align[15:8]} == IP_TYPEv4))
                  begin
                     ext_type_stb_nxt  = 1'b1;
                     ip_check_nxt      = rx_toe_enable;
                     rx_dec_state_nxt  = RX_DEC_IP1;
                  end

               else if (new_aligned_data & ({new_data_align[7:0],
                                        new_data_align[15:8]} == IP_TYPEv6))
                  begin
                     ext_type_stb_nxt  = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_IPv6_1;
                  end

               // Other type - just present to external filter interface
               else if (new_aligned_data)
                  begin
                     in_payload_nxt    = 1'b1;
                     ext_type_stb_nxt  = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_IDLE;
                  end

               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_SNAP4;
                  end
            end


         RX_DEC_IP1   : // Check IP version and get IP header length
            begin
               in_other_hdr      = 1'b1;
               if (new_aligned_data & (new_data_align[7:4] == IP_VERSION4) &
                                      (new_data_align[3:0] >= IP_IHL_MIN))
                  begin
                     ip_opt_length_nxt =
                                  {4'h0, (new_data_align[3:0] - IP_IHL_MIN)};
                     ip_v4_tos_nxt     = new_data_align[15:8];
                     ip_v4_frame_nxt   = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_IP2;
                  end

               // invalid - wait for next frame
               else if (new_aligned_data)
                  begin
                     in_payload_nxt    = 1'b1;
                     ip_check_nxt      = 1'b0;
                     rx_dec_state_nxt  = RX_DEC_IDLE;
                  end

               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_IP1;
                  end
            end


         RX_DEC_IP2   : // Get total length of datagram
            begin
               in_other_hdr      = 1'b1;
               if (new_aligned_data)
                  begin
                     ip_totlength_nxt  = {new_data_align[7:0],
                                          new_data_align[15:8]};
                     rx_dec_state_nxt  = RX_DEC_IP3;
                  end
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_IP2;
                  end
            end


         RX_DEC_IP3   : // wait for IP header identification
            begin
               in_other_hdr      = 1'b1;
               if (new_aligned_data)
                  begin
                     rx_dec_state_nxt  = RX_DEC_IP4;
                  end
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_IP3;
                  end
            end


         RX_DEC_IP4   : // Check no IP header fragmentation
            begin
               in_other_hdr      = 1'b1;
               if (new_aligned_data &
                      (({new_data_align[7:0],
                         new_data_align[15:8]} == IP_NFRAG_VAL1) |
                       ({new_data_align[7:0],
                         new_data_align[15:8]} == IP_NFRAG_VAL2)))
                  begin
                     rx_dec_state_nxt  = RX_DEC_IP5;
                  end

               // invalid - don't check TCP/UDP checksum (carry on checking IP)
               else if (new_aligned_data)
                  begin
                     no_tcp_udp_ck_nxt = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_IP5;
                  end

               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_IP4;
                  end
            end


         RX_DEC_IP5   : // Extract IP protocol (TCP or UDP only)
            begin
               in_other_hdr      = 1'b1;
               // TCP packet
               if (new_aligned_data & (new_data_align[15:8] == IP_TCP))
                  begin
                     tcp_frame_nxt     = ~no_tcp_udp_ck; // un-fragmented
                     rx_dec_state_nxt  = RX_DEC_IP6;
                  end

               // UDP packet
               else if (new_aligned_data & (new_data_align[15:8] == IP_UDP))
                  begin
                     udp_frame_nxt     = ~no_tcp_udp_ck; // un-fragmented
                     rx_dec_state_nxt  = RX_DEC_IP6;
                  end

               // invalid - don't check TCP/UDP checksum (carry on checking IP)
               else if (new_aligned_data)
                  begin
                     no_tcp_udp_ck_nxt = 1'b1;
                     rx_dec_state_nxt  = RX_DEC_IP6;
                  end

               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_IP5;
                  end
            end


         RX_DEC_IP6   : // wait for IP header checksum
            begin
               in_other_hdr      = 1'b1;
               // Once IP header checksum received, start adding data to
               // TCP/UDP header checksum if not blocked.
               if (new_aligned_data)
                  begin
                     tcp_udp_check_nxt = ~no_tcp_udp_ck & rx_toe_enable;
                     rx_dec_state_nxt  = RX_DEC_IP7;
                  end
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_IP6;
                  end
            end


         RX_DEC_IP7 : // decode IP source Address (first two bytes)
            begin
               in_other_hdr      = 1'b1;
               if (new_aligned_data)
                  begin
                     ext_ip_sa_nxt[15:0]  = new_data_align[15:0];
                     rx_dec_state_nxt     = RX_DEC_IP8;
                  end
               else
                  begin
                     rx_dec_state_nxt     = RX_DEC_IP7;
                  end
            end


         RX_DEC_IP8 : // decode IP source Address (second two bytes)
            begin
               in_other_hdr      = 1'b1;
               if (new_aligned_data)
                  begin
                     ext_ip_sa_nxt[31:16] = new_data_align[15:0];
                     ext_ip_sa_stb_nxt    = 1'b1;
                     rx_dec_state_nxt     = RX_DEC_IP9;
                  end
               else
                  begin
                     rx_dec_state_nxt     = RX_DEC_IP8;
                  end
            end


         RX_DEC_IP9 : // decode IP destination Address (first two bytes)
            begin
               in_other_hdr      = 1'b1;
               if (new_aligned_data)
                  begin
                     ext_ip_da_nxt[15:0]  = new_data_align[15:0];
                     rx_dec_state_nxt     = RX_DEC_IP10;
                  end
               else
                  begin
                     rx_dec_state_nxt     = RX_DEC_IP9;
                  end
            end


         RX_DEC_IP10 : // decode IP destination Address (second two bytes)
            begin
               in_other_hdr      = 1'b1;
               // If no options fields then this is the last field in IP header.
               // If IP header checksum is OK, go onto checking TCP/UDP checksum
               if (last_ip_header & ~no_tcp_udp_ck)
                  begin
                     ext_ip_da_nxt[31:16] = new_data_align[15:0];
                     ext_ip_da_stb_nxt    = 1'b1;
                     ip_check_nxt         = 1'b0;
                     rx_dec_state_nxt     = RX_DEC_CKSUM;
                     in_payload_nxt       = ~tcp_frame& ~udp_frame;
                  end

               // Last field in IP header, but bad checksum or not checking
               // TCP/UDP header checksum.
               else if (last_ip_header)
                  begin
                     ext_ip_da_nxt[31:16] = new_data_align[15:0];
                     ext_ip_da_stb_nxt    = 1'b1;
                     ip_check_nxt         = 1'b0;
                     tcp_udp_check_nxt    = 1'b0;
                     rx_dec_state_nxt     = RX_DEC_IDLE;
                     in_payload_nxt       = 1'b1;
                  end

               // Option fields in IP header need to be processed.
               else if (new_aligned_data)
                  begin
                     ext_ip_da_nxt[31:16] = new_data_align[15:0];
                     ext_ip_da_stb_nxt    = 1'b1;
                     tcp_udp_check_nxt    = 1'b0;
                     rx_dec_state_nxt     = RX_DEC_IP11;
                  end

               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt     = RX_DEC_IP10;
                  end
            end


         RX_DEC_IP11 : // Process IP header options fields
            begin
               in_other_hdr      = 1'b1;
               // Last field in IP header and IP header checksum is OK,
               // go onto checking TCP/UDP checksum
               if (last_ip_header & ~no_tcp_udp_ck)
                  begin
                     ip_check_nxt         = 1'b0;
                     tcp_udp_check_nxt    = rx_toe_enable;
                     rx_dec_state_nxt     = RX_DEC_CKSUM;
                     in_payload_nxt       = ~tcp_frame& ~udp_frame;
                  end

               // Last field in IP header, but bad checksum or not checking
               // TCP/UDP header checksum.
               else if (last_ip_header)
                  begin
                     ip_check_nxt         = 1'b0;
                     tcp_udp_check_nxt    = 1'b0;
                     rx_dec_state_nxt     = RX_DEC_IDLE;
                     in_payload_nxt       = 1'b1;
                  end

               // wait for next pipeline data to be last in IP header
               else
                  begin
                     rx_dec_state_nxt     = RX_DEC_IP11;
                  end
            end


         RX_DEC_PTP1 : // decode MAC Source Address
            begin
               // NOTE: Stay in this state for rest of frame. At end of frame
               //       decoding the synchronous part of FSM will reset back
               //       to idle to process next frame.
               //       This could be seen as a terminal state in LINT
               rx_dec_state_nxt = RX_DEC_PTP1;
               if (new_aligned_data)
                  begin
                     ptp_primary_nxt  = 1'b0;
                     ptp_pdelay_nxt   = 1'b0;
                  end
            end


         RX_DEC_CKSUM : // wait until all checksum data is processed and grab UDP Dest Addr.
            begin
               if (end_tcpudp_payload | udp_checksum_zero)
                  begin
                     tcp_udp_check_nxt    = 1'b0;
                     rx_dec_state_nxt     = RX_DEC_IDLE;
                     state_count_rst      = 1'b1;
                  end
               else if (new_aligned_data)
                 begin
                  if (state_count == 11'h000)
                    begin
                     ext_source_port_nxt  = {new_data_align[7:0],new_data_align[15:8]};
                     rx_dec_state_nxt     = RX_DEC_CKSUM;
                     state_count_inc      = 1'b1;
                     ext_sp_stb_nxt       = 1'b1;
                    end
                  else if (state_count == 11'h001)
                    begin
                     ext_dest_port_nxt    = {new_data_align[7:0],new_data_align[15:8]};
                     rx_dec_state_nxt     = RX_DEC_CKSUM;
                     state_count_inc      = 1'b1;
                     ext_dp_stb_nxt       = 1'b1;
                    end
                  else if (state_count == 11'h003 & udp_frame)
                    begin
                     last_tcpudp_header   = 1'b1;
                     in_payload_nxt       = 1'b1;
                     state_count_inc      = 1'b1;
                     rx_dec_state_nxt     = RX_DEC_CKSUM;
                   end
                  else if (state_count == 11'd002 & tcp_frame & p_edma_rsc == 1)
                    begin
                     tcp_seqnum_high_nxt = {new_data_align[7:0],new_data_align[15:8]};
                     state_count_inc      = 1'b1;
                     rx_dec_state_nxt     = RX_DEC_CKSUM;
                   end
                  else if (state_count == 11'd003 & tcp_frame & p_edma_rsc == 1)
                    begin
                     tcp_seqnum_low_nxt = {new_data_align[7:0],new_data_align[15:8]};
                     state_count_inc      = 1'b1;
                     rx_dec_state_nxt     = RX_DEC_CKSUM;
                   end
                  else if (state_count == 11'd006 & tcp_frame)
                    begin
                     tcp_offset_nxt       = new_data_align[7:4];
                     // Set rsc_stop if FIN/SYN/RST or URG flags are set
                     if (p_edma_rsc == 1)
                     begin
                       rsc_stop_nxt       = new_data_align[13] |    // URG
                                            (|new_data_align[10:8]); // RST/SYN/FIN;
                       rsc_push_nxt       = new_data_align[11]; // set with PSH flag
                       tcp_syn_nxt          = new_data_align[9];  // set with SYN flag
                     end
                     state_count_inc      = 1'b1;
                     rx_dec_state_nxt     = RX_DEC_CKSUM;
                   end
                  else if (state_count == ({6'd0,tcp_offset,1'b0} - 11'd1) & tcp_frame)
                    begin
                     last_tcpudp_header   = 1'b1;
                     in_payload_nxt       = 1'b1;
                     state_count_inc      = 1'b1;
                     rx_dec_state_nxt     = RX_DEC_CKSUM;
                   end
                  else
                    begin
                     state_count_inc      = 1'b1;
                     rx_dec_state_nxt     = RX_DEC_CKSUM;
                   end
                 end
               else
                  rx_dec_state_nxt     = RX_DEC_CKSUM;
            end

         RX_DEC_IPv6_1   : // Check IP version
            begin
               in_other_hdr      = 1'b1;
               rx_dec_state_nxt  = RX_DEC_IPv6_1;
               ext_ipv6_nxt      = 1'b1;
               if (new_aligned_data)
                  begin
                     ip_check_nxt      = 1'b0;  // No IP checksum for IPv6
                     case (state_count)
                     11'h000 :
                        begin
                           if (new_data_align[7:4] == IP_VERSION6)
                              begin
                                 ip_v6_tc_nxt      = {new_data_align[3:0],new_data_align[15:12]};
                                 state_count_inc   = 1'b1;
                                 ip_v6_frame_nxt   = 1'b1;
                              end
                           // invalid - wait for next frame
                           else
                              begin
                                 in_payload_nxt    = 1'b1;
                                 state_count_rst   = 1'b1;
                                 rx_dec_state_nxt  = RX_DEC_IDLE;
                              end
                        end

                     11'h001 :
                        begin
                           state_count_inc   = 1'b1;
                        end
                     11'h002 :
                        begin
                           state_count_inc   = 1'b1;
                           ip_totlength_nxt  = {new_data_align[7:0],
                                                new_data_align[15:8]};
                        end

                     11'h003 :
                        begin
                           nxt_hdr_is_frag_nxt   =
                                           (new_data_align[7:0] == IPV6_FRAG);
                           nxt_hdr_is_route_nxt  =
                                           (new_data_align[7:0] == IPV6_ROUTE);
                           if ((new_data_align[7:0] == IPV6_HOP)   |
                              (new_data_align[7:0] == IPV6_ROUTE) |
                              (new_data_align[7:0] == IPV6_FRAG)  |
                              (new_data_align[7:0] == IPV6_DEST))
                              begin
                                 ipv6_ext_hdr_nxt  = 1'b1;
                                 state_count_inc   = 1'b1;
                                 tcp_udp_check_nxt = rx_toe_enable;
                              end

                           else
                              begin
                                 ipv6_ext_hdr_nxt  = 1'b0;
                                 if (new_data_align[7:0] == IP_TCP)
                                    begin
                                       state_count_inc   = 1'b1;
                                       tcp_frame_nxt     = 1'b1;
                                       tcp_udp_check_nxt = rx_toe_enable;
                                    end

                                 else if (new_data_align[7:0] == IP_UDP)
                                    begin
                                       state_count_inc   = 1'b1;
                                       udp_frame_nxt     = 1'b1;
                                       tcp_udp_check_nxt = rx_toe_enable;
                                    end

                                 else
                                    begin
                                       state_count_inc   = 1'b1;
//                                       state_count_rst   = 1'b1;
//                                       rx_dec_state_nxt  = RX_DEC_IDLE;
                                       tcp_udp_check_nxt = 1'b0;
                                    end
                              end

                        end

                     // 128 bits Source Address
                     11'h004 :
                        begin
                           ext_ip_sa_nxt[15:0] = new_data_align[15:0];
//                           tcp_udp_check_nxt = rx_toe_enable;
                           state_count_inc   = 1'b1;
                        end

                     11'h005 :
                        begin
                           ext_ip_sa_nxt[31:16] = new_data_align[15:0];
//                           tcp_udp_check_nxt = rx_toe_enable;
                           state_count_inc   = 1'b1;
                        end

                     11'h006 :
                        begin
                           ext_ip_sa_nxt[47:32] = new_data_align[15:0];
//                           tcp_udp_check_nxt = rx_toe_enable;
                           state_count_inc   = 1'b1;
                        end

                     11'h007 :
                        begin
                           ext_ip_sa_nxt[63:48] = new_data_align[15:0];
//                           tcp_udp_check_nxt = rx_toe_enable;
                           state_count_inc   = 1'b1;
                        end

                     11'h008 :
                        begin
                           ext_ip_sa_nxt[79:64] = new_data_align[15:0];
//                           tcp_udp_check_nxt = rx_toe_enable;
                           state_count_inc   = 1'b1;
                        end

                     11'h009 :
                        begin
                           ext_ip_sa_nxt[95:80] = new_data_align[15:0];
//                           tcp_udp_check_nxt = rx_toe_enable;
                           state_count_inc   = 1'b1;
                        end

                     11'h00a :
                        begin
                           ext_ip_sa_nxt[111:96] = new_data_align[15:0];
//                           tcp_udp_check_nxt = rx_toe_enable;
                           state_count_inc   = 1'b1;
                        end

                     11'h00b: // Last 16 bits of Source Add.  Need to store
                              // checksum value here as we may need to recall
                              // it later if there are routing options
                        begin
                           ext_ip_sa_nxt[127:112] = new_data_align[15:0];
                           ext_ip_sa_stb_nxt = 1'b1;
//                           tcp_udp_check_nxt = rx_toe_enable;
//                           store_tcp_csum_nxt = 1'b1;
                           store_tcp_csum_nxt = tcp_udp_check;
                           state_count_inc   = 1'b1;
                        end

                     // 128 bits Destination Address
                     11'h00c :
                        begin
                           ext_ip_da_nxt[15:0] = new_data_align[15:0];
//                           tcp_udp_check_nxt = rx_toe_enable;
                           state_count_inc   = 1'b1;
                        end

                     11'h00d :
                        begin
                           ext_ip_da_nxt[31:16] = new_data_align[15:0];
//                           tcp_udp_check_nxt = rx_toe_enable;
                           state_count_inc   = 1'b1;
                        end

                     11'h00e :
                        begin
                           ext_ip_da_nxt[47:32] = new_data_align[15:0];
//                           tcp_udp_check_nxt = rx_toe_enable;
                           state_count_inc   = 1'b1;
                        end

                     11'h00f :
                        begin
                           ext_ip_da_nxt[63:48] = new_data_align[15:0];
//                           tcp_udp_check_nxt = rx_toe_enable;
                           state_count_inc   = 1'b1;
                        end

                     11'h010 :
                        begin
                           ext_ip_da_nxt[79:64] = new_data_align[15:0];
//                           tcp_udp_check_nxt = rx_toe_enable;
                           state_count_inc   = 1'b1;
                        end

                     11'h011 :
                        begin
                           ext_ip_da_nxt[95:80] = new_data_align[15:0];
//                           tcp_udp_check_nxt = rx_toe_enable;
                           state_count_inc   = 1'b1;
                        end

                     11'h012 :
                        begin
                           ext_ip_da_nxt[111:96] = new_data_align[15:0];
//                           tcp_udp_check_nxt = rx_toe_enable;
                           state_count_inc   = 1'b1;
                        end

                     default :
                        begin
                           state_count_rst   = 1'b1;
                           ext_ip_da_nxt[127:112] = new_data_align[15:0];
                           ext_ip_da_stb_nxt = 1'b1;
                           if (ipv6_ext_hdr)
                              begin
                                 rx_dec_state_nxt  = RX_DEC_IPv6_2;
                                 tcp_udp_check_nxt = 1'b0;
                              end
                           else if (tcp_frame | udp_frame)
                              rx_dec_state_nxt  = RX_DEC_CKSUM;
                           else
                             begin
                                in_payload_nxt    = 1'b1;
                                rx_dec_state_nxt  = RX_DEC_IDLE;
                             end
                        end

                     endcase

                  end
               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_IPv6_1;
                  end
            end

         RX_DEC_IPv6_2 :
            begin
               in_other_hdr      = 1'b1;
               rx_dec_state_nxt  = RX_DEC_IPv6_2;
               if (new_aligned_data)
                  begin
                     ip_check_nxt      = 1'b0;  // No IP checksum for IPv6
                     if (state_count == 11'h000)
                        begin
                           nxt_hdr_is_frag_nxt   =
                                            (new_data_align[7:0] == IPV6_FRAG);
                           nxt_hdr_is_route_nxt  =
                                           (new_data_align[7:0] == IPV6_ROUTE);
                           if (cur_hdr_is_frag)
                              begin
                                 ip_opt_length_nxt = 8'h00;
                                 ip_totlength_nxt  = ip_totlength - 16'h0008;
                                 no_tcp_udp_ck_nxt = 1'b1;
                              end
                           else
                              begin
                                 ip_totlength_nxt  = ip_totlength - 16'h0008 -
                                              {5'h00,new_data_align[15:8],3'h0};
                                 ip_opt_length_nxt = new_data_align[15:8];
                              end

                           if (cur_hdr_is_frag)
                              begin
                                 rx_dec_state_nxt  = RX_DEC_IDLE;
                                 state_count_rst   = 1'b1;
                                 in_payload_nxt    = 1'b1;
                              end

                           else if ((new_data_align[7:0] == IPV6_HOP)   |
                               (new_data_align[7:0] == IPV6_ROUTE) |
                               (new_data_align[7:0] == IPV6_DEST) |
                               (new_data_align[7:0] == IPV6_FRAG))
                              begin
                                 state_count_inc   = 1'b1;
                                 ipv6_ext_hdr_nxt  = 1'b1;
                              end

                           else
                              begin
                                 ipv6_ext_hdr_nxt  = 1'b0;
                                 if (new_data_align[7:0] == IP_TCP)
                                    begin
                                       state_count_inc   = 1'b1;
                                       tcp_frame_nxt     = 1'b1;
                                    end

                                 else if (new_data_align[7:0] == IP_UDP)
                                    begin
                                       state_count_inc   = 1'b1;
                                       udp_frame_nxt     = 1'b1;
                                    end

                                 else
                                    begin
                                       state_count_inc   = 1'b1;
                                    end
                              end
                        end

                     // Restart checksum calculation on the last DEST address
                     else if (state_count == ({1'b0,ip_opt_length,2'b00} - 11'd5) &
                              cur_hdr_is_route & segments_left)
                        begin
                           tcp_udp_check_nxt = rx_toe_enable;
                           state_count_inc   = 1'b1;
                        end

                     // Last cycle of this extension header
                     else if (state_count == ({1'b0,ip_opt_length,2'b00} + 11'd3))
                        begin
                           state_count_rst   = 1'b1;
                           if (ipv6_ext_hdr)
                              begin
                                 tcp_udp_check_nxt = 1'b0;
                                 rx_dec_state_nxt  = RX_DEC_IPv6_2;
                              end
                           else
                              begin
                                 if (!(tcp_frame|udp_frame))
                                    begin
                                       rx_dec_state_nxt  = RX_DEC_IDLE;
                                       tcp_udp_check_nxt = 1'b0;
                                       in_payload_nxt    = 1'b1;
                                    end
                                 else
                                    begin
                                       rx_dec_state_nxt  = RX_DEC_CKSUM;
                                       tcp_udp_check_nxt = rx_toe_enable;
                                    end
                              end
                        end

                     else
                        state_count_inc   = 1'b1;

                  end
               // wait for next pipeline data
               else
                  begin
                     rx_dec_state_nxt  = RX_DEC_IPv6_2;
                  end
            end



         default      : // RX_DEC_IDLE
            begin
               // If new frame coming in goto RX_DEC_DA1, only if enabled
               // by synchronous process of state machine.
               if (start_of_data)
                  begin
                     rx_dec_state_nxt     = RX_DEC_DA1;
                  end
               else
                  begin
                     rx_dec_state_nxt     = RX_DEC_IDLE;
                  end
            end

      endcase
   end


// -----------------------------------------------------------------------------
// Detect and store segments_left
// -----------------------------------------------------------------------------
   always@(posedge rx_clk or negedge n_rxreset)
   begin
      if (~n_rxreset)
         segments_left  <= 1'b0;
      else if (new_aligned_data & cur_hdr_is_route & state_count == 11'h001)
         segments_left  <= (new_data_align[15:8] != 8'h00);
   end


// -----------------------------------------------------------------------------
// State Counter for IPv6 states
// -----------------------------------------------------------------------------
   always@(posedge rx_clk or negedge n_rxreset)
   begin
      if (~n_rxreset)
        state_count <= 11'h000;
      else if (state_count_inc & ~(&state_count))
        state_count <= state_count + 11'h001;
      else if (state_count_rst | ~enable_receive_rck | ~frame_being_decoded)
        state_count <= 11'h000;
   end


// -----------------------------------------------------------------------------
// In IPV6, the DEST address to use in the checksum value depends on
// whether there are any routing options.  However, we may not know there
// are any routing options in the packet until after the DEST address of the
// IP header. We must therefore store the value of the checksum after the SRC
// address so that we can revert to this value should a routing option be
// detected later on
// -----------------------------------------------------------------------------
   always@(posedge rx_clk or negedge n_rxreset)
   begin
      if (~n_rxreset)
        stored_tcp_csum <= 17'h00000;
      else if (store_tcp_csum)
        stored_tcp_csum <= {tcp_checksum_carry,tcp_checksum_val};
   end


// -----------------------------------------------------------------------------
// IP Header Checksum Validation
// -----------------------------------------------------------------------------

   // Count correct number of options field (counted in 16 bit words)
   always@(posedge rx_clk or negedge n_rxreset)
   begin
    if (~n_rxreset)
      ip_options_cnt <= 9'd0;
    else if ((rx_dec_state_nxt == RX_DEC_IP11) & new_aligned_data)
      ip_options_cnt <= ip_options_cnt_nxt;
    else if (rx_dec_state_nxt == RX_DEC_IP11)
      ip_options_cnt <= ip_options_cnt;
    else if ((rx_dec_state_nxt == RX_DEC_IPv6_2) & new_aligned_data)
      ip_options_cnt <= ip_options_cnt_nxt;
    else if (rx_dec_state_nxt == RX_DEC_IPv6_2)
      ip_options_cnt <= ip_options_cnt;
    else
      ip_options_cnt <= 9'd0;
   end

   // Next value of options field counter
   assign ip_options_cnt_nxt = ip_options_cnt + 9'h001;

   // Indicate last ip header when value of options field counter
   // equals expected length and we have reached RX_DEC_IP10 or RX_DEC_IP11.
   // Note that ip_opt_length is expressed in 32 bit words, whereas we are
   // counting in 16 bit words.
   assign last_ip_header = new_aligned_data &
                           ( (rx_dec_state == RX_DEC_IP10 |
                              rx_dec_state == RX_DEC_IP11) &
                              ip_options_cnt == {ip_opt_length,1'b0});

   assign last_ipv6_header = new_aligned_data &
                            ((rx_dec_state == RX_DEC_IPv6_1 &
                               state_count == 11'h013 &
                               ~ipv6_ext_hdr) |
                             (rx_dec_state == RX_DEC_IPv6_2 &
                               (state_count == ({1'b0,ip_opt_length,2'b00} + 11'd3)) &
                               ~ipv6_ext_hdr)) ;


   // maintain checksum value
   always@(posedge rx_clk or negedge n_rxreset)
   begin
    if (~n_rxreset)
      begin
         ip_checksum_val   <= 16'h0000;
         ip_checksum_carry <= 1'b0;
      end
    else if (~enable_receive_rck | ~rx_toe_enable | ~frame_being_decoded)
      begin
         ip_checksum_val   <= 16'h0000;
         ip_checksum_carry <= 1'b0;
      end
    else if (ip_check & new_aligned_data)
      begin
         ip_checksum_val   <= ip_checksum_val_nxt[15:0];
         ip_checksum_carry <= ip_checksum_val_nxt[16];
      end
    else
      begin
         ip_checksum_val   <= ip_checksum_val;
         ip_checksum_carry <= ip_checksum_carry;
      end
   end

   // Calculate next value for checksum value.
   // Next value is previous plus the previous carry plus the new data (note
   // the order of the new data is [earliest byte, latest byte]).
   assign ip_checksum_val_nxt={1'b0, ip_checksum_val[15:0]} +
                              {16'd0, ip_checksum_carry} +
                              {1'b0, new_data_align[7:0], new_data_align[15:8]};


   // Validate the IP header checksum on last IP header. Checksum is OK if
   // the new value is 0xFFFF. The new value must be include the carry bit
   // added to the LSB (one's complement addition). Normally this is added
   // in the next cycle, so instead look for 0xFFFE if the carry is set.
   assign ip_checksum_ok = (ip_checksum_val_nxt[15:0] ==
                                           {15'h7fff,~ip_checksum_val_nxt[16]});


   // hold checksum error until end of frame.
   always@(posedge rx_clk or negedge n_rxreset)
   begin
    if (~n_rxreset)
      ip_ck_err_det <= 1'b0;
    else if (~enable_receive_rck | ~rx_toe_enable | ~frame_being_decoded)
      ip_ck_err_det <= 1'b0;
    else if (last_ip_header & ~ip_checksum_ok)
      ip_ck_err_det <= 1'b1;
    else
      ip_ck_err_det <= ip_ck_err_det;
   end

   // Signal IP checksum error if not OK or if the end of frame is reached
   // before calculation is complete
   assign ip_ck_err = ip_ck_err_det | (end_of_frame & ip_check);


// -----------------------------------------------------------------------------
// TCP/UDP Checksum Validation
// -----------------------------------------------------------------------------

   // Count correct number of TCP/UDP fields. Count number of 16 bit words.
   always@(posedge rx_clk or negedge n_rxreset)
   begin
    if (~n_rxreset)
      ip_length_cnt <= 16'h0000;
    else if (~enable_receive_rck | ~frame_being_decoded)
      ip_length_cnt <= 16'h0000;
    else if (new_aligned_data & (ip_check | (rx_dec_state == RX_DEC_CKSUM)))
      ip_length_cnt <= ip_length_cnt_nxt;
    else
      ip_length_cnt <= ip_length_cnt;
   end


   // Next value of TCP/UDP length counter (counting in 16 bit words).
   assign ip_length_cnt_nxt = ip_length_cnt + 16'h0001;


   // Round up ip_totlength to the nearest number of 16 bit words.
   assign ip_totlength_rounded = ({1'b0,ip_totlength[15:1]} +
                                  {15'd0,ip_totlength[0]});


   // Indicate last TCP/UDP data. ip_totlength is expressed in terms of bytes,
   // whereas we are counting in 16 bit words. We also need to round
   // up to the nearest number of 16 bit words.
   assign end_tcpudp_payload = new_aligned_data &
                            (rx_dec_state == RX_DEC_CKSUM) &
                            (ip_length_cnt_nxt == ip_totlength_rounded);


   // Work out where the UDP checksum value will be. This will be on the 27th
   // and 28th byte if the options field is zero length. (note that counter
   // value will be 13 (0xd) when checksum is in new_data_align).
   // Note that ip_opt_length is expressed in 32 bit words, whereas we are
   // counting in 16 bit words.
   assign udp_checksum[9:0] = 10'h00d + {1'b0, ip_opt_length, 1'b0};


   // detect when a UDP frame and the UDP checksum value is zero. When this
   // is signalled checksum verification is stopped and no error is reported.
   // note for ipv6 packets udp with a zero checksum must be discarded
   assign udp_checksum_zero = new_aligned_data & udp_frame &
                            ~ip_v6_frame & (ip_length_cnt == {6'h00,udp_checksum[9:0]}) &
                            (new_data_align[15:0] == 16'h0000);

   assign udp_checksum_zero_ipv6 = new_aligned_data & udp_frame &
                             ip_v6_frame & (ip_length_cnt == 16'h0003) &
                            (new_data_align[15:0] == 16'h0000);

   wire [17:0] tcp_checksum_1;
   wire [17:0] tcp_checksum_2;
   assign      tcp_checksum_1 = ip_totlength[15:0] + {8'h00,IP_TCP} + tcp_checksum_val[15:0] + {15'd0, tcp_checksum_carry};
   assign      tcp_checksum_2 = ip_totlength[15:0] + {8'h00,IP_UDP} + tcp_checksum_val[15:0] + {15'd0, tcp_checksum_carry};
   
   // maintain TCP/UDP checksum value
   always@(posedge rx_clk or negedge n_rxreset)
   begin
    if (~n_rxreset)
       begin
          tcp_checksum_val   <= 16'h0000;
          tcp_checksum_carry <= 1'b0;
       end

    // Zero when disabled or not receiving a frame
    else if (~enable_receive_rck | ~rx_toe_enable | ~frame_being_decoded)
       begin
          tcp_checksum_val   <= 16'h0000;
          tcp_checksum_carry <= 1'b0;
       end

    // Initialise checksum value with tcp_checksum_init - IPv4 ONLY
    else if ((rx_dec_state == RX_DEC_IP6) & new_aligned_data)
       begin
          tcp_checksum_val   <= tcp_checksum_init[15:0];
          tcp_checksum_carry <= tcp_checksum_init[16];
       end

    // For IPv6 packets with a routing header, we need to reset
    // the checksum to the temp value stored in stored_tcp_csum.
    // this value contains the checksum value after the source
    // address only has been processed
    // Use state count of 2 as segments_left is only valid at this point
    else if (new_aligned_data & cur_hdr_is_route & segments_left &
             (state_count == 11'h002))
       begin
          tcp_checksum_val   <= stored_tcp_csum[15:0];
          tcp_checksum_carry <= stored_tcp_csum[16];
       end

    // Initialise checksum value  - IPv6
    else if (new_aligned_data & (tcp_frame_nxt|udp_frame_nxt) &
            ((rx_dec_state == RX_DEC_IPv6_1 & state_count == 11'h003) |
             (rx_dec_state == RX_DEC_IPv6_2 & state_count == 11'h003)))
       begin
          // If there are no more extension headers and next hdr
          // is the TCP/UDP, then we can add the payload length
          // & next header values into the checksum here.
          // Note that ip_totlength is updated in state cnt 0
          // of RX_DEC_IPv6_2 state, so it is valid here in state 1
          if (tcp_frame_nxt)
             {tcp_checksum_carry,tcp_checksum_val}   <= tcp_checksum_1[16:0];
          else
             {tcp_checksum_carry,tcp_checksum_val}   <= tcp_checksum_2[16:0];
       end

    // If data is part of checksum calculation (tcp_udp_check high),
    // then add to checksum value.
    else if (tcp_udp_check & new_aligned_data)
       begin
          tcp_checksum_val   <= tcp_checksum_val_nxt[15:0];
          tcp_checksum_carry <= tcp_checksum_val_nxt[16];
       end

    // Otherwise maintain value
    else
       begin
          tcp_checksum_val   <= tcp_checksum_val;
          tcp_checksum_carry <= tcp_checksum_carry;
       end
   end



   // Calculate next value for checksum value.
   always @(*)
   begin
     // Total number of bytes in datagram is odd and last word
     if (ip_totlength[0] & end_tcpudp_payload)
        tcp_checksum_val_nxt = {1'b0, tcp_checksum_val[15:0]} +
                               {16'd0, tcp_checksum_carry} +
                               {1'b0, new_data_align[7:0], 8'h00};

     // Otherwise always add previous value plus the previous carry plus
     // the new data value ordered as [earliest byte, latest byte]
     else
        tcp_checksum_val_nxt = {1'b0, tcp_checksum_val[15:0]} +
                               {16'd0, tcp_checksum_carry} +
                               {1'b0, new_data_align[7:0],
                                   new_data_align[15:8]};
   end



   // Initial value of checksum calculation is
   //
   //   <total length> - (4 * <option length>) - 20 + X
   //       where X = 0x0011 for UDP and 0x0006 for TCP
   //
   // Note lengths must be expressed in bytes.
   //
   always @(udp_frame or ip_totlength or ip_opt_length)
   begin
     if (udp_frame)
       begin
          tcp_checksum_init = {1'b0, ip_totlength[15:0]} -
                              {7'd0, ip_opt_length,2'b00} -
                              17'h00003;
       end
     else
       begin
          tcp_checksum_init = {1'b0, ip_totlength[15:0]} -
                              {7'd0, ip_opt_length,2'b00} -
                              17'h0000e;
       end
   end

  // TCP Payload Length ...
  assign tcp_payload_len      = {ip_totlength[15:0]} -
                                {6'd0, ip_opt_length,2'b00} -
                                {6'd0, tcp_offset,2'b00} -
                                16'h0014;

   // Validate the TCP/UDP header checksum on last data.
   // Checksum is good if value is 0xFFFF or if UDP frame with zero checksum.
   // The new value must be include the carry bit added to the LSB (one's
   // complement addition). Normally this is added in the next cycle, so
   // instead look for 0xFFFE if the carry is set.
   assign tcp_udp_checksum_ok = (tcp_checksum_val_nxt[15:0] ==
                                     {15'h7fff,~tcp_checksum_val_nxt[16]}) |
                                udp_checksum_zero | ~(udp_frame|tcp_frame);


   // hold zero checksum udp ipv6 frame error until end of frame.
   always@(posedge rx_clk or negedge n_rxreset)
   begin
    if (~n_rxreset)
      begin
         zero_udp_csum_ipv6 <= 1'b0;
      end
    else if (~enable_receive_rck | ~rx_toe_enable | ~frame_being_decoded)
      begin
         zero_udp_csum_ipv6 <= 1'b0;
      end
    else if (udp_checksum_zero_ipv6)
      begin
         zero_udp_csum_ipv6 <= 1'b1;
      end
    else
      begin
         zero_udp_csum_ipv6 <= zero_udp_csum_ipv6;
      end
   end

   // hold checksum error until end of frame.
   always@(posedge rx_clk or negedge n_rxreset)
   begin
    if (~n_rxreset)
      tcp_udp_ck_err_det <= 1'b0;
    else if (~enable_receive_rck | ~rx_toe_enable | ~frame_being_decoded)
      tcp_udp_ck_err_det <= 1'b0;
    else if (end_tcpudp_payload & (~tcp_udp_checksum_ok | zero_udp_csum_ipv6))
      tcp_udp_ck_err_det <= 1'b1;
    else
      tcp_udp_ck_err_det <= tcp_udp_ck_err_det;
   end


   // Signal TCP/UDP checksum error if not OK or if the end of frame is reached
   // before calculation is complete. gate with the IP ck error, as there is no
   // point in incrementing the UDP/TCP checksum error stats if there was error
   // was actually in the IP checksum
   assign tcp_udp_ck_err = ((tcp_udp_ck_err_det |
                            (end_of_frame & tcp_udp_check)) & ~ip_ck_err_det);




   // IEEE 1588 stuff
   // drive sof_rx
   // assert at start of frame, de-assert at end of frame
   always@(posedge rx_clk or negedge n_rxreset)
   begin
    if (~n_rxreset)
      begin
         sof_rx <= 1'b0;
         sof_rx_tog <= 1'b0;
      end
    else if (~enable_receive_rck | ~frame_being_decoded)
      begin
         sof_rx <= 1'b0;
         sof_rx_tog <= sof_rx_tog;
      end
    else if (start_of_data)
      begin
         sof_rx <= 1'b1;
         sof_rx_tog <= ~sof_rx_tog;
      end
   end


   // want to match LSBs of IP address of 001, 010, 011 and 100
   assign ip_lsb_ptp_dec =
                       (~ext_ip_da_nxt[26] & (ext_ip_da_nxt[25:24] != 2'b00)) |
                       (ext_ip_da_nxt[26:24] == 3'b100);

   assign unicast_address ={rx_ptp_unicast[7:0], rx_ptp_unicast[15:8],
                            rx_ptp_unicast[23:16], rx_ptp_unicast[31:24]};

   // drive en_ptp_count
   always@(posedge rx_clk or negedge n_rxreset)
   begin
    if (~n_rxreset)
      begin
         en_ptp_count    <= 1'b0;
         ptp_primary_set <= 1'b0;
         ptp_pdelay_set  <= 1'b0;
      end
    // stop at end of frame or if destination port is not 013F or 0140
    else if (~enable_receive_rck | ~frame_being_decoded |
                            (new_aligned_data & (ptp_count == 5'b00010) &
                                ~udp_event_frame & ~udp_gener_frame))
      begin
         en_ptp_count    <= 1'b0;
         ptp_primary_set <= 1'b0;
         ptp_pdelay_set  <= 1'b0;
      end
    // IPv4 unicast, start if UDP frame with correct unicast IP address
    else if (ptp_unicast_ena & ext_ip_da_stb_nxt & udp_frame & ip_v4_frame &
            (ext_ip_da_nxt[31:0] == unicast_address))
      begin
         en_ptp_count    <= 1'b1;
         ptp_primary_set <= 1'b1;
         ptp_pdelay_set  <= 1'b1;
      end
    // IPv4 primary, start if UDP frame with correct multicast IP address
    else if (ext_ip_da_stb_nxt & udp_frame & ip_v4_frame &
       (ext_ip_da_nxt[23:0] == 24'h0100e0) & (ext_ip_da_nxt[31:27] == 5'h10))
      begin
         en_ptp_count    <= ip_lsb_ptp_dec;
         ptp_primary_set <= ip_lsb_ptp_dec;
      end
    // IPv4 peer, start if UDP frame with correct multicast IP address
    else if (ext_ip_da_stb_nxt & udp_frame & ip_v4_frame &
            (ext_ip_da_nxt[31:0] == 32'h6b0000e0))
      begin
         en_ptp_count    <= 1'b1;
         ptp_pdelay_set  <= 1'b1;
      end
    // IPv6 primary, start if UDP frame with correct multicast IP address
    else if (ext_ip_da_stb_nxt & udp_frame & ip_v6_frame &
            ((ext_ip_da_nxt[127:12] == 116'h81010000000000000000000000000) &
             (ext_ip_da_nxt[7:0] == 8'hff)))
      begin
         en_ptp_count    <= 1'b1;
         ptp_primary_set <= 1'b1;
      end
    // IPv6 peer, start if UDP frame with correct multicast IP address
    else if (ext_ip_da_stb_nxt & udp_frame & ip_v6_frame &
            (ext_ip_da_nxt[127:0] == 128'h6b0000000000000000000000000002ff))
      begin
         en_ptp_count    <= 1'b1;
         ptp_pdelay_set  <= 1'b1;
      end
   end

   // count through PTP frame when en_ptp_count is high
   always@(posedge rx_clk or negedge n_rxreset)
   begin
    if (~n_rxreset)
      ptp_count <= 5'b00000;
    else if (~enable_receive_rck | ~frame_being_decoded)
      ptp_count <= 5'b00000;
    else if (en_ptp_count & new_aligned_data & (ptp_count != 5'b11111))
      ptp_count <= ptp_count + 5'b00001;
   end

   // drive PTP signals
   // de-assert at end of frame
   // if ptp_count makes it to 5'b10100 check PTP event frame messageType
   wire dat_8tod;
   assign dat_8tod =  ((new_data_align[3:0] == 4'h8)
                      |(new_data_align[3:0] == 4'h9)
                      |(new_data_align[3:0] == 4'hb)
                      |(new_data_align[3:0] == 4'hc)
                      |(new_data_align[3:0] == 4'hd));

   always@(posedge rx_clk or negedge n_rxreset)
   begin
    if (~n_rxreset)
       begin
          sync_frame_rx    <= 1'b0;
          delay_req_rx     <= 1'b0;
          pdelay_req_rx    <= 1'b0;
          pdelay_resp_rx   <= 1'b0;
          ptp_v1           <= 1'b0;
          general_frame_rx <= 1'b0;
          udp_event_frame  <= 1'b0;
          udp_gener_frame  <= 1'b0;
       end
    else if (~enable_receive_rck | ~frame_being_decoded)
       begin
          sync_frame_rx    <= 1'b0;
          delay_req_rx     <= 1'b0;
          pdelay_req_rx    <= 1'b0;
          pdelay_resp_rx   <= 1'b0;
          ptp_v1           <= 1'b0;
          general_frame_rx <= 1'b0;
          udp_event_frame  <= 1'b0;
          udp_gener_frame  <= 1'b0;
        end
    // non-encapsulated PTP-frame
    else if (new_aligned_data & ptp_frame & ptp_primary_load)
       begin
          sync_frame_rx    <= (new_data_align[3:0] == 4'h0);
          delay_req_rx     <= (new_data_align[3:0] == 4'h1);
          general_frame_rx <= dat_8tod;
       end
    else if (new_aligned_data & ptp_frame & ptp_pdelay_load)
       begin
          sync_frame_rx    <= (new_data_align[3:0] == 4'h0);
          pdelay_req_rx    <= (new_data_align[3:0] == 4'h2);
          pdelay_resp_rx   <= (new_data_align[3:0] == 4'h3);
          general_frame_rx <= (new_data_align[3:0] == 4'ha); // Peer general message
       end
    // look at udp destination port to see if we have a PTP event frame
    // or PTP general frame
    else if (new_aligned_data & (ptp_count == 5'b00001))
       begin
          udp_event_frame <= (new_data_align[15:0] == 16'h3F01);
          udp_gener_frame <= (new_data_align[15:0] == 16'h4001);
       end
    // PTP version 2 encapsulated in IPv4
    // Note that Peer general Messages (i.e. Pdelay_Resp_Follow_Up) is decoded
    // at a different multicast address from other General Messages
    // depending on encapsulation.
    // See IEEE 1588D2.2 Appendix D/E/F
    else if (new_aligned_data & ip_v4_frame & (ptp_count == 5'b00100))
       begin
          // unicast
          if (ptp_unicast_ena & ptp_primary_set & ptp_pdelay_set &
        //     (new_data_align[15:8] == 8'h02))
             (new_data_align[11:8] == 4'h2))
             begin
                sync_frame_rx    <= (new_data_align[3:0] == 4'h0) & udp_event_frame;
                delay_req_rx     <= (new_data_align[3:0] == 4'h1) & udp_event_frame;
                pdelay_req_rx    <= (new_data_align[3:0] == 4'h2) & udp_event_frame;
                pdelay_resp_rx   <= (new_data_align[3:0] == 4'h3) & udp_event_frame;
                general_frame_rx <= dat_8tod & udp_gener_frame;
             end
//          else if (ptp_primary_set & (ext_ip_da[31:24] == 8'h81) & (new_data_align[15:8] == 8'h02))
          else if (ptp_primary_set & (ext_ip_da[31:24] == 8'h81) & (new_data_align[11:8] == 4'h2))
             begin
                sync_frame_rx    <= (new_data_align[3:0] == 4'h0) & udp_event_frame;
                delay_req_rx     <= (new_data_align[3:0] == 4'h1) & udp_event_frame;
                general_frame_rx <= dat_8tod & udp_gener_frame;
             end
    //      else if (ptp_primary_set & (ip_lsb_ptp_dec) & (new_data_align[15:8] == 8'h01))
          else if (ptp_primary_set & (ip_lsb_ptp_dec) & (new_data_align[11:8] == 4'h1))
             begin
                ptp_v1           <= 1'b1;
             end
          else if (ptp_pdelay_set)
             begin
                pdelay_req_rx    <= (new_data_align[3:0] == 4'h2) & udp_event_frame;
                pdelay_resp_rx   <= (new_data_align[3:0] == 4'h3) & udp_event_frame;
                general_frame_rx <= (new_data_align[3:0] == 4'ha) & udp_gener_frame; // Peer general message
             end
        end
    // PTP version 2 encapsulated in IPv6
    else if (new_aligned_data & ip_v6_frame & (ptp_count == 5'b00100))
       begin
          if (ptp_primary_set)
             begin
                sync_frame_rx    <= (new_data_align[3:0] == 4'h0) & udp_event_frame;
                delay_req_rx     <= (new_data_align[3:0] == 4'h1) & udp_event_frame;
                general_frame_rx <= dat_8tod & udp_gener_frame;
             end
          else // if (ptp_pdelay_set) // This must be true, otherwise ptp_count wouldnt be incrementing ...
             begin
                pdelay_req_rx    <= (new_data_align[3:0] == 4'h2) & udp_event_frame;
                pdelay_resp_rx   <= (new_data_align[3:0] == 4'h3) & udp_event_frame;
                general_frame_rx <= (new_data_align[3:0] == 4'ha) & udp_gener_frame; // Peer general message
             end
       end
    // PTP version 1 encapsulated in IPv4
    else if (new_aligned_data & ip_v4_frame & (ptp_count == 5'b10100))
       begin
          if (ptp_primary_set & ptp_v1)
             begin
                sync_frame_rx    <= (new_data_align[3:0] == 4'h0) & udp_event_frame;
                delay_req_rx     <= (new_data_align[3:0] == 4'h1) & udp_event_frame;
                general_frame_rx <= ((new_data_align[3:0] == 4'h2)
                                    |(new_data_align[3:0] == 4'h3)
                                    |(new_data_align[3:0] == 4'h4)) & udp_gener_frame;
             end
        end
   end

  // Combinatorial decode of state machine to indicate that the value being presented to the RX Pipeline input
  // corresponds to the Redundancy Tag. This is needed for later deletion of this field if enabled.
  assign frer_rtag_mark_early = (rx_dec_state_nxt == CB_TAG_RSVD) || (rx_dec_state == CB_TAG_RSVD) ||
                                (rx_dec_state_nxt == CB_RTAG)     || (rx_dec_state == CB_RTAG);

endmodule

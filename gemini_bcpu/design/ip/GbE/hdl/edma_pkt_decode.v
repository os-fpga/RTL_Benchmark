//------------------------------------------------------------------------------
// Copyright (c) 2005-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_pkt_decode.v
//   Module Name:        edma_pkt_decode
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
//   Description :      L2/L3/L4 packet decoder
//
//------------------------------------------------------------------------------


module edma_pkt_decode (

     host_clk,
     host_rst_n,

     soft_enable,

     data,
     sop,
     eop,
     valid,
     dma_bus_width,

     ptp_unicast_addr,
     ptp_unicast_addr_en,
     disable_preamble,

     running_byte_count,
     running_byte_count_nxt,

     screener_type1_regs,
     screener_type2_regs,
     scr2_compare_regs,
     scr2_ethtype_regs,
     queue_ptr_rx,
     svlan_type,

     mac_dest_addr_c,
     mac_dest_addr_stb_c,
     mac_src_addr_c,
     mac_src_addr_stb_c,
     vlan_tag1,
     vlan_tag1_stb,
     vlan_tag2,
     vlan_tag2_stb,
     ethertype,
     ethertype_stb,
     ip_sa,
     ip_sa_stb,
     ip_da,
     ip_da_stb,
     rx_csum_zero,
     l3_hdr_offst,
     l4_hdr_offst,
     pld_offst,
     l4_udp_hdr_detected,
     l4_tcp_hdr_detected,
     start_of_ip_srcadd_offset,
     end_of_ip_srcadd_offset,
     start_of_ip_destadd_offset,
     end_of_ip_destadd_offset,
     end_of_tcpudp_pld_offset,
     decode_out_vld,
     tcp_length,
     ipv4_decodes_vld,
     ipv4_csum_offset,
     tcp_csum_offset,
     end_of_ip_hdr_offset,
     ptp_timestamp_offset,
     ptp_event_msg,
     ptp_general_msg,
     ptp_sync_msg,
     ptp_dreq_msg,
     ptp_follow_msg,
     ptp_dresp_msg,
     ptp_pdreq_msg,
     ptp_pdresp_msg,
     ptp_version,
     ptp_seqid,
     ipv4_frame_detected,
     ipv6_frame_detected,
     ptpoe_type_detected,
     snap_hdr_detected,
     tcp_status

  );

  parameter decode_1588          = 1'b1;      // Include 1588 specific decodes
  parameter decode_ipv4_options  = 1'b1;      // When low, assume there are no IPv4 options (simplifies decoding)
  parameter decode_ipv6_exthdrs  = 1'b1;      // When low, assume there are no IPv6 extension headers (simplifies decoding)
  parameter include_screeners    = 1'b0;      //
  parameter p_num_type1_screeners   = 0;      //
  parameter p_num_type2_screeners   = 0;      //
  parameter p_num_scr2_compare_regs = 0;      //
  parameter p_num_scr2_ethtype_regs = 0;      //

  input               host_clk;
  input               host_rst_n;

  input               soft_enable;

  input  [127:0]      data;
  input               sop;
  input               eop;
  input               valid;
  input  [1:0]        dma_bus_width;      // programmed data width
                                          // 00 = 32  bit bus
                                          // 01 = 64  bit bus
                                          // 1x = 128 bit bus

  input  [31:0]       ptp_unicast_addr;
  input               disable_preamble;
  input               ptp_unicast_addr_en;

  input [(30*p_num_type1_screeners):0] screener_type1_regs; //
  input [(30*p_num_type2_screeners):0] screener_type2_regs; //
  input  [(41*p_num_scr2_compare_regs):0] scr2_compare_regs;
  input  [(16*p_num_scr2_ethtype_regs):0] scr2_ethtype_regs;
  input  [16:0]       svlan_type;

  output [3:0]        queue_ptr_rx;

  output [15:0]       running_byte_count;
  output [15:0]       running_byte_count_nxt;

  output [47:0]       mac_dest_addr_c;
  output              mac_dest_addr_stb_c;
  output [47:0]       mac_src_addr_c;
  output              mac_src_addr_stb_c;
  output [31:0]       vlan_tag1;
  output              vlan_tag1_stb;
  output [31:0]       vlan_tag2;
  output              vlan_tag2_stb;
  output [15:0]       ethertype;
  output              ethertype_stb;
  output [127:0]      ip_sa;
  output              ip_sa_stb;
  output [127:0]      ip_da;
  output              ip_da_stb;
  output              rx_csum_zero;
  output [5:0]        l3_hdr_offst;
  output [15:0]       l4_hdr_offst;
  output [15:0]       pld_offst;
  output [6:0]        start_of_ip_srcadd_offset;
  output [6:0]        end_of_ip_srcadd_offset;
  output [15:0]       start_of_ip_destadd_offset;
  output [15:0]       end_of_ip_destadd_offset;
  output [15:0]       end_of_tcpudp_pld_offset;
  output              ipv4_decodes_vld;
  output [6:0]        ipv4_csum_offset;
  output [15:0]       tcp_csum_offset;
  output              decode_out_vld;
  output [15:0]       end_of_ip_hdr_offset;
  output [15:0]       ptp_timestamp_offset;
  output [15:0]       tcp_length;
  output              ptp_event_msg;
  output              ptp_general_msg;
  output              ptp_sync_msg;
  output              ptp_dreq_msg;
  output              ptp_follow_msg;
  output              ptp_dresp_msg;
  output              ptp_pdreq_msg;
  output              ptp_pdresp_msg;
  output [1:0]        ptp_version;
  output [15:0]       ptp_seqid;
  output              ipv4_frame_detected;
  output              ipv6_frame_detected;
  output              l4_udp_hdr_detected;
  output              l4_tcp_hdr_detected;
  output              ptpoe_type_detected;
  output [2:0]        tcp_status;
  output              snap_hdr_detected;

  reg    [16:0]       running_byte_count_nxt_c;
  reg    [15:0]       running_byte_count;


  wire                ptpoe_type_detected_c;
  wire                ptpoe_type_detected;
  wire   [3:0]        sa_offset;
  wire   [3:0]        da_offset;
  wire   [4:0]        ethtype_1_offset;
  reg    [4:0]        ethtype_2_offset;
  wire   [4:0]        snap_1_offset;
  reg    [4:0]        snap_2_offset;
  wire   [15:0]       ethtype_1;
  wire   [15:0]       ethtype_1_r;
  wire   [47:0]       snap_1;
  wire   [47:0]       snap_1_r;
  wire   [15:0]       ethtype_2;
  wire   [31:0]       snap_2;
  wire   [15:0]       ethertype;
  wire   [15:0]       ethertype_c;
  wire   [47:0]       mac_dest_addr_c;
  wire                mac_dest_addr_stb_c;
  wire   [47:0]       mac_src_addr_c;
  wire                mac_src_addr_stb_c;
  wire   [31:0]       vlan_tag1;
  reg                 vlan_tag1_stb;
  wire   [31:0]       vlan_tag2;
  reg                 vlan_tag2_stb;
  wire                ethertype_stb_c;
  reg                 ethertype_stb_r;
  reg                 ethertype_stb;
  reg    [5:0]        ethertype_offst; // 2 bytes before l3_hdr_offst
  reg    [5:0]        l3_hdr_offst;    // Byte offset of L3
  wire                ipv4_ethertype_detected;
  wire   [3:0]        ip_version;
  wire                ipv4_frame_detected;
  wire                ipv6_frame_detected;
  wire                ipv6_ethertype_detected;
  wire   [3:0]        ipv4_hdr_length;
  wire   [15:0]       ip_hdr_first2bytes;
  wire                ipv4_hdr_length_vld;
  wire   [6:0]        ipv4_csum_offset;
  wire   [7:0]        ipv4_protocol;
  reg    [15:0]       end_of_ip_hdr_offset;
  reg    [15:0]       l4_hdr_offst;
  reg    [15:0]       pld_offst;
  reg    [12:0]       next_ext_hdr_offset_c;
  wire    [11:0]       next_ext_hdr_offset_c_aux1;
  wire    [11:0]       next_ext_hdr_offset_c_aux2;
  reg    [11:0]       next_ext_hdr_offset;
  reg    [3:0]        next_ext_hdr_offset_d1;
  reg    [3:0]        next_ext_hdr_offset_mux;
  reg                 use_segment_d1;
  reg                 use_segment_d1_c;
  reg    [6:0]        start_of_ip_srcadd_offset;
  reg    [6:0]        end_of_ip_srcadd_offset;
  wire   [16:0]       udp_destport_offset;
  wire   [15:0]       ip_payload_len;
  wire                first_nxt_hdr_vld_c;
  reg                 first_nxt_hdr_vld;
  wire   [7:0]        first_nxt_hdr;
  wire   [7:0]        exthdr_nxt_hdr_c;
  wire   [7:0]        exthdr_nxt_hdr_2_c;
  wire                exthdr_nxt_hdr_vld_c;
  reg                 no_more_ext_hdrs;
  reg                 no_more_ext_hdrs_c;
  reg    [1:0]        ipv6_ext_hdr_state;
  reg    [1:0]        ipv6_ext_hdr_state_nxt;
  wire                exthdr_len_vld_c;
  wire                exthdr_len_vld_2_c;
  wire   [7:0]        exthdr_len_c;
  wire   [7:0]        exthdr_len_2_c;
  reg    [15:0]       exthdr_len_tot_nxt;
  reg    [14:0]       exthdr_len_tot;
  wire                start_route_ext_hdr;
  reg    [7:0]        segments_left_c;
  reg    [7:0]        segments_left_r;
  reg    [7:0]        segments_left;
  reg                 segments_left_done;
  reg                 have_udp;
  reg                 have_udp_c;
  reg                 have_tcp;
  reg                 have_tcp_c;
  reg                 have_frag;
  reg                 have_frag_c;
  reg                 have_route;
  reg                 have_route_c;
  reg                 is_route;
  reg                 is_route_c;
  wire   [15:0]       end_of_tcpudp_pld_offset;
  reg    [15:0]       tcp_length;
  reg    [15:0]       start_of_ip_destadd_offset;
  reg    [15:0]       end_of_ip_destadd_offset;
  reg    [14:0]       start_of_final_dest_add;
  reg    [14:0]       end_of_final_dest_add;

  wire   [15:0]       udp_destport;
  wire   [127:0]      ip_dest_add;
  wire   [127:0]      ip_dest_add_extr;
  wire   [7:0]        ptp_msg_type_pad;
  wire   [3:0]        ptp_msg_type;
  wire   [15:0]       ptp_ver_offset;
  wire   [7:0]        ptp_version_pad;
  wire   [1:0]        ptp_version;
  wire   [16:0]       ptp_seqid_offset;
  wire   [15:0]       ptp_seqid;
  wire   [16:0]       ptp_ctlv1_offset;
  wire   [7:0]        ptp_ctlv1;
  wire                ptp_ctlv1_vld;
  reg    [15:0]       ptp_timestamp_offset;
  reg    [6:0]        ip_src_add_offset;
  reg    [6:0]        ip_dest_add_offset;
  reg                 ptp_general_msg_c;
  reg                 ptp_general_msg;
  reg                 ptp_event_msg_c;
  reg                 ptp_event_msg;
  reg                 ptp_sync_msg_c;
  reg                 ptp_sync_msg_d1;
  reg                 ptp_dreq_msg_c;
  reg                 ptp_dreq_msg_d1;
  reg                 ptp_dresp_msg_c;
  reg                 ptp_dresp_msg_d1;
  reg                 ptp_pdreq_msg_c;
  reg                 ptp_pdreq_msg_d1;
  reg                 ptp_pdresp_msg_c;
  reg                 ptp_pdresp_msg_d1;
  reg                 ptp_follow_msg_c;
  reg                 ptp_follow_msg_d1;
  reg                 decode_out_vld_r;
  wire                decode_out_vld;
  reg                 ipv4_decodes_vld_r;
  reg                 ipv4_decodes_vld_done;
  wire                ipv4_decodes_vld;
  reg    [5:0]        l3_hdr_offset_m1;
  wire   [15:0]       num_bytes_in_stripe;
  reg    [2:0]        tcp_status;         // Error status for TCP
  wire                ptp_msg_type_vld;
  reg                 ip_da_stb;
  wire                ip_da_stb_c;
  reg                 ip_sa_stb;
  wire                ip_sa_stb_c;
  wire   [31:0]       scr2_compare_match_glob;
  wire    [8:0]       scr2_ethtype_match_glob;
  reg                 ptp_all_dest_match;
  reg                 ptp_allmpeer_dest_match;
  wire   [7:0]        ipv4_tos;
  wire   [7:0]        ipv6_tc;

  parameter WAITING_FOR_FIRST_NXT_HDR   = 2'b00;
  parameter WAITING_FOR_EXTHDR_NXT_HDR  = 2'b01;
  parameter WAITING_FOR_END_OF_FRAME    = 2'b10;

  parameter NO_ERROR        = 3'h0;
  parameter VLAN_HDR_ERROR  = 3'h1;
  parameter SNAP_HDR_ERROR  = 3'h2;
  parameter IP_HDR_ERROR    = 3'h3;
  parameter UNKNOWN_TYPE    = 3'h4;
  parameter PKT_FRAGMENTED  = 3'h5;
  parameter IPV4_ONLY       = 3'h6;
  parameter PREMATURE_EOP   = 3'h7;

  assign num_bytes_in_stripe = dma_bus_width == 2'b00 ? 16'd4 :
                               dma_bus_width == 2'b01 ? 16'd8 :
                                                        16'd16;

  always @(*)
  begin
    if (sop & ~valid)
      running_byte_count_nxt_c  = 17'h00000;
    else if (valid & (sop | (|running_byte_count)))
      running_byte_count_nxt_c  = (running_byte_count & {16{~sop}}) + num_bytes_in_stripe;
    else
      running_byte_count_nxt_c  = {1'b0,running_byte_count};
  end
  assign running_byte_count_nxt = running_byte_count_nxt_c[15:0];

  always @(posedge host_clk or negedge host_rst_n)
  begin
    if (~host_rst_n)
      running_byte_count  <= 16'h0000;
    else if (~soft_enable)
      running_byte_count  <= 16'h0000;
    else
      running_byte_count  <= running_byte_count_nxt[15:0];
  end


  // Extract the MAC source address
  // set offset for src address
  assign sa_offset = disable_preamble ? 4'd14 : 4'd6;
 edma_field_decode #( .field_size(16'd6),.field_size_words(13'd1),.p_always_on_one_stripe(1'b0),.p_register_output(1'b0)) i_mac_src_add_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (1'b0),
    .field_offset           ({12'h000,sa_offset}),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  (),
    .field_valid            (),
    .field_c                (mac_src_addr_c),
    .field_valid_c          (mac_src_addr_stb_c)
  );

  // Extract the MAC destination address
  // set offset for dest address
  assign da_offset = disable_preamble ? 4'd8 : 4'd0;
  edma_field_decode #( .field_size(16'd6),.field_size_words(13'd1),.p_always_on_one_stripe(1'b0),.p_register_output(1'b0)) i_mac_dest_add_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (1'b0),
    .field_offset           ({12'h000,da_offset}),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  (),
    .field_valid            (),
    .field_c                (mac_dest_addr_c),
    .field_valid_c          (mac_dest_addr_stb_c)
  );
  always @(posedge host_clk or negedge host_rst_n)
  begin
    if (~host_rst_n)
    begin
      ptp_all_dest_match      <= 1'b0;
      ptp_allmpeer_dest_match <= 1'b0;
    end
    else
    begin
      if (mac_dest_addr_stb_c && valid)
      begin
        // MAC dest addr match for all messages
        ptp_all_dest_match <=
                        {mac_dest_addr_c[7:0],
                         mac_dest_addr_c[15:8],
                         mac_dest_addr_c[23:16],
                         mac_dest_addr_c[31:24],
                         mac_dest_addr_c[39:32],
                         mac_dest_addr_c[47:40]} == 48'h0180c200000e;

        // MAC dest addr match, for all messages except peer delay mechanism messages
        ptp_allmpeer_dest_match <=
                        {mac_dest_addr_c[7:0],
                         mac_dest_addr_c[15:8],
                         mac_dest_addr_c[23:16],
                         mac_dest_addr_c[31:24],
                         mac_dest_addr_c[39:32],
                         mac_dest_addr_c[47:40]} == 48'h011b19000000;
      end
    end
  end

  // Extract the First Ethertype value - fixed offset of 12
  wire   ethtype_1_vld_r;
  wire   snap_1_vld_r;
  wire   vlan_indicator_0;
  reg    vlan_indicator_0_r;
  wire   qinq_indicator_0;
  reg    qinq_indicator_0_r;
  wire   snap_indicator_0e;
  wire   snap_indicator_0;
  reg    snap_indicator_0_r;
  reg    snap_indicator_0e_r;
  wire   pppoe_indicator_0;
  reg    pppoe_indicator_0_r;
  wire   invalid_vlan_0;
  reg    invalid_vlan_0_r;
  wire   invalid_snap_0;
  reg    invalid_snap_0_r;
  wire   ethtype_1_stb_c;
  wire   snap_1_stb_c;
  assign ethtype_1_offset = disable_preamble ? 5'd20 : 5'd12;

  edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b1),.p_register_output(1'b0)) i_eth_type_1_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (1'b0),
    .field_offset           ({11'd0,ethtype_1_offset}),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  ({ethtype_1_r[7:0],ethtype_1_r[15:8]}),
    .field_valid            (ethtype_1_vld_r),
    .field_c                ({ethtype_1[7:0],ethtype_1[15:8]}),
    .field_valid_c          (ethtype_1_stb_c)
  );

  assign snap_1_offset = disable_preamble ? 5'd22 : 5'd14;

  edma_field_decode #( .field_size(16'd6),.p_always_on_one_stripe(1'b0),.p_register_output(1'b0)) i_snap_1_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (1'b0),
    .field_offset           ({11'd0,snap_1_offset}),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  ({snap_1_r[39:32],snap_1_r[47:40],snap_1_r[23:16],snap_1_r[31:24],snap_1_r[7:0],snap_1_r[15:8]}),
    .field_valid            (snap_1_vld_r),
    .field_c                ({snap_1[39:32],snap_1[47:40],snap_1[23:16],snap_1[31:24],snap_1[7:0],snap_1[15:8]}),
    .field_valid_c          (snap_1_stb_c)
  );

  always @(posedge host_clk or negedge host_rst_n)
  begin
    if (~host_rst_n)
    begin
      vlan_indicator_0_r      <= 1'b0;
      qinq_indicator_0_r      <= 1'b0;
      snap_indicator_0e_r     <= 1'b0;
      snap_indicator_0_r      <= 1'b0;
      invalid_vlan_0_r        <= 1'b0;
      invalid_snap_0_r        <= 1'b0;
      pppoe_indicator_0_r     <= 1'b0;
    end
    else
    begin
      if (ethtype_1_stb_c && valid)
      begin
        vlan_indicator_0_r    <= ethtype_1 == 16'h8100;
        qinq_indicator_0_r    <= ethtype_1 == svlan_type[15:0] && svlan_type[16];
        snap_indicator_0e_r   <= ethtype_1 <= 16'h05dc;
        pppoe_indicator_0_r   <= ethtype_1 == 16'h8864;
      end
      if (snap_1_stb_c && valid)
      begin
        invalid_vlan_0_r      <= snap_1[12];
        snap_indicator_0_r    <= snap_indicator_0e && snap_1[15:0]  == 16'haaaa && snap_1[31:16] == 16'h0300 && snap_1[47:32] == 16'h0000;
        invalid_snap_0_r      <= snap_indicator_0e && snap_1[15:0]  == 16'haaaa && (snap_1[31:16] != 16'h0300 || snap_1[47:32] != 16'h0000);
      end
    end
  end
  assign vlan_indicator_0  = ethtype_1_stb_c ? (ethtype_1 == 16'h8100 && valid)                                                                                     : vlan_indicator_0_r;
  assign qinq_indicator_0  = ethtype_1_stb_c ? (ethtype_1 == svlan_type[15:0] && svlan_type[16] && valid)                                                           : qinq_indicator_0_r;
  assign snap_indicator_0e = ethtype_1_stb_c ? (ethtype_1 <= 16'h05dc && valid)                                                                                     : snap_indicator_0e_r;
  assign snap_indicator_0  = snap_1_stb_c    ? (snap_indicator_0e && snap_1[15:0]  == 16'haaaa && snap_1[31:16] == 16'h0300 && snap_1[47:32] == 16'h0000   && valid): snap_indicator_0e && snap_indicator_0_r;
  assign invalid_snap_0    = snap_1_stb_c    ? (snap_indicator_0e && snap_1[15:0]  == 16'haaaa && (snap_1[31:16] != 16'h0300 || snap_1[47:32] != 16'h0000) && valid): snap_indicator_0e && invalid_snap_0_r;
  assign pppoe_indicator_0 = ethtype_1_stb_c ? (ethtype_1 == 16'h8864 && valid)                                                                                     : pppoe_indicator_0_r;
  assign invalid_vlan_0    = snap_1_stb_c    ? (snap_1[12] && valid)                                                                                                : invalid_vlan_0_r;  // CFI bit must be low for valid VLAN

  assign vlan_tag1      = {ethtype_1_r,snap_1_r[15:0]};
  assign vlan_tag2      = {snap_1_r[31:16],snap_1_r[47:32]};

  always @(posedge host_clk or negedge host_rst_n)
  begin
    if (~host_rst_n)
    begin
      vlan_tag1_stb  <= 1'b0;
      vlan_tag2_stb  <= 1'b0;
    end
    else
    begin
      vlan_tag1_stb  <= (qinq_indicator_0 | vlan_indicator_0) & ~ethtype_1_vld_r;
      vlan_tag2_stb  <= snap_1[31:16] == 16'h8100 & ~snap_1_vld_r;
    end
  end

  // If there was a single VLAN, then real ethertype to look at for L3
  // decoding will be fixed offset of 16
  // If there was a single QinQ, then real ethertype to look at for L3
  // decoding will be fixed offset of 20
  // If there was a SNAP+VLAN, then real ethertype to look at for L3
  // decoding will be fixed offset of 24
  // If there was a SNAP+QinQ, then real ethertype to look at for L3
  // decoding will be fixed offset of 24

  // Determine if there was a VLAN/QinQ and look for SNAP
  always @(*)
  begin
    casex ({disable_preamble,vlan_indicator_0,qinq_indicator_0})
      3'b11x  :begin ethtype_2_offset = 5'd24; snap_2_offset = 5'd26;end
      3'b001  :begin ethtype_2_offset = 5'd20; snap_2_offset = 5'd22;end
      3'b101  :begin ethtype_2_offset = 5'd28; snap_2_offset = 5'd30;end
      default :begin ethtype_2_offset = 5'd16; snap_2_offset = 5'd18;end
    endcase
  end

  wire ethtype_2_vld_r;
  wire snap_indicator_2e;
  wire snap_indicator_2;
  wire pppoe_indicator_2;
  wire ethtype_2_stb_c;
  wire invalid_snap_2;
  wire snap_2_stb_c;
  reg  snap_indicator_2_r;
  reg  snap_indicator_2e_r;
  reg  pppoe_indicator_2_r;
  reg  invalid_snap_2_r;

  edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b1),.p_register_output(1'b0)) i_eth_type_2_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (sop),
    .field_offset           ({11'd0,ethtype_2_offset}),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  (),
    .field_valid            (ethtype_2_vld_r),
    .field_c                ({ethtype_2[7:0],ethtype_2[15:8]}),
    .field_valid_c          (ethtype_2_stb_c)
  );

  edma_field_decode #( .field_size(16'd4),.field_size_words(13'd1),.p_always_on_one_stripe(1'b0)) i_snap_2_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (sop),
    .field_offset           ({11'd0,snap_2_offset}),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  (),
    .field_valid            (),
    .field_c                ({snap_2[23:16],snap_2[31:24],snap_2[7:0],snap_2[15:8]}),
    .field_valid_c          (snap_2_stb_c)
  );
  always @(posedge host_clk or negedge host_rst_n)
  begin
    if (~host_rst_n)
    begin
      snap_indicator_2e_r     <= 1'b0;
      snap_indicator_2_r      <= 1'b0;
      invalid_snap_2_r        <= 1'b0;
      pppoe_indicator_2_r     <= 1'b0;
    end
    else
    begin
      if (ethtype_2_stb_c && valid)
      begin
        snap_indicator_2e_r   <= ethtype_2 <= 16'h05dc;
        pppoe_indicator_2_r   <= ethtype_2 == 16'h8864;
      end
      if (snap_2_stb_c && valid)
      begin
        snap_indicator_2_r    <= snap_indicator_2e && snap_2[15:0]  == 16'haaaa && snap_2[31:16] == 16'h0300;
        invalid_snap_2_r      <= snap_indicator_2e && snap_2[15:0]  == 16'haaaa && snap_2[31:16] != 16'h0300;
      end
    end
  end
  assign snap_indicator_2e = ethtype_2_stb_c ? (ethtype_2 <= 16'h05dc && valid)                                                         : snap_indicator_2e_r;
  assign snap_indicator_2  = ethtype_2_stb_c ? (snap_indicator_2e && snap_2[15:0]  == 16'haaaa &&  snap_2[31:16] == 16'h0300 && valid)  : snap_indicator_2e && snap_indicator_2_r;
  assign pppoe_indicator_2 = ethtype_2_stb_c ? (ethtype_2 == 16'h8864 && valid)                                                         : pppoe_indicator_2_r;
  assign invalid_snap_2    = snap_2_stb_c    ? (snap_2[15:0]  == 16'haaaa && snap_2[31:16] != 16'h0300 && valid)                        : snap_indicator_2e && invalid_snap_2_r;


  wire pppoe_indicator;
  wire snap_indicator;
  wire invalid_snap;

  assign pppoe_indicator   = pppoe_indicator_0 || ((vlan_indicator_0 || qinq_indicator_0) && pppoe_indicator_2);
  assign snap_indicator    = snap_indicator_0  || ((vlan_indicator_0 || qinq_indicator_0) && snap_indicator_2);
  assign invalid_snap      = invalid_snap_0    || ((vlan_indicator_0 || qinq_indicator_0) && invalid_snap_2);

  always @(*)
  begin
    casex ({disable_preamble,vlan_indicator_0,qinq_indicator_0,(snap_indicator|pppoe_indicator)})
      // no PPPoE/SNAP. with/without VLAN
      4'b01x0  : begin ethertype_offst = 6'd16; l3_hdr_offst = 6'd18; end
      4'b0010  : begin ethertype_offst = 6'd20; l3_hdr_offst = 6'd22; end
      4'b11x0  : begin ethertype_offst = 6'd24; l3_hdr_offst = 6'd26; end
      4'b1010  : begin ethertype_offst = 6'd28; l3_hdr_offst = 6'd30; end

      // SNAP/PPPoE with/without VLAN
      4'b0001  : begin ethertype_offst = 6'd20; l3_hdr_offst = 6'd22; end
      4'b01x1  : begin ethertype_offst = 6'd24; l3_hdr_offst = 6'd26; end
      4'b0011  : begin ethertype_offst = 6'd28; l3_hdr_offst = 6'd30; end
      4'b1001  : begin ethertype_offst = 6'd28; l3_hdr_offst = 6'd30; end
      4'b11x1  : begin ethertype_offst = 6'd32; l3_hdr_offst = 6'd34; end
      4'b1011  : begin ethertype_offst = 6'd36; l3_hdr_offst = 6'd38; end

      // No VLAN, SNAP or PPPoE
      4'b1000  : begin ethertype_offst = 6'd20; l3_hdr_offst = 6'd22; end
      default  : begin ethertype_offst = 6'd12; l3_hdr_offst = 6'd14; end
    endcase
  end

  wire extracting_ethertype;
  wire ipv4_ethertype_detected_c;

  // First determine if the frame has an IP header ...
  // Do this by examining the ethertype ...
  // ethertype_offst points to the last type field in the L2 header (i.e. the one
  // that indicates what L3 header there is
  // We know the bit offset of the first byte of the ethertype - as indicated by ethertype_boffset
  edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b1))  i_ethertype_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (1'b0),
    .field_offset           ({10'd0,ethertype_offst}),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  ({ethertype[7:0],ethertype[15:8]}),
    .field_valid            (extracting_ethertype),
    .field_c                ({ethertype_c[7:0],ethertype_c[15:8]}),
    .field_valid_c          (ethertype_stb_c)
  );
  always @(posedge host_clk or negedge host_rst_n)
  begin
    if (~host_rst_n)
    begin
      ethertype_stb_r <= 1'b0;
      ethertype_stb <= 1'b0;
    end
    else
    begin
      ethertype_stb_r <= ethertype_stb_c & ~ethertype_stb_r;// This smoothes out any repeating ethertype as a result of snap or qinq
      ethertype_stb <= ethertype_stb_r;
    end
  end

  assign ptpoe_type_detected_c      = ethertype_c == 16'h88f7;
  assign ptpoe_type_detected        = ethertype == 16'h88f7;
  assign snap_hdr_detected          = snap_indicator;
  assign ipv4_ethertype_detected_c  = pppoe_indicator ? ethertype_c == 16'h0021 : ethertype_c == 16'h0800;
  assign ipv4_ethertype_detected    = pppoe_indicator ? ethertype == 16'h0021   : ethertype == 16'h0800;
  assign ipv6_ethertype_detected    = pppoe_indicator ? ethertype == 16'h0057   : ethertype == 16'h86dd;
  assign ipv4_frame_detected        = ipv4_ethertype_detected & ip_version == 4'h4 & ipv4_hdr_length > 4'h4;
  assign ipv6_frame_detected        = ipv6_ethertype_detected;

  // Once the ethertype is extracted, we can determine if the frame
  // has an IPv4 or IPv6 header
  always @(posedge host_clk or negedge host_rst_n)
  begin
    if  (~host_rst_n)
    begin
      ipv4_decodes_vld_r      <= 1'b0;
      ipv4_decodes_vld_done   <= 1'b0;
    end
    else
    begin
      if (~soft_enable)
      begin
        ipv4_decodes_vld_done  <= 1'b0;
        ipv4_decodes_vld_r     <= 1'b0;
      end
      else if (extracting_ethertype & ~eop)
      begin
        ipv4_decodes_vld_done  <= 1'b1;
        ipv4_decodes_vld_r     <= 1'b1;
      end
      else if (valid)
      begin
        if (eop)
          ipv4_decodes_vld_done  <= 1'b0;
        ipv4_decodes_vld_r     <= 1'b0;
      end
    end
  end
  assign ipv4_decodes_vld = (ipv4_decodes_vld_r | (~ipv4_decodes_vld_done & eop)) & valid;

  // For IPv4, there is a header length that can be extracted from the frame in bits 7:4 on byte 0
  // of the IPv4 header
  // Extract the IPv4 header length, used to calculate the offset to the end of the IPv4 header
  edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b1))  i_ipv4_hdr_len_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (1'b0),
    .field_offset           ({10'd0,l3_hdr_offst}),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  (ip_hdr_first2bytes),
    .field_valid            (ipv4_hdr_length_vld),
    .field_c                (),
    .field_valid_c          ()
  );
  assign ipv4_hdr_length = ip_hdr_first2bytes[3:0];
  assign ip_version = ip_hdr_first2bytes[7:4];

generate if (include_screeners == 1 && p_num_type1_screeners > 0) begin : gen_scrn_tos_extract
  assign ipv4_tos = ip_hdr_first2bytes[15:8] & {8{ipv4_frame_detected}};
  assign ipv6_tc = {ip_hdr_first2bytes[3:0],ip_hdr_first2bytes[15:12]} & {8{ipv6_frame_detected}};
end
endgenerate

  // For IPv6, there is no hdr length field, but there is a payload length.  If there are no
  // extension headers, then the IPv6 header length is just 40 bytes, and end of header is
  // l3_hdr_offset + 40. If there are extension headers, then we need to determine the total
  // length of all extension headers, then add that to (l3_hdr_offset + 40)
  // ipv4_hdr_length_c
  // To do that, we first need to extract the payload length from the IPv6 header -
  // actually there is a payload length in IPv4 headers also - ipv4_hdr_length_vld
  // Extract them both and store in ip_payload_len

  // Extract the ipv4 total_length field - exists at bits 31:16 of the IPv4 header
  // Extract the ipv6 total_length field - exists at bits 47:32 of the IPv6 header
  wire [6:0] l3_hdr_offst_p2;
  wire [6:0] l3_hdr_offst_p4;
  reg  [6:0] ip_total_length_offset;
  assign l3_hdr_offst_p2 = l3_hdr_offst + 6'd2;
  assign l3_hdr_offst_p4 = l3_hdr_offst + 6'd4;
  always @(*)
    if (ipv4_ethertype_detected_c)
      ip_total_length_offset = l3_hdr_offst_p2;
    else
      ip_total_length_offset = l3_hdr_offst_p4;

  edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b1))  i_ip_payload_length_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (1'b0),
    .field_offset           ({9'd0,ip_total_length_offset}),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  ({ip_payload_len[7:0],ip_payload_len[15:8]}),
    .field_valid            (),
    .field_c                (),
    .field_valid_c          ()
  );
  always@(*)
  begin
    if (ipv6_frame_detected)
      tcp_length = ip_payload_len - exthdr_len_tot;
    else
      tcp_length = ip_payload_len - {ipv4_hdr_length,2'b00};
  end
  assign end_of_tcpudp_pld_offset = l4_hdr_offst + tcp_length - 16'h0001;

  wire [16:0] l4_hdr_offst_p16;
  wire [16:0] l4_hdr_offst_p6;
  reg  [16:0] tcp_csum_offset_pad;
  assign l4_hdr_offst_p16 = l4_hdr_offst + 16'd16;
  assign l4_hdr_offst_p6 = l4_hdr_offst + 16'd6;
  always @(*)
    if (have_tcp_c)
      tcp_csum_offset_pad = l4_hdr_offst_p16;
    else
      tcp_csum_offset_pad = l4_hdr_offst_p6;

  assign tcp_csum_offset = tcp_csum_offset_pad[15:0];

  // Extract the checksum field and check if it is zero or not
  wire  [15:0] rx_csum;
  edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b0))  i_tcp_udp_csum_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (1'b0),
    .field_offset           (tcp_csum_offset),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  ({rx_csum[7:0],rx_csum[15:8]}),
    .field_valid            (),
    .field_c                (),
    .field_valid_c          ()
  );
  assign rx_csum_zero = rx_csum == 16'h0000;

  // Extract the ipv4 fragment and IP flags field - exists at bits 63:46 of the IPv4 header
  wire [6:0] ipv4_fragment_offset;
  assign ipv4_fragment_offset = (l3_hdr_offst + 6'd6);
  wire  [15:0] ipv4_fragment_field;
  edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b1))  i_ipv4_fragment_field_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (1'b0),
    .field_offset           ({9'd0,ipv4_fragment_offset}),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  ({ipv4_fragment_field[7:0],ipv4_fragment_field[15:8]}),
    .field_valid            (),
    .field_c                (),
    .field_valid_c          ()
  );

  // Extract the ipv4 protocol field - exists at bits 79:72 of the IPv4 header
  wire [6:0] ipv4_protocol_offset;
  assign ipv4_protocol_offset = (l3_hdr_offst + 6'd9);
  edma_field_decode #( .field_size(16'd1),.p_always_on_one_stripe(1'b1))  i_ipv4_protocol_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (1'b0),
    .field_offset           ({9'd0,ipv4_protocol_offset}),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  (ipv4_protocol),
    .field_valid            (),
    .field_c                (),
    .field_valid_c          ()
  );

  assign ipv4_csum_offset = (l3_hdr_offst + 6'd10);


  // Then extract the first next hdr field from the IPv6 frame. If it is not a valid extension header
  // then assume there are no extension headers ...
  wire [6:0] ipv6_first_nxt_hdr_offset;
  assign ipv6_first_nxt_hdr_offset = (l3_hdr_offst + 6'd6);
  edma_field_decode #( .field_size(16'd1),.p_always_on_one_stripe(1'b1))  i_ipv6_1st_nxt_hdr_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (eop),
    .field_offset           ({9'd0,ipv6_first_nxt_hdr_offset}),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  (first_nxt_hdr),
    .field_valid            (),
    .field_c                (),
    .field_valid_c          (first_nxt_hdr_vld_c)
  );

  always @(posedge host_clk or negedge host_rst_n)
  begin
    if  (~host_rst_n)
      first_nxt_hdr_vld <= 1'b0;
    else if (valid)
      first_nxt_hdr_vld <= first_nxt_hdr_vld_c;
  end


  always @(*)
  begin
    if (ipv4_hdr_length_vld & ipv4_ethertype_detected)
    begin
      // The end of IP header is calculated by adding the IP header length as
      // extracted from the frame with the l3 hdr offset.
      begin
        end_of_ip_hdr_offset  = ({10'd0,ipv4_hdr_length,2'h0} + {10'd0,l3_hdr_offset_m1}); // Pad to 16 bit
        l4_hdr_offst          = ({10'd0,ipv4_hdr_length,2'h0} + {10'd0,l3_hdr_offst}); // Pad to 16 bit
      end
    end
    else if (ipv6_frame_detected & (no_more_ext_hdrs_c | no_more_ext_hdrs))
    begin
      end_of_ip_hdr_offset  = {4'h0,(next_ext_hdr_offset_c[11:0] - 12'd1)};
      l4_hdr_offst          = {4'h0,next_ext_hdr_offset_c[11:0]};
    end
    else
    begin
      end_of_ip_hdr_offset  = 16'hffff;
      l4_hdr_offst          = 16'hffff;
    end
  end

  always @(*)
  begin
    if (ipv4_ethertype_detected_c)
      start_of_ip_srcadd_offset   = l3_hdr_offst + 6'd12;   // Start of Source Address
    else
      start_of_ip_srcadd_offset   = l3_hdr_offst + 6'd8;

    if (ipv4_ethertype_detected)
      end_of_ip_srcadd_offset   = l3_hdr_offst + 6'd15;   // End of Source Address
    else
      end_of_ip_srcadd_offset   = l3_hdr_offst + 6'd23;
  end

  always @(posedge host_clk or negedge host_rst_n)
  begin
    if  (~host_rst_n)
    begin
      no_more_ext_hdrs      <= 1'b0;
      l3_hdr_offset_m1      <= 6'h3f;
    end
    else
    begin
      if (~soft_enable)
      begin
        l3_hdr_offset_m1    <= 6'h3f;
        no_more_ext_hdrs    <= 1'b0;
     end
      else if (sop & valid)
      begin
        l3_hdr_offset_m1    <= 6'h3f;
        no_more_ext_hdrs    <= 1'b0;
      end
      else
      begin
        if (valid)
          no_more_ext_hdrs  <= no_more_ext_hdrs_c;

        if (valid)
        begin
          // Following signals are implemented to try reduce some timing paths
          l3_hdr_offset_m1  <= l3_hdr_offst - 6'h01; // l3_hdr_offset is guaranteed to be >0 if there is an L3 hdr so no need for underflow protection
          // No overflow protection here.  Resultant signals are only used if l3_hdr_offst[8] is 0
        end
      end
    end
  end

  // Decide if there any supported extension hdrs ...
  // Hop by hop = 0x00
  // Routing = 0x2b
  // Destination = 0x3c
  // Fragment = 0x2c
  //
  // Extract the subsequent next hdr field from the extension headers in the IPv6 frame
  wire [15:0] exthdr_nxt_hdr_pad_c;
  edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b1))  i_ipv6_nxt_hdr_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (eop),
    .field_offset           ({4'd0,next_ext_hdr_offset} | {16{no_more_ext_hdrs}}),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  (),
    .field_valid            (),
    .field_c                (exthdr_nxt_hdr_pad_c),
    .field_valid_c          (exthdr_nxt_hdr_vld_c)
  );
  assign exthdr_nxt_hdr_c = exthdr_nxt_hdr_pad_c[7:0];
  assign exthdr_len_c     = exthdr_nxt_hdr_pad_c[15:8];
  assign exthdr_len_vld_c = exthdr_nxt_hdr_vld_c;

// In 128 bit modes, it is possible you might get a second ext hdr in the same stripe,
// if the length of the first is only 64 bits!
  wire [15:0] exthdr_nxt_hdr_pad_2_c;
  wire [12:0] next_ext_hdr_offset_2;
  wire        exthdr_nxt_hdr_vld_2_c;
  wire        ptp_version_vld;
  assign next_ext_hdr_offset_2 = next_ext_hdr_offset + 12'h008;
  edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b1))  i_ipv6_nxt_hdr_2_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (eop),
    .field_offset           ({4'd0,next_ext_hdr_offset_2[11:0]} | {16{no_more_ext_hdrs}}),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  (),
    .field_valid            (),
    .field_c                (exthdr_nxt_hdr_pad_2_c),
    .field_valid_c          (exthdr_nxt_hdr_vld_2_c)
  );
  assign exthdr_nxt_hdr_2_c = exthdr_nxt_hdr_pad_2_c[7:0];
  assign exthdr_len_2_c     = exthdr_nxt_hdr_pad_2_c[15:8];
  assign exthdr_len_vld_2_c = exthdr_nxt_hdr_vld_2_c &
                              exthdr_len_c == 8'h00 &
                              exthdr_nxt_hdr_c != 8'h06 &
                              exthdr_nxt_hdr_c != 8'h11;

  // start_route_ext_hdr is an indication that the routing header is starting on this stripe
  assign start_route_ext_hdr = (is_route_c & ~is_route & exthdr_nxt_hdr_vld_c);

  // Decide when the segments left field will be on the stripe following the start of the extension header
  // which is indicated by next_ext_hdr_offset.
  // This occurs when the extension header itself started close to the end of the stripe (2 bytes or less)
  always @(*)
  begin
    if (exthdr_len_vld_2_c & exthdr_nxt_hdr_c == 8'h2b) // when 2 extension headers are on the same stripe, and 2nd is the routing - can only occur in 128bit mode
      use_segment_d1_c  =  (|next_ext_hdr_offset_2[1:0] & (&next_ext_hdr_offset_2[3:2]));
    else
      use_segment_d1_c  =  dma_bus_width == 2'b00 ? |next_ext_hdr_offset[1:0] :
                           dma_bus_width == 2'b01 ? (|next_ext_hdr_offset[1:0] & next_ext_hdr_offset[2]) :
                                                    (|next_ext_hdr_offset[1:0] & (&next_ext_hdr_offset[3:2]));
  end

  // next_ext_hdr_offset_mux shows the offset thhat the segments left field is located at.
  // If segments left was not on the same cycle as the start of the extension header, then thi mux
  // will use a delayed version of both
  always @(*)
  begin
    if (use_segment_d1)
      next_ext_hdr_offset_mux = next_ext_hdr_offset_d1;
    else if (exthdr_len_vld_2_c & exthdr_nxt_hdr_c == 8'h2b)
      next_ext_hdr_offset_mux = next_ext_hdr_offset_2[3:0];
    else
      next_ext_hdr_offset_mux = next_ext_hdr_offset[3:0];
  end

  // Use the offset information to extract the segments left field
  always @(*)
  begin
    casex ({dma_bus_width,next_ext_hdr_offset_mux[3:0]})
      6'b00_xx00 : segments_left_c = data[31:24];
      6'b00_xx01 : segments_left_c = data[7:0];
      6'b00_xx10 : segments_left_c = data[15:8];
      6'b00_xx11 : segments_left_c = data[23:16];

      6'b01_x000 : segments_left_c = data[31:24];
      6'b01_x001 : segments_left_c = data[39:32];
      6'b01_x010 : segments_left_c = data[47:40];
      6'b01_x011 : segments_left_c = data[55:48];
      6'b01_x100 : segments_left_c = data[63:56];
      6'b01_x101 : segments_left_c = data[7:0];
      6'b01_x110 : segments_left_c = data[15:8];
      6'b01_x111 : segments_left_c = data[23:16];

      6'b1x_0000 : segments_left_c = data[31:24];
      6'b1x_0001 : segments_left_c = data[39:32];
      6'b1x_0010 : segments_left_c = data[47:40];
      6'b1x_0011 : segments_left_c = data[55:48];
      6'b1x_0100 : segments_left_c = data[63:56];
      6'b1x_0101 : segments_left_c = data[71:64];
      6'b1x_0110 : segments_left_c = data[79:72];
      6'b1x_0111 : segments_left_c = data[87:80];
      6'b1x_1000 : segments_left_c = data[95:88];
      6'b1x_1001 : segments_left_c = data[103:96];
      6'b1x_1010 : segments_left_c = data[111:104];
      6'b1x_1011 : segments_left_c = data[119:112];
      6'b1x_1100 : segments_left_c = data[127:120];
      6'b1x_1101 : segments_left_c = data[7:0];
      6'b1x_1110 : segments_left_c = data[15:8];
      default    : segments_left_c = data[23:16];
    endcase
  end

  //
  always @(posedge host_clk or negedge host_rst_n)
  begin
    if  (~host_rst_n)
    begin
      segments_left_r <= 8'h00;
      segments_left_done <= 1'b0;
      next_ext_hdr_offset_d1 <= 4'h0;
      use_segment_d1 <= 1'b0;
    end
    else if (sop & valid)
    begin
      segments_left_r <= 8'h00;
      segments_left_done <= 1'b0;
      next_ext_hdr_offset_d1 <= 4'h0;
      use_segment_d1 <= 1'b0;
    end
    else if (valid & start_route_ext_hdr)
    begin
      use_segment_d1          <= use_segment_d1_c;
      if (exthdr_len_vld_2_c & exthdr_nxt_hdr_c == 8'h2b)
        next_ext_hdr_offset_d1  <= next_ext_hdr_offset_2[3:0];
      else
        next_ext_hdr_offset_d1  <= next_ext_hdr_offset[3:0];
      segments_left_done      <= 1'b1;
      if (~use_segment_d1_c)
        segments_left_r       <= segments_left_c;
      else
        segments_left_r       <= 8'h00;
    end
    else if (valid & segments_left_done & use_segment_d1)
    begin
      use_segment_d1          <= 1'b0;
      next_ext_hdr_offset_d1  <= next_ext_hdr_offset_d1;
      segments_left_done      <= 1'b1;
      segments_left_r         <= segments_left_c;
    end
  end

  always @(*)
  begin
    if (start_route_ext_hdr & ~use_segment_d1_c)
      segments_left = segments_left_c;
    else if (is_route & use_segment_d1)
      segments_left = segments_left_c;
    else
      segments_left = segments_left_r;
  end


  // If there is a routing header, then the destination address is, as per RFC ...
  // If the IPv6 packet contains a Routing header, the Destination
  // Address used in the pseudo-header is that of the final
  // destination.  At the originating node, that address will be in
  // the last element of the Routing header; at the recipient(s),
  // that address will be in the Destination Address field of the
  // IPv6 header.
  //
  // The issue we have in the implementation is that we dont know
  // at the point of the actual IP dest address whether there is
  // a routing header, and we also dont know where we are in the
  // ruting table (indicated by segments left). to complicate it
  // further, if there is a routing hdr and there is only
  // 1 element in the routing table, then that could occur only 8
  // bytes after the start of the routing header. With a 64 or 128
  // bit datapath, this means it could occur on the same clock cycle
  // The problem with that is that there would be an awful lot of
  // combinatorial logic to calculate where the start&end offset of the
  // correct destination address to pass to the checksum logic.
  // To get around this, we add a couple of sets of registers, which
  // either hold the value of the destination address  when there is
  // more than 1 entry in the routing table (and therefore is always
  // starting at least 1 clock cycle away from the extension header
  // length field), or by default is always 8 bytes after the start
  // of the routing header start offset (which is known nuch earlier).
  // The following logic is to try and eliminate lint warnings ...
  wire [13:0] ext_hdr_offset_p8;
  wire [13:0] ext_hdr_offset_p23;
  wire [11:0] ext_hdr_offset_m16;
  wire [11:0] ext_hdr_offset_m1;
  assign ext_hdr_offset_p8  = (next_ext_hdr_offset_c + 13'd8);
  assign ext_hdr_offset_p23 = (next_ext_hdr_offset_c + 13'd23);
  assign ext_hdr_offset_m16 = (next_ext_hdr_offset_c - 13'd16);
  assign ext_hdr_offset_m1  = (next_ext_hdr_offset_c - 13'd1);
  always @(posedge host_clk or negedge host_rst_n)
  begin
    if  (~host_rst_n)
    begin
      start_of_final_dest_add <= 15'h0000;
      end_of_final_dest_add <= 15'h0000;
    end
    else
    begin
      // is_route_c indicates we are now in a routing header - combinatorial
      // have_route_c indicates we are not in a routing header, but the next header is routing header
      if (have_route_c & ~is_route_c & valid)
      begin
        start_of_final_dest_add <= {2'h0,ext_hdr_offset_p8[12:0]};
        end_of_final_dest_add <= {2'h0,ext_hdr_offset_p23[12:0]};
      end
      else if (is_route_c & exthdr_len_vld_c & valid)
      begin
        start_of_final_dest_add <= {3'h0,ext_hdr_offset_m16};
        end_of_final_dest_add <= {3'h0,ext_hdr_offset_m1};
      end
    end
  end

  // Using that register, we can then combinatorially set the real
  // offsets either to that register, or if there are no segments left
  // at all, to just use the original IPv6 destination address
  // The following logic is to try and eliminate lint warnings ...
  wire [6:0] l3_hdr_offst_p16;
  wire [6:0] l3_hdr_offst_p19;
  wire [6:0] l3_hdr_offst_p24;
  wire [6:0] l3_hdr_offst_p39;
  assign l3_hdr_offst_p16 = (l3_hdr_offst + 6'd16);
  assign l3_hdr_offst_p19 = (l3_hdr_offst + 6'd19);
  assign l3_hdr_offst_p24 = (l3_hdr_offst + 6'd24);
  assign l3_hdr_offst_p39 = (l3_hdr_offst + 6'd39);
  always @(*)
  begin
    if (ipv4_ethertype_detected)
    begin
      start_of_ip_destadd_offset  = {9'h000,l3_hdr_offst_p16};
      end_of_ip_destadd_offset    = {9'h000,l3_hdr_offst_p19};
    end
    else
    begin
      if ((is_route_c | is_route) & (|segments_left))
      begin
        start_of_ip_destadd_offset  = {1'b0,start_of_final_dest_add};
        end_of_ip_destadd_offset    = {1'b0,end_of_final_dest_add};
      end
      else
      begin
        start_of_ip_destadd_offset  = {9'h000,l3_hdr_offst_p24};
        end_of_ip_destadd_offset    = {9'h000,l3_hdr_offst_p39};
      end
    end
  end


  // Decode the nxt header fields of the IPv6 header
  // Since the base header is 40bytes, we can always use registered versions
  // to decode the first nxt hdr.  This is really important to avoid massive
  // timing paths.
  // Extension headers can be as small as 8 bytes, so we need to take those
  // combinatorially
  always @(*)
  begin
    //
    if (first_nxt_hdr_vld & ipv6_frame_detected)
    begin
      no_more_ext_hdrs_c = ~( first_nxt_hdr == 8'h00 | first_nxt_hdr == 8'h2b |
                              first_nxt_hdr == 8'h2c | first_nxt_hdr == 8'h3c);
      have_tcp_c = first_nxt_hdr == 8'h06;
      have_udp_c = first_nxt_hdr == 8'h11;
      have_frag_c = first_nxt_hdr == 8'h2c;
      have_route_c = first_nxt_hdr == 8'h2b;
      is_route_c = 1'b0;
    end
    else if (exthdr_nxt_hdr_vld_c & ipv6_frame_detected & ~no_more_ext_hdrs)
    begin
      if (exthdr_len_vld_2_c) // 2 ext hdrs on same stripe
      begin
        no_more_ext_hdrs_c = ~( exthdr_nxt_hdr_2_c == 8'h00 | exthdr_nxt_hdr_2_c == 8'h2b |
                                exthdr_nxt_hdr_2_c == 8'h2c | exthdr_nxt_hdr_2_c == 8'h3c);
        have_tcp_c = exthdr_nxt_hdr_2_c == 8'h06;
        have_udp_c = exthdr_nxt_hdr_2_c == 8'h11;
        have_frag_c = (exthdr_nxt_hdr_c == 8'h2c | exthdr_nxt_hdr_2_c == 8'h2c | have_frag);
        have_route_c = (exthdr_nxt_hdr_c == 8'h2b | exthdr_nxt_hdr_2_c == 8'h2b);
        is_route_c = (have_route | exthdr_nxt_hdr_c == 8'h2b);
      end
      else
      begin
        no_more_ext_hdrs_c = ~( exthdr_nxt_hdr_c == 8'h00 | exthdr_nxt_hdr_c == 8'h2b |
                                exthdr_nxt_hdr_c == 8'h2c | exthdr_nxt_hdr_c == 8'h3c);
        have_tcp_c = exthdr_nxt_hdr_c == 8'h06;
        have_udp_c = exthdr_nxt_hdr_c == 8'h11;
        have_frag_c = (exthdr_nxt_hdr_c == 8'h2c | have_frag);
        have_route_c = exthdr_nxt_hdr_c == 8'h2b;
        is_route_c = have_route;
      end
    end
    else if (ipv4_ethertype_detected)
    begin
      no_more_ext_hdrs_c = 1'b1;
      have_tcp_c = ipv4_protocol == 8'h06;
      have_udp_c = ipv4_protocol == 8'h11;
      have_frag_c = ~(ipv4_fragment_field == 16'h0000 | ipv4_fragment_field == 16'h4000);
      have_route_c = 1'b0;
      is_route_c = 1'b0;
    end
    else
    begin
      no_more_ext_hdrs_c = no_more_ext_hdrs;
      have_tcp_c = have_tcp;
      have_udp_c = have_udp;
      have_frag_c = have_frag;
      have_route_c = have_route;
      is_route_c = is_route;
    end
  end

assign next_ext_hdr_offset_c_aux1   = (next_ext_hdr_offset[10:0] + {exthdr_len_2_c,3'b000});
assign next_ext_hdr_offset_c_aux2   = (next_ext_hdr_offset[10:0] + {exthdr_len_c,3'b000});

  always @(*)
  begin
    case (ipv6_ext_hdr_state)
      WAITING_FOR_FIRST_NXT_HDR :
      begin
        exthdr_len_tot_nxt = 16'h0000;
        if (first_nxt_hdr_vld)
        begin
          next_ext_hdr_offset_c[12:7] = 6'd0;
          next_ext_hdr_offset_c[6:0]  = (l3_hdr_offst + 6'd40);
          ipv6_ext_hdr_state_nxt      = WAITING_FOR_EXTHDR_NXT_HDR;
        end
        else
        begin
          next_ext_hdr_offset_c   = 13'h1fff;
          ipv6_ext_hdr_state_nxt  = WAITING_FOR_FIRST_NXT_HDR;
        end
      end

      WAITING_FOR_EXTHDR_NXT_HDR :
      begin
        if (exthdr_len_vld_c)
        begin
          if (exthdr_len_vld_2_c)
          begin
            exthdr_len_tot_nxt = exthdr_len_tot + 14'd16 + {exthdr_len_2_c,3'b000};

            // The length of the ext header is in multiples of 8 octets, and does not include the first 8 octets.

            next_ext_hdr_offset_c       = (next_ext_hdr_offset_c_aux1 + 12'd16);

            if (no_more_ext_hdrs_c | no_more_ext_hdrs)
              ipv6_ext_hdr_state_nxt = WAITING_FOR_END_OF_FRAME;
            else
              ipv6_ext_hdr_state_nxt = ipv6_ext_hdr_state;
          end
          else
          begin
            exthdr_len_tot_nxt = exthdr_len_tot + 14'd8 + {exthdr_len_c,3'b000};

            // The length of the ext header is in multiples of 8 octets, and does not include the first 8 octets.

            next_ext_hdr_offset_c       = (next_ext_hdr_offset_c_aux2 + 12'd8);

            if (no_more_ext_hdrs_c | no_more_ext_hdrs)
              ipv6_ext_hdr_state_nxt = WAITING_FOR_END_OF_FRAME;
            else
              ipv6_ext_hdr_state_nxt = ipv6_ext_hdr_state;
          end
        end
        else
        begin
          ipv6_ext_hdr_state_nxt = ipv6_ext_hdr_state;
          next_ext_hdr_offset_c = {1'b0,next_ext_hdr_offset};
          exthdr_len_tot_nxt = {1'b0,exthdr_len_tot};
        end
      end

      default : // WAITING_FOR_END_OF_FRAME
      begin
        ipv6_ext_hdr_state_nxt = ipv6_ext_hdr_state;
        next_ext_hdr_offset_c = {1'b0,next_ext_hdr_offset};
        exthdr_len_tot_nxt = {1'b0,exthdr_len_tot};
      end
    endcase
  end

  always @(posedge host_clk or negedge host_rst_n)
  begin
    if  (~host_rst_n)
    begin
      ipv6_ext_hdr_state    <= WAITING_FOR_FIRST_NXT_HDR;
      next_ext_hdr_offset   <= 12'hfff;
      exthdr_len_tot        <= 15'd0;
      have_udp              <= 1'b0;
      have_tcp              <= 1'b0;
      have_frag             <= 1'b0;
      have_route            <= 1'b0;
      is_route              <= 1'b0;
    end
    else
    begin
      if (~soft_enable)
      begin
        ipv6_ext_hdr_state    <= WAITING_FOR_FIRST_NXT_HDR;
        next_ext_hdr_offset   <= 12'hfff;
        exthdr_len_tot        <= 15'd0;
        have_udp              <= 1'b0;
        have_tcp              <= 1'b0;
        have_frag             <= 1'b0;
        have_route            <= 1'b0;
        is_route              <= 1'b0;
      end
      else if (sop & valid)
      begin
        ipv6_ext_hdr_state    <= WAITING_FOR_FIRST_NXT_HDR;
        next_ext_hdr_offset   <= 12'hfff;
        exthdr_len_tot        <= 15'd0;
        have_udp              <= 1'b0;
        have_tcp              <= 1'b0;
        have_frag             <= 1'b0;
        have_route            <= 1'b0;
        is_route              <= 1'b0;
      end
      else if (valid)
      begin
        ipv6_ext_hdr_state    <= ipv6_ext_hdr_state_nxt;
        next_ext_hdr_offset   <= next_ext_hdr_offset_c[11:0];
        exthdr_len_tot        <= exthdr_len_tot_nxt[14:0];
        have_udp              <= have_udp_c;
        have_tcp              <= have_tcp_c;
        have_frag             <= have_frag_c;
        have_route            <= have_route_c;
        is_route              <= is_route_c;
      end
    end
  end
  assign l4_tcp_hdr_detected = have_tcp & ~have_frag;
  assign l4_udp_hdr_detected = have_udp & ~have_frag;

  // Calculate where the IPv4 csum byte is located
  wire [16:0] l4_hdr_offst_p8;
  assign l4_hdr_offst_p8 = 16'd8 + l4_hdr_offst[15:0];
  always @(posedge host_clk or negedge host_rst_n)
  begin
    if  (~host_rst_n)
      pld_offst  <= 16'h0fff;
    else
    begin
      if (~soft_enable)
        pld_offst  <= 16'h0fff;
      else if (eop & valid)
        pld_offst  <= 16'h0fff;
      else if ((ipv6_frame_detected | ipv4_ethertype_detected) & ~(&l4_hdr_offst))
        pld_offst  <= l4_hdr_offst_p8[15:0];
      else
        pld_offst  <= {10'd0,l3_hdr_offst[5:0]};
    end
  end


  // Extract the IP source/destination address
  // -------------------------------------------------------------------------------
  always @(*)
  begin
    if (ipv4_ethertype_detected)
      ip_src_add_offset = (l3_hdr_offst + 6'd12);
    else
      ip_src_add_offset = (l3_hdr_offst + 6'd8);
  end

  edma_field_decode #( .field_size(16'd16),.field_size_words(13'd2),.p_always_on_one_stripe(1'b0)) i_ip_src_add_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (eop),
    .field_offset           ({9'd0,ip_src_add_offset[6:0]}),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  (ip_sa),
    .field_valid            (),
    .field_c                (),
    .field_valid_c          (ip_sa_stb_c)
  );
  always @(*)
  begin
    if (ipv4_ethertype_detected)
      ip_dest_add_offset = (l3_hdr_offst + 6'd16);
    else
      ip_dest_add_offset = (l3_hdr_offst + 6'd24);
  end
  edma_field_decode #( .field_size(16'd16),.field_size_words(13'd2),.p_always_on_one_stripe(1'b0)) i_ip_dest_add_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (eop),
    .field_offset           ({9'd0,ip_dest_add_offset[6:0]}),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  (ip_dest_add_extr),
    .field_valid            (),
    .field_c                (),
    .field_valid_c          (ip_da_stb_c)
  );
  always @(posedge host_clk or negedge host_rst_n)
  begin
    if (~host_rst_n)
    begin
      ip_sa_stb <= 1'b0;
      ip_da_stb <= 1'b0;
    end
    else
    begin
      ip_sa_stb <= ip_sa_stb_c & (ipv4_frame_detected | ipv6_frame_detected);
      ip_da_stb <= ip_da_stb_c & (ipv4_frame_detected | ipv6_frame_detected);
    end
  end
  assign ip_dest_add = ipv4_ethertype_detected ?
                                             {{96{1'b0}},
                                              ip_dest_add_extr[7:0],
                                              ip_dest_add_extr[15:8],
                                              ip_dest_add_extr[23:16],
                                              ip_dest_add_extr[31:24]} :
                                             {ip_dest_add_extr[7:0],
                                              ip_dest_add_extr[15:8],
                                              ip_dest_add_extr[23:16],
                                              ip_dest_add_extr[31:24],
                                              ip_dest_add_extr[39:32],
                                              ip_dest_add_extr[47:40],
                                              ip_dest_add_extr[55:48],
                                              ip_dest_add_extr[63:56],
                                              ip_dest_add_extr[71:64],
                                              ip_dest_add_extr[79:72],
                                              ip_dest_add_extr[87:80],
                                              ip_dest_add_extr[95:88],
                                              ip_dest_add_extr[103:96],
                                              ip_dest_add_extr[111:104],
                                              ip_dest_add_extr[119:112],
                                              ip_dest_add_extr[127:120]};

  assign ip_da =  ip_dest_add_extr;

  // -------------------------------------------------------------------------------
  // Extract the UDP Destination Port
  assign udp_destport_offset = (l4_hdr_offst + 16'd2);
  edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b1),.field_size_words(13'd2)) i_udp_dest_port_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable),
    .data                   (data),
    .valid                  (valid),
    .eop                    (eop),
    .field_offset           (udp_destport_offset[15:0]),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  ({udp_destport[7:0],udp_destport[15:8]}),
    .field_valid            (),
    .field_c                (),
    .field_valid_c          ()
  );


  // Extract the IPv4 version2 PTP message_type field
  edma_field_decode #( .field_size(16'd1),.field_size_words(13'd1),.p_always_on_one_stripe(1'b1)) i_ipv4_ptpv2_msg_type_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable & (ipv4_frame_detected | ipv6_frame_detected | ptpoe_type_detected_c)),
    .data                   (data),
    .valid                  (valid),
    .eop                    (eop),
    .field_offset           (pld_offst),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  (ptp_msg_type_pad),
    .field_valid            (ptp_msg_type_vld),
    .field_c                (),
    .field_valid_c          ()
  );
  assign ptp_msg_type = ptp_msg_type_pad[3:0];

  // Extract the PTP version field
  assign ptp_ver_offset = (pld_offst + 16'd1);
  edma_field_decode #( .field_size(16'd1),.field_size_words(13'd1),.p_always_on_one_stripe(1'b1)) i_ptp_version_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable & (ipv4_frame_detected | ipv6_frame_detected | ptpoe_type_detected_c)),
    .data                   (data),
    .valid                  (valid),
    .eop                    (eop),
    .field_offset           (ptp_ver_offset[15:0]),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  (ptp_version_pad),
    .field_valid            (ptp_version_vld),
    .field_c                (),
    .field_valid_c          ()
  );
  assign ptp_version = ptp_version_pad[1:0];


  // Extract the PTP sequence ID field - always at offset 30
  assign ptp_seqid_offset = (pld_offst + 16'd30);
  edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b1),.field_size_words(13'd1)) i_ptp_seqid_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable & (ipv4_frame_detected | ipv6_frame_detected | ptpoe_type_detected_c)),
    .data                   (data),
    .valid                  (valid),
    .eop                    (eop),
    .field_offset           (ptp_seqid_offset[15:0]),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  (ptp_seqid),
    .field_valid            (),
    .field_c                (),
    .field_valid_c          ()
  );

  // Extract the IPv4 version1 PTP control field
  assign ptp_ctlv1_offset = (pld_offst + 16'd32);
  edma_field_decode #( .field_size(16'd1),.field_size_words(13'd1),.p_always_on_one_stripe(1'b1)) i_ptp_ctl_extract  (
    .host_clk               (host_clk),
    .host_rst_n             (host_rst_n),

    .soft_enable            (soft_enable & (ipv4_frame_detected | ipv6_frame_detected | ptpoe_type_detected_c)),
    .data                   (data),
    .valid                  (valid),
    .eop                    (eop),
    .field_offset           (ptp_ctlv1_offset[15:0]),
    .running_byte_count     (running_byte_count),
    .dma_bus_width          (dma_bus_width),

    .field                  (),
    .field_valid            (ptp_ctlv1_vld),
    .field_c                (ptp_ctlv1),
    .field_valid_c          ()
  );

  // Extract the PTP timestamp offset - Version 2 always at offset 34 - Version 1 always at offset 40
  wire [16:0] pld_offst_p34;
  assign pld_offst_p34 = (pld_offst[15:0] + 16'd34);
  wire [16:0] pld_offst_p40;
  assign pld_offst_p40 = (pld_offst[15:0] + 16'd40);
  always @(*)
  begin
    if ((ptp_version == 2'h2 & ipv4_ethertype_detected) | ptpoe_type_detected | ipv6_frame_detected)
      ptp_timestamp_offset = pld_offst_p34[15:0];
    else if (ptp_version == 2'h1 & ipv4_ethertype_detected)
      ptp_timestamp_offset = pld_offst_p40[15:0];
    else
      ptp_timestamp_offset = 16'h0000;
  end

  // -------------------------------------------------------------------------------------------------------
  // The first octet of the PTP message shall immediately follow the final octet of the UDP header
  // The UDP destination port of an event message shall be 319.
  // The UDP destination port of a multicast general message shall be 320.

  // Extract PTP messages, event or general
  // sync, delay_req, delay_resp, pdelay_req, pdelay_resp, follow_up
  always @(*)
  begin
    ptp_general_msg_c  = 1'b0;
    ptp_event_msg_c    = 1'b0;
    ptp_sync_msg_c     = 1'b0;
    ptp_dreq_msg_c     = 1'b0;
    ptp_dresp_msg_c    = 1'b0;
    ptp_pdreq_msg_c    = 1'b0;
    ptp_pdresp_msg_c   = 1'b0;
    ptp_follow_msg_c   = 1'b0;
    // 1588 Transport over IPv4/UDPdecode_out_vld
    if (ipv4_ethertype_detected)
    begin
      // UDP, PTP Version1, IPv4 multicast addr match
      if ((ipv4_protocol == 8'h11) & (ptp_version == 2'h1) & (ip_dest_add[31:4] == 28'he000018) &
          ((ip_dest_add[3:0] == 4'h1) | (ip_dest_add[3:0] == 4'h2) | (ip_dest_add[3:0] == 4'h3) |
           (ip_dest_add[3:0] == 4'h4)))
      begin
        ptp_pdreq_msg_c     = 1'b0;
        ptp_pdresp_msg_c    = 1'b0;
        // Event Mesage, when UDP dest port and Control match
        // for Sync Frame Control field must match
        if ((udp_destport == 16'h013f) & ((ptp_ctlv1 == 8'h00) | (ptp_ctlv1 == 8'h01)) & ptp_ctlv1_vld)
        begin
          ptp_event_msg_c   = 1'b1;
          ptp_sync_msg_c    = (ptp_ctlv1 == 8'h00) ? 1'b1 : 1'b0;
          ptp_dreq_msg_c    = (ptp_ctlv1 == 8'h01) ? 1'b1 : 1'b0;
          ptp_follow_msg_c  = 1'b0;
          ptp_dresp_msg_c   = 1'b0;
          ptp_general_msg_c = 1'b0;
        end
        // General Mesage, when UDP dest port and Control match
        else if ((udp_destport == 16'h0140) & ptp_ctlv1_vld & ((ptp_ctlv1 == 8'h02) | (ptp_ctlv1 == 8'h03) | (ptp_ctlv1 == 8'h04) | (ptp_ctlv1 == 8'h05)))
        begin
          ptp_event_msg_c   = 1'b0;
          ptp_sync_msg_c    = 1'b0;
          ptp_dreq_msg_c    = 1'b0;
          ptp_follow_msg_c  = (ptp_ctlv1 == 8'h02) ? 1'b1 : 1'b0;
          ptp_dresp_msg_c   = (ptp_ctlv1 == 8'h03) ? 1'b1 : 1'b0;
          ptp_general_msg_c = 1'b1;
        end
      end
      // UDP, PTP Version2, IPv4 unicast addr match for peer delay mechanism messages
      else if (ptp_unicast_addr_en & (ipv4_protocol == 8'h11) & ptp_version_vld & (ptp_version == 2'h2) & (ip_dest_add[31:0] == ptp_unicast_addr))
      begin
        ptp_sync_msg_c    = (ptp_msg_type == 4'h0);
        ptp_dreq_msg_c    = (ptp_msg_type == 4'h1);
        ptp_follow_msg_c  = (ptp_msg_type == 4'h8);
        ptp_dresp_msg_c   = (ptp_msg_type == 4'h9);
        ptp_pdreq_msg_c   = (ptp_msg_type == 4'h2);
        ptp_pdresp_msg_c  = (ptp_msg_type == 4'h3);
        // Event message: sync, delay_req, pdelay_req, pdelay_resp
        if ((ptp_msg_type == 4'h0) | (ptp_msg_type == 4'h1) | (ptp_msg_type == 4'h2) | (ptp_msg_type == 4'h3))
        begin
          ptp_event_msg_c   = 1'b1;
          ptp_general_msg_c = 1'b0;
        end
        // General message: follow_up, delay_resp, pdelay_resp_follow_up, announce, signaling, management
        else if ((ptp_msg_type == 4'h8) | (ptp_msg_type == 4'h9) | (ptp_msg_type == 4'ha) |
           (ptp_msg_type == 4'hb) | (ptp_msg_type == 4'hc) | (ptp_msg_type == 4'hd))
        begin
          ptp_event_msg_c   = 1'b0;
          ptp_general_msg_c = 1'b1;
        end
      end
      // UDP, PTP Version2, IPv4 multicast addr match for all messages except peer delay mechanism messages
      else if ((ipv4_protocol == 8'h11) & (ptp_version == 2'h2) & ptp_version_vld & (ip_dest_add[31:0] == 32'he0000181))
      begin
        ptp_sync_msg_c    = ((ptp_msg_type == 4'h0) & (udp_destport == 16'h013f)) ? 1'b1 : 1'b0;
        ptp_dreq_msg_c    = ((ptp_msg_type == 4'h1) & (udp_destport == 16'h013f)) ? 1'b1 : 1'b0;
        ptp_follow_msg_c  = ((ptp_msg_type == 4'h8) & (udp_destport == 16'h0140)) ? 1'b1 : 1'b0;
        ptp_dresp_msg_c   = ((ptp_msg_type == 4'h9) & (udp_destport == 16'h0140)) ? 1'b1 : 1'b0;
        ptp_pdreq_msg_c   = 1'b0;
        ptp_pdresp_msg_c  = 1'b0;
        // Event message: sync and delay_req
        if (((ptp_msg_type == 4'h0) | (ptp_msg_type == 4'h1)) & (udp_destport == 16'h013f))
        begin
          ptp_event_msg_c   = 1'b1;
          ptp_general_msg_c = 1'b0;
        end
        // General message: follow_up, delay_resp, announce, signaling, management
        else if (((ptp_msg_type == 4'h8) | (ptp_msg_type == 4'h9) | (ptp_msg_type == 4'hb) |
           (ptp_msg_type == 4'hc) | (ptp_msg_type == 4'hd)) & (udp_destport == 16'h0140))
        begin
          ptp_event_msg_c   = 1'b0;
          ptp_general_msg_c = 1'b1;
        end
      end
      // UDP, PTP Version2, IPv4 multicast addr match for peer delay mechanism messages
      else if ((ipv4_protocol == 8'h11) & (ptp_version == 2'h2) & ptp_version_vld & (ip_dest_add[31:0] == 32'he000006b))
      begin
        ptp_sync_msg_c    = 1'b0;
        ptp_dreq_msg_c    = 1'b0;
        ptp_follow_msg_c  = 1'b0;
        ptp_dresp_msg_c   = 1'b0;
        ptp_pdreq_msg_c   = ((ptp_msg_type == 4'h2) & (udp_destport == 16'h013f)) ? 1'b1 : 1'b0;
        ptp_pdresp_msg_c  = ((ptp_msg_type == 4'h3) & (udp_destport == 16'h013f)) ? 1'b1 : 1'b0;
        // Event message: pdelay_req, pdelay_resp
        if (((ptp_msg_type == 4'h2) | (ptp_msg_type == 4'h3)) & (udp_destport == 16'h013f))
        begin
          ptp_event_msg_c   = 1'b1;
          ptp_general_msg_c = 1'b0;
        end
        // General message: pdelay_resp_follow_up
        else if ((ptp_msg_type == 4'ha) & (udp_destport == 16'h0140))
        begin
          ptp_event_msg_c   = 1'b0;
          ptp_general_msg_c = 1'b1;
        end
      end
    end

    // 1588 Transport over IPv6/UDP
    else if (ipv6_frame_detected & ptp_msg_type_vld)
    begin
      // UDP, IP dest addr match for peer delay mechanism messages
      if (ip_dest_add[127:0] == 128'hff02000000000000000000000000006b)
      begin
        ptp_sync_msg_c    = 1'b0;
        ptp_dreq_msg_c    = 1'b0;
        ptp_follow_msg_c  = 1'b0;
        ptp_dresp_msg_c   = 1'b0;
        ptp_pdreq_msg_c   = ((ptp_msg_type == 4'h2) & (udp_destport == 16'h013f)) ? 1'b1 : 1'b0;
        ptp_pdresp_msg_c  = ((ptp_msg_type == 4'h3) & (udp_destport == 16'h013f)) ? 1'b1 : 1'b0;
        // Event message: pdelay_req, pdelay_resp
        if (((ptp_msg_type == 4'h2) | (ptp_msg_type == 4'h3)) & (udp_destport == 16'h013f))
        begin
          ptp_event_msg_c   = 1'b1;
          ptp_general_msg_c = 1'b0;
        end
        // General message: pdelay_resp_follow_up
        else if ((ptp_msg_type == 4'ha) & (udp_destport == 16'h0140))
        begin
          ptp_event_msg_c   = 1'b0;
          ptp_general_msg_c = 1'b1;
        end
      end
      // UDP, IP dest addr match for all messages except peer delay mechanism messages
      else if ((ip_dest_add[127:116] == 12'hff0) & (ip_dest_add[111:0] == 112'h0000000000000000000000000181))
      begin
        ptp_sync_msg_c    = ((ptp_msg_type == 4'h0) & (udp_destport == 16'h013f)) ? 1'b1 : 1'b0;
        ptp_dreq_msg_c    = ((ptp_msg_type == 4'h1) & (udp_destport == 16'h013f)) ? 1'b1 : 1'b0;
        ptp_follow_msg_c  = ((ptp_msg_type == 4'h8) & (udp_destport == 16'h0140)) ? 1'b1 : 1'b0;
        ptp_dresp_msg_c   = ((ptp_msg_type == 4'h9) & (udp_destport == 16'h0140)) ? 1'b1 : 1'b0;
        ptp_pdreq_msg_c   = 1'b0;
        ptp_pdresp_msg_c  = 1'b0;
        // Event message: sync and delay_req
        if (((ptp_msg_type == 4'h0) | (ptp_msg_type == 4'h1)) & (udp_destport == 16'h013f))
        begin
          ptp_event_msg_c   = 1'b1;
          ptp_general_msg_c = 1'b0;
        end
        // General message: follow_up, delay_resp, announce, signaling, management
        else if (((ptp_msg_type == 4'h8) | (ptp_msg_type == 4'h9) | (ptp_msg_type == 4'hb) |
           (ptp_msg_type == 4'hc) | (ptp_msg_type == 4'hd)) & (udp_destport == 16'h0140))
        begin
          ptp_event_msg_c   = 1'b0;
          ptp_general_msg_c = 1'b1;
        end
      end
    end

    // 1588 Transport over Ethernet
    else if (ptpoe_type_detected & ptp_msg_type_vld)
    begin
      // MAC dest addr match for all messages
      if (ptp_all_dest_match)
      begin
        ptp_sync_msg_c    = (ptp_msg_type == 4'h0) ? 1'b1 : 1'b0;
        ptp_dreq_msg_c    = (ptp_msg_type == 4'h1) ? 1'b1 : 1'b0;
        ptp_follow_msg_c  = (ptp_msg_type == 4'h8) ? 1'b1 : 1'b0;
        ptp_dresp_msg_c   = (ptp_msg_type == 4'h9) ? 1'b1 : 1'b0;
        ptp_pdreq_msg_c   = (ptp_msg_type == 4'h2) ? 1'b1 : 1'b0;
        ptp_pdresp_msg_c  = (ptp_msg_type == 4'h3) ? 1'b1 : 1'b0;
        // Event message: sync, pdelay_req, pdelay_resp
        if ((ptp_msg_type == 4'h0) |
            (ptp_msg_type == 4'h1) |
            (ptp_msg_type == 4'h2) |
            (ptp_msg_type == 4'h3)
            )
        begin
          ptp_event_msg_c   = 1'b1;
          ptp_general_msg_c = 1'b0;
        end
        // General message: pdelay_resp_follow_up
        else if ((ptp_msg_type == 4'h8) |
            (ptp_msg_type == 4'h9) |
            (ptp_msg_type == 4'ha) |
            (ptp_msg_type == 4'hb) |
            (ptp_msg_type == 4'hc) |
            (ptp_msg_type == 4'hd)
            )
        begin
          ptp_event_msg_c   = 1'b0;
          ptp_general_msg_c = 1'b1;
        end
      end
      // MAC dest addr match, for all messages except peer delay mechanism messages
      else if (ptp_version_vld & ptp_allmpeer_dest_match)
      begin
        ptp_sync_msg_c    = (ptp_msg_type == 4'h0) ? 1'b1 : 1'b0;
        ptp_dreq_msg_c    = (ptp_msg_type == 4'h1) ? 1'b1 : 1'b0;
        ptp_follow_msg_c  = (ptp_msg_type == 4'h8) ? 1'b1 : 1'b0;
        ptp_dresp_msg_c   = (ptp_msg_type == 4'h9) ? 1'b1 : 1'b0;
        ptp_pdreq_msg_c   = 1'b0;
        ptp_pdresp_msg_c  = 1'b0;
        // Event message: sync and delay_req
        if ((ptp_msg_type == 4'h0) | (ptp_msg_type == 4'h1))
        begin
          ptp_event_msg_c   = 1'b1;
          ptp_general_msg_c = 1'b0;
        end
        // General message: follow_up, delay_resp, announce, signaling, management
        else if ((ptp_msg_type == 4'h8) | (ptp_msg_type == 4'h9) | (ptp_msg_type == 4'ha) | (ptp_msg_type == 4'hb) |
           (ptp_msg_type == 4'hc) | (ptp_msg_type == 4'hd))
        begin
          ptp_event_msg_c   = 1'b0;
          ptp_general_msg_c = 1'b1;
        end
      end
    end
  end

  // Set the outputs, bit 1 is set until EOP, bit 0 toggles
  always @(posedge host_clk or negedge host_rst_n)
  begin
    if  (~host_rst_n)
    begin
      ptp_event_msg             <= 1'b0;
      ptp_general_msg           <= 1'b0;
      ptp_sync_msg_d1           <= 1'b0;
      ptp_dreq_msg_d1           <= 1'b0;
      ptp_follow_msg_d1         <= 1'b0;
      ptp_dresp_msg_d1          <= 1'b0;
      ptp_pdreq_msg_d1          <= 1'b0;
      ptp_pdresp_msg_d1         <= 1'b0;
    end
    else
    begin
      if (~soft_enable)
      begin
        ptp_event_msg           <= 1'b0;
        ptp_general_msg         <= 1'b0;
        ptp_sync_msg_d1         <= 1'b0;
        ptp_dreq_msg_d1         <= 1'b0;
        ptp_follow_msg_d1       <= 1'b0;
        ptp_dresp_msg_d1        <= 1'b0;
        ptp_pdreq_msg_d1        <= 1'b0;
        ptp_pdresp_msg_d1       <= 1'b0;
      end
      else
      begin
        ptp_event_msg      <= ptp_event_msg_c;
        ptp_general_msg    <= ptp_general_msg_c;
        ptp_sync_msg_d1    <= ptp_sync_msg_c;
        ptp_dreq_msg_d1    <= ptp_dreq_msg_c;
        ptp_follow_msg_d1  <= ptp_follow_msg_c;
        ptp_dresp_msg_d1   <= ptp_dresp_msg_c;
        ptp_pdreq_msg_d1   <= ptp_pdreq_msg_c;
        ptp_pdresp_msg_d1  <= ptp_pdresp_msg_c;
      end
    end
  end

  assign ptp_sync_msg   = ptp_sync_msg_d1 | ptp_sync_msg_c;
  assign ptp_dreq_msg   = ptp_dreq_msg_d1 | ptp_dreq_msg_c;
  assign ptp_follow_msg = ptp_follow_msg_d1 | ptp_follow_msg_c;
  assign ptp_dresp_msg  = ptp_dresp_msg_d1 | ptp_dresp_msg_c;
  assign ptp_pdreq_msg  = ptp_pdreq_msg_d1 | ptp_pdreq_msg_c;
  assign ptp_pdresp_msg = ptp_pdresp_msg_d1 | ptp_pdresp_msg_c;


  // Signal to indicate that the extracted frame data is valid
  // It is set with every frame
  // -when all necessary data from PTP frame are decoded (at payload offset + 32 byte)
  // -when the frame size is smaller than payload offset + 32 byte
  always @(posedge host_clk or negedge host_rst_n)
  begin
    if  (~host_rst_n)
    begin
      decode_out_vld_r    <= 1'b0;
    end
    else
    begin
      if (~soft_enable | (eop & valid))
        decode_out_vld_r  <= 1'b0;
      else if (valid & ptp_ctlv1_vld)
        decode_out_vld_r  <= 1'b1;
      else
        decode_out_vld_r  <= 1'b0;
    end
  end

  assign decode_out_vld = (decode_out_vld_r | ptp_ctlv1_vld);


  // TCP/IP OffloadStatus reporting
  wire   [13:0]       stripe_num;
  wire   [13:0]       end_offset_stripe;
  assign stripe_num           = dma_bus_width == 2'b00 ? running_byte_count[15:2] :
                                dma_bus_width == 2'b01 ? {1'b0, running_byte_count[15:3]} :
                                                         {2'b00,running_byte_count[15:4]};
  assign end_offset_stripe    = dma_bus_width == 2'b00 ?  end_of_tcpudp_pld_offset[15:2] :
                                dma_bus_width == 2'b01 ?  {1'b0, end_of_tcpudp_pld_offset[15:3]} :
                                                          {2'b00,end_of_tcpudp_pld_offset[15:4]};
  always@(posedge host_clk or negedge host_rst_n)
  begin
    if (~host_rst_n)
    begin
      tcp_status            <= 3'h0;
    end
    else
    begin
      if ((tcp_status != PREMATURE_EOP) | sop)
      begin
        if (vlan_indicator_0 & invalid_vlan_0)
          tcp_status  <=  VLAN_HDR_ERROR;
        else if (invalid_snap)
          tcp_status  <=  SNAP_HDR_ERROR;
        else if (ipv4_ethertype_detected & (ip_version != 4'h4 | ipv4_hdr_length < 4'h5))
          tcp_status  <=  IP_HDR_ERROR;
        else if (ipv6_frame_detected & (ip_version != 4'h6))
          tcp_status  <=  IP_HDR_ERROR;
        else if (~ipv4_ethertype_detected & ~ipv6_frame_detected)
        begin
          if (~snap_indicator & ~vlan_indicator_0 & ~qinq_indicator_0 & ~pppoe_indicator)
            tcp_status  <=  UNKNOWN_TYPE;
          else
            tcp_status  <=  IP_HDR_ERROR;
        end
        else if (valid & eop & stripe_num < end_offset_stripe)
          tcp_status  <=  PREMATURE_EOP;
        else if (have_frag)
          tcp_status  <=  PKT_FRAGMENTED;
//        else if (valid & eop & stripe_num > end_offset_stripe)
//          tcp_status  <=  IP_HDR_ERROR;
        else if (~(have_tcp | have_udp))
          tcp_status  <=  IPV4_ONLY;
        else
          tcp_status  <=  3'b000;
      end
    end
  end


// Screener code ...

generate if (include_screeners == 1 && p_num_type2_screeners > 0 && p_num_scr2_compare_regs > 0) begin : gen_scrntype2_match
genvar a;
genvar b;
  wire [p_num_scr2_compare_regs-1:0] offset_type_0;
  wire [p_num_scr2_compare_regs-1:0] offset_type_1;
  reg    [32:0]       scr2_compare_match;
  for (a=0; a<p_num_scr2_compare_regs; a = a+1)
  begin : screener_type2_extract_byte_to_compare
    reg   [15:0]  offset_to_use;
    wire  [15:0]  scr2_comp_data;
    wire          scr2_comp_data_valid;

    assign offset_type_0[a]    = scr2_compare_regs[(41*a)+33];
    assign offset_type_1[a]    = scr2_compare_regs[(41*a)+34];

    always@(*)
    begin
      case ({offset_type_1[a],offset_type_0[a]})
        2'b00   : offset_to_use = {9'd0,scr2_compare_regs[(41*a)+41:(41*a)+35]};
        2'b01   : offset_to_use = {9'd0,scr2_compare_regs[(41*a)+41:(41*a)+35]} + {10'd0,l3_hdr_offst};
        2'b10   : offset_to_use = {9'd0,scr2_compare_regs[(41*a)+41:(41*a)+35]} + {1'd0,l4_hdr_offst[14:0]};
        default : offset_to_use = {9'd0,scr2_compare_regs[(41*a)+41:(41*a)+35]} + {1'd0,pld_offst[14:0]};
      endcase
    end

    // Extract the databyte for future comparison
    edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b0),.field_size_words(13'd1)) i_extract_scr2_comp_field  (
      .host_clk               (host_clk),
      .host_rst_n             (host_rst_n),

      .soft_enable            (soft_enable),
      .data                   (data),
      .valid                  (valid),
      .eop                    (eop),
      .field_offset           (offset_to_use),
      .running_byte_count     (running_byte_count),
      .dma_bus_width          (dma_bus_width),

      .field                  (scr2_comp_data),
      .field_valid            (scr2_comp_data_valid),
      .field_c                (),
      .field_valid_c          ()
    );

    always@(posedge host_clk or negedge host_rst_n)
    begin
      if (~host_rst_n)
        scr2_compare_match[a] <= 1'b0;
      else if (sop)
        scr2_compare_match[a] <= 1'b0;
      else if (scr2_comp_data_valid)
      begin
        // note the registers are actually reversed (word 1 is in word 0's position)
          scr2_compare_match[a] <= (scr2_compare_regs[(41*a)+16:(41*a)+1] &      // cmp val
                                    scr2_compare_regs[(41*a)+32:(41*a)+17]) == // Compare Mask
                                   (scr2_comp_data &                           // Data Field
                                    scr2_compare_regs[(41*a)+32:(41*a)+17]) && // Compare Mask
                                   (scr2_compare_regs[(41*a)+32:(41*a)+17] != 16'h0000); // Compare Mask must be != 0

      end
    end
  end

  // Tie scr2_compare_match bits mapping to non-present compare regs to zero
  for (b=p_num_scr2_compare_regs; b<33; b = b+1)
  begin :scr2_comp_match
    always @(*)
      scr2_compare_match[b] = 1'b0;
  end
  assign scr2_compare_match_glob = scr2_compare_match[31:0];
end else begin : gen_no_scrntype2_match
  wire    [32:0]       scr2_compare_match;
  assign scr2_compare_match[32:0] = 33'd0;
  assign scr2_compare_match_glob = scr2_compare_match[31:0];
end
endgenerate

generate if (include_screeners == 1 && p_num_type2_screeners > 0 && p_num_scr2_ethtype_regs > 0) begin : gen_ethtype_match
genvar c;
genvar d;
  reg    [8:0]        scr2_ethtype_match;
  for (c=0; c<p_num_scr2_ethtype_regs; c = c+1)
  begin :scr2_eth_match
    always@(posedge host_clk or negedge host_rst_n)
    begin
      if (~host_rst_n)
        scr2_ethtype_match[c] <= 1'b0;
      else if (sop)
        scr2_ethtype_match[c] <= 1'b0;
      else if (~vlan_indicator_0 & ethtype_1_vld_r)
        scr2_ethtype_match[c] <=  ethtype_1 == scr2_ethtype_regs[(16*c)+16:(16*c)+1];
      else if (vlan_indicator_0 & ethtype_2_vld_r)
        scr2_ethtype_match[c] <=  ethtype_2 == scr2_ethtype_regs[(16*c)+16:(16*c)+1];
    end
  end

  // Tie scr2_compare_match bits mapping to non-present compare regs to zero
  for (d=p_num_scr2_ethtype_regs; d<9; d = d+1)
  begin : scr2_eth_match2
    always @(*)
      scr2_ethtype_match[d] = 1'b0;
  end
  assign scr2_ethtype_match_glob = scr2_ethtype_match;
end else begin  : gen_no_ethtype_match
  wire    [8:0]        scr2_ethtype_match;
  assign scr2_ethtype_match[8:0] = 9'd0;
  assign scr2_ethtype_match_glob = scr2_ethtype_match;
end
endgenerate


generate if (include_screeners == 1 && p_num_type1_screeners > 0 && p_num_type2_screeners > 0 ) begin : gen_scrntop_inst1
        xgm_screener_top i_xgm_screener_top(
         .n_rxreset           (host_rst_n),
         .rx_clk              (host_clk),
         .reset_queue_ptr     (1'b0),
         .screener_type1_regs (screener_type1_regs[(30*p_num_type1_screeners):1]),
         .ip_v4_tos           (ipv4_tos),
         .ip_v6_tc            (ipv6_tc),
         .udp_dest_addr       (udp_destport),

         .screener_type2_regs (screener_type2_regs[(30*p_num_type2_screeners):1]),
         .scr2_ethtype_match  (scr2_ethtype_match_glob[7:0]),
         .scr2_compare_match  (scr2_compare_match_glob[31:0]),
         .tci                 (vlan_tag1[15:13]),
         .vlan_tagged         (vlan_indicator_0),

         .priority_queue      (queue_ptr_rx));
end
endgenerate

generate if (include_screeners == 1 && p_num_type1_screeners > 0 && p_num_type2_screeners == 0 ) begin : gen_scrntop_inst2
        xgm_screener_top i_xgm_screener_top(
         .n_rxreset           (host_rst_n),
         .rx_clk              (host_clk),
         .reset_queue_ptr     (1'b0),
         .screener_type1_regs (screener_type1_regs[(30*p_num_type1_screeners):1]),
         .ip_v4_tos           (ipv4_tos),
         .ip_v6_tc            (ipv6_tc),
         .udp_dest_addr       (udp_destport),
         .priority_queue      (queue_ptr_rx));
end
endgenerate

generate if (include_screeners == 1 && p_num_type1_screeners == 0 && p_num_type2_screeners > 0 ) begin : gen_scrntop_inst3
        xgm_screener_top i_xgm_screener_top(
         .n_rxreset           (host_rst_n),
         .rx_clk              (host_clk),
         .reset_queue_ptr     (1'b0),

         .screener_type2_regs (screener_type2_regs[(30*p_num_type2_screeners):1]),
         .scr2_ethtype_match  (scr2_ethtype_match_glob[7:0]),
         .scr2_compare_match  (scr2_compare_match_glob[31:0]),
         .tci                 (vlan_tag1[15:13]),
         .vlan_tagged         (vlan_indicator_0),

         .priority_queue      (queue_ptr_rx));
end
endgenerate

generate if (include_screeners == 0 ) begin : gen_scrntop_inst4
  assign queue_ptr_rx = 4'd0;

end
endgenerate



`ifdef SVA
bit has_ipv4_hdr;
bit has_ipv4_options;
int num_ipv4_options;

bit has_ipv6_hdr;
bit has_ipv6_ext_hdrs;
int num_ipv6_ext_hdrs;

bit has_udp_hdr;
bit has_tcp_hdr;

bit has_ptpoip_hdr;
bit has_ptpoe_hdr;

initial num_ipv6_ext_hdrs = 0;
always @(posedge host_clk)
begin
  has_udp_hdr      <= (have_udp & ipv6_frame_detected)  | (ipv4_protocol == 8'h11 & ipv4_ethertype_detected);
  has_tcp_hdr      <= (have_tcp & ipv6_frame_detected)  | (ipv4_protocol == 8'h06 & ipv4_ethertype_detected);
  if (eop & valid)
    num_ipv6_ext_hdrs <= 0;
  else
  begin
    case (ipv6_ext_hdr_state)
      WAITING_FOR_FIRST_NXT_HDR :
      begin
        if (first_nxt_hdr_vld & ~no_more_ext_hdrs_c)
          num_ipv6_ext_hdrs <= 1;
      end

      WAITING_FOR_EXTHDR_NXT_HDR :
      begin
        if (exthdr_len_vld_c & ~no_more_ext_hdrs_c)
          num_ipv6_ext_hdrs <= num_ipv6_ext_hdrs + 1;
      end
    endcase
  end
end





assign has_ptpoip_hdr = (ptp_event_msg |
                        ptp_general_msg |
                        ptp_sync_msg |
                        ptp_dreq_msg |
                        ptp_follow_msg |
                        ptp_dresp_msg |
                        ptp_pdreq_msg |
                        ptp_pdresp_msg ) & has_udp_hdr;

assign has_ptpoe_hdr = (ptp_event_msg |
                        ptp_general_msg |
                        ptp_sync_msg |
                        ptp_dreq_msg |
                        ptp_follow_msg |
                        ptp_dresp_msg |
                        ptp_pdreq_msg |
                        ptp_pdresp_msg ) & ~has_udp_hdr;

covergroup packet_decodes @ (posedge decode_out_vld);
  has_ipv4_hdr      : coverpoint ipv4_ethertype_detected;
  num_ipv4_options  : coverpoint ipv4_hdr_length {
    bins zero            = {5};
    bins one             = {6};
    bins two             = {7};
    bins three           = {8};
    bins four            = {9};
    bins gt4             = {[10:$]};
  }
  has_ipv6_hdr      : coverpoint ipv6_frame_detected;
  num_ipv6_options  : coverpoint num_ipv6_ext_hdrs {
    bins zero            = {0};
    bins one             = {1};
    bins two             = {2};
    bins gt2             = {[3:$]};
  }
  has_udp_hdr       : coverpoint has_udp_hdr;
  has_tcp_hdr       : coverpoint has_tcp_hdr;
  l3_l4_pkt_type    : cross has_ipv4_hdr,has_ipv6_hdr,has_udp_hdr,has_tcp_hdr {
    ignore_bins ig0 = binsof(has_ipv4_hdr) intersect {1} && binsof(has_ipv6_hdr) intersect {1};
    ignore_bins ig1 = binsof(has_udp_hdr) intersect {1} && binsof(has_tcp_hdr) intersect {1};
    ignore_bins ig2 = binsof(has_ipv4_hdr) intersect {1} && binsof(has_tcp_hdr) intersect {0} && binsof(has_udp_hdr) intersect {0};
    ignore_bins ig3 = binsof(has_ipv6_hdr) intersect {1} && binsof(has_tcp_hdr) intersect {0} && binsof(has_udp_hdr) intersect {0};
  }
  has_ptpoip_hdr    : coverpoint has_ptpoip_hdr;
  has_ptpoe_hdr     : coverpoint has_ptpoe_hdr;
  ptp_event_msg     : coverpoint ptp_event_msg;
  ptp_general_msg   : coverpoint ptp_general_msg;
  ptp_sync_msg      : coverpoint ptp_sync_msg;
  ptp_dreq_msg      : coverpoint ptp_dreq_msg;
  ptp_follow_msg    : coverpoint ptp_follow_msg;
  ptp_dresp_msg     : coverpoint ptp_dresp_msg;
  ptp_pdreq_msg     : coverpoint ptp_pdreq_msg;
  ptp_pdresp_msg    : coverpoint ptp_pdresp_msg;
endgroup
packet_decodes i_packet_decodes = new();
`endif

endmodule

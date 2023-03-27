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
//   Filename:           edma_pbuf_tx_tcp.v
//   Module Name:        edma_pbuf_tx_tcp
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
//   Description    : TCP Checksum Offload for Tx packet Buffer
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module edma_pbuf_tx_tcp (

    // system signals
    hclk,
    n_hreset,
    soft_reset,

    dpram_we,
    dpram_din,
    dpram_din_par,
    dpram_addr,
    man_rd_new_pkt,
    dpram_eop,
    tx_pbuf_tcp_en,
    dma_bus_width,
    dpram_din_d1,

    ip_hdr_cs_we,
    ip_hdr_cs,
    ip_hdr_cs_par,
    ip_hdr_cs_addr,
    tcp_hdr_cs_we,
    tcp_hdr_cs,
    tcp_hdr_cs_par,
    tcp_hdr_cs_addr,
    tcp_status,

    tx_ena_abort

   );

//***************************************************************************
// Port declarations
//***************************************************************************
  parameter p_edma_tx_pbuf_addr = 32'd0;
  parameter p_edma_spram        = 1'b0;
  parameter p_edma_asf_dap_prot = 1'b0;
  parameter p_edma_axi          = 1'b0;

   // System signals
   input                          hclk;               // AHB clock
   input                          n_hreset;           // AHB reset
   input                          soft_reset;         // soft reset

   input                          dpram_we;           // DPRAM interface
   input  [127:0]                 dpram_din;          // DPRAM interface
   input  [15:0]                  dpram_din_par;
   input  [127:0]                 dpram_din_d1;       // DPRAM interface, delayed
   input  [p_edma_tx_pbuf_addr-1:0] dpram_addr;         // DPRAM interface
   input                          man_rd_new_pkt;     // First descr read
                                                      // of pkt
   input                          dpram_eop;          // DPRAM interface
   input                          tx_pbuf_tcp_en;     // TCP enable
   input  [1:0]                   dma_bus_width;      // programmed data width
                                                      // 00 = 32  bit bus
                                                      // 01 = 64  bit bus
                                                      // 1x = 128 bit bus

   output                         ip_hdr_cs_we;       // IPV4_ csum enable
   output [127:0]                 ip_hdr_cs;          // IPV4_ csum
   output [15:0]                  ip_hdr_cs_par;
   output [p_edma_tx_pbuf_addr-1:0] ip_hdr_cs_addr;     // IPV4_ csum dpram add
   output                         tcp_hdr_cs_we;      // TCP/UDP csum en
   output [127:0]                 tcp_hdr_cs;         // TCP/UDP csum
   output [15:0]                  tcp_hdr_cs_par;
                                                      // last 16 bits are parity of TCP/UDP csum
   output [p_edma_tx_pbuf_addr-1:0] tcp_hdr_cs_addr;    // TCP/UDP csum add
   output [2:0]                   tcp_status;         // TCP error status

   output                         tx_ena_abort;       // Don't write to the RAM as
                                                      // it will be re-writtern later

   wire   [2:0]                   tcp_status_c;       // Error status for TCP

   reg    [127:0]                 ip_hdr_cs_nxt;      // IPV4_ checksum
   reg    [127:0]                 ip_hdr_cs;          // IPV4_ checksum
   reg    [15:0]                  ip_hdr_cs_par_nxt;
   reg                            ip_hdr_cs_we;       // Enable for IPV4 csum
   reg    [p_edma_tx_pbuf_addr-1:0] ip_hdr_cs_addr;   // DPRAM add (IPV4 csum)
   reg    [127:0]                 tcp_hdr_cs_nxt;     // TCP checksum
   reg    [127:0]                 tcp_hdr_cs;         // TCP checksum
   reg    [15:0]                  tcp_hdr_cs_par_nxt;
   reg                            tcp_hdr_cs_we;      // Enable for TCP csum
   reg    [p_edma_tx_pbuf_addr-1:0] tcp_hdr_cs_addr;    // DPRAM Add for TCP csum

   wire   [127:0]                 dpram_din_i;        // Dpram data in
   wire   [15:0]                  dpram_din_par_i;
   reg                            ip_cs_locn_d1;      // IPV4_ csum Delayed for edge det
   reg                            tcp_cs_locn_d1;     // TCP/UDP Delayed for edge det


// Status Condition ... (tcp_status)
// 0x0 = No error - both IP and TCP checksums are valid
// 0x1 = The VLAN packet did not have a valid header
// 0x2 = The SNAP packet did not have a valid header
// 0x3 = The IP packet header was invalidly short, or
//       not IPV4 at all
// 0x4 = The packet was not a VLAN, SNAP or IP type
// 0x5 = The packet was fragmented, only IP checksum was written(if IPv4)
// 0x6 = The packet was something other than TCP or UDP, only IP checksum
//       was written(if IPV4)
// 0x7 = Premature EOP in packet - This occurs when an EOP is detected but
//       the end of the IP/TCP or UDP packet was not expected.
  parameter NO_ERROR        = 3'h0;
  parameter VLAN_HDR_ERROR  = 3'h1;
  parameter SNAP_HDR_ERROR  = 3'h2;
  parameter IP_HDR_ERROR    = 3'h3;
  parameter UNKNOWN_TYPE    = 3'h4;
  parameter PKT_FRAGMENTED  = 3'h5;
  parameter IPV4_ONLY       = 3'h6;
  parameter PREMATURE_EOP   = 3'h7;


  parameter IDLE      = 5'h00;
  parameter START     = 5'h01;
  parameter VLAN2     = 5'h02;
  parameter SNAP2     = 5'h03;
  parameter SNAP4     = 5'h04;
  parameter IPV4_2    = 5'h05;
  parameter IPV4_4    = 5'h06;
  parameter IPV4_6    = 5'h07;
  parameter IPV4_8    = 5'h08;
  parameter IPV4_10   = 5'h09;
  parameter IPV6_M2BYTE    = 5'h0a;
  parameter IPV6_EXTHDR    = 5'h0b;
  parameter PPPoE     = 5'h0c;
  parameter PPPoE2    = 5'h10;
  parameter TCP1      = 5'h0d;
  parameter TCP2      = 5'h0e;
  parameter CALC_CSUM = 5'h0f;


reg sop;
reg dpram_we_d1;
reg dpram_eop_d1;
wire  ipv4_frame_detected;
always @(posedge hclk or negedge n_hreset)
begin
  if (~n_hreset)
  begin
    sop <= 1'b0;
    dpram_we_d1 <= 1'b0;
    dpram_eop_d1 <= 1'b0;
  end
  else
  begin
    dpram_we_d1 <= dpram_we;
    dpram_eop_d1 <= dpram_eop;
    if (man_rd_new_pkt)
      sop <= 1'b1;
    else if (dpram_we)
      sop <= 1'b0;
  end
end
  wire   [5:0]        l3_hdr_offst;    // Byte offset of L3
  wire   [15:0]       end_of_ip_hdr_offset;
  wire   [15:0]       running_byte_count;
  wire   [6:0]        ipv4_csum_offset;
  wire   [6:0]        start_of_ip_srcadd_offset;
  wire   [6:0]        end_of_ip_srcadd_offset;
  wire   [15:0]       start_of_ip_destadd_offset;
  wire   [15:0]       end_of_ip_destadd_offset;
  wire   [15:0]       end_of_tcpudp_pld_offset;
  wire   [15:0]       l4_hdr_offst;
  wire   [15:0]       tcp_length;
  wire   [15:0]       tcp_csum_offset;
  wire   [15:0]       ipv4_result;
  wire   [1:0]        ipv4_result_par; // parity of ipv4_result
  wire   [15:0]       ipv4_result_n;
  wire                ipv4_offload_valid;
  wire                tcp_offload_valid;
  wire                l4_tcp_hdr_detected;
  wire                l4_udp_hdr_detected;

 edma_pkt_decode #(
      .include_screeners      (1'b0),
      .p_num_type1_screeners  (0),
      .p_num_type2_screeners  (0),
      .p_num_scr2_compare_regs(0),
      .p_num_scr2_ethtype_regs(0)
 ) i_edma_pkt_decode (

    .host_clk               (hclk),
    .host_rst_n             (n_hreset),
    .soft_enable            (!soft_reset),

    .data                   (dpram_din[127:0]),  // passing only data without parity
    .sop                    (sop),
    .eop                    (dpram_eop),
    .valid                  (dpram_we),

    .ptp_unicast_addr_en    (1'b0),
    .ptp_unicast_addr       (32'd0),
    .disable_preamble       (1'b0),

    .running_byte_count     (running_byte_count ),
    .running_byte_count_nxt (),
    .dma_bus_width          (dma_bus_width),
    .svlan_type             ({1'b1,16'h88a8}),

    .mac_dest_addr_c        (),
    .mac_dest_addr_stb_c    (),
    .mac_src_addr_c         (),
    .mac_src_addr_stb_c     (),
    .vlan_tag1              (),
    .vlan_tag1_stb          (),
    .vlan_tag2              (),
    .vlan_tag2_stb          (),
    .ethertype              (),
    .ethertype_stb          (),
    .ip_sa                  (),
    .ip_sa_stb              (),
    .ip_da                  (),
    .ip_da_stb              (),
    .l3_hdr_offst           (l3_hdr_offst),
    .l4_hdr_offst           (l4_hdr_offst),
    .rx_csum_zero           (),
    .start_of_ip_srcadd_offset (start_of_ip_srcadd_offset),
    .start_of_ip_destadd_offset(start_of_ip_destadd_offset),
    .end_of_ip_srcadd_offset   (end_of_ip_srcadd_offset),
    .end_of_ip_destadd_offset  (end_of_ip_destadd_offset),
    .end_of_tcpudp_pld_offset  (end_of_tcpudp_pld_offset),
    .tcp_csum_offset        (tcp_csum_offset),
    .pld_offst              (),
    .tcp_length             (tcp_length),
    .decode_out_vld         (),
    .ipv4_decodes_vld       (),
    .ipv4_csum_offset       (ipv4_csum_offset ),
    .end_of_ip_hdr_offset   (end_of_ip_hdr_offset ),
    .ptp_version            (),
    .ptp_timestamp_offset   (),
    .ptp_event_msg          (),
    .ptp_general_msg        (),
    .ptp_sync_msg           (),
    .ptp_dreq_msg           (),
    .ptp_follow_msg         (),
    .ptp_dresp_msg          (),
    .ptp_pdreq_msg          (),
    .ptp_pdresp_msg         (),
    .ptp_seqid              (),
    .ipv4_frame_detected    (ipv4_frame_detected),
    .ipv6_frame_detected    (),
    .l4_tcp_hdr_detected    (l4_tcp_hdr_detected),
    .l4_udp_hdr_detected    (l4_udp_hdr_detected),
    .ptpoe_type_detected    (),
    .snap_hdr_detected      (),

    .queue_ptr_rx           (),

    .screener_type1_regs    (1'b0),
    .screener_type2_regs    (1'b0),
    .scr2_compare_regs      (1'b0),
    .scr2_ethtype_regs      (1'b0),
    .tcp_status             (tcp_status_c)

  );

 edma_csum #( .SKIP_OVER_CSUM(1'b1)) i_edma_ipv4_csum (

    .host_clk                (hclk),
    .host_rst_n              (n_hreset),

    .tx_r_data               (dpram_din_d1),
    .tx_r_eop                (dpram_eop_d1),
    .tx_r_err                (1'b0),
    .tx_r_valid              (dpram_we_d1),

    .csum_start_offset       ({10'd0,l3_hdr_offst}),
    .running_byte_count      (running_byte_count),
    .tx_e_valid              (dpram_we),
    .csum_offset             ({9'd0,ipv4_csum_offset}),
    .csum_end_offset         (end_of_ip_hdr_offset),
    .dma_bus_width           (dma_bus_width),

    .csum                    (ipv4_result_n),
    .csum_vld                (ipv4_offload_valid)
  );
  assign ipv4_result = ~ipv4_result_n;

wire [15:0] tcp_pseudo_src_result;
 edma_csum #( .SKIP_OVER_CSUM(1'b0)) i_edma_pseudo_src_csum (

    .host_clk                (hclk),
    .host_rst_n              (n_hreset),

    .tx_r_data               (dpram_din_d1),
    .tx_r_eop                (dpram_eop_d1),
    .tx_r_err                (1'b0),
    .tx_r_valid              (dpram_we_d1),

    .csum_start_offset       ({9'd0,start_of_ip_srcadd_offset}),
    .running_byte_count      (running_byte_count),
    .tx_e_valid              (dpram_we),
    .csum_offset             (16'h0000),
    .csum_end_offset         ({9'd0,end_of_ip_srcadd_offset}),
    .dma_bus_width           (dma_bus_width),

    .csum                    (tcp_pseudo_src_result),
    .csum_vld                ()
  );

wire [15:0] tcp_pseudo_dest_result;
 edma_csum #( .SKIP_OVER_CSUM(1'b0)) i_edma_pseudo_dest_csum (

    .host_clk                (hclk),
    .host_rst_n              (n_hreset),

    .tx_r_data               (dpram_din_d1),
    .tx_r_eop                (dpram_eop_d1),
    .tx_r_err                (1'b0),
    .tx_r_valid              (dpram_we_d1),

    .csum_start_offset       (start_of_ip_destadd_offset),
    .running_byte_count      (running_byte_count),
    .tx_e_valid              (dpram_we),
    .csum_offset             (16'h0000),
    .csum_end_offset         (end_of_ip_destadd_offset),
    .dma_bus_width           (dma_bus_width),

    .csum                    (tcp_pseudo_dest_result),
    .csum_vld                ()
  );
  wire [16:0] tcp_pseudo_add_result_a;
  assign tcp_pseudo_add_result_a = {tcp_pseudo_dest_result[7:0],tcp_pseudo_dest_result[15:8]} +
                                   {tcp_pseudo_src_result[7:0], tcp_pseudo_src_result[15:8]};

  wire [16:0] tcp_pseudo_add_result;
  assign tcp_pseudo_add_result   = tcp_pseudo_add_result_a[15:0] + tcp_pseudo_add_result_a[16];

  // tcp_pseudo_result holds the CSUM covering the source add + dest address of the Ip header
  // Also need to add the other parts of the Pseudo header including the length of the TCP
  // payload and the protocol field.  The protocol field is 6 for TCP and 17 for UDP.  Adding the
  // length and protocol here is not going to breach a 16bit limit, so no need to add the carry ...
  //
  wire [15:0] proto_field;
  wire [16:0] add_tcplen_prot_pad;
  wire [15:0] add_tcplen_prot;
  assign proto_field = l4_tcp_hdr_detected ? 16'h0006 : 16'h0011;

  assign add_tcplen_prot_pad = tcp_length + proto_field;
  assign add_tcplen_prot     = add_tcplen_prot_pad[15:0];

  // Now add the tcp_pseudo_add_result to the add_tcplen_prot
  // this can be registered because the writeback into the SRAM wont happen for a few cycles
  wire [16:0] tcp_pseudo_result_a;
  wire [16:0] tcp_pseudo_result_b;
  assign tcp_pseudo_result_a = add_tcplen_prot[15:0] + tcp_pseudo_add_result[15:0];
  assign tcp_pseudo_result_b = tcp_pseudo_result_a[16] + tcp_pseudo_result_a[15:0];
/*
  reg [15:0]  tcp_pseudo_result;
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      tcp_pseudo_result <= 16'h0000;
    else
      tcp_pseudo_result <= tcp_pseudo_result_b[15:0];
  end
*/

// Now add the actual final result in ...
// tcp_hdr_payload_result holds the CSUM covering the TCP header
wire [15:0] tcp_hdr_payload_result;
 edma_csum #( .SKIP_OVER_CSUM(1'b1)) i_edma_tcp_csum (

    .host_clk                (hclk),
    .host_rst_n              (n_hreset),

    .tx_r_data               (dpram_din_d1),
    .tx_r_eop                (dpram_eop_d1),
    .tx_r_err                (1'b0),
    .tx_r_valid              (dpram_we_d1),

    .csum_start_offset       (l4_hdr_offst),
    .running_byte_count      (running_byte_count),
    .tx_e_valid              (dpram_we),
    .csum_offset             ({3'b000,tcp_csum_offset[12:0]}),
    .csum_end_offset         (end_of_tcpudp_pld_offset),
    .dma_bus_width           (dma_bus_width),

    .csum                    (tcp_hdr_payload_result),
    .csum_vld                (tcp_offload_valid)
  );

  // Add it in here ....
  wire [16:0] tcp_csum_result_a;
  assign tcp_csum_result_a  = tcp_pseudo_result_b[15:0] +
                               {tcp_hdr_payload_result[7:0],tcp_hdr_payload_result[15:8]};

  wire [16:0] tcp_csum_result;
  assign tcp_csum_result = tcp_csum_result_a[15:0] + tcp_csum_result_a[16];

  // Zero checksums are not allowed in IPv6, so convert to FFFF
  reg [15:0] final_tcp_res;
  wire [1:0] final_tcp_res_par;  // if parity protection defined generate parity and pass using this wire
  always @(*)
  begin
    if (&tcp_csum_result[15:0] & l4_udp_hdr_detected & ~ipv4_frame_detected)
      final_tcp_res = tcp_csum_result[15:0];
    else
      final_tcp_res = ~tcp_csum_result[15:0];
  end

  // Take a note of the DPRAM address to which the
  // checksums are located for future writebacks
  // In the case of the IPV4_ checksum, this occurs during the
  // IPV4_6 state.  There is a 1 cycle latency between the dpram_we
  // and tx_ena and the address is post incremented
  reg    [13:0]       stripe_num;
  reg    [13:0]       tcp_csum_stripe;
  reg    [3:0]        tcp_csum_bytes;
  reg    [13:0]       ipv4_csum_stripe;
  reg    [3:0]        ipv4_csum_bytes;
  always @(*)
  begin
    if (dma_bus_width == 2'b00)
    begin
      stripe_num           = running_byte_count[15:2];
      tcp_csum_stripe      = {3'h0, tcp_csum_offset[12:2]} ;
      tcp_csum_bytes       = {2'h0, tcp_csum_offset[1:0]} ;
      ipv4_csum_stripe     = {9'd0, ipv4_csum_offset[6:2]} ;
      ipv4_csum_bytes      = {2'h0, ipv4_csum_offset[1:0]} ;
    end
    else if (dma_bus_width == 2'b01)
    begin
      stripe_num           = {1'b0, running_byte_count[15:3]};
      tcp_csum_stripe      = {4'h0, tcp_csum_offset[12:3]} ;
      tcp_csum_bytes       = {1'b0, tcp_csum_offset[2:0]} ;
      ipv4_csum_stripe     = {10'd0,ipv4_csum_offset[6:3]} ;
      ipv4_csum_bytes      = {1'b0, ipv4_csum_offset[2:0]} ;
    end
    else
    begin
      stripe_num           = {2'b00,running_byte_count[15:4]};
      tcp_csum_stripe      = {5'h00,tcp_csum_offset[12:4]};
      tcp_csum_bytes       = tcp_csum_offset[3:0];
      ipv4_csum_stripe     = {11'd0,ipv4_csum_offset[6:4]};
      ipv4_csum_bytes      = ipv4_csum_offset[3:0];
    end
  end
  assign dpram_din_i[127:0]     = { dpram_din[119:112],dpram_din[127:120],
                                    dpram_din[103:96],dpram_din[111:104],
                                    dpram_din[87:80], dpram_din[95:88],
                                    dpram_din[71:64], dpram_din[79:72],
                                    dpram_din[55:48], dpram_din[63:56],
                                    dpram_din[39:32], dpram_din[47:40],
                                    dpram_din[23:16], dpram_din[31:24],
                                    dpram_din[7:0],   dpram_din[15:8]};
  assign dpram_din_par_i[15:0]  = { dpram_din_par[14],dpram_din_par[15],
                                    dpram_din_par[12],dpram_din_par[13],
                                    dpram_din_par[10],dpram_din_par[11],
                                    dpram_din_par[8], dpram_din_par[9],
                                    dpram_din_par[6], dpram_din_par[7],
                                    dpram_din_par[4], dpram_din_par[5],
                                    dpram_din_par[2], dpram_din_par[3],
                                    dpram_din_par[0], dpram_din_par[1]};


  assign tcp_status = {3{tx_pbuf_tcp_en}} & tcp_status_c;

  always@(*)
  begin
    tcp_hdr_cs_nxt      = tcp_hdr_cs;
    tcp_hdr_cs_par_nxt  = tcp_hdr_cs_par;

    if (stripe_num == tcp_csum_stripe & dpram_we)
    begin
      case (tcp_csum_bytes)
        4'd0    : begin
                    tcp_hdr_cs_nxt[127:16]    = dpram_din_i[127:16];
                    tcp_hdr_cs_par_nxt[15:2]  = dpram_din_par_i[15:2];
                  end
        4'd2    : begin
                    tcp_hdr_cs_nxt[127:32]    = dpram_din_i[127:32];
                    tcp_hdr_cs_nxt[15:0]      = dpram_din_i[15:0];
                    tcp_hdr_cs_par_nxt[15:4]  = dpram_din_par_i[15:4];
                    tcp_hdr_cs_par_nxt[1:0]   = dpram_din_par_i[1:0];
                  end
        4'd4    : begin
                    tcp_hdr_cs_nxt[127:48]    = dpram_din_i[127:48];
                    tcp_hdr_cs_nxt[31:0]      = dpram_din_i[31:0];
                    tcp_hdr_cs_par_nxt[15:6]  = dpram_din_par_i[15:6];
                    tcp_hdr_cs_par_nxt[3:0]   = dpram_din_par_i[3:0];
                  end
        4'd6    : begin
                    tcp_hdr_cs_nxt[127:64]    = dpram_din_i[127:64];
                    tcp_hdr_cs_nxt[47:0]      = dpram_din_i[47:0];
                    tcp_hdr_cs_par_nxt[15:8]  = dpram_din_par_i[15:8];
                    tcp_hdr_cs_par_nxt[5:0]   = dpram_din_par_i[5:0];
                  end
        4'd8    : begin
                    tcp_hdr_cs_nxt[127:80]    = dpram_din_i[127:80];
                    tcp_hdr_cs_nxt[63:0]      = dpram_din_i[63:0];
                    tcp_hdr_cs_par_nxt[15:10] = dpram_din_par_i[15:10];
                    tcp_hdr_cs_par_nxt[7:0]   = dpram_din_par_i[7:0];
                  end
        4'd10   : begin
                    tcp_hdr_cs_nxt[127:96]    = dpram_din_i[127:96];
                    tcp_hdr_cs_nxt[79:0]      = dpram_din_i[79:0];
                    tcp_hdr_cs_par_nxt[15:12] = dpram_din_par_i[15:12];
                    tcp_hdr_cs_par_nxt[9:0]   = dpram_din_par_i[9:0];
                  end
        4'd12   : begin
                    tcp_hdr_cs_nxt[127:112]   = dpram_din_i[127:112];
                    tcp_hdr_cs_nxt[95:0]      = dpram_din_i[95:0];
                    tcp_hdr_cs_par_nxt[15:14] = dpram_din_par_i[15:14];
                    tcp_hdr_cs_par_nxt[11:0]  = dpram_din_par_i[11:0];
                  end
        default : begin
                    tcp_hdr_cs_nxt[111:0]     = dpram_din_i[111:0];
                    tcp_hdr_cs_par_nxt[13:0]  = dpram_din_par_i[13:0];
                  end
      endcase
    end
    else
    begin
      if (tcp_offload_valid)
      begin
        case (tcp_csum_bytes)
          4'd0    : begin
                      tcp_hdr_cs_nxt[15:0]    = final_tcp_res;
                      tcp_hdr_cs_par_nxt[1:0] = final_tcp_res_par;
                    end
          4'd2    : begin
                      tcp_hdr_cs_nxt[31:16]   = final_tcp_res;
                      tcp_hdr_cs_par_nxt[3:2] = final_tcp_res_par;
                    end
          4'd4    : begin
                      tcp_hdr_cs_nxt[47:32]   = final_tcp_res;
                      tcp_hdr_cs_par_nxt[5:4] = final_tcp_res_par;
                    end
          4'd6    : begin
                      tcp_hdr_cs_nxt[63:48]   = final_tcp_res;
                      tcp_hdr_cs_par_nxt[7:6] = final_tcp_res_par;
                    end
          4'd8    : begin
                      tcp_hdr_cs_nxt[79:64]   = final_tcp_res;
                      tcp_hdr_cs_par_nxt[9:8] = final_tcp_res_par;
                    end
          4'd10   : begin
                      tcp_hdr_cs_nxt[95:80]     = final_tcp_res;
                      tcp_hdr_cs_par_nxt[11:10] = final_tcp_res_par;
                    end
          4'd12   : begin
                      tcp_hdr_cs_nxt[111:96]    = final_tcp_res;
                      tcp_hdr_cs_par_nxt[13:12] = final_tcp_res_par;
                    end
          default : begin
                      tcp_hdr_cs_nxt[127:112]   = final_tcp_res;
                      tcp_hdr_cs_par_nxt[15:14] = final_tcp_res_par;
                    end
        endcase
      end
    end
  end
  always@(*)
  begin
    ip_hdr_cs_nxt     = ip_hdr_cs;
    ip_hdr_cs_par_nxt = ip_hdr_cs_par;

    if (stripe_num == ipv4_csum_stripe & dpram_we)
    begin
      case (ipv4_csum_bytes)
        4'd0    : begin
                    ip_hdr_cs_nxt[127:16]     = dpram_din_i[127:16];
                    ip_hdr_cs_par_nxt[15:2]   = dpram_din_par_i[15:2];
                  end
        4'd4    : begin
                    ip_hdr_cs_nxt[127:48]     = dpram_din_i[127:48];
                    ip_hdr_cs_nxt[31:0]       = dpram_din_i[31:0];
                    ip_hdr_cs_par_nxt[15:6]   = dpram_din_par_i[15:6];
                    ip_hdr_cs_par_nxt[3:0]    = dpram_din_par_i[3:0];
                  end
        4'd8    : begin
                    ip_hdr_cs_nxt[127:80]     = dpram_din_i[127:80];
                    ip_hdr_cs_nxt[63:0]       = dpram_din_i[63:0];
                    ip_hdr_cs_par_nxt[15:10]  = dpram_din_par_i[15:10];
                    ip_hdr_cs_par_nxt[7:0]    = dpram_din_par_i[7:0];
                  end
        default   : begin
                      ip_hdr_cs_nxt[127:112]    = dpram_din_i[127:112];
                      ip_hdr_cs_nxt[95:0]       = dpram_din_i[95:0];
                      ip_hdr_cs_par_nxt[15:14]  = dpram_din_par_i[15:14];
                      ip_hdr_cs_par_nxt[11:0]   = dpram_din_par_i[11:0];
                    end
      endcase
    end
    else
    begin
      if (ipv4_offload_valid)
      begin
        case (ipv4_csum_bytes)
          4'd0    : begin
                      ip_hdr_cs_nxt[15 :0]      = {ipv4_result[7:0],ipv4_result[15:8]};
                      ip_hdr_cs_par_nxt[1:0]    = {ipv4_result_par[0],ipv4_result_par[1]};
                    end
          4'd4    : begin
                      ip_hdr_cs_nxt[47 :32]     = {ipv4_result[7:0],ipv4_result[15:8]};
                      ip_hdr_cs_par_nxt[5:4]    = {ipv4_result_par[0],ipv4_result_par[1]};
                    end
          4'd8    : begin
                      ip_hdr_cs_nxt[79 :64]     = {ipv4_result[7:0],ipv4_result[15:8]};
                      ip_hdr_cs_par_nxt[9:8]    = {ipv4_result_par[0],ipv4_result_par[1]};
                    end
          default : begin
                      ip_hdr_cs_nxt[111:96]     = {ipv4_result[7:0],ipv4_result[15:8]};
                      ip_hdr_cs_par_nxt[13:12]  = {ipv4_result_par[0],ipv4_result_par[1]};
                    end
        endcase
      end
    end
  end

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      tcp_hdr_cs_addr    <= {p_edma_tx_pbuf_addr{1'b0}};
      tcp_hdr_cs         <= 128'd0;
      ip_hdr_cs_addr     <= {p_edma_tx_pbuf_addr{1'b0}};
      ip_hdr_cs          <= 128'd0;
      ip_cs_locn_d1      <= 1'b0;
      tcp_cs_locn_d1     <= 1'b0;
      tcp_hdr_cs_we      <= 1'b0;
      ip_hdr_cs_we       <= 1'b0;
    end
    else
    begin
      // the ip_hdr_cs_we and tcp_hdr_cs_we signals are passed to the underlying DMA to identify when a valid
      // IP checksum or TCP checksum should be inserted.  Under normal conditions the signals will be set
      // when an IP or TCp header has been decoded, and reset at the start of the next new frame (man_rd_new_pkt)
      // For non SPRAM configurations,  the stripe of data that the checksum bytes were located on was writte to
      // previously, and therefore will be overwritten with the checksum + existing stripe (i.e. the existing stripe
      // is buffered locally). if there has been an error during the decoding, we can clear the ip_hdr_cs_we and
      // tcp_hdr_cs_we signals to avoid the underlying DMA from writing the checksums into an errored frame.
      // For SPRAM configs, the stripe of data that the checksum bytes were located on was NOT
      // previously written.  It is therefore mandatory that the stripe is written following the detection of
      // an IP/TCP header, even if there was an error detected ...
      //
      if (man_rd_new_pkt)
        ip_hdr_cs_we <= 1'b0;
      else if (tx_pbuf_tcp_en &
              ((tcp_status == NO_ERROR | tcp_status == IPV4_ONLY | tcp_status == PKT_FRAGMENTED) & ipv4_frame_detected))
      begin
        if (ipv4_offload_valid)
          ip_hdr_cs_we <= 1'b1;
      end
      else if (p_edma_spram == 0)
        ip_hdr_cs_we <= 1'b0;

      if (man_rd_new_pkt)
        tcp_hdr_cs_we <= 1'b0;
      else if (tx_pbuf_tcp_en &
              (tcp_status == NO_ERROR & (l4_tcp_hdr_detected | l4_udp_hdr_detected)))
      begin
        if (tcp_offload_valid)
          tcp_hdr_cs_we <= 1'b1;
      end
      else if (p_edma_spram == 0)
        tcp_hdr_cs_we <= 1'b0;

      tcp_hdr_cs  <= tcp_hdr_cs_nxt;
      if (stripe_num == tcp_csum_stripe & dpram_we)
        tcp_cs_locn_d1  <= 1'b1;
      else
        tcp_cs_locn_d1  <= 1'b0;

      ip_hdr_cs <= ip_hdr_cs_nxt;
      if (stripe_num == ipv4_csum_stripe & dpram_we)
        ip_cs_locn_d1  <= 1'b1;
      else
        ip_cs_locn_d1  <= 1'b0;

      if ((p_edma_axi == 1 && stripe_num == tcp_csum_stripe & dpram_we) ||
          (p_edma_axi == 0 && tcp_cs_locn_d1))
        tcp_hdr_cs_addr <= dpram_addr;

      if ((p_edma_axi == 1 && stripe_num == ipv4_csum_stripe & dpram_we) ||
          (p_edma_axi == 0 && ip_cs_locn_d1))
        ip_hdr_cs_addr <= dpram_addr;
    end
  end

  assign tx_ena_abort = !tx_pbuf_tcp_en ? 1'b0 :
                        (tcp_status == 3'b000 | tcp_status == 3'b110) &
                           ((ip_cs_locn_d1 & ipv4_frame_detected) |
                           (tcp_cs_locn_d1 & (l4_tcp_hdr_detected|l4_udp_hdr_detected)));

// -----------------------------------------------------------------------------
// ASF - End to end data path parity protection
// -----------------------------------------------------------------------------

  generate if (p_edma_asf_dap_prot == 1) begin : gen_dp_parity
    reg [15:0]  ip_hdr_cs_par_r;
    reg [15:0]  tcp_hdr_cs_par_r;

    always @(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
      begin
        ip_hdr_cs_par_r   <= 16'd0;
        tcp_hdr_cs_par_r  <= 16'd0;
      end
      else
      begin
        ip_hdr_cs_par_r   <= ip_hdr_cs_par_nxt;
        tcp_hdr_cs_par_r  <= tcp_hdr_cs_par_nxt;
      end
    end

    assign tcp_hdr_cs_par = tcp_hdr_cs_par_r;
    assign ip_hdr_cs_par  = ip_hdr_cs_par_r;

    // The checksum generation is not protected, we just re-generate the parity here...
    // TOIMPRV - can duplicate checksum generation if require better DC.
    cdnsdru_asf_parity_gen_v1 #(.p_data_width(32)) i_gem_par_gen_dp_final_tcp_res(
      .odd_par(1'b0),
      .data_in({ipv4_result[15:0],final_tcp_res[15:0]} ),
      .data_out(),
      .parity_out({ipv4_result_par,final_tcp_res_par})
    );
  end else begin : gen_no_dp_parity
    assign final_tcp_res_par  = 2'd0;
    assign ipv4_result_par    = 2'd0;
    assign tcp_hdr_cs_par     = 16'd0;
    assign ip_hdr_cs_par      = 16'd0;
  end
  endgenerate

endmodule
